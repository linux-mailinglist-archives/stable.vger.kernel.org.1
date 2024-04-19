Return-Path: <stable+bounces-40289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF6B8AAFE2
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 15:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B90F1C22BC8
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 13:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2486912D75C;
	Fri, 19 Apr 2024 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PewEYGoF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C058C12D1F1
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535116; cv=none; b=Q7G3eZlpxx0Xi7Kn2QfDyprZEixVCYU6n2Fvv8XKotj/4LdAEpGsnsYeGKy9O3Oncrm+cK3EqEZ7YxjaRRAq8Pahdv0LBdV8AljrDFcQoP7PtRLw7m0vZgphRD4MydyTtZTQgB2dZErvlj2yxLbYIqGXDd7FY4u357VhbTDvK0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535116; c=relaxed/simple;
	bh=k/tTkUxRS4T5vxu2Ors6LiIwIxRVd+MH/lkHnelFqUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfrTFcfd0tjLHGxGbcI5z6bDocAwaIH/24ViJoZN6miJh//W+0gffJ3aAZDp/8bh234e9tkWPVZULwxY+Em9SDaU0t7lrN329CCt4KwG+2WgjmEVmiwGT1k9yoPcSaY9BAmW7TIMWvchV/36WJEwLgO+MFlG9d401nT3laIToAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PewEYGoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9DEC072AA;
	Fri, 19 Apr 2024 13:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713535116;
	bh=k/tTkUxRS4T5vxu2Ors6LiIwIxRVd+MH/lkHnelFqUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PewEYGoFeY263/MiZk6ekBZPPIg63wJLNS2fMJnEVsCjItuKJ48p8Q6aiw9e1oUKH
	 ZAu3UISNE6bgbQvF2ZQbWVKCMVmWd/c7Joi9wyh34cuz9xpbJWOD6yyfNT9ErOCn/S
	 i7+k0AdGhZguoZg6s1YxpGldrcRhdTh+I99386uk=
Date: Fri, 19 Apr 2024 15:58:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Cc: stable@vger.kernel.org, Chen Jiahao <chenjiahao16@huawei.com>,
	Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] Revert "riscv: kdump: fix crashkernel reserving problem
 on RISC-V"
Message-ID: <2024041939-isotope-client-3d75@gregkh>
References: <20240416085647.14376-1-xingmingzheng@iscas.ac.cn>
 <2024041927-remedial-choking-c548@gregkh>
 <3d6784be-f6ba-48eb-ae0e-b8a20fe90f58@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d6784be-f6ba-48eb-ae0e-b8a20fe90f58@iscas.ac.cn>

On Fri, Apr 19, 2024 at 08:26:07PM +0800, Mingzheng Xing wrote:
> On 4/19/24 18:44, Greg Kroah-Hartman wrote:
> > On Tue, Apr 16, 2024 at 04:56:47PM +0800, Mingzheng Xing wrote:
> >> This reverts commit 1d6cd2146c2b58bc91266db1d5d6a5f9632e14c0 which has been
> >> merged into the mainline commit 39365395046f ("riscv: kdump: use generic
> >> interface to simplify crashkernel reservation"), but the latter's series of
> >> patches are not included in the 6.6 branch.
> >>
> >> This will result in the loss of Crash kernel data in /proc/iomem, and kdump
> >> loading the kernel will also cause an error:
> >>
> >> ```
> >> Memory for crashkernel is not reserved
> >> Please reserve memory by passing"crashkernel=Y@X" parameter to kernel
> >> Then try to loading kdump kernel
> >> ```
> >>
> >> After revert this patch, verify that it works properly on QEMU riscv.
> >>
> >> Link: https://lore.kernel.org/linux-riscv/ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv
> >> Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
> >> ---
> > 
> > I do not understand, what branch is this for?  Why have you not cc:ed
> > any of the original developers here?  Why does Linus's tree not have the
> > same problem?  And the first sentence above does not make much sense as
> > a 6.6 change is merged into 6.7?
> 
> Sorry, I'll try to explain it more clearly.
> 
> This commit 1d6cd2146c2b ("riscv: kdump: fix crashkernel reserving problem
> on RISC-V") should not have existed because this patch has been merged into
> another larger patch [1]. Here is that complete series:

What "larger patch"?  It is in Linus's tree, so it's not part of
something different, right?  I'm confused.

> c37e56cac3d62 crash_core.c: remove unneeded functions
> 39365395046fe riscv: kdump: use generic interface to simplify crashkernel reservation [1]
> fdc268232dbba arm64: kdump: use generic interface to simplify crashkernel reservation
> 9c08a2a139fe8 x86: kdump: use generic interface to simplify crashkernel reservation code
> b631b95dded5e crash_core: move crashk_*res definition into crash_core.c
> 0ab97169aa051 crash_core: add generic function to do reservation
> 70916e9c8d9f1 crash_core: change parse_crashkernel() to support crashkernel=,high|low parsing
> a9e1a3d84e4a0 crash_core: change the prototype of function parse_crashkernel()
> a6304272b03ec crash_core.c: remove unnecessary parameter of function
> 
> I checked and that series above is not present in 6.6.y. It is only present
> in 6.7+. So this commit is causing an error. Crash kernel information
> cannot be read from /proc/iomem when using the 6.6.y kernel.

Did that ever work in older kernels?  Is this a regression?  Or are the
commits in 6.7 just to fix this feature up and get it to work?

> I tested two ways to fix this error, the first one is to revert this
> commit. the second one is to backport the complete series above to 6.6.y,
> but according to stable-kernel-rules, it seems that the most appropriate
> method is the first one.

It depends if this is a regression from older kernels or not.

Please work with the maintainers of the above code to figure out what is
best to do here and get them to agree what needs to happen.

thanks,

greg k-h

