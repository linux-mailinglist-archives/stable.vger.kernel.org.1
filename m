Return-Path: <stable+bounces-121841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88707A59CA7
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF5437A8639
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D24230BFC;
	Mon, 10 Mar 2025 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="owLipO7B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184722FE18;
	Mon, 10 Mar 2025 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626785; cv=none; b=oD9N37d9JgXA2F/t3hMFUODVYSNxKeDnuugaLE1dFqAsxuVAEPm1YFWnFEnwSFxBrE6qjjlz22BTXNg4gZy2sIDhUlqHlKettgZ5hi+ULvmW1LNgLc05lRyvWAqOwAR5Su5n1+xTeKrXwr5sNg+pIp0mYdI1xj0NQ5Qnc+o71J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626785; c=relaxed/simple;
	bh=LIgtc/Fuc8rQiQsEqydLp92hCtmmLHpPC3bBozJkoJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZ1NPlKJ0Fa9i2MkUCVnKl2Ww+ZxrnAslmG/i16PM4Lm2PpfJTgplNCv5HsVMe70L+EooLZpsR3012MFsPtTqWMBwg6ocmZ5g8u0mNBYxikhmq/YkgMVCK/mfpjFEJ32t+USAXYsm2IiOipfKNiZZccV3f5r2KryiGSOyO1BrTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=owLipO7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7233FC4CEE5;
	Mon, 10 Mar 2025 17:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741626784;
	bh=LIgtc/Fuc8rQiQsEqydLp92hCtmmLHpPC3bBozJkoJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=owLipO7BrF/bS3LxNARsJSHZjZnStgYuMnGsJSXrtOGosGkMScxSsZugNCY+0tmq7
	 REw/ZmcrnVQwuWEZ6rdZa/9nLhsrZfdP36B6lpuvfZTcqlwiAb9K75b/vL/fMl/dId
	 oeG7vKhiExEl+0m570kXdOtgTxlN+WV6BoZVla9U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Airlie <airlied@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 104/207] drm/nouveau: select FW caching
Date: Mon, 10 Mar 2025 18:04:57 +0100
Message-ID: <20250310170451.898087689@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
References: <20250310170447.729440535@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Airlie <airlied@redhat.com>

[ Upstream commit 6b481ab0e6855fb30e2923c51f62f1662d1cda7e ]

nouveau tries to load some firmware during suspend that it loaded
earlier, but with fw caching disabled it hangs suspend, so just rely on
FW cache enabling instead of working around it in the driver.

Fixes: 176fdcbddfd2 ("drm/nouveau/gsp/r535: add support for booting GSP-RM")
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20250207012531.621369-1-airlied@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index ce840300578d8..1050a4617fc15 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -4,6 +4,7 @@ config DRM_NOUVEAU
 	depends on DRM && PCI && MMU
 	select IOMMU_API
 	select FW_LOADER
+	select FW_CACHE if PM_SLEEP
 	select DRM_CLIENT_SELECTION
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DISPLAY_HDMI_HELPER
-- 
2.39.5




