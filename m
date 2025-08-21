Return-Path: <stable+bounces-171938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E13B2EB7D
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 04:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED2B5C895D
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 02:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058F62D3A70;
	Thu, 21 Aug 2025 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEsqq8BG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FDF8F54;
	Thu, 21 Aug 2025 02:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744866; cv=none; b=fCUx71TX3pAcdmCEPArhFgied8Fcq22+MqHKGRx0TgbXLvPQoop1x8xA9c7VVmWOcofP6HAuHSCvxTIHiTRekG0evMykMGK8H+M2el5Ta3ooVQlqcPUpf3zTsEYcXH63J19oDLkGBTa1dQvnq/gQzTWSXDjTXDJKbWwZAo9oGP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744866; c=relaxed/simple;
	bh=P/5DA2YXUnnCAFwd9glDmvY4JJh67YYsK3KUN4QtTFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llGyY+TKd7eFhb3jbipxW7fLtz8M6+NzmU1VOYW/FgD1gVS7bHqnv1AvqZrkcXXmM4R09ide6pvBTiKEdbOaQeJa89t/ZBy3wna4B6bMNs76ClAnXeMgJ1QGglmW3ooqTNbmF6lB89515yFXAGkgEymqGr5v7IctzCv0yy6YIcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEsqq8BG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D86EC4CEE7;
	Thu, 21 Aug 2025 02:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755744866;
	bh=P/5DA2YXUnnCAFwd9glDmvY4JJh67YYsK3KUN4QtTFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gEsqq8BG/DgPqtk+i+MUuoKFnLMBzvPIGS+eX3liXI0zEKyE+EwBb7kc8qDtp6+TZ
	 TphawouewPsfO+JYyZtIfRKk2uZECRPkY35xd2GNLo+gnzHqj+BXJ6CHk6U/D4BSbl
	 ymMIZQOlKTmaSI330015H1ZGnMAe7eMqNSdlA8DvXlxQyXHx4kOzx6QHinfYSL2vkx
	 RCOF0LIpSb5dO9oNvluZFk0/YPlfmWm6C9HYL5youDHjNCN/6wZOOx+lh9FxOLAdLN
	 mqcZtXTic9K+Ka2CQza54k5YBP8Rv3dCEKLPB/r6qevkZmgbKqhDD0oARSx5fGJJru
	 CMuPgNDBMfPGQ==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/core: set quota->charged_from to jiffies at first charge window
Date: Wed, 20 Aug 2025 19:54:23 -0700
Message-Id: <20250821025423.90825-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CABFDxMGmVgswVoZFgBz=7xqA59M7fMt0jw2QHqWjm-W9tZktWg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 10:08:03 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> On Thu, Aug 21, 2025 at 3:27 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Wed, 20 Aug 2025 22:18:53 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> >
> > > Hello, SeongJae
> > >
> > > On Wed, Aug 20, 2025 at 2:27 AM SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > On Wed, 20 Aug 2025 00:01:23 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
[...]
> I think that I checked about user impact already but it should be
> insufficient. As you said, I should discuss it first. Anyway, the
> whole thing is my mistake. I'm really so sorry.

Everyone makes mistakes.  You don't need to apologize.

> 
> So, Would it be better to send an RFC patch even now, instead of
> asking on this email thread? (I'll make next v3 patch with RFC tag,
> it's not question of v3 direction and just about remained question on
> this email thread)

If you unsure something and there is no reason to send a patch without a
discussion for the point, please discuss first.  To be honest I don't
understand the above question at all.

> 
> > >
> > > In the logic before this patch is applied, I think
> > > time_after_eq(jiffies, ...) should only evaluate to false when the MSB
> > > of jiffies is 1 and charged_from is 0. because if charging has
> > > occurred, it changes charge_from to jiffies at that time.
> >
> > It is not the only case that time_after_eq() can be evaluated to false.  Maybe
> > you're saying only about the just-after-boot running case?  If so, please
> > clarify.  You and I know the context, but others may not.  I hope the commit
> > message be nicer for them.
> 
> I think it is not just-after-boot running case also whole and only
> case, because charging changes charged_from to jiffies. if it is not
> the only case, could you please describe the specific case?

I don't understand the first sentence.  But...

I mean, time_after_eq() can return false for many cases including just when the
time is before.  Suppose a case that the first and the second arguments are,
say, 5000 and 7000.

> 
> > > Therefore,
> > > esz should also be zero because it is initialized with charged_from.
> > > So I think the real user impact is that "quota is not applied", rather
> > > than "stops working". If my understanding is wrong, please let me know
> > > what point is wrong.
> >
> > Thank you for clarifying your view.  The code is behaving in the way you
> > described above.  It is because damon_set_effective_quota(), which sets the
> > esz, is called only when the time_after_eq() call returns true.
> >
> > However, this is a bug rather than an intended behavior.  The current behavior
> > is making the first charging window just be wasted without doing nothing.
> >
> > Probably the bug was introduced by the commit that introduced esz.
> 
> Thanks for your explanation. I'll try to cover this point in the next
> patch as well.

If you gonna send a patch for fixing this bug, make it as a separate one,
please.

[...]
> > So what I'm saying is that I tink this patch's commit message can be more nice
> > to readers.
> 
> You're right. I'll try to make the commit message more clear. I'm
> really sorry for bothering you.

Again, you don't need to apologize.


Thanks,
SJ

[...]

