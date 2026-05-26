Return-Path: <stable+bounces-254268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OuEN/FTFWqmUQcAu9opvQ
	(envelope-from <stable+bounces-254268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:04:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 666D15D231C
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93F39304B69C
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 08:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5583CCFB5;
	Tue, 26 May 2026 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="TvE/aDCw"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB053CCFCC;
	Tue, 26 May 2026 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782431; cv=none; b=fmW/OEfxAGMplkQLGx3Uo5RHbQ+Yy34ip3iwNDaNoNSLjD/2ctQSbuAkaqa+nDTEmO3/G3DXuv2GFR7xzzad+PFjwqV9GC7b0xBqCH84igsusJdL0u5GJSpsXTZx+oVDK5bhrY5R9pdYetpqh1y2FeEurlkndH4zt6Z9/iys4Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782431; c=relaxed/simple;
	bh=UhdKlo7F3i10jkrcg9rE0cfbTVitXhlBv0J5E3tasxA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=kXzf3E02wQQbgN3VfGHlJt69nYBBXE5bZMPxPh9TTy5vsg6xiieECt13XmdjMbvZR0iBvDuzE8GsIJcLc7+AZdkCu/Jz5bM42FJu57QWFU2UQy95+6fp8+ZkcL5JCIxz+gZRB+in3w86LwOjgp1ovW2SC/nH+y5djtIKX5jg0Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=TvE/aDCw; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779782420;
	bh=otvRMQ0W1w2Sss+NNofN3CVZhsjcuh77HSoap1Rk0uE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TvE/aDCweFLSvnwyXvZysvUs2PvD6Et8tdNIIw8eoSx0oKDXNDNvgkmtfIvUIfS6I
	 mAk/T8rcWG/oG+A+Kg1G4CGtj/axLytx5EWm1Lg4Uu2RXOhgYtji7RM40of20RNfuS
	 usjjH9sqbRYeAX6mUd0Iem/sqi98KEfZhNO+3rIA=
Received: from China-team ([47.95.114.252])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id EB912EE0; Tue, 26 May 2026 15:58:57 +0800
X-QQ-mid: xmsmtpt1779782345t40pxgplm
Message-ID: <tencent_5886395ABE9AB30F2C49376B3F9C3798F207@qq.com>
X-QQ-XMAILINFO: OfIDjCoIYH8A/zkPqPRqaLeE0tNz6OglPAarIwndLUIvksPwaSZPuPTYLxM68e
	 3/iAAQddQMJSnAB+4P2R9ifWriST+9BHAqqdSFyGFdjHWDPoVQqPZE4bsTOIAHYHjIGUbq7fmT0G
	 i1Yipcy4cVrXlkyKHOf3+B62NIa3fkr9f09pO+snum0K+7O6QL1vZ10Bl6w1soOR//0bJyvQN2W/
	 LSLi08nyf2nUA/POcpZbnn9sh0/ccs6885hzWh8Qp7tqW5xmGKbPAm3pwetDSLquW3597TEpCNE9
	 6KmhbGilvLBvREwL6m8DH2mIifv1VU7hefMLQtV3FhkqLQfm5wGiQPGb3pWS3WFhDY8LVSAOkeCj
	 2B4aFAkUdbQdFuYBrrTYDFYdVLZWKYGMxo2FjkyungSZxUQ8+HCC41eONH9vs/7w8FG6a3iBd+VQ
	 4uGcjSrZGRsYcX0iTKlii7GWvRbUGKEj4kgawqIIVxqjwwIP4fLuX9+WLLt+nk45FVrzEXDqD0kn
	 6DrBtvV5MGu2aiMdVJdrBk2DHDPJLCYiBfUzKszfAjjgPEei7O2b+8yRZyDCDL8zKE7bQnk8rHSe
	 YQLJmQaMzKjcsPAthKipUFDNC07AAz/zP+CJz+78EELrFJXhzYVI+IvrsuSFvHkYUDsIHUEU+OEA
	 G2iIHYtf272wodFPONSksquva6Xi/BL9spWCO4uQc4hiYSUAxosKXTSpDVM16M+jXd4n5nHjQFfI
	 IEjkUFFIOyDl6geWESSdtl8/qdvQlz/zPY4F4SBQfCqm5oZ3LpAYtktCRyYE6zmCpK8fcuKdNP2o
	 QUOBbNxbU7dW1a8He3gRBMQX+QDRe8QQJsOEtw2wfTEagtguHt0XNT7uDwDvdGTIoXIfhyZ2eTfz
	 ZR5pMOn1aku79C+GqwdZfL8ui+twTpdCSIFLPakvKoTF5VejbWog49BqgFMLkVNV9mNDj6nZ3avb
	 haEOm5Nrr7nSzckARJfeue06qeOxjtSv5x7czjNy9AL8LX66EOlDPqx8pJ1wga5IxFigbTAnTXvj
	 KsekwdDsDlNZa0DAbP0ksxD/TeL43m4HqZPkaaDrEqYM2s8/+dEnT7AVUt2sK+Go+4jhhvceKeVM
	 7yz7SmOiY+q8t3WIgLAYEBGPvaQ9/1Qe1f3uvCgM4W53xVuyxP8HVGIzIwDw==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linkinjeon@kernel.org,
	stfrench@microsoft.com,
	d.ornaghi97@gmail.com,
	knavaneeth786@gmail.com,
	charsyam@gmail.com,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y v3 4/4] ksmbd: close durable scavenger races against m_fp_list lookups
Date: Tue, 26 May 2026 15:58:42 +0800
X-OQ-MSGID: <20260526075843.50277-4-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526075843.50277-1-alvalan9@foxmail.com>
References: <tencent_03EB621C56988886195ADF9AA78F33494007@qq.com>
 <20260526075843.50277-1-alvalan9@foxmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254268-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,gmail.com,foxmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,foxmail.com:email,foxmail.com:dkim]
X-Rspamd-Queue-Id: 666D15D231C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: DaeMyung Kang <charsyam@gmail.com>

[ Upstream commit bf736184d063da1a552ffeff0481813599a182cc ]

ksmbd_durable_scavenger() has two related races against any walker
that iterates f_ci->m_fp_list, including ksmbd_lookup_fd_inode()
(used by ksmbd_vfs_rename) and the share-mode checks in
fs/smb/server/smb_common.c.

(1) fp->node list-head reuse.  Durable-preserved handles can remain
linked on f_ci->m_fp_list after session teardown so share-mode checks
still see them while the handle is reconnectable.  The scavenger
collected expired handles by adding fp->node to a local
scavenger_list after removing them from the global durable idr.
Because fp->node is the same list_head used by m_fp_list,
list_add(&fp->node, &scavenger_list) overwrites the m_fp_list links
and corrupts both lists.  CONFIG_DEBUG_LIST can report this on the
share-mode walk path.

(2) Refcount race against m_fp_list walkers.  The scavenger qualifies
an expired durable handle with atomic_read(&fp->refcount) > 1 and
fp->conn under global_ft.lock, removes fp from global_ft, then drops
global_ft.lock before unlinking fp from m_fp_list and freeing it.
During that gap fp is still linked on m_fp_list with f_state ==
FP_INITED.  ksmbd_lookup_fd_inode() under m_lock read calls
ksmbd_fp_get() (atomic_inc_not_zero on refcount that is still 1) and
takes a live reference; the scavenger then unlinks and frees fp
while the holder owns a reference, leading to UAF on the holder's
subsequent ksmbd_fd_put() and on any field reads performed by a
concurrent share-mode walker that iterates m_fp_list without taking
ksmbd_fp_get() (smb_check_perm_dleases-like paths).

Fix both:

  * Stop reusing fp->node as a scavenger-private list node.  Remove
    one expired handle from global_ft under global_ft.lock, take an
    explicit transient reference, drop the lock, unlink fp->node
    from m_fp_list under f_ci->m_lock, then drop both the durable
    lifetime and transient references with atomic_sub_and_test(2,
    &fp->refcount).  If the scavenger is the last putter the close
    runs there; otherwise an in-flight holder that already raced
    through the m_fp_list lookup owns the final close via its
    ksmbd_fd_put() path.  The one-at-a-time disposal can rescan the
    durable idr when multiple handles expire in the same pass, but
    durable scavenging is a background expiration path and the final
    full scan recomputes min_timeout before the next wait.

  * Clear fp->persistent_id inside __ksmbd_remove_durable_fd() right
    after idr_remove(), so a delayed final close from a holder that
    snatched fp does not re-issue idr_remove() on a persistent id
    that idr_alloc_cyclic() in ksmbd_open_durable_fd() may have
    already handed out to a brand-new durable handle.

  * Bypass the per-conn open_files_count decrement in
    __put_fd_final() when fp is detached from any session table
    (fp->conn cleared by session_fd_check() at durable preserve --
    paired with the volatile_id clear at unpublish, so checking
    fp->conn alone is sufficient).  The walker that owns the final
    close runs from an unrelated work->conn whose
    stats.open_files_count never tracked this durable fp; without
    this guard the holder would underflow that unrelated counter.

The two races are folded into one patch because patch (1) alone
cleans up the corrupted list but leaves a deterministic UAF window
for m_fp_list walkers that the transient-reference and
persistent_id discipline in (2) close; bisecting onto an
intermediate state would land on a UAF that pre-patch chaos merely
made less reproducible.

Validation:
  * CONFIG_DEBUG_LIST coverage for the list_head reuse path.
  * KASAN-enabled direct SMB2 durable-handle coverage that exercised
    ksmbd_durable_scavenger() and non-NULL ksmbd_lookup_fd_inode()
    returns while durable handles expired under concurrent rename
    lookups, with no KASAN, UAF, list-corruption, ODEBUG, or WARNING
    reports.
  * checkpatch --strict
  * make -j$(nproc) M=fs/smb/server

Fixes: d484d621d40f ("ksmbd: add durable scavenger timer")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 fs/smb/server/vfs_cache.c | 104 ++++++++++++++++++++++++++++----------
 1 file changed, 77 insertions(+), 27 deletions(-)

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 544387c9a6f4..8faa5d97f7e1 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -325,6 +325,14 @@ static void __ksmbd_remove_durable_fd(struct ksmbd_file *fp)
 		return;
 
 	idr_remove(global_ft.idr, fp->persistent_id);
+	/*
+	 * Clear persistent_id so a later __ksmbd_close_fd() that runs from a
+	 * delayed putter (e.g. when a concurrent ksmbd_lookup_fd_inode()
+	 * walker held the final reference) does not re-issue idr_remove() on
+	 * an id that idr_alloc_cyclic() may have already handed out to a new
+	 * durable handle.
+	 */
+	fp->persistent_id = KSMBD_NO_FID;
 }
 
 static void ksmbd_remove_durable_fd(struct ksmbd_file *fp)
@@ -417,6 +425,20 @@ static struct ksmbd_file *__ksmbd_lookup_fd(struct ksmbd_file_table *ft,
 
 static void __put_fd_final(struct ksmbd_work *work, struct ksmbd_file *fp)
 {
+	/*
+	 * Detached durable fp -- session_fd_check() cleared fp->conn at
+	 * preserve, so this fp is no longer tracked by any conn's
+	 * stats.open_files_count.  This happens when
+	 * ksmbd_scavenger_dispose_dh() hands the final close off to an
+	 * m_fp_list walker (e.g. ksmbd_lookup_fd_inode()) whose work->conn
+	 * is unrelated to the conn that originally opened the handle; close
+	 * via the NULL-ft path so we do not underflow that unrelated
+	 * counter.
+	 */
+	if (!fp->conn) {
+		__ksmbd_close_fd(NULL, fp);
+		return;
+	}
 	__ksmbd_close_fd(&work->sess->file_table, fp);
 	atomic_dec(&work->conn->stats.open_files_count);
 }
@@ -792,24 +814,37 @@ static bool ksmbd_durable_scavenger_alive(void)
 	return true;
 }
 
-static void ksmbd_scavenger_dispose_dh(struct list_head *head)
+static void ksmbd_scavenger_dispose_dh(struct ksmbd_file *fp)
 {
-	while (!list_empty(head)) {
-		struct ksmbd_file *fp;
+	/*
+	 * Durable-preserved fp can remain linked on f_ci->m_fp_list for
+	 * share-mode checks.  Unlink it before final close; fp->node is not
+	 * available as a scavenger-private list node because re-adding it to
+	 * another list corrupts m_fp_list.
+	 */
+	down_write(&fp->f_ci->m_lock);
+	list_del_init(&fp->node);
+	up_write(&fp->f_ci->m_lock);
 
-		fp = list_first_entry(head, struct ksmbd_file, node);
-		list_del_init(&fp->node);
+	/*
+	 * Drop both the durable lifetime reference and the transient reference
+	 * taken by the scavenger under global_ft.lock.  If a concurrent
+	 * ksmbd_lookup_fd_inode() (or any other m_fp_list walker) snatched fp
+	 * before the unlink above, that holder owns the final close via
+	 * ksmbd_fd_put() -> __ksmbd_close_fd().  Otherwise the scavenger is
+	 * the last putter and finalises fp here.
+	 */
+	if (atomic_sub_and_test(2, &fp->refcount))
 		__ksmbd_close_fd(NULL, fp);
-	}
 }
 
 static int ksmbd_durable_scavenger(void *dummy)
 {
 	struct ksmbd_file *fp = NULL;
+	struct ksmbd_file *expired_fp;
 	unsigned int id;
 	unsigned int min_timeout = 1;
 	bool found_fp_timeout;
-	LIST_HEAD(scavenger_list);
 	unsigned long remaining_jiffies;
 
 	__module_get(THIS_MODULE);
@@ -819,8 +854,6 @@ static int ksmbd_durable_scavenger(void *dummy)
 		if (try_to_freeze())
 			continue;
 
-		found_fp_timeout = false;
-
 		remaining_jiffies = wait_event_timeout(dh_wq,
 				   ksmbd_durable_scavenger_alive() == false,
 				   __msecs_to_jiffies(min_timeout));
@@ -829,23 +862,39 @@ static int ksmbd_durable_scavenger(void *dummy)
 		else
 			min_timeout = DURABLE_HANDLE_MAX_TIMEOUT;
 
-		write_lock(&global_ft.lock);
-		idr_for_each_entry(global_ft.idr, fp, id) {
-			if (!fp->durable_timeout)
-				continue;
-
-			if (atomic_read(&fp->refcount) > 1 ||
-			    fp->conn)
-				continue;
-
-			found_fp_timeout = true;
-			if (fp->durable_scavenger_timeout <=
-			    jiffies_to_msecs(jiffies)) {
-				__ksmbd_remove_durable_fd(fp);
-				list_add(&fp->node, &scavenger_list);
-			} else {
+		do {
+			expired_fp = NULL;
+			found_fp_timeout = false;
+
+			write_lock(&global_ft.lock);
+			idr_for_each_entry(global_ft.idr, fp, id) {
 				unsigned long durable_timeout;
 
+				if (!fp->durable_timeout)
+					continue;
+
+				if (atomic_read(&fp->refcount) > 1 ||
+				    fp->conn)
+					continue;
+
+				found_fp_timeout = true;
+				if (fp->durable_scavenger_timeout <=
+				    jiffies_to_msecs(jiffies)) {
+					__ksmbd_remove_durable_fd(fp);
+					/*
+					 * Take a transient reference so fp
+					 * cannot be freed by an in-flight
+					 * ksmbd_lookup_fd_inode() that found
+					 * it through f_ci->m_fp_list while we
+					 * drop global_ft.lock and reach the
+					 * m_fp_list unlink in
+					 * ksmbd_scavenger_dispose_dh().
+					 */
+					atomic_inc(&fp->refcount);
+					expired_fp = fp;
+					break;
+				}
+
 				durable_timeout =
 					fp->durable_scavenger_timeout -
 						jiffies_to_msecs(jiffies);
@@ -853,10 +902,11 @@ static int ksmbd_durable_scavenger(void *dummy)
 				if (min_timeout > durable_timeout)
 					min_timeout = durable_timeout;
 			}
-		}
-		write_unlock(&global_ft.lock);
+			write_unlock(&global_ft.lock);
 
-		ksmbd_scavenger_dispose_dh(&scavenger_list);
+			if (expired_fp)
+				ksmbd_scavenger_dispose_dh(expired_fp);
+		} while (expired_fp);
 
 		if (found_fp_timeout == false)
 			break;
-- 
2.43.0


