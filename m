Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DD76FA485
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbjEHKAU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjEHKAR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:00:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BF42D411
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F14062171
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F7BC433D2;
        Mon,  8 May 2023 10:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540015;
        bh=gq2WjvZrCRTLHkAf17YogQc9bKTAC7ierVRLqekK1uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dMaakPicD+ntfCLcpKnihEixv06tmVoHdCz7yCWyWeStbFfivxhPFLv3x5PsGBwp3
         6TYjw8bDVGodo7lRPb1QW+r0Sh8NtAWl3jPh7W0yiVLpvOjLB3gGTLtbHzAqJVtgYf
         Lbn33WAP8Xo/iHnJV+zhr+tVP9aRmKQifoBlzV7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 179/611] arm64: dts: ti: k3-am62a7: Correct L2 cache size to 512KB
Date:   Mon,  8 May 2023 11:40:21 +0200
Message-Id: <20230508094428.184659297@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vignesh Raghavendra <vigneshr@ti.com>

[ Upstream commit 438b8dc949bf45979c32553e96086ff1c6e2504e ]

Per AM62Ax SoC datasheet[0] L2 cache is 512KB.

[0] https://www.ti.com/lit/gpn/am62a7 Page 1.

Fixes: 5fc6b1b62639 ("arm64: dts: ti: Introduce AM62A7 family of SoCs")
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Link: https://lore.kernel.org/r/20230320044935.2512288-2-vigneshr@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7.dtsi b/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
index 331d89fda29d0..f1ebaec404fbc 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
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



