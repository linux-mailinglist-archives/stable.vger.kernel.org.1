Return-Path: <stable+bounces-164429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C61A2B0F1F6
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 14:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD4707B3919
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 12:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0C52E5B0E;
	Wed, 23 Jul 2025 12:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TOAGkENw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DCE26E712;
	Wed, 23 Jul 2025 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272710; cv=none; b=D+QTswhznirxSj/RQCMgaIEYFS44JeYBtdjUfRcOW2pYoTLBN5lyEzXIvahe66wFHZ+RSj6wvTDyadVmqjspo1cE21uQbui0pxJXknCwLtJrM/iXrUa/jiXbmYfnmesnKJXchH9EBjOF4zvMTDyPi6zLEczMVVgoYhzWOVmrqIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272710; c=relaxed/simple;
	bh=izqxBYMXbdnI2uUmk/bBSzBtQCdsRbqjae2iSspGBjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAenjw6fpeCW9WwNmdPvnXzwN1ka2i89rGzVNGbduMCS2iwMjgi9y0uPLPAw0qMvBrhGvI6AJRBqeinverKzW5aZmWP2DzjUrLn4RPioc7gVlPbiwGUb7x7AQjpHM1at15K/s/gTGy7Hzj2i+J4WTJvzRd2W+Otr0ARh6DU+8Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TOAGkENw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE09C4CEE7;
	Wed, 23 Jul 2025 12:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753272709;
	bh=izqxBYMXbdnI2uUmk/bBSzBtQCdsRbqjae2iSspGBjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOAGkENwP8ypT0rzTG8ZY2u94ep2ojiKDmSFHVJG1RYF74lMoqqWrbVnL8+6jBJAy
	 mz4hxpK1+WZq9nf/k8+ztx1lHLc8TrqUzRbuYe6lST1RqZrnqh9in36bjM2at6Nz2d
	 MNyEUGXbEtJg5BevXNnEpt6dJWhGYyuKn13CDfDk=
Date: Wed, 23 Jul 2025 14:11:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ban ZuoXiang <bbaa@bbaa.fun>
Cc: stable@vger.kernel.org, iommu@lists.linux.dev, baolu.lu@linux.intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Fix misplaced domain_attached assignment
Message-ID: <2025072339-observant-diner-7716@gregkh>
References: <468CF4B655888074+20250723120423.37924-1-bbaa@bbaa.fun>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <468CF4B655888074+20250723120423.37924-1-bbaa@bbaa.fun>

On Wed, Jul 23, 2025 at 08:04:23PM +0800, Ban ZuoXiang wrote:
> Commit fb5873b779dd ("iommu/vt-d: Restore context entry setup order
> for aliased devices") was incorrectly backported: the domain_attached
> assignment was mistakenly placed in device_set_dirty_tracking()
> instead of original identity_domain_attach_dev().
> 
> Fix this by moving the assignment to the correct function as in the
> original commit.
> 
> Fixes: fb5873b779dd ("iommu/vt-d: Restore context entry setup order for aliased devices")
> Closes: https://lore.kernel.org/linux-iommu/721D44AF820A4FEB+722679cb-2226-4287-8835-9251ad69a1ac@bbaa.fun/
> Cc: stable@vger.kernel.org
> Reported-by: Ban ZuoXiang <bbaa@bbaa.fun>
> Signed-off-by: Ban ZuoXiang <bbaa@bbaa.fun>
> ---
>  drivers/iommu/intel/iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Now queued up, thanks!

greg k-h

