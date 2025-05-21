Return-Path: <stable+bounces-145753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B89DABEADF
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 06:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC6B4A1357
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 04:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295F422DFA7;
	Wed, 21 May 2025 04:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FJXWBlPR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AD8223330;
	Wed, 21 May 2025 04:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747800965; cv=none; b=Xzcp8s5zmrjFBdnc3tTorq41Tym6wffv5855c1IbeUU7m+EMD0g43cmDFuhQ2afGep3Je0ka6UHFE9LUuaryJ4J3X5YuL7wKvltLJECQ4fD8umz0Va56vfZCAj6+iXmJDT1AQqbqGFn3YNhiL73BmWYy6clavqM1ZE3ivmSnaMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747800965; c=relaxed/simple;
	bh=EUVQWWyTHlohq03AS4dRaa3i9b0S9pzbisHQKtSfN4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uA8PmM3cPcJ/rgnNseIfIHQQuOP2xkEH9otFxPYsSfeLnMxdq28/vUObFxQyhtSyGsX2Tl1zHFmbSOSL/Kj0TQi607CkWvTGYJ6mto9CVU3uhdDsO5f0/Dr2dAVr2VkKQBOTsn+/Qtg23d4UySpqLvquHQxFf0WLA2VJjTAlki0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FJXWBlPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A02EC4CEE4;
	Wed, 21 May 2025 04:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747800964;
	bh=EUVQWWyTHlohq03AS4dRaa3i9b0S9pzbisHQKtSfN4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJXWBlPRIJNECYAnA7jx/QBC7OfDjMlu2uZ8JDWpDKuI7gXcrMRy8hC7y04o/NOWV
	 v61CL5HskZsPGHgytIk5Dc5x++EK/MQCtU/570x5NqH0nJH9e2w6LuLAU27ddfjlAD
	 8UTPbYre06CP2cEZ8ZsVwIKFHlE+5UY9+bOJgDso=
Date: Wed, 21 May 2025 06:16:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH 5.10 1/5] kernfs: add a revision to identify directory
 node changes
Message-ID: <2025052147-sushi-panther-ab51@gregkh>
References: <20250521015336.3450911-1-dqfext@gmail.com>
 <20250521015336.3450911-2-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521015336.3450911-2-dqfext@gmail.com>

On Wed, May 21, 2025 at 09:53:31AM +0800, Qingfang Deng wrote:
> From: Ian Kent <raven@themaw.net>
> 
> Commit 895adbec302e92086359e6fd92611ac3be6d92c3 upstream.
> 
> Add a revision counter to kernfs directory nodes so it can be used
> to detect if a directory node has changed during negative dentry
> revalidation.
> 
> There's an assumption that sizeof(unsigned long) <= sizeof(pointer)
> on all architectures and as far as I know that assumption holds.
> 
> So adding a revision counter to the struct kernfs_elem_dir variant of
> the kernfs_node type union won't increase the size of the kernfs_node
> struct. This is because struct kernfs_elem_dir is at least
> sizeof(pointer) smaller than the largest union variant. It's tempting
> to make the revision counter a u64 but that would increase the size of
> kernfs_node on archs where sizeof(pointer) is smaller than the revision
> counter.
> 
> Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Ian Kent <raven@themaw.net>
> Link: https://lore.kernel.org/r/162642769895.63632.8356662784964509867.stgit@web.messagingengine.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

When forwarding on patches, you HAVE to sign off on them as well.

thanks,

greg k-h

