Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C8674C358
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjGILbV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjGILbT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:31:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B3CE40
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:31:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1371660B86
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AD0C433C7;
        Sun,  9 Jul 2023 11:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902266;
        bh=9kyalZM9Ve6poow92aJANGuY7lczQPWx+rgTMjAzMHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mqLkIt9EhsD/I1gVuqQ/P/DLugyy+HeijTHsA5Q91cDszP2iV41Xyi4Gfp4EGI6OQ
         aNA9J3y9B+yY0TwaLVwU8DYVCHXUDkYIXHnQ+2UXwwhIRwL5KgCZUxXiQ/fllmf2gF
         7vJD6NKB96xPkpoeYR+T+d0+5L37HgoIyH/ipgEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Golle <daniel@makrotopia.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 315/431] arm64: dts: mt7986: increase bl2 partition on NAND of Bananapi R3
Date:   Sun,  9 Jul 2023 13:14:23 +0200
Message-ID: <20230709111458.566493578@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit 3bfbff9b461e3506dfb5b2904e8c15a0aea39e07 ]

The bootrom burned into the MT7986 SoC will try multiple locations on
the SPI-NAND flash to load bl2 in case the bl2 image located at the the
previously attempted offset is corrupt.

Use 0x100000 instead of 0x80000 as partition size for bl2 on SPI-NAND,
allowing for up to four redundant copies of bl2 (typically sized a
bit less than 0x40000).

Fixes: 8e01fb15b8157 ("arm64: dts: mt7986: add Bananapi R3")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Link: https://lore.kernel.org/r/ZH9UGF99RgzrHZ88@makrotopia.org
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso     | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso
index 15ee8c568f3c3..543c13385d6e3 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dtso
@@ -29,13 +29,13 @@ partitions {
 
 					partition@0 {
 						label = "bl2";
-						reg = <0x0 0x80000>;
+						reg = <0x0 0x100000>;
 						read-only;
 					};
 
-					partition@80000 {
+					partition@100000 {
 						label = "reserved";
-						reg = <0x80000 0x300000>;
+						reg = <0x100000 0x280000>;
 					};
 
 					partition@380000 {
-- 
2.39.2



