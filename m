Return-Path: <stable+bounces-137118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D63AA1166
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62C83B3B54
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDB524291A;
	Tue, 29 Apr 2025 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aJVgesED";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lec00RY2"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629EF220685;
	Tue, 29 Apr 2025 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745943274; cv=none; b=jRk300Rxt0+a3MXqTp9c2ig94xuJ1oJXGA4tRCmkO7xuEsM5N3KlbilHuuKnj1Hj8UGOZwVnISUW28/Iw2v+Q1DRtxBTSfyctF4SsmfOOD9DVEBLqLtXopZgyaRoGTq05OC8Ai7E9I5FlxHF1Wfjbc2/nMmKCJlHNAZefS1LL4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745943274; c=relaxed/simple;
	bh=nmOVK/5oP2W84z1GhxIGMZxAc9Q7DJzziD3/msDKFJw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CPefV7vighgptLyEuzu70nvsiqfe84UmGR0SDVwVBjHzF1sOlbcTULoTvsm7zS3X0+kbM1qY/coD+oN8/kJVVbaQTrFnCIDtG1toUA4IHbWlCVn9vkzpT+6MNQhRqUTK4ZNggkVJ5mHNxxNS6bp5qnJt0CqRt3lu4FoSDQve3/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aJVgesED; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lec00RY2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745943268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qfL69VYEddMdBXsaXEyqXWeD+E6YG/rOeJLtsomd1uc=;
	b=aJVgesEDYo+Wr3Ayn7ihOQ3s194qDIi4yeVcaO8nUIYjoOK+4qu1BRRB20IxXvF0t3M6zr
	p/MUKqyNPcwVSjXploZCfOzJ/PIOjJrmo2M1eNLOTEEW+im0LrMV6XChBlxz3qCHWBLqcN
	L8OWoRUoN/3T2O4n94bpW5oNnKXVzulzJeal+u+z5Kl0sOZZYHOgvPnIeoSiR7Y0iDjIDf
	sbQmcAcGDjCrjMiEYKinjBU9ZlD5jupKYGbG4b9Sw4Y5tBr3tDHYjF0lMd4R6MuQzUkZ2w
	qpcRVAT3WoozOvgrU3nMzzWNJXrT9GqyOvim1T1+tdfD43+zk1um7+gfWh6pxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745943268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qfL69VYEddMdBXsaXEyqXWeD+E6YG/rOeJLtsomd1uc=;
	b=Lec00RY2NYzaBrbxa4Kahhmevdr2Ln760zQu6wLFShDGlR0rXTDIplE3tOUEQEsZ1geURU
	FZo2MPZUa8oJQ7Dg==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Kai Zhang <zhangkai@iscas.ac.cn>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH stable v6.6] riscv: kprobes: Fix wrong lengths passed to patch_text_nosync()
Date: Tue, 29 Apr 2025 18:14:18 +0200
Message-Id: <20250429161418.838564-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Unlike patch_text(), patch_text_nosync() takes the length in bytes, not
number of instructions. It is therefore wrong for arch_prepare_ss_slot() to
pass length=3D1 while patching one instruction.

This bug was introduced by commit b1756750a397 ("riscv: kprobes: Use
patch_text_nosync() for insn slots"). It has been fixed upstream by commit
51781ce8f448 ("riscv: Pass patch_text() the length in bytes"). However,
beside fixing this bug, this commit does many other things, making it
unsuitable for backporting.

Fix it by properly passing the lengths in bytes.

Fixes: b1756750a397 ("riscv: kprobes: Use patch_text_nosync() for insn slot=
s")
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/riscv/kernel/probes/kprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/=
kprobes.c
index 4fbc70e823f0..dc431b965bc3 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -28,8 +28,8 @@ static void __kprobes arch_prepare_ss_slot(struct kprobe =
*p)
=20
 	p->ainsn.api.restore =3D (unsigned long)p->addr + offset;
=20
-	patch_text_nosync(p->ainsn.api.insn, &p->opcode, 1);
-	patch_text_nosync((void *)p->ainsn.api.insn + offset, &insn, 1);
+	patch_text_nosync(p->ainsn.api.insn, &p->opcode, offset);
+	patch_text_nosync((void *)p->ainsn.api.insn + offset, &insn, sizeof(insn)=
);
 }
=20
 static void __kprobes arch_prepare_simulate(struct kprobe *p)
--=20
2.39.5


