Return-Path: <stable+bounces-271754-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0aiDDFSqR2q+dAAAu9opvQ
	(envelope-from <stable+bounces-271754-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 14:25:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 234CC70253E
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 14:25:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nyIH+P7c;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271754-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-271754-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B47B63001CD4
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 12:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3673D171C;
	Fri,  3 Jul 2026 12:25:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29832AAA0;
	Fri,  3 Jul 2026 12:25:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081537; cv=none; b=mJnTq2pTNn69Y5QZput6ySZ9mpxxbsHIklbTNi6m5wHh1kYOdw5GNP+UHZ4hsF2AvdacklIyWnMt1uZ+TCJmcnb7msc3i7g3Tw2ASyfMhOYQFf6sDGDS3ZJWYKSKPjUCVxsfBeyRk23KVqLTq75eZtJVJgFqkXvZ5odPOILoP88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081537; c=relaxed/simple;
	bh=J9z7NCIdmwhlhAqT8mXGeVKEtQCaKObsF620oGVQ6js=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=G2C623AtZ3jqkCYc4aeCYqM9bosygYLzI34WjBguHSrBRMGldVdaKQcRqUnhe+yCsuQGm4nWaUsd7b/UC9OEZEQazBOYfdAvqaAOMhk5KQJ/nutHH0aDT6u23114Bg2rLTSwwm/Kj9EUeKARzmDqhWq0km+ATRb8lLPSN7wuhXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyIH+P7c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBFD1F000E9;
	Fri,  3 Jul 2026 12:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783081536;
	bh=yCrLXsnLx/b2bMi+9G8HMMh37OcPMJMjpgwdLJka8XQ=;
	h=From:Date:Subject:To:Cc;
	b=nyIH+P7ck3fnFVUNe7Gaz9WIiYCAF3iWjigoDnKd1sFIOYEu7h4FEnWsN5ZQBSKmg
	 cVWqG6n3vaVT+tucS1oCyuyFavWTWgSgt1cTnYPvtNvmAfcw7ntdDQbd8u0PAfsP8E
	 Msu6Y4X0Za4zm4ATH5DZtoGzuCLnavqVnV2R+SziNZfjrrKbur1c277HQs/lKK0HoU
	 cFqu9Palj5NQQjvowIVyANf4UXX4IHS8ZOep2DviWFJicCS6JToxzWSYrYvfHgCbGP
	 biRhMDP1cBM+osZvduW7vXx6iCOG/5KbVALwgr04UaSC5fbkPXoZC5WnZCNHDcmeok
	 yPYf5SF+VEF/w==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 03 Jul 2026 14:25:27 +0200
Subject: [PATCH v4] ARM: breakpoint: CFI breakpoints only on demand
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-arm32-cfi-bug-v4-1-c26acb640a8f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTQ6CMBCG4auYrq2ZTkuxrryHcUHrAPUHTItEY
 7i7BRdGjS6/ZJ537ixS8BTZanZngXoffdukoeYz5uqiqYj7XdoMATVo1LwIJ4nclZ7bS8UFlNZ
 oyJVxiiVzDlT669TbbJ87XuyeXDdGxovax64Nt+lhL8a7X+1ecMELpXObQQYO7PpAoaHjog0VG
 +M9vngO4pNj4saWBjEzkgC+uPzLZeIkncwJ7RIK9caHYXgAmZpBfDsBAAA=
X-Change-ID: 20260626-arm32-cfi-bug-10fb960749c4
To: Russell King <linux@armlinux.org.uk>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
 slipher <slipher@protonmail.com>, Mark Rutland <mark.rutland@arm.com>, 
 Linus Walleij <linusw@kernel.org>, Will Deacon <will@kernel.org>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271754-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:nathan@kernel.org,m:samitolvanen@google.com,m:kees@kernel.org,m:rmk+kernel@armlinux.org.uk,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,m:slipher@protonmail.com,m:mark.rutland@arm.com,m:linusw@kernel.org,m:will@kernel.org,m:linux-perf-users@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,protonmail.com,arm.com,kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 234CC70253E

This removes the stub hw_breakpoint_cfi_handler() from ARM, making
it not steal breakpoint type 0x03 (ARM_ENTRY_CFI_BREAKPOINT) unless
CFI is actively used in the kernel.

When not instrumenting with CFI, or when a breakpoint is issued in
userspace, we fall through to return 1 from hw_breakpoint_pending()
"unhandled fault" so userspace can make use of this breakpoint.

Tested with LKDTM and this command line:
echo CFI_FORWARD_PROTO > /sys/kernel/debug/provoke-crash/DIRECT
still works as expected.

Fixes: c3f89986fde7 ("ARM: 9391/2: hw_breakpoint: Handle CFI breakpoints")
Reported-by: slipher <slipher@protonmail.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Closes: https://lore.kernel.org/lkml/kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com/
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Trying to solve the CFI bug. Let's see of this first
approach is acceptable for the reporter.
---
Changes in v4:
- Dodge the BKPT if we are coming from userspace!
- Would be great if the reporter can test this with and without
  CONFIG_CFI.
- Link to v3: https://patch.msgid.link/20260701-arm32-cfi-bug-v3-1-e3c37e2b80a4@kernel.org

Changes in v3:
- Actually strip the RFC prefix...
- Link to v2: https://patch.msgid.link/20260701-arm32-cfi-bug-v2-1-9bf922593e00@kernel.org

Changes in v2:
- Resending as non-RFC so it can be applied as a band-aid.
- Link to v1: https://patch.msgid.link/20260626-arm32-cfi-bug-v1-1-a467b5050c0b@kernel.org

To: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Russell King <linux@armlinux.org.uk>
To: Kees Cook <kees@kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Linus Walleij <linusw@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/kernel/hw_breakpoint.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index cd4b34c96e35..38feb30dfb5f 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -929,10 +929,6 @@ static void hw_breakpoint_cfi_handler(struct pt_regs *regs)
 		break;
 	}
 }
-#else
-static void hw_breakpoint_cfi_handler(struct pt_regs *regs)
-{
-}
 #endif
 
 /*
@@ -964,9 +960,14 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
 	case ARM_ENTRY_SYNC_WATCHPOINT:
 		watchpoint_handler(addr, fsr, regs);
 		break;
+#ifdef CONFIG_CFI
 	case ARM_ENTRY_CFI_BREAKPOINT:
-		hw_breakpoint_cfi_handler(regs);
+		if (user_mode(regs))
+			ret = 1; /* Don't handle userspace BKPT */
+		else
+			hw_breakpoint_cfi_handler(regs);
 		break;
+#endif
 	default:
 		ret = 1; /* Unhandled fault. */
 	}

---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260626-arm32-cfi-bug-10fb960749c4

Best regards,
--  
Linus Walleij <linusw@kernel.org>


