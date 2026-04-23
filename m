Return-Path: <stable+bounces-240422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKRnMsCw6WlchgIAu9opvQ
	(envelope-from <stable+bounces-240422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 07:40:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C87F144D4E7
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 07:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13AD23037431
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 05:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796EA3C198D;
	Thu, 23 Apr 2026 05:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="NutnDOPy"
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F063128D7
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 05:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776922780; cv=none; b=W69JqXZIJ8CMrXWTEPmrb0aOhUeXFJIH29Q2NGGMdvEGTAvh7nmtXhFdFKEnbFCvjP2PL8ILwX82v3f8rXxMxHurO04a+n9auXPdnr1hLGzUz0AwWMJJ5EdmCxEGalr3x+/FM/2c6KAFEryukCiN0WBSdeEHNCcaMjl8tTz/8vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776922780; c=relaxed/simple;
	bh=fOmqQobk0uDsBpeTJ2DEfckI8Jxe22SOF4Mx6KtLEXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCzyhpMGG6YuFY0ShpmrdX4Fe8EI6o/Ey3HIAba7yFwKvxu7C1N3qm6ZSzW9Ten3HhaYE4ODsaxgic4ho0ECMNu7n06jU46HSJD1cmMCiVuQec443n4msQWy/YP4TSuLLWo8+sJaPHvKu2cPKCkTvjMXtRMXY7lFrE4fgOembOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=NutnDOPy; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=J/NCgp1Yi4+HqGsu+RGhTGBl5z/rqfBxQu6nmnLYb1A=; 
	b=NutnDOPyvaUEZRFnVcoo2fjCyi+1DB4WQ14RAv362k28GlAvgzPV7hrid14ar/lpkoGzBwpRqr5
	1SypLXThD95r2gkfGjUQNEg3720j8iXpUbsd0jt9d+GYHuEgB23on6ID98BrU/0r8DBQKKDibU6wc
	+cmOVDX0U/SeIFNJBVUMnGdT+LNPlQkZDLLlpFF5ppQEm8BF9tyPGSPMHaaMb3j9JpK7az2IxRTy0
	mZac3sEc1b3+aV8k3BnN6A7TF1U8wKZhjZ0XsUMSLsFdNSDe9ktTrYFl6wt6KGqy4vJNbzcJ8Oaxm
	e1l4vYQ7LibcwL5rE8ApXz7YL2ilXF/Q8dMg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wFmmj-00891F-1F;
	Thu, 23 Apr 2026 13:39:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 23 Apr 2026 13:39:33 +0800
Date: Thu, 23 Apr 2026 13:39:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: gregkh@linuxfoundation.org
Cc: phx0fer@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] crypto: krb5enc - fix async decrypt
 skipping hash" failed to apply to 7.0-stable tree
Message-ID: <aemwlWqIUk5WR413@gondor.apana.org.au>
References: <2026042355-fructose-married-6872@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026042355-fructose-married-6872@gregkh>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240422-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email]
X-Rspamd-Queue-Id: C87F144D4E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 07:04:55AM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 7.0-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
> git checkout FETCH_HEAD
> git cherry-pick -x 3bfbf5f0a99c991769ec562721285df7ab69240b
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042355-fructose-married-6872@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..
> 
> Possible dependencies:

It should apply if you first bring in

commit 2ef3bac16fb5e9eee4fb1d722578a79b751ea58a
Author: Wesley Atwell <atwellwea@gmail.com>
Date:   Mon Mar 9 00:26:24 2026 -0600

    crypto: krb5enc - fix sleepable flag handling in encrypt dispatch

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

