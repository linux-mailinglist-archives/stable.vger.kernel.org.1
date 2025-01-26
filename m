Return-Path: <stable+bounces-110783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5480AA1CC61
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079651884185
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCB11F9AAB;
	Sun, 26 Jan 2025 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJjwryvl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FA118A924;
	Sun, 26 Jan 2025 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904168; cv=none; b=aprHrmTXS3MxsnND9T199AWnVgWhAX6eE21A9+QVn4fKe/E3Wrx3XJQAreWPJLLeNkaHuXeXF7x7Zd/HTgc0BhugIV3SI+S97k+SudsTd9oz2Ty0r1M3UZwT9d594+ldhDGGwV+bold3OktO9RDk8wKfN3NMVVrpFgk4c9U19BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904168; c=relaxed/simple;
	bh=qwCrlpBZb+ssNcQFYQepigLDu75J4MYFyMeMGCDgcRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sb5BufRnay9yS94L4rZPphFFI8FoYcUm67GGzw4L1ymxaC3ADZkXRLl7oSDs8l0oB3G+d8PhsvWEwlTXOhahNPhIKW0M/X1LX1i+zH27yoy2l8tnROmqN7VHaONcu+ripIU/RsfRxbzbC74Hd0yDzAfiMjG5vpa8MB4/8N0wLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJjwryvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED60C4CED3;
	Sun, 26 Jan 2025 15:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904168;
	bh=qwCrlpBZb+ssNcQFYQepigLDu75J4MYFyMeMGCDgcRY=;
	h=From:To:Cc:Subject:Date:From;
	b=IJjwryvla+hbVZCS6BQLod3mpImGGvum1lvPVvDNegOO7b7hgJSD/9CHSrAzg8vmP
	 /Ag8P4eXyQeUBLcjlQpCsMcRzDxb6TJA9CIxBo+hpHb3cXjKf3nS5MvLP+omGvRb0N
	 8br/3pgKVHsnJ+EXuLskraYJzA5UGyaQiu8eAHme8ujaWe5c6iaO4xX+I7zxSys0zG
	 6MfQ/KeVJphuxjS4HEaXTUyYshwj316M3fVGgJ+fFkdSo1LvkMGFEDOOe73HXT+XJn
	 Yyx9qREBu0WP67sYQkb4W2R0IoNDn3rbtp8VRWKnBd2w22pxPkNR+8HbfPv5A1Isxt
	 jIVUth/d0lkfA==
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
Subject: [PATCH AUTOSEL 5.15 1/3] tool api fs: Correctly encode errno for read/write open failures
Date: Sun, 26 Jan 2025 10:09:20 -0500
Message-Id: <20250126150923.962963-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.177
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


