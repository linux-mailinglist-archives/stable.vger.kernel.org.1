Return-Path: <stable+bounces-65242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD63944D6A
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 15:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6571C2438C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 13:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0701A4878;
	Thu,  1 Aug 2024 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7UR5uXY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72602189B98;
	Thu,  1 Aug 2024 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520088; cv=none; b=PPDm1Vl5/z5zAHkRGQq6X8YDT0SsEJ/UjmUchtRrCKRKLmgaQEbK8omvT4bMiBkDdTsLFcUBtC1dG9ytCOZnhLx6XfDRsawFBMa2d4USr4qmqFNjuDmIB4z5uysWL7wHed8xXAw0KFdcWNw3/mUl4kWNxU1AzveaWXQgzezJepg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520088; c=relaxed/simple;
	bh=v1Ep6fFQZWMoGRw+MSU0AWMNyuB/Z6gj+KXf6mF1Jfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KreptJ+0hEqaAJjb2I/GAWHU5Y3ubu0b4Vtck7ctDaGMJKeEy8W5qAR4IkbqKCyXPSDlEsnubn2tNjqMUDiJPVfhOIW68g1xVExmVw5zvoaQAfhRZI9B2mQ2knowO2FvmRcHq+snawW2cSLUH5s3BXIP3W9SfgqxMzpkgktpadY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7UR5uXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9067C4AF0A;
	Thu,  1 Aug 2024 13:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722520088;
	bh=v1Ep6fFQZWMoGRw+MSU0AWMNyuB/Z6gj+KXf6mF1Jfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y7UR5uXY4Jd+TGm+hIYAM67JruTOhNzL4CtFCMQ/P+sDyuuvMEbnvbDsG+jReJJyX
	 l8eI+NwGpTfqwAKHgN3GtwxMStWJUCC/jQycDv4Cwng//YwXTeZSghg9UIPybdr7Pl
	 QLlHCpIlxkZgYF7st8boloSe8JF3kqgdFBHoveUj+NSJUODPLKLo66jche1R6ZELtj
	 ZRWVstIL7o8cuiuaCyWao59HXPPBxoN11UAWCdqKm9wFQ/XhhRw/O7g2zC/eIB64uf
	 14q+2NwcLuMDeuxO/iwFTIlngAx4yIKG/uSkKsFBlL2Wg5vlET1VAP27ue3dpfHLOb
	 FUjozeEi2mqvw==
Date: Thu, 1 Aug 2024 15:48:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aleksa Sarai <cyphar@cyphar.com>, Tycho Andersen <tandersen@netflix.com>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Tejun Heo <tj@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] pidfd: prevent creation of pidfds for kthreads
Message-ID: <20240801-clever-mitleid-da9b4142edde@brauner>
References: <20240731-gleis-mehreinnahmen-6bbadd128383@brauner>
 <20240731145132.GC16718@redhat.com>
 <20240801-report-strukturiert-48470c1ac4e8@brauner>
 <20240801080120.GA4038@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801080120.GA4038@redhat.com>

On Thu, Aug 01, 2024 at 10:01:20AM GMT, Oleg Nesterov wrote:
> OK, I won't argue, but ....
> 
> On 08/01, Christian Brauner wrote:
> >
> > On Wed, Jul 31, 2024 at 04:51:33PM GMT, Oleg Nesterov wrote:
> > > On 07/31, Christian Brauner wrote:
> > > >
> > > > It's currently possible to create pidfds for kthreads but it is unclear
> > > > what that is supposed to mean. Until we have use-cases for it and we
> > > > figured out what behavior we want block the creation of pidfds for
> > > > kthreads.
> > >
> > > Hmm... could you explain your concerns? Why do you think we should disallow
> > > pidfd_open(pid-of-kthread) ?
> >
> > It basically just works now and it's not intentional - at least not on
> > my part. You can't send signals to them,
> 
> Yes, you can't send signals to kthread. So what?
> 
> You can't send signals to the normal processes if check_kill_permission()
> fails. And even if you are root, you can't send an unhandled signal via
> pidfd = pidfd_open(1).
> 
> > you may or may not get notified
> > via poll when a kthread exits.
> 
> Why? the exiting kthread should not differ in this respect?

Why do you want to allow it? I see zero reason to get a reference to a
kthread if there's no use-case for it. kthreads are mostly a kernel
thing so why give userspace handles to it. And as I said before, there's
userspace out there that's already confused why they can get references
to them in the first place.

> 
> > (So imho this causes more confusion then it is actually helpful. If we
> > add supports for kthreads I'd also like pidfs to gain a way to identify
> > them via statx() or fdinfo.)
> 
> /proc/$pid/status has a "Kthread" field...

Going forward, I don't want to force people to parse basic stuff out of
procfs. Ideally, they'll be able to mostly rely on pidfd operations
only.

