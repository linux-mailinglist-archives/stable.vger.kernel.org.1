Return-Path: <stable+bounces-110768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F071A1CC45
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C4E16AA0B
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E17239797;
	Sun, 26 Jan 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIW2X6+n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C6618A6B5;
	Sun, 26 Jan 2025 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904128; cv=none; b=aZT7z9p4CR5jmrH46+LE+to5W4JuufnDWHDzGhcBWm3x8Xg3bCPqSRj1ld37JgkONUPS9fOPE70WVx/p32aeQ9vTQmNPuxHAw8DZTOTlFkwNr+0vX6trh0h2UmnEwbA2ZBDfAyvbO8LrPoIlD1GtGeobtMgBO4fEdFq0OnfWzl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904128; c=relaxed/simple;
	bh=YVAxOjDTQgG4X5Z+5XBMLOGk7z6Cq7Ws5BFyPleI3RM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I8WTjXmTNyXpf7gUICaTUvCyBKptmF3lGusPjqLr9WviBG+0Af4Pp7iwlwr8gCrYhaZ6eLLEcho+n6HQgRrJOV/bbGhoCs11RrGUsrEpmq2teGz2+YGxdFOlaMWolyZh+K/IxtkrVmniQxwvn1f7ArouInanfiMalYiS0yFfb1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIW2X6+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A75EC4CED3;
	Sun, 26 Jan 2025 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904128;
	bh=YVAxOjDTQgG4X5Z+5XBMLOGk7z6Cq7Ws5BFyPleI3RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oIW2X6+nKKndCOBwKP07jtSmSrf7Wfo+CNeu2TH2dl8lNAVHWcIJGgrV9tdo545OU
	 dNF9gwoBjOsHeq3Ofaw+nyCwbE9G9ysN1+VzCKEoUrJBwslC5t0c79kNo2lo1Ln7xG
	 U8km/JhqjaD9Oz7iCoFfhlzwX6gdB5avuFcZDiM+fkKy502HKwDPJWGsNlf3eLQ8nR
	 nh6DzmNE7xRD8/o5UafsLDj0nL9syei1InOUBsoi8vkuhm+69r1nzX6CWJyiFXG1T9
	 jBKGvcn8b1TaCvQEqn9mmIfunl2s9fQKQqkz+3NFLisUOYqIw1m/UOlW5W2E0IanC1
	 gDg1E/+sfW/fQ==
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
Subject: [PATCH AUTOSEL 6.6 3/9] tool api fs: Correctly encode errno for read/write open failures
Date: Sun, 26 Jan 2025 10:08:31 -0500
Message-Id: <20250126150839.962669-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150839.962669-1-sashal@kernel.org>
References: <20250126150839.962669-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
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
index 5cb0eeec2c8a6..e7c1f084d05f2 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -295,7 +295,7 @@ int filename__read_int(const char *filename, int *value)
 	int fd = open(filename, O_RDONLY), err = -1;
 
 	if (fd < 0)
-		return -1;
+		return -errno;
 
 	if (read(fd, line, sizeof(line)) > 0) {
 		*value = atoi(line);
@@ -313,7 +313,7 @@ static int filename__read_ull_base(const char *filename,
 	int fd = open(filename, O_RDONLY), err = -1;
 
 	if (fd < 0)
-		return -1;
+		return -errno;
 
 	if (read(fd, line, sizeof(line)) > 0) {
 		*value = strtoull(line, NULL, base);
@@ -400,7 +400,7 @@ int filename__write_int(const char *filename, int value)
 	char buf[64];
 
 	if (fd < 0)
-		return err;
+		return -errno;
 
 	sprintf(buf, "%d", value);
 	if (write(fd, buf, sizeof(buf)) == sizeof(buf))
-- 
2.39.5


