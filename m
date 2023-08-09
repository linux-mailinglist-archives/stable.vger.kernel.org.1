Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31049775968
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjHILAO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjHILAM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:00:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776FC1FD8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:00:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6C3363144
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D428DC433C7;
        Wed,  9 Aug 2023 10:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578310;
        bh=m32v1OU2t/Sk7F7pAGVyC2uXdMNoNki8aX3j8pTj6hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xg9sdhxKjAJybEfE8T70f0A4Y4v3DVgVziAkO/MhbiHlYrLlkLW1CdMfLVMFqksgB
         J64OcoGxTboSaRsZIDMBq+mqVBX1fqM1pJMHH0aUSPZMOSoZyNwK6ekDP0SmfeZJ/Q
         4zO6XKajKjOtXzAfCMGe4XhbRD4dxIdXCmmtPiUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 014/127] arm64: dts: freescale: Fix VPU G2 clock
Date:   Wed,  9 Aug 2023 12:40:01 +0200
Message-ID: <20230809103637.108862719@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Benjamin Gaignard <benjamin.gaignard@collabora.com>

[ Upstream commit b27bfc5103c72f84859bd32731b6a09eafdeda05 ]

Set VPU G2 clock to 300MHz like described in documentation.
This fixes pixels error occurring with large resolution ( >= 2560x1600)
HEVC test stream when using the postprocessor to produce NV12.

Fixes: 4ac7e4a81272 ("arm64: dts: imx8mq: Enable both G1 and G2 VPU's with vpu-blk-ctrl")
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 4724ed0cbff94..bf8f02c1535c1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -756,7 +756,7 @@
 									 <&clk IMX8MQ_SYS1_PLL_800M>,
 									 <&clk IMX8MQ_VPU_PLL>;
 						assigned-clock-rates = <600000000>,
-								       <600000000>,
+								       <300000000>,
 								       <800000000>,
 								       <0>;
 					};
-- 
2.40.1



