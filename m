Return-Path: <stable+bounces-199999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C32CA35C1
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 12:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DFD331354EA
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 10:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927AD3385A2;
	Thu,  4 Dec 2025 10:57:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A79731A803;
	Thu,  4 Dec 2025 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764845875; cv=none; b=ledf9T3fl7bX0FqeiJTHt+ayD603AxMWi3gcBtHRnPG+ElX5+MiLfkxYQlNYP4H6jd1EmwsWF3rr2H+rmxNcqgnYPshmHKdaps91ph32VfVcHe65Ah2VMrQTjPzihIbgBKPDKj3v8sIVRy5G/5DHjOR+gEMfcyn0Y+N9WTGgsg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764845875; c=relaxed/simple;
	bh=Vt7YQc8U9exwpsDf9DXdMehfBmTuxlx9T0rEPB3gbGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNuo/OadHkcaWThuctMd3Og0h1SPDKs2GzR3Y2ID4hrA/+pzMKFEVF0EQqWIfkNlHlO+hFvI7oOcIaQzJ28wgKwRJ9AAobKCBAwElqcPhgnM6d9cub6qCZ/80PoHXSxsMZGaNiGPHCN7biVUnK0xR222/i5oN3uFdiEOGjhsD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af11d.dynamic.kabel-deutschland.de [95.90.241.29])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 206AC61E647AB;
	Thu, 04 Dec 2025 11:57:27 +0100 (CET)
Message-ID: <3dda7b74-b90e-42b6-ace5-9b0f1d976353@molgen.mpg.de>
Date: Thu, 4 Dec 2025 11:57:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ixgbevf: fix link setup
 issue
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, stable@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>
References: <20251204095323.149902-1-jedrzej.jagielski@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251204095323.149902-1-jedrzej.jagielski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jedrzej,


Thank you for your patch.

Am 04.12.25 um 10:53 schrieb Jedrzej Jagielski:
> It may happen that VF spawned for E610 adapter has problem with setting
> link up. This happens when ixgbevf supporting mailbox API 1.6 coopearates

cooperates

> with PF driver which doesn't support this version of API, and hence
> doesn't support new approach for getting PF link data.

Which commit introduced the support for this API version?

> In that case VF asks PF to provide link data but as PF doesn't support
> it, returns -EOPNOTSUPP what leads to early bail from link configuration
> sequence.
> 
> Avoid such situation by using legacy VFLINKS approach whenever negotiated
> API version is less than 1.6.

It’d be great, if you added how to exactly reproduce the issue.

> Fixes: 53f0eb62b4d2 ("ixgbevf: fix getting link speed data for E610 devices")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbevf/vf.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
> index 29c5ce967938..8af88f615776 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/vf.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
> @@ -846,7 +846,8 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
>   	if (!mac->get_link_status)
>   		goto out;
>   
> -	if (hw->mac.type == ixgbe_mac_e610_vf) {
> +	if (hw->mac.type == ixgbe_mac_e610_vf &&
> +	    hw->api_version >= ixgbe_mbox_api_16) {
>   		ret_val = ixgbevf_get_pf_link_state(hw, speed, link_up);
>   		if (ret_val)
>   			goto out;

The diff looks good. With the improved commit message, feel free to add:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

