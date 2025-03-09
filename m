Return-Path: <stable+bounces-121577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E15A58326
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 11:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74811188E470
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 10:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76791BF24;
	Sun,  9 Mar 2025 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rzO+G8Nj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77339C2C8
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741516462; cv=none; b=CgozPSCzaGIlXlEam3gjnsKpqrST4OBEgUJWtZqWEyefGLcFracuxwIHWGCXSQimbY2hMKWHIz9sIfbOYqdcfWXdd6r5XtJb8uNXE6JMYljnjfdOoCISwIIYYF2+BF86TDr1WPvB+Ev08dT+Knl4gWJq2vqPZeWz+nkR/nz4DiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741516462; c=relaxed/simple;
	bh=2XAArhwLUYwCp0nsaPeZ3fWvIVdzFeoLprLNvRuWVMA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OHyVj4PTIJPj+C3cG3RQI7TBK/uCyrfxQI2GYIBHeQR0wEEk4qZ98KRtB31TZmIcfA08FJWS5HZp+bCtUc/qsjsfuL1n9u5DpRmMkyEIRXfbh+5qj7N02IWjhq94KYH3dwbWbVP8HNnpH1abwlZLoKZQxbbDB7g/h7bUthTQecQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rzO+G8Nj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6637CC4CEE5;
	Sun,  9 Mar 2025 10:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741516461;
	bh=2XAArhwLUYwCp0nsaPeZ3fWvIVdzFeoLprLNvRuWVMA=;
	h=Subject:To:Cc:From:Date:From;
	b=rzO+G8NjsZRJ36yXJWqr9jEox0ioKKTJmgtgNVnFzcEV78nYrnqp1I/tdaes2ixkm
	 W8lE5OWDH4OVZUysG9qVNr/GGwFNlkvPYvBwbFojdjhuPzpjSe5sRig7HH+8mrizTr
	 qwADNunH/5pZ5QWlX/1jkzZpcVbXsbN+2jJMfsoo=
Subject: FAILED: patch "[PATCH] x86/boot: Sanitize boot params before parsing command line" failed to apply to 6.6-stable tree
To: ardb@kernel.org,hpa@zytor.com,mingo@kernel.org,stable@vger.kernel.org,torvalds@linux-foundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Mar 2025 11:33:05 +0100
Message-ID: <2025030905-smooth-making-7a63@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c00b413a96261faef4ce22329153c6abd4acef25
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030905-smooth-making-7a63@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c00b413a96261faef4ce22329153c6abd4acef25 Mon Sep 17 00:00:00 2001
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 6 Mar 2025 16:59:16 +0100
Subject: [PATCH] x86/boot: Sanitize boot params before parsing command line

The 5-level paging code parses the command line to look for the 'no5lvl'
string, and does so very early, before sanitize_boot_params() has been
called and has been given the opportunity to wipe bogus data from the
fields in boot_params that are not covered by struct setup_header, and
are therefore supposed to be initialized to zero by the bootloader.

This triggers an early boot crash when using syslinux-efi to boot a
recent kernel built with CONFIG_X86_5LEVEL=y and CONFIG_EFI_STUB=n, as
the 0xff padding that now fills the unused PE/COFF header is copied into
boot_params by the bootloader, and interpreted as the top half of the
command line pointer.

Fix this by sanitizing the boot_params before use. Note that there is no
harm in calling this more than once; subsequent invocations are able to
spot that the boot_params have already been cleaned up.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <stable@vger.kernel.org> # v6.1+
Link: https://lore.kernel.org/r/20250306155915.342465-2-ardb+git@google.com
Closes: https://lore.kernel.org/all/202503041549.35913.ulrich.gemkow@ikr.uni-stuttgart.de

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index c882e1f67af0..d8c5de40669d 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "misc.h"
 #include <asm/bootparam.h>
+#include <asm/bootparam_utils.h>
 #include <asm/e820/types.h>
 #include <asm/processor.h>
 #include "pgtable.h"
@@ -107,6 +108,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
+	sanitize_boot_params(bp);
 	boot_params_ptr = bp;
 
 	/*


