Return-Path: <stable+bounces-245587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAQ+EYsvA2qN1QEAu9opvQ
	(envelope-from <stable+bounces-245587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:47:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FE7521998
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D70E30C77EC
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C317B394EA8;
	Tue, 12 May 2026 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HV0HDhN+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A373E1731;
	Tue, 12 May 2026 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592546; cv=none; b=tu3cHrWfy/PsVpaB5R8ZnZPSMvux0RPPhuYvQah4KFRQrtbtNxHZMmLOEYE/BA9KRL3uNp2SsOeoSCIu7ylqhR1DIyNayE5GkX0yzz882moQJ3oGsWufl/+g7xaKLXTLREK7VgBqdl1xP0KiqrjpSLhtqAcSTbe3CvpIAmTZo0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592546; c=relaxed/simple;
	bh=/KFyDVeF8btGlxsC55m72RhQvj30DyASU4WnIuUh2Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAg4jiq5tU7AqTEXPc/SPYz/G0DfXfUS1ZjoFXBfgHXmWQAzUwq3C37BKgllkm8STEsbdMgW6L36lkb/A6wcA4nWQZgNPoVGe+hhQyzboKYr7aeQbddzi2oMDncXtLl6JQvkGQrABn4QJhW4F3xRW8y1dODm4MZ+VDG+8ySa3Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HV0HDhN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C38C2BCB0;
	Tue, 12 May 2026 13:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778592546;
	bh=/KFyDVeF8btGlxsC55m72RhQvj30DyASU4WnIuUh2Vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HV0HDhN+xFaDAKr/bHb8y1ee2uG+xCyEfpl5ThQDlTn7MuYYS1vBq9rWAOMLO2fOW
	 9SyHqlwCT3JzMydKAO1ushyiUWKU0jGgqCud3PJ89mhWgXolho626atu3SgdVzBC+U
	 UPSDk8R0rwqK8SZguSv78bNEjkmI3iMPEnBThPjo=
Date: Tue, 12 May 2026 15:29:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sebastian EM <mendozayt13@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: composite: fix integer underflow in WebUSB
 GET_URL handling
Message-ID: <2026051245-kangaroo-matriarch-8eed@gregkh>
References: <20260512014343.3770664-1-mendozayt13@gmail.com>
 <2026051221-glory-macaroni-dce6@gregkh>
 <CAD89HyBhwxDsat_JCFFfA-tUYVatxByDj=ikpc9Rxj=kAqn=Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD89HyBhwxDsat_JCFFfA-tUYVatxByDj=ikpc9Rxj=kAqn=Sw@mail.gmail.com>
X-Rspamd-Queue-Id: 42FE7521998
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245587-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 06:18:54AM -0500, Sebastian EM wrote:
> Hi Greg,
> 
> Thanks for the review.
> 
> You are right; the self Reported-by tag does not belong there, so I dropped
> it in v2.
> 
> The introducing commit is:
> 
> 93c473948c58 ("usb: gadget: add WebUSB landing page support")
> 
> I also added:
> 
> Cc: stable@vger.kernel.org
> 
> since the issue was introduced with the WebUSB GET_URL handling path and
> the fix is a small bounds/underflow fix suitable for stable kernels.
> 
> v2 is attached as a plain patch:
> 
> 0001-v2-usb-gadget-composite-fix-integer-underflow-in-WebUSB-GET_URL-handling.patch

We can't take patches as attachments, just send this as a normal v2
patch.

thanks,

greg k-h

