Return-Path: <stable+bounces-52167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4201C90871B
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 11:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3DF1C2206C
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 09:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C8C19149D;
	Fri, 14 Jun 2024 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vxxLdAaz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADFB146A7A;
	Fri, 14 Jun 2024 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718356205; cv=none; b=nqifJa01vcxtbLX/dp4wzouzJN3AIfz+sub7+qd8+7V4gkti3vMDCdCGejxXk7wzEsYe97/wuY2Vkp5WAHVjhwIPiAkq2ESNnn5AhK/BkB4pu+uS0xzA1mUFnPmSTjApTTa/cp8DAkBXf+6K/wiqQ6tSiujrgqumUsvMo3WcDeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718356205; c=relaxed/simple;
	bh=CoUsKKpI32pU95daZgGcxXSyemfLlfTxinEmRmDSL1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBm5jfO2m6O6EoaAEGnukVFd55ti7MVcWOEI6rLcceOHhwcFltXhx5oG0lPaX4GnDLYqQo8TpV32VNvOpNvdU1tEDpnXLjBOeYBnAT9P4CvQIJ7QR7E8kXOOUU7JSBLpV61YhcHQUBKtWDABmPOY3VYEbT+3gtp14owzOcNiMTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vxxLdAaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51142C2BD10;
	Fri, 14 Jun 2024 09:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718356204;
	bh=CoUsKKpI32pU95daZgGcxXSyemfLlfTxinEmRmDSL1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vxxLdAazcaZPdI0+ItnGVpNbpgrE1yvW7nZwkhj1881EeqjZjzXDLT8N8vfDMXGnq
	 8oeTYCnMDkHLZdQD375/WN/aYgQ5ua9izz16Yu4dyNbc9LQFu8jJj0rn9E8KEnPnsD
	 cYRD6pVO8ty/MBxzxKzs9zp00KUZB3rqZVyyWY3E=
Date: Fri, 14 Jun 2024 11:10:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Ismael Luceno <ismael@iodev.co.uk>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>
Subject: Re: Intel e1000e driver bug on stable (6.9.x)
Message-ID: <2024061406-refreeze-flatfoot-f33a@gregkh>
References: <ZmfcJsyCB6M3wr84@pirotess>
 <2024061323-unhappily-mauve-b7ea@gregkh>
 <6dcfa590-8d09-4d3a-9c35-0294099489ed@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dcfa590-8d09-4d3a-9c35-0294099489ed@leemhuis.info>

On Fri, Jun 14, 2024 at 08:58:11AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 13.06.24 10:35, Greg KH wrote:
> > On Wed, Jun 12, 2024 at 10:33:19PM +0200, Ismael Luceno wrote:
> >>
> >> I noticed that the NIC started to fail on a couple of notebooks [0]
> >> [1] after upgrading to 6.9.1.
> >>
> >> I tracked down the problem to commit 861e8086029e ("e1000e: move force
> >> SMBUS from enable ulp function to avoid PHY loss issue", 2024-03-03),
> >> included in all 6.9.x releases.
> >>
> >> The fix is in commit bfd546a552e1 ("e1000e: move force SMBUS near
> >> the end of enable_ulp function", 2024-05-28) from mainline.
> >>
> >> The NIC fails right after boot on both systems I tried; I mention
> >> because the description is a bit unclear about that on the fix, maybe
> >> other systems are affected differently.
> > 
> > Now queued up, thanks.
> 
> I see that they are in the latest 6.6.y and 6.9.y stable-rcs. Thing is:
> 
> bfd546a552e1 causes other regressions, which is why Hui Wang submitted a
> revert for that one:
> 
> https://lore.kernel.org/all/20240611062416.16440-1-hui.wang@canonical.com/
> 
> Vitaly Lifshits meanwhile submitted a change that afaics is meant to fix
> that regression:
> 
> https://lore.kernel.org/all/20240613120134.224585-1-vitaly.lifshits@intel.com/
> 
> CCed both so they can comment.
> 
> Not sure what's the best way forward here, maybe it is "not picking up
> bfd546a552e1 for now and waiting a few more days till the dust settles".

Ok, I'll just not pick this one up and let the maintainers figure it
out as this is still broken in Linus's tree as well.

Thanks for noticing this!

thanks,

greg k-h

