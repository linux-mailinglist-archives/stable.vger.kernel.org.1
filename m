Return-Path: <stable+bounces-230658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GdPKgqHxmlALQUAu9opvQ
	(envelope-from <stable+bounces-230658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:32:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14780345466
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB04D301DBBF
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 13:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097AE34B434;
	Fri, 27 Mar 2026 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVAsYc/h"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936722EC097
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774618375; cv=none; b=gHZKYA3K1D8ij4Cn8+z1X4hmEZZGYAMvskbpeZEdWMZ5Odz+9r31E9321NlXeS42IKn9J6dIR31R7gPTId4M29pyAfJgMvkKO8x5Gk0uTn6CwVUoP28G16mkubp8is8pW9sr4evEYyJkFCMhwS3/shaqmGbp6P4V5nnnFtz/Zd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774618375; c=relaxed/simple;
	bh=PNjh+nBtoovM25MVmCPA4ZyoI9w3XN6jgyoE16tARQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DnmZRXDu9ZgUEI7e4LFCmVb8w4ch31mGBuO4JjaNPyxykHAiVL8BukEibb8duCn3CObNB0ZfKEl4ZwbulA7AR9J8L8nMhRt9rG3P6+MEmjEvHF7Hm1OWIszVAWSShj/xMj7HOuwD5ADa+q6kvBB+AHoL+oGOQxv+BcRiCNyOyxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVAsYc/h; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b04d051664so17818595ad.0
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 06:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774618374; x=1775223174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EONMaUpVytMI8mDTZgVkhsH1HsODfwxhYYTYobffMbc=;
        b=HVAsYc/hEzGlJ8sfhC3A85W9aLu2mel2OEhfeLtDX+VrhsAi+GaB2KyYXVM9eFaXVN
         Jj8CCKRuTI15YZ1aPJaYfflEZKA0AslUbkL1G2T80ctAygOT6Gyog+CYtFbPnjZQ1SVc
         mahvRN4Z7UUd0RRDRhuVnOF/CiWvOs6RFX6iocsYGjIwTqNHFUiZME6fcAkpGZCibkfP
         gZW9cHvn4wfcGVR9UsgOHpPlDw29rq1eOkqS186n/ufIEPiKebVgyBrlc8s0wIW+bqbk
         8LTvoFDUFI+p7XC3aQMj0V8kK9kM6oaGrMf94H9LZcXiaTACi5PYpLf6kDrNGf+riEFN
         z5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774618374; x=1775223174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EONMaUpVytMI8mDTZgVkhsH1HsODfwxhYYTYobffMbc=;
        b=d/yXwFKwqUiaJFpKqCXBaa91O1dQk7gB9qqo6FJFc3r08VPT9CR2vC2j32NIYd0BWJ
         tIYUcQaaw95ohqAmtZ2V7l2TpLVjPUQxvZAaB3lzbWVkE6KLbonXWAZXJdLoYb1KheSa
         AShYEeAf9gsNEPDMIdyY/B3BkHTxy4jUrSI0fVWa7JwKNVSGvh67gIcdOdGtplXg/BpO
         VDcPco4oy3Z6EQ1IQ3pUpcjfqZcze8R6Tv8HNp1JyBTR7XOhW6bLzjnNZUs6pJCKRdjx
         ZQiK26xqJC6+f/KSNMDNmxb5ZZ2jCDg16DnTiiIXYx1IfKEtFL19VClYFmVWVGpp25tN
         Svgw==
X-Forwarded-Encrypted: i=1; AJvYcCXeiFBaiqUGTI+sxyi5Iyl2LX6V3upoXjPa/7iyvJc0gzXvJuhX/eSXdFU7tE2iM9Rv+h77u+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDMKiobraDckJGMyvEEu2U9+Zt6YxiyPlgnd5qwi8vgltQxNgs
	3YTjc075uuMwy5lV/y97YL/rZh0xnf/fLIiD8Un1MCxJnnAmwnrpT3gk
X-Gm-Gg: ATEYQzyPlC2p7fy3UP6m2nV27lIq4kNebD3O66BwC2ChnBxpdyaE5coU6osjyB3D0BF
	ETVZ7kPbrPCreB/U/XnBmkuRbRvdcky3dotVCK/XY8Z8tuAaOAOeiguZeUlgK7W4Wb+ssl1dyQT
	LRdqHkFCdfMOPH86N8rAgUVt6wPCIEGCt67ylWihotDlyPzU9oR6LnkjJjIFxwH2n0VxE21wJ0F
	idX5aZzvHGvt/kKBAN4c0A+ONzQXgjj7cYa9DXIiEohACniAizUP8SMeD9J82Wmy1JhgiWwh+oQ
	MB+5PJ3wSZlUh0ABVOAnexPk8YkzecdqI5ugX6TQxUAF3ZwDeBXl55qYEM4iLzMX5OwcUj3orkd
	NP6H3AWI9bvlLMeZWmjOI2zhuQsNbAH2S33HutV6i5yJ2Jb8CDaCa+2i2b8P5GQro8zw3ZPqip8
	sqtqEmhoEH3ENFsyShnk/DuTvZbsWi
X-Received: by 2002:a17:903:1ac4:b0:2b2:3eec:c75f with SMTP id d9443c01a7336-2b23eecd14fmr677615ad.28.1774618373775;
        Fri, 27 Mar 2026 06:32:53 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc7b8adasm82689115ad.33.2026.03.27.06.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 06:32:53 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: cem@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] xfs: annotate lockless bli_flags access in buf item paths
Date: Fri, 27 Mar 2026 21:14:48 +0800
Message-Id: <20260327131448.156177-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230658-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14780345466
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xfs_buf_item_unpin() and xfs_buf_item_committed() read bip->bli_flags
without holding the buffer lock, while xfs_buf_item_release() clears
XFS_BLI_LOGGED, XFS_BLI_HOLD, and XFS_BLI_ORDERED under that lock.
This can happen when an older checkpoint still holds a CIL reference to
the BLI while a new transaction is finishing with the buffer.

The lockless readers only test XFS_BLI_STALE and
XFS_BLI_INODE_ALLOC_BUF, which are disjoint from the bits being
cleared, so correctness is not affected in practice.  However, the
plain C accesses still constitute a data race that may allow the
compiler to optimize them in unexpected ways (e.g., load tearing or
fused reloads), so they should be marked explicitly.

Annotate the two lockless reads with READ_ONCE(), make the clearing
store in xfs_buf_item_release() a WRITE_ONCE(), and use READ_ONCE() in
the buf-item tracepoint that may snapshot bli_flags without the lock.

Fixes: 8e1238508633 ("xfs: remove stale parameter from ->iop_unpin method")
Fixes: 71e330b59390 ("xfs: Introduce delayed logging core code")
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 fs/xfs/xfs_buf_item.c | 18 +++++++++++-------
 fs/xfs/xfs_trace.h    |  2 +-
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 8487635579e5..c3d0dc17ee10 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -502,7 +502,8 @@ xfs_buf_item_unpin(
 {
 	struct xfs_buf_log_item	*bip = BUF_ITEM(lip);
 	struct xfs_buf		*bp = bip->bli_buf;
-	int			stale = bip->bli_flags & XFS_BLI_STALE;
+	unsigned int		flags = READ_ONCE(bip->bli_flags);
+	int			stale = flags & XFS_BLI_STALE;
 	int			freed;
 
 	ASSERT(bp->b_log_item == bip);
@@ -679,13 +680,14 @@ xfs_buf_item_release(
 {
 	struct xfs_buf_log_item	*bip = BUF_ITEM(lip);
 	struct xfs_buf		*bp = bip->bli_buf;
-	bool			hold = bip->bli_flags & XFS_BLI_HOLD;
-	bool			stale = bip->bli_flags & XFS_BLI_STALE;
+	unsigned int		flags = bip->bli_flags;
+	bool			hold = flags & XFS_BLI_HOLD;
+	bool			stale = flags & XFS_BLI_STALE;
 	bool			aborted = test_bit(XFS_LI_ABORTED,
 						   &lip->li_flags);
-	bool			dirty = bip->bli_flags & XFS_BLI_DIRTY;
+	bool			dirty = flags & XFS_BLI_DIRTY;
 #if defined(DEBUG) || defined(XFS_WARN)
-	bool			ordered = bip->bli_flags & XFS_BLI_ORDERED;
+	bool			ordered = flags & XFS_BLI_ORDERED;
 #endif
 
 	trace_xfs_buf_item_release(bip);
@@ -705,7 +707,8 @@ xfs_buf_item_release(
 	 * per-transaction state from the bli, which has been copied above.
 	 */
 	bp->b_transp = NULL;
-	bip->bli_flags &= ~(XFS_BLI_LOGGED | XFS_BLI_HOLD | XFS_BLI_ORDERED);
+	WRITE_ONCE(bip->bli_flags,
+		   flags & ~(XFS_BLI_LOGGED | XFS_BLI_HOLD | XFS_BLI_ORDERED));
 
 	/* If there are other references, then we have nothing to do. */
 	if (!atomic_dec_and_test(&bip->bli_refcount))
@@ -792,10 +795,11 @@ xfs_buf_item_committed(
 	xfs_lsn_t		lsn)
 {
 	struct xfs_buf_log_item	*bip = BUF_ITEM(lip);
+	unsigned int		flags = READ_ONCE(bip->bli_flags);
 
 	trace_xfs_buf_item_committed(bip);
 
-	if ((bip->bli_flags & XFS_BLI_INODE_ALLOC_BUF) && lip->li_lsn != 0)
+	if ((flags & XFS_BLI_INODE_ALLOC_BUF) && lip->li_lsn != 0)
 		return lip->li_lsn;
 	return lsn;
 }
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 813e5a9f57eb..2069534bb0c1 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -895,7 +895,7 @@ DECLARE_EVENT_CLASS(xfs_buf_item_class,
 	),
 	TP_fast_assign(
 		__entry->dev = bip->bli_buf->b_target->bt_dev;
-		__entry->bli_flags = bip->bli_flags;
+		__entry->bli_flags = READ_ONCE(bip->bli_flags);
 		__entry->bli_recur = bip->bli_recur;
 		__entry->bli_refcount = atomic_read(&bip->bli_refcount);
 		__entry->buf_bno = xfs_buf_daddr(bip->bli_buf);
-- 
2.34.1


