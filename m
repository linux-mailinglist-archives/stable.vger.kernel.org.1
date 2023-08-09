Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44A7775C54
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjHIL0K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbjHIL0K (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:26:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5C7ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:26:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D32B163255
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8587CC433C7;
        Wed,  9 Aug 2023 11:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580368;
        bh=v8bfDM1755eZFiA5y5X1NtPjn61pSlyWr6c0+Oq0cgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rKg+A5pnMVERCv7DUGJ6gMvFyGau8RVEnOSLGkm+otqpJLXZ/TJvjXYJ+QDPouhN2
         FzrAcBd9gzoj7kUy40lFt4ipv/QG7nwtqAdWuY325JwA/MXuo19xC3xrgwMuPYwpic
         ukeIiMIGv8Geepv3hFG2EplIU8rw57qzrsTYn2p4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 4.19 323/323] arm64: dts: stratix10: fix incorrect I2C property for SCL signal
Date:   Wed,  9 Aug 2023 12:42:41 +0200
Message-ID: <20230809103712.873770548@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
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

From: Dinh Nguyen <dinguyen@kernel.org>

commit db66795f61354c373ecdadbdae1ed253a96c47cb upstream.

The correct dts property for the SCL falling time is
"i2c-scl-falling-time-ns".

Fixes: c8da1d15b8a4 ("arm64: dts: stratix10: i2c clock running out of spec")
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -125,7 +125,7 @@
 	status = "okay";
 	clock-frequency = <100000>;
 	i2c-sda-falling-time-ns = <890>;  /* hcnt */
-	i2c-sdl-falling-time-ns = <890>;  /* lcnt */
+	i2c-scl-falling-time-ns = <890>;  /* lcnt */
 
 	adc@14 {
 		compatible = "lltc,ltc2497";


