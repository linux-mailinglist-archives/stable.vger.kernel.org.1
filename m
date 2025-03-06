Return-Path: <stable+bounces-121325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22A3A558D8
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 22:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5E33ADCB0
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 21:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A30207676;
	Thu,  6 Mar 2025 21:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bZsjzzv9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AbHbZCHf"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25932207669;
	Thu,  6 Mar 2025 21:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296823; cv=none; b=rca1qIVbyKtVjMQNv+R+6afPvIx1aoesW/oizVPiI7xIO7quj4VFoDNUD9y0kPnPo39cUw7tl5KuTQ6CsluPvqoMX91xnqcJ2MSJJ2V91lkfbBykK0jiArMdjKN8v+mTvhNe+sADMXZb66BeiYuWYlTLv74ox28F1XTj6AcUhCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296823; c=relaxed/simple;
	bh=y5SFPMw1ZxPPYZSH5ahTZc4SyXIQztlkZlEL+XAXbA8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jkh+paJ39/FDAM/CwCOPzRXMOzXIEdGEcE/RwyV7qvOUtzXxj2fpWU8PvKCYlYAot75IcBeEUMjkVVfkgzr7gdY0FpZ4oySLAxJLC5t6SkfZa3h9Y+09rpkjy2vFi+Gi9waU7OrA5TCYOA9LAMsOXsV2I5RLEsiRU053BAV2eUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bZsjzzv9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AbHbZCHf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Mar 2025 21:33:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741296820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8keB3TccVIEx9x7nioQcAlV/fWzwl5jFltbXmTUFXs=;
	b=bZsjzzv9Xyv0DgQHTPd+MkrZxW1vXwjlnqdVrbP9rvcba26PNFo8mUTmrwcXkTRn6uTXr0
	cMbQ54glXQZsKboZRffGx2jabIFstS16cr9xiItjGOVsZBCJuPvJzBit7RaX4oIOfV2fT5
	V/1DinzaLVDBSuEry92f2GkMZ6kOz8yllOXbTbRDM4fquVqmUrJgvckfeLwipPW+xQSPNG
	uCSnFL3IVfD2YqjCOSCGskqepvmSZnfEJFMlIzeDrNORB0AgTXOp52dw23VnF5AL9DlmCL
	Ja296aeEfIQyxhgwpt+wv5HXql0u7C2y0Q3zJ1mrPg2/o2NWxUS5BTa2a4B2OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741296820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8keB3TccVIEx9x7nioQcAlV/fWzwl5jFltbXmTUFXs=;
	b=AbHbZCHfQfoqcLBa/EnTGIlzDo2/O6D4gW+CP4DwMrD4wV8Ezhq2IsOTt5UgOqbtcy0M0E
	M/HIo00hG4N6fLCQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/boot: Sanitize boot params before parsing command line
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,  <stable@vger.kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250306155915.342465-2-ardb+git@google.com>
References: <20250306155915.342465-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174129681612.14745.2037949092408216187.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c00b413a96261faef4ce22329153c6abd4acef25
Gitweb:        https://git.kernel.org/tip/c00b413a96261faef4ce22329153c6abd4acef25
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 06 Mar 2025 16:59:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Mar 2025 22:02:39 +01:00

x86/boot: Sanitize boot params before parsing command line

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
---
 arch/x86/boot/compressed/pgtable_64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index c882e1f..d8c5de4 100644
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

