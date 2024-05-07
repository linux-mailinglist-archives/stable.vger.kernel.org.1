Return-Path: <stable+bounces-43428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849A48BF2B2
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB84B214D0
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867497FBAA;
	Tue,  7 May 2024 23:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDiAPoN2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F53145A0E;
	Tue,  7 May 2024 23:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123671; cv=none; b=kl18TT/GGrznYVBL6RcvYvzELPxaZKiIOuP0cY5clmhquZapYiVw74HghiS6h85Hyvbeh09oC1NVdNzLPNb3wBA69zDnogf+OXjX9gSio2Nz1+CMTfiMedrDcd6h28PKW9xQb6s+qRfw0T054ddhr8zvWs2xNNBXCFy7xNSoLPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123671; c=relaxed/simple;
	bh=0pkPt6yv9+tJzC4Rcu3b5OOqmxhlMgZFYdrw9FZDN14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eAWVj84SmE/rEP8h2r5Tpe40NOQvQNPNfAS4/2GgO9kltkR60a+Vp8V9d2gjHSTKZoKUK66QEpQTa3A4Aw+j0sdNp+58aG7RodpW7BZWEYUgZ+SLXZUQTtaDlDVlJOPV8ccwNP6/df+AlRfEDi6AXjRVrwax6MoflvP/BKABgS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDiAPoN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662A5C2BBFC;
	Tue,  7 May 2024 23:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123671;
	bh=0pkPt6yv9+tJzC4Rcu3b5OOqmxhlMgZFYdrw9FZDN14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDiAPoN2uiRcB+3Yjzbr4gjnb3NNINM9GIUeBIzAIuw/RUO5HYO1+2KmTA+lcLzNG
	 q7eBN1+yx1tmOF3ZxTL7of0VZnTDWCeC/4EKWazORP1UldwRb9AVNHpRkkkPX6rEAV
	 VFZUdIWlGhdJaBvLBMHpAALcLGGn+euwLMzLvBullahE4njnoANzJ3zac4EE00eEgl
	 Fy0QlIhtxnTbFjmJG1pRCXjNJPiNevTaFI6JWe40K3BU/OlxC2DBrpPx138Sjoqfp3
	 2lqX0io894ULtbMjxAtixVU1D+TFEKm3cDfsU5WBtNapH1z9/EZf4gYNYJcSz/0Cef
	 LgUHq09C21QPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	support.opensource@diasemi.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 4/6] ASoC: da7219-aad: fix usage of device_get_named_child_node()
Date: Tue,  7 May 2024 19:14:20 -0400
Message-ID: <20240507231424.395315-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231424.395315-1-sashal@kernel.org>
References: <20240507231424.395315-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.275
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit e8a6a5ad73acbafd98e8fd3f0cbf6e379771bb76 ]

The documentation for device_get_named_child_node() mentions this
important point:

"
The caller is responsible for calling fwnode_handle_put() on the
returned fwnode pointer.
"

Add fwnode_handle_put() to avoid a leaked reference.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20240426153033.38500-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/da7219-aad.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index e4e314604c0a1..06caca22a55a0 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -630,8 +630,10 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct snd_soc_component
 		return NULL;
 
 	aad_pdata = devm_kzalloc(dev, sizeof(*aad_pdata), GFP_KERNEL);
-	if (!aad_pdata)
+	if (!aad_pdata) {
+		fwnode_handle_put(aad_np);
 		return NULL;
+	}
 
 	aad_pdata->irq = i2c->irq;
 
@@ -706,6 +708,8 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct snd_soc_component
 	else
 		aad_pdata->adc_1bit_rpt = DA7219_AAD_ADC_1BIT_RPT_1;
 
+	fwnode_handle_put(aad_np);
+
 	return aad_pdata;
 }
 
-- 
2.43.0


