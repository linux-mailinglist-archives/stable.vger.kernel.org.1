Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C686FA484
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjEHKAP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjEHKAO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:00:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE4F2D409
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C94D4622AC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBA8C433EF;
        Mon,  8 May 2023 10:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540012;
        bh=5Or5I+sf5+beT4hrwEZHob3aNtQiozivCqxqd9luJ3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wa37Gnc6yFYnJb1OBHFPi8Z11YNEQbkzZ2xfHHBnTmnlUhSrtSE/ejYJUJR1uOjMA
         wlEwIC22AwJFNhJhXZg4zSHMjNqLFz7Un4iqJKSLGYmOnC37lVKwDLAeB42C+0K/j4
         LNk2Z4tz8PMq/s51O1+ifSFX8gK73XqzuOQWi22o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 178/611] arm64: dts: ti: k3-am625: Correct L2 cache size to 512KB
Date:   Mon,  8 May 2023 11:40:20 +0200
Message-Id: <20230508094428.154840505@linuxfoundation.org>
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

From: Vignesh Raghavendra <vigneshr@ti.com>

[ Upstream commit 6974371cab1c488a53960945cb139b20ebb5f16b ]

Per AM62x SoC datasheet[0] L2 cache is 512KB.

[0] https://www.ti.com/lit/gpn/am625 Page 1.

Fixes: f1d17330a5be ("arm64: dts: ti: Introduce base support for AM62x SoC")
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Link: https://lore.kernel.org/r/20230320044935.2512288-1-vigneshr@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am625.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625.dtsi b/arch/arm64/boot/dts/ti/k3-am625.dtsi
index 887f31c23fef6..31b37abbb8d5c 100644
--- a/arch/arm64/boot/dts/ti/k3-am625.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am625.dtsi
@@ -96,7 +96,7 @@
 	L2_0: l2-cache0 {
 		compatible = "cache";
 		cache-level = <2>;
-		cache-size = <0x40000>;
+		cache-size = <0x80000>;
 		cache-line-size = <64>;
 		cache-sets = <512>;
 	};
-- 
2.39.2



