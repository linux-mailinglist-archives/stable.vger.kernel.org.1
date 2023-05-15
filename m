Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17817037B2
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244130AbjEORXp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244058AbjEORXT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:23:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F4B9E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:21:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0932562C53
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA3BC433A4;
        Mon, 15 May 2023 17:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171304;
        bh=zFGHp+5IgPdnh3gU1gd6+dnQntP5Qd8ulJqIdaRDqYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oELddF9H2RzguWxOUShiAxK0vq5vCgM3Z+USWxcM/dtAjlcb7p/BPTyp604/gMm2A
         PXTye1wOi4fZWLbUzP3zUGjzLGQ2Ex3S0pnHcJu9m1P6yBuLBRfJ1ApbcUBsB2AT7h
         j2BULQbHlhmswoqCTngGE6bPhs8Li9tMVyOYDd+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6.2 165/242] ARM: dts: exynos: fix WM8960 clock name in Itop Elite
Date:   Mon, 15 May 2023 18:28:11 +0200
Message-Id: <20230515161726.831828533@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

commit 6c950c20da38debf1ed531e0b972bd8b53d1c11f upstream.

The WM8960 Linux driver expects the clock to be named "mclk".  Otherwise
the clock will be ignored and not prepared/enabled by the driver.

Cc: <stable@vger.kernel.org>
Fixes: 339b2fb36a67 ("ARM: dts: exynos: Add TOPEET itop elite based board")
Link: https://lore.kernel.org/r/20230217150627.779764-3-krzysztof.kozlowski@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/exynos4412-itop-elite.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
+++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
@@ -182,7 +182,7 @@
 		compatible = "wlf,wm8960";
 		reg = <0x1a>;
 		clocks = <&pmu_system_controller 0>;
-		clock-names = "MCLK1";
+		clock-names = "mclk";
 		wlf,shared-lrclk;
 		#sound-dai-cells = <0>;
 	};


