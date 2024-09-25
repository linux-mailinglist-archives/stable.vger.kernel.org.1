Return-Path: <stable+bounces-77208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9DF985A38
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBE6FB25D0D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D698318C359;
	Wed, 25 Sep 2024 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdRk0Xps"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C7C1B3F2B;
	Wed, 25 Sep 2024 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264515; cv=none; b=isUd8qO6AnsH9XOccRtAKU8F6hX9hU/a8Aw2M5Fzx5EP4/GWCaOFFnAiu+j5ZoARQ/19wgqhakynex8pv0kMo0lNBaqFjVY2oHFeJ71EAadVwNeDjDm402uaWPSgOu3/wPPYICr+U7YgKUHtv1FKydi7z3HUxsHXWNWzME5Jk0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264515; c=relaxed/simple;
	bh=YFY+3mAanqIL5F/49zuwu1YvcyrnvxDObgM837R9lN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JaDZyX0StceYyKt1V+le0dTiUUnFz4h41IrMNwcMVqs8WITiPb2RRjymntpKqBbH+KtsQe06/h3Beai1XdpZx4JxziD1lMxYqwYjZoaQqf4+3TvIQTtqm7qFXVHnNsNzSRYfuEXObpdhx0nHKJs1cX7LIKGEZ/LmL4Ymp3n8ptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdRk0Xps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507FEC4CEC7;
	Wed, 25 Sep 2024 11:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264515;
	bh=YFY+3mAanqIL5F/49zuwu1YvcyrnvxDObgM837R9lN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EdRk0Xps3X3qMRSNEHYOH3Al9QexJGSy5g+RjuM2TcqWCi+EcBBpxom6WnyJe/pNr
	 EVeZDxBIdGou5VHbziZEl91ZZM6eNAN1M/8DHFvGwfTP1BKPoJFFFnFmnLk0dmHEVK
	 +3mDEjCZHRdgdgW+VT4ZYu22I+9aznHHgzNNEjr4DCJNCSgshNjGfTr65IsoEqV5Kq
	 OhH+0ayY6r1F50/w4N0hSKOzcXMpN+5T5NZOFhaRJOuA1GqiIZ7JrbX7oo2CbWHnfK
	 xttIEvvgsL04zZNpT2nDWSQzAdo7bApJ/0MUrPUzjqA3dgQHMEZ0M5Uq/Zx/zpBvCf
	 4sfHkRnUpba7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Mirsad Todorovac <mtodorovac69@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	daniel.sneddon@linux.intel.com,
	jpoimboe@kernel.org,
	brgerst@gmail.com,
	pawan.kumar.gupta@linux.intel.com
Subject: [PATCH AUTOSEL 6.11 110/244] x86/syscall: Avoid memcpy() for ia32 syscall_get_arguments()
Date: Wed, 25 Sep 2024 07:25:31 -0400
Message-ID: <20240925113641.1297102-110-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

[ Upstream commit d19d638b1e6cf746263ef60b7d0dee0204d8216a ]

Modern (fortified) memcpy() prefers to avoid writing (or reading) beyond
the end of the addressed destination (or source) struct member:

In function ‘fortify_memcpy_chk’,
    inlined from ‘syscall_get_arguments’ at ./arch/x86/include/asm/syscall.h:85:2,
    inlined from ‘populate_seccomp_data’ at kernel/seccomp.c:258:2,
    inlined from ‘__seccomp_filter’ at kernel/seccomp.c:1231:3:
./include/linux/fortify-string.h:580:25: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
  580 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As already done for x86_64 and compat mode, do not use memcpy() to
extract syscall arguments from struct pt_regs but rather just perform
direct assignments. Binary output differences are negligible, and actually
ends up using less stack space:

-       sub    $0x84,%esp
+       sub    $0x6c,%esp

and less text size:

   text    data     bss     dec     hex filename
  10794     252       0   11046    2b26 gcc-32b/kernel/seccomp.o.stock
  10714     252       0   10966    2ad6 gcc-32b/kernel/seccomp.o.after

Closes: https://lore.kernel.org/lkml/9b69fb14-df89-4677-9c82-056ea9e706f5@gmail.com/
Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Mirsad Todorovac <mtodorovac69@gmail.com>
Link: https://lore.kernel.org/all/20240708202202.work.477-kees%40kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/syscall.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 2fc7bc3863ff6..7c488ff0c7641 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -82,7 +82,12 @@ static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
 					 unsigned long *args)
 {
-	memcpy(args, &regs->bx, 6 * sizeof(args[0]));
+	args[0] = regs->bx;
+	args[1] = regs->cx;
+	args[2] = regs->dx;
+	args[3] = regs->si;
+	args[4] = regs->di;
+	args[5] = regs->bp;
 }
 
 static inline int syscall_get_arch(struct task_struct *task)
-- 
2.43.0


