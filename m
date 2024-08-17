Return-Path: <stable+bounces-69374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4D6955582
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 07:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96511F23995
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 05:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1765A7D3F1;
	Sat, 17 Aug 2024 05:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MqEeOHWr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA0F2F23;
	Sat, 17 Aug 2024 05:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723871877; cv=none; b=FKmIAs+OL2e/LkZG0ERRwc6KmrwB1suT5sVovVJ1VlmT9eR+vyEdtljfZtKZFZCFteFSkSqfRlF8/+ZWfMGuC0RJfOoYbXJBgIF9RmhZ7qU1SccotbIYNzjClNoP/bW+B+UPip6Sv5qrlbQEIYERBRPdIg+UIJRcCIPj0AoNFSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723871877; c=relaxed/simple;
	bh=kxdohkZzGnZSc92jRJAMD2mosuQ9K9cXUXRgO4U8xbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAEKDS+olZnreXzs1C74RG9omGBnDMbc/YM8XdPl+qrIbskzJ4Zuhk+yq5snNgNj8aDqkwtus0vgpS/IP6UVrXTAEaIoJgMr0JBcjT45xPPFqf87C/QcEBYGS4ICSh7L/loWWfs4Mkzud2JKA1irh4xRHByPyP2EuQVBHRH2jdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MqEeOHWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEBCC116B1;
	Sat, 17 Aug 2024 05:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723871877;
	bh=kxdohkZzGnZSc92jRJAMD2mosuQ9K9cXUXRgO4U8xbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MqEeOHWrnCd7ad65ey+pouxpK7yWIcGymQlyzR1JrP0Ln0m13K8M7EiLdWjTMuKrC
	 ezS/rU/ArZ0NG0RTy75eFrPraGmSWz+USwqkZ3bzmVkSBQ9wVAPuA0vZ1xPoMtKfeh
	 yB3FyI1MHTL7uoCFWmOmpfE2U9roSPZ/gjmIpPks=
Date: Sat, 17 Aug 2024 07:17:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com,
	shijie.cai@samsung.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: dwc3: core: Prevent USB core invalid event
 buffer address access
Message-ID: <2024081700-skittle-lethargy-9567@gregkh>
References: <CGME20240815064918epcas5p1248e4f9084d33fdb11a25fa34e66cdbe@epcas5p1.samsung.com>
 <20240815064836.1491-1-selvarasu.g@samsung.com>
 <2024081618-singing-marlin-2b05@gregkh>
 <4f286780-89a2-496d-9007-d35559f26a21@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f286780-89a2-496d-9007-d35559f26a21@samsung.com>

On Fri, Aug 16, 2024 at 09:13:09PM +0530, Selvarasu Ganesan wrote:
> 
> On 8/16/2024 3:25 PM, Greg KH wrote:
> > On Thu, Aug 15, 2024 at 12:18:31PM +0530, Selvarasu Ganesan wrote:
> >> This commit addresses an issue where the USB core could access an
> >> invalid event buffer address during runtime suspend, potentially causing
> >> SMMU faults and other memory issues in Exynos platforms. The problem
> >> arises from the following sequence.
> >>          1. In dwc3_gadget_suspend, there is a chance of a timeout when
> >>          moving the USB core to the halt state after clearing the
> >>          run/stop bit by software.
> >>          2. In dwc3_core_exit, the event buffer is cleared regardless of
> >>          the USB core's status, which may lead to an SMMU faults and
> >>          other memory issues. if the USB core tries to access the event
> >>          buffer address.
> >>
> >> To prevent this hardware quirk on Exynos platforms, this commit ensures
> >> that the event buffer address is not cleared by software  when the USB
> >> core is active during runtime suspend by checking its status before
> >> clearing the buffer address.
> >>
> >> Cc: stable@vger.kernel.org # v6.1+
> > Any hint as to what commit id this fixes?
> >
> > thanks,
> >
> > greg k-h
> 
> 
> Hi Greg,
> 
> This issue is not related to any particular commit. The given fix is 
> address a hardware quirk on the Exynos platform. And we require it to be 
> backported on stable kernel 6.1 and above all stable kernel.

If it's a hardware quirk issue, why are you restricting it to a specific
kernel release and not a specific kernel commit?  Why not 5.15?  5.4?

thanks,

greg k-h

