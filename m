Return-Path: <stable+bounces-117123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F08A3B4DB
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492F23B664B
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD3E1F17E5;
	Wed, 19 Feb 2025 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jsY6RSQg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DA51EA7D6;
	Wed, 19 Feb 2025 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954278; cv=none; b=Ic8fVWYyDnu1kRIPWyaGY6j4uc2IqA3owyzXDqnFt66CwY/0AWiPVzeUAmlTnGKwxXm4bYLzY/s0xgtKUo9r0jh2tnxsQIsD3ZBUQ8XM6L/XaPqK5e5Hp1dvWXfqkQ0eXAsTlu0RKodSwjVd9yZjQxQAHdtEK3QfcbYPgMHKBDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954278; c=relaxed/simple;
	bh=kt/JOEDfbmdPqKxrk8KuaOalrJb0phuylFa6tmra3MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUJYUkdqoAnaA7XE5LHqe9ZWEdHmYmZDxd7v7XZiouC5f9rpUV3Q3uP9adg3odVdkFmEbVAa3Nbx+tpRhY1j2Y+9DvrmByFmNG1bTkqW1paE69LXcvXvbX2n047+5Q/kUI4c3tZYysU7YgG+Du0EbW39hHgLPRLhG7Fc+SAeLY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jsY6RSQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093B7C4CED1;
	Wed, 19 Feb 2025 08:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739954278;
	bh=kt/JOEDfbmdPqKxrk8KuaOalrJb0phuylFa6tmra3MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jsY6RSQgC8UomsFWXJQA8IT4VyYu38WJtFqFJPHBMw1fkGwACOtefU0L7cDA0PfVx
	 6fMgavDw9buXt4YcW3yKgnFwUlaiSoiaOMH1nG8NeO9Me5cAkYWB9+/SCqH7GDpZZK
	 9kCCfBWwZVgfg85ya3h5NVmoAz3VxqJ0DOqe3wJw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Ivan Kokshaysky <ink@unseen.parts>
Subject: [PATCH 6.13 154/274] alpha: make stack 16-byte aligned (most cases)
Date: Wed, 19 Feb 2025 09:26:48 +0100
Message-ID: <20250219082615.624931858@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082609.533585153@linuxfoundation.org>
References: <20250219082609.533585153@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Kokshaysky <ink@unseen.parts>

commit 0a0f7362b0367634a2d5cb7c96226afc116f19c9 upstream.

The problem is that GCC expects 16-byte alignment of the incoming stack
since early 2004, as Maciej found out [1]:
  Having actually dug speculatively I can see that the psABI was changed in
 GCC 3.5 with commit e5e10fb4a350 ("re PR target/14539 (128-bit long double
 improperly aligned)") back in Mar 2004, when the stack pointer alignment
 was increased from 8 bytes to 16 bytes, and arch/alpha/kernel/entry.S has
 various suspicious stack pointer adjustments, starting with SP_OFF which
 is not a whole multiple of 16.

Also, as Magnus noted, "ALPHA Calling Standard" [2] required the same:
 D.3.1 Stack Alignment
  This standard requires that stacks be octaword aligned at the time a
  new procedure is invoked.

However:
- the "normal" kernel stack is always misaligned by 8 bytes, thanks to
  the odd number of 64-bit words in 'struct pt_regs', which is the very
  first thing pushed onto the kernel thread stack;
- syscall, fault, interrupt etc. handlers may, or may not, receive aligned
  stack depending on numerous factors.

Somehow we got away with it until recently, when we ended up with
a stack corruption in kernel/smp.c:smp_call_function_single() due to
its use of 32-byte aligned local data and the compiler doing clever
things allocating it on the stack.

This adds padding between the PAL-saved and kernel-saved registers
so that 'struct pt_regs' have an even number of 64-bit words.
This makes the stack properly aligned for most of the kernel
code, except two handlers which need special threatment.

Note: struct pt_regs doesn't belong in uapi/asm; this should be fixed,
but let's put this off until later.

Link: https://lore.kernel.org/rcu/alpine.DEB.2.21.2501130248010.18889@angie.orcam.me.uk/ [1]
Link: https://bitsavers.org/pdf/dec/alpha/Alpha_Calling_Standard_Rev_2.0_19900427.pdf [2]

Cc: stable@vger.kernel.org
Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Ivan Kokshaysky <ink@unseen.parts>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/alpha/include/uapi/asm/ptrace.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/alpha/include/uapi/asm/ptrace.h
+++ b/arch/alpha/include/uapi/asm/ptrace.h
@@ -42,6 +42,8 @@ struct pt_regs {
 	unsigned long trap_a0;
 	unsigned long trap_a1;
 	unsigned long trap_a2;
+/* This makes the stack 16-byte aligned as GCC expects */
+	unsigned long __pad0;
 /* These are saved by PAL-code: */
 	unsigned long ps;
 	unsigned long pc;



