Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E3770344A
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242961AbjEOQqv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242989AbjEOQqp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:46:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0522E5243
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:46:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ECA56290E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789A4C4339B;
        Mon, 15 May 2023 16:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169203;
        bh=Zvknaq37eclXJmEZNGhMRlRqREfz+q/18uzeB+KgQOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UfRideOu6i5QMcis+1vwcipecRH9u18qo42XOJDyiSMJVpKIC26ogTrucIa+FUxq3
         tFHwnC9wY6xph7JE3qg095RbvJYYXwJT1+gImCJoBEJIACwsciyzn9n3CDGS9tgTIH
         7HQB3Qn9jjl/4g6be05su9hB/ZFFzoZKVGsLTgZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4.19 175/191] ARM: dts: s5pv210: correct MIPI CSIS clock name
Date:   Mon, 15 May 2023 18:26:52 +0200
Message-Id: <20230515161713.793424340@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 665b9459bb53b8f19bd1541567e1fe9782c83c4b upstream.

The Samsung S5P/Exynos MIPI CSIS bindings and Linux driver expect first
clock name to be "csis".  Otherwise the driver fails to probe.

Fixes: 94ad0f6d9278 ("ARM: dts: Add Device tree for s5pv210 SoC")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230212185818.43503-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/s5pv210.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -560,7 +560,7 @@
 				interrupts = <29>;
 				clocks = <&clocks CLK_CSIS>,
 						<&clocks SCLK_CSIS>;
-				clock-names = "clk_csis",
+				clock-names = "csis",
 						"sclk_csis";
 				bus-width = <4>;
 				status = "disabled";


