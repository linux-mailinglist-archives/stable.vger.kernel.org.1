Return-Path: <stable+bounces-93949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84F39D24A0
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56EFB1F230F2
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C7D1C3306;
	Tue, 19 Nov 2024 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JPqpOQWD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P/h+PV0+"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1582214AD1A;
	Tue, 19 Nov 2024 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014728; cv=none; b=p56kUylRuk2UX3oNoiRMfAGLt0mzrNp/Du7fiPcim+dvDL6gHqXm8azOJ9Wy/nFjgOEB3AZWJiQQ/0dXvVXH961ddCD9evY5HezEBW+XbUCpifnuz4xXr7KZJkRfWyRnFo7uQtPSZF9Fe8IDKLEMuOmURu/nklwOs91bOk9qtZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014728; c=relaxed/simple;
	bh=mknntYxIV69Ae/WS6lyHe236OCBngYEIu6gZwYR1Y+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sI4osRn3Rqy1vsHX9iN8VZbvKYgf8ZSbDv8+tnrUaOLqY/LuSKhts9xw+bjcSr3DNixsrai0c7rh5lnxvKYoVr0xMylFxavWq/hjE6ze5mAq46NeGB82M6GU5WIG6SXNEIxl3L99xe+4Xvtl7G2VHkHzXinsuxbzrA0zu5oJ08k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JPqpOQWD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P/h+PV0+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732014724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AnSoKCnQrjrmzqa2C++pRQDGWZYwmEGb3klOeM1ODno=;
	b=JPqpOQWDN5FAAIkObFQ79DDrfI8arMwdauXPgIuDle4pPYOugOv7fjHc9QGglhicCjsGPu
	XJ8j25eHWH5k0IrUP5IzQHZfZVgFgxtka4sW4icbnpcIoNdDJ7ozmtWhJBjEEPMq0BwlFl
	gD3VsjhSZtGW6KN+2zRp0axSnbAQFJupGqeIFzZ5jW5rR+Vwoyc0MvsYQBmO6/pdG4jZuz
	JfcUh3jY5vTwUnAfMzAAypk1op5cN5zr0SuTF2pIh0zaqvdiSL1d3GT826fJ6tG8Nsng8E
	7zuMBQjLRDv34YoYNKr7ZW+mMPoRDgcKh4DPYHEVHND66Os5gc9fcm0WBTgsrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732014724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AnSoKCnQrjrmzqa2C++pRQDGWZYwmEGb3klOeM1ODno=;
	b=P/h+PV0+Vj1KVJvq625yvh4OJfnE2mUnoxtSv70YLtIIg/RSzdMfzIRdzlK6kBxRSBD5m3
	HVAUppB4cdc98XCA==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH] riscv: kprobes: Fix incorrect address calculation
Date: Tue, 19 Nov 2024 12:10:56 +0100
Message-Id: <20241119111056.2554419-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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
---
 arch/riscv/kernel/probes/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/=
kprobes.c
index 474a65213657..d2dacea1aedd 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -30,7 +30,7 @@ static void __kprobes arch_prepare_ss_slot(struct kprobe =
*p)
 	p->ainsn.api.restore =3D (unsigned long)p->addr + len;
=20
 	patch_text_nosync(p->ainsn.api.insn, &p->opcode, len);
-	patch_text_nosync(p->ainsn.api.insn + len, &insn, GET_INSN_LENGTH(insn));
+	patch_text_nosync((void *)p->ainsn.api.insn + len, &insn, GET_INSN_LENGTH=
(insn));
 }
=20
 static void __kprobes arch_prepare_simulate(struct kprobe *p)
--=20
2.39.5


