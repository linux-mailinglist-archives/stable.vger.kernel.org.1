Return-Path: <stable+bounces-77439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F54985D3E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9BD1C24443
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830681DC74F;
	Wed, 25 Sep 2024 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7CeATMS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B641DC749;
	Wed, 25 Sep 2024 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265775; cv=none; b=U5oAYagc/jJTBkOMOEjUlBSWRj2tMQN4mR4yKyeuRo5NXDJhuZZDmyPcLcDBYLc3n3//r6L5hOnnF0fLljVlHbk9LwvUX6jiuq2UNXLsIAWzA7krpVvRQa4e2dnf2tWTVuTv7WCcqj7K2N1qCRVtd75atFlZMIhG9YcpWoq2C3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265775; c=relaxed/simple;
	bh=YFY+3mAanqIL5F/49zuwu1YvcyrnvxDObgM837R9lN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSzyA3cfHR2Ao/5Bn0OlR//w4Zs7U4nx5knDsbcocAE4gabCx2usDK3nbJVkj84yL5Rnx6NhUGtJOUj7piSmpd7HdkZLz/frotOpZQSMf4vmMo8qf9jI3iXj84kMXeK5jcz0gDwXml7pZb2QI2oZos8nNbb2TuOYXxlQTzubdhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7CeATMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E88FC4CEC7;
	Wed, 25 Sep 2024 12:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265775;
	bh=YFY+3mAanqIL5F/49zuwu1YvcyrnvxDObgM837R9lN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I7CeATMSd0/Fpn4VjS42l9BLSN0/eGNf2jXVV2bwXq8izyqfb3vTIvGl6rHwypU2i
	 +KqpYbgDHYY0uHgiYxu23CdiTwD7XjIXXYKHdZceMCb0P8QG8qCc49+zVlnnHTvHGs
	 dLCeXD+1xhA1p2Pajjf6+s+esRdHpkJuyF/TLEst1iw2vZX5bIb060iIrSZwrBhXZz
	 y/P5VjX9xkvVOXYkqI9wSdeJRvkQs4JQWo7I8n+nbdTe5FBwcn26QaGdFLUUvIirJ/
	 BMdiGwrpEF8PlEma+RRRwoWNDT4Bgf3yWbDl3XmllH3ThJkDu9OtXBEh8aQ4Tzon9x
	 uOjJh01hdZWKQ==
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
Subject: [PATCH AUTOSEL 6.10 094/197] x86/syscall: Avoid memcpy() for ia32 syscall_get_arguments()
Date: Wed, 25 Sep 2024 07:51:53 -0400
Message-ID: <20240925115823.1303019-94-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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


