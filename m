Return-Path: <stable+bounces-224491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O7uK80DsGkWegIAu9opvQ
	(envelope-from <stable+bounces-224491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:43:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 455C824B68E
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8014330B969C
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C8841B35D;
	Tue, 10 Mar 2026 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQ4lm5rJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B84B13AA2D;
	Tue, 10 Mar 2026 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142222; cv=none; b=HAcyCuezXPy6hBhIc2lUkSTvm/JjxonKrxGOIHDuF3AzzEPOe3lytZm0yDAsnteiUfhgjZTeeUj1iN1JpCFCOeSSNkJO69qXIJyuoos11KAWEK8uoh8sAjEqEj3PXexeYuqoJBhgkuIri3lfxdrfnMKY/fPfKBIdT02hbEvJ5Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142222; c=relaxed/simple;
	bh=qNEZnMyVE/GrXvfITWwGbWEQiCKfyfW7Oh+ggVr3nw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpau9WwUOlZWJ5T98fAY0MW59XawVJ8ZpUrWVHJZseTstVUA7VrZ7o/VUWbaOCFOYckhUNqYu9fIycx7Pq1kwwcMMaoKaXypxpZHH3ipgb4DLl5are6PYxW0Di7TGXYCs1dq5RRnny10VEnzMgWJ8jbyoGtlRrkz44GlpyHFpBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQ4lm5rJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A069C2BC9E;
	Tue, 10 Mar 2026 11:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142222;
	bh=qNEZnMyVE/GrXvfITWwGbWEQiCKfyfW7Oh+ggVr3nw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eQ4lm5rJwjcKnZ+KMVqTk/tzySCSoljk0irfPRtvAZLbIJTKBNLFTumZgoPXXYJ4f
	 jprQ8pYgxlUdAYsXhIMB8yJPBnhf8VuFO2sFAk58AOOClzNlw5YcXfiYVyIMpyhG1p
	 wFJ3yytA2aftfUEvzOsArk0oUNk3TVr7KMVMVdr6uAj07LJNaPwrhKtSj6JQF28iMT
	 +J1R7opZmEu/gRffgaka+cgCYLeDq/+omesnIT8YgraVZI/zroGGd3cYwXUojlivLD
	 E7thYmrwEfrb/DL4i7NjUTAHhywbCxwUgwdMiIyuBrl/Tl1UCiVSvfSBo33pMRXwCc
	 EM935FnYOCNfA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Miaoqian Lin <linmq006@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 312/314] tracing: Add NULL pointer check to trigger_data_free()
Date: Tue, 10 Mar 2026 07:19:31 -0400
Message-ID: <409e410e527d6d599cfef241d0b4d0e9e98a1c57.1773141556.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 455C824B68E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[roeck-us.net,gmail.com,kernel.org,efficios.com,goodmis.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224491-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,goodmis.org:email,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,efficios.com:email]
X-Rspamd-Action: no action

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 457965c13f0837a289c9164b842d0860133f6274 ]

If trigger_data_alloc() fails and returns NULL, event_hist_trigger_parse()
jumps to the out_free error path. While kfree() safely handles a NULL
pointer, trigger_data_free() does not. This causes a NULL pointer
dereference in trigger_data_free() when evaluating
data->cmd_ops->set_filter.

Fix the problem by adding a NULL pointer check to trigger_data_free().

The problem was found by an experimental code review agent based on
gemini-3.1-pro while reviewing backports into v6.18.y.

Cc: Miaoqian Lin <linmq006@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://patch.msgid.link/20260305193339.2810953-1-linux@roeck-us.net
Fixes: 0550069cc25f ("tracing: Properly process error handling in event_hist_trigger_parse()")
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_trigger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index cbfc306c0159a..98b8d5df15c79 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -19,6 +19,9 @@ static DEFINE_MUTEX(trigger_cmd_mutex);
 
 void trigger_data_free(struct event_trigger_data *data)
 {
+	if (!data)
+		return;
+
 	if (data->cmd_ops->set_filter)
 		data->cmd_ops->set_filter(NULL, data, NULL);
 
-- 
2.51.0


