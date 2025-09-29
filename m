Return-Path: <stable+bounces-181913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EBABA954E
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 15:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D9E3A4224
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 13:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987E42FBDFE;
	Mon, 29 Sep 2025 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IZAKjFOq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5888F26ACC
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152463; cv=none; b=s1U7/uvC1DAavDNUnXPrundCdTScPLYhtIqrmc7MSdPhzdD+bmrBc6/1WLjbKXas7Arl0BFtz8qavWqDMvzv8BQFDYB6YAPKdCI7qBVxx0vbnKDATYxv9/dS2LNEBMBB9fMjGkl3HcC1q1FBWOOmeg3u0CGjdv5Q6rIfdbt23vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152463; c=relaxed/simple;
	bh=m+WGMcfYXRnN5Zh6AHMy3m9K+ilP/OUp12K069iP64g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUN3lWuClpHFjvrnO7xPxRmEVn5TY62AHmDB31sgG06VSXvpLk59vNcsqU0ZN8GF6/7WnHVIaHoS2TMuejRIxNgwXXVCxFvqgnh/IRcRgueyirxsEfkNPFXWV413RnWIUjVIbmtSVLbt50WwhhrJTZa847X/eO9RHzRYRW1e9uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IZAKjFOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6968CC4CEF4;
	Mon, 29 Sep 2025 13:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759152462;
	bh=m+WGMcfYXRnN5Zh6AHMy3m9K+ilP/OUp12K069iP64g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZAKjFOqGoBcoP2m3bdsM2tQcv5J/zD/SvCVmZg2dIgzt0FVFYxWbHnzyZjA+LFsk
	 vdtw4AmpDMSTZyr4CRCj0hWSLcnSczkFBJrepzCZzEwuhsnIjCL5T/GHYxbFCt38R3
	 5X9PGKLncA2gfRm83DF990i+EgFx5wSZCShS9ll0=
Date: Mon, 29 Sep 2025 15:27:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wolfgang Walter <linux@stwm.de>
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>, stable@vger.kernel.org
Subject: Re: regression from 6.12.48 to 6.12.49: usb wlan adaptor stops
 working: bisected
Message-ID: <2025092930-manpower-flashily-e1fa@gregkh>
References: <01b8c8de46251cfaad1329a46b7e3738@stwm.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01b8c8de46251cfaad1329a46b7e3738@stwm.de>

On Fri, Sep 26, 2025 at 05:54:00PM +0200, Wolfgang Walter wrote:
> Hello,o
> after upgrading to 6.12.49 my wlan adapter stops working. It is detected:
> 
> kernel: mt76x2u 4-2:1.0: ASIC revision: 76120044
> kernel: mt76x2u 4-2:1.0: ROM patch build: 20141115060606a
> kernel: usb 3-4: reset high-speed USB device number 2 using xhci_hcd
> kernel: mt76x2u 4-2:1.0: Firmware Version: 0.0.00
> kernel: mt76x2u 4-2:1.0: Build: 1
> kernel: mt76x2u 4-2:1.0: Build Time: 201507311614____
> 
> but does nor work. The following 2 messages probably are relevant:
> 
> kernel: mt76x2u 4-2:1.0: MAC RX failed to stop
> kernel: mt76x2u 4-2:1.0: MAC RX failed to stop
> 
> later I see a lot of
> 
> kernel: mt76x2u 4-2:1.0: error: mt76x02u_mcu_wait_resp failed with -110
> 
> 
> I bisected it down to commit
> 
> 9b28ef1e4cc07cdb35da257aa4358d0127168b68
> usb: xhci: remove option to change a default ring's TRB cycle bit
> 
> 
> 9b28ef1e4cc07cdb35da257aa4358d0127168b68 is the first bad commit
> commit 9b28ef1e4cc07cdb35da257aa4358d0127168b68
> Author: Niklas Neronin <niklas.neronin@linux.intel.com>
> Date:   Wed Sep 17 08:39:07 2025 -0400
> 
>     usb: xhci: remove option to change a default ring's TRB cycle bit
> 
>     [ Upstream commit e1b0fa863907a61e86acc19ce2d0633941907c8e ]
> 
>     The TRB cycle bit indicates TRB ownership by the Host Controller (HC) or
>     Host Controller Driver (HCD). New rings are initialized with
> 'cycle_state'
>     equal to one, and all its TRBs' cycle bits are set to zero. When
> handling
>     ring expansion, set the source ring cycle bits to the same value as the
>     destination ring.
> 
>     Move the cycle bit setting from xhci_segment_alloc() to
> xhci_link_rings(),
>     and remove the 'cycle_state' argument from xhci_initialize_ring_info().
>     The xhci_segment_alloc() function uses kzalloc_node() to allocate
> segments,
>     ensuring that all TRB cycle bits are initialized to zero.
> 
>     Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
>     Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>     Link: https://lore.kernel.org/r/20241106101459.775897-12-mathias.nyman@linux.intel.com
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Stable-dep-of: a5c98e8b1398 ("xhci: dbc: Fix full DbC transfer ring
> after several reconnects")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> 

Does 6.17 also have this problem?

thanks,

greg k-h

