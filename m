Return-Path: <stable+bounces-106093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A469FC35F
	for <lists+stable@lfdr.de>; Wed, 25 Dec 2024 03:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2F918844AF
	for <lists+stable@lfdr.de>; Wed, 25 Dec 2024 02:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D647613B2AF;
	Wed, 25 Dec 2024 02:45:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A833D130AF6;
	Wed, 25 Dec 2024 02:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735094702; cv=none; b=WZVyCQfWk9sQWLzY35siQXOs9+4foOw1CxlmnvtQNBisuxKc5zVvn2OX/6UI86zzOJ9VBeB8gdB/JiITXhSH5Ufj45XST9XUPt7+sz126IADjIJceyz939fHbqGeNM7iyJ+pPBJAMe1sh/NjJmYIr2tRM12p4HJSxQ5Cqf2WNnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735094702; c=relaxed/simple;
	bh=aUzV+DHzGVAU7tJrn0HvvKdxPT4C+tB8L0v12RTpLjc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VExPU3H8oesVy+ruS1jkIgdHHTaCxdMPf6G6ZUIieOGQe0I82heDxbJEKyVBFFMmLSZeHQInaeWwWFm/u9AEBvYnePSmjXvTwo5EEZsisjKja+8bqUy7UMNr5rOI/D72wzSMYkCCDUhlNK43Bdnrwp+RIwGU/3Ujr9uz75qdfrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512E7C4CEDF;
	Wed, 25 Dec 2024 02:45:02 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tQHPJ-0000000EkuF-1BJn;
	Tue, 24 Dec 2024 21:45:57 -0500
Message-ID: <20241225024557.131467576@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 24 Dec 2024 21:45:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com,
 Lizhi Xu <lizhi.xu@windriver.com>
Subject: [for-linus][PATCH 2/2] tracing: Prevent bad count for tracing_cpumask_write
References: <20241225024536.865653915@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Lizhi Xu <lizhi.xu@windriver.com>

If a large count is provided, it will trigger a warning in bitmap_parse_user.
Also check zero for it.

Cc: stable@vger.kernel.org
Fixes: 9e01c1b74c953 ("cpumask: convert kernel trace functions")
Link: https://lore.kernel.org/20241216073238.2573704-1-lizhi.xu@windriver.com
Reported-by: syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0aecfd34fb878546f3fd
Tested-by: syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 957f941a08e7..f8aebcb01e62 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5087,6 +5087,9 @@ tracing_cpumask_write(struct file *filp, const char __user *ubuf,
 	cpumask_var_t tracing_cpumask_new;
 	int err;
 
+	if (count == 0 || count > KMALLOC_MAX_SIZE)
+		return -EINVAL;
+
 	if (!zalloc_cpumask_var(&tracing_cpumask_new, GFP_KERNEL))
 		return -ENOMEM;
 
-- 
2.45.2



