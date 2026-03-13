Return-Path: <stable+bounces-225324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ63OasgtGknhwAAu9opvQ
	(envelope-from <stable+bounces-225324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 15:35:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F0028514F
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 15:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA7C931523C2
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 14:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FBD3A545A;
	Fri, 13 Mar 2026 14:30:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7D03A381A
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412228; cv=none; b=KyBH9Ocb1klhiBx1XkYg/wEoo2YXMt6kEUNpBgmQbpaVQrD+X5+dUgPAVhs0BK4K31PS6hKp0bvQ1SbXe0iqGSpOKfEQ/nUwKiI9KGJOoWn1ocIxi5DemBmrhfHZYDrT2QVW6EBZ4HwxA3FkMBaIfJMEn/nZeqqzfxOlAtGcn+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412228; c=relaxed/simple;
	bh=nYwqeFc8OgCowD+Gzv8JyACPtM0oEhL1VoJpKzVF6cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfcxBkoSSCLqYmAi/M2L60GHQKYQXkc8lgJ3mgeIIptXPGo2f9oMcXwLxewfV4OEbsLw3OoBf+jWyR5dz8oSdOL4e5Ta6MzDqZujb9dYXNnr1eWyqSXka9Bxzaq9e742zv6fJcAwXcN1UyIqEgfdft56KtawhNBZbZ513j6N9/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A91E5165C;
	Fri, 13 Mar 2026 07:30:18 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4AA23F7BD;
	Fri, 13 Mar 2026 07:30:23 -0700 (PDT)
Date: Fri, 13 Mar 2026 14:30:19 +0000
From: Joey Gouly <joey.gouly@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Discard PC update state on vcpu reset
Message-ID: <20260313143019.GA3369094@e124191.cambridge.arm.com>
References: <20260312140850.822968-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312140850.822968-1-maz@kernel.org>
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225324-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey.gouly@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: 42F0028514F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 02:08:50PM +0000, Marc Zyngier wrote:
> Our vcpu reset suffers from a particularly interesting flaw, as it
> does not correctly deal with state that will have an effect on the
> execution flow out of reset.
> 
> Take the following completely random example, never seen in the wild
> and that never resulted in a couple of sleepless nights: /s
> 
> - vcpu-A issues a PSCI_CPU_OFF using the SMC conduit
> 
> - SMC being a trapped instruction (as opposed to HVC which is always
>   normally executed), we annotate the vcpu as needing to skip the
>   next instruction, which is the SMC itself
> 
> - vcpu-A is now safely off
> 
> - vcpu-B issues a PSCI_CPU_ON for vcpu-A, providing a starting PC
> 
> - vcpu-A gets reset, get the new PC, and is sent on its merry way
> 
> - right at the point of entering the guest, we notice that a PC
>   increment is pending (remember the earlier SMC?)
> 
> - vcpu-A skips its first instruction...
> 
> What could possibly go wrong?
> 
> Well, I'm glad you asked. For pKVM as a NV guest, that first instruction
> is extremely significant, as it indicates whether the CPU is booting
> or resuming. Having skipped that instruction, nothing makes any sense
> anymore, and CPU hotplugging fails.

Would the normal method of offlining/onlining via sysfs also be affected?

> 
> This is all caused by the decoupling of PC update from the handling
> of an exception that triggers such update, making it non-obvious
> what affects what when.
> 
> Fix this train wreck by discarding all the PC-affecting state on
> vcpu reset.

Good job on tracking it down.. makes you wonder why the DSB "fixed" things!

> 
> Fixes: f5e30680616ab ("KVM: arm64: Move __adjust_pc out of line")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/kvm/reset.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index 959532422d3a3..b963fd975aaca 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -247,6 +247,20 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  			kvm_vcpu_set_be(vcpu);
>  
>  		*vcpu_pc(vcpu) = target_pc;
> +
> +		/*
> +		 * We may come from a state where either a PC update was
> +		 * pending (SMC call resulting in PC being increpented to
                                                           incremented
> +		 * skip the SMC) or a pending exception. Make sure we get
> +		 * rid of all that, as this cannot be valid out of reset.
> +		 *
> +		 * Note that clearing the exception mask also clears PC
> +		 * updates, but that's an implementation detail, and we
> +		 * really want to make it explicit.
> +		 */
> +		vcpu_clear_flag(vcpu, PENDING_EXCEPTION);
> +		vcpu_clear_flag(vcpu, EXCEPT_MASK);
> +		vcpu_clear_flag(vcpu, INCREMENT_PC);
>  		vcpu_set_reg(vcpu, 0, reset_state.r0);
>  	}
>  

Reviewed-by: Joey Gouly <joey.gouly@arm.com>

Thanks,
Joey

