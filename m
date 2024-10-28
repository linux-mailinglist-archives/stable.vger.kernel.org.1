Return-Path: <stable+bounces-88986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6DB9B2D5C
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD41B22688
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61F31D88CA;
	Mon, 28 Oct 2024 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rt6jeDDe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AAE1D54FD;
	Mon, 28 Oct 2024 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112667; cv=none; b=tBKT5WF4tMFZRpfAHS1WLnuqk/Mdxxq0bfVBK8O426zV6N7N1G9yX6V6/BliKlZo2KkCelSzMt5Hq/YkoJbkkOJoKai5pDMWaW8/t/7WZhXK7ko13amgQc0fH1Q2KHoxfqa8remEGxoFvgU9nT/YhwtvKpYjiM4dSo+7MTEtTl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112667; c=relaxed/simple;
	bh=P+bRZ/KufpLKVv018UPYT8JM97TckEQkBQcRlfgvf08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDbtM1QJXY9wxP5hW1FKOZqX9Gdp0ze22BkeW4lU58ZeN84ot+V1tUBR2NxB6Azg+Xj8jfxZ1/XqmxM7TPTQWPgNEC4FmqsePDS17EmQM0A03557DhA1KE8TIORcz71yLngw2RgDZlve+yVp8MYHKeqc2GFLAFZeNACbK9E3xGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rt6jeDDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F1AC4CEE7;
	Mon, 28 Oct 2024 10:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112667;
	bh=P+bRZ/KufpLKVv018UPYT8JM97TckEQkBQcRlfgvf08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rt6jeDDeyndAKCF6T8vAwFJOriTPzsIC1s7XH8B5xcRxGel8tIyTwB6RmAGYC7klt
	 h3e3hbRnC438n4mv4vQxcT7atTTpIBHfOWWnMjRxA1Gxt3ad3/xOAcXDKbu+D9lXcL
	 6W+QiNcnnx618O68Oy7+H51Z4Lofn+egAteGuEVYZUdqu1JsFb/OzLBSG2HFL8p2zO
	 vndEKOiWsOnEOiQpvRvDUU9A/U4kObtlDWPsrwiz9ynU2R1QPFbr2vv9HWlKBzDsMl
	 ofPQSKO5yahPDODeySfRnkhKfyoKcikPyIzoYg8jwP5C0zgDaNiF/EEKpVgck6kjUQ
	 1VWAG+fI1glqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christian Heusel <christian@heusel.eu>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	me@jwang.link,
	end.to.start@mail.ru,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 04/32] ASoC: amd: yc: Add quirk for ASUS Vivobook S15 M3502RA
Date: Mon, 28 Oct 2024 06:49:46 -0400
Message-ID: <20241028105050.3559169-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105050.3559169-1-sashal@kernel.org>
References: <20241028105050.3559169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Christian Heusel <christian@heusel.eu>

[ Upstream commit 182fff3a2aafe4e7f3717a0be9df2fe2ed1a77de ]

As reported the builtin microphone doesn't work on the ASUS Vivobook
model S15 OLED M3502RA. Therefore add a quirk for it to make it work.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219345
Signed-off-by: Christian Heusel <christian@heusel.eu>
Link: https://patch.msgid.link/20241010-bugzilla-219345-asus-vivobook-v1-1-3bb24834e2c3@heusel.eu
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 06349bf0b6587..e353542dcf636 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -339,6 +339,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M7600RE"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M3502RA"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


