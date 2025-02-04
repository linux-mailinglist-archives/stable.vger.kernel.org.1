Return-Path: <stable+bounces-112256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D59AA27E5A
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 23:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61AD31885400
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 22:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C326121C19C;
	Tue,  4 Feb 2025 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b="IE7TfzeI"
X-Original-To: stable@vger.kernel.org
Received: from minute.unseen.parts (minute.unseen.parts [139.162.151.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50B4219A8E;
	Tue,  4 Feb 2025 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.151.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738708549; cv=none; b=dqJj9JndXYMlQR+brNNUr/6DOEuodYLy+1A646a6suhEPCUImynRDiuK3hdopEl0CbaF0DOOFRqMyd0P3ak695IKnftLWkmH+wGkI9oiT/p7Vfka+VCQVxcB3enm7IL9L9PCiFaW9JltPpwfxaVQub2cZdmlMWYkcgxb7TyqN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738708549; c=relaxed/simple;
	bh=3n8nMv5elRq84ySLHI9crqBdDM0DArlZUQPhIjOh60I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AdApccILh6G5Fmr8kZ1x+oTVyJEml4gmzv1gP/LwuS/LjBsySZDtxxHlCSCEf2UNcARjB7b5ruD3v3dKdYEoZbWJ6Bkydu45ldmrCskUB6kTQ3pbt3AjT+vmgV/vpRf85YkMX4QOEyCzYoBPM0HtxR/DaJ8jndnE8W305oqpwBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts; spf=pass smtp.mailfrom=unseen.parts; dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b=IE7TfzeI; arc=none smtp.client-ip=139.162.151.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unseen.parts
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=unseen.parts; s=sig; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hzkENabP7blyPPtr+aCJDt1hMksV24wuwIhX0BcT+Ac=; b=IE7TfzeIq+lGp5rc/dO93m8C+/
	ROcXdyygaU0JUV6gFi/51QFnTj0A1BuBPScNa7H8XVRS7SqN1YBks93Nu+NhO0A9CTyRL8r0XgYhj
	vXGE9MUUpKx8nsF1UM8Mj2Qa80LSqmUy/4CSLUbEUmhhuNBUJeTwLjb887qjickaDULzCaMkwNO3U
	zDsxrpj6Wje8gbqtJbq8Yp4NCoK5uu1vH0HoPMtkTpij2yzct1dTV5v0cOjX04rBuz7ENJp8MmwVP
	Gz7x0hmTicOL70MZln5tz539ifzY7eOEjPcKzxiG6ZXw0SFFoeQsQGR21wb4IpGnKo/4vKHYH2vF/
	F0k8CnHg==;
Received: from ink by minute.unseen.parts with local (Exim 4.96)
	(envelope-from <ink@unseen.parts>)
	id 1tfRVs-0001cO-1g;
	Tue, 04 Feb 2025 23:35:24 +0100
From: Ivan Kokshaysky <ink@unseen.parts>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Magnus Lindholm <linmag7@gmail.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] alpha: make stack 16-byte aligned (most cases)
Date: Tue,  4 Feb 2025 23:35:23 +0100
Message-Id: <20250204223524.6207-3-ink@unseen.parts>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250204223524.6207-1-ink@unseen.parts>
References: <20250204223524.6207-1-ink@unseen.parts>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Reviewed-by: Maciej W. Rozycki <macro@orcam.me.uk>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Ivan Kokshaysky <ink@unseen.parts>
---
 arch/alpha/include/uapi/asm/ptrace.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/ptrace.h b/arch/alpha/include/uapi/asm/ptrace.h
index 5ca45934fcbb..72ed913a910f 100644
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
-- 
2.47.2


