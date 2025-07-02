Return-Path: <stable+bounces-159250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D86AF5B17
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 16:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6C548001E
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 14:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4392BD5B5;
	Wed,  2 Jul 2025 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TanUsE0a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84771F5820
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751466394; cv=none; b=dhpdg6rojgnO4i0omum0ZSu7g/ub6aogg5Zs9hZ91cgRzSXNgcJ7nfVyMyrPUCQY8yxWoaJ5bvxpfdjJJ+PJEtD/sDNTEbyGnI+4tlv2pfm5m6rvHwCUKXSxBIXTJgXFN8oZmHa+L+aTQdppqyzu9SmlKbnioF6WhpxVs9uyWIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751466394; c=relaxed/simple;
	bh=/LiSu4n0hNVhKP/uidpJAC322sDIABqupw/MeLzyTu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUGbbTEZRcSOMiYtq/U5MXlsLRZO8IesTHNDXcRP4BPcLQMdfJPT6Kz8XHDZZZ9MYeDCBkLdhkFZAD/5ToG7wOkOdU+NoswHjzovDRecuEyKjuwIFNqAc2CiSWweKyFsRhkxjTnT+eDs59UcAPsh91rYDO6fU6FgSlw//Fe2Jao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TanUsE0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B482C4CEE7;
	Wed,  2 Jul 2025 14:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751466394;
	bh=/LiSu4n0hNVhKP/uidpJAC322sDIABqupw/MeLzyTu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TanUsE0a+KtuCHLBcG4lhfjREObmXTybX0HiEJ4H1wJ7EeXpyV8HrXsk51S0ohkBa
	 3WpywLaxzNVq754GtF4YQZof+X5OFbjEbA7N+tDDUSDz+/tcr8pWq2QBM1aAdSrw6F
	 ycOeHH9t1Qpn7U7yUgo0AXdPnW6z8twSbf+vFmH0=
Date: Wed, 2 Jul 2025 16:26:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: asml.silence@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: account ring
 io_buffer_list memory" failed to apply to 6.1-stable tree
Message-ID: <2025070225-drainpipe-civic-c246@gregkh>
References: <2025062043-header-audio-50d2@gregkh>
 <5d8cb207-7c78-4840-98cc-d8ef7bf81034@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d8cb207-7c78-4840-98cc-d8ef7bf81034@kernel.dk>

On Fri, Jun 27, 2025 at 10:09:28AM -0600, Jens Axboe wrote:
> On 6/19/25 11:40 PM, gregkh@linuxfoundation.org wrote:
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
> > git cherry-pick -x 475a8d30371604a6363da8e304a608a5959afc40
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062043-header-audio-50d2@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> Here's a 6.1-stable variant.

Now applied, thanks.

greg k-h

