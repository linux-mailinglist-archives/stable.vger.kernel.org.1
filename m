Return-Path: <stable+bounces-5251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5F880C17D
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 07:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57FB1F20F0C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 06:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A911F606;
	Mon, 11 Dec 2023 06:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k28DK+gM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743621D69A
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 06:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872A9C433C7;
	Mon, 11 Dec 2023 06:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702277256;
	bh=wiZf7baW/NVYGsl044hxt6FCjizb2DSSaHIhaWXdkCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k28DK+gMVyBvqtrhpHOSLjGZUoqERr3LLkTBvIK3AxpJM7PLPTgFnmHwvgBFtFs+l
	 IBiMlH4sXlH2SnmlJSdEy48CFyz6trT83w7GE1rfw4EYUv5p+8cyJ1gPPC0JvPpuqY
	 /6yYX1HQ/dgDxd4pUaYoSWIC/dwjnpTD+RB9sxGo=
Date: Mon, 11 Dec 2023 07:47:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?B?TOlv?= Lam <leo@leolam.fr>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] wifi: nl80211: fix deadlock in nl80211_set_cqm_rssi
 (6.6.x)
Message-ID: <2023121135-unwilling-exception-0bcc@gregkh>
References: <20231210213930.61378-1-leo@leolam.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231210213930.61378-1-leo@leolam.fr>

On Sun, Dec 10, 2023 at 09:39:30PM +0000, Léo Lam wrote:
> Commit 4a7e92551618f3737b305f62451353ee05662f57 ("wifi: cfg80211: fix
> CQM for non-range use" on 6.6.x) causes nl80211_set_cqm_rssi not to
> release the wdev lock in some situations.
> 
> Of course, the ensuing deadlock causes userland network managers to
> break pretty badly, and on typical systems this also causes lockups on
> on suspend, poweroff and reboot. See [1], [2], [3] for example reports.
> 
> The upstream commit, 7e7efdda6adb385fbdfd6f819d76bc68c923c394
> ("wifi: cfg80211: fix CQM for non-range use"), does not trigger this
> issue because the wdev lock does not exist there.
> 
> Fix the deadlock by releasing the lock before returning.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=218247
> [2] https://bbs.archlinux.org/viewtopic.php?id=290976
> [3] https://lore.kernel.org/all/87sf4belmm.fsf@turtle.gmx.de/
> 
> Fixes: 4a7e92551618 ("wifi: cfg80211: fix CQM for non-range use")
> Cc: stable@vger.kernel.org
> Signed-off-by: Léo Lam <leo@leolam.fr>
> ---
>  net/wireless/nl80211.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

So this is only for the 6.6.y tree?  If so, you should at least cc: the
other wireless developers involved in the original fix, right?

And what commit actually fixed this issue upstream, why not take that
instead?

thanks,

greg k-h

