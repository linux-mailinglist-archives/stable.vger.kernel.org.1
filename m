Return-Path: <stable+bounces-119392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20E0A4283D
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 17:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3816E1749A7
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4E42638AC;
	Mon, 24 Feb 2025 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DcvZZzys"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53962561DD;
	Mon, 24 Feb 2025 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415676; cv=fail; b=nXY6UC8SgSTaPf45apSDtJwyeMt2GZPFrZqvZCnppJmKNs3CiIAeUPuBJgmFETWgidpRAKY7vkeL+Gqg9QcgR15OgBI0+cNF37zWOAf8ZdlOkkolcmtfmwR24rRKvJZxlUI5TsVlpuatdBb7R1sCowG8vbkKvbpe627KNg334Do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415676; c=relaxed/simple;
	bh=PWBQ8bW3lu9wzBCgwi4xQ/CqRtIycz9gM10ped7QmTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r7oFOguB7IbSX1ubP6/qqee0xB/d9kscx6g3b39lgrF4bRQZ656esFAlRF0uyZe12MJwENHmH4rY6gA6/4sOFUaqNzBJD/RXJ+TU9LtAqwLfqkPCOIv15lnIjwYBrdgkzm4U+0GzZAv519FlSs1IJmKDPEsbb8LG/iFtpGPUUIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DcvZZzys; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUSHH6p832+ge5sgMXtO/XuLiGvaAcgn6X2ffHkUGArTttcqrXG4DIE4FM1lzNNpWX92SsY6HSUafjq76Vr7sy3RzLbb32exe3updLVg4MnrIcthArfHqS+ZkVZHr1MoWKH90yML+c6pASwu/fpmanXlKrDzYP2/HJIP3YDHjsOxHBWc/I7lPONIke5XVAP+aCCk5R+YByYVzmy5DND40Kte8uPkzQQSGLliVfaUYCFR9WR/NmabaftIobVQYtPUK3dl/gFeR+IMzEkKhX0yohBpJQHHHIow3MQOGwMsRt70LdWxGQCY2X0Kir1k3qZrOEp3T07hMZi9HB/JR9HEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NduYw1JCUe80hkzXbUZp8QvBLVlyiBW0+xJvQCqOfVU=;
 b=WpsO3CvrAitSwkJ+VGkwPXqkJHJ8sdq6oOEcXlQKPf1XpzpLqRHKHC5S2maaLw03LxY1sBIYLOUgIoM/D1xnTTqjHsflFMDF4b5MbIo0XRJKF0RqpriStLPm6rn0nIiOJFtDPgJulUhM2PiXIppbmBT6peKn6MGrYWZ28VKVUgQIR4i1sRnlrdRRAvqvagKBDgVxJGaaqj69klAq01vvtUrq2QFn35PN7hKo4Berc9E/UOFwvBtfGgRLTXNW9e10dozW541palbP7iKIAxxJOTqzHcDVT4CKFccEeFB//e4WM1zSnLle+LJDnBpx/jgbhLZeg4xacxVvfdb+V1cBrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NduYw1JCUe80hkzXbUZp8QvBLVlyiBW0+xJvQCqOfVU=;
 b=DcvZZzyszYvG9JGGFm4EfzUpGNQhhlks7lpU0pkU3byfNpCm0RPSwTCIVGKnKoghwPyTHseUD6LxmudkNwqDNVj2XQ2MAvIoeawz7Oa+ZPC+K7MCiZ0MNM/SUX4tcA9RNiqi7FtccWGy+Acjgm4DsHXBmRB4Uv2IcGthmCS2yLy6WJ/MZc870+q/RlbehVOGWaCL1OzjEce/Vmh1LbZkUsZViSe5qwNg/vH3ePzdnctNx7B+UoCwsT2uW62wZKRvYL248VepU2+o+adK1ui5VMK1XI9+kFtGT6E1klTSbQS5Wfi1+Jop7GIdvu4UR0nq3Xy96hKD/aSyC8MiGz+69Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 16:47:51 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 16:47:51 +0000
Date: Mon, 24 Feb 2025 18:47:48 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ioana.ciornei@nxp.com, yangbo.lu@nxp.com,
	michal.swiatkowski@linux.intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 net 8/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_tso_buffs()
Message-ID: <20250224164748.6qnuf7c7gpc6fq4d@skbuf>
References: <20250224111251.1061098-1-wei.fang@nxp.com>
 <20250224111251.1061098-1-wei.fang@nxp.com>
 <20250224111251.1061098-9-wei.fang@nxp.com>
 <20250224111251.1061098-9-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224111251.1061098-9-wei.fang@nxp.com>
 <20250224111251.1061098-9-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR02CA0046.eurprd02.prod.outlook.com
 (2603:10a6:802:14::17) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 7705e455-1c91-4b96-7c27-08dd54f2fa4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fL2CeO/gxuhKv6zE+bD2DirYz404zz5Dskmc+x4cbDEHVZAIZ6bZbZO56J2s?=
 =?us-ascii?Q?QQ8HyuAu1WAowJQrvz6VQDVgMW3daCTnz8viAYdopDx1cu2lUAOxo7IxM4F7?=
 =?us-ascii?Q?WN6tgpQz/KUVX4fa7VPw54Iy82OQEc86rHpMXFpunKlgPfewk7e8Q/MqNFO9?=
 =?us-ascii?Q?x3X7Y2yjLMJbPWZbVNJ3o5DVpiXHO5bKadRptkLINUk91CFDeN7N6kIr+D2T?=
 =?us-ascii?Q?H9b8aN8mOqLzrxRH9a1cDCFPpojs8/M9BtAvMups0/t1FZebeJELo39Bpa+o?=
 =?us-ascii?Q?rbMgqLC9mQFoxr5VEFaBkzCmslQMzL9pbLHEzoK2uAHFD/XPVzHSHR43LOxJ?=
 =?us-ascii?Q?uF8SuoYx5y7nJbZNd/r2Nd4SU3Ob3SduwyMYe7H84Vmtq3BqG07c0jcpdhUy?=
 =?us-ascii?Q?ggK47V/HhMGSWLahnz+x1zBHP+EDxWf4e3QRdNIu5E4mNL2DxE4SF4opGF1x?=
 =?us-ascii?Q?4IIQeFIXsa9ABwvWT/pBh4ArWuNsH/hYdNYYdr7rf4qWsThvxahRmSoNsk50?=
 =?us-ascii?Q?U0Hv3ys4sNRPckG2i//iknlO+OYvu756/+Y/YBEG7MbRUhtwxsY6j4rLV499?=
 =?us-ascii?Q?qDwNDkKu4KnbUsKPmJH2rbwYldVTAKB60HMtass048ZHfv1sKm6PuQnbodYj?=
 =?us-ascii?Q?EhAxy7fEpxAW8em8KjMeq2b0pr11jG6dCfo6+XZOkQkVJEdWVFAJdRmTfEgA?=
 =?us-ascii?Q?5/tpIu1mpVkaOcDCHoXRuyHzrP9NALH39t0ebv0XO6L6m157AaOWc78PhC0L?=
 =?us-ascii?Q?kj6r4dp3a2rjsUX77udaaMIjQzckV0j3Iy+0PsNuTz4d8cg55xWfSek7DUwm?=
 =?us-ascii?Q?2QvjhBhhd7EVhz7llfJZLvG7bi6VPpQA5SGhpsIda+njmUp8V1cATsCJg2qn?=
 =?us-ascii?Q?0zNBuhdaEli4jXiFH4+WDH9+C8DG0UkWciUmN4tGAAdECMRrvW/sUSKUVB3j?=
 =?us-ascii?Q?3XPbMpaeuKcSFP3t04LbRrSn84K+6c8vrA+RrktdZ4k/eXHlsgdP3ho99SJa?=
 =?us-ascii?Q?btEZkPXzrL2wJKsDXJnhZDZXWCW9T9Tec0JYqV/nnQCURmgyY8i+Ot2wuuE1?=
 =?us-ascii?Q?a+H3vkghoyL7hVXkbP5hoy6HbpAUT5hi6wSF8R1friJtS4NcDeDn6l1siv6o?=
 =?us-ascii?Q?KVd/A/f9llakHDd6Ce4euDTFdHSru//CAF+5btJBI9V6nEDT0hB/pCumrd+p?=
 =?us-ascii?Q?CY+Wz6h+nEAjxMVnuP9GQj3QP3u/pEGb35ZTMlXXbwP3j86Ho6LzTJOv1QSc?=
 =?us-ascii?Q?Kap/ai53NyrKAQJidSif3rOnkg+HrByTK1vSVPBjKG30ioLOEd0DZ24EFSF8?=
 =?us-ascii?Q?BxnqM/PTOGqeb7BRRKN20MBylmaG2+SM/b1m2FnDib2WhQvnOUON+sTTtFB8?=
 =?us-ascii?Q?ZSaPMpHQf4HddQYY4fJYblN7nHPo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a665vYSSoSKUP9muguTfMhMg7YKeMgluvdYgLMKpOB+oCbKNnOfyhRrBoz4P?=
 =?us-ascii?Q?H/LpgFxGtOKjyckNsUTbNiKHSu5Nax19npVvfhv5ptr3a4jZr8FWD9N95JjY?=
 =?us-ascii?Q?XnDYiaA8mJg6ky/vMf+j8m6VZAJA6+91Nmyxz2LKPC422T47tuTnToHYEo+V?=
 =?us-ascii?Q?FZ8HBPONQz6EVPN+IgqiYfwkca18eewUWV3uBan06oo+wEOpYrBpZraqp021?=
 =?us-ascii?Q?JalVQynA+lEGNcW3K3kMGisahEFEBYzyKJtTODZAr9kp9U2COCFsE7LkOg5Z?=
 =?us-ascii?Q?u6mj1zBK2NpSw4699XjrVa8v12e1jL83CN3smtC0P7JKTHsRmByiDn7M6lem?=
 =?us-ascii?Q?zS2FamGvQ7rpYb9Z2aTCiCV8hW/tpHdmqVWR18ZFr3dnvjNxhhxAXlzUSthG?=
 =?us-ascii?Q?s4mfvNFalcJVN7YQAxTrrhFisdvFz7U+Y6X7Rd8kzg0+hvnZGpSFwciyr29F?=
 =?us-ascii?Q?jFmgPU4DtDnRr1ft7ZaWF6uOKN3NLN+M9+r/G4UFgdDs9bF1I6r0ndwLONOp?=
 =?us-ascii?Q?Wv7UX9pkl+hlz1QHBbfkWIGEyFpIPJCa4jgaUTi4egUqqJ3vsSIZqXLWxggd?=
 =?us-ascii?Q?adi1c6nBTHTEC3bwgchkxKw/1yKZoDW+CZk2OhkyfbfhxyRYSoq/u/+Q2Ndy?=
 =?us-ascii?Q?RwU7eqJpgLC0O3BdOZ0dbA5UFFiGzfIH5ZFq8YCUGKDaMLYXyJbuFOS26vSf?=
 =?us-ascii?Q?ljViE/TjUtdWhYc9kF5PsDrNJE+dWPvQCuPMlcgbAhOQyfBsASlV6fOrBS8h?=
 =?us-ascii?Q?ToynauRNmC/uP7D1+GnMMuE7h5Z1TcuS1hHEQNAPqdQx/u0QcRC7eN1bMjmr?=
 =?us-ascii?Q?vVm0u2jP9cohMJKbi1WP+5w/tR/UeyeY+9gakjM2JRqcR0nH+JElqqnY55BI?=
 =?us-ascii?Q?ESMnctHhFAp2y/SI3GMX84awD9DAiHQXta4l3xkKo0tr5l4KkJum2bWR4Kdv?=
 =?us-ascii?Q?WnZ4KiwPgVgqvbU2LyjM2m8tMLxWiQWL34qhxKAuH9cemUcHhKnJu0JNvFIE?=
 =?us-ascii?Q?zDAQ2G88pRo3GmUEbrRREN3W+GnMIEXAIZeW98EEkzQsvGyRh9RerKlkTvvK?=
 =?us-ascii?Q?sS0qAcK0W5N2mQigSsMsaCx5YESZyk8JPsZtjKUWyyTmd8Q6IKi3Ld96GqDd?=
 =?us-ascii?Q?YwGB9P9ta+/KJCx9apLrUJ87WkEmEx/hyRYC/ceajw9pQ9H62rtmFu/SL5DD?=
 =?us-ascii?Q?mCMByfl5Je/6NxM/P6cDkTIsYp0Pdgs4Cb1lzLpqk0cuXBmVEvaUQT3bviMw?=
 =?us-ascii?Q?7DEt+n7yP9Nwf24It54nawbhre6j77aSg9sixlTGV9Bv3/edoQBQmbf9xXAt?=
 =?us-ascii?Q?Agu4EdIxZdQdaQUPPQSPY/DQtvlKEPHf5bJL/BjWFO88RJdjIC5IH1pEb0uW?=
 =?us-ascii?Q?YQUUh4ZZOylN0hWo3n9aLHF6KtXsPb/uDdqUY3tl8bCn0bKprGXlDy6uSJyo?=
 =?us-ascii?Q?zNtWYlBMzTGypYRguAO8uvjpKeQUiykeRRTXqdt/KGpFa7eqHy4WCcglXhm0?=
 =?us-ascii?Q?plfvhsGjOYsjyWiqqlBxBq1c28bGAhkrUxrOHyyLNziah2hWv7+fVU9qAvY2?=
 =?us-ascii?Q?RKZ6IJv+NIfjB4YZL21nHiwog+OGnQh7/wZzLoQXyYI5hPUOAKBAsXxn+4v5?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7705e455-1c91-4b96-7c27-08dd54f2fa4e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 16:47:51.6063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDW8x1tBTvs6oaR7X6lSHhCJ9BPWAc4EYlcUZTz+OLytUa96ohCyzxs4C8itFHhaeUoI7tv5WQduHNpuJL51vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8957

On Mon, Feb 24, 2025 at 07:12:51PM +0800, Wei Fang wrote:
> There is an off-by-one issue for the err_chained_bd path, it will free
> one more tx_swbd than expected. But there is no such issue for the
> err_map_data path. To fix this off-by-one issue and make the two error
> handling consistent, the increment of 'i' and 'count' remain in sync
> and enetc_unwind_tx_frame() is called for error handling.
> 
> Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
> Cc: stable@vger.kernel.org
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

