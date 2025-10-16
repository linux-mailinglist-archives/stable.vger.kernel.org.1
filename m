Return-Path: <stable+bounces-185938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 517C5BE2511
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065071893675
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12793161AD;
	Thu, 16 Oct 2025 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kxi4n1Io"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803043161A0
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605970; cv=none; b=hLiFiepn7ehyYhUaQWNlN4RiLeAjNtfUSP66cmmk9YRnga3TIniZk0iJwkWxW7Ol35qGbM1ihVnLUnJrvIkU/ps6W7oUYk4TIT6VQzaS3iXqq9rLS/8Og5dEPMOvwQKFGabZ0Wl35JZ1rj0pixB0NqZDETy5gVKzAVLSRLIrzU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605970; c=relaxed/simple;
	bh=C8UjgRKxo7yM6yiU6UjlwllLVxeL9xkLARBW5FwWR9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coEe6n/hLVN1VroVmgDsbY7BSoG7iYOindQvT6vDu0Fe1xCYDOo+mS49Dp/Er1wUhexEcRniLrCHkFerkZaYY9PZQ3SKBtHNvUCzdfHlNvum/J7oZjnLZEnucSrSYgbUUwSxDwtByPzyDp2PCCT4+NlxIZZbfZV6H2kslwMq/ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kxi4n1Io; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46C8C4CEF1;
	Thu, 16 Oct 2025 09:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760605970;
	bh=C8UjgRKxo7yM6yiU6UjlwllLVxeL9xkLARBW5FwWR9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxi4n1IokGqE/1PsY7/fYKgZojeZB3lnQpseYUtNMkMBorxAljrSvMmbu9d+sVZDx
	 AIWX3b1N+Q/DTI0Y37dcxdghjnhOZzxIaPBzVcdwwfG6MFcqOj2S3IpUjtvRJYkFkB
	 Coe6zgWeZm0+6XZ9Nfxet8Xt24i2uwObPC614zfQ=
Date: Thu, 16 Oct 2025 11:12:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] cpuidle: governors: menu: Avoid using invalid
 recent intervals data
Message-ID: <2025101611-shrubs-gigolo-3c4e@gregkh>
References: <20251014130300.2365621-1-senozhatsky@chromium.org>
 <2025101614-shown-handbag-58e3@gregkh>
 <p7j4aihzybksyabenydz634x4whuyjxsmvkhwiqxaor5uhpjz7@3l7kud4aobjf>
 <2025101606-galley-panda-297b@gregkh>
 <s7rjg3bxmjqxmqxppivrunk2awl2zwgxz7zb3godj3s2tvktg6@twicqbqsnuqk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s7rjg3bxmjqxmqxppivrunk2awl2zwgxz7zb3godj3s2tvktg6@twicqbqsnuqk>

On Thu, Oct 16, 2025 at 06:08:39PM +0900, Sergey Senozhatsky wrote:
> On (25/10/16 11:05), Greg KH wrote:
> > I've queued up a backport I did with a cc: to you on it already, that
> > should be identical to yours, right?
> 
> Looks right.  Thanks.
> 
> // I wonder why doesn't git cherry-pick -x add SoB automatically.
> 

You need "-s" to add your signed-off-by, "-x" just adds the text at the
bottom about the original commit id.

thanks,

greg k-h

