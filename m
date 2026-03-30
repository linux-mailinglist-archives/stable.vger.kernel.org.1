Return-Path: <stable+bounces-231130-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD/NBBdJymkQ7QUAu9opvQ
	(envelope-from <stable+bounces-231130-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:57:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B05358B29
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F92A3002B72
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC81C3A783B;
	Mon, 30 Mar 2026 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jDAbyJbS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B057D382362
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864649; cv=none; b=kkyexEEPiuPqKFA/k0aXT09YpZoVkhiG7PQOIxrKVNwcVwieW1/WBF5BFq6N2BiJZtGAHzZQMV6kOLNGhGBnUqLEVNJw4QgLoDUMZ9F0xx2DUvdqkDTfoaNvWgYgFgITITfSVauSaut6ruaA9F5mfq1IFuGNtF3/hstSyaIMb44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864649; c=relaxed/simple;
	bh=xEEHB6cRYKKpslPQ/21wCg++4/zKkxK+PTNWmUaJ/og=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QDd7mDt5pv2rdwV7z2staPOnpKixcdGa6lgFhh0VcmubP1XoXGBVmD5ZWCXBEUtskfhtqqL2gpMCerD2gocQT9iHtPK+IuiIeopaPyVMe4uVc/Wt7Ds84CUUyYSqQxlcCS9NsLN85ayG4ZgX1B5IBMJ06wXbLi4+mkIRgT706Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jDAbyJbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEB7C4CEF7;
	Mon, 30 Mar 2026 09:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774864649;
	bh=xEEHB6cRYKKpslPQ/21wCg++4/zKkxK+PTNWmUaJ/og=;
	h=Subject:To:Cc:From:Date:From;
	b=jDAbyJbSZAF0/WpbZ7Zx0xfpAxUBmkYcILBQyAO/LdNHA/hi89wwwwPOqaaWHJ/ua
	 RHjd5Ibh0yQ+J52kCdHflCBhk5RZlSR6OpD62PsGqjeymrH+JLEdb06ly8et5aYJVl
	 NkaWeWomGVnyAjHpwDmznAcILouuHpi5qlz3PhJ8=
Subject: FAILED: patch "[PATCH] xfs: avoid dereferencing log items after push callbacks" failed to apply to 6.12-stable tree
To: ytohnuki@amazon.com,cem@kernel.org,djwong@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:57:24 +0200
Message-ID: <2026033024-aground-clavicle-093b@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231130-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[syzkaller.appspot.com:query timed out];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: 48B05358B29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 79ef34ec0554ec04bdbafafbc9836423734e1bd6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033024-aground-clavicle-093b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 79ef34ec0554ec04bdbafafbc9836423734e1bd6 Mon Sep 17 00:00:00 2001
From: Yuto Ohnuki <ytohnuki@amazon.com>
Date: Tue, 10 Mar 2026 18:38:38 +0000
Subject: [PATCH] xfs: avoid dereferencing log items after push callbacks

After xfsaild_push_item() calls iop_push(), the log item may have been
freed if the AIL lock was dropped during the push. Background inode
reclaim or the dquot shrinker can free the log item while the AIL lock
is not held, and the tracepoints in the switch statement dereference
the log item after iop_push() returns.

Fix this by capturing the log item type, flags, and LSN before calling
xfsaild_push_item(), and introducing a new xfs_ail_push_class trace
event class that takes these pre-captured values and the ailp pointer
instead of the log item pointer.

Reported-by: syzbot+652af2b3c5569c4ab63c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=652af2b3c5569c4ab63c
Fixes: 90c60e164012 ("xfs: xfs_iflush() is no longer necessary")
Cc: stable@vger.kernel.org # v5.9
Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 813e5a9f57eb..0e994b3f768f 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -56,6 +56,7 @@
 #include <linux/tracepoint.h>
 
 struct xfs_agf;
+struct xfs_ail;
 struct xfs_alloc_arg;
 struct xfs_attr_list_context;
 struct xfs_buf_log_item;
@@ -1650,16 +1651,43 @@ TRACE_EVENT(xfs_log_force,
 DEFINE_EVENT(xfs_log_item_class, name, \
 	TP_PROTO(struct xfs_log_item *lip), \
 	TP_ARGS(lip))
-DEFINE_LOG_ITEM_EVENT(xfs_ail_push);
-DEFINE_LOG_ITEM_EVENT(xfs_ail_pinned);
-DEFINE_LOG_ITEM_EVENT(xfs_ail_locked);
-DEFINE_LOG_ITEM_EVENT(xfs_ail_flushing);
 DEFINE_LOG_ITEM_EVENT(xfs_cil_whiteout_mark);
 DEFINE_LOG_ITEM_EVENT(xfs_cil_whiteout_skip);
 DEFINE_LOG_ITEM_EVENT(xfs_cil_whiteout_unpin);
 DEFINE_LOG_ITEM_EVENT(xlog_ail_insert_abort);
 DEFINE_LOG_ITEM_EVENT(xfs_trans_free_abort);
 
+DECLARE_EVENT_CLASS(xfs_ail_push_class,
+	TP_PROTO(struct xfs_ail *ailp, uint type, unsigned long flags, xfs_lsn_t lsn),
+	TP_ARGS(ailp, type, flags, lsn),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(uint, type)
+		__field(unsigned long, flags)
+		__field(xfs_lsn_t, lsn)
+	),
+	TP_fast_assign(
+		__entry->dev = ailp->ail_log->l_mp->m_super->s_dev;
+		__entry->type = type;
+		__entry->flags = flags;
+		__entry->lsn = lsn;
+	),
+	TP_printk("dev %d:%d lsn %d/%d type %s flags %s",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  CYCLE_LSN(__entry->lsn), BLOCK_LSN(__entry->lsn),
+		  __print_symbolic(__entry->type, XFS_LI_TYPE_DESC),
+		  __print_flags(__entry->flags, "|", XFS_LI_FLAGS))
+)
+
+#define DEFINE_AIL_PUSH_EVENT(name) \
+DEFINE_EVENT(xfs_ail_push_class, name, \
+	TP_PROTO(struct xfs_ail *ailp, uint type, unsigned long flags, xfs_lsn_t lsn), \
+	TP_ARGS(ailp, type, flags, lsn))
+DEFINE_AIL_PUSH_EVENT(xfs_ail_push);
+DEFINE_AIL_PUSH_EVENT(xfs_ail_pinned);
+DEFINE_AIL_PUSH_EVENT(xfs_ail_locked);
+DEFINE_AIL_PUSH_EVENT(xfs_ail_flushing);
+
 DECLARE_EVENT_CLASS(xfs_ail_class,
 	TP_PROTO(struct xfs_log_item *lip, xfs_lsn_t old_lsn, xfs_lsn_t new_lsn),
 	TP_ARGS(lip, old_lsn, new_lsn),
diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
index 923729af4206..63266d31b514 100644
--- a/fs/xfs/xfs_trans_ail.c
+++ b/fs/xfs/xfs_trans_ail.c
@@ -365,6 +365,12 @@ xfsaild_resubmit_item(
 	return XFS_ITEM_SUCCESS;
 }
 
+/*
+ * Push a single log item from the AIL.
+ *
+ * @lip may have been released and freed by the time this function returns,
+ * so callers must not dereference the log item afterwards.
+ */
 static inline uint
 xfsaild_push_item(
 	struct xfs_ail		*ailp,
@@ -505,7 +511,10 @@ xfsaild_push(
 
 	lsn = lip->li_lsn;
 	while ((XFS_LSN_CMP(lip->li_lsn, ailp->ail_target) <= 0)) {
-		int	lock_result;
+		int		lock_result;
+		uint		type = lip->li_type;
+		unsigned long	flags = lip->li_flags;
+		xfs_lsn_t	item_lsn = lip->li_lsn;
 
 		if (test_bit(XFS_LI_FLUSHING, &lip->li_flags))
 			goto next_item;
@@ -514,14 +523,17 @@ xfsaild_push(
 		 * Note that iop_push may unlock and reacquire the AIL lock.  We
 		 * rely on the AIL cursor implementation to be able to deal with
 		 * the dropped lock.
+		 *
+		 * The log item may have been freed by the push, so it must not
+		 * be accessed or dereferenced below this line.
 		 */
 		lock_result = xfsaild_push_item(ailp, lip);
 		switch (lock_result) {
 		case XFS_ITEM_SUCCESS:
 			XFS_STATS_INC(mp, xs_push_ail_success);
-			trace_xfs_ail_push(lip);
+			trace_xfs_ail_push(ailp, type, flags, item_lsn);
 
-			ailp->ail_last_pushed_lsn = lsn;
+			ailp->ail_last_pushed_lsn = item_lsn;
 			break;
 
 		case XFS_ITEM_FLUSHING:
@@ -537,22 +549,22 @@ xfsaild_push(
 			 * AIL is being flushed.
 			 */
 			XFS_STATS_INC(mp, xs_push_ail_flushing);
-			trace_xfs_ail_flushing(lip);
+			trace_xfs_ail_flushing(ailp, type, flags, item_lsn);
 
 			flushing++;
-			ailp->ail_last_pushed_lsn = lsn;
+			ailp->ail_last_pushed_lsn = item_lsn;
 			break;
 
 		case XFS_ITEM_PINNED:
 			XFS_STATS_INC(mp, xs_push_ail_pinned);
-			trace_xfs_ail_pinned(lip);
+			trace_xfs_ail_pinned(ailp, type, flags, item_lsn);
 
 			stuck++;
 			ailp->ail_log_flush++;
 			break;
 		case XFS_ITEM_LOCKED:
 			XFS_STATS_INC(mp, xs_push_ail_locked);
-			trace_xfs_ail_locked(lip);
+			trace_xfs_ail_locked(ailp, type, flags, item_lsn);
 
 			stuck++;
 			break;


