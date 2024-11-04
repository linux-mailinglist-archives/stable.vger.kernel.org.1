Return-Path: <stable+bounces-89631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC649BB1CC
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3B81F21F4B
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 10:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A4C1B393D;
	Mon,  4 Nov 2024 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSBiVNid"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D6A1B0F26;
	Mon,  4 Nov 2024 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717517; cv=none; b=pYZXF1u9RoWcb5yIa6xs1K2ZLEc2veNu+x+Z2XDIfyLKF/bGXSTMZ1utysPDOXzg5w/idGgoIlEzKa5HyLhX4zHqjMvycpjeMgN2KT+bDBu78+XDjERsDp6btQGz6xgF8DaI9xUeYh/yLJNRMPrMGQeScdmLEZ1amvmsXZINhho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717517; c=relaxed/simple;
	bh=ccA9hhIWbNWL0PykeM6304+ud5NEmhGoD1jTaLRZ3iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOTDs9kSwHj1If2YUr8xOMH8YFeM1/0gWf1o1MXeZGPP76M1C9LXPg79EGPpvTropo0lUzF04vVO+8oyyxCkWFlnIVvmx1gCq1k6Dx/m3OKOVYHtt1tBx5xjWu1BysuN/JmPyPs/bnB08resP/9ctszGcMwxJY0viBKbJ12Rrf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSBiVNid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE86BC4CECE;
	Mon,  4 Nov 2024 10:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717517;
	bh=ccA9hhIWbNWL0PykeM6304+ud5NEmhGoD1jTaLRZ3iQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oSBiVNidlOgF/+D6WJHNzmwx/10kgxrDvSPVyYRV9pmSldUxwlQh4ngbAB3+iukqg
	 7N6jtwsjRHMMSo+gFCgl9TYJHrKppRxXui6LVePuN0wl7C30SO4HOC0Ei2YuqTCfjC
	 mrVCtU0nV+Q1eY3PV3tvwKUQ2JWxinTFudha3QJqR+6DrK62E8OYJrZTi6VdXmWOSF
	 e6gt8VVZo8tUGYoqD+eYF2KECsPhobNuLND8EiIEhi4PG5Fpskc0RVJpohCByWTwuj
	 wEwXyY2PlnXRokSVlnA9JO0OfyOGu71zyUbgceCGbJnY2F73rHMw0o7YQcRDDuQ/0c
	 W7EecOFuvgBgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexey Klimov <alexey.klimov@linaro.org>,
	Adam Skladowski <a39.skl@gmail.com>,
	Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
	Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	krzysztof.kozlowski@linaro.org,
	u.kleine-koenig@baylibre.com,
	dmitry.baryshkov@linaro.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 18/21] ASoC: codecs: wcd937x: relax the AUX PDM watchdog
Date: Mon,  4 Nov 2024 05:49:54 -0500
Message-ID: <20241104105048.96444-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105048.96444-1-sashal@kernel.org>
References: <20241104105048.96444-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.6
Content-Transfer-Encoding: 8bit

From: Alexey Klimov <alexey.klimov@linaro.org>

[ Upstream commit 107a5c853eef5336a9846e7dd2f9184b6e3c07c7 ]

On a system with wcd937x, rxmacro and Qualcomm audio DSP, which is pretty
common set of devices on Qualcomm platforms, and due to the order of how
DAPM widgets are powered on (they are sorted), there is a small time window
when wcd937x chip is online and expects the flow of incoming data but
rxmacro is not yet online. When wcd937x is programmed to receive data
via AUX port then its AUX PDM watchdog is enabled in
wcd937x_codec_enable_aux_pa(). If due to some reasons the rxmacro and
soundwire machinery are delayed to start streaming data, then there is
a chance for this AUX PDM watchdog to reset the wcd937x codec. Such event
is not logged as a message and only wcd937x IRQ counter is increased
however there could be a lot of other reasons for that IRQ.
There is a similar opportunity for such delay during DAPM widgets power
down sequence.

If wcd937x codec reset happens on the start of the playback, then there
will be no sound and if such reset happens at the end of a playback then
it may generate additional clicks and pops noises.

On qrb4210 RB2 board without any debugging bits the wcd937x resets are
sometimes observed at the end of a playback though not always.
With some debugging messages or with some tracing enabled the AUX PDM
watchdog resets the wcd937x codec at the start of a playback and there
is no sound output at all.

In this patch:
 - TIMEOUT_SEL bit in PDM_WD_CTL2 register is set to increase the watchdog
reset delay to 100ms which eliminates the AUX PDM watchdog IRQs on
qrb4210 RB2 board completely and decreases the number of unwanted clicks
noises;

 - HOLD_OFF bit postpones triggering such watchdog IRQ till wcd937x codec
reset which usually happens at the end of a playback. This allows to
actually output some sound in case of debugging.

Cc: Adam Skladowski <a39.skl@gmail.com>
Cc: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
Link: https://patch.msgid.link/20241022033132.787416-3-alexey.klimov@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wcd937x.c | 10 ++++++++--
 sound/soc/codecs/wcd937x.h |  4 ++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 63b25c321a03d..3c1224d8f2dff 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -715,12 +715,17 @@ static int wcd937x_codec_enable_aux_pa(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(component);
 	int hph_mode = wcd937x->hph_mode;
+	u8 val;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
+		val = WCD937X_DIGITAL_PDM_WD_CTL2_EN |
+		      WCD937X_DIGITAL_PDM_WD_CTL2_TIMEOUT_SEL |
+		      WCD937X_DIGITAL_PDM_WD_CTL2_HOLD_OFF;
 		snd_soc_component_update_bits(component,
 					      WCD937X_DIGITAL_PDM_WD_CTL2,
-					      BIT(0), BIT(0));
+					      WCD937X_DIGITAL_PDM_WD_CTL2_MASK,
+					      val);
 		break;
 	case SND_SOC_DAPM_POST_PMU:
 		usleep_range(1000, 1010);
@@ -741,7 +746,8 @@ static int wcd937x_codec_enable_aux_pa(struct snd_soc_dapm_widget *w,
 					hph_mode);
 		snd_soc_component_update_bits(component,
 					      WCD937X_DIGITAL_PDM_WD_CTL2,
-					      BIT(0), 0x00);
+					      WCD937X_DIGITAL_PDM_WD_CTL2_MASK,
+					      0x00);
 		break;
 	}
 
diff --git a/sound/soc/codecs/wcd937x.h b/sound/soc/codecs/wcd937x.h
index 37bff16e88ddd..a2bd47a93e507 100644
--- a/sound/soc/codecs/wcd937x.h
+++ b/sound/soc/codecs/wcd937x.h
@@ -391,6 +391,10 @@
 #define WCD937X_DIGITAL_PDM_WD_CTL0		0x3465
 #define WCD937X_DIGITAL_PDM_WD_CTL1		0x3466
 #define WCD937X_DIGITAL_PDM_WD_CTL2		0x3467
+#define WCD937X_DIGITAL_PDM_WD_CTL2_HOLD_OFF	BIT(2)
+#define WCD937X_DIGITAL_PDM_WD_CTL2_TIMEOUT_SEL	BIT(1)
+#define WCD937X_DIGITAL_PDM_WD_CTL2_EN		BIT(0)
+#define WCD937X_DIGITAL_PDM_WD_CTL2_MASK	GENMASK(2, 0)
 #define WCD937X_DIGITAL_INTR_MODE		0x346A
 #define WCD937X_DIGITAL_INTR_MASK_0		0x346B
 #define WCD937X_DIGITAL_INTR_MASK_1		0x346C
-- 
2.43.0


