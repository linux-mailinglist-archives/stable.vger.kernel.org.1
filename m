Return-Path: <stable+bounces-110393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAD8A1BC5A
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 19:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EEF116D05C
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 18:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72269224AEF;
	Fri, 24 Jan 2025 18:48:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407212248B8;
	Fri, 24 Jan 2025 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744526; cv=none; b=P8xNMuq6VtgkiXgrIr8N8esaP4ezn2uDjh2y3b4CGCNs4ozRjyf6J7CToQ81pjzH6FFrxgDHwh7Iv3j/qswy67LKWhQEbOw/voScSmxy+9VSNDPDz+QMjkqebw13KTpOcgjh3qxGLDdGvyE6uOAj/w7ag+tUgMRcWoCaXFtNbp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744526; c=relaxed/simple;
	bh=BspQb9QjiySTVe0WEVq+jOlRKe46nEEJnbxOVYP6v3A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NdNWNk3OpgWWqC/AKzVRFYwe+64pJHTBTaywNl1nHqwQl6p+N3VEpijff6L7NllR0cyIU0bhOSm5xHLgRTr3ae05V1R1PmlwMwH4joq1SDYHSOiiO2mhNb4QcppOcOQvvUfpcGvKxGA1B8aSCOD1UhhjbwDRrXmkwz571nMXtqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FD0C4CEE3;
	Fri, 24 Jan 2025 18:48:45 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tbOjh-00000001FAe-07yr;
	Fri, 24 Jan 2025 13:48:57 -0500
Message-ID: <20250124184856.882257259@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 24 Jan 2025 13:48:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 stable@vger.kernel.org,
 Luis Goncalves <lgoncalv@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 04/14] rtla/timerlat_top: Stop timerlat tracer on signal
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
Link: https://lore.kernel.org/20250116144931.649593-4-tglozar@redhat.com
Fixes: a828cd18bc4a ("rtla: Add timerlat tool and timelart top mode")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/timerlat_top.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 059b468981e4..d21a21053917 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -900,9 +900,12 @@ static struct osnoise_tool
 }
 
 static int stop_tracing;
+static struct trace_instance *top_inst = NULL;
 static void stop_top(int sig)
 {
 	stop_tracing = 1;
+	if (top_inst)
+		trace_instance_stop(top_inst);
 }
 
 /*
@@ -950,6 +953,13 @@ int timerlat_top_main(int argc, char *argv[])
 	}
 
 	trace = &top->trace;
+	/*
+	* Save trace instance into global variable so that SIGINT can stop
+	* the timerlat tracer.
+	* Otherwise, rtla could loop indefinitely when overloaded.
+	*/
+	top_inst = trace;
+
 
 	retval = enable_timerlat(trace);
 	if (retval) {
@@ -1131,7 +1141,7 @@ int timerlat_top_main(int argc, char *argv[])
 
 	return_value = 0;
 
-	if (trace_is_off(&top->trace, &record->trace)) {
+	if (trace_is_off(&top->trace, &record->trace) && !stop_tracing) {
 		printf("rtla timerlat hit stop tracing\n");
 
 		if (!params->no_aa)
-- 
2.45.2



