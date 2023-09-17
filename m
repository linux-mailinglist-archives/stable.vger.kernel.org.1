Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECCF7A3A98
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240386AbjIQUG1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240468AbjIQUGJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:06:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC94F3
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:05:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11306C433CA;
        Sun, 17 Sep 2023 20:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981157;
        bh=AcUDdRyH7qYeCFpzWUgeeRK7h+hUf9upgMa7Ss0V+XQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VMoFO+O82FEk+MmW9FYv3h0Snra3ykzPhJdE2oLmMOibKPwAJvTg4M0b0ThF7I5YV
         iK0Q+Iyvv2O85R1mArP25O0oPWOSaVOlBtgsPKGkONq5VgpU4Cus4LfRNle1ssmkeC
         2mCnRKUfG5Bn1a8L2ulNam/JNmP4zyjlHmEqDDVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kajol Jain <kjain@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 080/219] perf test stat_bpf_counters_cgrp: Fix shellcheck issue about logical operators
Date:   Sun, 17 Sep 2023 21:13:27 +0200
Message-ID: <20230917191043.869526841@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kajol Jain <kjain@linux.ibm.com>

[ Upstream commit 0dd1f815545d7210150642741c364521cc5cf116 ]

Running shellcheck on lock_contention.sh generates below warning:

In stat_bpf_counters_cgrp.sh line 28:
	if [ -d /sys/fs/cgroup/system.slice -a -d /sys/fs/cgroup/user.slice ]; then
                                            ^-- SC2166 (warning): Prefer [ p ] && [ q ] as [ p -a q ] is not well defined.

In stat_bpf_counters_cgrp.sh line 34:
	local self_cgrp=$(grep perf_event /proc/self/cgroup | cut -d: -f3)
        ^-------------^ SC3043 (warning): In POSIX sh, 'local' is undefined.
              ^-------^ SC2155 (warning): Declare and assign separately to avoid masking return values.
                        ^-- SC2046 (warning): Quote this to prevent word splitting.

In stat_bpf_counters_cgrp.sh line 51:
	local output
        ^----------^ SC3043 (warning): In POSIX sh, 'local' is undefined.

In stat_bpf_counters_cgrp.sh line 65:
	local output
        ^----------^ SC3043 (warning): In POSIX sh, 'local' is undefined.

Fixed above warnings by:
- Changing the expression [p -a q] to [p] && [q].
- Fixing shellcheck warnings for local usage, by prefixing
  function name to the variable.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Ian Rogers <irogers@google.com>
Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: https://lore.kernel.org/r/20230709182800.53002-6-atrajeev@linux.vnet.ibm.com
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: a84260e31402 ("perf test stat_bpf_counters_cgrp: Enhance perf stat cgroup BPF counter test")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../tests/shell/stat_bpf_counters_cgrp.sh     | 28 ++++++++-----------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
index d724855d097c2..a74440a00b6b6 100755
--- a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
@@ -25,22 +25,22 @@ check_bpf_counter()
 find_cgroups()
 {
 	# try usual systemd slices first
-	if [ -d /sys/fs/cgroup/system.slice -a -d /sys/fs/cgroup/user.slice ]; then
+	if [ -d /sys/fs/cgroup/system.slice ] && [ -d /sys/fs/cgroup/user.slice ]; then
 		test_cgroups="system.slice,user.slice"
 		return
 	fi
 
 	# try root and self cgroups
-	local self_cgrp=$(grep perf_event /proc/self/cgroup | cut -d: -f3)
-	if [ -z ${self_cgrp} ]; then
+	find_cgroups_self_cgrp=$(grep perf_event /proc/self/cgroup | cut -d: -f3)
+	if [ -z ${find_cgroups_self_cgrp} ]; then
 		# cgroup v2 doesn't specify perf_event
-		self_cgrp=$(grep ^0: /proc/self/cgroup | cut -d: -f3)
+		find_cgroups_self_cgrp=$(grep ^0: /proc/self/cgroup | cut -d: -f3)
 	fi
 
-	if [ -z ${self_cgrp} ]; then
+	if [ -z ${find_cgroups_self_cgrp} ]; then
 		test_cgroups="/"
 	else
-		test_cgroups="/,${self_cgrp}"
+		test_cgroups="/,${find_cgroups_self_cgrp}"
 	fi
 }
 
@@ -48,13 +48,11 @@ find_cgroups()
 # Just check if it runs without failure and has non-zero results.
 check_system_wide_counted()
 {
-	local output
-
-	output=$(perf stat -a --bpf-counters --for-each-cgroup ${test_cgroups} -e cpu-clock -x, sleep 1  2>&1)
-	if echo ${output} | grep -q -F "<not "; then
+	check_system_wide_counted_output=$(perf stat -a --bpf-counters --for-each-cgroup ${test_cgroups} -e cpu-clock -x, sleep 1  2>&1)
+	if echo ${check_system_wide_counted_output} | grep -q -F "<not "; then
 		echo "Some system-wide events are not counted"
 		if [ "${verbose}" = "1" ]; then
-			echo ${output}
+			echo ${check_system_wide_counted_output}
 		fi
 		exit 1
 	fi
@@ -62,13 +60,11 @@ check_system_wide_counted()
 
 check_cpu_list_counted()
 {
-	local output
-
-	output=$(perf stat -C 1 --bpf-counters --for-each-cgroup ${test_cgroups} -e cpu-clock -x, taskset -c 1 sleep 1  2>&1)
-	if echo ${output} | grep -q -F "<not "; then
+	check_cpu_list_counted_output=$(perf stat -C 1 --bpf-counters --for-each-cgroup ${test_cgroups} -e cpu-clock -x, taskset -c 1 sleep 1  2>&1)
+	if echo ${check_cpu_list_counted_output} | grep -q -F "<not "; then
 		echo "Some CPU events are not counted"
 		if [ "${verbose}" = "1" ]; then
-			echo ${output}
+			echo ${check_cpu_list_counted_output}
 		fi
 		exit 1
 	fi
-- 
2.40.1



