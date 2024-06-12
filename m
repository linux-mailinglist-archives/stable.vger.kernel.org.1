Return-Path: <stable+bounces-50239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2310A905274
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC26A1F22D8B
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF2416F901;
	Wed, 12 Jun 2024 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Un0vKuwg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA6816F0F3
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195409; cv=none; b=JvIociwq1zHdv2soo5aqs7aVdBTr+vhYVopYNenFPQX9FdvAxlK3ruV9plTbTMc1a77MNCRJqP//lfebAC1jY2EArhyQTwUxuLQzwvC4/HzHhgAnKcbgcHHhq5U03k8trQvUelVQmvkldLc8XEr+vfxm8u4qx86JAOeqC9PTVmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195409; c=relaxed/simple;
	bh=KQCbwT5LwiVudghOEdt5oBoX7IbGhu7iINLnbXxzrE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWGqaxB1zm3/kdExaQNBGV/HrbQz+XieoGghnfYQuBuCzdCeetxoU+F84TDVNB11GZu1anW4ZmM9ZNyKPtlX44UfUSPG6OxahchYJldB/4O7YMLpRWb4D9uPRlqXhcBbrZ0nhbL7loQ84tmuphfUZBj+B0u3JimHt2KsW3a/SjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Un0vKuwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93545C3277B;
	Wed, 12 Jun 2024 12:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718195409;
	bh=KQCbwT5LwiVudghOEdt5oBoX7IbGhu7iINLnbXxzrE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Un0vKuwgXAAoHLkQudF/UeSsvDSO7ZuYJzN/QDmBHNsl+InkpfgVmq6j/YZdjxZ57
	 R8W4FYp2gcQegnE76PVe8j98jwyMVhxdXgymTby9wz1E/zXJh0mTKgITZPNdU5fV/U
	 UVk/b3fzfkKm47VUeYrvdI8l8Y1+mGBNXJDoZFTM=
Date: Wed, 12 Jun 2024 14:30:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: ming.lei@redhat.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: fail NOP if non-zero op flags
 is passed in" failed to apply to 5.4-stable tree
Message-ID: <2024061259-prankish-karate-a090@gregkh>
References: <2024052549-gyration-replica-129f@gregkh>
 <52c45ad5-51f1-4fb7-8df4-b083bb303146@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52c45ad5-51f1-4fb7-8df4-b083bb303146@kernel.dk>

On Sat, May 25, 2024 at 09:40:45AM -0600, Jens Axboe wrote:
> On 5/25/24 9:05 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.4-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 3d8f874bd620ce03f75a5512847586828ab86544
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024052549-gyration-replica-129f@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..
> 
> Here's one for 5.4 stable, thanks.

Thanks, all now queued up.

greg k-h

