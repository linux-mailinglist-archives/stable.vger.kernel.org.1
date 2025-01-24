Return-Path: <stable+bounces-110394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42C2A1BC5B
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 19:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C18F3A40B4
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7178D224AED;
	Fri, 24 Jan 2025 18:48:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4078B2248B9;
	Fri, 24 Jan 2025 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744526; cv=none; b=sXrmVZ49vwRhcTigR7TYDtEGbtSoFqgmd7/+eQNNwT6JxZXFubdpBJHSQn/myrSGvwLYzK7Be2z3ykkAe72GYJGuNSeiMTgxuwB9Gt/E7TJ29YrYROYFf8UkYxfLxiIULwdFgfYMztc2CtJ5nQ8+heRf/U8nlCRhTQ0Wk21DFmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744526; c=relaxed/simple;
	bh=P10PejN5oJlunkjUJvK6/R2Is2zNt27mNcv/btPnBaU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=uWyhC0XVSZrv0FUPYaLUMFyjITqKnGBJ2+4QPa3y+h8kkAUehwMHYeGeVL2VPLpixXSnfQ0QYYCJkrc1LSRdgVrSTduWUcsavF1vS8LHStxrooSWHXHp4pe5DuoqnCwkFWM8vUeO1ofjtV386LQ62usniXjc/WQd7X+s+ZFZCeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E39C4CEE1;
	Fri, 24 Jan 2025 18:48:45 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tbOjg-00000001FAA-3bzv;
	Fri, 24 Jan 2025 13:48:56 -0500
Message-ID: <20250124184856.713740454@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 24 Jan 2025 13:48:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 stable@vger.kernel.org,
 Luis Goncalves <lgoncalv@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 03/14] rtla/timerlat_hist: Stop timerlat tracer on signal
References: <20250124184835.052017152@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Currently, when either SIGINT from the user or SIGALRM from the duration
timer is caught by rtla-timerlat, stop_tracing is set to break out of
the main loop. This is not sufficient for cases where the timerlat
tracer is producing more data than rtla can consume, since in that case,
rtla is looping indefinitely inside tracefs_iterate_raw_events, never
reaches the check of stop_tracing and hangs.

In addition to setting stop_tracing, also stop the timerlat tracer on
received signal (SIGINT or SIGALRM). This will stop new samples so that
the existing samples may be processed and tracefs_iterate_raw_events
eventually exits.

Cc: stable@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/20250116144931.649593-3-tglozar@redhat.com
Fixes: 1eeb6328e8b3 ("rtla/timerlat: Add timerlat hist mode")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/timerlat_hist.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 8b66387e5f35..f1edf1c8a7b0 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1131,9 +1131,12 @@ static struct osnoise_tool
 }
 
 static int stop_tracing;
+static struct trace_instance *hist_inst = NULL;
 static void stop_hist(int sig)
 {
 	stop_tracing = 1;
+	if (hist_inst)
+		trace_instance_stop(hist_inst);
 }
 
 /*
@@ -1180,6 +1183,12 @@ int timerlat_hist_main(int argc, char *argv[])
 	}
 
 	trace = &tool->trace;
+	/*
+	 * Save trace instance into global variable so that SIGINT can stop
+	 * the timerlat tracer.
+	 * Otherwise, rtla could loop indefinitely when overloaded.
+	 */
+	hist_inst = trace;
 
 	retval = enable_timerlat(trace);
 	if (retval) {
@@ -1348,7 +1357,7 @@ int timerlat_hist_main(int argc, char *argv[])
 
 	return_value = 0;
 
-	if (trace_is_off(&tool->trace, &record->trace)) {
+	if (trace_is_off(&tool->trace, &record->trace) && !stop_tracing) {
 		printf("rtla timerlat hit stop tracing\n");
 
 		if (!params->no_aa)
-- 
2.45.2



