Return-Path: <stable+bounces-155317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E0DAE382E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 10:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C958B3A786A
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 08:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6321D1F4177;
	Mon, 23 Jun 2025 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AW+mkI8A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208D2211F
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666638; cv=none; b=dlxa475w0slwyREYf3onSzQqAi1OiW6j3oD7jPHb6ajBRi8ICgZrmxUq8xgyuop8g8hmrgH1aJu5HmNUO3azUy1PdEB1ptrJCfBI6Fbs9U8HD174Exdv6aXshQW6VUrBjR3VxKgdTMyA1CUr2hBFGnS1GdrB0eBsz5Iez5aVvCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666638; c=relaxed/simple;
	bh=ezcCNn1+PFY6aWfTAwgAbek2PVNN7Xx24SyyVinu5EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLOiWF5ipbrsptBvp9h87/CXTf7vqZniULIwx/Zrg3+2V8aMbtyG9wnktZAfsrETuNleZ9emnGpKhH4lvUvjYGJRzaQYaPQuO40s05BUF9bqy01clgusin5Jce3UzU17KGS3yL1mu1oXtTIqv5+viXMpHgZ0EGsgrPNCdEmf45k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AW+mkI8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1397FC4CEED;
	Mon, 23 Jun 2025 08:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750666637;
	bh=ezcCNn1+PFY6aWfTAwgAbek2PVNN7Xx24SyyVinu5EA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AW+mkI8AwCBF/VwEw21UWgdgu/pcDq9BPCKvAm2PkKTssCKScs6rX2T6ZDlo4IprK
	 9JpuNEJPPcLb1L2rEcc9GUShFwyGr612t07jFhiFBikjUVRm5XVoJ3HAF+kLp+1OVd
	 gTPw9LbAdBnliU7ER2jogxq9fmFycBc9UWRVwLss=
Date: Mon, 23 Jun 2025 10:17:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: stable@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Pu Lehui <pulehui@huawei.com>,
	Luiz Capitulino <luizcap@amazon.com>,
	Wei Wei <weiwei.danny@bytedance.com>,
	Yuchen Zhang <zhangyuchen.lcr@bytedance.com>
Subject: Re: Host panic in bpf verifier when loading bpf prog in 5.10 stable
 kernel
Message-ID: <2025062344-width-unvisited-a96f@gregkh>
References: <20250605070921.GA3795@bytedance>
 <20250616070617.GA66@bytedance>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616070617.GA66@bytedance>

On Mon, Jun 16, 2025 at 03:06:17PM +0800, Aaron Lu wrote:
> Ping?
> 
> On Thu, Jun 05, 2025 at 03:09:21PM +0800, Aaron Lu wrote:
> > Hello,
> > 
> > Wei reported when loading his bpf prog in 5.10.200 kernel, host would
> > panic, this didn't happen in 5.10.135 kernel. Test on latest v5.10.238
> > still has this panic.
> 
> If a fix is not easy for these stable kernels, I think we should revert
> this commit? Because for whatever bpf progs, the bpf verifier should not
> panic the kernel.
> 
> Regarding revert, per my test, the following four commits in linux-5.10.y
> branch have to be reverted and after that, the kernel does not panic
> anymore:
> commit 2474ec58b96d("bpf: allow precision tracking for programs with subprogs")
> commit 7ca3e7459f4a("bpf: stop setting precise in current state")
> commit 1952a4d5e4cf("bpf: aggressively forget precise markings during
> state checkpointing")
> commit 4af2d9ddb7e7("selftests/bpf: make test_align selftest more
> robust")

Can you send the reverts for this, so that you get credit for finding
and fixing this issue, and you can put the correct wording in the commit
messages for why they need to be reverted?

thanks,

greg k-h

