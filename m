Return-Path: <stable+bounces-89544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 884FE9B9B42
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 00:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8401C210FD
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 23:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E881CEE88;
	Fri,  1 Nov 2024 23:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iJJ1pXX5"
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F4B165F0C
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730505065; cv=none; b=IZvneDjWmqZeORk1kKUn+fZD/MOgs35BsrxuuM7BXd+cxLmZ7C+W/MFcIK9/HqUeH6M1VbAFcWVv/7cr8/X0MzRNeXNd89UTF1tSkRTcA4jqnUMa30VHVISQCmYc1CiojFrtivRrJvVB55iWnANGJ4x59a7NT3uci+1Qjo/Hjbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730505065; c=relaxed/simple;
	bh=s6OXd5I2GrYrEHwNMh+mYZ8cUU3Jq2PipGGmepGS7fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0O9yNFnZMxy55Gb/vzweeanYsN0e1tFYIUhbo83/Sv0hAUrHM3bdMm1tHNDMB1BtGEy4nQPj3Vnrb9diFbOD6sMRKqwUvm4SIIV72mw8kLME8LdPvyrqYmuCHxsdcaNalzxSQV1Zfnujnohr2ua3zW13ksnS9Kv8SJ9p0Ake2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iJJ1pXX5; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 1 Nov 2024 23:50:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730505058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AmIV0z8LXveOpdqQ9bxCW3o7rmXNXV9lBOYS/prXoa0=;
	b=iJJ1pXX56dVy4ENpSza9acqVHSonkI4xZ2phm4hNMVSv94ZcMjEzFGz1W3ZKQljVdvkQb7
	/nHG5hRi5943plxJqwoSLZeH8uNlgvYBXuZbbd/KRdPkf0X/ZbTfq1WrRtjkxTtTaU33zl
	vdoF//MxpkEwonUwhfXMzkpzVM8iXTs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Alexey Gladkov <legion@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>,
	Kees Cook <kees@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [PATCH] signal: restore the override_rlimit logic
Message-ID: <ZyVpXtpAn1YKtXQS@google.com>
References: <20241031200438.2951287-1-roman.gushchin@linux.dev>
 <ZyVkJn2kOJzjPRyJ@example.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyVkJn2kOJzjPRyJ@example.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Nov 02, 2024 at 12:28:38AM +0100, Alexey Gladkov wrote:
> On Thu, Oct 31, 2024 at 08:04:38PM +0000, Roman Gushchin wrote:
> > Prior to commit d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of
> > ucounts") UCOUNT_RLIMIT_SIGPENDING rlimit was not enforced for a class
> > of signals. However now it's enforced unconditionally, even if
> > override_rlimit is set. This behavior change caused production issues.
> > 
> > For example, if the limit is reached and a process receives a SIGSEGV
> > signal, sigqueue_alloc fails to allocate the necessary resources for the
> > signal delivery, preventing the signal from being delivered with
> > siginfo. This prevents the process from correctly identifying the fault
> > address and handling the error. From the user-space perspective,
> > applications are unaware that the limit has been reached and that the
> > siginfo is effectively 'corrupted'. This can lead to unpredictable
> > behavior and crashes, as we observed with java applications.
> > 
> > Fix this by passing override_rlimit into inc_rlimit_get_ucounts() and
> > skip the comparison to max there if override_rlimit is set. This
> > effectively restores the old behavior.
> > 
> > Fixes: d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of ucounts")
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > Co-developed-by: Andrei Vagin <avagin@google.com>
> > Signed-off-by: Andrei Vagin <avagin@google.com>
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > Cc: Alexey Gladkov <legion@kernel.org>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  include/linux/user_namespace.h | 3 ++-
> >  kernel/signal.c                | 3 ++-
> >  kernel/ucount.c                | 5 +++--
> >  3 files changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> > index 3625096d5f85..7183e5aca282 100644
> > --- a/include/linux/user_namespace.h
> > +++ b/include/linux/user_namespace.h
> > @@ -141,7 +141,8 @@ static inline long get_rlimit_value(struct ucounts *ucounts, enum rlimit_type ty
> >  
> >  long inc_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v);
> >  bool dec_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v);
> > -long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type);
> > +long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type,
> > +			    bool override_rlimit);
> >  void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum rlimit_type type);
> >  bool is_rlimit_overlimit(struct ucounts *ucounts, enum rlimit_type type, unsigned long max);
> >  
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index 4344860ffcac..cbabb2d05e0a 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -419,7 +419,8 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
> >  	 */
> >  	rcu_read_lock();
> >  	ucounts = task_ucounts(t);
> > -	sigpending = inc_rlimit_get_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING);
> > +	sigpending = inc_rlimit_get_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING,
> > +					    override_rlimit);
> >  	rcu_read_unlock();
> >  	if (!sigpending)
> >  		return NULL;
> > diff --git a/kernel/ucount.c b/kernel/ucount.c
> > index 16c0ea1cb432..046b3d57ebb4 100644
> > --- a/kernel/ucount.c
> > +++ b/kernel/ucount.c
> > @@ -307,7 +307,8 @@ void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum rlimit_type type)
> >  	do_dec_rlimit_put_ucounts(ucounts, NULL, type);
> >  }
> >  
> > -long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
> > +long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type,
> > +			    bool override_rlimit)
> >  {
> >  	/* Caller must hold a reference to ucounts */
> >  	struct ucounts *iter;
> > @@ -316,7 +317,7 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
> >  
> >  	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
> >  		long new = atomic_long_add_return(1, &iter->rlimit[type]);
> > -		if (new < 0 || new > max)
> > +		if (new < 0 || (!override_rlimit && (new > max)))
> >  			goto unwind;
> >  		if (iter == ucounts)
> >  			ret = new;
> 
> It's a bad patch. If we do as you suggest, it will
> do_dec_rlimit_put_ucounts() in case of overflow. This means you'll
> break the counter and there will be an extra decrement in __sigqueue_free().
> We can't just ignore the overflow here.

Hm, I don't think my code is changing anything in terms of the overflow handling.
The (new < 0) handling is exactly the same as it was, the only difference is
that (new > max) is allowed if override_rlimit is set. But new physically
can't be larger than LONG_MAX, so there is no actual change if the limit
is LONG_MAX.

Maybe I'm missing something here, please, clarify.

Thanks!


