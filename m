Return-Path: <stable+bounces-43486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9818C09CE
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 04:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4051C21820
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 02:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFDD83A17;
	Thu,  9 May 2024 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zj2I7aHs"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B6613C835
	for <stable@vger.kernel.org>; Thu,  9 May 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221832; cv=none; b=fjM83USgTgin7qYqKtkycaEtDQTnAhOBGMdgi8P2OKMqzW/LD7Zo8Dwqcwh5lQiseAoYYCUeUr8f6A1V+mtJHRcbi83BluaYlU2m72ZIhW6urDUC5A+UULVrYZOQW0T/dUaV8w+VWg0Gn/ibOQbMqZer5B/dNooPyvNaAcntjkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221832; c=relaxed/simple;
	bh=2ZIKj8dvG51sz58qkMc4U9OBc8tpqDAi9diPCaGAO8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zu6BvzcRIbwWjrVhiwLRa2+vGtawrxM/74Ouwzu31VdjXWxUIK5Xe5ivQOC8V5MKYkFWLRdCVFWpHFooONss/nhSdndhQjsysr2fN7fuStPvTWDBgQXugXoqVv+CltbiU8LIF3eiRkEEis89TXuT9KeQPEbObY3ZrNkR+uX3hew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zj2I7aHs; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715221828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItGtoBo5wFLtI73ZT9s9uIzPdFCP5a0BFsFHiGhg5eE=;
	b=Zj2I7aHsLG9+uzHbF/IBp6qs5SBrRpuaDIxuJCDDiMO02S0RQbs7EMh5CrYoIoXc8u6ebO
	O8MnraCj4gNo4M/tLRNBGkBkQCVM5t1Nf6buEQ4VlT3cYg5TzNXGuqOVEHmW6iKZNz7SzC
	X3rPSYTBMF9uP0M/vth7L6cXTOZ5qCY=
From: George Guo <dongtai.guo@linux.dev>
To: gregkh@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	tom.zanussi@linux.intel.com
Cc: stable@vger.kernel.org,
	Tom Zanussi <zanussi@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 4.19.y 09/13] tracing: Have the historgram use the result of str_has_prefix() for len of prefix
Date: Thu,  9 May 2024 10:29:27 +0800
Message-Id: <20240509022931.3513365-10-dongtai.guo@linux.dev>
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

commit 036876fa56204ae0fa59045bd6bbb2691a060633 upstream.

As str_has_prefix() returns the length on match, we can use that for the
updating of the string pointer instead of recalculating the prefix size.

Cc: Tom Zanussi  <zanussi@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 kernel/trace/trace_events_hist.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 95f5e328a98b..460b07d51dd6 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4410,12 +4410,13 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 	unsigned int i;
 	int ret = 0;
 	char *str;
+	int len;
 
 	for (i = 0; i < hist_data->attrs->n_actions; i++) {
 		str = hist_data->attrs->action_str[i];
 
-		if (str_has_prefix(str, "onmatch(")) {
-			char *action_str = str + sizeof("onmatch(") - 1;
+		if ((len = str_has_prefix(str, "onmatch("))) {
+			char *action_str = str + len;
 
 			data = onmatch_parse(tr, action_str);
 			if (IS_ERR(data)) {
@@ -4423,8 +4424,8 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 				break;
 			}
 			data->fn = action_trace;
-		} else if (str_has_prefix(str, "onmax(")) {
-			char *action_str = str + sizeof("onmax(") - 1;
+		} else if ((len = str_has_prefix(str, "onmax("))) {
+			char *action_str = str + len;
 
 			data = onmax_parse(action_str);
 			if (IS_ERR(data)) {
-- 
2.34.1


