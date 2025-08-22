Return-Path: <stable+bounces-172465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF03B31FDC
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 18:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18F16665DC
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 15:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3B022688C;
	Fri, 22 Aug 2025 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BW7bMHN+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA0A242D93
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877873; cv=none; b=kBCriSQmqDG+QDq8DzjPyI7a00mUJe9EdLyCZXztzD1Sc/mtHsIkryoo3EnqS/felpt+FONxpir1jkNU11mtnFwDACvZlxw1XwAFPYhfWfSNVMM2FKAB08m0w6XmIRiYvd8Ip7GBWnKh2d9kq2Ei9MOb0W3OEkR7HhPehzqxDlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877873; c=relaxed/simple;
	bh=kcIhzD2CDzQKcU+tbkwXeTd5zPZ9ixLqOwm0JXkUl6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyIQw+zGYrAkzncZiJGbqXaNUxQzzUPceIJn2JGQ55MPQ8L4zrjo0AQ5rOJcz0de4SlJRe/68cwwXvKP1uYopfAglBYo6/K9vFekzaC89V6YQGziM2rE0ANhL9mTn0TvSfZlUm7E1EWB2Xmz144kLwg/Z/l98Qvs8/d7m7jALjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BW7bMHN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D943DC4CEED;
	Fri, 22 Aug 2025 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755877873;
	bh=kcIhzD2CDzQKcU+tbkwXeTd5zPZ9ixLqOwm0JXkUl6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BW7bMHN+43c8Jp7pQ95JT3Q+Y4dc8fCKL8c4LdpeCGUJndu9lugnNR5Xwcf43sCEZ
	 q/HzKy2LgM5eJ7I6buljhK9P7m0n+mS0QR+6jkBQ7Cf1ZpMcFJudlndPj3+LcxJ3x1
	 5kCAyv8BZqAU3vxHFkHaIpZw+0jP6O3ANz0AfFmU=
Date: Fri, 22 Aug 2025 17:51:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alistair Delva <adelva@google.com>
Cc: Sasha Levin <sashal@kernel.org>, Elie Kheirallah <khei@google.com>,
	Frederick Mayle <fmayle@google.com>,
	Cody Schuffelen <schuffelen@google.com>,
	"Cc: Android Kernel" <kernel-team@android.com>,
	Linux Stable maillist <stable@vger.kernel.org>
Subject: Re: 916b7f42b3b3 to 6.12 (was Re: 2a23a4e1159c to 6.12)
Message-ID: <2025082202-civil-appraisal-852a@gregkh>
References: <CANDihLGGcVHO=8uX6+TWciJyXqy6KtRHGgjbAGq4a1hZ36mU8A@mail.gmail.com>
 <2025082206-blubber-ought-421a@gregkh>
 <CANDihLEu2dMMpYdQxJK4q7YAqqiwdroH8J7q+w6FmhX7mcQQuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDihLEu2dMMpYdQxJK4q7YAqqiwdroH8J7q+w6FmhX7mcQQuQ@mail.gmail.com>

On Fri, Aug 22, 2025 at 08:35:07AM -0700, Alistair Delva wrote:
> On Thu, Aug 21, 2025 at 11:32 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Aug 19, 2025 at 03:00:25PM -0700, Alistair Delva wrote:
> > > Dear stable maintainers,
> > >
> > > Please consider cherry-picking 2a23a4e1159c ("kvm:
> > > retrynx_huge_page_recovery_thread creation") to 6.12. It fixes
> > > a problem where some VMMs (crosvm, firecracker, others) may
> > > unnecessarily terminate a VM when -ENOMEM is returned to
> > > userspace for a non-fatal condition.
> >
> > That is not a valid commit in Linus's tree, are you sure it is correct?
> 
> Sorry, the commit is actually 916b7f42b3b3.
 
 Much better, now queued up.

