Return-Path: <stable+bounces-128035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E8BA7AE94
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B01179A9F
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CEC2080F9;
	Thu,  3 Apr 2025 19:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOijUDnB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BA22080F1;
	Thu,  3 Apr 2025 19:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707811; cv=none; b=iAHO5aWmgw6NDLmOaBKPqjSxsC5kICMqlWR4N0cPxwym3ITEcx1OXehXpvdtyYudS7Gmebm2ae7SuQrDUNRa3tubuTr9uhnCfqlz5PuuwbR4XP8JC+k4M7tPxuvZmTxGj8TqutFNPiYgt8UnC1UYyng5k29ZtBqIciVuXaXYiOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707811; c=relaxed/simple;
	bh=4Z0q3Xs/H9AZcmWQTqJHE7x55UJuKGQjIQM0FFvzNiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WqXcSgojr0XIstgeHmW6ylxNoU287CLpcbRgYh06tch5SiaJR9x/w/WEIpEmCYuZr0hrwwBNjAyQdKpO0hESfoFJNaguchd643TJ/e7i8J/l0+oj6Eqiq8U2uewPB+kG+2gWQuyJEAF5Euey8i3Ma+mn7dZUoX2tFH9VUAKCW7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOijUDnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F83C4CEE3;
	Thu,  3 Apr 2025 19:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707810;
	bh=4Z0q3Xs/H9AZcmWQTqJHE7x55UJuKGQjIQM0FFvzNiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VOijUDnBQCX8CT3Cv831Wx783jMn1h6P3bVkpisCGeWx2S+0lxEyRe5F4qPt5W6L6
	 E5DssNj8qXMiGunhyCMJZ3qLjKOCortEjgooq9CMn8QOOt2VJ7S1kxqXZeu/cNlii/
	 kf6caJeabIaga0CvOcvYzdheBhiWReh74wV+Sc9IUlBHxKuv+AAu1FT+58RsXjHAch
	 wb0mFxBRUEj023PYlDRwYnoRLCe0/SO8awfGiOqDrSlkcY4rxK/T8LKv64Sd8heTM8
	 yfVLn4dCF62bNKfacGqodJK2BJK8yuIIzCr1VoehP1JFGznf/IPGtmNaWv5/5vlbNs
	 ZvBgp2DpQdE4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 34/37] tracing: probe-events: Add comments about entry data storing code
Date: Thu,  3 Apr 2025 15:15:10 -0400
Message-Id: <20250403191513.2680235-34-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191513.2680235-1-sashal@kernel.org>
References: <20250403191513.2680235-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit bb9c6020f4c3a07a90dc36826cb5fbe83f09efd5 ]

Add comments about entry data storing code to __store_entry_arg() and
traceprobe_get_entry_data_size(). These are a bit complicated because of
building the entry data storing code and scanning it.

This just add comments, no behavior change.

Link: https://lore.kernel.org/all/174061715004.501424.333819546601401102.stgit@devnote2/

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Closes: https://lore.kernel.org/all/20250226102223.586d7119@gandalf.local.home/
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 16a5e368e7b77..578919962e5df 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -770,6 +770,10 @@ static int check_prepare_btf_string_fetch(char *typename,
 
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 
+/*
+ * Add the entry code to store the 'argnum'th parameter and return the offset
+ * in the entry data buffer where the data will be stored.
+ */
 static int __store_entry_arg(struct trace_probe *tp, int argnum)
 {
 	struct probe_entry_arg *earg = tp->entry_arg;
@@ -793,6 +797,20 @@ static int __store_entry_arg(struct trace_probe *tp, int argnum)
 		tp->entry_arg = earg;
 	}
 
+	/*
+	 * The entry code array is repeating the pair of
+	 * [FETCH_OP_ARG(argnum)][FETCH_OP_ST_EDATA(offset of entry data buffer)]
+	 * and the rest of entries are filled with [FETCH_OP_END].
+	 *
+	 * To reduce the redundant function parameter fetching, we scan the entry
+	 * code array to find the FETCH_OP_ARG which already fetches the 'argnum'
+	 * parameter. If it doesn't match, update 'offset' to find the last
+	 * offset.
+	 * If we find the FETCH_OP_END without matching FETCH_OP_ARG entry, we
+	 * will save the entry with FETCH_OP_ARG and FETCH_OP_ST_EDATA, and
+	 * return data offset so that caller can find the data offset in the entry
+	 * data buffer.
+	 */
 	offset = 0;
 	for (i = 0; i < earg->size - 1; i++) {
 		switch (earg->code[i].op) {
@@ -826,6 +844,16 @@ int traceprobe_get_entry_data_size(struct trace_probe *tp)
 	if (!earg)
 		return 0;
 
+	/*
+	 * earg->code[] array has an operation sequence which is run in
+	 * the entry handler.
+	 * The sequence stopped by FETCH_OP_END and each data stored in
+	 * the entry data buffer by FETCH_OP_ST_EDATA. The FETCH_OP_ST_EDATA
+	 * stores the data at the data buffer + its offset, and all data are
+	 * "unsigned long" size. The offset must be increased when a data is
+	 * stored. Thus we need to find the last FETCH_OP_ST_EDATA in the
+	 * code array.
+	 */
 	for (i = 0; i < earg->size; i++) {
 		switch (earg->code[i].op) {
 		case FETCH_OP_END:
-- 
2.39.5


