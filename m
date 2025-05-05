Return-Path: <stable+bounces-141305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13848AAB242
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9A44C0E5F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5601636A989;
	Tue,  6 May 2025 00:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpbV4wj5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6BD280316;
	Mon,  5 May 2025 22:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485731; cv=none; b=qcncmeFkVMXJbZWnD9kFyACFjHRcrb/sTi22INp36U2EQ4jgeAR3QLI3arbJ4YrK9+/d7o2/bmDWCLDG8zwSYcexLTGybE8IkfKU4HujuhIKQwW4ubjz4CtAg5+8FqDVzzFnm/IIeInkTuhZdk+8yiiFpBli9xZ5bMGEv0z/dBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485731; c=relaxed/simple;
	bh=dre8okAa5Q0bcUAIP51uDJhSuiCVcGjq/ec+y9xLIKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iuuDGeV5qy5DDiWz6mIt6I46DgrR22mUewRKhs1qQTbEGQn/zJ7LDfxGPqZC6mK/LMyZkRIG3Ij0pLwy5KZS7KqxlmfouREP7HQ9uWFCrb19K0dpD2dvyU2QN3Fu1lHPobx4/YNdiV0TnszTg60RmXVO/YsQewoQNKrmJ9PTeiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpbV4wj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36241C4CEEE;
	Mon,  5 May 2025 22:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485729;
	bh=dre8okAa5Q0bcUAIP51uDJhSuiCVcGjq/ec+y9xLIKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mpbV4wj5V5662be2m5SnBsFBv98AP3vhnUHXksewnqiKhAva36hu0wulv10VOoJjA
	 9HvjkmghWgnsdKL+T9ViPgu4zMicN1+ML76x4kXe9EOfhFfefBvRl46MaevZs+3kqf
	 kCECKnSZ2mr9SVyNbWid4WC4Ee7UbZSTQoXb2XkRb86DsxoDz9pMolsCiYv6AhkskN
	 EZigF7+af8Uy6IXnLr9Cnm5IdwkdXNcHe7o5TCGaRUX7YZbZnBTaAH7xmy9Iasb9z/
	 IihYCMWKOLATintpbaf9AINX71vuEcfFKrg5j72LPU6dvkFI90N+iNLMLZa2HXce7l
	 aZuv/Wne/GULQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 448/486] ASoC: codecs: pcm3168a: Allow for 24-bit in provider mode
Date: Mon,  5 May 2025 18:38:44 -0400
Message-Id: <20250505223922.2682012-448-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit 7d92a38d67e5d937b64b20aa4fd14451ee1772f3 ]

As per codec device specification, 24-bit is allowed in provider mode.
Update the code to reflect that.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://patch.msgid.link/20250203141051.2361323-4-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/pcm3168a.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index fac0617ab95b6..6cbb8d0535b02 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -493,9 +493,9 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 		}
 		break;
 	case 24:
-		if (provider_mode || (format == SND_SOC_DAIFMT_DSP_A) ||
-		    		     (format == SND_SOC_DAIFMT_DSP_B)) {
-			dev_err(component->dev, "24-bit slots not supported in provider mode, or consumer mode using DSP\n");
+		if (!provider_mode && ((format == SND_SOC_DAIFMT_DSP_A) ||
+				       (format == SND_SOC_DAIFMT_DSP_B))) {
+			dev_err(component->dev, "24-bit slots not supported in consumer mode using DSP\n");
 			return -EINVAL;
 		}
 		break;
-- 
2.39.5


