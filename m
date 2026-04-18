Return-Path: <stable+bounces-238584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE0BO/Bs42m+GgEAu9opvQ
	(envelope-from <stable+bounces-238584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 13:37:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A15420FD2
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 13:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1A01302A2E9
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 11:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416BB346E64;
	Sat, 18 Apr 2026 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UBdWe1dE"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97552349B02
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776512227; cv=none; b=Gkm8c712GTHXSH6PUrWCSQDH3I+IWIKg5o0SBt+LCL0Kiv6ASrPqmzt+jesGZsTgTW6w+veKzJjcvTXpXdHA4c6d8JO0rEepD/zuuCL8RpqMt+3lRu6TDxu25sOXyYuST9Z42jVJbLNVWGtgmcHoxNH8ZA5zX/YvRMoOQvT7MWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776512227; c=relaxed/simple;
	bh=9j8eVaGwvN0ubS+y6hUq6RKr0xQ7mZq5xSdwgayZwFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UG3yXK+8W/AbXlp+tjt8Jb5g8igLh+pygkc/nBy/BAob6pN1wyzeEAIHRPKI0ggjvsjmagjTe9EfprQh+efq5Tk7S+wGZCS9LWW/s6UVkCQWAw8+mLI7b7hSVXdqOtSFUvLH60dUBAbqfmQgHWwXZPtZw6gow9Z8YKe8+SAVfsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UBdWe1dE; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 18 Apr 2026 13:36:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776512223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L7bwugRpccIipnAdTLaiDh6Aizt/AO7kL9dxWFVM0g4=;
	b=UBdWe1dExc+zfAuPmB/aknQFrw1Xii++JamXUDteqE21FqHPUIOl5EE/sMngLL+GxM0x3D
	dhe0P5nCqAczfOp06+iVbHTchz/ZZ/xK2lk6zu/QriU0p1vM5KuBZXQLkbmBBeL/pESLnM
	YnTu169idUl6iHl+EI9zhMAjhWa5/50=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	stable@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nvme-auth: Don't log shared secret in
 nvme_auth_dhchap_exponential()
Message-ID: <aeNs2pNRuex8JH8q@linux.dev>
References: <20260303190350.78705-2-thorsten.blum@linux.dev>
 <655d293e-51ce-4e24-93d1-587480d0680f@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <655d293e-51ce-4e24-93d1-587480d0680f@suse.de>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238584-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 55A15420FD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 04, 2026 at 08:17:03AM +0100, Hannes Reinecke wrote:
> On 3/3/26 20:03, Thorsten Blum wrote:
> > When debug logging is enabled, nvme_auth_dhchap_exponential() logs the
> > DHCHAP shared secret. Remove the log to avoid exposing key material.
> > 
> > Fixes: b61775d185a3 ("nvme-auth: Diffie-Hellman key exchange support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >   drivers/nvme/host/auth.c | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> > index 405e7c03b1cf..5e4df2ac3cc0 100644
> > --- a/drivers/nvme/host/auth.c
> > +++ b/drivers/nvme/host/auth.c
> > @@ -655,8 +655,6 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
> >   		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> >   		return ret;
> >   	}
> > -	dev_dbg(ctrl->device, "shared secret %*ph\n",
> > -		(int)chap->sess_key_len, chap->sess_key);
> >   	return 0;
> >   }
> 
> Yeah, that was primarily for debugging.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>

This was never applied, was it?

Thanks,
Thorsten

