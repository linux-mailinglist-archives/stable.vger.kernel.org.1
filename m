Return-Path: <stable+bounces-98339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75F69E4045
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A40167751
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663B520FA8B;
	Wed,  4 Dec 2024 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHJfOhjb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F66D20FA87;
	Wed,  4 Dec 2024 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331481; cv=none; b=HlNe+80mffO3YwZKnASJqe8RNVYPxivdY/qRiMggiw3jBTH0YtAf+qjMveSof1ZYrI2TP6XimZ5zyef1xGGxoPI7djDrx68S+EeMS9oxSe8ERqjn7WWJKKDeehY0VdnuibX1HK0F8ka4JKBelsRKI3WRoH8knKWJ+Gd35MNQrCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331481; c=relaxed/simple;
	bh=uSo708ym+6IUE3v7hcIVVLbdQwAsdo/NWdqhzGsHD1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGsccXNe+1c84d+vt7EDlyvD6WdcKlWX+A5amn6/Sits2G0gtl0V8JuJxouoNAGuw7xTF2rJxelRvES4rMGuItlsCZbxSguaPA1Ec+1CehURJw/snXz5J2n4uOtiSGm8+fRncjWmgLUTGfl0Zz0ofsZ63g8mkzmO3DehWOxhVM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHJfOhjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE94C4CECD;
	Wed,  4 Dec 2024 16:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331481;
	bh=uSo708ym+6IUE3v7hcIVVLbdQwAsdo/NWdqhzGsHD1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WHJfOhjbzhmym08mMsRH9ES3d2QwSjaJKeXn61dISoGXpiIETv8wTCDJo4NYP1hcg
	 bqpnspVwkmslECnnUIh4dyBHDkPAqmSS8q58wQeiuVoCDKKlCxIC93wN9TcMWPU0L0
	 uBDXtNajw3oyDS45+Yk/SBNwLlWOIHqzYwvLZX3DNI6MjBwP/7OcabEszov3H9C31H
	 LCdtUKnHjwvSGXfOIGLgISFL7RMJDyiFzSmBH+jkOk1rnED9Gxo/pmghdmcCGT/Gmd
	 eplIzc8mQil+TtVB3rAoiH6TWVk7eX/iQmZFSND2amrwio0zp0LF5fICrRXEr7Nxge
	 hR4zeDAfsfQmw==
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
Subject: [PATCH AUTOSEL 6.12 06/36] rtla/timerlat: Make timerlat_top_cpu->*_count unsigned long long
Date: Wed,  4 Dec 2024 10:45:22 -0500
Message-ID: <20241204154626.2211476-6-sashal@kernel.org>
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


