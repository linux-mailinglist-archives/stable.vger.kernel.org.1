Return-Path: <stable+bounces-111900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD64A24B03
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 18:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73EAC18869E5
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 17:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506CA1CAA8E;
	Sat,  1 Feb 2025 17:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwdPMfhE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E581CAA68
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738430507; cv=none; b=mLyd4/OO5WOLAV7JbBFOIN1wSs42iIgRIDwxITl/cNhF7jM6tNq6HSzfgeRdcoEGTt4+OMpXQ75n0WudqGg3JqKZbYrbXk13lMr6xYOQtJ4Ewi4MPzFujPbwfabjNC12SMTsJJmdXdqdrg206xn+hhGIVIPCgGYypx5iKnxHX34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738430507; c=relaxed/simple;
	bh=esqqEYo0++dYji/MtqD/F6i+A6z6+qF0OS2a7BNstg8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X8Gp7oGfwTLsm75UkZdpjuVHh+svaOIJGDYYPEHcK52fNKwQ6DEzLeLf/wgnnokTH8GNdJIqAuQF9socnMkybiLsHshrHA0PHyrGWw8xqKW4QSMnvu5ip0k44Gr0dofnhAnU8lM32q/KH92wRlj67vdonLZ6XzxAEG6MuIp7nko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XwdPMfhE; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4361eb83f46so22815565e9.3
        for <stable@vger.kernel.org>; Sat, 01 Feb 2025 09:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738430503; x=1739035303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u+/I2FOukc3Dk/asy1e7U9EZH1wtrOizoGOwl5SdtH4=;
        b=XwdPMfhEOhQhS38ol2WNJPz4Zu74+kQAXwT3cTKHhjms1GkbLAD/XZInKPIQ1TYH01
         wmW5NPfY++GKcbfJLp+52AOxspXzhwxM7bCOrvc5YCa8a7EB5SnLqkGArisTLzY4C5kg
         B3dxTZ/dgzbu1BS0JGEA1qu+zlkyoS611YG/Edhy0Ym/vRDWPpeAI+jboo0putl+GJ9i
         Z/AsZJrJTlra2q36EvW15vnmcNKRPDYuf42ofPtgh4QsET9hkTiKDWHRsDatuIyxBSx5
         mVwJjzRsfLmYKadCPNNSRNMCuj/HkpI7i5x27V2S5sM7S4f8z94An9NIOdtxBWFtsjxr
         Aakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738430503; x=1739035303;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+/I2FOukc3Dk/asy1e7U9EZH1wtrOizoGOwl5SdtH4=;
        b=v3DW7+tiJDLdO8nfG9IzcDY1jpDOvfSW3QoHko/QBRHe9j9gG2x6m15XAlIxFTGhNX
         4Id8mlP+oVmPkM/1N8oYtO6ttN25sKaf2ftryCBCyjDj5MzdlJmFdg5opR5CxaRQLGzZ
         y9HByUvpxBB2ZDG1rQdgLQ6AHdqKFK95mQ+lj3pt5h7ANT61UmcT++EMf1naGRg9rs+n
         /R0i02SnHi4mqyunT8EiKxihoT+chTKngupbXygEsargdLhSQKStqeDFBID+ecg19vvJ
         8cGxHcSg51ckNwqqjbDhcCcMbHX8y3E9CyIup7i3/tbYxjZhhjxyatRoqQPyxvSFBr7p
         dxdw==
X-Forwarded-Encrypted: i=1; AJvYcCXv5GH1qxKfYD2Db4lQvA5UD02kl9qLLI+qbLdO0BCAwjc8yySBv50ON12ZunxyCIRUjPqSwTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyiqwYWXIom2CShKa1Yu7GNd0Ndg+B/0KL4Q3rJ1fccURxVnD
	jhmhm2BTd0/ct+9KAV0zH2+Mk9UdYDxBKBkC+D8bMjTvXErvdW322WurLxN81glbFIHAcg==
X-Google-Smtp-Source: AGHT+IH4Sk//KUgQXbsaN7PuwigW7TIUt60j0OUYDwXcBLIFBYQIS6PTHwK/yF3wuAJQ2njkwqWraLJl
X-Received: from wmgg2.prod.google.com ([2002:a05:600d:2:b0:434:a7ab:5eea])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c17:b0:438:a290:3ce0
 with SMTP id 5b1f17b1804b1-438dc3be2efmr142365605e9.8.1738430503789; Sat, 01
 Feb 2025 09:21:43 -0800 (PST)
Date: Sat,  1 Feb 2025 18:21:35 +0100
In-Reply-To: <20250201172133.3592112-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201172133.3592112-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4536; i=ardb@kernel.org;
 h=from:subject; bh=sIXXXHX/WANPcyo/QtzvHZEcmMFcszZ6NY8ZNAqvLco=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX1ehILt1oaPSlPdDVk12a/7nBCrzZdSmPytp37mgcXZq
 UIddhYdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCJNGxn+5xpsvem/oGOpWIha
 86SHIv1WNTmdK2IOXzsT16vjlFPqx8gwoblTSD52xq3Dpts+20xWMHx3vuJ3Iv+/9L4rEsscYiO 4AA==
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250201172133.3592112-5-ardb+git@google.com>
Subject: [PATCH 1/2] efi: Avoid cold plugged memory for placing the kernel
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

UEFI 2.11 introduced EFI_MEMORY_HOT_PLUGGABLE to annotate system memory
regions that are 'cold plugged' at boot, i.e., hot pluggable memory that
is available from early boot, and described as system RAM by the
firmware.

Existing loaders and EFI applications running in the boot context will
happily use this memory for allocating data structures that cannot be
freed or moved at runtime, and this prevents the memory from being
unplugged. Going forward, the new EFI_MEMORY_HOT_PLUGGABLE attribute
should be tested, and memory annotated as such should be avoided for
such allocations.

In the EFI stub, there are a couple of occurrences where, instead of the
high-level AllocatePages() UEFI boot service, a low-level code sequence
is used that traverses the EFI memory map and carves out the requested
number of pages from a free region. This is needed, e.g., for allocating
as low as possible, or for allocating pages at random.

While AllocatePages() should presumably avoid special purpose memory and
cold plugged regions, this manual approach needs to incorporate this
logic itself, in order to prevent the kernel itself from ending up in a
hot unpluggable region, preventing it from being unplugged.

So add the EFI_MEMORY_HOTPLUGGABLE macro definition, and check for it
where appropriate.

Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c                 | 6 ++++--
 drivers/firmware/efi/libstub/randomalloc.c | 3 +++
 drivers/firmware/efi/libstub/relocate.c    | 3 +++
 include/linux/efi.h                        | 1 +
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 8296bf985d1d..7309394b8fc9 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -934,13 +934,15 @@ char * __init efi_md_typeattr_format(char *buf, size_t size,
 		     EFI_MEMORY_WB | EFI_MEMORY_UCE | EFI_MEMORY_RO |
 		     EFI_MEMORY_WP | EFI_MEMORY_RP | EFI_MEMORY_XP |
 		     EFI_MEMORY_NV | EFI_MEMORY_SP | EFI_MEMORY_CPU_CRYPTO |
-		     EFI_MEMORY_RUNTIME | EFI_MEMORY_MORE_RELIABLE))
+		     EFI_MEMORY_MORE_RELIABLE | EFI_MEMORY_HOT_PLUGGABLE |
+		     EFI_MEMORY_RUNTIME))
 		snprintf(pos, size, "|attr=0x%016llx]",
 			 (unsigned long long)attr);
 	else
 		snprintf(pos, size,
-			 "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
+			 "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
 			 attr & EFI_MEMORY_RUNTIME		? "RUN" : "",
+			 attr & EFI_MEMORY_HOT_PLUGGABLE	? "HP"  : "",
 			 attr & EFI_MEMORY_MORE_RELIABLE	? "MR"  : "",
 			 attr & EFI_MEMORY_CPU_CRYPTO   	? "CC"  : "",
 			 attr & EFI_MEMORY_SP			? "SP"  : "",
diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index e5872e38d9a4..5a732018be36 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -25,6 +25,9 @@ static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
 	if (md->type != EFI_CONVENTIONAL_MEMORY)
 		return 0;
 
+	if (md->attribute & EFI_MEMORY_HOT_PLUGGABLE)
+		return 0;
+
 	if (efi_soft_reserve_enabled() &&
 	    (md->attribute & EFI_MEMORY_SP))
 		return 0;
diff --git a/drivers/firmware/efi/libstub/relocate.c b/drivers/firmware/efi/libstub/relocate.c
index 99b45d1cd624..d4264bfb6dc1 100644
--- a/drivers/firmware/efi/libstub/relocate.c
+++ b/drivers/firmware/efi/libstub/relocate.c
@@ -53,6 +53,9 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
 		if (desc->type != EFI_CONVENTIONAL_MEMORY)
 			continue;
 
+		if (desc->attribute & EFI_MEMORY_HOT_PLUGGABLE)
+			continue;
+
 		if (efi_soft_reserve_enabled() &&
 		    (desc->attribute & EFI_MEMORY_SP))
 			continue;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 053c57e61869..db293d7de686 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -128,6 +128,7 @@ typedef	struct {
 #define EFI_MEMORY_RO		((u64)0x0000000000020000ULL)	/* read-only */
 #define EFI_MEMORY_SP		((u64)0x0000000000040000ULL)	/* soft reserved */
 #define EFI_MEMORY_CPU_CRYPTO	((u64)0x0000000000080000ULL)	/* supports encryption */
+#define EFI_MEMORY_HOT_PLUGGABLE	BIT_ULL(20)	/* supports unplugging at runtime */
 #define EFI_MEMORY_RUNTIME	((u64)0x8000000000000000ULL)	/* range requires runtime mapping */
 #define EFI_MEMORY_DESCRIPTOR_VERSION	1
 
-- 
2.48.1.362.g079036d154-goog


