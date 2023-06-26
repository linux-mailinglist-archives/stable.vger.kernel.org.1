Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F4F73E91F
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjFZScr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjFZScf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:32:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA3C10CC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:32:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32C0960F40
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443D2C433C8;
        Mon, 26 Jun 2023 18:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804353;
        bh=9fIJSvdYO46TvjcA/sHiZ/D2LUpdxE9tD8HDBQEf/MA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mP13LyCEGfNoed08dOlJvMBrKF7x5T8btvbKx7YDNyCRLwVCS736iUX2CF4IyR7iI
         qeqQJ7vMZrLmRU8ac+fMi7w/OCUm1ONdCjQSOVEtUzwt+tfnMgUZaEGsgmfxDPkALk
         EIJnxofnYSAfTZux/CpRWPN7Zg7PpCV7dgHe4Rwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 127/170] arm64: dts: rockchip: Enable GPU on SOQuartz CM4
Date:   Mon, 26 Jun 2023 20:11:36 +0200
Message-ID: <20230626180806.253568960@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>

[ Upstream commit e48824e8a03e5bc3666e9f5461f68d440d9acba0 ]

This enables the Mali-G52 GPU on the SOQuartz CM4 module.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Link: https://lore.kernel.org/r/20221112160404.70868-2-frattaroli.nicolas@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Stable-dep-of: cf9ae4a00774 ("arm64: dts: rockchip: fix nEXTRST on SOQuartz")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
index 4d494b53a71ab..4ceb9a979f6ad 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
@@ -143,6 +143,11 @@
 	status = "disabled";
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.39.2



