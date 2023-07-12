Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2847C750739
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 13:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjGLLzM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 07:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjGLLyu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 07:54:50 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0716926B0;
        Wed, 12 Jul 2023 04:53:59 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b923910dd4so405642a34.1;
        Wed, 12 Jul 2023 04:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689162789; x=1689767589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lk2CkawsWRPhUJhT7owy+MSUDnvJYEHIC5w9ORyYobQ=;
        b=Km9zYC/U6UXcasyyGW1McNOjTg4581w63rMh1WmLdV8hhNk70SF+VsTtw72+4GSVhi
         tjj3rxoSkaVcbqvPfr87FIikooOFnixJtOxSXNKKvMPqzicEA5Fg3goHUPjbzq7jQ6A3
         yiaglOgdeLY99baAsNfsZMAc6cYhwhou8dukfGVwSeChImq+gC1DTIB9k7JIO6SLdRsU
         7tcnD+MFbdcZjiHDogLqxH942DciGVQBc6kz/TQPOpZ3Uy0UhwPgdqAotlqYarj5fMxu
         wSN0IsL5L/8X3RBwHIrxWo1x9hpFZbHEYqiuX0yMfFrDML+unOnMaa3HSekYxu24dPFc
         /R1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689162789; x=1689767589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lk2CkawsWRPhUJhT7owy+MSUDnvJYEHIC5w9ORyYobQ=;
        b=BxyhJGDYEvKBQ8FVIzcPiGUEkrT+LmvsUJC1c2CJxQBeqVAipnX5BE6aH/JuObtYQD
         vo6pXxbyF7nVi2owY4U3JxgMyuYdf0KXYc3WUI7Ht0BgS5mzEsRGSFb/9SAD/h67DxqG
         wDFTzh2crGqETGOjAegz2IvDU7yA8MNSGfNDX0oCoZNo9OUiL8NW0VglOq3ETsIZQtOC
         V/6k9L8wU8grornepYzb0QbyRHdNQfwqCh10dwuvmbsUjrZT0lhMAeimWam7KtfrDQAl
         2TdpFetk8drdxGCt48sxttFQxOTjUyrRrQT8Ff+DLZAx/KFwLG1I67/fxyX1/Qm/hDu6
         bPKA==
X-Gm-Message-State: ABy/qLZ4cr1JUMOX6BoNXMj44tgqNerF4QELM4UIoVNDXwo/9HqG11jl
        R+FeHLb/+4b0/ja6mrMGt60=
X-Google-Smtp-Source: APBJJlHEla6YNT5iMgxmsaeujd1HxpkpIWcPh/o2YYUbBsJqgGJgv5+E7pT2BZwaZYV6WiMOr2m5fw==
X-Received: by 2002:a05:6870:230d:b0:1b0:6500:8045 with SMTP id w13-20020a056870230d00b001b065008045mr13859449oao.1.1689162789293;
        Wed, 12 Jul 2023 04:53:09 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:ce5f:dbc6:1eb6:2900])
        by smtp.gmail.com with ESMTPSA id zh27-20020a0568716b9b00b001a663e49523sm1905890oab.36.2023.07.12.04.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 04:53:08 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     shawnguo@kernel.org
Cc:     hs@denx.de, linux-arm-kernel@lists.infradead.org, sboyd@kernel.org,
        abelvesa@kernel.org, linux-clk@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>, stable@vger.kernel.org
Subject: [PATCH v3 1/3] ARM: dts: imx6sx: Remove LDB endpoint
Date:   Wed, 12 Jul 2023 08:52:59 -0300
Message-Id: <20230712115301.690714-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

Remove the LDB endpoint description from the common imx6sx.dtsi
as it causes regression for boards that has the LCDIF connected
directly to a parallel display.

Let the LDB endpoint be described in the board devicetree file
instead.

Cc: stable@vger.kernel.org
Fixes: b74edf626c4f ("ARM: dts: imx6sx: Add LDB support")
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v2:
- Rebased against 6.5-rc1.

 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
index 3a4308666552..41c900929758 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
@@ -863,7 +863,6 @@ port@0 {
 							reg = <0>;
 
 							ldb_from_lcdif1: endpoint {
-								remote-endpoint = <&lcdif1_to_ldb>;
 							};
 						};
 
@@ -1309,11 +1308,8 @@ lcdif1: lcdif@2220000 {
 					power-domains = <&pd_disp>;
 					status = "disabled";
 
-					ports {
-						port {
-							lcdif1_to_ldb: endpoint {
-								remote-endpoint = <&ldb_from_lcdif1>;
-							};
+					port {
+						lcdif1_to_ldb: endpoint {
 						};
 					};
 				};
-- 
2.34.1

