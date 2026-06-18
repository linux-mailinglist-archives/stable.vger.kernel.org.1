Return-Path: <stable+bounces-267277-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GWtFDaBoNGovXQYAu9opvQ
	(envelope-from <stable+bounces-267277-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 23:52:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 741576A2CFF
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 23:52:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=STgThfhb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267277-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267277-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39D1E303828A
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 21:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5793A26AA91;
	Thu, 18 Jun 2026 21:52:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C39D22D4C3;
	Thu, 18 Jun 2026 21:52:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781819547; cv=none; b=LxZrh3L9MIZx2pHCs5zteB9cJaJ3O/tOcZM8hhpNzqVE1vvXQT9uLGpftu7SnGmx/SelEFO0EndIGqpVHav4lhnQibVhi+qK8/R2cvqqyPDeOEl0k4xlYRjuSYBIwaNG5Y58Kg/gzT5Hr8eMViQVx+js54XD5HHfmZMW0xM5PdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781819547; c=relaxed/simple;
	bh=v41KJ4v+dQvq/CxvSaOJ/jvjxo+BqduvdqvMxfSacHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzIRSP8WsrtmtISvRmNO5eDCpwceikJ7h1Lwsj3+JywBjvgyRcrGw/jt3v5KZEOqbcMYuThjAchEru4uTWxfdFcLY++9heO6aRqCCdyUIHJM9b73Mg+iKMQeIY3GYmfEaoHpynsQQjrohvPbM5pHHQ+WRPRN+aE6QTrr5kKCWVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STgThfhb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7291F000E9;
	Thu, 18 Jun 2026 21:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781819545;
	bh=zOQ59vanl4P6qfmRFaXM/RAmGrRLBBPBrQiFh5bwZz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=STgThfhbmVFgko+VFg32ANBYYi1oVlspsO02ppuCMmb/wnGPbf+Bd/sDU+EMn6D6B
	 +Y5e3glHoBE2P8v67jYdJbpn57YxpxDfVzpUbsmHgc1kRD9u6vwTzgZhs2CxytBI2Z
	 oLPZQPHJhnM1E+mVfgXD/F6y1hfEe/XquAQrFq39lbTXF/b0UjsETb5rpyeRvIddCR
	 1NCbHNz8M3HATnXEOCj92KsShnBHbk8RQtl79g2540LYQyo7natXJtuE3oZ8DLYz8o
	 iy79Je36he7vQ3J95kiP45YlL9Uavr1q0k/sQ8RTaFGLuPuRzC4tICIgF0PWnNc1wp
	 crBSKvBGOXFFw==
Date: Thu, 18 Jun 2026 14:52:24 -0700
From: Oliver Upton <oupton@kernel.org>
To: Wei-Lin Chang <weilin.chang@arm.com>
Cc: kvmarm@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH RESEND v2 3/5] KVM: arm64: nv: Re-translate VNCR before
 injecting abort
Message-ID: <ajRomJ-Y3EOxJUU-@kernel.org>
References: <20260609185514.746507-1-oupton@kernel.org>
 <20260609185514.746507-4-oupton@kernel.org>
 <yw6b7zx2qxjckkut4lzkuqekh2omttwmulvqbslk27wt3vu6mp@ostr7avq6a7e>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw6b7zx2qxjckkut4lzkuqekh2omttwmulvqbslk27wt3vu6mp@ostr7avq6a7e>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267277-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[oupton@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:weilin.chang@arm.com,m:kvmarm@lists.linux.dev,m:maz@kernel.org,m:joey.gouly@arm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:stable@vger.kernel.org,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oupton@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 741576A2CFF

Hey Wei-Lin,

Sorry for the latency on my end.

On Wed, Jun 10, 2026 at 02:46:18PM +0100, Wei-Lin Chang wrote:
> Just a comment using this thread:
> 
> While reading this, I found this part of the code (not this patch in
> particular) a little bit difficult to reason about. I think it's because
> kvm_translate_vncr() is doing many things, and there are multiple
> potential failure reasons e.g. s1 walk fault, no memslot, gmem/user mem
> faultin errors, MMU notifier check, etc., and they are all mux'ed into
> an error code with some context visible by the caller.
> 
> So in kvm_handle_vncr_abort() we demux the error code and handle the
> errors with the help of the context (vt, is_gmem). We essentially have
> to keep track of what error codes correspond to what error reasons.
> 
> Do you think it is better if we refactor and handle the errors when they
> occur? Like inject the exception back to vEL2 right after getting the
> results of __kvm_translate_va(), and finish up the abort handling there.
> Same for other cases.
> 
> I can try it out and make it concrete if you also think this is
> reasonable. Probably after this series gets applied when the comments
> from Marc & Sashiko are addressed. (I reviewed and don't have additional
> comments though.)

Yeah, returning error codes for 'normal' behavior is extremely difficult
to work with. TBH, I'd rather we go a step further and rework the whole
software PTW to only return errors in the case that we have to report it
to userspace.

Otherwise, aborted walks due to guest behavior should ideally return 1
and and inspect the walk result to differentiate between a successful /
aborted translation.

Thanks,
Oliver

