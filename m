Return-Path: <stable+bounces-154245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1EDADD8EE
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A445A1BC6
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86F82EA161;
	Tue, 17 Jun 2025 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HE8FBw5N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CBE236435;
	Tue, 17 Jun 2025 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178568; cv=none; b=m2dvr3mD/NylOPTVlHiwKjCVuGZOQNGXhoWXn3gMHdf+AfUTQcZbzTOrqNbF4ocIIIYchbSDLxcYfFt9vFeSf7V4XI39RKaDWuKhBKNPOv6ZEQR1Ln4kDntkG6+uhDHF3HNtIw/bmDzSvyxMotSSnukk6VRYmHaqK7Vr8XJ/dCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178568; c=relaxed/simple;
	bh=Bdy664Lx0aO6RyyzFvyzDNh4IpctPAAKZpdUNmc/RxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUHFZn3CE9o5+FNXhb3kMEJR1uQub1HWks88bot3PSsPZ0uCPtPLGQyaWIAYJe/mmOeGvj4I9gX7+GDZpRo3dKjd1dOhO1z8N1u6pTnCxXWtZ+dtIbMlGVMlfKFbqBqhViPD9QMPFKtBjBPFr8PfMwrOVKC/LY/m6GSrscPpjUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HE8FBw5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2094C4CEE3;
	Tue, 17 Jun 2025 16:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178568;
	bh=Bdy664Lx0aO6RyyzFvyzDNh4IpctPAAKZpdUNmc/RxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HE8FBw5NtyJ71xDUSEZUcFe91um8nN745K2xXWZTxn4EaDQNRPuXIKvO5nUyVsX6W
	 rWuQcnrv8UYw8md5Mzw/O/uI8sXtkfJUvsKB2EVaWSovj1Bmpx2vY7lJvtQWcFRkdi
	 KCR0Di24jjL0MMg2u3WSqXv+o+OyQO8wSDu1O074=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Ben Gainey <ben.gainey@arm.com>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Dmitriy Vyukov <dvyukov@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Graham Woodward <graham.woodward@arm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	=?UTF-8?q?Krzysztof=20=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	Leo Yan <leo.yan@linux.dev>,
	Levi Yun <yeoreum.yun@arm.com>,
	Li Huafei <lihuafei1@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	=?UTF-8?q?Martin=20Li=C5=A1ka?= <martin.liska@hey.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Fleming <matt@readmodwrite.com>,
	Mike Leach <mike.leach@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Song Liu <song@kernel.org>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Steve Clevenger <scclevenger@os.amperecomputing.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Will Deacon <will@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Yujie Liu <yujie.liu@intel.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Zixian Cai <fzczx123@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 487/780] perf callchain: Always populate the addr_location map when adding IP
Date: Tue, 17 Jun 2025 17:23:15 +0200
Message-ID: <20250617152511.321697149@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit a913ef6fd883c05bd6538ed21ee1e773f0d750b7 ]

Dropping symbols also meant the callchain maps wasn't populated, but
the callchain map is needed to find the DSO.

Plumb the symbols option better, falling back to thread__find_map()
rather than thread__find_symbol() when symbols are disabled.

Fixes: 02b2705017d2e5ad ("perf callchain: Allow symbols to be optional when resolving a callchain")
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: Ben Gainey <ben.gainey@arm.com>
Cc: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>
Cc: Chun-Tse Shao <ctshao@google.com>
Cc: Colin Ian King <colin.i.king@gmail.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Dr. David Alan Gilbert <linux@treblig.org>
Cc: Graham Woodward <graham.woodward@arm.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Krzysztof Łopatowski <krzysztof.m.lopatowski@gmail.com>
Cc: Leo Yan <leo.yan@linux.dev>
Cc: Levi Yun <yeoreum.yun@arm.com>
Cc: Li Huafei <lihuafei1@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Martin Liška <martin.liska@hey.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Matt Fleming <matt@readmodwrite.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Song Liu <song@kernel.org>
Cc: Steinar H. Gunderson <sesse@google.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Steve Clevenger <scclevenger@os.amperecomputing.com>
Cc: Thomas Falcon <thomas.falcon@intel.com>
Cc: Veronika Molnarova <vmolnaro@redhat.com>
Cc: Weilin Wang <weilin.wang@intel.com>
Cc: Will Deacon <will@kernel.org>
Cc: Yicong Yang <yangyicong@hisilicon.com>
Cc: Yujie Liu <yujie.liu@intel.com>
Cc: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: Zixian Cai <fzczx123@gmail.com>
Link: https://lore.kernel.org/r/20250529044000.759937-2-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/machine.c | 6 ++++--
 tools/perf/util/thread.c  | 8 ++++++--
 tools/perf/util/thread.h  | 2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2531b373f2cf7..b048165b10c14 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1976,7 +1976,7 @@ static void ip__resolve_ams(struct thread *thread,
 	 * Thus, we have to try consecutively until we find a match
 	 * or else, the symbol is unknown
 	 */
-	thread__find_cpumode_addr_location(thread, ip, &al);
+	thread__find_cpumode_addr_location(thread, ip, /*symbols=*/true, &al);
 
 	ams->addr = ip;
 	ams->al_addr = al.addr;
@@ -2078,7 +2078,7 @@ static int add_callchain_ip(struct thread *thread,
 	al.sym = NULL;
 	al.srcline = NULL;
 	if (!cpumode) {
-		thread__find_cpumode_addr_location(thread, ip, &al);
+		thread__find_cpumode_addr_location(thread, ip, symbols, &al);
 	} else {
 		if (ip >= PERF_CONTEXT_MAX) {
 			switch (ip) {
@@ -2106,6 +2106,8 @@ static int add_callchain_ip(struct thread *thread,
 		}
 		if (symbols)
 			thread__find_symbol(thread, *cpumode, ip, &al);
+		else
+			thread__find_map(thread, *cpumode, ip, &al);
 	}
 
 	if (al.sym != NULL) {
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 89585f53c1d5c..10a01f8fbd400 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -410,7 +410,7 @@ int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp, bo
 }
 
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
-					struct addr_location *al)
+					bool symbols, struct addr_location *al)
 {
 	size_t i;
 	const u8 cpumodes[] = {
@@ -421,7 +421,11 @@ void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 	};
 
 	for (i = 0; i < ARRAY_SIZE(cpumodes); i++) {
-		thread__find_symbol(thread, cpumodes[i], addr, al);
+		if (symbols)
+			thread__find_symbol(thread, cpumodes[i], addr, al);
+		else
+			thread__find_map(thread, cpumodes[i], addr, al);
+
 		if (al->map)
 			break;
 	}
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index cd574a896418a..2b90bbed7a612 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -126,7 +126,7 @@ struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
 				      u64 addr, struct addr_location *al);
 
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
-					struct addr_location *al);
+					bool symbols, struct addr_location *al);
 
 int thread__memcpy(struct thread *thread, struct machine *machine,
 		   void *buf, u64 ip, int len, bool *is64bit);
-- 
2.39.5




