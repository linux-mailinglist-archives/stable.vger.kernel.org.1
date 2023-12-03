Return-Path: <stable+bounces-3797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8528025F2
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 18:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE641C208FF
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 17:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CB5168DA;
	Sun,  3 Dec 2023 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GzMBzEgM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B3CDDCD
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 17:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722D6C433C7;
	Sun,  3 Dec 2023 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701624288;
	bh=NFcK75m669gg85OC6PRhl8bCb4wRUcmVfGr9EkXvveA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GzMBzEgMlAFLpz05tx+4oDLOh1t9gxre1gNCBDmndiBIGL/cTrB05woErVJDZWBwu
	 XBCk8Ex0rDbf0rpTp/q5H0g/Mj4GGZY3N88/fuMBT3Z1LyXu8uquwhma0NyO4HhvCL
	 CLWU2RAjAO1hHKW4iI68c2IPg2oPkUT8JC9XGb+U=
Date: Sun, 3 Dec 2023 18:24:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: jannh@google.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: defer release of mapped
 buffer rings" failed to apply to 6.6-stable tree
Message-ID: <2023120327-alike-salvation-2495@gregkh>
References: <2023120359-fit-broom-4a79@gregkh>
 <644de084-3205-497c-9c7b-fff06661d394@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <644de084-3205-497c-9c7b-fff06661d394@kernel.dk>

On Sun, Dec 03, 2023 at 07:59:46AM -0700, Jens Axboe wrote:
> On 12/3/23 6:47 AM, gregkh@linuxfoundation.org wrote:
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
> > git cherry-pick -x c392cbecd8eca4c53f2bf508731257d9d0a21c2d
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120359-fit-broom-4a79@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> 
> Pick this one first:
> 
> commit edecf1689768452ba1a64b7aaf3a47a817da651a
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Mon Nov 27 20:53:52 2023 -0700
> 
>     io_uring: enable io_mem_alloc/free to be used in other parts
> 
> then it'll work fine.

Thanks, that worked!

greg k-h

