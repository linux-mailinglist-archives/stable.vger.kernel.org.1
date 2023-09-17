Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C677A3BB9
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbjIQUV2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbjIQUVU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:21:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8805810A
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:21:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC48C433C7;
        Sun, 17 Sep 2023 20:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982075;
        bh=xpKGV79LMQjIvPdw+UVYlas2kTLW9qMnILBDGHD4vlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xJWGdWGHO/1HuheLn5So+3iwzPNzeg4QABa981w5ZS4Us0og73XUKGTE17Euv2qeR
         QfKxzqNjCHQfI1yt5g8cejzaX7AsKPcWk+QvWOWuK+NVKKd1SBFuwSTYntaLSEejx+
         SPAOB2ODvif8382lwVhE18rlXFjbDEiBjBwEc9C4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 147/511] arm64: dts: qcom: pmi8994: Remove hardcoded linear WLED enabled-strings
Date:   Sun, 17 Sep 2023 21:09:34 +0200
Message-ID: <20230917191117.405001279@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marijn Suijten <marijn.suijten@somainline.org>

[ Upstream commit 9b729b0932d0e6097d9f103e9dd149ef10881f43 ]

The driver now sets an appropriate default for WLED4 (and WLED5) just
like WLED3 making this linear array from 0-3 redundant.  In addition the
driver is now able to parse arrays of variable length solving the "all
four strings *have to* be defined" comment.

Besides the driver will now warn when both properties are specified to
prevent ambiguity: the length of the array is enough to imply a set
number of strings.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-By: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20211007213400.258371-12-marijn.suijten@somainline.org
Stable-dep-of: 8db944326903 ("arm64: dts: qcom: pmi8994: Add missing OVP interrupt")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/pmi8994.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pmi8994.dtsi b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
index 7b41c1ed464ac..166467b637527 100644
--- a/arch/arm64/boot/dts/qcom/pmi8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
@@ -39,8 +39,6 @@ pmi8994_wled: wled@d800 {
 			interrupts = <3 0xd8 0x02 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "short";
 			qcom,num-strings = <3>;
-			/* Yes, all four strings *have to* be defined or things won't work. */
-			qcom,enabled-strings = <0 1 2 3>;
 			qcom,cabc;
 			qcom,external-pfet;
 			status = "disabled";
-- 
2.40.1



