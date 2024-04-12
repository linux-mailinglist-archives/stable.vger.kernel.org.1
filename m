Return-Path: <stable+bounces-39291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 925708A2B3A
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 11:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F1E1C230FB
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 09:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6170050A72;
	Fri, 12 Apr 2024 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WylpA7MC"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F11C502B2
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914258; cv=none; b=BlNJgEp915GTcHJXh0hiv95SbhlowUKONaiA1xn5ObeQ60ntz5TkkWaUWKnj4joGsXn9xs9sKd9q4h9DwoC242UwACRpEwijI3ZyjFXeJheOmOb1KiMnIJbNLyBf/hBfi/fGBy5BiAWBCak0Cig1OcxVR4wmVLDg4OS2TJtz9mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914258; c=relaxed/simple;
	bh=fgr5a8Qvt3ToodYbB5IDoBJIjJ1XvfDEaMfu7AgybV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cwvQK6m56kyKmlQniWh+w6DB2lzWC3CxX7N+NXrk5uODbM6RUNZ7RDQT5M0IkZriCsX/BWppOFCbs4chVN4OQ/wiRs/GKJiICZBy35+mCIv1dtyUd7fx9neaw1qgpviY0pbDX7r8AaDzDNBmK6RL9VCFN0Qcw3tsEfMh0i5BvAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WylpA7MC; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712914254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1wxmUekgN1ttNDn52OOXXc736kddn73oanBp2RvYtM=;
	b=WylpA7MCuClNB6ULdgpcwe/K1O/oFrnrGYOr5HZ0L54LTpcH3n7bVzhaRBfhKkYXiw0fDO
	ZzJ/nEjLK8umo4BqqY3VsrvFlXrY2YfRTW4A+uqQ7xDLU76LUbX4ls6I2ZFXezoxYJN/+s
	S6CCE6Z6eqP6nrFpaqbBZkDB5IUwX9w=
From: George Guo <dongtai.guo@linux.dev>
To: tom.zanussi@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	Tom Zanussi <tzanussi@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 4.19.y v4 2/2] tracing: Use var_refs[] for hist trigger reference checking
Date: Fri, 12 Apr 2024 17:30:41 +0800
Message-Id: <20240412093041.2334396-3-dongtai.guo@linux.dev>
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

From: Tom Zanussi <tzanussi@gmail.com>

commit e4f6d245031e04bdd12db390298acec0474a1a46 upstream.

Since all the variable reference hist_fields are collected into
hist_data->var_refs[] array, there's no need to go through all the
fields looking for them, or in separate arrays like synth_var_refs[],
which will be going away soon anyway.

This also allows us to get rid of some unnecessary code and functions
currently used for the same purpose.

Link: http://lkml.kernel.org/r/1545246556.4239.7.camel@gmail.com

Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 68 ++++++--------------------------
 1 file changed, 11 insertions(+), 57 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index e4f5b6894cf2..ede370225245 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1289,49 +1289,13 @@ check_field_for_var_ref(struct hist_field *hist_field,
 			struct hist_trigger_data *var_data,
 			unsigned int var_idx)
 {
-	struct hist_field *found = NULL;
-
-	if (hist_field && hist_field->flags & HIST_FIELD_FL_VAR_REF) {
-		if (hist_field->var.idx == var_idx &&
-		    hist_field->var.hist_data == var_data) {
-			found = hist_field;
-		}
-	}
-
-	return found;
-}
-
-static struct hist_field *
-check_field_for_var_refs(struct hist_trigger_data *hist_data,
-			 struct hist_field *hist_field,
-			 struct hist_trigger_data *var_data,
-			 unsigned int var_idx,
-			 unsigned int level)
-{
-	struct hist_field *found = NULL;
-	unsigned int i;
-
-	if (level > 3)
-		return found;
-
-	if (!hist_field)
-		return found;
-
-	found = check_field_for_var_ref(hist_field, var_data, var_idx);
-	if (found)
-		return found;
-
-	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++) {
-		struct hist_field *operand;
+	WARN_ON(!(hist_field && hist_field->flags & HIST_FIELD_FL_VAR_REF));
 
-		operand = hist_field->operands[i];
-		found = check_field_for_var_refs(hist_data, operand, var_data,
-						 var_idx, level + 1);
-		if (found)
-			return found;
-	}
+	if (hist_field && hist_field->var.idx == var_idx &&
+	    hist_field->var.hist_data == var_data)
+		return hist_field;
 
-	return found;
+	return NULL;
 }
 
 /**
@@ -1350,26 +1314,16 @@ static struct hist_field *find_var_ref(struct hist_trigger_data *hist_data,
 				       struct hist_trigger_data *var_data,
 				       unsigned int var_idx)
 {
-	struct hist_field *hist_field, *found = NULL;
+	struct hist_field *hist_field;
 	unsigned int i;
 
-	for_each_hist_field(i, hist_data) {
-		hist_field = hist_data->fields[i];
-		found = check_field_for_var_refs(hist_data, hist_field,
-						 var_data, var_idx, 0);
-		if (found)
-			return found;
-	}
-
-	for (i = 0; i < hist_data->n_synth_var_refs; i++) {
-		hist_field = hist_data->synth_var_refs[i];
-		found = check_field_for_var_refs(hist_data, hist_field,
-						 var_data, var_idx, 0);
-		if (found)
-			return found;
+	for (i = 0; i < hist_data->n_var_refs; i++) {
+		hist_field = hist_data->var_refs[i];
+		if (check_field_for_var_ref(hist_field, var_data, var_idx))
+			return hist_field;
 	}
 
-	return found;
+	return NULL;
 }
 
 /**
-- 
2.34.1


