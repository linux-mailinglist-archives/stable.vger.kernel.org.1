Return-Path: <stable+bounces-180697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC51B8B00A
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 20:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C051654C3
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 18:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6062A26E16E;
	Fri, 19 Sep 2025 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYKXeHdp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149EF1E1E16;
	Fri, 19 Sep 2025 18:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307957; cv=none; b=N3CAkNpUSqycWQXTdHOVWmssBpKUzHnJ6NkKJ3BHRmeClOVACbMIJCdImTWXQ/89AStBgkcYN/lb+tfqOTa3ghsccB2Ye/gLrkgGl/y5qpnl4eM9ykV9y1MDtJIypjKATX6vdK+giLL6Ep1zenN/okhiIrn95mPT5A+AU641d9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307957; c=relaxed/simple;
	bh=+sZY14sW8tr9IVa9GH1fBB0VscnTuhTsxV2CfzO6pdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsWLWzitgj5e2HeyuJD6oEeIrr4IUtIoOOonbvJTwy0lRHGuoE22gij75zxSBGuv1vx6ENc3nft2qNxsA8UIAT2ZoKXdd3/xMidALwd6RGNpNQ0DFSo21yvNyi9p9VE1wgH42Lgkm6Yc9ZVEJKzdRokL7veUo9VrJbZuetD0EfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYKXeHdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9E1C4CEF0;
	Fri, 19 Sep 2025 18:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758307956;
	bh=+sZY14sW8tr9IVa9GH1fBB0VscnTuhTsxV2CfzO6pdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NYKXeHdpOD1QbneH7XyTm8yziyDnhWbFad7CxaSZwm9o5f/2Ad2/EPvyMurh9fl6r
	 XpwDHZmNvLYX3IiWaTOOvp28390iGIKQ7CAkbWP55QLE2rf5FeKzRrfYiqFdWAoY2v
	 Bi6Du/7yz6eQ6/WckJumn+j/htMTZCIImITFILh14CNCnv60JTK1LRDTS26tO+HlQo
	 r8rqN3taiY9u3mcMjto5zndQ5hbS3IB7OKk7O9c1hJsuDaF5l8DSXd0HaSofQs3kuC
	 qBKtzpm2fn6dh80hQWZOwqsSoR3f96c3quFJIv08G/xgWPvCOoKa7fuXH2HQKEiOnz
	 jcnvqf/qIqeRA==
Date: Fri, 19 Sep 2025 19:52:32 +0100
From: Simon Horman <horms@kernel.org>
To: Deepak Sharma <deepak.sharma.472935@gmail.com>
Cc: krzk@kernel.org, vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	stable@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] net: nfc: nci: Add parameter validation for
 packet data
Message-ID: <20250919185232.GF589507@horms.kernel.org>
References: <20250919064545.4252-1-deepak.sharma.472935@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919064545.4252-1-deepak.sharma.472935@gmail.com>

On Fri, Sep 19, 2025 at 12:15:44PM +0530, Deepak Sharma wrote:
> Syzbot reported an uninit-value bug at nci_init_req for commit
> 5aca7966d2a7 ("Merge tag 'perf-tools-fixes-for-v6.17-2025-09-16'..).
> 
> This bug arises due to very limited and poor input validation
> that was done at nic_valid_size(). This validation only
> validates the skb->len (directly reflects size provided at the
> userspace interface) with the length provided in the buffer
> itself (interpreted as NCI_HEADER). This leads to the processing
> of memory content at the address assuming the correct layout
> per what opcode requires there. This leads to the accesses to
> buffer of `skb_buff->data` which is not assigned anything yet.
> 
> Following the same silent drop of packets of invalid sizes at
> `nic_valid_size()`, add validation of the data in the respective
> handlers and return error values in case of failure. Release
> the skb if error values are returned from handlers in 
> `nci_nft_packet` and effectively do a silent drop
> 
> Possible TODO: because we silently drop the packets, the
> call to `nci_request` will be waiting for completion of request
> and will face timeouts. These timeouts can get excessively logged
> in the dmesg. A proper handling of them may require to export
> `nci_request_cancel` (or propagate error handling from the
> nft packets handlers).
> 
> Reported-by: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=740e04c2a93467a0f8c8
> Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation)

There is a typo in the fixes tag. It should be:

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
                                                           ^^^
I expect there is no need to repost to address this.

> Tested-by: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
> Signed-off-by: Deepak Sharma <deepak.sharma.472935@gmail.com>

...

