Return-Path: <stable+bounces-110864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5CCA1D5FE
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 13:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D323A53D8
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 12:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D521FF1AA;
	Mon, 27 Jan 2025 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YbiJBqqR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2996618D;
	Mon, 27 Jan 2025 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737981920; cv=none; b=enoTnhnjtuuxx9SjLQd5Q6Bym2bb3X3VCeQsNV+wdBrIPvjp+MdQaROQ+ODI0IJRPE0l0m1xPShNSa47d0CdoEfyd/TyBwpS11GEWhggLHT2n/yPWD2FCgje8SUFWx7jHuRt3WGb1OPBSrgLEjTKuGpCMTjX+DSEGUwkJrLnKYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737981920; c=relaxed/simple;
	bh=/sbuDyR0VDHv7FHvceFeZmedS67JJsWPZZEIOXcXb1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbARcCgRJlJtso3rRalpZ6mHwhVC0eud00TGWJRMdYiNufWbaMtB/Q+VyUV1O0kSqtUyTEDsAQdicbrYnBg26NMlB3Vbnt99m5RoUUAfndnY1WhyHs5FfvC6u42Mfw8Hldld3lNDZq1LlFJQ2HX45IBSlNC9yX2nedCnsigcPIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YbiJBqqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F153EC4CED2;
	Mon, 27 Jan 2025 12:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737981918;
	bh=/sbuDyR0VDHv7FHvceFeZmedS67JJsWPZZEIOXcXb1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YbiJBqqRRaM8Yw7aM2kob14cxzyUwtc3AKAwVzl+XlSw98icL2HH0F9/wNzPMP2mf
	 hxXjAoUlJwwaWrUeURs0vgWyN0qwH0kZK5SfinphMbj6YVrl8DNOyiBFmFgjCjNwhZ
	 xgge8VFi3szfBognX+H2n17Sx6/3nHAlKxlbU8Bg=
Date: Mon, 27 Jan 2025 13:45:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: stable@vger.kernel.org, song@kernel.org, yukuai3@huawei.com,
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 6.13 0/5] md/md-bitmap: move bitmap_{start, end}write to
 md upper layer
Message-ID: <2025012755-dimmed-dismount-a5a5@gregkh>
References: <20250127084928.3197157-1-yukuai1@huaweicloud.com>
 <2025012752-jolly-chowtime-d498@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025012752-jolly-chowtime-d498@gregkh>

On Mon, Jan 27, 2025 at 10:11:30AM +0100, Greg KH wrote:
> On Mon, Jan 27, 2025 at 04:49:23PM +0800, Yu Kuai wrote:
> > This set fix reported problem:
> > 
> > https://lore.kernel.org/all/CAJpMwyjmHQLvm6zg1cmQErttNNQPDAAXPKM3xgTjMhbfts986Q@mail.gmail.com/
> > https://lore.kernel.org/all/ADF7D720-5764-4AF3-B68E-1845988737AA@flyingcircus.io/
> > 
> > See details in patch 5.
> 
> Why were these all not properly taggeed for stable inclusion to start
> with?

Also, as these are not in a released kernel just yet, why should we
include them in one now before 6.14-rc1 is out?

thanks,

greg k-h

