Return-Path: <stable+bounces-108417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460E1A0B4CB
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 11:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C19A166D88
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 10:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE90A22F14F;
	Mon, 13 Jan 2025 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vs4AstYt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFD222F14E
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736765426; cv=none; b=MDlQzNLaRFndiXRv74N3rJ+rHyzEavc4Y8M/7PWwlV+qI/cuUKv/xltqyl1mY/s6NqI1UHMpMbfxvjBo/GuDeMH3PZQGfg8obm8PkJchZNZtspBmq8USIHRG7F7zcENb2tZO8X/R1XWsr/xH8gbPh6ZiYQQ+avvClLdWN+qedF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736765426; c=relaxed/simple;
	bh=D2tm71zv7KipJc+VkMa9Sh8Uaw+rgJrBkdk/b3Jpq1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TliJ9/Z1O23jOWsAVlLWqu5mUGX2gB+fFAesVwfhDlmQjkDOY5MTqRXC+XIdYrsOB8/VMq53KI7sK+QxiWkIAvOc43eknVqg2R1r0sRhOF0Y/IcN4c2IAFHfcDcj55iSrVuTC900S4VkLmFrLN+oPjU11PfUAPTsNmRtpAxHl5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vs4AstYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FCAC4CEDD;
	Mon, 13 Jan 2025 10:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736765426;
	bh=D2tm71zv7KipJc+VkMa9Sh8Uaw+rgJrBkdk/b3Jpq1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vs4AstYtDhDOjUwtNM+ZgclbVLa55mV/bxUNmYXWrO9azEvyR/BzC/uoWxbCjrt2h
	 c+MVpzqj//Ct0mhh34dmh/TtZV1LOmiYnJN8KlzUtI5cNZjWccL8rFtc2FJizHW7VG
	 mBx67Zy92RP+Nl+76z2bAKWZUU3D02aorSMBs8kU=
Date: Mon, 13 Jan 2025 11:50:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: jannh@google.com, lizetao1@huawei.com, ptsm@linux.microsoft.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/eventfd: ensure
 io_eventfd_signal() defers another" failed to apply to 6.1-stable tree
Message-ID: <2025011314-skinhead-thigh-b568@gregkh>
References: <2025011246-appealing-angler-4f22@gregkh>
 <aa85959b-2890-42c9-beb8-0e0109494d90@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa85959b-2890-42c9-beb8-0e0109494d90@kernel.dk>

On Sun, Jan 12, 2025 at 07:55:26AM -0700, Jens Axboe wrote:
> On 1/12/25 2:16 AM, gregkh@linuxfoundation.org wrote:
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
> > git cherry-pick -x c9a40292a44e78f71258b8522655bffaf5753bdb
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011246-appealing-angler-4f22@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> And here's the 6.1 version.

Thanks, all 3 now queued up.

greg k-h

