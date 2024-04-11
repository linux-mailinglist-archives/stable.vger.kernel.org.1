Return-Path: <stable+bounces-39181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2E68A1394
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 13:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1AF1C20B1E
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 11:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4926D14A084;
	Thu, 11 Apr 2024 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pRm8z+sK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2363399F
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836258; cv=none; b=hnC0DdjdeA8aID7HKhoGw0UsOk4zGLk9IciqO335K/MUx9L5jkoEn7ZCqvaI/ws9D8+U/4ccO8LgYdtjPnCdqIIUL9uwGTAu+0Hj8sVytqkAQF6R/QdfPzSYUUKuNxBxjXzI1fc7EMR+m2lgHOhF6rooPPjzXbbsGddIaozUIXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836258; c=relaxed/simple;
	bh=EB/XQiRUR5cHdynRUpdtnd48nMSmaI97MaHlvzF1fM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpdwUN5TGAGeizMo82+TwCMYrcy8Sj0ErdQLXcCBoqJ/fDRJI3GMrwIGImRxwaXllM/RZlcLjYZcpu3WIvcbrfegxANqU9U2q9UsbhughXDN1QYR8rloPzVZA98EmqQKtk1yXj14OCFuaACBddkzPOTTNWJi2Kn4dTtMvBtbjgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pRm8z+sK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35582C43390;
	Thu, 11 Apr 2024 11:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712836257;
	bh=EB/XQiRUR5cHdynRUpdtnd48nMSmaI97MaHlvzF1fM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pRm8z+sKBHwt6fN1KZk4zkO63q9apxwGDsj7JVFtOOAxxaI5elNCZ4bpErwtYWZgr
	 rULfIj1CTQ+UFNydY+/p6s51p8fVt6lMv1tyGcuLpN0KMGkfVYvR18tm+odN6mgSti
	 t3qkls7bTHu4X/F7+KOHv8Xg/hgaxgT9ZgMlkBOc=
Date: Thu, 11 Apr 2024 13:50:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>
Subject: Re: v5.15 backport request
Message-ID: <2024041113-flyaway-headphone-df2b@gregkh>
References: <CAMj1kXEGNNZm9RrDxT6RzmE8WGFG-3kZePaZZNKJrT4fj3iveg@mail.gmail.com>
 <2024041134-strobe-childhood-cc74@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041134-strobe-childhood-cc74@gregkh>

On Thu, Apr 11, 2024 at 12:30:30PM +0200, Greg KH wrote:
> On Thu, Apr 11, 2024 at 12:23:37PM +0200, Ard Biesheuvel wrote:
> > Please consider the commits below for backporting to v5.15. These
> > patches are prerequisites for the backport of the x86 EFI stub
> > refactor that is needed for distros to sign v5.15 images for secure
> > boot in a way that complies with new MS requirements for memory
> > protections while running in the EFI firmware.
> 
> What old distros still care about this for a kernel that was released in
> 2021?  I can almost understand this for 6.1.y and newer, but why for
> this one too?

To be more specific, we have taken very large backports for some
subsystems recently for 5.15 in order to fix a lot of known security
issues with the current codebase, and to make the maintenance of that
kernel easier over time (i.e. keeping it in sync to again, fix security
issues.)

But this feels like a "new feature" that is being imposed by an external
force, and is not actually "fixing" anything wrong with the current
codebase, other than it not supporting this type of architecture.  And
for that, wouldn't it just make more sense to use a newer kernel?

thanks,

greg k-h

