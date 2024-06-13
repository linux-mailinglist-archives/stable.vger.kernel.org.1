Return-Path: <stable+bounces-52007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BFA9072F2
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2481DB297AB
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ECC143C59;
	Thu, 13 Jun 2024 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IbNrQdRu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43DC384;
	Thu, 13 Jun 2024 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282961; cv=none; b=cBCkEBKT2g3kbea0juF7R5hHc1sVGNHX9WHNAXm9ehsEd+0oIuFfr574DH4VF+AzUhrK0scjekDxEkPGY8RF5E+PUSnCaM54kvB0VOzkjP2wV2G6bExlLuCf5ENfOICtALgOfMMTm9mFDghB/0j9R+asY1QvyBudQioBd6c2D8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282961; c=relaxed/simple;
	bh=qcn5L4eACC+RJU8R4Md8TgmHNR77qSY64Q9M5w+kMn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lG8g85do8ouTC+cBfddpA617U/8EyiH2w5h26nr2ns/hEd0RsMuMb4Ey8ZSZb9CGhwTuCa+ndJdTmWH3FYlEKQtmL9A0OunnjRNvkk2qE8q0tdpT9VT/5s4GRQyMuZfqXkkwWPORmqBwdF4Zwgm9XObF6Devf4n7c8bqbunYJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IbNrQdRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68909C2BBFC;
	Thu, 13 Jun 2024 12:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282960;
	bh=qcn5L4eACC+RJU8R4Md8TgmHNR77qSY64Q9M5w+kMn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IbNrQdRu2vBeUa5cLOdeAnR22RQkIIVYuFYHWGlRhLn4IexKsqDrh0Nni1tb3ftZm
	 VtFSxcA6QO97lhQRMjN9NQtTv7MM4wa9I071L5kKzaJu427Bbp3FdctBxe/O7mxJRP
	 GmAYr9TkcW+sDRvp+bKvyRARQaBcHzB1tURSpEhQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.1 50/85] KVM: arm64: AArch32: Fix spurious trapping of conditional instructions
Date: Thu, 13 Jun 2024 13:35:48 +0200
Message-ID: <20240613113216.069747361@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113214.134806994@linuxfoundation.org>
References: <20240613113214.134806994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <maz@kernel.org>

commit c92e8b9eacebb4060634ebd9395bba1b29aadc68 upstream.

We recently upgraded the view of ESR_EL2 to 64bit, in keeping with
the requirements of the architecture.

However, the AArch32 emulation code was left unaudited, and the
(already dodgy) code that triages whether a trap is spurious or not
(because the condition code failed) broke in a subtle way:

If ESR_EL2.ISS2 is ever non-zero (unlikely, but hey, this is the ARM
architecture we're talking about), the hack that tests the top bits
of ESR_EL2.EC will break in an interesting way.

Instead, use kvm_vcpu_trap_get_class() to obtain the EC, and list
all the possible ECs that can fail a condition code check.

While we're at it, add SMC32 to the list, as it is explicitly listed
as being allowed to trap despite failing a condition code check (as
described in the HCR_EL2.TSC documentation).

Fixes: 0b12620fddb8 ("KVM: arm64: Treat ESR_EL2 as a 64-bit register")
Cc: stable@vger.kernel.org
Acked-by: Oliver Upton <oliver.upton@linux.dev>
Link: https://lore.kernel.org/r/20240524141956.1450304-4-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/hyp/aarch32.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

--- a/arch/arm64/kvm/hyp/aarch32.c
+++ b/arch/arm64/kvm/hyp/aarch32.c
@@ -50,9 +50,23 @@ bool kvm_condition_valid32(const struct
 	u32 cpsr_cond;
 	int cond;
 
-	/* Top two bits non-zero?  Unconditional. */
-	if (kvm_vcpu_get_esr(vcpu) >> 30)
+	/*
+	 * These are the exception classes that could fire with a
+	 * conditional instruction.
+	 */
+	switch (kvm_vcpu_trap_get_class(vcpu)) {
+	case ESR_ELx_EC_CP15_32:
+	case ESR_ELx_EC_CP15_64:
+	case ESR_ELx_EC_CP14_MR:
+	case ESR_ELx_EC_CP14_LS:
+	case ESR_ELx_EC_FP_ASIMD:
+	case ESR_ELx_EC_CP10_ID:
+	case ESR_ELx_EC_CP14_64:
+	case ESR_ELx_EC_SVC32:
+		break;
+	default:
 		return true;
+	}
 
 	/* Is condition field valid? */
 	cond = kvm_vcpu_get_condition(vcpu);



