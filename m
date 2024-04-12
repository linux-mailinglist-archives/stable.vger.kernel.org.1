Return-Path: <stable+bounces-39290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE638A2B3B
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 11:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB6EB213D0
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 09:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B6250A66;
	Fri, 12 Apr 2024 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f+tLoKdZ"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6711524BE
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914257; cv=none; b=RH1doJFvGE+pGUWAv4d3b0NE24KwBm3nHkRd7EZLqVEpNDRJNLIRuSYFxpOXQDSrU7dFOWChBPOj56WYCX/Gfm0r5bFdqVjr0SBmVbnDw4jZxqs6wvqimp8435kN+KpL9pjbjRK1hlf6CmkRvRlLTypaC92rmZbalW7pLKSsL8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914257; c=relaxed/simple;
	bh=kYHjLRLA07uCu/RkaF3WEbRCmkmg7/Q6hGDJelijhCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dNBmeW7ZUMLWBPNugOWHUlIVKyx4S3wJxhFTQFL4xJVWCYQcC+syDopMCObSnAJ5bJcG8jV9XI9UbfjkWpBAXnFKgSxBva6gpMkSGsLNk8bWqBAtrUK1x3b7sUeOFjyN8YOi71vM7KsiMWjoEQsPL5UhdqAMvakVs/EDmYSShL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f+tLoKdZ; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712914252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EArgIRu50OxrYQdlWlD8JhU9A/aGCT/hBxuzB8YnZ6w=;
	b=f+tLoKdZhQFbmkPcuXk+4AR+Atf0KU4lWcCoLAkNcj9P2efF8s9+zJ9sR/kZskIacEwtSu
	tYxTDCCiLv1gw8cgHmSbrGLr0wj6iZKNme/tZ5bBVcf2KtmMIzZGgQN0onZ4gmXAz/VJgD
	AgQ9NL0oBTjU/+IKNRxGsbF1Puhj/V0=
From: George Guo <dongtai.guo@linux.dev>
To: tom.zanussi@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 4.19.y v4 1/2] tracing: Remove hist trigger synth_var_refs
Date: Fri, 12 Apr 2024 17:30:40 +0800
Message-Id: <20240412093041.2334396-2-dongtai.guo@linux.dev>
In-Reply-To: <20240412093041.2334396-1-dongtai.guo@linux.dev>
References: <20240412093041.2334396-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tom Zanussi <tom.zanussi@linux.intel.com>

commit 912201345f7c39e6b0ac283207be2b6641fa47b9 upstream.

All var_refs are now handled uniformly and there's no reason to treat
the synth_refs in a special way now, so remove them and associated
functions.

Link: http://lkml.kernel.org/r/b4d3470526b8f0426dcec125399dad9ad9b8589d.1545161087.git.tom.zanussi@linux.intel.com

Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index e004daf8cad5..e4f5b6894cf2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -280,8 +280,6 @@ struct hist_trigger_data {
 	struct action_data		*actions[HIST_ACTIONS_MAX];
 	unsigned int			n_actions;
 
-	struct hist_field               *synth_var_refs[SYNTH_FIELDS_MAX];
-	unsigned int                    n_synth_var_refs;
 	struct field_var		*field_vars[SYNTH_FIELDS_MAX];
 	unsigned int			n_field_vars;
 	unsigned int			n_field_var_str;
@@ -3708,20 +3706,6 @@ static void save_field_var(struct hist_trigger_data *hist_data,
 }
 
 
-static void destroy_synth_var_refs(struct hist_trigger_data *hist_data)
-{
-	unsigned int i;
-
-	for (i = 0; i < hist_data->n_synth_var_refs; i++)
-		destroy_hist_field(hist_data->synth_var_refs[i], 0);
-}
-
-static void save_synth_var_ref(struct hist_trigger_data *hist_data,
-			 struct hist_field *var_ref)
-{
-	hist_data->synth_var_refs[hist_data->n_synth_var_refs++] = var_ref;
-}
-
 static int check_synth_field(struct synth_event *event,
 			     struct hist_field *hist_field,
 			     unsigned int field_pos)
@@ -3884,7 +3868,6 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 				goto err;
 			}
 
-			save_synth_var_ref(hist_data, var_ref);
 			field_pos++;
 			kfree(p);
 			continue;
@@ -4631,7 +4614,6 @@ static void destroy_hist_data(struct hist_trigger_data *hist_data)
 	destroy_actions(hist_data);
 	destroy_field_vars(hist_data);
 	destroy_field_var_hists(hist_data);
-	destroy_synth_var_refs(hist_data);
 
 	kfree(hist_data);
 }
-- 
2.34.1


