Return-Path: <stable+bounces-40246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D988AA9D4
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC8C1C21E1E
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FE44DA0D;
	Fri, 19 Apr 2024 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qfbtLGbX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2AD4EB43
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514311; cv=none; b=tyXxyf1qlhBRPQKpAKvHpmoHpAbloQ6cdgRH2hJ7NZ/ebVVFzrvznnkrV2sO9wEilEwZY+0/RcM7Pj03evmHeddv1xcz9dVwrBC4zxBitWyOMzHohjpMpIzfZ0MtU4y4y8NvK4AB3Qv/RgyJdfyolkBweGcG9rUsj/xx6lSJUhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514311; c=relaxed/simple;
	bh=lhPXGXY+onwX/n1frEVD6LOiSq7/E2OYBHZlgTpfsJA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iaxboUPB3JO3zpOcQZLiSydgtXNlylILkZ3JiT+Gg+ybDQZnfTNZSQB/YLXhfqwotXjhVOfPtpfkcC6w+4NRKGEjTYKiAM/sZo9BQJ5l3XgfAOVzwYGnH6fUgUUiCTSlF/b5F2z9YUmCMj264eVsOJF6v2OKH1hSa9/6/eusdo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qfbtLGbX; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-41485831b2dso14552635e9.3
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514308; x=1714119108; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vF44MyyevKYyLFGBLIWZlKmeOMBXH9w4UNuChOhzo6Y=;
        b=qfbtLGbXhzCr1aE+kypIXry6PU3zfbvltLbR60kJOaBrF1Mvud306su1yPrH4W34gf
         6u+JTiL52LiBfQ4DG5JDanWS+pQ0b+m/cK3ySx6npHdGPrSsmyNt5NUDMZ4nMMkn5jQC
         YRbjS//YxAZugJV45GSi0ZqHhYTXPZrgtVtOYcSne6qHjEi+yA2CXXNa9BVu5nArzhfk
         q5NVlGUvjZ6pPYFT8LP9c2E3ZtXK7FX1TsfZbkGQ4VilGZR/2Ie1rSC9ztnAI+JG4WGH
         6OMS9oS6kFM9OixEke8UOKGb6S0irInn88bewwc03cl8YJLn64xREKiQy6WRmhHOWHOt
         3Hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514308; x=1714119108;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vF44MyyevKYyLFGBLIWZlKmeOMBXH9w4UNuChOhzo6Y=;
        b=fYlBG5E/fKkCShSgPp2KF4XnruSa8+BxyMsMr2G3ah2M6Xu6myN+j+NLq1K3nOEt6j
         fyCOTOC9W00y3UaTWqrKhpLP51hwNVIZPgkV2XiwiPPJSjk0qPUbgVEuOV4NsqAQ/Bwl
         npVurrsRZsiYNOW6d/bn4BoRdR1xmRCOFn0PyzM0Wki1OwwF4k009LSXHlcvTWxShbCi
         gcBDRhsKaZAM2fBpXWeGVwOpQreDkvNJmK2nxk2mdzpgEkd60ymAs5cKhNM+x1cHGqrQ
         yvKILDWedQT4oB+q5vPu4MwIC5Qs3CEXRtOIgMhXnaOlO86DlYfuW5r/t8B7/WWTr9Xg
         sOdw==
X-Gm-Message-State: AOJu0YyF8iIPuBuvutHWaiwIbYv7OlcLGNnPAGdj5j0OgtuRVQu5JHNT
	Wd4ElPCiDhvRxXNnc1psa0eqeyYKDxSo5mwnVpxS67QgbuF19qH3a/Q8GMzYI0btJ0PIa4yK8Wu
	TX62oLi1S5NROAYUCa6fWhBoqn+R9hXbPMBaDT5NmAjE9mLpxKiHfjwWBDtYNSCuB8tqC4hHZdH
	TWnvpGn+W9EDtl+vdrNwO9gQ==
X-Google-Smtp-Source: AGHT+IF4PVpU5A8qaZFbMzai8HCl8WK0QiBR2ndS/yorgf0fpGmFiquilwXRIS+JZHZY540A8IzjsdK7
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1d1d:b0:418:394c:e4dc with SMTP id
 l29-20020a05600c1d1d00b00418394ce4dcmr9369wms.3.1713514308550; Fri, 19 Apr
 2024 01:11:48 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:16 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3538; i=ardb@kernel.org;
 h=from:subject; bh=a7k3ykjfgAYlwBfJLw5z2GdpTJOTtGhucDMZzC2BG+I=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXbE4Vte1jm//9uuXJ0vasU4MDZqWEzxreuXVSvY4D
 X35Wd87SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwESYdzH8rzh9vvlrRVNz3abG
 rwIntDiF87rl2C7fNWW79UCgvaM3nZFh6eSkTXefeHSuzxRM0XfuzQg7s+ekuEVA/dm5/LuutOr zAAA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-35-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 10/23] x86/boot: Set EFI handover offset
 directly in header asm
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit eac956345f99dda3d68f4ae6cf7b494105e54780 upstream ]

The offsets of the EFI handover entrypoints are available to the
assembler when constructing the header, so there is no need to set them
from the build tool afterwards.

This change has no impact on the resulting bzImage binary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230915171623.655440-12-ardb@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 18 ++++++++++++++-
 arch/x86/boot/tools/build.c | 24 --------------------
 2 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index becf39d8115c..34ab46b891e3 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -523,8 +523,24 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
 # define INIT_SIZE VO_INIT_SIZE
 #endif
 
+	.macro		__handover_offset
+#ifndef CONFIG_EFI_HANDOVER_PROTOCOL
+	.long		0
+#elif !defined(CONFIG_X86_64)
+	.long		ZO_efi32_stub_entry
+#else
+	/* Yes, this is really how we defined it :( */
+	.long		ZO_efi64_stub_entry - 0x200
+#ifdef CONFIG_EFI_MIXED
+	.if		ZO_efi32_stub_entry != ZO_efi64_stub_entry - 0x200
+	.error		"32-bit and 64-bit EFI entry points do not match"
+	.endif
+#endif
+#endif
+	.endm
+
 init_size:		.long INIT_SIZE		# kernel initialization size
-handover_offset:	.long 0			# Filled in by build.c
+handover_offset:	__handover_offset
 kernel_info_offset:	.long ZO_kernel_info
 
 # End of setup header #####################################################
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 14ef13fe7ab0..069497543164 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -55,8 +55,6 @@ u8 buf[SETUP_SECT_MAX*512];
 #define PECOFF_COMPAT_RESERVE 0x0
 #endif
 
-static unsigned long efi32_stub_entry;
-static unsigned long efi64_stub_entry;
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
 static unsigned long _end;
@@ -265,31 +263,12 @@ static void efi_stub_defaults(void)
 #endif
 }
 
-static void efi_stub_entry_update(void)
-{
-	unsigned long addr = efi32_stub_entry;
-
-#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
-#ifdef CONFIG_X86_64
-	/* Yes, this is really how we defined it :( */
-	addr = efi64_stub_entry - 0x200;
-#endif
-
-#ifdef CONFIG_EFI_MIXED
-	if (efi32_stub_entry != addr)
-		die("32-bit and 64-bit EFI entry points do not match\n");
-#endif
-#endif
-	put_unaligned_le32(addr, &buf[0x264]);
-}
-
 #else
 
 static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
 static inline void update_pecoff_text(unsigned int text_start,
 				      unsigned int file_sz) {}
 static inline void efi_stub_defaults(void) {}
-static inline void efi_stub_entry_update(void) {}
 
 static inline int reserve_pecoff_reloc_section(int c)
 {
@@ -332,8 +311,6 @@ static void parse_zoffset(char *fname)
 	p = (char *)buf;
 
 	while (p && *p) {
-		PARSE_ZOFS(p, efi32_stub_entry);
-		PARSE_ZOFS(p, efi64_stub_entry);
 		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
 		PARSE_ZOFS(p, _end);
@@ -416,7 +393,6 @@ int main(int argc, char ** argv)
 
 	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
 
-	efi_stub_entry_update();
 
 	crc = partial_crc32(buf, i, crc);
 	if (fwrite(buf, 1, i, dest) != i)
-- 
2.44.0.769.g3c40516874-goog


