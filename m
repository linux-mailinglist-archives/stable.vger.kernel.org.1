Return-Path: <stable+bounces-172785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 028D0B33715
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 09:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2431200D37
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 07:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DEB2882DB;
	Mon, 25 Aug 2025 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gLZ1mKLR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E3128BAB9;
	Mon, 25 Aug 2025 07:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756105259; cv=none; b=QG/7zdY+qDj8wI9KreXu3V+xHFqJBAlqtkLwmN4T+1z5KAQ5Q5GuS3qqkc1RkTCmOHropGl5OQHtxPMLbeDvB1M2Jo6CsbVaiJSDkVGLf3pLE4Qgzn5hMP5NUIC3b4GjOFmHf1Eb/pXGOb8LBMelxRhONRX+kTimRXzsyKWMseo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756105259; c=relaxed/simple;
	bh=ZFGRT8XhbRRDu0zZf/hkL81JK0HxzTeqjggcqL9BvtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gy65zLuX/Oi4DX2iAtVdIO68O5fXI0queAY19bD6pfZdLNb6uOaiMZHqpKmgJD41rnAkjzfQe4gVb/rsiEiKE6Y+XFMAD9aqhjJMY5szQHUWb6KA0IlKami7aHxARIB3a3GC+F6gkraKZZj1T57CPO0UdsRGfu8WfhqdmH0h5uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gLZ1mKLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7784BC116C6;
	Mon, 25 Aug 2025 07:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756105258;
	bh=ZFGRT8XhbRRDu0zZf/hkL81JK0HxzTeqjggcqL9BvtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gLZ1mKLREkZX3OCMEgBA3fWb6wt73e9RZbny9aOfsOz6X2hCLGrqiJNoP1ohHMXjN
	 P9/4Qco/Yz+EAfjSvLlyMKO3YZDc1QrO2hMNBnojywAMCKo4sxPXLftH4DZbCvqwG6
	 ji2kSuHMd4bf6MPAm7CLvuwz98uHUqKj5/N0k5ZM=
Date: Mon, 25 Aug 2025 09:00:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: stable@vger.kernel.org, jgg@nvidia.com, m.szyprowski@samsung.com,
	yilun.xu@intel.com, stable-commits@vger.kernel.org
Subject: Re: Patch "zynq_fpga: use sgtable-based scatterlist wrappers" has
 been added to the 6.16-stable tree
Message-ID: <2025082539-hug-spellbind-6779@gregkh>
References: <2025082118-visitor-lanky-8451@gregkh>
 <aKfn1+1q0VX3zfyG@yilunxu-OptiPlex-7050>
 <2025082242-blemish-stylus-39e0@gregkh>
 <aKvCfK8gV0UJy+wD@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKvCfK8gV0UJy+wD@yilunxu-OptiPlex-7050>

On Mon, Aug 25, 2025 at 09:55:08AM +0800, Xu Yilun wrote:
> On Fri, Aug 22, 2025 at 08:26:55AM +0200, Greg KH wrote:
> > On Fri, Aug 22, 2025 at 11:45:27AM +0800, Xu Yilun wrote:
> > > On Thu, Aug 21, 2025 at 03:20:18PM +0200, gregkh@linuxfoundation.org wrote:
> > > > 
> > > > This is a note to let you know that I've just added the patch titled
> > > > 
> > > >     zynq_fpga: use sgtable-based scatterlist wrappers
> > > > 
> > > > to the 6.16-stable tree which can be found at:
> > > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > > 
> > > > The filename of the patch is:
> > > >      zynq_fpga-use-sgtable-based-scatterlist-wrappers.patch
> > > > and it can be found in the queue-6.16 subdirectory.
> > > > 
> > > > If you, or anyone else, feels it should not be added to the stable tree,
> > > > please let <stable@vger.kernel.org> know about it.
> > > 
> > > Hi Greg:
> > > 
> > > This patch solves sgtable usage issue but causes AMD fpga driver fail,
> > > 
> > > https://lore.kernel.org/linux-fpga/202508041548.22955.pisa@fel.cvut.cz/
> > > 
> > > 
> > > The fix patch should be applied together with this patch:
> > > 
> > > https://lore.kernel.org/linux-fpga/20250806070605.1920909-2-yilun.xu@linux.intel.com/
> > > 
> > 
> > What is the git id of that patch in Linus's tree?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1ca61060de92a4320d73adfe5dc8d335653907ac
> 
> But I see the original "CC: stable@vger.kernel.org" tag is removed.

I picked it up a few days ago, so all is good, thanks.

greg k-h

