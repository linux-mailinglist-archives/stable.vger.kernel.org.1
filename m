Return-Path: <stable+bounces-58983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E05192CE5B
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 11:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8061F2285C
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 09:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF4818EFF9;
	Wed, 10 Jul 2024 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YWPmk5Xo"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07D513777F;
	Wed, 10 Jul 2024 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604409; cv=none; b=PltagvwqFJkOOzkyIU+dEzWs46JEIQVRrdUsvFKb2VDhQ7uxgZ78BlrAHdn7l5cI0QQcbcnWuO90bIJzObB2yNSVq5lTZoHFcDpSnDVQzUkGuMHBd+/zFhgR+ZWYeQz2D3cxFtatXiQzGPPzoQSaARPpOKXltk2gxGp+BHV2G/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604409; c=relaxed/simple;
	bh=ADk7DMyhfJqTTK/oN85NO5U162LUwk/tX+zJTn4Y/Z4=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PnTpHYpFBWZsaztpgN/ArRgsW91wP46ZjlUkSju0KKHuO5stf800GrwWerUW9A0jABmNAyWg4WjXU5BzEQUjoKl71suwJ+2XRWvWpmEpvkv0dWKSGXqIC9cznGC+OzJSX2LdQfFwxwokMPubmMEcZ0DtIc9trEr7wuWO2pu26iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YWPmk5Xo; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A8FMKk022710;
	Wed, 10 Jul 2024 02:39:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=ERuREC8x4VHnyKvbphf6LJ7Z2GFBuwanN+XTgY0f6v0=; b=YWP
	mk5XoI91ZOtFPtKEfQDSWhCJXKLRDnhGFmWxEzG4PKv4iVJID6cy1g8ze49gvVaj
	ilHMeFuNoPB7W87SgHr6ciUsrb25UFxytG4lqzpOlikm+EKnhL2JiJ5xBXzmXnmV
	80CUNfeF2zG/6z4zixpBe1Gpq1HpYWkiTGRX3IWDsRIXoCZk8jcOQXz43DzDbsJs
	CrsYvt4FEf+CqdT3NTf/R07VOziUKPRngHVZj5/kIRqiRwOdCxwErGQeTMC/mYEQ
	q9zU8wAjuYfTiE/RPGk3lTyqsOyP72uMCYS1/vhvUWOcNu3bpN9YU/wgUBBG9BhG
	dFvnhZQ/Fu/DjSfQ67w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 409e062373-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 02:39:52 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 10 Jul 2024 02:39:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 10 Jul 2024 02:39:19 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id B6A7C3F708F;
	Wed, 10 Jul 2024 02:39:16 -0700 (PDT)
Date: Wed, 10 Jul 2024 15:09:15 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Ronald Wahl <rwahl@gmx.de>
CC: Ronald Wahl <ronald.wahl@raritan.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        <netdev@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] net: ks8851: Fix potential TX stall after interface
 reopen
Message-ID: <Zo5Ww+IQJzDbzH3Q@test-OptiPlex-Tower-Plus-7010>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: Tef5VLgdl--PZeMuTwaTL3YWzRPfgvQm
X-Proofpoint-GUID: Tef5VLgdl--PZeMuTwaTL3YWzRPfgvQm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-09_01,2024-05-17_01

On 2024-07-10 at 01:28:45, Ronald Wahl (rwahl@gmx.de) wrote:
> From: Ronald Wahl <ronald.wahl@raritan.com>
> 
> The amount of TX space in the hardware buffer is tracked in the tx_space
> variable. The initial value is currently only set during driver probing.
> 
> After closing the interface and reopening it the tx_space variable has
> the last value it had before close. If it is smaller than the size of
> the first send packet after reopeing the interface the queue will be
> stopped. The queue is woken up after receiving a TX interrupt but this
> will never happen since we did not send anything.
> 
> This commit moves the initialization of the tx_space variable to the
> ks8851_net_open function right before starting the TX queue. Also query
> the value from the hardware instead of using a hard coded value.
> 
> Only the SPI chip variant is affected by this issue because only this
> driver variant actually depends on the tx_space variable in the xmit
> function.
> 
> Fixes: 3dc5d4454545 ("net: ks8851: Fix TX stall caused by TX buffer overrun")
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: netdev@vger.kernel.org
> Cc: stable@vger.kernel.org # 5.10+
> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
> ---
>  drivers/net/ethernet/micrel/ks8851_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
> index 6453c92f0fa7..03a554df6e7a 100644
> --- a/drivers/net/ethernet/micrel/ks8851_common.c
> +++ b/drivers/net/ethernet/micrel/ks8851_common.c
> @@ -482,6 +482,7 @@ static int ks8851_net_open(struct net_device *dev)
>  	ks8851_wrreg16(ks, KS_IER, ks->rc_ier);
> 
>  	ks->queued_len = 0;
> +	ks->tx_space = ks8851_rdreg16(ks, KS_TXMIR);
>  	netif_start_queue(ks->netdev);
> 
>  	netif_dbg(ks, ifup, ks->netdev, "network device up\n");
> @@ -1101,7 +1102,6 @@ int ks8851_probe_common(struct net_device *netdev, struct device *dev,
>  	int ret;
> 
>  	ks->netdev = netdev;
> -	ks->tx_space = 6144;
> 
>  	ks->gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>  	ret = PTR_ERR_OR_ZERO(ks->gpio);
> --
> 2.45.2
> 
>
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>

