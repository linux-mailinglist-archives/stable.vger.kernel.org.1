Return-Path: <stable+bounces-14442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F4D8380EF
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018A51F26DEC
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B32B135A4C;
	Tue, 23 Jan 2024 01:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0qxELaox"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF4B1353E8;
	Tue, 23 Jan 2024 01:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971967; cv=none; b=gw0wuh2kqb1Ob7j98V0z+JWv60lkKdeBdF/LeS8AcvRmXt/GHxe03SKr8WBk5yPl0v5BkZGFUXxSRwQSe+5tLNXIAxL48FQcRWYJtISxVbkL7vJvTiWbeX94vmaTLSd//KwrXYjMviUEvBGsono+NTOMyOQO+5Fv9d65bG86TXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971967; c=relaxed/simple;
	bh=BVNjowA/amp7J2pRA9Ai64nbQMqlAKf+35M9e+M/9qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+/dcRZu+gEZQtw9yiENxs4CeY4Jdx4PSX1Uejivq5voRmG6vkaYUtNqSDDocER0et71szFNQD3CjyxJ5a52ILUjbnB0ECYp76/gN1tA0rWlihUQR/ijE4/cvFPUfpYkdqrcL6zYvUdrFg6TAXS0Q9Fdt5MQw50QoEUPoAePLzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0qxELaox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AE8C43390;
	Tue, 23 Jan 2024 01:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971967;
	bh=BVNjowA/amp7J2pRA9Ai64nbQMqlAKf+35M9e+M/9qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0qxELaoxb4BPRbK1HetCa6ht5LFmThRl/s076WX4TIM087goOu/n+gO6LnMvSaDnf
	 Iua+ScjSp4OBgESgft2NECHOw9O4dc8TcbD/SnkmwOatQIThiEMce8P/C5y9SAAHOu
	 C1cUSRthRhd8fhdcpiE3IHqoynkhTRyE0aVXX3oM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Song Liu <song@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ming Wang <wangming01@loongson.cn>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 366/417] perf env: Avoid recursively taking env->bpf_progs.lock
Date: Mon, 22 Jan 2024 15:58:54 -0800
Message-ID: <20240122235804.499591844@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 9c51f8788b5d4e9f46afbcf563255cfd355690b3 ]

Add variants of perf_env__insert_bpf_prog_info(), perf_env__insert_btf()
and perf_env__find_btf prefixed with __ to indicate the
env->bpf_progs.lock is assumed held.

Call these variants when the lock is held to avoid recursively taking it
and potentially having a thread deadlock with itself.

Fixes: f8dfeae009effc0b ("perf bpf: Show more BPF program info in print_bpf_prog_info()")
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ming Wang <wangming01@loongson.cn>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20231207014655.1252484-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/bpf-event.c |  8 +++---
 tools/perf/util/bpf-event.h | 12 ++++-----
 tools/perf/util/env.c       | 50 ++++++++++++++++++++++++-------------
 tools/perf/util/env.h       |  4 +++
 tools/perf/util/header.c    |  8 +++---
 5 files changed, 50 insertions(+), 32 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index cc7c1f90cf62..91c7bfa82a50 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -606,9 +606,9 @@ int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env)
 	return evlist__add_sb_event(evlist, &attr, bpf_event__sb_cb, env);
 }
 
-void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
-				    struct perf_env *env,
-				    FILE *fp)
+void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
+				      struct perf_env *env,
+				      FILE *fp)
 {
 	__u32 *prog_lens = (__u32 *)(uintptr_t)(info->jited_func_lens);
 	__u64 *prog_addrs = (__u64 *)(uintptr_t)(info->jited_ksyms);
@@ -624,7 +624,7 @@ void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
 	if (info->btf_id) {
 		struct btf_node *node;
 
-		node = perf_env__find_btf(env, info->btf_id);
+		node = __perf_env__find_btf(env, info->btf_id);
 		if (node)
 			btf = btf__new((__u8 *)(node->data),
 				       node->data_size);
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 1bcbd4fb6c66..e2f0420905f5 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -33,9 +33,9 @@ struct btf_node {
 int machine__process_bpf(struct machine *machine, union perf_event *event,
 			 struct perf_sample *sample);
 int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env);
-void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
-				    struct perf_env *env,
-				    FILE *fp);
+void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
+				      struct perf_env *env,
+				      FILE *fp);
 #else
 static inline int machine__process_bpf(struct machine *machine __maybe_unused,
 				       union perf_event *event __maybe_unused,
@@ -50,9 +50,9 @@ static inline int evlist__add_bpf_sb_event(struct evlist *evlist __maybe_unused,
 	return 0;
 }
 
-static inline void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info __maybe_unused,
-						  struct perf_env *env __maybe_unused,
-						  FILE *fp __maybe_unused)
+static inline void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info __maybe_unused,
+						    struct perf_env *env __maybe_unused,
+						    FILE *fp __maybe_unused)
 {
 
 }
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 5b8cf6a421a4..5d878bae7d9a 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -21,13 +21,19 @@ struct perf_env perf_env;
 
 void perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node)
+{
+	down_write(&env->bpf_progs.lock);
+	__perf_env__insert_bpf_prog_info(env, info_node);
+	up_write(&env->bpf_progs.lock);
+}
+
+void __perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_prog_info_node *info_node)
 {
 	__u32 prog_id = info_node->info_linear->info.id;
 	struct bpf_prog_info_node *node;
 	struct rb_node *parent = NULL;
 	struct rb_node **p;
 
-	down_write(&env->bpf_progs.lock);
 	p = &env->bpf_progs.infos.rb_node;
 
 	while (*p != NULL) {
@@ -39,15 +45,13 @@ void perf_env__insert_bpf_prog_info(struct perf_env *env,
 			p = &(*p)->rb_right;
 		} else {
 			pr_debug("duplicated bpf prog info %u\n", prog_id);
-			goto out;
+			return;
 		}
 	}
 
 	rb_link_node(&info_node->rb_node, parent, p);
 	rb_insert_color(&info_node->rb_node, &env->bpf_progs.infos);
 	env->bpf_progs.infos_cnt++;
-out:
-	up_write(&env->bpf_progs.lock);
 }
 
 struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
@@ -76,14 +80,22 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 }
 
 bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
+{
+	bool ret;
+
+	down_write(&env->bpf_progs.lock);
+	ret = __perf_env__insert_btf(env, btf_node);
+	up_write(&env->bpf_progs.lock);
+	return ret;
+}
+
+bool __perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
 {
 	struct rb_node *parent = NULL;
 	__u32 btf_id = btf_node->id;
 	struct btf_node *node;
 	struct rb_node **p;
-	bool ret = true;
 
-	down_write(&env->bpf_progs.lock);
 	p = &env->bpf_progs.btfs.rb_node;
 
 	while (*p != NULL) {
@@ -95,25 +107,31 @@ bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
 			p = &(*p)->rb_right;
 		} else {
 			pr_debug("duplicated btf %u\n", btf_id);
-			ret = false;
-			goto out;
+			return false;
 		}
 	}
 
 	rb_link_node(&btf_node->rb_node, parent, p);
 	rb_insert_color(&btf_node->rb_node, &env->bpf_progs.btfs);
 	env->bpf_progs.btfs_cnt++;
-out:
-	up_write(&env->bpf_progs.lock);
-	return ret;
+	return true;
 }
 
 struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
+{
+	struct btf_node *res;
+
+	down_read(&env->bpf_progs.lock);
+	res = __perf_env__find_btf(env, btf_id);
+	up_read(&env->bpf_progs.lock);
+	return res;
+}
+
+struct btf_node *__perf_env__find_btf(struct perf_env *env, __u32 btf_id)
 {
 	struct btf_node *node = NULL;
 	struct rb_node *n;
 
-	down_read(&env->bpf_progs.lock);
 	n = env->bpf_progs.btfs.rb_node;
 
 	while (n) {
@@ -123,13 +141,9 @@ struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
 		else if (btf_id > node->id)
 			n = n->rb_right;
 		else
-			goto out;
+			return node;
 	}
-	node = NULL;
-
-out:
-	up_read(&env->bpf_progs.lock);
-	return node;
+	return NULL;
 }
 
 /* purge data in bpf_progs.infos tree */
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 4566c51f2fd9..359eff51cb85 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -164,12 +164,16 @@ const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
 
 void perf_env__init(struct perf_env *env);
+void __perf_env__insert_bpf_prog_info(struct perf_env *env,
+				      struct bpf_prog_info_node *info_node);
 void perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node);
 struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 							__u32 prog_id);
 bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
+bool __perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
 struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
+struct btf_node *__perf_env__find_btf(struct perf_env *env, __u32 btf_id);
 
 int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu);
 char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index eaeeba8d65ec..b2b0293567f0 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1809,8 +1809,8 @@ static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
 		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
 		next = rb_next(&node->rb_node);
 
-		bpf_event__print_bpf_prog_info(&node->info_linear->info,
-					       env, fp);
+		__bpf_event__print_bpf_prog_info(&node->info_linear->info,
+						 env, fp);
 	}
 
 	up_read(&env->bpf_progs.lock);
@@ -3136,7 +3136,7 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
 		/* after reading from file, translate offset to address */
 		bpil_offs_to_addr(info_linear);
 		info_node->info_linear = info_linear;
-		perf_env__insert_bpf_prog_info(env, info_node);
+		__perf_env__insert_bpf_prog_info(env, info_node);
 	}
 
 	up_write(&env->bpf_progs.lock);
@@ -3183,7 +3183,7 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 		if (__do_read(ff, node->data, data_size))
 			goto out;
 
-		perf_env__insert_btf(env, node);
+		__perf_env__insert_btf(env, node);
 		node = NULL;
 	}
 
-- 
2.43.0




