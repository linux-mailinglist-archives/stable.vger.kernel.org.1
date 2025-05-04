Return-Path: <stable+bounces-139560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0322AA85E0
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 12:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F0F18980F2
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 10:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901B819E98A;
	Sun,  4 May 2025 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G0mu5Qtn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WDUKrNAp"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61863597E;
	Sun,  4 May 2025 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746353974; cv=none; b=t7x01Ms8YI0CGhB4qB3Nl4lg1sib4GVk7S5TU/xFdHvOm3TgqSWon6qM0+aQ5cAJ47DcUj83ys6ULIVaOIT00hbaYoMUQa64ZVh0O96Z5op2M8sJX6ErXSuSfCg1lma5uur5adJy+qM1AnT8gS6foKyu6wVfQEEBai/Upb3duws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746353974; c=relaxed/simple;
	bh=/zphhyt/wytwwQ3L2MfF1xGmJccBco5+XhvPcJrJ6Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D2ZAVWy4eRbZoYUZHMD6XhYW5mXID/Ze9o88Zo9qnc8xursqEgctdAM6tGLQ1KLkEigFHQNzD9KrgNXWbaj3zHy1Ix+S/X3+AZCe8bCD4mrPVRgMdkPtkZ++Fz9KNoFGAJV9zYwh7toyfSRGtlIgNwNl77x8NPrgxz92stKAnHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G0mu5Qtn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WDUKrNAp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746353970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jfl7SNXUW9QYMi5IdJsuAK6+WDbLVdSs2AEZKeOH8eo=;
	b=G0mu5QtnRB2C2Jr/mXDF6LW+tpTJ5RyHja/nqS6uGtlSLT43QUkBsbkYd7TcQN+G9wFLgr
	WIK/tu6GTUDjMPizI5qndS8zUro5Mr6xSNpUWlIubE+Dj3Fp0RmulFvuiHkQZsDKsVMLEK
	l+DX19+gay6Fb9NmQfJwG7GhkRM1U0oDdgF966qgc0tQDJFJHulsSISYmbv+fYlacai0tP
	LfYnO5BY/8K3DAxdJDgoSsHrpyJ7DySuCFD6Qz7JyoUdGkpPxKElVCJjXWDwiwoiqUqwGZ
	3yLheynP3GDV+PQsoHMOA7ja2ndz34GJB0nOSZd76QgTIx0zAsnfA6urcHhluw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746353970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jfl7SNXUW9QYMi5IdJsuAK6+WDbLVdSs2AEZKeOH8eo=;
	b=WDUKrNApCeBn1j43PZF1WmP+DXkiGtG31xxSQxqtGVor3nXAXAjSjqxTmtewjBjrjS/WC2
	g+xugQG1ONBsOBDQ==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH] riscv: Fix kernel crash due to PR_SET_TAGGED_ADDR_CTRL
Date: Sun,  4 May 2025 12:19:20 +0200
Message-Id: <20250504101920.3393053-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When userspace does PR_SET_TAGGED_ADDR_CTRL, but Supm extension is not
available, the kernel crashes:

Oops - illegal instruction [#1]
    [snip]
epc : set_tagged_addr_ctrl+0x112/0x15a
 ra : set_tagged_addr_ctrl+0x74/0x15a
epc : ffffffff80011ace ra : ffffffff80011a30 sp : ffffffc60039be10
    [snip]
status: 0000000200000120 badaddr: 0000000010a79073 cause: 0000000000000002
    set_tagged_addr_ctrl+0x112/0x15a
    __riscv_sys_prctl+0x352/0x73c
    do_trap_ecall_u+0x17c/0x20c
    andle_exception+0x150/0x15c

Fix it by checking if Supm is available.

Fixes: 09d6775f503b ("riscv: Add support for userspace pointer masking")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
---
 arch/riscv/kernel/process.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 7c244de77180..3db2c0c07acd 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -275,6 +275,9 @@ long set_tagged_addr_ctrl(struct task_struct *task, uns=
igned long arg)
 	unsigned long pmm;
 	u8 pmlen;
=20
+	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
+		return -EINVAL;
+
 	if (is_compat_thread(ti))
 		return -EINVAL;
=20
--=20
2.39.5


