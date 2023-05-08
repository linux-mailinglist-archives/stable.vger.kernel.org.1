Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65E26FA70C
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbjEHK0n (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbjEHK0P (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:26:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB5E25503
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:26:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1479A62605
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23467C433EF;
        Mon,  8 May 2023 10:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541567;
        bh=VV3TeFoi2qi62pbvbiLcg+I6l6PfFqD2H5ZWuELQWcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tYuljS6UrB+JhCfU+8RbT2keXm+qVkZ9O9yTE6a7iGMm6SRnkkyFPkETUSz48sdzH
         30JuLrHwEQoF9zfZGUlwukd07cOKs79WUwGokErcepwOrBwhO9CGertChHlkqxoYIx
         e/tToIwf5UJuQBjcZXskDt5IcLCvqzEUs+i+W4JU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 156/663] arm64: dts: broadcom: bcmbca: bcm4908: fix procmon nodename
Date:   Mon,  8 May 2023 11:39:42 +0200
Message-Id: <20230508094433.559172178@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit f16a8294dd7a02c7ad042cd2e3acc5ea06698dc1 ]

This fixes:
arch/arm64/boot/dts/broadcom/bcmbca/bcm94908.dtb: syscon@280000: $nodename:0: 'syscon@280000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
        From schema: schemas/simple-bus.yaml

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Link: https://lore.kernel.org/all/20230228144400.21689-3-zajec5@gmail.com/
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
index af5dc04aa1878..343b320cbd746 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
@@ -254,7 +254,7 @@
 			};
 		};
 
-		procmon: syscon@280000 {
+		procmon: bus@280000 {
 			compatible = "simple-bus";
 			reg = <0x280000 0x1000>;
 			ranges;
-- 
2.39.2



