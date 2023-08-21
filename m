Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A45782F24
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 19:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbjHURKM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 13:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjHURKL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 13:10:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B851410D
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 10:10:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E4A86400F
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 17:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9C2C433C7;
        Mon, 21 Aug 2023 17:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692637799;
        bh=eJBYJRHZStr7l/a6ip14akFcrp8Xs6fKOMordGnP3Y4=;
        h=Subject:To:Cc:From:Date:From;
        b=rTe0WhQTTz5pu+MmyLuHE/hzlMo+bR/npvgIznh/1dz6tKBz0p/QUnahERSFfJw8l
         XIGyeHScUy5K5SObf9VxLFJYfssj8+t4ck8HWn6Nu1mabTJvFicQLTGX/9FtX8wLQp
         YV9wNfu8oiLsCcTQWi8iJBB3MQEBjldWVITm82yQ=
Subject: FAILED: patch "[PATCH] arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4" failed to apply to 5.4-stable tree
To:     chris.obbard@collabora.com, dev@folker-schwesinger.de,
        heiko@sntech.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 21 Aug 2023 19:09:56 +0200
Message-ID: <2023082156-capped-subtext-c4e2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x cee572756aa2cb46e959e9797ad4b730b78a050b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082156-capped-subtext-c4e2@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

cee572756aa2 ("arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4")
06c5b5690a57 ("arm64: dts: rockchip: sort nodes/properties on rk3399-rock-4")
69448624b770 ("arm64: dts: rockchip: fix regulator name on rk3399-rock-4")
8240e87f16d1 ("arm64: dts: rockchip: fix audio-supply for Rock Pi 4")
697dd494cb1c ("arm64: dts: rockchip: add SPDIF node for ROCK Pi 4")
65bd2b8bdb3b ("arm64: dts: rockchip: add ES8316 codec for ROCK Pi 4")
328c6112787b ("arm64: dts: rockchip: fix supplies on rk3399-rock-pi-4")
b5edb0467370 ("arm64: dts: rockchip: Mark rock-pi-4 as rock-pi-4a dts")
2bc65fef4fe4 ("arm64: dts: rockchip: rename label and nodename pinctrl subnodes that end with gpio")
7a87adbc4afe ("arm64: dts: rockchip: enable DC charger detection pullup on Pinebook Pro")
40df91a894e9 ("arm64: dts: rockchip: fix inverted headphone detection on Pinebook Pro")
5a65505a6988 ("arm64: dts: rockchip: Add initial support for Pinebook Pro")
c2753d15d2b3 ("arm64: dts: rockchip: split rk3399-rockpro64 for v2 and v2.1 boards")
cfd66c682e8b ("arm64: dts: rockchip: Add regulators for PCIe for Radxa Rock Pi 4 board")
023115cdea26 ("arm64: dts: rockchip: add thermal infrastructure to px30")
526ba2e2cf61 ("arm64: dts: rockchip: Enable PCIe for Radxa Rock Pi 4 board")
eb275167d186 ("Merge tag 'armsoc-dt' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cee572756aa2cb46e959e9797ad4b730b78a050b Mon Sep 17 00:00:00 2001
From: Christopher Obbard <chris.obbard@collabora.com>
Date: Wed, 5 Jul 2023 15:42:54 +0100
Subject: [PATCH] arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4

There is some instablity with some eMMC modules on ROCK Pi 4 SBCs running
in HS400 mode. This ends up resulting in some block errors after a while
or after a "heavy" operation utilising the eMMC (e.g. resizing a
filesystem). An example of these errors is as follows:

    [  289.171014] mmc1: running CQE recovery
    [  290.048972] mmc1: running CQE recovery
    [  290.054834] mmc1: running CQE recovery
    [  290.060817] mmc1: running CQE recovery
    [  290.061337] blk_update_request: I/O error, dev mmcblk1, sector 1411072 op 0x1:(WRITE) flags 0x800 phys_seg 36 prio class 0
    [  290.061370] EXT4-fs warning (device mmcblk1p1): ext4_end_bio:348: I/O error 10 writing to inode 29547 starting block 176466)
    [  290.061484] Buffer I/O error on device mmcblk1p1, logical block 172288
    [  290.061531] Buffer I/O error on device mmcblk1p1, logical block 172289
    [  290.061551] Buffer I/O error on device mmcblk1p1, logical block 172290
    [  290.061574] Buffer I/O error on device mmcblk1p1, logical block 172291
    [  290.061592] Buffer I/O error on device mmcblk1p1, logical block 172292
    [  290.061615] Buffer I/O error on device mmcblk1p1, logical block 172293
    [  290.061632] Buffer I/O error on device mmcblk1p1, logical block 172294
    [  290.061654] Buffer I/O error on device mmcblk1p1, logical block 172295
    [  290.061673] Buffer I/O error on device mmcblk1p1, logical block 172296
    [  290.061695] Buffer I/O error on device mmcblk1p1, logical block 172297

Disabling the Command Queue seems to stop the CQE recovery from running,
but doesn't seem to improve the I/O errors. Until this can be investigated
further, disable HS400 mode on the ROCK Pi 4 SBCs to at least stop I/O
errors from occurring.

While we are here, set the eMMC maximum clock frequency to 1.5MHz to
follow the ROCK 4C+.

Fixes: 1b5715c602fd ("arm64: dts: rockchip: add ROCK Pi 4 DTS support")
Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
Tested-By: Folker Schwesinger <dev@folker-schwesinger.de>
Link: https://lore.kernel.org/r/20230705144255.115299-2-chris.obbard@collabora.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index 907071d4fe80..95efee311ece 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -645,9 +645,9 @@ &saradc {
 };
 
 &sdhci {
+	max-frequency = <150000000>;
 	bus-width = <8>;
-	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
+	mmc-hs200-1_8v;
 	non-removable;
 	status = "okay";
 };

