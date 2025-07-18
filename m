Return-Path: <stable+bounces-163368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32546B0A4DA
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 15:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22AB37A30FA
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457B42DBF69;
	Fri, 18 Jul 2025 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net header.b="BoIRQ1qk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="htV0KDgV"
X-Original-To: stable@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CCC2DBF47
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752844199; cv=none; b=QX6eewoSvDu/XeShG/mSCR65FYs0Wv7HewBDgA6c3AeReR1JfDOdErNpmILgtKf6Vf6E0MMp7lEyBZUtQ7Oss+6Ntiwa423PFdfhT4eHdD8OaJQc1uicdOnTZaDn0EwYCpvvcFPFkaHXo4CIywfxOH+Zze2qv7hP3Dej6bUpUDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752844199; c=relaxed/simple;
	bh=4xQLWSrCB7BWKgHVf1VWM1FBYV1zzFAcKhahgr+DqkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZ77VeoZBDXhjjMplq9kPos85GdPRTFPudl4PshAoPjujFX9cSN0ufM7i2Y6w820uikNUW2OXeGYFYr/qfxSvBj6GVRrUEN5QHB/h6+ELApTjhkd/Yz4g4raXdUMMiBKQDJE6gu8WLbJPbR+5xctS7wYR3tXi4dPOGcI3ZFx7ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arunraghavan.net; spf=pass smtp.mailfrom=arunraghavan.net; dkim=pass (2048-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net header.b=BoIRQ1qk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=htV0KDgV; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arunraghavan.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arunraghavan.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C1CEEEC0190;
	Fri, 18 Jul 2025 09:09:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 18 Jul 2025 09:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	arunraghavan.net; h=cc:cc:content-transfer-encoding:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1752844195; x=1752930595; bh=+MxrVRLlqXL7WKutiapfjGCxQRS8lmkR
	c4oB0XUB8u8=; b=BoIRQ1qk97zMPweFQW1oIhR+MEpLS7TuU4ndZ8wDEPF8j0O2
	7UPobs5XZXqZNzPdTHIiogzahyM902jOyZ2E59XTGHkc7LX375EMqGIXOJ5sptlV
	My2DmtbjHojhif11twyMFiKA5Ini6cZnV33V6Res+BThvbLMtsBd8DZeZxHN52ly
	QLB/AQdf6rHaGNG3mfnCh8xHEc1ZiM9m8n0uXoE7vo9tARedCY9o3B6ZroBjrF1Q
	MJwdYkrrKObL/manPZlbVkXyesQsJHsY5t8g2cOqOXw3iTAXATwYl/A5wAbcAdS4
	7iC8stsnysXOGPM25R5uEpKces5s+ypYpp+xew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1752844195; x=1752930595; bh=+
	MxrVRLlqXL7WKutiapfjGCxQRS8lmkRc4oB0XUB8u8=; b=htV0KDgVIo0mODMZj
	uVPtbbKJh9javuELFNGS8R4AvlkdKVaquopwb8t9T9jjjPo3nxnSUC3NnPVE/x2P
	5Cyf4zW/F2X3BwUQ3MEH1Kogq7HdGxhice1arzgS4J0JzkhNW0DbHXBwmgiec2JE
	rpBy2hsT+eWHe1W6QAHqqcmyZal0F6AgNA5ihdazZjRE5JdP2tMA/eAcJWkagy5D
	1CwPDGpoN6XQ8bHxdMdALv7lKrvHIAVJCVna2MeUITATLrnjktCd5OaEYWVNgCub
	b7zZOE+P8dQM2uXJv1uOYhbsoNpSv6ap1tunZS2nfwZn4kMPJOrPVgOvYSPY4VZa
	QHdoQ==
X-ME-Sender: <xms:o0d6aP7flCgPysMBjs9ErtkLB5g_tVYS3C5P2-T-6zO1wBi-Na_bMg>
    <xme:o0d6aAYm3G3Owghl4aFdypKQZX3ZfyBXZlvGmG3JeLpqVW9ZC9RE40Zc8Y8CL8Q9i
    ZvYJ1DUJJG9YxDUtw>
X-ME-Received: <xmr:o0d6aM6-DlhU2SOUG-n1B1Ayv91NJJfPa5io5ybAYR9dn9NdtdbvNGsZecA-kAPn54XgIjYOtYFZwNMs2dmEYL1DXE2RXBDw-3N9lGiAj_Dy9bzTt3HC_RCpsEQpREc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeifeehgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:o0d6aLAOsnyaww9dOSqk4noxdXnB3EC6-Ck_X7lyUZQjjeflA9jD5Q>
    <xmx:o0d6aKe6Pj-lBphFjY7fOQhxLIatChJ9WJd3voPytZoxBueJmxgraw>
    <xmx:o0d6aCLLlINluG1E4p2pyAeCvqRqSkYaAz8NGkx3Wnp-frTBYYgqhQ>
    <xmx:o0d6aN1KpGurZE-ZvWC9YZk73Xip1XRuvEgy6pdgU0CWdlV8EMmKaQ>
    <xmx:o0d6aBZdGpzOWM69eS_pDhSwpFMiC61M7KmlOhH1SnELbpHKq7tjPAGk>
Feedback-ID: i42c0435e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 09:09:55 -0400 (EDT)
From: Arun Raghavan <arun@arunraghavan.net>
To: stable@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>,
	Pieterjan Camerlynck <p.camerlynck@televic.com>,
	Fabio Estevam <festevam@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.15.y] ASoC: fsl_sai: Force a software reset when starting in consumer mode
Date: Fri, 18 Jul 2025 09:09:49 -0400
Message-ID: <20250718130949.610540-1-arun@arunraghavan.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025071258-wharf-revisit-b7a3@gregkh>
References: <2025071258-wharf-revisit-b7a3@gregkh>
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
index 87d324927cd9..058b179f5453 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -580,13 +580,15 @@ static void fsl_sai_config_disable(struct fsl_sai *sai, int dir)
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


