Return-Path: <stable+bounces-219799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAakMBc7oGmagwQAu9opvQ
	(envelope-from <stable+bounces-219799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 13:22:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 370131A5A5F
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 13:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECFCF3069DDB
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 12:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2290B283159;
	Thu, 26 Feb 2026 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DS/rZe74"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D855C261B70;
	Thu, 26 Feb 2026 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772108561; cv=none; b=iKyf1RdvQ39ntjPSfWUs4Z95B8w+4xk8RtUQwmFqsAPrP5a/aguKgyhiroFqYfjoX0bNR5I0aq9/KLnDfAgf3gs1d4OeJrTVeBAL5crgX837le8mnYLvu0bT2ID52nCKqKOJrIEa322af8UECidqF2nSIOiRIVvdM/oQkC1d6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772108561; c=relaxed/simple;
	bh=pDUQ3U6u0AZuQaoY38Nd1cd4YlhwPhZcnTqYdko34JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNB66dIPsakHH3BpF2yo/GoS8ijsfj8b1wdKZ+7Qj2fYRM2ubp7stgvqEAz7PLhoSG4izWsqgdCTLnqKKzucVlE38WSqDZsPdv5c3e7xRDaoQojwzfWXKv/5opr7cc9LxrrgGRDLmKfaK8lwXCCAdD3i3KiAtDgdhzwU655EZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DS/rZe74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CFBC19423;
	Thu, 26 Feb 2026 12:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772108561;
	bh=pDUQ3U6u0AZuQaoY38Nd1cd4YlhwPhZcnTqYdko34JY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DS/rZe74nTK2sp+eRtG3gH6PgJCBD+6pREJb6cUfNrmEGz6NVlzNMzz/KkDUqqBsQ
	 m8MhOxTAGR9AfLcopMURyf3MHNggcmBVaEXLPVk/C79LJ/+RYlQfOTDHc6OtE01HOq
	 JU0rC/VzNlZ01sTPZokTPc/r3FeaWZ3SkobJBp4IjY6AidGn10ZmX/BIh6ag3dX555
	 SesML7a/5YdRUbWTFdC+UwFFJiNhHwbxJW2OwyENc2ARuEloGW8qgnFeNJLoOElSQl
	 +RQPd/DJJT5Ur6/gcdFisX1MJFeJXEju+JcN+8ct3oCA+55+bT5VWnuMxkTzL5YhGL
	 aqXrky7xd+kKA==
Date: Thu, 26 Feb 2026 13:22:37 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, David Rheinsberg <david@readahead.eu>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: uhid: Fix out-of-bounds write caused by raw
 events mismanagement
Message-ID: <aaA6fioiB9_aiBrA@plouf>
References: <20260211164025.171242-1-lee@kernel.org>
 <aZmsTQeeGf26FqvY@plouf>
 <172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet>
 <47ro00po-r74n-870q-q178-67s8rpsss12q@xreary.bet>
 <aZ3IKiL91Ya7_iIM@plouf>
 <r6574n79-563r-9rrp-0n92-784532r67o63@xreary.bet>
 <20260226111816.GA8023@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226111816.GA8023@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219799-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bentiss@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 370131A5A5F
X-Rspamd-Action: no action

On Feb 26 2026, Lee Jones wrote:
> On Tue, 24 Feb 2026, Jiri Kosina wrote:
> 
> > On Tue, 24 Feb 2026, Benjamin Tissoires wrote:
> > 
> > > Long story short: that patch is too intrusive as it makes assumption on
> > > the behavior of the device. We need to understand where/if the bug was
> > > spotted and fix the caller of hid_hw_raw_request, not the uhid
> > > implementation.
> > 
> > Thanks a lot for the analysis, Benjamin!
> > 
> > I asked about that here:
> > 
> > 	https://lore.kernel.org/all/172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet/
> > 
> > So let's wait for Lee to clarify. Until that, the patch stays out of the 
> > branch.
> 
> Thanks to both of you for looking into this.  I appreciate your efforts.
> 
> This is very much real world.
> 
> Is there a way to add an errata for the PS3 controller?
> 

Unfortunatelly no. uhid merely emulates what a device can do, and HID is
a convention. So if we were to have a special case to PS3 controllers,
we would then start having to maintain an endless list of quirks when
the issue is *not* in uhid, but in the processing of the device after
(maybe in hid-core?).

Cheers,
Benjamin

