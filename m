Return-Path: <stable+bounces-256580-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGnbNsNgGWrDvwgAu9opvQ
	(envelope-from <stable+bounces-256580-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:47:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE456002D5
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A85B33017CFB
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 09:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29433BD225;
	Fri, 29 May 2026 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cPtp8E8f"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7AB31A807;
	Fri, 29 May 2026 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047990; cv=none; b=rDjMltbnsYEyvLUzhBlzVYpw3rXAcgiSPXraqzJwnrNol9meBOoI8SX+GjVg5bzyUXEVozoyFtXXcch93Svoop2qwsTsn6/ff0Ni9f/QyanHsI3ePJOtxxu2nLBJzNVdOLO9FJIWqTahNWIuCopiS2NsT3K37mmso9KNB6WnMsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047990; c=relaxed/simple;
	bh=NsFQRYip/hELKHXpSdhGRL1Zi8kiBFNQRk5a4eoFpyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDZdAYa+k4VIWJUXfwGvjwV/Vx73nzGlKGosyvaw9C7TWsF3dtZrf9xHKUfivbJYx7tOOLTl7paY2YqwOJt1aJbqCw870IJD8Mne+lD1QDNiqYIfG6rg4CVPbA/4YDemEaU97oGn+J5oXmcsm++waceqqWFKmdLEgCJYPME+HvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cPtp8E8f; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F6732247;
	Fri, 29 May 2026 02:46:22 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CB1E3F905;
	Fri, 29 May 2026 02:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780047987; bh=NsFQRYip/hELKHXpSdhGRL1Zi8kiBFNQRk5a4eoFpyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cPtp8E8fiJFsIpbd4nDiEiAUlhSS9OYxgGdFZjsU1PMbXgie/yZqfAz3zm01OrzkD
	 39NJj4WjVcieajBynQfLB3WVipKS8FkXwfJiW8NOsb0T/r41l8OAVqUb760iy8nlJa
	 E69nTGWBqOTKgpS74gEYN3o/PGE0DbYd6AW3Ht3E=
Date: Fri, 29 May 2026 10:46:21 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Oliver Upton <oupton@kernel.org>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] KVM: arm64: Preserve all guest ZCR_EL2.LEN values
Message-ID: <20260529094621.GA1196227@e124191.cambridge.arm.com>
References: <20260529-kvm-arm64-fix-zcr-len-nv-v2-1-86cad51992bd@kernel.org>
 <868q92vace.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <868q92vace.wl-maz@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[arm.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256580-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey.gouly@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,arm.com:email,arm.com:dkim,e124191.cambridge.arm.com:mid]
X-Rspamd-Queue-Id: DFE456002D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 10:22:41AM +0100, Marc Zyngier wrote:
> Thanks for respinning this patch quickly.
> 
> On Fri, 29 May 2026 00:01:44 +0100,
> Mark Brown <broonie@kernel.org> wrote:
> > 
> > Since commit b3d29a823099 ("KVM: arm64: nv: Handle ZCR_EL2 traps") when
> > guests write to ZCR_EL2 we have clamped the value of ZCR_EL2.LEN to be
> > at most that configuring the maximum guest VL when accessed directly as
> > ZCR_EL2. This is not clearly the behaviour the architecture documents
> > for ZCR_EL2.LEN, while things are a little ambiguous currently there is
> > a fairly direct reading that suggests values will be read as written.
> > Further, the documented procedure for enumerating vector lengths means
> > that it is expected that values larger than the largest supported vector
> > length will be written in practice.
> 
> Honestly, that's not the core issue. And even $SUBJECT fails to
> capture what is at stake here.
> 
> > 
> > The reasoning for the current behaviour is not specifically articulated, my
> 
> I don't think there is a reasoning behind each and every bug.
> 
> > best guess is that it is intended to ensure that the guest can not see an
> > effective VL greater than the maximum that has been configured, though
> > this will be ineffective when a VHE guest uses the ZCR_EL1 accessor.
> 
> This last point *IS* the core problem. It is that the guest can access
> VLs beyond what is intended by the VM configuration. Not getting the
> read-as-written behaviour really is secondary compared to that issue.
> 
> [...]
> 
> I've rewritten the commit message to make it plain what the problem
> is, see below. I've also slightly tidied up access_zcr_el2(), but the
> fix otherwise looks good.

Seems like you're starting your own CMAAS! https://lore.kernel.org/kvmarm/86cxyzxymq.wl-maz@kernel.org/

> 
> Thanks,
> 
> 	M.
> 
> KVM: arm64: Correctly cap ZCR_EL2 provided by a guest hypervisor
> 
> ZCR_EL2 can be updated by a VHE guest hypervisor either using ZCR_EL2
> (which traps) or ZCR_EL1 (which does not trap). KVM handles both in
> different way:
> 
> - on ZCR_EL2 trap, ZCR_EL2.LEN is immediately capped at the VM's own
>   VL limit. This has the potential to break existing SW that relies
>   on the full LEN field to be stateful.
> 
> - on ZCR_EL1 access, we do absolutely nothing.
> 
> On restoring the SVE context for an L2 guest, we directly restore the
> guest hypervisor's view of ZCR_EL2 into the physical ZCR_EL2. If the
> guest's view of the register was updated using the ZCR_EL2 accessor,
> the value has already been sanitised (with the caveat mentioned above).
> 
> But if the guest used ZCR_EL1, the raw value is written into the HW,
> and the L2 guest can now access VLs that it shouldn't.
> 
> Fix all the above by moving the VL capping to the restore points,
> ensuring that:
> 
> - the HW is always programmed with a capped value, irrespective of
>   the accessor being used,
> 
> - the ZCR_EL2.LEN field is always completely stateful, irrespective
>   of the accessor being used.
> 
> Additionally, move ZCR_EL2 to be a sanitised register, ensuring that
> only the LEN field is actually stateful. This requires some creative
> construction of the RES0 mask, as the sysreg generation script does
> not yet generate RAZ/WI fields.
> 
> -- 

Reviewed-by: Joey Gouly <joey.gouly@arm.com>

Thanks,
Joey

> Without deviation from the norm, progress is not possible.

