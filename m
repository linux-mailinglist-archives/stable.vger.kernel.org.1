Return-Path: <stable+bounces-69869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DEA95AFC3
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 09:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE021F2207B
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 07:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20336165F11;
	Thu, 22 Aug 2024 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uCenwbu9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15B51D12EA;
	Thu, 22 Aug 2024 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313576; cv=none; b=QkldQwL9XhrSsyx6QFMHc6mebLODPzAjxXZR5jMcnSAWZNvT0M6m6Qg+/y72gdE5Mfsrt2wicjcqyDol8VhXK0kUiJtRUFpQ/nSNqJ6KukfyFx+g0sFEj5WkSMYZPjqGHYzpvvczvHB8iH3rs6NZhqk7XbVhy3ZEuS/634/YvNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313576; c=relaxed/simple;
	bh=OMRaVUfkgBOS/ydy85MiTpiO8SuezrvTPeHkVgl84Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKcxTqZNaYph7r5BzilNB89PFQezdHFEpen0TTcj4SFBMewKTiyKZEN2Bpg2fAZWGwfn4rbXH7EsrQb2BaIo2OiEUhHWj1qcKnL4SrmMNSiDAnhTDF/p4uPGk086vDAl6aFE40jyIGEnBOsbnJARrzdJZcYoNwHgjuv9seUEMvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uCenwbu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFA1C4AF0C;
	Thu, 22 Aug 2024 07:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724313576;
	bh=OMRaVUfkgBOS/ydy85MiTpiO8SuezrvTPeHkVgl84Ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uCenwbu9YYwwECz8i1SyhtXbJlNMkFAxdqOYES/Pf6gN7i2siRxEVL36XQ6eqmClg
	 iLVnZIB6ogF03Gjps2NdMpSiYDG7TLarv78PkVeaHgEuHnHJpCRLh46Sm3Nha0H6oZ
	 OTWDrybEkiRuQ28xLD006PC2NVQLSagduC2OeQKI=
Date: Thu, 22 Aug 2024 15:59:33 +0800
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
Message-ID: <2024082212-copper-oversight-f84f@gregkh>
References: <CGME20240815064918epcas5p1248e4f9084d33fdb11a25fa34e66cdbe@epcas5p1.samsung.com>
 <20240815064836.1491-1-selvarasu.g@samsung.com>
 <2024081618-singing-marlin-2b05@gregkh>
 <4f286780-89a2-496d-9007-d35559f26a21@samsung.com>
 <2024081700-skittle-lethargy-9567@gregkh>
 <c477fdb2-a92a-4551-b6c8-38ada06914c6@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c477fdb2-a92a-4551-b6c8-38ada06914c6@samsung.com>

On Sat, Aug 17, 2024 at 07:13:53PM +0530, Selvarasu Ganesan wrote:
> 
> On 8/17/2024 10:47 AM, Greg KH wrote:
> > On Fri, Aug 16, 2024 at 09:13:09PM +0530, Selvarasu Ganesan wrote:
> >> On 8/16/2024 3:25 PM, Greg KH wrote:
> >>> On Thu, Aug 15, 2024 at 12:18:31PM +0530, Selvarasu Ganesan wrote:
> >>>> This commit addresses an issue where the USB core could access an
> >>>> invalid event buffer address during runtime suspend, potentially causing
> >>>> SMMU faults and other memory issues in Exynos platforms. The problem
> >>>> arises from the following sequence.
> >>>>           1. In dwc3_gadget_suspend, there is a chance of a timeout when
> >>>>           moving the USB core to the halt state after clearing the
> >>>>           run/stop bit by software.
> >>>>           2. In dwc3_core_exit, the event buffer is cleared regardless of
> >>>>           the USB core's status, which may lead to an SMMU faults and
> >>>>           other memory issues. if the USB core tries to access the event
> >>>>           buffer address.
> >>>>
> >>>> To prevent this hardware quirk on Exynos platforms, this commit ensures
> >>>> that the event buffer address is not cleared by software  when the USB
> >>>> core is active during runtime suspend by checking its status before
> >>>> clearing the buffer address.
> >>>>
> >>>> Cc: stable@vger.kernel.org # v6.1+
> >>> Any hint as to what commit id this fixes?
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
> >>
> >> Hi Greg,
> >>
> >> This issue is not related to any particular commit. The given fix is
> >> address a hardware quirk on the Exynos platform. And we require it to be
> >> backported on stable kernel 6.1 and above all stable kernel.
> > If it's a hardware quirk issue, why are you restricting it to a specific
> > kernel release and not a specific kernel commit?  Why not 5.15?  5.4?
> 
> Hi Greg,
> 
> I mentioned a specific kernel because our platform is set to be tested 
> and functioning with kernels 6.1 and above, and the issue was reported 
> with these kernel versions. However, we would be fine if all stable 
> kernels, such as 5.4 and 5.15, were backported. In this case, if you 
> need a new patch version to update the Cc tag for all stable kernels, 
> please suggest the Cc tag to avoid confusion in next version.

I'll fix it up when applying it, thanks.

greg k-h

