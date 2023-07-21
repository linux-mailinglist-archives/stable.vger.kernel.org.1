Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D651C75CEC9
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjGUQYV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjGUQYG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:24:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58FE4482
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:20:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4794F61D3E
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4412EC433BD;
        Fri, 21 Jul 2023 16:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956432;
        bh=Tv4MD1Rnny7inpjVfJ9J0prHhkb7tYKIfRD4KpqOuAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h5bE3cm+fUyRtbwks0IY0UQlYOcrQDdFSjBoLOVFun2v8SII6kq1omGjHI1p0iHEN
         HLfvLJWhG49MWgGrXGf8Bb3Da6B8kVCRv+8SbWXsm7Sh7GDPkR4/kp4yAd+Cxqwrc3
         TLlFhEJCVtVWbXDx03HDPso6lKFMcvTq+WAU7HZM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Frank Wunderlich <frank-w@public-files.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 6.4 163/292] arm64: dts: mt7986: use size of reserved partition for bl2
Date:   Fri, 21 Jul 2023 18:04:32 +0200
Message-ID: <20230721160535.913900152@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

commit 7afe7b5969329175ac4f55a6b9c13ba4f6dc267e upstream.

To store uncompressed bl2 more space is required than partition is
actually defined.

There is currently no known usage of this reserved partition.
Openwrt uses same partition layout.

We added same change to u-boot with commit d7bb1099 [1].

[1] https://source.denx.de/u-boot/u-boot/-/commit/d7bb109900c1ca754a0198b9afb50e3161ffc21e

Cc: stable@vger.kernel.org
Fixes: 8e01fb15b815 ("arm64: dts: mt7986: add Bananapi R3")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Link: https://lore.kernel.org/r/20230528113343.7649-1-linux@fw-web.de
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso     | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso
index 84aa229e80f3..e48881be4ed6 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso
@@ -27,15 +27,10 @@ partitions {
 
 					partition@0 {
 						label = "bl2";
-						reg = <0x0 0x20000>;
+						reg = <0x0 0x40000>;
 						read-only;
 					};
 
-					partition@20000 {
-						label = "reserved";
-						reg = <0x20000 0x20000>;
-					};
-
 					partition@40000 {
 						label = "u-boot-env";
 						reg = <0x40000 0x40000>;
-- 
2.41.0



