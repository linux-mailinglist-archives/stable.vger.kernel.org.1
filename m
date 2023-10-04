Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C4F7B886F
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243735AbjJDSQK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244056AbjJDSQJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:16:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228D1BF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:16:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681FBC433CA;
        Wed,  4 Oct 2023 18:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443364;
        bh=FiryUqGOkGl0lR4tdUeVjKMLlsvX42tVriU8K+rdXlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tpkvEMx4DygXRqcS8EcEtHp3k91Ul7VgIWMKIzRxscqUqtCoUSh/0P0YsEGVngQwt
         5c++/bQP0jmsPNlV8K5vv0k8mlxhXvvDemB8UE3dflbt/Rg7wdk4tnamjLYNFxgwNE
         ZtHcqfShLPFec4bvltT3ZbJWYGfuF9CHNEFzofC4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aleksey Nasibulin <alealexpro100@ya.ru>,
        Christian Marangi <ansuelsmth@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 092/259] ARM: dts: BCM5301X: Extend RAM to full 256MB for Linksys EA6500 V2
Date:   Wed,  4 Oct 2023 19:54:25 +0200
Message-ID: <20231004175221.582176110@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksey Nasibulin <alealexpro100@ya.ru>

[ Upstream commit 91994e59079dcb455783d3f9ea338eea6f671af3 ]

Linksys ea6500-v2 have 256MB of ram. Currently we only use 128MB.
Expand the definition to use all the available RAM.

Fixes: 03e96644d7a8 ("ARM: dts: BCM5301X: Add basic DT for Linksys EA6500 V2")
Signed-off-by: Aleksey Nasibulin <alealexpro100@ya.ru>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org
Acked-by: Rafał Miłecki <rafal@milecki.pl>
Link: https://lore.kernel.org/r/20230712014017.28123-1-ansuelsmth@gmail.com
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts b/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
index f1412ba83defb..0454423fe166c 100644
--- a/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
+++ b/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
@@ -19,7 +19,8 @@
 
 	memory@0 {
 		device_type = "memory";
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000>,
+		      <0x88000000 0x08000000>;
 	};
 
 	gpio-keys {
-- 
2.40.1



