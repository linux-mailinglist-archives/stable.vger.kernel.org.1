Return-Path: <stable+bounces-39913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FC18A5554
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9EA41C21A3C
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7B24C618;
	Mon, 15 Apr 2024 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i7uTZAMA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535D9445;
	Mon, 15 Apr 2024 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192193; cv=none; b=Valz7YVBmEcWf7yNISNJOPdxqHDdSSjSsEI3VmOG/sKxzeS4H1KGIl1wHFOzK9f2o9c8x3BNLbdhmX/ptuql63btyFyRQbrdcpqFLgHu2zQ6GkXOi/ywmWthF/yvIjWN9C0h0usySEY2flEC2zHiUc6HL1wOyr0eLc5PtJEZSv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192193; c=relaxed/simple;
	bh=xxNshNwqs5iNJlAQa4Axc6/qfr1kW5bQOqIePCe4bH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O9VCY2aekvf3Rq0seVkNmEHt9waDnDk0/PTuvCdN3bK7s3x1Q0GenG0GSpmZhT3R+9finaFk9SxmMpZ+8lQdzsPtyR/816SO9qp1xsgZ1GeXywJ7V/GXTKs8GyXRSC6ljOEZ7P42J7mHRyGsHWrtwVs65tMDaiT4NsHCPhCVaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i7uTZAMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21632C113CC;
	Mon, 15 Apr 2024 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713192193;
	bh=xxNshNwqs5iNJlAQa4Axc6/qfr1kW5bQOqIePCe4bH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7uTZAMAT2ckna0nT4/e1UA3OEU63dQUHN8+5jfCkPsFjsoqyJWrhFCMUrdU4EbAb
	 0q7vClE+QETsp/mC7oR1boBM3zvLeLozbIQZevlmTLibrXVBLwmiz3Z22jJBOHObQu
	 sFnn12/ZWXLGsIPLSZZrbUX8P5NczrWFttDfITs8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Kees Cook <keescook@chromium.org>,
	Ajay Kaher <akaher@vmware.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 27/45] tracing: hide unused ftrace_event_id_fops
Date: Mon, 15 Apr 2024 16:21:34 +0200
Message-ID: <20240415141943.057461278@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141942.235939111@linuxfoundation.org>
References: <20240415141942.235939111@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 5281ec83454d70d98b71f1836fb16512566c01cd ]

When CONFIG_PERF_EVENTS, a 'make W=1' build produces a warning about the
unused ftrace_event_id_fops variable:

kernel/trace/trace_events.c:2155:37: error: 'ftrace_event_id_fops' defined but not used [-Werror=unused-const-variable=]
 2155 | static const struct file_operations ftrace_event_id_fops = {

Hide this in the same #ifdef as the reference to it.

Link: https://lore.kernel.org/linux-trace-kernel/20240403080702.3509288-7-arnd@kernel.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ajay Kaher <akaher@vmware.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Clément Léger <cleger@rivosinc.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Fixes: 620a30e97feb ("tracing: Don't pass file_operations array to event_create_dir()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 0a7348b90ba50..1f4f3096b9ac4 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1645,6 +1645,7 @@ static int trace_format_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+#ifdef CONFIG_PERF_EVENTS
 static ssize_t
 event_id_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 {
@@ -1659,6 +1660,7 @@ event_id_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
 }
+#endif
 
 static ssize_t
 event_filter_read(struct file *filp, char __user *ubuf, size_t cnt,
@@ -2104,10 +2106,12 @@ static const struct file_operations ftrace_event_format_fops = {
 	.release = seq_release,
 };
 
+#ifdef CONFIG_PERF_EVENTS
 static const struct file_operations ftrace_event_id_fops = {
 	.read = event_id_read,
 	.llseek = default_llseek,
 };
+#endif
 
 static const struct file_operations ftrace_event_filter_fops = {
 	.open = tracing_open_file_tr,
-- 
2.43.0




