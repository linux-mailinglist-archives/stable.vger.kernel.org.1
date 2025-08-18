Return-Path: <stable+bounces-169928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED218B299D3
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 08:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4602203B8D
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 06:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B93275878;
	Mon, 18 Aug 2025 06:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dm+NY5O7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F191DF982;
	Mon, 18 Aug 2025 06:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499127; cv=none; b=suRfA+9CAUF00Lf1b15AB3nz2MtJP6qSN3bw++c2LGU/FbXMiC38Efw+YV0Wrmmmisaevxo4NmfQM9FwzX2ok1ryyKQKG95pi8MRZGVYPjvwL6yWiDDx0/exwMwwRUPF9M5rmwuEi3lvmsVstvGZCQXF2/1xvWv55bqO7Nl2Bg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499127; c=relaxed/simple;
	bh=ZKis/lHHsil3+qxS9LXL9kurPk/4dJofbMX32NI6bl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re9PwbL2PAOKvQ7w4iANOtPk9FlVg4cNDXhmJHBDbJmhJs8vsFpzWl0O8joYNR4VcQ81dwhZFlJTdQLCNZK4dcEzmTdKdTpGY7D/eLmiMAQXe8iXJYYvKy7RKGdJMBT/q/XL5UX5qkS1BWj2tEwGVnPIcnW5V2bLxDhg6yr3ugY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dm+NY5O7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2878C4CEEB;
	Mon, 18 Aug 2025 06:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755499127;
	bh=ZKis/lHHsil3+qxS9LXL9kurPk/4dJofbMX32NI6bl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dm+NY5O7idMn1bzkulgc8bGD8Wss6RrmER9++RFLZQNgDHUdZ+4O2ZA3hyYk6RSep
	 IaveUimOYfOhHRu/kcyONCc34KE+gySVQlK1k1pEeHh+MsPr/vEsQP8bRc2a7QRy9T
	 cY6W8OvZkcreHF+LvRQxf7lKM7A6DckNflqV69gQ=
Date: Mon, 18 Aug 2025 08:38:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, xni@redhat.com,
	Song Liu <song@kernel.org>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: Patch "md: call del_gendisk in control path" has been added to
 the 6.6-stable tree
Message-ID: <2025081804-gloater-brought-c097@gregkh>
References: <20250817141818.2370452-1-sashal@kernel.org>
 <7748b907-8279-c222-d4e4-b94c3216408b@huaweicloud.com>
 <2025081846-veneering-radish-498d@gregkh>
 <0c083639-eb30-2830-0938-20684db3914a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c083639-eb30-2830-0938-20684db3914a@huaweicloud.com>

On Mon, Aug 18, 2025 at 02:26:23PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/18 13:55, Greg KH 写道:
> > On Mon, Aug 18, 2025 at 09:03:39AM +0800, Yu Kuai wrote:
> > > Hi,
> > > 
> > > 在 2025/08/17 22:18, Sasha Levin 写道:
> > > > This is a note to let you know that I've just added the patch titled
> > > > 
> > > >       md: call del_gendisk in control path
> > > > 
> > > > to the 6.6-stable tree which can be found at:
> > > >       http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > > 
> > > > The filename of the patch is:
> > > >        md-call-del_gendisk-in-control-path.patch
> > > > and it can be found in the queue-6.6 subdirectory.
> > > > 
> > > > If you, or anyone else, feels it should not be added to the stable tree,
> > > > please let <stable@vger.kernel.org> know about it.
> > > > 
> > > > 
> > > This patch should be be backported to any stable kernel, this change
> > > will break user tools mdadm:
> > > 
> > > https://lore.kernel.org/all/f654db67-a5a5-114b-09b8-00db303daab7@redhat.com/
> > 
> > Is it reverted in Linus's tree?
> > 
> 
> No, we'll not revert it, this is an improvement. In order to keep user
> tools compatibility, we added a switch in the kernel. As discussed in
> the thread, for old tools + new kernel, functionality is the same,
> however, there will be kernel warning about deprecated behaviour to
> inform user upgrading user tools.
> 
> However, I feel this new warning messages is not acceptable for
> stable kernels.

Why?  What is so special about stable kernels that taking the same
functionality in newer kernels is not ok?

Why not just "warn" the same here if you want to fix an issue where
userspace should be also updating some tools.  As long as you aren't
breaking anything, it should be fine, right?

Or are you breaking existing workflows?  You should be able to take a
new kernel without any userspace changes and all should work the same.
Why make new kernel users change userspace tools at all?

thanks,

greg k-h

