Return-Path: <stable+bounces-180805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04879B8DB67
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17073B62D7
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0E22459D1;
	Sun, 21 Sep 2025 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xlm/Ahok"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E7B12F5A5
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758459350; cv=none; b=perRAwfSgNnLfYWtj5xdFO0wvhisHvzXBF7XftgPfZUx7lruJjpYohf9pUS9EcBQcqOFtshP1U8KTwrpGZxXatEpNxANvmmhvooJUBl9+ZXEPdENTabH2GV6b50JdUVRzPqB8BYLHuStJixDbTHwNxHSe2uwI+fQFpGYFHf1PDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758459350; c=relaxed/simple;
	bh=yAVpk29zroYjob0o5HpDRvbuhKQcKjfPDQzXMbIvwbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPq/r1fjGVGhcA/yFmwuqswxf9wSdf9+utAqVhFldCUXoHdI0una2Y9etCmaAq+lH4TfGrJyv6occXJC3dJS6OrraeYvK0EUxSp3SibK01dbNzsS8Yt+ctNDUVMgthY/vZfI1xLiaF6jeCYM9PxvRBfesrGrBxORfN6ZzdjilMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xlm/Ahok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11921C4CEE7;
	Sun, 21 Sep 2025 12:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758459350;
	bh=yAVpk29zroYjob0o5HpDRvbuhKQcKjfPDQzXMbIvwbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xlm/AhokTapaguDhm+9ayXN8FSEivkaYJ7VUtFPU06CDXMsZSOJA4UKnyH5Z1OHdt
	 /L1ZrpUSU+urkGjJ6UcD/+N5ZcKGPpDNJgumpkAxYr/mPUzeV2SyRlVMHcxuSub32h
	 mIvL1jWanjCVRJEx2f1r5HFXkLrKOLNyzmEveijA=
Date: Sun, 21 Sep 2025 14:55:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: thaler@thaler.hu, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: include dying ring in task_work
 "should cancel"" failed to apply to 6.1-stable tree
Message-ID: <2025092141-rinse-unwary-4bea@gregkh>
References: <2025092128-embassy-flyable-e3fb@gregkh>
 <6ce95113-74e7-480a-942e-378dee39c801@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ce95113-74e7-480a-942e-378dee39c801@kernel.dk>

On Sun, Sep 21, 2025 at 06:46:00AM -0600, Jens Axboe wrote:
> On 9/21/25 6:32 AM, gregkh@linuxfoundation.org wrote:
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
> > git cherry-pick -x 3539b1467e94336d5854ebf976d9627bfb65d6c3
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092128-embassy-flyable-e3fb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> And 6.1-stable variants here.

Now applied, thanks.

greg k-h

