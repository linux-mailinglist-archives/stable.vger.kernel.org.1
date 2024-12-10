Return-Path: <stable+bounces-100453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AD79EB5C8
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 17:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431A9281D2C
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AE81BD9DD;
	Tue, 10 Dec 2024 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPZf5H1B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED8E1AAA15;
	Tue, 10 Dec 2024 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847300; cv=none; b=EKFy394M0FhezenoHT9le7XriXn37zAMlJeDCZ4UtO1n9l94EGd2Fu8twTfty+zOn2k/CnrxeGCR+DkVEyA+cuq8xp87cuiX9qfIvEIc/+k3ipGaOYvfWnO9f4lyn7a1sLVvC2dITIJEHmUZWEUMgWWEWjn72wAMGuN7/rgQeLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847300; c=relaxed/simple;
	bh=31VPjuhtUqs5XTJZjLWo1bnT/4FHbU4/2zRNq1awM5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEvSJu85E7sacZDilXxPKKeQFQrgw1SP/y3wwi9uYiNv+YlHQoqGJfxPUYN9mNm4oNmSyCEGJW3J4X7v3fGygxAG30P/0nHUGDGCXXZa+/6KnVzH6XvRg0LHcFt0riE11CfxJfH2UXPGJ8WgjYt1Vgu9ocVlnBalqAb+UZwnrLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPZf5H1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5F7C4CEDE;
	Tue, 10 Dec 2024 16:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733847300;
	bh=31VPjuhtUqs5XTJZjLWo1bnT/4FHbU4/2zRNq1awM5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPZf5H1BVBX/7HcnkYtV2DylIp1rLFxLRcczmtRuCwwQ2Fov8LtGizL9CXhSrQ6EQ
	 nfebIG+lJ8optZmTp/AFpDHHlZvHutvEUOtQWE8qTTsZp7qmhsFKnf5dVNugXqLaIK
	 IRpNPpTBEEIevy7tDYZNRQi6FAfxcPzF0OWoPxfZJxfyiPgKcPZO6aVWQFMWl6mTzp
	 ybDC/yirdvVia+jlDVS1pzPAKeJ/NHk05mUuKRZXieyAclX5H97oQNV7KUBQVhM9A0
	 wYs8BPZSzWrsel9pQIywsnafcIRsbqzYuzJ1z0ZPrktZcWKiCmwD3Npl4tFTXs6KGd
	 I/hWgMZfLyPag==
Date: Tue, 10 Dec 2024 11:14:58 -0500
From: Sasha Levin <sashal@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 5.4 20/28] net: enetc: add i.MX95 EMDIO support
Message-ID: <Z1hpArZhTewykeE4@sashalap>
References: <20241124135549.3350700-1-sashal@kernel.org>
 <20241124135549.3350700-20-sashal@kernel.org>
 <PAXPR04MB8510442A46C2F25FF783E899882E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510442A46C2F25FF783E899882E2@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Mon, Nov 25, 2024 at 01:54:14AM +0000, Wei Fang wrote:
>> From: Wei Fang <wei.fang@nxp.com>
>>
>> [ Upstream commit a52201fb9caa9b33b4d881725d1ec733438b07f2 ]
>>
>> The verdor ID and device ID of i.MX95 EMDIO are different from LS1028A
>> EMDIO, so add new vendor ID and device ID to pci_device_id table to support
>> i.MX95 EMDIO.
>>
>> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>> Signed-off-by: David S. Miller <davem@davemloft.net>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
>> b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
>> index fbd41ce01f068..aeffc3bd00afe 100644
>> --- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
>> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
>> @@ -3,6 +3,8 @@
>>  #include <linux/of_mdio.h>
>>  #include "enetc_mdio.h"
>>
>> +#define NETC_EMDIO_VEN_ID	0x1131
>> +#define NETC_EMDIO_DEV_ID	0xee00
>>  #define ENETC_MDIO_DEV_ID	0xee01
>>  #define ENETC_MDIO_DEV_NAME	"FSL PCIe IE Central MDIO"
>>  #define ENETC_MDIO_BUS_NAME	ENETC_MDIO_DEV_NAME " Bus"
>> @@ -85,6 +87,7 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
>>
>>  static const struct pci_device_id enetc_pci_mdio_id_table[] = {
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID) },
>> +	{ PCI_DEVICE(NETC_EMDIO_VEN_ID, NETC_EMDIO_DEV_ID) },
>>  	{ 0, } /* End of table. */
>>  };
>>  MODULE_DEVICE_TABLE(pci, enetc_pci_mdio_id_table);
>> --
>> 2.43.0
>
>Hi Sasha,
>
>This patch does not need to be backported, because this is a new
>feature which adds the EMDIO support for i.MX95 NETC. And i.MX95
>NETC is supported in the latest kernel (should be 6.13, Linus tree).

I'll drop it, thanks!

-- 
Thanks,
Sasha

