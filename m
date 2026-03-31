Return-Path: <stable+bounces-231341-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGLQFChzy2k3HwYAu9opvQ
	(envelope-from <stable+bounces-231341-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:09:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC325364CDE
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29BC7306514F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14973B4EA0;
	Tue, 31 Mar 2026 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="EMjTzWyn"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDEB3590A9
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940806; cv=none; b=SzsbG/lvBOo0Jqp82XvHKNG/ItSo8qPYurkPwNSqjqc4JHFfzPNbdZEWWfpOwv8mDDjwHHpMY8yQsvUsIFYoQzHJIf1eA5EPK9iCb4grGh9e/09iVXqLdsdz+J93c+6XbWGhf6xm6U0Fk+kIVPSQum/EyG2OqHixGXLxSU5+Rmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940806; c=relaxed/simple;
	bh=avJD1T3B2u2ZUEoocBwkD6KPjrhAm2HcoLWAQXvv/FQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S12Xa6TZ/5F/ylxSDy2+VDAgA+a6adWEIlwV9pDxD6+pE7fgAwdCC+Bl+ccXdEnMywqTA5HC1iA9n/Pum4SqYx1nzHr31cz7l4gabDYwQkjg35gOOAd8wU+523rOqLQted/g6aaw+S/YUWkc1jrJWAVhFf0uWMBG9/6LDIkmZbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=EMjTzWyn; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1774940805; x=1806476805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HyCNCu0Z2073gZF/iB62V3wwk8F4wsA50TJXvrJcpLM=;
  b=EMjTzWynGTRZiJdqA2IHWBeIHRo0Ip4hym2wWnQiQGSMVP4B+Nra3hAa
   lljyGPNaVrY/PPOf6BFYZenPyTsqr1PrQdFbNtJYW6IYKzD3IV76PxFTq
   t2hbg+uWE1VaN96H6gDHbf75XA8gLUTEkGEapy4v7BF+V0/x0sHI7sEiR
   wk1qormhPiNfQwhRRb4mZnBIopsoZKMrhxu9GlKVU8Fx6xTyFk6y1HkTw
   HzkpkXL468kNzTjhyCSfIiJ68E8D6u718q2h1zxP8ch+HoSLA99PeQiOF
   7q25RjxEQjIp6nWeit05pL7QowVANBvQV2lWF3I7uDP68H5HflzXSqIo1
   Q==;
X-CSE-ConnectionGUID: HvHgfO0ZQhGZt0VALuuYUA==
X-CSE-MsgGUID: l59KFZ93TuezGOiq4SjWwg==
X-IronPort-AV: E=Sophos;i="6.23,151,1770595200"; 
   d="scan'208";a="16076641"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 07:06:42 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:10075]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.226:2525] with esmtp (Farcaster)
 id ba5293ef-85ee-4854-8785-3ffbd44aa2c6; Tue, 31 Mar 2026 07:06:41 +0000 (UTC)
X-Farcaster-Flow-ID: ba5293ef-85ee-4854-8785-3ffbd44aa2c6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 31 Mar 2026 07:06:41 +0000
Received: from c889f3b07a0a.amazon.com (10.106.82.29) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 31 Mar 2026 07:06:39 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <cem@kernel.org>, <djwong@kernel.org>, "Yuto
 Ohnuki" <ytohnuki@amazon.com>,
	<syzbot+652af2b3c5569c4ab63c@syzkaller.appspotmail.com>
Subject: [PATCH 6.1.y 1/2] xfs: avoid dereferencing log items after push callbacks
Date: Tue, 31 Mar 2026 08:06:31 +0100
Message-ID: <20260331070630.61613-2-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <2026033026-recycler-barstool-5e75@gregkh>
References: <2026033026-recycler-barstool-5e75@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
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
	TAGGED_FROM(0.00)[bounces-231341-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url];
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
X-Rspamd-Queue-Id: BC325364CDE
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
 fs/xfs/xfs_trace.c     |  1 +
 fs/xfs/xfs_trace.h     | 36 ++++++++++++++++++++++++++++++++----
 fs/xfs/xfs_trans_ail.c | 26 +++++++++++++++++++-------
 3 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/xfs_trace.c b/fs/xfs/xfs_trace.c
index d269ef57ff01..dcf9af0108c1 100644
--- a/fs/xfs/xfs_trace.c
+++ b/fs/xfs/xfs_trace.c
@@ -22,6 +22,7 @@
 #include "xfs_trans.h"
 #include "xfs_log.h"
 #include "xfs_log_priv.h"
+#include "xfs_trans_priv.h"
 #include "xfs_buf_item.h"
 #include "xfs_quota.h"
 #include "xfs_dquot_item.h"
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index a9e3081b6625..a7245de495a5 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -47,6 +47,7 @@
 #include <linux/tracepoint.h>
 
 struct xfs_agf;
+struct xfs_ail;
 struct xfs_alloc_arg;
 struct xfs_attr_list_context;
 struct xfs_buf_log_item;
@@ -1335,14 +1336,41 @@ TRACE_EVENT(xfs_log_force,
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
index f51df7d94ef7..fc2cbac4a8b7 100644
--- a/fs/xfs/xfs_trans_ail.c
+++ b/fs/xfs/xfs_trans_ail.c
@@ -389,6 +389,12 @@ xfsaild_resubmit_item(
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
@@ -474,20 +480,26 @@ xfsaild_push(
 
 	lsn = lip->li_lsn;
 	while ((XFS_LSN_CMP(lip->li_lsn, target) <= 0)) {
-		int	lock_result;
+		int		lock_result;
+		uint		type = lip->li_type;
+		unsigned long	flags = lip->li_flags;
+		xfs_lsn_t	item_lsn = lip->li_lsn;
 
 		/*
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
@@ -503,22 +515,22 @@ xfsaild_push(
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




