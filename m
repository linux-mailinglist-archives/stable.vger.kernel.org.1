Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39A274C267
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjGILUQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjGILUP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D80B5
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BBAE60BB7
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFE5C433C7;
        Sun,  9 Jul 2023 11:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901613;
        bh=Sc/Y6taSEYeoSv/ZciwiOBAlYZa0aU2zKcDbdnJhlYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jsCw47pNsqyAPrnWboF43iAnX4bG+QtUv10IBDIblzKriD6Ro8Y/2pnMNE0fILH0k
         evWO0VdmQo6NjQi81JWSkyimnIIGurZOtL+TeFwFOnE2K8kLijGo1Q3k8TB9wHQ3pm
         yU6qD0Q+k27ohWJsDatFEhPwwETC1nB4d6r6Ewuc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 082/431] spi: spi-geni-qcom: Correct CS_TOGGLE bit in SPI_TRANS_CFG
Date:   Sun,  9 Jul 2023 13:10:30 +0200
Message-ID: <20230709111453.073500455@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>

[ Upstream commit 5fd7c99ecf45c8ee8a9b1268f0ffc91cc6271da2 ]

The CS_TOGGLE bit when set is supposed to instruct FW to
toggle CS line between words. The driver with intent of
disabling this behaviour has been unsetting BIT(0). This has
not caused any trouble so far because the original BIT(1)
is untouched and BIT(0) likely wasn't being used.

Correct this to prevent a potential future bug.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org
Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI based QUP")
Reviewed-by: Douglas Anderson <dianders@chromium.org
Link: https://lore.kernel.org/r/1682412128-1913-1-git-send-email-quic_vnivarth@quicinc.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index baf477383682d..d147519fe1089 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -35,7 +35,7 @@
 #define CS_DEMUX_OUTPUT_SEL	GENMASK(3, 0)
 
 #define SE_SPI_TRANS_CFG	0x25c
-#define CS_TOGGLE		BIT(0)
+#define CS_TOGGLE		BIT(1)
 
 #define SE_SPI_WORD_LEN		0x268
 #define WORD_LEN_MSK		GENMASK(9, 0)
-- 
2.39.2



