Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97F86FAACB
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjEHLGl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjEHLGS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:06:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59243557A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:05:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E717A62AA3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5486C433EF;
        Mon,  8 May 2023 11:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543906;
        bh=YHkcl1MdQC4V+K23BzzvIjP/4qT95taRjGoWL3baj/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fpe8yV07BfHGnXpLwO/4uJ9nHFilTwPxUS0u0tvxvf95i4vF61MEsN46Eh6nv4CUg
         5WuskJyrdTQG9IrXr/dT3mswRpi8mXY3upkvNdmM2GCGRkzX1sbMJ48YHAAIeDbhGs
         NglxCAbNHgKh7+MFHhetvF/7ewxE2xO1w6pbAu3Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dhruva Gole <d-gole@ti.com>,
        Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 239/694] arm64: dts: ti: k3-am625-sk: Add ti,vbus-divider property to usbss1
Date:   Mon,  8 May 2023 11:41:14 +0200
Message-Id: <20230508094440.093824958@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Dhruva Gole <d-gole@ti.com>

[ Upstream commit 4b71618cb772f20dfeeba826e9d1713a04f9687f ]

The property "ti,vbus-divider" is needed for both usbss0 and usbss1 as
both USB0 and USB1 have the same external voltage divider circuit.

Fixes: 2d94dfc43885 ("arm64: dts: ti: k3-am625-sk: Add support for USB")
Signed-off-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
Link: https://lore.kernel.org/r/20230328124315.123778-2-rogerq@kernel.org
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 6bc7d63cf52fe..4d5dec890ad66 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -480,6 +480,7 @@
 
 &usbss1 {
 	status = "okay";
+	ti,vbus-divider;
 };
 
 &usb0 {
-- 
2.39.2



