Return-Path: <stable+bounces-108310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E508A0A7E5
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 10:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F073A879C
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 09:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21609187553;
	Sun, 12 Jan 2025 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tI9FNde/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33A18BE8
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736672974; cv=none; b=s3Zut2z0Y8rEnvN5GWCY+UryBr65cEFhnqtvLHwQ+QzweqzR+3HgpRw81SWgnUqcYlK16xBrYri+1tAbXQ4LPUxRWiJ6c+YmAdyqP0OC+0qFo1tc8FLm4vFfGQDrocK3pV9WWdESw2Y9lrhJr7SVTYzX9YC5YYA8HCLUtsTmSSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736672974; c=relaxed/simple;
	bh=i9d+LE+lG9Ju7ftMTOolqt81omQ6u26Q6/QWbybfZtg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YRR9vzlcScaq+6xJykPBJJPi3mkvgew4NsNdD1aDThBIbysAkPnwUOPT+zU0uZMjgFUml3PXtUHXDnMzIOSFWutCdKU5RhauYhi1z6zez+z1Xqw0Ntp08hfgnsgZIm02QvnD5aNttAjiepmbqDxGMa1P5cbOLbeYtw5kEymkQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tI9FNde/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055FAC4CEDF;
	Sun, 12 Jan 2025 09:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736672974;
	bh=i9d+LE+lG9Ju7ftMTOolqt81omQ6u26Q6/QWbybfZtg=;
	h=Subject:To:Cc:From:Date:From;
	b=tI9FNde/taZXR/VmHtMmwfA36JTC0i+xHq9UBreh0IdTD9BL+8NSjsqbXMxBg+uAP
	 wvM48d13nxmhFkf+/1xeNjtSAOkohtPhql3KfB4C4p11FaUVW8Z8HkRJfsI6h730jJ
	 4cBO+YnY80mwurOTz4iJeRMdsQf2CMfkfpAAA/z4=
Subject: FAILED: patch "[PATCH] riscv: kprobes: Fix incorrect address calculation" failed to apply to 6.6-stable tree
To: namcao@linutronix.de,alexghiti@rivosinc.com,palmer@rivosinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 12 Jan 2025 10:09:31 +0100
Message-ID: <2025011231-bakery-sterling-1f23@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 13134cc949148e1dfa540a0fe5dc73569bc62155
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011231-bakery-sterling-1f23@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 13134cc949148e1dfa540a0fe5dc73569bc62155 Mon Sep 17 00:00:00 2001
From: Nam Cao <namcao@linutronix.de>
Date: Tue, 19 Nov 2024 12:10:56 +0100
Subject: [PATCH] riscv: kprobes: Fix incorrect address calculation

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

Fixes: b1756750a397 ("riscv: kprobes: Use patch_text_nosync() for insn slots")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20241119111056.2554419-1-namcao@linutronix.de
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 380a0e8cecc0..c0738d6c6498 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -30,7 +30,7 @@ static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 	p->ainsn.api.restore = (unsigned long)p->addr + len;
 
 	patch_text_nosync(p->ainsn.api.insn, &p->opcode, len);
-	patch_text_nosync(p->ainsn.api.insn + len, &insn, GET_INSN_LENGTH(insn));
+	patch_text_nosync((void *)p->ainsn.api.insn + len, &insn, GET_INSN_LENGTH(insn));
 }
 
 static void __kprobes arch_prepare_simulate(struct kprobe *p)


