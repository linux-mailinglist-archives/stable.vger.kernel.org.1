Return-Path: <stable+bounces-263747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lGs8HmhTMWpggwUAu9opvQ
	(envelope-from <stable+bounces-263747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:45:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3686900EB
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:45:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=XbIE9m3L;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263747-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263747-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 785A53048F29
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 13:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7B93271FD;
	Tue, 16 Jun 2026 13:42:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15872FFDD5
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 13:42:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617343; cv=none; b=dMIXp/9FpOnVO7YKSnpvyMW+gzaC6fdFtpYJbWIJlI+krcALKcqqzdxncWRinvDRYRs30UIpDK5HQLxfIZDwbAYdjdmiHe9Lar+ayi2oc2wljDE66qlp5HMlCsWVUZPPkGgNdwle+iH3sflOG6aN7lAPnYGKGqdfa4oGihRkplg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617343; c=relaxed/simple;
	bh=Z8+M+jTBdZz/kRhZ192LUFh35c9m2dFZgLP2oibWc2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQME3eYcOEd5qUX+NO916OkxjJr3bPZBkOEogzRPznIr4DKLs0JevSZBXwaLMs2O05wa5o+8yHakP6kdUkv6orOSFPV/LX9/CGOlhBidFyak6g0MzrMnKMX/5VGpxhz4+HEFaofntaKa2ZQki/YiapjdpgzxUjL0EIFx+0rWGfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XbIE9m3L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92931F000E9;
	Tue, 16 Jun 2026 13:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781617342;
	bh=oN+0E2Rjlm3CCS859ehWVQ4Ska16Q6Sa9rLFmIDGXKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XbIE9m3LctY6JxcCuz5QCuJIlNBJrXg9dobkvsDojalJozDbhK7zwyAnuKSaKmWAX
	 IE1iKVO+F5zA1AjX+J+xj71H+Uh62SJeyNPS38RDZTZVFqTiFfgn5x+8EA7PKTSLPp
	 EhHmkpw/Iu+BqKRhxGvIQbks7dnU+dsSTMeVq+XA=
Date: Tue, 16 Jun 2026 19:11:16 +0530
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <benh@debian.org>
Cc: Sasha Levin <sashal@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Nikolay Borisov <nik.borisov@suse.com>, stable@vger.kernel.org
Subject: Re: [6.6] x86/CPU/AMD: Move the Zen3 BTC_NO detection to the Zen3
 init function
Message-ID: <2026061610-mustard-marmalade-4319@gregkh>
References: <ahhd83m8AruYGvOc@decadent.org.uk>
 <1d128ddf72c7c42d47e1348b9dc74f7f829621fd.camel@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d128ddf72c7c42d47e1348b9dc74f7f829621fd.camel@debian.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:benh@debian.org,m:sashal@kernel.org,m:bp@alien8.de,m:nik.borisov@suse.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263747-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC3686900EB

On Thu, May 28, 2026 at 05:35:50PM +0200, Ben Hutchings wrote:
> For 6.6, please cherry-pick commit affc66cb96f8 "x86/CPU/AMD: Move the
> Zen3 BTC_NO detection to the Zen3 init function" as stable dependency of
> commit 0da91912fc15 ("x86/CPU/AMD: Move erratum 1076 fix into the Zen1
> init function").  This seems to be applicable without changes.

Now applied.

> It seems like 6.6 should also get backports of:
> 
> cfbf4f992bfc x86/CPU/AMD: Call the spectral chicken in the Zen2 init function
> 7c81ad8e8bc2 x86/CPU/AMD: Rename init_amd_zn() to init_amd_zen_common()
> 
> which have already been applied to the older branches.  But these don't
> apply cleanly.

I've applied them now, thanks.

greg k-h

