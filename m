Return-Path: <stable+bounces-182979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 802FBBB1474
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 18:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9122A08FC
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 16:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52F02C031B;
	Wed,  1 Oct 2025 16:45:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F22C0323
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759337113; cv=none; b=cu4TJFAxQk/aYz0qqhZudeFACZWh2a9luaehMroXZixfeZfu+fc7yKPIv/lW3BzAepUXedsB2gYGq850Lg9EkQOKDet0ssnwoPfzc3gqTlXoOVwdu+lFOeCxoeP1BdWt2VTWIl1lnyW81QAvQdKGI9gZbzziaTpdCT5aU5sFWhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759337113; c=relaxed/simple;
	bh=K7YWwtRoXyrnO3YXAJ6rlkNgEypHfVsTVv9EU7Z16Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRPSkFsibwW3jIOf0GfHX57zzcXAttdY/13rK6LEYMwMa1RmjGUbmT8jMk+R9dQsz1To+yVHI5RYqKUoU41iXQR+UxC/iFi2IvdtT06c0zieIdtGWSfnFRZzjGg+jlB6e14C8vdZHdRJFDJX6cWHgqK41L0Gujdc0dVW19WKvYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b4736e043f9so20907466b.0
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 09:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759337110; x=1759941910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RpMi9Th+Po7AoazGbT2yu6utd+ZudWSIE+dBXn6AEw=;
        b=UoE4ABrKP29LiSH6mQgsbfla8hcaxZl/RMzDy9qWTHwI+/bVQg+QxtWH2tqknWBx7I
         3BKElmjnk8totiaSVLMgiS2oN6ydpV6wLNeL5uwqZ4wIWjC+N7cPNDpZxUlneLzOQoDK
         UAcNaWvjO4YlHOWwVPRHK2bNMHti0/2xHMgMHzUxj3t7aMx57wuRWax6OjBguXuEoUNm
         1XQgMQn/HC/ht6kRYqIMiEzsFfRd5wejR5KHs+lR/cOj5DjJLZpczkwgWmFaXbnr6RfC
         EEKSDc8BFbKsmH0jUncbeuoL3GfvQEJQUk+o4aXw9kCwyRWHbm0/h5em4Rgn7gYPfrkZ
         58UA==
X-Forwarded-Encrypted: i=1; AJvYcCUsAfq+sSdwZEr2TcgY0rrvfhM/npqXyvwIGeMPOE2lu1WqfcL8fWsoGtfGDl8rLkVWUnm2Wdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSHXApEYJLXaH+iZ9eO4QFxNrUxGUPjSD0uayh0wj4Fv0qBrnT
	cmI8vp6eXtBHoBN7fpHlJZC2hxzWCwNdoZNO8oKeNcRCBsqiVGNM2BSE
X-Gm-Gg: ASbGncvzr16vl5Q+LOJY4V5v9T519VHQuqNdagE9m/tpgYkmPCAJfkTPcJeW3ivcOIz
	3vTuHkwkBR1rKUxyTEEhX5CahbHpx6vZcxqE49RIBUyFSGKZti1z5DdDO+kAtpHM6Ng0eZzJ/le
	Vidl2EnX8O+gYuJJc4O4QQjYGpK8VKGRuL0X1pQm5OZVgvAqHROwJFbzr1jRFI9cTj/VBfXGb2t
	a6vHxOQhCuPcp4XTP/AmOZRXtL9cKq2FnSoHnv5JWi6xgywpHm/zJTjL0vN2cqvION3UxnQjuJl
	aI0tMFbn78Az8KRgLPZuFodsUpbaQO6I2/EZs2I45U6DPO3J1TpeM+7SroFLf38DM2pJtGYozA2
	VYGsr/I/y3ikx7udAMYUXNHuaejZA0t4qX86NJg==
X-Google-Smtp-Source: AGHT+IFaatL0zRpXljYvk9pU9uM41+0gFgUFUB28SfXW6ic2vlnE+OWGmtK1CqAf9k3bMM7SwTnkww==
X-Received: by 2002:a17:907:1c95:b0:b3c:31c2:b57d with SMTP id a640c23a62f3a-b46e99531a7mr534332566b.55.1759337109937;
        Wed, 01 Oct 2025 09:45:09 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486a178610sm1548866b.92.2025.10.01.09.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 09:45:09 -0700 (PDT)
Date: Wed, 1 Oct 2025 09:45:07 -0700
From: Breno Leitao <leitao@debian.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Michael van der Westhuizen <rmikey@meta.com>, 
	Tobias Fleig <tfleig@meta.com>
Subject: Re: [PATCH] stable: crypto: sha256 - fix crash at kexec
Message-ID: <jm3bk53sqkqv6eg7rekzhn6bgld5byhkmksdjyxmrkifku2dmc@w7xnklqsrpee>
References: <20251001-stable_crash-v1-1-3071c0bd795e@debian.org>
 <20251001162305.GE1592@sol>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001162305.GE1592@sol>

Hello Eric,

On Wed, Oct 01, 2025 at 09:23:05AM -0700, Eric Biggers wrote:

> This looks fine, but technically 'unsigned int' would be more
> appropriate here, given the context.  If we look at the whole function
> in 6.12, we can see that it took an 'unsigned int' length:

Ack. Do you want me to send a v2 with `unsigned int` instead?

> This also suggests that files with lengths greater than UINT_MAX are
> still broken.  Is that okay?

I've tested it but kexec fails to load it, so, it seems we are safe
here:

	# kexec --load kernel --initrd foo 
	kexec_file_load failed: File too large

> Anyway, I'm glad that I fixed all these functions to use size_t lengths
> in newer kernels...

Thanks for that!
--breno

