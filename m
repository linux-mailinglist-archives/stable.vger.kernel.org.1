Return-Path: <stable+bounces-48294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AE08FE6EF
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8671C225A0
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEB9195993;
	Thu,  6 Jun 2024 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eYZtp+rY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FD8195B24
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717678676; cv=none; b=jyNvzfTZzcoKi3uh0QvLuwX3zCbH1TSYtjBDjmVCfgrcRR2CnjkKT2tsuigO7fLUsv8E1qUZ4M8pc2NWjDS4HwG3Q/m+G6adYsMROAREk2Tt8d7pGV1A/n5NGSxCtFlRen5DeuqqHIEwiH+Jbmpn+a6/xto1OQHdBTv3TLAqS7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717678676; c=relaxed/simple;
	bh=8urW+UEzx2r9A/i0p9aGrUEYzALlG+oz6qViD5m/x00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HB3f5t6LVZHfTYsK1ZKaT28ZJhJJglgTpLFMg228VdL9SS8uHQnFhePWsxiv+UooVPyBpHsttvSpfHt59P/3vYN7yeOFFb5JrxM/JKOgJ6MvjfamM2B9UMoDSasjbKkI8ybYqrCLwsQu8ccF9BRZUB32jjyAUekezocztWrDc4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eYZtp+rY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDE1C2BD10;
	Thu,  6 Jun 2024 12:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717678675;
	bh=8urW+UEzx2r9A/i0p9aGrUEYzALlG+oz6qViD5m/x00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYZtp+rYz9Y0rMVmCYjzFYJyZuF0PfccEL6i6z3gynRzhDMN6xXLHc2+bJInACwGi
	 iclh7injxEv+4ibvP+vNdQnLuAhhH3Y7wScs+W+WwigACSy3LL2LprzJoq3sy7TPpW
	 +CRg/JKq1SIwQeNZN1v3xXT5xhuYuztBS8f9GWQM=
Date: Thu, 6 Jun 2024 14:57:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.8.y-and-older] ALSA: timer: Set lower bound of start
 tick time
Message-ID: <2024060648-truck-prototype-1292@gregkh>
References: <20240527062431.18709-1-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527062431.18709-1-tiwai@suse.de>

On Mon, May 27, 2024 at 08:23:59AM +0200, Takashi Iwai wrote:
> commit 4a63bd179fa8d3fcc44a0d9d71d941ddd62f0c4e upstream.
> 
> Currently ALSA timer doesn't have the lower limit of the start tick
> time, and it allows a very small size, e.g. 1 tick with 1ns resolution
> for hrtimer.  Such a situation may lead to an unexpected RCU stall,
> where  the callback repeatedly queuing the expire update, as reported
> by fuzzer.
> 
> This patch introduces a sanity check of the timer start tick time, so
> that the system returns an error when a too small start size is set.
> As of this patch, the lower limit is hard-coded to 100us, which is
> small enough but can still work somehow.
> 
> [ backport note: the error handling is changed, as the original commit
>   is based on the recent cleanup with guard() in commit beb45974dd49
>   -- tiwai ]
> 
> Reported-by: syzbot+43120c2af6ca2938cc38@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/000000000000fa00a1061740ab6d@google.com
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/r/20240514182745.4015-1-tiwai@suse.de
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> 
> Greg, this is an alternative fix to the original cherry-pick; apply
> to 6.8.y and older stable kernels.  Thanks!

Now queued up, thanks!

greg k-h

