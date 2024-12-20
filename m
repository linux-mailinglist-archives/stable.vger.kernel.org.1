Return-Path: <stable+bounces-105439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44679F97BF
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5D61899918
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9297121D5B6;
	Fri, 20 Dec 2024 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRQpg0KV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA0521D5AB;
	Fri, 20 Dec 2024 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714706; cv=none; b=mGsLuWK5zE5MQT8ju8/pMl7aeAAsVNsC51NWK1JQTZsccDnhkkFCibCdxApvg7d1oHn+xz1C/8Q47jlKF6HOlLXaECuIuKQ/yMrMjvOigicTQiI8CrQY4VTY9VFi8/KtKGmUj7jtj5hA7Y1m5co9iMXoMdFNhq7r22c65s+WnFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714706; c=relaxed/simple;
	bh=ThH0aDLGcUGbu9Akpish5YXh+1I3B1+y+S5BGsx4ba8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rn9mHIp3ROLTh1u4qCgn7jQ4/Ov5m8OSI2WADvvRxzWE4AKjYiN5FMAP++3bbTqsRo5NGtMGQdurRhplqRG9AYuXGrJJS4Tk9nHxyTH2kTa45yBkpU4a+atQotRsD6qQL9FOHNI/6TrYkvNJ4lh1idi6aF5nBBs3wKSiRHo/5Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRQpg0KV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF49C4CECD;
	Fri, 20 Dec 2024 17:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714705;
	bh=ThH0aDLGcUGbu9Akpish5YXh+1I3B1+y+S5BGsx4ba8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SRQpg0KVvGf5jGlVz+o4lewx0EyCPFuCNLICs3F6tszG3JA/fp+q8jLsM+h7s94eA
	 P9YHoanCklwym++UF+6XbwfP0kOP+1kuvSGoO0JutVClfiWimr+i05VAKTKJkSFGFz
	 NaOCCq9QUSBdWfWLofbUkJXq8tfpnVqXssa3wJ0TwkJ6BfCJ/+UwvVXXzgDEnz2jDJ
	 oUU8im/FERY7JUOlnJUSCOMGQ3SYlEdLiapnC3Hi+DjFwqTiXqqxtx1XXKZVADFMUe
	 c3PHghbEwCO5p9BDkaZW0RlFlo6e4HtyiSfa70LyKUwRcT/FnkpCShpoizUMPUZb+I
	 bkh/nzkeu3CNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Simon Trimmer <simont@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	david.rhodes@cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: [PATCH AUTOSEL 6.12 07/29] ALSA: hda: cs35l56: Remove calls to cs35l56_force_sync_asp1_registers_from_cache()
Date: Fri, 20 Dec 2024 12:11:08 -0500
Message-Id: <20241220171130.511389-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171130.511389-1-sashal@kernel.org>
References: <20241220171130.511389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.6
Content-Transfer-Encoding: 8bit

From: Simon Trimmer <simont@opensource.cirrus.com>

[ Upstream commit 47b17ba05a463b22fa79f132e6f6899d53538802 ]

Commit 5d7e328e20b3 ("ASoC: cs35l56: Revert support for dual-ownership
of ASP registers")
replaced cs35l56_force_sync_asp1_registers_from_cache() with a dummy
implementation so that the HDA driver would continue to build.

Remove the calls from HDA and remove the stub function.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://patch.msgid.link/20241206105757.718750-1-rf@opensource.cirrus.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/cs35l56.h     | 6 ------
 sound/pci/hda/cs35l56_hda.c | 8 --------
 2 files changed, 14 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 94e8185c4795..3dc7a1551ac3 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -271,12 +271,6 @@ struct cs35l56_base {
 	struct gpio_desc *reset_gpio;
 };
 
-/* Temporary to avoid a build break with the HDA driver */
-static inline int cs35l56_force_sync_asp1_registers_from_cache(struct cs35l56_base *cs35l56_base)
-{
-	return 0;
-}
-
 static inline bool cs35l56_is_otp_register(unsigned int reg)
 {
 	return (reg >> 16) == 3;
diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index e3ac0e23ae32..7baf3b506eef 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -151,10 +151,6 @@ static int cs35l56_hda_runtime_resume(struct device *dev)
 		}
 	}
 
-	ret = cs35l56_force_sync_asp1_registers_from_cache(&cs35l56->base);
-	if (ret)
-		goto err;
-
 	return 0;
 
 err:
@@ -1059,9 +1055,6 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
 
 	regmap_multi_reg_write(cs35l56->base.regmap, cs35l56_hda_dai_config,
 			       ARRAY_SIZE(cs35l56_hda_dai_config));
-	ret = cs35l56_force_sync_asp1_registers_from_cache(&cs35l56->base);
-	if (ret)
-		goto dsp_err;
 
 	/*
 	 * By default only enable one ASP1TXn, where n=amplifier index,
@@ -1087,7 +1080,6 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
 
 pm_err:
 	pm_runtime_disable(cs35l56->base.dev);
-dsp_err:
 	cs_dsp_remove(&cs35l56->cs_dsp);
 err:
 	gpiod_set_value_cansleep(cs35l56->base.reset_gpio, 0);
-- 
2.39.5


