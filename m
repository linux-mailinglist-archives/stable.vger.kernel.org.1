Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3497A3A4F
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240352AbjIQUCT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240357AbjIQUBo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:01:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28522CD0
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:01:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C24C433CB;
        Sun, 17 Sep 2023 20:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980865;
        bh=dz/2/v+fQS4jrTSMGSxEqjVYhrCGbH+IQd01/o18AEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Spa4kyADVKemMy7SgiIyfD0ISrUaNKB/kEmBjfDbXzFhIJvuYJjcSs2aoa1SoAx91
         Nr65s0/CeOjA+RUpFyH4WAuF+V0CpUaQ05KlYoj1UbbQdnKnOD5jwe/Yc0SrCKwxJP
         AKUzT69Jyy2ZhcyUOzK064BlEiEiwme6yvSiFcMw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tomohiro Komagata <tomohiro.komagata.aj@renesas.com>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 6.1 031/219] arm64: dts: renesas: rzg2l: Fix txdv-skew-psec typos
Date:   Sun, 17 Sep 2023 21:12:38 +0200
Message-ID: <20230917191042.124703946@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Paterson <chris.paterson2@renesas.com>

commit db67345716a52abb750ec8f76d6a5675218715f9 upstream.

It looks like txdv-skew-psec is a typo from a copy+paste. txdv-skew-psec
is not present in the PHY bindings nor is it in the driver.

Correct to txen-skew-psec which is clearly what it was meant to be.

Given that the default for txen-skew-psec is 0, and the device tree is
only trying to set it to 0 anyway, there should not be any functional
change from this fix.

Fixes: 361b0dcbd7f9 ("arm64: dts: renesas: rzg2l-smarc-som: Enable Ethernet")
Fixes: 6494e4f90503 ("arm64: dts: renesas: rzg2ul-smarc-som: Enable Ethernet on SMARC platform")
Fixes: ce0c63b6a5ef ("arm64: dts: renesas: Add initial device tree for RZ/G2LC SMARC EVK")
Cc: stable@vger.kernel.org # 6.1.y
Reported-by: Tomohiro Komagata <tomohiro.komagata.aj@renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230609221136.7431-1-chris.paterson2@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi  |    4 ++--
 arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi |    2 +-
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
@@ -100,7 +100,7 @@
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
-		txdv-skew-psec = <0>;
+		txen-skew-psec = <0>;
 		rxd0-skew-psec = <0>;
 		rxd1-skew-psec = <0>;
 		rxd2-skew-psec = <0>;
@@ -128,7 +128,7 @@
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
-		txdv-skew-psec = <0>;
+		txen-skew-psec = <0>;
 		rxd0-skew-psec = <0>;
 		rxd1-skew-psec = <0>;
 		rxd2-skew-psec = <0>;
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
@@ -77,7 +77,7 @@
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
-		txdv-skew-psec = <0>;
+		txen-skew-psec = <0>;
 		rxd0-skew-psec = <0>;
 		rxd1-skew-psec = <0>;
 		rxd2-skew-psec = <0>;
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
@@ -80,7 +80,7 @@
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
-		txdv-skew-psec = <0>;
+		txen-skew-psec = <0>;
 		rxd0-skew-psec = <0>;
 		rxd1-skew-psec = <0>;
 		rxd2-skew-psec = <0>;
@@ -107,7 +107,7 @@
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
-		txdv-skew-psec = <0>;
+		txen-skew-psec = <0>;
 		rxd0-skew-psec = <0>;
 		rxd1-skew-psec = <0>;
 		rxd2-skew-psec = <0>;


