Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A4877575A
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjHIKpA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjHIKo7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:44:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207651999
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4C4F63118
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2436C433C9;
        Wed,  9 Aug 2023 10:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577898;
        bh=1rkQX5lhEFSUurPfbpiqpu3sgvQc6cshAdfE1M4feso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXlP9/x2dUwpHCBH5Dpcirb4ab1RCxGGJ6kF9+LADYGOrxbHU9E62QeZ71+QLHnW1
         oD2eZzwnkQL4buKPPTn2HI8Xt4aznuemdzlTcAu7gC1/T/ogG3Hg/8OPAzh2qHokua
         13hlDYSC5fpOagLKgTMaTZeJ557YxTIBWF9brt7o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tim Harvey <tharvey@gateworks.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 006/165] arm64: dts: imx8mm-venice-gw7903: disable disp_blk_ctrl
Date:   Wed,  9 Aug 2023 12:38:57 +0200
Message-ID: <20230809103642.966660364@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tim Harvey <tharvey@gateworks.com>

[ Upstream commit 3e7d3c5e13b05dda9db92d98803a626378e75438 ]

The GW7903 does not connect the VDD_MIPI power rails thus MIPI is
disabled. However we must also disable disp_blk_ctrl as it uses the
pgc_mipi power domain and without it being disabled imx8m-blk-ctrl will
fail to probe:
imx8m-blk-ctrl 32e28000.blk-ctrl: error -ETIMEDOUT: failed to attach power domain "mipi-dsi"
imx8m-blk-ctrl: probe of 32e28000.blk-ctrl failed with error -110

Fixes: a72ba91e5bc7 ("arm64: dts: imx: Add i.mx8mm Gateworks gw7903 dts support")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
index 363020a08c9b8..4660d086cb099 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
@@ -567,6 +567,10 @@
 	status = "okay";
 };
 
+&disp_blk_ctrl {
+	status = "disabled";
+};
+
 &pgc_mipi {
 	status = "disabled";
 };
-- 
2.40.1



