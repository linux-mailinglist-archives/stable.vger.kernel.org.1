Return-Path: <stable+bounces-40237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353878AA9CA
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF3D28443F
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D7B4E1DC;
	Fri, 19 Apr 2024 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0dhmSpTL"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C88B3A1A8
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514290; cv=none; b=T48Zu+xflqRZoHOjzbIPYJ5Y9Sf/PUtuuQdyWf6GR5m1GD/th9MsoNFHp1/2B0ahi8qYGr4zSsosm08iRm2fIV5j9dDQcPS/flbwh+i7CZjnQTbd9ThJ/GaX16h/2VsX0Opb3vwrIQn0yZY7kQq4teePIADqt84FopibGDnunag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514290; c=relaxed/simple;
	bh=cZlrK7VcBPGaKBKQRUFHRJ6afrO+p/fmZ53D4tt7mhA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=umMCOp3DFrqsC5x0P8xAWy9feta1jA9JwRNmtX6Fx5KGELn8tn2Q2bBU7nEA3bhMBSVVU+NkHG2HjUGsEk623pVJ4iF9kIHM5fZcewDz5HTBcizXIiJNOMyq2EoUm0n9hxNNC0F02v83Fmf0HUJZGAnrUnezF6paZZWx4sW9nIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0dhmSpTL; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de3d9eacb57so3379033276.1
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514288; x=1714119088; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ryXdNdXc58/TKL5CJXa7BnnxRoM5W5YL7HE9+rH2Rcg=;
        b=0dhmSpTLmlWj9zOy3dF6FkylzhMaAZV4B+xa09h5MInjhHm8Mfv7FkdT7dLD93bubm
         LBpHK9Eub2NZvTi0BEEJaEuQY/hwzpFZrq8D/Vmg0bOW4YF/x9pGpGugJQhU/pp9yvn3
         4ahVPfZD53UbcVD4JUUwoYLpnxI48XXQuLOMvSNflcdd+aCSLD816cdeoMItCtsjKchw
         xUzcYK19HavMrntSXL8quyR0b+byZEV1KjZ+mfTqWmGOE/p9kFbN1ATPo3z3dGOAvP3F
         wgJuV4TW0Vh8qd+hV2AALaQb/E+zFMwij5szSJ7l8pyAw9oZz8aoF/1MnP7EuJtG25as
         VzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514288; x=1714119088;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryXdNdXc58/TKL5CJXa7BnnxRoM5W5YL7HE9+rH2Rcg=;
        b=DGs776sX7BxNKX1OwQV6JiR+cCOByR6SfI4V12VO+WPvTLqppKIxm/falg0lGzjlkz
         YMd1NoBN++4fj8thYilND9/Bjd3VeXdlTrgcJA5TDlIv//6sNoTp4T45PEUU5OE6PDx7
         PoywKd4fC1eZkq52FCjz93lqFLCTaGRYKzgCgDIS2qchRlm4N8R7AT29h10wjnKE+dYT
         GlilYg7EEflu/9FmxLvxxO5v4UGJlix1pmYGdXDyjbygSJnyvt/5EU4+vnrBZ4EbgaNg
         Au+8BnLO8mc4COHB2LgIDEax2VtzsS1CeipcHJescjHGzErziTtCxHMShqWsYrudKG1J
         IuDg==
X-Gm-Message-State: AOJu0YzF3sXaam+h3uq7qdzLsYU+bSTWOg5ojlm2TeqBgAf7w4KWyz8Y
	vGn9KACM1jSs5VOmMdyBqliDjHuqFmLYjKwMDZLTZI7OLaZDKzXrEqTS+8Fxbrhd5KVv1WuYk1R
	JdePpVT0clYqRQO+cNRGoziCcYKbdE0+9BkcinXQ9Cd/rtbSKPDzMDA7eC/StOvuwL20G1tgMfV
	vnKmCRfVzLvDP/UCpP3+T7aw==
X-Google-Smtp-Source: AGHT+IEY3HRfEHMwd0csvtmRA4RltOcwGdaUEVkxlLjvQAj5U7pYlxJYZI6WOrYPkJLE+d9GIXtA0tbm
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:c10:b0:dbd:b165:441 with SMTP id
 fs16-20020a0569020c1000b00dbdb1650441mr399894ybb.0.1713514288514; Fri, 19 Apr
 2024 01:11:28 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:07 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898; i=ardb@kernel.org;
 h=from:subject; bh=jQO+2WRntDgctTjxEk/+b/vWauI/fszL3dFNg5TRPCg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXSpKqHz6m9SrAaySh/qUm8+y3Zt4R6Qpb9qPXRe93
 xyXZ2PrKGFhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPhi2X4Zx0YoCGRvrBa5I7t
 SZd/R6Z8V1vZE/d/cfPX8iYnZw7RLQw/ZkdLnVsqcOwdY7K+ve2KNUxZfl9f7Zny6cD/mKNWv3a zAgA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-26-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 01/23] x86/efi: Drop EFI stub .bss from .data section
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 5f51c5d0e905608ba7be126737f7c84a793ae1aa upstream ]

Now that the EFI stub always zero inits its BSS section upon entry,
there is no longer a need to place the BSS symbols carried by the stub
into the .data section.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230912090051.4014114-18-ardb@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/vmlinux.lds.S | 1 -
 drivers/firmware/efi/libstub/Makefile  | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 112b2375d021..32892e81bf61 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -46,7 +46,6 @@ SECTIONS
 		_data = . ;
 		*(.data)
 		*(.data.*)
-		*(.bss.efistub)
 		_edata = . ;
 	}
 	. = ALIGN(L1_CACHE_BYTES);
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 473ef18421db..748781c25787 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -102,13 +102,6 @@ lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
 # https://bugs.llvm.org/show_bug.cgi?id=46480
 STUBCOPY_FLAGS-y		+= --remove-section=.note.gnu.property
 
-#
-# For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
-# .bss section, so the .bss section of the EFI stub needs to be included in the
-# .data section of the compressed kernel to ensure initialization. Rename the
-# .bss section here so it's easy to pick out in the linker script.
-#
-STUBCOPY_FLAGS-$(CONFIG_X86)	+= --rename-section .bss=.bss.efistub,load,alloc
 STUBCOPY_RELOC-$(CONFIG_X86_32)	:= R_386_32
 STUBCOPY_RELOC-$(CONFIG_X86_64)	:= R_X86_64_64
 
-- 
2.44.0.769.g3c40516874-goog


