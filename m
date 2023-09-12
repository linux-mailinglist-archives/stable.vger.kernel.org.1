Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375E879B551
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbjIKVKW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbjIKOce (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:32:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C9CF2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:32:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A374C433C9;
        Mon, 11 Sep 2023 14:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442749;
        bh=zk4i8iV0nzGISLrws/4c8XaQHukTHcX/KSGiAmkHhek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iIC3Ieh2qpJAiUhEJKkQVb8auh+ExRbzAL7Y+fY4KDLhrkBrwJKfagReUGDuMp9kl
         w5uxadjOXY9qiykF66Va4rn8sgvnC5auUVIs3SbqWMkzA7e2f0RWKuQVHGvCt4MRx1
         zDK87/NfJ5op4SHTZr2k8FXw/QGc84v0HdJTbaj0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Meng Li <li.meng@amd.com>, Wyes Karny <wyes.karny@amd.com>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 135/737] cpufreq: amd-pstate-ut: Fix kernel panic when loading the driver
Date:   Mon, 11 Sep 2023 15:39:54 +0200
Message-ID: <20230911134654.275329639@linuxfoundation.org>
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

From: Swapnil Sapkal <swapnil.sapkal@amd.com>

[ Upstream commit 60dd283804479c4a52f995b713f448e2cd65b8c8 ]

After loading the amd-pstate-ut driver, amd_pstate_ut_check_perf()
and amd_pstate_ut_check_freq() use cpufreq_cpu_get() to get the policy
of the CPU and mark it as busy.

In these functions, cpufreq_cpu_put() should be used to release the
policy, but it is not, so any other entity trying to access the policy
is blocked indefinitely.

One such scenario is when amd_pstate mode is changed, leading to the
following splat:

[ 1332.103727] INFO: task bash:2929 blocked for more than 120 seconds.
[ 1332.110001]       Not tainted 6.5.0-rc2-amd-pstate-ut #5
[ 1332.115315] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1332.123140] task:bash            state:D stack:0     pid:2929  ppid:2873   flags:0x00004006
[ 1332.123143] Call Trace:
[ 1332.123145]  <TASK>
[ 1332.123148]  __schedule+0x3c1/0x16a0
[ 1332.123154]  ? _raw_read_lock_irqsave+0x2d/0x70
[ 1332.123157]  schedule+0x6f/0x110
[ 1332.123160]  schedule_timeout+0x14f/0x160
[ 1332.123162]  ? preempt_count_add+0x86/0xd0
[ 1332.123165]  __wait_for_common+0x92/0x190
[ 1332.123168]  ? __pfx_schedule_timeout+0x10/0x10
[ 1332.123170]  wait_for_completion+0x28/0x30
[ 1332.123173]  cpufreq_policy_put_kobj+0x4d/0x90
[ 1332.123177]  cpufreq_policy_free+0x157/0x1d0
[ 1332.123178]  ? preempt_count_add+0x58/0xd0
[ 1332.123180]  cpufreq_remove_dev+0xb6/0x100
[ 1332.123182]  subsys_interface_unregister+0x114/0x120
[ 1332.123185]  ? preempt_count_add+0x58/0xd0
[ 1332.123187]  ? __pfx_amd_pstate_change_driver_mode+0x10/0x10
[ 1332.123190]  cpufreq_unregister_driver+0x3b/0xd0
[ 1332.123192]  amd_pstate_change_driver_mode+0x1e/0x50
[ 1332.123194]  store_status+0xe9/0x180
[ 1332.123197]  dev_attr_store+0x1b/0x30
[ 1332.123199]  sysfs_kf_write+0x42/0x50
[ 1332.123202]  kernfs_fop_write_iter+0x143/0x1d0
[ 1332.123204]  vfs_write+0x2df/0x400
[ 1332.123208]  ksys_write+0x6b/0xf0
[ 1332.123210]  __x64_sys_write+0x1d/0x30
[ 1332.123213]  do_syscall_64+0x60/0x90
[ 1332.123216]  ? fpregs_assert_state_consistent+0x2e/0x50
[ 1332.123219]  ? exit_to_user_mode_prepare+0x49/0x1a0
[ 1332.123223]  ? irqentry_exit_to_user_mode+0xd/0x20
[ 1332.123225]  ? irqentry_exit+0x3f/0x50
[ 1332.123226]  ? exc_page_fault+0x8e/0x190
[ 1332.123228]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[ 1332.123232] RIP: 0033:0x7fa74c514a37
[ 1332.123234] RSP: 002b:00007ffe31dd0788 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[ 1332.123238] RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007fa74c514a37
[ 1332.123239] RDX: 0000000000000008 RSI: 000055e27c447aa0 RDI: 0000000000000001
[ 1332.123241] RBP: 000055e27c447aa0 R08: 00007fa74c5d1460 R09: 000000007fffffff
[ 1332.123242] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000008
[ 1332.123244] R13: 00007fa74c61a780 R14: 00007fa74c616600 R15: 00007fa74c615a00
[ 1332.123247]  </TASK>

Fix this by calling cpufreq_cpu_put() wherever necessary.

Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Meng Li <li.meng@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Suggested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate-ut.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index cf07ee77d3ccf..502d494499ae8 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -140,7 +140,7 @@ static void amd_pstate_ut_check_perf(u32 index)
 			if (ret) {
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 				pr_err("%s cppc_get_perf_caps ret=%d error!\n", __func__, ret);
-				return;
+				goto skip_test;
 			}
 
 			nominal_perf = cppc_perf.nominal_perf;
@@ -151,7 +151,7 @@ static void amd_pstate_ut_check_perf(u32 index)
 			if (ret) {
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 				pr_err("%s read CPPC_CAP1 ret=%d error!\n", __func__, ret);
-				return;
+				goto skip_test;
 			}
 
 			nominal_perf = AMD_CPPC_NOMINAL_PERF(cap1);
@@ -169,7 +169,7 @@ static void amd_pstate_ut_check_perf(u32 index)
 				nominal_perf, cpudata->nominal_perf,
 				lowest_nonlinear_perf, cpudata->lowest_nonlinear_perf,
 				lowest_perf, cpudata->lowest_perf);
-			return;
+			goto skip_test;
 		}
 
 		if (!((highest_perf >= nominal_perf) &&
@@ -180,11 +180,15 @@ static void amd_pstate_ut_check_perf(u32 index)
 			pr_err("%s cpu%d highest=%d >= nominal=%d > lowest_nonlinear=%d > lowest=%d > 0, the formula is incorrect!\n",
 				__func__, cpu, highest_perf, nominal_perf,
 				lowest_nonlinear_perf, lowest_perf);
-			return;
+			goto skip_test;
 		}
+		cpufreq_cpu_put(policy);
 	}
 
 	amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
+	return;
+skip_test:
+	cpufreq_cpu_put(policy);
 }
 
 /*
@@ -212,14 +216,14 @@ static void amd_pstate_ut_check_freq(u32 index)
 			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
 				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
 				cpudata->lowest_nonlinear_freq, cpudata->min_freq);
-			return;
+			goto skip_test;
 		}
 
 		if (cpudata->min_freq != policy->min) {
 			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 			pr_err("%s cpu%d cpudata_min_freq=%d policy_min=%d, they should be equal!\n",
 				__func__, cpu, cpudata->min_freq, policy->min);
-			return;
+			goto skip_test;
 		}
 
 		if (cpudata->boost_supported) {
@@ -231,16 +235,20 @@ static void amd_pstate_ut_check_freq(u32 index)
 				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
 					__func__, cpu, policy->max, cpudata->max_freq,
 					cpudata->nominal_freq);
-				return;
+				goto skip_test;
 			}
 		} else {
 			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 			pr_err("%s cpu%d must support boost!\n", __func__, cpu);
-			return;
+			goto skip_test;
 		}
+		cpufreq_cpu_put(policy);
 	}
 
 	amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
+	return;
+skip_test:
+	cpufreq_cpu_put(policy);
 }
 
 static int __init amd_pstate_ut_init(void)
-- 
2.40.1



