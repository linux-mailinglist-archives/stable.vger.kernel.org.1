Return-Path: <stable+bounces-176461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 154B3B37AB3
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 08:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453B91B63EF1
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 06:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB683128B5;
	Wed, 27 Aug 2025 06:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DagFxxCW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AXmnGXnF"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8F1314B9C;
	Wed, 27 Aug 2025 06:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277146; cv=none; b=iThR1jd4ruLQgA43aSjT14kz2I8r7wEYIAITXyEPLTHOkdFiWpiG9s4z1iBG1Cp25f3JW2Tj+ltp7lfMf17G1At4CGHLhnMd+xAocqlcZcqc6AkxoAQo5vIicYvd+Kjb7SED1BaNCBOuU/ZRk18SwJYG3VEvVjdybqo5bV1xDFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277146; c=relaxed/simple;
	bh=sM8ng4D3/htRQ2qiJTiHlfAfsq508seVqbfSprXd5u0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=cr4jZEggmSogube8hBc1oTZEDbmNYfMWeAprbKGx2dSokBoALIlOQG/i7vimEFcrnLAAUC9zJOwrh0/zMnJz5sYd7qdBluoPFDecXltxiUUPaQ5xZtWe0ZDM08rNyDo60M12LxoYU1aqjNxxX+C8p9mDctgBNYASar9n9NI2AnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DagFxxCW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AXmnGXnF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Aug 2025 06:45:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756277143;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=xSstOtXNLsz/qJYRZZmJvydqKWQnFsq2llurg5C8Zig=;
	b=DagFxxCWqZ7hVBtUZmN5oBm+Oe2NGo4pcLSN0WtvmQES5zIml37JPYM9ohjgdBpWgDCGuX
	k83igpQ4yeKeurQK/7aMza1+OFmsarIuGDjZvIbcW+nqhvLggmvitaty+0J35pA+R/GNqc
	Fmb7nhDEvZdEK3N3gALDO1NdRdw2qY6LH9ugvTUsCsg4dz4aqtYbO3mOT4t4mqkV50v6CL
	+DR39gPXZ8W3JtCqI5GNxFLvjEMx0y7dMXdDyDdOrgMOSVGpDNIu6VHcceglOYBQhzx8qw
	Gr/Exq64MZnTwjPwqnpuipy6EXkLOTDtHlL8r8VuMjTEv9Z76mH8E4XtoG01Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756277143;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=xSstOtXNLsz/qJYRZZmJvydqKWQnFsq2llurg5C8Zig=;
	b=AXmnGXnFsPRhmdvEto5/jf99kt/Mj+jT3huzEwMKVoA2hobfGLPjsRinIlgW/sEKZYL8HS
	zGtqkwwqB8RCHkBw==
From: "tip-bot2 for Suchit Karunakaran" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu/intel: Fix the constant_tsc model check for
 Pentium 4
Cc: Suchit Karunakaran <suchitkarunakaran@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175627714134.1920.18359417861492788607.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     24963ae1b0b6596dc36e352c18593800056251d8
Gitweb:        https://git.kernel.org/tip/24963ae1b0b6596dc36e352c18593800056=
251d8
Author:        Suchit Karunakaran <suchitkarunakaran@gmail.com>
AuthorDate:    Sat, 16 Aug 2025 12:21:26 +05:30
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 25 Aug 2025 08:23:37 -07:00

x86/cpu/intel: Fix the constant_tsc model check for Pentium 4

Pentium 4's which are INTEL_P4_PRESCOTT (model 0x03) and later have
a constant TSC. This was correctly captured until commit fadb6f569b10
("x86/cpu/intel: Limit the non-architectural constant_tsc model checks").

In that commit, an error was introduced while selecting the last P4
model (0x06) as the upper bound. Model 0x06 was transposed to
INTEL_P4_WILLAMETTE, which is just plain wrong. That was presumably a
simple typo, probably just copying and pasting the wrong P4 model.

Fix the constant TSC logic to cover all later P4 models. End at
INTEL_P4_CEDARMILL which accurately corresponds to the last P4 model.

Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural constant_tsc=
 model checks")
Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250816065126.5000-1-suchitkarunakaran%40g=
mail.com
---
 arch/x86/kernel/cpu/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 076eaa4..98ae4c3 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -262,7 +262,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	if (c->x86_power & (1 << 8)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
-	} else if ((c->x86_vfm >=3D INTEL_P4_PRESCOTT && c->x86_vfm <=3D INTEL_P4_W=
ILLAMETTE) ||
+	} else if ((c->x86_vfm >=3D INTEL_P4_PRESCOTT && c->x86_vfm <=3D INTEL_P4_C=
EDARMILL) ||
 		   (c->x86_vfm >=3D INTEL_CORE_YONAH  && c->x86_vfm <=3D INTEL_IVYBRIDGE))=
 {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 	}

