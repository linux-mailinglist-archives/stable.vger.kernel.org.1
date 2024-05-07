Return-Path: <stable+bounces-43282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDD08BF14F
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41061C20AFA
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B00185623;
	Tue,  7 May 2024 23:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ic4lyIOL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0708527D;
	Tue,  7 May 2024 23:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123287; cv=none; b=cH2OOw86zDK0jb98nqqOssCHQJXBSZKGJH9CqEgDP0gutzRO921irS0eCwfdnu90Rle0V48vZSf2Pyok+kCWgITb82eNmlppsQ/q71xciswnk6gy8PZs5Ytr27XK03bRrdS+hXP2aEY6705hQsZ4PbxH9tAnJVHEKZ86UcWyblM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123287; c=relaxed/simple;
	bh=C1B5jC0QAnqRkp/KEnzDHCaQIM2O1X0DeTCyuINL+nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSlz8cNWQKQBz5dBkXK2bO8YuFGYqLtFu4h1CovHgFT6XWFhRHqB2yN4jYNTA4AjrRTho92FYMVS0E/+bKxwH8ZuzyICGjFHZwEWGlgd281nzP55go12dfxkhgX+7oAnEf6dy08vHkRZ4ZOXqLVGBpsKxe9puYLhKLcCOVAiDV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ic4lyIOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F83C4FDF5;
	Tue,  7 May 2024 23:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123286;
	bh=C1B5jC0QAnqRkp/KEnzDHCaQIM2O1X0DeTCyuINL+nE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ic4lyIOLhxCnxIkrFTgx1FTi+xp75FnFZdZlK1vO8Ff4JKXPdbHFTkURJMHSJVNhj
	 80PedrS3tEMsXqSGvX0xqvpulgnWMPcUQUeVdoxTxeYOBSeqVCXS92ZFjWeDlMXz8n
	 ELGF5uDz11HQcCNq+KDzl32h2/h/3SZL5yTBVl2JqQlSV/UbOBYNxsrB01leAQavrA
	 8l3UsEqaGysAnKRE6e+G46mPdFzyEOpDVnTMeJZItKEoWEBrzWKjCguOExLV7/Z4vq
	 LM+hOWwZkQm+K/7Nrca+2DzJ5oDMs3jbn/QsX3bU2PVbLjcK6RIK/PSnyJgO3SOkg+
	 aHE/G32x956pg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 03/52] ALSA: hda: cs35l56: Exit cache-only after cs35l56_wait_for_firmware_boot()
Date: Tue,  7 May 2024 19:06:29 -0400
Message-ID: <20240507230800.392128-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit 73580ec607dfe125b140ed30c7c0a074db78c558 ]

Adds calls to disable regmap cache-only after a successful return from
cs35l56_wait_for_firmware_boot().

This is to prepare for a change in the shared ASoC module that will
leave regmap in cache-only mode after cs35l56_system_reset(). This is
to prevent register accesses going to the hardware while it is
rebooting.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://msgid.link/r/20240408101803.43183-3-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l56_hda.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 43a445bd961fb..de58a953b48d2 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -629,6 +629,8 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 		ret = cs35l56_wait_for_firmware_boot(&cs35l56->base);
 		if (ret)
 			goto err_powered_up;
+
+		regcache_cache_only(cs35l56->base.regmap, false);
 	}
 
 	/* Disable auto-hibernate so that runtime_pm has control */
@@ -978,6 +980,8 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int id)
 	if (ret)
 		goto err;
 
+	regcache_cache_only(cs35l56->base.regmap, false);
+
 	ret = cs35l56_set_patch(&cs35l56->base);
 	if (ret)
 		goto err;
-- 
2.43.0


