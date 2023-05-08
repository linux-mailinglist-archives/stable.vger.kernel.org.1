Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881576FA6EA
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjEHKZe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbjEHKZL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:25:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7330826457
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:24:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1A6A625BD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81C1C433EF;
        Mon,  8 May 2023 10:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541478;
        bh=b6/Ys0tOR2qmW3ze1O136kpJzwLC1eBz7ItdANpdi+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wF+n7z/SoqK93vOgTXY8mDE7FbMUjsVquKfcXg0y0RFl7BadClHbCSp5+ejN7Cwwz
         na9ORZ39LpHttHGsm9wVnaMaJViRuN0ZokNl1Uv0XnrVQ1/f4JyGLw93azObGJhxRI
         awfmXLNP+7AXD2IpiCeBh6wnh4M1VrFh+dKD0TYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        =?UTF-8?q?Michael=20Niew=C3=B6hner?= <linux@mniewoehner.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 126/663] tpm, tpm_tis: Disable interrupts if tpm_tis_probe_irq() failed
Date:   Mon,  8 May 2023 11:39:12 +0200
Message-Id: <20230508094432.613377579@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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
index a2cbf9b6f4c92..4e6075d4e2643 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1087,21 +1087,21 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
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



