Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB537036ED
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243886AbjEORPS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243900AbjEOROu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:14:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747679EDD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:13:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAE5660B9A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFADCC433D2;
        Mon, 15 May 2023 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170796;
        bh=25k/maKvTjokGF7S74GJjyHlScOMw2b5fZgwxGk+au4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m3QTLkDuP3hg9h5fCZKT4XDlaCv8JGdQMcmgZJvokuYEmk0pbU9dNf0O2g2eKPmBx
         Pl150TyTkCKLH9+JI/3ClpGT4aBRFhnXKdiZrPi6pu0YQ1Ri7UzsK/DESF6Ay/CTTJ
         iZsJUxyxAegGBo/rarlRwLgqntFgA6MVCSLC3Cts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 237/239] spi: fsl-spi: Re-organise transfer bits_per_word adaptation
Date:   Mon, 15 May 2023 18:28:20 +0200
Message-Id: <20230515161728.817519057@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

commit 8a5299a1278eadf1e08a598a5345c376206f171e upstream.

For different reasons, fsl-spi driver performs bits_per_word
modifications for different reasons:
- On CPU mode, to minimise amount of interrupts
- On CPM/QE mode to work around controller byte order

For CPU mode that's done in fsl_spi_prepare_message() while
for CPM mode that's done in fsl_spi_setup_transfer().

Reunify all of it in fsl_spi_prepare_message(), and catch
impossible cases early through master's bits_per_word_mask
instead of returning EINVAL later.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Link: https://lore.kernel.org/r/0ce96fe96e8b07cba0613e4097cfd94d09b8919a.1680371809.git.christophe.leroy@csgroup.eu
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-fsl-spi.c |   46 +++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -177,26 +177,6 @@ static int mspi_apply_cpu_mode_quirks(st
 	return bits_per_word;
 }
 
-static int mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
-				struct spi_device *spi,
-				int bits_per_word)
-{
-	/* CPM/QE uses Little Endian for words > 8
-	 * so transform 16 and 32 bits words into 8 bits
-	 * Unfortnatly that doesn't work for LSB so
-	 * reject these for now */
-	/* Note: 32 bits word, LSB works iff
-	 * tfcr/rfcr is set to CPMFCR_GBL */
-	if (spi->mode & SPI_LSB_FIRST &&
-	    bits_per_word > 8)
-		return -EINVAL;
-	if (bits_per_word <= 8)
-		return bits_per_word;
-	if (bits_per_word == 16 || bits_per_word == 32)
-		return 8; /* pretend its 8 bits */
-	return -EINVAL;
-}
-
 static int fsl_spi_setup_transfer(struct spi_device *spi,
 					struct spi_transfer *t)
 {
@@ -224,9 +204,6 @@ static int fsl_spi_setup_transfer(struct
 		bits_per_word = mspi_apply_cpu_mode_quirks(cs, spi,
 							   mpc8xxx_spi,
 							   bits_per_word);
-	else
-		bits_per_word = mspi_apply_qe_mode_quirks(cs, spi,
-							  bits_per_word);
 
 	if (bits_per_word < 0)
 		return bits_per_word;
@@ -361,6 +338,19 @@ static int fsl_spi_prepare_message(struc
 				t->bits_per_word = 32;
 			else if ((t->len & 1) == 0)
 				t->bits_per_word = 16;
+		} else {
+			/*
+			 * CPM/QE uses Little Endian for words > 8
+			 * so transform 16 and 32 bits words into 8 bits
+			 * Unfortnatly that doesn't work for LSB so
+			 * reject these for now
+			 * Note: 32 bits word, LSB works iff
+			 * tfcr/rfcr is set to CPMFCR_GBL
+			 */
+			if (m->spi->mode & SPI_LSB_FIRST && t->bits_per_word > 8)
+				return -EINVAL;
+			if (t->bits_per_word == 16 || t->bits_per_word == 32)
+				t->bits_per_word = 8; /* pretend its 8 bits */
 		}
 	}
 	return fsl_spi_setup_transfer(m->spi, first);
@@ -594,8 +584,14 @@ static struct spi_master *fsl_spi_probe(
 	if (mpc8xxx_spi->type == TYPE_GRLIB)
 		fsl_spi_grlib_probe(dev);
 
-	master->bits_per_word_mask =
-		(SPI_BPW_RANGE_MASK(4, 16) | SPI_BPW_MASK(32)) &
+	if (mpc8xxx_spi->flags & SPI_CPM_MODE)
+		master->bits_per_word_mask =
+			(SPI_BPW_RANGE_MASK(4, 8) | SPI_BPW_MASK(16) | SPI_BPW_MASK(32));
+	else
+		master->bits_per_word_mask =
+			(SPI_BPW_RANGE_MASK(4, 16) | SPI_BPW_MASK(32));
+
+	master->bits_per_word_mask &=
 		SPI_BPW_RANGE_MASK(1, mpc8xxx_spi->max_bits_per_word);
 
 	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE)


