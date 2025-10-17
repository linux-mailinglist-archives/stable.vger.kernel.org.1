Return-Path: <stable+bounces-187663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1106DBEACA4
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED6F966281
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9632929C325;
	Fri, 17 Oct 2025 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxCCBEEn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505AE258ECF;
	Fri, 17 Oct 2025 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718255; cv=none; b=eBEVEZQiQ9c0VDTEED+O6IpzYzhdoeivaMYPbAHBPU16ZKlr4dRAHL8y2xRcabEk/mKXlg/2mn7HLXQg/ioC7Ol7znetdCyo5Ol5+PcCvr3Ds36xJEJX8+yqElhqGncApEhFErhn6tT6y25IZvLBKwdJfhQDJRCb1fhVzqjJqfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718255; c=relaxed/simple;
	bh=46TQSPigHf5AnxxA3qcaZcsf/kBafWeQY87jhCkVJxM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZXWyjGqCv8rha57hjWddPDHww+sE8/LfzxebHswqYyyufiAGtkXTgSO8T1GLmjTdIunoS2Z4AxO7Cq871FdEgVWMWIJNj2TO3DIX2Cf3UNqozGA8MeyRQRh66o4gO6KWbMy/2tgqnt5KWb9q5j/DkKopMu2w6FCWXX3zpM3u+Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxCCBEEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC53C4CEE7;
	Fri, 17 Oct 2025 16:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760718254;
	bh=46TQSPigHf5AnxxA3qcaZcsf/kBafWeQY87jhCkVJxM=;
	h=From:Subject:Date:To:Cc:From;
	b=mxCCBEEnTG7ovqNv52ouf3Q5RZWVzXdYhKv3+2QD4bUZEz9sF0NUwN8fhUR8mC9hc
	 hUMYK1NfXNCkQBFewNyEKEdZiSTPUeyil2ukav7xG4XNvZRi0spnaxGdMBqQGl0jl+
	 NPjHi6rtwKpFKg3ZvMOIIb2QCxHT85GO90DKsn65qgLzHLXSPOYwicrABqWZCQyVa6
	 jc0ZBrQ9bbeSzQ+tJwjrCQnNF+jaPJvYixnUXsZX5XNHGyYnVQJiOH6WFD3hbruIsB
	 PqFULY5dL7maTRxkwxBGAJwY1lZ98CEvH8sDEiSnSZmCqrxWAYKQLmjV9eUqmlPVJb
	 p+aMDS+QZrXhw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 5.15.y 0/3] v5.15: fix build with GCC 15
Date: Fri, 17 Oct 2025 18:23:59 +0200
Message-Id: <20251017-v5-15-gcc-15-v1-0-da6c065049d7@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ9t8mgC/x2MQQqAIBAAvxJ7TmmFxegr0cFsq71UKEgh/j3rN
 MxhJkPkIBxhaDIEThLlPKpg24Df3bGxkqU6mM4QdmhVIoWkNu8/kOfF9TwzWQs1uQKvcv+7EUg
 j6QemUl73qWjyZgAAAA==
X-Change-ID: 20251017-v5-15-gcc-15-5ceda8ebe577
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>, 
 "H. Peter Anvin (Intel)" <hpa@zytor.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Akira Yokosawa <akiyks@gmail.com>, 
 Federico Vaga <federico.vaga@vaga.pv.it>, Alex Shi <alexs@kernel.org>, 
 Hu Haowen <src.res@email.cn>, 
 Tsugikazu Shibata <shibata@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2949; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=46TQSPigHf5AnxxA3qcaZcsf/kBafWeQY87jhCkVJxM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI+5S7v2np1x0v7ewmmp5+GnVBcb3r7t3p/fJTPVRaXr
 dq3Sq4qdZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEwkrYLhf3rWy+u5tzi4Vmjs
 FIrK3ZW+7T1749FQ52nMS/MDbGYrMjL89/ZYJKYc6FqutqgkTeUy45oChu7WiJ5Vs3xbbrnUbRb
 hBwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This kernel version doesn't build with GCC 15:

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
the GCC 15 release and not mentioning the error I had. This is the first
patch.

When I was investigating my error, I noticed other commits were already
backported to v5.15. They were all adding -std=gnu11 in different
Makefiles. In their commit message, they were mentioning 'gnu11' was
picked to use the same as the one from the main Makefile. But this is
not the case in this kernel version. Patch 2 fixes that.

Finally, I noticed the documentation was not correct in this kernel
version: this is because a commit was backported to v5.15 while it was
not supposed to. Patch 3 fixes that.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Alexey Dobriyan (1):
      x86/boot: Compile boot code with -std=gnu11 too

Matthieu Baerts (NGI0) (2):
      arch: back to -std=gnu89 in < v5.18
      Revert "docs/process/howto: Replace C89 with C11"

 Documentation/process/howto.rst                    | 2 +-
 Documentation/translations/it_IT/process/howto.rst | 2 +-
 Documentation/translations/ja_JP/howto.rst         | 2 +-
 Documentation/translations/ko_KR/howto.rst         | 2 +-
 Documentation/translations/zh_CN/process/howto.rst | 2 +-
 Documentation/translations/zh_TW/process/howto.rst | 2 +-
 arch/parisc/boot/compressed/Makefile               | 2 +-
 arch/s390/Makefile                                 | 2 +-
 arch/s390/purgatory/Makefile                       | 2 +-
 arch/x86/Makefile                                  | 2 +-
 arch/x86/boot/compressed/Makefile                  | 2 +-
 drivers/firmware/efi/libstub/Makefile              | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)
---
base-commit: 06cf22cc87e00b878c310d5441981b7750f04078
change-id: 20251017-v5-15-gcc-15-5ceda8ebe577

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


