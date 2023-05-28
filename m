Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A982713CF6
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjE1TU2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjE1TU1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5774EA6
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:20:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9A3261A6D
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13457C4339B;
        Sun, 28 May 2023 19:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301625;
        bh=lrOShuD1J7fhyB15rBLpvhFDnnnVo4vovmawdpsJHKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KwY3yj6eP11QoonjLaT/58wTlbliKY0ijVo9p7aPr9uZUU+cpkVWCsIqIN4doH9/f
         y2We7kBtwp5phv46nc7Gev4I5JNBjemKBgCVpX3wXkAqD/3Gd0G37KeAfiKQsz+B+A
         kxorLBplof1XJBJhP4+lr4xJ/ukzgBVVefztnP9k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 4.19 103/132] spi: spi-fsl-spi: automatically adapt bits-per-word in cpu mode
Date:   Sun, 28 May 2023 20:10:42 +0100
Message-Id: <20230528190836.846410074@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190833.565872088@linuxfoundation.org>
References: <20230528190833.565872088@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

(cherry picked from upstream af0e6242909c3c4297392ca3e94eff1b4db71a97)

Taking one interrupt for every byte is rather slow. Since the
controller is perfectly capable of transmitting 32 bits at a time,
change t->bits_per-word to 32 when the length is divisible by 4 and
large enough that the reduced number of interrupts easily compensates
for the one or two extra fsl_spi_setup_transfer() calls this causes.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-fsl-spi.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -357,12 +357,28 @@ static int fsl_spi_bufs(struct spi_devic
 static int fsl_spi_do_one_msg(struct spi_master *master,
 			      struct spi_message *m)
 {
+	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
 	struct spi_device *spi = m->spi;
 	struct spi_transfer *t, *first;
 	unsigned int cs_change;
 	const int nsecs = 50;
 	int status;
 
+	/*
+	 * In CPU mode, optimize large byte transfers to use larger
+	 * bits_per_word values to reduce number of interrupts taken.
+	 */
+	if (!(mpc8xxx_spi->flags & SPI_CPM_MODE)) {
+		list_for_each_entry(t, &m->transfers, transfer_list) {
+			if (t->len < 256 || t->bits_per_word != 8)
+				continue;
+			if ((t->len & 3) == 0)
+				t->bits_per_word = 32;
+			else if ((t->len & 1) == 0)
+				t->bits_per_word = 16;
+		}
+	}
+
 	/* Don't allow changes if CS is active */
 	first = list_first_entry(&m->transfers, struct spi_transfer,
 			transfer_list);


