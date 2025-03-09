Return-Path: <stable+bounces-121634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E584A588C1
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 23:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7244188BAAB
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 22:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196461AA1D2;
	Sun,  9 Mar 2025 22:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BwsRZ6Lk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9E713CFB6
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 22:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741557834; cv=none; b=EmcBnPakMIQO9sEta9PaKV8aoBwNaZ1sBzepF1FFs6l1S6CcUG7gKexDvyONad1BrDO8XuZYcH5Y0NERwUQNS614ojfgwrCu3DFA/3+UkSIedQSalV02NkZNU/gBU5Y/qJuS4VYcvT9ZxN0VZlWf+x+i9lISwj2vNXHA3QMXiDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741557834; c=relaxed/simple;
	bh=WlgttCev0sM/lAr8Dveoy3eihGaKM7ayXQLAI6CtWoU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BMa/i9P16qeIOp7gbhYb7sP7jOBghM+R8kTZkPmae48e2ypElT5zq0ezTNTt+up1vTAKGgtL9Wmv9NhgxEkZl5ULUNJkQYaypJk8wYMnn3jQ9fbw5DiCaP8KcA14R1F01LBZ5NWHuj2d+4dY1fvy9gwYT/Yysn+PZzYUq/GQc3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BwsRZ6Lk; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3912580843fso2311482f8f.2
        for <stable@vger.kernel.org>; Sun, 09 Mar 2025 15:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741557831; x=1742162631; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EF5JzM7X0nfENdYFyIH/3A8ZCi5sUX6xliumpSqbNEQ=;
        b=BwsRZ6Lk0Y6gU3xRde4AoZ3KBkq+HhGVDH6vJ018ZLZhcPvcn+TnEqsg9IN44Jbw/R
         bpIHRSKe531HBvEKcWMnaJdkBU8CF709/C3atoLPLQi8DS+pdf6BmuTMdg74YFAOJSQs
         UArTtEe3JCNWKhVnwPq/hd4E/gHymFyb4FQwVO2OSoOXCIkcCGi7MawqukaMJFgSkmom
         lZfmymvtVMSap9Oi5xp5gth5oPFQOxha1hPppWsE/uI4NCj4T7UQcAuZ56+NfSpj/T9h
         OdslzI/PvyQIQQ/AIUYM2B7cvKCVRbGOHN1rgz3Qw4BrYYZtJ3a6KGWEgrX7njdTK1FR
         2bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741557831; x=1742162631;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EF5JzM7X0nfENdYFyIH/3A8ZCi5sUX6xliumpSqbNEQ=;
        b=Rg4J4wnwoMfgStLmLEho+VfzAf69pnwv6kpPjGME1kjIQQNeoDGzFuqqT6tpDDI6Vf
         noOG1/OiBbb3BPn4a5hqD9HJmhrLCotpZHQQ4xLp2FmK8CNAyBFnZKdeaU+j71ilB6HY
         xavwWTkfe+WSkVFedoSvtqm9qmtLfD1kXg3OIOw6SODB0tyUqYnmADJPS7DcaxrwKagk
         cCEDOOixz1yKwh94I/tqj0VvQcN1OhXNxnZDlazBy40n0WwQqqHPvURRPPAobLC1VRET
         2/Z0v/49gn+73GoXzNSVPU1I7i7E/f27wUiYqjbYG8uDQc0N3S3V+ogL5XDwRHdB9fXw
         tcag==
X-Gm-Message-State: AOJu0YyrVF+stMAus1sBdZ6WY0vpVXflYiZ+8lkY/yevtZqV6bVC3u6w
	TJXvH2jsUhWnixnrV0yt7JQgB844odiqlgsADdRF9WpkWO6TRtpE40TeFjZhq2LhCAukRdLb6ON
	alfetb3wq5rjAVmVzO+3i6QGKCXckV9lu+m5tb447Ka6BfyjklAEcyu9ejkk0hKm+Lx6ag6K4Lj
	EtJdnlmD53YhIa6w8VWuoExw==
X-Google-Smtp-Source: AGHT+IF63r3Lbyu4dJXd5I0fMjVL1i9WmHG5v+3BzCf16WUp6i/iVS/SCLc/5ivRbdbM9HPSDK7TQ3UI
X-Received: from wmbay40.prod.google.com ([2002:a05:600c:1e28:b0:43b:c876:83fc])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1f8f:b0:391:2ba9:4c59
 with SMTP id ffacd0b85a97d-39132d986d7mr9302678f8f.43.1741557831633; Sun, 09
 Mar 2025 15:03:51 -0700 (PDT)
Date: Sun,  9 Mar 2025 23:03:20 +0100
In-Reply-To: <20250309220320.1876084-1-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250309220320.1876084-1-ardb+git@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250309220320.1876084-3-ardb+git@google.com>
Subject: [PATCH for-stable-6.x 2/2] x86/boot: Sanitize boot params before
 parsing command line
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

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
[ardb: resolve conflict]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/pgtable_64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 51f957b24ba7..15354673d3aa 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "misc.h"
+#include <asm/bootparam_utils.h>
 #include <asm/e820/types.h>
 #include <asm/processor.h>
 #include "pgtable.h"
@@ -106,6 +107,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
+	sanitize_boot_params(bp);
 	boot_params_ptr = bp;
 
 	/*
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


