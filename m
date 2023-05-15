Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BAB703935
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244444AbjEORkP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244583AbjEORj5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:39:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EB61527E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2CBA62DBD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A87C433D2;
        Mon, 15 May 2023 17:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172207;
        bh=+0VFB440BDw5dpQiODHMgyaBpzo4L+5etmiOL+KeIvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yb0jbNRri43zuZKghVkCI+3/N0TvZtvd1FLq0O16dbf4+nVeWmdHoFUIZfmxl4hLd
         4PvZdLpcUX8YbARSbFgnRzYnQGI+GfauYQWS9x38evSrgidnMqM2fL8k5fQvN0CFMs
         qhtZyfMSY9F2/8Vu/arDBXE42rBRrVHUV0JLxK4k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 079/381] arm64: dts: renesas: r8a774c0: Remove bogus voltages from OPP table
Date:   Mon, 15 May 2023 18:25:30 +0200
Message-Id: <20230515161740.385654718@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 554edc3e9239bb81e61be9f0f5dbbeb528a69e72 ]

According to the RZ/G Series, 2nd Generation Hardware User’s Manual
Rev. 1.11, the System CPU cores on RZ/G2E do not have their own power
supply, but use the common internal power supply (typical 1.03V).

Hence remove the "opp-microvolt" properties from the Operating
Performance Points table.  They are optional, and unused, when none of
the CPU nodes is tied to a regulator using the "cpu-supply" property.

Fixes: 231d8908a66fa98f ("arm64: dts: renesas: r8a774c0: Add OPPs table for cpu devices")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/8348e18a011ded94e35919cd8e17c0be1f9acf2f.1676560856.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 4c7d7e8f8e289..c4a6dfae93aad 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -49,17 +49,14 @@
 		opp-shared;
 		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
-			opp-microvolt = <820000>;
 			clock-latency-ns = <300000>;
 		};
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <820000>;
 			clock-latency-ns = <300000>;
 		};
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
-			opp-microvolt = <820000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
-- 
2.39.2



