Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C69B775A1C
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjHILFb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjHILFa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:05:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D19E1BFE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:05:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22AC263118
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3197EC433C8;
        Wed,  9 Aug 2023 11:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579129;
        bh=mewNc5/AW7N/T05NJYg1MeouL1J2XIc/JMk04u5Ul38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pNtQLrIo2MapO9Du8GM/+aPjQMVJTHnpbhYrUGXzdDTLuM/7UDI83BWIpLWICgZKG
         v2o3VbuhdrZzstnFptXwEYFuQqpd856cqN6S5gSd+JORvO8LZKGdt0IofMxSayulr9
         r5sSAFN18hBemHtbPLrZkVNjpfmrYrK462j1n9gQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 4.14 086/204] spi: spi-fsl-spi: allow changing bits_per_word while CS is still active
Date:   Wed,  9 Aug 2023 12:40:24 +0200
Message-ID: <20230809103645.526914388@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

commit a798a7086c38d91d304132c194cff9f02197f5cd upstream.

Commit c9bfcb315104 (spi_mpc83xx: much improved driver) introduced
logic to ensure bits_per_word and speed_hz stay the same for a series
of spi_transfers with CS active, arguing that

    The current driver may cause glitches on SPI CLK line since one
    must disable the SPI controller before changing any HW settings.

This sounds quite reasonable. So this is a quite naive attempt at
relaxing this sanity checking to only ensure that speed_hz is
constant - in the faint hope that if we do not causes changes to the
clock-related fields of the SPMODE register (DIV16 and PM), those
glitches won't appear.

The purpose of this change is to allow automatically optimizing large
transfers to use 32 bits-per-word; taking one interrupt for every byte
is extremely slow.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-fsl-spi.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -339,7 +339,7 @@ static int fsl_spi_do_one_msg(struct spi
 	struct spi_transfer *t, *first;
 	unsigned int cs_change;
 	const int nsecs = 50;
-	int status;
+	int status, last_bpw;
 
 	/*
 	 * In CPU mode, optimize large byte transfers to use larger
@@ -378,21 +378,22 @@ static int fsl_spi_do_one_msg(struct spi
 		if (cs_change)
 			first = t;
 		cs_change = t->cs_change;
-		if ((first->bits_per_word != t->bits_per_word) ||
-			(first->speed_hz != t->speed_hz)) {
+		if (first->speed_hz != t->speed_hz) {
 			dev_err(&spi->dev,
-				"bits_per_word/speed_hz cannot change while CS is active\n");
+				"speed_hz cannot change while CS is active\n");
 			return -EINVAL;
 		}
 	}
 
+	last_bpw = -1;
 	cs_change = 1;
 	status = -EINVAL;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (cs_change)
+		if (cs_change || last_bpw != t->bits_per_word)
 			status = fsl_spi_setup_transfer(spi, t);
 		if (status < 0)
 			break;
+		last_bpw = t->bits_per_word;
 
 		if (cs_change) {
 			fsl_spi_chipselect(spi, BITBANG_CS_ACTIVE);


