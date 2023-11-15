Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFC77ED0B0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343841AbjKOT5E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343802AbjKOT4w (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:56:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DDCAF
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:56:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC061C433C8;
        Wed, 15 Nov 2023 19:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078208;
        bh=Zt21gXsip+1g+pq4ZRvj5hUoXF/RW206fEyUSLimth8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0wBDhyXq9kc6W1LULWm5Wo3uLoZRUcFx1yDxLHUCX9AqO6zrAv9K8MhQ0ZWTXVVr3
         NVihMYFw0MTSp1hsXfI8V/iXMGUXcIa4meMxahXPbEbCRyUXd9+N6V1wqXU+mhKrLm
         4KXUUOEtzX988SLzHLAXQrzHUgEcral86yjADcMg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fabio Estevam <festevam@denx.de>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 179/379] arm64: dts: imx8qm-ss-img: Fix jpegenc compatible entry
Date:   Wed, 15 Nov 2023 14:24:14 -0500
Message-ID: <20231115192655.691724607@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit 1d33cd614d89b0ec024d25ec45acf4632211b5a7 ]

The first compatible entry for the jpegenc should be 'nxp,imx8qm-jpgenc'.

Change it accordingly to fix the following schema warning:

imx8qm-apalis-eval.dtb: jpegenc@58450000: compatible: 'oneOf' conditional failed, one must be fixed:
	'nxp,imx8qm-jpgdec' is not one of ['nxp,imx8qxp-jpgdec', 'nxp,imx8qxp-jpgenc']
	'nxp,imx8qm-jpgenc' was expected
	'nxp,imx8qxp-jpgdec' was expected

Fixes: 5bb279171afc ("arm64: dts: imx8: Add jpeg encoder/decoder nodes")
Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-img.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-img.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-img.dtsi
index 7764b4146e0ab..2bbdacb1313f9 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-img.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-img.dtsi
@@ -8,5 +8,5 @@ &jpegdec {
 };
 
 &jpegenc {
-	compatible = "nxp,imx8qm-jpgdec", "nxp,imx8qxp-jpgenc";
+	compatible = "nxp,imx8qm-jpgenc", "nxp,imx8qxp-jpgenc";
 };
-- 
2.42.0



