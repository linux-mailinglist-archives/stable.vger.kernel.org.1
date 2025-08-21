Return-Path: <stable+bounces-171946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA9DB2EDA1
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 07:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DEF16AB35
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 05:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C00258CDF;
	Thu, 21 Aug 2025 05:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZG63smvN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C143156F45;
	Thu, 21 Aug 2025 05:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755754911; cv=none; b=Vk/912t2T8odmpHulhAnSMycnbbX0rW65g4YN91+1m3axXkWVoLOLSb9+CNKzOz7EKtDQyR6WQ+NTfpoZjcoRYXODt2lWus/kuYJGa5/tQCmY4yCq2QqVTx5SlW32iPfJeRoEoVnVBVdA34oA3lehYRRducvDh5L0ondLdEgay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755754911; c=relaxed/simple;
	bh=JMtuIIvFo7J8JQhB3++74nBLvQexz96KHhNj/me0ewA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K24Qduijbid+qhJVIKBpow1yVc64fBjmmv4NcSjC5bp2sF9upgCoDNpTTrgwWMR4qoAEKfUIK/v5K0IcUqFRejcAiKxoWl11Z48ck1OcZpPr4ffyvYRdrXUx3d2wAwiLsWemkx+uj+kObZHnchD/yKZ+nYMhPxgLYQ1mwStFrC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZG63smvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44144C4CEED;
	Thu, 21 Aug 2025 05:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755754910;
	bh=JMtuIIvFo7J8JQhB3++74nBLvQexz96KHhNj/me0ewA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZG63smvNblF919/9nV8D4Hi36RuJURGwi6Upoz20ZjFw5cvdW/YdH/FiYZ+m3faF/
	 3s8oi/b6esDoLbM0iB2VseDM9dkx8e2abm/Xqsd8ViptL1yw6bkyMZ/EhRAFoOJNur
	 GO9ZEYXrxeCk+/e2HRl9G8i5dTWNaCTSdUvZvADIrB0hhBIh3YkbY5nQjFiGdzegDy
	 lIxBLnZyYeKMxCyCnZPRjuRsyiqJ9uo6czKSGihvd4k8/QPeO48wGPZjGjUoU+o7GN
	 HxcdOXeyj548+5xlUyh4kHwqaKHtRk+QJlxbChbludtkb9iCLLf+PZQdTeDjNXuL4m
	 Ui6wIYhSvDHsA==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/core: set quota->charged_from to jiffies at first charge window
Date: Wed, 20 Aug 2025 22:41:48 -0700
Message-Id: <20250821054148.53746-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CABFDxME5ZEAn+6=0GRWybTi-xBzbhhz7U38pMni3SdKjA+Aj-A@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 13:29:04 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> On Thu, Aug 21, 2025 at 11:54 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Thu, 21 Aug 2025 10:08:03 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> >
> > > On Thu, Aug 21, 2025 at 3:27 AM SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > On Wed, 20 Aug 2025 22:18:53 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> > > >
> > > > > Hello, SeongJae
> > > > >
> > > > > On Wed, Aug 20, 2025 at 2:27 AM SeongJae Park <sj@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, 20 Aug 2025 00:01:23 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> > [...]
> > > I think that I checked about user impact already but it should be
> > > insufficient. As you said, I should discuss it first. Anyway, the
> > > whole thing is my mistake. I'm really so sorry.
> >
> > Everyone makes mistakes.  You don't need to apologize.
> >
> > >
> > > So, Would it be better to send an RFC patch even now, instead of
> > > asking on this email thread? (I'll make next v3 patch with RFC tag,
> > > it's not question of v3 direction and just about remained question on
> > > this email thread)
> >
> > If you unsure something and there is no reason to send a patch without a
> > discussion for the point, please discuss first.  To be honest I don't
> > understand the above question at all.
> 
> Ah, I just mean that I need to make a new RFC patch instead of
> replying to this email thread.

Why?

> I'll just keep asking about previous
> comments on this email thread.

You said you will send a new patch instead of replying here, and then now you
are saying you will keep aking to this thread.

I'm confused.

[...]

Ok, I think this discussion is going unnecessarily deep and only wasting our
time at clarifying intention of past sentence.  Meanwhile apparently you
understood my major points.  To repeat, please clarify what is the problem and
user impacts, when and how it happens, and why the solution solves it.

Let's restart.  Could you please rewrite the commit log for this patch and send
the draft as a reply to this?

We can further discuss on the new draft if it has more things to improve.  And
once the discussion is finalized, you can post v4 of this patch with the
updated commit message.


Thanks,
SJ

