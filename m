Return-Path: <stable+bounces-77793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9BB9875CC
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 16:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6662EB28BD8
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 14:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D920D14F9DD;
	Thu, 26 Sep 2024 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PPmBFAez"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31755149C42
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361592; cv=none; b=Sf73/SPdAR7O0VnSB52blYtreyIVvS9EGHN4DF+cgzcxpFVLU4q5pO4BPz9q12KDZQlEEs2gfbZLcLPJ0INN9shEyc3cZO4kjgfbCtZmK84jmOjYDJrMJF3UgLUl7epjOcA+ytw/L7UBjMCm0tawyaIs4o0paNpzhnAI8bdISp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361592; c=relaxed/simple;
	bh=wfIyskPySyjPNW1pLmibdEptSD2xFwaJ+VXx4/SJsw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JD7mqqsDYwl6h2A4GgNoSZEE8KJmCj3rc4CTBtClKe3sPzrelx7mMfTxisfJtelEqe0qKJtBzEuPT9GfeQ5E5a3yOEJH8h6VsPLSz5peslHUaZmfOm0UZqMpy6drI2NDUoNAJ+jvoxd4/VLB3HHfR9XHLe3LlYH/ELExgihLtBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PPmBFAez; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-207349fa3d7so199005ad.1
        for <stable@vger.kernel.org>; Thu, 26 Sep 2024 07:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727361590; x=1727966390; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h9Kx4TvG8rWCki80hYYN6JcEZKQM9F21l0z7iQwPKdk=;
        b=PPmBFAezVUdIZRkycEmCJ52yvEPMuniL2kJYVxDGGc1WMv5t1V68AQq0jCnC5uLq+A
         L8hbcvQva9U4tYs19r5EpW4jasw7gdXAEzEx3jxEArA7Pf3iATi/HRNxuC8ZFJB8EG2O
         cpq0dhKCjoVaJO9WwbQ2uKQofZbDwRuRycDsZx7gmCxrUYzTzCbJZWQU5FzUSXYAUgu+
         SwGl69NPYk4gXWqBq2LgkZuDopNPDSak17d/p4RSR/Jv6JdcvrYpnojw/Hg8CFzAhSQ3
         pMZHJdm5HvdiOBk827xel/SxJOKLF+S30AB5aSud9I2lk3ITKEntaODrMoh4O6p6pfDD
         hI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727361590; x=1727966390;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9Kx4TvG8rWCki80hYYN6JcEZKQM9F21l0z7iQwPKdk=;
        b=VXwJxRSGMrUZCeqP+RQJEC2mFt/ImjSbAkrjUbSPwsrkR+i17kBSfi6v0wqjq7c5hr
         qrzvRUQxU8CmG2y+zo3r/nF/uLmvPJDU05rEZtvRVpzu/WDhGDEN8Lc1QOiY/ofEHllX
         DZE8CXujC7Xn6jdODk2kxRU8z1oobDnoa9Xu+g9Y8xGlWF54ED6E4hk60h77QT3Wx11I
         9Np6znpJ3TM3WNXvmRVtsyVpWRF3pZITnlvNRib9EK+HjxAUJbNeNm6wzFYS11JABj0r
         MII4XEKGhLW3V+0LjBH98nSjSJmTLiSpoYRmGrqSobbYLKEmUFST9ygX5TJVBO8OcBgR
         8QpA==
X-Forwarded-Encrypted: i=1; AJvYcCXPVdx4GgxRisCSP7bzRicuNSFUKYXuCcBCRW+h9aRKfjQjI5CXGdd4+8tAQmuRv7/Q2DCMo7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzUi4SrhbQWaoIKPKud3WXeebnFEgMWli59Qu8MAnOInlcOm3c
	H62JWXK/DIJKl4oX1yozZHUKipihwB1hNePFC1eMN/kFPU0Xm84C+i0DZ/CvqA==
X-Google-Smtp-Source: AGHT+IGqEw3AUY+vCnhHKos8GOabvXEypIRu6p3mjprWFoppCBU2eR5CREeDDbhv652YGeOXfhzoGg==
X-Received: by 2002:a17:903:41ca:b0:201:e2db:7be3 with SMTP id d9443c01a7336-20b20390211mr2538525ad.21.1727361590132;
        Thu, 26 Sep 2024 07:39:50 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af185482asm39276555ad.244.2024.09.26.07.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:39:49 -0700 (PDT)
Date: Thu, 26 Sep 2024 14:39:45 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Yu-Ting Tseng <yutingtseng@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/4] binder: fix OOB in binder_add_freeze_work()
Message-ID: <ZvVyHCZituk8fhi-@google.com>
References: <20240924184401.76043-1-cmllamas@google.com>
 <20240924184401.76043-3-cmllamas@google.com>
 <CAH5fLghapZJ4PbbkC8V5A6Zay-_sgTzwVpwqk6RWWUNKKyJC_Q@mail.gmail.com>
 <ZvRM6RHstUiTSsk4@google.com>
 <CAH5fLggK3qZCXezUPg-xodUqeWRsVwZw=ywenvLAtfVRD3AgHw@mail.gmail.com>
 <ZvRRJiRe7zwyPeY7@google.com>
 <CAH5fLgiqgWy9BVpQ8dE6hMNvDopEMVT-4w3DffXONDo3t6NqEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgiqgWy9BVpQ8dE6hMNvDopEMVT-4w3DffXONDo3t6NqEw@mail.gmail.com>

On Thu, Sep 26, 2024 at 10:06:14AM +0200, Alice Ryhl wrote:
> On Wed, Sep 25, 2024 at 8:06 PM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > On Wed, Sep 25, 2024 at 07:52:37PM +0200, Alice Ryhl wrote:
> > > > > I reviewed some other code paths to verify whether there are other
> > > > > problems with processes dying concurrently with operations on freeze
> > > > > notifications. I didn't notice any other memory safety issues, but I
> > > >
> > > > Yeah most other paths are protected with binder_procs_lock mutex.
> > > >
> > > > > noticed that binder_request_freeze_notification returns EINVAL if you
> > > > > try to use it with a node from a dead process. That seems problematic,
> > > > > as this means that there's no way to invoke that command without
> > > > > risking an EINVAL error if the remote process dies. We should not
> > > > > return EINVAL errors on correct usage of the driver.
> > > >
> > > > Agreed, this should probably be -ESRCH or something. I'll add it to v2,
> > > > thanks for the suggestion.
> > >
> > > Well, maybe? I think it's best to not return errnos from these
> > > commands at all, as they obscure how many commands were processed.
> >
> > This is problematic, particularly when it's a multi-command buffer.
> > Userspace doesn't really know which one failed and if any of them
> > succeeded. Agreed.
> >
> > >
> > > Since the node still exists even if the process dies, perhaps we can
> > > just let you create the freeze notification even if it's dead? We can
> > > make it end up in the same state as if you request a freeze
> > > notification and the process then dies afterwards.
> >
> > It's a dead node, there is no process associated with it. It would be
> > incorrect to setup the notification as it doesn't have a frozen status
> > anymore. We can't determine the ref->node->proc->is_frozen?
> >
> > We could silently fail and skip the notification, but I don't know if
> > userspace will attempt to release it later... and fail with EINVAL.
> 
> I mean, userspace *has* to be able to deal with the case where the
> process dies *right after* the freeze notification is registered. If
> we make the behavior where it's already dead be the same as that case,
> then we're not giving userspace any new things it needs to care about.

This is a fair point. To make it happen though, we would need to modify
the behavior of the request a bit. If the node is dead, we could still
attach the freeze notification to the reference but then we would skip
sending the "current" frozen state. This last bit won't be guaranteed
anymore. I _suppose_ this is ok, since as you mention, userspace should
have to deal with the process dying anyway.

I honestly don't really like this "fake successful" approach but then we
don't handle driver errors very well either. So it might be worth it to
avoid propagating this "dead node" error if we can. I'll do this for v2.

Thanks,
Carlos Llamas

