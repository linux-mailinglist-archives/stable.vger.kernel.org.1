Return-Path: <stable+bounces-77493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE36985DC6
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D81C1C251CE
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA422048F0;
	Wed, 25 Sep 2024 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmlI72A/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2D02048E8;
	Wed, 25 Sep 2024 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266008; cv=none; b=c4VBCeiQonXxooBr9lvWyOYY/SEKwfF7KXvI6cZAHAVm7dOEH9e6O+iMVd3yj2eLIk+6IIuz2U6gMpYDBXAr/duWh3Y53iYFP4vv+2JHKp2JU2MLka8GarD4P98e+WV88Cku2zF1ygLjPsautmsKbvS29b40AU7PcFX/BuH9/w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266008; c=relaxed/simple;
	bh=BxcwbgJ/CnH0K4cDKwkcguF41kZNgM81f4D/TFs+Ny4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIKqBp2NpxWaXKrDhO0k9YyyQwOq4l/RmV0PAaXE7y4kIbqPhPM5CAATTzN/3AldZjVenGSmGH3ncIN1jIdM+Ty+Us7Iz0MFdtbsQAlLa+6ayy48M3P92GI3NhKbYiB8PdbRfcES7WoVFWH/irlVMoAfLwnWVvZxD6s4CwyA+QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmlI72A/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36B7C4CEC7;
	Wed, 25 Sep 2024 12:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266008;
	bh=BxcwbgJ/CnH0K4cDKwkcguF41kZNgM81f4D/TFs+Ny4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmlI72A/aHkiHH34lh9MwfJO8CoNy1jwnpDPzMi16x5QidxQqSpgkM8o9UqxwTQkL
	 yp0FVyia6YfCcNfJpS50NOLuqKnQCoLDhvjBtgrBHjsIRhs+InwfztOKubuOM1dgmv
	 OIzWIZOXj5fG878UkPddGtFg0eqY8SVZxtTFVALrlSvcSFw8XapyYzO3JWmGkdTH1a
	 yCPsHDNZ6xxRmfr0J9RXSrFAU29LlbaESre8HXXZ9G3nICGRw8M0hh2znEl88ALmbQ
	 PyKGTD4Msm3X3TfwSxUrqXeJpc7NgI22mNEArHhQa2btK73LId2AyySOGkm752hR2f
	 LSKDiIQ7KUTww==
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
Subject: [PATCH AUTOSEL 6.10 148/197] drm/stm: ltdc: reset plane transparency after plane disable
Date: Wed, 25 Sep 2024 07:52:47 -0400
Message-ID: <20240925115823.1303019-148-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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


