Return-Path: <stable+bounces-222572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHaCAENnpWmx+wUAu9opvQ
	(envelope-from <stable+bounces-222572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:32:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C16CF1D68FC
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59F00301945D
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 10:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7143314A1;
	Mon,  2 Mar 2026 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="34ddcHF1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X+PXoftM"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8904232ABCD;
	Mon,  2 Mar 2026 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447549; cv=none; b=W49W4WFafyD2wziftQOp2K/cJWBT7XdsE3pNCWXX7m5e4zEPqcu+0fx/gdjeGPJjh/dq8DqXofUPMmBie7ogHNHyM++NoLvUhuL7tnpALOZZ26BsttVgTv6EgXj954Eu9d8+AO55qHxUklhZKOJ2QxccDNxsT2pSdq7Z/OutcR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447549; c=relaxed/simple;
	bh=a+h43aMFRtxSVb9RO2805noywvtdGvo0VfuqXMJbjaE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=raJuTd5/7C/gsksf5FGUucygsGDe9vNNZinNdHN8mdzUvoj8xTM+WuPKwIHGPM8pjVSKAj9YbZhEseNRaezLGEwn82b3DZBOR5AihJs3zaJS0yHYwiexdD3zL84F4/+bal0+tmgf6PQ/TTNv4ekT9si/H9xyw96rJ+8i8Q34t9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=34ddcHF1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X+PXoftM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Mar 2026 10:32:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772447547;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0ztioGz8P/XNXK3nDNFZJNrzJJPB1gxSoMAXQzGG/k=;
	b=34ddcHF1kj+M6B8Gj0R127f2gjHy8Qh75zBclz6HKjAmmj+Y/cmzorLvJFCTXGu48mo8nQ
	u6tBj8uSRza6xrOOZdjHy7bjgv1VoNXmRVM8rCNZdW+NqTHMI0qQWstcue8GOKDgCNM0tG
	Qdbovy3wiwujD/KlOLIkZQ6C2wc+GOXxnTHkj2JCwqu+JskF22KUdZtuMch8iLMOaP5FoL
	CY3TTom4B2MtiNSZty1lRqL7RrQZgaWVEbuxxZJ//VFZHvx6ihoBHdNq8or9bGLSLc9U9x
	H/HjN14Uuw7r+45Idsz+5EZxmm+F4D0RD2hsXismAsi9dxI7sD6yVH+jScwuJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772447547;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0ztioGz8P/XNXK3nDNFZJNrzJJPB1gxSoMAXQzGG/k=;
	b=X+PXoftMhgZAhMnx53l4wbTOJK8TQ4MxHiDMv7DPqxNeftrr1/8GJZnKBxFlj7y+i25/1S
	LO2S+6NM9tCtGWCQ==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot/sev: Move SEV decompressor variables into
 the .data section
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
 Changyuan Lyu <changyuanl@google.com>, Kevin Hui <kevinhui@meta.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C5648b7de5b0a5d0dfef3785f9582b718678c6448=2E1770217?=
 =?utf-8?q?260=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C5648b7de5b0a5d0dfef3785f9582b718678c6448=2E17702172?=
 =?utf-8?q?60=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177244754589.1647592.11010795601532256454.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222572-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,linutronix.de:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: C16CF1D68FC
X-Rspamd-Action: no action

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4ca191cec17a997d0e3b2cd312f3a884288acc27
Gitweb:        https://git.kernel.org/tip/4ca191cec17a997d0e3b2cd312f3a884288=
acc27
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 04 Feb 2026 09:01:00 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 02 Mar 2026 11:08:33 +01:00

x86/boot/sev: Move SEV decompressor variables into the .data section

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

Fixes: 68a501d7fd82 ("x86/boot: Drop redundant RMPADJUST in SEV SVSM presence=
 check")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Changyuan Lyu <changyuanl@google.com>
Tested-by: Kevin Hui <kevinhui@meta.com>
Tested-by: Changyuan Lyu <changyuanl@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/5648b7de5b0a5d0dfef3785f9582b718678c6448.17702=
17260.git.thomas.lendacky@amd.com
---
 arch/x86/boot/compressed/sev.c     | 8 ++++----
 arch/x86/boot/startup/sev-shared.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index c8c1464..46b5472 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -28,17 +28,17 @@
 #include "sev.h"
=20
 static struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
-struct ghcb *boot_ghcb;
+struct ghcb *boot_ghcb __section(".data");
=20
 #undef __init
 #define __init
=20
 #define __BOOT_COMPRESSED
=20
-u8 snp_vmpl;
-u16 ghcb_version;
+u8 snp_vmpl __section(".data");
+u16 ghcb_version __section(".data");
=20
-u64 boot_svsm_caa_pa;
+u64 boot_svsm_caa_pa __section(".data");
=20
 /* Include code for early handlers */
 #include "../../boot/startup/sev-shared.c"
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-s=
hared.c
index a0fa8bb..d9ac3a9 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -31,7 +31,7 @@ static u32 cpuid_std_range_max __ro_after_init;
 static u32 cpuid_hyp_range_max __ro_after_init;
 static u32 cpuid_ext_range_max __ro_after_init;
=20
-bool sev_snp_needs_sfw;
+bool sev_snp_needs_sfw __section(".data");
=20
 void __noreturn
 sev_es_terminate(unsigned int set, unsigned int reason)

