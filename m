Return-Path: <stable+bounces-233261-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CMeLYGu0Gmy+wYAu9opvQ
	(envelope-from <stable+bounces-233261-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 08:24:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA7239A1D8
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 08:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5150301494C
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 06:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E6D376490;
	Sat,  4 Apr 2026 06:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zLjl078Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAF833BBBD
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 06:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775283818; cv=none; b=a7NyaH2rEr0EO2fkK2vWUoE1GbDPvW4LG5CR1wM7HgNbu5O5UCUcNhRBNubFlQYv5SVZUyxoYj2ruYyG9h8r8eQoinYuRIt/zFvXvpkOY1Eorl1iplLs8OAijWLowXK6wHOdFAEgtz/KJ2pgwWX/v1pQqDu5lnbMSlMq8lDl7oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775283818; c=relaxed/simple;
	bh=YSj2qHQY3WBof2/tFluKj6QbWdaWSnkUwZL14Sfck5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMXVWmpXA26wec2EMiVzaWdoBtnCrFZz/FXEgA0a2g933vL6lbMgkXG03/BO7dw86aPCum402dIUqzZDAUEqLGIIrk4BYoGxD6YB1y0xc5PzsBvnuetVOkL9EBv648tqR4PyF9+0PRv8ybl/LHWOXKaF/2KXlBi+9h9HF1Ta9TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zLjl078Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BADC19423;
	Sat,  4 Apr 2026 06:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775283817;
	bh=YSj2qHQY3WBof2/tFluKj6QbWdaWSnkUwZL14Sfck5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zLjl078ZKEeZywSVvBlp6zuvccGJJk6/YbobJr36/CpaMK47Mz4dY9OUg+8jaKNny
	 IaM52zj1M1L1smMG4CNlGb24wzkAn+h4o7YcLHR8DxD2abwq8SPM9gHIH5H0723cxa
	 3D1zqhW+TWZfWPelUwQpZ8aa2i63mN2IBbnWzrFM=
Date: Sat, 4 Apr 2026 08:23:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: stable@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: Re: [PATCH stable 6.6 0/6] bpf: Fix bounds when ranges cross sign
 boundary
Message-ID: <2026040428-request-coastline-6a99@gregkh>
References: <cover.1775206731.git.paul.chaignon@gmail.com>
 <adArq7uWVYwwTR_4@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adArq7uWVYwwTR_4@mail.gmail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233261-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,suse.com];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1EA7239A1D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 11:05:47PM +0200, Paul Chaignon wrote:
> On Fri, Apr 03, 2026 at 05:33:59PM +0200, Paul Chaignon wrote:
> > As discussed in [1] yesterday, this series backports two sets of fixes
> > for BPF, with their selftests:
> > - 00bf8d0c6c9b ("bpf: Improve bounds when s64 crosses sign boundary")
> > - 26e5e346a52c ("selftests/bpf: Test cross-sign 64bits range
> >   refinement")
> > - f96841bbf4a1 ("selftests/bpf: Test invariants on JSLT crossing sign")
> > - 5dbb19b16ac4 ("bpf: Add third round of bounds deduction")
> > - fbc7aef517d8 ("bpf: Fix u32/s32 bounds when ranges cross min/max
> >   boundary")
> > - f81fdfd16771 ("selftests/bpf: test refining u32/s32 bounds when
> >   ranges cross min/max boundary")
> > 
> > Using Shung-Hsi's stable CI repo [2], I verified the BPF selftests pass
> > with these commits applied on top of v6.12.
> 
> As hinted here, the subject prefix is incorrect. This series is meant
> for v6.12, not v6.6. Should I resend?

Yes please!

