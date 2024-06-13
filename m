Return-Path: <stable+bounces-51572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB5C907086
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31161C22CDF
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F2D143892;
	Thu, 13 Jun 2024 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1/kPFgtx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AA81428F0;
	Thu, 13 Jun 2024 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281689; cv=none; b=XDZPf0QssIgB2Lp5737R7cedUCgstJj0TpVCg+yHyNNCDNfhs442ItFEB3CPva01iBNliGcYrqvXZoy1jjStN+xVkofMDoLYw11bEMHbOBxttDYCSdddhCAjxjo+YOjWnpoA6RGcrol5JLQZahHMophxAlLyV1jhUROLvZR8m5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281689; c=relaxed/simple;
	bh=OijFAhR9zFOD/62x0jyuyQWTB3C/dUndg+PhQfPEsxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISmKyG2hsPJSXUAg/cDbzZndJ9eetxX97oCL485tcSYnEBWOuF4TY7XXbpLpCTKV9Dpr2Xi/mFO+4us5JMbc20QzewTdOqq3ALN0qvXGYwfccQ5VkdwmpNqTVuBc2V2usaLaME/XQhpUxY2aBlP0IEkGyD3iGAA6vT0dtrSCmns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1/kPFgtx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02659C2BBFC;
	Thu, 13 Jun 2024 12:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281689;
	bh=OijFAhR9zFOD/62x0jyuyQWTB3C/dUndg+PhQfPEsxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1/kPFgtxDjX3XgoqnzCW1L6w3M4Dqbu4SY0rB1vA9ve/1rpWfudE0CG465u/J24no
	 oJ+RzV8xrMnaak90p6Sq24dJ6ic+y3t46vJhLOdkbAzePtcjXI3Tl6gw4VQCrkbq4E
	 g3MCaExmPLJ3GN/PUNocjE/sdMjPWE5Qaw64CRhM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 023/402] selftests: sud_test: return correct emulated syscall value on RISC-V
Date: Thu, 13 Jun 2024 13:29:40 +0200
Message-ID: <20240613113303.045474969@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Clément Léger <cleger@rivosinc.com>

[ Upstream commit 17c67ed752d6a456602b3dbb25c5ae4d3de5deab ]

Currently, the sud_test expects the emulated syscall to return the
emulated syscall number. This assumption only works on architectures
were the syscall calling convention use the same register for syscall
number/syscall return value. This is not the case for RISC-V and thus
the return value must be also emulated using the provided ucontext.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/r/20231206134438.473166-1-cleger@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/syscall_user_dispatch/sud_test.c     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index b5d592d4099e8..d975a67673299 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -158,6 +158,20 @@ static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
 
 	/* In preparation for sigreturn. */
 	SYSCALL_DISPATCH_OFF(glob_sel);
+
+	/*
+	 * The tests for argument handling assume that `syscall(x) == x`. This
+	 * is a NOP on x86 because the syscall number is passed in %rax, which
+	 * happens to also be the function ABI return register.  Other
+	 * architectures may need to swizzle the arguments around.
+	 */
+#if defined(__riscv)
+/* REG_A7 is not defined in libc headers */
+# define REG_A7 (REG_A0 + 7)
+
+	((ucontext_t *)ucontext)->uc_mcontext.__gregs[REG_A0] =
+			((ucontext_t *)ucontext)->uc_mcontext.__gregs[REG_A7];
+#endif
 }
 
 TEST(dispatch_and_return)
-- 
2.43.0




