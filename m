Return-Path: <stable+bounces-266661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qfNbH6NZMmq/ywUAu9opvQ
	(envelope-from <stable+bounces-266661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 10:24:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E04B3697843
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 10:24:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=XP+r4S1i;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266661-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266661-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7A183013887
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 08:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC305381AF0;
	Wed, 17 Jun 2026 08:23:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB48B380FE5;
	Wed, 17 Jun 2026 08:23:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781684638; cv=none; b=djKArBbJ21bFO9cny0h764Y5hIyylJ28ljgMA4BgYUfXnCEVR5ENglLnSnJtSkgctZ+3Dz9m95O8YLn5kZt99vffsGIbi0EVIOyugv5+SMSUBPRMb5LbqmwahMfniuCUfa5LWwbTIQKx+VNlW99YnplGLQNEvtJ6XYlLvf0bkU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781684638; c=relaxed/simple;
	bh=wo9nDHvniRQxPbdj8SFuco+7g3miFHcszLbivPTH4GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OR32MPhhL+Losfe/rfEMTa24tzNCLxFrwOgfRXwrG3CohBvTjm0lwhq8aZ5oBRyHFW3LHEFKQgEkBrf5rtzU/GD8wTZAlq097HF75z+IW+ktIqP0652gmE5sSTRK5IuvChMW6R72BA0kEGjnvB76HpvV6g0b98RtygFFr96SBVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XP+r4S1i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC451F000E9;
	Wed, 17 Jun 2026 08:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781684637;
	bh=mNb7fhTPpwYtkdprDlxN8Lw0+AyTFfgFLASUz89Mo5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XP+r4S1ikCZtadJNF+gqxTElSYr5B7PKudKOLiVEfEP7iloSNfPywYPZUyK3yI8yX
	 ddVUZVPqB7Je8Xh0+efIu9I92decAL7jl4LKiyqv+AIG0+rd0hDvHzQke0mzTbpNVc
	 GB04tKJxL2FY2QMQl38AESa9nlhbkjW4FBB9jKo8=
Date: Wed, 17 Jun 2026 13:52:51 +0530
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	David Vernet <void@manifault.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 064/522] selftests/bpf: S/iptables/iptables-legacy/
 in the bpf_nf and xdp_synproxy test
Message-ID: <2026061736-absurd-italics-ce32@gregkh>
References: <20260616145125.307082728@linuxfoundation.org>
 <20260616145128.790200973@linuxfoundation.org>
 <80be436bbcda9b8a66058c01eef0b0f94722e7ef.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80be436bbcda9b8a66058c01eef0b0f94722e7ef.camel@decadent.org.uk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266661-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ben@decadent.org.uk,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:martin.lau@kernel.org,m:andrii@kernel.org,m:void@manifault.com,m:paul.chaignon@gmail.com,m:shung-hsi.yu@suse.com,m:sashal@kernel.org,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,manifault.com,gmail.com,suse.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E04B3697843

On Wed, Jun 17, 2026 at 10:11:34AM +0200, Ben Hutchings wrote:
> On Tue, 2026-06-16 at 20:23 +0530, Greg Kroah-Hartman wrote:
> > 6.1-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Martin KaFai Lau <martin.lau@kernel.org>
> > 
> > [ Upstream commit de9c8d848d90cf2e53aced50b350827442ca5a4f ]
> > 
> > The recent vm image in CI has reported error in selftests that use
> > the iptables command.  Manu Bretelle has pointed out the difference
> > in the recent vm image that the iptables is sym-linked to the iptables-nft.
> > With this knowledge,  I can also reproduce the CI error by manually running
> > with the 'iptables-nft'.
> > 
> > This patch is to replace the iptables command with iptables-legacy
> > to unblock the CI tests.
> [...]
> 
> There is a later fix for this: commit 967e8def1100 "selftests/bpf: Fix
> bpf_nf selftest failure".  But I don't think it's that important.

Already queued up, thanks!

greg k-h

