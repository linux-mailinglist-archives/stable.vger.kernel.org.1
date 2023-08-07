Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618A17734D8
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 01:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjHGXTs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 19:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjHGXTs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 19:19:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479201710
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 16:19:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8BE5622DF
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 23:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F0EC433C7;
        Mon,  7 Aug 2023 23:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691450386;
        bh=FyjpDy896nlq5MnoS5RFNXBNl01oeD0KU4xIe7e4ksY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W9qNiOMuaXHlRIYVwR6IfpE6+QqUmahBQXQahAG5QwcDnr/JBLgU1S8oYn5eANR+C
         HT74XWHTlR4VNT9sOCzfd6RoN7j9Ddeu/p9skEW1O4wUierf8Vu1KDni74xGftsKwd
         p+yE7MGOaiw9zFkb0/XydZ4yZCIB9LjkGIItjVQcBq6niKraB8VQLZrwYwZDPyLhj8
         Ml094WOlIDMurCa0mzcpBEmIPb9vo9bmbEFgWOw9qYUGQ33PihNi9auk/WU/KUuMWj
         qy4R0cOaO05DDxif306DNoFHnQ7krNRaJoxB7sOIX4xFSvRKi8NFCn+8xf47yUzJFp
         UdSsCyITWcvoQ==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     stable@vger.kernel.org
Cc:     Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 5.4.y] arm64: dts: stratix10: fix incorrect I2C property for SCL signal
Date:   Mon,  7 Aug 2023 18:18:55 -0500
Message-Id: <20230807231855.703680-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2023080708-ocean-immorally-78ec@gregkh>
References: <2023080708-ocean-immorally-78ec@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The correct dts property for the SCL falling time is
"i2c-scl-falling-time-ns".

Fixes: c8da1d15b8a4 ("arm64: dts: stratix10: i2c clock running out of spec")
Cc: stable@vger.kernel.org
(cherry picked from commit db66795f61354c373ecdadbdae1ed253a96c47cb)
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 2c8c2b322c72..33f1fb9fd161 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -129,7 +129,7 @@
 	status = "okay";
 	clock-frequency = <100000>;
 	i2c-sda-falling-time-ns = <890>;  /* hcnt */
-	i2c-sdl-falling-time-ns = <890>;  /* lcnt */
+	i2c-scl-falling-time-ns = <890>;  /* lcnt */
 
 	adc@14 {
 		compatible = "lltc,ltc2497";
-- 
2.25.1

