Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC4379BCBB
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377823AbjIKW2t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbjIKOlS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:41:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDCC123
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:41:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86920C433C7;
        Mon, 11 Sep 2023 14:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443273;
        bh=wqRevlL1TunWb3hxt+3VpLah62AW3sA3p+MZY5U02uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vasLO5EhzNDhybHBpsH/nRv2ouWL+6QNVo/mvvoRjU4MWD0in4+EIX1Tnuf5OtVG5
         awo/rO9OhzGvChaePLXnjutDYrYJ4OHWr1gVJ6VCPVbrSyLEYXy/TmzE20nKiUWFnb
         zKCL1/+FlpEY6Lzl753R3IQYG1tXr+U+7kG/qi8I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 319/737] arm64: tegra: Fix HSUART for Smaug
Date:   Mon, 11 Sep 2023 15:42:58 +0200
Message-ID: <20230911134659.469984327@linuxfoundation.org>
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

From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>

[ Upstream commit 590bfe51838f6345a6a3288507661dc9b7208464 ]

After commit 71de0a054d0e ("arm64: tegra: Drop serial clock-names and
reset-names") was applied, the HSUART failed to probe and the following
error is seen:

 serial-tegra 70006300.serial: Couldn't get the reset
 serial-tegra: probe of 70006300.serial failed with error -2

Commit 71de0a054d0e ("arm64: tegra: Drop serial clock-names and
reset-names") is correct because the "reset-names" property is not
needed for 8250 UARTs. However, the "reset-names" is required for the
HSUART and should have been populated as part of commit a63c0cd83720c
("arm64: dts: tegra: smaug: Add Bluetooth node") that enabled the HSUART
for the Pixel C. Fix this by populating the "reset-names" property for
the HSUART on the Pixel C.

Fixes: a63c0cd83720 ("arm64: dts: tegra: smaug: Add Bluetooth node")
Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
index d7d7c63e62e25..79d294c2ee199 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
@@ -1312,6 +1312,7 @@ serial@70006000 {
 
 	uartd: serial@70006300 {
 		compatible = "nvidia,tegra30-hsuart";
+		reset-names = "serial";
 		status = "okay";
 
 		bluetooth {
-- 
2.40.1



