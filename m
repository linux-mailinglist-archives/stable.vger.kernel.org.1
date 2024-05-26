Return-Path: <stable+bounces-46253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FF68CF3F8
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 13:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB8F1F21C5C
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 11:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6480B664;
	Sun, 26 May 2024 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cJ+z3s7n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9E6rWNlr"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916D479C0;
	Sun, 26 May 2024 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716721283; cv=none; b=CqSGeFWf3HjTkUQOYo079J62clzJuUZT+xFUo/Dsa7BgEnlC0iV63VU0dXv51ZoOLJr/2bbZ9EV7077CE/P/J90lXx6Gy7mRCvjBNbBm2W93tYIvBfJf8b1yawFY1OCXPauMY4CenH1AKafBlclnf6cNpMYb8gZgOEIC0bdcAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716721283; c=relaxed/simple;
	bh=6e+h3k3AZ4xi2cYwU9pOafFSVaC00lSZkE0jcbqcV3s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IRc8xwANe7fLQA0EtQKm37x6PBe6jNsIHphSZOpaWRw9+/ZMqHae61g9s1z4xsiPk8Zt0fBMsJVgQmqTHjmkK+shQg4aw0IATXSEBItMIxZkqswqCbFx5UKUoos4OSwHgZmsKgjI+8LziFV3hWaGTsxaI+q5pa49wvZgYBXFh6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cJ+z3s7n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9E6rWNlr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716721274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t2Uz48YRsUOXeGZ9DVsANdtln0IbDr3I+aFSlZRM3WI=;
	b=cJ+z3s7nk0Gp7f9D4DJzEQ/CuZwEJLOxzlVVbBIkA2z/NXZpKArFHcQqGF50fczr1iPJlp
	gT6hOT56hnY4ui78+Pwa9Sp2Dx+brf4ii0v0Evv3QFke+pvS0MaXaI/WgDiqi+WWIXclfP
	7rRkWQwKuy4u7Vwrik4nrKEF4FxiGL1dRM4wuLSjUDrisUUt/gDbPia9iErLESPSK8MdPr
	rx0fZmY+DQxZjDwIzoTNBAnCtv31ssmh2El/j1pIqyNrVnULVGymlLgIC9uahERdM0YBZO
	nfvFyCQ0M0Xo7uBZsZIL89FTBg57DtwG935Uq5gzbZxLSj/QoI8dBRFAZLOMzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716721274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t2Uz48YRsUOXeGZ9DVsANdtln0IbDr3I+aFSlZRM3WI=;
	b=9E6rWNlr93vWj3BRUMTK3cmikVL1VaaaPC9QIWtLSafLmmoHGrMk5F4SfqY7UVXXIfWpWY
	Bm8URRST7vSd3SDg==
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH] riscv: enable HAVE_ARCH_HUGE_VMAP for XIP kernel
Date: Sun, 26 May 2024 13:01:04 +0200
Message-Id: <20240526110104.470429-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HAVE_ARCH_HUGE_VMAP also works on XIP kernel, so remove its dependency on
!XIP_KERNEL.

This also fixes a boot problem for XIP kernel introduced by the commit in
"Fixes:". This commit used huge page mapping for vmemmap, but huge page
vmap was not enabled for XIP kernel.

Fixes: ff172d4818ad ("riscv: Use hugepage mappings for vmemmap")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: <stable@vger.kernel.org>
---
This patch replaces:
https://patchwork.kernel.org/project/linux-riscv/patch/20240508173116.2866192-1-namcao@linutronix.de/

 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b94176e25be1..0525ee2d63c7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -106,7 +106,7 @@ config RISCV
 	select HAS_IOPORT if MMU
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMALLOC if HAVE_ARCH_HUGE_VMAP
-	select HAVE_ARCH_HUGE_VMAP if MMU && 64BIT && !XIP_KERNEL
+	select HAVE_ARCH_HUGE_VMAP if MMU && 64BIT
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
 	select HAVE_ARCH_KASAN if MMU && 64BIT
-- 
2.39.2


