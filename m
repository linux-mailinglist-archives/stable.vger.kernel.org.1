Return-Path: <stable+bounces-172308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7655B30EE6
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 08:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89CE01C819B8
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 06:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911AE2E5403;
	Fri, 22 Aug 2025 06:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I33GLOLm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEA01E4AB;
	Fri, 22 Aug 2025 06:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755844018; cv=none; b=V6jqBak/voj00aOJPkiCTdJ3alobjGt1LKQUwFhotmODibxeSILWDUSx0STNdBH+rIQWjPw+njswS/yD/RD7lMeObJY7p7wb1TUmqjzqLq+9+FuJ756UPUIN8+vLSHDsLmkEmfJAtXFa52n/Gs9dvDM4kJ79P/eav4RTzVRD5Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755844018; c=relaxed/simple;
	bh=rlXSCdysonug3xLR6G1cTz3ZIYDSaelP8s3M5sv+9gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVscL3Ubiy/O3a//NxWVq37f4QAUgomZlvbqegA/ITwiJ1lW6oRjWggUEm1HQJY3DfeNpKYcqJceobLEJN6VFZshH6EdBgDsC3J+BRsYGhF9GML56634O9kK3z7bomPyq/n6YYyj67qINo2YS44QwqS9AB7SrYRLUWb8yxMzGhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I33GLOLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A23C4CEF4;
	Fri, 22 Aug 2025 06:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755844018;
	bh=rlXSCdysonug3xLR6G1cTz3ZIYDSaelP8s3M5sv+9gM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I33GLOLmmSqajW5gGPee3jQ/Ro5ZVAy6RSCKxAno/q+9ZH/+p5vZm4dI8nsDTfJYz
	 3zdK8PcZJnKUsvPWyEM7n+uD8yVghu+qYH22wr+/27FB+0dvXf8NoYnC7fQ4fnz8fV
	 jpA1Tk9TDOcIlOrO8ZafyAke1dXexmZB4aKcxoZo=
Date: Fri, 22 Aug 2025 08:26:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: stable@vger.kernel.org, jgg@nvidia.com, m.szyprowski@samsung.com,
	yilun.xu@intel.com, stable-commits@vger.kernel.org
Subject: Re: Patch "zynq_fpga: use sgtable-based scatterlist wrappers" has
 been added to the 6.16-stable tree
Message-ID: <2025082242-blemish-stylus-39e0@gregkh>
References: <2025082118-visitor-lanky-8451@gregkh>
 <aKfn1+1q0VX3zfyG@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKfn1+1q0VX3zfyG@yilunxu-OptiPlex-7050>

On Fri, Aug 22, 2025 at 11:45:27AM +0800, Xu Yilun wrote:
> On Thu, Aug 21, 2025 at 03:20:18PM +0200, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     zynq_fpga: use sgtable-based scatterlist wrappers
> > 
> > to the 6.16-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      zynq_fpga-use-sgtable-based-scatterlist-wrappers.patch
> > and it can be found in the queue-6.16 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Hi Greg:
> 
> This patch solves sgtable usage issue but causes AMD fpga driver fail,
> 
> https://lore.kernel.org/linux-fpga/202508041548.22955.pisa@fel.cvut.cz/
> 
> 
> The fix patch should be applied together with this patch:
> 
> https://lore.kernel.org/linux-fpga/20250806070605.1920909-2-yilun.xu@linux.intel.com/
> 

What is the git id of that patch in Linus's tree?

thanks,

greg k-h

