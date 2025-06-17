Return-Path: <stable+bounces-152863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1ADADCE65
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F121792A2
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D5B2E06D9;
	Tue, 17 Jun 2025 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WBzq/1Tz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F8C28D85F;
	Tue, 17 Jun 2025 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168540; cv=none; b=D1uiuZAShKs7hRNSkPGKAt3+K7cJPrxCBIpN0nBYXUchXcbnCZeH/zGgjhC0ZY+9RvcmBXncrWwzcFkIRG4RfEO+sy4D1oRtYTferOJ71Dxy9zDDv2wzava0DT7DX/kjv+YuSbJ3M/9TT/AJM/M4vvAI1ez75ju4XHKdeldQf+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168540; c=relaxed/simple;
	bh=RqrNnIEvgWWx+6RBJEEqQrNxBks+dMkYMUTBqrCW+Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoJ07a+Myqtxfp016J8S4ZmsjCR/1EGYyy6GezqWbvq2BJt0t3sv+R61zas98VHzABKsXvjbUkDGtCgLJEuxACbxnaMNv7uJNkjh+A3QpnaQzLaWkvYHUwwXHG4LrgqYZzkKVKw/UFTMwREQpkwJwVgMa5ZRm6HW+bAzFWobNsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WBzq/1Tz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32334C4CEE7;
	Tue, 17 Jun 2025 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750168540;
	bh=RqrNnIEvgWWx+6RBJEEqQrNxBks+dMkYMUTBqrCW+Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBzq/1TzxYjDKsFFnMbZ2U5lW+CkeL6f1Qs0L9rNTti2UNUtomDiURAzi7an/ZFZc
	 LDqUHxphXUTW4+lghznirJHy/FfhKKo3b/WTycYvgQKI3CqzhF0Oolx8UR8RYZ6Jx2
	 hryE9j85nb8l5xOcpLTkXovZ2HmCshb8SgfrbPLo=
Date: Tue, 17 Jun 2025 15:55:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>, stable@vger.kernel.org,
	stable-commits@vger.kernel.org, petrm@mellanox.com,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: Patch "net: sch_ets: Add a new Qdisc" has been added to the
 5.4-stable tree
Message-ID: <2025061736-laurel-anointer-4232@gregkh>
References: <20250615131317.1089541-1-sashal@kernel.org>
 <871prjvl32.fsf@nvidia.com>
 <CAM_iQpW5m37WH5sKyEHemq8oJLDYWbakWpqGo51bAFpjYyC1wA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM_iQpW5m37WH5sKyEHemq8oJLDYWbakWpqGo51bAFpjYyC1wA@mail.gmail.com>

On Mon, Jun 16, 2025 at 06:07:02PM -0700, Cong Wang wrote:
> On Mon, Jun 16, 2025 at 7:05 AM Petr Machata <petrm@nvidia.com> wrote:
> >
> >
> > Sasha Levin <sashal@kernel.org> writes:
> >
> > > This is a note to let you know that I've just added the patch titled
> > >
> > >     net: sch_ets: Add a new Qdisc
> > >
> > > to the 5.4-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > >
> > > The filename of the patch is:
> > >      net-sch_ets-add-a-new-qdisc.patch
> > > and it can be found in the queue-5.4 subdirectory.
> > >
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> >
> > Not sure what the motivation is to include a pure added feature to a
> > stable tree. But if you truly want the patch, then there were a couple
> > follow up fixes over the years. At least the following look like patches
> > to code that would be problematic in 5.4.y as well:
> 
> I blindly guess it got accidentally pulled into -stable due to Fixes tag?
> 
> Could we drop this please?

Now dropped.

thanks,

greg k-h

