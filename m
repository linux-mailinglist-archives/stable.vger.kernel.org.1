Return-Path: <stable+bounces-86964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48A99A5374
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 12:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF881F226DA
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 10:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D24188A3B;
	Sun, 20 Oct 2024 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="QqVdEdWg"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0677485
	for <stable@vger.kernel.org>; Sun, 20 Oct 2024 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729419588; cv=none; b=aLkp1MN5rvuejAdv/vhsR1nWQUOJpVy4C3EBSfEb0ClJ70vtVoBlTmweN2BQtU+7Ro+xpdaGCzpFcHnAYNyUGAJm+YaBSF49KQGqV74XEmx0l0yqOiqRt5x8MlrZFFJwQTj+kRCsFvvb6x5LJrEwlnMqj3M1VZPzvTSA4tJUJlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729419588; c=relaxed/simple;
	bh=l1S0Oc4Vc+ZVohAA151UdXjpKQfwMpMbOn4+f3lXQvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uaojXVP2eRmiilE0rwUM/qkaE9P2NncZHt3/qDeUs7qPZOkiCqDtk4PtL+xvM0kRz8QzHo3TD88GGiBv8PF+KrxA33TgaBECVM/E3iDI1OKOURknuiqQME/kpu/zkyxaI43CoXVlD6dunTFmae3dCMIrPQScI267rKSleFgaLKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=QqVdEdWg; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729419585;
	bh=yVKYWzMebxw4JY7NKUStkDyKnGs9EY56GyMpc/ew/5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=QqVdEdWgDfwnj7sF608eoKseidVyEc9MnjcbtIetM2ltCo7znHh6/zw/rNtMoWxKB
	 zSfhIRGERY4m5CBmGapmGnHc1mYt/xCg1k7JTt7VDBitn670tYo0pSDNAAeZgWnvsS
	 OAoY8NZHSRrC2LoibpeFxwXOp47ROFjTuG6pZV8TH5gUkuT3Vnx6qSai15tKQIDkrp
	 nVarkPmuVFPUQ/snUHmLnzVrPrhNK7CXLx95oQTENFmMQqiEZQ8a2fuXYQTVTdWjHs
	 QFvIVBBMySAYWSOoMie1YL6gdCyvxHTxfuUPoJC5ZsvJeHDbHdmjRtWwdU7tWy4+wC
	 sasAFyyMjGu1g==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 67C964A02BE;
	Sun, 20 Oct 2024 10:19:38 +0000 (UTC)
Message-ID: <8adbf600-b8c1-4d3d-a6b0-8f18482742aa@icloud.com>
Date: Sun, 20 Oct 2024 18:19:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] phy: core: Simplify API of_phy_simple_xlate()
 implementation
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Felipe Balbi <balbi@ti.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org, linux-phy@lists.infradead.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241020-phy_core_fix-v1-0-078062f7da71@quicinc.com>
 <20241020-phy_core_fix-v1-6-078062f7da71@quicinc.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20241020-phy_core_fix-v1-6-078062f7da71@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VuuRnmVBSFD8Lq-91SJTDLikCykcND8L
X-Proofpoint-GUID: VuuRnmVBSFD8Lq-91SJTDLikCykcND8L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-20_07,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410200068

On 2024/10/20 13:27, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Simplify of_phy_simple_xlate() implementation by API
> class_find_device_by_of_node() which is also safer since it
> subsys_get() @phy_class subsystem firstly then iterates devices.
> 
> Also comment its parameter @dev with unused in passing since the parameter
> provides no available input info but acts as an auto variable.
> 
i am not sure which parameter is unused. @dev or @args

comment says @args is not used here
but code actually uses @args but does not use @dev

> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/phy/phy-core.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 24bd619a33dd..102fc6b6ff71 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -748,7 +748,7 @@ EXPORT_SYMBOL_GPL(devm_phy_put);
>  
>  /**
>   * of_phy_simple_xlate() - returns the phy instance from phy provider
> - * @dev: the PHY provider device
> + * @dev: the PHY provider device unused
>   * @args: of_phandle_args (not used here)
>   *
>   * Intended to be used by phy provider for the common case where #phy-cells is
> @@ -759,20 +759,13 @@ EXPORT_SYMBOL_GPL(devm_phy_put);
>  struct phy *of_phy_simple_xlate(struct device *dev,
>  				const struct of_phandle_args *args)
>  {
> -	struct phy *phy;
> -	struct class_dev_iter iter;
> -
> -	class_dev_iter_init(&iter, &phy_class, NULL, NULL);
> -	while ((dev = class_dev_iter_next(&iter))) {
> -		phy = to_phy(dev);
> -		if (args->np != phy->dev.of_node)
> -			continue;
> +	struct device *target_dev;
>  
> -		class_dev_iter_exit(&iter);
> -		return phy;
> +	target_dev = class_find_device_by_of_node(&phy_class, args->np);
> +	if (target_dev) {
> +		put_device(target_dev);
> +		return to_phy(target_dev);
>  	}
> -
> -	class_dev_iter_exit(&iter);
>  	return ERR_PTR(-ENODEV);
>  }
>  EXPORT_SYMBOL_GPL(of_phy_simple_xlate);
> 


