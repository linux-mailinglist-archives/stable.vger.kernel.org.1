Return-Path: <stable+bounces-64787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D52FF9433E9
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 18:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82ECB1F23579
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 16:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEC71BC06F;
	Wed, 31 Jul 2024 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nohRCWVl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F3E1B29A7;
	Wed, 31 Jul 2024 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442358; cv=none; b=GizKV0jOnd9nXz9txnSv+I9ZkpX5yXnXR2A6oGcI/mxSf4DWGwQCFrCh/QFZK0FKt4MoVCtqXJjnsxkNCILc01W8aEBIo4LCVnGEHZSo+9zydhA/OB2nYPxIS+YPueqsa3O7nBO/8UtSlBrUpFXo2Y2w8Sn3Y2b1QHWXXSOq7LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442358; c=relaxed/simple;
	bh=gq5iza4NF9H19lEIhd/P8tk5lcjFT21LKlLzDAN6oGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFjjyryl5tZ8kVORYcGTNSNCV71JuEb/YSwBuPRY5hiyPFIqQ0blU+zGtkiW+jLj6dMZEhZKm5UwVGBArvYiwFbQPU4MBMlNrUt1njR89eSp5WZgs5DdAqOTYid2Hys8npP4C3g5MdpP2peYLUpCjhCSuG4unHW8mxqhjJ2gYNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nohRCWVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC11CC116B1;
	Wed, 31 Jul 2024 16:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722442358;
	bh=gq5iza4NF9H19lEIhd/P8tk5lcjFT21LKlLzDAN6oGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nohRCWVl5+POoi2RtpgMJ+9ZceSmjHK6QcI7T25B8eSInqPT8UXQE/TDfi5FMQXH/
	 9y7RBhaaRjRLCUh6rIpgAMvagxIv5/L3VSQzEJtNYSLf3Vdcyi26PMeU7yjZyURl5y
	 2lYXF/d3A/XYidR6fcGExI6bbHwXfP0+8kPimBeM=
Date: Wed, 31 Jul 2024 18:12:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Pirko <jiri@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stable@vger.kernel.org,
	patches@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.10 259/809] virtio_net: add support for Byte Queue
 Limits
Message-ID: <2024073128-emergency-backspin-11ff@gregkh>
References: <20240730151724.637682316@linuxfoundation.org>
 <20240730151734.824711848@linuxfoundation.org>
 <20240730153217-mutt-send-email-mst@kernel.org>
 <2024073119-gentleman-busybody-8091@gregkh>
 <Zqph1kRQx0FU4L3I@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqph1kRQx0FU4L3I@nanopsycho.orion>

On Wed, Jul 31, 2024 at 06:09:58PM +0200, Jiri Pirko wrote:
> Wed, Jul 31, 2024 at 07:46:26AM CEST, gregkh@linuxfoundation.org wrote:
> >On Tue, Jul 30, 2024 at 03:33:18PM -0400, Michael S. Tsirkin wrote:
> >> On Tue, Jul 30, 2024 at 05:42:15PM +0200, Greg Kroah-Hartman wrote:
> >> > 6.10-stable review patch.  If anyone has any objections, please let me know.
> >> 
> >> Wow.
> >> 
> >> It's clearly a feature, not a bugfix. And a risky one, at that.
> >> 
> >> Applies to any stable tree.
> >
> >Now dropped, thanks.
> 
> I wonder, how this got into the stable queue?

Stable-dep-of: f8321fa75102 ("virtio_net: Fix napi_skb_cache_put warning")


