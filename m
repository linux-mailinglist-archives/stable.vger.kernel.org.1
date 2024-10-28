Return-Path: <stable+bounces-89018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374419B2DC3
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBA5281024
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4DD1DFE13;
	Mon, 28 Oct 2024 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ia6A0Wjn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE02F1D90D4;
	Mon, 28 Oct 2024 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112749; cv=none; b=Qv2gahSoEbp0XaBLq/U4dBurO1auj86b4wz/Yz4z3PnT0sQjsmmZpUCiQUiyyOeQ5sm2QtrrYYYf/Mp4BSYQw42IW7SgRRRP64btB38zaVG1gDePmZHBhDdTQ1554v3sysGu0ZQUDQNwjXMC8PTiDejJjqTHTVZZgjgk23bzCKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112749; c=relaxed/simple;
	bh=r5uSrvFvlRLlxIaGnygJzMmBoDijBxhldhloJYf3bAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Su22kBC69aig2ORmcYvVSV5nFpb76Houz13xAM9paCXJPE3oMK3lr0dt/8Cd27eQXk1nnFpFddNONtwnSMTXNss9FGM2Wlwg9PB1GQMDGAimFuzsgbys0w6kMUp2Cchd5M7MihNbdHKk/tMhJ1BAKMCP/CmGIzO+7JiuSA6xrRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ia6A0Wjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14164C4CEC3;
	Mon, 28 Oct 2024 10:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112748;
	bh=r5uSrvFvlRLlxIaGnygJzMmBoDijBxhldhloJYf3bAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ia6A0WjnH9HP4dWJuQCW1uYHhGu0YHEzSoajTAgSoIVOvtz6Yvwg8URSL2GvwUshG
	 OfjphSkEZ2V+J0OsxUfORLUfxedZXQR2wCcEvWH/o1fs6wgmIqowhMe4cLLVMaNetD
	 fTTXahib+KUE8zM2+plEhXf2i9Brkkg3QzLMQLkW7VUpqYdpVfhsLgQXpxtp6kbw8Z
	 q8UxTuaGeYNW65CeyLJvnLOZ4GeZ6n1yE0wybhoLocX3QQVhtP+ZUB4PjyoePDkWo8
	 lTE30pUI8H6xUPF/VyvoMspvNr22Nz+vXfm4vdemCAuqYC7jVS7JGknBkQlgYSYy5x
	 iwtIXttoa4mTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilya Dudikov <ilyadud@mail.ru>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	me@jwang.link,
	end.to.start@mail.ru,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/15] ASoC: amd: yc: Fix non-functional mic on ASUS E1404FA
Date: Mon, 28 Oct 2024 06:52:00 -0400
Message-ID: <20241028105218.3559888-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105218.3559888-1-sashal@kernel.org>
References: <20241028105218.3559888-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
Content-Transfer-Encoding: 8bit

From: Ilya Dudikov <ilyadud@mail.ru>

[ Upstream commit b0867999e3282378a0b26a7ad200233044d31eca ]

ASUS Vivobook E1404FA needs a quirks-table entry for the internal microphone to function properly.

Signed-off-by: Ilya Dudikov <ilyadud@mail.ru>
Link: https://patch.msgid.link/20241016034038.13481-1-ilyadud25@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index d03e95844c3a8..859161194af10 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -325,6 +325,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E1404FA"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


