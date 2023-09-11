Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D648079B386
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350774AbjIKVlQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238903AbjIKOHi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:07:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CFECF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:07:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05917C433C8;
        Mon, 11 Sep 2023 14:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441254;
        bh=Vjat6pwbQ3VmY8kOMSe/J9x7nyo3HUkYfulJpjjKjpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b59R8O+KK0DwyF4zsWAad6jYf5zVwFIidt9JpzqVGkxOJ1Var5XQNZcScOlmJYS9A
         KsFo+XJvgB5xWhK2lyPmZ9INpEOhrgM0SmBIpT4jR9DdXF6pcNstOVBLUCH7hOkt2V
         wkWEYp9KSCuGzw/RPimWqVvVV3J+RcGRYjqxLG5Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aradhya Bhatia <a-bhatia1@ti.com>,
        Nishanth Menon <nm@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 341/739] arm64: dts: ti: k3-am62x-sk-common: Update main-i2c1 frequency
Date:   Mon, 11 Sep 2023 15:42:20 +0200
Message-ID: <20230911134700.631529859@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aradhya Bhatia <a-bhatia1@ti.com>

[ Upstream commit 73387da70f9c26b6fba4f62371d013cce14663d9 ]

The Display Data Channel (DDC) transactions between an HDMI transmitter
(SIL9022A in this case) and an HDMI monitor, occur at a maximum of
100KHz. That's the maximum supported frequency within DDC standards.

While the SIL9022A can transact with the core at 400KHz, it needs to
drop the frequency to 100KHz when communicating with the monitor,
otherwise, the i2c controller times out and shows warning like this.

[  985.773431] omap_i2c 20010000.i2c: controller timed out

That feature, however, has not been enabled in the SIL9022 driver.

Since, dropping the frequency doesn't affect any other devices on the
bus, drop the main-i2c1 frequency from 400KHz to 100KHz.

Fixes: a841581451af ("arm64: dts: ti: Refractor AM625 SK dts")
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Link: https://lore.kernel.org/r/20230809084559.17322-2-a-bhatia1@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 34c8ffc553ec3..540ed8a0d7fb6 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -300,7 +300,7 @@ &main_i2c1 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
-	clock-frequency = <400000>;
+	clock-frequency = <100000>;
 
 	tlv320aic3106: audio-codec@1b {
 		#sound-dai-cells = <0>;
-- 
2.40.1



