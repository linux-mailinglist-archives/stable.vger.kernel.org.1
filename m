Return-Path: <stable+bounces-40245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36878AA9D3
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FE41F22D3A
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DC44D59F;
	Fri, 19 Apr 2024 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cxCC/+jI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D461B4E1DC
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514309; cv=none; b=hyuXnqDJd6ASDpxpDyCaP/Np7JFlsdqVlgtPHVH3A7AJyiPS+xmM6hLeXqNQgDS8tUQ5R8JiDEXnehbLGv3auuIt+Zvp/CDxqlYET4HphTrGWR8/mXWi1B2GcsVbxUOhtveIwxZlK5P55RgDKZPhj5i74CYwX62RNYs9KV49xdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514309; c=relaxed/simple;
	bh=EnPybLPrcfC1KvtMrOf0aZJRZsXC4SEUncM93mbBLuE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hvU0POZsD6pOxi9pCu/BuyJ+P0dyDUEUlX/ij+gcxf9huDfNdUPytDB9rtS/f7FFs2kd8LS5v1VozyTsbjMA503bah9sqUS3qw6aq7je4x3QWQF5LqN1adlkhW81SwPH8G27w/N+/JFKL2g6tTNDk6mWoi++hVTG0TsoeDpvriE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cxCC/+jI; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4155db7b58cso10067065e9.1
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514306; x=1714119106; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=931l5HeTRo7Krk/0BorRD0UDsLe+V1jXJh+O6eymDiQ=;
        b=cxCC/+jIV8s2gnWBMIbK2qZT5yDOwiZE8IxNIalroZk3oxpcqbq+o0nMSqpLg1cs6T
         qcOs0ntg5dBwyIc/SMXje6GPJo8DkTUtNimpI4ibyxND3nbpPgVyDqLwDwfzWS4prZqT
         AqPWy3wl0nenmvM/wrkmkCzFDyD25TyrzMAlwzBX05EUG0TYFSKI4VxoBVsgazKuXXpi
         3BNsZZ0rzwbKVktAdsBHmo8OA0T/jEAbAv8ALwXD7tbJGBGizdPaHP5klo1qdFHrGJZn
         lIGyVZfgDH7k1maUE06hPFQxjcqvq/l4kBv5JKmc4zvYhcGXJSWVJHzxJxtb8kmIjpwH
         zXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514306; x=1714119106;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=931l5HeTRo7Krk/0BorRD0UDsLe+V1jXJh+O6eymDiQ=;
        b=CVwIupAHo3sp63utrwIdKgm1DoZ8f9aLD3VuojMOpETNEmduriQtM946d64Fcb0VoC
         FfXh02wkpqrTAtLorBlGCQuj2CBE1xdY/UFqUx/WiWnk2q6gWtBdtkR4PNNV4pcmDgzC
         av/F4AJgAxBBS8C+ozYaZrWmJC+CgcaFCr0IxwFX/KWtPiY5kM6U+RD/bB9sWWI6G9NU
         QuJnpCyKUKc3xM3l1Psw1QgaBNv0GnfJT4/sk55w/DwqmSy05k2L9Q/3K92ex4DRQTZs
         bfnwRejwYz+z1ee+O/9WjokeMFT60LIfQvBJ8sBIC7jrgsfZl79n7SWdV1WjvXYexIUy
         y8Uw==
X-Gm-Message-State: AOJu0YxeigpKK3Gs/4qg0Q02JYYPoeEmGS23DIf41+wTCnTxWgT2l18k
	QKUUxrHznbuRCj+jPWYgsNzcag6OZf2QWiSHkv8Vtyqzxfwd0kCG7kdIR/RaFOPSVgBLC/r9Aax
	R/+pBQ+3MSca1XdNR16Cft7C1teB7vVj9shco/VUcTkFR09MV515RUYG+3YI36z148IHN86KZhD
	mnnyaSJsy9ksjWNmmgzyOT6A==
X-Google-Smtp-Source: AGHT+IGNcx0lKichLPLZKRomXgbAeiRgLtwQkG/YimTojQ2dYwf0kdvsKB1l4DicMoCSjcRlNfXSaxSh
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1c95:b0:418:f466:2611 with SMTP id
 k21-20020a05600c1c9500b00418f4662611mr4635wms.3.1713514306280; Fri, 19 Apr
 2024 01:11:46 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:15 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2304; i=ardb@kernel.org;
 h=from:subject; bh=aRg6AIj2qaGrFeECZGqhdIJ3kqrHtVn9V6FON7C1cOs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXeHdtrIu3foOzePW3zTjGBdwP4k+ct9b08fkXPX+Y
 xarRdg7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETW6DH84Tvs+sE8M+AVk9rK
 iWsYP+VeldqSU2+vfy7928+/t+v3JTIyTBE4VKe+dmXJ0fMX2i5/j2ANjUm3CGL+eHpK2NZqi9i LLAA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-34-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 09/23] x86/boot: Grab kernel_info offset from
 zoffset header directly
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 2e765c02dcbfc2a8a4527c621a84b9502f6b9bd2 upstream ]

Instead of parsing zoffset.h and poking the kernel_info offset value
into the header from the build tool, just grab the value directly in the
asm file that describes this header.

This change has no impact on the resulting bzImage binary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230915171623.655440-11-ardb@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 2 +-
 arch/x86/boot/tools/build.c | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index f63bf3ec6869..becf39d8115c 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -525,7 +525,7 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
 
 init_size:		.long INIT_SIZE		# kernel initialization size
 handover_offset:	.long 0			# Filled in by build.c
-kernel_info_offset:	.long 0			# Filled in by build.c
+kernel_info_offset:	.long ZO_kernel_info
 
 # End of setup header #####################################################
 
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 10b0207a6b18..14ef13fe7ab0 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -59,7 +59,6 @@ static unsigned long efi32_stub_entry;
 static unsigned long efi64_stub_entry;
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
-static unsigned long kernel_info;
 static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
@@ -337,7 +336,6 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, efi64_stub_entry);
 		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
-		PARSE_ZOFS(p, kernel_info);
 		PARSE_ZOFS(p, _end);
 
 		p = strchr(p, '\n');
@@ -419,8 +417,6 @@ int main(int argc, char ** argv)
 	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
 
 	efi_stub_entry_update();
-	/* Update kernel_info offset. */
-	put_unaligned_le32(kernel_info, &buf[0x268]);
 
 	crc = partial_crc32(buf, i, crc);
 	if (fwrite(buf, 1, i, dest) != i)
-- 
2.44.0.769.g3c40516874-goog


