Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9715078333B
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjHUT42 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjHUT41 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:56:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7A6FB
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:56:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B59E164607
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26D0C433C8;
        Mon, 21 Aug 2023 19:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647785;
        bh=wrNHVQLMKwx01yBzy+HQv/nDUYDt9rOVJ5y8YE06gas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0k/vmpFE1RH1Qr9FV269xu+5n4w2oiS5LXzmr9hLNlDCxXq7Twy/XOyFf5kl4KiFc
         zB7FYZEtTuWpFWOZSGFHwRUAHZl5n/iK6XqsyX0trlA8C2hv53AyX40gdgvHVguds0
         ZucZTUPGgRIp/ptZ+njuQ2824Jzn+yG3wC9QczYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christopher Obbard <chris.obbard@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 138/194] arm64: dts: rockchip: Disable HS400 for eMMC on ROCK 4C+
Date:   Mon, 21 Aug 2023 21:41:57 +0200
Message-ID: <20230821194128.755395247@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christopher Obbard <chris.obbard@collabora.com>

[ Upstream commit 2bd1d2dd808c60532283e9cf05110bf1bf2f9079 ]

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

Fixes: 246450344dad ("arm64: dts: rockchip: rk3399: Radxa ROCK 4C+")
Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
Link: https://lore.kernel.org/r/20230705144255.115299-3-chris.obbard@collabora.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
index f9884902f8745..c3f53aa1ea4ac 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
@@ -548,9 +548,8 @@
 &sdhci {
 	max-frequency = <150000000>;
 	bus-width = <8>;
-	mmc-hs400-1_8v;
+	mmc-hs200-1_8v;
 	non-removable;
-	mmc-hs400-enhanced-strobe;
 	status = "okay";
 };
 
-- 
2.40.1



