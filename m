Return-Path: <stable+bounces-5351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1686680CAE9
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E94B20F7F
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E3C3E499;
	Mon, 11 Dec 2023 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdrWVEgw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7513E474;
	Mon, 11 Dec 2023 13:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5879BC433CA;
	Mon, 11 Dec 2023 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702301145;
	bh=CR4WEiVLSbI2eaXlZ+1qwly9qiLQTKtm9P5IJp8GAYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JdrWVEgwfxDc3wu20xBwcrinYaKy9S/4VKOe2QcSwApLUdLd98hme+dafUfnIfslC
	 VFr1/X/On6ADNdadg3HQG8Ax2xuuvxNT/v+BxdjKJ3PpC5icWCBW6pi1Ikt0N1xasX
	 QfFluSUWQuyWw8FnN3K2H8hR/KQcbswmsVnSuHwMMDzeSF4zQew0e/Xt3fVj/KSI21
	 y5y2UN6d8W4EpJM1HsnUl9J/6mppJ62SjUYm+zftSjaCYoilQBDmmSx3TiToYW2520
	 Ok1fnf7nOvLnsPhR0dT4Z7hMU7KgPWAavD97ZovBr6TYAGYJqrkFTSM2gkq5RVTGR3
	 zIpKvPf2igNsg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rCgIq-0007Fh-0m;
	Mon, 11 Dec 2023 14:26:32 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	broonie@kernel.org,
	alsa-devel@alsa-project.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org,
	srinivas.kandagatla@linaro.org
Subject: [PATCH stable-6.6 1/2] ASoC: ops: add correct range check for limiting volume
Date: Mon, 11 Dec 2023 14:26:07 +0100
Message-ID: <20231211132608.27861-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211132608.27861-1-johan+linaro@kernel.org>
References: <20231211132608.27861-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

commit fb9ad24485087e0f00d84bee7a5914640b2b9024 upstream.

Volume can have ranges that start with negative values, ex: -84dB to
+40dB. Apply correct range check in snd_soc_limit_volume before setting
the platform_max. Without this patch, for example setting a 0dB limit on
a volume range of -84dB to +40dB would fail.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231204124736.132185-2-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/soc-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 55b009d3c681..2d25748ca706 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -661,7 +661,7 @@ int snd_soc_limit_volume(struct snd_soc_card *card,
 	kctl = snd_soc_card_get_kcontrol(card, name);
 	if (kctl) {
 		struct soc_mixer_control *mc = (struct soc_mixer_control *)kctl->private_value;
-		if (max <= mc->max) {
+		if (max <= mc->max - mc->min) {
 			mc->platform_max = max;
 			ret = 0;
 		}
-- 
2.41.0


