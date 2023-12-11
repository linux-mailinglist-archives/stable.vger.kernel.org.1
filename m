Return-Path: <stable+bounces-5490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D05880CCC2
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 15:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC410281A69
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B81D482E5;
	Mon, 11 Dec 2023 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBSpkhb/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFC848793;
	Mon, 11 Dec 2023 14:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3E5C433D9;
	Mon, 11 Dec 2023 14:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702303400;
	bh=Kb/hCA/NNWuX7ifXJpNPrwb6MlLuVpbHeb9xqr+8iZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dBSpkhb/wRT9Xz2AYhtZ26I1ApTml2JsKHSxzocrQnaSJ2SogV2fk7LZh0UtLiXLO
	 1UoVKViztPOs9pD4kFkDkTQEZt7/YH1bfQLu3r7EoI/ENOhpXvKtew5T1lmU13v2Oq
	 GOrzQy45pk1tQWZ278WnyMONjXazNiinW2pFC0trxbyzW5SrSBLsQ6rBI7hRfqucNq
	 7aifXn7/+3gdxCNfXViAAcBG5XYFWFrVgXmf+JHmytCnNBtxT4sBSfdcYzdfzeNyNQ
	 BDWXnQqprQFVxaAlyG/ORs7dkrTFJq5tdQ+FM39IEy6tnzAF3LO4X4IyNV1eEuvMBC
	 SUADBGL9nCdbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Rau <David.Rau.opensource@dm.renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	support.opensource@diasemi.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 4/5] ASoC: da7219: Support low DC impedance headset
Date: Mon, 11 Dec 2023 09:03:09 -0500
Message-ID: <20231211140311.392827-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211140311.392827-1-sashal@kernel.org>
References: <20231211140311.392827-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.332
Content-Transfer-Encoding: 8bit

From: David Rau <David.Rau.opensource@dm.renesas.com>

[ Upstream commit 5f44de697383fcc9a9a1a78f99e09d1838704b90 ]

Change the default MIC detection impedance threshold to 200ohm
to support low mic DC impedance headset.

Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
Link: https://lore.kernel.org/r/20231201042933.26392-1-David.Rau.opensource@dm.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/da7219-aad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 793c8768f7c44..5a31a4db1e23a 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -650,7 +650,7 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct snd_soc_codec *cod
 		aad_pdata->mic_det_thr =
 			da7219_aad_fw_mic_det_thr(codec, fw_val32);
 	else
-		aad_pdata->mic_det_thr = DA7219_AAD_MIC_DET_THR_500_OHMS;
+		aad_pdata->mic_det_thr = DA7219_AAD_MIC_DET_THR_200_OHMS;
 
 	if (fwnode_property_read_u32(aad_np, "dlg,jack-ins-deb", &fw_val32) >= 0)
 		aad_pdata->jack_ins_deb =
-- 
2.42.0


