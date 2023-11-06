Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FE67E242C
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjKFNTH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjKFNTG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:19:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240FAEA
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:19:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B3CC433C8;
        Mon,  6 Nov 2023 13:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276743;
        bh=/15aIqyeJFNo0X5tCUafy/N2Q6N/4tVXWv24UiPCeWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6MxwVDbK49EF8+eEsnZ5q2/hViaO/3m56G6/jPFANpj/jFqmNhVTExMHUYnYojcA
         RZ6aLkrTvnHh8jtt7rY4oTriQUThVxV3+2jlxufvOrZTToi9ZWx/hssNtN52I4cJYJ
         oUxv7ZQZgF2BwsIfwRPxvBbAwvTeyPhtbRSSMnBY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jisheng Zhang <jszhang@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>,
        Guo Ren <guoren@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 53/88] riscv: dts: thead: set dma-noncoherent to soc bus
Date:   Mon,  6 Nov 2023 14:03:47 +0100
Message-ID: <20231106130307.779341093@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jisheng Zhang <jszhang@kernel.org>

[ Upstream commit 759426c758c7053a941a4c06c7571461439fcff6 ]

riscv select ARCH_DMA_DEFAULT_COHERENT by default, and th1520 isn't
dma coherent, so set dma-noncoherent to reflect this fact.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Tested-by: Drew Fustini <dfustini@baylibre.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 56a73134b49e6..58108f0eb3fdc 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -139,6 +139,7 @@
 		interrupt-parent = <&plic>;
 		#address-cells = <2>;
 		#size-cells = <2>;
+		dma-noncoherent;
 		ranges;
 
 		plic: interrupt-controller@ffd8000000 {
-- 
2.42.0



