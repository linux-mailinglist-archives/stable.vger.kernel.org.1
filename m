Return-Path: <stable+bounces-67579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA99A95120C
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 04:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B241F2473D
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 02:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEC813D606;
	Wed, 14 Aug 2024 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKnQaSTI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0632113D531;
	Wed, 14 Aug 2024 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601713; cv=none; b=H4Nf0Nzwo3Ci0t35cy/rLvVmJH5WucBv8I5FJ3tX+rGvr9iKJlqDeY8RB1Dk64TD9LJgAz7S0a4dSHujtpVbRaWAaBHr6+odcV1/eFTWFRYyGQa4yrZaD1x1ZVC6eGSBL7KWH01oAI/GfFg8nJ0LURsOg0p+tFJHBmIKPloVaDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601713; c=relaxed/simple;
	bh=YqS6wgA8TzPLxuLVkvnPsaOdJPUjMTohbix0zBGoew4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZtddvRAoAoeC8KnBO7ybbFN+Rd3/Vq7xGo5cxmoO6vf2yDv8Stxh+2FPBSNVmGwrsa8F1eOPUVOLTBp4tp7o7VAkFeeYQ2m7NKxIkN7MET5PZm+3fNOetaUStH+c6fyXgKJRSbDHKFZ2+GNvmfBDzmL0Goja8X9xonNzljk1sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKnQaSTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4908C32782;
	Wed, 14 Aug 2024 02:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723601712;
	bh=YqS6wgA8TzPLxuLVkvnPsaOdJPUjMTohbix0zBGoew4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HKnQaSTIK57Je9MtFKeVY67bODxnRHr1rDQGawz2sfBSEEtOesVLGR/epybuKqz89
	 vdSe5FGD8/MVhUW6SHIr7gQXxH/kir6pUrv/k9bGyzNEbzK5bbk54IWBJEi8xk6nLp
	 EGxzlCWgs9TR671eZHvlzoCHSVNWdd267cZ2TTktGP55gdSdWBH1jE8Ubn1Pl/6UJW
	 qlnnC1oLDlQQ842kYZOoe4AsT0XtkgLqZF7EVd/vRoI2OMLvd3hppGwZypT7xRUJcm
	 iaVa6ZN1krUCN3GjzWAQ3p6JYsJJlywgrSonbSIbTmS8rHhfdSryF3IrbjolQHPU7u
	 YS7m+I5RHnLtg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <zhangyi@everest-semi.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	zhuning0077@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 13/13] ASoC: codecs: ES8326: button detect issue
Date: Tue, 13 Aug 2024 22:14:44 -0400
Message-ID: <20240814021451.4129952-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814021451.4129952-1-sashal@kernel.org>
References: <20240814021451.4129952-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.4
Content-Transfer-Encoding: 8bit

From: Zhang Yi <zhangyi@everest-semi.com>

[ Upstream commit 4684a2df9c5b3fc914377127faf2515aa9049093 ]

We find that we need to set snd_jack_types to 0. If not,
there will be a probability of button detection errors

Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
Link: https://patch.msgid.link/20240807025356.24904-2-zhangyi@everest-semi.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/es8326.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/es8326.c b/sound/soc/codecs/es8326.c
index 6a4e42e5e35b9..e620af9b864cb 100644
--- a/sound/soc/codecs/es8326.c
+++ b/sound/soc/codecs/es8326.c
@@ -825,6 +825,8 @@ static void es8326_jack_detect_handler(struct work_struct *work)
 		es8326_disable_micbias(es8326->component);
 		if (es8326->jack->status & SND_JACK_HEADPHONE) {
 			dev_dbg(comp->dev, "Report hp remove event\n");
+			snd_soc_jack_report(es8326->jack, 0,
+				    SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2);
 			snd_soc_jack_report(es8326->jack, 0, SND_JACK_HEADSET);
 			/* mute adc when mic path switch */
 			regmap_write(es8326->regmap, ES8326_ADC1_SRC, 0x44);
-- 
2.43.0


