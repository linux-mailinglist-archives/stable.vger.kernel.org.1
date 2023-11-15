Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E777ECE8C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbjKOTnx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbjKOTnv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:43:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05C71B1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:43:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA10C433C9;
        Wed, 15 Nov 2023 19:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077427;
        bh=gqUEHkyZ7Mdqe8iuxDWpbS3tLvimXLm/stoNFjoUwlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iVIDZMTWkXkzp/zqZx04FZnL1/NVVW/ivPQsoiqKpUe5C27JbzdpHvQ+HQxzU5dDy
         ReyAh1LLYTF40SQf9We/7ZerN0ICRT5YDVyFiUbI/oDiv1MEEb4EYpKlJwUfb4GjyV
         i8XRe0/yrn04upPH6tloKhLbj+STyddF4IV8goUc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Wang <kevinyang.wang@amd.com>,
        "Kunwu.Chan" <chentao@kylinos.cn>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 271/603] drm/amd/pm: Fix a memory leak on an error path
Date:   Wed, 15 Nov 2023 14:13:36 -0500
Message-ID: <20231115191632.094539252@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kunwu.Chan <chentao@kylinos.cn>

[ Upstream commit 828f8e31379b28fe7f07fb5865b8ed099d223fca ]

Add missing free on an error path.

Fixes: 511a95552ec8 ("drm/amd/pm: Add SMU 13.0.6 support")
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Kunwu.Chan <chentao@kylinos.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index de80e191a92c4..24d6811438c5c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1968,8 +1968,10 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	metrics = kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
 	ret = smu_v13_0_6_get_metrics_table(smu, metrics, true);
-	if (ret)
+	if (ret) {
+		kfree(metrics);
 		return ret;
+	}
 
 	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
-- 
2.42.0



