Return-Path: <stable+bounces-76503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEB097A4CD
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 17:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCCA1F21CEF
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8951A158536;
	Mon, 16 Sep 2024 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Uzya4vjd"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013050.outbound.protection.outlook.com [52.101.67.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB31D554;
	Mon, 16 Sep 2024 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726499242; cv=fail; b=rxQAh1lgd4AnnpTJpRiAMGG9vtHrsDNfqSOd1g6U6KUiiuP8jTyXhsqFhdEyBNy1g5ynMex55QeA54A0yqVZEJqI7siZ1FMVt7busJM78W8YWsCOkFJeMSOKs/3mqzPvFQzu1R+kAxyHACyfOU3YhRu0tI5VxbNc7R5bshZqktE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726499242; c=relaxed/simple;
	bh=8qlDrV7YMBKnrZ0HVIHaaLb5qTWiBbhFktiJw7N/1yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G7+s9Z0evnVKKWCVg/CmhmiY2YMV5/MCBcI4vVGbBqxt460VB+EQBWhq71HWzGOK8zcRCmQsMXkQIfjhj2TVSssDgiVEO/PeFBAa63IF/X9ZzJQVB8WJEGoblM1ur+tK+6ofXzPnWC1Iu/XIgjUC0U0rd+D6vWvEOgkqi6NMNCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Uzya4vjd; arc=fail smtp.client-ip=52.101.67.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHlH9u3NLSD0GiuYaf3uMkvtuGl/qV0fAJ6haBiRhe832NT/G5Yele90uvs5CmN2LNkoEE3nRs79hTRcZHtusoHIhDaW8xD+3xbOfRxIUK2/3Ov3bU1GVvLI0b/u86dJKvi9GoAPIAYlpxyUIeY7WxJ1OlrjtGfC3v3jGPweRb5CTUw7cOxDe1AvKLtH6F6M7dYiNfM4QNlFaSxcmzSJYs+LtZRnOf+nuensnyyCjqBvgoDb43rovgUpNnJ99VVfFAP+sDkab0bP4WtHRLU3aXDMnilTlmFWmPSFLO7SgrAO32a0EuFw0/tMyL3ggl51JzOttgCFeBkE3fHkYjmCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIzVTLxzLCF9veZStzYO8upuaWqoUsvALYL/gsUU9zM=;
 b=LxkwUbnItTe+u12nmkOs1OsEHZJ4JgTJgCBLaBWEgwHhsl4gwAMcQGfPgs/Pk/T9H+Ffy5CM3eu9pZLWINxMvCBTfEO3OHsO5YTjoTzKsQDJkJX69d57/tJihO6bDCLBwcvJf6JZqzBX04J8Bhl+xNJ5u7dqK9zzjsWVUgCfrKtDKIUFYmLWU5c0mvpgTgkKhmO1dQyQp8HFVRqXifbLIWa4TJI1V7SY1jJ92DwQHTxlmyoT9e+jYo+RAgQA17EWBgfDP3nbV/d6PiC4DHuGb4ZwNCCXRIiWWHACBwfyFWl4m5xLpYmh4hZ4CuGCiMd2UTOsefCxR90uBdAfTV5ZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIzVTLxzLCF9veZStzYO8upuaWqoUsvALYL/gsUU9zM=;
 b=Uzya4vjd/iVrJBXM2v1wXuecc5uF7TQyQEYdy1BP8bTbnCxYUXl1Gb7CMwn0HDqUDp+1QAdOxLP5GIXqcdbSZIpxPCUl3QXDYKkZxr5RaWvvxlukHP9xYEFjDazjC8h/GSt5T3OZamwmAHRSbNEuybRULx27xhjDUb0ZWqmLVqe2rK62R2oTt9uXs4oQ37xyk0RHH0cXWYygVGbteNouj25x0IUubqF+qPSXXo3YLcAiT7Ruivec30aLMZkdWiSJxOhklGJ+HeHujYHC8ib3jBdjsF8+6w9dnkSXGJazkYBWtq59KLNg8GEos5yEr7YBLjw0mZtVGFmrcrC1s+H+Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10990.eurprd04.prod.outlook.com (2603:10a6:150:209::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 15:07:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 15:07:15 +0000
Date: Mon, 16 Sep 2024 11:07:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: Kaixin Wang <kxwang23@m.fudan.edu.cn>
Cc: miquel.raynal@bootlin.com, 21210240012@m.fudan.edu.cn,
	21302010073@m.fudan.edu.cn, conor.culhane@silvaco.com,
	alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] i3c: master: svc: Fix use after free vulnerability in
 svc_i3c_master Driver Due to Race Condition
Message-ID: <ZuhJnLJ6MkOMz9yb@lizhi-Precision-Tower-5810>
References: <20240914163932.253-1-kxwang23@m.fudan.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914163932.253-1-kxwang23@m.fudan.edu.cn>
X-ClientProxiedBy: SJ0P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10990:EE_
X-MS-Office365-Filtering-Correlation-Id: fe535db2-8815-4cd4-6e07-08dcd6613fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5ofGqk5TSgQpbAJQFn7NYpdKnh3D30/Ld/E41NQFqSNylRlz4FGa48+JgtIv?=
 =?us-ascii?Q?Vik2RatfA1xWUkDW1Es0HhMI8CDGito6ybaNktAkrncDXtHDw0T76kDPlntO?=
 =?us-ascii?Q?QJFGrXC51bTQ1mJkJYNT7ufx4Zc+k3jCPE88RaLkX4GoFFQzVLQMLiiYgZja?=
 =?us-ascii?Q?zXC8INfP9yUINFrbKyBjkexCnabnahZmsLcOxAezPO5PjtRKQBKuMPuThX7R?=
 =?us-ascii?Q?3f8pCeLOb+wsgTXz+6iQsdAYawHh84WqngPOJnCtWhd2j5D+W5dYEhoNhzZj?=
 =?us-ascii?Q?Rz4QTj2Xog0qyMHEG0/rawr/wqvn402GdmjrYIaATsffzdAetrr+4B5s1NpP?=
 =?us-ascii?Q?y/H+s10z3xX8oW6sdS1J95ybAlZO9pZVY3FOU8Gbo6bNFUObvFiTa+ZDFo57?=
 =?us-ascii?Q?+BJUXrJg+q7JKyEfdy0DlTclADhhr0cX5t2hsuVCqEyeyFLXKi2kVeD3r+g0?=
 =?us-ascii?Q?Iyn2mRWqYB411/5OTaNs9Zwr/rfngEY2XSdDd67gHO3IjfJZMK1MaTYxDuC/?=
 =?us-ascii?Q?jlaGhgL2y8237xfU86ZuFIsBSeOdiEtE1bu/ucSW64pLzmt4qDgTBa+JkuY7?=
 =?us-ascii?Q?pYe1TgtQw+y79ENUSBBfJapuvY27EV710Iyg80ir8tv2R8848H6d9T6EYJz6?=
 =?us-ascii?Q?5auLop3ily30Xt2VHyiXleKcEeF/mzH77lX0UK3MkrwxFxHYI1IhcIIV+zP8?=
 =?us-ascii?Q?hu3AClG1lx+eHz9xiNYEfhPzRtyJLngu1TPHQiw1OETADMsp+4gmeSb97ok+?=
 =?us-ascii?Q?GJVitQanq58lxbhDBDBZY1+k/qrf9xetXS0ufeobCq5jfJ5GYOjLWgCbqMRb?=
 =?us-ascii?Q?t2eBi8T6I0//pIB98/p+cZsJoAI5iuvDhMEw1+f/ejzpM0/+SaCbCc0/zCMJ?=
 =?us-ascii?Q?veS5sKsrpGU680qtJ2g/LiHLY9WJrjJx+fvrO7IA69vj0VX3bIuTYhTbttwr?=
 =?us-ascii?Q?VD7f7XOFUWN3J66sXNfe9hKrzdwXd9/xWJ75fNYzPYjU+IpRKgtm+kc4KbtC?=
 =?us-ascii?Q?4RMAH8lwTsb7k3RqxbrL+Vi8QlieG4H2h5h+QukvkvvFYCGFatcNsZSQT0+d?=
 =?us-ascii?Q?3+/HgowIfnbldsZ4bPDLGKieOLDQF/MvgNMjK/ZW7goAVUcSYcrwUTUVKstN?=
 =?us-ascii?Q?AB926DCKP+1prBZKiSH5hGUUl46hhJK9Axp3CaWLqpos/qDL7n5bzDPGLf56?=
 =?us-ascii?Q?o8H9sn3CHp/ZSlkrme2AdFNY/5mPFFB5ujCIM2Zd4miZI/pSUruK5ewoHDYV?=
 =?us-ascii?Q?972NCmdqU4FL5pM7OegF1yXgRhjyw1QonFoIhMg7UGRuOKdLlvzwydpgo35j?=
 =?us-ascii?Q?0E+9Ou8wLgESbNqr7fPci38gy99EgQQW8rYMdlxSK+nuSdNjimSmwMAYVLrG?=
 =?us-ascii?Q?wXTt0fHZt2NCwWUMoRzEKszUPMHCCpnJTn8aRbMr2k0byUJf7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eCZRnNzzvrl0nepcGvEUn5wAoPH7aINinhMrVvxfbXXTwyDhrHJ5SZref0cG?=
 =?us-ascii?Q?ll/6Z8L+BtoCmM9W8uyHTxXWLjDXuyu7erxP8lFS3ZHxOsRXX2s/INsa8zdh?=
 =?us-ascii?Q?Zo1N/LzTIBc2X2i8HpvD7u6Q7Lh6tU2suavOFM/IykEzih8u3OimZgqTORAW?=
 =?us-ascii?Q?rMSXN7GXHZBGBU6x24Or63I47U5O87SJOdaYoSaFu9vFalbN58kzmIUTlRQv?=
 =?us-ascii?Q?dtCHTHcSv4WYmjBLmnJPIcN2T9vmYjgVBlT0XuKdFc+ISyELnqu+SmjmYSZ6?=
 =?us-ascii?Q?yoEf4FCn+R7/8usoq6nFFiyB+SHuWXlye//h4FfmeW70niiRSNWFgNs4s8s5?=
 =?us-ascii?Q?yibbCTxXePvrigSmmTwJ3VeadFq3uYTx5padjO6vg7KyX+PjUQ+Iw+3LvIo7?=
 =?us-ascii?Q?9pYU+/jD+OzRdJqqLCJH2Ktb+dKbxhh0b64/WwZjrQxp3essO4bpGrH+2Mlp?=
 =?us-ascii?Q?Q9TvSUWEZ3lo0/N9hxK4ac6PcXnfF5UknBpctSvPJISMSdoX1tzK1bC5Yo8Q?=
 =?us-ascii?Q?rMMJmIdxl8n0FITDnhUzy8kpXjvrB3sZeCflxd3MtVt2Wo2j60Hv30V9+Eb/?=
 =?us-ascii?Q?HSPB/R2oYKjuaLSM3/0cuSVLCsPl4yFwknMztaArrohGL4XhffHbAoBCKMnn?=
 =?us-ascii?Q?2kk7niNAP5oWDqQYmK3G2J2quRxdQkTILCnOdawo7A5JBUWc6cHBrLjEBO6s?=
 =?us-ascii?Q?IUVSf6+shKaQeE98StRkYV6dhgaF3XntL9At+eNWzHvXfgKhfBTjkFMWcJ0+?=
 =?us-ascii?Q?JWFadX+o7eii5acKUmwSMtqwR3CYaDJbSVIXMTE7etmVeOnrFQAVW5SIg2Xl?=
 =?us-ascii?Q?8Zdso6KxXWpfTiFxYYszNiqBC820cCxXpxbg3kAywYCcWiKWtJwdmYCA7Zf3?=
 =?us-ascii?Q?ioC6gOguo/JhJWNFdBq+ViGbMYKbAduNEoE9RsgTjNfqaK0fnzec+WHxYmFf?=
 =?us-ascii?Q?tN7JBQT4b16vyu+hGLA2SddMEYoHk4q4K9bgSgHqEWf6KWgAQqAX3RQVMwVp?=
 =?us-ascii?Q?NU0IkOY1Ip/fyEVBkpT/dGpEp5K9ZHzA2pM3oCfC2S3Sdb8+xwfGz2QfyaMw?=
 =?us-ascii?Q?faxTQD+ywjy88AN2dVtDEn6f6iLgPGKdtkdnAvRHu/t/cj3CJZea9Rq8PkO/?=
 =?us-ascii?Q?rXI8TaQ7UqvnFwNQCYV2z2zMCZ29gkN6/MHKXIje8amBycF2H7Sao3mATIo2?=
 =?us-ascii?Q?QR6Z0B4NZoxCwS+2WZckLNvKlwY0NiSbYuf2r4fEHqFv0MPjBmA7xVj4d8O+?=
 =?us-ascii?Q?I3DS5cy7ZAQQFF+EuG4cEYymaSFJ3Z+ztdgl+w8SPxxWe6GnNE8cwBt3G14t?=
 =?us-ascii?Q?EXWzZQlW728nLJOHSkvGgYlMuhAZNzPQTv9OrE126MnH51BfinoCp1GPzbnH?=
 =?us-ascii?Q?fDI0zCJTQnvBTrQMC79aJNHBt9MrM/U6MEBu+TtIMkzpi6a8wbgAqoFXKiWL?=
 =?us-ascii?Q?T0s+iKYRVBPJDRT+19EYhUhY+wd2LCR0Pt3PNrbBi//eKfA1EUpUZxpy0RhY?=
 =?us-ascii?Q?CuOcSj+nQL6jj0QujveDzoPftqThrtykLY92nk7KpGBD1PzX9mnP1HMzuAsC?=
 =?us-ascii?Q?NM+Fr+fymON9cUW6IBb5sqZeYsKUJdvVySH+gOy4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe535db2-8815-4cd4-6e07-08dcd6613fd4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 15:07:15.1751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRH7huMwoRApFHqQvp5SwUtyrbTZV0M1be/caaG5iNG5OVO91keC2y5pIpDuhbd9uJWrkAnlJvakkbJ5Iq05jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10990

On Sun, Sep 15, 2024 at 12:39:33AM +0800, Kaixin Wang wrote:
> In the svc_i3c_master_probe function, &master->hj_work is bound with
> svc_i3c_master_hj_work, &master->ibi_work is bound with
> svc_i3c_master_ibi_work. And svc_i3c_master_ibi_work  can start the
> hj_work, svc_i3c_master_irq_handler can start the ibi_work.
>
> If we remove the module which will call svc_i3c_master_remove to
> make cleanup, it will free master->base through i3c_master_unregister
> while the work mentioned above will be used. The sequence of operations
> that may lead to a UAF bug is as follows:
>
> CPU0                                         CPU1
>
>                                     | svc_i3c_master_hj_work
> svc_i3c_master_remove               |
> i3c_master_unregister(&master->base)|
> device_unregister(&master->dev)     |
> device_release                      |
> //free master->base                 |
>                                     | i3c_master_do_daa(&master->base)
>                                     | //use master->base
>
> Fix it by ensuring that the work is canceled before proceeding with the
> cleanup in svc_i3c_master_remove.
>
> Fixes: 0f74f8b6675c ("i3c: Make i3c_master_unregister() return void")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kaixin Wang <kxwang23@m.fudan.edu.cn>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> ---
> v3:
> - add the tag "Cc: stable@vger.kernel.org" in the sign-off area
> - Link to v2: https://lore.kernel.org/r/20240914154030.180-1-kxwang23@m.fudan.edu.cn
> v2:
> - add fixes tag and cc stable, suggested by Frank
> - add Reviewed-by label from Miquel
> - Link to v1: https://lore.kernel.org/r/20240911150135.839946-1-kxwang23@m.fudan.edu.cn
> ---
>  drivers/i3c/master/svc-i3c-master.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 0a68fd1b81d4..e084ba648b4a 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -1775,6 +1775,7 @@ static void svc_i3c_master_remove(struct platform_device *pdev)
>  {
>  	struct svc_i3c_master *master = platform_get_drvdata(pdev);
>
> +	cancel_work_sync(&master->hj_work);
>  	i3c_master_unregister(&master->base);
>
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> --
> 2.39.1.windows.1
>

