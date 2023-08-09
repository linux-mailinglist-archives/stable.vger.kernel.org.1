Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4422D775B56
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjHILQr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjHILQr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:16:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6081ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:16:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F01F61FA9
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EF7C433C7;
        Wed,  9 Aug 2023 11:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579805;
        bh=XrdkNDoIq2yvrGccPxLw9yteSjjPHvRpviM85Fy9Yy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=biDvAA7pl7uxJz+h37okWy4IjkXj6rpVfjcGmP+OHYxMHdmVm/UfYU1M/mmH3gyWr
         qwTAg8sgH2+bouDC+vwLKkdPwPjWbqlEkzxYCQZrsa7ViOOM13I6yJKc7VHKRh39RM
         zWFgxNM9gXrold55hX1R1FOmx8H5v9D/bmQRibkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 4.19 122/323] spi: spi-fsl-spi: relax message sanity checking a little
Date:   Wed,  9 Aug 2023 12:39:20 +0200
Message-ID: <20230809103703.700221478@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
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

commit 17ecffa289489e8442306bbc62ebb964e235cdad upstream.

The comment says that we should not allow changes (to
bits_per_word/speed_hz) while CS is active, and indeed the code below
does fsl_spi_setup_transfer() when the ->cs_change of the previous
spi_transfer was set (and for the very first transfer).

So the sanity checking is a bit too strict - we can change it to
follow the same logic as is used by the actual transfer loop.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-fsl-spi.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -373,13 +373,15 @@ static int fsl_spi_do_one_msg(struct spi
 	}
 
 	/* Don't allow changes if CS is active */
-	first = list_first_entry(&m->transfers, struct spi_transfer,
-			transfer_list);
+	cs_change = 1;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (cs_change)
+			first = t;
+		cs_change = t->cs_change;
 		if ((first->bits_per_word != t->bits_per_word) ||
 			(first->speed_hz != t->speed_hz)) {
 			dev_err(&spi->dev,
-				"bits_per_word/speed_hz should be same for the same SPI transfer\n");
+				"bits_per_word/speed_hz cannot change while CS is active\n");
 			return -EINVAL;
 		}
 	}


