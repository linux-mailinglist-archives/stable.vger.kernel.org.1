Return-Path: <stable+bounces-155359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A26ADAE3F84
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 14:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35125167B4F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 12:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DA5253939;
	Mon, 23 Jun 2025 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sHU19OYR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B6C25392B
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680206; cv=none; b=OP0W32wARXeJ3w9zSzJJeVdQx/8oH9LFbs3GIOFTWVh+yb2Bs8Lu9JkpvkU/LgZ3AEyjBid2YJ9NLlwAiLn5z2oXpJYFFlAmzjfAitopZKwETFAYT6qL/mDO4fZOSJC+SI7NNFgOWaWUvnbxVyW66S60assvuGSR7rq2pnjSCdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680206; c=relaxed/simple;
	bh=8qVv9Rr05quisAy5V3uejeL1mutESWDWw02Jfm7j/k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5cNFbis31yuataublvRfzfG5z7W2y+kmclbrdZyIUOhK7iWIpdV/ZwSAY+TGRdlHL6WRONsnH97jPlaf3UMsek0y6HfNHncmsSgqPCmTPRtpZbRycFm3yHs5/AT7ddex5r6Uxaa/4fGodF2LKwqn/O4aW4gp2i++Rtk7W90a1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sHU19OYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7D4C4CEF1;
	Mon, 23 Jun 2025 12:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750680205;
	bh=8qVv9Rr05quisAy5V3uejeL1mutESWDWw02Jfm7j/k4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sHU19OYRMFln4MV/SFHRZwsVm2UngArzLRTjE2OD70Mz9olC6Gn20eNfTW0Ya+g+J
	 QovoGyfGEoVMndnuIaeK1fgszyHBDwZ6NPUagBRFl7k0AeNOeYnS54Q6TBuMPfTzt8
	 mF8vgZIW4OENUUaSH7366oN+Zbh91HIpb8GCAuOM=
Date: Mon, 23 Jun 2025 14:03:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: stable@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Pu Lehui <pulehui@huawei.com>,
	Luiz Capitulino <luizcap@amazon.com>,
	Wei Wei <weiwei.danny@bytedance.com>,
	Yuchen Zhang <zhangyuchen.lcr@bytedance.com>
Subject: Re: Host panic in bpf verifier when loading bpf prog in 5.10 stable
 kernel
Message-ID: <2025062316-atrocious-hatchling-0cb9@gregkh>
References: <20250605070921.GA3795@bytedance>
 <20250616070617.GA66@bytedance>
 <2025062344-width-unvisited-a96f@gregkh>
 <20250623115552.GA294@bytedance>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623115552.GA294@bytedance>

On Mon, Jun 23, 2025 at 07:55:52PM +0800, Aaron Lu wrote:
> On Mon, Jun 23, 2025 at 10:17:15AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jun 16, 2025 at 03:06:17PM +0800, Aaron Lu wrote:
> > > Ping?
> > > 
> > > On Thu, Jun 05, 2025 at 03:09:21PM +0800, Aaron Lu wrote:
> > > > Hello,
> > > > 
> > > > Wei reported when loading his bpf prog in 5.10.200 kernel, host would
> > > > panic, this didn't happen in 5.10.135 kernel. Test on latest v5.10.238
> > > > still has this panic.
> > > 
> > > If a fix is not easy for these stable kernels, I think we should revert
> > > this commit? Because for whatever bpf progs, the bpf verifier should not
> > > panic the kernel.
> > > 
> > > Regarding revert, per my test, the following four commits in linux-5.10.y
> > > branch have to be reverted and after that, the kernel does not panic
> > > anymore:
> > > commit 2474ec58b96d("bpf: allow precision tracking for programs with subprogs")
> > > commit 7ca3e7459f4a("bpf: stop setting precise in current state")
> > > commit 1952a4d5e4cf("bpf: aggressively forget precise markings during
> > > state checkpointing")
> > > commit 4af2d9ddb7e7("selftests/bpf: make test_align selftest more
> > > robust")
> > 
> > Can you send the reverts for this, so that you get credit for finding
> > and fixing this issue, and you can put the correct wording in the commit
> > messages for why they need to be reverted?
> 
> No problem, thanks for the info.
> 
> I have sent them:
> https://lore.kernel.org/stable/20250623115403.299-1-ziqianlu@bytedance.com/

All now queued up, thanks!

greg k-h

