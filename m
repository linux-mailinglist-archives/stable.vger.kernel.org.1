Return-Path: <stable+bounces-98340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6DA9E4047
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0818282C32
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9C520FAAB;
	Wed,  4 Dec 2024 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdJ8mgsC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F9520D511;
	Wed,  4 Dec 2024 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331484; cv=none; b=DIPf0B1iuMp7/hISZE23Dmnr9vAQo09yOlNdkaT9wo3xoYaT/lM1Lum3I4NtbIk0FHF0K55+/3uRSkLckIY4BWJ0RzUFw9LV1Pywz/7rTVYW7N54BW9tmlDpZvyay9dcTp16n0E4qjNRmUcJai1LZudwoWQ89xnCEfq8TWVBYsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331484; c=relaxed/simple;
	bh=WhX+ruXdfwM8nhqsAMiKlobOuSeFumxFogO5m7DEJDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EB9dFW/UHgMDydGgM8RZxKvjwdzqEM3NmPCk8ZqS/6gOhQo3vYtAL1QMcuvH9nd6Qr8tKje2DCrKs/oCMjn0UJm27dHjblWlMq1RTaM59pHp/zW3QqFCBlLAB/n5BLgHa/wGc1dMVvBardFwUYh4gvCQE9TSJia5Obyu1OGJkUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdJ8mgsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B2BC4CED1;
	Wed,  4 Dec 2024 16:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331484;
	bh=WhX+ruXdfwM8nhqsAMiKlobOuSeFumxFogO5m7DEJDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JdJ8mgsCFOCFJkAmmvvfONwQdGFiTlIEU0rWX4vE1ilPEASkg3hI6Pt2sCCsI2nty
	 Hu4fzGBGHZ3xGlFQYtx7HNNZ3+aadPPaDfMEtbTrYdhp6YeY06g6BUfwYaQbeZIDHE
	 Ag3uFh/b6FS1GLgPSPZrUHgIrAl6xHEgn4HIOgW0vAs/k9r8UUzKs+x1wmOfyyn21i
	 w3o/78dpnkArBfnTVbJC0bWtzh/qBWr1CvWTsfcgEK9oWEee0eQbtORhy9/WQ/vxMY
	 07CnNNTU5Ij8Q+Fzfrjs8aXygpW72xt4XQPHK2SzLeUOSqWagpGdqPZG2SWtMGQPGQ
	 QWAgP6QPb+omg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Attila Fazekas <afazekas@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	bristot@kernel.org,
	jkacur@redhat.com,
	gmonaco@redhat.com,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 07/36] rtla/timerlat: Make timerlat_hist_cpu->*_count unsigned long long
Date: Wed,  4 Dec 2024 10:45:23 -0500
Message-ID: <20241204154626.2211476-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204154626.2211476-1-sashal@kernel.org>
References: <20241204154626.2211476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Tomas Glozar <tglozar@redhat.com>

[ Upstream commit 76b3102148135945b013797fac9b206273f0f777 ]

Do the same fix as in previous commit also for timerlat-hist.

Link: https://lore.kernel.org/20241011121015.2868751-2-tglozar@redhat.com
Reported-by: Attila Fazekas <afazekas@redhat.com>
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/tracing/rtla/src/timerlat_hist.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 1f9137c592f45..d49c8f0855fe0 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -62,9 +62,9 @@ struct timerlat_hist_cpu {
 	int			*thread;
 	int			*user;
 
-	int			irq_count;
-	int			thread_count;
-	int			user_count;
+	unsigned long long	irq_count;
+	unsigned long long	thread_count;
+	unsigned long long	user_count;
 
 	unsigned long long	min_irq;
 	unsigned long long	sum_irq;
@@ -304,15 +304,15 @@ timerlat_print_summary(struct timerlat_hist_params *params,
 			continue;
 
 		if (!params->no_irq)
-			trace_seq_printf(trace->seq, "%9d ",
+			trace_seq_printf(trace->seq, "%9llu ",
 					data->hist[cpu].irq_count);
 
 		if (!params->no_thread)
-			trace_seq_printf(trace->seq, "%9d ",
+			trace_seq_printf(trace->seq, "%9llu ",
 					data->hist[cpu].thread_count);
 
 		if (params->user_hist)
-			trace_seq_printf(trace->seq, "%9d ",
+			trace_seq_printf(trace->seq, "%9llu ",
 					 data->hist[cpu].user_count);
 	}
 	trace_seq_printf(trace->seq, "\n");
@@ -488,15 +488,15 @@ timerlat_print_stats_all(struct timerlat_hist_params *params,
 		trace_seq_printf(trace->seq, "count:");
 
 	if (!params->no_irq)
-		trace_seq_printf(trace->seq, "%9d ",
+		trace_seq_printf(trace->seq, "%9llu ",
 				 sum.irq_count);
 
 	if (!params->no_thread)
-		trace_seq_printf(trace->seq, "%9d ",
+		trace_seq_printf(trace->seq, "%9llu ",
 				 sum.thread_count);
 
 	if (params->user_hist)
-		trace_seq_printf(trace->seq, "%9d ",
+		trace_seq_printf(trace->seq, "%9llu ",
 				 sum.user_count);
 
 	trace_seq_printf(trace->seq, "\n");
-- 
2.43.0


