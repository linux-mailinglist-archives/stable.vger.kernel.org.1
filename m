Return-Path: <stable+bounces-92515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C099C5777
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 13:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC4CB3AF00
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1272121F4B0;
	Tue, 12 Nov 2024 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEmfR70P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C129E21F4A8;
	Tue, 12 Nov 2024 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407825; cv=none; b=CjJb1TH1MxK5dBGNf19BanBZH89nc64IE5naYeryc4lr/QQ5//pSfEOaXrXUWd4RfnJbesyPx3NCu0tAlhZ29ponlb+sKnI1mx8OZO7jKKzVRxUtC6CKthmDwOmAcZRQLmv16lMB72pp3Dn/R1ngEVzPAqCu3EfKCXUQfgep7V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407825; c=relaxed/simple;
	bh=gAEZS/3PgnLxe2AEnAzYsgWFUX6ph7baMJLD1F4z5E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdvR0sMoCDuPoxeZkqgdfLseDMV+2pbKKYRj39ByiU8XKCxhxbsOe8eoEzwjV+8/uadjQ/UzoPVe6D0HyWkTDNT1JE1att6MNioDLEDD9ziUT5OYS9QqST27QkGphkUFTDGuQaL8YkxewAFtvb4oNbjsRfVtZaEm0ZpnVK/cp1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEmfR70P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FEAC4CECD;
	Tue, 12 Nov 2024 10:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407825;
	bh=gAEZS/3PgnLxe2AEnAzYsgWFUX6ph7baMJLD1F4z5E0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tEmfR70P9yvPGaHIdbs6tQRmlPMXx1gArFDlVHUknPZWqr+oltqckfePoLeGa1K99
	 tzeM9qoV2tyfoKyRMFByvqXOHXbHF4BvLSn1wAyR7bN4+5pdxEfZ1lDcbMZq+h0+b8
	 SZJQfCGU3+nBv/Zsab/3HJHQuWA8PwRGPmyVHzXYADDK4apGIeHQYJUr3IF7YvD/Pr
	 By3v2ksS9KaleSHoTnW56vK3YakDGykgl3u10KJ+E0Yl5sf4AuZj1cbnsOBEVeyKq8
	 Ma4TF3UQvTokDjUqfp9uqqUHZmLtysmbSpttN9DmnySKv2WRp6DmtXL1nf5DJHye/A
	 p1BIF/ez1lLqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markus Petri <mp@mpetri.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	end.to.start@mail.ru,
	me@jwang.link,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 11/15] ASoC: amd: yc: Support dmic on another model of Lenovo Thinkpad E14 Gen 6
Date: Tue, 12 Nov 2024 05:36:32 -0500
Message-ID: <20241112103643.1653381-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103643.1653381-1-sashal@kernel.org>
References: <20241112103643.1653381-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.60
Content-Transfer-Encoding: 8bit

From: Markus Petri <mp@mpetri.org>

[ Upstream commit 8c21e40e1e481f7fef6e570089e317068b972c45 ]

Another model of Thinkpad E14 Gen 6 (21M4)
needs a quirk entry for the dmic to be detected.

Signed-off-by: Markus Petri <mp@mpetri.org>
Link: https://patch.msgid.link/20241107094020.1050935-1-mp@localhost
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index e027bc1d35f4f..f5ca5bdb364c7 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -227,6 +227,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21M3"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21M4"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


