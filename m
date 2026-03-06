Return-Path: <stable+bounces-223311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBKSF9ZsqmkPRQEAu9opvQ
	(envelope-from <stable+bounces-223311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 06:57:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7FB21BDE8
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 06:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98D86305184B
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 05:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3756736D9FD;
	Fri,  6 Mar 2026 05:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="jBoR9R3K"
X-Original-To: stable@vger.kernel.org
Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33DA36D4F8;
	Fri,  6 Mar 2026 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772776625; cv=none; b=NqmSQ31TphXWAVE7JggfGXELg2XYeCMpYN8l7uvDK2/rpeZWYUCAE5UGpMllJEug7c84ZWp3OiGiP6gWmZW4sju4Ht5HI3k0r9pm1NmFCY32Iq64lWaqBgLRgKnrLbgwCscjz82HGv9hPx8KNeBkazM9OvwT/uwGy8xNd/P7v7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772776625; c=relaxed/simple;
	bh=2XT2pC15mVN+lX5dwtD+IHNSiOvmfczcHRV7Oa7zui0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UMx9YFLFIiv1XWeNcSDPBNc0DwS0bPhQyd27ezNhfXR/7Btvcd+bNp+EC6VOpi6l3zFf9tw0dnSuxjgkc3WoXggthyOz2DQR4ZmitYh85XLNKQ2n8JL+eWsELzEPTn5Kv50v1sc31ZdCrEoD3Ay8xh1u1LjuaauW16NmQGkEcHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=jBoR9R3K; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1772776623; x=1804312623;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=RJlkan/bm4WkpgfpFn8vBoIW/xcIt8h3GoUwLxbVo0w=;
  b=jBoR9R3KoDQQhVFFm6BQj2uiEus4knhQX0zqm17VwyvCnti80YN9jCTb
   21vo5OV7tXmTnI0EFkigfDVcz2XFiepW6ivPa1/WdBmoMEUHPKMr5WyUB
   qwSNGr3JmsXXNTcEAeYnwX6emRuXYnLzoM+SWLcV1+5PCWXoJSxxAaYyu
   R2FhvudPNcgfVvYYWRzNFHXyVSem6zPyqWgpN7YAEGZM+yUxpn+pnPnq7
   uz31Ob4vrj4809glNq8+CrnJfwksgeNqsoWb00xTPrVgnfbvHXD6MKo7L
   zz+hEEX6f/+ZR1SX6HUyf25tUctT34I1KB5AKPD3RJMyIx9fWp2P7xV8b
   w==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 14:46:50 +0900
X-IronPort-AV: E=Sophos;i="6.23,104,1770562800"; 
   d="scan'208";a="619082192"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 06 Mar 2026 14:46:50 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Date: Fri, 06 Mar 2026 14:46:28 +0900
Subject: [PATCH v2 1/2] x86/x2apic: Disable x2apic on resume if the kernel
 expects so
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-x2apic-fix-v2-1-bee99c12efa3@sony.com>
References: <20260306-x2apic-fix-v2-0-bee99c12efa3@sony.com>
In-Reply-To: <20260306-x2apic-fix-v2-0-bee99c12efa3@sony.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, 
 Jan Kiszka <jan.kiszka@siemens.com>, Sohil Mehta <sohil.mehta@intel.com>, 
 Andrew Cooper <andrew.cooper3@citrix.com>, 
 Shashank Balaji <shashank.mahadasyam@sony.com>, 
 Rahul Bukte <rahul.bukte@sony.com>, Daniel Palmer <daniel.palmer@sony.com>, 
 Tim Bird <tim.bird@sony.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3265;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=2XT2pC15mVN+lX5dwtD+IHNSiOvmfczcHRV7Oa7zui0=;
 b=owGbwMvMwCU2bX1+URVTXyjjabUkhsxVWR5rE242JLve0ZA+/7Fp17vV+5Lm/u7euj/BYVt7W
 qjR/Qu3O0pZGMS4GGTFFFlKlap/7V0RtKTnzGtFmDmsTCBDGLg4BWAir6Yx/Ga/KqIZ/mnj2X79
 dRuUbX/0/HOY4GvFrsw1YUrehVfMPjGMDCtXC3A3W/Bc0nRiEYoutjqqzVPx4MC3I7Jt9x6Lp3W
 48QIA
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=75227BFABDA852A48CCCEB2196AF6F727A028E55
X-Rspamd-Queue-Id: BC7FB21BDE8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sony.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sony.com:s=s1jp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-223311-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[sony.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shashank.mahadasyam@sony.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,uefi.org:url,sony.com:dkim,sony.com:email,sony.com:mid]
X-Rspamd-Action: no action

When resuming from s2ram, firmware may re-enable x2apic mode, which may have
been disabled by the kernel during boot either because it doesn't support
irq remapping or for other reasons. This causes the kernel to continue using
the xapic interface, while the hardware is in x2apic mode, which causes hangs.
This happens on defconfig + bare metal + s2ram.

Fix this in lapic_resume() by disabling x2apic if the kernel expects it to be
disabled, i.e. when x2apic_mode = 0.

The ACPI v6.6 spec, Section 16.3 [1] says firmware restores either the pre-sleep
configuration or initial boot configuration for each CPU, including MSR state:

	When executing from the power-on reset vector as a result of waking
	from an S2 or S3 sleep state, the platform firmware performs only the
	hardware initialization required to restore the system to either the
	state the platform was in prior to the initial operating system boot,
	or to the pre-sleep configuration state. In multiprocessor systems,
	non-boot processors should be placed in the same state as prior to the
	initial operating system boot.

	(further ahead)

	 If this is an S2 or S3 wake, then the platform runtime firmware
	 restores minimum context of the system before jumping to the waking
	 vector. This includes:

	 	CPU configuration. Platform runtime firmware restores the
		pre-sleep configuration or initial boot configuration of each
		CPU (MSR, MTRR, firmware update, SMBase, and so on). Interrupts
		must be disabled (for IA-32 processors, disabled by CLI
		instruction).

		(and other things)

So at least as per the spec, re-enablement of x2apic by the firmware is allowed
if "x2apic on" is a part of the initial boot configuration.

[1] https://uefi.org/specs/ACPI/6.6/16_Waking_and_Sleeping.html#initialization

Fixes: 6e1cb38a2aef ("x64, x2apic/intr-remap: add x2apic support, including enabling interrupt-remapping")
Cc: stable@vger.kernel.org
Co-developed-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>

---

Changes in v2:
- Add __x2apic_disable() stub for !CONFIG_X86_X2APIC
- Mention the ACPI spec in the commit message (Sohil Mehta)
---
 arch/x86/kernel/apic/apic.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index d93f87f29d03..c8cb82d5131c 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1894,6 +1894,7 @@ void __init check_x2apic(void)
 
 static inline void try_to_enable_x2apic(int remap_mode) { }
 static inline void __x2apic_enable(void) { }
+static inline void __x2apic_disable(void) { }
 #endif /* !CONFIG_X86_X2APIC */
 
 void __init enable_IR_x2apic(void)
@@ -2456,6 +2457,15 @@ static void lapic_resume(void *data)
 	if (x2apic_mode) {
 		__x2apic_enable();
 	} else {
+		/*
+		 * x2apic may have been re-enabled by the firmware on resuming
+		 * from s2ram
+		 */
+		if (x2apic_enabled()) {
+			pr_warn_once("x2apic: re-enabled by firmware during resume. Disabling\n");
+			__x2apic_disable();
+		}
+
 		/*
 		 * Make sure the APICBASE points to the right address
 		 *

-- 
2.43.0


