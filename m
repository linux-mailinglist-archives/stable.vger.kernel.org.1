Return-Path: <stable+bounces-67756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E57A952B3E
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 11:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3B11C213D4
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 09:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBC91A00CB;
	Thu, 15 Aug 2024 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wkZBihOx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5140819D884
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710951; cv=none; b=m0YGsL3OKW0T73TJb9skItYsmgSftxJ15DFpJGmDTX3cxm2796ku0SAcHxKyWiSO665EEJC+WazVwT16t7UTYuHHSEl/+44Wj27sMvf0LY7Pg8hrMSnTu4eWSwmfnzsjOPXSTVhKGxnoRyI6nYvqH/71H9jwVMfC6Ai3Hzc5yDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710951; c=relaxed/simple;
	bh=1TMgSN8bO3JqRVVj0Ks7HWYCudge5pMOnJYD9O3GuLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2zBeD04bacvxaHklNtq5f0HWdQ7jYZY61Or+5/vThpd2ogTqr3dR7DRn26tbTmmzJ2WrSQkcdLmCqM+scfUclQSlevRAcLWrCtR5xuNdsuIcpeO734P4gvICcOq2twPOPHavVIpk9gJn0DANH5qbktRTPubIc7U65WxNBuF2j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wkZBihOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6922FC32786;
	Thu, 15 Aug 2024 08:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723710950;
	bh=1TMgSN8bO3JqRVVj0Ks7HWYCudge5pMOnJYD9O3GuLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wkZBihOxa1ePP16Av/OD0JknYFdz3HD/RiMxJfasNJfX+9fKPbqfsZmWwanKGHR+k
	 xOX959qG6dBarFuesC0HKezL0DOA3Nmn4dPc4EWc9HEnLkX9ghtZKc20ato/d1qQ5o
	 HW3Acfdk+UlNh3UBwphduYVOvt2aT+fw96OrNFFU=
Date: Thu, 15 Aug 2024 10:35:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: David Stevens <stevensd@chromium.org>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org
Subject: Re: [PATCH 6.6 1/2] genirq/cpuhotplug: Skip suspended interrupts
 when restoring affinity
Message-ID: <2024081532-excluding-subpanel-2424@gregkh>
References: <20240814182826.1731442-1-bvanassche@acm.org>
 <20240814182826.1731442-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814182826.1731442-2-bvanassche@acm.org>

On Wed, Aug 14, 2024 at 11:28:25AM -0700, Bart Van Assche wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> commit a60dd06af674d3bb76b40da5d722e4a0ecefe650 upstream.
> 
> irq_restore_affinity_of_irq() restarts managed interrupts unconditionally
> when the first CPU in the affinity mask comes online. That's correct during
> normal hotplug operations, but not when resuming from S3 because the
> drivers are not resumed yet and interrupt delivery is not expected by them.
> 
> Skip the startup of suspended interrupts and let resume_device_irqs() deal
> with restoring them. This ensures that irqs are not delivered to drivers
> during the noirq phase of resuming from S3, after non-boot CPUs are brought
> back online.
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20240424090341.72236-1-stevensd@chromium.org
> ---
>  kernel/irq/cpuhotplug.c | 11 ++++++++---
>  kernel/irq/manage.c     | 12 ++++++++----
>  2 files changed, 16 insertions(+), 7 deletions(-)

When forwarding patches on from others, you always have to sign off on
them :(

thanks,

greg k-h

