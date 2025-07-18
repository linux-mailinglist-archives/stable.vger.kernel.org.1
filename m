Return-Path: <stable+bounces-163370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71418B0A4EE
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 15:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F251160B04
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 13:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72579292B29;
	Fri, 18 Jul 2025 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net header.b="rNchnZcC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FFhQ/WzB"
X-Original-To: stable@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BE42E370B
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752844687; cv=none; b=R6b7Nc1HBiMitHUFP+QuAaGjkI/nQ49ShTuh8CfhQD5XJgrc3NW4VUCMWYLSah9WFbU0PBODflI1szGK9rKhlOcopqUAVHQgNA156hoxScTj2pPUw8DefcQdyDgcA8aAUBAf03lzpNMb255nQXc7K3aN6eyE+KcTIpaUScV2bN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752844687; c=relaxed/simple;
	bh=aS+dVxV7qSmkpZJfkVs1xCsjNSD0kx/wCILwxQNeg3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwtfvN1Tpfpz1As0RbFCve6VrgivtsInlxWV5qo7g2bUSWs5mXtM/GfNUNiBXYXgVgBZrP2AilTm1iH+t91I2thDk+CNWzT3oa3seJJ8YA2WKOp7UCptzV32704efEYuNY4+dsRKjNT+gijMLQwHM63ZTmhwyVenQLBQcLxIdOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arunraghavan.net; spf=pass smtp.mailfrom=arunraghavan.net; dkim=pass (2048-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net header.b=rNchnZcC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FFhQ/WzB; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arunraghavan.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arunraghavan.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1CBFCEC0120;
	Fri, 18 Jul 2025 09:18:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 18 Jul 2025 09:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	arunraghavan.net; h=cc:cc:content-transfer-encoding:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1752844684; x=1752931084; bh=YxxqMKo9mKJmbqvJyTp1Z68oulbwHvOZ
	T7XX2pOCX6g=; b=rNchnZcCwzQJ+VngmOIfO035LFUwCiuxxYKgpaOjh8WGK7lQ
	NfiSLRjDyueV2rVdVPIdOEG1r2SRFrFe0SqNXXQyg3JAfVdz5KRydVx8BtxP2Uq7
	6L8mzHw9OuQ8ZbTUDzpfmXycb/fyt35qb3lGTnDBkulPQGpjTIiyyMAuGYCmElmO
	IOLwQg2WyfgkAarlHzXdxngD9tjKSmi4uzXVjlFH3D06dozvtMsLSd0/jdWVlwyf
	sZydPeIyV09yugO9eO0oBzv77snDr9u7jDFsY6RPHYjZvjQc3Bw19KHEPCqxxpFD
	8Zv4r+rLBqlYhSYH2YxMdRvjgtcAjT57W83f1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1752844684; x=1752931084; bh=Y
	xxqMKo9mKJmbqvJyTp1Z68oulbwHvOZT7XX2pOCX6g=; b=FFhQ/WzBKgQe/GJGA
	KWLV+Pe6QgCd4yG0guBDAhdGbA0zYTgcCJ6VIvj+U7V2Ri/N/Q/2DTAMrKcdHJLZ
	l2gXTe+lDgjn4FFRMVF+n7CaWNoLneTvNwaBp5e9XGGd0DgjZ/BAfd9gcqlL3ZDx
	e+peSv+degN+IXUuhaoMHb21dAm7fcbAqwLloDDOKILwBaiJHFjp3nguhJ2EPnhj
	toTBwxCBLX0C0f9HHuWVowZVshh09/f47xGsT+YrNXctLU8czUQFXwSoTdUNBg3/
	NaT9Zcj2ls2W1ZfL40dLqvruleKygPQL1nHHvMo/+gnvQgqho0B5VDwAv9JR0e6Z
	hP5aQ==
X-ME-Sender: <xms:i0l6aCdn0F8YJWtCd868qqbc1LjLEHBtpsElyuYLBC2Yy2rV7DuNRA>
    <xme:i0l6aHuIb5XeZIXhby2Kyl5lha4Gj9TaRLEfBh170bXsy6HZd7_-gzMY6nvdHJp8B
    BQW_1k2o_b58uUR6w>
X-ME-Received: <xmr:i0l6aJ_IINbHx6nFQd2YzX_wdPFPpmYcqA5Uj8NP4YlsXeXQwZCz2shmqVUtkU80>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeifeehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetrhhunhcutfgr
    ghhhrghvrghnuceorghruhhnsegrrhhunhhrrghghhgrvhgrnhdrnhgvtheqnecuggftrf
    grthhtvghrnhepffekgeffveeuhfekffetudejgeegieeuheejffehvdefheeiiedtgfel
    jeejvddunecuffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhunhesrghruhhnrhgrghhhrghv
    rghnrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
    rhhunhesrghshihmphhtohhtihgtrdhiohdprhgtphhtthhopehprdgtrghmvghrlhihnh
    gtkhesthgvlhgvvhhitgdrtghomhdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghi
    lhdrtghomhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:i0l6aK0C3qmMvQmc6ay9U-6Z0o2oVxs_lHiXb4ceb4yQXNLfbQLMsQ>
    <xmx:i0l6aGDrZktveOtDoX1FZQJqrxeNa_nHbzUg36neJS67XCBRQecewg>
    <xmx:i0l6aOe_AyXKDc4T6qDAd7UldYxtnldCf2CU00d0Y5JCHrrvMoqCpw>
    <xmx:i0l6aL6AZ1OTBg-ZFlQia-6x_A0hz2Tsrn3Tl1rAfy1pig82sDMIKw>
    <xmx:jEl6aO-Nu_gjSM0Tq5HA85heUPrPzfgSyaxdRKXkhWf0t21AsNzoQaNK>
Feedback-ID: i42c0435e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 09:18:03 -0400 (EDT)
From: Arun Raghavan <arun@arunraghavan.net>
To: stable@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>,
	Pieterjan Camerlynck <p.camerlynck@televic.com>,
	Fabio Estevam <festevam@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.10.y] ASoC: fsl_sai: Force a software reset when starting in consumer mode
Date: Fri, 18 Jul 2025 09:17:59 -0400
Message-ID: <20250718131759.641179-1-arun@arunraghavan.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025071258-retiring-unspoken-567d@gregkh>
References: <2025071258-retiring-unspoken-567d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arun Raghavan <arun@asymptotic.io>

commit dc78f7e59169d3f0e6c3c95d23dc8e55e95741e2 upstream.

On an imx8mm platform with an external clock provider, when running the
receiver (arecord) and triggering an xrun with xrun_injection, we see a
channel swap/offset. This happens sometimes when running only the
receiver, but occurs reliably if a transmitter (aplay) is also
concurrently running.

It seems that the SAI loses track of frame sync during the trigger stop
-> trigger start cycle that occurs during an xrun. Doing just a FIFO
reset in this case does not suffice, and only a software reset seems to
get it back on track.

This looks like the same h/w bug that is already handled for the
producer case, so we now do the reset unconditionally on config disable.

Signed-off-by: Arun Raghavan <arun@asymptotic.io>
Reported-by: Pieterjan Camerlynck <p.camerlynck@televic.com>
Fixes: 3e3f8bd56955 ("ASoC: fsl_sai: fix no frame clk in master mode")
Cc: stable@vger.kernel.org
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Link: https://patch.msgid.link/20250626130858.163825-1-arun@arunraghavan.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 998102711da0..d81a9322b03d 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -572,13 +572,15 @@ static void fsl_sai_config_disable(struct fsl_sai *sai, int dir)
 	 * anymore. Add software reset to fix this issue.
 	 * This is a hardware bug, and will be fix in the
 	 * next sai version.
+	 *
+	 * In consumer mode, this can happen even after a
+	 * single open/close, especially if both tx and rx
+	 * are running concurrently.
 	 */
-	if (!sai->is_slave_mode) {
-		/* Software Reset */
-		regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), FSL_SAI_CSR_SR);
-		/* Clear SR bit to finish the reset */
-		regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), 0);
-	}
+	/* Software Reset */
+	regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), FSL_SAI_CSR_SR);
+	/* Clear SR bit to finish the reset */
+	regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), 0);
 }
 
 static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
-- 
2.50.1


