Return-Path: <stable+bounces-187685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B248EBEB14B
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 19:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507291AA557C
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A75306B33;
	Fri, 17 Oct 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPgP6gif"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B8A1C6A3;
	Fri, 17 Oct 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760722439; cv=none; b=IZaxvWXwRhn9aeRW0n263wNSOoQ2N5wqHbBw9gSBN3DxKMkBLeqm5Cg5l3IR5AlkQ09dkgVZhxDERwf2U+yad8YVxUGOD9BdqAem801VyZFQp/uxGiNpCeYdosfb2ebsVJ//FYAcY+y5Oagi7ahfY//wtozmya2JWu9OLw8AHm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760722439; c=relaxed/simple;
	bh=+AtrBZZs/qIkDn+qTjTtCY5vfEV341Ish4teGAyteog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AXIAOrjmmkGsohu3bm0808dxejB0eYxFazN5vif4Ho2h1w0KuEfy2H0B8zBDSOay7Z0UWW3kKguLQJ1cVT1l+qOE6F/7pF1b+zmd+bry/dEiuP4xOs/nyExQvjKn8nL6u9FKMQTW5reJNtpVL+4hQQUw+Xf93WR5mi+isKOKlbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPgP6gif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A862C116B1;
	Fri, 17 Oct 2025 17:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760722439;
	bh=+AtrBZZs/qIkDn+qTjTtCY5vfEV341Ish4teGAyteog=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OPgP6gifmek7PvNRAp6QYqMZpMuvHUIcOFrLV8RQEHsjK4A20whrYv/o6pnZBlgxU
	 I6GNRwdO4qTRXeWcOpCDII6kqrhQgvgHKaItBtU4KLao65t1KYz27nbobMfCLTHKOV
	 dvbzHRc/k8ekapMMwEQmYQdGWIrQ0qWyINV3sRZeDa9xUnKzgJrvf8Jp/gWu1CMtwx
	 I4EDwUHC9A+UqcX9+pF7EiOSUcasCow50eHFolYPkOFkoRMl5HxDlbCG97Ra0+CX+X
	 SAOLnVeAJBhOmX28EaEEoCjgupuAYU8+nAg9EkEftJdkWFyXBKo5DtNaJRs3UUYqdo
	 +pyCLiTGEPodg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Oct 2025 19:33:40 +0200
Subject: [PATCH 5.4.y 3/5] x86/boot: Compile boot code with -std=gnu11 too
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-v5-4-gcc-15-v1-3-6d6367ee50a1@kernel.org>
References: <20251017-v5-4-gcc-15-v1-0-6d6367ee50a1@kernel.org>
In-Reply-To: <20251017-v5-4-gcc-15-v1-0-6d6367ee50a1@kernel.org>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>, 
 "H. Peter Anvin (Intel)" <hpa@zytor.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Ard Biesheuvel <ardb@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3092; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5YeFtji4y5HM3kRjIcpX2gQzUdq9XBx5bFFcsgr3U+E=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI+1f6eZLswUyGt/orm7pU111m4/gndX14+T4ErvHju+
 c9VLE5GHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABexZmSYw7TqlfLVWcJ9alFn
 hW4mHpVaWzLze1JgcO0jm9e1bxObGP7nz998w3GbM8ukFdy2CqWygW8Ubu60OS+7qX75+7hrARX
 sAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Alexey Dobriyan <adobriyan@gmail.com>

commit b3bee1e7c3f2b1b77182302c7b2131c804175870 upstream.

Use -std=gnu11 for consistency with main kernel code.

It doesn't seem to change anything in vmlinux.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Link: https://lore.kernel.org/r/2058761e-12a4-4b2f-9690-3c3c1c9902a5@p183
[ This kernel version doesn't build with GCC 15:

    In file included from include/uapi/linux/posix_types.h:5,
                     from include/uapi/linux/types.h:14,
                     from include/linux/types.h:6,
                     from arch/x86/realmode/rm/wakeup.h:11,
                     from arch/x86/realmode/rm/wakemain.c:2:
    include/linux/stddef.h:11:9: error: cannot use keyword 'false' as enumeration constant
       11 |         false   = 0,
          |         ^~~~~
    include/linux/stddef.h:11:9: note: 'false' is a keyword with '-std=c23' onwards
    include/linux/types.h:30:33: error: 'bool' cannot be defined via 'typedef'
       30 | typedef _Bool                   bool;
          |                                 ^~~~
    include/linux/types.h:30:33: note: 'bool' is a keyword with '-std=c23' onwards
    include/linux/types.h:30:1: warning: useless type name in empty declaration
       30 | typedef _Bool                   bool;
          | ^~~~~~~

  The fix is similar to commit ee2ab467bddf ("x86/boot: Use '-std=gnu11'
  to fix build with GCC 15") which has been backported to this kernel.

  Note: In < 5.18 version, -std=gnu89 is used instead of -std=gnu11, see
  commit e8c07082a810 ("Kbuild: move to -std=gnu11"). I suggest not to
  modify that in this commit here as all the other similar fixes to
  support GCC 15 set -std=gnu11. This can be done in a dedicated commit
  if needed.
  There was a conflict, because commit 2838307b019d ("x86/build: Remove
  -m16 workaround for unsupported versions of GCC") and commit
  accb8cfd506d ("x86/realmode: build with -D__DISABLE_EXPORTS") are not
  in this version and change code in the context. -std=gnu11 can still
  be added at the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 69f0cb01c666..69930ed5574b 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -31,7 +31,7 @@ endif
 CODE16GCC_CFLAGS := -m32 -Wa,$(srctree)/arch/x86/boot/code16gcc.h
 M16_CFLAGS	 := $(call cc-option, -m16, $(CODE16GCC_CFLAGS))
 
-REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING \
+REALMODE_CFLAGS	:= -std=gnu11 $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
 		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=none)

-- 
2.51.0


