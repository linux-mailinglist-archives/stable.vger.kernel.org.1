Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB96278728D
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241858AbjHXOzJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241881AbjHXOyn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:54:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4956D19AA
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:54:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D23BB66F12
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22ABC433C7;
        Thu, 24 Aug 2023 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888879;
        bh=4ekIoDOeQ/wRY7PYnPbq5+7CG80MAJvR0ynrsZ/aMpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z7OnMn1137ehYALouAYYLSYBXpMBtpFxEVNgY3RtfQCBOHTWujirWa22XazCX2RNn
         F4y7A68J3/rrdrv/UQiiLSWt7X1CdAgDZ+vKbYdZHDyQc9At07sGzEm7/7GQX4zlP6
         y/WBFElrFWZ2WLAcZiTyb04Q+/j0ITsdhBcd9wpY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zev Weiss <zev@bewilderbeest.net>,
        Joel Stanley <joel@jms.id.au>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 047/139] ARM: dts: aspeed: asrock: Correct firmware flash SPI clocks
Date:   Thu, 24 Aug 2023 16:49:30 +0200
Message-ID: <20230824145025.647268228@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zev Weiss <zev@bewilderbeest.net>

[ Upstream commit 9dedb724446913ea7b1591b4b3d2e3e909090980 ]

While I'm not aware of any problems that have occurred running these
at 100 MHz, the official word from ASRock is that 50 MHz is the
correct speed to use, so let's be safe and use that instead.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Cc: stable@vger.kernel.org
Fixes: 2b81613ce417 ("ARM: dts: aspeed: Add ASRock E3C246D4I BMC")
Fixes: a9a3d60b937a ("ARM: dts: aspeed: Add ASRock ROMED8HM3 BMC")
Link: https://lore.kernel.org/r/20230224000400.12226-4-zev@bewilderbeest.net
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
index 9b4cf5ebe6d5f..c62aff908ab48 100644
--- a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
@@ -63,7 +63,7 @@ flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-max-frequency = <100000000>; /* 100 MHz */
+		spi-max-frequency = <50000000>; /* 50 MHz */
 #include "openbmc-flash-layout.dtsi"
 	};
 };
-- 
2.40.1



