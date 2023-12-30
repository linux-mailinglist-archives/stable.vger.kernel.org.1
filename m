Return-Path: <stable+bounces-8807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E848204FA
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6609828218A
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28E5883C;
	Sat, 30 Dec 2023 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SBZa/AC3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFC08821;
	Sat, 30 Dec 2023 12:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C95C433C7;
	Sat, 30 Dec 2023 12:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703937813;
	bh=oh2cxhuuH7wKaC9WFjIzgY4/LtBY4Rv5q0k5Cnr5am8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SBZa/AC3WzF1G81fsGYMsZkpGhWumyc6sR472hG+MJcrZ99Nr1JPhrB/9K0OvvTKt
	 1dnGPrrpjT5lg3nppuxIXpaTwxT8HSm2vPH8yl1RqtUvgnGVwEOzOpc32oxJka5Qnj
	 GFi8WPWyNnuPeuggpspfHguWz9TxgNZWIl01TT6Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>,
	Hsin-Yi Wang <hsinyi@google.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 072/156] ASoC: hdmi-codec: fix missing report for jack initial status
Date: Sat, 30 Dec 2023 11:58:46 +0000
Message-ID: <20231230115814.710168292@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
References: <20231230115812.333117904@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 025222a9d6d25eee2ad9a1bb5a8b29b34b5ba576 ]

This fixes a problem introduced while fixing ELD reporting with no jack
set.

Most driver using the hdmi-codec will call the 'plugged_cb' callback
directly when registered to report the initial state of the HDMI connector.

With the commit mentionned, this occurs before jack is ready and the
initial report is lost for platforms actually providing a jack for HDMI.

Fix this by storing the hdmi connector status regardless of jack being set
or not and report the last status when jack gets set.

With this, the initial state is reported correctly even if it is
disconnected. This was not done initially and is also a fix.

Fixes: 15be353d55f9 ("ASoC: hdmi-codec: register hpd callback on component probe")
Reported-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Closes: https://lore.kernel.org/alsa-devel/CADYyEwTNyY+fR9SgfDa-g6iiDwkU3MUdPVCYexs2_3wbcM8_vg@mail.gmail.com/
Cc: Hsin-Yi Wang <hsinyi@google.com>
Tested-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://msgid.link/r/20231218145655.134929-1-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 20da1eaa4f1c7..0938671700c62 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -850,8 +850,9 @@ static int hdmi_dai_probe(struct snd_soc_dai *dai)
 static void hdmi_codec_jack_report(struct hdmi_codec_priv *hcp,
 				   unsigned int jack_status)
 {
-	if (hcp->jack && jack_status != hcp->jack_status) {
-		snd_soc_jack_report(hcp->jack, jack_status, SND_JACK_LINEOUT);
+	if (jack_status != hcp->jack_status) {
+		if (hcp->jack)
+			snd_soc_jack_report(hcp->jack, jack_status, SND_JACK_LINEOUT);
 		hcp->jack_status = jack_status;
 	}
 }
@@ -880,6 +881,13 @@ static int hdmi_codec_set_jack(struct snd_soc_component *component,
 
 	if (hcp->hcd.ops->hook_plugged_cb) {
 		hcp->jack = jack;
+
+		/*
+		 * Report the initial jack status which may have been provided
+		 * by the parent hdmi driver while the hpd hook was registered.
+		 */
+		snd_soc_jack_report(jack, hcp->jack_status, SND_JACK_LINEOUT);
+
 		return 0;
 	}
 
-- 
2.43.0




