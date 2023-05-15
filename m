Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B246C703938
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244506AbjEORkY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244604AbjEORkA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:40:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF5E1B766
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:37:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF8DA62DEA
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D465AC433EF;
        Mon, 15 May 2023 17:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172204;
        bh=yNNOQDUTepK3CVuIAj0W+0yKY+IttWeLcLyIp9e+2Cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zxhA8b8wQTV/HWNq3f/RT8rrKAJMMOzFyJsSTwKQ3wMbkb6KUfWblaVId6ITY7l9X
         K9ys8E5TJy4XeRdtgJpCapG8tTnJP4lE8wrm73nvlMhsc/xFGCtBD5bS+9K8ubTq41
         zqiezwdVlOUzSaE/jY7FbGVhdDstEMQmyL/IZXR4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 078/381] arm64: dts: renesas: r8a77990: Remove bogus voltages from OPP table
Date:   Mon, 15 May 2023 18:25:29 +0200
Message-Id: <20230515161740.337883098@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit fb76b0fae3ca880363214e1dcd6513ab8bd529e7 ]

According to the R-Car Series, 3rd Generation Hardware User’s Manual
Rev. 2.30, the System CPU cores on R-Car E3 do not have their own power
supply, but use the common internal power supply (typical 1.03V).

Hence remove the "opp-microvolt" properties from the Operating
Performance Points table.  They are optional, and unused, when none of
the CPU nodes is tied to a regulator using the "cpu-supply" property.

Fixes: dd7188eb4ed128dc ("arm64: dts: renesas: r8a77990: Add OPPs table for cpu devices")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/9232578d9d395d529f64db3333a371e31327f459.1676560856.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index 37159b9408e8a..e91d197a4c0b4 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -60,17 +60,14 @@
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



