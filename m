Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552047A3A9A
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240389AbjIQUG2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240495AbjIQUGO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:06:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3B6EE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:06:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E611C433C9;
        Sun, 17 Sep 2023 20:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981164;
        bh=OwuYqBXSKFkqO6BZYKjTziP8vGOUgaxhrGsonnA6eaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dpLlCcmyNucvJWVybovy14aXDUmuq5H1NaUHAKFC9VvGWb0mAev76mpk4tmvjLeW+
         REcRD0Gv/51vC9EJkWcZ+tf+XHeICff0eHpkX7Ri6oQpqf+TRFvfarzFecEGZkUQLf
         NeRPJmE5Mbzxj3bT/C3cXD5tmqbcHyGApPIGY2os=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 081/219] perf test stat_bpf_counters_cgrp: Enhance perf stat cgroup BPF counter test
Date:   Sun, 17 Sep 2023 21:13:28 +0200
Message-ID: <20230917191043.901641440@linuxfoundation.org>
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

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit a84260e314029e6dc9904fd6eabf8d9fd7965351 ]

It has system-wide test and cpu-list test but the cpu-list test fails
sometimes.  It runs sleep command on CPU1 and measure both user.slice
and system.slice cgroups by default (on systemd-based systems).

But if the system was idle enough, sometime the system.slice gets no
count and it makes the test failing.  Maybe that's because it only looks
at the CPU1, let's add CPU0 to increase the chance it finds some tasks.

Fixes: 7901086014bbaa3a ("perf test: Add a new test for perf stat cgroup BPF counter")
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org
Link: https://lore.kernel.org/r/20230825164152.165610-3-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
index a74440a00b6b6..e75d0780dc788 100755
--- a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
@@ -60,7 +60,7 @@ check_system_wide_counted()
 
 check_cpu_list_counted()
 {
-	check_cpu_list_counted_output=$(perf stat -C 1 --bpf-counters --for-each-cgroup ${test_cgroups} -e cpu-clock -x, taskset -c 1 sleep 1  2>&1)
+	check_cpu_list_counted_output=$(perf stat -C 0,1 --bpf-counters --for-each-cgroup ${test_cgroups} -e cpu-clock -x, taskset -c 1 sleep 1  2>&1)
 	if echo ${check_cpu_list_counted_output} | grep -q -F "<not "; then
 		echo "Some CPU events are not counted"
 		if [ "${verbose}" = "1" ]; then
-- 
2.40.1



