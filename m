Return-Path: <stable+bounces-49889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A767E8FEF45
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68491C23CC1
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989511CBE86;
	Thu,  6 Jun 2024 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cc7ktxVb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570AE1CBE85;
	Thu,  6 Jun 2024 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683761; cv=none; b=XeSlQOELuFmjEB2IahGQTTVjRNHC8iYJRfVGFhjueu/15n1iorES/fUF+GtMdXXWe0rlycOrR6AgWBwavw/scGQazta3t+XXpv0yafbZZImZCOy1R6IcSSCxZzyhgD6w0ysfB2ahmOaWfZUFnVeUABWmKTsErHuvIRKlsr/bBUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683761; c=relaxed/simple;
	bh=MQPSTY6ZgOOkA6RY7oSnWW+6trILqsdfjVq//MZfQko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYfhK/2PgQ93KUj0QQOSDv7+zEdknzy+BdOl2PBSGU3ZOPjZwL/9Iw918JHsYDLCLgCjvDfTFj4USyS0mH6fpvlzLFRoUBA+YnGkRjaAruuNIXeQ6cSvNqK6od44NgrDTMguFvYhWSaSMX9I7aLr095b12WLVuH8IIGLVr2mCE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cc7ktxVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375ADC2BD10;
	Thu,  6 Jun 2024 14:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683761;
	bh=MQPSTY6ZgOOkA6RY7oSnWW+6trILqsdfjVq//MZfQko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cc7ktxVbI1npkn9GM4MhEIUJydKxH7Bv3P06naqL/7RPPgTwceQyDFAGSssu+JiqF
	 5ZStSyE83fyQF43UiAOI1TvT6qkle9qRcuN8Jphds4RDL3QeAmmk+ggUhz+exL4sdG
	 JXEJrH2nvln0xUKKEdc/ZJBoz2TNkspPVKNW5fPk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ben Chaney <bchaney@akamai.com>,
	Kees Cook <keescook@chromium.org>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.6 738/744] x86/efistub: Omit physical KASLR when memory reservations exist
Date: Thu,  6 Jun 2024 16:06:50 +0200
Message-ID: <20240606131756.137048779@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

commit 15aa8fb852f995dd234a57f12dfb989044968bb6 upstream.

The legacy decompressor has elaborate logic to ensure that the
randomized physical placement of the decompressed kernel image does not
conflict with any memory reservations, including ones specified on the
command line using mem=, memmap=, efi_fake_mem= or hugepages=, which are
taken into account by the kernel proper at a later stage.

When booting in EFI mode, it is the firmware's job to ensure that the
chosen range does not conflict with any memory reservations that it
knows about, and this is trivially achieved by using the firmware's
memory allocation APIs.

That leaves reservations specified on the command line, though, which
the firmware knows nothing about, as these regions have no other special
significance to the platform. Since commit

  a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")

these reservations are not taken into account when randomizing the
physical placement, which may result in conflicts where the memory
cannot be reserved by the kernel proper because its own executable image
resides there.

To avoid having to duplicate or reuse the existing complicated logic,
disable physical KASLR entirely when such overrides are specified. These
are mostly diagnostic tools or niche features, and physical KASLR (as
opposed to virtual KASLR, which is much more important as it affects the
memory addresses observed by code executing in the kernel) is something
we can live without.

Closes: https://lkml.kernel.org/r/FA5F6719-8824-4B04-803E-82990E65E627%40akamai.com
Reported-by: Ben Chaney <bchaney@akamai.com>
Fixes: a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
Cc:  <stable@vger.kernel.org> # v6.1+
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/efi/libstub/x86-stub.c |   28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -776,6 +776,26 @@ static void error(char *str)
 	efi_warn("Decompression failed: %s\n", str);
 }
 
+static const char *cmdline_memmap_override;
+
+static efi_status_t parse_options(const char *cmdline)
+{
+	static const char opts[][14] = {
+		"mem=", "memmap=", "efi_fake_mem=", "hugepages="
+	};
+
+	for (int i = 0; i < ARRAY_SIZE(opts); i++) {
+		const char *p = strstr(cmdline, opts[i]);
+
+		if (p == cmdline || (p > cmdline && isspace(p[-1]))) {
+			cmdline_memmap_override = opts[i];
+			break;
+		}
+	}
+
+	return efi_parse_options(cmdline);
+}
+
 static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 {
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
@@ -807,6 +827,10 @@ static efi_status_t efi_decompress_kerne
 		    !memcmp(efistub_fw_vendor(), ami, sizeof(ami))) {
 			efi_debug("AMI firmware v2.0 or older detected - disabling physical KASLR\n");
 			seed[0] = 0;
+		} else if (cmdline_memmap_override) {
+			efi_info("%s detected on the kernel command line - disabling physical KASLR\n",
+				 cmdline_memmap_override);
+			seed[0] = 0;
 		}
 	}
 
@@ -881,7 +905,7 @@ void __noreturn efi_stub_entry(efi_handl
 	}
 
 #ifdef CONFIG_CMDLINE_BOOL
-	status = efi_parse_options(CONFIG_CMDLINE);
+	status = parse_options(CONFIG_CMDLINE);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to parse options\n");
 		goto fail;
@@ -890,7 +914,7 @@ void __noreturn efi_stub_entry(efi_handl
 	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
 		unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
 					       ((u64)boot_params->ext_cmd_line_ptr << 32));
-		status = efi_parse_options((char *)cmdline_paddr);
+		status = parse_options((char *)cmdline_paddr);
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to parse options\n");
 			goto fail;



