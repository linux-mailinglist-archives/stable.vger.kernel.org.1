Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4096FA9DB
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbjEHK4b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbjEHK4N (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:56:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9466026EB1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:55:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 171DC6294B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E97BC433D2;
        Mon,  8 May 2023 10:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543305;
        bh=Ug9NZHoDCYVYO8qjH3CgqBdFoPrTxpFJbQaHzYqaRXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhArjBFEGD8vAIMmyjevRb0dXG5js2XHmgeLJDnVu2yhdc2GlPPh3YZIGvOiJnabz
         0W1jmhMybmEmwCvscSz7NSj+EOSw1uw+Sp8cfCr56sXmQZ/8R7iuqR/hrYLN6yvgYX
         lz4T/+Zq207YBYSY9fWQ9pznJ8XtrbcFxy0DUfNM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Mariusz=20Bia=C5=82o=C5=84czyk?= <manio@skyboo.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.3 017/694] hwmon: (adt7475) Use device_property APIs when configuring polarity
Date:   Mon,  8 May 2023 11:37:32 +0200
Message-Id: <20230508094433.189080888@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Chris Packham <chris.packham@alliedtelesis.co.nz>

commit 2a8e41ad337508fc5d598c0f9288890214f8e318 upstream.

On DT unaware platforms of_property_read_u32_array() returns -ENOSYS
which wasn't handled by the code treating adi,pwm-active-state as
optional. Update the code to use device_property_read_u32_array() which
deals gracefully with DT unaware platforms.

Fixes: 86da28eed4fb ("hwmon: (adt7475) Add support for inverting pwm output")
Reported-by: Mariusz Białończyk <manio@skyboo.net>
Link: https://lore.kernel.org/linux-hwmon/52e26a67-9131-2dc0-40cb-db5c07370027@alliedtelesis.co.nz/T/#mdd0505801e0a4e72340de009a47c0fca4f771ed3
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Link: https://lore.kernel.org/r/20230418233656.869055-2-chris.packham@alliedtelesis.co.nz
Cc: stable@vger.kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/adt7475.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1604,9 +1604,9 @@ static int adt7475_set_pwm_polarity(stru
 	int ret, i;
 	u8 val;
 
-	ret = of_property_read_u32_array(client->dev.of_node,
-					 "adi,pwm-active-state", states,
-					 ARRAY_SIZE(states));
+	ret = device_property_read_u32_array(&client->dev,
+					     "adi,pwm-active-state", states,
+					     ARRAY_SIZE(states));
 	if (ret)
 		return ret;
 


