Return-Path: <stable+bounces-120221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC3BA4D8C0
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 10:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920A31884776
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 09:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4587A1FE456;
	Tue,  4 Mar 2025 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gGNHSFem";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZZZxVicn"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1981FC7F6;
	Tue,  4 Mar 2025 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081036; cv=none; b=fwkjB1rGXfIMKt7flY5o9yPOCy0cz3oShCqU8OGEdYUDxsp6VJCbPU2LcNfS/r79u+IQgGXkJWPEpbMdSSURrgIpnPGdhXHZy5NBYT2x0C/EzRoYognws/0SXLJLXe5b6z2/hB97PxagfBd20FggAh4N5hmpU2InvIOE46vxn68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081036; c=relaxed/simple;
	bh=ECiv+IeorJmI0anaoaZx3+9zpvm8plcLmakLMudV1z8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jHUM4JRFTkWO/7MeS6/ts3twFipHM/F3aHCVkRoumhUHWTaT/u2ClUZRazcVuhF7lk5fUoA87SCGZYb3Q669V1k7RL5Ondqi0xs6yQku5AlIF+gXOPWVb5QFldCK+Tm5qkP8SlC15r3kAHYKfZSRkxN79tWk7m8LdAX2obwoI9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gGNHSFem; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZZZxVicn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 09:37:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741081032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tvSqVPxY/CKXnGEq7azJizLT2rjKx2Ct/S6FuaRKkFA=;
	b=gGNHSFem5xDD0gT8SeYEc1E5DujsoXfBEk+ZWTpbjnTk9ZRM8o5dwOIpQJ/2M5H+zJKG0P
	cywAy9YQy1rkmul6oyXscSmPuV8GR4VrUYaPCAMVSpISgdd6ATMq2qMVavBqgW2/Mpkeao
	QilZ28b4JoSqebZauUWzGIOAVKMZ9ERzWkbenuhAh9AaiUDQdGqvhKf/hSlpqHmCkxokMm
	xjbLau98gKW6F6UxND7HnOAHl93DY6OwKBh2onDMBwO0OBCpm/W/1YTak1lVbcsZj50poE
	bblKmFQ+aI3XkiYEvbOkpx2kP2t7TQZ90NsdfD5l0zej85WOdHEZ1GgB2Pw4Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741081032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tvSqVPxY/CKXnGEq7azJizLT2rjKx2Ct/S6FuaRKkFA=;
	b=ZZZxVicnwLK2ztH7msRTjrAq0pcKBlmyatPZfxl0bPiAtQw1lSA4yORDd8a3CX+UhmWMBz
	m1DbKba5xg9pcMCg==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cacheinfo: Validate CPUID leaf 0x2 EDX output
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 stable@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250304085152.51092-2-darwi@linutronix.de>
References: <20250304085152.51092-2-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108103200.14745.14436031278283791501.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8177c6bedb7013cf736137da586cf783922309dd
Gitweb:        https://git.kernel.org/tip/8177c6bedb7013cf736137da586cf783922309dd
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Tue, 04 Mar 2025 09:51:12 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 09:59:14 +01:00

x86/cacheinfo: Validate CPUID leaf 0x2 EDX output

CPUID leaf 0x2 emits one-byte descriptors in its four output registers
EAX, EBX, ECX, and EDX.  For these descriptors to be valid, the most
significant bit (MSB) of each register must be clear.

The historical Git commit:

  019361a20f016 ("- pre6: Intel: start to add Pentium IV specific stuff (128-byte cacheline etc)...")

introduced leaf 0x2 output parsing.  It only validated the MSBs of EAX,
EBX, and ECX, but left EDX unchecked.

Validate EDX's most-significant bit.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250304085152.51092-2-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index e6fa03e..a6c6bcc 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -808,7 +808,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 			cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
 
 			/* If bit 31 is set, this is an unknown format */
-			for (j = 0 ; j < 3 ; j++)
+			for (j = 0 ; j < 4 ; j++)
 				if (regs[j] & (1 << 31))
 					regs[j] = 0;
 

