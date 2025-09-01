Return-Path: <stable+bounces-176816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC23B3DE97
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 11:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D54C443A71
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 09:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D70130DEC4;
	Mon,  1 Sep 2025 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="duhoG9Vf"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1230DEB1
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718998; cv=none; b=LdIgCZE/gKV8Xlb5mOmC2vCZbyExAwHvfEruCEftm26UcMx9KuyesQvdsyphUQmY9SzDME+kN+Zv2YJjNhnL8WBNhBHyA74ZRhMV9mLhRgGNJbjKKfBq4MN+qArQOx5EQr9ERXHJnpe43A50eSsR2WkSvTpNd4fLg3ryeXlRV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718998; c=relaxed/simple;
	bh=qZJxbmaqGWsy4atFe2P3rGVqkuLG6BlTXh6WeAcAyhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=Aws2wGG8AiIWTiGOuvCnFg8NFXJXKPjNk4rEEXCY4atvZKWUBFRm+uKNUz1Ans1+0i6Xq1e0oeTjud+5Pm1wEJldFK6MzI0Trlkb47PPmIsLekehhxRBdiyvHE/dNOuVxvgPK5gdWrORDO/EYnMJ5v0TK+KbIh27I/5XQMt+unU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=duhoG9Vf; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250901092952epoutp0499d8cd492f2035582eff6e41f95f16da~hHp3LK27z0566705667epoutp04J
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 09:29:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250901092952epoutp0499d8cd492f2035582eff6e41f95f16da~hHp3LK27z0566705667epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756718992;
	bh=74Q1v6jsTAK/snjr8Bol8mkXpMT6PrDDB7mwBUaLBDo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=duhoG9Vfo9MZOdJwEUweOVti6TF5ssKEaXuBHMXGEot2BY0fWmc9P0IBHlRSrsThv
	 tOpfjQieTm9YhADMDRenITqN/7yWck6ARrjqndgd8fQjNwztCOUxyzUKyQJx9D9emj
	 vhEPYe+CdkbzK61hgNNRDZTZLN/WrKt0Lsvg300o=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250901092952epcas5p15f9c1d6b59500aeac07e20af90cad9f6~hHp20veHp1370913709epcas5p13;
	Mon,  1 Sep 2025 09:29:52 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.86]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cFk9W4mCWz2SSKY; Mon,  1 Sep
	2025 09:29:51 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250901092950epcas5p35accdcb60fe3ba58772289058a12f8a1~hHp1a6Xqt2257322573epcas5p34;
	Mon,  1 Sep 2025 09:29:50 +0000 (GMT)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250901092949epsmtip23b4ed2198fb6b60b6d40969701766613~hHpz3yNss1644216442epsmtip2H;
	Mon,  1 Sep 2025 09:29:49 +0000 (GMT)
From: Shashank A P <shashank.ap@samsung.com>
To: jack@suse.com, linux-kernel@vger.kernel.org
Cc: shadakshar.i@samsung.com, thiagu.r@samsung.com, hy50.seo@samsung.com,
	kwangwon.min@samsung.com, alim.akhtar@samsung.com, h10.kim@samsung.com,
	kwmad.kim@samsung.com, selvarasu.g@samsung.com, Shashank A P
	<shashank.ap@samsung.com>, stable@vger.kernel.org
Subject: [PATCH] fs: quota: create dedicated workqueue for
 quota_release_work
Date: Mon,  1 Sep 2025 14:59:00 +0530
Message-ID: <20250901092905.2115-1-shashank.ap@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250901092950epcas5p35accdcb60fe3ba58772289058a12f8a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250901092950epcas5p35accdcb60fe3ba58772289058a12f8a1
References: <CGME20250901092950epcas5p35accdcb60fe3ba58772289058a12f8a1@epcas5p3.samsung.com>

There is a kernel panic due to WARN_ONCE when panic_on_warn is set.

This issue occurs when writeback is triggered due to sync call for an
opened file(ie, writeback reason is WB_REASON_SYNC). When f2fs balance
is needed at sync path, flush for quota_release_work is triggered.
By default quota_release_work is queued to "events_unbound" queue which
does not have WQ_MEM_RECLAIM flag. During f2fs balance "writeback"
workqueue tries to flush quota_release_work causing kernel panic due to
MEM_RECLAIM flag mismatch errors.

This patch creates dedicated workqueue with WQ_MEM_RECLAIM flag
for work quota_release_work.

------------[ cut here ]------------
WARNING: CPU: 4 PID: 14867 at kernel/workqueue.c:3721 check_flush_dependency+0x13c/0x148
Call trace:
 check_flush_dependency+0x13c/0x148
 __flush_work+0xd0/0x398
 flush_delayed_work+0x44/0x5c
 dquot_writeback_dquots+0x54/0x318
 f2fs_do_quota_sync+0xb8/0x1a8
 f2fs_write_checkpoint+0x3cc/0x99c
 f2fs_gc+0x190/0x750
 f2fs_balance_fs+0x110/0x168
 f2fs_write_single_data_page+0x474/0x7dc
 f2fs_write_data_pages+0x7d0/0xd0c
 do_writepages+0xe0/0x2f4
 __writeback_single_inode+0x44/0x4ac
 writeback_sb_inodes+0x30c/0x538
 wb_writeback+0xf4/0x440
 wb_workfn+0x128/0x5d4
 process_scheduled_works+0x1c4/0x45c
 worker_thread+0x32c/0x3e8
 kthread+0x11c/0x1b0
 ret_from_fork+0x10/0x20
Kernel panic - not syncing: kernel: panic_on_warn set ...

Fixes: ac6f420291b3 ("quota: flush quota_release_work upon quota writeback")
CC: stable@vger.kernel.org
Signed-off-by: Shashank A P <shashank.ap@samsung.com>
---
 fs/quota/dquot.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index df4a9b348769..d0f83a0c42df 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -162,6 +162,9 @@ static struct quota_module_name module_names[] = INIT_QUOTA_MODULE_NAMES;
 /* SLAB cache for dquot structures */
 static struct kmem_cache *dquot_cachep;
 
+/* workqueue for work quota_release_work*/
+struct workqueue_struct *quota_unbound_wq;
+
 void register_quota_format(struct quota_format_type *fmt)
 {
 	spin_lock(&dq_list_lock);
@@ -881,7 +884,7 @@ void dqput(struct dquot *dquot)
 	put_releasing_dquots(dquot);
 	atomic_dec(&dquot->dq_count);
 	spin_unlock(&dq_list_lock);
-	queue_delayed_work(system_unbound_wq, &quota_release_work, 1);
+	queue_delayed_work(quota_unbound_wq, &quota_release_work, 1);
 }
 EXPORT_SYMBOL(dqput);
 
@@ -3041,6 +3044,11 @@ static int __init dquot_init(void)
 
 	shrinker_register(dqcache_shrinker);
 
+	quota_unbound_wq = alloc_workqueue("quota_events_unbound",
+					   WQ_UNBOUND | WQ_MEM_RECLAIM, WQ_MAX_ACTIVE);
+	if (!quota_unbound_wq)
+		panic("Cannot create quota_unbound_wq\n");
+
 	return 0;
 }
 fs_initcall(dquot_init);
-- 
2.34.1


