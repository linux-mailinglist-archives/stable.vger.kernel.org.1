Return-Path: <stable+bounces-98376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FA89E43C8
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 19:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A4BB461F6
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494C020FAAE;
	Wed,  4 Dec 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hh4a4+f/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06CC1C3C0A;
	Wed,  4 Dec 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331597; cv=none; b=JGzN1jlNB2EiQhVKHLkj+pMFdUYZeOMfUfBN5SMjMy4kdgx3GNt6WEkSz+blDs7ERAGS6ogl5acSeZrzgYN+bvhk2V1DkLP2ebjan54DgJTs1GfERvnfaAtdIrEJ/dkEAQ9+YF27hrPOqYF6sGtcj8poBVYOPjICWjTbow2IsDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331597; c=relaxed/simple;
	bh=WhX+ruXdfwM8nhqsAMiKlobOuSeFumxFogO5m7DEJDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDTV62uAQp1JbNvE0jLzAlKNaKGp9pocnblaDanI6h7S07atTGvqstaVviJ1Pz5kSxuQ04WdTndEdstwkonHj6chKtzP9jjQb2zcaVAy2hoYj76BU2Yrs9w/x1o1hwHotcDRvdg26nczhyfc9gM7B9T0HdWwYwrzfcP2kcBSew0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hh4a4+f/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61021C4CECD;
	Wed,  4 Dec 2024 16:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331596;
	bh=WhX+ruXdfwM8nhqsAMiKlobOuSeFumxFogO5m7DEJDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hh4a4+f/T0yashVxCxQw/GwPaL68eqN2M6jMYeBF2zjO0s7iWqgVIu9TcOKKGHNUq
	 lmNbE1f/c/YYr6tmqUMP1kDdQvxkjvp2UipFduDxus3aVFGLtvMxqHW+P/l7xm62Js
	 MFeoVtrWDvL31wmPG42jMB3TiZbbcfS2/ylR4pns4GTz5gzdroGTpvi64DESzDGSFD
	 3g69Bvh4nAXnzaOfyqmd+c3tQYy6dfoxpjJYPlH7Q1nmnBW7gUBs2HDCe9ghFX92F7
	 0cPlJFAXGASCvIlaO6ZzeRVn2mPTmy6lRnRP4O3WEanvKU01X6Mz+O7ALiERO3s9e7
	 0u5B2cADCmH1w==
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
Subject: [PATCH AUTOSEL 6.11 07/33] rtla/timerlat: Make timerlat_hist_cpu->*_count unsigned long long
Date: Wed,  4 Dec 2024 10:47:20 -0500
Message-ID: <20241204154817.2212455-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204154817.2212455-1-sashal@kernel.org>
References: <20241204154817.2212455-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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


