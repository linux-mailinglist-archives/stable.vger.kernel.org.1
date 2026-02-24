Return-Path: <stable+bounces-217923-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJuhDuHKnWmxSAQAu9opvQ
	(envelope-from <stable+bounces-217923-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 16:59:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFA5189773
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 16:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CBA2302A51A
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 15:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547A43A6410;
	Tue, 24 Feb 2026 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtyB6uoZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1571B3A640C;
	Tue, 24 Feb 2026 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771948642; cv=none; b=sYzqvR2xN6BlMIaTFsUxI0GmFDxdTAC8lHqsNMS0GmCw6Ch7oIqF2BhixqQqRBbVHAYKkn0rrmqGQXER/5PBXsF0FP0eMmUPb3qN4FGaH/NzaSalpPsnLxQTWmTqBXQyPa6v5mVMMJXxYgmXzSV3aP9X1fp7t+ARmsRurZmaIrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771948642; c=relaxed/simple;
	bh=9jsAK4p7Db0iITnevDW9lC9VIs/vOIDx/B0jZPgFxFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eafijRNF7VKb9uPK08U8grozclPY/o3rkfckz5bOKfEg9fTvd9rmzP/oracqH+5dEpMExDSNsWeYV+4krty8u//MsQujnRRMxCB3U0J5HD+xn+X0+/nENVQYKD3/03l1Wy0ttMTZKCENvo397KSQRmOmiQh+Af9Gk8vfTIglRIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtyB6uoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0F7C116D0;
	Tue, 24 Feb 2026 15:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771948641;
	bh=9jsAK4p7Db0iITnevDW9lC9VIs/vOIDx/B0jZPgFxFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtyB6uoZ0WZVMxqIYY4brkjq9P3/s1434J8fDoahfagYKPmFnfjyTNK8V7JIkCvm7
	 GrqFZaNhybysEOHrC8BZlwJpnpHMaN81v5xVEmCtnJMQaHEK/H6YwjGweZy/TeOkdP
	 bR1RwOMSBQZtjULkehbAi3pSjmHNIxa7ql93ndaaFrhi2KTqyoBQlQwg5sXH0dtSoP
	 cOrrM9IlrzvRdK9PW04KWjdA5ws+RDimBvrvayH60uxppnz5xOxf+O+yYwuTR8Lj+6
	 7FiGjvyS0J/nEcvn3XNO0r2G36Ieb4stNq7k1fKEQITBwUGgNUHjjk1w7TGHnP82OY
	 WLp1pwSqWozBw==
Date: Tue, 24 Feb 2026 16:57:17 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Lee Jones <lee@kernel.org>, David Rheinsberg <david@readahead.eu>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: uhid: Fix out-of-bounds write caused by raw
 events mismanagement
Message-ID: <aZ3IKiL91Ya7_iIM@plouf>
References: <20260211164025.171242-1-lee@kernel.org>
 <aZmsTQeeGf26FqvY@plouf>
 <172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet>
 <47ro00po-r74n-870q-q178-67s8rpsss12q@xreary.bet>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47ro00po-r74n-870q-q178-67s8rpsss12q@xreary.bet>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217923-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 8BFA5189773
X-Rspamd-Action: no action

On Feb 24 2026, Jiri Kosina wrote:
> On Sat, 21 Feb 2026, Jiri Kosina wrote:
> 
> > > > Since the report ID is located within the data buffer, overwriting it
> > > > would mean that any subsequent matching could cause a disparity in
> > > > assumed allocated buffer size.  This in turn could trivially result in
> > > > an out-of-bounds condition.  To mitigate this issue, let's refuse to
> > > > overwrite a given report's data area if the ID in get_report_reply
> > > > doesn't match.
> > > 
> > > That's a strong assumption and a breakage of the userspace FWIW. The CI
> > > is now full of errors:
> > > https://gitlab.freedesktop.org/bentiss/hid/-/commits/for-7.0/upstream-fixes
> > > 
> > > It is pretty common to allocate the buffer and not initialize it in
> > > get_report operations.
> > > 
> > > It was a bad API choice to have rnum and data[0] for all HID requests
> > > (internally, externally), but we should stick to it. The CI breakage in
> > > itself is not a big issue TBH, but if it breaks here, it will probably
> > > break existing users.
> > 
> > Lee,
> > 
> > was this found via code inspection, fuzzing, or is there some real-world 
> > report behind it?
> 
> For now I've dropped this from for-7.0/upstream-fixes until it's all 
> clarified.
> 
> Thanks,
> 

So I've debugged today the error I was seeing. First, my statement is
slightly exagerated, because we are talking here about a get_report
function, and Lee's patch checks for the return buffer, not the incoming
buffer.

So I had a small time where I was wondering if I was not wrong and
something was off in the test suite.

However, it seems the bug is caused by the PS3 emulation:
https://gitlab.freedesktop.org/libevdev/hid-tools/-/blob/master/hidtools/device/sony_gamepad.py?ref_type=heads#L256-257

During the initialization of the PS3 controller, hid-sony.c calls
several GET_REPORT on 0xF2 and 0xF5. Both of these feature reports are
hidden in the report descriptor (a few lines above in the
sony_gamepad.py file). However, the emulation returns `[0x01, 0x00,
0x18, 0x5E, 0x0F, 0x71, 0xA4, 0xBB]` when we request a 0xf5 report,
which seems to be bogus.

So I digged out the PS3 controller from a drawer, and looked at the
incoming data from it.

And it turns out that the controller reply that exact sequence when
requested about the 0xf5 feature.

So that means that the emulation is correct, and we can have devices
which report a different report number. Arguably this is wrong, but we
are in the peripheral world where every vendor does what it wants :(

Long story short: that patch is too intrusive as it makes assumption on
the behavior of the device. We need to understand where/if the bug was
spotted and fix the caller of hid_hw_raw_request, not the uhid
implementation.

Cheers,
Benjamin

