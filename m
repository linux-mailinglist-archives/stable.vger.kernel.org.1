Return-Path: <stable+bounces-25907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD94870048
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 12:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F6E2833FD
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 11:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D7639864;
	Mon,  4 Mar 2024 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJbn31KO"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1953A38F9D
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551253; cv=none; b=LchorshjEbFUeXEe46z8ffPg2brTLPWHWzCO+898yeLQTvQSw8aj1KF40UbudGqXTSNQkeKsPYQFt7PPEWd6Z7JvOqYWbqBmHuaPwdMBvhBi23w7NHIBgiLUVJTaRNo2yKuApoPwmxH24gfkNCT4CRbxGs5UtYJjUUgD96ywWm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551253; c=relaxed/simple;
	bh=8OWldvukvmZpWOq8P7oUlDuHoHdvrpus0wKOSakpwtQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oG4TPv+XKlzZJDLneZ+aQFw2Sc7a/S+adQum+8xY1W1bIjo0Drv/rZ38vQptfNK94s6ggWTgJf7rmRO3Dy0w9RlPo3+59mF8onVSIrtGnCrHNTnXLaNusiszNhSXGFdbBTFhRVfgFBDUTYAmKvvaKGAm0YRZtfPVHZCou7e4i/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UJbn31KO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608dc99b401so74192517b3.0
        for <stable@vger.kernel.org>; Mon, 04 Mar 2024 03:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551251; x=1710156051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2VMwItLsTNQ1/Piu0UnveJwXB3eNhUp/z91rraupBN4=;
        b=UJbn31KOEoUVHy0AhWG5Hm9OCtYVdab2wgC+mCSe8njAZEse3l8YyY8shThU8RIksi
         X1GymZEoJ5t44oUqrs1TH/1ErZgB6RfMCM0SV7yTk1hvgS2TtniFHNwPSBW2aQfkXeVt
         oPDo2ITIB06QYU6uGR6+MhmBQw/QuEQv4xfzDwlenYze0oXR/iuSIPJ9vOE48oV78Pvm
         VLDoq8ywIyMUkM8WboZbLuDis2Bld4/W41a9QfXj/w5/YAXzIPYj+v1OuBpnxdctTwLD
         b/OdI1dZ/Os0NZCsF3jsqMMWopXaZZEU0tlEdR8M7NpgeNI/X/WPuGgUaC3vwxA9J6rO
         Gvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551251; x=1710156051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2VMwItLsTNQ1/Piu0UnveJwXB3eNhUp/z91rraupBN4=;
        b=TmxNFsGaEbsic2CterAsUbsVma23M6TPMlNqz5eOBnmNpsa3uGrUk5KUxtT5YJ1/X8
         D+sjE6szYuOl7LobzBj/RFMtYtdQewbMuHYdj+3lFJfFRkEORqwPov183UHMnVfQMvR4
         HRzCIYgONt5ljWExmc9WfilCpMi6ea1ylBuWCh18bECaXrnk9DC/svPILWRgkG7ui4Cv
         i7eUHJ5LZh68jQf6fX+eEwbSDWiLLQ1njmW567eurzaLcH3M5Z31aV9DCsqak5MCdE4v
         HU8cZ8bYzPL+4bVgwdLsI0uREkpBUI+XehNSZgja2s6z90nZ2UPfK9MXehN0cgFpM/9Z
         8fBg==
X-Gm-Message-State: AOJu0YzN8LSojH800r7f/gcYCoLkZjsr9018xkZLiS2WPSe+b136itxe
	Dmmqv3SMSUUqIhOoKo3CICtUEvcLlJ2KVtliB4vb9mFGD0TP/A7XM/q8fldroHB8zLYzOT807ca
	kIgGkREAY/s2M0PYV6Vrv/q9zbzEU6fh/Jc+HiQ/TypZgyMWrATRazXIypXn9FGNQ45xUejWsQx
	U6ORGh2pBF9pzR6KKMBDHR+Q==
X-Google-Smtp-Source: AGHT+IHSHHdFcPDmBUGEGULbdTc1D0bjggDzywnPnpvbnxWw1FbeUWwEctW4kLK3Ceug3jmNDavXCmwo
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:690c:fcd:b0:609:33af:cca8 with SMTP id
 dg13-20020a05690c0fcd00b0060933afcca8mr2555248ywb.2.1709551251233; Mon, 04
 Mar 2024 03:20:51 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:52 +0100
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304111937.2556102-20-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3359; i=ardb@kernel.org;
 h=from:subject; bh=P8OiDo3hIcD2caoAHpBhOy8GahGPOEMqbPhF5JV0ZE4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpusiHU7apaVlW7nrDOJPjpd0SBUkttUUbFlZuWNvm7
 Njc8ulyRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIrSzDP43+ZreO8DOGfzm6
 prb2JZgaSCttqZ//+FiP3EGze6Jcsxl+sycvDf+Z9NOc+9KNg4wVYYf3+c+Y1x6/3+lS87JqoWc XGAE=
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-34-ardb+git@google.com>
Subject: [PATCH stable-v6.1 14/18] efi/x86: Avoid physical KASLR on older Dell systems
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 50d7cdf7a9b1ab6f4f74a69c84e974d5dc0c1bf1 upstream ]

River reports boot hangs with v6.6 and v6.7, and the bisect points to
commit

  a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")

which moves the memory allocation and kernel decompression from the
legacy decompressor (which executes *after* ExitBootServices()) to the
EFI stub, using boot services for allocating the memory. The memory
allocation succeeds but the subsequent call to decompress_kernel() never
returns, resulting in a failed boot and a hanging system.

As it turns out, this issue only occurs when physical address
randomization (KASLR) is enabled, and given that this is a feature we
can live without (virtual KASLR is much more important), let's disable
the physical part of KASLR when booting on AMI UEFI firmware claiming to
implement revision v2.0 of the specification (which was released in
2006), as this is the version these systems advertise.

Fixes: a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218173
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 31 +++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 61017921f9ca..47ebc85c0d22 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -273,17 +273,20 @@ void efi_adjust_memory_range_protection(unsigned long start,
 	}
 }
 
+static efi_char16_t *efistub_fw_vendor(void)
+{
+	unsigned long vendor = efi_table_attr(efi_system_table, fw_vendor);
+
+	return (efi_char16_t *)vendor;
+}
+
 static const efi_char16_t apple[] = L"Apple";
 
 static void setup_quirks(struct boot_params *boot_params)
 {
-	efi_char16_t *fw_vendor = (efi_char16_t *)(unsigned long)
-		efi_table_attr(efi_system_table, fw_vendor);
-
-	if (!memcmp(fw_vendor, apple, sizeof(apple))) {
-		if (IS_ENABLED(CONFIG_APPLE_PROPERTIES))
-			retrieve_apple_device_properties(boot_params);
-	}
+	if (IS_ENABLED(CONFIG_APPLE_PROPERTIES) &&
+	    !memcmp(efistub_fw_vendor(), apple, sizeof(apple)))
+		retrieve_apple_device_properties(boot_params);
 }
 
 /*
@@ -759,11 +762,25 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && !efi_nokaslr) {
 		u64 range = KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR - kernel_total_size;
+		static const efi_char16_t ami[] = L"American Megatrends";
 
 		efi_get_seed(seed, sizeof(seed));
 
 		virt_addr += (range * seed[1]) >> 32;
 		virt_addr &= ~(CONFIG_PHYSICAL_ALIGN - 1);
+
+		/*
+		 * Older Dell systems with AMI UEFI firmware v2.0 may hang
+		 * while decompressing the kernel if physical address
+		 * randomization is enabled.
+		 *
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=218173
+		 */
+		if (efi_system_table->hdr.revision <= EFI_2_00_SYSTEM_TABLE_REVISION &&
+		    !memcmp(efistub_fw_vendor(), ami, sizeof(ami))) {
+			efi_debug("AMI firmware v2.0 or older detected - disabling physical KASLR\n");
+			seed[0] = 0;
+		}
 	}
 
 	status = efi_random_alloc(alloc_size, CONFIG_PHYSICAL_ALIGN, &addr,
-- 
2.44.0.278.ge034bb2e1d-goog


