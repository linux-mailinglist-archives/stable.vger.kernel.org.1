Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A9A7ECCCB
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjKOTcf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbjKOTce (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:32:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E85319F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:32:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068C1C433C8;
        Wed, 15 Nov 2023 19:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076751;
        bh=q2PVEIktzp2SKJL00lD592NHKdxP07z2BgpxVHAZ/Po=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zzUzDllTQjIe/h9DTaaISMO4b88KCxcEqnkrFFpYxlMIn+x81I+Xjg8V17ahe80B9
         jojk99/7gmPdBM+Hcz7PkAemi1l349YdreIT2QBwRlTGDaSniLyT7WBq8Q892yjapo
         SLVTCeDjI1fOgVCV0o+Drt0T0VINL5onbPP0xDk0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 410/550] interconnect: qcom: sc8180x: Set ACV enable_mask
Date:   Wed, 15 Nov 2023 14:16:34 -0500
Message-ID: <20231115191629.183377421@linuxfoundation.org>
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

[ Upstream commit 0fcaaed3ff4b99e5b688b799f48989f1e4bb8a8b ]

ACV expects an enable_mask corresponding to the APPS RSC, fill it in.

Fixes: 9c8c6bac1ae8 ("interconnect: qcom: Add SC8180x providers")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230811-topic-acv-v2-4-765ad70e539a@linaro.org
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/qcom/sc8180x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qcom/sc8180x.c
index c76e3a6a98cdd..024930f24f1f7 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -1344,6 +1344,7 @@ static struct qcom_icc_node slv_qup_core_2 = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = BIT(3),
 	.num_nodes = 1,
 	.nodes = { &slv_ebi }
 };
-- 
2.42.0



