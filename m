Return-Path: <stable+bounces-221797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML9XJ9qZo2kwIAUAu9opvQ
	(envelope-from <stable+bounces-221797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:43:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE6E1CB7B1
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E43E8306FE16
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D323F2DCF67;
	Sun,  1 Mar 2026 01:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvieI5NA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968132F3C34
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329161; cv=none; b=m/CSXZUGAaCn7U4fEfc4ESzwyk7ZJubj/FrljuxEJcTGpser62OWeGhwLaM842maRwSHXnB6UxE9dKkYoZEYICdsz4NscVcPgScgOq3eelZQDMiQjoD6RocQDl4GLcXBQCdeCNMQtPfeHDzseXVvwKTFnDKq1/vGahBtiB4U+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329161; c=relaxed/simple;
	bh=7HRUhMCSg+OSPm9O1veqgxOrbjeHvhJG/6MzA6/D3jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZpRSQjd364fVo1u2fDzx9TRrpoVZD10GuFgAvdaVkSRCYIxSl5dKuVJcaykI7ym8fHjXuR3KoIzfdEGpBAN8Ia924IHu2IhrmJU2iLkOTu21azUKRZ2jOBH2szRRLDcieco2iRPxV3bctkEtGhbnvDXY+fM5iK91PrbJIBc/ALw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvieI5NA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16115C19421;
	Sun,  1 Mar 2026 01:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329161;
	bh=7HRUhMCSg+OSPm9O1veqgxOrbjeHvhJG/6MzA6/D3jk=;
	h=From:To:Cc:Subject:Date:From;
	b=bvieI5NAfCZ9cgtdPDBIgxReev/tXI8xuj8kZp7s4V7Bf7HmbfAvYUvfZ0v0L2kLv
	 x0eMY4TPVASRRWjW/E4TV47QrfF7tnAHguxXjhzBMrqBWUfA1zXezI913ZgBOQ04JE
	 sux+YWccKwf7EjmFl8ckvER/fe1m37cDZzqlQ3pdX7YRBK8vkbo+lxfINtCcRwl9+R
	 dH5aoHV4tRKY+kaDICYG0Kf9Rcv005BtCuQGrADe38qTsD+uSlngyhalUXTyjT4j6s
	 y2+JJ6PS4kF5fqD/xKoiUBsOej4CWQSHjoS6yZ3LbFtPSbTTrUVu92zVjl1OK4iBCJ
	 OI4voI0zH3X9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ardb@kernel.org
Cc: Dave Young <dyoung@redhat.com>
Subject: FAILED: Patch "x86/kexec: Copy ACPI root pointer address from config table" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:39:19 -0500
Message-ID: <20260301013919.1700262-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221797-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5AE6E1CB7B1
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e00ac9e5afb5d80c0168ec88d8e8662a54af8249 Mon Sep 17 00:00:00 2001
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 17 Feb 2026 12:09:35 +0100
Subject: [PATCH] x86/kexec: Copy ACPI root pointer address from config table

Dave reports that kexec may fail when the first kernel boots via the EFI
stub but without EFI runtime services, as in that case, the RSDP address
field in struct bootparams is never assigned. Kexec copies this value
into the version of struct bootparams that it provides to the incoming
kernel, which may have no other means to locate the ACPI root pointer.

So take the value from the EFI config tables if no root pointer has been
set in the first kernel's struct bootparams.

Fixes: a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
Cc: <stable@vger.kernel.org> # v6.1
Reported-by: Dave Young <dyoung@redhat.com>
Tested-by: Dave Young <dyoung@redhat.com>
Link: https://lore.kernel.org/linux-efi/aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com/
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/kexec-bzimage64.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 7508d0ccc7403..251edc5a040fc 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -193,6 +193,13 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 	struct efi_info *current_ei = &boot_params.efi_info;
 	struct efi_info *ei = &params->efi_info;
 
+	if (!params->acpi_rsdp_addr) {
+		if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
+			params->acpi_rsdp_addr = efi.acpi20;
+		else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
+			params->acpi_rsdp_addr = efi.acpi;
+	}
+
 	if (!efi_enabled(EFI_RUNTIME_SERVICES))
 		return 0;
 
-- 
2.51.0





