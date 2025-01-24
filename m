Return-Path: <stable+bounces-110392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3B2A1BC57
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 19:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D55AE7A50AF
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 18:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F622248B6;
	Fri, 24 Jan 2025 18:48:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C13E1D968E;
	Fri, 24 Jan 2025 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744526; cv=none; b=R1g7LsHmaELewikTbB2gqKwuvbPC7Y87mNt+rOYlgp/FAtHQnDGOzeHIQ9bf0lw9awfSVj8675Kw6TGkqdiaQUfScYL752C+4vGXhaT6BuExerDc/6NVIK2koUz4CPv8YOl4ZAs4tQI1aOOkthSXPnfdJ4giKiwdkrSEprkhQkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744526; c=relaxed/simple;
	bh=9iy+had2RVBUhstp0nrx+8UpsLg46IAk3oc/HvAHvBc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VyAOm0pkhlUCYxCjFcSBTBENcMBRV47SfyKlyPI1V1iRV8q52wheLLNG6qMm0R1dz9Cx3F2kMkp0t+JKPx2q7qI9369X5wuUNKYcZVBTJ+bGTtzGJoveJ7VqDxYUikhLzMrwHX4E5ALtLMowobFVMCg+Br+wxi02gOTtie0XieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B737C4CEE0;
	Fri, 24 Jan 2025 18:48:45 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tbOjg-00000001F9g-2u5N;
	Fri, 24 Jan 2025 13:48:56 -0500
Message-ID: <20250124184856.544449472@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 24 Jan 2025 13:48:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 stable@vger.kernel.org,
 Luis Goncalves <lgoncalv@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 02/14] rtla: Add trace_instance_stop
References: <20250124184835.052017152@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Support not only turning trace on for the timerlat tracer, but also
turning it off.

This will be used in subsequent patches to stop the timerlat tracer
without also wiping the trace buffer.

Cc: stable@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/20250116144931.649593-2-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/trace.c | 8 ++++++++
 tools/tracing/rtla/src/trace.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 170a706248ab..440323a997c6 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -196,6 +196,14 @@ int trace_instance_start(struct trace_instance *trace)
 	return tracefs_trace_on(trace->inst);
 }
 
+/*
+ * trace_instance_stop - stop tracing a given rtla instance
+ */
+int trace_instance_stop(struct trace_instance *trace)
+{
+	return tracefs_trace_off(trace->inst);
+}
+
 /*
  * trace_events_free - free a list of trace events
  */
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index c7c92dc9a18a..76e1b77291ba 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -21,6 +21,7 @@ struct trace_instance {
 
 int trace_instance_init(struct trace_instance *trace, char *tool_name);
 int trace_instance_start(struct trace_instance *trace);
+int trace_instance_stop(struct trace_instance *trace);
 void trace_instance_destroy(struct trace_instance *trace);
 
 struct trace_seq *get_trace_seq(void);
-- 
2.45.2



