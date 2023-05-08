Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DB06FA48F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbjEHKAr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbjEHKAp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:00:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971302D439
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:00:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A7F7622BC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C84C433EF;
        Mon,  8 May 2023 10:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540043;
        bh=QX8W8u0UYodCboyNWc/hxK2HeStEPKYql8K4p9E4lsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1/GSVDAzj+FW0a707gmsYnaa0jM7ROoTWzMXf4zPG9fSM10y+z2892vPVbmvEY6Ci
         9qio4muaJqZkB0NpVh7KvF2j/rKd7KMwWaMBkWkBnoceyWqrTJWJ0C+hpBzD5c3doT
         q6a/uSnlqFk9zom9KXHaznqhFxu02H2t2Cp66Us4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 221/611] arm64: dts: sc7180: Rename qspi data12 as data23
Date:   Mon,  8 May 2023 11:41:03 +0200
Message-Id: <20230508094429.584378559@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

[ Upstream commit d84f8f2687bdc67f20262e822b206419bcfd0038 ]

There are 4 qspi data pins: data0, data1, data2, and data3. Currently
we have a shared pin state for data0 and data1 (2 lane config) and a
pin state for data2 and data3 (you'd enable both this and the 2 lane
state for 4 lanes). The second state is obviously misnamed. Fix it.

Fixes: ba3fc6496366 ("arm64: dts: sc7180: Add qupv3_0 and qupv3_1")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230323102605.1.Ifc1b5be04653f4ab119698a5944bfecded2080d6@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1521,7 +1521,7 @@
 				};
 			};
 
-			qspi_data12: qspi-data12 {
+			qspi_data23: qspi-data23 {
 				pinmux-data {
 					pins = "gpio66", "gpio67";
 					function = "qspi_data";


