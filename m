Return-Path: <stable+bounces-85624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E119799E822
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8241C21753
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5050C1E1A35;
	Tue, 15 Oct 2024 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xa7Q+RCT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA001C57B1;
	Tue, 15 Oct 2024 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993741; cv=none; b=Fdvc6fD0YemvySGT2sQY5gSlVu5j4+JQapPOuthWpSbEASUdDmv2wjIAw4VJ8Eg/boEYEGkKRTpBO6aY4cfJFG8tDidOwIjoJXEbHvsPddehVCeb5Xp8BqoaXkp+Z2jyTBdRYzOFQdRM+/4ugA5SZM7ThNmxI6RlC45eTLtvfYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993741; c=relaxed/simple;
	bh=ioyXIigYqzRVk6IjmdDCooRYHea0ilNQAqGLlkFrJHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVM4iWAPO5ZQgRfaH2unx6gTmTJ1vr2LUMSecRAxDbMknww/pOrZocu6Wr3n7R7hB2NUiE499s0ggBca+4cl6q+zmRxACaUJ99UcJHw7iAkejpuGc9j5LB4KUmW/8QJzNislam80eyC8ymoD7FcSkXSz4A3sMpA83OvnRly6ePw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xa7Q+RCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714F4C4CEC6;
	Tue, 15 Oct 2024 12:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993740;
	bh=ioyXIigYqzRVk6IjmdDCooRYHea0ilNQAqGLlkFrJHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xa7Q+RCTOvvnRjlaqVkMof7BKckZAh+n4aKvUqE+72H5hnY61WsuH8NEJDDr5gbGU
	 fIoHQU8WnHRtTZd1mwvVlS1lJXdMCt7jz5OLOOGFb9wvEfbH2CAl97AVEsaMZJ0Op8
	 UEL/YJkFnm4LDNLVlR+yUNIwBMEeYPn8lSv4CGWY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 484/691] selftests: vDSO: fix vDSO symbols lookup for powerpc64
Date: Tue, 15 Oct 2024 13:27:12 +0200
Message-ID: <20241015112459.549696831@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit ba83b3239e657469709d15dcea5f9b65bf9dbf34 ]

On powerpc64, following tests fail locating vDSO functions:

  ~ # ./vdso_test_abi
  TAP version 13
  1..16
  # [vDSO kselftest] VDSO_VERSION: LINUX_2.6.15
  # Couldn't find __kernel_gettimeofday
  ok 1 # SKIP __kernel_gettimeofday
  # clock_id: CLOCK_REALTIME
  # Couldn't find __kernel_clock_gettime
  ok 2 # SKIP __kernel_clock_gettime CLOCK_REALTIME
  # Couldn't find __kernel_clock_getres
  ok 3 # SKIP __kernel_clock_getres CLOCK_REALTIME
  ...
  # Couldn't find __kernel_time
  ok 16 # SKIP __kernel_time
  # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:16 error:0

  ~ # ./vdso_test_getrandom
  __kernel_getrandom is missing!

  ~ # ./vdso_test_gettimeofday
  Could not find __kernel_gettimeofday

  ~ # ./vdso_test_getcpu
  Could not find __kernel_getcpu

On powerpc64, as shown below by readelf, vDSO functions symbols have
type NOTYPE, so also accept that type when looking for symbols.

$ powerpc64-linux-gnu-readelf -a arch/powerpc/kernel/vdso/vdso64.so.dbg
ELF Header:
  Magic:   7f 45 4c 46 02 02 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF64
  Data:                              2's complement, big endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              DYN (Shared object file)
  Machine:                           PowerPC64
  Version:                           0x1
...

Symbol table '.dynsym' contains 12 entries:
   Num:    Value          Size Type    Bind   Vis      Ndx Name
     0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
     1: 0000000000000524    84 NOTYPE  GLOBAL DEFAULT    8 __[...]@@LINUX_2.6.15
     2: 00000000000005f0    36 NOTYPE  GLOBAL DEFAULT    8 __[...]@@LINUX_2.6.15
     3: 0000000000000578    68 NOTYPE  GLOBAL DEFAULT    8 __[...]@@LINUX_2.6.15
     4: 0000000000000000     0 OBJECT  GLOBAL DEFAULT  ABS LINUX_2.6.15
     5: 00000000000006c0    48 NOTYPE  GLOBAL DEFAULT    8 __[...]@@LINUX_2.6.15
     6: 0000000000000614   172 NOTYPE  GLOBAL DEFAULT    8 __[...]@@LINUX_2.6.15
     7: 00000000000006f0    84 NOTYPE  GLOBAL DEFAULT    8 __[...]@@LINUX_2.6.15
     8: 000000000000047c    84 NOTYPE  GLOBAL DEFAULT    8 __[...]@@LINUX_2.6.15
     9: 0000000000000454    12 NOTYPE  GLOBAL DEFAULT    8 __[...]@@LINUX_2.6.15
    10: 00000000000004d0    84 NOTYPE  GLOBAL DEFAULT    8 __[...]@@LINUX_2.6.15
    11: 00000000000005bc    52 NOTYPE  GLOBAL DEFAULT    8 __[...]@@LINUX_2.6.15

Symbol table '.symtab' contains 56 entries:
   Num:    Value          Size Type    Bind   Vis      Ndx Name
...
    45: 0000000000000000     0 OBJECT  GLOBAL DEFAULT  ABS LINUX_2.6.15
    46: 00000000000006c0    48 NOTYPE  GLOBAL DEFAULT    8 __kernel_getcpu
    47: 0000000000000524    84 NOTYPE  GLOBAL DEFAULT    8 __kernel_clock_getres
    48: 00000000000005f0    36 NOTYPE  GLOBAL DEFAULT    8 __kernel_get_tbfreq
    49: 000000000000047c    84 NOTYPE  GLOBAL DEFAULT    8 __kernel_gettimeofday
    50: 0000000000000614   172 NOTYPE  GLOBAL DEFAULT    8 __kernel_sync_dicache
    51: 00000000000006f0    84 NOTYPE  GLOBAL DEFAULT    8 __kernel_getrandom
    52: 0000000000000454    12 NOTYPE  GLOBAL DEFAULT    8 __kernel_sigtram[...]
    53: 0000000000000578    68 NOTYPE  GLOBAL DEFAULT    8 __kernel_time
    54: 00000000000004d0    84 NOTYPE  GLOBAL DEFAULT    8 __kernel_clock_g[...]
    55: 00000000000005bc    52 NOTYPE  GLOBAL DEFAULT    8 __kernel_get_sys[...]

Fixes: 98eedc3a9dbf ("Document the vDSO and add a reference parser")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/vDSO/parse_vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 4ae417372e9eb..d9ccc5acac182 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -216,7 +216,8 @@ void *vdso_sym(const char *version, const char *name)
 		ELF(Sym) *sym = &vdso_info.symtab[chain];
 
 		/* Check for a defined global or weak function w/ right name. */
-		if (ELF64_ST_TYPE(sym->st_info) != STT_FUNC)
+		if (ELF64_ST_TYPE(sym->st_info) != STT_FUNC &&
+		    ELF64_ST_TYPE(sym->st_info) != STT_NOTYPE)
 			continue;
 		if (ELF64_ST_BIND(sym->st_info) != STB_GLOBAL &&
 		    ELF64_ST_BIND(sym->st_info) != STB_WEAK)
-- 
2.43.0




