Return-Path: <stable+bounces-110786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6115A1CC83
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C60F7A1252
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C7224817A;
	Sun, 26 Jan 2025 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YH/FicDX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E559518A6CE;
	Sun, 26 Jan 2025 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904177; cv=none; b=OUc3PvyYLSsLXiOnkIYWWAsiKA1vzSo6ARg8lU9WaMJ0dSrGMyCyaYjVTV3aoADrdR7vhi4EWJmCvtdiTi6yjbzJILKKs3bfa/J5luV1SqrA8Fq8X3yncnARkMEQGgtawQVpQz5s0SDXlb4AGe9ftx7zO1PbSGNFFdr6Xl/fs0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904177; c=relaxed/simple;
	bh=qwCrlpBZb+ssNcQFYQepigLDu75J4MYFyMeMGCDgcRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VvNr87pifG4d3Ci1cYQWZFnYIiYIGLK2pCV2Tuw8OeH9dYkWYn2OLmVhqe/KcH9vdWs4u02CPS3XYbWK044d9bmZgvKYwley3ROInZCgdVAfh+06bPPFBI5GLyZ1aq+5Wau9ihrds9ogyFGa1A+70guriowRoUcQ0/6/E7gnWcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YH/FicDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADBDC4CEE4;
	Sun, 26 Jan 2025 15:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904176;
	bh=qwCrlpBZb+ssNcQFYQepigLDu75J4MYFyMeMGCDgcRY=;
	h=From:To:Cc:Subject:Date:From;
	b=YH/FicDXHKctcpBUY8PfiNxmF+5RMRvazjYJkyMcdPtvvGUmRC7GxSTfU6OdTlWp5
	 TpSwLA53oah6awQ5gw8AVLuh+M+U35/yHsKKTuJ+POc2IJRwqkUPKX+omlI/loh2i0
	 CEcp5FxeQFG7ClUbu8c37OsFXr4zE4MQmOsyCtcSWeUyhI5edLLODG7F5esnihv6fK
	 7kjEMpJKTc5mGfmBsYrH9pnm9Wy2Sk7LK6b3hCPC33irif753tVy59988KzlaBj9/D
	 ZqKxgYTsPYHHabK5qibohrQm/eEn8l7x9eFkViP97dPQC4QAMd9922C2VuFwDAHRHV
	 Z51lVHz8HNoKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Ben Gainey <ben.gainey@arm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Paran Lee <p4ranlee@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Steinar H . Gunderson" <sesse@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Ze Gao <zegao2021@gmail.com>,
	Zixian Cai <fzczx123@gmail.com>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 1/2] tool api fs: Correctly encode errno for read/write open failures
Date: Sun, 26 Jan 2025 10:09:30 -0500
Message-Id: <20250126150932.963016-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.233
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

[ Upstream commit 05be17eed774aaf56f6b1e12714325ca3a266c04 ]

Switch from returning -1 to -errno so that callers can determine types
of failure.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Ben Gainey <ben.gainey@arm.com>
Cc: Colin Ian King <colin.i.king@gmail.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Paran Lee <p4ranlee@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steinar H. Gunderson <sesse@google.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Falcon <thomas.falcon@intel.com>
Cc: Weilin Wang <weilin.wang@intel.com>
Cc: Yang Jihong <yangjihong@bytedance.com>
Cc: Yang Li <yang.lee@linux.alibaba.com>
Cc: Ze Gao <zegao2021@gmail.com>
Cc: Zixian Cai <fzczx123@gmail.com>
Cc: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
Link: https://lore.kernel.org/r/20241118225345.889810-3-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/api/fs/fs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 82f53d81a7a78..a0a6a907315f0 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -323,7 +323,7 @@ int filename__read_int(const char *filename, int *value)
 	int fd = open(filename, O_RDONLY), err = -1;
 
 	if (fd < 0)
-		return -1;
+		return -errno;
 
 	if (read(fd, line, sizeof(line)) > 0) {
 		*value = atoi(line);
@@ -341,7 +341,7 @@ static int filename__read_ull_base(const char *filename,
 	int fd = open(filename, O_RDONLY), err = -1;
 
 	if (fd < 0)
-		return -1;
+		return -errno;
 
 	if (read(fd, line, sizeof(line)) > 0) {
 		*value = strtoull(line, NULL, base);
@@ -428,7 +428,7 @@ int filename__write_int(const char *filename, int value)
 	char buf[64];
 
 	if (fd < 0)
-		return err;
+		return -errno;
 
 	sprintf(buf, "%d", value);
 	if (write(fd, buf, sizeof(buf)) == sizeof(buf))
-- 
2.39.5


