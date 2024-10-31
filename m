Return-Path: <stable+bounces-89427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 102B79B7FCD
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 17:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF0E1F222E3
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 16:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20161BC9F4;
	Thu, 31 Oct 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m119S1B2"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEE91BBBD4
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391467; cv=none; b=Fyil8HTQ3l6b4FEF+PqUvDUpouJC5SJ7G8uenItO0yx2//ER8zJpZzKICUF6rof/4Jc6sSmRWC8b/e+JewJy7OVeIS4ExoojVWwfh0h3zXdMpA53BtDb2R8o2/lrP/Jz7kvKs1BFS/GbEfVVHK9GL727WmPiGaIYwWdl9L+X/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391467; c=relaxed/simple;
	bh=iZF+mooExopyq0xzdO7CNurUgan6rIV70ohSFzoQHg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8jmFJqh5c/80kE6NjoZy65F0+hcCO2XQP+PXtad+iBbwnVTLFAPMJBeol66s2dt+Osjax7xem2OKnbLUwH+75HhC/d4d+I4XjClPyFpbg2uMuWb8kUK9emNR47bWSdGD1lNyBUWlbUc2xwhEEueTLzHcU088O4fPUBJu93wPUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m119S1B2; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 31 Oct 2024 16:17:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730391461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zz4c3x5dbiaQ/rDPEPHeqjhR4kVLEaCYKPw8Ka78Dic=;
	b=m119S1B2eU/7eMmPJLPzLd++29ABneZsc3f3z1jyJr3d9Z5LwVwBljLq5+9XNmNxg85RP2
	Qqn4Z39JN45Dil5xzv0t0Z43mdLhjn7zKFz+V/eWD8PZkSt8/D1LgUgxNa//ra9NUVQeCN
	/B96m+63E/jYvsItFIvWzs5dbf+OHIc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrei Vagin <avagin@google.com>
Cc: Alexey Gladkov <legion@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ucounts: fix counter leak in inc_rlimit_get_ucounts()
Message-ID: <ZyOtnhVpTgdmvaoM@google.com>
References: <20241031045602.309600-1-avagin@google.com>
 <ZyNS9J7TOQ84AkYz@example.org>
 <CAEWA0a7W4u189wViEk2P9ZBgUe7DFGmSA8UKW0gKvCC8_pRiHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEWA0a7W4u189wViEk2P9ZBgUe7DFGmSA8UKW0gKvCC8_pRiHw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 31, 2024 at 08:43:22AM -0700, Andrei Vagin wrote:
> On Thu, Oct 31, 2024 at 2:50 AM Alexey Gladkov <legion@kernel.org> wrote:
> >
> > On Thu, Oct 31, 2024 at 04:56:01AM +0000, Andrei Vagin wrote:
> > > The inc_rlimit_get_ucounts() increments the specified rlimit counter and
> > > then checks its limit. If the value exceeds the limit, the function
> > > returns an error without decrementing the counter.
> > >
> > > Fixes: 15bc01effefe ("ucounts: Fix signal ucount refcounting")
> > > Tested-by: Roman Gushchin <roman.gushchin@linux.dev>
> > > Co-debugged-by: Roman Gushchin <roman.gushchin@linux.dev>
> > > Cc: Kees Cook <kees@kernel.org>
> > > Cc: Andrei Vagin <avagin@google.com>
> > > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > > Cc: Alexey Gladkov <legion@kernel.org>
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Andrei Vagin <avagin@google.com>
> > > ---
> > >  kernel/ucount.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/ucount.c b/kernel/ucount.c
> > > index 8c07714ff27d..16c0ea1cb432 100644
> > > --- a/kernel/ucount.c
> > > +++ b/kernel/ucount.c
> > > @@ -328,13 +328,12 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
> > >               if (new != 1)
> > >                       continue;
> > >               if (!get_ucounts(iter))
> > > -                     goto dec_unwind;
> > > +                     goto unwind;
> > >       }
> > >       return ret;
> > > -dec_unwind:
> > > +unwind:
> > >       dec = atomic_long_sub_return(1, &iter->rlimit[type]);
> > >       WARN_ON_ONCE(dec < 0);
> > > -unwind:
> > >       do_dec_rlimit_put_ucounts(ucounts, iter, type);
> > >       return 0;
> > >  }
> >
> > Agree. The do_dec_rlimit_put_ucounts() decreases rlimit up to iter but
> > does not include it.
> >
> > Except for a small NAK because the patch changes goto for get_ucounts()
> > and not for rlimit overflow check.
> 
> Do you think it is better to rename the label and use dec_unwind? I don't
> think it makes a big difference, but if you think it does, I can send
> this version.
> 
> BTW, while investigating this, we found another one. Currently,
> sigqueue_alloc enforces a counter limit even when override_rlimit is set
> to true. This was introduced by commit f3791f4df569ea ("Fix
> UCOUNT_RLIMIT_SIGPENDING counter leak"). This change in behavior has
> introduced regressions, causing failures in applications that previously
> functioned correctly.
> 
> For example, if the limit is reached and a process receives a SIGSEGV
> signal, sigqueue_alloc fails to allocate the necessary resources for the
> signal delivery, preventing the signal from being delivered with
> siginfo. This prevents the process from correctly identifying the fault
> address and handling the error. From the user-space perspective,
> applications are unaware that the limit has been reached and that the
> siginfo is effectively 'corrupted'. This can lead to unpredictable
> behavior and crashes, as we observed with java applications.
> 
> To address this, we think to restore the original logic for
> override_rlimit. This will ensure that kernel signals are always
> delivered correctly, regardless of the counter limit.  Does this
> approach seem reasonable? Do you have any concerns?

I think override_rlimit argument should be passed into inc_rlimit_get_ucounts()
and be handled there properly by ignoring the comparison with max.

I gonna prepare a patch later today, if there are no objections for this
approach.

Thanks!

