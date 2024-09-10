Return-Path: <stable+bounces-75568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33183973535
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661D11C24B95
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2087118801A;
	Tue, 10 Sep 2024 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wOYwetO1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D0B185B43;
	Tue, 10 Sep 2024 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965113; cv=none; b=RCUqvVNqknVASL/0lkPcCy63NxPtE4hETeTz0txsbl9HOGNg0nS1Kca8A1KLlc5goIynz39Eobr4dK2lb9uC9ncVCbt/G5GHZRGF2hNtVcxrsJu9rl4ft8aQQe6i5UqJLA3dJbZYdYWg2iPXdZAFfHoe5Fp1JIqtHSaKzJo0Nws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965113; c=relaxed/simple;
	bh=2Gj4rvoC9wGG6k4rEDpPiFw+da2faSf8fuTSdQBdByU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzU3KMAiNLGqhIjBtZqpRzEVNwzKjgGRhO5G8KezoMzBKpeg/AiWcDbTMUMkq6QNGVxaZ6U3OCYawizylkIC6FrjbPkHh6bWUrKmEt0NiS5KXo4TphVpS55Q7yYL0iin7fZNTe5RwmUJN53QyajkOOijDOy0RJ8qnNkqROaLSJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wOYwetO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A815C4CEC3;
	Tue, 10 Sep 2024 10:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725965113;
	bh=2Gj4rvoC9wGG6k4rEDpPiFw+da2faSf8fuTSdQBdByU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wOYwetO1NLl0gZDb57gdyiNodFDBmnt3IZTvwWRytL1BYrWDKcfoDNjaKLgeQe4v8
	 5ZGzy0rcILW3QglYT4kQsz/BQMqpy6avvctzs3zxavbzx70xYhTP0KZ31vQT4JwXwN
	 2XUf+Ftc3Tg3CId8v01xRQ6h0KPZMcQc3Gj61fM4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zqiang <qiang.zhang1211@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 141/186] smp: Add missing destroy_work_on_stack() call in smp_call_on_cpu()
Date: Tue, 10 Sep 2024 11:33:56 +0200
Message-ID: <20240910092600.403245210@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092554.645718780@linuxfoundation.org>
References: <20240910092554.645718780@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zqiang <qiang.zhang1211@gmail.com>

[ Upstream commit 77aeb1b685f9db73d276bad4bb30d48505a6fd23 ]

For CONFIG_DEBUG_OBJECTS_WORK=y kernels sscs.work defined by
INIT_WORK_ONSTACK() is initialized by debug_object_init_on_stack() for
the debug check in __init_work() to work correctly.

But this lacks the counterpart to remove the tracked object from debug
objects again, which will cause a debug object warning once the stack is
freed.

Add the missing destroy_work_on_stack() invocation to cure that.

[ tglx: Massaged changelog ]

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20240704065213.13559-1-qiang.zhang1211@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/smp.c b/kernel/smp.c
index b0684b4c111e..c6b3ad79c72b 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1009,6 +1009,7 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
 
 	queue_work_on(cpu, system_wq, &sscs.work);
 	wait_for_completion(&sscs.done);
+	destroy_work_on_stack(&sscs.work);
 
 	return sscs.ret;
 }
-- 
2.43.0




