Return-Path: <stable+bounces-225348-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE4iDQs5tGl3jAAAu9opvQ
	(envelope-from <stable+bounces-225348-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 17:19:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90020286DA1
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 17:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8505301C5A7
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 16:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA2937F8D7;
	Fri, 13 Mar 2026 16:16:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7683C3459
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773418579; cv=none; b=Ux3LBtNjoOoaxj3bSo4JPFTtxGQZ2Qz3tgOZTR4YYJ0x8oPR+D4sQFFlTW2ZAl+1gr6A87NoSBxLqpEM6Ap4IwFNJoHwtg/8qScKtasxiTqkzbvZOFILCknEeI54huzoUT0+UOQMPxfbs5GGU8w9B3FwvUZkpNf2rB2E0nOzvZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773418579; c=relaxed/simple;
	bh=xpb+sAZZFW4cZzQqktbvtQyTfq7nsxB6lk9Mqo8D8Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pphrnD2jMPLX9aZqvvF/BQ8H02YRPNdPyR02hoHE2vbVu8QJJ8LjqMaqMyC/vOXGyjoT+D0k08fHMDHzUeZuZ9JAl5nP74bGEiImQ8Kgz/LBSW6BrQP4B6a+bBB/IgQq5x4SThOoK3A/bTP/8PGmmHl5yoKTEFdN4kq0ynrAM3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B102176A;
	Fri, 13 Mar 2026 09:16:11 -0700 (PDT)
Received: from [10.57.18.169] (unknown [10.57.18.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9780F3F7BD;
	Fri, 13 Mar 2026 09:16:16 -0700 (PDT)
Message-ID: <10f5de0b-1fdc-4867-8ccb-e9362fc553fe@arm.com>
Date: Fri, 13 Mar 2026 16:16:15 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: arm64: Discard PC update state on vcpu reset
Content-Language: en-GB
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Cc: Joey Gouly <joey.gouly@arm.com>, Oliver Upton <oupton@kernel.org>,
 Zenghui Yu <yuzenghui@huawei.com>, stable@vger.kernel.org
References: <20260312140850.822968-1-maz@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20260312140850.822968-1-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225348-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suzuki.poulose@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.962];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email,arm.com:mid]
X-Rspamd-Queue-Id: 90020286DA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 12/03/2026 14:08, Marc Zyngier wrote:
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
>    normally executed), we annotate the vcpu as needing to skip the
>    next instruction, which is the SMC itself
> 
> - vcpu-A is now safely off
> 
> - vcpu-B issues a PSCI_CPU_ON for vcpu-A, providing a starting PC
> 
> - vcpu-A gets reset, get the new PC, and is sent on its merry way
> 
> - right at the point of entering the guest, we notice that a PC
>    increment is pending (remember the earlier SMC?)
> 
> - vcpu-A skips its first instruction...
> 
> What could possibly go wrong?
> 
> Well, I'm glad you asked. For pKVM as a NV guest, that first instruction
> is extremely significant, as it indicates whether the CPU is booting
> or resuming. Having skipped that instruction, nothing makes any sense
> anymore, and CPU hotplugging fails.
> 
> This is all caused by the decoupling of PC update from the handling
> of an exception that triggers such update, making it non-obvious
> what affects what when.
> 
> Fix this train wreck by discarding all the PC-affecting state on
> vcpu reset.
> 
> Fixes: f5e30680616ab ("KVM: arm64: Move __adjust_pc out of line")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>   arch/arm64/kvm/reset.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index 959532422d3a3..b963fd975aaca 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -247,6 +247,20 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>   			kvm_vcpu_set_be(vcpu);
>   
>   		*vcpu_pc(vcpu) = target_pc;
> +
> +		/*
> +		 * We may come from a state where either a PC update was
> +		 * pending (SMC call resulting in PC being increpented to
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
>   		vcpu_set_reg(vcpu, 0, reset_state.r0);
>   	}

Wow! Thats it finally !! Glad you found the root cause.


Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>



