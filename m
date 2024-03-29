Return-Path: <stable+bounces-33154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C71E891832
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 12:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F195283046
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 11:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0782A1A5;
	Fri, 29 Mar 2024 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VbSDz9fT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3AB3CF7D
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711713202; cv=none; b=aePIVPym7Sd0hcWnTBP3eZHpeDJHRroYgVpWphmENwGZSfE3MZTaXmYUoRFOwQgBfDWSsZgsprdZ+84uLxU9gc4BuAwBw1TPEldXZx/rRhYT6FT5sXR5nOYUTAT7RojIcXs4DxAS9AK2/vuOwUhMBTvnrSrWZrMBcSbvWDf1HMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711713202; c=relaxed/simple;
	bh=XvTd+eccGJcKXGpA3VgGBC+MtVKkvneet0XElL9X5tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuX9YszOGOwmPsvtM0xCyQEUiDZd+XcfdXX0RHAlrWZY6NggF9tif8BJ0WeF4dAyoSo/YeoNc7pojZKNijBLh5P/9LGZMzY9ik57k66/f4XXskrpB6/7aSfr1WA1EdAcQZFzS+FL6boPxk3SWnB7hOYPrjsFrWqyNOHB9HBZXns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VbSDz9fT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924D8C433F1;
	Fri, 29 Mar 2024 11:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711713202;
	bh=XvTd+eccGJcKXGpA3VgGBC+MtVKkvneet0XElL9X5tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VbSDz9fTd70kuU88M2AU7GI553Lw+a/5yF8KuSA+TBwdKwiYCvBNHQ8hp2SBNn1la
	 O2PXu83aafmvV9STbzPKH2Ue7s9NkpMmyt97CiShS7HeVFwVQ+00PB95KZYCGFLpf1
	 FZXpPC3FPgBAs3jGXJ879QLhreIvJ6duAy2HK7Ik=
Date: Fri, 29 Mar 2024 12:53:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, stable@vger.kernel.org,
	sashal@kernel.org
Subject: Re: [PATCH 6.6.y 0/4] vfio: Interrupt eventfd hardening for 6.6.y
Message-ID: <2024032959-improve-groove-7bac@gregkh>
References: <20240327225444.909882-1-alex.williamson@redhat.com>
 <bff69f62-692b-481e-bbad-020148894f7b@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bff69f62-692b-481e-bbad-020148894f7b@redhat.com>

On Thu, Mar 28, 2024 at 11:03:40AM +0100, Eric Auger wrote:
> Hi Alex,
> On 3/27/24 23:54, Alex Williamson wrote:
> > These backports only require reverting to the older eventfd_signal()
> > API with two parameters, prior to commit 3652117f8548
> > ("eventfd: simplify eventfd_signal()").  Thanks,
> for the series
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

All now queued up, thanks.

But what about older kernels?  These should go much further back, right?

thanks,

greg k-h

