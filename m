Return-Path: <stable+bounces-223310-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCw6KLNsqmkPRQEAu9opvQ
	(envelope-from <stable+bounces-223310-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 06:57:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE55621BDC4
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 06:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DB61302AD1D
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 05:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9301936C588;
	Fri,  6 Mar 2026 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="lPDOEQWT"
X-Original-To: stable@vger.kernel.org
Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AAC2DB791;
	Fri,  6 Mar 2026 05:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772776622; cv=none; b=jVPbno9CBeDXX8IVZuptvZjQ6cf+mUhRsmqXOj99trf9MWco2WXjXV+pF1imjjUqKlbszMx1X+BsgCk96vuPeM05KnvirFSS+KbQKmhSLFMG0alSiSiY0ZcCcy8Rm9mX0wbGL0WR8ZXl0yesIdaJKqiKP11e3oKanDW0O/xfZL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772776622; c=relaxed/simple;
	bh=yVWRTWr2K5zF5AOYDd/Q/w65glmiFBSUw+cVbjAoqvc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YmOAt6UX+qyQ1P/vhoa8brRSQjRjPVzn1kfj1/Y1nqMJvc/F6hwjPBCEJmRiMJG+mFyNdxopnhL1uhnRBOkA+URi8FrOS0WcxYyxVqktRGm+8Y4v6dI0rFIfPSrUbJpERMx+1FwoTuILD8GUnoFFK0qxngKbhktqkHd7LNABIcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=lPDOEQWT; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1772776620; x=1804312620;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=nQYRjKyrx78rG0AQNmZ1lkIyhjfw5MLx9OflMRCGrl0=;
  b=lPDOEQWTFoxFcm0+V5SjCXC+aoGcLy2lEJ3Nm5lfGu7FGzMAQUnDpXCk
   uPJ68fu3EBF7YjA+tgKRfUI5bhu6j5TzJZ+d57zf+1DPVEKgWo4VZWJai
   fEmiVeJltBpn77+HZP8zSc7m9E2wZ4nT4oELS93002Bftr5xGST7iWaKc
   f3RnDQ/ponvJZfnSlmGAmyqksprLAKnrrzTgu8VcH5DITOFra2iN4+zuw
   aw4ftfJZEDBOxNbnDqqe3Hlps76OTRnXAyTU+oqCtZDf5PO7RsiDFelZU
   Nn6rlGWIg0AUMZVM9uzVbyioiOFqDGioTLCcqK8scXgxt71ExJ7gNUeUH
   A==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 14:46:50 +0900
X-IronPort-AV: E=Sophos;i="6.23,104,1770562800"; 
   d="scan'208";a="619082191"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 06 Mar 2026 14:46:49 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Subject: [PATCH v2 0/2] x86/x2apic: Fix hangup of defconfig kernel on
 resume from s2ram
Date: Fri, 06 Mar 2026 14:46:27 +0900
Message-Id: <20260306-x2apic-fix-v2-0-bee99c12efa3@sony.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADRqqmkC/03MQQrCMBCF4auUWRtJBqujq95DumjG1M7CpCQSW
 krubiwILv8H79sguSguwa3ZILosSYKvgYcGeBr80yl51AbUeNaojVpwmIXVKIuilomNbdleNdT
 DHF2dd+ze154kvUNcdzub7/pj8J/JRml1MUzjiWggsl0Kfj1yeEFfSvkAOHo1VqMAAAA=
X-Change-ID: 20260201-x2apic-fix-85c8c1b5cb90
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2033;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=yVWRTWr2K5zF5AOYDd/Q/w65glmiFBSUw+cVbjAoqvc=;
 b=owGbwMvMwCU2bX1+URVTXyjjabUkhsxVWR63L8x8vPVksNhH3oMO2mv9LL7faQp9fmMR+7TCA
 CklRaYNHaUsDGJcDLJiiiylStW/9q4IWtJz5rUizBxWJpAhDFycAjCRVcwM/zR+uJ61YplXFXj/
 6N5/Ht5rzy0461oSu+GfSdfkzv2nTOQYGbp8Nef4qEUc4/4855HkwuyCdrb5+19tv8a82v3X6/9
 x5iwA
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=75227BFABDA852A48CCCEB2196AF6F727A028E55
X-Rspamd-Queue-Id: EE55621BDC4
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
	TAGGED_FROM(0.00)[bounces-223310-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Changes in v2:
- Patch 1's commit references the ACPI spec (Sohil Mehta)
- Patch 2's commit references the Intel SDM (Jan's and Andrew's discussion)
- Patch 3 to rename x2apic_available() to x2apic_without_ir_available() dropped
due to a lack of direction
- Link to v1: https://lore.kernel.org/r/20260202-x2apic-fix-v1-0-71c8f488a88b@sony.com

On resume from s2ram, a defconfig kernel gets into a state where the x2apic
hardware state and the kernel's perceived state are different.

On boot, x2apic is enabled by the firmware, and then the kernel disables it
(relevant lines from dmesg):

	[    0.000381] x2apic: enabled by BIOS, switching to x2apic ops
	[    0.009939] APIC: Switched APIC routing to: cluster x2apic
	[    0.095151] x2apic: IRQ remapping doesn't support X2APIC mode
	[    0.095154] x2apic disabled
	[    0.095551] APIC: Switched APIC routing to: physical flat

defconfig has CONFIG_IRQ_REMAP=n, which leads to x2apic being disabled,
because on bare metal, x2apic has an architectural dependence on interrupt
remapping.

While resuming from s2ram, x2apic is enabled again by the firmware, but
the kernel continues using the physical flat apic routing. This causes a
hangup.

Patch 1 fixes this in lapic_resume() by disabling x2apic when the kernel expects
it to be disabled.
Patch 2 enables CONFIG_IRQ_REMAP in defconfig so that defconfig kernels at
least don't disable x2apic because of a lack of IRQ_REMAP support.

Signed-off-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
---
Shashank Balaji (2):
      x86/x2apic: Disable x2apic on resume if the kernel expects so
      x86/defconfig: Add CONFIG_IRQ_REMAP

 arch/x86/configs/x86_64_defconfig |  1 +
 arch/x86/kernel/apic/apic.c       | 10 ++++++++++
 2 files changed, 11 insertions(+)
---
base-commit: e5dd3611420978eac7031c627604a64b01ec56eb
change-id: 20260201-x2apic-fix-85c8c1b5cb90

Best regards,
-- 
Shashank Balaji <shashank.mahadasyam@sony.com>


