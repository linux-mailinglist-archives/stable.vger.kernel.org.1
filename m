Return-Path: <stable+bounces-25-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB547F5BA4
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 10:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F881C20DBE
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 09:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B10322304;
	Thu, 23 Nov 2023 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sX9JcuMX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B1421350;
	Thu, 23 Nov 2023 09:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8BAC433C9;
	Thu, 23 Nov 2023 09:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700732904;
	bh=hgdvnIPPccubzs/g8g1k94iDsPT4gPn3WhqGmyKIz/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=sX9JcuMXDY3YUOTcFYDBGux0YFcW90U71oN5fOTga/3Cr1pc9vi7HXbzDi6cPpJXn
	 I1nBnofehwbZwffToBqtvjgBL2TPIsFdgLC5XUTTnih0YAXJdNcBEcQMUEQqo1gOGb
	 o2+Q64yIEH5q9AiDBU4sb2tOpHFBHB7Yt2Jf6F2NEyl2Cn+1z3RP3iOP6lYFsinFlD
	 JBF9FKPF6zP8RZ85rkMTgoVAicxkEyQ+olwuSpjP1N39COnMvxJAAucnryBKTWpRB+
	 c2XxIJr1cCkd8we1AIv4QTjELF6i26ZyB3rCfbzj8OPbbrG2vT6HGampvAnjyAzsvC
	 LpMS5+sAKX+Bw==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1r66K9-0005KO-1m;
	Thu, 23 Nov 2023 10:48:41 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH stable-6.6 0/2] ASoC: codecs: wsa883x: fix pops and clicks
Date: Thu, 23 Nov 2023 10:47:47 +0100
Message-ID: <20231123094749.20462-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a backport of commits

	0220575e65a ("ASoC: soc-dai: add flag to mute and unmute stream during trigger")
	805ce81826c8 ("ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag")

which specifically fix a loud crackling noise when starting a stream on
the Lenovo ThinkPad X13s.

These backports should apply to any stable tree which already has commit
3efcb471f871 ("ASoC: soc-pcm.c: Make sure DAI parameters cleared if the
DAI becomes inactive") backported (e.g. 6.6.2 and 6.5.12).

Note that the interaction of these commits resulted in a bad merge in
mainline which is fixed up here:

	https://lore.kernel.org/lkml/20231123091815.21933-1-johan+linaro@kernel.org/

Johan


Srinivas Kandagatla (2):
  ASoC: soc-dai: add flag to mute and unmute stream during trigger
  ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag

 include/sound/soc-dai.h    |  1 +
 sound/soc/codecs/wsa883x.c |  7 +------
 sound/soc/soc-dai.c        |  7 +++++++
 sound/soc/soc-pcm.c        | 12 ++++++++----
 4 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.41.0


