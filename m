Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D157ECF35
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbjKOTrD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbjKOTrC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:47:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28C0C2
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:46:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E197C433CB;
        Wed, 15 Nov 2023 19:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077618;
        bh=qkvkjQ+qf31SrwWwZqU8l3ZmJ7NC+/9BzWQ+T4UOOqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OI6IHd2cHKD1hgDi0MznsKcAZMYFmn1q558IC/6CEYx0a6mCoKEuIHQRlJc/31gff
         Alya/KWguCHOu1aJiLVoqINbTTRoqhxJfw97MhwlRwAebX/5p2Amm5q9nlkp++vQOb
         WAKB2E/pbY6eBtyBbgil3tqf6jjrRiOxvKK/cJ8U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 413/603] mfd: arizona-spi: Set pdata.hpdet_channel for ACPI enumerated devs
Date:   Wed, 15 Nov 2023 14:15:58 -0500
Message-ID: <20231115191641.555489888@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 831d1af85133e1763d41e20414912d9a1058ea72 ]

Commit 9e86b2ad4c11 changed the channel used for HPDET detection
(headphones vs lineout detection) from being hardcoded to
ARIZONA_ACCDET_MODE_HPL (HP left channel) to it being configurable
through arizona_pdata.hpdet_channel the DT/OF parsing added for
filling arizona_pdata on devicetree platforms ensures that
arizona_pdata.hpdet_channel gets set to ARIZONA_ACCDET_MODE_HPL
when not specified in the devicetree-node.

But on ACPI platforms where arizona_pdata is filled by
arizona_spi_acpi_probe() arizona_pdata.hpdet_channel was not
getting set, causing it to default to 0 aka ARIZONA_ACCDET_MODE_MIC.

This causes headphones to get misdetected as line-out on some models.
Fix this by setting hpdet_channel = ARIZONA_ACCDET_MODE_HPL.

Fixes: e933836744a2 ("mfd: arizona: Add support for ACPI enumeration of WM5102 connected over SPI")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20231014205414.59415-1-hdegoede@redhat.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/arizona-spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index 02cf4f3e91d76..de5d894ac04af 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -159,6 +159,9 @@ static int arizona_spi_acpi_probe(struct arizona *arizona)
 	arizona->pdata.micd_ranges = arizona_micd_aosp_ranges;
 	arizona->pdata.num_micd_ranges = ARRAY_SIZE(arizona_micd_aosp_ranges);
 
+	/* Use left headphone speaker for HP vs line-out detection */
+	arizona->pdata.hpdet_channel = ARIZONA_ACCDET_MODE_HPL;
+
 	return 0;
 }
 
-- 
2.42.0



