Return-Path: <stable+bounces-191451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44310C14807
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 13:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CEB64E75B9
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 12:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6076C32863F;
	Tue, 28 Oct 2025 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wt7egkQV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U+U7dZCf"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AD5302CC2;
	Tue, 28 Oct 2025 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652917; cv=none; b=hgsFtt/y5lKn9FHzLIVmtQ+gbZJoiya9hbT8L0W/y8Nf4Z12+CiyTnYJR6bI+T8B8QA0FmmJO9u8XgBx8DQkXkbgnExRqDn7zlViatG5VaXetTs6ASjyi+0zqu53Acb7/Z2ySMOZMzjv//KQLyBSK94dt9ZQ7VrCS2SGvSRs5Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652917; c=relaxed/simple;
	bh=l7vOFpR42jbNSBtXSBdE8trxX9hJseDCpSFfGaihnz0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=rHAQtlGm+kWMWidf71aMJ9pjtzXgsKETLEj0k0dJb2vw2UsPZuxYqeKczKJZiUIXYt4UObzgFpSZEbnsYKYyJs9LB6+nMXNH1PggZ5cnahqo7Q/URnmp7IeL/tKfiacEld8Xa6K4cbyN1Ge1heoI+LsgYpzTDaM1IadJgG1N80M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wt7egkQV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U+U7dZCf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 Oct 2025 12:01:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761652913;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YeVIUNu11cNST0eypHpOvCA3xSe//4ZGBiT4znegk7E=;
	b=Wt7egkQVxYeOjVaaGNFQYYb4swa8JTcytEMFcYwiILRZqr3LspbEh7y7ir8dOEy+uYDh8l
	2Nl/yU57JymRi1EPSu/Vh8elYzkX4pm0RU+MIE3CT0VHy44ExmjuTUgGMK2bWqOgunsyNN
	hH3HUOQ44elZmhBD52bQF4Q8l9mJlYmfSyKsTGS7d5uB1gDkOeEqrKGdk5AJkxdPvT64ZK
	HvP03ogl350MRZhxR3eXXCLzkQ40P6fQhSXYpoph5NBkACV5fFvuOIywztAf4wE3xsmoIy
	aOB52y761yGgRQOl9ToFPnfTGYJywKjSAaKZXAt8Q9eDG40hKyurLrSyXprNrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761652913;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YeVIUNu11cNST0eypHpOvCA3xSe//4ZGBiT4znegk7E=;
	b=U+U7dZCfJEte1jV/md8tZmW5RRpE2XO4lDYPpz2GyP8wwMfFo1qOYl/NEnTetaEz0AKYrK
	FkFIZcBNSFG8gVDg==
From: "tip-bot2 for Gregory Price" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/CPU/AMD: Add RDSEED fix for Zen5
Cc: stable@vger.kernel.org, Gregory Price <gourry@gourry.net>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176165291198.2601451.3074910014537130674.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     607b9fb2ce248cc5b633c5949e0153838992c152
Gitweb:        https://git.kernel.org/tip/607b9fb2ce248cc5b633c5949e015383899=
2c152
Author:        Gregory Price <gourry@gourry.net>
AuthorDate:    Mon, 20 Oct 2025 11:13:55 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 28 Oct 2025 12:37:49 +01:00

x86/CPU/AMD: Add RDSEED fix for Zen5

There's an issue with RDSEED's 16-bit and 32-bit register output
variants on Zen5 which return a random value of 0 "at a rate inconsistent
with randomness while incorrectly signaling success (CF=3D1)". Search the
web for AMD-SB-7055 for more detail.

Add a fix glue which checks microcode revisions.

  [ bp: Add microcode revisions checking, rewrite. ]

Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20251018024010.4112396-1-gourry@gourry.net
---
 arch/x86/kernel/cpu/amd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index ccaa51c..bc29be6 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1035,8 +1035,18 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
 	}
 }
=20
+static const struct x86_cpu_id zen5_rdseed_microcode[] =3D {
+	ZEN_MODEL_STEP_UCODE(0x1a, 0x02, 0x1, 0x0b00215a),
+	ZEN_MODEL_STEP_UCODE(0x1a, 0x11, 0x0, 0x0b101054),
+};
+
 static void init_amd_zen5(struct cpuinfo_x86 *c)
 {
+	if (!x86_match_min_microcode_rev(zen5_rdseed_microcode)) {
+		clear_cpu_cap(c, X86_FEATURE_RDSEED);
+		msr_clear_bit(MSR_AMD64_CPUID_FN_7, 18);
+		pr_emerg_once("RDSEED32 is broken. Disabling the corresponding CPUID bit.\=
n");
+	}
 }
=20
 static void init_amd(struct cpuinfo_x86 *c)

