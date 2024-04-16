Return-Path: <stable+bounces-39977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9611E8A6094
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 03:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419BF1F219F0
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 01:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E215AA92E;
	Tue, 16 Apr 2024 01:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g3oIvHJH"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38531139E
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 01:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713232488; cv=none; b=XxdhTy9D/aPE+Y9S89nE3VFXhOO2TaUt62GQtp1Qt9tHoE4E3+WAPw/XCBvCRz3W9E+P0k8fJMTqnUfUYd2yXY78s5QEIs1pRX+vi0jzISMMfRVmoj4eRiqRbiAvQhOK4zD2wZT/170i66MTBJ4afDT1LVBxdrYmU9mcylK51xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713232488; c=relaxed/simple;
	bh=UmXdxqwH4sj9RmKAcekLh/yjceU7ZYfzDTHryeGdseI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qrZLv1Vwp25LOX6tiUojAYUVa4SbTOh9nNULDqEdtszta1nc84rMzRAUisoXdimY2et5ew2DxI2BfFNmcL62NbRyvO3+hf3zT1Q2/rx1H3sOeTBxAre+fOkVWLP+7/VmhY7mLSGUm7U5Kdhnb8LCcaZxvDP0lvdEjobY4BsHGPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g3oIvHJH; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713232484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ce9z3rTgtAmb+z21uy40IYtJhZfm3O/70hN4lTpTqdQ=;
	b=g3oIvHJHfFtnw79mWSH6eFvzLLCevA9Zso7G+6ifB8JCpY0YLq32UtQNt0CSe/HMAUACAU
	52GjKQ7OD9USFzF7f6YHRloaTgkevFWj8DDBaluw9o6s57k8W1IvlCjH6aqdM//wj0OuD+
	TfvXMRNWTazq74aokrlhTAez01BpjDY=
From: George Guo <dongtai.guo@linux.dev>
To: gregkh@linuxfoundation.org,
	tom.zanussi@linux.intel.com
Cc: stable@vger.kernel.org,
	Tom Zanussi <tzanussi@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 4.19.y v5 2/2] tracing: Use var_refs[] for hist trigger reference checking
Date: Tue, 16 Apr 2024 09:54:32 +0800
Message-Id: <20240416015432.2282705-3-dongtai.guo@linux.dev>
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

From: Tom Zanussi <tzanussi@gmail.com>

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


