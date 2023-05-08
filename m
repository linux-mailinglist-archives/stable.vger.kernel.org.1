Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA256FAA57
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjEHLC3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbjEHLBZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:01:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C39F2BCCF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:00:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2151B62A0C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9B1C433EF;
        Mon,  8 May 2023 11:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543629;
        bh=E2cQKGIf0Sg7svGkr9tFQQGW4JGX17m45vZK3M2h3HQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YDyREkBhshmFs9nydw57mV7NjVoqNCeBjr+DB2axApdaULejyU3JGXMPnt/YXkomt
         YPNQ+klEhLhJ+AKjVCgcQoXpImOyq6UZh62INdxkuh8nxlKdQFPQkFoAMtCQjnDXfO
         QdfafZpVnUQPMmb+Xyjmier4vZEFj15mGYbUq8w4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 143/694] tpm, tpm_tis: Claim locality before writing interrupt registers
Date:   Mon,  8 May 2023 11:39:38 +0200
Message-Id: <20230508094437.101876604@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Lino Sanfilippo <l.sanfilippo@kunbus.com>

[ Upstream commit 15d7aa4e46eba87242a320f39773aa16faddadee ]

In tpm_tis_probe_single_irq() interrupt registers TPM_INT_VECTOR,
TPM_INT_STATUS and TPM_INT_ENABLE are modified to setup the interrupts.
Currently these modifications are done without holding a locality thus they
have no effect. Fix this by claiming the (default) locality before the
registers are written.

Since now tpm_tis_gen_interrupt() is called with the locality already
claimed remove locality request and release from this function.

Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Stable-dep-of: 955df4f87760 ("tpm, tpm_tis: Claim locality when interrupts are reenabled on resume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 4e6075d4e2643..39f27edb32879 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -739,16 +739,10 @@ static void tpm_tis_gen_interrupt(struct tpm_chip *chip)
 	cap_t cap;
 	int ret;
 
-	ret = request_locality(chip, 0);
-	if (ret < 0)
-		return;
-
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		ret = tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
 	else
 		ret = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc, 0);
-
-	release_locality(chip, 0);
 }
 
 /* Register the IRQ and issue a command that will cause an interrupt. If an
@@ -771,10 +765,16 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
 	}
 	priv->irq = irq;
 
+	rc = request_locality(chip, 0);
+	if (rc < 0)
+		return rc;
+
 	rc = tpm_tis_read8(priv, TPM_INT_VECTOR(priv->locality),
 			   &original_int_vec);
-	if (rc < 0)
+	if (rc < 0) {
+		release_locality(chip, priv->locality);
 		return rc;
+	}
 
 	rc = tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality), irq);
 	if (rc < 0)
@@ -808,10 +808,12 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
 	if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
 		tpm_tis_write8(priv, original_int_vec,
 			       TPM_INT_VECTOR(priv->locality));
-		return -1;
+		rc = -1;
 	}
 
-	return 0;
+	release_locality(chip, priv->locality);
+
+	return rc;
 }
 
 /* Try to find the IRQ the TPM is using. This is for legacy x86 systems that
-- 
2.39.2



