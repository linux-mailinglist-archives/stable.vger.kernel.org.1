Return-Path: <stable+bounces-179170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 869A6B50F94
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 09:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B233B6B43
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 07:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9264C30BF54;
	Wed, 10 Sep 2025 07:36:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F7330C35D;
	Wed, 10 Sep 2025 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489808; cv=none; b=KGqlh3P2sMa0STIqmTWuDMeTVNs+qvp9WCKnhb8kGrnYa71tSrx01V+opY2fezYMHNMRPWvXshMY/4CanpaV9NNhfXPlsxB0Uuv9JA38fGLnfA3EchzyvbH4fna7mMai0RtEyn+fhuQx0TPlX7eYWT29tHjQPVq+ugyWkKLRKKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489808; c=relaxed/simple;
	bh=TmOayCIKSed+U3pftMVxB4RfTilR+32vHekUHfTlPq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTtAtXSwfEtOOVlQLP7piXXZ59J0/+dfG7HueP5h/qihlVrCmK3ZRx2mR9E5LIehgd8/eVkBJOfp9+sDT9Xd6+dAA0j7Gbdn+leVyKrovDTp3daT6rCEupzh+Lw+T9L3RfXAcDh9hqyt51PPbvM1SJfHKJ8OKOdMnoxK3whIQzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54492cc6eb1so4412298e0c.2;
        Wed, 10 Sep 2025 00:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757489805; x=1758094605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4ZPB9cLoxkxbaM7F/g702qjjiFbhLGJdP74V/VQO3M=;
        b=TWU29+1/XRebZ1reyHvsT5lnkiwejDM7cNIkO5dj++2CeKRrlvAzI78IMbN7VEclwj
         m1ey/gsFKERoiOm/Gv3ehfJxhuA1weS6bnKjOk+6fXCOtpjT/8jWE1h0GXyDrhL+mh/B
         HlknnCwmgUk8kpYxuH4REGz8J6Vk30qySCvfsWLDVWX77OL0oVSb9X0N1C3VNg4M1Qk1
         Aot2G4aK4fqy4+SJz73w6rVus5WJMbQ8mJ2YYVPuH1MSzKS7Vwh5Y9meYxiV5kbxeqQR
         8jrIJ+IdBy0FPEJe3zrIkVazaJyGmIpFkIAWnHBTVdfB6eT59ZLPaF19faQt8MQQ2lkA
         P5oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd6uRL2GhV11hi4O4PrpOXQoP3MKRbZzbH48OaGX37O1aedCXLZwOckVk940JjIkethkcpIGJT@vger.kernel.org, AJvYcCXy04zY3ZYfuz+nIXbI7GoDqczBXRXWQoxpTdxgsE/V9UXlU8dHrpR1dkOYdHpdmWrew6zPfvUxmZyg9Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbZe6tTgQuZLt1vNYjC3Qd5VEow6/bAUMCdZmK3njcovWe9O0/
	tb27Mx2yXh0vBp7MCuZ4rbzYA+iNxr9wljbipc3jPlDB6c0CmQHDk/MIXeZd0bat
X-Gm-Gg: ASbGncuGTv6z90sIKbMv1v0Y2Kjtv7/DduOH6WP/6oII8sHMkmR0S5VYj9DKsQM5bW/
	Blf59O71MxfxLFhRLP1LEVwUrCTH1wqnyz7t7cXsYK9jHFg7v3nPiY1DpphSrPlD/BCym3rs7qV
	jWGH9txXdoDQoeSvP6OiPWWalwim8zEbWhpdEa87Wvg3as+37L0ePoUwElt2dyNRoXy88qAwVLw
	hsBjcHWFzUoeRGJGc9bhY0B9fONr1ZPvVPurtc3iBFLjQF72YbFpYh/Fusmzn5hjwj8gQTby4Z0
	BzjWXgoQANaJA0RSA3QQpBI3Wn0VOa3hbulIIj+ZGt1TScqdfzZoDcp22CbwiXBkXyw0U/uhl4s
	siWlPq0E9Cw5HTBJ1fMaPQGQdH5MUFjpF79BvnM7XxVKc8o+cA37ZL0lOn163ZZHmleovMGg=
X-Google-Smtp-Source: AGHT+IG+e8sxjfMstEQ/h0SSAawby6HdebEO0x3qlZcLae3bXLN/9yP4BTh3lXqTRy8m5O9clYDQOA==
X-Received: by 2002:a05:6122:168a:b0:544:9f73:9b46 with SMTP id 71dfb90a1353d-54737c557d4mr5238663e0c.16.1757489805465;
        Wed, 10 Sep 2025 00:36:45 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54521bac78bsm8720770e0c.30.2025.09.10.00.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 00:36:45 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-52dd67b03c8so4586792137.2;
        Wed, 10 Sep 2025 00:36:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGmJiyJNWCBi/EIUu/9FbFE5gSXMdVmybzLQ8RLBMDhqtCUaT/sJFLsga3wtGOYv45TlMRJaC7@vger.kernel.org, AJvYcCV04nBzmjpIxuyQSYkZVWMuvqa+Yvz9SfRbGLqX0M3wO2m0tHeuslG7ojtomzcigj/LGkp48PSh9QOu/nc=@vger.kernel.org
X-Received: by 2002:a05:6102:1612:b0:524:2917:61aa with SMTP id
 ada2fe7eead31-53d2490d7a8mr5170926137.32.1757489804939; Wed, 10 Sep 2025
 00:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909145243.17119-1-lance.yang@linux.dev> <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
 <99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org>
In-Reply-To: <99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Sep 2025 09:36:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVYiSLOk-zVopXV8i7OZdO7PAK7stZSJNJDMw=ZEqtktA@mail.gmail.com>
X-Gm-Features: AS18NWBjsCg0nVfXhXD258JRfHuut4V1EOs3ikA4pxJOAq5hXrzJ1s5v9rh0wsw
Message-ID: <CAMuHMdVYiSLOk-zVopXV8i7OZdO7PAK7stZSJNJDMw=ZEqtktA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock pointers
To: Finn Thain <fthain@linux-m68k.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Lance Yang <lance.yang@linux.dev>, 
	akpm@linux-foundation.org, amaindex@outlook.com, anna.schumaker@oracle.com, 
	boqun.feng@gmail.com, ioworker0@gmail.com, joel.granados@kernel.org, 
	jstultz@google.com, leonylgao@tencent.com, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, longman@redhat.com, mhiramat@kernel.org, 
	mingo@redhat.com, mingzhe.yang@ly.com, oak@helsinkinet.fi, 
	peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, 
	tfiga@chromium.org, will@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Sept 2025 at 02:07, Finn Thain <fthain@linux-m68k.org> wrote:
> On Tue, 9 Sep 2025, Kent Overstreet wrote:
> > On Tue, Sep 09, 2025 at 10:52:43PM +0800, Lance Yang wrote:
> > > From: Lance Yang <lance.yang@linux.dev>
> > >
> > > The blocker tracking mechanism assumes that lock pointers are at least
> > > 4-byte aligned to use their lower bits for type encoding.
> > >
> > > However, as reported by Eero Tamminen, some architectures like m68k
> > > only guarantee 2-byte alignment of 32-bit values. This breaks the
> > > assumption and causes two related WARN_ON_ONCE checks to trigger.
> >
> > Isn't m68k the only architecture that's weird like this?
>
> No. Historically, Linux/CRIS did not naturally align integer types either.
> AFAIK, there's no standard that demands natural alignment of integer
> types. Linux ABIs differ significantly.
>
> For example, Linux/i386 does not naturally align long longs. Therefore,
> x86 may be expected to become the next m68k (or CRIS) unless such
> assumptions are avoided and alignment requirements are made explicit.
>
> The real problem here is the algorithm. Some under-resourced distros
> choose to blame the ABI instead of the algorithm, because in doing so,
> they are freed from having to work to improve upstream code bases.
>
> IMHO, good C doesn't make alignment assumptions, because that hinders
> source code portability and reuse, as well as algorithm extensibility.
> We've seen it before. The issue here [1] is no different from the pointer
> abuse which we fixed in Cpython [2].
>
> Linux is probably the only non-trivial program that could be feasibly
> rebuilt with -malign-int without ill effect (i.e. without breaking
> userland) but that sort of workaround would not address the root cause
> (i.e. algorithms with bad assumptions).

The first step to preserve compatibility with userland would be to
properly annotate the few uapi definitions that would change with
-malign-int otherwise.  I am still waiting for these patches...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

