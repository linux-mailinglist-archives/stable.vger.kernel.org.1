Return-Path: <stable+bounces-16956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C6E840F36
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A2B1F267F1
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73742164193;
	Mon, 29 Jan 2024 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hfrvMJWH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A9015D5C5;
	Mon, 29 Jan 2024 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548403; cv=none; b=hGQ0jitxzv/0xhWWfyQ46UT1YJXqrvSretgz5GAZbhZwNyPG8Ea5Vl9h3kn7G3itUyrL584QMac0eWmrBa7jPcz9aSNLSpepZu68MYIy5g0G/riSRWVCA3j9KZanOb8gN6eAdiUf2z+Zgt/UOOD5oe07PpCg4rIqKZ+ktxK2JNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548403; c=relaxed/simple;
	bh=Z0tukAm+c+Gjx0AsBEVNaZLE2cgh5DrJkDFiIZHG9Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGEsKuXHYzTBzfnU3m4AGxU5rzTK8NQCt3+Yt1XHf2X3qWZr4LrdC/azsCJ/9+UPLxfOLSB/rU+jEo7+E38N5gxVAI2sPdIvK+bWRy7mBr04Zo+4Vg4KLTsDrUEmD2O5xbrvA7buP1+qevQm2MfVtrCV3aGPH76KAEajTpmqgmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hfrvMJWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E365AC43390;
	Mon, 29 Jan 2024 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548403;
	bh=Z0tukAm+c+Gjx0AsBEVNaZLE2cgh5DrJkDFiIZHG9Dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hfrvMJWHrcP8y7wZZwCQlsLJd4D2O9soGOTBbKwR3jwgmpPt+k3vLYiiGVR40ngWe
	 JWVP/feWmuGp19E6uqo4OZ2p3wqEc3bbrOBafjC2YXre5uEsjGlFewaD2NK4UK9aRx
	 3vvhJM2EunKD/Jyt8UuTUgpYcpFzpB6JTTBKLxsY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xi Ruoyao <xry111@xry111.site>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 6.1 182/185] mips: Call lose_fpu(0) before initializing fcr31 in mips_set_personality_nan
Date: Mon, 29 Jan 2024 09:06:22 -0800
Message-ID: <20240129170004.434465895@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129165958.589924174@linuxfoundation.org>
References: <20240129165958.589924174@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xi Ruoyao <xry111@xry111.site>

commit 59be5c35850171e307ca5d3d703ee9ff4096b948 upstream.

If we still own the FPU after initializing fcr31, when we are preempted
the dirty value in the FPU will be read out and stored into fcr31,
clobbering our setting.  This can cause an improper floating-point
environment after execve().  For example:

    zsh% cat measure.c
    #include <fenv.h>
    int main() { return fetestexcept(FE_INEXACT); }
    zsh% cc measure.c -o measure -lm
    zsh% echo $((1.0/3)) # raising FE_INEXACT
    0.33333333333333331
    zsh% while ./measure; do ; done
    (stopped in seconds)

Call lose_fpu(0) before setting fcr31 to prevent this.

Closes: https://lore.kernel.org/linux-mips/7a6aa1bbdbbe2e63ae96ff163fab0349f58f1b9e.camel@xry111.site/
Fixes: 9b26616c8d9d ("MIPS: Respect the ISA level in FCSR handling")
Cc: stable@vger.kernel.org
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/elf.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -11,6 +11,7 @@
 
 #include <asm/cpu-features.h>
 #include <asm/cpu-info.h>
+#include <asm/fpu.h>
 
 #ifdef CONFIG_MIPS_FP_SUPPORT
 
@@ -309,6 +310,11 @@ void mips_set_personality_nan(struct arc
 	struct cpuinfo_mips *c = &boot_cpu_data;
 	struct task_struct *t = current;
 
+	/* Do this early so t->thread.fpu.fcr31 won't be clobbered in case
+	 * we are preempted before the lose_fpu(0) in start_thread.
+	 */
+	lose_fpu(0);
+
 	t->thread.fpu.fcr31 = c->fpu_csr31;
 	switch (state->nan_2008) {
 	case 0:



