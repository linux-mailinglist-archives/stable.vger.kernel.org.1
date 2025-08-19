Return-Path: <stable+bounces-171746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DFAB2B925
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 08:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4756F189E07B
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 06:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F430262FD2;
	Tue, 19 Aug 2025 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gb2cmxzI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145AD265606;
	Tue, 19 Aug 2025 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755583972; cv=none; b=bgrPReMk3yntXW4CM1YdMy7gwh+8vQ5z4UtHCy+8sSn9qNSQqqobobKcahfGWIE01z0CDAu5o7qMLR8xqqAm/jDoaG8CsvZLFXYEsBPask39ASbkP9jgoqLE4lEmDVFt1jOgbtylNJYIk4aad08rcsWy8EAsf74/Or/I2bZ6NVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755583972; c=relaxed/simple;
	bh=5SN+Rc2EPVWfaOs00Q6zJvP5aztuLUPx0X8yZGIh3b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzuFnaFe53iJN+FBn21Ry2lnA3zpW4KOMMO1RPL4VCq/yTgsZDcupC789ij3r4VBe3E9zQoH4ZYBvUyq5eP7nM6WoaDwHPwVZnBiw6UO9/hCzxwh7vJYiXDs97xlD2JOVHVwQCZXBPtMIKPAKv8VGazmmL15l+7pOnf59bQT8ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gb2cmxzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4BFC4CEF4;
	Tue, 19 Aug 2025 06:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755583971;
	bh=5SN+Rc2EPVWfaOs00Q6zJvP5aztuLUPx0X8yZGIh3b4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gb2cmxzIWyUTSLnZz4zA2Aht7KYOpvNije2iSz80zt5z+qnx0saE3AKPdziuU68Uh
	 dE8efiNDpIaqN45b7UqXS7IJRll98FQpMkJ8ZFCzpmD/8SbbNkm1tL7028+m3EA9BV
	 XqJCmjvd+K+6et66GYjz8KMS58moICmJof/MEB+s=
Date: Tue, 19 Aug 2025 08:12:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, xni@redhat.com,
	Song Liu <song@kernel.org>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: Patch "md: call del_gendisk in control path" has been added to
 the 6.6-stable tree
Message-ID: <2025081924-barbecue-energetic-28db@gregkh>
References: <20250817141818.2370452-1-sashal@kernel.org>
 <7748b907-8279-c222-d4e4-b94c3216408b@huaweicloud.com>
 <2025081846-veneering-radish-498d@gregkh>
 <0c083639-eb30-2830-0938-20684db3914a@huaweicloud.com>
 <2025081804-gloater-brought-c097@gregkh>
 <e0fef2d7-9c72-495e-4c62-7c4fd766c84d@huaweicloud.com>
 <2025081812-stalemate-hug-a179@gregkh>
 <aa4ca148-2d15-a10b-84d5-8232da12ebf0@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa4ca148-2d15-a10b-84d5-8232da12ebf0@huaweicloud.com>

On Tue, Aug 19, 2025 at 09:06:18AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/18 17:39, Greg KH 写道:
> > On Mon, Aug 18, 2025 at 03:13:11PM +0800, Yu Kuai wrote:
> > > Hi,
> > > 
> > > 在 2025/08/18 14:38, Greg KH 写道:
> > > > On Mon, Aug 18, 2025 at 02:26:23PM +0800, Yu Kuai wrote:
> > > > > Hi,
> > > > > 
> > > > > 在 2025/08/18 13:55, Greg KH 写道:
> > > > > > On Mon, Aug 18, 2025 at 09:03:39AM +0800, Yu Kuai wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > 在 2025/08/17 22:18, Sasha Levin 写道:
> > > > > > > > This is a note to let you know that I've just added the patch titled
> > > > > > > > 
> > > > > > > >         md: call del_gendisk in control path
> > > > > > > > 
> > > > > > > > to the 6.6-stable tree which can be found at:
> > > > > > > >         http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > > > > > > 
> > > > > > > > The filename of the patch is:
> > > > > > > >          md-call-del_gendisk-in-control-path.patch
> > > > > > > > and it can be found in the queue-6.6 subdirectory.
> > > > > > > > 
> > > > > > > > If you, or anyone else, feels it should not be added to the stable tree,
> > > > > > > > please let <stable@vger.kernel.org> know about it.
> > > > > > > > 
> > > > > > > > 
> > > > > > > This patch should be be backported to any stable kernel, this change
> > > > > > > will break user tools mdadm:
> > > > > > > 
> > > > > > > https://lore.kernel.org/all/f654db67-a5a5-114b-09b8-00db303daab7@redhat.com/
> > > > > > 
> > > > > > Is it reverted in Linus's tree?
> > > > > > 
> > > > > 
> > > > > No, we'll not revert it, this is an improvement. In order to keep user
> > > > > tools compatibility, we added a switch in the kernel. As discussed in
> > > > > the thread, for old tools + new kernel, functionality is the same,
> > > > > however, there will be kernel warning about deprecated behaviour to
> > > > > inform user upgrading user tools.
> > > > > 
> > > > > However, I feel this new warning messages is not acceptable for
> > > > > stable kernels.
> > > > 
> > > > Why?  What is so special about stable kernels that taking the same
> > > > functionality in newer kernels is not ok?
> > > > 
> > > > Why not just "warn" the same here if you want to fix an issue where
> > > > userspace should be also updating some tools.  As long as you aren't
> > > > breaking anything, it should be fine, right?
> > > 
> > > Yes, it's fine, just in downstream kernels, people won't be happy about
> > > new warnings.
> > 
> > People are NEVER happy about new warnings.  So why are you warning them
> > at all in newer kernels?
> 
> Again, only old user tools + new kernels will warn, and behave like old
> tools + old kernels. We'll need both kernel and user tool to be updated
> to fix this problem.
> 
> > 
> > > > Or are you breaking existing workflows?  You should be able to take a
> > > > new kernel without any userspace changes and all should work the same.
> > > > Why make new kernel users change userspace tools at all?
> > > 
> > > There is a pending fix in mdraid that will be pushed soon, with this
> > > nothing will be broken.
> > 
> > Great, what is the git id?
> 
> It's just pushed to Jen's tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-6.17&id=25db5f284fb8f30222146ca15b3ab8265789da38
> > 
> > > And because user tools have problems in this case as well, both kernel
> > > and user tools have to be fixed to make things better.
> > 
> > So Linus's tree right now doesn't work without the pending fix as well?
> 
> Sadly, yes, this is indeed a regression from rc1. We're using latest
> user tools for test and didn't realize this problem in time.

Ok, for now, until that patch is added to Linus's tree, I've dropped
this patch from all stable queues.

thanks,

greg k-h

