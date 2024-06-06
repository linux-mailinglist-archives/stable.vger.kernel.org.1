Return-Path: <stable+bounces-49677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4928FEE63
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA54A1C252AF
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EC01C3716;
	Thu,  6 Jun 2024 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="je13v5l+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D101991C5;
	Thu,  6 Jun 2024 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683654; cv=none; b=FtB7D6kZSe1VtPkYgA/NXctY6J0fQBYNMrvKMZdBPRAb6ONYDAnmqAuKqsvTbdeBmKIC64nAmQNLDjfciLoGAf/GBZy4dimerMstSj5ObQz017+NSnIRbGx13aiXkCjBKRxsIat1jUC9JVj5Ri8j41/nzFh7nHWrJvdxG0yz7vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683654; c=relaxed/simple;
	bh=iIg3t8NJlygiRIDOI0viVZJXMFe5URo+w6wE1uPTy20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D515DHxtqVpJN3NQIxcQFc54IhUNnAgdjGme6UiV72mhsl217D/VFeXumIScf/8ZfT2cAkGhuhicQ703cnZuAii6LDWRvhB8+Gz8VOLbzKnq3T34yt3Xb5GeZDr7h9HyJ/Qw5Q6I4T2weQa8WdAMVk+Rp+A3QVnA9SMxSOrFBsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=je13v5l+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3472EC32781;
	Thu,  6 Jun 2024 14:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683654;
	bh=iIg3t8NJlygiRIDOI0viVZJXMFe5URo+w6wE1uPTy20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=je13v5l+xWycbOuq+gK4ZhfyJtssJvv3XDV4nTKDP25mMDskrvfCkqiRD5Rki5DIk
	 DmRBlXnACJ/ZL5IpzqCwJS1q5y0i9k7cSZTRftWJ2qrnhL8G0BmllBB0AEMPXvtj3C
	 2JXKmywLcTERB1DmBiSs3RJAZ2q54KQiXKV7sdi4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 529/744] perf tools: Add/use PMU reverse lookup from config to name
Date: Thu,  6 Jun 2024 16:03:21 +0200
Message-ID: <20240606131749.402763126@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 67ee8e71daabb8632931b7559e5c8a4b69a427f8 ]

Add perf_pmu__name_from_config that does a reverse lookup from a
config number to an alias name. The lookup is expensive as the config
is computed for every alias by filling in a perf_event_attr, but this
is only done when verbose output is enabled. The lookup also only
considers config, and not config1, config2 or config3.

An example of the output:

  $ perf stat -vv -e data_read true
  ...
  perf_event_attr:
    type                             24 (uncore_imc_free_running_0)
    size                             136
    config                           0x20ff (data_read)
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    exclude_guest                    1
  ...

Committer notes:

Fix the python binding build by adding dummies for not strictly
needed perf_pmu__name_from_config() and perf_pmus__find_by_type().

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Yang Jihong <yangjihong1@huawei.com>
Link: https://lore.kernel.org/r/20240308001915.4060155-7-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: d9c5f5f94c2d ("perf pmu: Count sys and cpuid JSON events separately")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/perf_event_attr_fprintf.c | 10 ++++++++--
 tools/perf/util/pmu.c                     | 18 ++++++++++++++++++
 tools/perf/util/pmu.h                     |  1 +
 tools/perf/util/python.c                  | 10 ++++++++++
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index f3c6db5f4182c..1c1582688f037 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -221,8 +221,14 @@ static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
 }
 #endif
 
-static void __p_config_id(char *buf, size_t size, u32 type, u64 value)
+static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type, u64 value)
 {
+	const char *name = perf_pmu__name_from_config(pmu, value);
+
+	if (name) {
+		print_id_hex(name);
+		return;
+	}
 	switch (type) {
 	case PERF_TYPE_HARDWARE:
 		return __p_config_hw_id(buf, size, value);
@@ -251,7 +257,7 @@ static void __p_config_id(char *buf, size_t size, u32 type, u64 value)
 #define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE, val)
 #define p_read_format(val)	__p_read_format(buf, BUF_SIZE, val)
 #define p_type_id(val)		__p_type_id(pmu, buf, BUF_SIZE, val)
-#define p_config_id(val)	__p_config_id(buf, BUF_SIZE, attr->type, val)
+#define p_config_id(val)	__p_config_id(pmu, buf, BUF_SIZE, attr->type, val)
 
 #define PRINT_ATTRn(_n, _f, _p, _a)			\
 do {							\
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 64b605a6060e2..0b1c380fce901 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2081,3 +2081,21 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 	zfree(&pmu->id);
 	free(pmu);
 }
+
+const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
+{
+	struct perf_pmu_alias *event;
+
+	if (!pmu)
+		return NULL;
+
+	pmu_add_cpu_aliases(pmu);
+	list_for_each_entry(event, &pmu->aliases, list) {
+		struct perf_event_attr attr = {.config = 0,};
+		int ret = perf_pmu__config(pmu, &attr, &event->terms, NULL);
+
+		if (ret == 0 && config == attr.config)
+			return event->name;
+	}
+	return NULL;
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index c4b4fabe16edc..ed6693f991867 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -266,5 +266,6 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus);
 void perf_pmu__delete(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__find_core_pmu(void);
+const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config);
 
 #endif /* __PMU_H */
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index c29f5f0bb552c..b01b0e5510563 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -103,6 +103,16 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
 	return EOF;
 }
 
+const char *perf_pmu__name_from_config(struct perf_pmu *pmu __maybe_unused, u64 config __maybe_unused)
+{
+	return NULL;
+}
+
+struct perf_pmu *perf_pmus__find_by_type(unsigned int type __maybe_unused)
+{
+	return NULL;
+}
+
 int perf_pmus__num_core_pmus(void)
 {
 	return 1;
-- 
2.43.0




