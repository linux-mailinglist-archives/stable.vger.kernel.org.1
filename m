Return-Path: <stable+bounces-171612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D81FB2AB9A
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E57C77AB77F
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331622264B0;
	Mon, 18 Aug 2025 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zxxuaJNG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OPtKQSjT"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA1B35A2AC;
	Mon, 18 Aug 2025 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528728; cv=none; b=uswMwybHXce5j9YjhxhmimLmT9O15GC2Bo7rOuQdpp7fwZjUe/qpuJXsyCsjGNzyE78kI7AjL1UFqBgkExoVHUyJds/W/yvaNJ++sc253KuemV5+ioBE4XUUfIPQF+uITgYsIVjP/h7KNXS1rblRbCRRAie/PKPBfryDIRdpKCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528728; c=relaxed/simple;
	bh=/am5oTINd5DY0RExse6S2+Zj65REocHnE++uvCDptxM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Q9c2Q0yugFZwtVjlTbp4RywLIVA9+b94jgTAEcsAkndehxWtqvMk3zbX7i+kdvv+XWI+ewXeUZuICQJBMuBqrEp21mzZZw88xSgA9yfKFbkVGSUkbSWMyO+ZBK6MgWNFTUnpW4TYADyFtQW5F5QvGijzqO2hWd4THRUNN/UvMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zxxuaJNG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OPtKQSjT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 14:52:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755528724;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uz87yJ73tHCf6Na5w9ucGOaKs8zsdimcHtMPz3jBBA8=;
	b=zxxuaJNG20NGBeYmlVJbevpSv9arQiTSqN7eML3e0Nv2VJf6R1etJVXpM1aneVaVOaav2B
	73gXUZfVBtGpg4m1Ep7jV1PHZV0iOpeWHrjf8ceYD4EQuCv4/hikTNJsMcZOD/20pLpcT/
	XoPSotgnfpsh3vqbtXqlz/7+F7P0gWrG+rVmsOtYD3TjjbYZmK/OjDov8RwipAiZ1+4Vkn
	8MP0nXIewSMieHuUdw111ameX9fGmw2i98hdzc+8VmViGUCneWMW7Ekl4vi/F1bd5CcwEG
	/PqNArLvhBRVuSVo+eg2vKF6qBHregCeim0TqXH26NQn1vTOICxJwNLzBVMbeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755528724;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uz87yJ73tHCf6Na5w9ucGOaKs8zsdimcHtMPz3jBBA8=;
	b=OPtKQSjTh/+HnW+rydrhjsiR6iG1jvM8ZVw2bZsRMOeDh1wni0s1ubNpDfG9jH2CrQ0oT5
	HYhZ3s1uUhYrYPAg==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/CPU/AMD: Ignore invalid reset reason value
Cc: Libing He <libhe@redhat.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Mario Limonciello <mario.limonciello@amd.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250721181155.3536023-1-yazen.ghannam@amd.com>
References: <20250721181155.3536023-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175552872343.1420.5386589162109047550.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e9576e078220c50ace9e9087355423de23e25fa5
Gitweb:        https://git.kernel.org/tip/e9576e078220c50ace9e9087355423de23e=
25fa5
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 21 Jul 2025 18:11:54=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 18 Aug 2025 16:36:59 +02:00

x86/CPU/AMD: Ignore invalid reset reason value

The reset reason value may be "all bits set", e.g. 0xFFFFFFFF. This is a
commonly used error response from hardware. This may occur due to a real
hardware issue or when running in a VM.

The user will see all reset reasons reported in this case.

Check for an error response value and return early to avoid decoding
invalid data.

Also, adjust the data variable type to match the hardware register size.

Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
Reported-by: Libing He <libhe@redhat.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250721181155.3536023-1-yazen.ghannam@amd.com
---
 arch/x86/kernel/cpu/amd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index a5ece6e..a6f88ca 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1326,8 +1326,8 @@ static const char * const s5_reset_reason_txt[] =3D {
=20
 static __init int print_s5_reset_status_mmio(void)
 {
-	unsigned long value;
 	void __iomem *addr;
+	u32 value;
 	int i;
=20
 	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
@@ -1340,12 +1340,16 @@ static __init int print_s5_reset_status_mmio(void)
 	value =3D ioread32(addr);
 	iounmap(addr);
=20
+	/* Value with "all bits set" is an error response and should be ignored. */
+	if (value =3D=3D U32_MAX)
+		return 0;
+
 	for (i =3D 0; i < ARRAY_SIZE(s5_reset_reason_txt); i++) {
 		if (!(value & BIT(i)))
 			continue;
=20
 		if (s5_reset_reason_txt[i]) {
-			pr_info("x86/amd: Previous system reset reason [0x%08lx]: %s\n",
+			pr_info("x86/amd: Previous system reset reason [0x%08x]: %s\n",
 				value, s5_reset_reason_txt[i]);
 		}
 	}

