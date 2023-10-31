Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC6F7DD4F5
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376286AbjJaRqD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376296AbjJaRqB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:46:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A25F9
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:45:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D89EC433C7;
        Tue, 31 Oct 2023 17:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774357;
        bh=KKYXmChCHkiRq4jd3AgL6138Es6NqWYm0e1VohCYmGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n2HYJQDlKGtLj/ajEcRpUdDvCBY2rHCXb0p3GJnijwkhBgNlmYpstWkiWnXd0OnTW
         JhObivYEHMTLG/Snf2RKKglo+Gn3q+TFaG7k1OgDGXicoyiXf792jDiUeb/3enzu9s
         +3UZUR4DKX3zMcPrANeDFh708p0kCeAzMtUfooqA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.5 018/112] arm64: dts: rockchip: set codec system-clock-fixed on px30-ringneck-haikou
Date:   Tue, 31 Oct 2023 18:00:19 +0100
Message-ID: <20231031165901.882382937@linuxfoundation.org>
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

From: Jakob Unterwurzacher <jakobunt@gmail.com>

commit 1e585cd0aad3d491938230318d6d479f09589fd8 upstream.

Having sgtl5000_clk defines as "fixed-clock" is not enough to prevent
the dai subsystem from overwriting the frequency via sgtl5000_set_dai_sysclk.

Setting system-clock-fixed does the job, and now a 1kHz sine wave
comes out as actually 1kHz, no matter the sample rate of the source.

Testcase: These should sound the same:

 speaker-test -r 48000 -t sine -f 1000
 speaker-test -r 24000 -t sine -f 1000

Also remove the clock link here as having it in sgtl5000 and
sgtl5000_codec causes duplicate clock unprepares with associated
backtrace.

Cc: stable@vger.kernel.org
Fixes: c484cf93f61b ("arm64: dts: rockchip: add PX30-µQ7 (Ringneck) SoM with Haikou baseboard")
Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Link: https://lore.kernel.org/r/20230907151725.198347-2-jakob.unterwurzacher@theobroma-systems.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index 8792fae50257..de0a1f2af983 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -72,8 +72,10 @@ i2s0-sound {
 		simple-audio-card,bitclock-master = <&sgtl5000_codec>;
 
 		sgtl5000_codec: simple-audio-card,codec {
-			clocks = <&sgtl5000_clk>;
 			sound-dai = <&sgtl5000>;
+			// Prevent the dai subsystem from overwriting the clock
+			// frequency. We are using a fixed-frequency oscillator.
+			system-clock-fixed;
 		};
 
 		simple-audio-card,cpu {
-- 
2.42.0



