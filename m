Return-Path: <stable+bounces-242059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA25Ikoc82kvxQEAu9opvQ
	(envelope-from <stable+bounces-242059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:09:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AA249FA83
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EE913017000
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD1B369211;
	Thu, 30 Apr 2026 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tr+sv2mF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5E0263F44;
	Thu, 30 Apr 2026 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540084; cv=none; b=Qw1rj6ze7VSClMj4GlfyeKynS3J5xPMPtZbEy8188UayyTogCswhUlkGS4Tf3awpfLjJNyuQfOge6s/Q53/upP6YriiKlXs8CLf9nF8UH/QVvUYmcUCDjPaIp5Izu7uGC6IwHka9ydA+WnHAwS2yu/C83zsE9231xfQQNi8Zpm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540084; c=relaxed/simple;
	bh=ZFzSNODvz59u5BBj2IDcPy45PSPOnkHPbn9VjRLPFko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAeO+1eSbEAy6NWPTkwcgVH+2ZYxxxSzihnHGpMl/KYs/BbFvjDv022ewn9r9vkwQx4MB8/NqNslYqFarNFD4vC5/0yfy4Z3UEDX3+CxIQnQNrb8qDPDsa1PfEYewYAOGf5iGSdab8yjUZvJMpTMlqUGjYpppUP9Asvi9AyrReY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tr+sv2mF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F31C2BCB3;
	Thu, 30 Apr 2026 09:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777540083;
	bh=ZFzSNODvz59u5BBj2IDcPy45PSPOnkHPbn9VjRLPFko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tr+sv2mFI9m4Ofy6Z0CStOodv0cPAChYeTf2a3fmIaFcBPf+N3J7PMUQ2IsSG5aKu
	 Ws09EaXWOCdaKF/SE443itbM9VK4E6tn5zNtfAWEe8F1oVWjulubvyY+SDFIG8nGJb
	 aWwDoCxGyVXwVXC9Fo/HEw+pFY5Br/2PfTvj2DMn+cBsBZsx93dLe+tf6r4zPvfsXb
	 3KzcHrFPh+lw+7fU3SCr7XSFXlFjhgeGtTQy7ByyUK5bnWqLhPH0nxu0bphVd+9mvJ
	 TzuqDp7DgriF5jFxU5E3CPNYB03GIMupks3LEdgHdC2+eFLWbj4/NOO1gDLJ5imF9V
	 b4u8H3NfNszvQ==
Date: Thu, 30 Apr 2026 10:07:58 +0100
From: Will Deacon <will@kernel.org>
To: Fuad Tabba <tabba@google.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com, qperret@google.com,
	vdonnefort@google.com, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/8] KVM: arm64: Make EL2 exception entry and exit
 context-synchronization events
Message-ID: <afMb7uuPlUbLeu7k@willie-the-truck>
References: <20260428103008.696141-1-tabba@google.com>
 <20260428103008.696141-2-tabba@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428103008.696141-2-tabba@google.com>
X-Rspamd-Queue-Id: 26AA249FA83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242059-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 11:30:01AM +0100, Fuad Tabba wrote:
> SCTLR_EL2.EIS and SCTLR_EL2.EOS control whether exception entry and
> exit at EL2 are Context Synchronisation Events (CSEs). Per ARM DDI
> 0487 M.b, EIS is governed by D1.4.2 rule RBBSRF (p. D1-7205) and EOS
> by D1.4.4.1 rule RBWCFK (p. D1-7209). D24.2.175 (p. D24-9754):
> 
>   - !FEAT_ExS: the bit is RES1, so the entry/exit is unconditionally
>     a CSE.
>   - FEAT_ExS: the reset value is architecturally UNKNOWN; software
>     must set the bit to make the entry/exit a CSE.
> 
> INIT_SCTLR_EL2_MMU_ON in arch/arm64/include/asm/sysreg.h sets neither
> bit. KVM/arm64 hot paths rely on ERET from EL2 being a CSE, and on
> synchronous EL1->EL2 entry being a CSE, to elide explicit ISBs after
> MSRs to context-switching system registers (HCR_EL2, HFGxTR_EL2,
> HCRX_EL2, ZCR_EL2, CPACR_EL1, CPTR_EL2, SCTLR_EL1, ptrauth keys,
> etc.); examples include the activate-traps path,
> ptrauth_switch_to_guest, and the FPSIMD trap re-enable in
> kvm_hyp_handle_fpsimd. On FEAT_ExS hardware those reliances are not
> architecturally backed unless EOS=1 (and, for entry, EIS=1), and
> whether they hold today depends on firmware initialisation outside
> the kernel's control.
> 
> Make the guarantee explicit: include SCTLR_ELx_EIS | SCTLR_ELx_EOS in
> INIT_SCTLR_EL2_MMU_ON so that EL2 exception entry and exit are
> unconditionally CSEs regardless of whether FEAT_ExS is implemented.
> This matches the pairing in arch/arm64/kvm/config.c which treats EIS
> and EOS together as RES1 under !FEAT_ExS.
> 
> INIT_SCTLR_EL2_MMU_OFF is left unchanged: that path is used during
> very early EL2 init and the EL2 MMU-off transition, neither of which
> relies on these bits in the same way.
> 
> Fixes: fe2c8d19189e ("KVM: arm64: Turn SCTLR_ELx_FLAGS into INIT_SCTLR_EL2_MMU_ON")

I don't think this Fixes: tag is accurate:

1. That commit doesn't do anything with EIS/EOS afaict.
2. Back in 5.12 (when that thing landed), SCTLR_EL2_RES1 did actually
   include EIS and EOS

so I think the issue here might be that the auto-generated sysreg file
quietly changes the RES1 definitions as bits get allocated, but the
macros using the RES1 definition don't get updated. That's a pretty
horrible pit that it feels like we might keep falling into :/

Looking at 0a35bd285f43 ("arm64: Convert SCTLR_EL2 to sysreg
infrastructure"), I think we ended up dropping a whole bunch of fields
from the RES1 mask (which became 0!). Have you checked all of those?

Will

