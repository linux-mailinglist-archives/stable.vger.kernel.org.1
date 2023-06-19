Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B45873524C
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjFSKdT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjFSKdS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:33:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E516BCA
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:33:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C2F160B67
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFBFC433C8;
        Mon, 19 Jun 2023 10:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170796;
        bh=5FCtmPR1WPvaKonQ5+eMTQzLrgA85GsmeSlUJHuAlIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cBJDZzXfVwNwsroAugLBYej+VoSo6B5ah3iztHKcq2q5Q86M49t3aAtIZGl1T9Pob
         jL1Sl7JBU1oYMNXsiICHcYeJ69uM+IvxAaBSdxWe6tZIPaF6BdZu5PeypHsJp60AQk
         XFyy7+MbYDm++nJhT2h/K+mzIbFJ/X1E6IHyEX1U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 013/187] arm64: dts: arm: add missing cache properties
Date:   Mon, 19 Jun 2023 12:27:11 +0200
Message-ID: <20230619102158.235608528@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 55b37d9c8ba23d28c584aef0801fb1e60e4a817c ]

As all level 2 and level 3 caches are unified, add required
cache-unified properties to fix warnings like:

  foundation-v8.dtb: l2-cache0: 'cache-unified' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230421223213.115639-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/arm/foundation-v8.dtsi           | 1 +
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts           | 1 +
 arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dtsi b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
index 029578072d8fb..7b41537731a6a 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dtsi
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
@@ -59,6 +59,7 @@ cpu3: cpu@3 {
 		L2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
index ef68f5aae7ddf..afdf954206f1d 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
@@ -72,6 +72,7 @@ cpu@3 {
 		L2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
index 796cd7d02eb55..7bdeb965f0a96 100644
--- a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
+++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
@@ -58,6 +58,7 @@ cpu@1 {
 		L2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
-- 
2.39.2



