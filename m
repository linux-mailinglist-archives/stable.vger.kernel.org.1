Return-Path: <stable+bounces-186256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B62ABBE71E3
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 10:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4AD913473C3
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 08:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F5827CB35;
	Fri, 17 Oct 2025 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="ZvE79FkM"
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E1A269AEE;
	Fri, 17 Oct 2025 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689075; cv=none; b=CSkkNFaQue+vvKl9APvnVCvJLfeuc0VXPZQs0HJ9C4uvCgWtVDCIICtisHG8G9E8U9CT3J7QvcHWgLZ3Dl+HrEtInA/lWOEKldy+yDOM1IQPwYHrPmrVUJyDzqPny5nh8zbhZYRB8fP/9L6hpak7FvnyhCLNBLkSkHLLjQkpwJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689075; c=relaxed/simple;
	bh=43YF12BDAH/Ba3dKvt6RFRpVtCOSXmUnBY3cZsIoIeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgOFArZp4PmM6eHWa21FM4Bf5VbEdnZnc8wr2B6yF7ieqqsulBKNn+nU36WKu/ywqUrMUY78NE636AUGH9+gFUUUSTUC58OqFyQOzvFKDEUj96rrJOeS5qvv1Wz7ntZBGLXb1RengpEUUs+7kSRA1QZQhLBmn5S8zjJm7X/hJqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=ZvE79FkM; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=96ZHaGBqeD7BFkim6YwKV7lQH4LexCYnCik0wXeuFf4=; 
	b=ZvE79FkMcSa+mUlR8obnxBjWQobwgwTRmd4E8uzJo0+yc/+pClbvFHm4qD15L6R1UB5k2crwk2g
	bkPCN8HpIBbviokWxD0Md7uuaHxHofoaTJrHST8sAuNQCynbyRqhIGscGM/mu6SdZehWvydh5tYSg
	vedFlmzlu93Seq2On8jcXBUceS/7mHSVtHB2yGG4rvdPYmwVtgj85H8cebAsuYs/rnVRMs0MCAGrQ
	urOSDZrRRSPMmwuiDbkO81eGcmcEg3WMC1p8o4TG3KZ5I9FbcNQ0GxsafGsdC9oFMovEQnnjNY9MO
	q6UrNteHcQx58amxJMOfkltTyIi5nxGGJk8Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1v9feg-00DN05-2L;
	Fri, 17 Oct 2025 16:17:43 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Oct 2025 16:17:42 +0800
Date: Fri, 17 Oct 2025 16:17:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Victoria Milhoan (b42089)" <vicki.milhoan@freescale.com>,
	Dan Douglass <dan.douglass@nxp.com>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] crypto: caam: Add check for kcalloc() in test_len()
Message-ID: <aPH7puE_qyvONCcx@gondor.apana.org.au>
References: <20250923124418.1857922-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923124418.1857922-1-lgs201920130244@gmail.com>

On Tue, Sep 23, 2025 at 08:44:18PM +0800, Guangshuo Li wrote:
> As kcalloc() may fail, check its return value to avoid a NULL pointer
> dereference when passing the buffer to rng->read(). On allocation
> failure, log the error and return since test_len() returns void.
> 
> Fixes: 2be0d806e25e ("crypto: caam - add a test for the RNG")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> changelog:
> v3:
> - Fix build error: test_len() returns void; return without a value.
> - No functional changes beyond the allocation failure path.
> 
> v2:
> - Return on allocation failure to avoid possible NULL dereference.
> ---
>  drivers/crypto/caam/caamrng.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

