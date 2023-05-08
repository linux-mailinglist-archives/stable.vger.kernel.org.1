Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12556FA91B
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjEHKsA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbjEHKrf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:47:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BCD29FD2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:47:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ED62628E7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC4DC433EF;
        Mon,  8 May 2023 10:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542824;
        bh=7EUzsX8JrcFemhdwca7bezGO5URyHPSzWt/iPLv0KYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bIAI2RDik9o9GUB9uN1emfa08tKZkrkhfU8rCjRAqOUGZxbK7yh7lBD9LvKMsWiXV
         FUfJteubqaxM+/N9qAOE5YcqJwthxUhF1XCdlyVOvbjXScMqBzt3hf3pH4Hn7H2u2C
         H+NbzyI6X0RZIeGlpLe/ljSjuqcL8sbuaC5DJQm0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 528/663] rtc: omap: include header for omap_rtc_power_off_program prototype
Date:   Mon,  8 May 2023 11:45:54 +0200
Message-Id: <20230508094446.006072783@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit f69c2b5420497b7a54181ce170d682cbeb1f119f ]

Non-static functions should have a prototype:

  drivers/rtc/rtc-omap.c:410:5: error: no previous prototype for ‘omap_rtc_power_off_program’ [-Werror=missing-prototypes]

Fixes: 6256f7f7f217 ("rtc: OMAP: Add support for rtc-only mode")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230311094021.79730-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-omap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 4d4f3b1a73093..73634a3ccfd3b 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/rtc.h>
+#include <linux/rtc/rtc-omap.h>
 
 /*
  * The OMAP RTC is a year/month/day/hours/minutes/seconds BCD clock
-- 
2.39.2



