Return-Path: <stable+bounces-128822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F84FA7F52C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 08:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2AAC3B251F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 06:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692AF20E031;
	Tue,  8 Apr 2025 06:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="apBmzCAY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A4F1865E5;
	Tue,  8 Apr 2025 06:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744094774; cv=none; b=Yi6cyRpNwXuArSg106y7lCjOepNQVzQJoGz2AVMpGvzEH4m9z5vWmB62euQkIEytbeVtozQWBzQJhou3E5c+ivx8Nvbf4yV2ksMwfF2ny1jc5uvyfZy62JnMNfYb/9OWxgC7dmj3uQxPL2TsxBhybOKtXjefT/ZMSer7sH6Z31k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744094774; c=relaxed/simple;
	bh=IUDmoeOeSZ2ZiqTBuyZEpCQWRPAGzE4Mub+k1wf5svU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J024ixPBzTpSYOJ5Rk7Yok8b7YFw9R5hi2SBKMiD0UT+ypAB13JopqxbrovEzhm+eBvHhktF9dxNd2cRFj/WtozGc7jdS21BNHR5y2IWaIwOXTBlLUedIpVYNZipi7BmaF9MkuxDQpajSGOejchZVugvMIHHOBnHqbry6ACZtpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=apBmzCAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27432C4CEE9;
	Tue,  8 Apr 2025 06:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744094773;
	bh=IUDmoeOeSZ2ZiqTBuyZEpCQWRPAGzE4Mub+k1wf5svU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=apBmzCAYqNAaV6wr2xTQCcfX8897VkajKQUXwX1939+BEqsKT1p37QQmVJ0eDUVwQ
	 RfjzHnJ7fVlMtw62tp3mkKL4F9E54gDOSrDE92c33jZRXi250dBF2gGr3PfERqteyU
	 rsZ8XxqSDKTzM2HMDZtfirfEaFyik9txnlm1QW5E=
Date: Tue, 8 Apr 2025 08:44:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexander Wetzel <alexander@wetzel-home.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Patch "wifi: mac80211: remove debugfs dir for virtual monitor"
 has been added to the 6.13-stable tree
Message-ID: <2025040829-zone-barman-1690@gregkh>
References: <20250407152519.3128878-1-sashal@kernel.org>
 <ce57a679-9449-479a-aaef-58226c3445cd@wetzel-home.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce57a679-9449-479a-aaef-58226c3445cd@wetzel-home.de>

On Mon, Apr 07, 2025 at 06:23:27PM +0200, Alexander Wetzel wrote:
> On 4/7/25 17:25, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      wifi: mac80211: remove debugfs dir for virtual monitor
> > 
> > to the 6.13-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       wifi-mac80211-remove-debugfs-dir-for-virtual-monitor.patch
> > and it can be found in the queue-6.13 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> 
> The commit here is causing a sparse warning. Please always add commit
> 861d0445e72e ("wifi: mac80211: Fix sparse warning for monitor_sdata") when
> you backport this patch to avoid that. (So far I got the  backport
> notification for 6.12 and 6.13.)
> 
> It's also no big deal when you decide to not backport this patch.

Now queued up, thanks.

greg k-h

