Return-Path: <stable+bounces-200207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CA8CA98A7
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 23:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5AD37301FA9E
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 22:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5673D3B3;
	Fri,  5 Dec 2025 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N9iYvFy+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202A81CD1E4
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 22:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764975106; cv=none; b=SJDoYaqdSmmAgZrNoFIJyIx5Yp8dOfzbnOvjVQmuzYefzskYTf6e3MhCWCsazVw+A4fSnuWwueWr/AvbYiDhn34uVrKXOSJfOI3I5CL6X1q+4g5hHU0jW62GQqS770a9RajL5nGehyIzJ/n0gFsBd1mNBp8ylG5kSXo7RoGAChw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764975106; c=relaxed/simple;
	bh=Ok8jTmdXZxogtxskwYzvmB15+ePBZ1aBYdxuQVq8go4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=g5PG+fpne3dBebLyGLo4fCp//VBNN8jB8QvjAdmjXPKzvZ6mvFAhYfaYEacANaVLbriO2Ut72yVtASH9sinRlSvBVCcEEk6HZ82rk+n1FqSGS0FzKVGSllt7jwwRZuRrkE8ltsnVBOK5OaZg788WB9Rz3jGdvBGS5sxHaVe3n60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N9iYvFy+; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-7c75250e724so4329838a34.0
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 14:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764975104; x=1765579904; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KZ6t7ECEa6TXHskG0snKO3BunyXOALdoY4sWT/SldB4=;
        b=N9iYvFy+DGldGXDJs/t9o2TWU4BpK2OGx5EXEvzP6hlTKDpf17EYKyM/rEB0rdZLi8
         3oz7aEazjRVCznSwEMj0mLIsMoqkBgshVvlMiDwpM2uWqFociG7mrBo4jKY3wesImXlJ
         Rpvfzz6BBFE4jgAisUvldX6zhi/LSc1ImG4dlbvb461KC3SHFpL/dzSwh0+B4uSA0x6p
         WSJixcRuBqQswbAi1jpCgIuXYAUevnIRmPn3F2mB1unXTfoeM6yNYHGwer1K+giS213F
         7zcanGfYyoXt1Oj1oFSbnjvokLGL3ZFlKHY1TYv7AVx0FhwklK0ZkQAdCDEfzytrUJqE
         AbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764975104; x=1765579904;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZ6t7ECEa6TXHskG0snKO3BunyXOALdoY4sWT/SldB4=;
        b=U1PEIyQvEm1TbJ1zMg5eW8gQu6s5w0FQtLWo8aHYKBC22DOIY40ZdtuRgFytnybPuM
         e7+Y+8dBe8L38GqHIFk6FKjAZFA5kLrb2kC8jMBtmHcNGp6sf9lRitQsymSEvPicxcrt
         i430C5Z/N0ZAm/+osqKxEv6Nzd7xuvepHQH9nUYlSHE4BV3L8G51GXjr8AOmUbOPONuO
         oKtd9a+bgqyTaPaFpR0XmbrYG1c5Yp3hLSKtUlf0RVXvDLocZxgRmrEvDpmLdra8q8my
         N2mjL2AnC5Ham7HR2eFAn7t7Eh96dTaSwOhilGg0jC9B44e7OnGEVfOzjjH7pDe2txfh
         Y9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUjQsSbZcSYq2eObqb3QUTSE7kaNYOwK5aY0fUA9cexgEZ0tzUpeK+yANsSGSkRoMrswbLRCF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVIxEwhSiNJaiJ4+uWOwBPFPuyzt1XEWb1rkSPGMMnm3ZNyqdS
	1oD3Ve5mzEA8IyiR85SHnQHtJjjrBsjKaC4AJk9iKcnODgZCCR/rQYlPDK6A2L5k6QMOC5pP0rx
	Wwca6vR3Svcc17RYmpIFhIRTqUA==
X-Google-Smtp-Source: AGHT+IGtsCfXiK6Ca9aoNBk4FCPOxvVSHwXC29bCUXc+AJsis0zprJjFy5EwP7iFzoRRKCHwHGUL9V6/X/OhgFQ8rg==
X-Received: from ilbbk5.prod.google.com ([2002:a05:6e02:3285:b0:433:7ad9:4c25])
 (user=justinstitt job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:178a:b0:659:9a49:9017 with SMTP id 006d021491bc7-6599a986298mr335711eaf.68.1764975104215;
 Fri, 05 Dec 2025 14:51:44 -0800 (PST)
Date: Fri, 05 Dec 2025 14:51:41 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPxhM2kC/42NvQ6CMBSFX8Xc2RJaUyxODrI66GgY+LnATbAlb
 UUJ4d2tfQKn85OT76zg0BI6OO1WsDiTI6NDEPsdNEOle2TUhgwiFTI9CsWcr+oRWUsu6kuTZ5O
 37F1ZzYTiHaIS8pA3EBCTxY4+Ef+ALOHJ8mtvxb24XqAMdiDnjV3i/czj7L+nmTPOcqlqzOssk yI998b0IyaNeUK5bdsXVem9KdoAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764975103; l=2094;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Ok8jTmdXZxogtxskwYzvmB15+ePBZ1aBYdxuQVq8go4=; b=+5fF9xjzd/gKfdwP8eCwDRuFOJpnnxJkpqF1OjNQdwbauu1LndafYJx35q8YJ0TDFXjqD60mE
 Rf4IC5n1OVHDQPc5ol2vyveK/sd6BcjvbO3xh/WRL1rUq+soDPpFDXv
X-Mailer: b4 0.12.3
Message-ID: <20251205-stable-disable-unit-ptr-warn-v2-1-cec53a8f736b@google.com>
Subject: [PATCH 6.1.y RESEND v2] KVM: arm64: sys_regs: disable
 -Wuninitialized-const-pointer warning
From: Justin Stitt <justinstitt@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Will Deacon <will@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Christopher Covington <cov@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

A new warning in Clang 22 [1] complains that @clidr passed to
get_clidr_el1() is an uninitialized const pointer. get_clidr_el1()
doesn't really care since it casts away the const-ness anyways -- it is
a false positive.

This patch isn't needed for anything past 6.1 as this code section was
reworked in Commit 7af0c2534f4c ("KVM: arm64: Normalize cache
configuration") which incidentally removed the aforementioned warning.
Since there is no upstream equivalent, this patch just needs to be
applied to 6.1.

Disable this warning for sys_regs.o instead of backporting the patches
from 6.2+ that modified this code area.

Cc: stable@vger.kernel.org
Fixes: 7c8c5e6a9101e ("arm64: KVM: system register handling")
Link: https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e [1]
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- disable warning for TU instead of initialising the struct
- update commit message
- Link to v1: https://lore.kernel.org/all/20250724-b4-clidr-unint-const-ptr-v1-1-67c4d620b6b6@google.com/
- Link to v1 resend (sent wrong diff, thanks Nathan): https://lore.kernel.org/all/20251204-b4-clidr-unint-const-ptr-v1-1-95161315ad92@google.com/
---
 arch/arm64/kvm/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 5e33c2d4645a..5fdb5331bfad 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -24,6 +24,9 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 
 kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
 
+# Work around a false positive Clang 22 -Wuninitialized-const-pointer warning
+CFLAGS_sys_regs.o := $(call cc-disable-warning, uninitialized-const-pointer)
+
 always-y := hyp_constants.h hyp-constants.s
 
 define rule_gen_hyp_constants

---
base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
change-id: 20250728-stable-disable-unit-ptr-warn-281fee82539c

Best regards,
--
Justin Stitt <justinstitt@google.com>


