Return-Path: <stable+bounces-161703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DC4B02B07
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 15:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00F41C20AA6
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 13:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01934277CA8;
	Sat, 12 Jul 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d+gpOOUf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99768277804
	for <stable@vger.kernel.org>; Sat, 12 Jul 2025 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752327775; cv=none; b=NRnh0Vsif1ZsCSXqS4tSOC8AHXudoZ72vxwlxaiGdC++LCrZ1yt/71gu2/98VnuYOR5w78/lNGUE/XuOFqlR01rPhV2hYniqrX0vvWVfbEghuTdwghCCNxRKZOHcKbi8VRrjDaFsCcnVKxlOlRYA6Ri/N5YbplvVf8nndlnWjJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752327775; c=relaxed/simple;
	bh=VKI4Ni79h2iW1vafDhYQ+Rpb6uMqeU/bIbVBMd43vAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjhCYgfq8ujRSmV4oK91Bq5SqDtS7uUoQjKRaVg0u9mas6V7MOZusBUd7+BDh0Ee5g2o899/5pGT3QAxN214+RznFDyXJNhstkBOfy7KO8AW+Rgtjo5e/ZsA95JJrTed2S4KgbiTTDy5lXg1Xp6TN4DR8yc5ggVTUK27hYVv4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d+gpOOUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BA2C4CEEF;
	Sat, 12 Jul 2025 13:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752327775;
	bh=VKI4Ni79h2iW1vafDhYQ+Rpb6uMqeU/bIbVBMd43vAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d+gpOOUfaKgG9yyQof/dBwqYm9TMwKspBX/0+uptzkOf4DE1TaP/2561mrjwgT/LT
	 3Rn7i3VaMFPBew880td5YUtpRuJQOe0melJneJHG0FndPmBzF65scMqjcwVMWOEqDs
	 plNFVARsCHwp0XJmOPn45vVRYc2dWqLZzMFXm5kw=
Date: Sat, 12 Jul 2025 15:42:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Pu Lehui <pulehui@huawei.com>, stable@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Wei Wei <weiwei.danny@bytedance.com>,
	Yuchen Zhang <zhangyuchen.lcr@bytedance.com>
Subject: Re: Host panic in bpf verifier when loading bpf prog in 5.10 stable
 kernel
Message-ID: <2025071246-armhole-salsa-ba8f@gregkh>
References: <20250605070921.GA3795@bytedance>
 <20250616070617.GA66@bytedance>
 <2025062344-width-unvisited-a96f@gregkh>
 <20250623115552.GA294@bytedance>
 <2025062316-atrocious-hatchling-0cb9@gregkh>
 <e9fa5e34-eacd-4f35-a250-2da75c9b7df8@huawei.com>
 <20250624035216.GA316@bytedance>
 <2ed4150a-e651-4d10-bada-57bc3895dbe7@huawei.com>
 <2025062458-flask-enviably-20a7@gregkh>
 <20250625093311.GA388@bytedance>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625093311.GA388@bytedance>

On Wed, Jun 25, 2025 at 05:33:11PM +0800, Aaron Lu wrote:
> On Tue, Jun 24, 2025 at 11:33:20AM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Jun 24, 2025 at 02:41:56PM +0800, Pu Lehui wrote:
> > > 
> > > 
> > > On 2025/6/24 11:52, Aaron Lu wrote:
> > > > On Tue, Jun 24, 2025 at 09:32:54AM +0800, Pu Lehui wrote:
> > > > > Hi Aaron, Greg,
> > > > > 
> > > > > Sorry for the late. Just found a fix [0] for this issue, we don't need to
> > > > > revert this bugfix series. Hope that will help!
> > > > > 
> > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=4bb7ea946a37
> > > > > [0]
> > > > 
> > > > I can confirm this also fixed the panic issue on top of 5.10.238.
> > > > 
> > > > Hi Greg,
> > > > 
> > > > The cherry pick is not clean but can be trivially fixed. I've appended
> > > > the patch I've used for test below for your reference in case you want
> > > > to take it and drop that revert series. Thanks.
> > > > 
> > > > > > From f0e1047ee11e4ab902a413736e4fd4fb32b278c8 Mon Sep 17 00:00:00 2001
> > > > From: Andrii Nakryiko <andrii@kernel.org>
> > > > Date: Thu, 9 Nov 2023 16:26:37 -0800
> > > > Subject: [PATCH] bpf: fix precision backtracking instruction iteration
> > > > 
> > > > commit 4bb7ea946a370707315ab774432963ce47291946 upstream.
> > > > 
> > > > Fix an edge case in __mark_chain_precision() which prematurely stops
> > > > backtracking instructions in a state if it happens that state's first
> > > > and last instruction indexes are the same. This situations doesn't
> > > > necessarily mean that there were no instructions simulated in a state,
> > > > but rather that we starting from the instruction, jumped around a bit,
> > > > and then ended up at the same instruction before checkpointing or
> > > > marking precision.
> > > > 
> > > > To distinguish between these two possible situations, we need to consult
> > > > jump history. If it's empty or contain a single record "bridging" parent
> > > > state and first instruction of processed state, then we indeed
> > > > backtracked all instructions in this state. But if history is not empty,
> > > > we are definitely not done yet.
> > > > 
> > > > Move this logic inside get_prev_insn_idx() to contain it more nicely.
> > > > Use -ENOENT return code to denote "we are out of instructions"
> > > > situation.
> > > > 
> > > > This bug was exposed by verifier_loop1.c's bounded_recursion subtest, once
> > > > the next fix in this patch set is applied.
> > > > 
> > > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > Fixes: b5dc0163d8fd ("bpf: precise scalar_value tracking")
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Link: https://lore.kernel.org/r/20231110002638.4168352-3-andrii@kernel.org
> > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > 
> > > Alright, this patch should target for linux-5.10.y and linux-5.15.y.
> > > 
> > > And better to add here with the follow tag:
> > > 
> > > Reported-by: Wei Wei <weiwei.danny@bytedance.com>
> > > Closes: https://lore.kernel.org/all/20250605070921.GA3795@bytedance/
> > 
> > Thanks, I've dropped the reverts and now queued this up.  Let's push out
> > a -rc2 and see how that goes through testing...
> 
> Thanks Greg.
> 
> 5.15 stable tree also has this problem and after applying the above
> patch to 5.15.185, the problem is also fixed. I appreciate if you can
> also queue it for 5.15 stable branch, thanks.

Now applied, thanks.

greg k-h

