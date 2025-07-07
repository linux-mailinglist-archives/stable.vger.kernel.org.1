Return-Path: <stable+bounces-160335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D988EAFAB40
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 07:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C49EF7A7895
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 05:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED3A274B55;
	Mon,  7 Jul 2025 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J4hHcLE0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5207727146F;
	Mon,  7 Jul 2025 05:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751867727; cv=none; b=JL14Soof0v08ilGZegbQAPFQP0OHq7QY+oZuL2bBH1aHk+WNIrvI1+CwyHoAa/JtdJq8KbpEzQCRi+H6z4znKqk0n/oeQKmO5vYPRE40aWtuMAcncTq28zwAAwxatoVbg+ziC01H5LPuDwd1d9k5o6B0n4pvOQfZMiEcRyigtTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751867727; c=relaxed/simple;
	bh=QpKNSzW+kob0sT0+NIZZdNQuw+iVTZlH+/8pMSZzof0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0GprOn5DeDC1tNAe4CQpx9bHEQFEDonGgKzVtOiZXwH6pBJujdbeQkMrhcEVtN2OwIUtsOH2calgxnSRhngBHG8y6TnXSk84xGN6ZG4ceBDM8UBysMiisPwQleHHJzPxMwScRxcGgygmsEwbiB95lS2LpViofPPDTBSpOdDIHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J4hHcLE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D17C4CEF1;
	Mon,  7 Jul 2025 05:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751867726;
	bh=QpKNSzW+kob0sT0+NIZZdNQuw+iVTZlH+/8pMSZzof0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J4hHcLE0vILN73maLb1CoUl0lljdFfa4t0KCFSGNzAU3QGeZyK7hoZfXFD8E6W7XZ
	 aE6HuPowk3R5HZ459wiUZl8yZVhAf4mJ7PhPwTFWDok2IxXjYRMb8UM0cjqyZHAAAt
	 JguxlfQUWYsLBub/ofS3LQ4INYzb46PxFDgF6D4g=
Date: Mon, 7 Jul 2025 07:55:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Jung <ptr1337@cachyos.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
	jslaby@suse.cz
Subject: Re: Linux 6.15.5
Message-ID: <2025070706-skydiver-surcharge-0f97@gregkh>
References: <2025070646-unopposed-nutrient-8e1c@gregkh>
 <44281bb6-d5c3-4523-9079-e526bd684913@cachyos.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44281bb6-d5c3-4523-9079-e526bd684913@cachyos.org>

On Sun, Jul 06, 2025 at 06:47:49PM +0200, Peter Jung wrote:
> Hi Greg,
> 
> We have updated on CachyOS to 6.15.5 and one user is reporting, that the
> secondary drive gets "dissapeared" and dmesg posts repeatedly:
> 
> > sd 5:0:0:0: [sda] access beyond end of device and BTRFS error messages,
> followed by the device going readonly
> 
> Downgrading to 6.15.4 does fix the issue.

Any chance someone can use 'git bisect' to find the offending change?

thanks,

greg k-h

