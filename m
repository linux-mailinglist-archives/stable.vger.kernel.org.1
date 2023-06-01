Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D242719DE6
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjFAN10 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjFAN1I (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:27:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9D5125
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:26:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBE6F644C0
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAFFC433D2;
        Thu,  1 Jun 2023 13:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626012;
        bh=l8Sp1rRdzkG/FxY65CYqI3d8YVfl+w3I91K39+OAy5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yfISMLZSvJDzefWxxSkWGjafFqdIO11uuwg0GTyLfmF7/YOaobenlIqSTXCerTLt0
         1dRBRRR/y2DjCASeJF/113k+bjWyyr4P+ITBqEozKvGXyOSF+c4uTq4YsQxymToQ6q
         iixWXE26DuYML0t4kpGwZOwZSOPu3mntvOxAvQ58=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wyes Karny <wyes.karny@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 40/45] cpufreq: amd-pstate: Remove fast_switch_possible flag from active driver
Date:   Thu,  1 Jun 2023 14:21:36 +0100
Message-Id: <20230601131940.538835001@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wyes Karny <wyes.karny@amd.com>

[ Upstream commit 249b62c448de7117c18531d626aed6e153cdfd75 ]

amd_pstate active mode driver is only compatible with static governors.
Therefore it doesn't need fast_switch functionality. Remove
fast_switch_possible flag from amd_pstate active mode driver.

Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8dd46fad151eb..fda15b4a0770f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -996,7 +996,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	policy->policy = CPUFREQ_POLICY_POWERSAVE;
 
 	if (boot_cpu_has(X86_FEATURE_CPPC)) {
-		policy->fast_switch_possible = true;
 		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
 		if (ret)
 			return ret;
@@ -1019,7 +1018,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 {
 	pr_debug("CPU %d exiting\n", policy->cpu);
-	policy->fast_switch_possible = false;
 	return 0;
 }
 
-- 
2.39.2



