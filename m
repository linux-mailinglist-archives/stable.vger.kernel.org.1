Return-Path: <stable+bounces-140183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845C5AAA60B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8160F3B1214
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F4831A0FD;
	Mon,  5 May 2025 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkMEL8R8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFE628DF14;
	Mon,  5 May 2025 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484288; cv=none; b=AMtZexBFE69hcOvAMoD9YXhitUuFE5iZZ8JlZ/pYzA2CWCvSUR/Z89IrQlwYPY6sTsebgAEiHBN9L79L+wfOAgcwKmqsH2qY6C953d01E8kRPRHGT1T06sX3QEXpOJJlsUGUhICEaQUi5kRa6SaBqM1RdwM5ZHWuqTZPv6tucKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484288; c=relaxed/simple;
	bh=ZBwHAHoci1CN5jPJYMM0igKKNuqHeRDs1uAY+YiLzuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AivWMMkoPxJlBZdiFRWUJ8bwBqmWWcA+ojdS/stWc6WNIAkM+Wmhed6WoJRx/E4HUtGptmYa6InTVbIZNPCWlVNBXxwzKPBlP7HiFF8tHBLzKMdHE1l9i7eAt4I4EwWPhM7sw9Qw277gpGacTBRA1M4o/fv8adyvx/UYcZUKacE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkMEL8R8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A366AC4CEED;
	Mon,  5 May 2025 22:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484288;
	bh=ZBwHAHoci1CN5jPJYMM0igKKNuqHeRDs1uAY+YiLzuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RkMEL8R8sX8ktq1tB4tHzqGgQtb6Gz+2oSYHZ7cHwFM3KzJeA4N+o+9shuuiaVZkb
	 CLlef+sm67iQgt3ByfrYAy75fQSu2P/XMkME3cn/sMcmH5Lt/glVXR7XzYM1OUSklm
	 NeUX4Sy26h4WB0vAlbmx8YgK2mij5Oi/3aAuLc812Z8uzP6pEuS7FqMjBGCaJwXmd7
	 +N86bWSS0+wW5ZX8fl4UvB0MluSeIof9v18ZvrWQorm3qOcYonhSD/n6lnTWZ2LMeF
	 LiiSfT7h5j5O3g2JwdwovM/fsKrNFVEprcI5oWbO1hk0EWKw7AflAIi9h0GkUZ1AF1
	 Wd9mG2x7tevvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Francois Dugast <francois.dugast@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 436/642] drm/xe: Stop ignoring errors from xe_ttm_stolen_mgr_init()
Date: Mon,  5 May 2025 18:10:52 -0400
Message-Id: <20250505221419.2672473-436-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Lucas De Marchi <lucas.demarchi@intel.com>

[ Upstream commit ff57025c358603555f1e0ae0d50282a460433594 ]

Make sure to differentiate normal behavior, e.g. there's no stolen, from
allocation errors or failure to initialize lower layers.

Reviewed-by: Francois Dugast <francois.dugast@intel.com>
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250213192909.996148-5-lucas.demarchi@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_device.c         |  4 +++-
 drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c | 17 +++++++++--------
 drivers/gpu/drm/xe/xe_ttm_stolen_mgr.h |  2 +-
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 4e1839b483a00..e22f29ac96631 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -722,7 +722,9 @@ int xe_device_probe(struct xe_device *xe)
 	}
 
 	/* Allocate and map stolen after potential VRAM resize */
-	xe_ttm_stolen_mgr_init(xe);
+	err = xe_ttm_stolen_mgr_init(xe);
+	if (err)
+		return err;
 
 	/*
 	 * Now that GT is initialized (TTM in particular),
diff --git a/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c b/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
index d414421f8c131..d9c9d2547aadf 100644
--- a/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
@@ -207,17 +207,16 @@ static u64 detect_stolen(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
 #endif
 }
 
-void xe_ttm_stolen_mgr_init(struct xe_device *xe)
+int xe_ttm_stolen_mgr_init(struct xe_device *xe)
 {
-	struct xe_ttm_stolen_mgr *mgr = drmm_kzalloc(&xe->drm, sizeof(*mgr), GFP_KERNEL);
 	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+	struct xe_ttm_stolen_mgr *mgr;
 	u64 stolen_size, io_size;
 	int err;
 
-	if (!mgr) {
-		drm_dbg_kms(&xe->drm, "Stolen mgr init failed\n");
-		return;
-	}
+	mgr = drmm_kzalloc(&xe->drm, sizeof(*mgr), GFP_KERNEL);
+	if (!mgr)
+		return -ENOMEM;
 
 	if (IS_SRIOV_VF(xe))
 		stolen_size = 0;
@@ -230,7 +229,7 @@ void xe_ttm_stolen_mgr_init(struct xe_device *xe)
 
 	if (!stolen_size) {
 		drm_dbg_kms(&xe->drm, "No stolen memory support\n");
-		return;
+		return 0;
 	}
 
 	/*
@@ -246,7 +245,7 @@ void xe_ttm_stolen_mgr_init(struct xe_device *xe)
 				     io_size, PAGE_SIZE);
 	if (err) {
 		drm_dbg_kms(&xe->drm, "Stolen mgr init failed: %i\n", err);
-		return;
+		return err;
 	}
 
 	drm_dbg_kms(&xe->drm, "Initialized stolen memory support with %llu bytes\n",
@@ -254,6 +253,8 @@ void xe_ttm_stolen_mgr_init(struct xe_device *xe)
 
 	if (io_size)
 		mgr->mapping = devm_ioremap_wc(&pdev->dev, mgr->io_base, io_size);
+
+	return 0;
 }
 
 u64 xe_ttm_stolen_io_offset(struct xe_bo *bo, u32 offset)
diff --git a/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.h b/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.h
index 1777245ff8101..8e877d1e839bd 100644
--- a/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.h
+++ b/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.h
@@ -12,7 +12,7 @@ struct ttm_resource;
 struct xe_bo;
 struct xe_device;
 
-void xe_ttm_stolen_mgr_init(struct xe_device *xe);
+int xe_ttm_stolen_mgr_init(struct xe_device *xe);
 int xe_ttm_stolen_io_mem_reserve(struct xe_device *xe, struct ttm_resource *mem);
 bool xe_ttm_stolen_cpu_access_needs_ggtt(struct xe_device *xe);
 u64 xe_ttm_stolen_io_offset(struct xe_bo *bo, u32 offset);
-- 
2.39.5


