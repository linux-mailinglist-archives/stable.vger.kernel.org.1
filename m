Return-Path: <stable+bounces-58882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC2892C11A
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D981F2256C
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF6C19A85B;
	Tue,  9 Jul 2024 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnPZziLB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A01719A854;
	Tue,  9 Jul 2024 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542381; cv=none; b=h1p323bpHU45FEiHLjdpJO5q6qDcCOThsHOdoOy1+r/J2Mg1JsTMj3uh63Xcym+8G7qCjvtfKNyGqKje80E+ozcky28x9b46D1tw8YNKLYAzVnF6iU0kTLGYSYaldyoaFTzu/cro/qTeTQZBfLBBpuKm8b8Dn6dqD2GiWTrMd20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542381; c=relaxed/simple;
	bh=WO7VhII6dUc8eCAjBAK55s5oiuUwMqkB28oGuPSdRD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqKN/f+lLwBVa0DmpmWF3v3fi2YNfvt9ASWThTzL059vSQKrTt556aR7bqT6D51g5TOHAbdSGfiIj/G4tdLFF6uhxKWuWJzuenNBPf1+3uyhYn61LOJLBTYWP1FRrfFNIOIN5qzBZe+wiy8E0V3uMhuVs4q64eil3GCED2RRueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnPZziLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CE9C32782;
	Tue,  9 Jul 2024 16:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542380;
	bh=WO7VhII6dUc8eCAjBAK55s5oiuUwMqkB28oGuPSdRD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZnPZziLBvQZtluoo0ed01ppw6Uf3tE5CGvZgN3/Orcw007ooc76NVbVPR0NuY8E+6
	 yuv6bjKlNY3iAw9Yhoq0qyhAW61Buzr6I6eyyuPw/VH7VRyH8NRvr8y/y5rKMevKzb
	 t9a/O+zjHgV/e800aKXr876NGy7ofrqwzBNWOaIIrg3aFVAFkaDoJaYQx7agYwBkMc
	 MXPqno8IJLn2XGDpotX8nmYns9gD/Tt9Bih2K/thccK5nhHfZxJ+XuYJbI8ng+a8jy
	 YUkwhI1h86fGYGuRZ5oK6x0MfYtsbgqJsAbEqTTJOeu6Y/YWj3eWhfx/+JDOx4Cozu
	 W74zR7BQC7RNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas GENTY <tomlohave@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	alban.boye@protonmail.com,
	kuninori.morimoto.gx@renesas.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 03/14] bytcr_rt5640 : inverse jack detect for Archos 101 cesium
Date: Tue,  9 Jul 2024 12:25:47 -0400
Message-ID: <20240709162612.32988-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162612.32988-1-sashal@kernel.org>
References: <20240709162612.32988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.221
Content-Transfer-Encoding: 8bit

From: Thomas GENTY <tomlohave@gmail.com>

[ Upstream commit e3209a1827646daaab744aa6a5767b1f57fb5385 ]

When headphones are plugged in, they appear absent; when they are removed,
they appear present.
Add a specific entry in bytcr_rt5640 for this device

Signed-off-by: Thomas GENTY <tomlohave@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20240608170251.99936-1-tomlohave@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 1d049685e7075..47b581d99da67 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -468,6 +468,17 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ARCHOS"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ARCHOS 101 CESIUM"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_JD_NOT_INV |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ARCHOS"),
-- 
2.43.0


