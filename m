Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C7975D405
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjGUTQ6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjGUTQ5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:16:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F7E30E1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:16:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC94961D2F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB1EC433C7;
        Fri, 21 Jul 2023 19:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967015;
        bh=LjHFTjG8i4S7hLbrcbIEp9q9rdzfNsl+uF5IozDekWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cgmzoZ4MlleIgl5rp12nDtvJ3q6iJ16syuV4VHVcyED0h0A/9WjPxUmZzx8877PYm
         rwHPNQEJaUIxBxW+gXubCxhN+GIbO0Y2v58K3eQGtssAqfVEiE/yTXY351MtmhhZBG
         YRwCgNAEoe5NOFYEm7xXbc0/y/S3O1t4ohcT4+vs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Akshata MukundShetty <akshata.mukundshetty@amd.com>,
        Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 6.1 002/223] HID: amd_sfh: Rename the float32 variable
Date:   Fri, 21 Jul 2023 18:04:15 +0200
Message-ID: <20230721160520.977437262@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

commit c1685a862a4bea863537f06abaa37a123aef493c upstream.

As float32 is also used in other places as a data type, it is necessary
to rename the float32 variable in order to avoid confusion.

Cc: stable@vger.kernel.org
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Link: https://lore.kernel.org/r/20230707065722.9036-2-Basavaraj.Natikar@amd.com
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
index 6f0d332ccf51..c81d20cd3081 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
@@ -132,13 +132,13 @@ static void get_common_inputs(struct common_input_property *common, int report_i
 	common->event_type = HID_USAGE_SENSOR_EVENT_DATA_UPDATED_ENUM;
 }
 
-static int float_to_int(u32 float32)
+static int float_to_int(u32 flt32_val)
 {
 	int fraction, shift, mantissa, sign, exp, zeropre;
 
-	mantissa = float32 & GENMASK(22, 0);
-	sign = (float32 & BIT(31)) ? -1 : 1;
-	exp = (float32 & ~BIT(31)) >> 23;
+	mantissa = flt32_val & GENMASK(22, 0);
+	sign = (flt32_val & BIT(31)) ? -1 : 1;
+	exp = (flt32_val & ~BIT(31)) >> 23;
 
 	if (!exp && !mantissa)
 		return 0;
@@ -151,10 +151,10 @@ static int float_to_int(u32 float32)
 	}
 
 	shift = 23 - exp;
-	float32 = BIT(exp) + (mantissa >> shift);
+	flt32_val = BIT(exp) + (mantissa >> shift);
 	fraction = mantissa & GENMASK(shift - 1, 0);
 
-	return (((fraction * 100) >> shift) >= 50) ? sign * (float32 + 1) : sign * float32;
+	return (((fraction * 100) >> shift) >= 50) ? sign * (flt32_val + 1) : sign * flt32_val;
 }
 
 static u8 get_input_rep(u8 current_index, int sensor_idx, int report_id,
-- 
2.41.0



