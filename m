Return-Path: <stable+bounces-20528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A4285A492
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 14:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77D681C23072
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 13:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503FF3612D;
	Mon, 19 Feb 2024 13:24:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E9432182
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349051; cv=none; b=SpXlaMqiHOUkW3h1+NCTm+Md5uHGPgfDDX0RnrntosNYvEiuTx8nteooFDiM0xDePIKl4R2yIYNTcnKPiygWHQWk6aof8LLt7o6bXhFH0f4Sp82eY1JAzSkP02LFwww3WWfRuhZZZPv7Cz0QH3yovD2YGIAwW+dwayklTk6q+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349051; c=relaxed/simple;
	bh=AajlHF4Swl8ovOgGqJh90HWbwfQ1me6Enr9BSHDWiCw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VLki8jPwl2Hgcdxa5GJoSnSl9RYkJ3MAyoTOlFIjFhtcNob9O57NcI7Q+64FfWgEG3HKHi1hqPt6L2NZFj6Ti1zcx5twa4xlEOB+ZI9sE6H9o0Z4KXcmoso26ceQb7lwxN8YD+mIfiF9NN56mNk143KvtJr4PxLh5exaBsoVk8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tdjmf5yCBz1FKhS;
	Mon, 19 Feb 2024 21:19:14 +0800 (CST)
Received: from canpemm500006.china.huawei.com (unknown [7.192.105.130])
	by mail.maildlp.com (Postfix) with ESMTPS id 825F218005F;
	Mon, 19 Feb 2024 21:24:04 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 21:24:04 +0800
Received: from huawei.com (10.67.174.111) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 21:24:04 +0800
From: Xiang Yang <xiangyang3@huawei.com>
To: <ardb@kernel.org>, <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>
CC: <keescook@chromium.org>, <linux-arm-kernel@lists.infradead.org>,
	<stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<xiangyang3@huawei.com>, <xiujianfeng@huawei.com>, <liaochang1@huawei.com>
Subject: [PATCH 5.10.y v2] Revert "arm64: Stash shadow stack pointer in the task struct on interrupt"
Date: Mon, 19 Feb 2024 21:21:53 +0800
Message-ID: <20240219132153.378265-1-xiangyang3@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)

This reverts commit 3f225f29c69c13ce1cbdb1d607a42efeef080056.

The shadow call stack for irq now is stored in current task's thread info
in irq_stack_entry. There is a possibility that we have some soft irqs
pending at the end of hard irq, and when we process softirq with the irq
enabled, irq_stack_entry will enter again and overwrite the shadow call
stack whitch stored in current task's thread info, leading to the
incorrect shadow call stack restoration for the first entry of the hard
IRQ, then the system end up with a panic.

task A                               |  task A
-------------------------------------+------------------------------------
el1_irq        //irq1 enter          |
  irq_handler  //save scs_sp1        |
    gic_handle_irq                   |
    irq_exit                         |
      __do_softirq                   |
                                     | el1_irq         //irq2 enter
                                     |   irq_handler   //save scs_sp2
                                     |                 //overwrite scs_sp1
                                     |   ...
                                     |   irq_stack_exit //restore scs_sp2
  irq_stack_exit //restore wrong     |
                 //scs_sp2           |

So revert this commit to fix it.

Fixes: 3f225f29c69c ("arm64: Stash shadow stack pointer in the task struct on interrupt")

Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
---
 arch/arm64/kernel/entry.S | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index a94acea770c7..020a455824be 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -431,7 +431,9 @@ SYM_CODE_END(__swpan_exit_el0)
 
 	.macro	irq_stack_entry
 	mov	x19, sp			// preserve the original sp
-	scs_save tsk			// preserve the original shadow stack
+#ifdef CONFIG_SHADOW_CALL_STACK
+	mov	x24, scs_sp		// preserve the original shadow stack
+#endif
 
 	/*
 	 * Compare sp with the base of the task stack.
@@ -465,7 +467,9 @@ SYM_CODE_END(__swpan_exit_el0)
 	 */
 	.macro	irq_stack_exit
 	mov	sp, x19
-	scs_load_current
+#ifdef CONFIG_SHADOW_CALL_STACK
+	mov	scs_sp, x24
+#endif
 	.endm
 
 /* GPRs used by entry code */
-- 
2.34.1


