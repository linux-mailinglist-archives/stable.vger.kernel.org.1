Return-Path: <stable+bounces-242343-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AAnBL2S9Gm7CQIAu9opvQ
	(envelope-from <stable+bounces-242343-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:47:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A974AC1D7
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8736230166F4
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A97F364927;
	Fri,  1 May 2026 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gFuVJF6u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7E72DCF58
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777636025; cv=none; b=Bwc+r8KIsACeY60Mk06J8qN5QbJs3gOl67fujt+UvIW268hrC1IcipqFMZZoCY0du5TgUMQN3fuvEvtyh+LD6YwuXPAZSfyigyCogXjIa8cW/wulBohLQQ3Lh1PIWSDB1jLsxIhz064JaM1kRbO+7ZHTwhVz7E68JjgAe1fTf0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777636025; c=relaxed/simple;
	bh=LDZPg5lwJbkg/sBa4yvDhVwOBqDgHZcJegNCY4c7Azc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oq6fmaYpbZFDIhUYnQV/T4STP3fvakoa0o6KnocyndzNeVFH42paYizvt1z0dCJesyhJuTWcKDvuYOCo+SQWZwb7DesyFFDb0IsQU9iq4tlVu5ApVOe96Ar9KDOAwvD6miHDkVzQRxg+ycrzXloC/3BKzf+FSQ0Hm23MI2W9lSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gFuVJF6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934EDC2BCB4;
	Fri,  1 May 2026 11:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777636024;
	bh=LDZPg5lwJbkg/sBa4yvDhVwOBqDgHZcJegNCY4c7Azc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gFuVJF6upvQXGjFlfkFMMS0R1Bpkzjq5nU+p5xNRivmboKt3p4fz1mvlCez/VVbAo
	 88uQ31keHh6F/IpH4NxUui3oD1F10ztM7Hf6rEwJuNM1xT9kVATRcIl5TKHQnbeArP
	 +/DmT8nz5wrzjuTQH+6nMYTwYUqYYMFpEntbJQus=
Date: Fri, 1 May 2026 13:47:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Helge Deller <deller@gmx.de>
Cc: jpoimboe@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] module.lds.S: Fix modules on 32-bit
 parisc architecture" failed to apply to 7.0-stable tree
Message-ID: <2026050155-kennel-caboose-2f30@gregkh>
References: <2026050157-rewrite-overfeed-ad3b@gregkh>
 <ad114140-ac88-415c-beef-c36a1ba4516d@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad114140-ac88-415c-beef-c36a1ba4516d@gmx.de>
X-Rspamd-Queue-Id: 98A974AC1D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242343-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,gmx.de:email]

On Fri, May 01, 2026 at 01:31:37PM +0200, Helge Deller wrote:
> Hi Greg,
> 
> On 5/1/26 13:01, gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 7.0-stable tree.
> Can you please cherry-pick this upstream commit first:
> 
> commit 4afc71bba8b7d7841681e7647ae02f5079aaf28f
> Author: Joe Lawrence <joe.lawrence@redhat.com>
>     module.lds,codetag: force 0 sh_addr for sections
> 
> after that this commit applies cleanly:
> commit 1221365f55281349da4f4ba41c05b57cd15f5c28
> Author: Helge Deller <deller@gmx.de>
>     module.lds.S: Fix modules on 32-bit parisc architecture
> 
> 
> Both are relevant for 7.0-stable only. No further downwards porting needed.

That worked, thanks!

greg k-h

