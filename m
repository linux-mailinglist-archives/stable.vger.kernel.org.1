Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D9E6FAD50
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjEHLdd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbjEHLdR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:33:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F823D224
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:32:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04DBD63103
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9858C4339B;
        Mon,  8 May 2023 11:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545534;
        bh=Dk3JdR2G+491PHOOQvvFUi1KjknDUYJ54gzcEzTSg+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DSfBeeb1GOzaQLJ3yYfdB8rvHQJlJTOtYkRiAcRcqumPw95YmVuJ6klbNDDMzR8Lf
         QX4U62V/+dyzQXhhknd1ND5opFIn3hZ1esez+czbbFJYxlgy5CGD1w8tQNxiPzf6G3
         Pb1EnjTRouXyY2T5RyVs3rMZCG2wgoS6Pl2hf4EU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 072/371] tpm, tpm_tis: Claim locality when interrupts are reenabled on resume
Date:   Mon,  8 May 2023 11:44:33 +0200
Message-Id: <20230508094814.981313730@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

[ Upstream commit 955df4f87760b3bb2af253d3fbb12fb712b3ffa6 ]

In tpm_tis_resume() make sure that the locality has been claimed when
tpm_tis_reenable_interrupts() is called. Otherwise the writings to the
register might not have any effect.

Fixes: 45baa1d1fa39 ("tpm_tis: Re-enable interrupts upon (S3) resume")
Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 3ea0fff30273e..d65fff4e2ebe9 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1173,28 +1173,27 @@ int tpm_tis_resume(struct device *dev)
 	struct tpm_chip *chip = dev_get_drvdata(dev);
 	int ret;
 
+	ret = tpm_tis_request_locality(chip, 0);
+	if (ret < 0)
+		return ret;
+
 	if (chip->flags & TPM_CHIP_FLAG_IRQ)
 		tpm_tis_reenable_interrupts(chip);
 
 	ret = tpm_pm_resume(dev);
 	if (ret)
-		return ret;
+		goto out;
 
 	/*
 	 * TPM 1.2 requires self-test on resume. This function actually returns
 	 * an error code but for unknown reason it isn't handled.
 	 */
-	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
-		ret = tpm_tis_request_locality(chip, 0);
-		if (ret < 0)
-			return ret;
-
+	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
 		tpm1_do_selftest(chip);
+out:
+	tpm_tis_relinquish_locality(chip, 0);
 
-		tpm_tis_relinquish_locality(chip, 0);
-	}
-
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(tpm_tis_resume);
 #endif
-- 
2.39.2



