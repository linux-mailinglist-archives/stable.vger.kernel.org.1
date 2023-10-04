Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0487B8A62
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244411AbjJDSfD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244415AbjJDSfC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:35:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1841FC0
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:34:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62829C433C7;
        Wed,  4 Oct 2023 18:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444498;
        bh=N7oQPsSYV/uH0Ii2tSEf6s63iSwEZPxcJ5n2JWfcu5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y6ey2lCS8puRKFx4CW3L/d8h85z1ZbzIkkCX/L3GHowEBd0UN2AayLkxZmdJgmStq
         zH8FfvuSvpLTjonGNA9qIJFUaszoG4QwZAx9BvzMG5I1b37bmPHFrfcR4UBPlX7UEz
         1Ddef7TWWM40NeS2Lvx2evpqucUbVWMW56LTTcsc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, August Wikerfors <git@augustwikerfors.se>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.5 270/321] ASoC: amd: yc: Fix non-functional mic on Lenovo 82QF and 82UG
Date:   Wed,  4 Oct 2023 19:56:55 +0200
Message-ID: <20231004175241.793912436@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: August Wikerfors <git@augustwikerfors.se>

commit 1263cc0f414d212129c0f1289b49b7df77f92084 upstream.

Like the Lenovo 82TL and 82V2, the Lenovo 82QF (Yoga 7 14ARB7) and 82UG
(Legion S7 16ARHA7) both need a quirk entry for the internal microphone to
function. Commit c008323fe361 ("ASoC: amd: yc: Fix a non-functional mic on
Lenovo 82SJ") restricted the quirk that previously matched "82" to "82V2",
breaking microphone functionality on these devices. Fix this by adding
specific quirks for these models, as was done for the Lenovo 82TL.

Fixes: c008323fe361 ("ASoC: amd: yc: Fix a non-functional mic on Lenovo 82SJ")
Closes: https://github.com/tomsom/yoga-linux/issues/51
Link: https://bugzilla.kernel.org/show_bug.cgi?id=208555#c780
Cc: stable@vger.kernel.org
Signed-off-by: August Wikerfors <git@augustwikerfors.se>
Link: https://lore.kernel.org/r/20230911213409.6106-1-git@augustwikerfors.se
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/amd/yc/acp6x-mach.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -217,10 +217,24 @@ static const struct dmi_system_id yc_acp
 		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "82V2"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82UG"),
+		}
+	},
+	{
 		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),


