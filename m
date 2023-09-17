Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F607A37B7
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjIQTYO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239485AbjIQTXq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:23:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0717F11C
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:23:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3700AC433C9;
        Sun, 17 Sep 2023 19:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978620;
        bh=Qd8mitvA6EH/kBleBnNokUjbrPUregecCeXUsj2r/Lo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1QtzU9JT/Xj8J2Q4mnoCvDNvVCQPn1t2vRa6yomxGUOSxd/0pqg4kKjIqdjXHZ4yJ
         Hx6y+HrO0gCuUceiURzZthIYRW+YNSe70LzxivcjKfT9Um2eINi8wzIgnOd57CqCYW
         kfBLP9lFu8bJUbJhlnOqE0CHSeiL+e+SQuPYXXCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Quentin Monnet <quentin@isovalent.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 082/406] bpftool: Use a local bpf_perf_event_value to fix accessing its fields
Date:   Sun, 17 Sep 2023 21:08:56 +0200
Message-ID: <20230917191103.296558378@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Lobakin <alobakin@pm.me>

[ Upstream commit 658ac06801315b739774a15796ff06913ef5cad5 ]

Fix the following error when building bpftool:

  CLANG   profiler.bpf.o
  CLANG   pid_iter.bpf.o
skeleton/profiler.bpf.c:18:21: error: invalid application of 'sizeof' to an incomplete type 'struct bpf_perf_event_value'
        __uint(value_size, sizeof(struct bpf_perf_event_value));
                           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helpers.h:13:39: note: expanded from macro '__uint'
tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^

struct bpf_perf_event_value is being used in the kernel only when
CONFIG_BPF_EVENTS is enabled, so it misses a BTF entry then.
Define struct bpf_perf_event_value___local with the
`preserve_access_index` attribute inside the pid_iter BPF prog to
allow compiling on any configs. It is a full mirror of a UAPI
structure, so is compatible both with and w/o CO-RE.
bpf_perf_event_read_value() requires a pointer of the original type,
so a cast is needed.

Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20230707095425.168126-5-quentin@isovalent.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/skeleton/profiler.bpf.c | 27 ++++++++++++++---------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/bpftool/skeleton/profiler.bpf.c
index ce5b65e07ab10..2f80edc682f11 100644
--- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
+++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
@@ -4,6 +4,12 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+struct bpf_perf_event_value___local {
+	__u64 counter;
+	__u64 enabled;
+	__u64 running;
+} __attribute__((preserve_access_index));
+
 /* map of perf event fds, num_cpu * num_metric entries */
 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
@@ -15,14 +21,14 @@ struct {
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
 	__uint(key_size, sizeof(u32));
-	__uint(value_size, sizeof(struct bpf_perf_event_value));
+	__uint(value_size, sizeof(struct bpf_perf_event_value___local));
 } fentry_readings SEC(".maps");
 
 /* accumulated readings */
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
 	__uint(key_size, sizeof(u32));
-	__uint(value_size, sizeof(struct bpf_perf_event_value));
+	__uint(value_size, sizeof(struct bpf_perf_event_value___local));
 } accum_readings SEC(".maps");
 
 /* sample counts, one per cpu */
@@ -39,7 +45,7 @@ const volatile __u32 num_metric = 1;
 SEC("fentry/XXX")
 int BPF_PROG(fentry_XXX)
 {
-	struct bpf_perf_event_value *ptrs[MAX_NUM_MATRICS];
+	struct bpf_perf_event_value___local *ptrs[MAX_NUM_MATRICS];
 	u32 key = bpf_get_smp_processor_id();
 	u32 i;
 
@@ -53,10 +59,10 @@ int BPF_PROG(fentry_XXX)
 	}
 
 	for (i = 0; i < num_metric && i < MAX_NUM_MATRICS; i++) {
-		struct bpf_perf_event_value reading;
+		struct bpf_perf_event_value___local reading;
 		int err;
 
-		err = bpf_perf_event_read_value(&events, key, &reading,
+		err = bpf_perf_event_read_value(&events, key, (void *)&reading,
 						sizeof(reading));
 		if (err)
 			return 0;
@@ -68,14 +74,14 @@ int BPF_PROG(fentry_XXX)
 }
 
 static inline void
-fexit_update_maps(u32 id, struct bpf_perf_event_value *after)
+fexit_update_maps(u32 id, struct bpf_perf_event_value___local *after)
 {
-	struct bpf_perf_event_value *before, diff;
+	struct bpf_perf_event_value___local *before, diff;
 
 	before = bpf_map_lookup_elem(&fentry_readings, &id);
 	/* only account samples with a valid fentry_reading */
 	if (before && before->counter) {
-		struct bpf_perf_event_value *accum;
+		struct bpf_perf_event_value___local *accum;
 
 		diff.counter = after->counter - before->counter;
 		diff.enabled = after->enabled - before->enabled;
@@ -93,7 +99,7 @@ fexit_update_maps(u32 id, struct bpf_perf_event_value *after)
 SEC("fexit/XXX")
 int BPF_PROG(fexit_XXX)
 {
-	struct bpf_perf_event_value readings[MAX_NUM_MATRICS];
+	struct bpf_perf_event_value___local readings[MAX_NUM_MATRICS];
 	u32 cpu = bpf_get_smp_processor_id();
 	u32 i, zero = 0;
 	int err;
@@ -102,7 +108,8 @@ int BPF_PROG(fexit_XXX)
 	/* read all events before updating the maps, to reduce error */
 	for (i = 0; i < num_metric && i < MAX_NUM_MATRICS; i++) {
 		err = bpf_perf_event_read_value(&events, cpu + i * num_cpu,
-						readings + i, sizeof(*readings));
+						(void *)(readings + i),
+						sizeof(*readings));
 		if (err)
 			return 0;
 	}
-- 
2.40.1



