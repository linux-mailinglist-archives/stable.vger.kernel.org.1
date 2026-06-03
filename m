Return-Path: <stable+bounces-260204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i3hREUezIGpx6wAAu9opvQ
	(envelope-from <stable+bounces-260204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 01:05:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2D663BB8B
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 01:05:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=u9embgzY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260204-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260204-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ACB53057768
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 22:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072523D47D0;
	Wed,  3 Jun 2026 22:57:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FD649551D
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 22:57:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527454; cv=none; b=UcpZtSIrTHJq4V0rlYAA7uVvfw4DK5dmuT4ot7Qp1HdPDx2a8E14LJA1tCQR6HfC03Ax4IBm2ObvvKIMopcf7uGMwKlM2zIz5cijp0rye8kFvWXXN5INo/YkCSsiDIQlRmsorI8BXrg+bfGwNy6O0PjlBoym/BrGPC550t645MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527454; c=relaxed/simple;
	bh=0EIrwD+lgpB/geyCy3UdXRKAOa6LD3lv0ucquiJdRBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xq7cyDQUH7kgMR7cpOBZxiGR8wE2EAgRiOGKg9q6Y5dGqoGZYvNNo6VsfSZ35Uc/AWwpTKph6baUTFr/VWzTz0Gqxr3fkdnXugSm13B4cO2b5UsglHBwWC5xO18psg24G4fSHv05j9aAUpAt6jbPxoT5xz5lVoBknZ5n9eUtOzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=u9embgzY; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D28EA4837;
	Wed,  3 Jun 2026 15:57:25 -0700 (PDT)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D83163F632;
	Wed,  3 Jun 2026 15:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780527450; bh=0EIrwD+lgpB/geyCy3UdXRKAOa6LD3lv0ucquiJdRBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9embgzYSCBW6F3fG2pkIi3sDaOnzDBs91m7puG95nQVk4qSajWCQnNsTtZzf6zcL
	 WvKp/ZWpyfpOSVMa+PziSVKxaPkMiSSYlZ1HB/qa45dp9265aYlEmnEz/YUZzsYpTY
	 h+h90T+6J+z8Zwmrix6fJYoxlRkp/zt0vjBZipnQ=
Date: Wed, 3 Jun 2026 23:57:20 +0100
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: arm64: nv: Fix handling of XN[0] when
 !FEAT_XNX
Message-ID: <zzprmfdgkd4sfxjuvbj65ssmdbcxvb2lrdv7lgywysuthx6t4i@ffehlydwbwy7>
References: <20260602165901.52800-1-oupton@kernel.org>
 <20260602165901.52800-2-oupton@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602165901.52800-2-oupton@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260204-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:oupton@kernel.org,m:kvmarm@lists.linux.dev,m:maz@kernel.org,m:joey.gouly@arm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[weilin.chang@arm.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weilin.chang@arm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,arm.com:dkim,arm.com:from_mime,arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ffehlydwbwy7:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A2D663BB8B

Hi Oliver,

On Tue, Jun 02, 2026 at 09:59:00AM -0700, Oliver Upton wrote:
> XN has already been extracted from its bitfield position so using
> FIELD_PREP() on the mask that clears XN[0] is completely broken, having
> the effect of unconditionally granting execute permissions...
> 
> Fix the obvious mistake by manipulating the right bit.
> 
> Cc: stable@vger.kernel.org
> Fixes: d93febe2ed2e ("KVM: arm64: nv: Forward FEAT_XNX permissions to the shadow stage-2")
> Reviewed-by: Wei-Lin Chang <weilin.chang@arm.com>
> Signed-off-by: Oliver Upton <oupton@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_nested.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
> index 091544e6af44..a0eb83319c2e 100644
> --- a/arch/arm64/include/asm/kvm_nested.h
> +++ b/arch/arm64/include/asm/kvm_nested.h
> @@ -131,7 +131,7 @@ static inline bool kvm_s2_trans_exec_el0(struct kvm *kvm, struct kvm_s2_trans *t
>  	u8 xn = FIELD_GET(KVM_PTE_LEAF_ATTR_HI_S2_XN, trans->desc);
>  
>  	if (!kvm_has_xnx(kvm))
> -		xn &= FIELD_PREP(KVM_PTE_LEAF_ATTR_HI_S2_XN, 0b10);
> +		xn &= 0b10;
>  
>  	switch (xn) {
>  	case 0b00:
> @@ -147,7 +147,7 @@ static inline bool kvm_s2_trans_exec_el1(struct kvm *kvm, struct kvm_s2_trans *t
>  	u8 xn = FIELD_GET(KVM_PTE_LEAF_ATTR_HI_S2_XN, trans->desc);
>  
>  	if (!kvm_has_xnx(kvm))
> -		xn &= FIELD_PREP(KVM_PTE_LEAF_ATTR_HI_S2_XN, 0b10);
> +		xn &= 0b10;
>  

Now that the other patch brings up kvm_pgtable_stage2_pte_prot(), what
do you think about also using that here? It can save a little bit of
duplicated decode logic.

Other than this being in a header and we'll have to move the code
around for this to work, I'm curious are there any other issues with
this idea?

Thanks,
Wei-Lin Chang

>  	switch (xn) {
>  	case 0b00:
> -- 
> 2.47.3
> 

