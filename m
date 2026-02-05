Return-Path: <stable+bounces-214475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKrkGKeqhGk14QMAu9opvQ
	(envelope-from <stable+bounces-214475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:35:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 843BFF4150
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD538300845C
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 14:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E63A3F0741;
	Thu,  5 Feb 2026 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xwek//D5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228783EF0B0;
	Thu,  5 Feb 2026 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301952; cv=none; b=bHBPMCzrSNCt476R5bcN2E42dSAOXxiWnSGa8jvsFkfXaVC47qZaC1k7KEgEW0heI3Fm9ROSxJbuEWCxGtjGJZ+09Mlx2kXjz+kZ5N/cPNxu7bBqnwVAk+cncNABSdHIv+DN18/OzkmtI2I8IHPXOztMDcfbCaq+EihtsKHjjx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301952; c=relaxed/simple;
	bh=7qx17il4RHXDWXxc5LrH10qSwUPlfC+1HS9jltXeTCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1Jjqw86195btEDo4eTi8izcFAZWLovyCwx9j2W67k02p1Hz6wEMX9gRwQHOiXbV/oiY9n2w70aIp1wqgTNGQM0+croqwo/Jd+OMknApSg6+phbmVAVJ5hHOcz9ncpPkTKK1l+EEFDQ43GdbVb8TwIbk+a8+hyfD6rnYjNrFHHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xwek//D5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7C9C4CEF7;
	Thu,  5 Feb 2026 14:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770301951;
	bh=7qx17il4RHXDWXxc5LrH10qSwUPlfC+1HS9jltXeTCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xwek//D56D38T1ytuo1c5YajeF8KO3jyY4yLCtlWrTsnEM8qoLxdp4YCTYWGtOeFv
	 xrjyhv8RciqeDWlrd4OclibdSj9q7S3x64Pxja/YQLl2nY4EfwrUBehE2ZA37UE1hp
	 6Cxjw+SHn9WE/myHkOj8d5ZuzhX6gqr1vRsX7cbE=
Date: Thu, 5 Feb 2026 15:32:28 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 5.10 022/161] phy: rockchip: inno-usb2: fix communication
 disruption in gadget mode
Message-ID: <2026020521-mullets-amino-063c@gregkh>
References: <20260204143851.755002596@linuxfoundation.org>
 <20260204143852.563376077@linuxfoundation.org>
 <5cee4d2e571b3132a95cca6f6230c769b8618836.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cee4d2e571b3132a95cca6f6230c769b8618836.camel@decadent.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214475-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 843BFF4150
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 03:09:39PM +0100, Ben Hutchings wrote:
> On Wed, 2026-02-04 at 15:38 +0100, Greg Kroah-Hartman wrote:
> > 5.10-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > 
> > commit 7d8f725b79e35fa47e42c88716aad8711e1168d8 upstream.
> [...]
> 
> This one and the next one (phy-rockchip-inno-usb2-fix-communication-
> disruption-in-gadget-mode.patch and phy-rockchip-inno-usb2-fix-
> disconnection-in-gadget-mode.patch) have been swapped from their
> original order in mainline.  Please swap them back to avoid a potential
> build failure during bisection.

Now fixed up, thanks!

greg k-h

