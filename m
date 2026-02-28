Return-Path: <stable+bounces-220906-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADgNH5ZIo2l//AQAu9opvQ
	(envelope-from <stable+bounces-220906-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:57:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A061C79DC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09F7A326795D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3DC429084;
	Sat, 28 Feb 2026 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4yrIJ0K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F0A429E76;
	Sat, 28 Feb 2026 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300794; cv=none; b=EQWYBk8Q7zre6WVqevCwv4Wqu05DiQ86BemQxpiXcubLTIbnVE9WA1A5wbV5UcSPsTacmkdj7ae8Bk0Qr1WjctE2wAnnc+2/hQ1akmSuxFefJT4IA4bQ7vZVCHXlRc16CwxW4vPkrATWFOMhUx1lHu3mVll4SIDNIkEAG5wruqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300794; c=relaxed/simple;
	bh=49oIs/oTGfxRNFYKoZCt0EzCE9469vwMbZg/yGgoTnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8UIK7WbmxQi4aigXmFnlCmKYznI1AuK3Xb3Xx+67FdcooGIrR6wjHPXqpZco2gXwZEpXxdVEflxZMRj3htqL7x4PGSst1xTUUJpNvOqRj/99BnnramYhjDHVKQ/UowaBtvEZaCzLDlFLPIBxltt0AhG7GXDXWuNAZb/IyeeQn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4yrIJ0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F811C19424;
	Sat, 28 Feb 2026 17:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300794;
	bh=49oIs/oTGfxRNFYKoZCt0EzCE9469vwMbZg/yGgoTnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s4yrIJ0KoTXuYK2QKaUMz1BypxTYpS1iM4v49nqF7/hvwgtLu58dgCeEXM+095g9q
	 t6zXLL3bvigmEMkC15CGAdg6VcdXhL+X35p0EgdGD/y1zC1b7AwMMw+YceyKBkyK8L
	 6UlWAOSGY22hVkNvhnGxlGoVHF2fg0rFuZ/5Qou4rFxhNYlSuI2MpDfV7JfpFWMrHy
	 bce3C7KJ5w/MoKjaieWhTkIj6WkKizHganuOJMTOT7WiYHJQ6i2oEN04tZJXgwiG22
	 BVY98v2pkG12rj6xJ1rrWbMsd5MUONcTEO7WelliJd6f/pTHLoeIvjFiFnruiuUOm+
	 TE99WhckBRfIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 827/844] x86/kexec: Copy ACPI root pointer address from config table
Date: Sat, 28 Feb 2026 12:32:20 -0500
Message-ID: <20260228173244.1509663-828-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220906-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43A061C79DC
X-Rspamd-Action: no action

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit e00ac9e5afb5d80c0168ec88d8e8662a54af8249 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/kexec-bzimage64.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index c3244ac680d14..f3b451eb49be1 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -192,6 +192,13 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
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


