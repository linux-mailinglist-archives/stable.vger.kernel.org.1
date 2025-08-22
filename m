Return-Path: <stable+bounces-172323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC8FB310C7
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0709F17CA81
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 07:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5D12E9EA9;
	Fri, 22 Aug 2025 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Ru1eWcKJ"
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCFA2E229D
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848934; cv=none; b=nPa2aKNRvgWkWFH6WRO2OrP8Qjjl1In69B0FeCuea5pUB7pEq2abc6gwyOwAIimsqYXNDRbnIsJ4I86mA6mjFbjCEfzojiDxhx5HuF0tlRTOprkPqgcAmTwuU0+BSlr1R9eKNWnQd/lXQETq4s46TpJTYXaq155svmpaLyikQGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848934; c=relaxed/simple;
	bh=ThqB0zR8ZaczI1VWZo9l1mrqUNhb1q1av+oK2Smjodg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4yXUOwC8nBS+4OZPrMjH1rOYt3k+rEAHlUHNdbCtxgwzCo25CZwMFM0rmm2LOZS4izc/Vrv7F+Dip/Djsc3IoUElbdzdy8vwl1TZpE8D8zaXWTwi3WXjBf6zrcc5NejrXm5005dXK4fq/AEvPdXFDbzWYV7SYNoSMj00FmM0c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Ru1eWcKJ; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/7g+I6gSwip9uXn9w43I97u0FV3ol68RBnnFL1/1K10=; b=Ru1eWcKJ+4k1t2OTc7gBQOlhub
	zTIJ0gj67vV1F9bMSy+StEJet07+wg+z7eWgE0m+d+rglPW7BP5+T6x1R+tVs03M+6uzONMEzJ+x5
	KmAFl7i1jxX4o0BpmBaLbbnViPDmf41a1WcKfOMyn4zwjRC/NoK1D7CwJMo/jobbXRYIDCQdAR499
	unTXYaoDWz4VpKEorDKCMIQV8/VRpevnB/gWlo/ZOLU0Sa+qoouLngPF3T3CusaIWIWqHTWLxaDkL
	uyXRS9fg67GyemSqwvgBCDIUAl/IQiBRu5SEDizS1UIaIPoUHE4zwEgR0O5mmjUELPW2vfST2xyqZ
	jcB3aLFw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1upMGY-00GLH4-1o;
	Fri, 22 Aug 2025 15:48:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Aug 2025 15:48:46 +0800
Date: Fri, 22 Aug 2025 15:48:46 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 6.16.y 2/2] crypto: acomp - Fix CFI failure due to type
 punning
Message-ID: <aKgg3vHUz2MM7A-L@gondor.apana.org.au>
References: <2025082113-buddhism-try-6476@gregkh>
 <20250821192131.923831-1-sashal@kernel.org>
 <20250821192131.923831-2-sashal@kernel.org>
 <aKgZVNygjrqd9L6M@gcabiddu-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKgZVNygjrqd9L6M@gcabiddu-mobl.ger.corp.intel.com>

On Fri, Aug 22, 2025 at 08:16:36AM +0100, Giovanni Cabiddu wrote:
>
> Wouldn't it be simpler to drop the below changes to crypto/zstd.c in
> this patch and avoid backporting commit f5ad93ffb541 ("crypto: zstd -
> convert to acomp") to stable?
> 
> f5ad93ffb541 appears to be more of a feature than a fix, and there are
> related follow-up changes that aren't marked with a Fixes tag:
> 
>   03ba056e63d3 ("crypto: zstd - fix duplicate check warning")
>   25f4e1d7193d ("crypto: zstd - replace zero-length array with flexible array member")
> 
> Eric, Herbert, what's your take?

Yes there is no reason to backport that patch at all.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

