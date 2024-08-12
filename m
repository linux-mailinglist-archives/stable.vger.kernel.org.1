Return-Path: <stable+bounces-66553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D1394EFD4
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5AF31F2361E
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98649183CBA;
	Mon, 12 Aug 2024 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bivtU72P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5806A183CB1
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473692; cv=none; b=HW5Md9wXlshSLON8yuy6QdF5eG1Tqe87mV/C8NMFEJmVQVAiVNf2XOGp1kIqIfgNuEsvvf011e8nXecrbCQxy7djzJjRhN+gM95B23pDz7aiqPrYNhfj4k8DlvnJG+LrznH0vXU1Xs1fXLaZ/aoiskU4e6eyyIfnYVz4x4/lHTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473692; c=relaxed/simple;
	bh=CMlixNh8/YU3d3IVorxyqGf5YmpiVgk5zNwt19KJ/j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfHrlN/RfuHN+oRvsFeoXM0NiL8l8pKYGxBtVOdr62sQI9lPdjpvEdmCKxtbJ6zLAVPFzqXm6Sjhqlj7dgsuTjSL1GZoosmvdtHrCH13EumvcFYP5hFTF+CvTdgKuEETVvqAfVmdK70/yRynT5KxNrv+DFH7r1WV5bqxzWQ1xXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bivtU72P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA72C4AF09;
	Mon, 12 Aug 2024 14:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723473692;
	bh=CMlixNh8/YU3d3IVorxyqGf5YmpiVgk5zNwt19KJ/j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bivtU72P5n9fv0XDho7J0vxo7+rlVL8pPcMcTNu/TcQMPdMVIpG1c4svL7xN6I+Yu
	 6x0JgXdJ1sFCtXAaVBGfHItLepJgSo2aFd4TN69xY8Akmis6+7grDnBVHLudXNjlMX
	 M6t+UMC1xTJzPhuU3cuJ9JGsYNUsWXQrjYRUiHdM=
Date: Mon, 12 Aug 2024 16:41:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kevin Berry <kpberry@google.com>
Cc: stable@vger.kernel.org, ovt@google.com
Subject: Re: [PATCH 0/1] xfs: fix log recovery buffer allocation for the
Message-ID: <2024081203-striving-music-7e6a@gregkh>
References: <20240810011646.3746457-1-kpberry@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810011646.3746457-1-kpberry@google.com>

On Sat, Aug 10, 2024 at 01:16:45AM +0000, Kevin Berry wrote:
> Hi folks, in order to fix CVE-2024-39472 in kernels 5.15, 6.1, and 6.6,
> I have adapted the mainline patch 45cf976008dd (xfs: fix log recovery
> buffer allocation for the legacy h_size fixup) to resolve conflicts
> with those kernels. Specifically, the mainline patch uses kvfree, but
> the amended patch uses kmem_free since kmem_free was used in xfs until
> patch 49292576136f (xfs: convert kmem_free() for kvmalloc users to
> kvfree()).
> 
> I tested the patch by applying it to the above kernels and recompiling
> them. I also ran xfstests on the 6.6.43 kernel with the patch applied.
> In my initial xfstests run, all xfs and generic tests passed except for
> generic/082, generic/269, generic/627, and xfs/155, but those tests all
> passed on a second run. I'm assuming those initial failures were
> unrelated to this patch, unless someone more familiar with those tests
> thinks otherwise.
> 
> I'd be more than happy to do any more verification or tests if they're
> required. Thanks!

Note, for xfs changes, you do need to actually cc: the xfs developers :(

Please do so in the future...

thanks,

greg k-h

