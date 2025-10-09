Return-Path: <stable+bounces-183657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6450BBC7648
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 06:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C49E34E284
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 04:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0467825BEE5;
	Thu,  9 Oct 2025 04:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="snt2pTUm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0F0221FB6
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 04:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759985919; cv=none; b=lPmLGwztrylIbdypCSxXXsV99Fla1GKvziAaZEHNMGouGy9lrQCzXztgYkdkNqSDa2QwZWhf4ERi8BTG5a2I0wSPfublU5QAx5JGAKUy6MkFBgfSL9B7HVL75zr0Av56Bbu2+3hcsiQ1BWcccgE0ap7QR+kt2EhEZT1sT6YK6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759985919; c=relaxed/simple;
	bh=8ZvSA0eEZa8MvP4UpyKW9mNFbJlvbGFHfX9E1JBcJhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjoPDcyGT3syspx9jERMKzKz2gbeHppyvp8uM0uGoL8Mca4CFozq2YftLy7XNwO1PDsxBjddZrfeOvLduL21aPl0DkaLyz2ZJYgS1iwP6R/yrMTrMAYYe7Z+RafM1SOphk54U8Ii0/1cHNSshEC3GjL+JOnSRN7YMVPcdVJO0Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=snt2pTUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E2AC4CEE7;
	Thu,  9 Oct 2025 04:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759985918;
	bh=8ZvSA0eEZa8MvP4UpyKW9mNFbJlvbGFHfX9E1JBcJhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snt2pTUmogPqUzw7EPOEEC2W3sTSJdAWufO2VD2uBxBJMYQP8LNdgy5x06AfOPtpw
	 q3BQdNSsNZTTAP+wHN8bKwnc+6pgEi4m4WJvUJ6Yrf4mAG8XUohA4YOUSUGDt4jyDS
	 +/yMpggOZ8K+TSPryH2QUvqsb/kGvC1NvEIbXyO4=
Date: Thu, 9 Oct 2025 06:58:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jimmy Hu <hhhuuu@google.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: udc: fix race condition in usb_del_gadget
Message-ID: <2025100927-pantry-acre-f9a8@gregkh>
References: <20251009022150.302915-1-hhhuuu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009022150.302915-1-hhhuuu@google.com>

On Thu, Oct 09, 2025 at 02:21:49AM +0000, Jimmy Hu wrote:
> A race condition during gadget teardown can lead to a use-after-free
> in usb_gadget_state_work(), as reported by KASAN:
> 
>   BUG: KASAN: invalid-access in sysfs_notify+0_x_2c/0_x_d0
>   Workqueue: events usb_gadget_state_work
> 
> The fundamental race occurs because a concurrent event (e.g., an
> interrupt) can call usb_gadget_set_state() and schedule gadget->work
> at any time during the cleanup process in usb_del_gadget().
> 
> Commit 399a45e5237c ("usb: gadget: core: flush gadget workqueue after
> device removal") attempted to fix this by moving flush_work() to after
> device_del(). However, this does not fully solve the race, as a new
> work item can still be scheduled *after* flush_work() completes but
> before the gadget's memory is freed, leading to the same use-after-free.
> 
> This patch fixes the race condition robustly by introducing a 'teardown'
> flag and a 'state_lock' spinlock to the usb_gadget struct. The flag is
> set during cleanup in usb_del_gadget() *before* calling flush_work() to
> prevent any new work from being scheduled once cleanup has commenced.
> The scheduling site, usb_gadget_set_state(), now checks this flag under
> the lock before queueing the work, thus safely closing the race window.
> 
> Fixes: 5702f75375aa9 ("usb: gadget: udc-core: move sysfs_notify() to a workqueue")
> Signed-off-by: Jimmy Hu <hhhuuu@google.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/usb/gadget/udc/core.c | 18 +++++++++++++++++-
>  include/linux/usb/gadget.h    |  6 ++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

