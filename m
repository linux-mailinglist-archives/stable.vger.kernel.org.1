Return-Path: <stable+bounces-180700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6FDB8B268
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 21:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9BA0A816E3
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 19:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60B631326C;
	Fri, 19 Sep 2025 19:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HnD8JPRu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1lp/MrMW"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BD6381BA;
	Fri, 19 Sep 2025 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311745; cv=none; b=JFf2425lw5sNCIWyvhC9yFbNv67+badR8Euxamx0nyiNmN7N7G5zVEgU+vWYTsmlFiEnxzg+CFW0mYK+13ND0eNCdgcWbsMRSasC00fMPXBalFP26xiT7I63QSvunDjf+8W6xz+xUGlE4lDrZOetxokvDhptzuJAOkk3nVn7q+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311745; c=relaxed/simple;
	bh=s0MxGzxUtc0wRxwG7SBL0oDJWjnuHRvInlaFdq51KLw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nqfWXR7fUF9HIBSnZNBy6jGI5y05FDDZ6KamZ1ha+M6HLq+felqj4gLLHF3V0qW9lAfXotxmxUCLULTZwRThAU3rCNGOn/zDAAUF63EYtnmjrn3LazAOqaZTjvGCmA8w7gyyGlsZVJ6FWEbAJVT4Ps3Ik5sPxaoJWyBEZPA4uYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HnD8JPRu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1lp/MrMW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 19 Sep 2025 19:55:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758311742;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYi25QlQkFvEwdfzdXN1cK3rR/0x0Vn4HxFOCsZc5sE=;
	b=HnD8JPRu0x6rDMh8KJU8On1oV5ku43+OdQ1Xibl5dflNmdWwPm4XJqNlIC51dS7NTUct49
	FNzkG1XOJxSHWtxisahgTM27J1NzUynDSMZVQiEBM5/3zDOTCThuGH5R5OSTqEmkfGr/BZ
	FwtWgVJbv9coCvXQfj2+miah1nvt+23d8fy9jqGCzkutZVWMza4TCNp2moPq+cua/u+6IA
	PulZLgMXmVSX+3TRHrfC1NCj4AxrDa2yEUVRk5CA8JFmvSgsaPq3++9oFopVLxnqRSDs+V
	9hJo4YKeHDstz0uXzLtxtN4g5G8/SFG44NehUFtQGaAwy4nhVG4synFQ7UgR6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758311742;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYi25QlQkFvEwdfzdXN1cK3rR/0x0Vn4HxFOCsZc5sE=;
	b=1lp/MrMWEgcIlOgtqXY5iN7Jst5AWF/1gD4aBxkpg/999nqG3iQFngsA1zCRaNYyLUx3oq
	f1ClHrR2t/7ceJAA==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/umip: Check that the instruction opcode is at
 least two bytes
Cc: Dan Snyder <dansnyder@google.com>, Sean Christopherson <seanjc@google.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250808172358.1938974-2-seanjc@google.com>
References: <20250808172358.1938974-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175831174075.709179.17586704180114237934.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     32278c677947ae2f042c9535674a7fff9a245dd3
Gitweb:        https://git.kernel.org/tip/32278c677947ae2f042c9535674a7fff9a2=
45dd3
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Fri, 08 Aug 2025 10:23:56 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 19 Sep 2025 20:21:12 +02:00

x86/umip: Check that the instruction opcode is at least two bytes

When checking for a potential UMIP violation on #GP, verify the decoder found
at least two opcode bytes to avoid false positives when the kernel encounters
an unknown instruction that starts with 0f.  Because the array of opcode.bytes
is zero-initialized by insn_init(), peeking at bytes[1] will misinterpret
garbage as a potential SLDT or STR instruction, and can incorrectly trigger
emulation.

E.g. if a VPALIGNR instruction

   62 83 c5 05 0f 08 ff     vpalignr xmm17{k5},xmm23,XMMWORD PTR [r8],0xff

hits a #GP, the kernel emulates it as STR and squashes the #GP (and corrupts
the userspace code stream).

Arguably the check should look for exactly two bytes, but no three byte
opcodes use '0f 00 xx' or '0f 01 xx' as an escape, i.e. it should be
impossible to get a false positive if the first two opcode bytes match '0f 00'
or '0f 01'.  Go with a more conservative check with respect to the existing
code to minimize the chances of breaking userspace, e.g. due to decoder
weirdness.

Analyzed by Nick Bray <ncbray@google.com>.

Fixes: 1e5db223696a ("x86/umip: Add emulation code for UMIP instructions")
Reported-by: Dan Snyder <dansnyder@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/umip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 5a4b213..406ac01 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -156,8 +156,8 @@ static int identify_insn(struct insn *insn)
 	if (!insn->modrm.nbytes)
 		return -EINVAL;
=20
-	/* All the instructions of interest start with 0x0f. */
-	if (insn->opcode.bytes[0] !=3D 0xf)
+	/* The instructions of interest have 2-byte opcodes: 0F 00 or 0F 01. */
+	if (insn->opcode.nbytes < 2 || insn->opcode.bytes[0] !=3D 0xf)
 		return -EINVAL;
=20
 	if (insn->opcode.bytes[1] =3D=3D 0x1) {

