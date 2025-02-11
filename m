Return-Path: <stable+bounces-114839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEE6A30322
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 06:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86DBC166C0D
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 05:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ED61E5B78;
	Tue, 11 Feb 2025 05:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZVAPunx2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8F526BD92;
	Tue, 11 Feb 2025 05:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739253573; cv=none; b=slwBhmvOABA9F4dpKqNGWw/kIaG3274XD4lyZ7hLM7pLn8VX/MqBwseEEVjf7PPfy0CaEnP/XIWdEiPqyalkBAWZZPT7Ppbz0DNqOXe9w9ckJkXaPyPZ2nGOIcEP1mOg6Aa9BpsXTvjPHbzDg4fGgfc60r0JqwbUTApd3aLEm2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739253573; c=relaxed/simple;
	bh=sdntzUYPKMFgCsaGnaIYA/kTz7P7GEVr0mar4xXCQ1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQjWM3SwR3DuVKQqh6PAZJFzzdz8Eyhtb2zDbaqlXN/9G9PWnnvv9mVq8jxdmeJ2pgXm3jVbgAsOqTM7kwHXi0uFL3Q6eCZJMMYnKyaLMaq/GTKG8VB5dNsDrsFFLPXAxtEKBsvImcxGqjhX/5sxi4Kldyyy9RCRUB1zEFwnS6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZVAPunx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0810BC4CEDD;
	Tue, 11 Feb 2025 05:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739253572;
	bh=sdntzUYPKMFgCsaGnaIYA/kTz7P7GEVr0mar4xXCQ1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZVAPunx24vxENEflgtcTRP+PcpLKkKDCNCl1J/i8+f0w1mTNKzybu+qe1hrcVwsvo
	 /5C80/lZykGq4HFxCc3LbexNqSQYJIEZ8p+khLJGTF3chbdLODDouonEK0IkXijm+n
	 0J8MenFT7qkOljV0Cz+hJ5G2Z+MyOPDSamm0vbv8=
Date: Tue, 11 Feb 2025 06:58:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: mathias.nyman@intel.com, WeitaoWang-oc@zhaoxin.com,
	Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	h10.kim@samsung.com, eomji.oh@samsung.com, alim.akhtar@samsung.com,
	thiagu.r@samsung.com, muhammed.ali@samsung.com,
	pritam.sutar@samsung.com, cpgs@samsung.com, stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: Initialize unassigned variables to fix
 possible errors
Message-ID: <2025021141-numeric-manifesto-4b2d@gregkh>
References: <CGME20250210131144epcas5p4a0599050f5973b495db0371021c21e27@epcas5p4.samsung.com>
 <1891546521.01739216582564.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1891546521.01739216582564.JavaMail.epsvc@epcpadp2new>

On Mon, Feb 10, 2025 at 06:41:23PM +0530, Selvarasu Ganesan wrote:
> Fix the following smatch errors:
> 
> drivers/usb/host/xhci-mem.c:2060 xhci_add_in_port() error: unassigned variable 'tmp_minor_revision'
> drivers/usb/host/xhci-hub.c:71 xhci_create_usb3x_bos_desc() error: unassigned variable 'bcdUSB'
> 
> Fixes: d9b0328d0b8b ("xhci: Show ZHAOXIN xHCI root hub speed correctly")
> Fixes: eb02aaf21f29 ("usb: xhci: Rewrite xhci_create_usb3_bos_desc()")

This should be two different changes, right?

Please break it up and send as a patch series.

thanks,

greg k-h

