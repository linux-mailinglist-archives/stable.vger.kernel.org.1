Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C5879B7E9
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354222AbjIKVwy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbjIKOKz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:10:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B86CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:10:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E0BC433C8;
        Mon, 11 Sep 2023 14:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441451;
        bh=0w1O3C+x8+cRw99KeV6noexjKSJfMGhXM6VMdW0WnPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LkT+7vzLSz1eHJHEniNoHu0xzjp6Tb7TJQ0471epqxGOnTAXSp0tLXZI+7R4FJoAY
         ogBKnMBNq2RV2ZZeLBe8QQe0U1E0k6LNX52gkRH9gc0hsZNgBhCfRkNrDOKXakL8LU
         mNUwEedtJquUI6rgbTmJyTj4m3kpbbmyc/pksV78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 400/739] clk: qcom: reset: Use the correct type of sleep/delay based on length
Date:   Mon, 11 Sep 2023 15:43:19 +0200
Message-ID: <20230911134702.354178891@linuxfoundation.org>
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

[ Upstream commit 181b66ee7cdd824797fc99b53bec29cf5630a04f ]

Use the fsleep() helper that (based on the length of the delay, see: [1])
chooses the correct sleep/delay functions.

[1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt

Fixes: 2cb8a39b6781 ("clk: qcom: reset: Allow specifying custom reset delay")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230726-topic-qcom_reset-v3-1-5958facd5db2@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/reset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
index 0e914ec7aeae1..e45e32804d2c7 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -16,7 +16,8 @@ static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
 	struct qcom_reset_controller *rst = to_qcom_reset_controller(rcdev);
 
 	rcdev->ops->assert(rcdev, id);
-	udelay(rst->reset_map[id].udelay ?: 1); /* use 1 us as default */
+	fsleep(rst->reset_map[id].udelay ?: 1); /* use 1 us as default */
+
 	rcdev->ops->deassert(rcdev, id);
 	return 0;
 }
-- 
2.40.1



