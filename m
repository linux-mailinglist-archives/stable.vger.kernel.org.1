Return-Path: <stable+bounces-179557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514A3B56720
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 08:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B968E1A21CE9
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 06:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AF525C822;
	Sun, 14 Sep 2025 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oABnD2WI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F7A23B616;
	Sun, 14 Sep 2025 06:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757832427; cv=none; b=Dlh/XeXY8XYNqOf5BZzw90z2+r+EfeOfjKFu0G6LkdY+NoaS29PobWbt26qBv2Z04lB/BGZy7V9EpiZTqauSUhB1Bla6D8ebYvUS0MDXKTYRhNlucK4nON68BBf89Opv70XLWGD53eyEie8urFAAEthlK/d8iEUd2q6wStBdq2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757832427; c=relaxed/simple;
	bh=ngd42q6af0I6yj6kQcs47JogyuSAQZidJb5hPUi99xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xqn83pdOwOdq885PMBaylYKBuL/KvvqXy2Bisipd5FUhq5qfTTgZvEx7cG4tWGS3Q3lGImmtuU89pTEaCN5qXdCAjjm0BhuhvNPrG5SkYmeNohh4N/M3jRib7A25q11oXNvX4wr9mYWhUAHPseSh7yNItilyRlPQB4hZNHRAxes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oABnD2WI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB574C4CEF0;
	Sun, 14 Sep 2025 06:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757832426;
	bh=ngd42q6af0I6yj6kQcs47JogyuSAQZidJb5hPUi99xQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oABnD2WIh304JhRQRMbM7saDpmUlIVsRdBjAlxabhr9GYcyJ7cmsbnc0TBFSJfM7C
	 oNYu/4XiB2RWsrpzqz0vVEDcpsMxXGpnm85/8zlW4jqcXTM2VQUHJBhUJL1hhGqoxb
	 fu5mQCAuRv7DcwbYzZtwoj0wcQ773dvt8/jmd7uw=
Date: Sun, 14 Sep 2025 08:47:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: ekffu200098@gmail.com, akpm@linux-foundation.org,
	stable@vger.kernel.org, damon@lists.linux.dev
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: set quota->charged_from to
 jiffies at first" failed to apply to 5.15-stable tree
Message-ID: <2025091447-stagnant-underwear-b8ff@gregkh>
References: <2025091357-stapling-walrus-d0f7@gregkh>
 <20250914015539.56587-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914015539.56587-1-sj@kernel.org>

On Sat, Sep 13, 2025 at 06:55:39PM -0700, SeongJae Park wrote:
> Hi Greg,
> 
> On Sat, 13 Sep 2025 14:25:57 +0200 <gregkh@linuxfoundation.org> wrote:
> 
> > 
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x ce652aac9c90a96c6536681d17518efb1f660fb8
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091357-stapling-walrus-d0f7@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > ------------------ original commit in Linus's tree ------------------
> > 
> > >From ce652aac9c90a96c6536681d17518efb1f660fb8 Mon Sep 17 00:00:00 2001
> > From: Sang-Heon Jeon <ekffu200098@gmail.com>
> > Date: Fri, 22 Aug 2025 11:50:57 +0900
> > Subject: [PATCH] mm/damon/core: set quota->charged_from to jiffies at first
> >  charge window
> [...]
> > Link: https://lkml.kernel.org/r/20250822025057.1740854-1-ekffu200098@gmail.com
> > Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for schemes application speed control") # 5.16
> 
> The broken commit was introduced from 5.16, so I don't think this commit need
> to be cherry-picked on 5.15.y.  Please let me knwo if I'm missing something or
> there is anything I can help.

You are right, I was too loose in the version ranges here, thanks.

greg k-h

