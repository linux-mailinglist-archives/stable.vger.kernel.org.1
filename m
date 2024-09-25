Return-Path: <stable+bounces-77614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4DD985F25
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED181C25C8F
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618221885A0;
	Wed, 25 Sep 2024 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpQmXHnc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB06188598;
	Wed, 25 Sep 2024 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266483; cv=none; b=HF//AGQ8AE5tfE0cqpouhFfThfPiL8MsI0PXqyqDhWTzOBpw84UMoeamfAT0CvK1Kh/mCdjnJH+Y7/YHs6+fg0KLf3WfniLaTt4S4ePqUFV74YysEPkm3rEeSsvB8VJT+Z0B/7+xqBqe4I8rfq68IxJGqsSZv1tXkdue4mXtW/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266483; c=relaxed/simple;
	bh=Vp8R+/qaspTgdizqroZB0Cd0hd0g6Iz6ztmnrfoDv3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpdRLb1JFj98tTZ6j5yqV6GrwXhCeTOrEZC8wPr0TDljvgszJEl6xjtxq13qiPLNaNjqNv5gwC2gyuuGBLcb0buwbCeLDcXuuFDsLgAiIA8LMaHoia1nIP7Is0rejyNNKKAXSyYBIorl+qYF+s9VTeCFCdoTrf79PQi3AzP8stI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpQmXHnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB6BC4CECD;
	Wed, 25 Sep 2024 12:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266483;
	bh=Vp8R+/qaspTgdizqroZB0Cd0hd0g6Iz6ztmnrfoDv3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QpQmXHnczHLlkbEMCQD4f38gR5v/QVUQPX4LINidl+K/df/tax4vjwd+bprLfqce7
	 Xcgb4PTnT3hKyBEOxTdQFBzqdIgephkI51q2rCTmdMY7CDJvc8ZINa3RRXGKpfXfjl
	 fVVl44XJg3Z0YHXiopr9M7oyNXWkHF+LiJYsNERwp3vgrPlrtwrEsmHHw3v3Tr1Xj2
	 E05cPxPRUHDUs8D0mPJX43VNoRD5ruiftQbvs8vNrmF/erTQ/Hp8SsQ3vgqlbmjGl+
	 eEpxhn9//jpJquzgmcvB70v060QMurUGpHl6umPVIxK3QAnvQq8m5OnkLBWLuHcvVP
	 uGceGPidm14Og==
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
Subject: [PATCH AUTOSEL 6.6 067/139] x86/kexec: Add EFI config table identity mapping for kexec kernel
Date: Wed, 25 Sep 2024 08:08:07 -0400
Message-ID: <20240925121137.1307574-67-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index d287fe290c9ab..2fa12d1dc6760 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
+#include <asm/efi.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -90,6 +91,8 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
 {
 #ifdef CONFIG_EFI
 	unsigned long mstart, mend;
+	void *kaddr;
+	int ret;
 
 	if (!efi_enabled(EFI_BOOT))
 		return 0;
@@ -105,6 +108,30 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
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


