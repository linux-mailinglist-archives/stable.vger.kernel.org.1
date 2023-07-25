Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E037076150D
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbjGYLZK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjGYLZJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:25:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BDE9D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:25:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DF3E6166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1E5C433C7;
        Tue, 25 Jul 2023 11:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284307;
        bh=og1l9JlDqTQW0p+OEuy/ep1t09lZJYsiXejiLmrD8nY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lClITaApmFHdqvjMq3p1hwDjutsVqeHpQLRI1pWZJk01r6Dhgcib5BZj0yRdZSJHa
         jKtumcu5JeVLOM/1lWbBUuyE0DJ9U89N8kx7L92aDBIrt+YYCc5gPnUvNea441qHzL
         lKUgmphowzckqvMKZgOBFaLUODi6aPVPK5kTXDiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        =?UTF-8?q?Michael=20Niew=C3=B6hner?= <linux@mniewoehner.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 5.10 308/509] tpm, tpm_tis: Claim locality in interrupt handler
Date:   Tue, 25 Jul 2023 12:44:07 +0200
Message-ID: <20230725104607.837266352@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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

commit 0e069265bce5a40c4eee52e2364bbbd4dabee94a upstream.

Writing the TPM_INT_STATUS register in the interrupt handler to clear the
interrupts only has effect if a locality is held. Since this is not
guaranteed at the time the interrupt is fired, claim the locality
explicitly in the handler.

Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Tested-by: Michael Niewöhner <linux@mniewoehner.de>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm_tis_core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -731,7 +731,9 @@ static irqreturn_t tis_int_handler(int d
 		wake_up_interruptible(&priv->int_queue);
 
 	/* Clear interrupts handled with TPM_EOI */
+	tpm_tis_request_locality(chip, 0);
 	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), interrupt);
+	tpm_tis_relinquish_locality(chip, 0);
 	if (rc < 0)
 		return IRQ_NONE;
 


