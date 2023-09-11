Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781AF79BACB
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjIKWqw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241798AbjIKPOu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:14:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECF2FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:14:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6209EC433C8;
        Mon, 11 Sep 2023 15:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445285;
        bh=wuuQxkqdlaKhAPeF6YfbdiFIk5/T3j6YxfhingqXH+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0KPLsM2wZnCWjnjjgQ5n1hQgAGYO1skwTPoz5OdryM2M1zmyq5iUc/rdnehnL+S14
         /FkRkWhDXQeezXdBBM1rCUoAVvg5KYNblhCLbQETAwVCUplfqgI5/u6+WUjWcFfgqh
         9MPceUAF4vz+peRu66DixcKa7s4LyRjumX1Ms+8U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 254/600] arm64: tegra: Fix HSUART for Jetson AGX Orin
Date:   Mon, 11 Sep 2023 15:44:47 +0200
Message-ID: <20230911134641.100924136@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jon Hunter <jonathanh@nvidia.com>

[ Upstream commit 861dbb2b15b1049113887fb95e856f7123eea0cc ]

After commit 71de0a054d0e ("arm64: tegra: Drop serial clock-names and
reset-names") was applied, the HSUART failed to probe and the following
error is seen:

 serial-tegra 3100000.serial: Couldn't get the reset
 serial-tegra: probe of 3100000.serial failed with error -2

Commit 71de0a054d0e ("arm64: tegra: Drop serial clock-names and
reset-names") is correct because the "reset-names" property is not
needed for 8250 UARTs. However, the "reset-names" is required for the
HSUART and should have been populated as part of commit ff578db7b693
("arm64: tegra: Enable UART instance on 40-pin header") that
enabled the HSUART for Jetson AGX Orin. Fix this by populating the
"reset-names" property for the HSUART on Jetson AGX Orin.

Fixes: ff578db7b693 ("arm64: tegra: Enable UART instance on 40-pin header")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index 57ab753288144..f094011be9ed9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -2004,6 +2004,7 @@ interrupt-controller@2a40000 {
 
 		serial@3100000 {
 			compatible = "nvidia,tegra194-hsuart";
+			reset-names = "serial";
 			status = "okay";
 		};
 
-- 
2.40.1



