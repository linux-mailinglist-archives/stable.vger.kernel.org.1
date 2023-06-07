Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5766726C5C
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjFGUdG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjFGUdF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:33:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325FA210B
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:32:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFE436452D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2652C433EF;
        Wed,  7 Jun 2023 20:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169969;
        bh=Rfc8FVa3EmDZrkjVY98z7BNwarxJsKCcOvt1SKfKOCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LrSfRwTVu6gAOHF4bERMHkumfCVvvmDe2QZoBy1YHYozLRsDAhp0b5VuiUq3A7sfJ
         uUeUGjYS9mOAHv/oKu1RGV+UBe+15jld/5eI3bjdya/lga+2iy/2obhBE0Ms0VTeSL
         Tp95UvLspGZ4zK7cOVaE0+YOCrgD+M3FoUZA/bfw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        =?UTF-8?q?Michael=20Niew=C3=B6hner?= <linux@mniewoehner.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 6.3 282/286] tpm, tpm_tis: Request threaded interrupt handler
Date:   Wed,  7 Jun 2023 22:16:21 +0200
Message-ID: <20230607200932.493840520@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lino Sanfilippo <l.sanfilippo@kunbus.com>

commit 0c7e66e5fd69bf21034c9a9b081d7de7c3eb2cea upstream.

The TIS interrupt handler at least has to read and write the interrupt
status register. In case of SPI both operations result in a call to
tpm_tis_spi_transfer() which uses the bus_lock_mutex of the spi device
and thus must only be called from a sleepable context.

To ensure this request a threaded interrupt handler.

Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Tested-by: Michael Niewöhner <linux@mniewoehner.de>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm_tis_core.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -805,8 +805,11 @@ static int tpm_tis_probe_irq_single(stru
 	int rc;
 	u32 int_status;
 
-	if (devm_request_irq(chip->dev.parent, irq, tis_int_handler, flags,
-			     dev_name(&chip->dev), chip) != 0) {
+
+	rc = devm_request_threaded_irq(chip->dev.parent, irq, NULL,
+				       tis_int_handler, IRQF_ONESHOT | flags,
+				       dev_name(&chip->dev), chip);
+	if (rc) {
 		dev_info(&chip->dev, "Unable to request irq: %d for probe\n",
 			 irq);
 		return -1;


