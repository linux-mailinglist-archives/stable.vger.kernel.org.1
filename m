Return-Path: <stable+bounces-40302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD968AB247
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 17:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4610C1F22463
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 15:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBFB130A6B;
	Fri, 19 Apr 2024 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="txOCZseU"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C126E12FF83
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541640; cv=none; b=UV8/qgA7K9d2Wsx9H25OTl2GRU8q41WHBwgNrnOedcsOYx+AKCx2Jh61EEXVTYWHEw4Cd+d3N/dm8wDHM8MjoXt43qBV8yWIz+J/10GJWOdphCFgWU2/zu+JS7kIr6tubOnacgy3+fZQmA+IEcUNAkZQR/uxSuOLGkAY0RbWMgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541640; c=relaxed/simple;
	bh=Ws19VyQ11dcLtRV9s/UD/OgrLqylGJoOHl2vm3x9rmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=upXtJWwDg9SShNEVYQUDwUtMe3WC87IGg3ZqHQJ0VoAbRzqehvn5WngWHmu9Dyr1fUsuPj+/DL8/H9055ek275wtOIkG8TNTYZq4XiOBdFr8oU9SneIpVyq3mfyByq3lfuY0pTzJTtYjx58X8L9S6IFQHmA687vDBKYcEgby6O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=txOCZseU; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713541635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=laGL9R48mvTRhDPdJySO/zz3EaWzTU1dG5JdOiSjNBA=;
	b=txOCZseUZU0tX2tcE3WCE79A2LhYiIEyGP+/d6fQWGe5+neONzFxYqc/b8gyqAqh6x2Ywo
	/5wVo6K4kJzDFUI2NDka3If1Ai/gCwM0LBT5vIgnbQV+kb8mVhRFW4Skh1AHndaLBR1XnQ
	A7VbI8pPg9OjyZXzFE4gxhrQDtze62U=
From: George Guo <dongtai.guo@linux.dev>
To: gregkh@linuxfoundation.org,
	tom.zanussi@linux.intel.com
Cc: stable@vger.kernel.org,
	Tom Zanussi <tzanussi@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 4.19.y v6 2/2] tracing: Use var_refs[] for hist trigger reference checking
Date: Fri, 19 Apr 2024 23:46:58 +0800
Message-Id: <20240419154658.4015260-3-dongtai.guo@linux.dev>
In-Reply-To: <20240419154658.4015260-1-dongtai.guo@linux.dev>
References: <20240419154658.4015260-1-dongtai.guo@linux.dev>
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
Signed-off-by: George Guo <guodongtai@kylinos.cn>
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


