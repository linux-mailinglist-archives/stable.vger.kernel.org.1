Return-Path: <stable+bounces-89566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DB69BA09D
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 14:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1FC1F214D3
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 13:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B36B189B88;
	Sat,  2 Nov 2024 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/OvHFbY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1478C17741;
	Sat,  2 Nov 2024 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730555210; cv=none; b=Gx7CD83uskTNJZuiGpdZFMiWP4kJg9jtAuMLKgL6UGQPJHecHkJICtRMufE4C9sohXagEijWNws//ZI3HpFbtkRbBDGm7xX1LkIJ/dtbIX7U0bxSnswPwtLFDnPR80Idy3v/NGX64L54WGDw/4OqdnzWGNtBtRpRxOz4kC5ogcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730555210; c=relaxed/simple;
	bh=6/ztXe5C0kLiKzO+JnaX2nzcCBLJpFZMo7r20PXRidM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUYp39xYkVNQg+nJLruu2UZyfYhC9qTWui/pnMOUIGhE6VPCdURc6oAqOn9cOq+HPBDn1EWBYMKeHtrXDsC6fkLq2MJ3pmV7TJ8OwKOPnmWJesFAl7Bc6/5y3ocEA5oogC3toIFce/jgsqHlRbiFEnVVXh2XSF8zdoMw+LbIpQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/OvHFbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DAEC4CEC3;
	Sat,  2 Nov 2024 13:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730555209;
	bh=6/ztXe5C0kLiKzO+JnaX2nzcCBLJpFZMo7r20PXRidM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/OvHFbYEyCIpYEp71NXenZ8i3H8vfQZRbFKVj30pX1caUnAMiQCk17O9pUbh8uTZ
	 0jrPomoa+6nw3bJHUWkx8soBUMqKUnXpuV8hiEcu4abRm6nKnIzDKto6xp0ljAZLZu
	 ixDAa1Wcq+uYk0oSQdoKSiAMnl098gH81hMTNV+bhhqJYFE1n5OPPzMjH/SD6FzvF2
	 xABEYbwMOfsrxUCTo5mkMnfOm30IhryzQvlsqad+hPKkj3yyFPZWbxxoimXe07m4U+
	 l559zODVp1OIdbTIStkyTIPLVDk/HLAiUkSc50RRHmU0at9S6OJv9GF4mCwXx1pwRZ
	 j8yJMjRzaOkow==
Date: Sat, 2 Nov 2024 14:46:44 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>,
	Kees Cook <kees@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [PATCH] signal: restore the override_rlimit logic
Message-ID: <ZyYtRHECu_LxRsje@example.org>
References: <20241031200438.2951287-1-roman.gushchin@linux.dev>
 <ZyVkJn2kOJzjPRyJ@example.org>
 <ZyVpXtpAn1YKtXQS@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyVpXtpAn1YKtXQS@google.com>

On Fri, Nov 01, 2024 at 11:50:54PM +0000, Roman Gushchin wrote:
> On Sat, Nov 02, 2024 at 12:28:38AM +0100, Alexey Gladkov wrote:
> > On Thu, Oct 31, 2024 at 08:04:38PM +0000, Roman Gushchin wrote:
> > > Prior to commit d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of
> > > ucounts") UCOUNT_RLIMIT_SIGPENDING rlimit was not enforced for a class
> > > of signals. However now it's enforced unconditionally, even if
> > > override_rlimit is set. This behavior change caused production issues.
> > > 
> > > For example, if the limit is reached and a process receives a SIGSEGV
> > > signal, sigqueue_alloc fails to allocate the necessary resources for the
> > > signal delivery, preventing the signal from being delivered with
> > > siginfo. This prevents the process from correctly identifying the fault
> > > address and handling the error. From the user-space perspective,
> > > applications are unaware that the limit has been reached and that the
> > > siginfo is effectively 'corrupted'. This can lead to unpredictable
> > > behavior and crashes, as we observed with java applications.
> > > 
> > > Fix this by passing override_rlimit into inc_rlimit_get_ucounts() and
> > > skip the comparison to max there if override_rlimit is set. This
> > > effectively restores the old behavior.
> > > 
> > > Fixes: d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of ucounts")
> > > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > > Co-developed-by: Andrei Vagin <avagin@google.com>
> > > Signed-off-by: Andrei Vagin <avagin@google.com>
> > > Cc: Kees Cook <kees@kernel.org>
> > > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > > Cc: Alexey Gladkov <legion@kernel.org>
> > > Cc: <stable@vger.kernel.org>
> > > ---
> > >  include/linux/user_namespace.h | 3 ++-
> > >  kernel/signal.c                | 3 ++-
> > >  kernel/ucount.c                | 5 +++--
> > >  3 files changed, 7 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> > > index 3625096d5f85..7183e5aca282 100644
> > > --- a/include/linux/user_namespace.h
> > > +++ b/include/linux/user_namespace.h
> > > @@ -141,7 +141,8 @@ static inline long get_rlimit_value(struct ucounts *ucounts, enum rlimit_type ty
> > >  
> > >  long inc_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v);
> > >  bool dec_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v);
> > > -long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type);
> > > +long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type,
> > > +			    bool override_rlimit);
> > >  void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum rlimit_type type);
> > >  bool is_rlimit_overlimit(struct ucounts *ucounts, enum rlimit_type type, unsigned long max);
> > >  
> > > diff --git a/kernel/signal.c b/kernel/signal.c
> > > index 4344860ffcac..cbabb2d05e0a 100644
> > > --- a/kernel/signal.c
> > > +++ b/kernel/signal.c
> > > @@ -419,7 +419,8 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
> > >  	 */
> > >  	rcu_read_lock();
> > >  	ucounts = task_ucounts(t);
> > > -	sigpending = inc_rlimit_get_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING);
> > > +	sigpending = inc_rlimit_get_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING,
> > > +					    override_rlimit);
> > >  	rcu_read_unlock();
> > >  	if (!sigpending)
> > >  		return NULL;
> > > diff --git a/kernel/ucount.c b/kernel/ucount.c
> > > index 16c0ea1cb432..046b3d57ebb4 100644
> > > --- a/kernel/ucount.c
> > > +++ b/kernel/ucount.c
> > > @@ -307,7 +307,8 @@ void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum rlimit_type type)
> > >  	do_dec_rlimit_put_ucounts(ucounts, NULL, type);
> > >  }
> > >  
> > > -long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
> > > +long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type,
> > > +			    bool override_rlimit)
> > >  {
> > >  	/* Caller must hold a reference to ucounts */
> > >  	struct ucounts *iter;
> > > @@ -316,7 +317,7 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
> > >  
> > >  	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
> > >  		long new = atomic_long_add_return(1, &iter->rlimit[type]);
> > > -		if (new < 0 || new > max)
> > > +		if (new < 0 || (!override_rlimit && (new > max)))
> > >  			goto unwind;
> > >  		if (iter == ucounts)
> > >  			ret = new;
> > 
> > It's a bad patch. If we do as you suggest, it will
> > do_dec_rlimit_put_ucounts() in case of overflow. This means you'll
> > break the counter and there will be an extra decrement in __sigqueue_free().
> > We can't just ignore the overflow here.
> 
> Hm, I don't think my code is changing anything in terms of the overflow handling.
> The (new < 0) handling is exactly the same as it was, the only difference is
> that (new > max) is allowed if override_rlimit is set. But new physically
> can't be larger than LONG_MAX, so there is no actual change if the limit
> is LONG_MAX.
> 
> Maybe I'm missing something here, please, clarify.

I re-read your patch one more time. Sorry. Yes, you're right, i am wrong.
You're just allow overlimit.

But one thing confuses me.

Now the maximum rlimits of the upper userns are being forced. Changing
rlimit to RLIM_INFINITY affects only the current userns and child userns.

But after this patch, this is not the case for RLIMIT_SIGPENDING and
within userns it is possible to ignore the restrictions of upper-level
userns which ruins the whole idea.

I agree with Eric. If you don't need upper-level userns limits, you don't
need to set them.

-- 
Rgrds, legion


