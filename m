Return-Path: <stable+bounces-77653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98864985F8B
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B470287BC2
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DD7226646;
	Wed, 25 Sep 2024 12:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEvhVrjy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20618226640;
	Wed, 25 Sep 2024 12:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266589; cv=none; b=JEx5DpfNfdcTyxUo8TlhOEN46YK2ugaO8Uv1+H5xLj6KyuUxq5I9pdXTDQpyIAE4mPXFGklq1ewbfEbdp5cIPVyQ7GRUFHQPOQbAqrauUaxQPGKPCJpzdciiCLBC0Jp82MTnCuHcwvL5h1V3U0DLKSpBeQbHv7GIXyEbib8DO2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266589; c=relaxed/simple;
	bh=BxcwbgJ/CnH0K4cDKwkcguF41kZNgM81f4D/TFs+Ny4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYUgpXxgJL99SShT2nUMFmCrZf8sRAnmPCdsXvOPYTxHa8O1fqbc9ydl8zVJJPUx1yNSMuPR6rY234klKSDY8jaJOklzsadQex4nQxtHaYuIGA5qvjSWqj0Q//ccunMzb3Wtk31WQMAdcpzno5yOYiPPQ5VPaOuhjyoC4GMfTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEvhVrjy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E6FC4CEC3;
	Wed, 25 Sep 2024 12:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266589;
	bh=BxcwbgJ/CnH0K4cDKwkcguF41kZNgM81f4D/TFs+Ny4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JEvhVrjyUgbZCsuh4VdZwUUKjICcXk+psJ2slWjr2b8+Akgeq/M9zGtZv7tSM/Unk
	 xfG5yNB/e5BK2I4niFz2ESv9gPApkh8nDYG+0z3qRL/RDnrL4g1AA/V34D0YKHxREy
	 1fOdbDRjLXivScqtbgM02UJKD4sG4EO3zs0W6wwuDLDgv3aFBqyCL5bA2Po5pjppZs
	 x2rsRg+9Hv9NQ0amLU1l8JBl8zosQ3cXNYOcRsYAScdkCTIMefwLtJQXVYoR4J2omt
	 ladOl0e9VBH0oTO0xe3sEpxRHLp9b8eUOr5uXF0dRObvt8+51FO4Yj0hxnLcidPSZF
	 PmlovhndbhCxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Sasha Levin <sashal@kernel.org>,
	philippe.cornu@foss.st.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	dri-devel@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 106/139] drm/stm: ltdc: reset plane transparency after plane disable
Date: Wed, 25 Sep 2024 08:08:46 -0400
Message-ID: <20240925121137.1307574-106-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Yannick Fertre <yannick.fertre@foss.st.com>

[ Upstream commit 02fa62d41c8abff945bae5bfc3ddcf4721496aca ]

The plane's opacity should be reseted while the plane
is disabled. It prevents from seeing a possible global
or layer background color set earlier.

Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240712131344.98113-1-yannick.fertre@foss.st.com
Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/stm/ltdc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index eeaabb4e10d3e..9e76785cb2691 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -1513,6 +1513,9 @@ static void ltdc_plane_atomic_disable(struct drm_plane *plane,
 	/* Disable layer */
 	regmap_write_bits(ldev->regmap, LTDC_L1CR + lofs, LXCR_LEN | LXCR_CLUTEN |  LXCR_HMEN, 0);
 
+	/* Reset the layer transparency to hide any related background color */
+	regmap_write_bits(ldev->regmap, LTDC_L1CACR + lofs, LXCACR_CONSTA, 0x00);
+
 	/* Commit shadow registers = update plane at next vblank */
 	if (ldev->caps.plane_reg_shadow)
 		regmap_write_bits(ldev->regmap, LTDC_L1RCR + lofs,
-- 
2.43.0


