Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EB26FA442
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjEHJ5O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbjEHJ5I (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:57:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B87D30DD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE0E162263
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE795C433EF;
        Mon,  8 May 2023 09:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539826;
        bh=UVEioMCdxAv05b7rG6JC5IwSvwTQDblkk3VWrogHC5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=siqM+w/UWYreFxeTWWrxiyNfHff9BwxTH5w/XaRYUC/jRqloX1phcu9HWXa1CtYlo
         Zg79WyAVFflx+pC4ylO+CAxacCr5KGlAWhD4Mvoss3VRJ+Cva94VojaaD50OPabKgA
         xA384ptVna9pxZw+dz4s137KQ2Fb0KzG08Yltnqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Devarsh Thakkar <devarsht@ti.com>,
        Nishanth Menon <nm@ti.com>, Bryan Brattlof <bb@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 150/611] arm64: dts: ti: k3-am62a7-sk: Fix DDR size to full 4GB
Date:   Mon,  8 May 2023 11:39:52 +0200
Message-Id: <20230508094427.136785297@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Devarsh Thakkar <devarsht@ti.com>

[ Upstream commit a1bc0d6084dba8a31831c65318a8a8e46f00906f ]

All revisions of AM62A7-SK board have 4GB LPDDR4 Micron
MT53E2G32D4DE-046 AUT:B memory. Commit 38c4a08c820c ("arm64: dts: ti:
Add support for AM62A7-SK") enabled just 2GB due to a schematics error
in early revision of the board. Fix it by enabling full 4GB available on
the platform.

Design docs: https://www.ti.com/lit/zip/sprr459

Fixes: 38c4a08c820c ("arm64: dts: ti: Add support for AM62A7-SK")
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Bryan Brattlof <bb@ti.com>
Link: https://lore.kernel.org/r/20230314094645.3411599-1-devarsht@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 576dbce80ad83..b08a083d722d4 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -26,8 +26,9 @@
 
 	memory@80000000 {
 		device_type = "memory";
-		/* 2G RAM */
-		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
+		/* 4G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000000 0x80000000>;
 	};
 
 	reserved-memory {
-- 
2.39.2



