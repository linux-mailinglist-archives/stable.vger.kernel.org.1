Return-Path: <stable+bounces-36312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C9389B7F1
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 08:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A93F1C21451
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 06:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148142030B;
	Mon,  8 Apr 2024 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xGjRkHh0"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E5200BA
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558985; cv=none; b=ii1FDMMqCeP+jKFatPim3mRnskmkG6oWxRPpSEIIAIDZ9m9ZHAHsTqGalaWjMOGrO2NtZjWUSuz2fOsFF1T4ndeMiVNym+SJ038BSwqUYJiAusqnwpG03RQwbswTv3+s6iNsDB43DZxaJ+Lhlgcq2uM1flaSRIQUaPR28TYeDgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558985; c=relaxed/simple;
	bh=Cahw7zJUYcz0blWvfgW2gwdvY79C17c8ixaPdeOMxpw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oZP4xxPL9fEMXVBQ/q2MH5ZruFKX37YA1ucYzzYBLW1NFylWPbpq4rDtaJ7/TtBSl0T0FwdIV0JFRBkhGvFrLM2HI2sjgeb8GhMPUF+naQ/saZYN9BT9XqMAmKgh03k9cvdfGahWjXA06Eubwcmiy8Im8Tbf4i5opZQzdIw4FHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xGjRkHh0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso6700360276.1
        for <stable@vger.kernel.org>; Sun, 07 Apr 2024 23:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712558982; x=1713163782; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NbCpWjppG+HMF8MQ0j24SA361UINTcJTjEqJlX7yob0=;
        b=xGjRkHh0zCDa7gwmfaHc400QeMiadCN2/kfh6N2JWmeX/x6UFdEdteUmKVIs/gHtja
         2up7rFw7vvYIU7m4pwZDlRs0/2yVKVUHLpcFl2qcL6GewzXyzvggG7wfzcaL+hFMriuS
         YfpPDBd3V+5pTnNup6U4m59xmS9x8ixW3b98hnbeBFAuXLvJoxdeZKbPP4KTtywBvjyA
         g4nKz4LRvugxwoqIYnYRH8xtS9L4f28lHucfxbuSu7cKyy6RGa0vkBrm6LHjKpMRYfMJ
         EP0eRVzzXThJXgPiN3gaEgRjCuUS6R4iK07XZt9AJJdtKQ8rFimqdLL1Kkl7QFl92AbY
         ygNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712558982; x=1713163782;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbCpWjppG+HMF8MQ0j24SA361UINTcJTjEqJlX7yob0=;
        b=OJUfMpv1z1+ZxDkAZ5K0jKMhKSaWGYA+L3TV5jvlVHFYQ/kaQu60ccZ2YTrdjN0Prf
         wiR4Gq5pA/61afG0+SH3VNxi0dWzj3Y9rov9bkLfg4t6lCwJTDXpWYLo6RkpJvsPvTIz
         qSjMQAahAfXs2NK4Wwyjm2A5PrGKCgmmAHmRU0gE/YQ+TQZ1evVOR0l2d/RzWhRwY9PM
         0aDWlLQ8hwlGuUHf7Ar+NtGJ0/v7yuY0TTbgznahoUnlpnewLhCwyfImOa+Idmu123WC
         t2cKmb8NEDARNQuXlRzmu1kHZ0djZnzmLb6slDDEpominHVmMPVnc64W9J9JQ+0acw6S
         GREw==
X-Gm-Message-State: AOJu0YyX3HDjfpDzjjb/eNVJ7SL6oYjplIlTOUi495/YI94jwZLEpRR6
	MR/P2+tq0RBi/0Tfr1rtNxykJkxlQfr+IZQs9jnPQx8frqxivgd6bwa2txWHjFnUV9paeWqj0tm
	MCtcnED8i/MKyozg2J5tnBkIXfnQ6AQSoqpYXKFYKWUBngWofZX4GSAPWTA3Blb/WGi6lbWnapF
	iZ0jcULzXzmzLMFD2/eQ0xgg==
X-Google-Smtp-Source: AGHT+IF/puYfwzSoY5PzDBlbXfylX8/NfybvFg6OA8XWIMJ4L2fcbwpuOA4ZGBQJWwrDMwKJocxB3JJ1
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:2b84:b0:dd1:390a:51e8 with SMTP id
 fj4-20020a0569022b8400b00dd1390a51e8mr2723113ybb.10.1712558982537; Sun, 07
 Apr 2024 23:49:42 -0700 (PDT)
Date: Mon,  8 Apr 2024 08:49:20 +0200
In-Reply-To: <20240408064917.3391405-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240408064917.3391405-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2474; i=ardb@kernel.org;
 h=from:subject; bh=U1UH1I2rm/uc9+6WIBeeY3Q8l9XQgxm49wdlKyVYBgE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU14csGyixKRCdduHeFdXc75d/0nwfxmhUcqsda60SdWF
 l34k8DQUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbC5svIsG+HjcjRau8l84s/
 rDSyrj6pu3fpUlWuZyK/lwsWfv8X8JDhf9ADJusNzs+f7+SNcxBeGClXYxIqVDpvZspuh/bHAgJ N3AA=
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408064917.3391405-10-ardb+git@google.com>
Subject: [PATCH -for-stable-v6.6+ 2/6] efi/libstub: Add generic support for
 parsing mem_encrypt=
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 7205f06e847422b66c1506eee01b9998ffc75d76 upstream ]

Parse the mem_encrypt= command line parameter from the EFI stub if
CONFIG_ARCH_HAS_MEM_ENCRYPT=y, so that it can be passed to the early
boot code by the arch code in the stub.

This avoids the need for the core kernel to do any string parsing very
early in the boot.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20240227151907.387873-16-ardb+git@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 8 ++++++++
 drivers/firmware/efi/libstub/efistub.h         | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index bfa30625f5d0..3dc2f9aaf08d 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -24,6 +24,8 @@ static bool efi_noinitrd;
 static bool efi_nosoftreserve;
 static bool efi_disable_pci_dma = IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
 
+int efi_mem_encrypt;
+
 bool __pure __efi_soft_reserve_enabled(void)
 {
 	return !efi_nosoftreserve;
@@ -75,6 +77,12 @@ efi_status_t efi_parse_options(char const *cmdline)
 			efi_noinitrd = true;
 		} else if (IS_ENABLED(CONFIG_X86_64) && !strcmp(param, "no5lvl")) {
 			efi_no5lvl = true;
+		} else if (IS_ENABLED(CONFIG_ARCH_HAS_MEM_ENCRYPT) &&
+			   !strcmp(param, "mem_encrypt") && val) {
+			if (parse_option_str(val, "on"))
+				efi_mem_encrypt = 1;
+			else if (parse_option_str(val, "off"))
+				efi_mem_encrypt = -1;
 		} else if (!strcmp(param, "efi") && val) {
 			efi_nochunk = parse_option_str(val, "nochunk");
 			efi_novamap |= parse_option_str(val, "novamap");
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index c04b82ea40f2..fc18fd649ed7 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -37,8 +37,8 @@ extern bool efi_no5lvl;
 extern bool efi_nochunk;
 extern bool efi_nokaslr;
 extern int efi_loglevel;
+extern int efi_mem_encrypt;
 extern bool efi_novamap;
-
 extern const efi_system_table_t *efi_system_table;
 
 typedef union efi_dxe_services_table efi_dxe_services_table_t;
-- 
2.44.0.478.gd926399ef9-goog


