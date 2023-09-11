Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF55779B232
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345367AbjIKVTy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239966AbjIKOcp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:32:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39535F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:32:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81135C433C8;
        Mon, 11 Sep 2023 14:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442760;
        bh=tIMFiffZKRUW3WkZxP46aNBlsfFAhvHkOygP8g4tv8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=liqlSZO15yYcW8++Q2jOGpnVHQxPTrjlUqZtV3T6IsJnY2w/puIfCD6Ib2xBxKajo
         tTEbSXMVhAtlpqXP2u6r4rciFwHPY+2ql72sYVMpnn4QptrkgBCdLJYIB/PM3Q4D8q
         RqR8ipjRlnoPkGsY9ITa/LYk84K6iMWn9Z59lxDo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Viresh Kumar <viresh.kumar@linaro.org>,
        Sumit Gupta <sumitg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 138/737] cpufreq: tegra194: add online/offline hooks
Date:   Mon, 11 Sep 2023 15:39:57 +0200
Message-ID: <20230911134654.356075505@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sumit Gupta <sumitg@nvidia.com>

[ Upstream commit a3aa97be69a7cc14ddc2bb0add0b9c51cb74bf83 ]

Implement the light-weight tear down and bring up helpers to reduce the
amount of work to do on CPU offline/online operation.
This change helps to make the hotplugging paths much faster.

Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Link: https://lore.kernel.org/lkml/20230816033402.3abmugb5goypvllm@vireshk-i7/
[ Viresh: Fixed rebase conflict ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Stable-dep-of: de0e85b29edf ("cpufreq: tegra194: remove opp table in exit hook")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/tegra194-cpufreq.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 36dad5ea59475..4f572eb7842f5 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -508,6 +508,21 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static int tegra194_cpufreq_online(struct cpufreq_policy *policy)
+{
+	/* We did light-weight tear down earlier, nothing to do here */
+	return 0;
+}
+
+static int tegra194_cpufreq_offline(struct cpufreq_policy *policy)
+{
+	/*
+	 * Preserve policy->driver_data and don't free resources on light-weight
+	 * tear down.
+	 */
+	return 0;
+}
+
 static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
 				       unsigned int index)
 {
@@ -535,6 +550,8 @@ static struct cpufreq_driver tegra194_cpufreq_driver = {
 	.target_index = tegra194_cpufreq_set_target,
 	.get = tegra194_get_speed,
 	.init = tegra194_cpufreq_init,
+	.online = tegra194_cpufreq_online,
+	.offline = tegra194_cpufreq_offline,
 	.attr = cpufreq_generic_attr,
 };
 
-- 
2.40.1



