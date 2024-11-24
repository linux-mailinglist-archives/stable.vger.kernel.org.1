Return-Path: <stable+bounces-94906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04BC9D742A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBB58B3D3D2
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E5B1A4F21;
	Sun, 24 Nov 2024 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nu7+cdT7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEA51A0BEE;
	Sun, 24 Nov 2024 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455202; cv=none; b=bf2T+HI0OstwdEU/n0vgOLQxiGAARoMEsVL1layTaRUW9aXaN8BW5JvhLRHu7DJmbjrqAuBG9DwwstGOSEH6tEUH4EX6j+aiqcUQ4rSQdXMei69BEdwJFpkNr357Rw2GY+9ycWI2CEWKVJoa0YJ9C+L2256Au8Ol70EiXb6l8JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455202; c=relaxed/simple;
	bh=gn5ZlkcJ4bGW2KoF/vP1dAgEOQgOyNSNHjnDrT+t3yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZkSi42/cLBonhGnrHUa4RHerepWTl5LYn40HisVsd4wXplbNdEec0RJj3dqNE/zHXJvTqKAmKK/cebtAsgTqwXom5cdjQip5QS4aLSGoYNcTCV1fod54MxO211zs5kqhaQBd2Yw/aJgLnX6rYxvQl4EmqnpSXq4V9FBVGJUBDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nu7+cdT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3168EC4CED3;
	Sun, 24 Nov 2024 13:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455201;
	bh=gn5ZlkcJ4bGW2KoF/vP1dAgEOQgOyNSNHjnDrT+t3yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nu7+cdT7h8FTOwbr4DcKsk+r3eeV9myuMKMBOe5klxFgz5ti6bcjN4M6X32PmHsbp
	 6XFPZBGtwe2YAFFHjOK3BsY3bdmqqht8/o53GUH3y19IVLfL5Ne1viur/XBImd8bgF
	 oXchI/GZlI+NvfVigEStu4Z7KS+naJLn9eMxOOgE9xKaVeWMq7q+yYXCKMR1DFCkw2
	 Qv7isAZ9gDIHXKx1esOGFjveVwFSJutN7VN/8ZSGZIzvKXpPLggCAzheDiXSARtNRL
	 i7894ZcLWHktMEGMnaSfU9LHhSqxBBr0L7+j9iUBz7DQYHZt/tV2/LBBUhcAN02pVs
	 rhDRXBMGlNPNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= <samsagax@gmail.com>,
	Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 010/107] drm: panel-orientation-quirks: Add quirk for AYA NEO 2 model
Date: Sun, 24 Nov 2024 08:28:30 -0500
Message-ID: <20241124133301.3341829-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Joaquín Ignacio Aramendía <samsagax@gmail.com>

[ Upstream commit 361ebf5ef843b0aa1704c72eb26b91cf76c3c5b7 ]

Add quirk orientation for AYA NEO 2. The name appears without spaces in
DMI strings. That made it difficult to reuse the 2021 match. Also the
display is larger in resolution.

Tested by the JELOS team that has been patching their own kernel for a
while now and confirmed by users in the AYA NEO and ChimeraOS discord
servers.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/2b35545b77a9fd8c9699b751ca282226dcecb1dd.1726492131.git.tjakobi@math.uni-bielefeld.de
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 2d84d7ea1ab7a..4864d8406db41 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -184,6 +184,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T103HAF"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* AYA NEO AYANEO 2 */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
+		},
+		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* AYA NEO 2021 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYADEVICE"),
-- 
2.43.0


