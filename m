Return-Path: <stable+bounces-73875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947C997072D
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911A01C20D95
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CC21531D1;
	Sun,  8 Sep 2024 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0QFtq+cu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC43118C22
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725797327; cv=none; b=lCvk12r1NzIr885eumd93qkv/VbzCxZb6tL2SyOMpeEzrtrC7BZXOjh4KPpAJR+b6IwRxQkuxP/uDkC2O699LHXdVbxxUR0PKRS9ByogYtXZ9Za1uOmo2jetl1L+MxA4VGc1N9iFwWRWhfZp0UQgkOobxPvgypH0jToxQDg/gm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725797327; c=relaxed/simple;
	bh=AqMGWMlhxdEJL+v/ruv9L26nejeDCZCujI3z0f3Xazw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a4sbG5xvCGocIwC7yjq0beGVmQ/h3VOz/2nCT+EBeIiWW/CQECChqfDvnfpR+jalguTsINm8nh9URPwsZM2GG7P1AuV5m1OwFeD6Qc4JSgONNBi/mPSdGR3VeywQ0/k8IyP4NFqfMfI6U/59TLuBEfIHBxlrWAPI25UmHs6P+Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0QFtq+cu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1778EC4CEC3;
	Sun,  8 Sep 2024 12:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725797326;
	bh=AqMGWMlhxdEJL+v/ruv9L26nejeDCZCujI3z0f3Xazw=;
	h=Subject:To:Cc:From:Date:From;
	b=0QFtq+cuJCOGJcYfu22Y//HbCMkjVq9oJwQPYg5CXJFT0z5uuvyE+o89exs6FCQer
	 +g0/VF7X0MMwdu66s5LLx9+XKxe28vCDzNeB3I6L4VuRORJBUU1hnAiEXvkanWV2W+
	 NWwyVVOLvGlYf41sqcGoTSsE+mJtC/DvaeJu1Oag=
Subject: FAILED: patch "[PATCH] tracing: Avoid possible softlockup in tracing_iter_reset()" failed to apply to 4.19-stable tree
To: zhengyejian@huaweicloud.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 14:08:35 +0200
Message-ID: <2024090835-matchbox-untreated-40ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 49aa8a1f4d6800721c7971ed383078257f12e8f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090835-matchbox-untreated-40ad@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

49aa8a1f4d68 ("tracing: Avoid possible softlockup in tracing_iter_reset()")
bc1a72afdc4a ("ring-buffer: Rename ring_buffer_read() to read_buffer_iter_advance()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 49aa8a1f4d6800721c7971ed383078257f12e8f9 Mon Sep 17 00:00:00 2001
From: Zheng Yejian <zhengyejian@huaweicloud.com>
Date: Tue, 27 Aug 2024 20:46:54 +0800
Subject: [PATCH] tracing: Avoid possible softlockup in tracing_iter_reset()

In __tracing_open(), when max latency tracers took place on the cpu,
the time start of its buffer would be updated, then event entries with
timestamps being earlier than start of the buffer would be skipped
(see tracing_iter_reset()).

Softlockup will occur if the kernel is non-preemptible and too many
entries were skipped in the loop that reset every cpu buffer, so add
cond_resched() to avoid it.

Cc: stable@vger.kernel.org
Fixes: 2f26ebd549b9a ("tracing: use timestamp to determine start of latency traces")
Link: https://lore.kernel.org/20240827124654.3817443-1-zhengyejian@huaweicloud.com
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ebe7ce2f5f4a..edf6bc817aa1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3958,6 +3958,8 @@ void tracing_iter_reset(struct trace_iterator *iter, int cpu)
 			break;
 		entries++;
 		ring_buffer_iter_advance(buf_iter);
+		/* This could be a big loop */
+		cond_resched();
 	}
 
 	per_cpu_ptr(iter->array_buffer->data, cpu)->skipped_entries = entries;


