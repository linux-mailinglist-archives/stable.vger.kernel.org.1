Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1D170C963
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbjEVTrb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbjEVTra (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:47:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0E899
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:47:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B7D462AB0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545A0C4339B;
        Mon, 22 May 2023 19:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784848;
        bh=k65eIBNbWGgq8kPNcDAf+4jUBJl/3bdgi6/uQvDQIZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KmeXVr6mnZ+IP8QN/wXSZdzZY2iCp5Df+q3X48Axg5Jk+jmIVTzTsLkRg46rkz1A+
         RDtk4zHzOvm0HvcFkUkQ3WxMwlUMtqze+oLwMfXaix4vSP7yCoQZ7iGN+BcbQRPGZ7
         TkZrtXMUW30HHaBJNTQsdiJfYBu+IyiDtQ9AStxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 194/364] mfd: intel_soc_pmic_chtwc: Add Lenovo Yoga Book X90F to intel_cht_wc_models
Date:   Mon, 22 May 2023 20:08:19 +0100
Message-Id: <20230522190417.585395853@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit ded99b89d25fd73a1d7bd910378e0339fd9d4c4a ]

The Android Lenovo Yoga Book X90F / X90L uses the same charger / fuelgauge
setup as the already supported Windows Lenovo Yoga Book X91F/L, add
a DMI match for this to intel_cht_wc_models with driver_data
set to INTEL_CHT_WC_LENOVO_YOGABOOK1.

When the quirk for the X91F/L was initially added it was written to
also apply to the X90F/L but this does not work because the Android
version of the Yoga Book uses completely different DMI strings.
Also adjust the X91F/L quirk to reflect that it only applies to
the X91F/L models.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20230301095402.28582-1-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel_soc_pmic_chtwc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
index d53dae2554906..871776d511e31 100644
--- a/drivers/mfd/intel_soc_pmic_chtwc.c
+++ b/drivers/mfd/intel_soc_pmic_chtwc.c
@@ -159,11 +159,19 @@ static const struct dmi_system_id cht_wc_model_dmi_ids[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
 		},
 	}, {
-		/* Lenovo Yoga Book X90F / X91F / X91L */
+		/* Lenovo Yoga Book X90F / X90L */
 		.driver_data = (void *)(long)INTEL_CHT_WC_LENOVO_YOGABOOK1,
 		.matches = {
-			/* Non exact match to match all versions */
-			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X9"),
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
+		},
+	}, {
+		/* Lenovo Yoga Book X91F / X91L */
+		.driver_data = (void *)(long)INTEL_CHT_WC_LENOVO_YOGABOOK1,
+		.matches = {
+			/* Non exact match to match F + L versions */
+			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X91"),
 		},
 	}, {
 		/* Lenovo Yoga Tab 3 Pro YT3-X90F */
-- 
2.39.2



