Return-Path: <stable+bounces-219831-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNo9FBBsoGk3jgQAu9opvQ
	(envelope-from <stable+bounces-219831-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 16:51:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3841A91EF
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 16:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E20E13003D16
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955EA40FDA2;
	Thu, 26 Feb 2026 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOAcMRlZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B432425CED;
	Thu, 26 Feb 2026 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121097; cv=none; b=f5lzaKlWp6ws0xQ+JR2HaORuIoEfw/Jdka3lT73NSBuonMn7G5KMQ521y93NVw4XXmy69Z7tfSlKtgGpe9BzdHa8he3GriLfzeqEGuRfNWsWYCWUSNnQwDIKWLCK2WOgpGmYmr463VuCkuxnbis9c0ROiTLgmuScZ7KBp0KHmS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121097; c=relaxed/simple;
	bh=3THBpMzB78GLEKZ0Zo3teu1wR2OWupOfhAzrlRp0CiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLJQFDUWhRAU9ZvPJ6CLlRVahK/J7yuCApf69+ZeoyT3ZuGjdIsNvJutUg59jTC9INZ3D9tcNq8UA1lA2iiWDR7LVqbCBWzY0cBerKqy3rEa/J8vL4D2clbmYSnB3LHa/1iuBdiXfU4EiV5HWgYqUYko0RMGxOilCsbwJD/IzC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOAcMRlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40DFC19423;
	Thu, 26 Feb 2026 15:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121097;
	bh=3THBpMzB78GLEKZ0Zo3teu1wR2OWupOfhAzrlRp0CiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JOAcMRlZ7G++HFqAwfVI4DC4CXFU6bympWmzuxC/Hr/IE+nNSQ6QN4nmxofmbOvAw
	 B+E2kKSc57DU+umbJ+AZP9gQZCw3WakBojoYOGTJe6GaABN9txwsot6HLoi3LWy9ip
	 gvoJhUKrsg/muBptOUuGwspqmVFXPtOJXtFCs3w8tlHdH87PbI1rNNYgB6YdglGZT4
	 8GC4bsnPEGS/InHQ5AVk7Q9wbv1lqMhR5Jn9Hct94DWR7BGt0kEJfURofClWKQtjnQ
	 /sSgkhQLViDQpL/QdQ9SJbEXd53mAKhkE1EeVAgOTnHLjfXTi3rea+oTrZ6fE2IP4d
	 HZrjwlyLr4fwA==
Date: Thu, 26 Feb 2026 16:51:31 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, David Rheinsberg <david@readahead.eu>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: uhid: Fix out-of-bounds write caused by raw
 events mismanagement
Message-ID: <aaBqruhB0a7m0SBG@plouf>
References: <20260211164025.171242-1-lee@kernel.org>
 <aZmsTQeeGf26FqvY@plouf>
 <172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet>
 <47ro00po-r74n-870q-q178-67s8rpsss12q@xreary.bet>
 <aZ3IKiL91Ya7_iIM@plouf>
 <r6574n79-563r-9rrp-0n92-784532r67o63@xreary.bet>
 <20260226111816.GA8023@google.com>
 <aaA6fioiB9_aiBrA@plouf>
 <20260226140810.GD8023@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226140810.GD8023@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219831-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bentiss@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B3841A91EF
X-Rspamd-Action: no action

On Feb 26 2026, Lee Jones wrote:
> On Thu, 26 Feb 2026, Benjamin Tissoires wrote:
> 
> > On Feb 26 2026, Lee Jones wrote:
> > > On Tue, 24 Feb 2026, Jiri Kosina wrote:
> > > 
> > > > On Tue, 24 Feb 2026, Benjamin Tissoires wrote:
> > > > 
> > > > > Long story short: that patch is too intrusive as it makes assumption on
> > > > > the behavior of the device. We need to understand where/if the bug was
> > > > > spotted and fix the caller of hid_hw_raw_request, not the uhid
> > > > > implementation.
> > > > 
> > > > Thanks a lot for the analysis, Benjamin!
> > > > 
> > > > I asked about that here:
> > > > 
> > > > 	https://lore.kernel.org/all/172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet/
> > > > 
> > > > So let's wait for Lee to clarify. Until that, the patch stays out of the 
> > > > branch.
> > > 
> > > Thanks to both of you for looking into this.  I appreciate your efforts.
> > > 
> > > This is very much real world.
> > > 
> > > Is there a way to add an errata for the PS3 controller?
> > > 
> > 
> > Unfortunatelly no. uhid merely emulates what a device can do, and HID is
> > a convention. So if we were to have a special case to PS3 controllers,
> > we would then start having to maintain an endless list of quirks when
> > the issue is *not* in uhid, but in the processing of the device after
> > (maybe in hid-core?).
> 
> Actually I think the issue is in UHID.  At least the way I read it.

And I disagree :)

> 
> Are there legitimate use-cases for devices overwriting the Report ID
> contained in the first index of the data buffer?  From my very limited
> knowledge of the subsystem, this sounds like an oversight.
> 

Legitimate, probably no, but we are talking about physical devices
here. uhid is a mere replacement of a transport layer, and there is
nothing that prevents a device to reply with a buffer starting with 1
when requested about feature 2 (because it's firmware and they just
don't care).

This happens a lot with proprietary features on devices, when there is
no spec, so ODM provide their own driver and they can do whatever they
want.

If uhid or any transport layer solely takes the decision that a reply to
a request is wrong, we have no chance of fixing it after the fact. This
is what happens with the PS3 controller: an undocumented feature is
used, but that's what the Playstation does, so we need to tag along.

I hope it makes more sense now.

FTR, Lee shared the logs of the issue privately, and I already told him
where we should fix the issue.

Cheers,
Benjamin

