Return-Path: <stable+bounces-7270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2823A8171C3
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF63283716
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8993D5BF90;
	Mon, 18 Dec 2023 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="udxDxizU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507B822091;
	Mon, 18 Dec 2023 14:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80ACBC433C9;
	Mon, 18 Dec 2023 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908015;
	bh=nhtunOzJDJ7PytPlhLbzjCv1OczbSKGfczoOtTqI5fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=udxDxizUF6A3K3PCfGvsfY8eNlZjX3JgjFC60N30KtT5aqIfnC+uwI2p2ZU7tJ7rI
	 8e5w3DATo+/GQ1WGuXx4VO9KIlPQN0BhAP1kG//73wdPNlM7u++O+wRxLCWoUG/mOW
	 cogSh/RDM16ucPNlGWj3YPdlBXgyXP4gWjTyu3ZM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 004/166] efi/x86: Avoid physical KASLR on older Dell systems
Date: Mon, 18 Dec 2023 14:49:30 +0100
Message-ID: <20231218135105.135201382@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit 50d7cdf7a9b1ab6f4f74a69c84e974d5dc0c1bf1 ]

River reports boot hangs with v6.6 and v6.7, and the bisect points to
commit

  a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")

which moves the memory allocation and kernel decompression from the
legacy decompressor (which executes *after* ExitBootServices()) to the
EFI stub, using boot services for allocating the memory. The memory
allocation succeeds but the subsequent call to decompress_kernel() never
returns, resulting in a failed boot and a hanging system.

As it turns out, this issue only occurs when physical address
randomization (KASLR) is enabled, and given that this is a feature we
can live without (virtual KASLR is much more important), let's disable
the physical part of KASLR when booting on AMI UEFI firmware claiming to
implement revision v2.0 of the specification (which was released in
2006), as this is the version these systems advertise.

Fixes: a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218173
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 31 +++++++++++++++++++------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 9d5df683f8821..70b325a2f1f31 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -307,17 +307,20 @@ static void setup_unaccepted_memory(void)
 		efi_err("Memory acceptance protocol failed\n");
 }
 
+static efi_char16_t *efistub_fw_vendor(void)
+{
+	unsigned long vendor = efi_table_attr(efi_system_table, fw_vendor);
+
+	return (efi_char16_t *)vendor;
+}
+
 static const efi_char16_t apple[] = L"Apple";
 
 static void setup_quirks(struct boot_params *boot_params)
 {
-	efi_char16_t *fw_vendor = (efi_char16_t *)(unsigned long)
-		efi_table_attr(efi_system_table, fw_vendor);
-
-	if (!memcmp(fw_vendor, apple, sizeof(apple))) {
-		if (IS_ENABLED(CONFIG_APPLE_PROPERTIES))
-			retrieve_apple_device_properties(boot_params);
-	}
+	if (IS_ENABLED(CONFIG_APPLE_PROPERTIES) &&
+	    !memcmp(efistub_fw_vendor(), apple, sizeof(apple)))
+		retrieve_apple_device_properties(boot_params);
 }
 
 /*
@@ -799,11 +802,25 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && !efi_nokaslr) {
 		u64 range = KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR - kernel_total_size;
+		static const efi_char16_t ami[] = L"American Megatrends";
 
 		efi_get_seed(seed, sizeof(seed));
 
 		virt_addr += (range * seed[1]) >> 32;
 		virt_addr &= ~(CONFIG_PHYSICAL_ALIGN - 1);
+
+		/*
+		 * Older Dell systems with AMI UEFI firmware v2.0 may hang
+		 * while decompressing the kernel if physical address
+		 * randomization is enabled.
+		 *
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=218173
+		 */
+		if (efi_system_table->hdr.revision <= EFI_2_00_SYSTEM_TABLE_REVISION &&
+		    !memcmp(efistub_fw_vendor(), ami, sizeof(ami))) {
+			efi_debug("AMI firmware v2.0 or older detected - disabling physical KASLR\n");
+			seed[0] = 0;
+		}
 	}
 
 	status = efi_random_alloc(alloc_size, CONFIG_PHYSICAL_ALIGN, &addr,
-- 
2.43.0




