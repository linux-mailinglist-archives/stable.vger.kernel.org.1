Return-Path: <stable+bounces-216835-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFQpFCx3lGlmEAIAu9opvQ
	(envelope-from <stable+bounces-216835-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:11:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ECC14D0AD
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F97B30580BE
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F85736C0B9;
	Tue, 17 Feb 2026 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bUhUPeWf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5749C338581;
	Tue, 17 Feb 2026 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771337418; cv=none; b=XnLPIlS7ylbGCP8EQIcgMJG0aOwCUxNDxHq8LT0fv0nn4NiYyrj5XVwyQPFDigY1/+FXjcrF2b7mkbv34yrcWhRXhwcIkYDIDtct2mkf0arkoH3+HAFDm5uchNRIlfxBYaAUFp4hrKTUwly9Vvj5RDuUbb8RDXcWOXgoaMWp5nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771337418; c=relaxed/simple;
	bh=vn1t/wW3tD+nyVk4FWbkz8/fkTB6j0/+tsYguCyWDPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnWb5IATM9W64fP3lJR7iu9vU9oOonehlPzTQpPVi9qj6KBRwRPfQpI+QrnmqPlzuNkzLuetvDVgXO3Qc5j+mMB9Ah+9prGLskcP6Fx1jAEga0/12QLYIM6l5Gpu8yjS3t0bBpxqnwnvLUcNxWPmoGnJfwlBngIFPLraNK94hy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bUhUPeWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E285C4CEF7;
	Tue, 17 Feb 2026 14:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771337418;
	bh=vn1t/wW3tD+nyVk4FWbkz8/fkTB6j0/+tsYguCyWDPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bUhUPeWfcoazn+gG7u/46Cx60IQd8Ndc8wZOE7vyOEXNFQlyt9HmKEPCBP4zGic83
	 gDekwlaVWrc/a51rLZ9/dEEpt+A5vumbLBVydwJNp6wL8z+YjViqM1BNn79/D/W6Yd
	 BVlhl8pBskar4Bm3icvXcz8UoR9jERVaw+0WuZS4=
Date: Tue, 17 Feb 2026 15:10:14 +0100
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
Message-ID: <2026021718-citrus-parakeet-dc60@gregkh>
References: <20260217133411.2881311-1-ryan.roberts@arm.com>
 <2026021700-chafe-jurist-cb24@gregkh>
 <17c9efaf-6c33-4485-bde2-345cc15ac000@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17c9efaf-6c33-4485-bde2-345cc15ac000@arm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216835-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: A6ECC14D0AD
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 01:58:36PM +0000, Ryan Roberts wrote:
> On 17/02/2026 13:50, Greg KH wrote:
> > On Tue, Feb 17, 2026 at 01:34:05PM +0000, Ryan Roberts wrote:
> >> Hi All,
> >>
> >> This series is a backport that applies to stable kernel 6.6 (base v6.6.126), for
> >> some speed ups to enable significantly faster booting on systems with a lot of
> >> memory. The patches were originally posted at:
> >>
> >>   https://lore.kernel.org/linux-arm-kernel/20240412131908.433043-1-ryan.roberts@arm.com/
> >>
> >> ... and were originally merged upstream in v6.10-rc1.
> >>
> >> I'm requesting this be merged to stable on behalf of a partner who wants to get
> >> the benefit of this series in Debian 12.
> > 
> > Why can't they just use a newer kernel version (i.e. 6.12)?  Surely they
> > would be able to justify moving to a newer kernel for performance
> > reasons, why enable them to stay on an older one, just delaying the
> > inevitable upgrade they will have to do anyway in a year or so?
> 
> I can't answer this presicely, but I did ask and push for that approach. As I
> understand it, they are stuck with Debian 12, which is stuck with kernel 6.1.
> The Debian maintainer apparently requested that these go through stable in order
> to get them into Debian 12.

I understand the position of Debian not wanting to take patches for new
features that are not already upstream, but really, Debian offers a
newer kernel for hardware that wants to use it for things like this,
right?  Why not just use that instead?

thanks,

greg k-h

