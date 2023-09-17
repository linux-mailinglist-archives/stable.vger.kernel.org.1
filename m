Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0147A3B2B
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240623AbjIQUOB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240756AbjIQUNm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:13:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB897195
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:13:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FD4C433C8;
        Sun, 17 Sep 2023 20:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981609;
        bh=T7bcrBAT3B2mrpDiThxWXFxEBT7H1fohY3CdZ30bGJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E9ibumVP4hmrC0OaYX8BX3JKat6MfSlIrS8vv8nOiakR37xpWW8EXH6+9vU0Jp0x8
         Zc1PAbf+VBGXLkEj8H55Y6X5frvcfuGIkCVwkFOhUVFr2ggitjLQr81Ib7+6bD3VMT
         srAGRXD2rQnsoNF/HVvXvzlSqJcbZbBc46iHtk6s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liao Chang <liaochang1@huawei.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 078/511] cpufreq: powernow-k8: Use related_cpus instead of cpus in driver.exit()
Date:   Sun, 17 Sep 2023 21:08:25 +0200
Message-ID: <20230917191115.758604813@linuxfoundation.org>
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

From: Liao Chang <liaochang1@huawei.com>

[ Upstream commit 03997da042dac73c69e60d91942c727c76828b65 ]

Since the 'cpus' field of policy structure will become empty in the
cpufreq core API, it is better to use 'related_cpus' in the exit()
callback of driver.

Fixes: c3274763bfc3 ("cpufreq: powernow-k8: Initialize per-cpu data-structures properly")
Signed-off-by: Liao Chang <liaochang1@huawei.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/powernow-k8.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 12ab4014af712..94fe0e15623e4 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1101,7 +1101,8 @@ static int powernowk8_cpu_exit(struct cpufreq_policy *pol)
 
 	kfree(data->powernow_table);
 	kfree(data);
-	for_each_cpu(cpu, pol->cpus)
+	/* pol->cpus will be empty here, use related_cpus instead. */
+	for_each_cpu(cpu, pol->related_cpus)
 		per_cpu(powernow_data, cpu) = NULL;
 
 	return 0;
-- 
2.40.1



