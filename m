Return-Path: <stable+bounces-95923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432109DFAB7
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 07:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE463B211D0
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 06:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B421F8EF0;
	Mon,  2 Dec 2024 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nOnDNiFi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CC8481A3;
	Mon,  2 Dec 2024 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733120996; cv=none; b=RtJviie/bR9yeKMHPZ8jp+0RpOlRzIKMRrJdHyVLxBn4a89tYTPvTqOAaai7nxPOtY6xN4Z09lAcmClcdPecO/tBR0DtKASOXt8yx6tMm0LHu1E6Em5bfPagd7VtgSc6gj37gBoe47x7zxDtyKE0L5VuB+tF1OphXzrDAmJ0P6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733120996; c=relaxed/simple;
	bh=Q+lsak6WpmNviab8JCWeOQfBMJB1auwCh9dDSAYF4Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmzskBOz5GPBDx0aO51jI4f0c9cMYnWBnaahv/4bi8wbYaTYN4r6EtWad2NUyaMj0UduEUdV+mme06AYl4tGY3/DynaiBj0MyfuHTpys8B0R7FSE2e2lr2v0eUhECC8K400B13HxGcOt4j9ZPHzUYpnEgGX4N7V4NSENgWNlXV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nOnDNiFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454F7C4CED2;
	Mon,  2 Dec 2024 06:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733120995;
	bh=Q+lsak6WpmNviab8JCWeOQfBMJB1auwCh9dDSAYF4Xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nOnDNiFisnWzsSJ/batlbGuZwblae+8KbQrf/dp9zMeo1pDnHCLTHn1hXKhjcowiV
	 KiQjy2GdNgGMawq62/e0qOXqOk78weJ/gr6JYRKPgv0VfJN9ropECpywbsFoWV6mxq
	 gcIfM1hAx0b/67CcfrAcJKcLyiyUmS7HiovTBT9Y=
Date: Mon, 2 Dec 2024 07:29:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dominique MARTINET <dominique.martinet@atmark-techno.com>
Cc: Oliver Neukum <oneukum@suse.com>, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	Greg Thelen <gthelen@google.com>,
	John Sperbeck <jsperbeck@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: usb: usbnet: fix name regression
Message-ID: <2024120259-diaphragm-unspoken-5fe0@gregkh>
References: <20241017071849.389636-1-oneukum@suse.com>
 <Z00udyMgW6XnAw6h@atmark-techno.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z00udyMgW6XnAw6h@atmark-techno.com>

On Mon, Dec 02, 2024 at 12:50:15PM +0900, Dominique MARTINET wrote:
> Hi,
> 
> Oliver Neukum wrote on Thu, Oct 17, 2024 at 09:18:37AM +0200:
> > The fix for MAC addresses broke detection of the naming convention
> > because it gave network devices no random MAC before bind()
> > was called. This means that the check for the local assignment bit
> > was always negative as the address was zeroed from allocation,
> > instead of from overwriting the MAC with a unique hardware address.
> 
> So we hit the exact inverse problem with this patch: our device ships an
> LTE modem which exposes a cdc-ethernet interface that had always been
> named usb0, and with this patch it started being named eth1, breaking
> too many hardcoded things expecting the name to be usb0 and making our
> devices unable to connect to the internet after updating the kernel.
> 
> 
> Long term we'll probably add an udev rule or something to make the name
> explicit in userspace and not risk this happening again, but perhaps
> there's a better way to keep the old behavior?
> 
> (In particular this hit all stable kernels last month so I'm sure we
> won't be the only ones getting annoyed with this... Perhaps reverting
> both patches for stable branches might make sense if no better way
> forward is found -- I've added stable@ in cc for heads up/opinions)

Device names have NEVER been stable.  They move around and can change on
every boot, let alone almost always changing between kernel versions.
That's why we created udev, to solve this issue.

But how is changing the MAC address changing the device naming here?
How are they linked to suddenly causing the names to switch around?

thanks,

greg k-h

