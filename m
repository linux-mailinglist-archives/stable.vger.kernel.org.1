Return-Path: <stable+bounces-6372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB5A80DE64
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 23:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC551C214CE
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 22:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E4F54665;
	Mon, 11 Dec 2023 22:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="cLBD1hcQ"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19353AF
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 14:41:22 -0800 (PST)
Message-ID: <2c50fd92-0e8c-4456-814d-4b1f32a907ea@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1702334480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/zmVPT+ekNuC8upNW/rPLz+xSm1s7+hspkJpHviUjY=;
	b=cLBD1hcQxvOR9wVlK33jMYF1B9e2dOmFBXpyhVmX+SSSpkfFqwTlgXxZKNUD73W4u3WYRe
	FGxf+G6vkl2T3XuEI6X/vlUndip+dtOfQDAUMSrXT3CQfNijHdcF4erBibybEzjJlzEPYA
	yCjMSyQEnDgrUEjxwMSmgOgsYXfpYSrB6iDgJLnxNtWXikkmGcIoOlWBJLckE5zAMq7HeO
	E7atiLtq3p2/tnZuA+pgRY7Uim/fG2GwlcIy081GlAOHXUSQIOJAYQaHRBy5GR4GPox4wH
	5vOf7ePBjz9LkRqgEcqojXWwwjecPVLUZiMae2W/52aJBnvb7VzX9TamrbbR1A==
Date: Tue, 12 Dec 2023 05:41:17 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] wifi: nl80211: fix deadlock in nl80211_set_cqm_rssi
 (6.6.x)
Content-Language: en-US
To: =?UTF-8?Q?L=C3=A9o_Lam?= <leo@leolam.fr>, stable@vger.kernel.org
References: <20231210213930.61378-1-leo@leolam.fr>
Cc: Johannes Berg <johannes.berg@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <20231210213930.61378-1-leo@leolam.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 11.12.23 04:39, Léo Lam wrote:
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
>   net/wireless/nl80211.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 6a82dd876f27..0b0dfecedc50 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -12906,17 +12906,23 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
>   					lockdep_is_held(&wdev->mtx));
>   
>   	/* if already disabled just succeed */
> -	if (!n_thresholds && !old)
> -		return 0;
> +	if (!n_thresholds && !old) {
> +		err = 0;
> +		goto unlock;
> +	}
>   
>   	if (n_thresholds > 1) {
>   		if (!wiphy_ext_feature_isset(&rdev->wiphy,
>   					     NL80211_EXT_FEATURE_CQM_RSSI_LIST) ||
> -		    !rdev->ops->set_cqm_rssi_range_config)
> -			return -EOPNOTSUPP;
> +		    !rdev->ops->set_cqm_rssi_range_config) {
> +			err = -EOPNOTSUPP;
> +			goto unlock;
> +		}
>   	} else {
> -		if (!rdev->ops->set_cqm_rssi_config)
> -			return -EOPNOTSUPP;
> +		if (!rdev->ops->set_cqm_rssi_config) {
> +			err = -EOPNOTSUPP;
> +			goto unlock;
> +		}
>   	}
>   
>   	if (n_thresholds) {

I have at least 7 users who have tested that fix on my end:

https://lore.kernel.org/stable/20231210213930.61378-1-leo@leolam.fr/

So it can also be called tested now:

https://forum.manjaro.org/t/153045/77
https://forum.manjaro.org/t/153045/88
https://forum.manjaro.org/t/153045/90
https://forum.manjaro.org/t/153045/92
https://forum.manjaro.org/t/153045/93
https://forum.manjaro.org/t/153045/94

-- 
Best, Philip


