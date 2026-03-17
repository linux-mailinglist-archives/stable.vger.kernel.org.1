Return-Path: <stable+bounces-226104-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKG/MCh0uWm8EgIAu9opvQ
	(envelope-from <stable+bounces-226104-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:32:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBC52AD185
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED9EC30862F9
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CFF7E0E4;
	Tue, 17 Mar 2026 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="CCsKlxuV"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25ED33EC
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761422; cv=fail; b=r9Lh4QyhMAKIYUt9y9tnXON8pIYRkanILcno0ditcnbxDVAKwnZL/cUiEmwoh91x7TllsRZoj3Meb7YH3JK/WrSjSI0Uz7zWoeYDfcuCGrMaO4cRqaC/r1y8c+rXc0TAQZYIqKonaEtsm9OA3PBrAfT4U0vbi7HGvcPEBcCkrnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761422; c=relaxed/simple;
	bh=UlWc9H72/7FHCeRQl7a964VfHVhxnAKvkK53m3YIHlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AenO7UTs5zT4E8f30DYpDMYyUa03F9+eFCHJ6rdu+zdIy8DhX5ag8WP9pVTSptz6Q9E9OscdVuqYo0pFqkcqsBFqIORQOu0aGQ7mlvGzGT8WdicbeDJ7aE9K9qOG2yPJt8YFcCZuu49RlDfwW90qYudmpCsJza24UjGbrsHvQJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=CCsKlxuV; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GMPkSU2244769;
	Tue, 17 Mar 2026 15:20:02 GMT
Received: from os0p286cu011.outbound.protection.outlook.com (mail-japanwestazon11010035.outbound.protection.outlook.com [52.101.228.35])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4cw11gt9mu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 15:20:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDrP8fwNVNtxNmLcRsGBCu9lY3DWh4T4CkwUP9yfzvyJ5s4sNsAs4TOomNUdwdU7xa6nQirxNuPrq6/UeYgxcJDbM3VVT9qTPbdE9clzGBbLXa0/lMbhXJnNsaI/xlgmDGY+oYrzoIfcdKqxkoQQMt6VwETypwBvEzVs3e5psxOKw85zCFY77YSoegOef5bsTJOwHNxGNmY4oRO3Q/I/1cluIWoDci5Z3813gpDzbNd1G++p7EnDapK09xJBvSg/TokD8NluSyLkkIqPQ98+kh5oxxUwiZWbd/CBg+XHHfWc6bNqXbHGzA06roePyLSq0Mxf5INMDHZlcX0zi0hJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tZq9v72JS7mgyE2i4phNd9dCAEp9Tp2cX3X7U5bFx8=;
 b=yYNR9xNDIN6lBI2dAuG3wwoCQeAYcmj3dVm0+Qi/rkoxjYv0dtbBPgpjIc2f6bD7p1+prhqh7uDykG9DZ0fub1Jp1thqHh3+wCnQVMn7H2EYAvQ2CCUT08+cSFqU79aZ4rdY0wFBZ8G3RU2tVYA2d9zyj5puoqH7aMrBBHrFuCwCwjFINpCENYku47cTyJ+/krwsQmCNYlKPwbdB1NSwvccgcGkNkoI7gZ/p70XBcA0yKrjdSltq71wgc9SB3JSiSNGpvk1ZzC9B97aash+Ky3cq1UippkVJ9QgPcVebFkEQqSXUBCjFGl+5Ecr2haSIaZ3FiXzJRXspFZyufZHQGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tZq9v72JS7mgyE2i4phNd9dCAEp9Tp2cX3X7U5bFx8=;
 b=CCsKlxuVp75SRR5SeP2cyGwoVkEwlAIuUpyLsV4uOgHuhwPMMuqQdPYxVLZSp6qc7P10XIi8NnMYLU9oUTwRlsMQZn59ip8El5e9mNE/Cw+dZO8rhgZzzbUog/eRdtVYcJhJlEmUwVGsdd44tuHRhRBragDYlxw07pAXIG6g7fPwu+9QWb0ZeXVqF/Hg3EXbMEHFe9fzZZZsM6Iz08sDsPT8LzAKpBKRnJzHHs7iBES7y8ZH9/+EMDrN6yt3nedZ7tVbQh2q+6eDGYV696NnKutl325xjQAlGnwH92Sw7+5QRkMsVTl2mGCojzWZn56bbv2uxJGPiu5Yc1XN1mJmAg==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYWP286MB3548.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 15:19:58 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7f13:e26e:3d72:9ab1]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7f13:e26e:3d72:9ab1%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 15:19:57 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.6.y] iio: imu: inv_icm42600: fix odr switch when turning buffer off
Date: Tue, 17 Mar 2026 15:19:40 +0000
Message-Id: <20260317151940.343916-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2026031710-candle-hypnotism-fa31@gregkh>
References: <2026031710-candle-hypnotism-fa31@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0331.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39a::15) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYWP286MB3548:EE_
X-MS-Office365-Filtering-Correlation-Id: f29c35a5-6f72-4d89-0fce-08de8438a627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|19092799006|366016|3613699012|38350700014|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	4uD+cp581gBe/DyDRlguIx15W/Ol8te6NeGURwNxTkS54G04S11DIz5VQ7sUZeonb7SQy3CfpRWx/vNBW23oYgHx8zUreSYiXLaTXKZL39E3c0fDQmCPCzBLKUBaOVSvoj6kecXhVH+uecxyH0d/ros8QMNdLMVVq4t9vnKLBtBMO42HiUWxl30K3XSsWcddereT4TAYpRpN0zzfibWc5I7pyjFGziwgqUps99BZUiv2ZGbNzb/pFjMpK2h1IL8qvKJC5T0vC9xK3QEKiQAyivnpOt3F1/i3YhhQBq6BlkWqVptMOLD45FhOGu+3+RSHFMqLexUmzI/c1/aQIfJDKj3sJfoHQFIrF4biSS7nlmN2WvfLKaNGzWVDpW2WcSJWq1+mok4Ol6iLYIIczRDzflbkqH6k85H3LxDlo3wDRgtC2Ai7nfxMDfHj5eTQWftbbiNcJfttRvAYob5977t4VLa5MsvDfHjtkk6Z+PuvQ2NnRw3zJZbEAsbSNqh9c/LkjZIO7SSivZ3VoZb/n46ChBtSR64UfC7+YaNK2fiHOQSFRRF//nOlZHzPvmSsU4SlWxvKcsj2Y8QAOADudb9q4JPbw5tO7JM+bcTNhzBu5Pv+pShqzUOFBq8i4QGv7pxpY8OAriX6uoR5VjK2zuIAfmk0/c3Q4dDz3b9dbsYdXqueZQycepYpzZW6CD2K5SW1UYxG2wGeSoKtORwGqgXzgGT3Zb91LNGfagLGxHqnsRKZNJKjWvpTZ1Y+Ckas27phKdp1vL9M/huE/FsXzTHoJaTGIIFz2FcNnODQixX59LMTi35s8PBVPKvQQD1XOCtt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(19092799006)(366016)(3613699012)(38350700014)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gXQjToeCstGEwNwbvwx5BAWxbet/UlRpGlpQnsr1wJjAQq2kvyjIo9PHZ2eG?=
 =?us-ascii?Q?QrA5mkRsu7n3FVet5EjosUO38whrH+ZXhT7UHl15xN8HozrZIaNPFVX/kmq3?=
 =?us-ascii?Q?p/90Xc2uSD44NWJPNCzBIQTKWkkcnp7OtQ3lJmwFW6NOp/3s/4K0soh3XBjc?=
 =?us-ascii?Q?mry2Z3U5G0SiY/rs3UaQmXibh0YWXgKYKoWtPsdwpRZgDLajqMwJ2H5X+b1Q?=
 =?us-ascii?Q?Bonwty7cOvmlSafGuXfj5e+f2GJlCUREciXJ8YJzECATIJiyWhXju9YzS3ES?=
 =?us-ascii?Q?XiNXqwBkcRgnXI/RpPBUSR+Y8JsNqrF1pWEqPMYwo9/wrHfNgRBWJjnZxw3l?=
 =?us-ascii?Q?NVuMKhvYUYBNX6T23IOKxbNGjCR/ZPazLhcO8bvUhIunbS93+Z/k0mGirCIy?=
 =?us-ascii?Q?5MS2alLZxjDIp0O3by0MTbQyEhENMkXztYic5bnWVIQrfRJbh53lkr52j5hZ?=
 =?us-ascii?Q?4aeFphKpZ7QyZwNpCzMQpJb5qS7mw1LyotkAWSrvspShH4rtXRgUXbptFcaG?=
 =?us-ascii?Q?/v/EtN3j7XsC/z5RKA4C+wLZk25HQyixe+ylPRStpP+pydT8nOPCL4BQTaMu?=
 =?us-ascii?Q?lcsf/jZzoD/onR379oSVObUtZjILd5UNPV1tGTzgYVEtRRrdawjqqnRWF+Y1?=
 =?us-ascii?Q?uFP+hROakYEbxzugyX1pTwP7N6mizjgmYNanqjtEovTUHVtAEwd1B3YruPGL?=
 =?us-ascii?Q?7kG09TDK3NML1Z+2Hc1bb8iOIDi1u6Hwd+GqqwQNSUNdlm1cjGcGFqUZR4Tm?=
 =?us-ascii?Q?4gT4CwNy8vWYDvF6U+3UCsIpobaoOYcv14NEcfp23e+7EbR15pyoBJlb0Sm8?=
 =?us-ascii?Q?azvQCeVfPIoIfz2TYPVIixMSok1WAxonjMQsh1Nb+MUUt98J5H/+hOACK7pP?=
 =?us-ascii?Q?4qz+8pSNs0sqAiLpaXRQf6DSRDGOBGXztTITVChTg6BvWm6LCWrNimTuJq+i?=
 =?us-ascii?Q?Beml2KJnprPidB1cUwR/kCiBnXWXisnzDNT+f10Y+q+6+WOQw4jSoIcmNCCm?=
 =?us-ascii?Q?vwvEq7HUwD2z+GMXL51cZ05eXfb4wgWRHBY9kjX/Z7bOkd9bUBMohSVuoS/9?=
 =?us-ascii?Q?fElGt7gWSA9Z1WyXGW/HIl4UnmcNIunT8F8nSiMWV/NZ2K29nL5HZNmj2LmU?=
 =?us-ascii?Q?JtiDEoA0rd6UQA2ZNvKMUgmBcDVgUV5Xd7ddw8b0RIv8bBcuNhBtMVlajd+B?=
 =?us-ascii?Q?c/jaK6irM/JSzKwkSoqQVDqd0oJWyboTdMFKi3mpK/79NQ8vufTSbClZRksR?=
 =?us-ascii?Q?VEM+TwdcP97CHKiPdoh6UvLY0VCbuOBeV8KfZJOiqlrp0/Wmn3Q0Y+94ejYK?=
 =?us-ascii?Q?4BRJE1BRDsVj0iZf4ur1WA800ewtGhrrfbEzYbjo7pWoE6DbiNJZnZlU2WrP?=
 =?us-ascii?Q?voaP2S1IhRJMCQZLi4HdJM98IGn+TNc16Kp5S0mrHtYbAWNW7jmHhEmIsd6g?=
 =?us-ascii?Q?OFlgMqzcfbakrSOUJw5IWhfUcz6xivcGu+WsEJTdrTCxn2819SWy0NWyJl5e?=
 =?us-ascii?Q?e6WK2kHW4UIq4Ee74wI9HnwSwE704Q7o9Szv1WAlsCnLS/rFJXdeps87iA3l?=
 =?us-ascii?Q?yAoVD6/UOXR2MIRcQx3Pn8IVXIztVbDl6F8Hije5iqO7Cy0+OyEl/Qsyd1qv?=
 =?us-ascii?Q?D4VDyGJtbJjwCJY/P+k+vMkwxsnwTSx1uC7XZz9tt+OKbAyfumGT1Q3PUqfN?=
 =?us-ascii?Q?skbghUh1lULiTKOuqResS2kznwfCD7G7sVy4mE9IJvPBQeH7GErHTgiwmdHX?=
 =?us-ascii?Q?0ZylusPtkg=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	BtXYS6RXaoboP/Xv28QIBVZMuYEuR7c1XWb9F5XAMjiLQkEed20fNmp36l190rb0A2kayD6omsb2IdimNjUbJhR0pzguWbft5PaGKkDvN+G10x0aAMHdv0NHVSQuQRQ2fUEX7A3k63SlY5o/9yDysA6Ni+8xlI2XnnzNQESrMaf/mU/CQFQWpGnIR7PzcF81UZ4EhnR36DiyvJCtHoNlBuMb8Bv/bdytmsHIBabQpCWfTy1mzBnkiPDb0JwnHVKc3Pb4/gsaCtpA8Rzq2IQGQtnUk2e4TAKjONDnr8P70DcadMYWIRt9qg+WUt9wjbpNLD6TbI/1PwXLMkxBR2h5OA==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29c35a5-6f72-4d89-0fce-08de8438a627
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 15:19:57.5714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9IeGiflhh5HVtaRmvhWC9jGWEyFV1/JofCNxbPOXibzmG42Wp7S8NaFolgmsfYVlONzzyEmkfwrKTyjEFxRCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3548
X-Authority-Analysis: v=2.4 cv=AIx+R2tb c=1 sm=1 tr=0 ts=69b97122 cx=c_pps
 a=d1+uMV69xEGOqD/Mz7G4YA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=Uwzcpa5oeQwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=W6z64dnQKVPvYeLC5f8l:22 a=NpUDEC63da1vOGE9rZHW:22
 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=dmF26TSAndsNLafa5AIA:9
 a=EFfWL0t1EGez1ldKSZgj:22
X-Proofpoint-GUID: 95K-mJCDCI45EZp40ALckbIuK5lL5gd4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEzNCBTYWx0ZWRfX02ekEJTv/0ES
 4Lld6fD2Zh97wzFx57lu3kCNR971s5z1snh+a3mo/xyFplWJdkFyRmeh/Oiaqv2r4g8WMKFttiT
 eiGbYOeSOnhRF9X2bEWod2G2PTabsvOnRUlToXcKKCyAgefD0Hc+azQbsNxe/vzSb9w9QEPBj3z
 YM1AiF9VEiSCzlcYe22phMX+FCmg5kFYi9sLVgiQrUj3BDImy6YTD/Z9QA87bQjDvCAoqki3YDG
 KG5uA8XoSXYT3mGaW/4RUvyF4X+NyaNseFpOOuiGcQOOa9J2Laqqq28FIYtQHF+aJlJYvMFHCVY
 C07h942RgF/qWpO0bwpoCsokKBshjaPnNcfMD667SXbxeUIRpI+dqfU8Rk752VoT2jhz/5C3jCi
 yVAS0xqcI2D2Uqk0iNOMFnoyBPtjphmQltvq46PYF7bDvsYCrpC8w0db6BpZBE7lZ91qGoZYGCJ
 aXaQ1TWRsaFp42YCBtA==
X-Proofpoint-ORIG-GUID: 95K-mJCDCI45EZp40ALckbIuK5lL5gd4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_02,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170134
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tdk.com,quarantine];
	R_DKIM_ALLOW(-0.20)[tdk.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226104-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[tdk.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,tdk.com:dkim,tdk.com:email,tdk.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inv.git-commit@tdk.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5CBC52AD185
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

ODR switch is done in 2 steps when FIFO is on : change the ODR register
value and acknowledge change when reading the FIFO ODR change flag.
When we are switching odr and turning buffer off just afterward, we are
losing the FIFO ODR change flag and ODR switch is blocked.

Fix the issue by force applying any waiting ODR change when turning
buffer off.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index aca6ce758890..743580ea5845 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -378,6 +378,7 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
 static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int sensor;
 	unsigned int *watermark;
@@ -399,6 +400,8 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 
 	mutex_lock(&st->lock);
 
+	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
+
 	ret = inv_icm42600_buffer_set_fifo_en(st, st->fifo.en & ~sensor);
 	if (ret)
 		goto out_unlock;
-- 
2.25.1


