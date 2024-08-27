Return-Path: <stable+bounces-70349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0850960B0A
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567591F23C90
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 12:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DC01BF33A;
	Tue, 27 Aug 2024 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vr5TrhaK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1C51BDAA8
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762916; cv=none; b=aHYqMVWvsbcOIeAYQLMDN/ihx4iS8+axiHM212e7OmlaloyfR0CCHWRBgPc7oNRF3yH5Efk25LPOWBxzXPaE8Cg4cVgO/XLkJxhbZboPjm1UqjN2uxFH11ADhLC86HdPmmNc+ErizwCS30UTbXJGfRqevUlIA3zNSu/FeLIe32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762916; c=relaxed/simple;
	bh=QZKsIkASmfkJ8gFX1VK89wnrn651+wKAKFkfbHijiAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cg0Zic9X6FOxdG3gd2yD9vpl9XQ7TSlWPlXOUSsv73NvXkl+gftlWMABTFof780l5Mpl7TUaj8FG2BuIFGP0Qy5Rq8OikHISWOsjrzNEacKwyT+yWB+SVS7A5V1e9xxbt3eu8r/5ktbAyowqDMF5fw6GbE2FhDvwstH5dB0qjYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vr5TrhaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F0FC6104A;
	Tue, 27 Aug 2024 12:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724762916;
	bh=QZKsIkASmfkJ8gFX1VK89wnrn651+wKAKFkfbHijiAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vr5TrhaKJMK8rP109euI4+mBYyB6BxENFHc0RmUbsCjgmy33/oWkhSzRwC35gAKwB
	 LzgA9bSlgL4oR8aYMjL6hrr37zyfqpFiPltqq5BBOYnlZpxpKnEVRMLWRF0LlVqhMs
	 LT5BG7TJWm2XAMoBnNR1AThnGREN+5czfZoeQc1w=
Date: Tue, 27 Aug 2024 14:48:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	Hughdan Liu <hughliu@amazon.com>
Subject: Re: [PATCH 5.10.y] nfsd: Don't call freezable_schedule_timeout()
 after each successful page allocation in svc_alloc_arg().
Message-ID: <2024082726-switch-barricade-8c4a@gregkh>
References: <20240819170551.10764-1-kuniyu@amazon.com>
 <ZsOKuAYNaW0CGqnA@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsOKuAYNaW0CGqnA@tissot.1015granger.net>

On Mon, Aug 19, 2024 at 02:11:04PM -0400, Chuck Lever wrote:
> On Mon, Aug 19, 2024 at 10:05:51AM -0700, Kuniyuki Iwashima wrote:
> > When commit 390390240145 ("nfsd: don't allow nfsd threads to be
> > signalled.") is backported to 5.10, it was adjusted considering commit
> > 3feac2b55293 ("sunrpc: exclude from freezer when waiting for requests:").
> > 
> > However, 3feac2b55293 is based on commit f6e70aab9dfe ("SUNRPC: refresh
> > rq_pages using a bulk page allocator"), which converted page-by-page
> > allocation to a batch allocation, so schedule_timeout() is placed
> > un-nested.
> > 
> > As a result, the backported commit 7229200f6866 ("nfsd: don't allow nfsd
> > threads to be signalled.") placed freezable_schedule_timeout() in the wrong
> > place.
> > 
> > Now, freezable_schedule_timeout() is called after every successful page
> > allocation, and we see 30%+ performance regression on 5.10.220 in our
> > test suite.
> > 
> > Let's move it to the correct place so that freezable_schedule_timeout()
> > is called only when page allocation fails.
> > 
> > Fixes: 7229200f6866 ("nfsd: don't allow nfsd threads to be signalled.")
> > Reported-by: Hughdan Liu <hughliu@amazon.com>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/sunrpc/svc_xprt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > index d1eacf3358b8..60782504ad3e 100644
> > --- a/net/sunrpc/svc_xprt.c
> > +++ b/net/sunrpc/svc_xprt.c
> > @@ -679,8 +679,8 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
> >  					set_current_state(TASK_RUNNING);
> >  					return -EINTR;
> >  				}
> > +				freezable_schedule_timeout(msecs_to_jiffies(500));
> >  			}
> > -			freezable_schedule_timeout(msecs_to_jiffies(500));
> >  			rqstp->rq_pages[i] = p;
> >  		}
> >  	rqstp->rq_page_end = &rqstp->rq_pages[i];
> > -- 
> > 2.30.2
> > 
> 
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

Now queued up, thanks.

greg k-h

