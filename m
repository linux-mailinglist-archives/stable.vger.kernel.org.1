Return-Path: <stable+bounces-83516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D26499B369
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2021C21034
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467B716C444;
	Sat, 12 Oct 2024 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlgRSAfk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C0515CD52;
	Sat, 12 Oct 2024 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732386; cv=none; b=TQ7h5jjPb8yrq6ruZLl/3rPI/vgBXsJpq9asc2sIV8Kzqo+XQ2VoJhvp+4coiaFZeGIN3eGkg3a1fZvIUMgslKkAIiVCvS63rM6IzCmlhzAA4QyuC06X3Zk4YidwcWDyjS0B0tUFBBlziXgh3E5EtTeuqxW9NS/hhXeDMJvc1RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732386; c=relaxed/simple;
	bh=/UhmavUvI2ZNZ2UWyBos8WUr2di3xdupe4CqtO17SeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FB8q8T2YUdX7Dv+/dqo4b/nCwFPnVrYOfp+PF0PRR9GsgsMRsN7A738KJ8AfCmI3z4dVS25bCXpY2D1HKbo81ZeHWCVf6hEnv3hi42okLdaPWWWwCtg+3/bxyyHASu/7k2m51k3RsDAiSTxluCP3A0gOG9CNwk/YEVOVnE1vloU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlgRSAfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE0EC4CEC6;
	Sat, 12 Oct 2024 11:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732385;
	bh=/UhmavUvI2ZNZ2UWyBos8WUr2di3xdupe4CqtO17SeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QlgRSAfkfV4qTYcqx9qug8vthHZJ4O30rmJD9JzsZfHWuRzh8w9ZpnfuwYFgredK1
	 vntMtLahb+0dWiMJON4CHG03zhZo0FndfN4YNjsoE++L8LmN86Y5shv9AdpVW8ASCf
	 qQr0YVcDmQ9UlQIMhEYjRZDcC4TQ2WABYOgOi0y5LJMcPLa6ethRdIubK7dWDPft5T
	 Rr/3W1I68h2tIemur18nYxUIUThNHDK+Dqbcas0zv1wdY3LV9LSMFAyrdIXG8wgFb2
	 qEFDbCCHASUNdx+YMpgn1Sq7Ok6tTzHLAg1y3yu455cgmWRHjefVmNZAiw2UAilA7L
	 mCqbxm+TaMw7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Lawrence Glanzman <davidglanzman@yahoo.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	me@jwang.link,
	end.to.start@mail.ru,
	mnixry@outlook.com,
	kfs.szk@gmail.com,
	malcolm@5harts.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 02/16] ASoC: amd: yc: Add quirk for HP Dragonfly pro one
Date: Sat, 12 Oct 2024 07:25:58 -0400
Message-ID: <20241012112619.1762860-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112619.1762860-1-sashal@kernel.org>
References: <20241012112619.1762860-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
Content-Transfer-Encoding: 8bit

From: David Lawrence Glanzman <davidglanzman@yahoo.com>

[ Upstream commit 84e8d59651879b2ff8499bddbbc9549b7f1a646b ]

Adds a quirk entry to enable the mic on HP Dragonfly pro one laptop

Signed-off-by: David Lawrence Glanzman <davidglanzman@yahoo.com>
Link: https://patch.msgid.link/1249c09bd6bf696b59d087a4f546ae397828656c.camel@yahoo.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 06349bf0b6587..ace6328e91e31 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -444,6 +444,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A3E"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8A7F"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


