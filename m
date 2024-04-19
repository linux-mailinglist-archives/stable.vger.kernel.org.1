Return-Path: <stable+bounces-40238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAB68AA9CC
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8CE284548
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3698741C89;
	Fri, 19 Apr 2024 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+oVabBK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599E53A1A8
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514295; cv=none; b=iGSZZkND/nkv/SdLk0vd1inTEJIUb/J/r5mhTnasvUp3KR4XCiZmIHa+ZbRWDfBUrLnBk06v3z5GtKrhNaNRPsBss1LW8qM5Oic+05K8nXprNzsDAKGnzOg/Re2odV55vXZ61HYc6nbRGgfsFvppwMRHuZ8X0jXHkLinQGPj2sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514295; c=relaxed/simple;
	bh=aQourgWq5u/GtxhorUB+TKbifDy8NOdt3ELiFp7IHP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oQ755d6TjivbY3DazNkF8SCd0LXenGdAh5ys10Hox2L0azWYDvUcFXVEy/si+eNKKCQyFsMG1Gl5pGsAXBcNaKfm3UTjQahwOyEHDrnrvrZHACNDGj7ZDtxIaemA4w5y1Y6blw/Jwp2NRw8ft83EPXw7A0bOvJzKo7uevmfYtzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+oVabBK; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-41681022d82so9013325e9.1
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514291; x=1714119091; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EnpXQFkPioV4WD1eolUSMJVmrqnnLb+UPDvmvoIwzck=;
        b=N+oVabBKc0KM4VZebqC7CR7iQZ+soesZNQJevh2bLK8X2qnXzBgm4D8IoFq7K8NiDG
         +TVNN/HvL7/RDbYXGTHj4f6SKe8lu1C4HLBkpHApgbQqxnlhDxI3Cr4Rv1CVBH/mGrrV
         C/kHwyJiaj6B/jZmE3nMONIP2vtjnhc1oBvmRqxXeAyooxGLImYcx7Pe8LyXGBUt/G5s
         xZ7zkjctKG03YZ5JKM/u2vruyaL3JxakoygftVzSH+co+141nIR4L6pIp2goJXC9/eFY
         V1VWHmeh3CTMRcGbqKB6oxwLnhWx1kDAod5XX9ii/BfDqxHA4mrILzzjTnkKesBdd38P
         Dt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514291; x=1714119091;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EnpXQFkPioV4WD1eolUSMJVmrqnnLb+UPDvmvoIwzck=;
        b=Ro043AfZJAs2OZZ68b52kPnKNUHg3nb3Xr7NLyidSK8zHySPig3iT4GgZRYJBR6Y0I
         yYDUPpQY2//GNoC40qtt1Xcor2C0KvpIcdCWa7qUXi3JCwtkZ+hjlKXGfY11Ar6BxByI
         WG07k44J277+c5o9U/yoAglmtU7+ZSx2j3qOjQQqgU53wJix97aGteQILCdIqSTHSjSv
         ciJZmt48Vdgdg6XBtAfJU1XRhL3gr4V7NZNiBQDcW45bXwcF2yE4STA7G55o9LqDbWK0
         hyjDPSuhIiV7Jig3iBZCt2qo3fLNjof1Xr/cAkrXOj5E6MQQPjakYw3+bVV1iDEQcPUZ
         eR/w==
X-Gm-Message-State: AOJu0YyhWl/xVNKmDnWd1qVXh0WLE4kS1rVrFVohEtCBltjjimrjlgL1
	4lbmlXVerkizEdoorF9uUU5iTaGnPh0hijtKOXWWNeS2DBkoOSh4BexeF04L8CmtF4E81NOm0KC
	xUAy/iaucrzcR/IMZqvMmgFZGd9+WaLCJHdA1uiAZnPpf/7FUUuzy9a3Wkbz9q9zOf/oyXKFqeo
	+E96CmVVBqbOsU8PsqpFaX6g==
X-Google-Smtp-Source: AGHT+IHKR7QG7UjCBe6zkkOglvVJTeKr0lncwFz24/wAXGGER6QvVjZfwBtvdLZpVD8MLUZBuO4UE6gq
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1c11:b0:414:843:3ac1 with SMTP id
 j17-20020a05600c1c1100b0041408433ac1mr9493wms.7.1713514290738; Fri, 19 Apr
 2024 01:11:30 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:08 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4020; i=ardb@kernel.org;
 h=from:subject; bh=N0B/CmDtPOOr4PG5bO4e7bxW2Jc/lfcmFIyOh2Fx1v8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXfrWHBOxSuM1fX57lNtMFnfV9Vjd2xPAenr66W8ll
 769XxPXUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACay/gIjw7be+Xwe/xRP6JTH
 pHWZMM+pmCdoKNJ4ruPEdi6+/CcX9Bn+KR/OPM389kXqhxiXDZZKW+84rFRrMDpukG1m2+R4/mQ oMwA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-27-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 02/23] x86/efi: Disregard setup header of
 loaded image
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 7e50262229faad0c7b8c54477cd1c883f31cc4a7 upstream ]

The native EFI entrypoint does not take a struct boot_params from the
loader, but instead, it constructs one from scratch, using the setup
header data placed at the start of the image.

This setup header is placed in a way that permits legacy loaders to
manipulate the contents (i.e., to pass the kernel command line or the
address and size of an initial ramdisk), but EFI boot does not use it in
that way - it only copies the contents that were placed there at build
time, but EFI loaders will not (and should not) manipulate the setup
header to configure the boot. (Commit 63bf28ceb3ebbe76 "efi: x86: Wipe
setup_data on pure EFI boot" deals with some of the fallout of using
setup_data in a way that breaks EFI boot.)

Given that none of the non-zero values that are copied from the setup
header into the EFI stub's struct boot_params are relevant to the boot
now that the EFI stub no longer enters via the legacy decompressor, the
copy can be omitted altogether.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230912090051.4014114-19-ardb@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 46 +++-----------------
 1 file changed, 6 insertions(+), 40 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index dc50dda40239..c592ecd40dab 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -426,9 +426,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 				   efi_system_table_t *sys_table_arg)
 {
-	struct boot_params *boot_params;
-	struct setup_header *hdr;
-	void *image_base;
+	static struct boot_params boot_params __page_aligned_bss;
+	struct setup_header *hdr = &boot_params.hdr;
 	efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
 	int options_size = 0;
 	efi_status_t status;
@@ -449,30 +448,9 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 		efi_exit(handle, status);
 	}
 
-	image_base = efi_table_attr(image, image_base);
-
-	status = efi_allocate_pages(sizeof(struct boot_params),
-				    (unsigned long *)&boot_params, ULONG_MAX);
-	if (status != EFI_SUCCESS) {
-		efi_err("Failed to allocate lowmem for boot params\n");
-		efi_exit(handle, status);
-	}
-
-	memset(boot_params, 0x0, sizeof(struct boot_params));
-
-	hdr = &boot_params->hdr;
-
-	/* Copy the setup header from the second sector to boot_params */
-	memcpy(&hdr->jump, image_base + 512,
-	       sizeof(struct setup_header) - offsetof(struct setup_header, jump));
-
-	/*
-	 * Fill out some of the header fields ourselves because the
-	 * EFI firmware loader doesn't load the first sector.
-	 */
+	/* Assign the setup_header fields that the kernel actually cares about */
 	hdr->root_flags	= 1;
 	hdr->vid_mode	= 0xffff;
-	hdr->boot_flag	= 0xAA55;
 
 	hdr->type_of_loader = 0x21;
 
@@ -481,25 +459,13 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	if (!cmdline_ptr)
 		goto fail;
 
-	efi_set_u64_split((unsigned long)cmdline_ptr,
-			  &hdr->cmd_line_ptr, &boot_params->ext_cmd_line_ptr);
-
-	hdr->ramdisk_image = 0;
-	hdr->ramdisk_size = 0;
-
-	/*
-	 * Disregard any setup data that was provided by the bootloader:
-	 * setup_data could be pointing anywhere, and we have no way of
-	 * authenticating or validating the payload.
-	 */
-	hdr->setup_data = 0;
+	efi_set_u64_split((unsigned long)cmdline_ptr, &hdr->cmd_line_ptr,
+			  &boot_params.ext_cmd_line_ptr);
 
-	efi_stub_entry(handle, sys_table_arg, boot_params);
+	efi_stub_entry(handle, sys_table_arg, &boot_params);
 	/* not reached */
 
 fail:
-	efi_free(sizeof(struct boot_params), (unsigned long)boot_params);
-
 	efi_exit(handle, status);
 }
 
-- 
2.44.0.769.g3c40516874-goog


