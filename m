Return-Path: <stable+bounces-180880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5C6B8F0FA
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 07:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861CE175DC2
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 05:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE78C23F40D;
	Mon, 22 Sep 2025 05:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E4p6lOGG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAA9188715
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 05:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758520746; cv=none; b=SdzJm1tMkvCtCzPCicbWGuUskF/DIFW/F2PyPiwZ5rFwbGsPrx0M57N67W0Omo7l7RfSEcnI7oGVGcjlNFdcKXurEPzKWEZA0OHLPMiEDzjt5++6TliHLRayMIgYVGBuwyurBULh3BRUmF8+fWu/rmwCPJNZYg/7SpUenLqDeAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758520746; c=relaxed/simple;
	bh=nD6/YGdfYKluGYsTBS+AwB59Iyw9Rmy3PXEJn7gVlpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PG3oIdzQc9S5FtNQgh2OpjaSKlwIoXFGbdP4220SSjFYhGuvLAA3WlbE7XUi9g4x6F686igd5lLrmp+UiYOgRSQ/58DU/nSmomzy0brPJVvDbOzxnxsvVnG4OPe48UmkDaQgMXS7EOqpJrSs4JfQPPW/ZYRhO3UNNxz1tA090UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E4p6lOGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55FFC4CEF0;
	Mon, 22 Sep 2025 05:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758520746;
	bh=nD6/YGdfYKluGYsTBS+AwB59Iyw9Rmy3PXEJn7gVlpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E4p6lOGGLfc/wLW7BCITAZLSH8caYObZv45UV5mrgXBT5X6hCJSgnL1RoEMZdEmDk
	 xJDetyq3nwW1vXSes2nxXsbSZ289tQji+HgeqHs+TIjAm/X3y+OGcgfTiTGUufNb0/
	 VOe9NvS9IWKWlIn15/aeZoTSObPtsYbVo5vd4mJo=
Date: Mon, 22 Sep 2025 07:59:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: thaler@thaler.hu, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: include dying ring in task_work
 "should cancel"" failed to apply to 6.12-stable tree
Message-ID: <2025092206-identical-bonded-c86f@gregkh>
References: <2025092127-synthetic-squash-4d57@gregkh>
 <bc33927c-a7ed-4518-92e6-e97fc5fde5e8@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc33927c-a7ed-4518-92e6-e97fc5fde5e8@kernel.dk>

On Sun, Sep 21, 2025 at 06:44:45AM -0600, Jens Axboe wrote:
> On 9/21/25 6:32 AM, gregkh@linuxfoundation.org wrote:
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
> > git cherry-pick -x 3539b1467e94336d5854ebf976d9627bfb65d6c3
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092127-synthetic-squash-4d57@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> > 
> > Possible dependencies:
> 
> Here's this and the others marked for 6.12-stable, already prepared them
> last week as I knew I'd be traveling.

As you have backported commit b6f58a3f4aa8 ("io_uring: move struct
io_kiocb from task_struct to io_uring_task") does that mean we should
also add commit 69a62e03f896 ("io_uring/msg_ring: don't leave
potentially dangling ->tctx pointer") which claims to fix it?

I tried to apply it (same for 6.1 and 6.6), but it didn't apply cleanly.

thanks,

greg k-h

