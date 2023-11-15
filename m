Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8007ECBAE
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjKOTXt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjKOTXs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:23:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA071AD
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:23:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EE6C433CA;
        Wed, 15 Nov 2023 19:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076224;
        bh=k8jU+qNIFcXbcEodNZN6HPtXANJ+oF4G10v+co4lYJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PEoYKursX816V8U+a8xyJS/Xu3OJTzEC5pIq4bCXtAEWPPJFOwysJMf5jswlFCbxw
         4152tBujV7bteYGzJ4/ispLdCsvjiQzRmu+aIoHNuHnRBaHNfzlEEvduSEdaqUP8xr
         bygBIyzkXqBEEflCTaP1dTgenF+Oi99a/86G/nV8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Devi Priya <quic_devipriy@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 155/550] clk: qcom: clk-rcg2: Fix clock rate overflow for high parent frequencies
Date:   Wed, 15 Nov 2023 14:12:19 -0500
Message-ID: <20231115191611.447319061@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Devi Priya <quic_devipriy@quicinc.com>

[ Upstream commit f7b7d30158cff246667273bd2a62fc93ee0725d2 ]

If the parent clock rate is greater than unsigned long max/2 then
integer overflow happens when calculating the clock rate on 32-bit systems.
As RCG2 uses half integer dividers, the clock rate is first being
multiplied by 2 which will overflow the unsigned long max value.
Hence, replace the common pattern of doing 64-bit multiplication
and then a do_div() call with simpler mult_frac call.

Fixes: bcd61c0f535a ("clk: qcom: Add support for root clock generators (RCGs)")
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Link: https://lore.kernel.org/r/20230901073640.4973-1-quic_devipriy@quicinc.com
[bjorn: Also drop unnecessary {} around single statements]
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/clk-rcg2.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index e22baf3a7112a..5183c74b074f8 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -158,17 +158,11 @@ static int clk_rcg2_set_parent(struct clk_hw *hw, u8 index)
 static unsigned long
 calc_rate(unsigned long rate, u32 m, u32 n, u32 mode, u32 hid_div)
 {
-	if (hid_div) {
-		rate *= 2;
-		rate /= hid_div + 1;
-	}
+	if (hid_div)
+		rate = mult_frac(rate, 2, hid_div + 1);
 
-	if (mode) {
-		u64 tmp = rate;
-		tmp *= m;
-		do_div(tmp, n);
-		rate = tmp;
-	}
+	if (mode)
+		rate = mult_frac(rate, m, n);
 
 	return rate;
 }
-- 
2.42.0



