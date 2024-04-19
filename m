Return-Path: <stable+bounces-40236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 691718AA9CB
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C236CB2112E
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92AC4D59F;
	Fri, 19 Apr 2024 08:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pWK5/3zh"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0353A1A8
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514288; cv=none; b=qWaOSEGGA0q0K8paim8U6IGE+qf7/onoMJ3rHdY0kVnX+WMl6VhtlGke+I1Y/ecnvJRJOfsBZUdI4sX9bEryrv24HTbP6pMAI37+S0y0ktdJkZogi44xNQM6cmpzFDd3eqTiIs5PO2VpEwUDfyl3Hy2Aude7Vju/75ZPYrED7U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514288; c=relaxed/simple;
	bh=p1LlpSq19BsnDOYSW1nkKP6Ul97dtzIU/vkuum6zJrs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=dXpytNYA9EEH3bkRoAw9OebfUAT/tRxQomP2bg385biRpkyuCs9KPEFsCsw6mP2JBF9WO03rBPqMwc3Wwt3QtPELBIf6oBvIPiw9AZORRgxKdAQTu0eUuYbOyP/BrB2mmlx9CAezADoWMlN+0+k2YAboyqtZIJUS1dOqAt2NmtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pWK5/3zh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b13ce3daaso39116327b3.0
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514286; x=1714119086; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fKqWl2fzXQHdgd8NOXvu93h2ddCLHT4SsNby6IqJlaw=;
        b=pWK5/3zhPfK+udXf9xZa45ND/E0MV6VzJ/82IZaWLK6RB+RkXdA4Dprrs4Ss2KNEvH
         wviXsYpKDdBrW9+3psKLuLnJEVrfQ9+kJZLGuprlmxwjnTxc4fG1NaXOI7xQnZeLR6Fe
         E72GdqeyrVcCCipTEK6TlpzDQMVTqguINHekzTZdes1hoPEGLyFmp9syiRSZVaO73KSl
         DRsIWdCohOsLNvNSJJ/ZC/Q1eF4OGuh1dGpj26eouw+hrUYtFxPO4w5PJu1kTXDKgd7h
         TLpy4ZJeGrGklBy3EwmY0+YC3YKU6gy2bka2djl3BlzxO2HfBAkiM8qmcnhzMqWUifsd
         REXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514286; x=1714119086;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fKqWl2fzXQHdgd8NOXvu93h2ddCLHT4SsNby6IqJlaw=;
        b=TY6gyUR1Gddm0ViSfOb2fvwUloq/m0KixL6ULHTAM91MSlA2hdLgyWS8QCC1x+Gec+
         9TqXUIm62bsPSTD/M54fu1/ocAV60FzB696dbKFaZmsX0HjUK7JYteTxzso06r/+9ecG
         vG+HYHwnhWdPToBjQ+vTdA4zMutDPYlwN/0irATwJMRsSgCPsd0YdFQhkQ/Q1NHJ5tIq
         7m4E4mla3VaYbdWNy+6k48LQtvMe7fSCvnGRVmJRtWoZ6rP73NGgqy6Hou8TRyIEsINt
         GuoR53Yd5mdKw+E0418grJ4IAzAZYn2v2evHDa/YACbhb2NTHImJo/k6P/EMejb7EVRA
         IU2A==
X-Gm-Message-State: AOJu0YxmAk9usjOx5feUxZsI3JChC50os+HsUCyGECplVeCUs56cdNlh
	b9FQlScoCZrBhAo2TiRMC05fp3IlTVZlDesXd4UwpSD15jNTD+oDxp8FdqjVeIA8uP0q13rjTfB
	IbnMTNJMXeFigqzSJx2p8IHNMtDZg8yp136UmpgWhTrtoX9qO8hBr1nD3iyYljGFJEOq6/fEfoY
	ONR9iEVKZr4etsLRiUaT6buw==
X-Google-Smtp-Source: AGHT+IFbQ31lR5vTtVOxPacJCpGR/K4Yr7Xl7GzhYEhDTZxK/GcgS2ufqgUYbRh5EZQfe2fNXCKohiKq
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:20ca:b0:de1:2220:862b with SMTP id
 dj10-20020a05690220ca00b00de12220862bmr400994ybb.12.1713514286089; Fri, 19
 Apr 2024 01:11:26 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3203; i=ardb@kernel.org;
 h=from:subject; bh=K7Ac0rcLNdyV7PvLqaM1qShkDHucZBWpsYeMvbPHwmM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXfLHwz85kWnh5Xx/V7Xe28zP03Jpc8WDe7cezosQ/
 /k1+eqHjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARXXOGP7zn5rEvXnRgd3dc
 Kf+M21Mu8V9WXZp90F5w3pX887UpuhMYfrOUpvy5oKIrzX5j957q3e/z9TgWWzY/Yc/1muAQu2x iCg8A
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-25-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 00/23] x86/efistub backports
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This is the final batch of changes to bring linux-6.1.y in sync with
6.6 and later in terms of compatibility with tightened boot security
requirements imposed by MicroSoft, compliance with which is a
prerequisite for them to be willing to resume signing distro shim images
with the MS 3rd party secure boot certificate.

Without this, distros can only boot on off-the-shelf x86 PCs after
disabling secure boot explicitly.

Most of these changes appeared in v6.8 and have been backported to v6.6
already.

Ard Biesheuvel (20):
  x86/efi: Drop EFI stub .bss from .data section
  x86/efi: Disregard setup header of loaded image
  x86/efistub: Reinstate soft limit for initrd loading
  x86/efi: Drop alignment flags from PE section headers
  x86/boot: Remove the 'bugger off' message
  x86/boot: Omit compression buffer from PE/COFF image memory footprint
  x86/boot: Drop redundant code setting the root device
  x86/boot: Drop references to startup_64
  x86/boot: Grab kernel_info offset from zoffset header directly
  x86/boot: Set EFI handover offset directly in header asm
  x86/boot: Define setup size in linker script
  x86/boot: Derive file size from _edata symbol
  x86/boot: Construct PE/COFF .text section from assembler
  x86/boot: Drop PE/COFF .reloc section
  x86/boot: Split off PE/COFF .data section
  x86/boot: Increase section and file alignment to 4k/512
  x86/efistub: Use 1:1 file:memory mapping for PE/COFF .compat section
  x86/sme: Move early SME kernel encryption handling into .head.text
  x86/sev: Move early startup code into .head.text section
  x86/efistub: Remap kernel text read-only before dropping NX attribute

Hou Wenlong (2):
  x86/head/64: Add missing __head annotation to startup_64_load_idt()
  x86/head/64: Move the __head definition to <asm/init.h>

Pasha Tatashin (1):
  x86/mm: Remove P*D_PAGE_MASK and P*D_PAGE_SIZE macros

 arch/x86/boot/Makefile                  |   2 +-
 arch/x86/boot/compressed/Makefile       |   2 +-
 arch/x86/boot/compressed/misc.c         |   1 +
 arch/x86/boot/compressed/sev.c          |   3 +
 arch/x86/boot/compressed/vmlinux.lds.S  |   6 +-
 arch/x86/boot/header.S                  | 211 ++++++---------
 arch/x86/boot/setup.ld                  |  14 +-
 arch/x86/boot/tools/build.c             | 273 +-------------------
 arch/x86/include/asm/boot.h             |   1 +
 arch/x86/include/asm/init.h             |   2 +
 arch/x86/include/asm/mem_encrypt.h      |   8 +-
 arch/x86/include/asm/page_types.h       |  12 +-
 arch/x86/include/asm/sev.h              |  10 +-
 arch/x86/kernel/amd_gart_64.c           |   2 +-
 arch/x86/kernel/head64.c                |   7 +-
 arch/x86/kernel/sev-shared.c            |  23 +-
 arch/x86/kernel/sev.c                   |  11 +-
 arch/x86/mm/mem_encrypt_boot.S          |   4 +-
 arch/x86/mm/mem_encrypt_identity.c      |  58 ++---
 arch/x86/mm/pat/set_memory.c            |   6 +-
 arch/x86/mm/pti.c                       |   2 +-
 drivers/firmware/efi/libstub/Makefile   |   7 -
 drivers/firmware/efi/libstub/x86-stub.c |  58 ++---
 23 files changed, 194 insertions(+), 529 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


