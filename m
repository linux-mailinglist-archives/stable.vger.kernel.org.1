Return-Path: <stable+bounces-49641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A28D58FEE3E
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88291C24523
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91C71A0AE0;
	Thu,  6 Jun 2024 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XY/6iAZN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CC91A01DA;
	Thu,  6 Jun 2024 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683636; cv=none; b=TlFoCa0Vb4Equ+H2yfCB2+IxpOKYkdh4ppK3Ar8r54au4idl3AYgPJih+JTNGSlI1WNzj383eoRHj6oSwRQRLzWlIjo+GZB2M3nCfga7uq6etyc3/hlzTUZOvpdI9FB8JiX1jDHerrGSsFp3u0G1ksfkJADEyZ5MiVTrHZecHH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683636; c=relaxed/simple;
	bh=BedvyeTFZwaUcKmXmRt4iV4uGvr/r6HEtziwLdyI4aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kn02v/8+d5LVb6mIHkeLnEUjNBCbfiWQeJf3ZNcZ7iKMMFz5R2/0X5Ye3VObHROFk0x4fP9jtKJpBtkExRP8V8ZRIl6CcypoDE+puk+TFqCm1RdaBNgoAiJwnQ9wDT8+1/S6i4OSZqWFsTc785Ty2Bb4WPSn+6ZTNZUCHA4m874=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XY/6iAZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1851FC2BD10;
	Thu,  6 Jun 2024 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683636;
	bh=BedvyeTFZwaUcKmXmRt4iV4uGvr/r6HEtziwLdyI4aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XY/6iAZNQ5tQj/mKdo+YyUuIo6yIZRPIPm5z8V/cv+eQr6RLOHx85RiBNiDg6AVGP
	 8DIt8R7I1Sz0YmblycX6bxw7eliYl5VOT0fYfxi5P5q5ujNY2T4OCYW/MFlr6bE+oT
	 ygrHLrbJ6W6j9WtUG+B9seWHVQwXQSqckHLuF85A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 508/744] perf report: Avoid SEGV in report__setup_sample_type()
Date: Thu,  6 Jun 2024 16:03:00 +0200
Message-ID: <20240606131748.747506858@linuxfoundation.org>
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

[ Upstream commit 45b4f402a6b782352c4bafcff682bfb01da9ca05 ]

In some cases evsel->name is lazily initialized in evsel__name(). If not
initialized passing NULL to strstr() leads to a SEGV.

Fixes: ccb17caecfbd542f ("perf report: Set PERF_SAMPLE_DATA_SRC bit for Arm SPE event")
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@linux.dev>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240508035301.1554434-4-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 169c64e9a01a8..2a8889c6d7f97 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -426,7 +426,7 @@ static int report__setup_sample_type(struct report *rep)
 		 * compatibility, set the bit if it's an old perf data file.
 		 */
 		evlist__for_each_entry(session->evlist, evsel) {
-			if (strstr(evsel->name, "arm_spe") &&
+			if (strstr(evsel__name(evsel), "arm_spe") &&
 				!(sample_type & PERF_SAMPLE_DATA_SRC)) {
 				evsel->core.attr.sample_type |= PERF_SAMPLE_DATA_SRC;
 				sample_type |= PERF_SAMPLE_DATA_SRC;
-- 
2.43.0




