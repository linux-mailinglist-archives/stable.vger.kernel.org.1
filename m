Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CD779BE8D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240185AbjIKVEd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241376AbjIKPHX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:07:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84105FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:07:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0E5C433C8;
        Mon, 11 Sep 2023 15:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444839;
        bh=WGSvBHcR3LI9xIBZidaP6gntcYAZVDV6VBTdE6xDQG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DOTCNTwtFScPZ7yfXDzKtOHTF/CRHHFCvFTo+WtZ5nnXCQgIqY1E8AX2A7+ChZPZo
         PnakBusU9RVdH02WxZ4KHzeoFUYVf1HtTwf+KpZB0gnFkMGFp6/p6g+yut7ug7mRNb
         mcGwl+dqHAtAuco0Mkqspb0AL6Km6gTg0dmpx5o4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liao Chang <liaochang1@huawei.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 135/600] cpufreq: powernow-k8: Use related_cpus instead of cpus in driver.exit()
Date:   Mon, 11 Sep 2023 15:42:48 +0200
Message-ID: <20230911134637.597102754@linuxfoundation.org>
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
index d289036beff23..b10f7a1b77f11 100644
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



