Return-Path: <stable+bounces-171924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6E7B2E4E8
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 20:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9343516B136
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 18:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFFD2773DC;
	Wed, 20 Aug 2025 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTJAijor"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BA03EA8D;
	Wed, 20 Aug 2025 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755714459; cv=none; b=WU4JfKkzK2n/LTmgS/5wjDBVo/dmKw0A/0XGUsNc8BdZ+baziPTJ+8bpIXZCvjnYS+M04enuOBoZSVgehY69hPJ2mW3PYnBLuvOHjUDW+S9ESJv5qCU231X4FY12I/xQVMqv/HL2P5Gka97WJaX9dSvvP3MdTP7tIAwSIN3uSuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755714459; c=relaxed/simple;
	bh=oFLkheXmHC67SEen1WsTdZ0OtW3OuMfl/32fOXPzKa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kc8GvL/xEz44bMExSc0ZrgQS9RHNId278lchGiLhjEdoXl+jDUPgvUS3oXY2RtmLzfX407q/bGySr7jtBknkI3wCznjbPsp1Eo1pBm4E83zDfBE+f+YdC1kCZNjJ58nLJXkbMMPcPL8m7xbIXBCr+RFENl4ejEufFbDLmtPwt18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTJAijor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955E2C4CEE7;
	Wed, 20 Aug 2025 18:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755714458;
	bh=oFLkheXmHC67SEen1WsTdZ0OtW3OuMfl/32fOXPzKa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTJAijor/+hjR+u7n9UGW05n8/Cp6dxDGnfIHh+1uFNiFtyOIE4cxhPYy61jb5s/P
	 KaRxK2srhuQmodhMj2ECrqXgjf4ba+vLUpWvIaU76lqKs0J8U8FSZOf+jT1FxdSafk
	 ia20F4FKWkNM0sZdV4OnXHjN02qGXRG/JjtzgCGWZ2VHna9Xt1Xh7VwmO38OiYqtTe
	 0+Wsj67S3gpV7kPXOvsD3DBzj76CXVX+ZnjFAWLVnpEyoisqHnO3yZUXUepUUtGHrE
	 5XUxeyFvTG3NPR6e2z1F1cH4WvWsDmGBko5gQSHEnYCIRn/b78NgcCbBk5W/VtddLX
	 LmDjl/dHsXFvQ==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/core: set quota->charged_from to jiffies at first charge window
Date: Wed, 20 Aug 2025 11:27:36 -0700
Message-Id: <20250820182736.84941-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CABFDxMHpodpNQM_a=T0vf48k486mYqukCVnQPbanLh+G_HH+9g@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 20 Aug 2025 22:18:53 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Hello, SeongJae
> 
> On Wed, Aug 20, 2025 at 2:27 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Wed, 20 Aug 2025 00:01:23 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> >
> > > Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
> > > include/linux/jiffies.h
> > >
> > > /*
> > >  * Have the 32 bit jiffies value wrap 5 minutes after boot
> > >  * so jiffies wrap bugs show up earlier.
> > >  */
> > >  #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
> > >
> > > And they cast unsigned value to signed to cover wraparound
> >
> > "they" sounds bit vague.  I think "jiffies comparison helper functions" would
> > be better.
> 
> I agree, I will change it.
> 
> > >
> > >  #define time_after_eq(a,b) \
> > >   (typecheck(unsigned long, a) && \
> > >   typecheck(unsigned long, b) && \
> > >   ((long)((a) - (b)) >= 0))
> > >
> > > In 64bit system, these might not be a problem because wrapround occurs
> > > 300 million years after the boot, assuming HZ value is 1000.
> > >
> > > With same assuming, In 32bit system, wraparound occurs 5 minutues after
> > > the initial boot and every 49 days after the first wraparound. And about
> > > 25 days after first wraparound, it continues quota charging window up to
> > > next 25 days.
> >
> > It would be nice if you can further explain what real user impacts that could
> > make.  To my understanding the impact is that, when the unexpected extension of
> > the charging window is happened, the scheme will work until the quota is full,
> > but then stops working until the unexpectedly extended window is over.
> >
> > The after-boot issue is really bad since there is no way to work around other
> > than reboot the machine.
> 
> I agree with your point that user impact should be added to commit
> messages. Before modifying the commit message, I want to check that my
> understanding of "user impact" is correct.

I think you should make clear at least you believe you understand the
consequences of your patches including user impacts before sending your patches
without RFC tag.  I'd suggest you to take more time on making such
preparational confidences and/or discussions _before_ sending non-RFC patches.
You're nver lagging.  Take your time.

> 
> In the logic before this patch is applied, I think
> time_after_eq(jiffies, ...) should only evaluate to false when the MSB
> of jiffies is 1 and charged_from is 0. because if charging has
> occurred, it changes charge_from to jiffies at that time.

It is not the only case that time_after_eq() can be evaluated to false.  Maybe
you're saying only about the just-after-boot running case?  If so, please
clarify.  You and I know the context, but others may not.  I hope the commit
message be nicer for them.

> Therefore,
> esz should also be zero because it is initialized with charged_from.
> So I think the real user impact is that "quota is not applied", rather
> than "stops working". If my understanding is wrong, please let me know
> what point is wrong.

Thank you for clarifying your view.  The code is behaving in the way you
described above.  It is because damon_set_effective_quota(), which sets the
esz, is called only when the time_after_eq() call returns true.

However, this is a bug rather than an intended behavior.  The current behavior
is making the first charging window just be wasted without doing nothing.

Probably the bug was introduced by the commit that introduced esz.

> 
> > >
> > > Example 1: initial boot
> > > jiffies=0xFFFB6C20, charged_from+interval=0x000003E8
> > > time_after_eq(jiffies, charged_from+interval)=(long)0xFFFB6838; In
> > > signed values, it is considered negative so it is false.
> >
> > The above part is using hex numbers and look like psuedo-code.  This is
> > unnecessarily difficult to read.  To me, this feels like your personal note
> > rather than a nice commit message that written for others.  I think you could
> > write this in a much better way.
> >
> > >
> > > Example 2: after about 25 days first wraparound
> > > jiffies=0x800004E8, charged_from+interval=0x000003E8
> > > time_after_eq(jiffies, charged_from+interval)=(long)0x80000100; In
> > > signed values, it is considered negative so it is false
> >
> > Ditto.
> 
> Okay, I think I can fix these sections with explanation using MSB.

Also please make it easier to read for more human people.

> 
> > >
> > > So, change quota->charged_from to jiffies at damos_adjust_quota() when
> > > it is consider first charge window.
> > >
> > > In theory; but almost impossible; quota->total_charged_sz and
> > > qutoa->charged_from should be both zero even if it is not in first
> >
> > s/should/could/ ?
> 
> Sorry for my poor english.
> 
> > Also, explaining when that "could" happen will be nice.
> 
> I want to confirm this situation as well. I think the situation below
> is the only case.

Again, if there is anything unclear, let's do discussions before sending
non-RFC patches.

> 
> 1. jiffies overflows to exactly 0
> 2. And quota is configured but never actually applied, so total_charged_sz is 0

Or, total_charged_sz is also overflows and bcome 0.

> 3. And charging occurs at that exact moment.

It's not necessarily when charging occurs but when damon_adjust_quota() is
called.  More technically speaking once per the scheme's apply interval.

> 
> Is that right? If right, I think this situation is almost impossible
> and uncommon. I feel like It's unnecessary to describe it. I'm not
> trying to ignore your valuable opinion, but do you still think it's
> better to add a description?

I'm ok to completely drop the explanation.  But if you are gonna mention it
partially, please clarify.

> 
> > > charge window. But It will only delay one reset_interval, So it is not
> > > big problem.
> > >
> > > Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for schemes application speed control") # 5.16
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> >
> > I think the commit message could be much be improved, but the code change seems
> > right.
> 
> Once again, Sorry for my poor english. I'm doing my best on my own.

This is not about English skill but the commit "message".  Your English skill
is good and probably betetr than mine.  But I ad a difficult time at reviewing
your patch, and feeling it could been easier if the message was nicer.

So what I'm saying is that I tink this patch's commit message can be more nice
to readers.


Thanks,
SJ

[...]

