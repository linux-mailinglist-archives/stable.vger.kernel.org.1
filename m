Return-Path: <stable+bounces-196873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CCBC83F84
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 09:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 437CB34B9B0
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 08:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C016A2D8776;
	Tue, 25 Nov 2025 08:26:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A32A2D0C72;
	Tue, 25 Nov 2025 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059178; cv=none; b=IuTM9vQToYjnPraMrYgTV+JdVvEKAQeXQp8O8Q5Vs8uGQstcKHzpGkJKv/GbKZRcsw5G00W/mLz3fDgqoLbjAfxlmiIUjGHpOAdbujmiLZWp4UFeBKp/g2/efBOKqXqcOZvnayirw7LcdL8+rsq9mBYKReFLIXiXnYaZdgsf1F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059178; c=relaxed/simple;
	bh=A8USku3cF+CtOrBNc8ByQNPSjsw8wSqV1XtkyoQUkvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZp6wEQKDXNVM/twj8cInJ8MHvTT1E0gRhMx2aAEHHzRm6JNU86X83vQxuUsWORqlkRcTUgGLh8KjnW6uWs2IL5fUUiLkG1AmneBdzeOaH/S5PJaHqo7VzbrzuGazXFQr/7wEE29wUl0T32p3CB8JNXtIqZxFgoPgTEaWGXiwRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1E4C4CEF1;
	Tue, 25 Nov 2025 08:26:15 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Rui Wang <wangrui@loongson.cn>
Subject: [PATCH] LoongArch: Fix build errors for CONFIG_RANDSTRUCT
Date: Tue, 25 Nov 2025 16:25:59 +0800
Message-ID: <20251125082559.488612-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_RANDSTRUCT enabled, members of task_struct are randomized.
There is a chance that TASK_STACK_CANARY be out of 12bit immediate's
range and causes build errors. TASK_STACK_CANARY is naturally aligned,
so fix it by replacing ld.d/st.d with ldptr.d/stptr.d which have 14bit
immediates.

Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511240656.0NaPcJs1-lkp@intel.com/
Suggested-by: Rui Wang <wangrui@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/switch.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switch.S
index 9c23cb7e432f..3007e909e0d8 100644
--- a/arch/loongarch/kernel/switch.S
+++ b/arch/loongarch/kernel/switch.S
@@ -25,8 +25,8 @@ SYM_FUNC_START(__switch_to)
 	stptr.d a4, a0, THREAD_SCHED_CFA
 #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP)
 	la	t7, __stack_chk_guard
-	LONG_L	t8, a1, TASK_STACK_CANARY
-	LONG_S	t8, t7, 0
+	ldptr.d	t8, a1, TASK_STACK_CANARY
+	stptr.d	t8, t7, 0
 #endif
 	move	tp, a2
 	cpu_restore_nonscratch a1
-- 
2.47.3


