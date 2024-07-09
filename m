Return-Path: <stable+bounces-58780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EBE92BFCD
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE22228603C
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81FE1AAE00;
	Tue,  9 Jul 2024 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qr/LVt3w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9234E19D8B2;
	Tue,  9 Jul 2024 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542049; cv=none; b=tCGaIq8/YeP64ThBjuixpmj/gp0T4aPBcxSuBl71tlJF1SSAScjhLkbEzbGBFtKiD+EEIhDqdH6Lpap89OBlM2UivjroG+Zyooz2vXWbvjILzFMQaUjafqToL0H/6ntd4INvI1N6ZbO99gLkhK4yVyVMEngqSE2KvxB0h2vhbL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542049; c=relaxed/simple;
	bh=Xq+0vUYsrT6HOH4JXBAguaoIJtc1QaSdaisDPx+OCuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXeeODjGqYGnrkciY3UhUkhkLltsXSqvjfITNeuGQK72sZAL05NIhFAlCUFHrzBem2x/WxtdmqrNdNp+IYhhZx5xh2+v/AAxX2LuXQjIZRQTsh29HsN+1eDzwRsWaIqwIEKCSKiDFkyDjEJSPEvfKNMCOVHw6lENBC+z/WqMiNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qr/LVt3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9937C4AF0E;
	Tue,  9 Jul 2024 16:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542049;
	bh=Xq+0vUYsrT6HOH4JXBAguaoIJtc1QaSdaisDPx+OCuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qr/LVt3wX/oG1qyzBVS/QcZ5FlChjPVO86t9CV08vlKEIrMZ4qVhrlhCBtIBWfscT
	 yMNqByk1SM4PKvnP90cYm11XagoWBkT3MZY65k3rlp6zcvwOApHLm4sSP7g8ZxSug/
	 cc0TnSwVRc5DIN8KM8M6X8dzWVmbHLVFHxCvv0j0D3URBTsMAMnLLqGYouOGSDIwHk
	 ltgfPsRzTg9LMm1oPDfpC14/vu6LHL32qXb/b6Rw0aGHVdZou86g5RbV5xJTRXubDE
	 fsU8FvtOPCxvpP/8wjYpMtfRPSEHlEQW0aXjeWHkJX5tUStYmHHfONcJm41z4nKz4b
	 +nPhGej69fSmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	david.rhodes@cirrus.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 18/40] ASoC: cs35l56: Disconnect ASP1 TX sources when ASP1 DAI is hooked up
Date: Tue,  9 Jul 2024 12:18:58 -0400
Message-ID: <20240709162007.30160-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162007.30160-1-sashal@kernel.org>
References: <20240709162007.30160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.8
Content-Transfer-Encoding: 8bit

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit 8af49868e51ed1ba117b74728af12abe1eda82e5 ]

If the ASP1 DAI is hooked up by the machine driver the ASP TX mixer
sources should be initialized to disconnected. There aren't currently
any available products using the ASP so this doesn't affect any
existing systems.

The cs35l56 does not have any fixed default for the mixer source
registers. When the cs35l56 boots, its firmware patches these registers
to setup a system-specific routing; this is so that Windows can use
generic SDCA drivers instead of needing knowledge of chip-specific
registers. The setup varies between end-products, which each have
customized firmware, and so the default register state varies between
end-products. It can also change if the firmware on an end-product is
upgraded - for example if a change was needed to the routing for Windows
use-cases. It must be emphasized that the settings applied by the
firmware are not internal magic tuning; they are statically implementing
use-case setup that on Linux would be done via ALSA controls.

The driver is currently syncing the mixer controls with whatever
initial state the firmware wrote to the registers, so that they report
the actual audio routing. But if the ASP DAI is hooked up this can create
a powered-up DAPM graph without anything intentionally setting up a path.
This can lead to parts of the audio system powering up unexpectedly.

For example when cs35l56 is connected to cs42l43 using a codec-codec link,
this can create a complete DAPM graph which then powers-up cs42l43. But
the cs42l43 can only be clocked from its SoundWire bus so this causes a
bunch of errors in the kernel log where cs42l43 is unexpectedly powered-up
without a clock.

If the host is taking ownership of the ASP (either directly or as a
codec-to-codec link) there is no need to keep the mixer settings that the
firmware wrote. The driver has ALSA controls for setting these using
standard Linux mechanisms. So if the machine driver hooks up the ASP the
ASP mixers are initialized to "None" (no input). This prevents unintended
DAPM-graph power-ups, and means the initial state of the mixers is
always going to be None.

Since the initial state of the mixers can vary from system to system and
potentially between firmware upgrades, no use-case manager can currently
assume that cs35l56 has a known initial state. The firmware could just as
easily default them to "None" as to any input source. So defaulting them
to "None" in the driver is not increasing the entropy of the system.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20240613132527.46537-1-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l56-shared.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index fd02b621da52c..d29878af2a80d 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -214,6 +214,10 @@ static const struct reg_sequence cs35l56_asp1_defaults[] = {
 	REG_SEQ0(CS35L56_ASP1_FRAME_CONTROL5,	0x00020100),
 	REG_SEQ0(CS35L56_ASP1_DATA_CONTROL1,	0x00000018),
 	REG_SEQ0(CS35L56_ASP1_DATA_CONTROL5,	0x00000018),
+	REG_SEQ0(CS35L56_ASP1TX1_INPUT,		0x00000000),
+	REG_SEQ0(CS35L56_ASP1TX2_INPUT,		0x00000000),
+	REG_SEQ0(CS35L56_ASP1TX3_INPUT,		0x00000000),
+	REG_SEQ0(CS35L56_ASP1TX4_INPUT,		0x00000000),
 };
 
 /*
-- 
2.43.0


