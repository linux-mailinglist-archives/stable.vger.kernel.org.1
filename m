Return-Path: <stable+bounces-56152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BD291D4F7
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81BB01C202E2
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0232AF07;
	Mon,  1 Jul 2024 00:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pI8kC9OX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ECE2AE8E;
	Mon,  1 Jul 2024 00:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792752; cv=none; b=L9V20Qs5ksSEraEMiqQIoXpT1QDZCEsGCulo147RfZHVYFxCWBtL9Ed6Ai0ur8g17aRNEYqwKXz2yhuL/YwAvuye1nBncYa+s9WhpncXJpBWTJOwTN9HDB5pM5Ova6Z4yHu/dlqYppVMzU2z1sltg8XFehWCAfhuZNlZoJzKDMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792752; c=relaxed/simple;
	bh=hw7u6xYg/+CQm01IClMuBvMqpvZ+em+NVWONFAx+A5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aN4YDjn7hagGiMYD3Ek4+f8b2DAJ8JPPmwTfE6TTtRdTRFY94OkXU2T4q9tR13rFb2TQtgRvNnVlqD+r6DYcYSq0N/xoJ7Ggl62SQql4+d9+HTO8kRyLyw31DNc2POn5Hk9aNziNcNNQUY/iJbUA2HHlHnyuTVg/UfQxwc+atNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pI8kC9OX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9283C2BD10;
	Mon,  1 Jul 2024 00:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792752;
	bh=hw7u6xYg/+CQm01IClMuBvMqpvZ+em+NVWONFAx+A5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pI8kC9OXzWwE9tmIOFuYI0YMcFa8k0hlRQo5fUK2mgkhgRHqV+ZqD8Yf9g+bPFJxv
	 Fv8mK6lk1NqUQRMtvgd0vP6r6fHmxan0j0AgbbxL/aKq/Bb4xBLQqNWWmDHLmwFZzh
	 LJGfYLlB+A3Lzju+fEiQvgddWnP8U44drvJtZ0Dk/zrD4Psf1AKSpUbufbguL+7Gjf
	 IOWzlyEYxgOPtzl2PIWH0lk1p3Sn3BVu2hEggZttwqKdcHM2E+sxOP9P/wkkExNRrl
	 YTr0826XCJUElKa+kuzkLKnn98VgbOlMnf7jREZ4WKL/kMnOWO6ChIJWmObKLsolHV
	 EqSA0HUewtg0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexey Makhalov <alexey.makhalov@broadcom.com>,
	kernel test robot <lkp@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	zack.rusin@broadcom.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.9 09/20] drm/vmwgfx: Fix missing HYPERVISOR_GUEST dependency
Date: Sun, 30 Jun 2024 20:11:14 -0400
Message-ID: <20240701001209.2920293-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001209.2920293-1-sashal@kernel.org>
References: <20240701001209.2920293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.7
Content-Transfer-Encoding: 8bit

From: Alexey Makhalov <alexey.makhalov@broadcom.com>

[ Upstream commit 8c4d6945fe5bd04ff847c3c788abd34ca354ecee ]

VMWARE_HYPERCALL alternative will not work as intended without VMware guest code
initialization.

  [ bp: note that this doesn't reproduce with newer gccs so it must be
    something gcc-9-specific. ]

Closes: https://lore.kernel.org/oe-kbuild-all/202406152104.FxakP1MB-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240616012511.198243-1-alexey.makhalov@broadcom.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/Kconfig b/drivers/gpu/drm/vmwgfx/Kconfig
index faddae3d6ac2e..6f1ac940cbae7 100644
--- a/drivers/gpu/drm/vmwgfx/Kconfig
+++ b/drivers/gpu/drm/vmwgfx/Kconfig
@@ -2,7 +2,7 @@
 config DRM_VMWGFX
 	tristate "DRM driver for VMware Virtual GPU"
 	depends on DRM && PCI && MMU
-	depends on X86 || ARM64
+	depends on (X86 && HYPERVISOR_GUEST) || ARM64
 	select DRM_TTM
 	select DRM_TTM_HELPER
 	select MAPPING_DIRTY_HELPERS
-- 
2.43.0


