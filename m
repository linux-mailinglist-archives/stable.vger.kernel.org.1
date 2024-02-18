Return-Path: <stable+bounces-20441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEB9859603
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 10:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5270E1C20A13
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 09:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601DB8836;
	Sun, 18 Feb 2024 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iNhzhRzH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E453FC8
	for <stable@vger.kernel.org>; Sun, 18 Feb 2024 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708248875; cv=none; b=KX2NiOLHk92ks2+bvp0tKO2PtKcJZIP8lGEUo+fuVXr9VZBb7M1WIq2tDBbdfsk3pIRx57h+qTiYMz6Lfi/hc350z9PDMwb2LewyTOwEsJkfjeqEBMmTrYuSF+bLgECBZjwmLCHJvPbKPpng8rYu6sS3KeH9XEKng0TvK37Nd34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708248875; c=relaxed/simple;
	bh=DPiAV3iqoIoJ3RDBnSgdMnEStWmhfZYC+8bhlhTlKWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOfqrHM2R4jyVVo5GBkozXGJedMeNyVOq8+OSW+N8z9lH8ekAQXnlA3ntzISeHVFUTbH2xP2kobvNwXheR9SdfqH7+ofWv6tItL6hC0OTseKFUiP+gkHlgDgZIUzLcfPLaNmd+3naQ/uqhzNiWUtwlrYMri8XxitvVOljubFsGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iNhzhRzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81493C433F1;
	Sun, 18 Feb 2024 09:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708248874;
	bh=DPiAV3iqoIoJ3RDBnSgdMnEStWmhfZYC+8bhlhTlKWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNhzhRzHBf8clbrho1hnBE7FE1WKx5jJJjtwuX7f4DIYkZWQ6uo1vsED/GpShlrqR
	 q9lzIV+cOFS0j9RSgfyjXphNoUCdZrzrpwTkJMs/VsRhwPL64NeRccG4xLK0e6qUao
	 lIJviTiAhLAjgD2l6KIBjv6b5BlVMlC/Pt+gE9l0=
Date: Sun, 18 Feb 2024 10:34:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: David Sterba <dsterba@suse.com>
Cc: stable@vger.kernel.org
Subject: Re: Btrfs fixes for 6.7.x
Message-ID: <2024021824-green-syndrome-70cd@gregkh>
References: <20240215133633.25420-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215133633.25420-1-dsterba@suse.com>

On Thu, Feb 15, 2024 at 02:36:31PM +0100, David Sterba wrote:
> Hi,
> 
> there's been a bug in btrfs space reservation since 6.7 that is now affecting
> quite some users. I'd like to ask to add the fix right after it got merged to
> Linus' tree so it can possibly be released in 6.7.5.
> 
> All apply cleanly on top of current 6.7.x tree. Thanks.
> 
> 1693d5442c458ae8d5b0d58463b873cd879569ed
> f4a9f219411f318ae60d6ff7f129082a75686c6c
> 12c5128f101bfa47a08e4c0e1a75cfa2d0872bcd
> 2f6397e448e689adf57e6788c90f913abd7e1af8
> 
> Short ids with subjects:
> 
> 1693d5442c45 btrfs: add and use helper to check if block group is used
> f4a9f219411f btrfs: do not delete unused block group if it may be used soon
> 12c5128f101b btrfs: add new unused block groups to the list of unused block groups
> 2f6397e448e6 btrfs: don't refill whole delayed refs block reserve when starting transaction
> 

All now queued up, thanks.

greg k-h

