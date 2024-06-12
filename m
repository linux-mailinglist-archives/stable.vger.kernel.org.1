Return-Path: <stable+bounces-50242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FB9905297
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D673A282528
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6A816FF55;
	Wed, 12 Jun 2024 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YSsdgMbp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7A216D4F6
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195752; cv=none; b=dEop+M6VAM4yd4VTwpthI4NtNIwSH3ya/eENX8ci1FsY1I8XN24NZ64ybKvD+U8ij552feNKLJ1CdPluWbSHpexayBs8vDfzhWSG/L3g4upjCCKyKx/P1UM5j4L7UIjd7ETqNZhOvxepiCeTWnoUN6ppU4sX/ws9WdKSf/h914w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195752; c=relaxed/simple;
	bh=po3Q1dgxSB8ft2ZJeU+XxZ4RpHBnDvnnitMk/X+fedM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkXV/H1uzegdrc+o9Q9P/51JgwQ2RoZVf27AiwVlQoF7Zl7BhCvqfT1r0m9XVxQksQmHj87NhUXEpGlhlLy1nAPZiXcSojie9vMUOJ2XL/m1l7yrbTGlHY+icemiwYLSikYs+J4ztJmubqfiFAp/5hWavvW+sCPxehySjqgCjaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YSsdgMbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D854C3277B;
	Wed, 12 Jun 2024 12:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718195752;
	bh=po3Q1dgxSB8ft2ZJeU+XxZ4RpHBnDvnnitMk/X+fedM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YSsdgMbpTZV6IysnvTDp/OA9bG9egxasoJ1v26zZqw7NE/A/SslmTm3wI0c2nL/sq
	 hqbLBlaa43Kfs+P2cvQdAbo2BOZx4ubi9M+umTN3GRcO0RXVw7LlsWNIvNBg9iuAcu
	 v5UiyL2dw3TA4ma+RnngbkPzRnonvj2D6Bkv/DhI=
Date: Wed, 12 Jun 2024 14:35:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shawn Anastasio <sanastasio@raptorengineering.com>
Cc: stable@vger.kernel.org,
	Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: Backport request for "powerpc/iommu: Add iommu_ops to report
 capabilities and allow blocking domains"
Message-ID: <2024061225-groom-opal-58c1@gregkh>
References: <b7df9808-9a26-4e80-8137-d72e392b177e@raptorengineering.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7df9808-9a26-4e80-8137-d72e392b177e@raptorengineering.com>

On Wed, Jun 05, 2024 at 08:01:26PM -0500, Shawn Anastasio wrote:
> Hello,
> 
> Commit a940904443e432623579245babe63e2486ff327b ("powerpc/iommu: Add
> iommu_ops to report capabilities and allow blocking domains") fixes a
> regression that prevents attaching PCI devices to the vfio-pci driver on
> PPC64. Its inclusion in 6.1 would open the door for restoring VFIO and
> KVM PCI passthrough support on distros that rely on this LTS kernel.

Given that the commit does NOT apply to the 6.1.y kernel tree, how was
this tested?

if you want it applied, please provide a working, and tested, backport.

thanks,

greg k-h

