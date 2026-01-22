Return-Path: <stable+bounces-211186-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNIxF6N/cWk1IAAAu9opvQ
	(envelope-from <stable+bounces-211186-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 02:38:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E205D6069D
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 02:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2A01382096
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 01:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA5821FF2A;
	Thu, 22 Jan 2026 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dLUzQBKP"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AA93033FB
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 01:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769045908; cv=none; b=BLmL4Uc0YKZ/P1WOOGfHyHnRrKG2JafOf1TNU81X1TPeUMt2DeqNyKguW/6FW0E3lJcIkxYUZTTntPpSzW3CK29QVf4Vgw597FqewFNqaL4rHaA/GMEM/puilPU6AsEw83aC79e/WWuFAyp87MZrhBIybqoPEYlr8H3F9J2HJug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769045908; c=relaxed/simple;
	bh=oY/qN6nZjPxrQYZGrC5kxmWY9kyRk/6YjHOsTx5Jz8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urg5sGM84rUzs/fEsxOjRKzHMUvsSlHyalgCdYENDay50bV7DddDWCXPOJdFsypCAHK+r/VdxqU9b28+up3LiMCA6qm/X7QQVhBHppgxaDVMgJbEWcExmA9GkgNfMCqnNgRvFl3B/Wnv8h2tp7oafJPhguIvdUhDqOP6syAgqAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dLUzQBKP; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 22 Jan 2026 01:38:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769045903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2rgyhPOsWcxR+CccOn5CSJfPcIulXCGROrBkQlH1Hw=;
	b=dLUzQBKPylLEp+xsRT31ktLjpnhES0ORWsr2drYoiJ50B/mF6F1nym2aTgkN4jUmT2Dg0M
	JCVV5X0JBlA/nyKoM4JRafnf2BxQlK/odJQAN5MgSp1pvh5lullBHtzQV1RX//34jerVl1
	+r5EyZ60tnLhU9sv66uhfFszV6ifENg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 16/26] KVM: nSVM: Add missing consistency check for
 nCR3 validity
Message-ID: <zhrcqjacdnmm4gtcmbx7rqaoap6kxtzirv5t2a3rustjsrc32g@2w5u23dcb3bi>
References: <20260115011312.3675857-1-yosry.ahmed@linux.dev>
 <20260115011312.3675857-17-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260115011312.3675857-17-yosry.ahmed@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211186-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry.ahmed@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,linux.dev:email,linux.dev:dkim]
X-Rspamd-Queue-Id: E205D6069D
X-Rspamd-Action: no action

On Thu, Jan 15, 2026 at 01:13:02AM +0000, Yosry Ahmed wrote:
> From the APM Volume #2, 15.25.4 (24593—Rev. 3.42—March 2024):
> 
> 	When VMRUN is executed with nested paging enabled
> 	(NP_ENABLE = 1), the following conditions are considered illegal
> 	state combinations, in addition to those mentioned in
> 	“Canonicalization and Consistency Checks”:
> 	• Any MBZ bit of nCR3 is set.
> 	• Any G_PAT.PA field has an unsupported type encoding or any
> 	reserved field in G_PAT has a nonzero value.
> 
> Add the consistency check for nCR3 being a legal GPA with no MBZ bits
> set. The G_PAT.PA check was proposed separately [*].
> 
> [*]https://lore.kernel.org/kvm/20251107201151.3303170-6-jmattson@google.com/
> 
> Fixes: 4b16184c1cca ("KVM: SVM: Initialize Nested Nested MMU context on VMRUN")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  arch/x86/kvm/svm/nested.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 0f2b42803cf6..eb4a633a668d 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -351,6 +351,11 @@ static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
>  	if (CC(control->asid == 0))
>  		return false;
>  
> +	if (nested_npt_enabled(to_svm(vcpu))) {

This won't work correctly in svm_set_nested_state(), because the control
cache hadn't been restored yet. Also makes more sense in general to
check NPT enablement using the passed in control area.

This should be:

	if (control->nested_ctl & SVM_NESTED_CTL_NP_ENABLE) {

> +		if (CC(!kvm_vcpu_is_legal_gpa(vcpu, control->nested_cr3)))
> +			return false;
> +	}
> +
>  	if (CC(!nested_svm_check_bitmap_pa(vcpu, control->msrpm_base_pa,
>  					   MSRPM_SIZE)))
>  		return false;
> -- 
> 2.52.0.457.g6b5491de43-goog
> 

