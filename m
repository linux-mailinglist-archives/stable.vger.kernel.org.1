Return-Path: <stable+bounces-70090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BB995DE37
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 15:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE971F22277
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 13:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C4416E886;
	Sat, 24 Aug 2024 13:51:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C059F143889;
	Sat, 24 Aug 2024 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724507472; cv=none; b=ES4oTuacvsU3zlN53zuZSgKazby2q6sdsRjvzeQ5IsHv68BYRjtjjE4xaDQpWRkdE0zyU+tb70JYUVE0yej4nkGgt+ciVr5T0KpKHRaJCOeUQSA3X0cEUTOzHu5B6wf6vBazjmLjpIe4kfJa2KFJBBTXBmVFsfkf1zi60Bd2Si0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724507472; c=relaxed/simple;
	bh=8FMUt6BQxit/n38Ct4Jyf0mdhrKf4YPJQE6YGQsEJ1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIfDVbjYqhWwt47ts5D7yjKf4MB5rgEW8/bpqSs9T2Eiz4medItLHBktKVzBmWZ3RJgJJDj01h3pD8ZK4xa71VRNqRu4BY1NriCab80iMfqm+/v8TR5lOKoIriJgMz4kOzsfFP9nnPGRhIKMBnO2Jdu0zCC7PBRh0zwYYBV8hgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1shr22-007231-3C;
	Sat, 24 Aug 2024 21:51:05 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 24 Aug 2024 21:51:04 +0800
Date: Sat, 24 Aug 2024 21:51:04 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Paluri, PavanKumar" <papaluri@amd.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	John Allen <john.allen@amd.com>,
	"David S . Miller" <davem@davemloft.net>, stable@vger.kernel.org
Subject: Re: [PATCH] crypto: ccp: Properly unregister /dev/sev on sev
 PLATFORM_STATUS failure
Message-ID: <ZsnlSBNi4qsvbdKG@gondor.apana.org.au>
References: <20240815122500.71946-1-papaluri@amd.com>
 <1c6365b1-c134-d1a9-9fb2-22b26abf1a87@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c6365b1-c134-d1a9-9fb2-22b26abf1a87@amd.com>

On Thu, Aug 22, 2024 at 10:17:34AM -0500, Paluri, PavanKumar wrote:
>
> A gentle reminder,

I'd like to see an ack from Tom.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

