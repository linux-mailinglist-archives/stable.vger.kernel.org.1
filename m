Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE326FAAEB
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjEHLH5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjEHLHm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:07:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADEF1FC8
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:06:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5472762AD1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E74C433EF;
        Mon,  8 May 2023 11:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544008;
        bh=ahUa1UfK+wXJpZr4jJUxGrRTFiAjG029VB0ciGgt0mA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G/JIT4s//xVhWAoN7wbGeGQw+hi7ZLQWBhR5gG/p9nhUs/THz2jal1t/9ueKqMTm0
         U4nF5kzExLkN+3vOqy8vO6QVI0+1roXG9LGLZNRFbzL+mmTUc1vRtpJwlBNcGyjguO
         1Vi5umjmOnxz1dvqsN36KMBvPsHVbg1vkR7OKv7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 272/694] arm64: dts: sdm845: Rename qspi data12 as data23
Date:   Mon,  8 May 2023 11:41:47 +0200
Message-Id: <20230508094441.080022080@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 37f7349b56decc91c66f8039712e63740b1f25f9 ]

There are 4 qspi data pins: data0, data1, data2, and data3. Currently
we have a shared pin state for data0 and data1 (2 lane config) and a
pin state for data2 and data3 (you'd enable both this and the 2 lane
state for 4 lanes). The second state is obviously misnamed. Fix it.

Fixes: e1ce853932b7 ("arm64: dts: qcom: sdm845: Add qspi (quad SPI) node")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230323102605.3.I88528d037b7fda4e53a40f661be5ac61628691cd@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 5e640e01e8518..c5e92851a4f08 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2763,7 +2763,7 @@
 				function = "qspi_data";
 			};
 
-			qspi_data12: qspi-data12-state {
+			qspi_data23: qspi-data23-state {
 				pins = "gpio93", "gpio94";
 				function = "qspi_data";
 			};
-- 
2.39.2



