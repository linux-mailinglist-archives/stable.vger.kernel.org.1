Return-Path: <stable+bounces-112254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8818A27E54
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 23:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2BF63A5A3F
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 22:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A0221B91F;
	Tue,  4 Feb 2025 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b="n/w14soR"
X-Original-To: stable@vger.kernel.org
Received: from minute.unseen.parts (minute.unseen.parts [139.162.151.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AE12163BA;
	Tue,  4 Feb 2025 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.151.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738708548; cv=none; b=dmoDvNKsOZtiX8RMrd6BsEcAYfFM2dMX9ksbHdCnBsSFKzQWuTVu+crD6hGRBR7/bY/WTbGM2dKzOoEIwoZZQq4ZauA2YH9BSOD8K2LDZRJigW2/nP12A8hSmH16mXGUAEITfGNjbMoimGN2zrbZqH+yqL37N7jnhnG1R0Rtd3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738708548; c=relaxed/simple;
	bh=ENohXiMoG6J67UfAWY/pbJxgusEggTfD0/yv1wiqIps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cm8NOQi369pzvppGg0Pn8L3Z0+5zcEnEE1idGu25r0E3ryK3fsB8ZyI5Y8QT8Cny28x21F5VqpGaH+OD/YcLikSxrHhKaBYKFunRBVZuOvwHhaulll97EY1w9+iOUCNpw121qMgtIAJqfLZuj2S+XEZ7tQoMhsGTXUSisMZCtXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts; spf=pass smtp.mailfrom=unseen.parts; dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b=n/w14soR; arc=none smtp.client-ip=139.162.151.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unseen.parts
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=unseen.parts; s=sig; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bwrfKNDJU5sKU0Sm5a58jIBrW0E/LkYTnQP8GVVLfcQ=; b=n/w14soRtVHimHYm45UttRdCBG
	9MKRWgQv/8Sp1SFMtiD4e5SUWYScRRi7nh1ypwjZRJ7VBejM+tbuK48mLb9S0eeVC0/zEJztk+mhZ
	O7U808+9EfnYXXib4hqLw1ZiNx6TAFMFT+NPYrgAY84iM2twcPxL+E6er76Dtl9IEaOmOwwjAzJpZ
	7znQR1PF5HsNBs0+L0xZqII4d+pfBQWU06KbJcA9tVJrizY31sWx/V+2IS4sbOtTKmgPvDOjXFHj6
	oBLcIURafRQOkimh6zL7a8HKMf8Hix4KLSiNSaxdbSHsRdKYnuJBQ4T4xR//flS9pQYUmIV+fKoDn
	7yy1B54g==;
Received: from ink by minute.unseen.parts with local (Exim 4.96)
	(envelope-from <ink@unseen.parts>)
	id 1tfRVs-0001cF-1F;
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
Subject: [PATCH v3 0/3] alpha: stack fixes
Date: Tue,  4 Feb 2025 23:35:21 +0100
Message-Id: <20250204223524.6207-1-ink@unseen.parts>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes oopses on Alpha/SMP observed since kernel v6.9. [1]
Thanks to Magnus Lindholm for identifying that remarkably longstanding
bug.

The problem is that GCC expects 16-byte alignment of the incoming stack
since early 2004, as Maciej found out [2]:
  Having actually dug speculatively I can see that the psABI was changed in
 GCC 3.5 with commit e5e10fb4a350 ("re PR target/14539 (128-bit long double
 improperly aligned)") back in Mar 2004, when the stack pointer alignment
 was increased from 8 bytes to 16 bytes, and arch/alpha/kernel/entry.S has
 various suspicious stack pointer adjustments, starting with SP_OFF which
 is not a whole multiple of 16.

Also, as Magnus noted, "ALPHA Calling Standard" [3] required the same:
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

Patche 1 is preparatory; 2 - the main fix; 3 - fixes remaining
special cases.

Ivan.

[1] https://lore.kernel.org/rcu/CA+=Fv5R9NG+1SHU9QV9hjmavycHKpnNyerQ=Ei90G98ukRcRJA@mail.gmail.com/#r
[2] https://lore.kernel.org/rcu/alpine.DEB.2.21.2501130248010.18889@angie.orcam.me.uk/
[3] https://bitsavers.org/pdf/dec/alpha/Alpha_Calling_Standard_Rev_2.0_19900427.pdf
---
Changes in v2:
- patch #1: provide empty 'struct pt_regs' to fix compile failure in libbpf,
  reported by John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>;
  update comment and commit message accordingly;
- cc'ed <stable@vger.kernel.org> as older kernels ought to be fixed as well.

Changes in v3:
- patch #1 dropped for the time being;
- updated commit messages as Maciej suggested.
---
Ivan Kokshaysky (3):
  alpha: replace hardcoded stack offsets with autogenerated ones
  alpha: make stack 16-byte aligned (most cases)
  alpha: align stack for page fault and user unaligned trap handlers

 arch/alpha/include/uapi/asm/ptrace.h |  2 ++
 arch/alpha/kernel/asm-offsets.c      |  4 ++++
 arch/alpha/kernel/entry.S            | 24 ++++++++++--------------
 arch/alpha/kernel/traps.c            |  2 +-
 arch/alpha/mm/fault.c                |  4 ++--
 5 files changed, 19 insertions(+), 17 deletions(-)

-- 
2.47.2


