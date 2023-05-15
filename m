Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6824D7038AE
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244291AbjEOReH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244295AbjEORdu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:33:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBF917947
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8586362083
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D909C433EF;
        Mon, 15 May 2023 17:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171893;
        bh=vStKJEne7Ft5xib0WFgd4nHsqJtxaId9XuTiXPhH6oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d6DuSkdBqAH1qFmk23mbUtgat6UpwlZegs5+rE058BW3+RcqJPiviN+qHAwni+JBR
         uRuLRcd28pvv2twC1U8DKTJKbyE5I3WjEG27Bc+xgkHQ2/wAhfKudWuslTa7w7KDhY
         oWGG9z+TdxMUUIYT+g/ONBAtaj2ZNC1zuJNj25pA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5.15 082/134] ARM: dts: exynos: fix WM8960 clock name in Itop Elite
Date:   Mon, 15 May 2023 18:29:19 +0200
Message-Id: <20230515161705.910692816@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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
@@ -179,7 +179,7 @@
 		compatible = "wlf,wm8960";
 		reg = <0x1a>;
 		clocks = <&pmu_system_controller 0>;
-		clock-names = "MCLK1";
+		clock-names = "mclk";
 		wlf,shared-lrclk;
 		#sound-dai-cells = <0>;
 	};


