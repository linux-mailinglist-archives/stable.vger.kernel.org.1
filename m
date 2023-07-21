Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD14E75CD38
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjGUQJP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjGUQJO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:09:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E4C2D7C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:09:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB37761D2A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78A5C433C8;
        Fri, 21 Jul 2023 16:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955750;
        bh=AHD9iKyrhhNmOIaWLq1ryY6tiVk8FrAU5k4D3C3iKbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZfwWI6h8ccgklVJhPzgK7x1OgNSXIOq6vAxzZ2DkGbyZ+1PLqbeiFczlQFDh9Weq7
         S3x1BRZWYjav2pktIz0DqQYKYvNWfuZl3l5UDJHHc1FxBZpT4vdnMATaN5Pdqi6QOW
         kLIL0Vz2L0ld4bwTC8Lkh1ogZzeMDOyPQacEg5ec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Akshata MukundShetty <akshata.mukundshetty@amd.com>,
        Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 6.4 004/292] HID: amd_sfh: Rename the float32 variable
Date:   Fri, 21 Jul 2023 18:01:53 +0200
Message-ID: <20230721160529.000192189@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
@@ -132,13 +132,13 @@ static void get_common_inputs(struct com
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


