Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8256FAC61
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbjEHLXw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbjEHLXt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:23:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973043948F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:23:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7A1661086
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD67C433A0;
        Mon,  8 May 2023 11:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545020;
        bh=HcVHmsYf0WHbDYdxMfdo34ht14fDlnotCj2cU3dTJdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yD83udAI5kUc0nciJ1pdndyi5VAx9bEjOGGWuaX6FbgVbZsRQ8lqtW1ae7Oz7G+Pd
         Y3wDI1+yqKkwIyjxLbYuIA37yjZim6U+q60rFTwO26DXPbRda+tDYq8+wIlnoi4Q09
         lub56fb6E2PTfsMoOxOQrxslhU0AOo4rWZherd5w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 598/694] power: supply: generic-adc-battery: fix unit scaling
Date:   Mon,  8 May 2023 11:47:13 +0200
Message-Id: <20230508094454.601413716@linuxfoundation.org>
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

From: Sebastian Reichel <sre@kernel.org>

[ Upstream commit 44263f50065969f2344808388bd589740f026167 ]

power-supply properties are reported in µV, µA and µW.
The IIO API provides mV, mA, mW, so the values need to
be multiplied by 1000.

Fixes: e60fea794e6e ("power: battery: Generic battery driver using IIO")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 66039c665dd1e..0af536f4932f1 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -135,6 +135,9 @@ static int read_channel(struct gab *adc_bat, enum power_supply_property psp,
 			result);
 	if (ret < 0)
 		pr_err("read channel error\n");
+	else
+		*result *= 1000;
+
 	return ret;
 }
 
-- 
2.39.2



