Return-Path: <stable+bounces-180804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A05B8DB64
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815EC17DAF4
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AE62459D1;
	Sun, 21 Sep 2025 12:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xjWiWli0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FE212F5A5
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758459342; cv=none; b=RBsbcSM4L1AKIyx5l8HgHdMdLe/kdpgSoh6k/Fp0qmT26pyH/ySA+jq8inQ8D/f2e+yegyRSsaXdnUlxzGgBXBadze7+RFn6fY6c+32mvIhvYRPpE8jQBJK03IxA29GwsBwthW1DmGGvOTF/1t2Ywtf5MlTHzBtr02lIrgog0Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758459342; c=relaxed/simple;
	bh=VLNpx+xJGlJRQSF7vcTZuODghQAC3QJooinOdd0dFLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEZlTWqwB56jTUuyYkofAOdge9NAZc2/SY7sN3i7TRq5Lfjx/qfWrUVJPaRDciRZ8hfRrsYh0J+wMalyfhzO07tp3FowMnGqGLAgR6EUnsfwpfy54pLGvmUoLB1Hxcr9bWicvW0QsIBBBHUwX5EjH+FOcu72i2cybdScPhfKxn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xjWiWli0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D6DC4CEE7;
	Sun, 21 Sep 2025 12:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758459342;
	bh=VLNpx+xJGlJRQSF7vcTZuODghQAC3QJooinOdd0dFLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xjWiWli0IeFWmFCuOSlZSjjNKtNWiz+NgsHbJzNyqLAJqJsfarsZ8d4evIjWnXWcF
	 cqEjDSCXyeoFYKxNZR7utabd0etKrpuipMc5yr+6rSW/SMMGxpmUeLql0Wpj+HtaKv
	 dqrPX09p1bn2V6PZ2EKEDXkKofueN23EgldRFWQU=
Date: Sun, 21 Sep 2025 14:55:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: thaler@thaler.hu, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: include dying ring in task_work
 "should cancel"" failed to apply to 6.6-stable tree
Message-ID: <2025092133-frostily-regulator-644c@gregkh>
References: <2025092127-emit-dean-5272@gregkh>
 <05a536f3-6e28-4cea-b07c-780085973658@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05a536f3-6e28-4cea-b07c-780085973658@kernel.dk>

On Sun, Sep 21, 2025 at 06:45:22AM -0600, Jens Axboe wrote:
> On 9/21/25 6:32 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 3539b1467e94336d5854ebf976d9627bfb65d6c3
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092127-emit-dean-5272@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> 
> Ditto on the 6.6-stable side.

Now applied, thanks.

greg k-h

