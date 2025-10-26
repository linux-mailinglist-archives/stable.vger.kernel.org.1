Return-Path: <stable+bounces-189862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBE4C0ABB1
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD473B343F
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D35C2ED165;
	Sun, 26 Oct 2025 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eK2FeNPg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7801DF99C
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761490664; cv=none; b=BVq81FREc/kXCMsq8byKvlgoUxtyiElKDQ1XHt5ZqciN6BumCEY9DhPsd6H9VPkGrtA8k5yNhvLzVs1KpU7E7SGIWVu+J6RPYHo2POjXByODVt6GHDpK/jzUJnuetOWx+0cGK2wOWWz1/pjZZNWbZP9DM/Ed/vTAhblwuwqX4oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761490664; c=relaxed/simple;
	bh=fVp/L4bNBUBGUXKR+FjTMeGX6N5jSwmIYwX9Ks2UHjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QA3tU7PY8AlnRSJXXx4G0Zuu43fmtApAKw1+90/CO6SVIjX0eh5wQh39aQ708tOJ4KyRrLfkZ9IKN6gZlMn21Qoxa+pgM+MiWlZzx/35zHsWrQUCwmeqV9PqlJkviE4gor5L4GD/Lag0LrtMVkGkMeRgz/JLVPGV5imTig/tzdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eK2FeNPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21FBC4CEE7;
	Sun, 26 Oct 2025 14:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761490664;
	bh=fVp/L4bNBUBGUXKR+FjTMeGX6N5jSwmIYwX9Ks2UHjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eK2FeNPgJmKr5QgjUQeptZpbvEBWAFIjwNLtNnX/NWouW8Qmu0pbR4zQy+dOTMz/R
	 3vvdLfpx9M4B628wwPhZsjcYZFUSEifzttAV4QGwEcKLukHvtG/ERRcv7kE/0vb2fg
	 DuZNyVDXgT/7FD1nv4BHiNDjYw+4e/AZLWf4m/8s=
Date: Sun, 26 Oct 2025 15:56:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: changfengnan@bytedance.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/sqpoll: be smarter on when to
 update the stime usage" failed to apply to 6.12-stable tree
Message-ID: <2025102639-language-slacking-913e@gregkh>
References: <2025102618-plastic-eldercare-f957@gregkh>
 <27aac3f8-06e7-4320-9410-30071e8cc447@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27aac3f8-06e7-4320-9410-30071e8cc447@kernel.dk>

On Sun, Oct 26, 2025 at 08:28:07AM -0600, Jens Axboe wrote:
> On 10/26/25 8:22 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x a94e0657269c5b8e1a90b17aa2c048b3d276e16d
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102618-plastic-eldercare-f957@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> 
> And here's this one, just a single fuzzed commit after patch 1 got
> applied.

Both now queued up, thanks.

greg k-h

