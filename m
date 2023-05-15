Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B95703925
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244448AbjEORjc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243327AbjEORjR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:39:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF78313283
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:36:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7746062DC8
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9F7C433EF;
        Mon, 15 May 2023 17:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172194;
        bh=ZGAacLBeVYZkq82ruS4X/tASMfAaJ2tPuVHY47k9p20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wc6kh7Rs+oXLQqMfFvUiakTSLlCzXiQ7pYEiKlP2N5Uq3NZs1nwwT1WobpfYXQfpP
         SppL6AgR5VBYAN4XMyNulyDhLl03WpnWmLu4zTmdVTmkS0BxkN+ogqFW0NJWZsRgBL
         gXTXNVAFFeT6I2w19KuOF7LjxsHCIDIdkLLUE4r4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        =?UTF-8?q?Michael=20Niew=C3=B6hner?= <linux@mniewoehner.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 067/381] tpm, tpm_tis: Disable interrupts if tpm_tis_probe_irq() failed
Date:   Mon, 15 May 2023 18:25:18 +0200
Message-Id: <20230515161739.838036834@linuxfoundation.org>
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

From: Lino Sanfilippo <l.sanfilippo@kunbus.com>

[ Upstream commit 6d789ad726950e612a7f31044260337237c5b490 ]

Both functions tpm_tis_probe_irq_single() and tpm_tis_probe_irq() may setup
the interrupts and then return with an error. This case is indicated by a
missing TPM_CHIP_FLAG_IRQ flag in chip->flags.
Currently the interrupt setup is only undone if tpm_tis_probe_irq_single()
fails. Undo the setup also if tpm_tis_probe_irq() fails.

Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Tested-by: Michael Niewöhner <linux@mniewoehner.de>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Stable-dep-of: 955df4f87760 ("tpm, tpm_tis: Claim locality when interrupts are reenabled on resume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 274096fece3fa..99cbf6fb062ce 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1069,21 +1069,21 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 			goto out_err;
 		}
 
-		if (irq) {
+		if (irq)
 			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
 						 irq);
-			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
-				dev_err(&chip->dev, FW_BUG
+		else
+			tpm_tis_probe_irq(chip, intmask);
+
+		if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
+			dev_err(&chip->dev, FW_BUG
 					"TPM interrupt not working, polling instead\n");
 
-				rc = request_locality(chip, 0);
-				if (rc < 0)
-					goto out_err;
-				disable_interrupts(chip);
-				release_locality(chip, 0);
-			}
-		} else {
-			tpm_tis_probe_irq(chip, intmask);
+			rc = request_locality(chip, 0);
+			if (rc < 0)
+				goto out_err;
+			disable_interrupts(chip);
+			release_locality(chip, 0);
 		}
 	}
 
-- 
2.39.2



