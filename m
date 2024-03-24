Return-Path: <stable+bounces-32020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CC2889ECA
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 13:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 577B0B363D1
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 11:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAD7292B7D;
	Mon, 25 Mar 2024 03:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXs0iXqF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9199C17F36C;
	Sun, 24 Mar 2024 23:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324016; cv=none; b=gqpGCUHbXnywUi1s/r9grHl4JhfInwWo5yF88WJdnOeGJW9BzCCKHGOXpAYvAbKa7wotZjvDirpJeJPi9uMRuUUOo4LX4e4sAB4bOqUOQ9zv5mxawtWrcZX6GVnhq9JHT0y3Cg8yJBNqkfeWy5XyxFO5qtzdfStEtUjxZoc/npY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324016; c=relaxed/simple;
	bh=sL2RKPUz7dDRVOIkRhMDv4+bFxzDPiGYLyueB87xlFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRY79Q44h8IpSO90Ekeuk+SxziVHyNcYdAGkdmLs0KNGwFicduVmS2VJDgr+gvB5LjcEswEooxyV8iIoLfhJphCdqCce8q7PuwHva1gLfLlFJun8mRKNY98to/SA+WWxeFsBa7/lWgZrd0IpaeF23KLhUN/j/qHUGoR9z0Il8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXs0iXqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C969C43390;
	Sun, 24 Mar 2024 23:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324016;
	bh=sL2RKPUz7dDRVOIkRhMDv4+bFxzDPiGYLyueB87xlFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DXs0iXqFi8tP5+oRDAp2qNZ3ASqmtg3bMaXAmiztaKTKwEqErtvmTVLJU0DC75ZAF
	 LHZoa/LbLoa2HQxQ+aH++o6wVkZlE3u1qaPiyDDJ4gPEJt+3IB3dA+02Q3LkbCaI3r
	 eNEru+ig9Bb9U4kyKpa8v2+0lDKRAb2up0aOpESbnaVNOhnpPSQ2WMYGUoFWwAVtti
	 z1DZ8pIgeCB8rvb2rZ4m/65byflcyYhTVFXlroFoptqagpRTBWig3KnWYZ5+dcY18C
	 LeM2zdBTwhTUpS5EOT2XdsbBBYoq5kuu50aW1Kn5SbLNt9gYYwkz4kBXOTRGrfOCl7
	 PniqRJMZWNOhg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alban=20Boy=C3=A9?= <alban.boye@protonmail.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 017/183] ASoC: Intel: bytcr_rt5640: Add an extra entry for the Chuwi Vi8 tablet
Date: Sun, 24 Mar 2024 19:43:50 -0400
Message-ID: <20240324234638.1355609-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Alban Boyé <alban.boye@protonmail.com>

[ Upstream commit f8b0127aca8c60826e7354e504a12d4a46b1c3bb ]

The bios version can differ depending if it is a dual-boot variant of the tablet.
Therefore another DMI match is required.

Signed-off-by: Alban Boyé <alban.boye@protonmail.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://msgid.link/r/20240228192807.15130-1-alban.boye@protonmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index df3b370fe7292..c740dec00f83b 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -526,6 +526,18 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{	/* Chuwi Vi8 dual-boot (CWI506) */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "i86"),
+			/* The above are too generic, also match BIOS info */
+			DMI_MATCH(DMI_BIOS_VERSION, "CHUWI2.D86JHBNR02"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{
 		/* Chuwi Vi10 (CWI505) */
 		.matches = {
-- 
2.43.0


