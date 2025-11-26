Return-Path: <stable+bounces-196949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01819C88141
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 05:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 832CA34D5BE
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 04:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B011F4CBB;
	Wed, 26 Nov 2025 04:38:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A520E158538;
	Wed, 26 Nov 2025 04:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764131912; cv=none; b=SK2NR+8r4CxoQq/Z/3NxdKT6qaXx2nAtWuSKHVFbLKJPXchXcIXA9HrXGWRtvQKXNDc8qrlterBimoi4UV0R+sdaOViHFZzAucJlYFVF04rxxyCGotr9VQ5+szGt6L/5eoLrFDavUuWaB/HS8XVdlow+3NKGkZbyC1kTTvgO064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764131912; c=relaxed/simple;
	bh=3LVjDb4rIEwFz/cgzJlaF2lHNCAZMww188LbmMGprdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ff/6BO9S5K0HGAVB83KP7wY6+upoBzeJW4bFuN7GgB1QqA9DIcusm9/FlWdpRTJ8cyw3dkdZmk0IsrBcsBeUoum8PG9lwpcjz8RrCAPeOdtwaJsU7z0Q31We6n4A6muXrl3CGLbByGAZFgJ1OA6EZnyagh0AB8F6tqq4Tj4johU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DE1C113D0;
	Wed, 26 Nov 2025 04:38:28 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH] LoongArch: Fix arch_dup_task_struct() for CONFIG_RANDSTRUCT
Date: Wed, 26 Nov 2025 12:38:15 +0800
Message-ID: <20251126043815.1482382-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the optimized version of arch_dup_task_struct() for LoongArch
assumes 'thread' is the last member of 'task_struct'. But this is
not true if CONFIG_RANDSTRUCT is enabled after Linux-6.16.

So fix the arch_dup_task_struct() function for CONFIG_RANDSTRUCT by
copying the whole 'task_struct'.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/process.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index efd9edf65603..d1e04f9e0f79 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -130,6 +130,11 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 
 	preempt_enable();
 
+	if (IS_ENABLED(CONFIG_RANDSTRUCT)) {
+		memcpy(dst, src, sizeof(struct task_struct));
+		return 0;
+	}
+
 	if (!used_math())
 		memcpy(dst, src, offsetof(struct task_struct, thread.fpu.fpr));
 	else
-- 
2.47.3


