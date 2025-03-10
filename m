Return-Path: <stable+bounces-121806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCDAA59C65
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 065287A4F08
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB9B232367;
	Mon, 10 Mar 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aDQ49SlD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF5B230D3D;
	Mon, 10 Mar 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626682; cv=none; b=pwq2tJMROtKbe2r0fctG6gKo4Q1u4VwD2HHHP0oLuY+GuZm+BktjZ3RNNvvRXXns1pLeuEzIzBP29keTOvTmMZ9oBfhRCQnMCtf/C8s3XzfucnAiUywgPGwAMrH/n4p4fc5Q33JbUlFI6V/urxu8N//NUx0f9MTnxjj2gLNMRFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626682; c=relaxed/simple;
	bh=QwelUynC+k/WXZ0wpEiavr6+XPkrjcrjp2joBoNx1lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYtn6949XV2i5aQNJkQud202S5Tpk8JndZoOZrYy0AYTwlQZ7G+14at+Sl9wjZabnLGprcoQZQ48ppLdlajkC5exb3Uy0Ovg/hdc8N+N3nWoWlKqt7g3c2vO6r7MmQbPL2vfFTRlgQUQDsUGLx3VCWqU1BaIexJeof10TMMBPGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aDQ49SlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C41C4CEE5;
	Mon, 10 Mar 2025 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741626682;
	bh=QwelUynC+k/WXZ0wpEiavr6+XPkrjcrjp2joBoNx1lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aDQ49SlDif8ITgM18KspGrLG1dmBpus0B/c76hVBH3G1spNZlWMb7fAwyN5j1oOQO
	 L3FF4pmwGTab+wMnpP3I8Oeeawvh/hik9nYTW1AGb47krJAKtSddhIJfcWpGVZDtWJ
	 HAJuFycOgkqfoTnMbgIUzQypfydEquW3pVZo81DY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.13 044/207] x86/boot: Sanitize boot params before parsing command line
Date: Mon, 10 Mar 2025 18:03:57 +0100
Message-ID: <20250310170449.518856383@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
References: <20250310170447.729440535@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ardb@kernel.org>

commit c00b413a96261faef4ce22329153c6abd4acef25 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/boot/compressed/pgtable_64.c |    2 ++
 1 file changed, 2 insertions(+)

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
@@ -107,6 +108,7 @@ asmlinkage void configure_5level_paging(
 	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
+	sanitize_boot_params(bp);
 	boot_params_ptr = bp;
 
 	/*



