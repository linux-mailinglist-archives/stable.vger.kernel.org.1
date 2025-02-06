Return-Path: <stable+bounces-114045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE61A2A3C6
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 10:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C2218848D4
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 09:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199B62253F7;
	Thu,  6 Feb 2025 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Ln4KOAGF"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC4C225A3E;
	Thu,  6 Feb 2025 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832543; cv=none; b=JaJ+9+/vZ7Iq5GmAuqu1uOoVWR3T/lOgkhVVj8DAWWWgEfabD6XaUibMbHJPSmy8SsUcfRfBpxCxRRxEiX5tOTeOWYZDWb4KWkYtfLdgT5DxdHcp/qBQGOvKToFtpKTOpslm0I9nWj+ZHvzgW0+Ugq+Y9I2Avq8Nue3pvW5tG8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832543; c=relaxed/simple;
	bh=7jAIuBV+/kYZyNMP7HxSUsmu8APD8C6CGiLI6Xg+y6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pHSlXTrDtozCGCXlLP03Viebr9ZKoyZMB7gVNy8KAWmijzNyGQdoJ5MbVk6h87torS/5OziWOJpDeuFQoG9UQfpdhDbONp2xxshnmaf+ksiGIIjeRp5HzNi1p8AZICqfTroTO3l7spg2VCqPz09y2dBcJWQSb6QaFcTXIDbndQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=Ln4KOAGF; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3f48:0:640:7695:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 27B2160A06;
	Thu,  6 Feb 2025 12:02:17 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6b8:b081:1229::1:1a])
	by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 62ilp53IZKo0-nZUeuZcr;
	Thu, 06 Feb 2025 12:02:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1738832536;
	bh=tnsS/bGpQAwc8OLFLKLSqn0mhm9Mmm9Ui6vHfp9zubo=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Ln4KOAGFUy4TsmmOk5INOj4rcLEJMVmXhmsWNyHY5q+l6LnqOWjsHMC7bnoRt0phD
	 bn7z1unHY+T1+apewjfu+4JlQOzugcnGlqCg0F54xpCUr81zAd4DDyhJ7mW8hWszRY
	 EKNcHpiNi8nz9ysnD7usP4fokf3tcWeh/ZGMal3E=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	Wen Yang <wenyang@linux.alibaba.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	kniv@yandex-team.ru,
	stable@vger.kernel.org
Subject: [PATCH v2] ftrace: Avoid potential division by zero in function_stat_show()
Date: Thu,  6 Feb 2025 12:01:56 +0300
Message-Id: <20250206090156.1561783-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205095021.15771b88@gandalf.local.home>
References: <20250205095021.15771b88@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check whether denominator expression x * (x - 1) * 1000 mod {2^32, 2^64}
produce zero and skip stddev computation in that case.

For now don't care about rec->counter * rec->counter overflow because
rec->time * rec->time overflow will likely happen earlier.

Cc: stable@vger.kernel.org
Fixes: e31f7939c1c27 ("ftrace: Avoid potential division by zero in function profiler")
Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
---
v2: Instead of splitting the division into two store denominator into
separate variable and zero-check it

 kernel/trace/ftrace.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 728ecda6e8d4..9ea6609588cf 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -540,6 +540,7 @@ static int function_stat_show(struct seq_file *m, void *v)
 	static struct trace_seq s;
 	unsigned long long avg;
 	unsigned long long stddev;
+	unsigned long long stddev_denom;
 #endif
 	guard(mutex)(&ftrace_profile_lock);
 
@@ -559,23 +560,19 @@ static int function_stat_show(struct seq_file *m, void *v)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	seq_puts(m, "    ");
 
-	/* Sample standard deviation (s^2) */
-	if (rec->counter <= 1)
-		stddev = 0;
-	else {
-		/*
-		 * Apply Welford's method:
-		 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
-		 */
+	/*
+	 * Variance formula:
+	 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
+	 * Maybe Welford's method is better here?
+	 * Divide only by 1000 for ns^2 -> us^2 conversion.
+	 * trace_print_graph_duration will divide by 1000 again.
+	 */
+	stddev = 0;
+	stddev_denom = rec->counter * (rec->counter - 1) * 1000;
+	if (stddev_denom) {
 		stddev = rec->counter * rec->time_squared -
 			 rec->time * rec->time;
-
-		/*
-		 * Divide only 1000 for ns^2 -> us^2 conversion.
-		 * trace_print_graph_duration will divide 1000 again.
-		 */
-		stddev = div64_ul(stddev,
-				  rec->counter * (rec->counter - 1) * 1000);
+		stddev = div64_ul(stddev, stddev_denom);
 	}
 
 	trace_seq_init(&s);
-- 
2.34.1


