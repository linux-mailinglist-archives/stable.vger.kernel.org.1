Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC537038B1
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242671AbjEOReN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244401AbjEORd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:33:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF58C4ED0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:31:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98E6E62D2A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B11C433EF;
        Mon, 15 May 2023 17:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171897;
        bh=+RcXgZWucDgFeNxbckfTTeHe5CcUbJD+uKE0L5JPzRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lGnL+mKLEOjwsCNrE62ikj96T0duAgvfnm8Kt8zSzxgVIwKMpWbJp0thZ/Fk8clPz
         B0WcNLjCVfZqxPAUBti/xMrW4d8bdnieMd6LBkhRBlWuEq6ZxocjZbRNN5PCcrQsKS
         D0SdFKmZcwIZP/82xuUOAjWyc8PAsnBWhIYUkL24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5.15 083/134] ARM: dts: s5pv210: correct MIPI CSIS clock name
Date:   Mon, 15 May 2023 18:29:20 +0200
Message-Id: <20230515161705.940390474@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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
@@ -582,7 +582,7 @@
 				interrupts = <29>;
 				clocks = <&clocks CLK_CSIS>,
 						<&clocks SCLK_CSIS>;
-				clock-names = "clk_csis",
+				clock-names = "csis",
 						"sclk_csis";
 				bus-width = <4>;
 				status = "disabled";


