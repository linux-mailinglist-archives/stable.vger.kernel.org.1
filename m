Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05567039F1
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244626AbjEORqx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244695AbjEORqh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:46:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BDC132B8
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3666362EB1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251A4C4339B;
        Mon, 15 May 2023 17:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172715;
        bh=Z3SH7zS4+UJqGz17yWcClfbdrPdo8ns43fqlpP3yl+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qq6N9Yt1p+n/PWav/48v3GVCpNqGOPfexEZ7swOGX60Qie6gse+WhDm19f/E+Dwqy
         /BVccUVxPphYsS7j+P20wAR+FLPSfDe9GygEIuMIxqvoczC0+M4S/1YQrG3q3r2x17
         FSqsLvEUI9rItYyZLseW0OCsbcXsDvc0I9oBqw2I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 243/381] power: supply: generic-adc-battery: fix unit scaling
Date:   Mon, 15 May 2023 18:28:14 +0200
Message-Id: <20230515161747.683600140@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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
index 58f09314741a7..09bb4ff291cb0 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -138,6 +138,9 @@ static int read_channel(struct gab *adc_bat, enum power_supply_property psp,
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



