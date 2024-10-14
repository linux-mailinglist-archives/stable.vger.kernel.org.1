Return-Path: <stable+bounces-83768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C30D99C6BF
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 12:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6EC81F22DFA
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 10:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7972B1607AC;
	Mon, 14 Oct 2024 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="GFG53Ax3"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2552B1591E2
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900542; cv=none; b=QD5Xe4zEGHwr4PO38IhAfMpQXNCUlO4e3u2Rk9Fa68oeI/HLKxQuKT+K3vl/l00BCBSVn/J8hpQgR2MOwUjGiLqTulpE32uMqvDPudANF179yUgHexMt3VzZ78RE0MXxBz9ndHjhDr0HwVoQCD8JlgRwQ2QIQJXB5qH19WlqGBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900542; c=relaxed/simple;
	bh=wHCxYSfFuaNeA3TT/4cfIRlmF+58tPwuSpi0Baco4D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qUakTCnKu6TCeZtkJRlX5mRasfxrNMGdl0J40R8Yb3FBaTOiqQj3KZNPflAUfirwZ249RbxNDwzf9M6zSynn2WyEDJvtICLsRoya1tv4du62XUPrOxJXL8KHpduYVb92THWa5Y01MYAFMyUiUojcdcz6xEWx/dbBPGREk3dDdoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=GFG53Ax3; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 46978A0B52;
	Mon, 14 Oct 2024 12:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ddAL5RTHjumrRgAOWfEV
	FabhquD8pSD1jG/Vy9qkYwk=; b=GFG53Ax3kvzd9MvEhhqXHH6eCXDB6YH1CTrT
	EaemE77kpmVQcQxbM/cYkfW2L8yG12/eS0VjtJvA1H89fBNBPQ+jjeOiVlIvoIpP
	wDg8Il0MtFgyBuBS4zmxFMqvZA2mcP/0twXPZz+gEQg1N+IDZmMv1l0FIO38bMNR
	3dtrBGYD+Eqn3PGyP5SI4RMSVmE5w0AeW++SCeJ/uFw/YYzCgdU4Pu3CEpbJzPe7
	EErup6ns3Ao4jTbc2Xez7KMhTQzHlrBrh8MCB/LydYs7FTJHYLJdX1M7+0u12kDJ
	Macg7xvIUwhyyKr2d/TtVeSCmGXHo1Q/SNghxO5wRBRDFr7bm12cwB8SB88U0TY3
	Lb7+1SeilLP13t342iVkPGWJnaQTOweFBsJOMMgi70NpicLAYW/6kNpzRsveCGHr
	Y9i+rr7kBsB6aHg1eRXpkcrNLw6+FEz7U71QEoafYdmHNumtV5g1+YP8UMHiJH/W
	ypgXgI39RLwAilfjUpR2NN9ZzwScy90JIoREjWwBPGVnzfeKHP6sEAs5iuhJVx+Q
	DsiJZ5/xbyaTwG8dlOoPZDRWiDlCtx5zOx+lMxF1ztFQv3pLgKl3B5uxzFrpxqtD
	Swm4edHOE9f01HzCn+4QJ8xFyd3dGqDW37s9PUOX5zb5Bvzp7Hd4CMsjmgjWY+Xr
	IJILCNo=
Message-ID: <196c236b-75d7-4609-958b-fdf458e69a07@prolan.hu>
Date: Mon, 14 Oct 2024 12:08:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 1/2] net: fec: Move `fec_ptp_read()` to the
 top of the file
To: <kuba@kernel.org>, <stable@vger.kernel.org>
CC: <horms@kernel.org>, <Frank.li@nxp.com>, <wei.fang@nxp.com>,
	<shenwei.wang@nxp.com>, <xiaoning.wang@nxp.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <richardcochran@gmail.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
References: <20240812094713.2883476-1-csokas.bence@prolan.hu>
 <172360263324.1842448.13885436119657830097.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <172360263324.1842448.13885436119657830097.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855647165

Hi,
I just noticed this series' `Fixes:` tag was dropped when it was 
committed. However, we believe it should be considered for backporting 
to stable, so let this be a heads-up to the stable team.
Bence

On 2024. 08. 14. 4:30, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Mon, 12 Aug 2024 11:47:13 +0200 you wrote:
>> This function is used in `fec_ptp_enable_pps()` through
>> struct cyclecounter read(). Moving the declaration makes
>> it clearer, what's happening.
>>
>> Fixes: 61d5e2a251fb ("fec: Fix timer capture timing in `fec_ptp_enable_pps()`")
>> Suggested-by: Frank Li <Frank.li@nxp.com>
>> Link: https://lore.kernel.org/netdev/20240805144754.2384663-1-csokas.bence@prolan.hu/T/#ma6c21ad264016c24612048b1483769eaff8cdf20
>> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
>>
>> [...]
> 
> Here is the summary with links:
>    - [v3,net-next,1/2] net: fec: Move `fec_ptp_read()` to the top of the file
>      https://git.kernel.org/netdev/net-next/c/4374a1fe580a
>    - [v3,net-next,2/2] net: fec: Remove duplicated code
>      https://git.kernel.org/netdev/net-next/c/713ebaed68d8
> 
> You are awesome, thank you!


