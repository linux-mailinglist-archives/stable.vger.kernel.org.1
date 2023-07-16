Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEE17552DC
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjGPUMu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjGPUMt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:12:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193A51BF
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:12:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BE0660E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0658C433C7;
        Sun, 16 Jul 2023 20:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538367;
        bh=MEjax2E3uwZ/Q7uTHGyL3toADYhbdwMSK5uHSBlQBd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZ47hK/U3BD2U9H/OQagbnuumvL5eF6qeUScGLigEClqs/S5FW+n0sUOTXmWWpdnO
         nXurzfYRdplCAuHVqyDTrlhFv09dF6E4Ltvzyemzf4n2sGH4neNuAf6c5bJjmMnU5z
         Jtzgako/CPrrSjJwoykCfuuwyboUB8ZRZ6nq7jwM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nishanth Menon <nm@ti.com>,
        Udit Kumar <u-kumar1@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 396/800] arm64: dts: ti: k3-am69-sk: Fix main_i2c0 alias
Date:   Sun, 16 Jul 2023 21:44:09 +0200
Message-ID: <20230716194958.268848727@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

[ Upstream commit b38c6ced4ec5b3f6260ff6cc2b71e8a3d8c897d7 ]

main_i2c0 is aliased as i2c0 which creates a problem for u-boot R5
SPL attempting to reuse the same definition in the common board
detection logic as it looks for the first i2c instance as the bus on
which to detect the eeprom to understand the board variant involved.
Switch main_i2c0 to i2c3 alias allowing us to introduce wkup_i2c0
and potentially space for mcu_i2c instances in the gap for follow on
patches.

Fixes: 635fb18ba008 ("arch: arm64: dts: Add support for AM69 Starter Kit")
Signed-off-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Link: https://lore.kernel.org/r/20230602214937.2349545-5-nm@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index bc49ba534790e..f364b7803115d 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -23,7 +23,7 @@ chosen {
 	aliases {
 		serial2 = &main_uart8;
 		mmc1 = &main_sdhci1;
-		i2c0 = &main_i2c0;
+		i2c3 = &main_i2c0;
 	};
 
 	memory@80000000 {
-- 
2.39.2



