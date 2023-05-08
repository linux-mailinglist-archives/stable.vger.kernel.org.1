Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C276FA490
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbjEHKA4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbjEHKAx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:00:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79C22D437
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:00:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C954622BE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7E4C433D2;
        Mon,  8 May 2023 10:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540046;
        bh=s+RkJHwfx+/S1xRGIHQNAAgbalalE2WFrz9H5e3o4Xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UB9tBxza3jmqyt9f3T3rzmmJj6nzjioI7KGvq/5XOAMQH9hXKP2PeFw/JvqVZTcjd
         nLVSB4f9Miy0jWhdQflFHbhscm3XFIk4FsVHB3ohjEvXE8zmlEMMy9zpvX8g3/JtDu
         VbJyntXlqu6ybKD9JVkFzt018Y/Tz6LsfMW92bLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 222/611] arm64: dts: sc7280: Rename qspi data12 as data23
Date:   Mon,  8 May 2023 11:41:04 +0200
Message-Id: <20230508094429.622387300@linuxfoundation.org>
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

[ Upstream commit 14acf21c0d3f7b7298ffcd2e5b5db4a476ec6202 ]

There are 4 qspi data pins: data0, data1, data2, and data3. Currently
we have a shared pin state for data0 and data1 (2 lane config) and a
pin state for data2 and data3 (you'd enable both this and the 2 lane
state for 4 lanes). The second state is obviously misnamed. Fix it.

Fixes: 7720ea001b52 ("arm64: dts: qcom: sc7280: Add QSPI node")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230323102605.2.I4043491bb24b1e92267c5033d76cdb0fe60934da@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -4345,7 +4345,7 @@
 				function = "qspi_data";
 			};
 
-			qspi_data12: qspi-data12-pins {
+			qspi_data23: qspi-data23-pins {
 				pins = "gpio16", "gpio17";
 				function = "qspi_data";
 			};


