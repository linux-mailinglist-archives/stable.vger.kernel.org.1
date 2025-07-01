Return-Path: <stable+bounces-159140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47434AEF82B
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 14:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3115188DDD7
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 12:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06DB273808;
	Tue,  1 Jul 2025 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b="JpMC2Vk1"
X-Original-To: stable@vger.kernel.org
Received: from gbr-app-1.alpinelinux.org (gbr-app-1.alpinelinux.org [213.219.36.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA77128373
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.219.36.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372403; cv=none; b=asvTWzO9Kwllc6bJVOKcon1eF45xI5S5TtlNcnvvIHe1ymIBRBvNGp1NNMfUKmQutN1Ql6QtIivseYKHlblTRKQ+PuKvFOQju4VJtJTVSzFW7iealW8OFT2jKV/wrV+dxz7B/ns5MKcV0ISLpwaSIxa20TbAyUpobCLEFvFv5Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372403; c=relaxed/simple;
	bh=DuNcpJgkR/fC+tbNSrCG4eMxDYwYGtqY2sP0scrPwCk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Gt7X5LFoh05Z3Y+TmKzKgFLpmnzofyYP9NFqnievy1qH4LCWQIwCHyEhr+9/Do6hti/H5frd+6MVgx/9YaYNqfpnvXblCx31SFFXwe5Dd6LjNSYkAT/WPaWnbTcqaoGylygeV023El6thOBylYdkl95Qq/oDPWHnWKEWvdgZ8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org; spf=pass smtp.mailfrom=alpinelinux.org; dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b=JpMC2Vk1; arc=none smtp.client-ip=213.219.36.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpinelinux.org
Received: from ncopa-desktop (unknown [IPv6:2001:4646:fb05:0:4470:81ef:576c:2941])
	(Authenticated sender: ncopa@alpinelinux.org)
	by gbr-app-1.alpinelinux.org (Postfix) with ESMTPSA id 08558223627;
	Tue,  1 Jul 2025 12:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpinelinux.org;
	s=smtp; t=1751371831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tXTc4KwG/jXUxAlRTXSvdzPmRvD0sV0P1VqGDcbK7yg=;
	b=JpMC2Vk1VNAN2hgUHJ9mIqJCeTwW/N2XRje/VNIWAFr2aXTGgVZUmuplZknwZBBpNPaiJJ
	LPx2+eiqcZAczilGiNUw8JaHM4a9m7E0zXaF1kyNdl9H2IAQ43UoICMPOVnRz3jmkPeLsu
	UMkiFmTfulNrmH/uVjYVrqORocksRcI=
Date: Tue, 1 Jul 2025 14:10:26 +0200
From: Natanael Copa <ncopa@alpinelinux.org>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, Sergio =?ISO-8859-1?B?R29ueuFsZXo=?=
 Collado <sergio.collado@gmail.com>, Achill Gilgenast <fossdd@pwned.life>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [REGRESSION] v6.12.35: (build) kallsyms.h:21:10: fatal error:
 execinfo.h: No such file or directory
Message-ID: <20250701141026.6133a3aa@ncopa-desktop>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-alpine-linux-musl)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

I bumped into a build regression when building Alpine Linux kernel 6.12.35 on x86_64:

In file included from ../arch/x86/tools/insn_decoder_test.c:13:
../tools/include/linux/kallsyms.h:21:10: fatal error: execinfo.h: No such file or directory
   21 | #include <execinfo.h>
      |          ^~~~~~~~~~~~
compilation terminated.

The 6.12.34 kernel built just fine.

I bisected it to:

commit b8abcba6e4aec53868dfe44f97270fc4dee0df2a (HEAD)
Author: Sergio Gonz_lez Collado <sergio.collado@gmail.com>
Date:   Sun Mar 2 23:15:18 2025 +0100

    Kunit to check the longest symbol length
    
    commit c104c16073b7fdb3e4eae18f66f4009f6b073d6f upstream.
    
which has this hunk:

diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
index 472540aeabc2..6c2986d2ad11 100644
--- a/arch/x86/tools/insn_decoder_test.c
+++ b/arch/x86/tools/insn_decoder_test.c
@@ -10,6 +10,7 @@
 #include <assert.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <linux/kallsyms.h>
 
 #define unlikely(cond) (cond)
 
@@ -106,7 +107,7 @@ static void parse_args(int argc, char **argv)
        }
 }
 
-#define BUFSIZE 256
+#define BUFSIZE (256 + KSYM_NAME_LEN)
 
 int main(int argc, char **argv)
 {

It looks like the linux/kallsyms.h was included to get KSYM_NAME_LEN.
Unfortunately it also introduced the include of execinfo.h, which does
not exist on musl libc.

This has previously been reported to and tried fixed:
https://lore.kernel.org/stable/DB0OSTC6N4TL.2NK75K2CWE9JV@pwned.life/T/#t

Would it be an idea to revert commit b8abcba6e4ae til we have a proper
solution for this?

Thanks!

-nc

