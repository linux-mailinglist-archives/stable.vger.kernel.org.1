Return-Path: <stable+bounces-43478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25AA8C09C5
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 04:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E3E1F22D8D
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 02:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9414513CAB3;
	Thu,  9 May 2024 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MpEUXNc9"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE0613CAB7
	for <stable@vger.kernel.org>; Thu,  9 May 2024 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221808; cv=none; b=KcdZ5tBS317rYOhDnj5w2rs6yV4PGQuxl/r1NKgURTCVfFElEIPtH1c47rbF7VFPdLBnzGmbNdaCZwAU78ZbOd75++VaiRZVVoCG3nIylBvckPxwlSJQ1csaqoAAUgJTU0w8bupT2DlUFQAL/t3OO/HuXe8Gky3xzrrwWhrYUfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221808; c=relaxed/simple;
	bh=hMPn0McpZRtYsykI6eYHJ+rpqDJVcJNaY4EpzQKdfPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HRx24oM/jbRtKAdhBXmDsrP6dTg9JIkDAIM4sXQnaccDsMIYT7Gvlf8k2axIyQ9dbdnomukTKG7RQ+vV1+SksssCz8iuzWg7r4MbJnur7NyZTShsJaBh319NpTILAEGorjRi1PIEsrJEnQwB0ktNfyWgcLJ0zjHABuC05XrvzMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MpEUXNc9; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715221804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y7MxZaCmstrZeYPGTaKwrDFTLD0ln93uH1C4ijFZfpg=;
	b=MpEUXNc9b7XrjjMqbEtDao0zi1hTnxuQAP4uz6EkFPBbyGL0CDPpKLKpQpbYq7kKaJaTOS
	0j9BBcNyFH0XpsrlKHQcIOAI+h6euOYYWurpPCXW3Tgvoj8iwTrQz2oO3L5jimrMR4S/Z7
	WwEqeolTvZoL09AKeWjXmurycMs98m0=
From: George Guo <dongtai.guo@linux.dev>
To: gregkh@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	tom.zanussi@linux.intel.com
Cc: stable@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 4.19.y 01/13] tracing: Simplify creation and deletion of synthetic events
Date: Thu,  9 May 2024 10:29:19 +0800
Message-Id: <20240509022931.3513365-2-dongtai.guo@linux.dev>
In-Reply-To: <20240509022931.3513365-1-dongtai.guo@linux.dev>
References: <20240509022931.3513365-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Masami Hiramatsu <mhiramat@kernel.org>

commit faacb361f271be4baf2d807e2eeaba87e059225f upstream.

Since the event_mutex and synth_event_mutex ordering issue
is gone, we can skip existing event check when adding or
deleting events, and some redundant code in error path.

This changes release_all_synth_events() to abort the process
when it hits any error and returns the error code. It succeeds
only if it has no error.

Link: http://lkml.kernel.org/r/154140847194.17322.17960275728005067803.stgit@devbox

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 kernel/trace/trace_events_hist.c | 53 +++++++++++---------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ede370225245..efba381dbc60 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1028,18 +1028,6 @@ struct hist_var_data {
 	struct hist_trigger_data *hist_data;
 };
 
-static void add_or_delete_synth_event(struct synth_event *event, int delete)
-{
-	if (delete)
-		free_synth_event(event);
-	else {
-		if (!find_synth_event(event->name))
-			list_add(&event->list, &synth_event_list);
-		else
-			free_synth_event(event);
-	}
-}
-
 static int create_synth_event(int argc, char **argv)
 {
 	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
@@ -1072,15 +1060,16 @@ static int create_synth_event(int argc, char **argv)
 	if (event) {
 		if (delete_event) {
 			if (event->ref) {
-				event = NULL;
 				ret = -EBUSY;
 				goto out;
 			}
-			list_del(&event->list);
-			goto out;
-		}
-		event = NULL;
-		ret = -EEXIST;
+			ret = unregister_synth_event(event);
+			if (!ret) {
+				list_del(&event->list);
+				free_synth_event(event);
+			}
+		} else
+			ret = -EEXIST;
 		goto out;
 	} else if (delete_event) {
 		ret = -ENOENT;
@@ -1120,29 +1109,21 @@ static int create_synth_event(int argc, char **argv)
 		event = NULL;
 		goto err;
 	}
+	ret = register_synth_event(event);
+	if (!ret)
+		list_add(&event->list, &synth_event_list);
+	else
+		free_synth_event(event);
  out:
-	if (event) {
-		if (delete_event) {
-			ret = unregister_synth_event(event);
-			add_or_delete_synth_event(event, !ret);
-		} else {
-			ret = register_synth_event(event);
-			add_or_delete_synth_event(event, ret);
-		}
-	}
 	mutex_unlock(&synth_event_mutex);
 	mutex_unlock(&event_mutex);
 
 	return ret;
  err:
-	mutex_unlock(&synth_event_mutex);
-	mutex_unlock(&event_mutex);
-
 	for (i = 0; i < n_fields; i++)
 		free_synth_field(fields[i]);
-	free_synth_event(event);
 
-	return ret;
+	goto out;
 }
 
 static int release_all_synth_events(void)
@@ -1161,10 +1142,12 @@ static int release_all_synth_events(void)
 	}
 
 	list_for_each_entry_safe(event, e, &synth_event_list, list) {
-		list_del(&event->list);
-
 		ret = unregister_synth_event(event);
-		add_or_delete_synth_event(event, !ret);
+		if (!ret) {
+			list_del(&event->list);
+			free_synth_event(event);
+		} else
+			break;
 	}
 	mutex_unlock(&synth_event_mutex);
 	mutex_unlock(&event_mutex);
-- 
2.34.1


