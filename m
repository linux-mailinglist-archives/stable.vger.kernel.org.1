Return-Path: <stable+bounces-89954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7FF9BDBE8
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89262B2327B
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3681922C6;
	Wed,  6 Nov 2024 02:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pp/6OczF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C34418FDD2;
	Wed,  6 Nov 2024 02:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858948; cv=none; b=LyHuWPK1wdzH+/QYFcWfKH/8z7ZVbj2jBhbsaeYX0oFMiWocklWcBrXlLyKcMgJpVw5JaxTdwTE2uIGsVknB5fHC51QmyUrfqNm70joSkarMHcw6wTKYGYwoQpZmmq7XAJRg+KH2fnqKqx0wLCFmzPzco3WU7lC/pA8Xn9Vo+ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858948; c=relaxed/simple;
	bh=B6UfHUEIWaWEcRpuQYHyphb64JFnYui36KlElCdvEMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QLW4cCuJJ3XGEf8rkdV8KKaXVmWTmluiXADjEdQWONHG3HNc5j0m0gTWpWgDD262h+uU4m3t/+7IgnOzlhtEajtGaHWbSHeKHqbKhl2GULh9/eGTL4zjwBCfG6iFQRMk/GYw6edRk0s9+XVwtoU6ptixRo+O3TT4AxA4l7DM/PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pp/6OczF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC2DC4CECF;
	Wed,  6 Nov 2024 02:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730858947;
	bh=B6UfHUEIWaWEcRpuQYHyphb64JFnYui36KlElCdvEMI=;
	h=From:To:Cc:Subject:Date:From;
	b=pp/6OczFTLqCbavqo5uroOck8H6ydjhl7AT2DlOHW2E3WqKmDVsAtMgYcxE7V/aJN
	 LKKjhETSZ+55SPsE31ftzGwTPmxlDxLOjlHPNX6UaMabxT+0oGkMBgFT+xD/zQgagu
	 x/4PaQve54ASACcSFg6VBqk1kNqDImCMVHNvgDv1eEt4vAVJadYFXoIM8KZjeuWwK6
	 /RcpiTOTxfB9tAkQ+CBYZw3yX+I6OhbveqlbYHM8hlfIODOfOO64IOVfIBtuZu2lhQ
	 Bc9zAAuxHNIhoCxUB/0u5ZNv5LVz3U8yLB5Z4lTYfu8zUKyt+hqYlOi/34+W1237UG
	 URAaJsSu3MMzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	alexghiti@rivosinc.com
Cc: Jason Montleon <jmontleo@redhat.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: FAILED: Patch "riscv: Do not use fortify in early code" failed to apply to v6.6-stable tree
Date: Tue,  5 Nov 2024 21:09:04 -0500
Message-ID: <20241106020905.164658-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From afedc3126e11ff1404b32e538657b68022e933ca Mon Sep 17 00:00:00 2001
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 9 Oct 2024 09:27:49 +0200
Subject: [PATCH] riscv: Do not use fortify in early code

Early code designates the code executed when the MMU is not yet enabled,
and this comes with some limitations (see
Documentation/arch/riscv/boot.rst, section "Pre-MMU execution").

FORTIFY_SOURCE must be disabled then since it can trigger kernel panics
as reported in [1].

Reported-by: Jason Montleon <jmontleo@redhat.com>
Closes: https://lore.kernel.org/linux-riscv/CAJD_bPJes4QhmXY5f63GHV9B9HFkSCoaZjk-qCT2NGS7Q9HODg@mail.gmail.com/ [1]
Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
Fixes: 26e7aacb83df ("riscv: Allow to downgrade paging mode from the command line")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20241009072749.45006-1-alexghiti@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/errata/Makefile    | 6 ++++++
 arch/riscv/kernel/Makefile    | 5 +++++
 arch/riscv/kernel/pi/Makefile | 6 +++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
index 8a27394851233..f0da9d7b39c37 100644
--- a/arch/riscv/errata/Makefile
+++ b/arch/riscv/errata/Makefile
@@ -2,6 +2,12 @@ ifdef CONFIG_RELOCATABLE
 KBUILD_CFLAGS += -fno-pie
 endif
 
+ifdef CONFIG_RISCV_ALTERNATIVE_EARLY
+ifdef CONFIG_FORTIFY_SOURCE
+KBUILD_CFLAGS += -D__NO_FORTIFY
+endif
+endif
+
 obj-$(CONFIG_ERRATA_ANDES) += andes/
 obj-$(CONFIG_ERRATA_SIFIVE) += sifive/
 obj-$(CONFIG_ERRATA_THEAD) += thead/
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 7f88cc4931f5c..69dc8aaab3fb3 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -36,6 +36,11 @@ KASAN_SANITIZE_alternative.o := n
 KASAN_SANITIZE_cpufeature.o := n
 KASAN_SANITIZE_sbi_ecall.o := n
 endif
+ifdef CONFIG_FORTIFY_SOURCE
+CFLAGS_alternative.o += -D__NO_FORTIFY
+CFLAGS_cpufeature.o += -D__NO_FORTIFY
+CFLAGS_sbi_ecall.o += -D__NO_FORTIFY
+endif
 endif
 
 extra-y += vmlinux.lds
diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefile
index d5bf1bc7de62e..81d69d45c06c3 100644
--- a/arch/riscv/kernel/pi/Makefile
+++ b/arch/riscv/kernel/pi/Makefile
@@ -16,8 +16,12 @@ KBUILD_CFLAGS	:= $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 KBUILD_CFLAGS	+= -mcmodel=medany
 
 CFLAGS_cmdline_early.o += -D__NO_FORTIFY
-CFLAGS_lib-fdt_ro.o += -D__NO_FORTIFY
 CFLAGS_fdt_early.o += -D__NO_FORTIFY
+# lib/string.c already defines __NO_FORTIFY
+CFLAGS_ctype.o += -D__NO_FORTIFY
+CFLAGS_lib-fdt.o += -D__NO_FORTIFY
+CFLAGS_lib-fdt_ro.o += -D__NO_FORTIFY
+CFLAGS_archrandom_early.o += -D__NO_FORTIFY
 
 $(obj)/%.pi.o: OBJCOPYFLAGS := --prefix-symbols=__pi_ \
 			       --remove-section=.note.gnu.property \
-- 
2.43.0





