Return-Path: <stable+bounces-128584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C817BA7E6C0
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C91189AA85
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736C420E035;
	Mon,  7 Apr 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="anhx/jUZ"
X-Original-To: stable@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B6B20C034;
	Mon,  7 Apr 2025 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043361; cv=none; b=RBFKdKY1F2Ox2L6DSDMpgH67W/OpkpMLXkjaUuw0QW0bD19aijJ0tIyQ7zCxmxDpveM0GIx9ghpkWMmFdiUfjrUpBjaaKDZck54lf8PyGddLJc5RCh5PVJXgkbSjud1CGSUrPCal2p+1ZgeOBBS/C8z6PFFjik+xBt84rI5om2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043361; c=relaxed/simple;
	bh=KYidTERWG2F2KJBW788o//A+Ev0GgwOnY2zCQoJxJJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQxtSMObihHQYOatkGBKn/uUzLhL62i5T2etQrGukL+033MAGQCpDQBAjXDk7BO/BQHNGN8If22HiTm/Y0Zw5SpZ3LXbSOsQaq+njAtll1c8kMgqF3DPS+O8CYV4uLHL6iT+G3NiovjoYpWct4bvoTva/pBo0TNUPWN0YqkOLdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=anhx/jUZ; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
Message-ID: <ce57a679-9449-479a-aaef-58226c3445cd@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1744043007;
	bh=KYidTERWG2F2KJBW788o//A+Ev0GgwOnY2zCQoJxJJI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=anhx/jUZKnutCdf6LVZL4PKOzA5GXjU+3kShT9cWnD7xEPIqgK9lGOB8PltfSoE1H
	 9tSvGklP2RgzRSRpUc7qWunIPKgLFY9BIvNY5TUW+IkwejOnqdoyNty12S2YkhmD3M
	 WFLSeb3UfxEZO1zUjDf01YQUqEIlk+kFlsABcLCk=
Date: Mon, 7 Apr 2025 18:23:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "wifi: mac80211: remove debugfs dir for virtual monitor"
 has been added to the 6.13-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>
References: <20250407152519.3128878-1-sashal@kernel.org>
Content-Language: en-US, de-DE
From: Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <20250407152519.3128878-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/25 17:25, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      wifi: mac80211: remove debugfs dir for virtual monitor
> 
> to the 6.13-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       wifi-mac80211-remove-debugfs-dir-for-virtual-monitor.patch
> and it can be found in the queue-6.13 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 

The commit here is causing a sparse warning. Please always add commit 
861d0445e72e ("wifi: mac80211: Fix sparse warning for monitor_sdata") 
when you backport this patch to avoid that. (So far I got the  backport 
notification for 6.12 and 6.13.)

It's also no big deal when you decide to not backport this patch.

> 
> 
> commit 193bafe31a2a08b5631a98ecf148fa0d18e94b0d
> Author: Alexander Wetzel <Alexander@wetzel-home.de>
> Date:   Tue Feb 4 17:42:40 2025 +0100
> 
>      wifi: mac80211: remove debugfs dir for virtual monitor
>      
>      [ Upstream commit 646262c71aca87bb66945933abe4e620796d6c5a ]
>      
>      Don't call ieee80211_debugfs_recreate_netdev() for virtual monitor
>      interface when deleting it.
>      
>      The virtual monitor interface shouldn't have debugfs entries and trying
>      to update them will *create* them on deletion.
>      
>      And when the virtual monitor interface is created/destroyed multiple
>      times we'll get warnings about debugfs name conflicts.
>      
>      Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
>      Link: https://patch.msgid.link/20250204164240.370153-1-Alexander@wetzel-home.de
>      Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
> index 299d38e9e8630..2fc60e1e77a55 100644
> --- a/net/mac80211/driver-ops.c
> +++ b/net/mac80211/driver-ops.c
> @@ -116,8 +116,14 @@ void drv_remove_interface(struct ieee80211_local *local,
>   
>   	sdata->flags &= ~IEEE80211_SDATA_IN_DRIVER;
>   
> -	/* Remove driver debugfs entries */
> -	ieee80211_debugfs_recreate_netdev(sdata, sdata->vif.valid_links);
> +	/*
> +	 * Remove driver debugfs entries.
> +	 * The virtual monitor interface doesn't get a debugfs
> +	 * entry, so it's exempt here.
> +	 */
> +	if (sdata != local->monitor_sdata)
> +		ieee80211_debugfs_recreate_netdev(sdata,
> +						  sdata->vif.valid_links);
>   
>   	trace_drv_remove_interface(local, sdata);
>   	local->ops->remove_interface(&local->hw, &sdata->vif);
> diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
> index 806dffa48ef92..04b3626387309 100644
> --- a/net/mac80211/iface.c
> +++ b/net/mac80211/iface.c
> @@ -1212,16 +1212,17 @@ void ieee80211_del_virtual_monitor(struct ieee80211_local *local)
>   		return;
>   	}
>   
> -	RCU_INIT_POINTER(local->monitor_sdata, NULL);
> -	mutex_unlock(&local->iflist_mtx);
> -
> -	synchronize_net();
> -
> +	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
>   	ieee80211_link_release_channel(&sdata->deflink);
>   
>   	if (ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
>   		drv_remove_interface(local, sdata);
>   
> +	RCU_INIT_POINTER(local->monitor_sdata, NULL);
> +	mutex_unlock(&local->iflist_mtx);
> +
> +	synchronize_net();
> +
>   	kfree(sdata);
>   }
>   


