Return-Path: <stable+bounces-158690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17219AE9E3D
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 15:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0266E7A7599
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 13:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753BC2E540A;
	Thu, 26 Jun 2025 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net header.b="PtNmuljE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OgUgAiwO"
X-Original-To: stable@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC69B2AD11;
	Thu, 26 Jun 2025 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943345; cv=none; b=EGHU2WB6GqKG76ZaJqe44xnr9QARS6M9SyMDD4idqok5sdvtOmY5YbT4iSawr+y7RI0kPdRapUyco141zmOjKWXce6IdhRmjJGOnR4IOjHF+cLNznlaSbx9jcRf+bIvzTZxZrJsxOLCSzH6QcDL1ItY91T4M4wIQjOd5TmSC+pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943345; c=relaxed/simple;
	bh=oOQgk5plAXC3cHkBFuuDTyF/8Mxjc15JcHehSvv9EQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZI5IiBSH/8z+s9MrSIUT2x34U/pQf3BgzZQByK+EWto1BBro7UT5amKFUedho3nv84aaQjkX0jeiQKnggpJX2YYx9R0aBJ9z59B81npNTKcfH1MoSFxsQExJGJuPIgCg2Pge2Y4dIpuOdjKoqXKabUn+D4/OExtMCJfUqxTShX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arunraghavan.net; spf=pass smtp.mailfrom=arunraghavan.net; dkim=pass (2048-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net header.b=PtNmuljE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OgUgAiwO; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arunraghavan.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arunraghavan.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 05540EC01D1;
	Thu, 26 Jun 2025 09:09:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 26 Jun 2025 09:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	arunraghavan.net; h=cc:cc:content-transfer-encoding:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm1; t=1750943342; x=
	1751029742; bh=3TR8c1XlSAHzq5ql4c7mGOadV5LanrZWk1R0NaowOXw=; b=P
	tNmuljElytKPpwQz2xCaNZXiDrB2v+MUCcyu4EOq+nvkgcUyiOH18XhQbZent4dc
	mIQpNliglBAWiM79yhhbQwmeyzqj/ZuFmui8i3MM1hbOHTDEwzlM5rHo0w0zsgtj
	1yXJ6ick3qlMTadVmoFCtZx8jdVTiainoddnZmImk9wu1mPwVVqrOKxJ/+Kb8MOU
	hZhDcatHzawvRfZjJ40rRKEjV9T+qJ6SLqTEzD9yEuk51xXFoto3acnZfZO6bDP+
	d9GBYP/e1EcIkT9zibyQbDduqdXFisWM31H4VdXsRkhEm0Vm6odJvR5qSetNzSBb
	DtPWqAeU/n3wKb6LEsVqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1750943342; x=1751029742; bh=3TR8c1XlSAHzq5ql4c7mGOadV5LanrZWk1R
	0NaowOXw=; b=OgUgAiwOR+NljDySxtWkacQflqePd6AVC7W1eXEjYtm0AZLzCiN
	0cx8EvvL+J9TYWEnOB1gNxhOierzdYC8rMFNLLFiPZLQLppa3ABJUUCG9xiTCdgt
	CKvyDH5MJLfO/oit9BfH21YlNxvkyWCyYHAufnd2yvzndB1Ls8c5aXoq3VPLuihx
	ACYak+2cke2D6RZ3Xz1827UYmZIrFiaQ+vc0rNdLInY6IHH4EjW8jNwHS2lbU7UJ
	GmzVz1twBAWNGp+vu8gwb40A+p2V2xLugVT6BrnlrbVZjHXOTOCD4i40GQ4uYX9n
	BT9BfjTNdQ4Fc9+gU1WJVLjWu4sW7rMvf/A==
X-ME-Sender: <xms:bUZdaCobQOs-jdUnkj5hgNMqXWq5ubSYk3YQL8uQw0wKLpjcSSINOA>
    <xme:bUZdaAppYYFqbQqI5YUyUFG9M83YNERiHj4g8Bxxsdsa--HRFH73uqKQ2V9pcYsRm
    EavPXnHvqK4WIyZXg>
X-ME-Received: <xmr:bUZdaHMNcRNZjIIoM4K_rYEgD6bBA5tgG7dHJ-FFuBjwzWYJjl9hQFImdgp1QmdS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetrhhunhcutfgrghhhrghv
    rghnuceorghruhhnsegrrhhunhhrrghghhgrvhgrnhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepteduheelvedvledvudfhudevkefhhfeifefggeevkedvudfgueelvdehtdetvdef
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghruh
    hnsegrrhhunhhrrghghhgrvhgrnhdrnhgvthdpnhgspghrtghpthhtohepudegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehshhgvnhhgjhhiuhdrfigrnhhgsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepgihiuhgsohdrlhgvvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopehnihgtoh
    hlvghothhsuhhkrgesghhmrghilhdrtghomhdprhgtphhtthhopehlghhirhgufihoohgu
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepphgvrhgvgiesphgvrhgvgidrtgiipdhrtghpthhtohepthhifigr
    ihesshhushgvrdgtohhmpdhrtghpthhtohepphdrtggrmhgvrhhlhihntghksehtvghlvg
    hvihgtrdgtohhm
X-ME-Proxy: <xmx:bUZdaB54Hz6UhUVeDLG3l_ZwEUttpvdcpg1T5EsH99vDQPKzVTJTAg>
    <xmx:bUZdaB7dPLXisgzE6x7ObluNUnAkDoKb8nFuVrH2WW8-jdav1B2htw>
    <xmx:bUZdaBi2ITaqNxZIk6IqQvI_Y3DJAfLp9WeiX7noVe3XwalDn9mCGQ>
    <xmx:bUZdaL6psXbo9zJBPJ_3Ybzg4-di_hvQl0sm6ETIqBojIV2YSUwHlg>
    <xmx:bUZdaNpGehd9MBJzwrMUl8LVtfQNs4jACysufrmqmU4sldkB8Q23KAd_>
Feedback-ID: i42c0435e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 09:09:00 -0400 (EDT)
From: Arun Raghavan <arun@arunraghavan.net>
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Pieterjan Camerlynck <p.camerlynck@televic.com>,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Arun Raghavan <arun@asymptotic.io>,
	stable@vger.kernel.org
Subject: [PATCH v4] ASoC: fsl_sai: Force a software reset when starting in consumer mode
Date: Thu, 26 Jun 2025 09:08:25 -0400
Message-ID: <20250626130858.163825-1-arun@arunraghavan.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arun Raghavan <arun@asymptotic.io>

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
---

v4
- Add Fixes and cc stable

v3
- Incorporate feedback from Shengjiu Wang to consolidate with the
  existing handling of this issue in producer mode

v2 (no longer relevant)
- Address build warning from kernel test robot

 sound/soc/fsl/fsl_sai.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index af1a168d35e3..50af6b725670 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -803,13 +803,15 @@ static void fsl_sai_config_disable(struct fsl_sai *sai, int dir)
 	 * anymore. Add software reset to fix this issue.
 	 * This is a hardware bug, and will be fix in the
 	 * next sai version.
+	 *
+	 * In consumer mode, this can happen even after a
+	 * single open/close, especially if both tx and rx
+	 * are running concurrently.
 	 */
-	if (!sai->is_consumer_mode[tx]) {
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
2.49.0


