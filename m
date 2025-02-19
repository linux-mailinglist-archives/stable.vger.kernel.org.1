Return-Path: <stable+bounces-118235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18796A3BB19
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 11:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749053A7F90
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E661CDA14;
	Wed, 19 Feb 2025 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nwCfw+Vx"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD221C4609;
	Wed, 19 Feb 2025 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739959079; cv=none; b=c1CAlgWPexEcErLNDp0i/FMQqtgCWfmth49MjOXzNNrL+fbj+1/QvtKbUsGCe+jrOrR7SR2upR9wY6hILO4Jz3uV3ZHf9pWIWTuvjibyh5lIyDTcH4UxoVtVPgQjZkrURsUVVt6f+cHbmTDAm2w6x99mrW6CmjFhNP5PYc2hDZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739959079; c=relaxed/simple;
	bh=SZa961bThvHd51Sn594n645+PCjPk12+PueSnQDteLU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GImkXFV9uEKi1wZCur3n9WDlmolhbgZypQ8tkXRypEKQpWvpSjWJMlX5sDjyqzkWRFbKVy6cwqM+PAdPUQwp4/vb4l48q+TYkvY9yx5V19DddvpK4WKsKw9jnv1HvRau3Dovq7GCN4so5+7N8+CvtWpGU+bPmj/s4HNbN+FTyg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nwCfw+Vx; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1E+JK
	CDyr0UDbEZ31/NEb2aNDhIFieLLmKQm1VWaC8Q=; b=nwCfw+VxxrTeK8m1zQ89P
	sj++7+64qQ9wuvV/EeDbDvwIyjZtyi+DnSYZyrk7V6yCnxz2RFZwrQRAnJcxQX1q
	fiFret0K67ZrizItIhK6w6JZLcjzvN91FVynSHcSULP67AZKBlESFLL6cArdtsJD
	ZUcpzoVh01L6cCJ5lru8PI=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3D0HtqrVn0BWbNQ--.28485S4;
	Wed, 19 Feb 2025 17:57:03 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	himal.prasad.ghimiray@intel.com,
	badal.nilawar@intel.com,
	matthew.brost@intel.com
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Add check for alloc_ordered_workqueue()
Date: Wed, 19 Feb 2025 17:56:59 +0800
Message-Id: <20250219095659.2613487-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3D0HtqrVn0BWbNQ--.28485S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr18tr4kAr4DArWrtF1rXrb_yoWfGFb_CF
	WxXrn7XFs8CF1vgF1IyrZ3ZFy2yr98uayfW3W5K3sxtry2qrW2v3sFvr98Zr1xXa17WFnr
	Z3W8W3ZIqwnrWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRuBTYDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbB0hT4bme1p+I8RwAAs8

Add check for the return value of alloc_ordered_workqueue()
in xe_gt_alloc() to catch potential exception.

Fixes: e2d84e5b2205 ("drm/xe: Mark GT work queue with WQ_MEM_RECLAIM")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/gpu/drm/xe/xe_gt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 5d6fb79957b6..0f42bbcb8d42 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -79,6 +79,8 @@ struct xe_gt *xe_gt_alloc(struct xe_tile *tile)
 	gt->tile = tile;
 	gt->ordered_wq = alloc_ordered_workqueue("gt-ordered-wq",
 						 WQ_MEM_RECLAIM);
+	if (!gt->ordered_wq)
+		return ERR_PTR(-ENOMEM);
 
 	err = drmm_add_action_or_reset(&gt_to_xe(gt)->drm, gt_fini, gt);
 	if (err)
-- 
2.25.1


