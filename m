Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF267876DD
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbjHXRUi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242731AbjHXRUN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:20:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E228E1BCE
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:20:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F57E67534
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90647C433C7;
        Thu, 24 Aug 2023 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897609;
        bh=crGNLcgC7vSOsfx8YO+AI2R31vkeZYgv8hLYHodnwyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDGl/1VYQOD/dsCdLsUpZVyou2o0VrZm9BdtzlXSzH3Yo32vOyVrc4MzS4qcoScLF
         0VVT+wrGgOXNVamXp3uCQ+BiTnPaPKFhzbFvAkmNm66JuloI2p/jOzm0ABL9r0Famr
         p3f7GFsn5z3Z+brZCrqQhKStx2kQfBkXn4UGPD3U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christopher Obbard <chris.obbard@collabora.com>,
        Folker Schwesinger <dev@folker-schwesinger.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 101/135] arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4
Date:   Thu, 24 Aug 2023 19:09:33 +0200
Message-ID: <20230824170621.645368037@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christopher Obbard <chris.obbard@collabora.com>

[ Upstream commit cee572756aa2cb46e959e9797ad4b730b78a050b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index 360a31d2c56cc..2f52b91b72152 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -607,9 +607,9 @@
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
-- 
2.40.1



