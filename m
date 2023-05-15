Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ADE7039C4
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244675AbjEORps (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244620AbjEORp3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:45:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E3116905
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:43:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5883C62046
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF2BC433EF;
        Mon, 15 May 2023 17:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172598;
        bh=7Dse9Mo4Bl2qyQdAHwynYAxizlp7dspDsUDbsWpPqTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z5mcOZS37umCck79orurv+ugcW1kgtEW62tSm3njdkGnXkqg0o7nSZR3oak/5IZVi
         MC3Ifa5fKGCuCGZ1doOk+vcm66hbt2AzzVXI4c5V3/UDEDQzL+aN6I1zB1mSZX3NBE
         eKCBkI3H7JLBauEpqkxu2iano4I5OL19mpgCGYZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 206/381] spi: fsl-spi: Fix CPM/QE mode Litte Endian
Date:   Mon, 15 May 2023 18:27:37 +0200
Message-Id: <20230515161746.101369774@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit c20c57d9868d7f9fd1b2904c7801b07e128f6322 ]

CPM has the same problem as QE so for CPM also use the fix added
by commit 0398fb70940e ("spi/spi_mpc8xxx: Fix QE mode Litte Endian"):

  CPM mode uses Little Endian so words > 8 bits are byte swapped.
  Workaround this by always enforcing wordsize 8 for 16 and 32 bits
  words. Unfortunately this will not work for LSB transfers
  where wordsize is > 8 bits so disable these for now.

Also limit the workaround to 16 and 32 bits words because it can
only work for multiples of 8-bits.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Fixes: 0398fb70940e ("spi/spi_mpc8xxx: Fix QE mode Litte Endian")
Link: https://lore.kernel.org/r/1b7d3e84b1128f42c1887dd2fb9cdf390f541bc1.1680371809.git.christophe.leroy@csgroup.eu
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-spi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index bdf94cc7be1af..1bad0ceac81b4 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -207,8 +207,8 @@ static int mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
 				struct spi_device *spi,
 				int bits_per_word)
 {
-	/* QE uses Little Endian for words > 8
-	 * so transform all words > 8 into 8 bits
+	/* CPM/QE uses Little Endian for words > 8
+	 * so transform 16 and 32 bits words into 8 bits
 	 * Unfortnatly that doesn't work for LSB so
 	 * reject these for now */
 	/* Note: 32 bits word, LSB works iff
@@ -216,9 +216,11 @@ static int mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
 	if (spi->mode & SPI_LSB_FIRST &&
 	    bits_per_word > 8)
 		return -EINVAL;
-	if (bits_per_word > 8)
+	if (bits_per_word <= 8)
+		return bits_per_word;
+	if (bits_per_word == 16 || bits_per_word == 32)
 		return 8; /* pretend its 8 bits */
-	return bits_per_word;
+	return -EINVAL;
 }
 
 static int fsl_spi_setup_transfer(struct spi_device *spi,
@@ -248,7 +250,7 @@ static int fsl_spi_setup_transfer(struct spi_device *spi,
 		bits_per_word = mspi_apply_cpu_mode_quirks(cs, spi,
 							   mpc8xxx_spi,
 							   bits_per_word);
-	else if (mpc8xxx_spi->flags & SPI_QE)
+	else
 		bits_per_word = mspi_apply_qe_mode_quirks(cs, spi,
 							  bits_per_word);
 
-- 
2.39.2



