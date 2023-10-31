Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167047DD4F4
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376333AbjJaRqB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376314AbjJaRp6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:45:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7118912D
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:45:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88173C433C8;
        Tue, 31 Oct 2023 17:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774353;
        bh=tmBHz4lOrqlaSCaevJD8m8A+E+lcTSa3zQix3chgSGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d7JPCpHXD/g3L0nTtmiM4iIACNT7zIXCghN9w+i4w+GVUr/xJMXiYHBvPnxxKknIV
         9KhzvQ8eevuqZPbjPpV9qAsemO5P/NjaRaJt3bvuFBeMluq6H5MdUZzKhtLdpv/KeQ
         wcVDuYWGc31plSk8NvMU5yzHH10/0TvLuk5sZhyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ermin Sunj <ermin.sunj@theobroma-systems.com>,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.5 017/112] arm64: dts: rockchip: use codec as clock master on px30-ringneck-haikou
Date:   Tue, 31 Oct 2023 18:00:18 +0100
Message-ID: <20231031165901.852765272@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ermin Sunj <ermin.sunj@theobroma-systems.com>

commit 84fa1865edbb3800f3344e2a5bc73c187adf42d0 upstream.

If the codec is not the clock master, the MCLK needs to be
synchronous to both I2S_SCL ans I2S_LRCLK. We do not have that
on Haikou, causing distorted audio.

Before:

 Running an audio test script on Ringneck, 1kHz
 output sine wave is not stable and shows distortion.

After:

 10h audio test script loop failed only one time.
 That is 0.00014% failure rate.

Cc: stable@vger.kernel.org
Fixes: c484cf93f61b ("arm64: dts: rockchip: add PX30-µQ7 (Ringneck) SoM with Haikou baseboard")
Signed-off-by: Ermin Sunj <ermin.sunj@theobroma-systems.com>
Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Link: https://lore.kernel.org/r/20230907151725.198347-1-jakob.unterwurzacher@theobroma-systems.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index 08a3ad3e7ae9..8792fae50257 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -68,15 +68,15 @@ i2s0-sound {
 		simple-audio-card,format = "i2s";
 		simple-audio-card,name = "Haikou,I2S-codec";
 		simple-audio-card,mclk-fs = <512>;
+		simple-audio-card,frame-master = <&sgtl5000_codec>;
+		simple-audio-card,bitclock-master = <&sgtl5000_codec>;
 
-		simple-audio-card,codec {
+		sgtl5000_codec: simple-audio-card,codec {
 			clocks = <&sgtl5000_clk>;
 			sound-dai = <&sgtl5000>;
 		};
 
 		simple-audio-card,cpu {
-			bitclock-master;
-			frame-master;
 			sound-dai = <&i2s0_8ch>;
 		};
 	};
-- 
2.42.0



