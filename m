Return-Path: <stable+bounces-125224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73711A690DF
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FBCB1B666DB
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFB32144B6;
	Wed, 19 Mar 2025 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J11uSUd3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8BF1D5AC6;
	Wed, 19 Mar 2025 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395040; cv=none; b=ozoi1r2EtjiHk06QTdbhIoU2Im9mG8js+R++ovhP0dC9o5+nZtpIOPmWo9683YDK/ExX9fifNO/Pu9bLG7qWvNmt4O/ZTi6z7n4BNmB/zOVC6LgSTTeXJVcxLI2mL00GCO8h323HXzDoDgSCEn1RPefUIslShyp6pdc5kHrk7zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395040; c=relaxed/simple;
	bh=d3sCLBfsojkHNWNY8DGkJ1PLo9tHnNND3vgu3peHg8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OeDd94SyOaI3kSLusuWGcpHDPkuH+bDSL82t/7Jt7vQsc0fAQsFOaPCDpCTzh4DqgIHGOtaK0pw5Majcq4s86zpCLJsYJWRTeasaVflShOQW7+LWMv/HQvmsvq149/8HYk03r6uYvk30CULcNNkd6xDoVz1HJtdsxuhlYGGzW30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J11uSUd3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D500FC4CEE4;
	Wed, 19 Mar 2025 14:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395039;
	bh=d3sCLBfsojkHNWNY8DGkJ1PLo9tHnNND3vgu3peHg8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J11uSUd36R2iSQAGzzmHVKx1lyVgdTw22kCgQ5cBvIeOZqysVmolVBeIfE/7pRaBB
	 +I9NCkzhe+ib8YuyuxDZoeT0JzL2W64sGyG98oM9TR358FuRRQpjiUqeTs5y+Il8l6
	 CCx4tEUEoegfzjxLl0Y0cFDVuOr6HOS2gijvgVbo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Loehle <christian.loehle@arm.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 063/231] sched/debug: Provide slice length for fair tasks
Date: Wed, 19 Mar 2025 07:29:16 -0700
Message-ID: <20250319143028.381502631@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
References: <20250319143026.865956961@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Loehle <christian.loehle@arm.com>

[ Upstream commit 9065ce69754dece78606c8bbb3821449272e56bf ]

Since commit:

  857b158dc5e8 ("sched/eevdf: Use sched_attr::sched_runtime to set request/slice suggestion")

... we have the userspace per-task tunable slice length, which is
a key parameter that is otherwise difficult to obtain, so provide
it in /proc/$PID/sched.

[ mingo: Clarified the changelog. ]

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/453349b1-1637-42f5-a7b2-2385392b5956@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 82b165bf48c42..1e3bc0774efd5 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1264,6 +1264,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	if (task_has_dl_policy(p)) {
 		P(dl.runtime);
 		P(dl.deadline);
+	} else if (fair_policy(p->policy)) {
+		P(se.slice);
 	}
 #ifdef CONFIG_SCHED_CLASS_EXT
 	__PS("ext.enabled", task_on_scx(p));
-- 
2.39.5




