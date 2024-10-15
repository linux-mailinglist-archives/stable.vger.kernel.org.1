Return-Path: <stable+bounces-85319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B52999E6C9
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06F25B26B51
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695F81D9674;
	Tue, 15 Oct 2024 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JpWIrh7F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2051D5AA5;
	Tue, 15 Oct 2024 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992713; cv=none; b=UgbMaZikvZessbX3uqBnsE2BFrpZB75GaN1o5dfiP+acgtxFHNH0vdVlwlmq88MfsuobObKWPpqrTcT1HK0p0fNCHl2rePeZ/Vza8mXRR0lcLuRVTBfW7XDrmR5Xr4TlTgZ65EsnvG/N0VSNFNYZMSX2iGMeYYnLpyKEVAnnUxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992713; c=relaxed/simple;
	bh=oGf14xe506rsLE0NCads2R75/dvpBN2YT6EVe8ykN1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkEQcepwiPg46LKY/5iXLXrajoP/urtu9Eo/1LByE4n1P5DUonjFNVmNVmte70LXZ9gZ9WMRvhAFvaP/emBQGjreTO8fXxh4SfIRo+0WPBHivVYHeakTLm+/lxWBoCFTNNyeFqdYWqhWTL/oy4U1idRWGaVeo0phTVyeulNyCQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JpWIrh7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD20C4CEC6;
	Tue, 15 Oct 2024 11:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728992712;
	bh=oGf14xe506rsLE0NCads2R75/dvpBN2YT6EVe8ykN1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JpWIrh7F5cJbJSaEmKR6V0BhVukDSEhkh3OZqwJzQZIEWS1POTk6JrC1g6cwlCdit
	 PGMUZyrw+Vd1W9pyYtBW4HM8kCBgG7EoFaF1H32s5FL77MU7SBTTzkEmCrLJVZexNm
	 PTnfvDB7sya2G36NI8flS4DnMCUgSFfb35Lu8Zj0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Clark <robdclark@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 179/691] drm/msm: Fix incorrect file name output in adreno_request_fw()
Date: Tue, 15 Oct 2024 13:22:07 +0200
Message-ID: <20241015112447.467549137@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksandr Mishin <amishin@t-argos.ru>

[ Upstream commit e19366911340c2313a1abbb09c54eaf9bdea4f58 ]

In adreno_request_fw() when debugging information is printed to the log
after firmware load, an incorrect filename is printed. 'newname' is used
instead of 'fwname', so prefix "qcom/" is being added to filename.
Looks like "copy-paste" mistake.

Fix this mistake by replacing 'newname' with 'fwname'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2c41ef1b6f7d ("drm/msm/adreno: deal with linux-firmware fw paths")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/602382/
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 4c61f99068083..2377a1bbbb800 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -321,7 +321,7 @@ adreno_request_fw(struct adreno_gpu *adreno_gpu, const char *fwname)
 		ret = request_firmware_direct(&fw, fwname, drm->dev);
 		if (!ret) {
 			DRM_DEV_INFO(drm->dev, "loaded %s from legacy location\n",
-				newname);
+				fwname);
 			adreno_gpu->fwloc = FW_LOCATION_LEGACY;
 			goto out;
 		} else if (adreno_gpu->fwloc != FW_LOCATION_UNKNOWN) {
-- 
2.43.0




