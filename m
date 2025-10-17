Return-Path: <stable+bounces-187664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A120ABEACC5
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268643BADBC
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D4B29D26C;
	Fri, 17 Oct 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ljzn0BO8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B2E23536B;
	Fri, 17 Oct 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718257; cv=none; b=JGq7tIAMqgOKonoRR/eAQvq3lbUkcXo8flwL+A1uVSRtFuaOaiKybo2g/+hzLasdqDlf2d0z6puZ9SW466z7vNS69BkGcM8AHXHK5USXYMDyvYs8kwr8FAWkQBLJOHyAPO/afRtKFPFFPXcO/ZFgpjp9m+KXCOYulNOjAbXbXnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718257; c=relaxed/simple;
	bh=sEpXyWc8WPx+wgGW++vXxjuzS6Puz8c7VQa7fhvyQus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SfL+KNrSOLszrH+Fi7uov93Q1HSyd5oIsq3C4MhQJz0bbZkmdcFPvpEq8q6/Txyyi7vnUuXmzaxXOgQhiLWmyeYFe09UYTjKTUCUlMj/mSg5aZ5X8iEjuDkqqtq0oS4hsAtwEpbs+QStYwRxdU/KT/oiPvXU/+/iLX5/4QliKs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ljzn0BO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B6EC113D0;
	Fri, 17 Oct 2025 16:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760718257;
	bh=sEpXyWc8WPx+wgGW++vXxjuzS6Puz8c7VQa7fhvyQus=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ljzn0BO8rpBEDzd5EJgDMeLX2YxZIlbHDdBt6q3Xsb8P9nF6E1WeZXwWmDWNv39ut
	 sSUqh7Fi3uLDFMcQEDqGQ1MumVrINjuTv8+HjPvb3y1fFGqeKome0k67AMpnvIsLyi
	 /rusmz7ixcLjPANI4DcH7vFgor+tl7xMfc008bqhKDhpW9ZL8FHbIQQsHBCYpN9U4g
	 FCefp8kR0wK/aNYZtDobiNO/3MqBMKsP3igB07AObjAetGNntRO4DRCUJzDfgjl/Qk
	 wVgsDScWxd/kSlNIBY/aU9DG7+UMASPugj6TnBYS2MiGJMLjFQnMgl/+4hV071FrYR
	 gHjpafY0b3HBA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Oct 2025 18:24:00 +0200
Subject: [PATCH 5.15.y 1/3] x86/boot: Compile boot code with -std=gnu11 too
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-v5-15-gcc-15-v1-1-da6c065049d7@kernel.org>
References: <20251017-v5-15-gcc-15-v1-0-da6c065049d7@kernel.org>
In-Reply-To: <20251017-v5-15-gcc-15-v1-0-da6c065049d7@kernel.org>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>, 
 "H. Peter Anvin (Intel)" <hpa@zytor.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Ard Biesheuvel <ardb@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2817; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=C8xXiN4qk+ttj1GqxqW+f7yllK4/pnw5yfZZS2EX2Cg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI+5a4QTDsvdKHwzJPJwTVGM4qXfPqmUWKZdvGSu93qD
 aXTvbhUOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACayzJ+RYY5t3E2+2fWTjR9d
 dlm0V7D+0f79zWodkySXXDP9IbduewEjw3ubYL0Y/dOuu6RKz/Mc7YuaHXPph1XEYd2Z7hNMHp5
 5zwkA
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
  if needed. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 9c09bbd390ce..d5ee0b920dc0 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -24,7 +24,7 @@ endif
 
 # How to compile the 16-bit code.  Note we always compile for -march=i386;
 # that way we can complain to the user if the CPU is insufficient.
-REALMODE_CFLAGS	:= -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
+REALMODE_CFLAGS	:= -std=gnu11 -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
 		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
 		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=none)

-- 
2.51.0


