Return-Path: <stable+bounces-40239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C63C58AA9CD
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 552E2B215D0
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CEA4E1DC;
	Fri, 19 Apr 2024 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yN3yrEKk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BEB4D59F
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514296; cv=none; b=d90SiNkWT7JplPfuu1Qi2dtcuZr8UvHcNppqhNFKeRTuGD7S1fjWcIMLALgCgrGYzEMgQwY+PsIQCKB5oMrRtpvsF5l8Bd3e3CxphHNC2WaLteGrGLx3mfyITP/RxTZtBL+POP3qdx83DM/WuT7DYBR66t3F62RJZBBpyrtSdVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514296; c=relaxed/simple;
	bh=4gKzDZBQcfV6gmj09ybKWV+0qDmXVE74YEYxcAlMyrU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=dUfw1mwKxDne4CTVy30WzhqouD92MZu2g0xbguFsLmnwUbOs58jehpN47wbMcv85lvou9P2qbzgO7OYAhES/8+nNvqndpV2qAdRI/c15dJ/SBc0awhLR+nDjGSJXYfkNGyP7vLEQtzupBqO75aVc4+Bl09joE4yZCnD4/99gZnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yN3yrEKk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-417de456340so10033835e9.2
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514293; x=1714119093; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RYjUq1/MpZFIrREyumsz6gj9zzxWTbkpo6xR13iDX9E=;
        b=yN3yrEKk5dsl8AjTuNH6RVWqGzNJPW7IfRFeueWdU/T2xS6+T5ymYGVuzOPnySrd4z
         HTwHmC41qDpKLbX9r6iVbodoVlPoU2eBQTCfeOeIQGUFOqbIg+/A1kXbKaIcLr3ucfQA
         rgDQvXoSivT83xYa+UYyF9FPHydus2+imFtPFuCNFBo6dD8czbeYOp1/BLUYJBZdm7PQ
         QXQ9P7t3k3fuHlHtgDvtv+eD2Dctv2GZzMmqgu+im2+EEA3amzVGRvf2maPVzRLHcQVS
         fj9zcQUTsiWsbq4GjS8xN2ZhmxS2xluuKfAfxIpvbO9UHKr3RBjl4ytIqhGR8tUnPtwY
         6Plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514293; x=1714119093;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RYjUq1/MpZFIrREyumsz6gj9zzxWTbkpo6xR13iDX9E=;
        b=CsexGZCtrmZiq0UAL9xZCjQwKArjkLPIIuaMTwcOEy5uG7/VamXI40uJRnpbqtoWRF
         L0joYAkmTt9/W55r6aNVH1nrNHMp3sdWPl8Ebm8jIGqtDFqLtvwNjPoagj5h6+Q9rSjW
         9pJ/NGRujMF7wIFzrx9/OiUXXZTZVI1E/AJsNAqtqWNM1qdCU90L6afa59JYc1MHrqRn
         PEfCXoP3XOxsv/T1xLOrSytRovJuI2iQisoO5Z5zsvdYbCgCccSle5nukKAM1dydYmkb
         Jp5KDQ4rGabGFwFf2crSR4kPMUPcIrv/j4/+1tgOcT0JMRHi4EUk45Md9AfiLHmTTgyS
         u9yQ==
X-Gm-Message-State: AOJu0YwfaeJ9tzrtWaMiAoHmvPpXjk1U1UheIMjN3xHnahX4yu9iApkb
	WsQpoG3CRMFk8+Sxq5i6xCMojlqjQuLlbV5Qo93wK4vtRJofp1i+VBnc4U/ru9tGVhNKYm2A6XP
	ty03JSs0gnuF+chYh9xpNbDRdm939gt2egu0tdkJ3y9C9F143G/JpCKJayRIxQB2+YHXpZxvBRo
	TuI0retODoWnkPvRiO7g+spQ==
X-Google-Smtp-Source: AGHT+IG64eHFGv1QctGx/L2eFi8vycySVz+3h4DYzSWZL/a5lv6mFqi2SOHAL5PKkbCRmA3CDak+UbEN
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:35c5:b0:416:b992:cbdd with SMTP id
 r5-20020a05600c35c500b00416b992cbddmr4640wmq.5.1713514292900; Fri, 19 Apr
 2024 01:11:32 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:09 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2335; i=ardb@kernel.org;
 h=from:subject; bh=ntWeJbJWsbgXu4LAynWRRvA9xuveFgGD6M0ox+cGWHM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXUb00dXipTfE1kh8yD0yifVu6FPLU88PtLMzpp66G
 NQ668apjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRuycZGZZvnbj62c9ZR+Uf
 ny6O+nkvyWrKd9GQGPGbi/hTkgoNbD8zMjzTntb/f+OBB5equCfwZnokaZS2/RBM/fj05stTalH 3stkB
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-28-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 03/23] x86/efistub: Reinstate soft limit for
 initrd loading
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit decd347c2a75d32984beb8807d470b763a53b542 upstream ]

Commit

  8117961d98fb2 ("x86/efi: Disregard setup header of loaded image")

dropped the memcopy of the image's setup header into the boot_params
struct provided to the core kernel, on the basis that EFI boot does not
need it and should rely only on a single protocol to interface with the
boot chain. It is also a prerequisite for being able to increase the
section alignment to 4k, which is needed to enable memory protections
when running in the boot services.

So only the setup_header fields that matter to the core kernel are
populated explicitly, and everything else is ignored. One thing was
overlooked, though: the initrd_addr_max field in the setup_header is not
used by the core kernel, but it is used by the EFI stub itself when it
loads the initrd, where its default value of INT_MAX is used as the soft
limit for memory allocation.

This means that, in the old situation, the initrd was virtually always
loaded in the lower 2G of memory, but now, due to initrd_addr_max being
0x0, the initrd may end up anywhere in memory. This should not be an
issue principle, as most systems can deal with this fine. However, it
does appear to tickle some problems in older UEFI implementations, where
the memory ends up being corrupted, resulting in errors when unpacking
the initramfs.

So set the initrd_addr_max field to INT_MAX like it was before.

Fixes: 8117961d98fb2 ("x86/efi: Disregard setup header of loaded image")
Reported-by: Radek Podgorny <radek@podgorny.cz>
Closes: https://lore.kernel.org/all/a99a831a-8ad5-4cb0-bff9-be637311f771@podgorny.cz
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index c592ecd40dab..1f5edcb6339a 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -453,6 +453,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	hdr->vid_mode	= 0xffff;
 
 	hdr->type_of_loader = 0x21;
+	hdr->initrd_addr_max = INT_MAX;
 
 	/* Convert unicode cmdline to ascii */
 	cmdline_ptr = efi_convert_cmdline(image, &options_size);
-- 
2.44.0.769.g3c40516874-goog


