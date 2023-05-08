Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D546FAAAD
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjEHLFb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbjEHLEs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:04:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2F72E82C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:04:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E812E61353
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0864C433D2;
        Mon,  8 May 2023 11:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543818;
        bh=w7nWp0v0nn2KG45md7CI3TUuCyLuzJymYTR6tDZGHDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gYDxc2Enhg1vh6CU08DYSEtg1mCO3yy0/RHOGwMvg+/8VmAr3opGn+ReQgnWt6xk2
         ezOPW/nkUdaKvPQSm5vvkS/ntmOkyMfZk27qyUxFySx+yCQH6oY+yZy2SGQW6Et08f
         AHxcdVc6vk0fZIvxIL3w4f1INQWHFLe2ElCHmw98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 180/694] soc: canaan: Make K210_SYSCTL depend on CLK_K210
Date:   Mon,  8 May 2023 11:40:15 +0200
Message-Id: <20230508094438.273355955@linuxfoundation.org>
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

From: Jesse Taube <mr.bossman075@gmail.com>

[ Upstream commit 49f965b6fbca63904d7397ce96066fa992f401a3 ]

CLK_K210 is no longer a dependency of SOC_CANAAN,
but K210_SYSCTL depends on CLK_K210. This patch makes K210_SYSCTL
depend on CLK_K210. Also fix whitespace errors.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/all/42446784-a88b-df09-41e9-5f685b4df6ee@infradead.org
Fixes: 3af577f9826f ("RISC-V: stop directly selecting drivers for SOC_CANAAN")
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/canaan/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/canaan/Kconfig b/drivers/soc/canaan/Kconfig
index 2527cf5757ec9..43ced2bf84447 100644
--- a/drivers/soc/canaan/Kconfig
+++ b/drivers/soc/canaan/Kconfig
@@ -3,8 +3,9 @@
 config SOC_K210_SYSCTL
 	bool "Canaan Kendryte K210 SoC system controller"
 	depends on RISCV && SOC_CANAAN && OF
+	depends on COMMON_CLK_K210
 	default SOC_CANAAN
-        select PM
-        select MFD_SYSCON
+	select PM
+	select MFD_SYSCON
 	help
 	  Canaan Kendryte K210 SoC system controller driver.
-- 
2.39.2



