Return-Path: <stable+bounces-8741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6B98204A5
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506581C20BE0
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 11:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948FB749E;
	Sat, 30 Dec 2023 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zRNrRS06"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FBA7465
	for <stable@vger.kernel.org>; Sat, 30 Dec 2023 11:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CA6C433C7;
	Sat, 30 Dec 2023 11:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703936597;
	bh=f+SrcJ3wSfMf1gdNgdTBMGxkYCdL2vJAYm4maE+IBXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zRNrRS06lMN/ISyGFF0Ry1bGcPa3V4Xe0vvG+bohbrYbOphX16DOPQf5tvjiqixST
	 MIzo/jYzSP+e10hAlt2ALaczXiX/OEQsTlwiGfAgRhgjdGRuTVbg4AbqNf7Fio9A6V
	 r1djAoP6HQL5A0z4GjqKZWqiMCCk1PlfJZ50e4BE=
Date: Sat, 30 Dec 2023 11:43:15 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?B?TOlv?= Lam <leo@leolam.fr>
Cc: stable@vger.kernel.org,
	Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 2/2] wifi: nl80211: fix deadlock in nl80211_set_cqm_rssi
 (6.6.x)
Message-ID: <2023123005-annuity-numbly-e6d8@gregkh>
References: <20231216054715.7729-2-leo@leolam.fr>
 <20231216054715.7729-4-leo@leolam.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231216054715.7729-4-leo@leolam.fr>

On Sat, Dec 16, 2023 at 05:47:17AM +0000, Léo Lam wrote:
> Commit 008afb9f3d57 ("wifi: cfg80211: fix CQM for non-range use"
> backported to 6.6.x) causes nl80211_set_cqm_rssi not to release the
> wdev lock in some of the error paths.
> 
> Of course, the ensuing deadlock causes userland network managers to
> break pretty badly, and on typical systems this also causes lockups on
> on suspend, poweroff and reboot. See [1], [2], [3] for example reports.
> 
> The upstream commit 7e7efdda6adb ("wifi: cfg80211: fix CQM for non-range
> use"), committed in November 2023, is completely fine because there was
> another commit in August 2023 that removed the wdev lock:
> see commit 076fc8775daf ("wifi: cfg80211: remove wdev mutex").
> 
> The reason things broke in 6.6.5 is that commit 4338058f6009 was applied
> without also applying 076fc8775daf.
> 
> Commit 076fc8775daf ("wifi: cfg80211: remove wdev mutex") is a rather
> large commit; adjusting the error handling (which is what this commit does)
> yields a much simpler patch and was tested to work properly.
> 
> Fix the deadlock by releasing the lock before returning.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=218247
> [2] https://bbs.archlinux.org/viewtopic.php?id=290976
> [3] https://lore.kernel.org/all/87sf4belmm.fsf@turtle.gmx.de/
> 
> Link: https://lore.kernel.org/stable/e374bb16-5b13-44cc-b11a-2f4eefb1ecf5@manjaro.org/
> Fixes: 008afb9f3d57 ("wifi: cfg80211: fix CQM for non-range use")
> Tested-by: Léo Lam <leo@leolam.fr>
> Tested-by: Philip Müller <philm@manjaro.org>
> Cc: stable@vger.kernel.org
> Cc: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Léo Lam <leo@leolam.fr>
> ---
>  net/wireless/nl80211.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Both now queued up, thanks.

greg k-h

