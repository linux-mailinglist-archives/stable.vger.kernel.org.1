Return-Path: <stable+bounces-227727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO0NKwVAvmmhKwMAu9opvQ
	(envelope-from <stable+bounces-227727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:51:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F422E3C9C
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44CBC3031E94
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F6136D4E0;
	Sat, 21 Mar 2026 06:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TXLIuAUe"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC96F1C549F;
	Sat, 21 Mar 2026 06:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774075902; cv=none; b=geI8EMHdCl8MdWQqkR5w0o8MKTGAr5FuMB0PR0UV1TxbyYj7hWkpuZoM2XKKPjUY6HPII9GjV2Q+ZJ6bCCntR4lThVl1hk0pv/4JfeM1PWP1dM94h7Ftwp3jIODKhP0nUDT3rGh7A01RYjyXNB0JU+YXhkHRIrhv+wdRW6cI25U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774075902; c=relaxed/simple;
	bh=8tjJoXaiiaQiixnJ12O+jr+ng5K6SlyLuSrlbYJUVmc=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=EPrNXbcT7Bij5rSNxYdgmNsDF+4YljCqiteHrPfg4+SRip//5ia7SK/+WhmSsiI+RDR8cabNiim7nbTH1TND3uktHFS3fhk9n5RV5jqJQCFsAG/lNktFVHge6BHCOUceR/4E7ROTtSrsw5ZNezX1BKkcyGHx8PWvmcKRSUkjiAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TXLIuAUe; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iU7fULhnma33dp/23p2NuWLiV6eIfv8H817dB3QYFxs=;
	b=TXLIuAUeOibfTKOTiR3ewg4V+Pq06u0Qzwin5YISmHRm7uTsYuplo1kFXY2kcg2dgAEcVEnew
	zz0FqiUA7/1FVjvAE8aIBcKuoH2wOXYuVZCKOJmvzBGOynpSlbZJ2GKzzpbCDRMBjJ2Zl8tZ+QS
	WMf2mc+GlCKcm6Gy0pOLjSU=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fd91s5YVlz1T4G5;
	Sat, 21 Mar 2026 14:46:09 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B19A40569;
	Sat, 21 Mar 2026 14:51:35 +0800 (CST)
Received: from kwepemq100003.china.huawei.com (7.202.195.72) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 21 Mar 2026 14:51:34 +0800
Received: from [10.67.113.213] (10.67.113.213) by
 kwepemq100003.china.huawei.com (7.202.195.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 21 Mar 2026 14:51:34 +0800
Message-ID: <69BE3FE8.9080109@hisilicon.com>
Date: Sat, 21 Mar 2026 14:51:20 +0800
From: Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Shawn Guo <shawnguo@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: hisilicon: poplar: Correct PCIe reset GPIO
 polarity
References: <20260227071958.1350024-1-shawnguo@kernel.org>
In-Reply-To: <20260227071958.1350024-1-shawnguo@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq100003.china.huawei.com (7.202.195.72)
X-Spamd-Result: default: False [-0.16 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_FROM(0.00)[bounces-227727-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[xuwei5@hisilicon.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 11F422E3C9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Shawn,

On 2026/2/27 15:19, Shawn Guo wrote:
> The PCIe reset GPIO on Poplar is actually active low.  The active high
> worked before because kernel driver didn't respect the setting from DT.
> This is changed since commit 1d26a55fbeb9 ("PCI: histb: Switch to using
> gpiod API"), and thus PCIe on Poplar got brken since then.
> 
> Fix the problem by correcting the polarity.
> 
> Fixes: 32fa01761bd9 ("arm64: dts: hi3798cv200: enable PCIe support for poplar board")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
> index 7d370dac4c85..579d55daa7d0 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
> @@ -179,7 +179,7 @@ &ohci {
>  };
>  
>  &pcie {
> -	reset-gpios = <&gpio4 4 GPIO_ACTIVE_HIGH>;
> +	reset-gpios = <&gpio4 4 GPIO_ACTIVE_LOW>;
>  	vpcie-supply = <&reg_pcie>;
>  	status = "okay";
>  };
> 

Applied to the HiSilicon arm64 dt tree.
Thanks!

Best Regards,
Wei

