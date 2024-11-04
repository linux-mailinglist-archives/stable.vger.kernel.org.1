Return-Path: <stable+bounces-89692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5D89BB364
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507201C2152B
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F3E1C0DF0;
	Mon,  4 Nov 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CpPx29cC"
X-Original-To: stable@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922E61BFE10;
	Mon,  4 Nov 2024 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719678; cv=none; b=HpRjucJJBx9ta+tvBfvKIwfJijAfY/6lPfKWkN5ZPkfrkk6a5wRnENtfweFjr/mVV9TGHrmLNF8qbccUUWIVPuU6ewtY5mCkYx+ssvUs3poNdAgnCViI5Bvyi6z1HlN4cRAdmjFtaGtCgr1P3kLe+680+iKcx2nBTFd1P/poC9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719678; c=relaxed/simple;
	bh=DaSIEBgG2arTZrXAqthhtGFZjVD7oESyK8ikcDhZAaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnSK8Gb7JrAjFeQvKf+g4uWUGrvjxGAwSPV63C8BycQYf93dsNdumKu8SuAymxbEF/qB0axwqU0LFaANEboPi2KUBpeItGKwAhYNFX0ep4hpTRpYiMKhAnqgjTYQmx44gkf3MZnA2ovaoSrQx3zQIFf8p73UrjrHOSERNwznxBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CpPx29cC; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730719673; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Ymfli/aj8w7Alz6lpVhVsP42jBq57YRIsah1Dm91/4g=;
	b=CpPx29cCDqPSflkKH30V52ycHYh8Cfpii3RL3o+KDAxyrTZGVhoIh+dfHsAQB8EK5fajjoz/wwLdPXft7BEAwjK8KrnDI0qztQm3osjx2wCV4XZEJncZo8fg8MZWlxMgVoN8oAeL9Kd9Fjc7XEp24YTmMAkHoKA9kYYzjWYTPvM=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WIgekVk_1730719670 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 19:27:51 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	gregkh@linuxfoundation.org
Cc: adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	mark.rutland@arm.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	acme@redhat.com,
	kprateek.nayak@amd.com,
	ravi.bangoria@amd.com,
	sandipan.das@amd.com,
	anshuman.khandual@arm.com,
	german.gomez@arm.com,
	james.clark@arm.com,
	terrelln@fb.com,
	seanjc@google.com,
	changbin.du@huawei.com,
	liuwenyu7@huawei.com,
	yangjihong1@huawei.com,
	mhiramat@kernel.org,
	ojeda@kernel.org,
	song@kernel.org,
	leo.yan@linaro.org,
	kjain@linux.ibm.com,
	ak@linux.intel.com,
	kan.liang@linux.intel.com,
	atrajeev@linux.vnet.ibm.com,
	siyanteng@loongson.cn,
	liam.howlett@oracle.com,
	pbonzini@redhat.com,
	jolsa@kernel.org
Subject: [PATCH 5.10.y 1/2] Revert "perf hist: Add missing puts to hist__account_cycles"
Date: Mon,  4 Nov 2024 19:27:35 +0800
Message-ID: <20241104112736.28554-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241104112736.28554-1-xueshuai@linux.alibaba.com>
References: <20241104112736.28554-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revert "perf hist: Add missing puts to hist__account_cycles"

This reverts commit a83fc293acd5c5050a4828eced4a71d2b2fffdd3.

On x86 platform, kernel v5.10.228, perf-report command aborts due to "free():
invalid pointer" when perf-record command is run with taken branch stack
sampling enabled. This regression can be reproduced with the following steps:

	- sudo perf record -b
	- sudo perf report

The root cause is that bi[i].to.ms.maps does not always point to thread->maps,
which is a buffer dynamically allocated by maps_new(). Instead, it may point to
&machine->kmaps, while kmaps is not a pointer but a variable. The original
upstream commit c1149037f65b ("perf hist: Add missing puts to
hist__account_cycles") worked well because machine->kmaps had been refactored to
a pointer by the previous commit 1a97cee604dc ("perf maps: Use a pointer for
kmaps").

To this end, just revert commit a83fc293acd5c5050a4828eced4a71d2b2fffdd3.

It is worth noting that the memory leak issue, which the reverted patch intended
to fix, has been solved by commit cf96b8e45a9b ("perf session: Add missing
evlist__delete when deleting a session"). The root cause is that the evlist is
not being deleted on exit in perf-report, perf-script, and perf-data.
Consequently, the reference count of the thread increased by thread__get() in
hist_entry__init() is not decremented in hist_entry__delete(). As a result,
thread->maps is not properly freed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: German Gomez <german.gomez@arm.com>
Cc: James Clark <james.clark@arm.com>
Cc: Nick Terrell <terrelln@fb.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Changbin Du <changbin.du@huawei.com>
Cc: liuwenyu <liuwenyu7@huawei.com>
Cc: Yang Jihong <yangjihong1@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Song Liu <song@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Yanteng Si <siyanteng@loongson.cn>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: stable@vger.kernel.org # 5.10.228
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 tools/perf/util/hist.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index c78d8813811c..8a793e4c9400 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2624,6 +2624,8 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 
 	/* If we have branch cycles always annotate them. */
 	if (bs && bs->nr && entries[0].flags.cycles) {
+		int i;
+
 		bi = sample__resolve_bstack(sample, al);
 		if (bi) {
 			struct addr_map_symbol *prev = NULL;
@@ -2638,7 +2640,7 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			 * Note that perf stores branches reversed from
 			 * program order!
 			 */
-			for (int i = bs->nr - 1; i >= 0; i--) {
+			for (i = bs->nr - 1; i >= 0; i--) {
 				addr_map_symbol__account_cycles(&bi[i].from,
 					nonany_branch_mode ? NULL : prev,
 					bi[i].flags.cycles);
@@ -2647,12 +2649,6 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 				if (total_cycles)
 					*total_cycles += bi[i].flags.cycles;
 			}
-			for (unsigned int i = 0; i < bs->nr; i++) {
-				map__put(bi[i].to.ms.map);
-				maps__put(bi[i].to.ms.maps);
-				map__put(bi[i].from.ms.map);
-				maps__put(bi[i].from.ms.maps);
-			}
 			free(bi);
 		}
 	}
-- 
2.39.3


