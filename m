Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79616FAA79
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbjEHLDO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbjEHLCn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:02:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D44E67
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:01:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A7CA62A3E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E18BC433EF;
        Mon,  8 May 2023 11:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543704;
        bh=U7PV5EGW4rviqv8Z1kn7D7pdjOTUohDcLe8g0Z1eVFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YSK+xq3pcCUn0A8KBZI52gyclgqBSck/4NEWyAnOn8Ea/QC6EFcp/hbpNPitnAeTT
         b3cKZwEDhP2hLKdc2JG3AhUzwet02IUp+fD7es+gVj0uGeUFH9SrpRRB50ouZgx0fu
         Ip1TXUbMpOO87AokjW6Z0RnN/Lp0hEW6PTOsnRhw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bhavya Kapoor <b-kapoor@ti.com>,
        Nishanth Menon <nm@ti.com>, Diwakar Dhyani <d-dhyani@ti.com>,
        Nitin Yadav <n-yadav@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 173/694] arm64: dts: ti: k3-j721e-main: Remove ti,strobe-sel property
Date:   Mon,  8 May 2023 11:40:08 +0200
Message-Id: <20230508094438.022901956@linuxfoundation.org>
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

From: Bhavya Kapoor <b-kapoor@ti.com>

[ Upstream commit 4f4b30a777d3e61603119297965343a37be36435 ]

According to latest errata of J721e [1], (i2024) 'MMCSD: Peripherals
Do Not Support HS400' which applies to MMCSD0 subsystem. Speed modes
supported has been already updated but missed dropping 'ti,strobe-sel'
property which is only required by HS400 speed mode.

Thus, drop 'ti,strobe-sel' property from kernel dtsi for J721e SoC.

[1] https://www.ti.com/lit/er/sprz455/sprz455.pdf

Fixes: eb8f6194e807 ("arm64: dts: ti: k3-j721e-main: Update the speed modes supported and their itap delay values for MMCSD subsystems")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Diwakar Dhyani <d-dhyani@ti.com>
Reviewed-by: Nitin Yadav <n-yadav@ti.com>
Link: https://lore.kernel.org/r/20230203073724.29529-1-b-kapoor@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index c935622f01028..bfa296dce3a31 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -1180,7 +1180,6 @@
 		ti,itap-del-sel-mmc-hs = <0xa>;
 		ti,itap-del-sel-ddr52 = <0x3>;
 		ti,trm-icp = <0x8>;
-		ti,strobe-sel = <0x77>;
 		dma-coherent;
 	};
 
-- 
2.39.2



