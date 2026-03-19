Return-Path: <stable+bounces-227214-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBi6AOScu2l0lwIAu9opvQ
	(envelope-from <stable+bounces-227214-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 07:51:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FDF2C6EB9
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 07:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48EF6302A182
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 06:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2233451DC;
	Thu, 19 Mar 2026 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IIDaNWzu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58E7173
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 06:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903073; cv=none; b=oqDFJZOw4ofQV94zCRelFGM4aUSuZ1jEigBdAceoJLwD/pVFPHqvLJ2GK643mmu47oEi6UKPcarukWVj9xwvAkqeeFiZwVaXeBokDRfd1GhHWhbsDuEnIkkuOSYdP8PsHFbnNEW+QxF9FXQ6/hHq0T8OGdn9Z2ku2qe4zXJHRJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903073; c=relaxed/simple;
	bh=THl3Fuo9BG7SbNMHwTOJ7LymkElnryDyYT03iWt6ImI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhTJ2cHigA64s4+VPE3/eArcyNI6+WqHo0SHOgGfxISm2Qx1n6ELK65iCNQQCv3//xvztooV1bfHgw9uXt8i7NI7aF6fgZknTSm8Xf30RJYH4YiRVHM8GfNNhL5sHGyTyIsIB3q7DJ136iRnEpJ9P8qxinZOqaEnPMC+NX69La0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IIDaNWzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE7CC19424;
	Thu, 19 Mar 2026 06:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773903072;
	bh=THl3Fuo9BG7SbNMHwTOJ7LymkElnryDyYT03iWt6ImI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IIDaNWzuPl9Mvtk02Ownk+yjf7citHJPpp+jBbpZ675R/ZJKiESTwO4Bk6KYYXmd5
	 AmrCFLh38hTRJMM5+aTCz4OXM1oTLxJMJFfeGZhme3U+LDpb0+dc9JaMrVcwk/dVzn
	 0k51g+NFivpPYvxua1krTZhy1p5kfs90DazJZdCo=
Date: Thu, 19 Mar 2026 07:51:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: kuba@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] net/tcp-md5: Fix MAC comparison to be
 constant-time" failed to apply to 6.18-stable tree
Message-ID: <2026031932-concise-squeegee-6f90@gregkh>
References: <2026031756-likewise-lumpiness-6c88@gregkh>
 <20260318212703.GA2013993@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318212703.GA2013993@google.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227214-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.962];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 87FDF2C6EB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 09:27:03PM +0000, Eric Biggers wrote:
> On Tue, Mar 17, 2026 at 01:01:56PM +0100, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.18-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> I already did this a week earlier.

Sorry bout that, I process them after going through the upstream
patches.  I see that now and will go queue it up.

thanks,

greg k-h

