Return-Path: <stable+bounces-226469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOtMABiKuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:06:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A872AEF1B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF92A3045659
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420FA3F54D7;
	Tue, 17 Mar 2026 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="py7nmnMi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AA53F54D1;
	Tue, 17 Mar 2026 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766853; cv=none; b=alGHuvVcE6ViasbCJ6HUY26IQ8ir3+Mgckjghrtbod+9InxGKVslEm4Z98Nr5VjYQRmFo4yfrovE0T8GiMi7vIBkVa0LwwliFGic18orNiyp1CMrBf/1yGwwe7Rk1w3kYXFlshorR/7JRaZOcK3eG8boXfRx3klhVk2xeW5EVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766853; c=relaxed/simple;
	bh=nWBzfWt92Mp0iwlvT7v+AnllqZuqHVdGZ3kuN46cvIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKupKa3YpFHItwFGNiS6WyjQie5bbdyNFsRdKoLklE+UHrZLPWbASlN0Mn4OL9xjPd+aDOjhfWsI7IrUfTEq23zv/YZBSp+ZDcIFOFJZFZNaKBynXKp52hw4XjByi+Gl0gfkyhVwbOmlAPmR3Tr+M1dkcGSUhRjeyt4Qb0VpgsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=py7nmnMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634D8C4CEF7;
	Tue, 17 Mar 2026 17:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766852;
	bh=nWBzfWt92Mp0iwlvT7v+AnllqZuqHVdGZ3kuN46cvIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=py7nmnMieq2AsDelk6G0LD9XBijFEJC1s/u3NbQx3s1a9E3Hl2aOuHLZGl5qeRiOs
	 QsbPrmK6vQHRE50Y0gf444/ZP5fW3Yc3M6QF9mSdG5DC25CB/YRxmWkSYz2O+s4Rcq
	 8JJNmGhcXDgWQSQVubVXyiMKGDi724VSEX61snic=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rahul Bukte <rahul.bukte@sony.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH 6.19 334/378] x86/apic: Disable x2apic on resume if the kernel expects so
Date: Tue, 17 Mar 2026 17:34:51 +0100
Message-ID: <20260317163019.272743517@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226469-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,alien8.de:email,uefi.org:url]
X-Rspamd-Queue-Id: 97A872AEF1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shashank Balaji <shashank.mahadasyam@sony.com>

commit 8cc7dd77a1466f0ec58c03478b2e735a5b289b96 upstream.

When resuming from s2ram, firmware may re-enable x2apic mode, which may have
been disabled by the kernel during boot either because it doesn't support IRQ
remapping or for other reasons. This causes the kernel to continue using the
xapic interface, while the hardware is in x2apic mode, which causes hangs.
This happens on defconfig + bare metal + s2ram.

Fix this in lapic_resume() by disabling x2apic if the kernel expects it to be
disabled, i.e. when x2apic_mode = 0.

The ACPI v6.6 spec, Section 16.3 [1] says firmware restores either the
pre-sleep configuration or initial boot configuration for each CPU, including
MSR state:

  When executing from the power-on reset vector as a result of waking from an
  S2 or S3 sleep state, the platform firmware performs only the hardware
  initialization required to restore the system to either the state the
  platform was in prior to the initial operating system boot, or to the
  pre-sleep configuration state. In multiprocessor systems, non-boot
  processors should be placed in the same state as prior to the initial
  operating system boot.

  (further ahead)

  If this is an S2 or S3 wake, then the platform runtime firmware restores
  minimum context of the system before jumping to the waking vector. This
  includes:

	CPU configuration. Platform runtime firmware restores the pre-sleep
	configuration or initial boot configuration of each CPU (MSR, MTRR,
	firmware update, SMBase, and so on). Interrupts must be disabled (for
	IA-32 processors, disabled by CLI instruction).

	(and other things)

So at least as per the spec, re-enablement of x2apic by the firmware is
allowed if "x2apic on" is a part of the initial boot configuration.

  [1] https://uefi.org/specs/ACPI/6.6/16_Waking_and_Sleeping.html#initialization

  [ bp: Massage. ]

Fixes: 6e1cb38a2aef ("x64, x2apic/intr-remap: add x2apic support, including enabling interrupt-remapping")
Co-developed-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260306-x2apic-fix-v2-1-bee99c12efa3@sony.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/apic/apic.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1894,6 +1894,7 @@ void __init check_x2apic(void)
 
 static inline void try_to_enable_x2apic(int remap_mode) { }
 static inline void __x2apic_enable(void) { }
+static inline void __x2apic_disable(void) { }
 #endif /* !CONFIG_X86_X2APIC */
 
 void __init enable_IR_x2apic(void)
@@ -2456,6 +2457,11 @@ static void lapic_resume(void *data)
 	if (x2apic_mode) {
 		__x2apic_enable();
 	} else {
+		if (x2apic_enabled()) {
+			pr_warn_once("x2apic: re-enabled by firmware during resume. Disabling\n");
+			__x2apic_disable();
+		}
+
 		/*
 		 * Make sure the APICBASE points to the right address
 		 *



