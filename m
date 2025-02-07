Return-Path: <stable+bounces-114223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C94EA2BF65
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 10:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B583A8F0F
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 09:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21D71A2381;
	Fri,  7 Feb 2025 09:34:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED3B610D
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920861; cv=none; b=Njwoy83NJrpHC9aK0k5O+Qi8q9WQKhn/id3R9rOhAFiCEyIhtqrNaiP2po+zKSaxd2nOoFQLCp+Y2SYsJUNVEbhhvQc++7qvZJd59P/6p7367j9xsX3BLqH/bHBJQ5HdwuP5na8Ou+TN8kryMK06SNxUYzFwOrmyNqMvwrEX3yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920861; c=relaxed/simple;
	bh=YmLWIXw9eCJ/RvuYBvufGOuTwv7X5B+yazuXUO7E8R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzL2Fo2TXRx3i5/Wx7cImVtKupgVDrybQk/wylSHNWpkdpHEc1v7Fd8GtzWXsb3rugjVpkb9TMwzBThQH6kO7Wv5SCtv6AncVqcB4aKk/2k5+jm3//Gw4GwzRaei0BR1bVgYRikyW1gPUzEI6LPYPFnD/m5W4kruEGQOxGRzAq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59B9D339;
	Fri,  7 Feb 2025 01:34:41 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F24463F5A1;
	Fri,  7 Feb 2025 01:34:15 -0800 (PST)
Date: Fri, 7 Feb 2025 09:34:10 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	eauger@redhat.com, eric.auger@redhat.com, fweimer@redhat.com,
	jeremy.linton@arm.com, maz@kernel.org, oliver.upton@linux.dev,
	pbonzini@redhat.com, stable@vger.kernel.org, tabba@google.com,
	wilco.dijkstra@arm.com, will@kernel.org
Subject: Re: [PATCH v2 8/8] KVM: arm64: Eagerly switch ZCR_EL{1,2}
Message-ID: <Z6XTkkz8uS-DnegG@J2N7QTR9R3>
References: <20250206141102.954688-1-mark.rutland@arm.com>
 <20250206141102.954688-9-mark.rutland@arm.com>
 <9972d29a-1387-408c-9070-d53b025191f2@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9972d29a-1387-408c-9070-d53b025191f2@sirena.org.uk>

On Thu, Feb 06, 2025 at 07:12:52PM +0000, Mark Brown wrote:
> On Thu, Feb 06, 2025 at 02:11:02PM +0000, Mark Rutland wrote:
> 
> > +static inline void fpsimd_lazy_switch_to_guest(struct kvm_vcpu *vcpu)
> > +{
> > +	u64 zcr_el1, zcr_el2;
> > +
> > +	if (!guest_owns_fp_regs())
> > +		return;
> > +
> > +	if (vcpu_has_sve(vcpu)) {
> > +		/* A guest hypervisor may restrict the effective max VL. */
> > +		if (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu))
> > +			zcr_el2 = __vcpu_sys_reg(vcpu, ZCR_EL2);
> > +		else
> > +			zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
> > +
> > +		write_sysreg_el2(zcr_el2, SYS_ZCR);
> > +
> > +		zcr_el1 = __vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu));
> > +		write_sysreg_el1(zcr_el1, SYS_ZCR);
> > +	}
> > +}
> 
> I don't think we should worry about it for this series but just for
> future reference:
> 
> These new functions do unconditional writes for EL2, the old code made
> use of sve_cond_update_zcr_vq() which suppresses the writes but didn't
> have the selection of actual sysreg that write_sysreg_el2() has.  I
> believe this was done due to a concern about potential overheads from
> writes to the LEN value effective in the current EL.  OTOH that also
> introduced an additional read to get the current value, and that was all
> done without practical systems to benchmark any actual impacts from noop
> writes so there's a reasonable chance it's just not a practical issue.
> We should check this on hardware, but that can be done separately.

Yep, I'm aware of that.

Mark.

