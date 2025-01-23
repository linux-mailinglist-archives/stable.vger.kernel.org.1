Return-Path: <stable+bounces-110279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F860A1A550
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 14:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105E73A5692
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 13:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBBA211276;
	Thu, 23 Jan 2025 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ecKwwf3i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D26E20F998
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737640572; cv=none; b=aJz+xu0vkS7RAXON5bs2+3RBLz7+nPx43jkMO5QtAVE+IzWgEytW07VEsvvMuDwSwLbijq1gzpmchrMPrt47ipHrSm0+58OQChZTs2mWmaHcHFJ6atsaZdWRf7Be093Pk54kr9/J4b9u5LdpFoikRg5An1AJ468yIExoX5S4pZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737640572; c=relaxed/simple;
	bh=eYFR5Kpbe8OlQhfhD3CmNn6dUab7jsly1E9pDdzbN50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+Fp0ay6GYIFwT9GOBwB4HU5yW2d2FyywedRLSX5HpdrM9blXv+nFqhzv7hpdbxfNnwmEa2D+0SxDRZQtAFGw0cPPaxxfE0ObxU3yK18+Z9874GnGKvTeijCjI+fu22ssPUAek+Onx/KTwaDSu6/m+KTF8ocDuC+7EOamKGkkRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ecKwwf3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66820C4CEDD;
	Thu, 23 Jan 2025 13:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737640571;
	bh=eYFR5Kpbe8OlQhfhD3CmNn6dUab7jsly1E9pDdzbN50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecKwwf3iqanAFHW0PTpuNECgDCe/53c4qnaoFjYJlTWO2Tm7o9nEpzgRg82YDw2q9
	 O9aGdpr6XEyNxtoPVpLqVrFlcOpUI87gdHOSGXh4I3xfLUzYEAW797L+i/HBR/xPdL
	 ePakl4FKjWUwICMFHhTbIIawmx126UXGEO87JgNs=
Date: Thu, 23 Jan 2025 14:56:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc: "Shubham Pushpkar -X (spushpka - E INFOCHIPS PRIVATE LIMITED at Cisco)" <spushpka@cisco.com>,
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	David Sterba <dsterba@suse.com>
Subject: Re: [Internal Review] [Patch] btrfs: fix use-after-free of block
 device file in __btrfs_free_extra_devids()
Message-ID: <2025012346-submarine-dismount-f9b3@gregkh>
References: <20250123114141.1955806-1-spushpka@cisco.com>
 <Z5I/YsJbzLaTBZ/9@goliath>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5I/YsJbzLaTBZ/9@goliath>

On Thu, Jan 23, 2025 at 01:08:52PM +0000, Daniel Walker (danielwa) wrote:
> 
> Looks fine for release to me.

Released to where?  This is already in the 6.12 release, what other
stable tree should it be added to?

confused,

greg k-h

