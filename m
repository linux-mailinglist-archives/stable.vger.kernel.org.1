Return-Path: <stable+bounces-40242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F208AA9D1
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E088CB21AB9
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6AA4E1AD;
	Fri, 19 Apr 2024 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LGoAQRc9"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C936A3A1A8
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514302; cv=none; b=dEYVAfKIpcz7rtdR1UROvAX2OB7i/VNdt7EbaPiuKKqN/EPyisG7vygJP4jCDKubqtB9qAMkGXAAEna0joqXC3kc8eUgOoMR+2/7WK0foo93J4aX5FYEk8bs2ZcmwRUw8LBLXQs+46MUsPlqGm7V0UyIBDYmfdt7lzkQys1bMLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514302; c=relaxed/simple;
	bh=18XDpqJz80CqecZKaoC3ynCGOruJl8RzlCgjb/CIUZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=D5lMRDQAyyfizsFoqAFu5nh7mL2kIDj4QWbsdFlhiIqERDj5mijdpJ+yUehJtqfF3StOT0JANJCzaimWPvJRVue5lefdMK0woAN2Oxe6jOzlc7PC0d2zwIhCv1Y1AB/EeWemnNAKmy/tfyhSilc6XsqqZnQj/ZiDjS+8nZp7qEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LGoAQRc9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b2abd30f9so22478677b3.0
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514300; x=1714119100; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3ZmRQH6ImzlNG6vwerHEhLNZsBTXc5jiqBc3TwHTiQ=;
        b=LGoAQRc9ftQ12Ek9iUitw/4N7oCsgzl/edbFd+XhE42pxzzDIioBxcQFsEAnfydAm0
         TWJYh7JsMJQMugAOUKB8TldLaGadBhMrwwiR5CNysyUXgLFotW1To0ZkPhtZVYS22y1V
         GNb5EKEtVMmtV2J09F1ooytsOEDNrSseQv/M8LYuIGxuKLXuWY3WPEVM1K5QyTgOQ5ey
         Nn4h60Ea3nZp83tEcQw3nKALOAyIhbnGmqoXipF7H3o0R+NgIyvIQ08rroIUnyqFNDZH
         QBkYnYEiw2U1Ipx6Iu1GBymSLpNru7KwReRNTzoCBGdhucJBkS6yIi3IwyqGxXhbLv9L
         RWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514300; x=1714119100;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3ZmRQH6ImzlNG6vwerHEhLNZsBTXc5jiqBc3TwHTiQ=;
        b=SxRS+BCQJxVRX3chHeoNVPuknHg4iYzYuQefM+N2EMFAc1MIRKyUy5Y+K3OrZHqeu5
         UFDA2GMMQ0Ll2iL9PZPhatMHXM/qKfowjFXPAlUkGcGMuMZaNxjjcAdKVHa9w0JPwntJ
         ogQ4RMAnzOmkGrRx7BIc87GIsWzkhqCMxdtAA7/WenFAnhm53XISRDdDd3HCIK7AE6+t
         oMtUYWSCzuRCrOq3KZW3FoN+01PZjuW8h3dLPj8z3uznuxyaumo8FEBlaTn2N7MRwKOk
         xotl9BsK2HmV3fISmfYymRdCnSwkQTtAi2xP+YvoCmGE+cTEvRKv22IVGhzzi430N4tE
         ad5g==
X-Gm-Message-State: AOJu0Yz159298WbItZRiyjaFLanPcklwS2WAHN0D6BR9mgJkTdNgQ/9J
	RG0i6UxvYF04TMvAvvGc+j+Lf8OUrYlgpFDZiM76Zc8dBeLIdSYCqQrREjeL6fi5koTWB03z5NH
	3zZmcXjtchEdMbKsQNHXI9j018Bv+Ci5WUOXXfthFRgc6DlrHH3uqQo9GVDdMLedLxQDs1BtvBh
	+36HukESGD8wRutLaFBkcN0A==
X-Google-Smtp-Source: AGHT+IGkhas0WGfy+mbYoKkSJVy5vwHZBLoLEiSezjbEbnMTW/nYiqketT91FXy4fBWk/n5IY/ksFWJU
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a0d:ed47:0:b0:618:511e:c54c with SMTP id
 w68-20020a0ded47000000b00618511ec54cmr342143ywe.0.1713514299906; Fri, 19 Apr
 2024 01:11:39 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:12 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5475; i=ardb@kernel.org;
 h=from:subject; bh=7yEW1HeWl3Aq+nmI0V4r/gCiWQzdN9hWnAP71iwlOio=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXU57zdFtARnqv94EC/rKfCmNm3s+5nD7xxdzOQt/9
 0v9lZboKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABO5e5WRYe+qvV+vpZ5c/2ab
 iMgSh8iq4wf+WpYeclpXKrwoSPRa4B2Gv6JPquMb071LEnde+bFW7Wu05Pu6G0X3ODWawuytWCQ WcQEA
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-31-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 06/23] x86/boot: Omit compression buffer from
 PE/COFF image memory footprint
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 8eace5b3555606e684739bef5bcdfcfe68235257 upstream ]

Now that the EFI stub decompresses the kernel and hands over to the
decompressed image directly, there is no longer a need to provide a
decompression buffer as part of the .BSS allocation of the PE/COFF
image. It also means the PE/COFF image can be loaded anywhere in memory,
and setting the preferred image base is unnecessary. So drop the
handling of this from the header and from the build tool.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230912090051.4014114-22-ardb@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      |  6 +--
 arch/x86/boot/tools/build.c | 50 +++-----------------
 2 files changed, 8 insertions(+), 48 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b8d241e57b49..98dd4c36ccca 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -89,12 +89,10 @@ optional_header:
 #endif
 
 extra_header_fields:
-	# PE specification requires ImageBase to be 64k aligned
-	.set	image_base, (LOAD_PHYSICAL_ADDR + 0xffff) & ~0xffff
 #ifdef CONFIG_X86_32
-	.long	image_base			# ImageBase
+	.long	0				# ImageBase
 #else
-	.quad	image_base			# ImageBase
+	.quad	0				# ImageBase
 #endif
 	.long	0x20				# SectionAlignment
 	.long	0x20				# FileAlignment
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index bd247692b701..0354c223e354 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -65,7 +65,6 @@ static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
 static unsigned long kernel_info;
 static unsigned long startup_64;
-static unsigned long _ehead;
 static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
@@ -229,27 +228,14 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
 #endif
 }
 
-static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
-			       unsigned int init_sz)
+static void update_pecoff_text(unsigned int text_start, unsigned int file_sz)
 {
 	unsigned int pe_header;
 	unsigned int text_sz = file_sz - text_start;
-	unsigned int bss_sz = init_sz - file_sz;
+	unsigned int bss_sz = _end - text_sz;
 
 	pe_header = get_unaligned_le32(&buf[0x3c]);
 
-	/*
-	 * The PE/COFF loader may load the image at an address which is
-	 * misaligned with respect to the kernel_alignment field in the setup
-	 * header.
-	 *
-	 * In order to avoid relocating the kernel to correct the misalignment,
-	 * add slack to allow the buffer to be aligned within the declared size
-	 * of the image.
-	 */
-	bss_sz	+= CONFIG_PHYSICAL_ALIGN;
-	init_sz	+= CONFIG_PHYSICAL_ALIGN;
-
 	/*
 	 * Size of code: Subtract the size of the first sector (512 bytes)
 	 * which includes the header.
@@ -257,7 +243,7 @@ static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
 	put_unaligned_le32(file_sz - 512 + bss_sz, &buf[pe_header + 0x1c]);
 
 	/* Size of image */
-	put_unaligned_le32(init_sz, &buf[pe_header + 0x50]);
+	put_unaligned_le32(file_sz + bss_sz, &buf[pe_header + 0x50]);
 
 	/*
 	 * Address of entry point for PE/COFF executable
@@ -308,8 +294,7 @@ static void efi_stub_entry_update(void)
 
 static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
 static inline void update_pecoff_text(unsigned int text_start,
-				      unsigned int file_sz,
-				      unsigned int init_sz) {}
+				      unsigned int file_sz) {}
 static inline void efi_stub_defaults(void) {}
 static inline void efi_stub_entry_update(void) {}
 
@@ -360,7 +345,6 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, efi32_pe_entry);
 		PARSE_ZOFS(p, kernel_info);
 		PARSE_ZOFS(p, startup_64);
-		PARSE_ZOFS(p, _ehead);
 		PARSE_ZOFS(p, _end);
 
 		p = strchr(p, '\n');
@@ -371,7 +355,7 @@ static void parse_zoffset(char *fname)
 
 int main(int argc, char ** argv)
 {
-	unsigned int i, sz, setup_sectors, init_sz;
+	unsigned int i, sz, setup_sectors;
 	int c;
 	u32 sys_size;
 	struct stat sb;
@@ -442,31 +426,9 @@ int main(int argc, char ** argv)
 	buf[0x1f1] = setup_sectors-1;
 	put_unaligned_le32(sys_size, &buf[0x1f4]);
 
-	init_sz = get_unaligned_le32(&buf[0x260]);
-#ifdef CONFIG_EFI_STUB
-	/*
-	 * The decompression buffer will start at ImageBase. When relocating
-	 * the compressed kernel to its end, we must ensure that the head
-	 * section does not get overwritten.  The head section occupies
-	 * [i, i + _ehead), and the destination is [init_sz - _end, init_sz).
-	 *
-	 * At present these should never overlap, because 'i' is at most 32k
-	 * because of SETUP_SECT_MAX, '_ehead' is less than 1k, and the
-	 * calculation of INIT_SIZE in boot/header.S ensures that
-	 * 'init_sz - _end' is at least 64k.
-	 *
-	 * For future-proofing, increase init_sz if necessary.
-	 */
-
-	if (init_sz - _end < i + _ehead) {
-		init_sz = (i + _ehead + _end + 4095) & ~4095;
-		put_unaligned_le32(init_sz, &buf[0x260]);
-	}
-#endif
-	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16), init_sz);
+	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
 
 	efi_stub_entry_update();
-
 	/* Update kernel_info offset. */
 	put_unaligned_le32(kernel_info, &buf[0x268]);
 
-- 
2.44.0.769.g3c40516874-goog


