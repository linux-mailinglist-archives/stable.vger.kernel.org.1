Return-Path: <stable+bounces-267956-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id whwvH+6bOmpJBggAu9opvQ
	(envelope-from <stable+bounces-267956-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 16:45:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BAB6B7FEA
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 16:45:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=VLpYZwhv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267956-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267956-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0004030265AF
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C5B3BB9FA;
	Tue, 23 Jun 2026 14:44:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474523B95EB
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 14:44:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225883; cv=none; b=gpB6yHeVMnLvpjCRRNSAdBQ+Y83btKBylhx5i2v9MgS8ziJwNzPHYFu8NiVNXSBQGirdNCX5MftYRCmhV4a+6k3FvAqztdjdXRsDYWXV93hyDDktpGK4OcYz9zDeCqgnsYjxzWFU6d5/Qn985jKdoKY9PkGOeepdwGDXJI2jnKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225883; c=relaxed/simple;
	bh=OLyyvbXtqpwYtrdcTo4YciOw2e2u9muWYAHapaeDZcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewLGQKvmURL7JI6Ekt/a7csqwjRCfFg0aYKsGmZencn4oDIAxYJmj+AzJdEuQoEbXmIZkDh0misYFOArJKgJaE948vKcHxfQlFuzwL4usCRGLknh4dpIxtYioOHhl3T3Lp004SdHjbOtHlepYJnzVPi+mFcmXhZbfzEzh0O9c28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VLpYZwhv; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25C6A1A25;
	Tue, 23 Jun 2026 07:44:37 -0700 (PDT)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC4683F632;
	Tue, 23 Jun 2026 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782225881; bh=OLyyvbXtqpwYtrdcTo4YciOw2e2u9muWYAHapaeDZcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VLpYZwhv/YRlKuEE5RRJyglnvSTlYCj0qlJlvr76oFvssE7LthszFJL5YPy8hZPdS
	 NSDnKL+l/Qzrn6Mjp/9ze5FnXE9MCi7mGTU9uIBadRpw2tXON7lIGzcnI1qJ6mQl+D
	 CnQ4No3ZMYwIvYb2KY8JtEKIKtO2n6dX8WbcWB5w=
Date: Tue, 23 Jun 2026 15:44:25 +0100
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Oliver Upton <oupton@kernel.org>
Cc: kvmarm@lists.linux.dev, Marc Zyngier <maz@kernel.org>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH RESEND v2 3/5] KVM: arm64: nv: Re-translate VNCR before
 injecting abort
Message-ID: <cdcjimpyohzgbttm7fnhzzqbiy2s74y7p2lmap2agutosk4d2r@gj7d5nwdbr6y>
References: <20260609185514.746507-1-oupton@kernel.org>
 <20260609185514.746507-4-oupton@kernel.org>
 <yw6b7zx2qxjckkut4lzkuqekh2omttwmulvqbslk27wt3vu6mp@ostr7avq6a7e>
 <ajRomJ-Y3EOxJUU-@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajRomJ-Y3EOxJUU-@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267956-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:oupton@kernel.org,m:kvmarm@lists.linux.dev,m:maz@kernel.org,m:joey.gouly@arm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:stable@vger.kernel.org,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[weilin.chang@arm.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weilin.chang@arm.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:dkim,arm.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8BAB6B7FEA

On Thu, Jun 18, 2026 at 02:52:24PM -0700, Oliver Upton wrote:
> Hey Wei-Lin,
> 
> Sorry for the latency on my end.
> 
> On Wed, Jun 10, 2026 at 02:46:18PM +0100, Wei-Lin Chang wrote:
> > Just a comment using this thread:
> > 
> > While reading this, I found this part of the code (not this patch in
> > particular) a little bit difficult to reason about. I think it's because
> > kvm_translate_vncr() is doing many things, and there are multiple
> > potential failure reasons e.g. s1 walk fault, no memslot, gmem/user mem
> > faultin errors, MMU notifier check, etc., and they are all mux'ed into
> > an error code with some context visible by the caller.
> > 
> > So in kvm_handle_vncr_abort() we demux the error code and handle the
> > errors with the help of the context (vt, is_gmem). We essentially have
> > to keep track of what error codes correspond to what error reasons.
> > 
> > Do you think it is better if we refactor and handle the errors when they
> > occur? Like inject the exception back to vEL2 right after getting the
> > results of __kvm_translate_va(), and finish up the abort handling there.
> > Same for other cases.
> > 
> > I can try it out and make it concrete if you also think this is
> > reasonable. Probably after this series gets applied when the comments
> > from Marc & Sashiko are addressed. (I reviewed and don't have additional
> > comments though.)
> 
> Yeah, returning error codes for 'normal' behavior is extremely difficult
> to work with. TBH, I'd rather we go a step further and rework the whole
> software PTW to only return errors in the case that we have to report it
> to userspace.
> 
> Otherwise, aborted walks due to guest behavior should ideally return 1
> and and inspect the walk result to differentiate between a successful /
> aborted translation.

Thanks for your suggestion!
I'll put this in the "potential improvements" list for now, there are
other fixes I need to work on.

Thanks,
Wei-Lin Chang

> 
> Thanks,
> Oliver

