Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C467ECE96
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbjKOToI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbjKOToH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C1DB9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185F2C433CB;
        Wed, 15 Nov 2023 19:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077444;
        bh=UQO9uhItbvo0NvJyZwV1ZbRfRGnMW4zb6DYtIjBW6OU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XwYeoKxgzW41Hus7jY657mnw+xV88849TbM+HYzyF7OfsHAJAvH+FqKeYUpB1xdI9
         V4i57XmINJPSvmn0UeHgO25UFR+5JINRVO2l5p5p+0S4qvLtQECyWSFnKpmkTr2qiO
         wJCViMVezLvURZzgKgM2BMw9SUDD7TALmEeUrsCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wadim Egorov <w.egorov@phytec.de>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 307/603] arm64: dts: ti: k3-am625-beagleplay: Fix typo in ramoops reg
Date:   Wed, 15 Nov 2023 14:14:12 -0500
Message-ID: <20231115191634.662998871@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wadim Egorov <w.egorov@phytec.de>

[ Upstream commit 33269ac0b768b07da017df173d52952625c57870 ]

Seems like the address value of the reg property was mistyped.
Update reg to 0x9ca00000 to match node's definition.

Fixes: f5a731f0787f ("arm64: dts: ti: Add k3-am625-beagleplay")
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Reviewed-by: Nishanth Menon <nm@ti.com>
Link: https://lore.kernel.org/r/20230925151444.1856852-1-w.egorov@phytec.de
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 7cfdf562b53bf..2de74428a8bde 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -58,7 +58,7 @@ reserved-memory {
 
 		ramoops: ramoops@9ca00000 {
 			compatible = "ramoops";
-			reg = <0x00 0x9c700000 0x00 0x00100000>;
+			reg = <0x00 0x9ca00000 0x00 0x00100000>;
 			record-size = <0x8000>;
 			console-size = <0x8000>;
 			ftrace-size = <0x00>;
-- 
2.42.0



