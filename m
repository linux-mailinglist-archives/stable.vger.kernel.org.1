Return-Path: <stable+bounces-80742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 492A69904F9
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 15:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704A81C221ED
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 13:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5EC2139C6;
	Fri,  4 Oct 2024 13:56:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828AE212F1E;
	Fri,  4 Oct 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050187; cv=none; b=Hs/pfo1xBP6cRi0YnW7tg9SZ5/bIax1iqt8nU57efVlaE0Srr8Gdl7PuoKgFEzkZesNEzY9g3bSECAT8lmr0Qkb+sHlbLUB3+B8RNv8n9q+LmcExCrp4LC/kcsoAoFmjnVGyy444Sfb6aDHsbrs2+7+39ld9gKLdwLZDx4imYV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050187; c=relaxed/simple;
	bh=kE5N9LMzZ5xDIVfqC2ZVNeflYoiHF/zPTxu7bKcTfKA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OVoZ48NddykV62lXnGe3Rqixi+71wIHpNRcLZs4Kq7THu/EH2FxeF8oFCtDrI7j7flPVGPbCuoT9johIOBclNmTLASKUGjINCd8r143jyEZu1s3r8HENDSnV9WghicpgHV+gOh0xsYjcR+OPlaxJew7R0BQ41XLSRavm4G0LLLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344F0C4CEC7;
	Fri,  4 Oct 2024 13:56:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1swio7-00000005C94-2aO5;
	Fri, 04 Oct 2024 09:57:23 -0400
Message-ID: <20241004135723.471955359@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 04 Oct 2024 09:56:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Tomas Glozar <tglozar@redhat.com>,
 Eder Zulian <ezulian@redhat.com>
Subject: [for-linus][PATCH 3/8] rtla: Fix the help text in osnoise and timerlat top tools
References: <20241004135655.993267242@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Eder Zulian <ezulian@redhat.com>

The help text in osnoise top and timerlat top had some minor errors
and omissions. The -d option was missing the 's' (second) abbreviation and
the error message for '-d' used '-D'.

Cc: stable@vger.kernel.org
Fixes: 1eceb2fc2ca54 ("rtla/osnoise: Add osnoise top mode")
Fixes: a828cd18bc4ad ("rtla: Add timerlat tool and timelart top mode")
Link: https://lore.kernel.org/20240813155831.384446-1-ezulian@redhat.com
Suggested-by: Tomas Glozar <tglozar@redhat.com>
Reviewed-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Eder Zulian <ezulian@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/osnoise_top.c  | 2 +-
 tools/tracing/rtla/src/timerlat_top.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 2f756628613d..30e3853076a0 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -442,7 +442,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'd':
 			params->duration = parse_seconds_duration(optarg);
 			if (!params->duration)
-				osnoise_top_usage(params, "Invalid -D duration\n");
+				osnoise_top_usage(params, "Invalid -d duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 8c16419fe22a..210b0f533534 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -459,7 +459,7 @@ static void timerlat_top_usage(char *usage)
 		"	  -c/--cpus cpus: run the tracer only on the given cpus",
 		"	  -H/--house-keeping cpus: run rtla control threads only on the given cpus",
 		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
-		"	  -d/--duration time[m|h|d]: duration of the session in seconds",
+		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
 		"	     --dump-tasks: prints the task running on all CPUs if stop conditions are met (depends on !--no-aa)",
 		"	  -t/--trace[file]: save the stopped trace to [file|timerlat_trace.txt]",
@@ -613,7 +613,7 @@ static struct timerlat_top_params
 		case 'd':
 			params->duration = parse_seconds_duration(optarg);
 			if (!params->duration)
-				timerlat_top_usage("Invalid -D duration\n");
+				timerlat_top_usage("Invalid -d duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
-- 
2.45.2



