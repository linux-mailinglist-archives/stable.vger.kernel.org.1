Return-Path: <stable+bounces-91851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 545239C0B80
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 17:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4E19B22CC3
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 16:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF664218933;
	Thu,  7 Nov 2024 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zUcVm2ZX"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABF121731C
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996446; cv=none; b=is34sgthyYWgbleWRg253LDKapSbCbLtBrN+eha987dCo4cLH7PlOrGdsZJsvaaH1bkogetMUn+2GLc4+fEwKGVi9IPwtNnxVcEMp7Tf6bbrUB3BXyjEavayMgHY6rSdiC0v07xsxhGUHypUiVoST8H3Dp1pV/CXnwWUQuGBM3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996446; c=relaxed/simple;
	bh=OQ+ILS6ZdIDbpDd6fnm+5OYFklVHCZ8ERtWBLEZnFyg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=cAg4wDZtuWF4/0VFzwjJini9b28PdBKsLDgQZQrfx5csjvC0iBSN4EsSdMJxY4XySaXIY9HfRn8/1TBTMdUjLh6arfJVYJGYzCezIwE7+u24ZXZAw9tEu3AKljYPw6yg5vcR6UCPX8QJbaYFi5QxpVdAI4Ilfv0XhAM0hA79B9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zUcVm2ZX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30df208cadso2753595276.0
        for <stable@vger.kernel.org>; Thu, 07 Nov 2024 08:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730996443; x=1731601243; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Zi7/BGIzk4kmPbaIIn5N5Q89D8reWg5dpAnu28NGJw=;
        b=zUcVm2ZXhGnSypH0GLkeSotuc0HUk4N/11XDq7hA1rvqRRCuts+swxtmwH8mby9NYG
         FjPmoUKFr7AYaBUm+ridTTXCuC0L5AzkyI2y171yuta8Nem/IG+AQX5jvIMSv0de6LEd
         1hs2CfsGXyalmc5dPq7VBzh6/W+r+vzlV4N8DAOtavaWVaLt9lmX5FqpgvkHjpRXsXAx
         Oi1WgYyrmu4beez7OADsPLKcUDMKTbGRilw5olJeN+/bagoRtc0ZXgbe+6wcLiDKri6I
         XrMs5M6mE3VS7jtwNBZfw5FE3xP8nAjxru+zbvP8riHx4UVz5gbFjkrOy3xTAafQw/45
         uEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730996443; x=1731601243;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Zi7/BGIzk4kmPbaIIn5N5Q89D8reWg5dpAnu28NGJw=;
        b=TLeUbBmsSDhhMhN8uuSyGiyPtyCyxsmXaoUpxKi1PHY4oHmRbwSUE6myHf2eFJznWm
         48LBE3WGQjK3b1HgzcDsfETEidSlxWTSqHzMZczBnQW1UZQrbRmaRqTricybjUFjWBCc
         HocL9TdF41jVclUB87aSZXSfbreL2qejE8IjVZU2vJ+14lH7XujBRjxhpDsPqJ8IbJRb
         eeWJsCclVSvwobbxW/86sJKWhIznNSqSVktDqFPKdPdahxs8I/efYMUHkIl4GcyZIwQk
         k2xdbKv1DKuFC1a+lksX7RyADJLQmgPVU604EaWvX3AVUYnP+En4oHSYt3tzPtyZyfmG
         ciEQ==
X-Gm-Message-State: AOJu0Yyk50mBPhvH1cRiKNhB9IxLzoM4hOjzQ/tIiLaRXFAGtbu3brx9
	khkXUXs0g3wFs+8o33vHn4Vv6JZFjSx1zd8qzJrrNruvby+ChBjf5pocSAxeg/KZvgbAxEiwPxZ
	O8pNWfw==
X-Google-Smtp-Source: AGHT+IH0/hEWrV52DVmrj7Z6n0WIT9Ut3IVouygX8jmB/XLHKPkNRIO9up6ksFd2vuXYZmCZkrEILwBAMRRP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc7:bda:7167:18d8])
 (user=irogers job=sendgmr) by 2002:a25:d843:0:b0:e29:7454:e773 with SMTP id
 3f1490d57ef6-e337e1d738cmr33276.5.1730996442881; Thu, 07 Nov 2024 08:20:42
 -0800 (PST)
Date: Thu,  7 Nov 2024 08:20:28 -0800
In-Reply-To: <20241107162035.52206-1-irogers@google.com>
Message-Id: <20241107162035.52206-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107162035.52206-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v2 1/8] perf jevents: fix breakage when do perf stat on system metric
From: Ian Rogers <irogers@google.com>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ben Zong-You Xie <ben717@andestech.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Dima Kogan <dima@secretsauce.net>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Xu Yang <xu.yang_2@nxp.com>

When do perf stat on sys metric, perf tool output nothing now:
$ perf stat -a -M imx95_ddr_read.all -I 1000
$

This command runs on an arm64 machine and the Soc has one DDR hw pmu
except one armv8_cortex_a55 pmu. Their maps show as follows:

const struct pmu_events_map pmu_events_map[] = {
{
	.arch = "arm64",
	.cpuid = "0x00000000410fd050",
	.event_table = {
		.pmus = pmu_events__arm_cortex_a55,
		.num_pmus = ARRAY_SIZE(pmu_events__arm_cortex_a55)
	},
	.metric_table = {
		.pmus = NULL,
		.num_pmus = 0
	}
},

static const struct pmu_sys_events pmu_sys_event_tables[] = {
{
	.event_table = {
		.pmus = pmu_events__freescale_imx95_sys,
		.num_pmus = ARRAY_SIZE(pmu_events__freescale_imx95_sys)
	},
	.metric_table = {
		.pmus = pmu_metrics__freescale_imx95_sys,
		.num_pmus = ARRAY_SIZE(pmu_metrics__freescale_imx95_sys)
	},
	.name = "pmu_events__freescale_imx95_sys",
},

Currently, pmu_metrics_table__find() will return NULL when only do perf
stat on sys metric. Then parse_groups() will never be called to parse
sys metric_name, finally perf tool will exit directly. This should be a
common problem. To fix the issue, this will keep the logic before commit
f20c15d13f01 ("perf pmu-events: Remember the perf_events_map for a PMU")
to return a empty metric table rather than a NULL pointer. This should
be fine since the removed part just check if the table match provided
metric_name. Without these code, the code in parse_groups() will also
check the validity of metrci_name too.

Fixes: f20c15d13f01 ("perf pmu-events: Remember the perf_events_map for a PMU")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 12 +-----------
 tools/perf/pmu-events/jevents.py         | 12 +-----------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 2b7516946ded..b8719dab264d 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -585,17 +585,7 @@ const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pm
         if (!map)
                 return NULL;
 
-        if (!pmu)
-                return &map->metric_table;
-
-        for (size_t i = 0; i < map->metric_table.num_pmus; i++) {
-                const struct pmu_table_entry *table_pmu = &map->metric_table.pmus[i];
-                const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
-
-                if (pmu__name_match(pmu, pmu_name))
-                           return &map->metric_table;
-        }
-        return NULL;
+	return &map->metric_table;
 }
 
 const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 6e71b09dbc2a..70f4fd5395fb 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1101,17 +1101,7 @@ const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pm
         if (!map)
                 return NULL;
 
-        if (!pmu)
-                return &map->metric_table;
-
-        for (size_t i = 0; i < map->metric_table.num_pmus; i++) {
-                const struct pmu_table_entry *table_pmu = &map->metric_table.pmus[i];
-                const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
-
-                if (pmu__name_match(pmu, pmu_name))
-                           return &map->metric_table;
-        }
-        return NULL;
+	return &map->metric_table;
 }
 
 const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
-- 
2.47.0.199.ga7371fff76-goog


