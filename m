Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6482D755577
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjGPUlP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjGPUlM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:41:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA4A197
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:41:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 819E960E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C09C433C8;
        Sun, 16 Jul 2023 20:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540070;
        bh=G/+TS5VFaATf3n+2/coTI5rD/c41vh+4AU2iPlLxxcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a8w/+UMT5gHomVNDylRL6FRnE0htJIe3Nh8mCyW+m9AyD6HzJbAoMgwvE3XPi8xrV
         rtj4UtlUhXAmWIZMIMPxCr6rnQxscYfzfjZ4SA7MFSsEGo8YTHlf/9xS7Psi5+Eif0
         IF2gR0CCRQNEcwJiipFLNSLLfwJb4G+BRxcje24o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christian Lamparter <chunkeey@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 233/591] ARM: dts: BCM5301X: fix duplex-full => full-duplex
Date:   Sun, 16 Jul 2023 21:46:12 +0200
Message-ID: <20230716194929.902525068@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christian Lamparter <chunkeey@gmail.com>

[ Upstream commit fd274b733bfdde3ca72f0fa2a37f032f3a8c402c ]

this typo was found by the dtbs_check
| ports:port@5:fixed-link: 'oneOf' conditional failed,
|  {'speed': [[1000]], 'duplex-full': True} is not of type 'array'
| 'duplex-full' does not match any of the regexes: 'pinctrl-[0-]..."

this should have been full-duplex;

Fixes: 935327a73553 ("ARM: dts: BCM5301X: Add DT for Meraki MR26")
Fixes: ec88a9c344d9 ("ARM: BCM5301X: Add DT for Meraki MR32")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Link: https://lore.kernel.org/r/50522f45566951a9eabd22820647924cc6b4a264.1686238550.git.chunkeey@gmail.com
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm53015-meraki-mr26.dts | 2 +-
 arch/arm/boot/dts/bcm53016-meraki-mr32.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm53015-meraki-mr26.dts b/arch/arm/boot/dts/bcm53015-meraki-mr26.dts
index 14f58033efeb9..ca2266b936ee2 100644
--- a/arch/arm/boot/dts/bcm53015-meraki-mr26.dts
+++ b/arch/arm/boot/dts/bcm53015-meraki-mr26.dts
@@ -128,7 +128,7 @@ port@5 {
 
 			fixed-link {
 				speed = <1000>;
-				duplex-full;
+				full-duplex;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/bcm53016-meraki-mr32.dts b/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
index e678bc03d8165..008de8ee2584a 100644
--- a/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
+++ b/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
@@ -187,7 +187,7 @@ port@5 {
 
 			fixed-link {
 				speed = <1000>;
-				duplex-full;
+				full-duplex;
 			};
 		};
 	};
-- 
2.39.2



