Return-Path: <stable+bounces-214504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGbkFWbAhGnG4wMAu9opvQ
	(envelope-from <stable+bounces-214504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 17:08:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2518AF4F92
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 17:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23DFC3004608
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 16:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C28436363;
	Thu,  5 Feb 2026 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GA5Fc7GE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB28643635E;
	Thu,  5 Feb 2026 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307677; cv=none; b=NHCjssYmLW3RW0yKT1FyBqWesrgXHXeUuak6Z45QssRr2TG+Xz42vfet8N/5w8eK43FC87B7ZEGR3RcFqvgV0hSqC7/Bzt5Fnuq4gbmqRHM3K3khOrzcHjx1sXVVOlOMRs3paQpJMCdp2bEYI4LFVNGGa16vj3rWOjWGKfcQaCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307677; c=relaxed/simple;
	bh=d86prwuHqoR9J6hWCY8eBcWS+BLmCXKsMlupX2UjubY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIu7XUH76rE6RIM0btBdesR55oeq/nMqsKSLsnnW0ivxZGNZxEKGZGniCZ8xep5v6hPCSgEypNsnDE21WcgEl0qEpCXoPhVC7U75mD0IsE3AAJSay2d269Nl3OJlLiv1PehopcxfrI1iIeGOfdE+1EwJsdiHeqWx5Qz743ZPFyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GA5Fc7GE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF6FC116D0;
	Thu,  5 Feb 2026 16:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770307676;
	bh=d86prwuHqoR9J6hWCY8eBcWS+BLmCXKsMlupX2UjubY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GA5Fc7GERpOJiWO+UDCW6g/zdkl0QjBpZZZcfoyZb38vVCO4ruVvnU+u8bpBZSNpP
	 1OUiBVZh9TI3y4O8qjBrh9AKn9vMivFP9eqdmFHBOitsPW+0Quc+bauy8bfH4HhiBP
	 GKQbVUgx9ws9oY3//ZpkTJsljOVl0gUspBtf8B7A=
Date: Thu, 5 Feb 2026 17:07:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH] mux: mmio: fix regmap leak on probe failure
Message-ID: <2026020547-primp-dominion-cbc3@gregkh>
References: <20251127134702.1915-1-johan@kernel.org>
 <aXjgH6RCFq8y97-3@hovoldconsulting.com>
 <aYNxOL6vqCm_UL0V@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYNxOL6vqCm_UL0V@hovoldconsulting.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214504-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ti.com:email]
X-Rspamd-Queue-Id: 2518AF4F92
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 05:18:00PM +0100, Johan Hovold wrote:
> Hi Greg and Peter,
> 
> On Tue, Jan 27, 2026 at 04:56:15PM +0100, Johan Hovold wrote:
> > On Thu, Nov 27, 2025 at 02:47:02PM +0100, Johan Hovold wrote:
> > > The mmio regmap that may be allocated during probe is never freed.
> > > 
> > > Switch to using the device managed allocator so that the regmap is
> > > released on probe failures (e.g. probe deferral) and on driver unbind.
> > > 
> > > Fixes: 61de83fd8256 ("mux: mmio: Do not use syscon helper to build regmap")
> > > Cc: stable@vger.kernel.org	# 6.16
> > > Cc: Andrew Davis <afd@ti.com>
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > ---
> > 
> > Can this one be picked up for 6.20?
> 
> This one has been sitting on the list for over two months now without
> any comment from Peter.
> 
> I know there have been some issues in the past which patches for this
> subsystem not being picked up, so perhaps you could just take this one
> directly, Greg?
> 
> It's been reviewed by Andrew.
> 
> Johan

Now taken, thanks.,

greg k-h

