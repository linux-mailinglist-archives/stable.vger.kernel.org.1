Return-Path: <stable+bounces-40360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F108AC058
	for <lists+stable@lfdr.de>; Sun, 21 Apr 2024 19:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A659B281268
	for <lists+stable@lfdr.de>; Sun, 21 Apr 2024 17:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E312A1BC23;
	Sun, 21 Apr 2024 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eoYuZvqH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ACC625
	for <stable@vger.kernel.org>; Sun, 21 Apr 2024 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713721690; cv=none; b=bPVyfOZrVisOUkZDeRI3HN+IUElVhqWw9SmlLYVVkKjFSs2lOvkqBQqygPGll2ufdjZIukDzkWd8wsHh0yXHdzQXQKRLACeOWlbvPPv3fw8KHc7Z4VqS7sJ9J5cv5QANUPwg5/P5CrrCM5ru1nq/f74FdOsAi1Ivn7rYnbxJBAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713721690; c=relaxed/simple;
	bh=nVqmOLqS8Jm879/wAzi3qp2fB/Kd9kS1cq5sv7FOepE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyNf62bEXm7yLxr8PmwMrB1Pd2/QWvfE4uZQr03fSkJCLpZdrmFo4P5cPT6Io6bwe12JkFTJHFFIILUePoYtlQdj+Ek3019Adu0HnoSXWDm3+bhCDI60fgQnIYhHuPi8Igr6HVTGqSyELLyXzn6dsz/FBtxtAg1NVwF4ujdYnhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eoYuZvqH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so2958564b3a.0
        for <stable@vger.kernel.org>; Sun, 21 Apr 2024 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713721689; x=1714326489; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ci/J2ILNecORXupy9IHKIghPdBckTpTbuTnDZ9u6/Us=;
        b=eoYuZvqH1UkPW1+ZnsDJqA6ya7IIgZSVbu0CpxBIXy8RAmqmwdQP484s6PcGKaaqrV
         YDZKZKlkcgc53EJv4MWmyLKYEUgBXy+IEkQeNjfcdEQh9EKAIzWmVfbzgGne1OPFVbny
         kefL1BdBpwKClgX3+HnGOPdlyYVHAVix90k/1gVx+YK4jD0AS3Amqwi5g9gvjmGwsadt
         E0ar1iob0jZmzR+XcMCk2nljPudkpmZ/CZgnUetEaij6QWZoqj8Fu5F49Hgup0BRPKAW
         18ffDCa4lasawp/Tho2lpTBDSeIuHanezNVHwshf3HFWUQZ2iQhVTDTvjXjzJEO6ZdbD
         RUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713721689; x=1714326489;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ci/J2ILNecORXupy9IHKIghPdBckTpTbuTnDZ9u6/Us=;
        b=qht/ZouQxDHx59qyHshqT1E1BsrvE2u9LorA2hY6hZfoQn7ytG7T+eLbpXuxOWgHdD
         dJUumWEp/uTKwkJPQ+NA1BDfe3R1KU2oJWxadEPEcduc1PzNgxM+5pznIKRfyvpffulo
         MGjDV4d++YPD12HDLQXy/ADcHyfRQRHpA0Al3QYTrc4y5jeUOwjYsvwhuOmQ2UUB4vxu
         M7iiUbjJo3fgXJ4mhsFgkBa8nxkxuJhDUGl8IUdKEsxea48xf7ktdrcDOgdK3dtSRQ8W
         VHLUPIPLL3RRY1JNp1DjuV/Bdfc5mMow3RZLjaTjT0/CnlyhU0cKFpfU56X48+HKSpjo
         lobw==
X-Forwarded-Encrypted: i=1; AJvYcCX2CNIGsnzsxJ3PI7yyAOAVFJBzGXr53HR3xD/9DYUzBpYfZEYzfPDlP7EdMJo84r9PTGDIOQne9zRJQlSGpAn6wRlgOYZV
X-Gm-Message-State: AOJu0Yy2OwgUh5N+fhQCdh1s1clSdV3e7P/PHsIaj5Y8+t+G75tKAp7Q
	6wnCCb2fqAs8cISzX5b/wXvoUYB+dL5CsIe/j0+jJPtf2SVWf6jG1RXpr7Gb2Q==
X-Google-Smtp-Source: AGHT+IGi2HySwpde2wPLGS1rXBVAEyk1Wfn9J93KyuB17lYPSWAXzJl73cC5aQiCwTgjPjlaLTj62A==
X-Received: by 2002:a05:6a00:3929:b0:6e7:b3c4:43a4 with SMTP id fh41-20020a056a00392900b006e7b3c443a4mr9638797pfb.25.1713721688439;
        Sun, 21 Apr 2024 10:48:08 -0700 (PDT)
Received: from google.com (139.69.82.34.bc.googleusercontent.com. [34.82.69.139])
        by smtp.gmail.com with ESMTPSA id d6-20020a63d646000000b005dc8702f0a9sm6192755pgj.1.2024.04.21.10.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 10:48:07 -0700 (PDT)
Date: Sun, 21 Apr 2024 17:48:03 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Serban Constantinescu <serban.constantinescu@arm.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 4/4] binder: fix max_thread type inconsistency
Message-ID: <ZiVRU_nBc91qp0j7@google.com>
References: <20240417191418.1341988-1-cmllamas@google.com>
 <20240417191418.1341988-5-cmllamas@google.com>
 <2024041858-unwoven-craziness-13a6@gregkh>
 <ZiRXHs9_Uszd7xzS@google.com>
 <2024042112-landscape-gains-1bb0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024042112-landscape-gains-1bb0@gregkh>

On Sun, Apr 21, 2024 at 08:39:23AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Apr 21, 2024 at 12:00:30AM +0000, Carlos Llamas wrote:
> > On Thu, Apr 18, 2024 at 06:40:52AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Apr 17, 2024 at 07:13:44PM +0000, Carlos Llamas wrote:
> > > > The type defined for the BINDER_SET_MAX_THREADS ioctl was changed from
> > > > size_t to __u32 in order to avoid incompatibility issues between 32 and
> > > > 64-bit kernels. However, the internal types used to copy from user and
> > > > store the value were never updated. Use u32 to fix the inconsistency.
> > > > 
> > > > Fixes: a9350fc859ae ("staging: android: binder: fix BINDER_SET_MAX_THREADS declaration")
> > > > Reported-by: Arve Hjønnevåg <arve@android.com>
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > > ---
> > > >  drivers/android/binder.c          | 2 +-
> > > >  drivers/android/binder_internal.h | 2 +-
> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > Why does only patch 4/4 need to go into the tree now, and as a stable
> > > backport, but the first 3 do not?  Shouldn't this be two different
> > > series of patches, one 3 long, and one 1 long, to go to the different
> > > branches (next and linus)?
> > 
> > Yes, that is correct. Only patch 4/4 would need to be picked for linus
> > now and for stable. The others would go to next. Sorry, I was not aware
> > that sending them separately would be preferred.
> > 
> > I'll drop 4/4 patch from the series in v2. Let me know if you still need
> > me to send it again separately.
> 
> Please do, thanks!
> 
> greg k-h
> 

Ok, done. The separated patch is here:
https://lore.kernel.org/all/20240421173750.3117808-1-cmllamas@google.com/

Thanks,
Carlos Llamas

