Return-Path: <stable+bounces-240423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI9ICDy36WlgiQIAu9opvQ
	(envelope-from <stable+bounces-240423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 08:07:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7F544D69E
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 08:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BB813006208
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 06:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25C338B143;
	Thu, 23 Apr 2026 06:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bjz6FrgW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4002BD01B
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 06:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776924468; cv=none; b=H3VcepNrJy0m6FPb9rkkxVP2WiE8QUHLMm2vSnAXhW49TzWtMja9yy5XMt5wx2wRyhdt3cf/OgkzkN7vDBVQwMqySpLx00B1mnwX0jl7yYYYMKVhE5RiOf5tk42lLqmiJEyjAFbqPysXO5FE5fgHkdkFh/XqJW40+Ys5R8mt81g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776924468; c=relaxed/simple;
	bh=dzJdFYWB1XEtRuUvATWVazohjqB8DcSUdWIvc6DzphI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZ26IRYLd942jkdKpLDZQftX49hxFvGTDQ4pklZWjDJxehnw6vO8L81cPei8riQhDC43csvy3d6fvA6Jf2O/V2D0zauemI8kuL8Lep2CwGiM7abRpzhVx630lCxgr3h3otBvWbb7uXZDy5F1Gk968/a7MEyt7MVuv6ouCahYRVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bjz6FrgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E27DC2BCAF;
	Thu, 23 Apr 2026 06:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776924468;
	bh=dzJdFYWB1XEtRuUvATWVazohjqB8DcSUdWIvc6DzphI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bjz6FrgWzmdWnxSFT9FjHPdYSmgCWfgDx1K30AkwWSVzBB/G+v9SxRfakjQB0NXaI
	 l6NX1oENi0+eYn0zAw4CS/Xj0PBeJM1CbKZ6KKMEbQbrJUuP+FHvedLHKAH8vjlDFG
	 DRSfWlSS0C1EBcQDw93mpAc/wQGJKhXktYqLe+gg=
Date: Thu, 23 Apr 2026 08:07:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: phx0fer@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] crypto: krb5enc - fix async decrypt
 skipping hash" failed to apply to 7.0-stable tree
Message-ID: <2026042340-entail-elite-34f8@gregkh>
References: <2026042355-fructose-married-6872@gregkh>
 <aemwlWqIUk5WR413@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aemwlWqIUk5WR413@gondor.apana.org.au>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240423-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,gregkh:email]
X-Rspamd-Queue-Id: 1F7F544D69E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 01:39:33PM +0800, Herbert Xu wrote:
> On Thu, Apr 23, 2026 at 07:04:55AM +0200, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 7.0-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 3bfbf5f0a99c991769ec562721285df7ab69240b
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042355-fructose-married-6872@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..
> > 
> > Possible dependencies:
> 
> It should apply if you first bring in
> 
> commit 2ef3bac16fb5e9eee4fb1d722578a79b751ea58a
> Author: Wesley Atwell <atwellwea@gmail.com>
> Date:   Mon Mar 9 00:26:24 2026 -0600
> 
>     crypto: krb5enc - fix sleepable flag handling in encrypt dispatch

That worked, thanks!

greg k-h

