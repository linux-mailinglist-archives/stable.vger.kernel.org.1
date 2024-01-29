Return-Path: <stable+bounces-17300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDDA8410A1
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E7E1C23BBF
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A0476C89;
	Mon, 29 Jan 2024 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A5TRqGSX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD7976C7E;
	Mon, 29 Jan 2024 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548658; cv=none; b=JTce51+Z5SZBeYFLWheBWM8rqTuITksQ+l3EzPCRTxyYb8ISSL/rx5VhTqkhqaTxwdExBst+1Jl5oza74Hkog+E9qOp22xAhc9HXQ082MpD62E7vLHKx6YGgK6xfSkw4KwY37oPU1muynm3eQ775O5gM9e0qrtzklCfmpKfsU+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548658; c=relaxed/simple;
	bh=uhkc5FLLi/QhBY0cHFq1wW3ffbBG2o3zHPKC4Nkysc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFRLPYcucSXWA5pjSrYcbh6DviB1WYjh95ECA3DxbjhIoalvgQn7zFgLQMuhaOVqBEv6b2g/D8BJVNxRDRjzIM92hrwiUjKvnxkfb5BRVtQb6uZxH2mfxIoKnvpbiZRRT8FT7PsV23vYNi7fDC9vpA3eGKJdh8t9ab9OerkU010=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A5TRqGSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A316AC433C7;
	Mon, 29 Jan 2024 17:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548657;
	bh=uhkc5FLLi/QhBY0cHFq1wW3ffbBG2o3zHPKC4Nkysc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5TRqGSXDE1vpG2Sw0IuFqN+NxUVD2SORgwmdi570kES42mVb4Ko4B61R2P4p+Ipu
	 Z5P62V3v7kKdBoIsA3Q39Zy4g/K0WmytGelikumx7vHXi1kIXP8eRpO/ZLi0yj6PlA
	 rXalU/KdMTVLQCxEWFr1HIAL6r+xYSi/5IDEvfiQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xi Ruoyao <xry111@xry111.site>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 6.6 325/331] mips: Call lose_fpu(0) before initializing fcr31 in mips_set_personality_nan
Date: Mon, 29 Jan 2024 09:06:29 -0800
Message-ID: <20240129170024.386363192@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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



