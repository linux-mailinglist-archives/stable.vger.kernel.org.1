Return-Path: <stable+bounces-154818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D0EAE0AEB
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 17:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF3B189FDEE
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 15:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE3A27E7D9;
	Thu, 19 Jun 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zWgFbHt6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t7gTRwGL"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0B51F0992;
	Thu, 19 Jun 2025 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750348749; cv=none; b=Mi9er9JYIcaqqpb20pFofoU1q8xPw0VcugFX5Z+xkPJqubL8fu4SFGUq8TbJUwTk9efVdKI/u/MeZ6R4JpTw6nercxrAAWoOq3ssDG4KOeW6OrZHkS7YtJgxuXyM4+BADYRd79yM/bnEcw/WNYH0cajKylB6+EgKVca9FdM9uX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750348749; c=relaxed/simple;
	bh=woQZ6vVEELn8x2rED7MrTPUOtcE8fQHWD9x1AI6eNjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bh5bvrhvK7enBU7AaJsy4SwwT9OypVnjfJXZ2cTgVGOoXWn9kcXs71bc+RCZZCMvoViJfuvLfEnHyYv6W+vL916Ce1jUDwVeQRH4lxRdCyPLK42vtpswkSy/lsLt3fy3jJW3YA4CCRvyc9t7MAn4/aRsUrI5DyZ4oB9nmCDOI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zWgFbHt6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t7gTRwGL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750348745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YJRIKqq5GC/lr+opxe5M1YFNp8xB8Hupy6OYrK1o2zw=;
	b=zWgFbHt6aweg/7iDtk6+ko0Z8F5Co4l3dhUabpL6EQHm1wBxMwsF1umOC7dyLWhBkOf9pe
	rNv3Tq69H7PKgM+Mo3sxxPP6KOU5dfxdrlmDLWrET7UQLIcE8pMeBLMfKYOlCJ6IobgoaG
	C3oR4sG1Qyeybf/9FvuO4uxGQKO4bYLSzy3HtX21YKLzj2w1VnNLpJuKHUd3Id1KrRk+cS
	hkNaHdnTfc5ARJJCmYd1oV6eswoqSybukTxr1gx2OL8GcNAtBpwMVZQ3oZX4tQn4BwSU2e
	7tHraqirWytWtIpHPMr2os/7+QF7vZYrs0AkRYeXS2XJ9fGnE0HzRqOiyEXHBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750348745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YJRIKqq5GC/lr+opxe5M1YFNp8xB8Hupy6OYrK1o2zw=;
	b=t7gTRwGLsSMLFoGSgxG9WxTGmlTlrcUy0QLyomzN3PfdAcTmX1a5uMp1yvcX5V51qu14pI
	ogUbCQDvwayDZaDQ==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	rtm@csail.mit.edu,
	stable@vger.kernel.org
Subject: [PATCH] Revert "riscv: Define TASK_SIZE_MAX for __access_ok()"
Date: Thu, 19 Jun 2025 17:58:58 +0200
Message-Id: <20250619155858.1249789-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This reverts commit ad5643cf2f69 ("riscv: Define TASK_SIZE_MAX for
__access_ok()").

This commit changes TASK_SIZE_MAX to be LONG_MAX to optimize access_ok(),
because the previous TASK_SIZE_MAX (default to TASK_SIZE) requires some
computation.

The reasoning was that all user addresses are less than LONG_MAX, and all
kernel addresses are greater than LONG_MAX. Therefore access_ok() can
filter kernel addresses.

Addresses between TASK_SIZE and LONG_MAX are not valid user addresses, but
access_ok() let them pass. That was thought to be okay, because they are
not valid addresses at hardware level.

Unfortunately, one case is missed: get_user_pages_fast() happily accepts
addresses between TASK_SIZE and LONG_MAX. futex(), for instance, uses
get_user_pages_fast(). This causes the problem reported by Robert [1].

Therefore, revert this commit. TASK_SIZE_MAX is changed to the default:
TASK_SIZE.

This unfortunately reduces performance, because TASK_SIZE is more expensive
to compute compared to LONG_MAX. But correctness first, we can think about
optimization later, if required.

Reported-by: <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/linux-riscv/77605.1750245028@localhost/
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
---
 arch/riscv/include/asm/pgtable.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgta=
ble.h
index 438ce7df24c39..5bd5aae60d536 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -1075,7 +1075,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
  */
 #ifdef CONFIG_64BIT
 #define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
-#define TASK_SIZE_MAX	LONG_MAX
=20
 #ifdef CONFIG_COMPAT
 #define TASK_SIZE_32	(_AC(0x80000000, UL) - PAGE_SIZE)
--=20
2.39.5


