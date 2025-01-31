Return-Path: <stable+bounces-111791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86105A23C61
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 11:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6B51616FB
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 10:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7201B415D;
	Fri, 31 Jan 2025 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b="vZKua7aF"
X-Original-To: stable@vger.kernel.org
Received: from minute.unseen.parts (minute.unseen.parts [139.162.151.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345221779B8;
	Fri, 31 Jan 2025 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.151.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738320105; cv=none; b=pmumBA3/0TE35wzieA3hyOXb4SFkempbb61DO0yRwd93yOktoryVNAVwIqhofGFxlIM7pMCsLxHgxeDJDh3lJs1j5fBCjHxrJVGE+7gdf0C+hpuCxoaOimwHRUmoYbJTPlRZG64dsAUrtYrVZKggiQZhBHekLsfRQ7c4EyjJRf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738320105; c=relaxed/simple;
	bh=KVvvmT6srlE5+YlgqATQtQdAp90368UR5QrugMJeqwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WzNQafxxLJdaCT+Shp1FiZ5zwEfdCABnry4TpEsRA/PQRfzBV4gyM7qVldrxAo9g7ecQfyCHfVAWlt+hddSGzc8yGz+2l3tq69/m8BEZOuCq7czZYaYvvwf0V/TFqvuWXXhKFDtWizjRVWFVXBq9uaazk1Aeo4Bo3QW19fy0clk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts; spf=pass smtp.mailfrom=unseen.parts; dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b=vZKua7aF; arc=none smtp.client-ip=139.162.151.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unseen.parts
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=unseen.parts; s=sig; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=z9vWniiq01s0S9UtaVEgmaVgdztvwEOlANaQmWgdsqk=; b=vZKua7aFpP4Wpztv5zzp33XqkV
	3VyT/wpn8D1ni11HzMvqLXhiQaR8TS09dZ9ImtEFi6Z5K2jKWVJAeIdFQ2Fha+nqi0ZoI+M5HtrGw
	j9b2RsUs6dOZ8QgfzCidydm04CIQ0xjXI6hVnD6e9jmLngYinKRWxZR1Z2nui105Fx//RyTeP7Lo2
	jZIUZVDQ8EVb0KcSwpVT6TpybpSQ4gfUDPUjm5sLf7YULjDlk+E8ISquqgAA4tpWOIibSxjf54290
	B00DR8w/YVanjfr9E8oXgP9JvBIw5qcB+rrX3mtye3pTu2PAh80nMDNAh6dApGb1EqBwwb8NzHoRt
	llGQGWhw==;
Received: from ink by minute.unseen.parts with local (Exim 4.96)
	(envelope-from <ink@unseen.parts>)
	id 1tdoSn-0002sO-2b;
	Fri, 31 Jan 2025 11:41:29 +0100
From: Ivan Kokshaysky <ink@unseen.parts>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Magnus Lindholm <linmag7@gmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/4] alpha: stack fixes
Date: Fri, 31 Jan 2025 11:41:25 +0100
Message-Id: <20250131104129.11052-1-ink@unseen.parts>
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

Patches 1-2 are preparatory; 3 - the main fix; 4 - fixes remaining
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
---
Ivan Kokshaysky (4):
  alpha/uapi: do not expose kernel-only stack frame structures
  alpha: replace hardcoded stack offsets with autogenerated ones
  alpha: make stack 16-byte aligned (most cases)
  alpha: align stack for page fault and user unaligned trap handlers

 arch/alpha/include/asm/ptrace.h      | 64 ++++++++++++++++++++++++++-
 arch/alpha/include/uapi/asm/ptrace.h | 65 ++--------------------------
 arch/alpha/kernel/asm-offsets.c      |  4 ++
 arch/alpha/kernel/entry.S            | 24 +++++-----
 arch/alpha/kernel/traps.c            |  2 +-
 arch/alpha/mm/fault.c                |  4 +-
 6 files changed, 83 insertions(+), 80 deletions(-)

-- 
2.39.5


