Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F167ECCDA
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbjKOTc6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjKOTc6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:32:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203F119D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:32:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861A8C433C7;
        Wed, 15 Nov 2023 19:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076774;
        bh=B52WIjoht8AGPHts7TuAt8YeLuY/fLSZ/iyYgMsz8VE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ADGYRGmqrC8KonZiq81x6X6uPl0EXPqs+KCXrfU5P3IlfQTsfbkqiEjpKKOq6TPE2
         EIYkMuruLKqkHqRAmwNUo9ogd4oTsz3FvFiJDWbD/txGY6MsioEbgDSIpMSLzKkeLA
         YAXexVqoxw4MYi8xXdGE3aTuHcOdlB7KcNExwSIc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 417/550] interconnect: qcom: sm6350: Set ACV enable_mask
Date:   Wed, 15 Nov 2023 14:16:41 -0500
Message-ID: <20231115191629.667785829@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit fe7a3abf4111992af3de51d22383a8e8a0affe1e ]

ACV expects an enable_mask corresponding to the APPS RSC, fill it in.

Fixes: 6a6eff73a954 ("interconnect: qcom: Add SM6350 driver support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230811-topic-acv-v2-8-765ad70e539a@linaro.org
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/qcom/sm6350.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sm6350.c b/drivers/interconnect/qcom/sm6350.c
index 8a33a39f13260..aae4b43b730c0 100644
--- a/drivers/interconnect/qcom/sm6350.c
+++ b/drivers/interconnect/qcom/sm6350.c
@@ -144,6 +144,7 @@ DEFINE_QNODE(xs_sys_tcu_cfg, SM6350_SLAVE_TCU, 1, 8);
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = BIT(3),
 	.keepalive = false,
 	.num_nodes = 1,
 	.nodes = { &ebi },
-- 
2.42.0



