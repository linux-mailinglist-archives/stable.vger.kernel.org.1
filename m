Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6820579B5A2
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbjIKWXF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239826AbjIKO3o (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:29:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264A2F0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:29:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D17C433C8;
        Mon, 11 Sep 2023 14:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442579;
        bh=ndNe+vLgR9pUMLxASmAssrGbWMMzvapkPlFeMGHhgu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EV4B1MKQfRsMtLvxDlmdNi6xI4G9zh5sbRTzezVUJmH6KRiXwNVt3Ull8MISLTnwO
         3iTW+MlkA7WwLh8HKTMQs2iVybNwXuESb0Rxx73LSSMfgyaoEsQOBhSGWPD9LQ5lJ3
         MG+xNB/Jtev6Vg9cfxRpbNlkAPmFbuiM8Cyy3Z6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lin Yujun <linyujun809@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 075/737] ARM: dts: integrator: fix PCI bus dtc warnings
Date:   Mon, 11 Sep 2023 15:38:54 +0200
Message-ID: <20230911134652.610859863@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin Yujun <linyujun809@huawei.com>

[ Upstream commit 42ff49a1967af71772b264009659ce181f7d2d2a ]

An warning is reported when allmodconfig is used to compile the kernel of the ARM architecture:

arch/arm/boot/dts/arm/integratorap.dts:161.22-206.4: Warning (pci_bridge): /pciv3@62000000: node name is not "pci" or "pcie"

Change the node name to pci to clear the build warning.

Signed-off-by: Lin Yujun <linyujun809@huawei.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20230811-versatile-dts-v6-6-v1-1-d8cb9d1947ed@linaro.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/integratorap.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index 5b52d75bc6bed..d9927d3181dce 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -158,7 +158,7 @@
 		valid-mask = <0x003fffff>;
 	};
 
-	pci: pciv3@62000000 {
+	pci: pci@62000000 {
 		compatible = "arm,integrator-ap-pci", "v3,v360epc-pci";
 		device_type = "pci";
 		#interrupt-cells = <1>;
-- 
2.40.1



