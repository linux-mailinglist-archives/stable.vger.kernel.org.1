Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061F07A3915
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbjIQTof (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239965AbjIQToT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:44:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2159E7
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:44:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0AFC433C9;
        Sun, 17 Sep 2023 19:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979853;
        bh=6p+s9zXewaP5izUoTHdAfQcJZiBlzcCJ0v3zPtxlhuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O1F8m+iyuhOSnTiwx0ed+zpfHGm2ZB7yNmR7432uAizrErtmuo7mRhG3feHHkJbs8
         LRnzq45SiSb9PkO15/d484xcYBxYWL3k3MFdxEoukALULCWaSw0s3m2TI2ayUaxH3W
         QIeL12Bv/u/u1Tnk759/u+m1Rn9G4o2EAKOjC0OA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sheetal <sheetal@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Mohan Kumar D <mkumard@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 6.5 025/285] arm64: tegra: Update AHUB clock parent and rate on Tegra234
Date:   Sun, 17 Sep 2023 21:10:25 +0200
Message-ID: <20230917191052.512504639@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sheetal <sheetal@nvidia.com>

commit e483fe34adab3197558b7284044c1b26f5ede20e upstream.

I2S data sanity tests fail beyond a bit clock frequency of 6.144MHz.
This happens because the AHUB clock rate is too low and it shows
9.83MHz on boot.

The maximum rate of PLLA_OUT0 is 49.152MHz and is used to serve I/O
clocks. It is recommended that AHUB clock operates higher than this.
Thus fix this by using PLLP_OUT0 as parent clock for AHUB instead of
PLLA_OUT0 and fix the rate to 81.6MHz.

Fixes: dc94a94daa39 ("arm64: tegra: Add audio devices on Tegra234")
Cc: stable@vger.kernel.org
Signed-off-by: Sheetal <sheetal@nvidia.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -180,7 +180,8 @@
 				clocks = <&bpmp TEGRA234_CLK_AHUB>;
 				clock-names = "ahub";
 				assigned-clocks = <&bpmp TEGRA234_CLK_AHUB>;
-				assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLA_OUT0>;
+				assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLP_OUT0>;
+				assigned-clock-rates = <81600000>;
 				status = "disabled";
 
 				#address-cells = <2>;


