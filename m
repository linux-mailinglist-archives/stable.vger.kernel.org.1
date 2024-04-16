Return-Path: <stable+bounces-39976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4F58A6093
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 03:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8502821DE
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 01:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D138F5A;
	Tue, 16 Apr 2024 01:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vi2103S8"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703A73FD4
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713232486; cv=none; b=jO6lrYVq4HpgyVR5rlLLw6aHNU8gAScQBbXIcQpJVFPwXaeiZgq3lXL2i9JGx3ZD7WLDuasKkMM5MhJNMG+oCF+zv9uQjfRwx1U88Zy/Fpt5n/9tH9z3gOgcxw7hRKlts4Ob0IY7NZI1uIDiDL+jAHrt++rUvj/RZoo67v6agI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713232486; c=relaxed/simple;
	bh=lsLCBFrVN80SAY3gmxE4uIB3hFAU7d9hvKI+lzQ/pLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o8kMBuzQpD3CFPWM7zuaEYT4s0MQZbPlMU3xb1f/JuHafdTJTYWMDzBnRvxMNl9yUOqxQ94I1b5LR+j/EU6ziHaxJEFWdLqN0ZRplUO5RUp+wWfFSt63FC8CYmXFybYR00Cajqrl0POYQjQih2UapiBRU4zTfN+JL8FBspVO+i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vi2103S8; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713232482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUPbQrJhA5p5ATS70Y1LQQnInKd8si1rbBIrnHRq0/s=;
	b=vi2103S8CX0hnJetU+d08OfkEQ4g3tr2ngoh4oJsguxUWTnQlOJgs2XA4A9ujb1g2cRr2s
	RCADtXL4+thOmnoKbedQypyfgsJEhckH2HdTwTRM0QwvMqCdKbtxTnJLyPPXjB3J8HCVtj
	dBSklXq75ywPmeQz/80kFhWl2gZtTaI=
From: George Guo <dongtai.guo@linux.dev>
To: gregkh@linuxfoundation.org,
	tom.zanussi@linux.intel.com
Cc: stable@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 4.19.y v5 1/2] tracing: Remove hist trigger synth_var_refs
Date: Tue, 16 Apr 2024 09:54:31 +0800
Message-Id: <20240416015432.2282705-2-dongtai.guo@linux.dev>
In-Reply-To: <20240416015432.2282705-1-dongtai.guo@linux.dev>
References: <20240416015432.2282705-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tom Zanussi <tom.zanussi@linux.intel.com>

All var_refs are now handled uniformly and there's no reason to treat
the synth_refs in a special way now, so remove them and associated
functions.

Link: http://lkml.kernel.org/r/b4d3470526b8f0426dcec125399dad9ad9b8589d.1545161087.git.tom.zanussi@linux.intel.com

Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
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


