Return-Path: <stable+bounces-227256-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Cx+F0jSu2k4owIAu9opvQ
	(envelope-from <stable+bounces-227256-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 11:39:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C242C9969
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 11:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0A3631FA735
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2FB352927;
	Thu, 19 Mar 2026 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dxjiojGN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7940436EA8F
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773916581; cv=none; b=lHpoe9bI4aUyZ/Qn0LXgMof71QS62cbqDVO1xxRUDS4OUkBbZIutm3hEePTuUDxviQOhpTgLQJYVKbizQxYExs5D1OsGUL2lRp1kx5/yHwBozPjTFwffB4IxIlypP8ydz2tx3pbm/ZN3vNh5zPcYVFQ/1WT9AI66Q5UsgUE5pVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773916581; c=relaxed/simple;
	bh=X4xJkvlPBmUqsz0of2YwC7FiKpHaPtMyG/Mrkg5h6B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8QJtlVpu46WSfoulT7Xu5iUMwGOmNcsMO3vGofyVUx94QbxyKLY6Q9C1mGFGUDZ78LxBkU+AWcccNms6XtVj1TMPa1hyWhSE50ZXTrpOSHVfPpYPN0zSR4YeWzIjA7qmPSIGdLd9OlPiY8i/lyDKK4uJvk8ce6r0i5XeSH5AQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dxjiojGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A32C2BCAF;
	Thu, 19 Mar 2026 10:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773916581;
	bh=X4xJkvlPBmUqsz0of2YwC7FiKpHaPtMyG/Mrkg5h6B4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dxjiojGNMl6tG7vh7MGzyHK3RTp8Sm61/Vs/1ll27C0J29GftNdb7lJvVq0D4O4AL
	 gh4VWc1GWN9b2Fr4oosGXuFBxxTOotc/5JbamukdcHU54QYG98bo4cUI7kVpqGZmor
	 V0aBf6hWKXqDXxpvznMuLT5rjV2bBZmfQUulMeSs=
Date: Thu, 19 Mar 2026 11:36:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: keenanat2000@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: check if target buffer
 list is still legacy on" failed to apply to 6.12-stable tree
Message-ID: <2026031911-threefold-animosity-cf26@gregkh>
References: <2026031700-vagrancy-doze-c356@gregkh>
 <4e1d07d8-73fe-41d2-a2a7-31f769f4503c@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e1d07d8-73fe-41d2-a2a7-31f769f4503c@kernel.dk>
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227256-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.517];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7C242C9969
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 06:59:37AM -0600, Jens Axboe wrote:
> On 3/17/26 6:55 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Here's a tested version for 6.12.
> 
> -- 

Now applied, thanks.

greg k-h

