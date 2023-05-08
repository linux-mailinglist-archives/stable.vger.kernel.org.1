Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09836FAA76
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjEHLDD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbjEHLCm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:02:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16173413E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C9D762A49
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD65C433D2;
        Mon,  8 May 2023 11:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543698;
        bh=xzlrzZkuLIcP7YhZu2SlQaZL/uCQ6swPFrmmflrvv8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=10Vwh97PNiGDSxOTlhqOehwB3YIWXhpoYfHzPs/NZdO47v9dRqlWt2CEcnm5CGGUm
         0KrJfJC6WqqshjBbzolk+iGseUTIhDCgAhfeOxNxAlVq50tmqFTp2d3uBhje4HTaDv
         B+E3DEfqCQe397MtlWGKNPVfaFDA1zmw/vQ8tNNg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 145/694] tpm, tpm_tis: Claim locality when interrupts are reenabled on resume
Date:   Mon,  8 May 2023 11:39:40 +0200
Message-Id: <20230508094437.160811581@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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
index c5fef63c6179d..eecfbd7e97867 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1191,28 +1191,27 @@ int tpm_tis_resume(struct device *dev)
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



