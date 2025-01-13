Return-Path: <stable+bounces-108370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BF4A0B06E
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 09:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12A6166440
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 08:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA83233127;
	Mon, 13 Jan 2025 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XKa2qrvT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mwWri7Ln"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637483C1F
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736755209; cv=none; b=Riujc/PYo1SZ5E/BTKBMbezCUOn5+5S9sRARC/qdZL2DhbkzTCwP00kUArdV+h49f9Pr62/qBHDbSFYTZQ6p2uAW4Ft4drKzWx1c5KvUXO6uL8cwAOza7gcqrApZViir28vnrLRQOos76V/D5C6ly6wkexaezemwckJz7VazvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736755209; c=relaxed/simple;
	bh=3vOUx3V7yCxjPN7WEDz0RIXRr3fkHwLxBhlt1P3EWDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qY9/IqLiI0sSDT+9XVVqcHhA2MDvaVN5SWDXxP5rc2jmjK0ihiLYEGToeqUT8vC31E/IXETSrVYKf6slPEM0Z/Pn3VRopa+JLnKT67bn+TezfEExGaflP7UVJMGhjK5Tgut9OJ8NuzlO0kH4Uh7CW8n2tLQSaFvSmBQ3yyurWc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XKa2qrvT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mwWri7Ln; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736755204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+SU//DJALOeLgp+94B9R+pSYVYbx1XFXFGYVNbXy/M=;
	b=XKa2qrvTb+/M5XaAZqtovsJHqGSk/f1Wb1R1v9JyjHrK4B0hYTaoYmALbcRsT/vG5Z7v+Y
	dUyK1PD+wErX0x3dEt76au0Twn1qE8/osUmXlYMwEqpBGn4U4RGPSRx3RvmWXEXwlpiR/E
	d0uumGAyLDpFpPQMoV/exgnycA4mf2agASmdlm/F+kkWDiLJ35c3JM11FAdPge20XV0YLu
	nKvC9NMOtIBJqLS81hC7/V/mtKXW9/KJvjUaGNRHJn81BKpcAeceRCsTCUbKQM2OhIb1Gm
	Ar+HcZu6ohczc/OeP/l5PUPLoW8m3tAd3KrwW7CG4khSx67A4j8/JNtwu4wdfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736755204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+SU//DJALOeLgp+94B9R+pSYVYbx1XFXFGYVNbXy/M=;
	b=mwWri7LnKLZeSz03sVWY436UvAHVRtPeULceoWEBePKZj+XE7/c9HxxHzCd7gS4QyyHl6q
	SgupyzfmE0ObAeCA==
To: stable@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.6.y] riscv: kprobes: Fix incorrect address calculation
Date: Mon, 13 Jan 2025 08:59:55 +0100
Message-Id: <20250113075955.675949-1-namcao@linutronix.de>
In-Reply-To: <2025011231-bakery-sterling-1f23@gregkh>
References: <2025011231-bakery-sterling-1f23@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

commit 13134cc949148e1dfa540a0fe5dc73569bc62155 upstream.

p->ainsn.api.insn is a pointer to u32, therefore arithmetic operations are
multiplied by four. This is clearly undesirable for this case.

Cast it to (void *) first before any calculation.

Below is a sample before/after. The dumped memory is two kprobe slots, the
first slot has

  - c.addiw a0, 0x1c (0x7125)
  - ebreak           (0x00100073)

and the second slot has:

  - c.addiw a0, -4   (0x7135)
  - ebreak           (0x00100073)

Before this patch:

(gdb) x/16xh 0xff20000000135000
0xff20000000135000:	0x7125	0x0000	0x0000	0x0000	0x7135	0x0010	0x0000	0x0000
0xff20000000135010:	0x0073	0x0010	0x0000	0x0000	0x0000	0x0000	0x0000	0x0000

After this patch:

(gdb) x/16xh 0xff20000000125000
0xff20000000125000:	0x7125	0x0073	0x0010	0x0000	0x7135	0x0073	0x0010	0x0000
0xff20000000125010:	0x0000	0x0000	0x0000	0x0000	0x0000	0x0000	0x0000	0x0000

Fixes: b1756750a397 ("riscv: kprobes: Use patch_text_nosync() for insn slot=
s")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20241119111056.2554419-1-namcao@linutronix.=
de
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
[rebase to v6.6]
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/riscv/kernel/probes/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/=
kprobes.c
index fecbbcf40ac3..4fbc70e823f0 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -29,7 +29,7 @@ static void __kprobes arch_prepare_ss_slot(struct kprobe =
*p)
 	p->ainsn.api.restore =3D (unsigned long)p->addr + offset;
=20
 	patch_text_nosync(p->ainsn.api.insn, &p->opcode, 1);
-	patch_text_nosync(p->ainsn.api.insn + offset, &insn, 1);
+	patch_text_nosync((void *)p->ainsn.api.insn + offset, &insn, 1);
 }
=20
 static void __kprobes arch_prepare_simulate(struct kprobe *p)
--=20
2.39.5


