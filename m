Return-Path: <stable+bounces-98655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C910C9E498B
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8999F281793
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FCD218EB7;
	Wed,  4 Dec 2024 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXZF3AL0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FBE218EAE;
	Wed,  4 Dec 2024 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355036; cv=none; b=SWLdLr2u1/fZXCBztPzjbS0xJmdsuPau5CS1T4GT5K5MQShomBu8Zs1Oz1C3eOTT8bJ4LUEfpKFFMzVIKs8g/4ehmHzuPx5xJK8LTRdu3gv4lP/cFnMIOrO2QkGztvPewYIV7dDHy5h7rX9s0CWU0vHB/0Eqf2VnEuMV4HRyFU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355036; c=relaxed/simple;
	bh=iOzsphW00Lfj5DBJiTRvU5jwovvXRQIQwiLwndUtijc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cAz9s8dYdSyphGAY8rQ0IMeCT3c6pvtheksdk97F9i7EkpVoTTuA8ob//rJcsfJCcB3ObRg35Co5LZSSKzf/vdi+mdEvT4VJ4tq+spAIR3mGbV/knaz4P5e53xEDf0nEvH5x3aSZZsyvceR9ty3ixKKMFG6ojP4JUW6+dworVcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXZF3AL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF080C4CECD;
	Wed,  4 Dec 2024 23:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355036;
	bh=iOzsphW00Lfj5DBJiTRvU5jwovvXRQIQwiLwndUtijc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NXZF3AL0lt1fekNuYSwKpFM5VGMaaTWVHTyx2p9MB9P9mIhoKmaRHf8LqKSCteHiT
	 Ww3xWDcUQAnBqV1uFQlzLU5sqdwD8RJXa16592kGSLRP7QFzHSN3Rl3ov23A60fHLC
	 o5Nq0FENV11j0yuvZNGPmb4/nUIB6cC5te9ULBkvEFA/OtTSGIx/3NjeKDXihr1DLw
	 gABYuW+nwQwKVyyNNycI8NRBD0E6Y2taN1UrfUKbLNxOgtSG34DVgCOUAUNDS12QIm
	 CHXLeWoooLb/JhaSjAISXNUvVY9OVy0+Ih9AwB8gpYTqJUrwcShMusLpHKCm8tS7H2
	 yYATQh+/zJbGw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
	Tova <blueaddagio@laposte.net>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	end.to.start@mail.ru,
	me@jwang.link,
	venkataprasad.potturu@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 7/8] ASoC: amd: yc: Add quirk for microphone on Lenovo Thinkpad T14s Gen 6 21M1CTO1WW
Date: Wed,  4 Dec 2024 17:18:49 -0500
Message-ID: <20241204221859.2248634-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221859.2248634-1-sashal@kernel.org>
References: <20241204221859.2248634-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <ukleinek@debian.org>

[ Upstream commit cbc86dd0a4fe9f8c41075328c2e740b68419d639 ]

Add a quirk for Tova's Lenovo Thinkpad T14s with product name 21M1.

Suggested-by: Tova <blueaddagio@laposte.net>
Link: https://bugs.debian.org/1087673
Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
Link: https://patch.msgid.link/20241122075606.213132-2-ukleinek@debian.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index c18549759eab1..4272d6812512e 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -220,6 +220,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21J6"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21M1"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


