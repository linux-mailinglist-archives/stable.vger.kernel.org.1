Return-Path: <stable+bounces-52352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3964190A8F1
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 11:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267431C229CC
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 09:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4806E1836FC;
	Mon, 17 Jun 2024 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g6KQUWO1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB22B18F2C2
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718614963; cv=none; b=crLF85c0jIBfMSGg6ZwSVXaNv4pjuDovsa5a7V6S7xjLTO1/knHd5Me2wxZS/wrGMc1Ma8kQOhMywTYz7zkbYV2ZDdVFXB0A/z0l8cMPlx80I5hr/dVecHa5MY1nKQVOqDu2BfZjnEnkainBxHLqZ3mNvmvA47s4mU+4DN6+LDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718614963; c=relaxed/simple;
	bh=zblbLtjxHyX2m9dvWgroaFJk1MwBvANosfwA8iJIkyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cI7rLCrOaCaDC2l0GDRPDgLny7Tb0LDjcV6xB5VPjcqLTqRyVstygWvia2wU+sFfNylrJaXNYQeZ0kKJvYb4eaRmtcbrh1Sbwwi11VqU5O2gUFJdNMscWqUAi9TskkDBWhqNw+xdapnHWmGrLHRU0FJYW3ByixfKsKL5ZVAFY0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g6KQUWO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D358C3277B;
	Mon, 17 Jun 2024 09:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718614961;
	bh=zblbLtjxHyX2m9dvWgroaFJk1MwBvANosfwA8iJIkyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6KQUWO1Z8iYWfnTs36flV78l02MQD6TtbtbgF15FZh2i3azlRlqE8D0T/4wtvlJs
	 isj5bdy/w4CG8uQ68tWNHoZ9zX8mvUF0Qk0n2b/vLIxZkAoiV4rhXBuZ5aMYJJ6EDg
	 x9NZzkTR6OgbX7qzFa75jh7ufP15amWbVlhtIsRc=
Date: Mon, 17 Jun 2024 11:02:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: check for non-NULL file pointer
 in" failed to apply to 6.1-stable tree
Message-ID: <2024061731-affront-promenade-3d62@gregkh>
References: <2024061319-avenue-nutlike-03f6@gregkh>
 <00f44cd8-be41-43aa-9b9e-37cd845b34a8@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f44cd8-be41-43aa-9b9e-37cd845b34a8@kernel.dk>

On Fri, Jun 14, 2024 at 06:48:49PM -0600, Jens Axboe wrote:
> On 6/13/24 1:30 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 5fc16fa5f13b3c06fdb959ef262050bd810416a2
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061319-avenue-nutlike-03f6@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> Here's one for 6.1-stable.

Both now queued up, thanks.

greg k-h

