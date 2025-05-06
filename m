Return-Path: <stable+bounces-141862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813D4AACEBF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 22:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB6F466563
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 20:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB4533E1;
	Tue,  6 May 2025 20:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aUkU0EFp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ISTqBmHf"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AE54B1E6D;
	Tue,  6 May 2025 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746562685; cv=none; b=gmCV5mFMXbI10S3WJB+r6XAjfWLcCyHnVH2On7yP3S74SdDEDT73j52XzD5lCS2bkgOEjFd2rpkn2Sc5eOmTZUAlkWJ8azxgA/acnbwAxOVsZfCZWvejPms6DULXFtu+XVYJ6e3V+cQiRNPRyWH2xo6K8EBu1NTiEaulBrZ6lq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746562685; c=relaxed/simple;
	bh=jMJosw9hZXCTi7Wr9id5YVeiCBRHKhharw17GPJkFP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=N943859Ndr8GCHhU9Nn914behTKY0MDF55DUy5a9toaGQDLB4roh+l/tkZ7ub/NFGz0KxtQJgq5Y1JpNcm8ZVGE6EVmw5/J4Ow6sTY+racOgIysiYyE1XPfuTMq8LYCHSnbpXGXWyxkveimgE6eMdYJmeoYPvD/qWZF+Vvgwf8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aUkU0EFp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ISTqBmHf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746562680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JL3KJECzkhV/qvzTbpNQakf8HDmxnrdG6VFLv0G/Yhs=;
	b=aUkU0EFpALSvYtaPELyXgLD9eiLYltdKXUYsXtn2Hjj7y0cBwyrAqj6CQw/W95tk30NxFA
	3fY4DzE3PgVUTsUjJI8Wc6EuBZit4uZAdohzfaY4asalDv+2Orx6W44OW9qs/XxXRyPCa/
	Gq9NwHkfTtdyx9mfAJQJJ0pf2xIveuz7lgYsWSm5Jz4Q0FUVPYB+BtHz5ddOJx5XdaYPtt
	uTQYChI2SMNI5vIy5toFVg+uSB0kpA/V6DykHegnQp1NHMGAkuNXFNfjF7/AAcd5zU+Raa
	5BlkmvonCVHpQCmgTReoGtUaH6CtTCPm/T7bel1tLvsSPFkVPtmR9qRKvJSkXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746562680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JL3KJECzkhV/qvzTbpNQakf8HDmxnrdG6VFLv0G/Yhs=;
	b=ISTqBmHfkw0nuQ6Ti7cf04Qt+m5Hevz5/81ZA22DDowMHZgue8Ig2w2rnbpc0FfAs420BP
	Blzxi4Q1mmyZgTDQ==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Kai Zhang <zhangkai@iscas.ac.cn>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH stable v6.6] riscv: Pass patch_text() the length in bytes
Date: Tue,  6 May 2025 22:17:52 +0200
Message-Id: <20250506201752.1915639-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Samuel Holland <samuel.holland@sifive.com>

[ Upstream commit 51781ce8f4486c3738a6c85175b599ad1be71f89 ]

patch_text_nosync() already handles an arbitrary length of code, so this
removes a superfluous loop and reduces the number of icache flushes.

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20240327160520.791322-6-samuel.holland@sifi=
ve.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
[apply to v6.6]
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
this patch fixes a bug introduced by commit b1756750a397 ("riscv: kprobes: =
Use
patch_text_nosync() for insn slots"), which replaced patch_text() with
patch_text_nosync(). That is broken, because patch_text() and
patch_text_nosync() takes different parameters (number of instruction vs
patched length in bytes).

This bug was reported in:
https://lore.kernel.org/stable/c7e463c0-8cad-4f4e-addd-195c06b7b6de@iscas.a=
c.cn/
---
 arch/riscv/include/asm/patch.h     |  2 +-
 arch/riscv/kernel/patch.c          | 14 +++++---------
 arch/riscv/kernel/probes/kprobes.c | 18 ++++++++++--------
 arch/riscv/net/bpf_jit_comp64.c    |  7 ++++---
 4 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
index 9f5d6e14c405..7228e266b9a1 100644
--- a/arch/riscv/include/asm/patch.h
+++ b/arch/riscv/include/asm/patch.h
@@ -9,7 +9,7 @@
 int patch_insn_write(void *addr, const void *insn, size_t len);
 int patch_text_nosync(void *addr, const void *insns, size_t len);
 int patch_text_set_nosync(void *addr, u8 c, size_t len);
-int patch_text(void *addr, u32 *insns, int ninsns);
+int patch_text(void *addr, u32 *insns, size_t len);
=20
 extern int riscv_patch_in_stop_machine;
=20
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 78387d843aa5..aeda87240dbc 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -19,7 +19,7 @@
 struct patch_insn {
 	void *addr;
 	u32 *insns;
-	int ninsns;
+	size_t len;
 	atomic_t cpu_count;
 };
=20
@@ -234,14 +234,10 @@ NOKPROBE_SYMBOL(patch_text_nosync);
 static int patch_text_cb(void *data)
 {
 	struct patch_insn *patch =3D data;
-	unsigned long len;
-	int i, ret =3D 0;
+	int ret =3D 0;
=20
 	if (atomic_inc_return(&patch->cpu_count) =3D=3D num_online_cpus()) {
-		for (i =3D 0; ret =3D=3D 0 && i < patch->ninsns; i++) {
-			len =3D GET_INSN_LENGTH(patch->insns[i]);
-			ret =3D patch_insn_write(patch->addr + i * len, &patch->insns[i], len);
-		}
+		ret =3D patch_insn_write(patch->addr, patch->insns, patch->len);
 		/*
 		 * Make sure the patching store is effective *before* we
 		 * increment the counter which releases all waiting CPUs
@@ -262,13 +258,13 @@ static int patch_text_cb(void *data)
 }
 NOKPROBE_SYMBOL(patch_text_cb);
=20
-int patch_text(void *addr, u32 *insns, int ninsns)
+int patch_text(void *addr, u32 *insns, size_t len)
 {
 	int ret;
 	struct patch_insn patch =3D {
 		.addr =3D addr,
 		.insns =3D insns,
-		.ninsns =3D ninsns,
+		.len =3D len,
 		.cpu_count =3D ATOMIC_INIT(0),
 	};
=20
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/=
kprobes.c
index 4fbc70e823f0..297427ffc4e0 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -23,13 +23,13 @@ post_kprobe_handler(struct kprobe *, struct kprobe_ctlb=
lk *, struct pt_regs *);
=20
 static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 {
+	size_t len =3D GET_INSN_LENGTH(p->opcode);
 	u32 insn =3D __BUG_INSN_32;
-	unsigned long offset =3D GET_INSN_LENGTH(p->opcode);
=20
-	p->ainsn.api.restore =3D (unsigned long)p->addr + offset;
+	p->ainsn.api.restore =3D (unsigned long)p->addr + len;
=20
-	patch_text_nosync(p->ainsn.api.insn, &p->opcode, 1);
-	patch_text_nosync((void *)p->ainsn.api.insn + offset, &insn, 1);
+	patch_text_nosync(p->ainsn.api.insn, &p->opcode, len);
+	patch_text_nosync((void *)p->ainsn.api.insn + len, &insn, GET_INSN_LENGTH=
(insn));
 }
=20
 static void __kprobes arch_prepare_simulate(struct kprobe *p)
@@ -116,16 +116,18 @@ void *alloc_insn_page(void)
 /* install breakpoint in text */
 void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
-	u32 insn =3D (p->opcode & __INSN_LENGTH_MASK) =3D=3D __INSN_LENGTH_32 ?
-		   __BUG_INSN_32 : __BUG_INSN_16;
+	size_t len =3D GET_INSN_LENGTH(p->opcode);
+	u32 insn =3D len =3D=3D 4 ? __BUG_INSN_32 : __BUG_INSN_16;
=20
-	patch_text(p->addr, &insn, 1);
+	patch_text(p->addr, &insn, len);
 }
=20
 /* remove breakpoint from text */
 void __kprobes arch_disarm_kprobe(struct kprobe *p)
 {
-	patch_text(p->addr, &p->opcode, 1);
+	size_t len =3D GET_INSN_LENGTH(p->opcode);
+
+	patch_text(p->addr, &p->opcode, len);
 }
=20
 void __kprobes arch_remove_kprobe(struct kprobe *p)
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp6=
4.c
index 26eeb3973631..16eb4cd11cbd 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -14,6 +14,7 @@
 #include "bpf_jit.h"
=20
 #define RV_FENTRY_NINSNS 2
+#define RV_FENTRY_NBYTES (RV_FENTRY_NINSNS * 4)
=20
 #define RV_REG_TCC RV_REG_A6
 #define RV_REG_TCC_SAVED RV_REG_S6 /* Store A6 in S6 if program do calls */
@@ -681,7 +682,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_typ=
e poke_type,
 	if (ret)
 		return ret;
=20
-	if (memcmp(ip, old_insns, RV_FENTRY_NINSNS * 4))
+	if (memcmp(ip, old_insns, RV_FENTRY_NBYTES))
 		return -EFAULT;
=20
 	ret =3D gen_jump_or_nops(new_addr, ip, new_insns, is_call);
@@ -690,8 +691,8 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_typ=
e poke_type,
=20
 	cpus_read_lock();
 	mutex_lock(&text_mutex);
-	if (memcmp(ip, new_insns, RV_FENTRY_NINSNS * 4))
-		ret =3D patch_text(ip, new_insns, RV_FENTRY_NINSNS);
+	if (memcmp(ip, new_insns, RV_FENTRY_NBYTES))
+		ret =3D patch_text(ip, new_insns, RV_FENTRY_NBYTES);
 	mutex_unlock(&text_mutex);
 	cpus_read_unlock();
=20
--=20
2.39.5


