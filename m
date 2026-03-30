Return-Path: <stable+bounces-231278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HSyA0fmymloBAYAu9opvQ
	(envelope-from <stable+bounces-231278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 23:08:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BEA361458
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 23:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D8EA3034327
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 21:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EC239BFEB;
	Mon, 30 Mar 2026 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCcm8ia/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D68373BF7
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 21:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774904882; cv=none; b=r4JMn7FNoS4h9c8zxkSDNlqcQOiGtPP5VfxNNVBaxlM2MXJynyKbzwrdzguV2JEmZYQL7aKST7s1PBxTMjsT+FOBiM1yP78DLtK67c+8nd8LQEGH9wbwmMVVxbbGLMMqRvLLAZ+CGdSu5OKlTcea7DnlJZo6ZKWRQrxiy0LjsUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774904882; c=relaxed/simple;
	bh=wf+WC6K1MGsF+jQfwyrXxe34hHSliuwSrNEYy8Q1+K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqOXWQft5og64+Q0eb6XPsYHoX3WsJCYTz85Gk6096KTA267CIcrBbNkGIFSCyPzEme2uKoK32Rn/4kPEycfa2IK9X6hUsJRF63QbZUZcc7lNmka6VWbvY34Hbpk2VQh2CjJ3O7vnfjpeCJ6Dyu+j74UBZWoRNlsMA8af9kTAo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCcm8ia/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EC4C4CEF7;
	Mon, 30 Mar 2026 21:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774904881;
	bh=wf+WC6K1MGsF+jQfwyrXxe34hHSliuwSrNEYy8Q1+K4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DCcm8ia/AFRUb+rqrME29tD9v/jYUn1Axw1AF1aDXUSv71qqXqlIb47NfgEENao1a
	 1tfVMryd95JZRYB6lEPoaBaKzEvvlNrZSX/drtZdMAjMkoKAkcZr0t5dwIa1ZT3QSj
	 UgSTXmxg9oixAkSfHU5wn8Uw9btocteyTgFEm7+Pde0OBPYlHwu5yWucoNkc1CGmuq
	 7e4Hrjd1jrPInHc3XanoR1QLniBuDnviNW5oxbOUglT4hiMQQVsCavEgZY8wmN27gM
	 /kUswipqIbKWMRuORBE2nbgRPSIh+shsb4oGI1vhdE7wYLnfanSLK1F43hIIM2nCHz
	 Wjb7+2RsOC5kA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Werner Kasselman <werner@verivus.com>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19.y] ksmbd: fix use-after-free and NULL deref in smb_grant_oplock()
Date: Mon, 30 Mar 2026 17:07:59 -0400
Message-ID: <20260330210759.1213972-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026032916-payday-kelp-1054@gregkh>
References: <2026032916-payday-kelp-1054@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231278-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91BEA361458
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Werner Kasselman <werner@verivus.com>

[ Upstream commit 48623ec358c1c600fa1e38368746f933e0f1a617 ]

smb_grant_oplock() has two issues in the oplock publication sequence:

1) opinfo is linked into ci->m_op_list (via opinfo_add) before
   add_lease_global_list() is called.  If add_lease_global_list()
   fails (kmalloc returns NULL), the error path frees the opinfo
   via __free_opinfo() while it is still linked in ci->m_op_list.
   Concurrent m_op_list readers (opinfo_get_list, or direct iteration
   in smb_break_all_levII_oplock) dereference the freed node.

2) opinfo->o_fp is assigned after add_lease_global_list() publishes
   the opinfo on the global lease list.  A concurrent
   find_same_lease_key() can walk the lease list and dereference
   opinfo->o_fp->f_ci while o_fp is still NULL.

Fix by restructuring the publication sequence to eliminate post-publish
failure:

- Set opinfo->o_fp before any list publication (fixes NULL deref).
- Preallocate lease_table via alloc_lease_table() before opinfo_add()
  so add_lease_global_list() becomes infallible after publication.
- Keep the original m_op_list publication order (opinfo_add before
  lease list) so concurrent opens via same_client_has_lease() and
  opinfo_get_list() still see the in-flight grant.
- Use opinfo_put() instead of __free_opinfo() on err_out so that
  the RCU-deferred free path is used.

This also requires splitting add_lease_global_list() to take a
preallocated lease_table and changing its return type from int to void,
since it can no longer fail.

Fixes: 1dfd062caa16 ("ksmbd: fix use-after-free by using call_rcu() for oplock_info")
Cc: stable@vger.kernel.org
Signed-off-by: Werner Kasselman <werner@verivus.com>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ adapted kmalloc_obj() macro to kmalloc(sizeof()) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/oplock.c | 72 ++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index cfc2a431fa918..41a31e1d7b14a 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -82,11 +82,19 @@ static void lease_del_list(struct oplock_info *opinfo)
 	spin_unlock(&lb->lb_lock);
 }
 
-static void lb_add(struct lease_table *lb)
+static struct lease_table *alloc_lease_table(struct oplock_info *opinfo)
 {
-	write_lock(&lease_list_lock);
-	list_add(&lb->l_entry, &lease_table_list);
-	write_unlock(&lease_list_lock);
+	struct lease_table *lb;
+
+	lb = kmalloc(sizeof(struct lease_table), KSMBD_DEFAULT_GFP);
+	if (!lb)
+		return NULL;
+
+	memcpy(lb->client_guid, opinfo->conn->ClientGUID,
+	       SMB2_CLIENT_GUID_SIZE);
+	INIT_LIST_HEAD(&lb->lease_list);
+	spin_lock_init(&lb->lb_lock);
+	return lb;
 }
 
 static int alloc_lease(struct oplock_info *opinfo, struct lease_ctx_info *lctx)
@@ -1042,34 +1050,27 @@ static void copy_lease(struct oplock_info *op1, struct oplock_info *op2)
 	lease2->version = lease1->version;
 }
 
-static int add_lease_global_list(struct oplock_info *opinfo)
+static void add_lease_global_list(struct oplock_info *opinfo,
+				  struct lease_table *new_lb)
 {
 	struct lease_table *lb;
 
-	read_lock(&lease_list_lock);
+	write_lock(&lease_list_lock);
 	list_for_each_entry(lb, &lease_table_list, l_entry) {
 		if (!memcmp(lb->client_guid, opinfo->conn->ClientGUID,
 			    SMB2_CLIENT_GUID_SIZE)) {
 			opinfo->o_lease->l_lb = lb;
 			lease_add_list(opinfo);
-			read_unlock(&lease_list_lock);
-			return 0;
+			write_unlock(&lease_list_lock);
+			kfree(new_lb);
+			return;
 		}
 	}
-	read_unlock(&lease_list_lock);
 
-	lb = kmalloc(sizeof(struct lease_table), KSMBD_DEFAULT_GFP);
-	if (!lb)
-		return -ENOMEM;
-
-	memcpy(lb->client_guid, opinfo->conn->ClientGUID,
-	       SMB2_CLIENT_GUID_SIZE);
-	INIT_LIST_HEAD(&lb->lease_list);
-	spin_lock_init(&lb->lb_lock);
-	opinfo->o_lease->l_lb = lb;
+	opinfo->o_lease->l_lb = new_lb;
 	lease_add_list(opinfo);
-	lb_add(lb);
-	return 0;
+	list_add(&new_lb->l_entry, &lease_table_list);
+	write_unlock(&lease_list_lock);
 }
 
 static void set_oplock_level(struct oplock_info *opinfo, int level,
@@ -1189,6 +1190,7 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 	int err = 0;
 	struct oplock_info *opinfo = NULL, *prev_opinfo = NULL;
 	struct ksmbd_inode *ci = fp->f_ci;
+	struct lease_table *new_lb = NULL;
 	bool prev_op_has_lease;
 	__le32 prev_op_state = 0;
 
@@ -1291,21 +1293,37 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 	set_oplock_level(opinfo, req_op_level, lctx);
 
 out:
-	opinfo_count_inc(fp);
-	opinfo_add(opinfo, fp);
-
+	/*
+	 * Set o_fp before any publication so that concurrent readers
+	 * (e.g. find_same_lease_key() on the lease list) that
+	 * dereference opinfo->o_fp don't hit a NULL pointer.
+	 *
+	 * Keep the original publication order so concurrent opens can
+	 * still observe the in-flight grant via ci->m_op_list, but make
+	 * everything after opinfo_add() no-fail by preallocating any new
+	 * lease_table first.
+	 */
+	opinfo->o_fp = fp;
 	if (opinfo->is_lease) {
-		err = add_lease_global_list(opinfo);
-		if (err)
+		new_lb = alloc_lease_table(opinfo);
+		if (!new_lb) {
+			err = -ENOMEM;
 			goto err_out;
+		}
 	}
 
+	opinfo_count_inc(fp);
+	opinfo_add(opinfo, fp);
+
+	if (opinfo->is_lease)
+		add_lease_global_list(opinfo, new_lb);
+
 	rcu_assign_pointer(fp->f_opinfo, opinfo);
-	opinfo->o_fp = fp;
 
 	return 0;
 err_out:
-	__free_opinfo(opinfo);
+	kfree(new_lb);
+	opinfo_put(opinfo);
 	return err;
 }
 
-- 
2.53.0


