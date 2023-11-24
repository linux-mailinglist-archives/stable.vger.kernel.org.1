Return-Path: <stable+bounces-174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 351DA7F7463
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14411F20F35
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 12:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B65B20B00;
	Fri, 24 Nov 2023 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RMfWHMKw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE967F0
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 12:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0502DC433C8;
	Fri, 24 Nov 2023 12:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700830574;
	bh=tXodNCp90IcMgXVb9zTy4ArfWVM0su0sPbQ4h74T/Go=;
	h=Subject:To:Cc:From:Date:From;
	b=RMfWHMKwbYnVv+67kjPReX51ftlPVOuwKdki5CM6yhEEVX4tCYwAOakmQAqQ6mofJ
	 eS0dIOHopHq3KnSrG7Grn5Pj38Wr+2IAXijFGmHQXBRtvnRoWyLrs9nj5/EAJZiw/B
	 235qsHV1sp8/xlPzBJhlh5SQTWBdiCpVHDxEmNVA=
Subject: FAILED: patch "[PATCH] riscv: put interrupt entries into .irqentry.text" failed to apply to 4.19-stable tree
To: namcaov@gmail.com,palmer@rivosinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 12:56:11 +0000
Message-ID: <2023112409-padlock-freeway-b534@gregkh>
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
git cherry-pick -x 87615e95f6f9ccd36d4a3905a2d87f91967ea9d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112409-padlock-freeway-b534@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

87615e95f6f9 ("riscv: put interrupt entries into .irqentry.text")
f0bddf50586d ("riscv: entry: Convert to generic entry")
c3ec1e8964fb ("Merge patch series "RISC-V: Align the shadow stack"")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 87615e95f6f9ccd36d4a3905a2d87f91967ea9d2 Mon Sep 17 00:00:00 2001
From: Nam Cao <namcaov@gmail.com>
Date: Mon, 21 Aug 2023 16:57:09 +0200
Subject: [PATCH] riscv: put interrupt entries into .irqentry.text

The interrupt entries are expected to be in the .irqentry.text section.
For example, for kprobes to work properly, exception code cannot be
probed; this is ensured by blacklisting addresses in the .irqentry.text
section.

Fixes: 7db91e57a0ac ("RISC-V: Task implementation")
Signed-off-by: Nam Cao <namcaov@gmail.com>
Link: https://lore.kernel.org/r/20230821145708.21270-1-namcaov@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 143a2bb3e697..d7dd9030df3f 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -14,6 +14,8 @@
 #include <asm/asm-offsets.h>
 #include <asm/errata_list.h>
 
+	.section .irqentry.text, "ax"
+
 SYM_CODE_START(handle_exception)
 	/*
 	 * If coming from userspace, preserve the user thread pointer and load


