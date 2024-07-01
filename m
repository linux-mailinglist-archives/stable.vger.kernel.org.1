Return-Path: <stable+bounces-56146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FF391D4DC
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6B81C20AA2
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0D08BF7;
	Mon,  1 Jul 2024 00:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVvYy8QW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172D08494;
	Mon,  1 Jul 2024 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792737; cv=none; b=j/uMLJaZdqa+Atu8VSKn8g6gZT2lihW087WVrVzyDqPIGIFUPstodcHm4PnokbpqjM3HYs8v2GizXgbaXvmhE4nQvP3zM04gr6ACA9666zrHNvAwWkyaUYNcnm7xxcMNMo7GYTavmcJnyFtTxe5PSRdaMncDMumJ81L3iK8dYSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792737; c=relaxed/simple;
	bh=GxLpi+fuId9C96AZzAKCOjRR9OiSVqXrxP0Z3u0bnRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BF7G/vmMOeo7SdRp78wTYqmfVmXffWut38ABpo2cOOOPaybNOhKJDlm0CbrT5t1+6t34k4rCLbxMuPTaRR4VAc3w1o4uO+6KjP9hYganSqEV3dq5Z5ZHoT6rb02/edi/3z1mYO2f8mfZEg5PEOslWsIpz2ifB2KeMQNMJ7Cd84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVvYy8QW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34907C4AF0E;
	Mon,  1 Jul 2024 00:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792736;
	bh=GxLpi+fuId9C96AZzAKCOjRR9OiSVqXrxP0Z3u0bnRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LVvYy8QWGHfFg+/5nVm+Cbx69jxbLklDPVDpiHiz3pnTTYxnR3Q0PzjQOyDtQOQ6M
	 2w1CO+RTrPP8DqyXp2gCSlchF8QHNzS5yMx765uOg8c4DPSl45qzIaY/haMJWsRaSK
	 Kg/Lq5tzJEjaTCfweLB4neT9NrvAn9QPtF5sqq9Cf3N+LCQLuED1Ix66E+Dyzk2eNr
	 l7MsRUWQh9X0BQ/b5c56V/2D6tV6hIdYlxH4t6Mee62f+qzF/5uEDijXu5qLn57h3i
	 HorEWSlLuivzSxY8ZeP4HSUKrWt87dlni3S/KSDrmSW93fgUxAWpZ3kLvlVfhthPDj
	 fZc+qDutKVzjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 03/20] ALSA: hda: cs35l41: Support Lenovo Thinkbook 16P Gen 5
Date: Sun, 30 Jun 2024 20:11:08 -0400
Message-ID: <20240701001209.2920293-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001209.2920293-1-sashal@kernel.org>
References: <20240701001209.2920293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.7
Content-Transfer-Encoding: 8bit

From: Stefan Binding <sbinding@opensource.cirrus.com>

[ Upstream commit 82f3daed2d3590fa286a02301573a183dd902a0f ]

This laptop does not contain _DSD so needs to be supported using the
configuration table.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20240606130351.333495-2-sbinding@opensource.cirrus.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l41_hda_property.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 4f5e581cdd5ff..e034828df4452 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -118,6 +118,8 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "17AA38B5", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B6", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B7", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
+	{ "17AA38F9", 2, EXTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
+	{ "17AA38FA", 2, EXTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
 	{}
 };
 
@@ -509,6 +511,8 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "17AA38B5", generic_dsd_config },
 	{ "CSC3551", "17AA38B6", generic_dsd_config },
 	{ "CSC3551", "17AA38B7", generic_dsd_config },
+	{ "CSC3551", "17AA38F9", generic_dsd_config },
+	{ "CSC3551", "17AA38FA", generic_dsd_config },
 	{}
 };
 
-- 
2.43.0


