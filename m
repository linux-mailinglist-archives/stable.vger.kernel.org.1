Return-Path: <stable+bounces-231336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HXyOPluy2k3HwYAu9opvQ
	(envelope-from <stable+bounces-231336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 08:51:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 669DA364A1B
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 08:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DE3A304B5FB
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 06:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AE23B5832;
	Tue, 31 Mar 2026 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="a3336s2r"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676493B19CE
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774939853; cv=none; b=M1gSkrxj3l3lPBF8tT7uZLzXRbH4Mi2rmdp60ZDowqObwOMrhmzRS9WGOIk0KjuGyaz5khzw1aAinmwMr+rx83MzrZGAzg3fHOs8y5N7Uf1J2uo1R343sNtBdK1DnkpGmBmKJLaA0dD0g5a9Qb8yDhTlAvwd7sAo4BjXo/8AtBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774939853; c=relaxed/simple;
	bh=YmqbYqkIavX3ApJdGEM92xne3K0aMrS/ry8E0XFzSnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmTZ1VO4IVwDubhPEM5Jh3kpmRvW3HQeuQQmF4CjqKv2aDgktj0MkMp/haRQ8/8N+3O9dSurGwCsauyYbsSFhROnZtSkgwv+9CXOsn2Nr8uLPVpJvd46hGiW/H7W3/lppXHrSSpvi0HcRKZ+lqL7HnThydBeZt1i7IcFofJBvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=a3336s2r; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1774939852; x=1806475852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TkhUR1CBsXLgl3atUuYiM7nBfs6xnEatdqIUxbRh8e0=;
  b=a3336s2r41aH7KVKd0NgjfsF7Ah67mHiIgzsVqB0v410yGv2LMkJ47og
   WsPBZzk/OVSUl8Yz5VzGwhEVgu5XySqObpU0Akg5GDswir0e15BxhxE0L
   c7FGDBzcporOZNKgLDLkNxCbDQnZI1/rYN9RHUzUHWc8+Az+V7rH8jZNP
   oWt1aa7TnGi1Gn1AZ+okcf1v76gk8OfHWQ8unX4xJKmMBgSPLmOh8BqS/
   zh1DeDnlsLvbC0jZjUwHJrPDzi4JI8mWg6YNLXqvzStmXAjMrj4uQ+yyv
   bP5odIVrrtbikeOwYXXrkO+3rpNq5zUzXyk8lnF1PqShPqCAdtPmraKw1
   A==;
X-CSE-ConnectionGUID: o4z9XnPORfGYoHJ8K2Fipg==
X-CSE-MsgGUID: +HaJVodNSw6ZjplnzeKFGw==
X-IronPort-AV: E=Sophos;i="6.23,151,1770595200"; 
   d="scan'208";a="15713178"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 06:50:49 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:18519]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.226:2525] with esmtp (Farcaster)
 id fcbd0758-c485-4c07-a574-970610dab2b8; Tue, 31 Mar 2026 06:50:49 +0000 (UTC)
X-Farcaster-Flow-ID: fcbd0758-c485-4c07-a574-970610dab2b8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 31 Mar 2026 06:50:49 +0000
Received: from c889f3b07a0a.amazon.com (10.106.82.29) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 31 Mar 2026 06:50:47 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <cem@kernel.org>, <djwong@kernel.org>, "Yuto
 Ohnuki" <ytohnuki@amazon.com>,
	<syzbot+652af2b3c5569c4ab63c@syzkaller.appspotmail.com>
Subject: [PATCH 6.12.y] xfs: avoid dereferencing log items after push callbacks
Date: Tue, 31 Mar 2026 07:50:39 +0100
Message-ID: <20260331065038.55682-2-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <2026033024-aground-clavicle-093b@gregkh>
References: <2026033024-aground-clavicle-093b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-231336-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ytohnuki@amazon.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable,652af2b3c5569c4ab63c];
	NEURAL_HAM(-0.00)[-0.991];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 669DA364A1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
(cherry picked from commit 79ef34ec0554ec04bdbafafbc9836423734e1bd6)
---
 fs/xfs/xfs_trace.h     | 36 ++++++++++++++++++++++++++++++++----
 fs/xfs/xfs_trans_ail.c | 26 +++++++++++++++++++-------
 2 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index fcb2bad4f76e..f50a2862011b 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -52,6 +52,7 @@
 #include <linux/tracepoint.h>
 
 struct xfs_agf;
+struct xfs_ail;
 struct xfs_alloc_arg;
 struct xfs_attr_list_context;
 struct xfs_buf_log_item;
@@ -1351,14 +1352,41 @@ TRACE_EVENT(xfs_log_force,
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
index f56d62dced97..85641af916a0 100644
--- a/fs/xfs/xfs_trans_ail.c
+++ b/fs/xfs/xfs_trans_ail.c
@@ -370,6 +370,12 @@ xfsaild_resubmit_item(
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
@@ -510,7 +516,10 @@ xfsaild_push(
 
 	lsn = lip->li_lsn;
 	while ((XFS_LSN_CMP(lip->li_lsn, ailp->ail_target) <= 0)) {
-		int	lock_result;
+		int		lock_result;
+		uint		type = lip->li_type;
+		unsigned long	flags = lip->li_flags;
+		xfs_lsn_t	item_lsn = lip->li_lsn;
 
 		if (test_bit(XFS_LI_FLUSHING, &lip->li_flags))
 			goto next_item;
@@ -519,14 +528,17 @@ xfsaild_push(
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
@@ -542,22 +554,22 @@ xfsaild_push(
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
-- 
2.50.1




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705




