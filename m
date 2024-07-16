Return-Path: <stable+bounces-60286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D13E932F88
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 19:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE6F1F23A8C
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E8319FA94;
	Tue, 16 Jul 2024 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YB9j+Bf6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07D718E28
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152732; cv=none; b=Zj96WnljnnnSN0KHHE5ty5ctIU3hSwIDnSYuoLHQ60C8gTxJdtCOekS8NTwDk22+Tcz0h+mENdi+9aD26WOHxN6sEJkIcPzBQR6H2Nftjp/YCx4ef/1f8G0iD11/yH8TMv2+3zvang7r1wImVIzX0P4FbOMixMxly70eH8hF9b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152732; c=relaxed/simple;
	bh=GeHrno/kdLPrWzBwMd/E/ksqLarjIUlGU/Z85R7mBec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ja9GifpRSfmDTI1aTIvMRkbawqPqyBN6oGY1G+LBsZ+I9MBInsIXrjzMSc6ILcV2mHtN2f3PJj4xAwXnjW1YCyqFWjT0mz4qwaH2CDDE3KRUA7pL3++1QSMuRXt8Cj5KIuBreWAwpC6hTg08mqwKMTrIuekTXTMbX2jDsKT3fVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YB9j+Bf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223A9C116B1;
	Tue, 16 Jul 2024 17:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721152732;
	bh=GeHrno/kdLPrWzBwMd/E/ksqLarjIUlGU/Z85R7mBec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YB9j+Bf6sMuhQuE9oFFiFuYJ+IXLrQH0AyzYF4QiOthN6F/7spzL7QC2+jUv2XYVV
	 01QDqgDM3jYWuiffjJDdcou9EE/T+T0Md9me0UaMKNhqJ+19mD9elXBOFiXU6FJc0X
	 K0cioxVjl1WTt674idOBAYLtCftfdhJm+DQdHJwMZQDCadxhjHv5iF2kNk1nUARpFy
	 xAU7uOR7s3FLUPf5mHSZtJ/0o4/F+liyFmmM9PjrcHa65bPMJHfDIg/KuT5h1vYzFg
	 I28jhDelfHQQfATKWcXsMD4lxre7cX3bi2strlQp4XueDl0t/7kkh7vLGgvj3akYgR
	 HUuSP3sQjpJLA==
From: SeongJae Park <sj@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: merge regions aggressively when max_nr_regions" failed to apply to 6.1-stable tree
Date: Tue, 16 Jul 2024 10:58:49 -0700
Message-Id: <20240716175849.51658-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2024071625-bless-undivided-0af3@gregkh>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Jul 2024 09:16:19 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, Jul 15, 2024 at 12:59:45PM -0700, SeongJae Park wrote:
> > On Mon, 15 Jul 2024 19:12:29 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > > On Mon, Jul 15, 2024 at 09:57:17AM -0700, SeongJae Park wrote:
> > > > Hi Greg,
> > > > 
> > > > On Mon, 15 Jul 2024 13:34:48 +0200 <gregkh@linuxfoundation.org> wrote:
> > > > 
> > > > > 
> > > > > The patch below does not apply to the 6.1-stable tree.
> > > > > If someone wants it applied there, or to any other stable or longterm
> > > > > tree, then please email the backport, including the original git commit
> > > > > id to <stable@vger.kernel.org>.
> > > > > 
> > > > > To reproduce the conflict and resubmit, you may use the following commands:
> > > > > 
> > > > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > > > > git checkout FETCH_HEAD
> > > > > git cherry-pick -x 310d6c15e9104c99d5d9d0ff8e5383a79da7d5e6
> > > > 
> > > > But this doesn't reproduce the failure on my machine, like below?
> > > > 
> > > >     $ git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > > >     [...]
> > > >     $ git checkout FETCH_HEAD
> > > >     [...]
> > > >     HEAD is now at cac15753b8ce Linux 6.1.99
> > > >     $ git cherry-pick -x 310d6c15e9104c99d5d9d0ff8e5383a79da7d5e6
> > > >     Auto-merging mm/damon/core.c
> > > >     [detached HEAD ecd04159c5f3] mm/damon/core: merge regions aggressively when max_nr_regions is unmet
> > > >      Date: Mon Jun 24 10:58:14 2024 -0700
> > > >      1 file changed, 19 insertions(+), 2 deletions(-)
> > > 
> > > Try building it:
> > > 
[...]
> > > mm/damon/core.c:946:29: note: in expansion of macro \u2018max\u2019
> > >   946 |                 threshold = max(1, threshold * 2);
> > >       |                             ^~~
> > > cc1: all warnings being treated as errors
> > > make[3]: *** [scripts/Makefile.build:250: mm/damon/core.o] Error 1
> > > make[2]: *** [scripts/Makefile.build:503: mm/damon] Error 2
> > > make[1]: *** [scripts/Makefile.build:503: mm] Error 2
> > 
> > Thank you for sharing this.
> > 
> > I found the issue can be fixed in two ways.  I'd like to know what way you'd
> > prefer.
> > 
> > The first way is adding below simple fix to mm/damon/core.c file.
> > 
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -943,7 +943,7 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
> >                         damon_merge_regions_of(t, threshold, sz_limit);
> >                         nr_regions += damon_nr_regions(t);
> >                 }
> > -               threshold = max(1, threshold * 2);
> > +               threshold = max(1U, threshold * 2);
> >         } while (nr_regions > c->attrs.max_nr_regions &&
> >                         threshold / 2 < max_thres);
> >  }
> > 
> > The second way is adding upstream commits that avoids the warning of DAMON code
> > on >=6.6 kernels.  Specifically, commit 867046cc7027 ("minmax: relax check to
> > allow comparison between unsigned arguments and signed constants") is needed.
> > However, the commit cannot cleanly cherry-picked on its own.  Cherry-picking
> > the commit together with below commits (listed latest one first) made all
> > commits cleanly be picked and the warning disappears.
> > 
> > 4ead534fba42 minmax: allow comparisons of 'int' against 'unsigned char/short'
> > d03eba99f5bf minmax: allow min()/max()/clamp() if the arguments have the same signedness.
> > 2122e2a4efc2 minmax: clamp more efficiently by avoiding extra comparison
> > 5efcecd9a3b1 minmax: sanity check constant bounds when clamping
> 
> I just tried the above, and then added your commit, but I still get the
> same build error.  Did you try it?

Yes, I tried and confirmed that on my machine.  I'm wondering if you applied
only the four patches on the above list?  To fix the warning, the commit
867046cc7027 ("minmax: relax check to allow comparison between unsigned
arguments and signed constants") should also be applied on top of those.

Nonetheless, with more testing, I found it causes yet another error on my kunit
build.  It required further picking commit f6e9d38f8eb0 ("minmax: fix header
inclusions") to fix it.

> 
> I would love to get the minmax stuff properly backported to 6.1 (and
> older if possible), as we have run into this same issue with many
> changes over the years.

Yes, I agree.

> 
> > Same warning happens on 5.15.y.  In the case, adding the minmax.h upstream
> > commits only adds more build errors.  To remove those, yet another upstream
> > commit, namely commit a49a64b5bf19 ("tracing: Define the is_signed_type() macro
> > once") need to be cherry-picked.
> > 
> > IMHO, the second way is more complex but right for long term, since future
> > commits for stable tree may also have similar issue.  It is not a strong
> > opinion, and either ways work for me.
> > 
> > So, Greg, what would you prefer?
> 
> I would prefer the second way, IF it works.  In my limited testing right
> now, I couldn't get it to work at all.  Can you send a series of
> backported patches that work for you so that I ensure that I'm not just
> doing something stupid on my end?

Thank you for the kind and clear answer.  I just posted the patches:
https://lore.kernel.org/20240716175205.51280-1-sj@kernel.org

Please let me know if it still not works.


Thanks,
SJ

[...]

