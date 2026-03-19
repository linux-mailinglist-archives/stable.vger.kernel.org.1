Return-Path: <stable+bounces-227304-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IzrzNY4AvGnqrAIAu9opvQ
	(envelope-from <stable+bounces-227304-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:56:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E002CC44F
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99CDC31B90F8
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC393B893A;
	Thu, 19 Mar 2026 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IIsUezRh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B0C3B6377;
	Thu, 19 Mar 2026 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928493; cv=none; b=gDp0CTyiyg+hiq2pylIVQCe7p/X/B2bP5qMG6IhWVw4msOG6hPaFcJJv4PMVfYPRZy84s8yyYUqm6R6+4ByB3ww2tPDVnNJpNdkZKPaf40Jwdc575dsVm3I86Fmo0ouv4SE7H3v277Ha0SoPj1t3SN9duSKIj66p8zJlbubq/FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928493; c=relaxed/simple;
	bh=6lTDuDTet2Kh2hHL2W19L/RTuSwbVdiJ3pKzj7JqvFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lteh1NKzMgw9g2TdgdfSkLcDpLZQLFb7a+uNDozQsfa1DXJFky7idROgDNnRzbdVeHKEpqQj3fe1RvKypxFcDZro1Wd7ZeTC8i2wqQORsmKMO3vHPc9sIOjVLLjEJek3GXRU/T6FE1+YRHN5en1ZKAkCIwOLgHn263Gpvou2IKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IIsUezRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B35C2BCB0;
	Thu, 19 Mar 2026 13:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773928492;
	bh=6lTDuDTet2Kh2hHL2W19L/RTuSwbVdiJ3pKzj7JqvFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IIsUezRhwWh1BsXMNOJ67yiJdcGBaUlTKxxOylNOTzzVPX5If51Fyl1Q45iNKlID+
	 IRhJzrCjbQdEi7iEc6pUVS7I3hMBr6lVPqk92iS65c4xksOiAHuQ2IX8pXJIsAsVEQ
	 SchRwP5nXQB6bLzrS3p0vJvDDcY0y+u92y0FhVOc=
Date: Thu, 19 Mar 2026 14:54:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jack Aboutboul <jaboutboul@microsoft.com>,
	Sharath George John <sgeorgejohn@microsoft.com>,
	Noah Meyerhans <nmeyerhans@microsoft.com>,
	Jim Perrin <Jim.Perrin@microsoft.com>
Subject: Re: [PATCH 6.1 0/3]  arm64: Speed up boot with faster linear map
 creation
Message-ID: <2026031906-mulled-bully-10f6@gregkh>
References: <20260217133527.2881603-1-ryan.roberts@arm.com>
 <2026021717-stellar-skylight-7824@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026021717-stellar-skylight-7824@gregkh>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-227304-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.957];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 42E002CC44F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Feb 17, 2026 at 02:50:28PM +0100, Greg KH wrote:
> On Tue, Feb 17, 2026 at 01:35:21PM +0000, Ryan Roberts wrote:
> > Hi All,
> > 
> > This series is a backport that applies to stable kernel 6.1 (base v6.1.163), for
> > some speed ups to enable significantly faster booting on systems with a lot of
> > memory. The patches were originally posted at:
> > 
> >   https://lore.kernel.org/linux-arm-kernel/20240412131908.433043-1-ryan.roberts@arm.com/
> > 
> > ... and were originally merged upstream in v6.10-rc1.
> > 
> > I'm requesting this be merged to stable on behalf of a partner who wants to get
> > the benefit of this series in Debian 12.
> 
> Same here, why not just use 6.12.y?

Ok, I'll take the 6.6.y patches, but for 6.1.y, people should _REALLY_
move off of it if they are using these types of systems as there are
loads of other things/fixes that they will get if they move.

thanks,

greg k-h

