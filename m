Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56176761448
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjGYLRm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbjGYLRh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:17:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7DD99
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:17:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8D556166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AE0C433CB;
        Tue, 25 Jul 2023 11:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283855;
        bh=upDRi5XA/xGN59LYW5xg4m///czAqNETzmL3DKZ1Jts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bBvY7+TaSdSf+wpgxL8FBL92v9HVPwOMUJzDDj98npAehsFwLARJ0Vkmnjc33nor9
         QtcpQsqLF3z8S34fyDmF3aDi3PZ4HuaW2C+7QJv/OMtdJvj3it5ZkuktzHVAgtKHHh
         noGdDHeu7cQ7EXLDRApQHPMzbjzGkWBaMshertcw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 146/509] ARM: dts: stm32: fix i2s endpoint format property for stm32mp15xx-dkx
Date:   Tue, 25 Jul 2023 12:41:25 +0200
Message-ID: <20230725104600.414863219@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Olivier Moysan <olivier.moysan@foss.st.com>

[ Upstream commit 076c74c592cabe4a47537fe5205b5b678bed010d ]

Use "dai-format" to configure DAI audio format as specified in
audio-graph-port.yaml bindings.

Fixes: 144d1ba70548 ("ARM: dts: stm32: Adapt STM32MP157 DK boards to stm32 DT diversity")
Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index 47df8ac67cf1a..75869d6a1ab24 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -406,7 +406,7 @@ &i2s2 {
 	i2s2_port: port {
 		i2s2_endpoint: endpoint {
 			remote-endpoint = <&sii9022_tx_endpoint>;
-			format = "i2s";
+			dai-format = "i2s";
 			mclk-fs = <256>;
 		};
 	};
-- 
2.39.2



