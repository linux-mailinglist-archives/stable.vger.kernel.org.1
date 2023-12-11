Return-Path: <stable+bounces-5457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D8980CC76
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 15:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A661C211F1
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B569482E7;
	Mon, 11 Dec 2023 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AF3aoQqh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B7482D2;
	Mon, 11 Dec 2023 14:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A547C433CA;
	Mon, 11 Dec 2023 14:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702303300;
	bh=uNrzFIHW5arvNF8Q+6qd4P78lIhkuakWAiBbRtTZw5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AF3aoQqhQZtmegR62jvgNQMSYr1C6S/U6TNYWRsv5zIlcO1ytd/X7x33X3KRpKZhy
	 Wvcju5ARmVAvuUplhkOkWKHZESpge81ctPv+MAqu4I1O3EfVD98vhyQ1lvOpEjQ4JW
	 XnbOEhbTyZ1JrmdrJyUdCoi5i6tKKPAFROgXlAzTecuIKmILEZjFfKp8Yi3nj5mEsK
	 JzwO/E1rSKSPCeEev+kbkK9qMLNtUmIX+4v4bT4o0olO4AI/iaObHzabx2kWLKRIze
	 l5SAxwM0/fizDr/MEc1ye9Ga0JoZodq//ZWB3r/thKLNkXMmlUf3Rrx/BqI9XE70v4
	 9zZbZ8vQYeZoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 06/16] ASoC: cs43130: Fix incorrect frame delay configuration
Date: Mon, 11 Dec 2023 09:00:30 -0500
Message-ID: <20231211140116.391986-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211140116.391986-1-sashal@kernel.org>
References: <20231211140116.391986-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.203
Content-Transfer-Encoding: 8bit

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

[ Upstream commit aa7e8e5e4011571022dc06e4d7a2f108feb53d1a ]

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20231117141344.64320-3-mstrozek@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs43130.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 285806868c405..02fb9317b6970 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -578,7 +578,7 @@ static int cs43130_set_sp_fmt(int dai_id, unsigned int bitwidth_sclk,
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		hi_size = bitwidth_sclk;
-		frm_delay = 2;
+		frm_delay = 0;
 		frm_phase = 1;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
-- 
2.42.0


