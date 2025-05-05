Return-Path: <stable+bounces-141451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E7AAAB71F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1923AD3AC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10762459CF;
	Tue,  6 May 2025 00:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZqivO3p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ABF281537;
	Mon,  5 May 2025 23:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486351; cv=none; b=f9lhFdYeGZQ728pme8IlmtY7llRzwI0p182YMpB6e9e1YJx9E+Pdtl3ahnVIxc5WwNKGLbHNxnnVH/EP6eaeJxVOMz+y4Pjl0ZRgJETPIkjUrFFaysPfx5aicptZwtrwNKEoXGh/wTZr6cs4ubfIu50/waevQO7flUWTk0aBtfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486351; c=relaxed/simple;
	bh=xnvKQSgmz6+WJmoTJIO0JKQ6WIu8i0r+uXotJHnnevk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K8CoVQz86NFxpwr6NwXcWtjy07BYsqYL8c5vNGvQlKz4v5JFIs0vq10Kwdp95GOt7DWTDIwdVgkwDFFYFuwdzKhxxpr25QooUtLOL1Ego7tG2Kp8QTbT04ZAPORXfxqVbGYSMaH6kSpX0lhxrqUvC8TAf8wHEmcRsRIWuw25J6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZqivO3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B76C4CEF1;
	Mon,  5 May 2025 23:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486350;
	bh=xnvKQSgmz6+WJmoTJIO0JKQ6WIu8i0r+uXotJHnnevk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uZqivO3pM0aI2DXBcxSZ09FbTyl6LRflCQdVegU9H9S0IQuPS5YNNR4e8pelON2/A
	 bE574aB3fT2KVnLm6mvtXvyNtj52DKUGEeTNNOuWn1SUmaspJ9xEPup51qiD3i/Uff
	 TNQVidZu7FpdPVMl05ZMMfwjbXn9Q72dVTPRDT6uo3F3t8/PfZ7foRwxf4Uh7kXkeN
	 21UdszTwn8wqf1YyyZxMmJ3FF1BIiJNaUvUqzIxOnWOfJH04AegXxSQFfIJrxZ6BZv
	 aixJWvKJvpuf6S3CQ+kO1cfOTLPOWbiaiuKthbXbthgWjW0LwK6eb+CrG6f+bQTdij
	 V/uAjMVK9+quQ==
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
Subject: [PATCH AUTOSEL 6.6 274/294] ASoC: codecs: pcm3168a: Allow for 24-bit in provider mode
Date: Mon,  5 May 2025 18:56:14 -0400
Message-Id: <20250505225634.2688578-274-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 9d6431338fb71..329549936bd5c 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -494,9 +494,9 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
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


