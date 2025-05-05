Return-Path: <stable+bounces-140350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49450AAA7EF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B13D987EAE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5DC33FD95;
	Mon,  5 May 2025 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VanjSCLR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7FE33FD8F;
	Mon,  5 May 2025 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484677; cv=none; b=Mjly9cYBF0QX4kaDxY5LJ2+62T6mIQOX3aC+valFWkCHLIWdDmO1fYgYXDRdelc7dB7SCRzrUGZWQ3Jk2Tk94491kj5om3vWNKeUzC7Op1ydhhFVb1aEvPKxZRIlFiTb4wWldOmi47x4GcM95aGQzFfqmp/3THzjDmKE17GstLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484677; c=relaxed/simple;
	bh=HjNB+8AM96Z+ZemBOMVtBTLcrRMw83gjifHftvtdS8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M4cckBiGe4AXOlNwKUoa6vXYsGYq67AAjt7Ptz41oTuHsBfCOPSscwMGqdt6GrG5tikPN+PJNKfH1GueKbEwZ73yNeb51825mIeIBYrVPmy+QtXb/X6H9AYeMg89+bPyS0f5uD76Zc4Rnanc1wE82J7qY5190eroCAo2pCtu5uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VanjSCLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D308DC4CEE4;
	Mon,  5 May 2025 22:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484676;
	bh=HjNB+8AM96Z+ZemBOMVtBTLcrRMw83gjifHftvtdS8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VanjSCLR2vttdDMLXCYhWYCUoSciQwMnwUCQq04zHXVcrR0N6CleY2p+/7zyRkTcP
	 x7hIME94DFOfFvIn8pGlMHbObL0ml3nJSjYIlJLbBmxyJgJIoquC5UjyX555dqkXTz
	 P8pZhZFy3ta4pwNbm7leBR2MbE3RggVvVSq47LsKf/b8FKMWIq1kyhAf1XCpp5oIsG
	 nvHX6RAU9BuYhwIov2qnftdXNQUQWTbEdOhoG2g8j7uuPC6TCsv/1nuFkLfVN1jpTN
	 FpA/xNyOji4YybkwtwNOAoLkItZ/DCo7xwofBsqxcROgJXbV3B64UuccIlWXaMkpSH
	 829/CgQulpHsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Olivier Moysan <olivier.moysan@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	lgirdwood@gmail.com,
	lumag@kernel.org,
	christianshewitt@gmail.com,
	kuninori.morimoto.gx@renesas.com,
	herve.codina@bootlin.com,
	jonas@kwiboo.se,
	krzysztof.kozlowski@linaro.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 601/642] ASoC: hdmi-codec: allow to refine formats actually supported
Date: Mon,  5 May 2025 18:13:37 -0400
Message-Id: <20250505221419.2672473-601-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Olivier Moysan <olivier.moysan@foss.st.com>

[ Upstream commit 038f79638e0676359e44c5db458d52994f9b5ac1 ]

Currently the hdmi-codec driver registers all the formats that are
allowed on the I2S bus. Add i2s_formats field to codec data, to allow
the hdmi codec client to refine the list of the audio I2S formats
actually supported.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20250108170356.413063-3-olivier.moysan@foss.st.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/hdmi-codec.h    | 1 +
 sound/soc/codecs/hdmi-codec.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
index b220072cfa1ba..273f4c36fad98 100644
--- a/include/sound/hdmi-codec.h
+++ b/include/sound/hdmi-codec.h
@@ -120,6 +120,7 @@ struct hdmi_codec_ops {
 /* HDMI codec initalization data */
 struct hdmi_codec_pdata {
 	const struct hdmi_codec_ops *ops;
+	u64 i2s_formats;
 	uint i2s:1;
 	uint no_i2s_playback:1;
 	uint no_i2s_capture:1;
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 69f98975e14ae..5c47aa0551c94 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -1077,6 +1077,10 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 	if (hcd->i2s) {
 		daidrv[i] = hdmi_i2s_dai;
 		daidrv[i].playback.channels_max = hcd->max_i2s_channels;
+		if (hcd->i2s_formats) {
+			daidrv[i].playback.formats = hcd->i2s_formats;
+			daidrv[i].capture.formats = hcd->i2s_formats;
+		}
 		if (hcd->no_i2s_playback)
 			memset(&daidrv[i].playback, 0,
 			       sizeof(daidrv[i].playback));
-- 
2.39.5


