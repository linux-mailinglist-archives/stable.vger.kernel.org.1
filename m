Return-Path: <stable+bounces-45550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3408CBA78
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 06:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26461282B94
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 04:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D411E4A2;
	Wed, 22 May 2024 04:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="hN3BLJsX"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02EF23CB
	for <stable@vger.kernel.org>; Wed, 22 May 2024 04:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716353267; cv=none; b=PGpw77ZUoIAgcc5z+CC0koCFuBWacOr33irWRE/l4pG0m31pCJU6Z9dRaD8WthUo1HhXdPbv+y3DS+3T7oW+/rfqCTwgGQREY5cjqv2dRhrDSAJhYnHdQr/nxLr5hlXFSL4v+7XmqL6FAUtrbSGG7zrfYt7xLabLzGcM/tSPh/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716353267; c=relaxed/simple;
	bh=JwLXpEOVUZ/PpQpxYN07YDI+GRqiFye0/rCRTmX7fEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atYm/sYHMgxL8XD7a/JIGayiP+TFSNX1Q7lu2SAsHyBePBJTt3RG6aA/01J+Ryv4/cdNZC3+49QwoiHnrKBiyakxXZWfj+vM7k8wzL/dQJmifBFzvECU+a7ZE6ZO3Dayyg9ZlzRjavTajA7zK5fACPQh7Lm05wKa4FLr6RiaKhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=hN3BLJsX; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 05E88400FA
	for <stable@vger.kernel.org>; Wed, 22 May 2024 04:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716353263;
	bh=Y7cjLP0Ap9UvX8pB0DctXypZFWRK43iX7uPE6HzNb+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=hN3BLJsXjB1gdN8Qd3Yh6rOU3x/Q87s0TJf+bfcxxz0YX7Ld8tJk/jlHWC60/utJW
	 gtFXZjjIGaVEYC0KoBytyz3hT+1y0kj/QE7e+vwc3KovdlnHWrw53ldCqUQibnS44L
	 9fxLURYR9I3+/oazdRpMqEkPwQrCsodcLk9qdAwExB2NPbqxuSgFpjWvqaMh6nPhUL
	 4tFJX/1hSuzB5NQTKQOE71g0TSsjbz1KeOJmbeaJzxtppXh006ejXPCn9y5oj3YaEp
	 KhX/xGyaZ8hSkeHLfZhmq9zCFLX/0wCn5kuS3xuCuBsaareBTPoelu5SwFm+1LanBM
	 6xNbTow428XCQ==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6f46acb3537so387121b3a.1
        for <stable@vger.kernel.org>; Tue, 21 May 2024 21:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716353261; x=1716958061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7cjLP0Ap9UvX8pB0DctXypZFWRK43iX7uPE6HzNb+U=;
        b=waa0U4C9iWbsPITiU7fdgA1Mbap0PpDycRPik/EuFhqXWg7jXgHUzLoY9tzR84dn8E
         lVAx5wFOOUvswBlucCOAKd2HvHh2gVT8o85k/DXZYiM6fX/6iF3PpA60McJnC41VsvsH
         /FfF7NVY66kryRTTWwyeDi0UfaumAhMVghnZgp0hLosDRMHBqM37T+zjiFKBafsrS9wM
         RDImGOoVabcSRIuERwZ36Sod2zPtO/2XEZcNV/sepop4wvmfvK8oJgER65oFJIGsPwTR
         Sy9JSMDsv0VHuqEf7RKO75BmTLa1AAbdigmORKz2C4MGwCVYTI81NhIZVwD9FQ1vLjAP
         3VQA==
X-Forwarded-Encrypted: i=1; AJvYcCUrKwvGjFMs2KNZ8GzLQGiDCngqC8dkSIeqsFeaeXoWcLNSZwo3AiNGrnDBfjG23mDNymcu0nv8jGTVs3k9fqtC68JRcODj
X-Gm-Message-State: AOJu0YxNe91MKc2w7fGwMdtqvTnG2KS26uj0b2nqyY+s11137rm6a52f
	IP0tauDZ51CKrIhlKLDtbuRzslbLsrwD66ALj8eQvIUHgxEpklqdawQrKhzgK9KcmekhcfqoXbT
	12GGUPjbzMH0cDG43wzKOnUQYqriKbUwpfjgmXizXYrHiNcE82S2wBEEF2UN/wj8yMHAq4Q3oZO
	06zQ==
X-Received: by 2002:a05:6a00:6506:b0:6f4:4b35:d7b5 with SMTP id d2e1a72fcca58-6f69fb7dc7emr14909481b3a.1.1716353261288;
        Tue, 21 May 2024 21:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH96ol61ldW4aYAvuIjp7wX67i0ZWOa1ssLayi1caqRf+Lgg8CimRqnfGXMg8A498e75rtFRw==
X-Received: by 2002:a05:6a00:6506:b0:6f4:4b35:d7b5 with SMTP id d2e1a72fcca58-6f69fb7dc7emr14909466b3a.1.1716353260886;
        Tue, 21 May 2024 21:47:40 -0700 (PDT)
Received: from localhost ([122.199.27.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ade270sm21680884b3a.119.2024.05.21.21.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 21:47:40 -0700 (PDT)
Date: Wed, 22 May 2024 14:47:38 +1000
From: Liam Kearney <liam.kearney@canonical.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, stable@vger.kernel.org
Subject: Re: [PATCH v2] crypto: arm64: use simd_skcipher_create() when
 registering aes internal algs
Message-ID: <5a7izhohyagdbn3dya6dk3m3fl2ga2hy3i6k7ga2jr722uod3v@rlp6jvjjgaz7>
References: <20240522035837.18610-1-liam.kearney@canonical.com>
 <2024052212-saved-manmade-9c8e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052212-saved-manmade-9c8e@gregkh>

On Wed, May 22, 2024 at 06:18:54AM +0200, Greg KH wrote:
> On Wed, May 22, 2024 at 01:58:37PM +1000, Liam Kearney wrote:
> > The arm64 crypto drivers duplicate driver names when adding simd
> > variants, which after backported commit 27016f75f5ed ("crypto: api -
> > Disallow identical driver names"), causes an error that leads to the
> > aes algs not being installed. On weaker processors this results in hangs
> > due to falling back to SW crypto.
> 
> But that commit has already been reverted in the stable releases, right?
>

Ah yes, my apologies, I seem to have missed the revert. I've been away
for a few weeks, and this was just bumping the submission I made at the
beginning of May.

In that case, feel free to ignore this.

> > Use simd_skcipher_create() as it will properly namespace the new algs.
> > This issue does not exist in mainline/latest (and stable v6.1+) as the
> > driver has been refactored to remove the simd algs from this code path.
> > 
> > Fixes: 27016f75f5ed ("crypto: api - Disallow identical driver names")
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Liam Kearney <liam.kearney@canonical.com>
> 
> What kernel tree(s) are you thinking this needs to go to?
> 
> thanks,
> 
> greg k-h

It would be any pre 6.x, so 4.19, 5.4, 5.10, 5.15
But no need now since offending has been reverted.

(group replying for posterity)

Thanks,
Liam Kearney

