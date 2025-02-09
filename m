Return-Path: <stable+bounces-114428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E06A2DC6D
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 11:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F115166040
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 10:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EECC1B85EC;
	Sun,  9 Feb 2025 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="LqR/Sans"
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD1C16132F;
	Sun,  9 Feb 2025 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739096587; cv=none; b=mPcVvpElPl4U+1QKoFdCu9fdwvMfWTchwegtnn7V+rs3QN2vcWfSBVGTk5teLYELhyUEKQpGbRHBBiiJapIlJZ01RZxheNZNGZlAm0ocQGZDJ+LIoppzcLKxxFROPXvFcWcGjByEHihxt0GZSbILfL65tmXCmCis+mZh1KBQhY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739096587; c=relaxed/simple;
	bh=iKCYjBHY9JTHLmo6uukCwOj0goR6aHxnF5IGRna1lLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXstKDKN3HGm14+6ZSd/Z+EbpP3qSyx5mE7ahJ4Wgnfb+ogg64t3KWG85iQjcFQAsnUOl6zB5mjrIzlQB3XCgvJshWvsXgZixMGF4+U4RAacGk+TfOpdoH4Q12jLtz4EKS1m7zohJvlBh2E3Imc+Kh9f7ZtmONgKpkVcIeQSlf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=LqR/Sans; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CDFdVtlriN/R40iHQ45+kDTehenIynhUB6/rRqEd2Wg=; b=LqR/Sansh5OhO7enfDdS1eP6Ny
	Kvn3yLpGLBlXmMPyoonMVXVC7RnK98REOi+6Fg4QtxCIzGTJ5pw9tdtWPxhVQqaL1bD2JcFg8FrKC
	E8YzoHiRex3QBnKGxMILIA1iMM/2yuaDFGAkBkrK9huHcWrT5o9f720dnnIGkyKPAPKkXZ4t2hGfp
	/PHjPzzYIhTiAouNT4z/17SKtnFWIfNj+cyndAk7GjpxO/upa7K4CfyqC0iTEX2mXRMD/nnPbyQYV
	EBfczduVGdp1IrSifoUZLhmzKkjM6jt3wXOQaa2CvKZ5QrEL0zPYMWuUtfqGSnlprc9Mhmz28oVoN
	WM6efjBQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1th4Ft-00GIm0-1a;
	Sun, 09 Feb 2025 18:22:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 09 Feb 2025 18:22:58 +0800
Date: Sun, 9 Feb 2025 18:22:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>, John Allen <john.allen@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] crypto: ccp - Fix check for the primary ASP device
Message-ID: <Z6iCAnIV3f0aiMV-@gondor.apana.org.au>
References: <9cb3a054c95327fe26de41419dd23c914f141614.1737155147.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cb3a054c95327fe26de41419dd23c914f141614.1737155147.git.thomas.lendacky@amd.com>

On Fri, Jan 17, 2025 at 05:05:47PM -0600, Tom Lendacky wrote:
> Currently, the ASP primary device check does not have support for PCI
> domains, and, as a result, when the system is configured with PCI domains
> (PCI segments) the wrong device can be selected as primary. This results
> in commands submitted to the device timing out and failing. The device
> check also relies on specific device and function assignments that may
> not hold in the future.
> 
> Fix the primary ASP device check to include support for PCI domains and
> to perform proper checking of the Bus/Device/Function positions.
> 
> Fixes: 2a6170dfe755 ("crypto: ccp: Add Platform Security Processor (PSP) device support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  drivers/crypto/ccp/sp-pci.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

