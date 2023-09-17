Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0F87A3925
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239972AbjIQTpi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239905AbjIQTpU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:45:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FD419F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:45:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23DBC433C8;
        Sun, 17 Sep 2023 19:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979905;
        bh=Eq+N04DxwXMDAOJ085dzkitG0mh/YnPITlGgdULigL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AzkvvKMaD/SI5VxsZxL6H2GefhXUwvxA4c+6ZxwdjPgY+9yLpwVv1VAmH8VcixvaW
         1LD2gUY4xd+9eszPvBf8BOm2XgO3NlB+Qjm9P6DmVYbIA3JnkhSJQKeYwoFXywciqi
         JD8IllQShbXZTS6MOIpgOTrIo7Q1GDi+7tPXKE1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aleksey Nasibulin <alealexpro100@ya.ru>,
        Christian Marangi <ansuelsmth@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 6.5 033/285] ARM: dts: BCM5301X: Extend RAM to full 256MB for Linksys EA6500 V2
Date:   Sun, 17 Sep 2023 21:10:33 +0200
Message-ID: <20230917191052.815074909@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksey Nasibulin <alealexpro100@ya.ru>

commit 91994e59079dcb455783d3f9ea338eea6f671af3 upstream.

Linksys ea6500-v2 have 256MB of ram. Currently we only use 128MB.
Expand the definition to use all the available RAM.

Fixes: 03e96644d7a8 ("ARM: dts: BCM5301X: Add basic DT for Linksys EA6500 V2")
Signed-off-by: Aleksey Nasibulin <alealexpro100@ya.ru>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org
Acked-by: Rafał Miłecki <rafal@milecki.pl>
Link: https://lore.kernel.org/r/20230712014017.28123-1-ansuelsmth@gmail.com
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6500-v2.dts |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6500-v2.dts
+++ b/arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6500-v2.dts
@@ -19,7 +19,8 @@
 
 	memory@0 {
 		device_type = "memory";
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000>,
+		      <0x88000000 0x08000000>;
 	};
 
 	gpio-keys {


