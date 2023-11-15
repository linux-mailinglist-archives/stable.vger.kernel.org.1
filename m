Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29AB7ED11B
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343996AbjKOT7c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344036AbjKOT71 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:59:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5F7AF
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:59:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC9BC433C7;
        Wed, 15 Nov 2023 19:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078364;
        bh=lktR4Azq16bUmOIYoiPzoAoZRZ7JCaTp3teotlPvpGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOXhtszjvEBnUsqBs5qj1iL9haW7Ni3H/+V10C+mRGwjcKzOpzhsBcfZy3WvmNV0g
         D+04RNEYIHb1dpPEgqZEAca31Vk0s5OYJIRyBKgmE3Gcp1o+iS80TFz0rNfiv4h6G6
         dTcgaORhOR3h8rZqTGU2j6ZcDYQaN7REwgkyeSCQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fabien Parent <fparent@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh@kernel.org>, Lee Jones <lee@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 243/379] dt-bindings: mfd: mt6397: Add binding for MT6357
Date:   Wed, 15 Nov 2023 14:25:18 -0500
Message-ID: <20231115192659.506746374@linuxfoundation.org>
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

From: Fabien Parent <fparent@baylibre.com>

[ Upstream commit 118ee241c423636c03527eada8f672301514751e ]

Add binding documentation for the MT6357 PMIC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20221005-mt6357-support-v3-1-7e0bd7c315b2@baylibre.com
Stable-dep-of: 61fdd1f1d2c1 ("dt-bindings: mfd: mt6397: Split out compatible for MediaTek MT6366 PMIC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/mfd/mt6397.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index 0088442efca1a..518986c44880f 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -21,6 +21,7 @@ Required properties:
 compatible:
 	"mediatek,mt6323" for PMIC MT6323
 	"mediatek,mt6331" for PMIC MT6331 and MT6332
+	"mediatek,mt6357" for PMIC MT6357
 	"mediatek,mt6358" for PMIC MT6358 and MT6366
 	"mediatek,mt6359" for PMIC MT6359
 	"mediatek,mt6397" for PMIC MT6397
-- 
2.42.0



