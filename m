Return-Path: <stable+bounces-2712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBF17F9556
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 21:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D12280D7C
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 20:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6326DF4D;
	Sun, 26 Nov 2023 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FF9A4F;
	Sun, 26 Nov 2023 20:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135D3C433C7;
	Sun, 26 Nov 2023 20:39:08 +0000 (UTC)
Date: Sun, 26 Nov 2023 21:39:06 +0100
From: Helge Deller <deller@gmx.de>
To: Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 4.14 00/53] 4.14.331-rc2 review
Message-ID: <ZWOs6uwZoCoxYSSs@p100>
References: <20231125163059.878143365@linuxfoundation.org>
 <09f33739-9bf6-4ff8-895d-92d3567c3cb9@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09f33739-9bf6-4ff8-895d-92d3567c3cb9@roeck-us.net>

* Guenter Roeck <linux@roeck-us.net>:
> On 11/25/23 08:32, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.331 release.
> > There are 53 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Mon, 27 Nov 2023 16:30:48 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Building parisc64:generic-64bit_defconfig ... failed
> --------------
> Error log:
> hppa64-linux-ld: arch/parisc/kernel/head.o: in function `$iodc_panic':
> (.head.text+0x64): undefined reference to `init_stack'
> hppa64-linux-ld: (.head.text+0x68): undefined reference to `init_stack'
> make[1]: *** [Makefile:1049: vmlinux] Error 1
> make: *** [Makefile:153: sub-make] Error 2

Indeed.
Thanks for testing, Guenter!

Greg, could you please replace the patch in queue/4.14 with
the one below? It simply uses another stack start, which is ok since the
machine will stop anyway.

No changes needed for your other stable-queues. I tested 4.19 and
it's ok as-is.

Thanks!
Helge


From 29e10df694b70b4283e2d6f6852afc0ea7823e5b Mon Sep 17 00:00:00 2001
From: Helge Deller <deller@gmx.de>
Date: Fri, 10 Nov 2023 16:13:15 +0100
Subject: [PATCH] parisc: Prevent booting 64-bit kernels on PA1.x machines

commit a406b8b424fa01f244c1aab02ba186258448c36b upstream.

Bail out early with error message when trying to boot a 64-bit kernel on
32-bit machines. This fixes the previous commit to include the check for
true 64-bit kernels as well.

Patch modified for 4.14 to use __bss_stop for stack. This is OK, since
the machine will halt after printing the warning.

Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: 591d2108f3abc ("parisc: Add runtime check to prevent PA2.0 kernels on PA1.x machines")
Cc:  <stable@vger.kernel.org> # v6.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/arch/parisc/kernel/head.S b/arch/parisc/kernel/head.S
index 2f570a520586..2f552ff3a75f 100644
--- a/arch/parisc/kernel/head.S
+++ b/arch/parisc/kernel/head.S
@@ -69,9 +69,8 @@ $bss_loop:
 	stw,ma          %arg2,4(%r1)
 	stw,ma          %arg3,4(%r1)
 
-#if !defined(CONFIG_64BIT) && defined(CONFIG_PA20)
-	/* This 32-bit kernel was compiled for PA2.0 CPUs. Check current CPU
-	 * and halt kernel if we detect a PA1.x CPU. */
+#if defined(CONFIG_PA20)
+	/* check for 64-bit capable CPU as required by current kernel */
 	ldi		32,%r10
 	mtctl		%r10,%cr11
 	.level 2.0
@@ -84,7 +83,7 @@ $bss_loop:
 $iodc_panic:
 	copy		%arg0, %r10
 	copy		%arg1, %r11
-	load32		PA(init_stack),%sp
+	load32		PA(__bss_stop),%sp
 #define MEM_CONS 0x3A0
 	ldw		MEM_CONS+32(%r0),%arg0	// HPA
 	ldi		ENTRY_IO_COUT,%arg1


