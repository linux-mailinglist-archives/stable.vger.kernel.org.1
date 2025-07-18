Return-Path: <stable+bounces-163364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C23B0A480
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 14:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD385C03ED
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 12:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879292D6624;
	Fri, 18 Jul 2025 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net header.b="jNF1GT8/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QjrX3PhD"
X-Original-To: stable@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BD52DBF4B
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843283; cv=none; b=nw4GoANCSH/JfMLfZ46y9QIXZY2JI5fsWL3TIgR1QAFsextyvJUTXON4pTjsIxIBzORTslZjInamS5shBGKsRBvHH4yR4xb5eVQn5xT+is2Ei2mFj6Ff8Tb6s2DUdePYtFeEtzXMGAT1/YfpZE2nhYpFDMzG5+wn9CAsAxFc0+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843283; c=relaxed/simple;
	bh=nyA5BiB/R5yOIjMjIzLrna8mcePLLJT28p8gFQrTzaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myVun9u7YLmRf8ePPXAn1eutrtklIVOXNQJcj1O7UmgEMvz4CtF2uz0mHN+XdoYwbaOoUyBP6Hnr4dv95uF0le58l2r526N+s80XZ0LKxw9GMnbglTOOlKFtr4dfqEGVRWyFFHa42QzfzELppy9sGEjzWnIXTfkwkrpAAmrec7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arunraghavan.net; spf=pass smtp.mailfrom=arunraghavan.net; dkim=pass (2048-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net header.b=jNF1GT8/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QjrX3PhD; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arunraghavan.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arunraghavan.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B0A6CEC00EA;
	Fri, 18 Jul 2025 08:54:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 18 Jul 2025 08:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	arunraghavan.net; h=cc:cc:content-transfer-encoding:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1752843279; x=1752929679; bh=niMvncM+0o3bIQeMo8pB7FYnkNktl6un
	phRRVnQceks=; b=jNF1GT8/ooQhVCtrJvIyp3+06Kke8aWxnVOQ970HwiaHo7Ry
	zOMoLKW2vmwWP2y1j+pq4DIPNYsuiBbeZW2HyZtI/rKdqDL80iYEn23yP+31CqtC
	uDg/DCtKrx35vwkp4C8rf6sRnqJqTlNeGWMOroQTFU5BkvXG0bm1YJjAzv+VA92Q
	QHCJEjQVV2JRruJO+yCFgifqTGnE0GUCU3qwkZ0Qf9t6wsiWcNRFAPYL38f/Vmkq
	/8cIjM9tbN+bJFoUiB2k0oh2WbfEZ9z04FKXSI9r8J7Fn23EAE76zk7S76JU3PYo
	PN6AiU0S5MoPC/xMb1INuVXb5MJ/AO5jnqCWpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1752843279; x=1752929679; bh=n
	iMvncM+0o3bIQeMo8pB7FYnkNktl6unphRRVnQceks=; b=QjrX3PhDGKBXDZiPy
	y9u9MT6/2bg4g8stEZKmdyDTIPrn24TybdntFg7kXalCJTQN9YjwDnSzvg6H+s6e
	5pdqcPf8aHC0VkXHU77Ydxwol1Wlxx2IlhaUJpzPscyyA2/p9MKYoXh3LUNX64iY
	2n1w/U6H3A09NzWPUt46KeaNyFp/4tj5/HdVfwpmmUAVnr+dnVdfMG0HYhskhukU
	Zk6yST+xwmh4rbrb7HwPLPdmtqvZ3XwBBS/n446qemn3f+Wq/2SDR8nGAL65aWgC
	no8mEYyTci9aiSV5xuXqOHGRcfEM4bKmO2nUydIszxty4uyOL7fwpgRibf3uGq18
	f7FIg==
X-ME-Sender: <xms:D0R6aEKFevVhQ0uDhL5PWKpw2Q4hm8G3ptK-8Wtn3hrAiZFEvkrN1w>
    <xme:D0R6aPqbzlCXRsAZ6W_CSznsIlr0O2wuY4MVCjcBX-Yip-WzGCHdaKgD9A0ZgqEyX
    LIR1i0kdA7SFt9OdA>
X-ME-Received: <xmr:D0R6aLIvNCR64LC3lcwR3lV-AxCFEI-hCbED8RgtHhHGLnMuiKENjylvwXILhH1u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeifeehtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:D0R6aMT3P9avFlDebV72PVmX4ICI3x8TKnV6uOWKjZr2v8iVuMuxEg>
    <xmx:D0R6aCvwghbp6aSoKJ97SznJ4rpnESavxoeGF3-r3XCchevUgBjPqg>
    <xmx:D0R6aFYsZEGw_rVYOrDxMhXDntsZcYXdpjPXgImhGJyKUuoZsWQl1A>
    <xmx:D0R6aAFmNULP1xgOur_9UX8LkCHe2g5CtDZ1NGlJ5vfBWTNKKdB1tw>
    <xmx:D0R6aBqH0Ur42peol9MkeduvtR2mxrweoNnsl4qZ7Im5YCKUNcntgPBd>
Feedback-ID: i42c0435e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 08:54:38 -0400 (EDT)
From: Arun Raghavan <arun@arunraghavan.net>
To: stable@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>,
	Pieterjan Camerlynck <p.camerlynck@televic.com>,
	Fabio Estevam <festevam@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.6.y] ASoC: fsl_sai: Force a software reset when starting in consumer mode
Date: Fri, 18 Jul 2025 08:54:21 -0400
Message-ID: <20250718125421.532335-1-arun@arunraghavan.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025071256-clobber-annotate-b978@gregkh>
References: <2025071256-clobber-annotate-b978@gregkh>
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
index aa15f56ca139..886f5c29939b 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -762,13 +762,15 @@ static void fsl_sai_config_disable(struct fsl_sai *sai, int dir)
 	 * anymore. Add software reset to fix this issue.
 	 * This is a hardware bug, and will be fix in the
 	 * next sai version.
+	 *
+	 * In consumer mode, this can happen even after a
+	 * single open/close, especially if both tx and rx
+	 * are running concurrently.
 	 */
-	if (!sai->is_consumer_mode) {
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


