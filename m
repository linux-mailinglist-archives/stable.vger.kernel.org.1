Return-Path: <stable+bounces-5349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B7680CAE7
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724E81C20F53
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F3F3E492;
	Mon, 11 Dec 2023 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cS/iWytV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C011A3E472;
	Mon, 11 Dec 2023 13:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53085C433C7;
	Mon, 11 Dec 2023 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702301145;
	bh=/z+1W086U9uqPBNKB8aX+O++X4c1G0rkhD8UdWMNhzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cS/iWytVlYQM0gozRB+Upq9CcIRrAvHsRFH6RQAkA1LWOcZagdgs3QQjBjKh2pVvG
	 ZFWp+/Z3CseCAgK6+JwoLQpZpkj8yhwlr0hISQFT4+CvkKkYX7VZZuoLBnJTKe5++f
	 Gsty+T7k9GY3hBQYrmPQUkNNCVbun56KPl7tMCQcMoKyIq7eg1aj+o11ffMLX3x7CT
	 Qa3ZO0/Ce82thdg6p9AwPChR7f+GWLnKW1/ImDclts5x8ABjzTr4pICELFPQAH+5hN
	 1w5BBDgSEwzP5ZtaGCJeM8iwGrNBi5Om+KLerFSJYLnfA8TnXkf6+OVc1+L/C3Bx/r
	 h6ARAZJ3U+NZA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rCgIq-0007Fj-10;
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
Subject: [PATCH stable-6.6 2/2] ASoC: qcom: sc8280xp: Limit speaker digital volumes
Date: Mon, 11 Dec 2023 14:26:08 +0100
Message-ID: <20231211132608.27861-3-johan+linaro@kernel.org>
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

commit 716d4e5373e9d1ae993485ab2e3b893bf7104fb1 upstream.

Limit the speaker digital gains to 0dB so that the users will not damage them.
Currently there is a limit in UCM, but this does not stop the user form
changing the digital gains from command line. So limit this in driver
which makes the speakers more safer without active speaker protection in
place.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231204124736.132185-3-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
[ johan: backport to 6.6; rename snd_soc_rtd_to_cpu() ]
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/qcom/sc8280xp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 14d9fea33d16..c61cad0180c8 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -27,6 +27,23 @@ struct sc8280xp_snd_data {
 static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct sc8280xp_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct snd_soc_card *card = rtd->card;
+
+	switch (cpu_dai->id) {
+	case WSA_CODEC_DMA_RX_0:
+	case WSA_CODEC_DMA_RX_1:
+		/*
+		 * set limit of 0dB on Digital Volume for Speakers,
+		 * this can prevent damage of speakers to some extent without
+		 * active speaker protection
+		 */
+		snd_soc_limit_volume(card, "WSA_RX0 Digital Volume", 84);
+		snd_soc_limit_volume(card, "WSA_RX1 Digital Volume", 84);
+		break;
+	default:
+		break;
+	}
 
 	return qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
 }
-- 
2.41.0


