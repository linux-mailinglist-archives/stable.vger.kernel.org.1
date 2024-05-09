Return-Path: <stable+bounces-43484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE8A8C09CB
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 04:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4890728372E
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 02:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5911BA50;
	Thu,  9 May 2024 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M1WBYTOj"
X-Original-To: stable@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BFC7FBC1
	for <stable@vger.kernel.org>; Thu,  9 May 2024 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221826; cv=none; b=aCXnXWSUDESosRKSw+sPhxoXwhaSekrgRWDYxhk5wHur1owuVR9w1sRyEVzxO5gIugZWNB4JTCegq0QYefHE0EZ7DvsdgdyDO8DhBYWeYeL4glKzU4OoKhQ42omWZC3OWzsaLvHgWBL+tU3VmL3dtn/psbDGvHLrZvB7XSNSMIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221826; c=relaxed/simple;
	bh=DxL2njOvOlc826jZDyZXagIcQqGRCSurHQ9CsFRdCwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DjqlPqOxEHflJiWmQD8p5KlwVeuB9tJWFkbgHdkRxskEM4dxWIrS902d7mIrisJWraac+QdsBCdjBw9FqrBWq417fnEmlk5Kn3epbDVPGo72Tja6yfXiPcdDzjpbvmNv3IC8DU3zlLrRGW+DyMqsS7JQjOD0qo9d6CreVLlVQHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M1WBYTOj; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715221823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pqu4RF8vvyMyKw/ZAvbG+SK8gEco48VOR/lnKCC+FPM=;
	b=M1WBYTOjTupimp+yC4uVX2GEtId2M6frVeoJFYo42fuwnlAIMBFjtOTv+pfYSTjxkqinJj
	NSEhtkr+7nzJD3bVDzHxK1ZcwHdT+yUiw1MDpovqm5KAC7FhuTPB1Zg7u18sc4U1vNnZmW
	AZV8oGZE+S7tNQzO9nDacbPw2WCpYDw=
From: George Guo <dongtai.guo@linux.dev>
To: gregkh@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	tom.zanussi@linux.intel.com
Cc: stable@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 4.19.y 07/13] tracing: Use str_has_prefix() helper for histogram code
Date: Thu,  9 May 2024 10:29:25 +0800
Message-Id: <20240509022931.3513365-8-dongtai.guo@linux.dev>
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

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

commit 754481e6954cbef53f8bc4412ad48dde611e21d3 upstream.

The tracing histogram code contains a lot of instances of the construct:

 strncmp(str, "const", sizeof("const") - 1)

This can be prone to bugs due to typos or bad cut and paste. Use the
str_has_prefix() helper macro instead that removes the need for having two
copies of the constant string.

Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 kernel/trace/trace_events_hist.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1139075a6395..1441c3934cbf 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1878,8 +1878,8 @@ static int parse_action(char *str, struct hist_trigger_attrs *attrs)
 	if (attrs->n_actions >= HIST_ACTIONS_MAX)
 		return ret;
 
-	if ((strncmp(str, "onmatch(", strlen("onmatch(")) == 0) ||
-	    (strncmp(str, "onmax(", strlen("onmax(")) == 0)) {
+	if ((str_has_prefix(str, "onmatch(")) ||
+	    (str_has_prefix(str, "onmax("))) {
 		attrs->action_str[attrs->n_actions] = kstrdup(str, GFP_KERNEL);
 		if (!attrs->action_str[attrs->n_actions]) {
 			ret = -ENOMEM;
@@ -1896,34 +1896,34 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 {
 	int ret = 0;
 
-	if ((strncmp(str, "key=", strlen("key=")) == 0) ||
-	    (strncmp(str, "keys=", strlen("keys=")) == 0)) {
+	if ((str_has_prefix(str, "key=")) ||
+	    (str_has_prefix(str, "keys="))) {
 		attrs->keys_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->keys_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if ((strncmp(str, "val=", strlen("val=")) == 0) ||
-		 (strncmp(str, "vals=", strlen("vals=")) == 0) ||
-		 (strncmp(str, "values=", strlen("values=")) == 0)) {
+	} else if ((str_has_prefix(str, "val=")) ||
+		   (str_has_prefix(str, "vals=")) ||
+		   (str_has_prefix(str, "values="))) {
 		attrs->vals_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->vals_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "sort=", strlen("sort=")) == 0) {
+	} else if (str_has_prefix(str, "sort=")) {
 		attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->sort_key_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "name=", strlen("name=")) == 0) {
+	} else if (str_has_prefix(str, "name=")) {
 		attrs->name = kstrdup(str, GFP_KERNEL);
 		if (!attrs->name) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "clock=", strlen("clock=")) == 0) {
+	} else if (str_has_prefix(str, "clock=")) {
 		strsep(&str, "=");
 		if (!str) {
 			ret = -EINVAL;
@@ -1936,7 +1936,7 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "size=", strlen("size=")) == 0) {
+	} else if (str_has_prefix(str, "size=")) {
 		int map_bits = parse_map_size(str);
 
 		if (map_bits < 0) {
@@ -3623,7 +3623,7 @@ static struct action_data *onmax_parse(char *str)
 	if (!onmax_fn_name || !str)
 		goto free;
 
-	if (strncmp(onmax_fn_name, "save", strlen("save")) == 0) {
+	if (str_has_prefix(onmax_fn_name, "save")) {
 		char *params = strsep(&str, ")");
 
 		if (!params) {
@@ -4414,8 +4414,8 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 	for (i = 0; i < hist_data->attrs->n_actions; i++) {
 		str = hist_data->attrs->action_str[i];
 
-		if (strncmp(str, "onmatch(", strlen("onmatch(")) == 0) {
-			char *action_str = str + strlen("onmatch(");
+		if (str_has_prefix(str, "onmatch(")) {
+			char *action_str = str + sizeof("onmatch(") - 1;
 
 			data = onmatch_parse(tr, action_str);
 			if (IS_ERR(data)) {
@@ -4423,8 +4423,8 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 				break;
 			}
 			data->fn = action_trace;
-		} else if (strncmp(str, "onmax(", strlen("onmax(")) == 0) {
-			char *action_str = str + strlen("onmax(");
+		} else if (str_has_prefix(str, "onmax(")) {
+			char *action_str = str + sizeof("onmax(") - 1;
 
 			data = onmax_parse(action_str);
 			if (IS_ERR(data)) {
-- 
2.34.1


