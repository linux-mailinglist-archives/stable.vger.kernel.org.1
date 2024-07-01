Return-Path: <stable+bounces-56183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CE691D554
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE8D280EBE
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D5E158D77;
	Mon,  1 Jul 2024 00:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8SjXY3L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B5A158D63;
	Mon,  1 Jul 2024 00:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792885; cv=none; b=Zcko89Dt33iWoCft2U7iQGOOtdWig+L42p0aJjRTvg9njERsUafYyziZaaza1OHSJacVBsM4Ixpzspb4zc7TtY7In2kczP5Ny+R2sb1dtYJe3J6UHESZ2rKsGxKJJxmZgAKX2PmMmoxPQPKR5fxZWQBrFPf0EKZNV0gcOkSSUkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792885; c=relaxed/simple;
	bh=M61yBx5cxGcVNquIAfQM/2mtYbrQDh++NFKojAQrq60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wk7pDwc4YXaewwSSFXDL0NeGPccxH8ZGsy+K50OqTt5pE0qCrt5ee+1tfVDeEFz/Bpyyv5UUMu0jlU0jTzOC75vFpUT4N8ly8JR6/Icfj3qBpKewrFG6rjBbw/tfvnyU47BxgPyw1W7v69p1T3rdPDmfM+6w+sA5+3yUUb6TxOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8SjXY3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63952C32786;
	Mon,  1 Jul 2024 00:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792884;
	bh=M61yBx5cxGcVNquIAfQM/2mtYbrQDh++NFKojAQrq60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B8SjXY3LzErIVf9+y6VCa5Osy1SFrJFHMVxNWqZVBXFbfFWRort4xxWwYL9CxFHOD
	 ozU5gmCqdl3xrHtT7RL77FvqOkjXYxdIVO8tDTe8/jZtFlYz7q/yX87i60kYktsvVp
	 9kXd/F6PPV+b87NdsDOK7bYpj9FpJ0y/LBwP3bWwkSYrqlyloa/lemyB+pbuQm5c1z
	 51sZn/2PyIVcaJzfVkPJ2FwVPL21KTnfv3vbKPn4RDdjfOdIe+ZS2BVYj4sk15Cggw
	 n2El+ymM2X5y0ACgyge25il71ZSNonkO9Z4d58b32V22TUFSDoNe98hef9xH18r2Z8
	 E9PA13Ox/2Ufg==
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
Subject: [PATCH AUTOSEL 5.15 3/5] drm/vmwgfx: Fix missing HYPERVISOR_GUEST dependency
Date: Sun, 30 Jun 2024 20:14:31 -0400
Message-ID: <20240701001438.2921324-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001438.2921324-1-sashal@kernel.org>
References: <20240701001438.2921324-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.161
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
index c9ce47c448e03..5b9a9fba85421 100644
--- a/drivers/gpu/drm/vmwgfx/Kconfig
+++ b/drivers/gpu/drm/vmwgfx/Kconfig
@@ -2,7 +2,7 @@
 config DRM_VMWGFX
 	tristate "DRM driver for VMware Virtual GPU"
 	depends on DRM && PCI && MMU
-	depends on X86 || ARM64
+	depends on (X86 && HYPERVISOR_GUEST) || ARM64
 	select DRM_TTM
 	select MAPPING_DIRTY_HELPERS
 	# Only needed for the transitional use of drm_crtc_init - can be removed
-- 
2.43.0


