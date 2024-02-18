Return-Path: <stable+bounces-20420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD60859411
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 03:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FF4282FF1
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 02:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40074136A;
	Sun, 18 Feb 2024 02:33:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E296B4A31
	for <stable@vger.kernel.org>; Sun, 18 Feb 2024 02:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708223592; cv=none; b=F9473rxsNVH7O1pEVGFEFsfd33RWym2y56qKmexyIEWgCalrXeT70xkbhQrlHphTKBmTEdUr/FiThhl0rqNmA8B+rkIjXB2pLuGbYMdFz7u0Dbr4jTsdzQDm2U6zkHFMSA5TdveGhTHmbbiCu2IMEYBppd/zFljVAIV/jzfpfGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708223592; c=relaxed/simple;
	bh=rxwQHmtpV8c47v0yz6UkD5G1zKMvgSgHvEcJKMRRqMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4mqxLO3dIgKLk/mtZanuG2bl5/X506EGtV1Z5b3Qy0OztOzmlXLZ6c1gVdZgBldrVdu5yENqbdZ1W/ScQKep4qnlChnZB5cMXBgeleDRsGJmb1t2wV1uuYtjDiDeA3ZED3ofZz7QXnvCohLEOpY9XzIE6T+I+mQobkHGgDwcFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TcqR90z3Pz1Q98X;
	Sun, 18 Feb 2024 10:31:01 +0800 (CST)
Received: from canpemm500008.china.huawei.com (unknown [7.192.105.151])
	by mail.maildlp.com (Postfix) with ESMTPS id 60CB91A016C;
	Sun, 18 Feb 2024 10:33:07 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm500008.china.huawei.com (7.192.105.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 10:33:07 +0800
Received: from huawei.com (10.67.174.111) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 18 Feb
 2024 10:33:06 +0800
From: Xiang Yang <xiangyang3@huawei.com>
To: <ardb@kernel.org>, <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>
CC: <keescook@chromium.org>, <linux-arm-kernel@lists.infradead.org>,
	<stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<xiangyang3@huawei.com>, <xiujianfeng@huawei.com>, <liaochang1@huawei.com>
Subject: [PATCH 5.10.y 1/5] Revert "arm64: Stash shadow stack pointer in the task struct on interrupt"
Date: Sun, 18 Feb 2024 10:30:51 +0800
Message-ID: <20240218023055.145519-2-xiangyang3@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218023055.145519-1-xiangyang3@huawei.com>
References: <20240218023055.145519-1-xiangyang3@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Fixes: 3f225f29c69c ("arm64: Stash shadow stack pointer in the task struct on interrupt")

Cc: Ard Biesheuvel <ardb@kernel.org>
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


