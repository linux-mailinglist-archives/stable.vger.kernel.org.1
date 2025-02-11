Return-Path: <stable+bounces-114753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05187A3002D
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B8E1667A0
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0941E572A;
	Tue, 11 Feb 2025 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYJb+0Ts"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBF71E503D;
	Tue, 11 Feb 2025 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237411; cv=none; b=XjKglW13GMYY7RtLDGhOSK3vY1x+MY00F/HQ6QOKY8flUNV/VRPciUM68+lGinDNoHZ8lDD7fbBU5YYE9YB3aNkKDYBoAtH6R/NKdQkPMc1KdiUTyvNpkN8Rk4lv72VvXA/pQ/rlzt1UYTfddaUVjfA0rw1ayUHTcjMN/jDQDOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237411; c=relaxed/simple;
	bh=qoqij4vJ3WRoMvK2vgIenmYic7F8ROVpLlWYSQ9+Moo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rDna4ujMqlIQ3MKNMhLPR5JHcq1Xc6b8vIdSzZ8JHCZcuUJp9oxZSQCYOWPgYVY8562K0/iSdFntJWbWeNNWDJ7pvz8HAe4j6ioZgyV+yBvM3GmDFUJARBR9cKwreiWWAm794VkTX/QYplih3PikLU7FkSYpeTb64QukT555c88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYJb+0Ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC46C4CEE7;
	Tue, 11 Feb 2025 01:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237409;
	bh=qoqij4vJ3WRoMvK2vgIenmYic7F8ROVpLlWYSQ9+Moo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PYJb+0TsgjZ4EokA7vkR5mwhHhzCLM1tusxGcQYDnqKD8jGcLZ4KzhJnPlayOAtWW
	 h4RYlcmKGRMbFBSlu4zRfnaNlxmOhSCagaRMvVyW4xkP4+dxKUShqUO6yrBKlcM25Y
	 1VoK68HziO/DTl0R/m2PadONgBrumHOZopM+biCyDrg4pS10AnPm6So/EUEc84o2zb
	 apEfCGu2mTFezvT9PQDG6FDYc0YDvEaQmWEu0BAnMJdIpS5Xk+lwN4sd0f34tjXXQH
	 sEwrM98L9Ha4wgjMX+0KehS6h1wz5eJ4yUc+j9kXoiqtOtIBO6ecs8/kucBWY0GpHW
	 NJrPgU4R7Pwcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christian Loehle <christian.loehle@arm.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Subject: [PATCH AUTOSEL 6.13 09/21] sched/debug: Provide slice length for fair tasks
Date: Mon, 10 Feb 2025 20:29:42 -0500
Message-Id: <20250211012954.4096433-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211012954.4096433-1-sashal@kernel.org>
References: <20250211012954.4096433-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.2
Content-Transfer-Encoding: 8bit

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
index a1be00a988bf6..5b32d3cc393bf 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1265,6 +1265,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
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


