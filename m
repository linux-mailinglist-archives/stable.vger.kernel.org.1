Return-Path: <stable+bounces-226115-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABr5NwZ6uWnQGQIAu9opvQ
	(envelope-from <stable+bounces-226115-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:57:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 442BF2AD668
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A3183064669
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055962DA75C;
	Tue, 17 Mar 2026 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="Ilga0CZc"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAE2261B70
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763047; cv=fail; b=RvcoDRv/3VOY7py4f5aidptANTUIOzpQrJ3oaYJbDFXz+KQGyrQWL49y9nm/6q83+mCKUnxtfM4LKKHADoqes2RddN66tpgQl984VE1oOtaM/ba2UEknqdOjZKVLZg60Z6Mg81xpDuOS94xx44fbW18CK7y++NqPydmAU4E6ucM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763047; c=relaxed/simple;
	bh=/dKlhWWVlzs++MYxtvZp29+tNZpDfIlplopKx4hiQCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WHYc2MJpcm4x0RGOuCw54FzxLvMzPB1hGwHQKCP/KYbcUVzYw7sKq/ykLvb3h3vC9+tJi77kYL+Ib1zhPc8c+0X6R11mIh14PpeIGjl8c9MhTC+V5Q8D3BZBZwjnRP90AE8zjwjzMc+PDEc4LkvK4fy3u6rYuPOjL1jQfX6k5jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=Ilga0CZc; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GMljeg2284393;
	Tue, 17 Mar 2026 15:57:20 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazon11011020.outbound.protection.outlook.com [52.101.125.20])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4cw11gta7q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 15:57:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgRMeVqJhPKao9ckaN1mrX5QXv/74ueJXEHI46Iwejtt6ifCSObu6DVz0X57VVJV9dn7FUtq229lqR93ctYxJDlxIan5M0GkEzfoheUGiblja4hYKrMV7FglYAD/vjAPdWfk43SQ5OkKp4q1/KIPMlgV4rAWmq01XVALJykOwOY48hbE4+p47Um41aBZottNLRsZBraXCAoPEGR8S+iPKYJ8GXKhNEtG30721zWUdzuJUbfpv63XfMdpU5K0Gr8FBof+jcD2UyX+GrhGM3dukxmApcxjVpnDZeMgCEnqHsl6TX6Y66JqjZrKELMw3oRRBGCa3k7mx26/5btB8yAFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZWDlUy2Fkr14K6OKUAN8t94m8cQOD+mInVhyohClsw=;
 b=BpP9XsnVT0sauZT1XO4tVKapB6rW+SqFLIiWIohwoV6Tl/gKjY0ICPIkynBC7hFkY421VAvdmHhC9v91VW16irApJv+Y1k+x4kWOucDWfWSYNZIHioK7FzkmHvKtgmamtx+0eXG8QGzBRwcMl0qVt68u5PT3iA7OWANgz0PJIDaNAR5z4ziZSAEew7UUHNg65omz6UjfpsHZCmuHzVgFw0rH8ZHiPa53LpLpXSjqZ+i7wIgL+n1nR06lNayHvP776fVQI4icHlHCV89U9j6fVp6drhF+coKVmdWAAKGeVZsTkEi3MhQSa44SmQ9bTlJJMIc33k75zqMMB2Cuuf4qtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZWDlUy2Fkr14K6OKUAN8t94m8cQOD+mInVhyohClsw=;
 b=Ilga0CZcPxtd39/3Xtpp1ECAmcuJSqg3Mhd9n3SCt610n0SGXV66iY4VuvJSMrIdM088uOuAKaUSVSbPgM/yPjuUpNRLpFR8n1W+2d+QMDDFNgEDNnDsDgVYYY0K088tVACA5OZ8j/bPLpQRSiAyMX0zC/wzHVAtbrAei1a7g50Y11qPyyogbbiWAvlOAmm8fSqcrQVOFNwTeVDjfAX7g5MehbTv5LAilnr6WfZF/cQA70VyJo6Nk12IMGIhbIBUyf3XCJZeefvxV/8vF+94EIyx28n2TBeSILFRemnM5EdAebsWbrg/AW4DP4VIBLgur0ts3Gny/MH1N54ys25oCg==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS3P286MB2507.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 15:57:13 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7f13:e26e:3d72:9ab1]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7f13:e26e:3d72:9ab1%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 15:57:13 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.10.y] iio: imu: inv_icm42600: fix odr switch when turning buffer off
Date: Tue, 17 Mar 2026 15:56:59 +0000
Message-Id: <20260317155659.744490-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2026031737-trophy-prison-d009@gregkh>
References: <2026031737-trophy-prison-d009@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0130.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::9) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS3P286MB2507:EE_
X-MS-Office365-Filtering-Correlation-Id: 131f58e7-4608-41e6-c8cb-08de843ddaa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|3613699012|38350700014|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FtXQYoD+SOf4OKi66uVrhn1JQsCKjTHdJzSx2v7IbaohqiRmad/Js8Q/0M51JlgFCFpphz06wm873/TLGbnh1FhLLJEkYPuYoVMj5CY06nMBLrsoc6Tc4mPj6kyAOQCfkkXpvy+qNj2R1eAr0xRw2xKKZuCupY02l2C2PD/ABqreweaxfTTRTr+xDuCIwDa5XLe5EK3oHLXVHys9UOw9PLbw0oT8Rtv3ttLHAOPizjKeXS+UrXTRtL0/DAayESGxB36LU4FZbPy1usyS+X5zwI/BmvRBzUhAITZwWM0nO7qwUDD0h2A0Fw+AMEYA2/qndD85rlgzHd6URSUjm1JfPHbJ1BtnSSlqLxkQQzaGcbkRTlXWhdoXoFvoKj/0nmLiF+ePEI2w8nQs5bUMLwUIvrR8WG4yNtJMP9NYMFPdX6IJxnIK3GNRc4wEPMKYAFdH6k0VJ4sgqAYdUkuTKCvd+xxXAc/GECJF6UcAVn3WYM7KRIioZwHsp+NHhQtK0A9Y2lV3SYRYWFhu7ENzYvZvsCIm+qlK7fYvstJSXrL2OQoxgN68VLftC0C1SS1cDifadkyGfxhQVO/EarVWfREq4cdpN/8l2S69cecFtI6k3EOw+1jGJTCaFn8kQOPe561D4S+LzcA8Xu7uUl1ZSXEmicRtsf1ioyZV8GDeZBsTnuIuiUjp2M1oBL6AT0gkHaU4iMDXGOM/frsuD2mdEcp4uCAnXGZd4YezBFGLCWiMq3+JpLFscPRtRMCm5OJ8m8cymf7AYrO8HKZ8NbxSsAm1uWmntzB8nXFMbF+zf9cVvIfdDGGUk1iL6oXyWp6faRMH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(3613699012)(38350700014)(7053199007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mrLFiF7cxUsq2Mo9KNb5Y4gcG+FvpH7pJknsoCotaqr6MSPDdukO3q8WulB5?=
 =?us-ascii?Q?Wyz7ONx9w64Kjcm3tweY9ZaKhIiNN21wLsPPbXmVTIzSEq0gzSH+QGBQq4Qg?=
 =?us-ascii?Q?7ZfNKfSl/PRa59KpVlQ93ty3xfVL0msKgwHzjoMhPcwv/0xSzudrdzXkDE3W?=
 =?us-ascii?Q?EMBIaRw4Y8xz1ba1do0jwRAUn2QxwldiR3QySUCKCYK503YLRSqI2gQXbrnp?=
 =?us-ascii?Q?kglxNCqPWRviZZobmf8bVysr4hb8w48ak3Z6eMjzhA/ESOuqvt5F4SCADRuP?=
 =?us-ascii?Q?bG0Gr4+8KPWEOERdqe2YBi3mKUQeQZQ0PaCyvFasPtFVylHOguW73yCZeNqV?=
 =?us-ascii?Q?2r1bhXnM5eP6VN7G/Ra9SwWG5iEXSw0y04Qz/rwfrePQC1If7Dnjime0eng3?=
 =?us-ascii?Q?Bcb0WPLbnl8Yqw3CUOmG/GLjUGwCCZxhZKL7gVEqUiX27XnkZbB3g1Sxzl+a?=
 =?us-ascii?Q?KObnkSwyP3u0WzHb9N/MYZ03Ozmg8VIOCuNVFYbaafEaK3et6Q1RS5cdepdH?=
 =?us-ascii?Q?aDTmoW9Jn5sQpXP0bBiEe4d44XfMFHxo0kV1GYu18OD5sqR0dXvA9Yg4j2uV?=
 =?us-ascii?Q?Kg+arT/OsQzDutk0CbrVkS+ZymHtUdXnnswF0R1yTWUqHtEy0BLOenpeNoKA?=
 =?us-ascii?Q?hKiM8CO4rShhGH3wS83DYeDap5e42Cnyv2Pm0ykBVV4Qwjg+RLK2Fg8tV6lD?=
 =?us-ascii?Q?PvTtk755KLr3Cs+8Ncefm19ckjlqUnxoK+CWjGPmewk1cTu8QA2ot9KZudJg?=
 =?us-ascii?Q?JxciQ66RYKK4xeZqY59flR2/IrYKusRTLAXA/hPJ6c4cR706P3d5elMEn8N3?=
 =?us-ascii?Q?INav4pYjMC5ucJ5vUF4IP2uWfL7VLG7Ueh/ocrniein18epYeJa+zB3Ie3vf?=
 =?us-ascii?Q?FFIXyVCHNoDLFTj6BdEfw4HKNyaFNuX0aDDmuqayH70zoMRUMIKhoVHW5jgL?=
 =?us-ascii?Q?+oNq/6BUqsIow2WXZ/M4DSmIb/6QBVo7fb0or9WcDpyN7SMOSuiKVYlXJvCU?=
 =?us-ascii?Q?KSAhDPly9GoRZMQD70sfk6+JAxtSgm42VEMiXsRf4PRiFf2xi7XW14D4Xt9g?=
 =?us-ascii?Q?n3WRxhiNALIqIxrbsrsFKH0AZbanxNNVJ4Hip63GEmnEbJqp2CRLpWTL7T5P?=
 =?us-ascii?Q?RWkfTR6lpxVHOS3Mrmi8wW8uEfFf+7TRaR2CIBEH9MzHna54DSDUGVn54+27?=
 =?us-ascii?Q?LSqocZpzFT9y7dTxow9PohbQXOXLLQptbV0Qi9ZC1Bswp/+/NdjTK9O9ECkE?=
 =?us-ascii?Q?fbC5hywxD09Qi25BKJuvasZqOBdgwUlxFHM5XDOercQJKjx/1tkWxhMLFk2G?=
 =?us-ascii?Q?4s8I13KeFqbGQNvfbbqub9+kSFvinxjBz0beRd+Ll66NvJ+KwPKt/67eUWJt?=
 =?us-ascii?Q?0AjwzoL33UmeAM4lpisyuNgjX24Gfq661bdffPGsRMBaYZYrYh0TcjbLb2cg?=
 =?us-ascii?Q?C+fGPIbn0bk1cFEV92WEFU1YE6d6u4AnZOq22/+26JaXN5DnHuojKZVw3itP?=
 =?us-ascii?Q?SCT5qceDt4SNjCWG4/NvQue88HZJvwfBm4IusPw1EV5qcPUgX5eGfQHkMqCy?=
 =?us-ascii?Q?WtNGSi8nIa+qvaedg2bawpovvDyZLWvuAsFNkTTm6tWS2yb0155TRmavrz2V?=
 =?us-ascii?Q?MJZLFn8c2pVJ186QCuOd8wzfDh276moXHv5FrzomoZO6RLh50qaX6OZw8HE6?=
 =?us-ascii?Q?T/fpSDvFGukRNH9FxgPd+ytobG3vrl5F4D8EmzfLhD2zfc6F/XXFm0vcIAgL?=
 =?us-ascii?Q?Eh3pTu1i7Q=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	N8ZnnMEwCh+cNRzCQ3JelxoQ8yo6zl3NN4GJgcuuBreP63McIbx8J9kfheYTyJHJSzQFW5W9DbyYqqo7LE480vt/wcMVGQUywX6QRfY+i9Y5Fj8ODMikZ1i28+FutEHGbCUAg/c9HEGqfyWCbr9oUhG2yCFqSHobLrOUq3CPgWx7NWoBJnfcIARa7+QDL7EzI7a+UrqHRthDYu7JkXkrWDJET6JSajSnhb36JDzWQVMz1XYHpn6yws894m4x6HfKr1hH9pAaN9F6g5dYnx0NJrUKw7TBJzSPy9mDcEMl6UpkS7C6aNrehGmb+7bcvD1aOQFGCi5Zjwud9QbbLW9kdw==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131f58e7-4608-41e6-c8cb-08de843ddaa5
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 15:57:13.0333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iymv8dYaoSuvvBRNtrXlKuyftcAbUXzVnSDstv8HuVVILMTVWAjyJyGHDYbnjnTMtIIwmySdPf4sXNzMUc0DNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2507
X-Authority-Analysis: v=2.4 cv=AIx+R2tb c=1 sm=1 tr=0 ts=69b979df cx=c_pps
 a=/I7KA9t+8HAhutJC4ZwGhw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=Uwzcpa5oeQwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=W6z64dnQKVPvYeLC5f8l:22 a=NpUDEC63da1vOGE9rZHW:22
 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=dmF26TSAndsNLafa5AIA:9
 a=EFfWL0t1EGez1ldKSZgj:22
X-Proofpoint-GUID: comb3waEbcQlEsuejio_yozeuI0QsK0d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE0MCBTYWx0ZWRfX8/gVcZPsHXRH
 80TPW5NK3QyaR9W1mxiVEs7ZEbZRWGw+37GXGLL8MAISZyMGWJDMZDmLlt5qI1zwtJL8Bxa3EDk
 +uIwTH0U8whF5EY9gSzpck6jaRsU805AMXVjCR2hiGVAbyoLQyF0+UbbI2NMfjUmi8Xo7WC7961
 +xwYTUbUx11Cs0DBm+0ZA2w5lFhNsRiJLq0jVR7WQLbyIRYgprka9CC/GWjjzhYQtznHm+Zv/js
 9J7fbZcitmJcY/Hf3eVqNBidxR7KutkDy5RWrlNNageCBdOrLNGNMLMzMFxPctGx62FNwryObny
 xKr+GjPl+4YeqTwPwLkEssBi5HbnaNuv44qwXy0ntZcVHP3/4KboqJgGKMlpjE8LbSY2aL+RNd3
 EdmMlcLN8oYL9nLSMbORe5JvVQhKZ5Vbq+9HKinKuutVOyt6IrWeSodmL+uTQ/9jK+RNufPrKwO
 41GlPsAivO2LgLfkFXQ==
X-Proofpoint-ORIG-GUID: comb3waEbcQlEsuejio_yozeuI0QsK0d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_03,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170140
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tdk.com,quarantine];
	R_DKIM_ALLOW(-0.20)[tdk.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226115-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[tdk.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tdk.com:dkim,tdk.com:email,tdk.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inv.git-commit@tdk.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 442BF2AD668
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
(cherry picked from commit ffd32db8263d2d785a2c419486a450dc80693235)
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 32d7f8364230..f29c3e8531e6 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -377,6 +377,7 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
 static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int sensor;
 	unsigned int *watermark;
@@ -398,6 +399,8 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 
 	mutex_lock(&st->lock);
 
+	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
+
 	ret = inv_icm42600_buffer_set_fifo_en(st, st->fifo.en & ~sensor);
 	if (ret)
 		goto out_unlock;
-- 
2.25.1


