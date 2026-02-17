Return-Path: <stable+bounces-216841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAyWB5J6lGkfFAIAu9opvQ
	(envelope-from <stable+bounces-216841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:26:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9460714D221
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2CCB300FB5D
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2E736BCCD;
	Tue, 17 Feb 2026 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uw4lkXZd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC42036B066;
	Tue, 17 Feb 2026 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338376; cv=none; b=NZgoAiGN+maIY14PgZS2bj8MbXEzzJjap2HHuhFTtpgkekmddgrJdQFfRLhg9ASbJinxFQKNcZrR0OeraoYS4t/0oVlw8qCUOC9p7yvjWs6HWg9bBCZxtQ9H1yS93/XlTQpn4WrhCUapkaFU4SrcRf2NBP/cgX8/EOQpkyBHjTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338376; c=relaxed/simple;
	bh=VehWWkmgu07iCydxagS32dNxJbtfdPA16Ye7cVaDBKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH3cTGJpVRbMZJTEOKC9R/oGDX+82DQC5oCIDlOYMnohA7iG2Ojp0OmFh1GpwjO+ugvoJIYMZ7Wv3a445j6STTyJha/MKJ4JW/Hrw3PaxZG6z25gbf15nSEpROrAx7L/E3G8K8kReoFXqR7iDLs8U4BYzJQK6iZyOhHEbBZ6CjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uw4lkXZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FC7C4CEF7;
	Tue, 17 Feb 2026 14:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771338375;
	bh=VehWWkmgu07iCydxagS32dNxJbtfdPA16Ye7cVaDBKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uw4lkXZdkllu/Jx7rdQ4TjmCxsefwBeoysvMRmAN/sKwTZ/l8GtrvPZWe4Ct+u0Sk
	 6JG2UtED1mEXuRRw/VmTNIYOLqHQK75G9CiwpTIVsuoR6lHgwTq4WMQeDGdpPXfU9e
	 r9LA+9AWRQPjr5nruVXggcz5msiMTQI5kK63BQI0=
Date: Tue, 17 Feb 2026 15:26:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jack Aboutboul <jaboutboul@microsoft.com>,
	Sharath George John <sgeorgejohn@microsoft.com>,
	Noah Meyerhans <nmeyerhans@microsoft.com>,
	Jim Perrin <Jim.Perrin@microsoft.com>
Subject: Re: [PATCH 6.6 0/3] arm64: Speed up boot with faster linear map
 creation
Message-ID: <2026021758-subsidy-tinfoil-ee2c@gregkh>
References: <20260217133411.2881311-1-ryan.roberts@arm.com>
 <2026021700-chafe-jurist-cb24@gregkh>
 <17c9efaf-6c33-4485-bde2-345cc15ac000@arm.com>
 <2026021718-citrus-parakeet-dc60@gregkh>
 <7f30a8e4-49c3-421d-be05-08afb544aa41@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f30a8e4-49c3-421d-be05-08afb544aa41@arm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216841-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9460714D221
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 02:21:30PM +0000, Ryan Roberts wrote:
> On 17/02/2026 14:10, Greg KH wrote:
> > On Tue, Feb 17, 2026 at 01:58:36PM +0000, Ryan Roberts wrote:
> >> On 17/02/2026 13:50, Greg KH wrote:
> >>> On Tue, Feb 17, 2026 at 01:34:05PM +0000, Ryan Roberts wrote:
> >>>> Hi All,
> >>>>
> >>>> This series is a backport that applies to stable kernel 6.6 (base v6.6.126), for
> >>>> some speed ups to enable significantly faster booting on systems with a lot of
> >>>> memory. The patches were originally posted at:
> >>>>
> >>>>   https://lore.kernel.org/linux-arm-kernel/20240412131908.433043-1-ryan.roberts@arm.com/
> >>>>
> >>>> ... and were originally merged upstream in v6.10-rc1.
> >>>>
> >>>> I'm requesting this be merged to stable on behalf of a partner who wants to get
> >>>> the benefit of this series in Debian 12.
> >>>
> >>> Why can't they just use a newer kernel version (i.e. 6.12)?  Surely they
> >>> would be able to justify moving to a newer kernel for performance
> >>> reasons, why enable them to stay on an older one, just delaying the
> >>> inevitable upgrade they will have to do anyway in a year or so?
> >>
> >> I can't answer this presicely, but I did ask and push for that approach. As I
> >> understand it, they are stuck with Debian 12, which is stuck with kernel 6.1.
> >> The Debian maintainer apparently requested that these go through stable in order
> >> to get them into Debian 12.
> > 
> > I understand the position of Debian not wanting to take patches for new
> > features that are not already upstream, but really, Debian offers a
> > newer kernel for hardware that wants to use it for things like this,
> > right?  Why not just use that instead?
> 
> Let me go push a bit harder. But I expect we are in the grey zone between bug
> and feature here; this is a performance bug fix, not a new feature. By
> selectively backporting I'm guessing they are avoiding the risk of new features
> that a new kernel brings introducing new bugs? I'm guessing there is a higher
> qualification bar for that.

That's a broken "qualification system" if that is the case, given that
the patches that flow back into stable kernel releases should be
triggering "full qualification" if anyone actually paid attention to
what goes into there :)

Anyway, good luck!  And same for 6.1.y, if they are ok with 6.6.y, why
would they even care about 6.1.y?

thanks,

greg k-h

