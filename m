Return-Path: <stable+bounces-187682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8864EBEB142
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 19:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DE43B1BA2
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72A430649A;
	Fri, 17 Oct 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbI+Id2J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03352E4254;
	Fri, 17 Oct 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760722433; cv=none; b=g8uQfNyPQa2Tf2zsokm4thRxyNKevSgJTQ0IYKRhzUGnXTEKytUOlYn6qKnw2oNDn40iVVbcc8zR+yIsWI3o+73f2R+vS81NmzpMWmKj6Nav02LTjOmOZrSQxQXwHL+Olk8fb+bNQ1AsNoPU+q2MwsOOSSNmNacmjSHWWv8HFiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760722433; c=relaxed/simple;
	bh=ld5+olC/DnGpYRVDW+48NSZXVONg1fDqPUONiGRoliY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EGeNVIIQbRl/xEOrY4nz925V8WWQOrjZPk4T6zZyZuGAq3vbmLmPR543PlKUoHkEM5Q56zeJrUjRhyrjIW9d8EjcVfnI6Jp12kIWfC4cgeu4+9fPrC+2V+2/8Az5XuMm9E++u9Dq+NC2SPZHnh1EW5UW9wDMrC4I+GghjjTUN2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbI+Id2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52059C4CEE7;
	Fri, 17 Oct 2025 17:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760722433;
	bh=ld5+olC/DnGpYRVDW+48NSZXVONg1fDqPUONiGRoliY=;
	h=From:Subject:Date:To:Cc:From;
	b=GbI+Id2J+wvdI+64U0OStsctOny5SivXLoGAlOnBoRXLzQJcSwsBNfTDAEtv+nPom
	 +hitcxQdg9Zxw24kGADR2cLjsN8p3kbONw79JPETM3ElnjBXjxYYqa38vSMOuH/I9i
	 t6oxPFqSqVgYeupQNF8viS2BRKw4NSyGhaUr9vpFAQK//OLlku5KWB9qmAuS/yqXss
	 NDz8taDHp/cSvAPEZQKzE6paNEDDyPehy88608e2RVZahlYp9VRJ/yUFnabbnNRijF
	 u2hCLCfITDAZ3MkC3ofgfIw0/sgz1k5Q8WALmr1k2uNjoPJ6y37zOnjL0Q2smaSHS4
	 2qh4XRrpDHRpw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 5.4.y 0/5] v5.4: fix build with GCC 15
Date: Fri, 17 Oct 2025 19:33:37 +0200
Message-Id: <20251017-v5-4-gcc-15-v1-0-6d6367ee50a1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPF98mgC/x3MMQqAMAxA0atIZiNtbBG8ijhoGmsWlRZEEe9uc
 XzD/w9kSSoZ+uqBJKdm3bcCW1fA67RFQQ3FQIa8NbbD06PDyIzWIwVinlvjWmIoxZFk0eu/DeA
 b19wwvu8HcGBtz2QAAAA=
X-Change-ID: 20251017-v5-4-gcc-15-2d2ccb30432c
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Kostadin Shishmanov <kostadinshishmanov@protonmail.com>, 
 Jakub Jelinek <jakub@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
 Ard Biesheuvel <ardb@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
 Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin (Intel)" <hpa@zytor.com>, 
 Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <natechancellor@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2922; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ld5+olC/DnGpYRVDW+48NSZXVONg1fDqPUONiGRoliY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI+1X5/fe7MkycvirpPlxWFbrRpDZba77Xxjm3iAocfu
 9fN2XXqYkcpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEGqMYGf6s2bXgMPuWkq9O
 2o0fyt8+fnL4S4PPvpt7N2r9l/aYqrOPkWHhUq2+ng0fdfMfpGnKT7DXZlyeeG1jy6z6TdemlUq
 21LAAAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Two backports linked to build issues with GCC 15 have failed in this
version:

  - ee2ab467bddf ("x86/boot: Use '-std=gnu11' to fix build with GCC 15")
  - 8ba14d9f490a ("efi: libstub: Use '-std=gnu11' to fix build with GCC 15")

Conflicts have been solved, and described.

After that, this kernel version still didn't build with GCC 15:

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

I initially fixed this by adding -std=gnu11 in arch/x86/Makefile, then I
realised this fix was already done in an upstream commit, created before
the GCC 15 release and not mentioning the error I had. This is patch 3.

When I was investigating my error, I noticed other commits were already
backported to stable versions. They were all adding -std=gnu11 in
different Makefiles. In their commit message, they were mentioning
'gnu11' was picked to use the same as the one from the main Makefile.
But this is not the case in this kernel version. Patch 4 fixes that.

Finally, I noticed extra warnings I didn't have in v5.10. Patch 5 fixes
that.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Alexey Dobriyan (1):
      x86/boot: Compile boot code with -std=gnu11 too

Matthieu Baerts (NGI0) (1):
      arch: back to -std=gnu89 in < v5.18

Nathan Chancellor (3):
      x86/boot: Use '-std=gnu11' to fix build with GCC 15
      efi: libstub: Use '-std=gnu11' to fix build with GCC 15
      kernel/profile.c: use cpumask_available to check for NULL cpumask

 arch/parisc/boot/compressed/Makefile  | 2 +-
 arch/s390/Makefile                    | 2 +-
 arch/s390/purgatory/Makefile          | 2 +-
 arch/x86/Makefile                     | 2 +-
 arch/x86/boot/compressed/Makefile     | 1 +
 drivers/firmware/efi/libstub/Makefile | 2 +-
 kernel/profile.c                      | 6 +++---
 7 files changed, 9 insertions(+), 8 deletions(-)
---
base-commit: cda7d335d88aa30485536aee3027540f41bf4f10
change-id: 20251017-v5-4-gcc-15-2d2ccb30432c

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


