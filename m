Return-Path: <stable+bounces-89693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B81279BB369
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0331F23176
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2017F1CACFA;
	Mon,  4 Nov 2024 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZEi9BpRJ"
X-Original-To: stable@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BB11C07EC;
	Mon,  4 Nov 2024 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719680; cv=none; b=b5vfRTHirM7zXZpjjWUJcVWvxO/d2guZ9vbhZotV6rVr+lynoux8eVHx8v0hbUVAYb6/18AR+8dVHcLelBZAZckbv0RI1qMS1jF0bwEZmnNeyEJbpWxwMVD3DppKkKs6V1ssQwNPlQib1zt8iov3zzVPxOkYKICPQ+59g5hOVSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719680; c=relaxed/simple;
	bh=r04tfij5AvjHLqWSHMynEE+bUdin3ecVxudrG96bYJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWPpLeAtkg+HBRo2UO+vcevpNY+JCjHJebVF5HCfLOVZAtUFM85esdYoP0L+34c8qbbkXkQJvV7PW12O2RkyN93IID30JBPnCWQf+Nt1NiXv76wVP47rAAJ0gRIkaadZ9X/vdch6RejvBeCzx1ML+Bp9kbYHgCSoxWuHPghLrTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZEi9BpRJ; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730719675; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Wd2oxyb+vbPAQp/ebmoKg3Otxx3owYEaGtIP0qtImK4=;
	b=ZEi9BpRJfLWElE9sLHw+D4Pku2FaJ/hBcQy34hIBs6w/fWxRILVBCWCtpC6DnP/yuDz0dhveH6gpOXbngBH7yV39Lb4skYwy0YHlAMeunstE84m95g6B5jcEQCjLGBH+L6wk1QFOUFYiY8UOc2cDSUICh3PY+6b7/eq/za+iuEY=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WIgekWY_1730719672 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 19:27:53 +0800
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
Subject: [PATCH 5.10.y 2/2] perf session: Add missing evlist__delete when deleting a session
Date: Mon,  4 Nov 2024 19:27:36 +0800
Message-ID: <20241104112736.28554-3-xueshuai@linux.alibaba.com>
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

From: Riccardo Mancini <rickyman7@gmail.com>

commit cf96b8e45a9bf74d2a6f1e1f88a41b10e9357c6b upstream.

ASan reports a memory leak caused by evlist not being deleted on exit in
perf-report, perf-script and perf-data.
The problem is caused by evlist->session not being deleted, which is
allocated in perf_session__read_header, called in perf_session__new if
perf_data is in read mode.
In case of write mode, the session->evlist is filled by the caller.
This patch solves the problem by calling evlist__delete in
perf_session__delete if perf_data is in read mode.

Changes in v2:
 - call evlist__delete from within perf_session__delete

v1: https://lore.kernel.org/lkml/20210621234317.235545-1-rickyman7@gmail.com/

ASan report follows:

$ ./perf script report flamegraph
=================================================================
==227640==ERROR: LeakSanitizer: detected memory leaks

<SNIP unrelated>

Indirect leak of 2704 byte(s) in 1 object(s) allocated from:
    #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
    #1 0xbe3d56 in zalloc /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
    #2 0x7f999e in evlist__new /home/user/linux/tools/perf/util/evlist.c:77:26
    #3 0x8ad938 in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3797:20
    #4 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
    #5 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
    #6 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
    #7 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
    #8 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
    #9 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
    #10 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
    #11 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)

Indirect leak of 568 byte(s) in 1 object(s) allocated from:
    #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
    #1 0xbe3d56 in zalloc /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
    #2 0x80ce88 in evsel__new_idx /home/user/linux/tools/perf/util/evsel.c:268:24
    #3 0x8aed93 in evsel__new /home/user/linux/tools/perf/util/evsel.h:210:9
    #4 0x8ae07e in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3853:11
    #5 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
    #6 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
    #7 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
    #8 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
    #9 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
    #10 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
    #11 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
    #12 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)

Indirect leak of 264 byte(s) in 1 object(s) allocated from:
    #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
    #1 0xbe3d56 in zalloc /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
    #2 0xbe3e70 in xyarray__new /home/user/linux/tools/lib/perf/xyarray.c:10:23
    #3 0xbd7754 in perf_evsel__alloc_id /home/user/linux/tools/lib/perf/evsel.c:361:21
    #4 0x8ae201 in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3871:7
    #5 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
    #6 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
    #7 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
    #8 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
    #9 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
    #10 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
    #11 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
    #12 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)

Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
    #1 0xbe3d56 in zalloc /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
    #2 0xbd77e0 in perf_evsel__alloc_id /home/user/linux/tools/lib/perf/evsel.c:365:14
    #3 0x8ae201 in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3871:7
    #4 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
    #5 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
    #6 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
    #7 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
    #8 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
    #9 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
    #10 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
    #11 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)

Indirect leak of 7 byte(s) in 1 object(s) allocated from:
    #0 0x4b8207 in strdup (/home/user/linux/tools/perf/perf+0x4b8207)
    #1 0x8b4459 in evlist__set_event_name /home/user/linux/tools/perf/util/header.c:2292:16
    #2 0x89d862 in process_event_desc /home/user/linux/tools/perf/util/header.c:2313:3
    #3 0x8af319 in perf_file_section__process /home/user/linux/tools/perf/util/header.c:3651:9
    #4 0x8aa6e9 in perf_header__process_sections /home/user/linux/tools/perf/util/header.c:3427:9
    #5 0x8ae3e7 in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3886:2
    #6 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
    #7 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
    #8 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
    #9 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
    #10 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
    #11 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
    #12 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
    #13 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)

SUMMARY: AddressSanitizer: 3728 byte(s) leaked in 7 allocation(s).

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
Acked-by: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20210624231926.212208-1-rickyman7@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: stable@vger.kernel.org # 5.10.228
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 tools/perf/util/session.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 354e1e04a266..81b7ec2ae861 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -299,8 +299,11 @@ void perf_session__delete(struct perf_session *session)
 	perf_session__release_decomp_events(session);
 	perf_env__exit(&session->header.env);
 	machines__exit(&session->machines);
-	if (session->data)
+	if (session->data) {
+		if (perf_data__is_read(session->data))
+			evlist__delete(session->evlist);
 		perf_data__close(session->data);
+	}
 	free(session);
 }
 
-- 
2.39.3


