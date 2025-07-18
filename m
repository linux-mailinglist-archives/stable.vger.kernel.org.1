Return-Path: <stable+bounces-163371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E320B0A51F
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 15:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 791867BE00B
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 13:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC232D979C;
	Fri, 18 Jul 2025 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net header.b="x6flhF+/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QfvGuKND"
X-Original-To: stable@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0642DCBF3
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845191; cv=none; b=C0T4GQwDTy+W7t+WgWn+p2HPVY7WCntgJ2lon5fmyBUkV1/XgNl2zAAoanJwvttDNbyXCDFVFx6EgX84mWxPDAZfvyjEkfGLg4uZkA0ONwR1hLLIdT52LKnzYWL25+V6Ubk4NYCLCw5epcrrWiJ5tkR2NvRqoDPNZEx2+GjbEjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845191; c=relaxed/simple;
	bh=uPLnPtkpaHHQU7F3hx1mNrxl6Ln/0aR8+cLmMQ5FEzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWp6zqk8sr/iutn6SWKk3GJjjastEPmO2e+QuzCcVJiEUJIjjC+9SAsWuXBUXTGrBmopMARmTOCFHOHU4z2RJB4wljdeY6A4eD+7Vre7/s7iaUP4febisHj1RiNc/g7kF6/ld6966Y7yuQToyklJtdp+PhgCUIO5esSCKvI866A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arunraghavan.net; spf=pass smtp.mailfrom=arunraghavan.net; dkim=pass (2048-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net header.b=x6flhF+/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QfvGuKND; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arunraghavan.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arunraghavan.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 62682EC0120;
	Fri, 18 Jul 2025 09:26:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 18 Jul 2025 09:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	arunraghavan.net; h=cc:cc:content-transfer-encoding:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1752845188; x=1752931588; bh=Hz9CQ1XEXu6z0nqJPB7i71GCqpEmu3RM
	Ft3mPhhk9NU=; b=x6flhF+/zhtVw+Cd4335MGFx9ezxrGbmsl8msN2nm4UBSfYA
	ch14hXoPV41U1+lKI+0n7cjcQ7wxelBNdDmbuXJSes+Qs7o2LDawp3cSbqrL3HFP
	Z9wnP4WLyYj1JrddJ6oXU8TF+cc6UiO3+n2aCtSbwL9CykhKQiba5DM0Zb5/IdpT
	sqtEjLTUi/wbCNPkysw6CZpkbsoMdXk6hb8dzM8ZtgOTARgqQ7DVU/7RKwtXLxUl
	+4NJnsR48yXjYASR/ocN5RFypFVrerkT+qiOSFKHer8dec57WnuvtYKXYoPaYDBd
	NQ4sUbg3WcXkeXu85CfEroa+LnOz+X488NpMLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1752845188; x=1752931588; bh=H
	z9CQ1XEXu6z0nqJPB7i71GCqpEmu3RMFt3mPhhk9NU=; b=QfvGuKNDYM2STt4O+
	lxV4MOR8Xngv9oV0Xa87N74MWoMtz5PNIZQ9ss1l5qoEmEzL8ryBpNIa68Be21pt
	14Db6rRVKtL+Ma2d7+CrJ4LXgCGh2p4QuCV9E4HKWTjeyb4UHUl8LgW7YvgxP/8s
	JYLcoihmzJwFo7ssvFOFAYaq5n6dquGEw+XNFS79UCss9QFmwhUE/+G1IuhuDf5W
	TC1TZddNbwCLLK49iFqyZOzM3NfzFIESypCh+CLdfyUWDAULODtS+5ZB2GA244+H
	o7upfwuaNtQ4ReMBqst7VQMcg/7ZkACJl2UMtdn8ahl94oilUPfP9VTm9kY/60TQ
	LmxCg==
X-ME-Sender: <xms:hEt6aFpoX2V2oKp0diRFY1Gfn2Mw2WYprZ1BSwS7NCyy_w_udNXudA>
    <xme:hEt6aDLdasMnbFAo_LvBKnnLpGYpyxkl9GzPlzhH27bIp0foSYANXd3WWSjPadzhL
    esNtz5P_Uk8Rdt3EA>
X-ME-Received: <xmr:hEt6aIpE9ALRud9TKm9G3WiaAaZuM8PHT5OCnjqC3GYFsCOPsmNNaj0OnkplDEUb0_Y97q3c117uV5t2bLCitL3MVAN4nPnEhrA893WPxyMrOvwuB0wQdDmoBIAPbx0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeifeehkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:hEt6aLzn4sct95su-mJ24OzCAJA1YFAMAPZvpNMkCADPflDMCcof0g>
    <xmx:hEt6aMPsG6UjYQsXn4vQomPU93TrGW4M93j7uRZuBP6OSmhl_ydfOw>
    <xmx:hEt6aA5JmBfzpu0iYv3fkoqFef-auJqRB_OcIbuCH47P6EJYf6825w>
    <xmx:hEt6aFnw0lEMLpJcdQ0xleAwZyQLY9Q0YPzJ3fsWyBFNuNU0r1m_KA>
    <xmx:hEt6aLIuN73pHxmN1pTmqtTqYp4M55eBnO7gmjMo3JedTnqOBDcDiDRw>
Feedback-ID: i42c0435e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 09:26:27 -0400 (EDT)
From: Arun Raghavan <arun@arunraghavan.net>
To: stable@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>,
	Pieterjan Camerlynck <p.camerlynck@televic.com>,
	Fabio Estevam <festevam@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4.y] ASoC: fsl_sai: Force a software reset when starting in consumer mode
Date: Fri, 18 Jul 2025 09:26:25 -0400
Message-ID: <20250718132625.670333-1-arun@arunraghavan.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025071259-appendage-epidemic-aae1@gregkh>
References: <2025071259-appendage-epidemic-aae1@gregkh>
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
index fdbfaedda4ce..219c4133d26e 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -565,13 +565,15 @@ static void fsl_sai_config_disable(struct fsl_sai *sai, int dir)
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


