Return-Path: <stable+bounces-98375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE8E9E40A4
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF7328152B
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47B11C3C12;
	Wed,  4 Dec 2024 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzE6EYH3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DACD1C3C0A;
	Wed,  4 Dec 2024 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331593; cv=none; b=dFaehcb3ewtZ5J5gf6B3CXL57EEbqHdMusKw2RJMck1+ZHdbNu4bKK8rmCIslJs2uDPPMMXtmtODs8gLq/gUOclN4spPyovnuz9dKDzQnstVANcFeQdhQ0kLrX9vPamih/r4bjWIpYDcnzbaN9k7s5nWNSa9ViuXFaBrwU1eN8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331593; c=relaxed/simple;
	bh=uSo708ym+6IUE3v7hcIVVLbdQwAsdo/NWdqhzGsHD1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kep2VoarB/0v4AUlYb764/u78MXFLP6fTqMRKVj2ijzA/9xvZKqEs9UKsz3/Tv7J5z0lj+V7zMVoDchNx1oyDOz5wlTaxE8qIZZSFlJxKNxbh3qa1hwu1Wu7Cdi0AZNpL+beS/3bCA13VTwFwpYlUyTDtmPfwRXQOemTMtlMyUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzE6EYH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D738C4CECD;
	Wed,  4 Dec 2024 16:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331593;
	bh=uSo708ym+6IUE3v7hcIVVLbdQwAsdo/NWdqhzGsHD1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IzE6EYH3aMFd095kYvc544hZ+YiIYlqjbupn+4W8Niceepkc60tQrXhLaVGhCjI4W
	 1P5vHjdZL8j7lFMk6UgK7JOL5mNGRQiovMtw2Js4Fyh+nrZ/Ty5WmwC7pqjxhXjTn0
	 6DcP/5XP7UwVRqtKOjt/sbKYFFqV68Tp+XTYiyVTASHXS39XJ0mCHO82feNAYGHhG+
	 4Q7JQEWpFTs48+SeYLz6ymWQ486FMaGg7olu6ufiVczVFmVyTc/APSGwIC+S91OtcI
	 8VuHd/fHnF4ok/DaWODGLw/h98NvgpwAu1We2T+ZWpRKesLHsCzzw4cdHii1Bz+g9k
	 YPtuWunQwtdZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Attila Fazekas <afazekas@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	bristot@kernel.org,
	jkacur@redhat.com,
	ezulian@redhat.com,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 06/33] rtla/timerlat: Make timerlat_top_cpu->*_count unsigned long long
Date: Wed,  4 Dec 2024 10:47:19 -0500
Message-ID: <20241204154817.2212455-6-sashal@kernel.org>
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

[ Upstream commit 4eba4723c5254ba8251ecb7094a5078d5c300646 ]

Most fields of struct timerlat_top_cpu are unsigned long long, but the
fields {irq,thread,user}_count are int (32-bit signed).

This leads to overflow when tracing on a large number of CPUs for a long
enough time:
$ rtla timerlat top -a20 -c 1-127 -d 12h
...
  0 12:00:00   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
 1 #43200096  |        0         0         1         2 |        3         2         6        12
...
127 #43200096  |        0         0         1         2 |        3         2         5        11
ALL #119144 e4 |                  0         5         4 |                  2        28        16

The average latency should be 0-1 for IRQ and 5-6 for thread, but is
reported as 5 and 28, about 4 to 5 times more, due to the count
overflowing when summed over all CPUs: 43200096 * 127 = 5486412192,
however, 1191444898 (= 5486412192 mod MAX_INT) is reported instead, as
seen on the last line of the output, and the averages are thus ~4.6
times higher than they should be (5486412192 / 1191444898 = ~4.6).

Fix the issue by changing {irq,thread,user}_count fields to unsigned
long long, similarly to other fields in struct timerlat_top_cpu and to
the count variable in timerlat_top_print_sum.

Link: https://lore.kernel.org/20241011121015.2868751-1-tglozar@redhat.com
Reported-by: Attila Fazekas <afazekas@redhat.com>
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/tracing/rtla/src/timerlat_top.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 210b0f533534a..ee7c291fc9bb3 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -54,9 +54,9 @@ struct timerlat_top_params {
 };
 
 struct timerlat_top_cpu {
-	int			irq_count;
-	int			thread_count;
-	int			user_count;
+	unsigned long long	irq_count;
+	unsigned long long	thread_count;
+	unsigned long long	user_count;
 
 	unsigned long long	cur_irq;
 	unsigned long long	min_irq;
@@ -280,7 +280,7 @@ static void timerlat_top_print(struct osnoise_tool *top, int cpu)
 	/*
 	 * Unless trace is being lost, IRQ counter is always the max.
 	 */
-	trace_seq_printf(s, "%3d #%-9d |", cpu, cpu_data->irq_count);
+	trace_seq_printf(s, "%3d #%-9llu |", cpu, cpu_data->irq_count);
 
 	if (!cpu_data->irq_count) {
 		trace_seq_printf(s, "%s %s %s %s |", no_value, no_value, no_value, no_value);
-- 
2.43.0


