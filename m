Return-Path: <stable+bounces-77201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CFC985A0D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0291F2131B
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B091B2EC0;
	Wed, 25 Sep 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTB28lf6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBA71B29C1;
	Wed, 25 Sep 2024 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264498; cv=none; b=o/JbZw4OnrN/o9AxYxJ+lMnojcZ+2Vdx7H0hBUzBHd+9oC+PIBcEM94cu5O7+a0dGqgDkG+4drmHqFOScekOCW2vD2We4H62t4mhC4eVK7MO/Yetu5mnTJVdJvr++Habm0WEb1/PWRzDDlDYkorQSmA/R2WcYxRfHeGPBHOuIB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264498; c=relaxed/simple;
	bh=yAsjGmzhk7oPiKoh2767+SxCR8rtYXdH4zooQEBJeS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQisQ15iG1y39gvnqHKVnL0x7wfjq9ozYwB5+hNmz4qDfLNbbHM9jjbgaMzfwmQ0v6FjeyJRoo0t6EpUXw0JxXLQQY7IejjBjaZ6EXZY39r8fxaCpchX/n322bBV3uwwmh20iOUpslofSuGGPUiugxygriFsSBbpXIGJtMu73BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTB28lf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4A0C4CEC3;
	Wed, 25 Sep 2024 11:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264498;
	bh=yAsjGmzhk7oPiKoh2767+SxCR8rtYXdH4zooQEBJeS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iTB28lf6rzFRffrealtKJhOtXcKI6fxIQFdmBNoNZhnCpuPtnhHezKGXJnyL4oRHT
	 rLhzcxHFA5zTs/PSCWrb8w0lnpqCc3d1re1rCTYGhvJjezMjbbOZb/IhT5LJk7ju5c
	 eMXGw6lF7bR49f890VzaMps9wUaucvAN8WDDHSyqliCAtXk4gkVPADM6J+nUe9wj27
	 mMzUzuNDrvY/kI9nLfOIFiJLJC93aF59qX1O283X9AtyQZOBlPOVjgDAzQZT037Wh+
	 Qt41VJ512173G6AaT75zngUEDAnj4icNAm4wAO40Ls4SlGYISWuh9izFbodChtTo/L
	 vMjs4X6ytuXog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tao Liu <ltao@redhat.com>,
	Steve Wahl <steve.wahl@hpe.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Pavin Joseph <me@pavinjoseph.com>,
	Sarah Brofeldt <srhb@dbc.dk>,
	Eric Hagberg <ehagberg@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	ytcoode@gmail.com,
	david.kaplan@amd.com
Subject: [PATCH AUTOSEL 6.11 103/244] x86/kexec: Add EFI config table identity mapping for kexec kernel
Date: Wed, 25 Sep 2024 07:25:24 -0400
Message-ID: <20240925113641.1297102-103-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Tao Liu <ltao@redhat.com>

[ Upstream commit 5760929f6545c651682de3c2c6c6786816b17bb1 ]

A kexec kernel boot failure is sometimes observed on AMD CPUs due to an
unmapped EFI config table array.  This can be seen when "nogbpages" is on
the kernel command line, and has been observed as a full BIOS reboot rather
than a successful kexec.

This was also the cause of reported regressions attributed to Commit
7143c5f4cf20 ("x86/mm/ident_map: Use gbpages only where full GB page should
be mapped.") which was subsequently reverted.

To avoid this page fault, explicitly include the EFI config table array in
the kexec identity map.

Further explanation:

The following 2 commits caused the EFI config table array to be
accessed when enabling sev at kernel startup.

    commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
                          earlier during boot")
    commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
                          detection/setup")

This is in the code that examines whether SEV should be enabled or not, so
it can even affect systems that are not SEV capable.

This may result in a page fault if the EFI config table array's address is
unmapped. Since the page fault occurs before the new kernel establishes its
own identity map and page fault routines, it is unrecoverable and kexec
fails.

Most often, this problem is not seen because the EFI config table array
gets included in the map by the luck of being placed at a memory address
close enough to other memory areas that *are* included in the map created
by kexec.

Both the "nogbpages" command line option and the "use gpbages only where
full GB page should be mapped" change greatly reduce the chance of being
included in the map by luck, which is why the problem appears.

Signed-off-by: Tao Liu <ltao@redhat.com>
Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Pavin Joseph <me@pavinjoseph.com>
Tested-by: Sarah Brofeldt <srhb@dbc.dk>
Tested-by: Eric Hagberg <ehagberg@gmail.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/all/20240717213121.3064030-2-steve.wahl@hpe.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/machine_kexec_64.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index cc0f7f70b17ba..9c9ac606893e9 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
+#include <asm/efi.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -87,6 +88,8 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
 {
 #ifdef CONFIG_EFI
 	unsigned long mstart, mend;
+	void *kaddr;
+	int ret;
 
 	if (!efi_enabled(EFI_BOOT))
 		return 0;
@@ -102,6 +105,30 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
 	if (!mstart)
 		return 0;
 
+	ret = kernel_ident_mapping_init(info, level4p, mstart, mend);
+	if (ret)
+		return ret;
+
+	kaddr = memremap(mstart, mend - mstart, MEMREMAP_WB);
+	if (!kaddr) {
+		pr_err("Could not map UEFI system table\n");
+		return -ENOMEM;
+	}
+
+	mstart = efi_config_table;
+
+	if (efi_enabled(EFI_64BIT)) {
+		efi_system_table_64_t *stbl = (efi_system_table_64_t *)kaddr;
+
+		mend = mstart + sizeof(efi_config_table_64_t) * stbl->nr_tables;
+	} else {
+		efi_system_table_32_t *stbl = (efi_system_table_32_t *)kaddr;
+
+		mend = mstart + sizeof(efi_config_table_32_t) * stbl->nr_tables;
+	}
+
+	memunmap(kaddr);
+
 	return kernel_ident_mapping_init(info, level4p, mstart, mend);
 #endif
 	return 0;
-- 
2.43.0


