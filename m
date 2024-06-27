Return-Path: <stable+bounces-56017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C90791B2EE
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 01:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F26C7B22091
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 23:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9279C1A2FDD;
	Thu, 27 Jun 2024 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fy4I9w7T"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E263D1A2FD8
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 23:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531831; cv=none; b=pRXf7A5ROCNcSFVSCVU/+kEEDkZ5AhYmfsl5YxOSuN+ZHl9+2gDi4a1h2gOVgknXMZ5jYEnKuN/kMkpiMDJ9Ou0ICtENAODKnVU8ZKTNBXX1CVcA+viMsIohe9AhTcN2MvCdY3m6usCuApwiuFSZ5wL3f8qlEP+U1ZXrJWTZYV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531831; c=relaxed/simple;
	bh=ebDrfZM1wUMlJNsSwoYEcAdl1mrbsPa0i3TteWCdB5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfMXyFY16JapjgajT/XgTVHYVFggEn74CGSvvVpypQN65dlwyO/LLiU7BKh/G9Y7boaIUNY0o2Xuqnt76jIPnzwNQqEZajaJ+czh9MDqZSIEqVpwg6kGUDs7MT5jIwexZWXPdeoB0reYpjJi/0xl1itNuuIbMwsbDdw5KIHfn08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fy4I9w7T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719531828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iihd8gyXaTK/eS/7NE9gghzxDsNIhcxbmKKrWECTt2U=;
	b=Fy4I9w7TWmck8oYIwXZDwZaQ4bm4lsv9UhVrh43f7Vt6DgitSCId/IDIbN7XeTOcLjSzJO
	tR05c9DjhLWuo+JmDxGK4Ii7NXbn/15Wp3HRQGBQ6RRAIBEZOibBllo1J4TjJDa7I+bDub
	HidDsG9XSfhzelg8g6Tf0uKWceS57Y8=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-yBqv9lUsOwq06xpfMJsaWA-1; Thu, 27 Jun 2024 19:43:47 -0400
X-MC-Unique: yBqv9lUsOwq06xpfMJsaWA-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3d566d78080so15458b6e.1
        for <stable@vger.kernel.org>; Thu, 27 Jun 2024 16:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719531826; x=1720136626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iihd8gyXaTK/eS/7NE9gghzxDsNIhcxbmKKrWECTt2U=;
        b=G9FLuj8/xDKah7A8w7V2+bpmp9S6SmCetX64uJ4j6EeumFA8OyQl74YleLfKq7jVwA
         RHgIytw2dIVytnJc2DF4TbhmsBP1/uGcuFgmgb19atWsJurLSwt272zwI4guRjvg5fLu
         1kak0AkpiPd3o2nOk9gu+YypveXleHjfliEucYv8QPRuJQZH+xHj1GejdKJ8egeVwoPW
         AxonAxpkOs+kXkNYXpnJDhk1pzFseAuF5Bf+fBqDcY32gRdNh31VGvULbcJJihULe/Eb
         F6y6kz3KN7uLcF+1YKJnaamjfzckZNxJ35H2Ukh8jcwc0S8XVRZ3tY+8ZBWNoaa+5+E+
         Tgmg==
X-Forwarded-Encrypted: i=1; AJvYcCXTqW5mG5CLydg9ApfTYg2sSV91DixyB2e7l37MTCkGNLpCzKrhj3eKkXBR32EfA3GS1aYbPWzv/+x2OKVvrDOFE4SAbuk/
X-Gm-Message-State: AOJu0YxpLE5GiV37SglCD2YwAtczjF4Y6aFbCMasedU+70ra74vkrnNw
	+tBGlR1E/VuHq5dWYqMjZEIJgkoZbgpBfCi5no3ArHoLVi+dAC3LTlhB0urtpc/Oakbw2oimR9g
	EpCJpyzqng3agXGf/2LBD2K780ZjEHWDtfVD1JwDAK+PsLsdUtjuw/Q==
X-Received: by 2002:a05:6830:4581:b0:700:cd64:b65 with SMTP id 46e09a7af769-700cd64148cmr7374921a34.0.1719531826434;
        Thu, 27 Jun 2024 16:43:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9FkEGY1E26IdOAs8EQP58uudvAQdli3PHkfSqokwSqpokiAmzs3MKI6eyPxywyIZHfUTa4A==
X-Received: by 2002:a05:6830:4581:b0:700:cd64:b65 with SMTP id 46e09a7af769-700cd64148cmr7374907a34.0.1719531826023;
        Thu, 27 Jun 2024 16:43:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-446514b2484sm2671841cf.81.2024.06.27.16.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 16:43:45 -0700 (PDT)
Date: Thu, 27 Jun 2024 19:43:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yang Shi <yang@os.amperecomputing.com>, yangge1116@126.com,
	david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [v2 PATCH] mm: gup: do not call try_grab_folio() in slow path
Message-ID: <Zn35MMS_kq3p0m7q@x1n>
References: <20240627221413.671680-1-yang@os.amperecomputing.com>
 <Zn3zjKnKIZjCXGrU@x1n>
 <20240627163242.39b0a716bd950a895c032136@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240627163242.39b0a716bd950a895c032136@linux-foundation.org>

On Thu, Jun 27, 2024 at 04:32:42PM -0700, Andrew Morton wrote:
> On Thu, 27 Jun 2024 19:19:40 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > Yang,
> > 
> > On Thu, Jun 27, 2024 at 03:14:13PM -0700, Yang Shi wrote:
> > > The try_grab_folio() is supposed to be used in fast path and it elevates
> > > folio refcount by using add ref unless zero.  We are guaranteed to have
> > > at least one stable reference in slow path, so the simple atomic add
> > > could be used.  The performance difference should be trivial, but the
> > > misuse may be confusing and misleading.
> > 
> > This first paragraph is IMHO misleading itself..
> > 
> > I think we should mention upfront the important bit, on the user impact.
> > 
> > Here IMO the user impact should be: Linux may fail longterm pin in some
> > releavnt paths when applied over CMA reserved blocks.  And if to extend a
> > bit, that include not only slow-gup but also the new memfd pinning, because
> > both of them used try_grab_folio() which used to be only for fast-gup.
> 
> It's still unclear how users will be affected.  What do the *users*
> see?  If it's a slight slowdown, do we need to backport this at all?

The user will see the pin fails, for gpu-slow it further triggers the WARN
right below that failure (as in the original report):

        folio = try_grab_folio(page, page_increm - 1,
                                foll_flags);
        if (WARN_ON_ONCE(!folio)) { <------------------------ here
                /*
                        * Release the 1st page ref if the
                        * folio is problematic, fail hard.
                        */
                gup_put_folio(page_folio(page), 1,
                                foll_flags);
                ret = -EFAULT;
                goto out;
        }

For memfd pin and hugepd paths, they should just observe GUP failure on
those longterm pins, and it'll be the caller context to decide what user
can see, I think.

> 
> > 
> > The patch itself looks mostly ok to me.
> > 
> > There's still some "cleanup" part mangled together, e.g., the real meat
> > should be avoiding the folio_is_longterm_pinnable() check in relevant
> > paths.  The rest (e.g. switch slow-gup / memfd pin to use folio_ref_add()
> > not try_get_folio(), and renames) could be good cleanups.
> > 
> > So a smaller fix might be doable, but again I don't have a strong opinion
> > here.
> 
> The smaller the better for backporting, of course.

I think a smaller version might be yangge's patch, plus Yang's hugepd
"fast" parameter for the hugepd stack, then hugepd can also use
try_grab_page().  memfd-pin change can be a separate small patch perhaps
squashed.

I'll leave how to move on to Yang.

Thanks,

-- 
Peter Xu


