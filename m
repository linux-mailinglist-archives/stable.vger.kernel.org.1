Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B3B79B6B3
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjIKWui (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241830AbjIKPPk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:15:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F216FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:15:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979CAC433C8;
        Mon, 11 Sep 2023 15:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445336;
        bh=shkzRltcLTmXJD/XfSU9ec923aUUSFPshvbiJtfvuOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYVFZYTIXT69d0OaV4nEvfuOjvcvA6XAWKTk+4boXFzjXtSB7M2MCE5NfuESAb7iu
         7z/uUNYYTjhpq/XmjzKxQLcPPkfskam30UZ9uYNfYQbH+qTK/8GuRRv1kwS11BkYCb
         WpwdyW6ZE4ANB1vLT2qMvR3X7A3myXaf0mx7foRs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 311/600] arm64: dts: qcom: sc8280xp-x13s: Unreserve NC pins
Date:   Mon, 11 Sep 2023 15:45:44 +0200
Message-ID: <20230911134642.827435277@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index b2b744bb8a538..49d15432aeabf 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -347,7 +347,7 @@ edp_bl_pwm: edp-bl-pwm-state {
 };
 
 &tlmm {
-	gpio-reserved-ranges = <70 2>, <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
+	gpio-reserved-ranges = <70 2>, <74 6>, <125 2>, <128 2>, <154 4>;
 
 	kybd_default: kybd-default-state {
 		disable {
-- 
2.40.1



