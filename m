Return-Path: <stable+bounces-106770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B40A01C00
	for <lists+stable@lfdr.de>; Sun,  5 Jan 2025 22:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C0E161A22
	for <lists+stable@lfdr.de>; Sun,  5 Jan 2025 21:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7A11448E3;
	Sun,  5 Jan 2025 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=o2.pl header.i=@o2.pl header.b="BOHsus9s"
X-Original-To: stable@vger.kernel.org
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE9E17543
	for <stable@vger.kernel.org>; Sun,  5 Jan 2025 21:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.222.135.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736112302; cv=none; b=gNLKsu7lfLJM9eP+Nf+pOboumXtvIJmZKgN9I0AG65ihHIrBWJH3vQEbLjn7+lUJu5N62TalsEs0UP3ix+XMU0sXui5c7yaJ60bbwPpHlwgwAvoGfo7EUiGkyUM9CsGFY6SLR3ghlTNScQh92RKzFHtcNGbqnjl3WCw6fU4Gp60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736112302; c=relaxed/simple;
	bh=SsjA84wrFwgPhCFGRkJsChg53z08c4e8e2KhZm+mi/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ltBjgtkSjvBxxB0+/lI20idUMaCURgS6ANUZb4sHXOx4FsKiYh//SVTklEMbYRcNptlUQHxQDxyuxkLesQzxge/wyidnhqUkQ+bPhYbKFVD6AtgXZBWtecqEymFvJ2ALE+DH5IpaQEOxfnS9Q0EcaVsY69xGw7kDIBZwSa2lLVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl; spf=pass smtp.mailfrom=o2.pl; dkim=pass (2048-bit key) header.d=o2.pl header.i=@o2.pl header.b=BOHsus9s; arc=none smtp.client-ip=193.222.135.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=o2.pl
Received: (wp-smtpd smtp.tlen.pl 1367 invoked from network); 5 Jan 2025 22:18:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=20241105;
          t=1736111895; bh=VnLPdnjsaycnpSx/pL4+U4RdKV4dB9Ee+hdEOWVTlfk=;
          h=From:To:Cc:Subject;
          b=BOHsus9s/rllxnUMSJbXELLZkfUjDTx5aphRrpGpIfn6Ku7N57GIuh3wlc1/Tg/bi
           KXQCdZgsDwjKPq12V80Ec8KVXmPG2uT7b6E66UFij/Ubfy04ZA0C1sJiC+59O8Bkku
           sGgyWbIOMlh20ySGwhYs1X8wiWt2zfIeNEaUhqqkfEfz8m3EZoGHX/UnqVBXF4mOFX
           hh8kE2/7lKoWn/qE+o5Wxerngb4kB0LWwiEAPY0CrC3s1Y8EZbGFK5lAMVnTfy4Gr9
           Jv14+dX/PqHYy6BAM6UWYL0NUlo29XVWAtnmP1iaRibsIyvRczwQPZ9mvT87F0CNg9
           ek7H3/1dK3zzg==
Received: from unknown (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[37.109.144.183])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-mips@vger.kernel.org>; 5 Jan 2025 22:18:14 +0100
From: =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
	stable@vger.kernel.org,
	Dengcheng Zhu <dzhu@wavecomp.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Ming Wang <wangming01@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH] mips/math-emu: fix emulation of the prefx instruction
Date: Sun,  5 Jan 2025 22:18:06 +0100
Message-Id: <20250105211806.421305-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 149f5602e58afcfd9f26f783a5147466
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 000000A [sROE]                               

Currently, installation of Debian 12.8 for mipsel fails on machines
without an FPU [1]. This is caused by the fact that zstd (which is used
for initramfs compression) executes the prefx instruction, which is not
emulated properly by the kernel.

The prefx (Prefetch Indexed) instruction fetches data from memory into
the cache without any side effects. Though functionally unrelated, it
requires an FPU [2].

Bytecode format of this instruction ends on "001111" binary:

	(prefx instruction format) & 0x0000003f = 0x0000000f

The code in fpux_emu() runs like so:

	#define MIPSInst(x) x
	#define MIPSInst_FMA_FFMT(x) (MIPSInst(x) & 0x00000007)
	#define MIPSInst_FUNC(x) (MIPSInst(x) & 0x0000003f)
	enum cop1x_func { ..., pfetch_op = 0x0f, ... };

	...

	switch (MIPSInst_FMA_FFMT(ir)) {
	...

	case 0x3:
		if (MIPSInst_FUNC(ir) != pfetch_op)
			return SIGILL;

		/* ignore prefx operation */
		break;

	default:
		return SIGILL;
	}

That snippet above contains a logic error and the
	if (MIPSInst_FUNC(ir) != pfetch_op)
comparison always fires.

When MIPSInst_FUNC(ir) is equal to pfetch_op, ir must end on 001111
binary. In this case, MIPSInst_FMA_FFMT(ir) must be equal to 0x7, which
does not match that case label.

This causes emulation failure for the prefx instruction. Fix it.

This has been broken by
commit 919af8b96c89 ("MIPS: Make definitions of MIPSInst_FMA_{FUNC,FMTM} consistent with MIPS64 manual")
which modified the MIPSInst_FMA_FFMT macro without updating the users.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: stable@vger.kernel.org # after 3 weeks
Cc: Dengcheng Zhu <dzhu@wavecomp.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Ming Wang <wangming01@loongson.cn>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Fixes: 919af8b96c89 ("MIPS: Make definitions of MIPSInst_FMA_{FUNC,FMTM} consistent with MIPS64 manual")

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1091858
[2] MIPS Architecture For Programmers Volume II-A: The MIPS32 Instruction Set

---

Tested in QEMU for mipsel and mips64el.
---
 arch/mips/math-emu/cp1emu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 265bc57819df..c89e70df43d8 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1660,7 +1660,7 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 		break;
 	}
 
-	case 0x3:
+	case 0x7:
 		if (MIPSInst_FUNC(ir) != pfetch_op)
 			return SIGILL;
 
-- 
2.25.1


