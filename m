Return-Path: <stable+bounces-224329-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPrNKjsDsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224329-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:40:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BBA24B48B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94A59310BC80
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E42138E107;
	Tue, 10 Mar 2026 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fbci+iHQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3100E387587;
	Tue, 10 Mar 2026 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142024; cv=none; b=BNClVPbip7ENxLB4bS+PLaHtpiu6Cob4cB9a3/81aRvTKUFFTjjkHro29hdI9L9jVc5SAE+qZapFlrl27D70Cai9ayHxlA4w7pgr7dWryOd2gKjCYgX5UjKTFJ3s2c/olsRGh+D93Bu7pk9UG96mB5lNk/Nhnw0Z2XkayEMM0S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142024; c=relaxed/simple;
	bh=wI7Pnsmf0DB8qEydEVm5GZN+LfASciMIswxpG4HQewY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j74J9Je4u3Va6Pbv3NqogVivYJVBavLYUtIhL/oRGRItmZjLn5348e1wcWknloVgDY/JlbkyqiQcZ3DWahlxGAu2w38UE+sV2E4xqfyHCBFGyeN/A7OulQys9ZiA4+seNyPg8Wtgo5UEM3EaBnNlL6LvYOwdgDgZwm9OTRGYPcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fbci+iHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35441C19423;
	Tue, 10 Mar 2026 11:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142024;
	bh=wI7Pnsmf0DB8qEydEVm5GZN+LfASciMIswxpG4HQewY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fbci+iHQ1pGYKIdidHsZK1l9NddQ0mqWAF6jWiGWZe7mRTPCdVIahebpmMN2lgsqe
	 LWQVVm0ICKUqPiZnWAeM5zERT6VJjKD+7641YL9a/4lVl2/BO9IiG913jRiXU1bcys
	 pZ+dFz3Gie7qhV2bAzFyIAfVf7Tu8vEjQjjnPJyc7dfrQUTnEfFK0aUO3hpjPfoWmO
	 He2Gpdp6uasVfgWXBzKzb2qVD2APpE6RFfHIrJMILeEXoh/90R5d1AGW7t1TLCQ+4g
	 ayfxJ2D20GKGtu+krJrDlGs0qHP2KvCoYwcD67TdSA9CYehZHm58M6QX8G2gZcC9ah
	 suWWy/WZHVBWA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Kevin Hui <kevinhui@meta.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18 150/314] x86/boot/sev: Move SEV decompressor variables into the .data section
Date: Tue, 10 Mar 2026 07:16:49 -0400
Message-ID: <a8bae1461cf144161ad9a684dd8e3bc28c26ed89.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 12BBA24B48B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224329-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,meta.com:email,linuxfoundation.org:email,amd.com:email]
X-Rspamd-Action: no action

From: Tom Lendacky <thomas.lendacky@amd.com>

commit 4ca191cec17a997d0e3b2cd312f3a884288acc27 upstream.

As part of the work to remove the dependency on calling into the decompressor
code (startup_64()) for a UEFI boot, a call to rmpadjust() was removed from
sev_enable() in favor of checking the value of the snp_vmpl variable.

When booting through a non-UEFI path and calling startup_64(), the call to
sev_enable() is performed before the BSS section is zeroed. With the removal
of the rmpadjust() call and the corresponding check of the return code, the
snp_vmpl variable is checked.

Since the kernel is running at VMPL0, the snp_vmpl variable will not have been
set and should be the default value of 0.  However, since the call occurs
before the BSS is zeroed, the snp_vmpl variable may not actually be zero,
which will cause the guest boot to fail.

Since the decompressor relocates itself, the BSS would need to be cleared both
before and after the relocation, but this would, in effect, cause all of the
changes to BSS variables before relocation to be lost after relocation.

Instead, move the snp_vmpl variable into the .data section so that it is
initialized and the value made safe during relocation. As a pre-caution
against future changes, move other SEV-related decompressor variables into the
.data section, too.

Fixes: 68a501d7fd82 ("x86/boot: Drop redundant RMPADJUST in SEV SVSM presence check")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Changyuan Lyu <changyuanl@google.com>
Tested-by: Kevin Hui <kevinhui@meta.com>
Tested-by: Changyuan Lyu <changyuanl@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/5648b7de5b0a5d0dfef3785f9582b718678c6448.1770217260.git.thomas.lendacky@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/boot/compressed/sev.c     | 8 ++++----
 arch/x86/boot/startup/sev-shared.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 0d20bc178629e..b688303666052 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -27,17 +27,17 @@
 #include "sev.h"
 
 static struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
-struct ghcb *boot_ghcb;
+struct ghcb *boot_ghcb __section(".data");
 
 #undef __init
 #define __init
 
 #define __BOOT_COMPRESSED
 
-u8 snp_vmpl;
-u16 ghcb_version;
+u8 snp_vmpl __section(".data");
+u16 ghcb_version __section(".data");
 
-u64 boot_svsm_caa_pa;
+u64 boot_svsm_caa_pa __section(".data");
 
 /* Include code for early handlers */
 #include "../../boot/startup/sev-shared.c"
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 4e22ffd735168..e52e886ad313d 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -31,7 +31,7 @@ static u32 cpuid_std_range_max __ro_after_init;
 static u32 cpuid_hyp_range_max __ro_after_init;
 static u32 cpuid_ext_range_max __ro_after_init;
 
-bool sev_snp_needs_sfw;
+bool sev_snp_needs_sfw __section(".data");
 
 void __noreturn
 sev_es_terminate(unsigned int set, unsigned int reason)
-- 
2.51.0


