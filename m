Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CD3726B92
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjFGU03 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjFGU0X (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:26:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8961FDE
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:26:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ED4A64450
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4CCC433D2;
        Wed,  7 Jun 2023 20:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169548;
        bh=ff1S6i4jLOfLLDr5CzWF6ooM3A4D2S7c6EccFUBVNa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wgnTpGUz28LY+5GSzXtWCwfh4/nWoAQToGUgHUPTm4dnuZM2mQJ98Zou9v1gZEgnG
         h4rVIqCyfz/FU82zfgahGwUHTxD/ljVCG2DHKaq46DUsHz0RRcaWuwH4ueyuGQoqYi
         SB1Vr391OWek9RKWnPQ3510MIkqVjEV+lSfzDodU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 122/286] ASoC: dt-bindings: Adjust #sound-dai-cells on TIs single-DAI codecs
Date:   Wed,  7 Jun 2023 22:13:41 +0200
Message-ID: <20230607200927.067033112@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Martin Povišer <povik+lin@cutebit.org>

[ Upstream commit efb2bfd7b3d210c479b9361c176d7426e5eb8663 ]

A bunch of TI's codecs have binding schemas which force #sound-dai-cells
to one despite those codecs only having a single DAI. Allow for bindings
with zero DAI cells and deprecate the former non-zero value.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org
Link: https://lore.kernel.org/r/20230509153412.62847-1-povik+lin@cutebit.org
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/sound/tas2562.yaml | 6 ++++--
 Documentation/devicetree/bindings/sound/tas2770.yaml | 6 ++++--
 Documentation/devicetree/bindings/sound/tas27xx.yaml | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
index 1085592cefccc..81218c07079a8 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
@@ -55,7 +55,9 @@ properties:
     description: TDM TX current sense time slot.
 
   '#sound-dai-cells':
-    const: 1
+    # The codec has a single DAI, the #sound-dai-cells=<1>; case is left in for backward
+    # compatibility but is deprecated.
+    enum: [0, 1]
 
 required:
   - compatible
@@ -72,7 +74,7 @@ examples:
      codec: codec@4c {
        compatible = "ti,tas2562";
        reg = <0x4c>;
-       #sound-dai-cells = <1>;
+       #sound-dai-cells = <0>;
        interrupt-parent = <&gpio1>;
        interrupts = <14>;
        shutdown-gpios = <&gpio1 15 0>;
diff --git a/Documentation/devicetree/bindings/sound/tas2770.yaml b/Documentation/devicetree/bindings/sound/tas2770.yaml
index 982949ba8a4be..cdb493db47f9b 100644
--- a/Documentation/devicetree/bindings/sound/tas2770.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2770.yaml
@@ -57,7 +57,9 @@ properties:
       - 1 # Falling edge
 
   '#sound-dai-cells':
-    const: 1
+    # The codec has a single DAI, the #sound-dai-cells=<1>; case is left in for backward
+    # compatibility but is deprecated.
+    enum: [0, 1]
 
 required:
   - compatible
@@ -74,7 +76,7 @@ examples:
      codec: codec@41 {
        compatible = "ti,tas2770";
        reg = <0x41>;
-       #sound-dai-cells = <1>;
+       #sound-dai-cells = <0>;
        interrupt-parent = <&gpio1>;
        interrupts = <14>;
        reset-gpio = <&gpio1 15 0>;
diff --git a/Documentation/devicetree/bindings/sound/tas27xx.yaml b/Documentation/devicetree/bindings/sound/tas27xx.yaml
index 0957dd435bb4b..2ef05aacc167a 100644
--- a/Documentation/devicetree/bindings/sound/tas27xx.yaml
+++ b/Documentation/devicetree/bindings/sound/tas27xx.yaml
@@ -50,7 +50,9 @@ properties:
     description: TDM TX voltage sense time slot.
 
   '#sound-dai-cells':
-    const: 1
+    # The codec has a single DAI, the #sound-dai-cells=<1>; case is left in for backward
+    # compatibility but is deprecated.
+    enum: [0, 1]
 
 required:
   - compatible
@@ -67,7 +69,7 @@ examples:
      codec: codec@38 {
        compatible = "ti,tas2764";
        reg = <0x38>;
-       #sound-dai-cells = <1>;
+       #sound-dai-cells = <0>;
        interrupt-parent = <&gpio1>;
        interrupts = <14>;
        reset-gpios = <&gpio1 15 0>;
-- 
2.39.2



