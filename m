Return-Path: <stable+bounces-163367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E24B0A4B0
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 15:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F5016B3E5
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 13:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14772DAFC3;
	Fri, 18 Jul 2025 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net header.b="3E6a/UKX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GK+bzfbp"
X-Original-To: stable@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3007C1F949
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843734; cv=none; b=O70w8x9Y5r4gsxOBc3+ys5zt3NuBewp4+wJcdgqNyW+jQMOEgj7yYQv5Nj11t8eaukuKrargtZqK9hSCYkVRAH1zqgFhbdkNh1Vq6zzV4OSY9P2bwMk7EsHnA+X5IVxP6W90SHZ1BwQiB2QkhrWmgilpOtXYQUvHtdgTjTLqNyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843734; c=relaxed/simple;
	bh=ZQ9XfNSSAbv0K9iBQXCoD3fH+aBjKrL6RP86iJBXUCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grhISC4MsjYWhIutcLs3MDTcTEpod1k5QyhzE5NGgqQHFHUXjhr8wlC202bIt1WeUd4GtwZJXy7/fePTrHXEVG10xhU2QteKkj7VIkPOdofFyLSUEVRDoHAtVBYMlYBetbXZdkksMP+VtSPYZYoJgxDrRp/sdsv1ZX2QcoyBP5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arunraghavan.net; spf=pass smtp.mailfrom=arunraghavan.net; dkim=pass (2048-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net header.b=3E6a/UKX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GK+bzfbp; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arunraghavan.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arunraghavan.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4098FEC0174;
	Fri, 18 Jul 2025 09:02:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 18 Jul 2025 09:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	arunraghavan.net; h=cc:cc:content-transfer-encoding:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1752843731; x=1752930131; bh=EY2WRitYkVFFlIRh2ultlD8ch9PGvWZj
	Qd2LK/5qcW0=; b=3E6a/UKXc7QWY5AbzSMsj3NKUzTBp4ociG83VTwPSQsiKms/
	zgXJXRosRxfHmkpOUgPUYbXOY0yIUkGYH7zNQuOGZGL+dJWZ+GNAnnGe8HMEZk9O
	xNYg/J1ngFufdWcgM2wK+2Yo0wqxmDyuRTke4cgTEUshKdIBBNy9yFm6TbyupeOJ
	2I4r4DFzmbvqqGkDZYiaWHbeK3zoWpINweW921rnbQh5OkWWtw0qKoWoEvUKLKDH
	Z/cTLbPOVaPSCk+ONjb3cvBnP1NXydHSvXnfNl2/7gIZQ1r+bqBDBH0xjNwfHH0E
	Kv7Yj8T1BHZghYpaoWbX11VhA/NtlCIyAj0q0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1752843731; x=1752930131; bh=E
	Y2WRitYkVFFlIRh2ultlD8ch9PGvWZjQd2LK/5qcW0=; b=GK+bzfbp/obOenCoJ
	FsDIh96+Wud/Ko4s/okuI+FzSbTYyriqxURAWh3bvYnkNRwyT3M+LAiujZsk84mD
	zH0Y+1ZH7B/O87j/dMaZXOD0P39iGQk3E+9y+8IvbIBv8r8YAgCC0lawAMihiN6+
	sQQBWAdoao4r6NqbXE55Vbm5ZfftaQ1IOlx1Vq7ETkoxLh9Eba0+ogZcd26QJCTH
	x6VM7g6bBBeYQg1O/aDtov8U/Id56eIR3tkBZjEdNGDbmXDUNOY/ic+bcs/c7JwH
	j3Ok5Dp/WcqiY2QANEKsEpTtQ0MvTF8xRa1W7c7dudyAzhRy0HxYDOkB+FUTWGz4
	YZGPw==
X-ME-Sender: <xms:0kV6aKUeXk4wNe91zvPdyS6IFACtFZxEnhYrDzkwcRLEEHHBGCH4Pw>
    <xme:0kV6aCHdyeboJjlbYV_rhZOTbBEgl-c1cvPoKR5SGGxe_Ex1YFL6N8paGd3hOfuxP
    A9HI5LlSg15DFHxUw>
X-ME-Received: <xmr:0kV6aE33q551tv12UA4Y-TElbeDaktMtu6arrwfFl6z4wDjyXkZUtgCl-F31wQrrVDYqBi-3GkjUEtitg4QwjwMpHyNvjbd7SBnFTPJwakzwbPi7aW2JWujvdPqy2gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeifeehvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:0kV6aMM2eQX5WBOeuC9BHnZRbtg8nGBJJ2ymbmGqnajr54KXjnynfw>
    <xmx:0kV6aL7cj9W_rBmIgGyn1MjdJvKAqL_p5qu7_p125QU51KaDc8Oahw>
    <xmx:0kV6aO349MdmNZmc5j7LQKvwv0w2zwwHJ-NYSMwwx0f_v_5QqAN0eg>
    <xmx:0kV6aEws4DI_d5zf5nTHQyp-iSJovj5VSmNgIHgysZvn62_u5hwGtA>
    <xmx:00V6aA2pToOqWcohHsK4m7S8TMwHnKZgoK0LoqleYhBjmWM7R5PQEPFL>
Feedback-ID: i42c0435e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 09:02:10 -0400 (EDT)
From: Arun Raghavan <arun@arunraghavan.net>
To: stable@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>,
	Pieterjan Camerlynck <p.camerlynck@televic.com>,
	Fabio Estevam <festevam@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1.y] ASoC: fsl_sai: Force a software reset when starting in consumer mode
Date: Fri, 18 Jul 2025 09:02:01 -0400
Message-ID: <20250718130201.576416-1-arun@arunraghavan.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025071257-utility-ungodly-5f38@gregkh>
References: <2025071257-utility-ungodly-5f38@gregkh>
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
index 4b155e49cbfc..27ad825c78f2 100644
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


