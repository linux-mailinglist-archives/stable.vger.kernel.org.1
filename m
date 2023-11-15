Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87D37ED002
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbjKOTwR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbjKOTwQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:52:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F90B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:52:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D24C433C9;
        Wed, 15 Nov 2023 19:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077932;
        bh=cYmSfubwcviVb9xpKXO0uckXfTlXlZPADV8KDYtFuSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ox5qsBPZXl4AcpXY8CowPMAwuxxvNnCA0gahApMGKHFx3I2NmmMviVrQryr3vsSt7
         luZ27Mg1UKIMRt9aiDbNbNMuFMPeTHtfnACSApOWhwhM7rEk8CmcRYco3EjprfvQnr
         k3qEvzPSsFhpOtcLMiuBaQMsmTvXwJOjffHAodm8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dominique Martinet <dominique.martinet@atmark-techno.com>,
        Alex Fetters <Alex.Fetters@garmin.com>,
        Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.6 601/603] Revert "mmc: core: Capture correct oemid-bits for eMMC cards"
Date:   Wed, 15 Nov 2023 14:19:06 -0500
Message-ID: <20231115191652.628799786@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

commit 421b605edb1ce611dee06cf6fd9a1c1f2fd85ad0 upstream.

This reverts commit 84ee19bffc9306128cd0f1c650e89767079efeff.

The commit above made quirks with an OEMID fail to be applied, as they
were checking card->cid.oemid for the full 16 bits defined in MMC_FIXUP
macros but the field would only contain the bottom 8 bits.

eMMC v5.1A might have bogus values in OEMID's higher bits so another fix
will be made, but it has been decided to revert this until that is ready.

Fixes: 84ee19bffc93 ("mmc: core: Capture correct oemid-bits for eMMC cards")
Link: https://lkml.kernel.org/r/ZToJsSLHr8RnuTHz@codewreck.org
Link: https://lkml.kernel.org/r/CAPDyKFqkKibcXnwjnhc3+W1iJBHLeqQ9BpcZrSwhW2u9K2oUtg@mail.gmail.com
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: stable@vger.kernel.org
Cc: Alex Fetters <Alex.Fetters@garmin.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Link: https://lore.kernel.org/r/20231103004220.1666641-1-asmadeus@codewreck.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -104,7 +104,7 @@ static int mmc_decode_cid(struct mmc_car
 	case 3: /* MMC v3.1 - v3.3 */
 	case 4: /* MMC v4 */
 		card->cid.manfid	= UNSTUFF_BITS(resp, 120, 8);
-		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 8);
+		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 16);
 		card->cid.prod_name[0]	= UNSTUFF_BITS(resp, 96, 8);
 		card->cid.prod_name[1]	= UNSTUFF_BITS(resp, 88, 8);
 		card->cid.prod_name[2]	= UNSTUFF_BITS(resp, 80, 8);


