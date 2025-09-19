Return-Path: <stable+bounces-180699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0F3B8B259
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 21:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639965A6A34
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 19:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC642D373F;
	Fri, 19 Sep 2025 19:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qwsDmjJq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7yvfUDxo"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F950189;
	Fri, 19 Sep 2025 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311745; cv=none; b=KyahAbznxKLnwbT4nuU/i6Vd0xGqMUs0+aG2syN+mfxlLhcaBDR9sIWfohrqw4o4zxZUMY+UIRZFcGu/J8BN7o5CS6ATJ29jdIxJo0/CBfuEPtPmip5dezu4xtVGiSrFtfxGAE8cnCQ17+akTcsO2vbjzSA6fLofUZHCTxL9Y5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311745; c=relaxed/simple;
	bh=4QByUP6xaTZF3iAphfZDqGgSRee9RWGjtopVvDIu74g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hvEG8We3Uwq8pTjZ5zHvsg+hr0Yxmu3yHXTgf+Ce9JRKmDKycklr8tnglVEK5Je2Rq0L4k1/Ixygq1ZSIdHPJ4xBM3ZjfyGOan5wzuI+aEje67KQVspN8cUQAjr9BMGbiJubbg/5vvNljtzaP+qjZ/+ZizhG4HZYkQJRXWF7MJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qwsDmjJq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7yvfUDxo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 19 Sep 2025 19:55:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758311741;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TAtcQIJI/HoNJ6uRpiF874pXefIxXUFzrtLGzPJy7iY=;
	b=qwsDmjJqRxFBBgAq0T68BmFcVBHAWhs4ze7QW5w3xNrmAqFe+6lqId9j2Lae96BSHba7ba
	s876Uc3m8qVmDpVvAHrOBGMpQ4+vh5u6+BbMvDRj6nz9+i5OrinT5373SOMrPwjbW4wzhN
	AnMp2Sn6BKTNTSSpadLFOjNom0BFr4OIyZ9lvWUZKSM5XzOdL5TaFAh7oPvOIRGc5T8pw3
	ykGnwb6pBgc86kgi4hkw5HrVtkjNI+s9KltP4rgQGEkmz22FvIQQoUB7KRr75gQ+GWwTO/
	Y0LxXDSa7zqSyRLf8kzvLsZOhsAf1Xdy/syTVZQ19hP/j/fYS+3pdqMI1Kvt3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758311741;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TAtcQIJI/HoNJ6uRpiF874pXefIxXUFzrtLGzPJy7iY=;
	b=7yvfUDxo4D/J7ET8iXfZmPVf9qsu0lhK/BOB0scAXtjrigy/YaD0/1c0Eo3mK/QZPaeQg7
	beG3m7ghlplPeXCQ==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/umip: Fix decoding of register forms of 0F 01
 (SGDT and SIDT aliases)
Cc: Sean Christopherson <seanjc@google.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250808172358.1938974-3-seanjc@google.com>
References: <20250808172358.1938974-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175831173709.709179.11826475048283663530.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     27b1fd62012dfe9d3eb8ecde344d7aa673695ecf
Gitweb:        https://git.kernel.org/tip/27b1fd62012dfe9d3eb8ecde344d7aa6736=
95ecf
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Fri, 08 Aug 2025 10:23:57 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 19 Sep 2025 21:34:48 +02:00

x86/umip: Fix decoding of register forms of 0F 01 (SGDT and SIDT aliases)

Filter out the register forms of 0F 01 when determining whether or not to
emulate in response to a potential UMIP violation #GP, as SGDT and SIDT only
accept memory operands.  The register variants of 0F 01 are used to encode
instructions for things like VMX and SGX, i.e. not checking the Mod field
would cause the kernel to incorrectly emulate on #GP, e.g. due to a CPL
violation on VMLAUNCH.

Fixes: 1e5db223696a ("x86/umip: Add emulation code for UMIP instructions")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/umip.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 406ac01..d432f38 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -163,8 +163,19 @@ static int identify_insn(struct insn *insn)
 	if (insn->opcode.bytes[1] =3D=3D 0x1) {
 		switch (X86_MODRM_REG(insn->modrm.value)) {
 		case 0:
+			/* The reg form of 0F 01 /0 encodes VMX instructions. */
+			if (X86_MODRM_MOD(insn->modrm.value) =3D=3D 3)
+				return -EINVAL;
+
 			return UMIP_INST_SGDT;
 		case 1:
+			/*
+			 * The reg form of 0F 01 /1 encodes MONITOR/MWAIT,
+			 * STAC/CLAC, and ENCLS.
+			 */
+			if (X86_MODRM_MOD(insn->modrm.value) =3D=3D 3)
+				return -EINVAL;
+
 			return UMIP_INST_SIDT;
 		case 4:
 			return UMIP_INST_SMSW;

