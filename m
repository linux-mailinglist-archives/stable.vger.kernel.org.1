Return-Path: <stable+bounces-155121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D589AE19A2
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 13:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 678877ABCE7
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EC6289E3F;
	Fri, 20 Jun 2025 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oGePHy8n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gItVlmop"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17D0289370;
	Fri, 20 Jun 2025 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417796; cv=none; b=Ksef0RDxpm9W5ru+anGkiAC1PWAilI18Ngx+zeWbrr1RYuaLCl7PyIo7SAbvO7za/LRUgtYfJ8teeHVIN9V3VuApD4/8nhjSqwlWgPXd9EGVhUInXGfSQlMLgAUwrHE77iiJ+e/oUoG6daK3dHayi/HFdobvHY/3ptLvVjBhyE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417796; c=relaxed/simple;
	bh=IBZkMlagCA+R/KhShpO9+UpMtZRbm3VwQ3iZSH+Pgqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ta1QWAewPeNr9GzaG2vrEq2H4GxH37dZh5zgU7iduKSu27luTYg6kYxzRAUKilZRHUQyUUSvCj1D9xhXqXP2EoK9q/jHx3aHWM49Hm3JjN9mxooKZJpdrx/FDW42onmAffVEZ/wvtHMfobYj9KeeKq4BfM5ytEr3ciZRYGcettI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oGePHy8n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gItVlmop; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750417791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PWqArSOAfTC1L3Ga/GRvc43T5ZdN4RWui3vJm5T69f0=;
	b=oGePHy8ntSocBb8MmX7vxwMR9AqGRAPw0yxsBBrcSfEeaK1J4g5eQEg9+8zn5QV19p9F8C
	rdJhUnL5TuKHtOxM40vvqSPPbyagDXffZmP0GSTQx67YmcZnIfjvc+e1KpBrJpFLw2wli+
	RbCV1BHNjfw+sxnUEdRsHk6gXGklaJi618XzRu7HGUadmZoOz4ZhqskAeinurLKFH61F9B
	mu/okgLunmYf7hJEclF8rUZzxq6Lwlc/72jc8YUsS7J8JxYPiOqLPn/jSjQ0jnGUpI5Pfo
	qCUg51IxvxsWrB/p682AUP/BT0odvO3FucyXsKFZD/piun7nnbslBgJhxVtFFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750417791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PWqArSOAfTC1L3Ga/GRvc43T5ZdN4RWui3vJm5T69f0=;
	b=gItVlmoprKsgxq+suCSmg/zOUer9qJQuKwHSqxDJwzd5/0p34r50fGnn5RHBtznem2B6fK
	pQY35dFXapMQoiCg==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Nylon Chen <nylon.chen@sifive.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "riscv: misaligned: fix sleeping function called during misaligned access handling"
Date: Fri, 20 Jun 2025 13:09:39 +0200
Message-Id: <20250620110939.1642735-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This reverts commit 61a74ad25462 ("riscv: misaligned: fix sleeping function
called during misaligned access handling"). The commit addresses a sleeping
in atomic context problem, but it is not the correct fix as explained by
Cl=C3=A9ment:

"Using nofault would lead to failure to read from user memory that is paged
out for instance. This is not really acceptable, we should handle user
misaligned access even at an address that would generate a page fault."

This bug has been properly fixed by commit 453805f0a28f ("riscv:
misaligned: enable IRQs while handling misaligned accesses").

Revert this improper fix.

Link: https://lore.kernel.org/linux-riscv/b779beed-e44e-4a5e-9551-4647682b0=
d21@rivosinc.com/
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
---
 arch/riscv/kernel/traps_misaligned.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps=
_misaligned.c
index dd8e4af6583f4..93043924fe6c6 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -454,7 +454,7 @@ static int handle_scalar_misaligned_load(struct pt_regs=
 *regs)
=20
 	val.data_u64 =3D 0;
 	if (user_mode(regs)) {
-		if (copy_from_user_nofault(&val, (u8 __user *)addr, len))
+		if (copy_from_user(&val, (u8 __user *)addr, len))
 			return -1;
 	} else {
 		memcpy(&val, (u8 *)addr, len);
@@ -555,7 +555,7 @@ static int handle_scalar_misaligned_store(struct pt_reg=
s *regs)
 		return -EOPNOTSUPP;
=20
 	if (user_mode(regs)) {
-		if (copy_to_user_nofault((u8 __user *)addr, &val, len))
+		if (copy_to_user((u8 __user *)addr, &val, len))
 			return -1;
 	} else {
 		memcpy((u8 *)addr, &val, len);
--=20
2.39.5


