Return-Path: <stable+bounces-22959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 605C285DE6E
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91FBF1C23BDA
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7F67D3F4;
	Wed, 21 Feb 2024 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G61X+U6Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4937CF02;
	Wed, 21 Feb 2024 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525089; cv=none; b=BBDIbegfdNWUy7MXXCJbk9unrojv6b3fyMNhrS0S34CMR7VX47M7V8HE1adlx5XrNzm6TenOvtBy1YB48FcRX+oEKN0KZrfVMB3up9kCnYIv3UkVWkPNHJvQhBz88xBG/Xu4GAIkhHOsKh2h1+P7sacX0omwI3tUSAUYmVUDjVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525089; c=relaxed/simple;
	bh=nbUK88B4DGlerWH0ydGMVQaY9v8fqAt0Hu2hSn7ih0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uH5DfzuxARPr/XtpAoclgEN/AP6RQ8W4JfCy3kcp8hOcmwtHzVd+xoS2/8SpjXqdtFPdhdgcK1H8gx8bjWxm2ii1NHKoH3ei0JETtTB7plB7jUFj8LB7E9yVie233go02RTu8foN3mquJSjNy3FG/izpOhsBqwmJ+ulRMW/EGMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G61X+U6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206BFC433C7;
	Wed, 21 Feb 2024 14:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708525089;
	bh=nbUK88B4DGlerWH0ydGMVQaY9v8fqAt0Hu2hSn7ih0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G61X+U6ZurZF3mgIg57hwFXHuaYWVy24xn32roqmyiSLY8KBReWE24/AA4/JQGkuD
	 S1c6hItL0qCYuQGrluy5OtkemtmIuzJ2L6Gkfd/VoP4iY+29C10w7zjsE5TjjDA3FV
	 EJNOcQCD3Fgj9PxIJlU1r5X4Sod1aNCyQS/iiqBM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xi Ruoyao <xry111@xry111.site>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 5.4 058/267] mips: Call lose_fpu(0) before initializing fcr31 in mips_set_personality_nan
Date: Wed, 21 Feb 2024 14:06:39 +0100
Message-ID: <20240221125941.829638279@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125940.058369148@linuxfoundation.org>
References: <20240221125940.058369148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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



