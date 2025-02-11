Return-Path: <stable+bounces-114773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9438A3006A
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E7D166A70
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092741F12FA;
	Tue, 11 Feb 2025 01:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zpxz+jvQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4B1F12F2;
	Tue, 11 Feb 2025 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237460; cv=none; b=C0ZMQVsNcFFDM6WNjVZipCLunV4cbQwRNPcMVGCSqYesrB2T8ZRKyB3128HXZYogpWwGg/GdgRUsxzDazo02GDPUJnDeCqJrYh1RBzQAM59TsM7fSyA7fgu3n1GVKGNpOfMqsr/k/MGKUm4lFNQ2QsedWnUzZNRmeyCcNEafuwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237460; c=relaxed/simple;
	bh=Q0FnytlgEyxNSe5xTnqjy3UtG3XE9+2p9g5n5auPW6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SAAnOR8YvMXd/lylxbN0Yjz5MKIoU4HxwiD6UclaCNYPDk+wfAgopgrEazqgO3IWw290H7KDXBGCEilNJZPCbGilTDkaLwcFQ9evWTLBBJBaSYln3U253KPV3I9gsx0xQ4PD0Yrzq/jQjmyvwypzi3rPMXZ5ejBnACA9IiMilKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zpxz+jvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A895C4CEE9;
	Tue, 11 Feb 2025 01:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237460;
	bh=Q0FnytlgEyxNSe5xTnqjy3UtG3XE9+2p9g5n5auPW6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zpxz+jvQGjGV8/s/yIof/zWneSQcc6T6rd0/E+J80mkiqkq29odK3T8P6xLhg7Qkl
	 BgS2v0PzB7WUC7MN9xjUGWt7ByWWGuBUR4xdh/0TAEUm8xFuXcSV2y2wlmfwTqR4Ix
	 l176jPzdtTH2pE26ecz/VCr/IITqxS5M99ghMc8iM5Dff4Hq01jsfqd0LBC12mMHeF
	 qStnCp8gz0b2ULUhBYWgRqVMkquo5B3JHku6Vsj7dhtT23yDNNfJ2KAno/xmeAR3Z8
	 4NP6oZ2PdxY1Cf7Zg7U2p1bRY+B40SIpILcUXSl6WJiYnJb89pexQ1aMsPdkWaiAsA
	 b9aon+rYt2VrA==
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
Subject: [PATCH AUTOSEL 6.12 08/19] sched/debug: Provide slice length for fair tasks
Date: Mon, 10 Feb 2025 20:30:36 -0500
Message-Id: <20250211013047.4096767-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013047.4096767-1-sashal@kernel.org>
References: <20250211013047.4096767-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.13
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


