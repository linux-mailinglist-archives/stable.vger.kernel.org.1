Return-Path: <stable+bounces-124178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D149EA5E3A5
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 19:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5DC188B7AA
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 18:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3905E256C6A;
	Wed, 12 Mar 2025 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EfzNzMWP"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DCC250BFC;
	Wed, 12 Mar 2025 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804162; cv=fail; b=nictC74wsBagoZoQSiZ1RzOdCDnqqZuIOCeHsoqxqdMSLERebvSxphrNuSi1/+lakwpik1ogxUXnPK2g0hlC0nkN2OwpZdkkmfFSM6os9eKIQ3kxHqvID6vDGjgO85PPvKZH07zlLhLoCPGJ3h0YaR2zikkhYI9S3QhECE1/dTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804162; c=relaxed/simple;
	bh=udQvGGUq0FkIxFlZ6Czvr4zDUoN4eNsw9J5uwIIg9ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l4KYAci1G1mnHdYkVx8AqGQY6AKQjLf9SHtvfYwZljgan32FnjX6AQqIB8QwncRv3j2Y/9sw6KxtFyQDllSYScFXq4uHQLT7CrSKmGneOw0MHJdUejI6x4KPkNi2J184XI8DAQAzbaeoUS4jea52P1NTLv3TEw73O3CQwecuH+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EfzNzMWP; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7Ucl6gc9Hbg+I3V/viGyb5O70VwqiTJxOQmQLiWm7KrqgSG5P0exYtyeYvTeiJujp4hgqdU0WoglzVNftdMfhgGuhKrQidHHF0JAu51Dsw09TSXGg0QJgBVdc20V+w8kV+NNNJhr6jqbcZoopc8Uol16ZXkpieEoIkE/5UPHQ5/crCS5d3VOGmyuDRblx4U/1UO23URKf9FjonSPK/u2Isex0c3LZ3VnV3WPrfe2sBK1igsTp4Z7huHniinPAEeRWwJTkAAywHCh1lLsqECVYVCbnwg4GCrZFamS2uSYlfauFMM/QlUm+yb0M/QArjCLaEpz3V1YFyBX9uKjjkOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pc2fgNSvb2r79KaEsywvUJ/qIRsgl5bPLNkFFMLjbVA=;
 b=uzNer1Pb+n13IwJfxqF+eQ40HoHEsKpJlVCuMaVKVSrh8NJqsp6uLZ60lmP55Ydv4WHGTml35FpvoTlSzKA2aR4zSG2AGZGz3My/qO7TPOtaqCSVpqQ7SCVLrN/1dZKinMUUGw4L3FtlXrwBdZKjdWM1lWVp4SITOWXAQgYXKQxQBChJTjZ5bbOby/l1yf1mcJeV30IaebOYS62K9D6b/BCTx8d+ywUjKqL0S/CCKKp/JHUXd2+bQP6GZaBc/I0F+W+e8eNCyTbs0OFHldZLkMd/gfcNjeOMn5ql91G722SxuiYaT0noyfWVeGbnG2IlHTgekpE9NszG3m82BRS1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pc2fgNSvb2r79KaEsywvUJ/qIRsgl5bPLNkFFMLjbVA=;
 b=EfzNzMWPKDAqPitUzilO6BLpk6NvwlaYLsOSQZAsvRnEQqs7rWf4IeAnyft8ZpP6vrD7zqcLP1j2SlewDW9SBG19/XxDUSgnjVhbu2wpYYy34APkf2CcFDW94bNVi6dCaoUz12Spfrm8ZAPvO7+K93wMrBNCtqBbU3Dw+on6UEGxip/11ck4g7EeSZkVMlUXzKuUojFks67gWss32rg+DW1MET9HMSY1WYpJ5fWO1MMX0/iE84PHKWdn3MdL2KQkfR4WishFbWHy71C+ibutAc+HlFJlOKsPnMZpSoVkB5L+2N5RjYdhXzvfVwWHdQLor0Z9DDdCj7momPQsK531pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9579.eurprd04.prod.outlook.com (2603:10a6:10:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Wed, 12 Mar
 2025 18:29:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 18:29:16 +0000
Date: Wed, 12 Mar 2025 14:29:10 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc: miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
	alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	rvmanjumce@gmail.com
Subject: Re: [PATCH v4] svc-i3c-master: Fix read from unreadable memory at
 svc_i3c_master_ibi_work()
Message-ID: <Z9HSdtD1CkdCpGu9@lizhi-Precision-Tower-5810>
References: <20250312135356.2318667-1-manjunatha.venkatesh@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312135356.2318667-1-manjunatha.venkatesh@nxp.com>
X-ClientProxiedBy: SA0PR11CA0120.namprd11.prod.outlook.com
 (2603:10b6:806:d1::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9579:EE_
X-MS-Office365-Filtering-Correlation-Id: 91317b7d-b11a-467f-2eb0-08dd6193cbac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?89GTPipFRBBG1Hp2vh9Ys0k7dNmLEPZwl0CGMailTLLFUgSJ+Xindn4nZTn9?=
 =?us-ascii?Q?7RM7znsQyfYmGbrYjR83/lbksZu9Gwa6YzfbEqXQhu5g38YzZDA5A2+VHNop?=
 =?us-ascii?Q?Lr743rSYIyi2+J9qABHQwkf7M1ZmajXnfnmWC4vZDc0xRZCGGEbPUGwOm4vk?=
 =?us-ascii?Q?RNB1Q2nOWVzist1Op57bH/z/TLelfwFyMGlDBNR/oFY26SFCbiFDTNd3RXCx?=
 =?us-ascii?Q?NK1+kU23yrXeg02rXW29m+ySAs03nr4ip+cu/M0DDYORJBduIf3NQSrb0JGL?=
 =?us-ascii?Q?z8jCBy7Sf5pnnVMs0eT/CEh3g1dbqiMvIy9kJSnJ17b7v4jGooz3wXdDsrL1?=
 =?us-ascii?Q?t3Wbmb5hwQEpLYvACXU5QHMbZDh/DbSsuhd7kIgKhvRfs0VQsUMjxC4Cn4fY?=
 =?us-ascii?Q?0z+SNEIy1KGBkazwTTjbRxb1t7EWpfoNcfS3hfO4uYv6aTJnSrsdq0LCTV5g?=
 =?us-ascii?Q?kd7vkIJSdr76osnRJdrrrFYHyEv4E1lqSfC8dgeNlCuVNmZOahxntXzIU9Eg?=
 =?us-ascii?Q?adBLlfIW2WwaVnD3MdrlTOy/p5TMWarv5ol9xc9Q/wwW9eqy+M4OfVZIRXY7?=
 =?us-ascii?Q?23GTfQxaoJxBWd7MemWnx2Ut/Ox3y7O7gb+pOgXQNSNkRKGV8x+ZubediSmu?=
 =?us-ascii?Q?EvzVW+to6gA51BSLn4ryJynqhHFF2hZ8fPyVDNQGDQIxPm22VuqYR5ytfzPp?=
 =?us-ascii?Q?ln3T0oiPs7wa4PQPzcirgq2YfSQh5v5SWOj5aLZdTRt5O6Ph9h9vtc54laZb?=
 =?us-ascii?Q?OgXA9vg/WfB5NK2OIdcVRaTuSrwrf3jXUdAJnK2j4lGnLobXSQMYlg3rm96t?=
 =?us-ascii?Q?h+XjwbwEbyZKV+G7BAhJ2ZIvK3IRuJ7olXFFH85qLJqFuQ34mPRKoaPL+hMv?=
 =?us-ascii?Q?Ts9jlqruyH4DBlh9fa+H89KPmYw9Z38e2gA1WrnfbCXguJL+AYdk/JMHNzdv?=
 =?us-ascii?Q?UVtjiH9jSFB9nluW/j+4AwDfkn+VHvrAIMvNuoLgRgWqAO2SBgXusdM5HR2z?=
 =?us-ascii?Q?3E5drJtQYoCTwQsI3vuTdDhCN/5dvipq6RPYHwNG9ifNNa2vKynByj1DNqIK?=
 =?us-ascii?Q?El61kcDyn6OE6xpBDQJ57UVX9qAh0lKGgr+OUJ+VyHvNwXYDm2xm0jHYUrRE?=
 =?us-ascii?Q?hC78Oz8A0So+/1GsFrf3iYwRI+GgpTusNUqcPz2RgMAQaWW5gldQQJprlWZA?=
 =?us-ascii?Q?fsuTUESFYa0YU+CrQW42/eh6K+OuZ8V268lajy1p1NcHKsALg5QCOP0ptfvo?=
 =?us-ascii?Q?rvRRMNCA/bZ4CKi89MDLez36x6Wlcbt+AyfJL+QH3OugKWZzfdRzNnSASaJK?=
 =?us-ascii?Q?e9XnxlSlCMuG6CR5uN1MMVeKxFd6Hd6f7qMftzgp2ouU0KIBrVMFh9WY1GVs?=
 =?us-ascii?Q?xwOJuuMOMZ6BUFsCWRwxEFJW1bocmqQSg12Mm4M6OYm+1K/RpPEeORh3m/Si?=
 =?us-ascii?Q?nJlk77WEMti+DPLvtNXW16enSEQ9OQOj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WqMDQkVzf1M6Uopw9RXof8PpioCoavyH3isQz5C948KLopPkDtidIuOVTlE7?=
 =?us-ascii?Q?sHxcxx6FyLBavwZPF6/byH38LTHS95dzRDSkJPhZU6/bv5ytxm2VKf0kVrI+?=
 =?us-ascii?Q?HO+BFTbqjYUpmoIUuVNNF4JwlzmpOnLhnBCrrES3RnyLDz3WgEjDWszXXKVT?=
 =?us-ascii?Q?bHoBKI1ZDM3gDsZkzpOUvDGYazUKqitFM9YQUu5joCXnifyhFTE4AxgB25aZ?=
 =?us-ascii?Q?FlI4A8FGD3Q7w5126sYpZw6xo4tOZq+n2QL22ouNCa3bhLFUdA1G5bvVRpmQ?=
 =?us-ascii?Q?MjyV/jjeBo8iajx+y5yWVzlaY5kCR1a8YsAMvResi7rZdmcLI/OLdNi1JT54?=
 =?us-ascii?Q?JatRXoPY9tAvpCrbYoI2JibK9MjP4u1GwE5suKccTgmpf8tyW1dIHtPXdcNg?=
 =?us-ascii?Q?bat18mnhDTzM6TojcECFU3PXDIfLrnqiHB6aNQXLrpv3mzKaIPFeV3YlRW/x?=
 =?us-ascii?Q?oqdQNcoP+lFKOsabDeHRPixX8jy7n+7KAsaAZKdKlRY2X4oJaeqxnYUvcb1l?=
 =?us-ascii?Q?H6tz8VsoWVRClSfL8Vz8mwYPr9LStDH9obp6RRqk3xlwbTgbZfh5GAKz9NZu?=
 =?us-ascii?Q?18ig4QxByRYTtUELD+r8xWXqEVX/ik+OWnCnXywlLiNTdbq7c5qeSTO83SxK?=
 =?us-ascii?Q?19CypIAb6zDwA3QzQgPXt13E9w7zIuLEbFS6PFYsF9Z4cwJ/5eQwxV1cQ6Q/?=
 =?us-ascii?Q?zCOlO+4YrpPRMq1J4gVa8vS2mA0rp3KqOz00C5uBj6o7iulem5Xefq/PEuyQ?=
 =?us-ascii?Q?jqbcYqQ/HVL4hGg+ZbCRm1JVLSlp6neacyHreQJaCF30HrsUmaiWpLrBfGGx?=
 =?us-ascii?Q?qsa5bRHc0VEde1obahCr4mK1XrtMR8bEQGMNtRwThK52KnPWDkZaxvvaIq5U?=
 =?us-ascii?Q?YtpJubleUmYx2CfuOsg1g7Gw1XeNWHwHws1wLcd6zMHN+v762XL9tgBggn0v?=
 =?us-ascii?Q?Q8XaNMhKGwQiCcn928zkPtavBZnjrI4JQopDKLPBasqf0VxKGhehySebrQN2?=
 =?us-ascii?Q?d4IxQrbhx+kIwPEM+ZutUR8JDU6ABJThSjiHNOjugG0fTTmpeiboFphXK+q2?=
 =?us-ascii?Q?Z7ztzjJZVlUbNrdj5ADQDdPDCWiU/IgkCiMRhtkD3bF2/kKQfNJVdPa+om3I?=
 =?us-ascii?Q?ehGtutZs5ozk13So413g6E7MoO38ofPwimG962J1G0W0P548qjX5fIHRuZff?=
 =?us-ascii?Q?j5kLigFUuyPLl4MZ9FJ35oaBkmULvm3N/b/Lk+e5wEL4aJNQH2b2obYlAp18?=
 =?us-ascii?Q?p5rcMgsFp+aNECwltkDayDk82rv4Ofj3JoVYwxxeaGAhsmlJF6p8MytM9Xla?=
 =?us-ascii?Q?fD9TZssVhY+8uptf1YShEboJgXWP9s/y9mdkWG+pd1dX8O63o6KwBztDSq2X?=
 =?us-ascii?Q?h43tNSJuY6EUHUJeMb0nzYyPsb5ujWd+n0ivvmmiHii++Pm9YJEgJtDoK1mp?=
 =?us-ascii?Q?01y05Sl15327wgW112IvBZIPc3MLFqaEsnzjElWJdRp2iMJFDoVqLXK4OH3W?=
 =?us-ascii?Q?tT51kKJp6nTBk1PEnlo5gaSiwwYxVcvmiCUsS97NlsMx2dAGmfqFz3r0dZbw?=
 =?us-ascii?Q?rqLYbiV+jfIShGeh3L5/CkO5BBNnnCcPcDtv7If2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91317b7d-b11a-467f-2eb0-08dd6193cbac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 18:29:16.3954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyUWoutviFUPdTSTSqvugCJAZc3Toa5AI4BPmbyG9gyilrS7drqFShntFtvrBtXgvSZMHjqR34fqsrFqFYZQiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9579

On Wed, Mar 12, 2025 at 07:23:56PM +0530, Manjunatha Venkatesh wrote:
> As part of I3C driver probing sequence for particular device instance,
> While adding to queue it is trying to access ibi variable of dev which is
> not yet initialized causing "Unable to handle kernel read from unreadable
> memory" resulting in kernel panic.
>
> Below is the sequence where this issue happened.
> 1. During boot up sequence IBI is received at host  from the slave device
>    before requesting for IBI, Usually will request IBI by calling
>    i3c_device_request_ibi() during probe of slave driver.
> 2. Since master code trying to access IBI Variable for the particular
>    device instance before actually it initialized by slave driver,
>    due to this randomly accessing the address and causing kernel panic.
> 3. i3c_device_request_ibi() function invoked by the slave driver where
>    dev->ibi = ibi; assigned as part of function call
>    i3c_dev_request_ibi_locked().
> 4. But when IBI request sent by slave device, master code  trying to access
>    this variable before its initialized due to this race condition
>    situation kernel panic happened.
>
> Fixes: dd3c52846d595 ("i3c: master: svc: Add Silvaco I3C master driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> ---
> Changes since v3:
>   - Description  updated typo "Fixes:"
>
>  drivers/i3c/master/svc-i3c-master.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index d6057d8c7dec..98c4d2e5cd8d 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -534,8 +534,11 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
>  	switch (ibitype) {
>  	case SVC_I3C_MSTATUS_IBITYPE_IBI:
>  		if (dev) {
> -			i3c_master_queue_ibi(dev, master->ibi.tbq_slot);
> -			master->ibi.tbq_slot = NULL;
> +			data = i3c_dev_get_master_data(dev);
> +			if (master->ibi.slots[data->ibi]) {
> +				i3c_master_queue_ibi(dev, master->ibi.tbq_slot);
> +				master->ibi.tbq_slot = NULL;
> +			}

You still not reply previous discussion:

https://lore.kernel.org/linux-i3c/Z8sOKZSjHeeP2mY5@lizhi-Precision-Tower-5810/T/#mfd02d6ddca0a4b57bc823dcbfa7571c564800417

This is not issue only at svc driver, which should be common problem for
other master controller drivers

Frank

>  		}
>  		svc_i3c_master_emit_stop(master);
>  		break;
> --
> 2.46.1
>

