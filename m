Return-Path: <stable+bounces-136495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A98F3A99ED8
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 04:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26ED07A7E91
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 02:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9CE481DD;
	Thu, 24 Apr 2025 02:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JIChhbBM"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6184335957;
	Thu, 24 Apr 2025 02:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745462046; cv=none; b=XOGNTdnJM21/zTZ8F2yW7yW4R/h/CdgFBP7OKuHPc5C2G6Ox/LpM5qgnPCDnyvRVepLnvrZJvHzNym+12DIgii8jpTntiWJ7axvBMe+XESfEYQ3JNkuT9dxBqXyrHRogpf+k7OSGXDCKouG7KjB88YkTZrGHqZqFK7WAfMtdHMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745462046; c=relaxed/simple;
	bh=SuJTF1bzmxMi+NcU7iuruI5TglhqOE44junnmgMQryE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SaBKMz/2H6xdord2EXe3U9+swO7bWHgMnQUWHNEVV+JJ3k20Re8m44xfEX/SbmzS7Z6aTjaGAPZYRzgWRQaKu6wHGI9cbxvtroOWjNu1jxZAUfWsj4rgVe1sIFrxnPLd/VOk1FLS+eVl2hnpYqB1TVNu79XgOyKiQjqxwXHLKGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JIChhbBM; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/qHdb
	A/SsKmSVbxALImyuT2U+gPSzBFsItLJqVnqFQg=; b=JIChhbBMKSrqIerR2Oeca
	jdo9HRpJJaxmUw9/1RAwwKy5G0POQdMWz70jyU8dxsxJHdedT8R4Zryoi8lHQ+Qn
	JRLjr2QBpwWMD8RgoGRFnaT7J8pHp8P+vI5I5jB/no+OJIT2MxAQKrigCTc3w+ZC
	A0Zk8PPOvNTAHTT2F0eyMk=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBXvlQBowlogHeXCA--.20626S4;
	Thu, 24 Apr 2025 10:33:39 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	badal.nilawar@intel.com,
	himal.prasad.ghimiray@intel.com,
	matthew.brost@intel.com
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] drm/xe: Add check for alloc_ordered_workqueue()
Date: Thu, 24 Apr 2025 10:33:35 +0800
Message-Id: <20250424023335.3497842-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXvlQBowlogHeXCA--.20626S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr18tr4kAr4DArWfGryUJrb_yoWfZFc_CF
	WxXrn7XFs8CF1qvF1SkrWfZFyayryrua97uF15K3s3try7WrW2v39Fvr98ZFyxXa17uFnr
	Z3W8W3ZIvwnrWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNyxRDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbBkA05bmgJnX3o1QAAs2

Add check for the return value of alloc_ordered_workqueue()
in xe_gt_alloc() to catch potential exception.

Fixes: e2d84e5b2205 ("drm/xe: Mark GT work queue with WQ_MEM_RECLAIM")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_gt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 10a9e3c72b36..1f50f26fb657 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -81,6 +81,8 @@ struct xe_gt *xe_gt_alloc(struct xe_tile *tile)
 	gt->tile = tile;
 	gt->ordered_wq = alloc_ordered_workqueue("gt-ordered-wq",
 						 WQ_MEM_RECLAIM);
+	if (!gt->ordered_wq)
+		return ERR_PTR(-ENOMEM);
 
 	err = drmm_add_action_or_reset(&gt_to_xe(gt)->drm, gt_fini, gt);
 	if (err)
-- 
2.25.1


