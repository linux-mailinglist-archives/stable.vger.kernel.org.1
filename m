Return-Path: <stable+bounces-136716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CC8A9CC81
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 17:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88B217C8D7
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 15:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792B8274FCD;
	Fri, 25 Apr 2025 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaD4jQY/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4F32750ED
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593966; cv=none; b=PvnHnpOkEilL8ilWd/xfGDDY04BRrCdDVGLFGKx+0KjFrp0y4A8j4Rx6Td15XCNCC8WY5R4/GIRXIs8Q1TBxYfwZCnd9mrQ/w7ipZqWGsOmJwUyHmv4CVUOwCGFcpm0/y3CL5T1F0xrKsN/0fiI9EBjRuu+bWcGnZajPIogzDnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593966; c=relaxed/simple;
	bh=3KEYF6wq5doHPSDEyFCUV31EnYHZGmE8JIMIGueI/dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZCvc4hII86gRuCJ8/vQ2Sxoh+Wh3YCtiscXro1/uOBnK7QFHpCfUVXlZjvi7v2OwvpUjed/gG7i+9JFJdOCAVq+iwTr/IBvkDQo7FJvk0LB3HHZAqddYQMV3h7nOOExPWhps0FWSepX+YdnNShmHYOyAG1Gg/9sWcygOEpXDbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aaD4jQY/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745593962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7wnpRUGCy1asyCGpaZqWQHx5uwoqnqV1Pz1YZ80UYmM=;
	b=aaD4jQY/Lm78zy43eDArgb9iYVCyCsEgExnde9Dok6E8bfPxq/+96MFP/8hppa1OcCfxzX
	Dn3ltW6ART2xjuZurbqJqcSPAo9wBi8YlIf7uxiD060jcX6LVsP1SjnYJs2WVnEVjQlk4a
	n9sgG/9D23Qqy2UONJwOrJBQy2+0GYg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-9_O77c8WPNiqImnuTbiGoQ-1; Fri, 25 Apr 2025 11:12:40 -0400
X-MC-Unique: 9_O77c8WPNiqImnuTbiGoQ-1
X-Mimecast-MFC-AGG-ID: 9_O77c8WPNiqImnuTbiGoQ_1745593960
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3913b2d355fso810962f8f.1
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 08:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745593960; x=1746198760;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7wnpRUGCy1asyCGpaZqWQHx5uwoqnqV1Pz1YZ80UYmM=;
        b=Q6u1UDAU3u5CfNfynywHbKFV2+DjyOsfsuv13k6ocf/B2yoolIFK1B6NzggHBLwyIq
         /l3tegircHN70UwlnMiY/8+CgftXmVFh28eCBoi8TgkYXMHsRM95kWEKWyw3cmoWv3Cc
         euPXtFZjpXhZKkiG5w14aFdD8R34N4B5E8kjLwPRuSvdcpYtYl6OgsaqOY8KeyNUDqGP
         ZZKfQsjfBJBphowYRZryuOppmzWrRL8+wT61rAxXPQjNRkpIT+a2KG/CLDq9XzrTBL3g
         RUw1/1dBFTf5h6N9Naxp5CkeWBhzyypjQRRqE7z+wJ8AkP0JOhwPgVcxgPyt3yP4NbJk
         pTGg==
X-Forwarded-Encrypted: i=1; AJvYcCVLXOSjOtmKwULgI8GrYA5fshbKh5HofcrI5HK0XeeJlTehHQ+FiCh0/JvZO62tBdYtSRbld38=@vger.kernel.org
X-Gm-Message-State: AOJu0YzphWTANs+dmMsZnHE//QqT9+0nwXGFfPPvB4lNgn2Q/2Ln/gQI
	YeF1AinbGjnpb3htTIOWzcvREedhZ6ioe4QBNCofH6Duf0RgazFBLAKQGOo0GYL168ey+TMosxw
	rBAT04wtO4mMd3BTp2fyM3wUI7RATBA6/CRW/MF34WJSRUbuzlOge6Q==
X-Gm-Gg: ASbGncs8b+FpJjIVlcPHZPg5AM1PZ6A5cBG4rBFFRNRPlCg8q+rMlNykWZkbBJ5pPVd
	HdhdCI7hjRnaac0+0byLY2wSXzq6PsLwTpGp8fikBhLd9fbl1ssJIy/Vzcwj+V3rDw3q08EdqTq
	8ZgXk442fdbWLVC6tHuodvyhC/en8F/fjcmVUODq5s3q7DNkz5xOliCGyCeHZAPpp7fLIZLphCo
	F4/0NOkRTkYXPvz2Ev7OGOpmBFiTpfXTSNKBSgq8gdlCTB1F2P+xTG8Fu6PcNmb6oH9LgJcOZsh
	Js/sP6qhOuKFcBUDA97kjZ06hO8TlCSbljWgKk25hl5kSe1OSdFicIQWoprhVeiOZ8pwMKkLn1d
	LoJaIvUrhT+bOiJfcd8VZaL/jbF0fKtVoy01L
X-Received: by 2002:a5d:5888:0:b0:391:1222:b444 with SMTP id ffacd0b85a97d-3a074e1eb59mr2612450f8f.20.1745593959680;
        Fri, 25 Apr 2025 08:12:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb8zX1fiNGn7dGhgouHSaj/JSOfWUgiuFpdN8caJ0tf/dvhMJAiX+roZ1dwcXdc6c/rcWKCg==
X-Received: by 2002:a5d:5888:0:b0:391:1222:b444 with SMTP id ffacd0b85a97d-3a074e1eb59mr2612418f8f.20.1745593959236;
        Fri, 25 Apr 2025 08:12:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70f:6900:6c56:80f8:c14:6d2a? (p200300cbc70f69006c5680f80c146d2a.dip0.t-ipconnect.de. [2003:cb:c70f:6900:6c56:80f8:c14:6d2a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ccb8e1sm2665832f8f.59.2025.04.25.08.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 08:12:38 -0700 (PDT)
Message-ID: <23e2d207-58ac-49d3-b93e-4105a0624f9d@redhat.com>
Date: Fri, 25 Apr 2025 17:12:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/userfaultfd: Fix uninitialized output field for
 -EAGAIN race
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: Mike Rapoport <rppt@kernel.org>, James Houghton <jthoughton@google.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-stable <stable@vger.kernel.org>, Andrea Arcangeli <aarcange@redhat.com>
References: <20250424215729.194656-1-peterx@redhat.com>
 <20250424215729.194656-2-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250424215729.194656-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.04.25 23:57, Peter Xu wrote:
> While discussing some userfaultfd relevant issues recently, Andrea noticed
> a potential ABI breakage with -EAGAIN on almost all userfaultfd ioctl()s.

I guess we talk about e.g., "man UFFDIO_COPY" documentation:

"The copy field is used by the kernel to return the number of bytes that 
was actually copied,  or an  error  (a  negated errno-style value).  The 
copy field is output-only; it is not read by the UFFDIO_COPY operation."

I assume -EINVAL/-ESRCH/-EFAULT are excluded from that rule, because 
there is no sense in user-space trying again on these errors either way. 
Well, there are cases where we would store -EFAULT, when we receive it 
from mfill_atomic_copy().

So if we store -EAGAIN to copy.copy it says "we didn't copy anything". 
(probably just storing 0 would have been better, but I am sure there was 
a reason to indicate negative errors in addition to returning an error)

> 
> Quote from Andrea, explaining how -EAGAIN was processed, and how this
> should fix it (taking example of UFFDIO_COPY ioctl):
> 
>    The "mmap_changing" and "stale pmd" conditions are already reported as
>    -EAGAIN written in the copy field, this does not change it. This change
>    removes the subnormal case that left copy.copy uninitialized and required
>    apps to explicitly set the copy field to get deterministic
>    behavior (which is a requirement contrary to the documentation in both
>    the manpage and source code). In turn there's no alteration to backwards
>    compatibility as result of this change because userland will find the
>    copy field consistently set to -EAGAIN, and not anymore sometime -EAGAIN
>    and sometime uninitialized.
> 
>    Even then the change only can make a difference to non cooperative users
>    of userfaultfd, so when UFFD_FEATURE_EVENT_* is enabled, which is not
>    true for the vast majority of apps using userfaultfd or this unintended
>    uninitialized field may have been noticed sooner.
> 
> Meanwhile, since this bug existed for years, it also almost affects all
> ioctl()s that was introduced later.  Besides UFFDIO_ZEROPAGE, these also
> get affected in the same way:
> 
>    - UFFDIO_CONTINUE
>    - UFFDIO_POISON
>    - UFFDIO_MOVE
> 
> This patch should have fixed all of them.
> 
> Fixes: df2cc96e7701 ("userfaultfd: prevent non-cooperative events vs mcopy_atomic races")
> Fixes: f619147104c8 ("userfaultfd: add UFFDIO_CONTINUE ioctl")
> Fixes: fc71884a5f59 ("mm: userfaultfd: add new UFFDIO_POISON ioctl")
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Cc: linux-stable <stable@vger.kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Reported-by: Andrea Arcangeli <aarcange@redhat.com>
> Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   fs/userfaultfd.c | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index d80f94346199..22f4bf956ba1 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1585,8 +1585,11 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
>   	user_uffdio_copy = (struct uffdio_copy __user *) arg;
>   
>   	ret = -EAGAIN;
> -	if (atomic_read(&ctx->mmap_changing))
> +	if (unlikely(atomic_read(&ctx->mmap_changing))) {
> +		if (unlikely(put_user(ret, &user_uffdio_copy->copy)))
> +			return -EFAULT;
>   		goto out;
> +	}

Nit: It's weird that we do "return -EFAULT" in one case, in the other we 
do "goto out;" which ends up doing a "return ret" ...

Maybe to keep it consistent:

ret = -EAGAIN;
if (unlikely(atomic_read(&ctx->mmap_changing))) {
	if (unlikely(put_user(ret, &user_uffdio_copy->copy)))
		ret = -EFAULT;
    	goto out;
}


In all of these functions, we should probably just get rid of the "goto 
out" and just return directly. We have a weird mixture of "goto out;" 
and return; ... a different cleanup.


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


