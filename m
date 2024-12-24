Return-Path: <stable+bounces-106076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FDF9FBEF3
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 15:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D37297A19C6
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 14:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7877C1BF7E8;
	Tue, 24 Dec 2024 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="V9St8mz9"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017C618DF60
	for <stable@vger.kernel.org>; Tue, 24 Dec 2024 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735049017; cv=none; b=F/x9zkVcwABRLPjAJ/tvEKSEjodXbB92zQRnPzSnHwe8/FRZ4SoN2KfY6KERl+gS9N9NOYdxsBa7/AR/WlvlendyGtTLdrrllCSCjVdTyGFeP1/qPaPGJjb25qOYwzlr3eJKjDYhbWVefMlo+voW9Tnr/sB4xq4l+JBdyZWjZgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735049017; c=relaxed/simple;
	bh=cqAKDFaEJPIsj3nuyd36OrY5ofBigy6lwLjWld2gIp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhfuSmlwtu5rGuHAaLTxMRg2TTOqGQfv540wC7Flnkz2d4xlzrZmHeJN0W3FTcaEODzth/0jv4g55x96Lr4bC+h3JiGJ0Vmyfgh9Vh3mJmbYM86cJsBjFVEfsUGcpngG6tlr8hgRUuN2xHLyDD9dl4ZAwoW6YNZK5V8z89snCcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=V9St8mz9; arc=none smtp.client-ip=17.58.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735049015;
	bh=1zU/xugu6Mhb77n19HMl4rFbAMFTLQKCduA+uISnK94=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=V9St8mz9Ty2sI93WJx6gCtpikzWz1FBjx9LhlySZq7Gma17cakDbWvUjDxo0sblFz
	 qM8UEh9IUhbQcC8+Bukyak/ItWTCruGe9gYuxeiDcsKA1NNY2eNtjc2TzvR1pBhRLm
	 Ogmn3TCGw6//E7SJAKLbBt1egNfEg9mMtcoBSNyj8hngn9dM05EQ6z9UiNWvu1LXtg
	 ddwupNiMtySMm9b9N1YLKw/99wB16MZuS2MPQZ6iZ8Er58MjcSZasKeX9m2dmlqKJa
	 SShtM9rIlomGAmhIp21cektOWnjK27UFwfRDQoS4jc81i9dmREjcNt82OVBZr3ymbw
	 oip83EHcjqDUA==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id 848613A008A;
	Tue, 24 Dec 2024 14:03:24 +0000 (UTC)
Message-ID: <16198d1c-3d07-4615-9559-5cb8e4aa9ed3@icloud.com>
Date: Tue, 24 Dec 2024 22:03:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] phy: core: Fix bugs for several APIs and simplify
 an API
To: Vinod Koul <vkoul@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Johan Hovold <johan@kernel.org>, stable@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>, Johan Hovold <johan+linaro@kernel.org>,
 Simon Horman <horms@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>
References: <20241213-phy_core_fix-v6-0-40ae28f5015a@quicinc.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20241213-phy_core_fix-v6-0-40ae28f5015a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vkJnDKCcbGEWa8tEwOw5CbTMeIfixxwI
X-Proofpoint-ORIG-GUID: vkJnDKCcbGEWa8tEwOw5CbTMeIfixxwI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=632
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240122

On 2024/12/13 20:36, Zijun Hu wrote:
> This patch series is to fix bugs for below APIs:
> 
> devm_phy_put()
> devm_of_phy_provider_unregister()
> devm_phy_destroy()
> phy_get()
> of_phy_get()
> devm_phy_get()
> devm_of_phy_get()
> devm_of_phy_get_by_index()
> 
> And simplify below API:
> 
> of_phy_simple_xlate().
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Changes in v6:
> - Use non-error path solution for patch 6/6.
> - Remove stable tag for both patch 2/6 and 3/6.
> - Link to v5: https://lore.kernel.org/r/20241106-phy_core_fix-v5-0-9771652eb88c@quicinc.com

Hi Vinod,

These patch series has no response for more than 1.5 months.
could you would like to have a code review ?

Sorry for this noise.

Mainline and linux-next have fixes of similar issues for your references
shown below:

For patch [1/6, 3/6]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fdce49b5da6e0fb6d077986dec3e90ef2b094b50
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d4929755e4d02bd3de3ae5569dab69cb9502c54f

For patch 6/6:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=dcacb364772eb463bde225176086bd7738b7102f




