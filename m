Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3095D7ECBF5
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjKOTZh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjKOTZc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:25:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EC919D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:25:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97C7C433C7;
        Wed, 15 Nov 2023 19:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076329;
        bh=xGdWC6oJhrdbp+6fwAZox5cqTC6l/SBtVCeRvO31CE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ch9a+IinJMn2gAPJ7FTWFhAI115UusBcnXs8Qf3t3kNAUALzrt2Zn/jNg9Zuvm3Om
         1C2SvlZOnejBa8KlwaJoZhX/BcBodwQZrXn2N9yQfpfWmtaKdJzw2DtFEEWB9Lt/ii
         XGzjQog4RKm9hbVnxzty0SQ/6M5SXiie/D+ORHlY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 197/550] hte: tegra: Fix missing error code in tegra_hte_test_probe()
Date:   Wed, 15 Nov 2023 14:13:01 -0500
Message-ID: <20231115191614.428745264@linuxfoundation.org>
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

From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

[ Upstream commit b7c3ca3553d1de5e86c85636828e186d30cd0628 ]

The value of 'ret' is zero when of_hte_req_count() fails to get number
of entitties to timestamp. And returning success(zero) on this failure
path is incorrect.

Fixes: 9a75a7cd03c9 ("hte: Add Tegra HTE test driver")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Reviewed-by: Dipen Patel <dipenp@nvidia.com>
Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hte/hte-tegra194-test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-test.c
index ba37a5efbf820..ab2edff018eb6 100644
--- a/drivers/hte/hte-tegra194-test.c
+++ b/drivers/hte/hte-tegra194-test.c
@@ -153,8 +153,10 @@ static int tegra_hte_test_probe(struct platform_device *pdev)
 	}
 
 	cnt = of_hte_req_count(hte.pdev);
-	if (cnt < 0)
+	if (cnt < 0) {
+		ret = cnt;
 		goto free_irq;
+	}
 
 	dev_info(&pdev->dev, "Total requested lines:%d\n", cnt);
 
-- 
2.42.0



