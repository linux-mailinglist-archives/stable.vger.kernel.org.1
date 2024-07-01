Return-Path: <stable+bounces-56178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4033991D546
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3132814B9
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DE815667C;
	Mon,  1 Jul 2024 00:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCd/eD5d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444E6156641;
	Mon,  1 Jul 2024 00:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792866; cv=none; b=hsgVsMP4HXIGZYgyLwSpPgzHJduxbVzR2GHZMygTHwG1LnL6waCDdAvzoxRux3v69YsXDRJqlVUimGU2aC8cNjR32oQx/P1aXYz9FZ/nxSoT2TGQWwq8eCn1z026Wx2UD/y64uMVMfa6sx2pClA+wucX41EZVHjKjPs/adrH+xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792866; c=relaxed/simple;
	bh=hw7u6xYg/+CQm01IClMuBvMqpvZ+em+NVWONFAx+A5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuHn7ZoGSxtKUaAa9Mssr/8XxDdO/MqOzc61Uii4+d7FWXSBQjrdGjY71o3VtmhdyXEeCuCU0KItcX7BTu+0LUgV5yKT8sILoSTREaBZiLZipCFZ1bxTRVj85gyLQFznXQ9OVA2qUiYmYbZ3pRox14NqsoiL+fHDInk1Ljlm2zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCd/eD5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96D5C2BD10;
	Mon,  1 Jul 2024 00:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792866;
	bh=hw7u6xYg/+CQm01IClMuBvMqpvZ+em+NVWONFAx+A5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JCd/eD5dj8adV1mZZ7QyfkalSbU8+qxUCxaE1Vdbkkmto33MDCyb9baUtmOL5QUPZ
	 ZovRiDRvhb4u/bD3ghDYIkUMkNvBwczHL2C14yp0w5y1I7x6YoknlYes/4bpSXZ9Os
	 epwjiWBaVdSHfCRcZABD5jS2fukMmvsFbiV63kJ2wvdxrU8/DDYTa4ifoTMCftI1W0
	 bj7CskbGxerifrb1AwqI+IbC/I4t1ft+3Ni+p66vsPITM5kTJ0ziKhF0mldI1xeUls
	 rp4c5I9uQy2LXtCrh/aVgmHr0GDjFbhheQSqdUi19aGfaPJIAwAgXaFRqgbYEU4bp4
	 y6j00Gel7rwww==
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
Subject: [PATCH AUTOSEL 6.1 3/5] drm/vmwgfx: Fix missing HYPERVISOR_GUEST dependency
Date: Sun, 30 Jun 2024 20:14:13 -0400
Message-ID: <20240701001420.2921203-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001420.2921203-1-sashal@kernel.org>
References: <20240701001420.2921203-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.96
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


