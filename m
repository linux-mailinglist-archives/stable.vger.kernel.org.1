Return-Path: <stable+bounces-25893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E4F87002C
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 12:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE861C23471
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 11:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A62239AFC;
	Mon,  4 Mar 2024 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EfJM/zRG"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D316039AE1
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551221; cv=none; b=XSYoy6jfSkYKMoxFUPTyGUCGLewn6NQ8iONL1y1cKkV+e8xxin0AKCXnucZg6ixoI15RGV8gpLMenb167x6O38/aP11z5woYocfzeG7rGOScI9RasAQ3JiIa6avEgLSgRCfBs5cKhw5xSELqAD79+GDWWexsW8f3Pmlt9JMgj9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551221; c=relaxed/simple;
	bh=4WABv3LbX7RB6RL/LQUoVlByDA2A00lpXRli1Q5d06c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dj5WXNmO0bSaOa922x24C1PuQjXwAVA7LM5e2uFwbnncy5P4XqoM6AFOEifqwdFIQx3ts32lNNLAlC6S+3/8gvKX4RDJ9fGR+LdX2gFnDrHIlgbshW9DJjiBNrogwbiMzzrnEu1WhVJs0mDhnmCayKG/a2EAwSCXAOET3NF4zb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EfJM/zRG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so5573887276.2
        for <stable@vger.kernel.org>; Mon, 04 Mar 2024 03:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551219; x=1710156019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D+X5faEeUBlay3vk+5zci3Xi22Op4CTAjCUtJzx6Rx8=;
        b=EfJM/zRGF5GvC0xfnRAsN1k8LX97v9k7oZ8B+Gf4DbTuaz+KwYHnR0vr/WWM4RcCPu
         jUAJLosDIQ50A49WXEbVVV0SU0i9vXchWvgA6w7fZCx+JJ5Rep7Uxld8shL9V+Mx6tbz
         ztfEkTpCRJ/rf4zidC094P18/G/11wliihq79+r8Es7f6xzE+hgHxAgM5KjHA+MU8GKT
         dpFyXA6csdpw7ytIFnkoR1/2ThIDx4coivoWxkXUE6sxPYXzo0xNsXitmXxYEI84Oof5
         nabTqovGyETdiYI6sHMRmPOvE9cRC9Ll69Wu8CwdmpVXMEJ38Izsi/Nqv/QVEbrhBH6n
         VokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551219; x=1710156019;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+X5faEeUBlay3vk+5zci3Xi22Op4CTAjCUtJzx6Rx8=;
        b=j4sBhA79kwrrBxa36GKa0TFDY1AAU9ZeuzWm7br9cBvraXfh3QGxkpS0nGQxplowJZ
         t+mKiJEIxvaVLVz7TVXJJ4nowWCbUGUHYgbiXqKWziGzMo8y8dBsB0U4Ox8uK5dSNblL
         w6MYQHokyacc/P2MlQvhxXzLALGHp+BLiwpT6Rg058kX+0jYOZlyD4a4tLr54x+p74PZ
         gJg95JWgMAFrfAmoJ3sYfxVCae+lz97JxwEKqmHqvsHiHfV4eE8GfQ6nOn//tJvfyAQ9
         5IJhmBS/WXz8HT+7pvCshXpi0kEOepFOUyypvAh2B7xIhScZNrJrEUMhQrU0EUkXqlDq
         cSEA==
X-Gm-Message-State: AOJu0Yz4PaPLXKzV1N1j8BTmXPdHvCylcbenLCHabldSIr1fhxmUAt9Y
	bhqwXcOMme95ZxzVnGuqFHYCugMZ2xgWyPXWTGtbi18HQo6H7uhYraEsvswmde7cWBhFca15eKo
	uAh7Q6M12gMqCSpHHSckNWaWTSVwaMdg8Zdr+GL+//KhouYYBmzgDuo9Q1ugrs+NDieifslye8P
	PBP1WyZt2NAOs/BMHnGOckHA==
X-Google-Smtp-Source: AGHT+IGxpdXyNbJ8NDNLY58QKkLKsMoe1cUbU9eDsZBMAQ5XgPPz7Nxib3nj/NtrkNAiThWbJnJ+O323
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:f0b:b0:dcd:2f2d:7a0f with SMTP id
 et11-20020a0569020f0b00b00dcd2f2d7a0fmr325290ybb.9.1709551218767; Mon, 04 Mar
 2024 03:20:18 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3462; i=ardb@kernel.org;
 h=from:subject; bh=8zK9T8Um6D+rimjHJ8fjgKpgLdtOefuReu6MIS11PB0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpOs/Ws3tmX8oVrT7l5TGPR3SWfWF5V+lt/4+xLvmCl
 5/pyKV3lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIl8vsXIMPea9ovjR67IsdVc
 nPon0UhO5WhC5iRdnX5P/ZYdz7YYv2dkeOQi91uxo1t94uKO1StUP3pZLd/jODV8rsX+EKnVvcf P8wAA
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-20-ardb+git@google.com>
Subject: [PATCH stable-v6.1 00/18] efistub/x86 changes for secure boot
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

These are the remaining patches that bring v6.1 in sync with v6.6 in
terms of support for 4k section alignment and strict separation of
executable and writable mappings. More details in [0].

[0] https://lkml.kernel.org/r/CAMj1kXE5y%2B6Fef1SqsePO1p8eGEL_qKR9ZkNPNKb-y6P8-7YmQ%40mail.gmail.com

Ard Biesheuvel (15):
  arm64: efi: Limit allocations to 48-bit addressable physical region
  x86/efistub: Simplify and clean up handover entry code
  x86/decompressor: Avoid magic offsets for EFI handover entrypoint
  x86/efistub: Clear BSS in EFI handover protocol entrypoint
  x86/decompressor: Move global symbol references to C code
  efi/libstub: Add limit argument to efi_random_alloc()
  x86/efistub: Perform 4/5 level paging switch from the stub
  x86/decompressor: Factor out kernel decompression and relocation
  x86/efistub: Prefer EFI memory attributes protocol over DXE services
  x86/efistub: Perform SNP feature test while running in the firmware
  x86/efistub: Avoid legacy decompressor when doing EFI boot
  efi/x86: Avoid physical KASLR on older Dell systems
  x86/efistub: Avoid placing the kernel below LOAD_PHYSICAL_ADDR
  x86/boot: Rename conflicting 'boot_params' pointer to
    'boot_params_ptr'
  x86/boot: efistub: Assign global boot_params variable

Evgeniy Baskov (1):
  efi/libstub: Add memory attribute protocol definitions

Johan Hovold (1):
  efi: efivars: prevent double registration

Yuntao Wang (1):
  efi/x86: Fix the missing KASLR_FLAG bit in boot_params->hdr.loadflags

 Documentation/x86/boot.rst                     |   2 +-
 arch/arm64/include/asm/efi.h                   |   1 +
 arch/x86/boot/compressed/Makefile              |   5 +
 arch/x86/boot/compressed/acpi.c                |  14 +-
 arch/x86/boot/compressed/cmdline.c             |   4 +-
 arch/x86/boot/compressed/efi_mixed.S           | 107 +++----
 arch/x86/boot/compressed/head_32.S             |  32 ---
 arch/x86/boot/compressed/head_64.S             |  63 +----
 arch/x86/boot/compressed/ident_map_64.c        |   7 +-
 arch/x86/boot/compressed/kaslr.c               |  26 +-
 arch/x86/boot/compressed/misc.c                |  69 +++--
 arch/x86/boot/compressed/misc.h                |   1 -
 arch/x86/boot/compressed/pgtable_64.c          |   9 +-
 arch/x86/boot/compressed/sev.c                 | 114 ++++----
 arch/x86/include/asm/boot.h                    |  10 +
 arch/x86/include/asm/efi.h                     |  14 +-
 arch/x86/include/asm/sev.h                     |   7 +
 drivers/firmware/efi/libstub/Makefile          |   1 +
 drivers/firmware/efi/libstub/alignedmem.c      |   2 +
 drivers/firmware/efi/libstub/arm64-stub.c      |   7 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c |   2 +
 drivers/firmware/efi/libstub/efistub.h         |  28 +-
 drivers/firmware/efi/libstub/mem.c             |   2 +
 drivers/firmware/efi/libstub/randomalloc.c     |  14 +-
 drivers/firmware/efi/libstub/x86-5lvl.c        |  95 +++++++
 drivers/firmware/efi/libstub/x86-stub.c        | 295 +++++++++++---------
 drivers/firmware/efi/libstub/x86-stub.h        |  17 ++
 drivers/firmware/efi/vars.c                    |  13 +-
 include/linux/efi.h                            |   1 +
 29 files changed, 560 insertions(+), 402 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/x86-5lvl.c
 create mode 100644 drivers/firmware/efi/libstub/x86-stub.h

-- 
2.44.0.278.ge034bb2e1d-goog


