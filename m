Return-Path: <stable+bounces-163713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB52B0DAA7
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7CE16D13D
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC412E338B;
	Tue, 22 Jul 2025 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dfpmbrNo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2325E282F5;
	Tue, 22 Jul 2025 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190402; cv=none; b=h10Nqb38at0VG1MH/IfL5UnEodo97BDN+YWswWoAvxBSUpCERILrme3UYP35lR40QFkWOe+D5B5GWTXHNZhnzd++M+G26nyQcXYYGtA5CmNCJA7c1kTNXN6gJxtdNshUYzc1rrARwZDjsB5leergClBZyJje/4pqNL6Dz5McKzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190402; c=relaxed/simple;
	bh=yJib0iOZQEofOelVhYch2rjGbC0RQyv5LUtihrEDWS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBkjjnYCNam8jXedItFmhReaz4SQjj2bKsS76NuQDPcWJ9Fp5/lQPPhBEuSztSAQsDM/1mpxb5CIBKbkUWatLTMouM7bMhZsG+ptLjmdFF5vvDrC0mksEXipSLY2EkNHqzmAtbKjUQhVmzg2NrOZq/Y6pScIjf4+XakpxJnmhsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dfpmbrNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED1DC4CEEB;
	Tue, 22 Jul 2025 13:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753190401;
	bh=yJib0iOZQEofOelVhYch2rjGbC0RQyv5LUtihrEDWS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dfpmbrNoMfXrtHC5vf3Ha4Wrlb4aQIrOeQk1NZN02aMeuLtbG6cnc8l6eQmXDGoGZ
	 8YcV4p2P1pH01KNp+nOFFnvwEzUcnHxOBL9pPv4/ZgKBFobin0mQrhg2/MMIscXLV4
	 jZUd9rF2aYnx2z4yJwTr61IGfMQh9qxugwObZxbo=
Date: Tue, 22 Jul 2025 15:19:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ban ZuoXiang <bbaa@bbaa.fun>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, bbaa@bbaa.moe
Subject: Re: [REGRESSION][BISECTED] PCI =?utf-8?Q?P?=
 =?utf-8?Q?assthrough_=2F_SR-IOV_Failure_on_Stable_Kernel_?= =?utf-8?B?4oml?=
 v6.12.35
Message-ID: <2025072222-dose-lifting-e325@gregkh>
References: <721D44AF820A4FEB+722679cb-2226-4287-8835-9251ad69a1ac@bbaa.fun>
 <6294f64a-d92d-4619-aef1-a142f5e8e4a5@linux.intel.com>
 <5F974FF84FAB6BD8+4a13da11-7f32-4f58-987a-9b7e1eaeb4aa@bbaa.fun>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5F974FF84FAB6BD8+4a13da11-7f32-4f58-987a-9b7e1eaeb4aa@bbaa.fun>

On Tue, Jul 22, 2025 at 09:14:08PM +0800, Ban ZuoXiang wrote:
> > Thanks for reporting. Can this issue be reproduced with the latest
> > mainline linux kernel? Can it work if you simply revert this commit?
> >
> > Thanks,
> > baolu 
> 
> Hi, baolu
> 
> The issue cannot be reproduced on the latest mainline kernel (6.16.0-rc7-1-mainline).
> The Ubuntu v6.14-series kernel which also include the commit is also not affected.
> I think the issue only affects the v6.12 series in linux-stable tree. Should I wait for the stable maintainers to solve it?

Nope!  We need your help as you are the one that can reproduce it :)

Are we missing a backport?  Did we get the backport incorrect?  Should
we just revert it?

thanks,

greg k-h

