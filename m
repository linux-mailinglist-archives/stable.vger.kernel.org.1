Return-Path: <stable+bounces-114790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3585A30096
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761971883752
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA7B1F5420;
	Tue, 11 Feb 2025 01:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHVEg6TG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0F91F4E57;
	Tue, 11 Feb 2025 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237506; cv=none; b=gYF27oI4qhbTe6SzDEdYKhEK0fvn0QstLYVB4ll3ty+SWCrk+EVxCFgcekBJmfKja1A/UfCbCAgxSoklrHykUDhGUOHInRYIr0etysybG0cGjcZG5Gr3A5lfQH7DcgISlgJ7XdMHojh8d1231vvQ87GX3J9qEzfaBbQNUOxHUgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237506; c=relaxed/simple;
	bh=laWs+64X4UMUjppHO1EP9Kt5etxk1cmZTV770JRXEsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hoflYjPMKvkNzfXKwgZheHjuIhFCGagjwyaicmZlazNFtyKNdgmr0iGbhQRVtcWWTRWeVbCeOCEQOpM2MQoBBshPHI6V7qit3zFYf0nHWAhEKOFnWg5a6aerO6zJpUuLVY8gqQng3mK/SgNAbNC1osEg9AJuNFPOJmq3OqbMbCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHVEg6TG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F156C4CEEA;
	Tue, 11 Feb 2025 01:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237505;
	bh=laWs+64X4UMUjppHO1EP9Kt5etxk1cmZTV770JRXEsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mHVEg6TG3PBRyDXJ9w/LZCLxREZ8+26QqlzTGwev/kZ95kTURcwmBD+D6VcTQSFds
	 pefiRATG0Diw87T25CJkhhHr4UA53Sn+dWRvplReXc3oSovY/GSl4nfBheXDXIyd7P
	 jpgO4Q95175hHD6pU/g+DCe8zQctmB0vTHdmPww3b9rmmJ5Mm3ZF227xoGmfdQPpOs
	 lPpCsxwD8sGO9b9yOec9dNsHYPVEbyv/Yl1XsudpkbGSM6AhL+jbyaFe+jTgxzvzZf
	 rE6HQaXgSDeab+ddfb/H5HMw/VQJUhZyljIYKOSShfV1SZYu0U9O679ankrpt8mreZ
	 KE6vhn5zFZeOQ==
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
Subject: [PATCH AUTOSEL 6.6 06/15] sched/debug: Provide slice length for fair tasks
Date: Mon, 10 Feb 2025 20:31:26 -0500
Message-Id: <20250211013136.4098219-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013136.4098219-1-sashal@kernel.org>
References: <20250211013136.4098219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.76
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
index 4c3d0d9f3db63..115e266db76bf 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1089,6 +1089,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	if (task_has_dl_policy(p)) {
 		P(dl.runtime);
 		P(dl.deadline);
+	} else if (fair_policy(p->policy)) {
+		P(se.slice);
 	}
 #undef PN_SCHEDSTAT
 #undef P_SCHEDSTAT
-- 
2.39.5


