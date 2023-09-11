Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ED279B03A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242973AbjIKU6w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238906AbjIKOHm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:07:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83196E40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:07:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8FEC433C8;
        Mon, 11 Sep 2023 14:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441257;
        bh=Hx6eyoBYnb+pnGzYPtggFA0mLHPBX3H3UkMymILi7t4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YanaccKYaPOAulhXKkCDpO0SsDzdAgwPuBGRPPDrCzT1egk/xVOg1aJfpzcrWE17R
         jBqFkhdcbhcQkPFbP2TF4OT7FAtFFQtfV2sGBUAuOyOm+oBUw2+3VuP6Lce0mZPFnZ
         VRB/djMOwIEv6uPLNa1d2T0TJeGhAG0HEuA17m4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 350/739] arm64: dts: qcom: sc8280xp-x13s: Unreserve NC pins
Date:   Mon, 11 Sep 2023 15:42:29 +0200
Message-ID: <20230911134700.896062096@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 7868ed0144b33903e16a50485775f669c109e41a ]

Pins 83-86 and 158-160 are NC, so there's no point in keeping them
reserved. Take care of that.

Fixes: 32c231385ed4 ("arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230803-topic-x13s_pin-v1-1-fae792274e89@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 7cc3028440b64..059dfccdfe7c2 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -1246,7 +1246,7 @@ hastings_reg_en: hastings-reg-en-state {
 };
 
 &tlmm {
-	gpio-reserved-ranges = <70 2>, <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
+	gpio-reserved-ranges = <70 2>, <74 6>, <125 2>, <128 2>, <154 4>;
 
 	bt_default: bt-default-state {
 		hstp-bt-en-pins {
-- 
2.40.1



