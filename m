Return-Path: <stable+bounces-230866-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOwLAwXTyGnprAUAu9opvQ
	(envelope-from <stable+bounces-230866-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:21:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F29E3510B3
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 630B2301B92C
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 07:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDE92C028C;
	Sun, 29 Mar 2026 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C8xTjk3j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5312D22D4DC
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774768896; cv=none; b=gFQo5Lzf610PxzJ9MTyzZCQLztQhP4jAEF4QoABkQ1Oc/8DYd5+wfU/gbI1gQ+L3EyX82e0rYR8qDmKYaLb9GDz+KFS87GdLmJmkptq2LhFhebSelUA6JDjxwAVsQxcdo60y4f5RG1vQ6dyP3+Sfilt8Qz7H4frPe1TaJ84g95w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774768896; c=relaxed/simple;
	bh=Wx72m4iwelmd7XgNABsOK2HB4pMZX/i190ezJvHeAyw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u8i04u5A19QTxDDD01ivKJqzvYDz+QLB++g3Ns6809JyQAbN8ViYQjnl9vkOBrX3/FAAHYwOMykhn7XTLvQZ28qvlZqvWoFmNDkeMoo6AzWszdmOxASb71PxZzwcUIjKu3CXpHAffwDPjM3m9UChb1q7jTVMMGNgXWDfwZmal50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C8xTjk3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC3AC116C6;
	Sun, 29 Mar 2026 07:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774768896;
	bh=Wx72m4iwelmd7XgNABsOK2HB4pMZX/i190ezJvHeAyw=;
	h=Subject:To:Cc:From:Date:From;
	b=C8xTjk3j6y2nQ2HDOJDc6XBfNJmRexpXPJveM+78z4pIKpm1ztIsCYuMunWGeMAv9
	 P8G0e31m/v+DnlRSs8xLiRmcIiEyb8zT1foTTGTWmaRLUy+i02BDAAN7L06VNE8chl
	 IB+UNM3zHurluXOZ4rQK6rn+RSjqao2S7BCfVrV0=
Subject: FAILED: patch "[PATCH] ksmbd: fix use-after-free and NULL deref in" failed to apply to 6.6-stable tree
To: werner@verivus.com,chenxiaosong@kylinos.cn,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 09:21:19 +0200
Message-ID: <2026032919-unsaddle-sedan-a35b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230866-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,kylinos.cn:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F29E3510B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 48623ec358c1c600fa1e38368746f933e0f1a617
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032919-unsaddle-sedan-a35b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 48623ec358c1c600fa1e38368746f933e0f1a617 Mon Sep 17 00:00:00 2001
From: Werner Kasselman <werner@verivus.com>
Date: Mon, 16 Mar 2026 11:38:47 +0000
Subject: [PATCH] ksmbd: fix use-after-free and NULL deref in
 smb_grant_oplock()

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

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 393a4ae47cc1..9b2bb8764a80 100644
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
+	lb = kmalloc_obj(struct lease_table, KSMBD_DEFAULT_GFP);
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
 
-	lb = kmalloc_obj(struct lease_table, KSMBD_DEFAULT_GFP);
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
+	if (opinfo->is_lease) {
+		new_lb = alloc_lease_table(opinfo);
+		if (!new_lb) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+	}
+
 	opinfo_count_inc(fp);
 	opinfo_add(opinfo, fp);
 
-	if (opinfo->is_lease) {
-		err = add_lease_global_list(opinfo);
-		if (err)
-			goto err_out;
-	}
+	if (opinfo->is_lease)
+		add_lease_global_list(opinfo, new_lb);
 
 	rcu_assign_pointer(fp->f_opinfo, opinfo);
-	opinfo->o_fp = fp;
 
 	return 0;
 err_out:
-	__free_opinfo(opinfo);
+	kfree(new_lb);
+	opinfo_put(opinfo);
 	return err;
 }
 


