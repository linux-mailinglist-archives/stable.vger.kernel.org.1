Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0328475D1F4
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjGUSyh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjGUSyg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:54:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD87359C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:54:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B18B61D82
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A09CC433C7;
        Fri, 21 Jul 2023 18:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965672;
        bh=BNuzvQl3oyqrwG/CpPmiyJcLlA7+35wE4UK8KuGcERA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BCsdlgNLswv27d2H6XtIvPMopkutmvkbX55rZVaE5evaMvucl9CCnXguEuviYBK/2
         0YufRhLDroQhsjSFb7ygEOMXk9/dbwZy5Qs+lA2jqoam6lwQ3JnQ2/2q+WeIyZ0gPa
         6p6HsKMqYEjaa8rImKCdljsBqXA744d8Y/lr7RPc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 045/532] spi: dw: Round of n_bytes to power of 2
Date:   Fri, 21 Jul 2023 17:59:09 +0200
Message-ID: <20230721160617.088756588@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Joy Chakraborty <joychakr@google.com>

[ Upstream commit 9f34baf67e4d08908fd94ff29c825bb673295336 ]

n_bytes variable in the driver represents the number of bytes per word
that needs to be sent/copied to fifo. Bits/word can be between 8 and 32
bits from the client but in memory they are a power of 2, same is mentioned
in spi.h header:
"
 * @bits_per_word: Data transfers involve one or more words; word sizes
 *      like eight or 12 bits are common.  In-memory wordsizes are
 *      powers of two bytes (e.g. 20 bit samples use 32 bits).
 *      This may be changed by the device's driver, or left at the
 *      default (0) indicating protocol words are eight bit bytes.
 *      The spi_transfer.bits_per_word can override this for each transfer.
"

Hence, round of n_bytes to a power of 2 to avoid values like 3 which
would generate unalligned/odd accesses to memory/fifo.

* tested on Baikal-T1 based system with DW SPI-looped back interface
transferring a chunk of data with DFS:8,12,16.

Fixes: a51acc2400d4 ("spi: dw: Add support for 32-bits max xfer size")
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com
Signed-off-by: Joy Chakraborty <joychakr@google.com
Reviewed-by: Serge Semin <fancer.lancer@gmail.com
Tested-by: Serge Semin <fancer.lancer@gmail.com
Link: https://lore.kernel.org/r/20230512104746.1797865-4-joychakr@google.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-dw-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 59e22c6b4b201..8fc598f09a728 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -416,7 +416,10 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	int ret;
 
 	dws->dma_mapped = 0;
-	dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
+	dws->n_bytes =
+		roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word,
+						BITS_PER_BYTE));
+
 	dws->tx = (void *)transfer->tx_buf;
 	dws->tx_len = transfer->len / dws->n_bytes;
 	dws->rx = transfer->rx_buf;
-- 
2.39.2



