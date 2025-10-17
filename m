Return-Path: <stable+bounces-187673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B208BBEAF7B
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 19:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C6E744CDA
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFA52EB866;
	Fri, 17 Oct 2025 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1Bg3h5u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38562E06D2;
	Fri, 17 Oct 2025 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720031; cv=none; b=dwHTEx7vu+oitMEnCu0M8qaE/WuEJAn+wIRgd4HKBbpGprDFYOK08UGcWgiQT6YLSYizcLm/yqqiDwcH6t5rfKkFu3NGI36wgqUTPC0o7rQVFmf1kOHn5bYGWMCYcF4uTmZaRwSXo87NZ2PJLzobSkDk9Th2/2+8LcEEJbaUUJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720031; c=relaxed/simple;
	bh=56kXImUOjI7S0JtfattLR6VoUm8jYTpY84IFUYVfYAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lr5pvU0n4DP63eHhd40xA5V1uoy+cxFhRxnpagraA7Cv4mjeYi2tyejBXA+lrePRuvqeRDVOlkAuH9JmS0b9WaQSdwe9XlTKI+4cxoW0ykf1d8zgwYI0CQuVA7N9RtcnkZppsi64anDZLmlF4RDml3Ps/hrwTGkoBuHlH7SsPFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1Bg3h5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A99C4CEFE;
	Fri, 17 Oct 2025 16:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760720031;
	bh=56kXImUOjI7S0JtfattLR6VoUm8jYTpY84IFUYVfYAo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C1Bg3h5ueGjboU/TprejgVFM0X5oYVxaiYV/tg6jdLnIgNF4Ll/pSmvnEJ5ly+ZGE
	 3l640KjuYLptQ7+v3YIte0WQxs/sJm1tq7LPfiLq/038dD6lCX0CMcbkVeXMwUGa5M
	 RRdBdNfS3xzDs5zQV2/VpK3bSJQxF3zo9z6FIn8rWH/reR17jhXcon2SQj6c6Hs6oy
	 w0ZdjZfWjHRwt5uyIMRe+d5w1dfdoWZD46u38hI2jvZI2EXfkD+BGWTcSSjN4fiujP
	 EIt0x26lukeeYN2JppehofcFOGHEn0QyzGY2y9UHUoS1k5WMr4nLBYUCDVApA8AB2l
	 KF0HKelxiJnbA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Oct 2025 18:53:25 +0200
Subject: [PATCH 5.10.y 1/3] x86/boot: Compile boot code with -std=gnu11 too
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-v5-10-gcc-15-v1-1-cdbbfe1a2100@kernel.org>
References: <20251017-v5-10-gcc-15-v1-0-cdbbfe1a2100@kernel.org>
In-Reply-To: <20251017-v5-10-gcc-15-v1-0-cdbbfe1a2100@kernel.org>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>, 
 "H. Peter Anvin (Intel)" <hpa@zytor.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Ard Biesheuvel <ardb@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3055; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Vm/w1YyWqDcVlHEO1pDghuv63FD1ynM2aKxxlwUTgv0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI+lUy7b7z+ZsLLphDGxPjl0w0UHT7tb7biZT8uatT3b
 M0zdku+jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIn4ZjD893v64zhX9mcFm3bW
 fz0Pnkuuf9SZwK7fMCfXL/OasfNXY0aGfzvjHp3Zzpu05H3qR+8/J3XFP6y482nVS99PXgLHdKN
 zuQE=
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
  -m16 workaround for unsupported versions of GCC") is not in this
  version and change code in the context. -std=gnu11 can still be added
  at the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 8b9fa777f513..f584d07095f1 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -31,7 +31,7 @@ endif
 CODE16GCC_CFLAGS := -m32 -Wa,$(srctree)/arch/x86/boot/code16gcc.h
 M16_CFLAGS	 := $(call cc-option, -m16, $(CODE16GCC_CFLAGS))
 
-REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
+REALMODE_CFLAGS	:= -std=gnu11 $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
 		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=none)

-- 
2.51.0


