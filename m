Return-Path: <stable+bounces-12364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F461836329
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 13:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744C81C22C9D
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 12:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FFE3BB3A;
	Mon, 22 Jan 2024 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DPrNhd2n"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7973BB33;
	Mon, 22 Jan 2024 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926308; cv=fail; b=nGtrq8V1jh0YcYP8VyWCbVswEZJ00Ia9taaEp1gN4VAFLFS8xtcJSFJzomaIYWOo2bjhF+4H1sNeTqrZK5KJgCiSVay4Wq9WY7uRGrnqHOs6CD3EcNOD/ARBE18zpItTxTrkXEkYbUWV5cdoEkVkefVAvDXJH2oOyhPHg3VmzLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926308; c=relaxed/simple;
	bh=l3MwbmG4SXC3Yit7j8up0R4iDOKFBkEsxkIDQuLvdFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c3MEf8JEUu+MaBVhjNjV9ZfQ6yXtLWrjjhi2uCp91BMPVv58VOcsxNT+efoyaBzVe6gCvU/8zqzU+ZbAyz+bDB5RiVFP1NrwIT/4RpLiZoSjEeyBYVyb054AoyNX/+0YbTKjQH8Ok6o2/VG+TtuPPRDxnp2boiT02jSAd45+W9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DPrNhd2n; arc=fail smtp.client-ip=40.107.105.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFuPm1o97wCsqvhX/27SnoeOk1ORWbKoHzF6yJrmY1nbHbiKNlBj7cQDFCmywrWVRx1v0xC4+R7qGWeu4t/ykMN/Zyv6Mo0AZGKfJPyTXRiiAXjGv5kvMgDcukBG6xH3Kxc1sbSZphKqm3XrdkySWePaGxFLrIznc2k3SGjzD1oXFQCtdjUAHhcukGtkHM436nHtp1oGsboflshf/v37GpIFRyMEjgsl64reYgregCrwP0htVeZrd2fYABm144ckF6ED1iL4VcIYK/fVcCkdF/NLNUPnf1C7UPlK0H26yKjQqcLB+XOkoU2Maon8fk1DXsWxF9Mls8dwGOaCUsPt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnWqlORgw/Gbh4w5PjIO7+iOSNPs4uQpLbRWqYsFzBs=;
 b=de9P9UGFZpsfkeltLYsdleOEYhkBpsBadoBe36M212AWlk32Q/QbBxzSkC2qjXC88lI+Ea8wYmSC1GYg+cFrpJgH3xSn5+bsYURHyazkB3D00bvxt/qpeDmOFo1RNH6P1/iEKxrUCt4Dexweso0WVj5yejuk1dwavDahyAsE5Wy1168WtU6OYlrF4mBExcJtzRm0SjbOUAn5GHscSKiw7M3gONFPS5D+y+0zO+iPGHrS7OttOBO4dHR2qQ1qWSpeg79RNZ3tGbU7GY16FK0gpCXtVwxXFb2rOBOkaEDOzE5iTrMsvyDOasKqmnTNhL9Rlqi//md9KcCqcnZCZSKCGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnWqlORgw/Gbh4w5PjIO7+iOSNPs4uQpLbRWqYsFzBs=;
 b=DPrNhd2nhJxrzXh9OLjV3guCeuK3Nrgu7cIks/qaUk58bGiuiFrmrsTq+fIuPrKLcH4n1vr6ZUrBEBdlhyuhU+aLXtkmjb6Tr2C0Ez9hjp1JevsOcuZJ+e0+ngZJgeVfIp2U1Sa1mevWCWrbBiND9KsVqF5LZWf360sYD9IYMTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by DU2PR04MB8902.eurprd04.prod.outlook.com (2603:10a6:10:2e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 12:25:02 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 12:25:02 +0000
Date: Mon, 22 Jan 2024 14:24:57 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev-maintainers <edumazet@google.com>, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net,
	netdev <netdev@vger.kernel.org>, stable@vger.kernel.org,
	Tim Menninger <tmenninger@purestorage.com>
Subject: Re: [PATCH net v1] net: dsa: mv88e6xxx: Make unsupported C45 reads
 return 0xffff
Message-ID: <20240122122457.jt6xgvbiffhmmksr@skbuf>
References: <20240120192125.1340857-1-andrew@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120192125.1340857-1-andrew@lunn.ch>
X-ClientProxiedBy: AS4P251CA0026.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::15) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|DU2PR04MB8902:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3df196-bc75-4a6d-0711-08dc1b45283e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	la1dqLQa11mnoF4hPsS8W7oiKad0paxcem4q6acPfm5epvMOEqxv7bC7ku2mWuqCwKciDcDo5dpOEvpo0nokBQHdIQCFUowVlWbHHA2DJcBfYIPpufwFNa0BgxxkZASEhcaeo8+PKq8VvtgA82ogYHMGpBqpuzpTqrX9HuzgccunfHSxiRP0ptjFhS50DdGtcC97FdZmojQp0HtbZlAXN6O78PFE6e1nKwcLLF9+W/91b5+gAT6Dn2Ng0U2m1d3wND3JaLlOnUOyKwz+sdTuYHXg7xa9b/HpnIH0WZaSpiIxEvknqx3HKDYozR8dur/1YEQXYjTUHrK9s4oi50FmZ5rNtWTgYmxW8WE/C2RnJQmtd6Xgw6+qvztHOeRws2JsduyTiOmehMjgPHs0drtU/C+KTRYIHosN89+czfhWy6B/uDW4pBaz339smiTq5fr+wwfRm4ld9HaehMSZQWjw8JuHGulkj0xdxuZkezw5VYxDubZIAN8ZzRuK3F+lJ4hsa4o7Y1MZ4Kem/Gug++5tqq51L2+wpHyFNm3EOsHZrfc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(1076003)(6506007)(6512007)(9686003)(26005)(6666004)(86362001)(38100700002)(41300700001)(8676002)(8936002)(33716001)(966005)(4326008)(83380400001)(6486002)(2906002)(5660300002)(44832011)(316002)(478600001)(6916009)(66946007)(66476007)(66556008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6IjzxOYrjOceEZLNht6ehzFD2SFyJfjvOQHk4Aul+DwfuYqsf1aGuKuCmg+l?=
 =?us-ascii?Q?J8mRjuLU9GjvKoQnf0UL8AebBPHu+Hn/lI4sTBKdG44KfrCAW8UEU3b19wgF?=
 =?us-ascii?Q?ZmFXHSeepxddHAVt/eBllU7uSmn9pjPT6hItLnpjMbQ5ZbjHhVJpfsIGo5dh?=
 =?us-ascii?Q?vZJhnrPx8oE3WYZN4G0NF8lb7HOb2YoJDYiypdmtukzJd7y03hVzZn9Cwnz4?=
 =?us-ascii?Q?FCySmuWvgQR0J5UdaH7JxokUD6z/zZ0QNeDQd5Bbw3FMKz/VJDMz+fWIuj0C?=
 =?us-ascii?Q?Z1/pLhaX3PeiGji44oFA6tK8SBAtlTUIWDMxGtFKeAyJESOypnK9O3cVqrgw?=
 =?us-ascii?Q?JzN/Lgu4cQlk/jTmD4bSmv6X4/hJdkSMKZXoHXXD1nhvmA/isQYvYZDMFbIc?=
 =?us-ascii?Q?z6+UH9Fje0XE+WpKB11xP0hlkLxgzCtC6Swlz7EP4wwROey4f8+nUc5eYcmi?=
 =?us-ascii?Q?KaxnK47KmwOrmbyOzHpb+pj7VQelEou/X4clp4v5G+GUF2mFqzvAbY5a0FIx?=
 =?us-ascii?Q?ZewIfQHAfge2vD6r/k9m9SdiJT54ScLya2M0Tx1Dv4MyabKlHuc06bRtM1t2?=
 =?us-ascii?Q?UMIF0VZBw8tOA+PK1IJDIqcYsiNOx/562j15KNwUc4Oh/OOx4b938aoot6hG?=
 =?us-ascii?Q?rrERh2jaxQ4kL4RExjiCJBbjMbhmWYVLZ/R0MKop2FkKQCa4v0j2kXefwXam?=
 =?us-ascii?Q?AnpLENjA57tKZvE2a0ZToj5bFaSC8u2yq372Fjre0IEm9Wrt8DLwOGztwFVA?=
 =?us-ascii?Q?J3zcNokO5pydErPOXucYYWS8iLNcqjbSOAQf5hOv+fg94uaoxo/wd/ZOOQqn?=
 =?us-ascii?Q?4d5qyx8/IMCP6XgCxsUFPKSUOdv/TW/blTz6KmUmgUAINTXwbRUpfBMfSAiP?=
 =?us-ascii?Q?3KmoFfVVdQTJ6ZH/iGYOnu2Vv83soJrQ6J20nOGY1uvvrD5yEWGgs3Equrxz?=
 =?us-ascii?Q?IrNfqIjPacqvNnBXD6SMouZNx8DWfEbdRrwM0Cy7S8s+1+Bg7MtRjGK2yO7J?=
 =?us-ascii?Q?+nBxBKhLMesb0YHwA9Y3xuZriug53N8b8dHcUN0Gq/MVCO0s3pYL4AxecV9i?=
 =?us-ascii?Q?E4j7pQ7Swr4JEZoWyHlnElH3SEbv9ho3gMKOty1MEF5KUtEofzQ80vzCDwJe?=
 =?us-ascii?Q?y2VbK6EVwDDfoHZvpFhPOoR3EC8v1G1+Z83dlBBhqHYQEdz7RaVhpCw/IEUr?=
 =?us-ascii?Q?zmVIQ8JaAu4/EGt9TdAB8f0Y62U1b622LVjXiFXSxZv8UwaPu2I+p8V3NZKS?=
 =?us-ascii?Q?NsJUnArj4+D1+ABhrVrNjKBhNUEDwi5/YHCGuVA1P5ZHry820UydqC+B7ul2?=
 =?us-ascii?Q?JPOPu3Gly3ucHJsv21QOg0KMO/XLInj4pLZnoizsYFyFFwOgSrjsZS7vDQOE?=
 =?us-ascii?Q?+WFfg2faRJTrMWXs8Jv4ViMR4iD2gnaxVsH4Kd9sq+svmCT5ZqESTB8LGsFe?=
 =?us-ascii?Q?Hi31hOU9gkaUT+hB7ALJvsbGuaSPzcr9Ya/lpe6jvDpyfAmJpnVC01lsGL3u?=
 =?us-ascii?Q?bxrq1e9qKu1cU+84eg7ZK7FudV/oUaOAmJd5stKYne5dHT9PnGmf4fFREVSX?=
 =?us-ascii?Q?JHM2WOKQl0yXcDXjBXlWXTl+k+n0jRAATVZT4wkdSiYgNppKN224HQbyZB6n?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3df196-bc75-4a6d-0711-08dc1b45283e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 12:25:02.4274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDN6sbyTbW6kyMieKDWOfqIrf/TtP3mJdU/En8kJfNFhCqlrxBSbhRYnSHoE1Iqdlg4+FeXsLZ7BuSaRFWRU5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8902

Hi Andrew,

On Sat, Jan 20, 2024 at 08:21:25PM +0100, Andrew Lunn wrote:
> When there is no device on the bus for a given address, the pull up
> resistor on the data line results in the read returning 0xffff. The
> phylib core code understands this when scanning for devices on the
> bus, and a number of MDIO bus masters make use of this as a way to
> indicate they cannot perform the read.
> 
> Make us of this as a minimal fix for stable where the mv88e6xxx

s/us/use/

Also, what is the "proper" fix if this is the minimal one for stable?

> returns EOPNOTSUPP when the hardware does not support C45, but phylib
> interprets this as a fatal error, which it should not be.

I think the commit message is a bit backwards, it starts with an
explanation of the solution without ever clarifying exactly what is
the problem.

At least it could have referenced the old thread which explains that:
https://lore.kernel.org/netdev/CAO-L_44YVi0HDk4gC9QijMZrYNGoKtfH7qsXOwtDwM4VrFRDHw@mail.gmail.com/

> 
> Cc: stable@vger.kernel.org
> Reported-by: Tim Menninger <tmenninger@purestorage.com>
> Fixes: 1a136ca2e089 ("net: mdio: scan bus based on bus capabilities for C22 and C45")
> Fixes: da099a7fb13d ("net: phy: Remove probe_capabilities")
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 383b3c4d6f59..614cabb5c1b0 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -3659,7 +3659,7 @@ static int mv88e6xxx_mdio_read_c45(struct mii_bus *bus, int phy, int devad,
>  	int err;
>  
>  	if (!chip->info->ops->phy_read_c45)
> -		return -EOPNOTSUPP;
> +		return 0xffff;
>  
>  	mv88e6xxx_reg_lock(chip);
>  	err = chip->info->ops->phy_read_c45(chip, bus, phy, devad, reg, &val);
> -- 
> 2.43.0
>

Is this an RFC pending testing from Tim? Or have you reproduced the
problem and confirmed that this fixes it? It's not clear how the old
thread ended.

