Return-Path: <stable+bounces-226616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEgdBEGNuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:20:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B882AF551
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 708A4325D88D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C0626561A;
	Tue, 17 Mar 2026 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="b7Mm42I/"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BF726FD9B
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767485; cv=fail; b=ZlfHfiNMSz50dv8tpgcz3q8JKROgoGk1irLfOUG/SifwB5g9VjpbhZeA1F2t+nEALHnDu/i2uWtl/MXJXqqRr+ib/rWj6IWPHWqj9el4Kp1L13kjXhKheY8rN7hu7rJ50uVWZAYpGfPip/JivqvM4iJklyB1BtyMc1CK6xsh+L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767485; c=relaxed/simple;
	bh=Q6UxtjIAce8qBHeH7Uq5K6vNA04ZLwlsXcXt0GANSgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NWq4insvnEsPIsbT9tCvxQoOiTWSRswy9vh+IYSLTDJ8EMEy2KIhaT7dxt8rxOpsV45EZb23xOwjLv91KOyNXD9Uvkx+Gh5NmhpHIHlWOgak5DErcesuHBpeYMBy+CLoZoFrna9FA8tmuXsNTM8t5Fp74N78jYTtW9J3LuT8cc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=b7Mm42I/; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GN7eHJ2318555;
	Tue, 17 Mar 2026 17:11:15 GMT
Received: from os0p286cu011.outbound.protection.outlook.com (mail-japanwestazon11010018.outbound.protection.outlook.com [52.101.228.18])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4cw11gtbay-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 17:11:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueUMnc4qBXpC2dVtUy8dd0/xBJj7UAtX36I+1WY1aNCL+EMkd3zmMnZ3wS7srwNMJrzQbDqsGGpwNrqH7+CyfU0+cOanakw3BTGEY8sxyEjkK6Juy1K4uZxEnDjIHqeKSRfea/W+o8f/MdTXZorB4rpQlvQdBfpxo2PzPO/utWNhIep2xPAuOo9T1pLyXH7CC5XAJj6gQ3sap0HbiUJazBAi7g1TI5nADKRMo1j+pmigEulqyRsSBmvxap/EP3fA8gCfFVj9QM0YJVbEidTX/wfSWgaFiAOhBJ17VclTqXckDdfe8Q5WaDcbw+5FY//0hzfZH5SYFuXiKPcweh+H3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKyznf+mO8kxfVKxXnZ9vXSE6GYJy0xn7xUnw52oUuM=;
 b=OCJLMMQvgNsDMg4ZdiAAGQ4Hnwok1q852emjyQAD45zu2eVMQqYQRA10DeKo5JRx3KzN5wCVD/MwAvHsqqjeO0UbabAynEYlMut4OeaJZAPU6JSObtL/jVaY7skkMeqED6x7d8m0m7z3Z90Ghqo1e6XEvyXMXhC0GB7qOrMp3Ic5tmgJABRYTQX/RoNLXfVqNLDD8plyUD2B5NCeGXoeBuYAv57yht3PrQrOZSuqlOLVtWs/zt9bhK+GmkPESFG9ch4rHEFII31PorCp0Mbcns9W8iPz3TSwC5mtv6t9y7kWe6deRbIwVZnbx+50wAjgA9S2uJDTP4cp5HyuHF90hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKyznf+mO8kxfVKxXnZ9vXSE6GYJy0xn7xUnw52oUuM=;
 b=b7Mm42I/Di4M+YbEmKqiPQ6U33+GXgASv9O4gQOrVb09fu1ZVU+oyEV86OCx4HpNazA4K2Aav6bAiNc/vzuoQjbK22K4KK0iJCvq7dAbZ/1+5ID4eP8P18+PqjlWkrw5KqV90KIIJwA/naRENXeZzOR6ATL4Y+s8Li9qDA0zYfwqsj2JKYiSY4WTRwJLlZRuqs081eIgNo+RU9kEkaeybYNj3B/ah0FAvN88LDgP/vrsQGKDNIEZzMt4rDtHj4MLNHsGBCchxafq0Z7JFDu0Zwcvo1M/bCkOP6gSs7qxWNZeVo6akdYSfqw+3waQQ9Ysx1ePnbdRh/ocyNUK95heVw==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS3P286MB1962.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 17:11:11 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7f13:e26e:3d72:9ab1]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7f13:e26e:3d72:9ab1%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 17:11:11 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.10.y] iio: imu: inv_icm42600: fix odr switch when turning buffer off
Date: Tue, 17 Mar 2026 17:10:59 +0000
Message-Id: <20260317171059.746423-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2026031737-trophy-prison-d009@gregkh>
References: <2026031737-trophy-prison-d009@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0091.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::10) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS3P286MB1962:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d10c17b-2155-4689-28d6-08de84483052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|3613699012|38350700014|56012099003|7053199007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tDvXCR/TbXx6yWpTQU3B2pPtkcBfTPAcmTX6UCgOepeLjEwopkD5j2y8bwIKqAsCjN8HsGargKmw/kHA1WeUPGoX7jXRCcJYnEmNPRH8iGyUXt42GeY+FaGc0NN5p5sVRfCp+i4PD1YFpzkQz9imP3HPIdQDTzZctfbBvmvokG0APk1q7kBsYaQ08iqwnBJ55G8Bt8aeg3kOfWP6K4UOcBEwXuwufTSc9FHlKzvtnOFcNbPDskWcO8lIKOtAidciy0Zy56i/+MidUrvfGa/Ip5VTzpEg4CPvOGQeCDblKWh2PelpoMccondCSlVw81dg3N4ZmDkDyfAEsoSVQcCkEm9mqcPZbhy0WV6XqoAgmfaoW1lp8CE/49nyNqj5VbcVdKmcX+E4fdwRfRdmOK0lVFraAYwYv9iREok6Y/QWTeSkynRcQGO8m3rE66BpvP3QXk1uva8ygkBP1aJbco3444ErXYRzUu/FqoIEmzcd/cMMbChgaYjv9N5NQ/F91hVavRhBas1D9HLE3uQwWMdUp8f6P7dLoKD3k3zG59P8D2s+z9pGM1MKFIUGSo6DcsvC6CfQgUhIfsUlmEBOdpLrUX3GtQ8Pcbwk3UZTwKlWea2qViRBUga0T5r5ii3GJRoqVapKx1S+qn5emCMbWzKcSgx0HGhM4VL90CQNaWokQQIJeFDLehSHHMwgAqeFEHUBPBx/7H07dPQMXEuPLLsL1CmrHmDp4fA9yuvduOHRl8/UN7WYLpz3VF7XlIoGuHEBvbU+LwwNBWcYrYeB4TK2NHmWHLee1Jf5i+mgeQGaOXq+Q1Q9hiI83p73jTeFMC25
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(3613699012)(38350700014)(56012099003)(7053199007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/RxoGPO9lU+klu+fPN5mxu8cjrjoxV1V7tPlIzKjQZb9UoNQYCE0DH6MnV+s?=
 =?us-ascii?Q?23mCB61pD8kdX35wwHVAg/0cb40aIiM61NKn2KDwx/RBW3CTF6fPOgjoG4y3?=
 =?us-ascii?Q?r5TcHrsVEJyV1fcKzUqMtoqqr25ijjw/NIhYlT+DCTDOSVW32rbo5podK1eS?=
 =?us-ascii?Q?4UuP/zNAxbwyYyGUKO8Ih5tn7q6WeUTqRGpdikCKdGio/SldGT7Zc8qZKd+J?=
 =?us-ascii?Q?M//La4OS8Mv7/Z0Qi2d3dDy0PHa2RH/aT/CLQKmpOetRtQfbPqVHQUTUVmho?=
 =?us-ascii?Q?b5S7A+33t1Gsbg0hqHBnXzCy+UAwlQQjZXoaXec950uVbR876EPdlSUOIWRS?=
 =?us-ascii?Q?UFI4bHvjs7plU8l5zog1tXDYI2I9SDHam1R8BsL1gqEbZcVvhaGbcsHlhLIV?=
 =?us-ascii?Q?jjtr/1VKeu+UXjqWTM90hR+8i2pIUpzm/W6GQu0+smiU7O2Wzfi15yNGUoJs?=
 =?us-ascii?Q?njOcR6lVN/FnB2iVS1MWft44Kwr4s14lVxTAtKfuCBX2H7saXnLlb7zJXrsA?=
 =?us-ascii?Q?JFAtHO8qWJcAr8aC3zHfJqkd6WsgwUzrQR9Bx/mcxuwWHHhGYLYTNW2PQETy?=
 =?us-ascii?Q?L5yjvoE+JGw0W3P/OQMMBjsCxFlSrbea2/NvZXHYRffWaSE5aXnTYNOdgdt3?=
 =?us-ascii?Q?VMj4Ssq2uSv83tC6ynsM7QEUnEBv472vPrebI1dGx1hjTiTs21QuDwyWIYjt?=
 =?us-ascii?Q?KYgcrWcynZA2QV8j2j0FMu1OpgsuQ0RRiHEQfPHj7cEBhF0UDx0JpKb6UH1K?=
 =?us-ascii?Q?P8cEQVdAvncsFvwRNDxUaTUGtZI0ih6dMF03EcebE9bjI/C0UYtWIBXY/ABc?=
 =?us-ascii?Q?kcsPXSxa5cjfy9rA4GFS91u5g3ua8oThjEQGHgHXrEeydzEj9by8zWCiy7o5?=
 =?us-ascii?Q?KNB+RjyYO28TMuX3hHKoVvMSlzkIms8e+1pDRKwdivp1mW3vD6iea6dAf7/C?=
 =?us-ascii?Q?t7mvRNmKT6yRdizPqQMWDfV799LKc/ohl+BbZCidH3dLv7RfCL88J8gMeHij?=
 =?us-ascii?Q?pXOXyOSQwYqdZtoygL0hu0gH9WJE9PI/Xxeeo7she4EryuPVZG303INq+9Cf?=
 =?us-ascii?Q?nJcyK6QlhAj0TovUIu9Z6tEqknUpfCNqCa785cI52Z6Z5+vY2upX1UPzIjhA?=
 =?us-ascii?Q?bKAkhwj1QhpIh7kWxwF3X+WT3L5tWNifLPDyTfNTb8iyY2JQOpG70lcjHjbG?=
 =?us-ascii?Q?oKF5qemCmJ0u9ol9fcZ14JNTzzpLIX/q6kue2epyHINuWAAvRx6/8H1zK3Be?=
 =?us-ascii?Q?GuDMZa/nTZ7IYtiALNFWxzllIS0P0R8LyvdDmYp8a0sdx6P55VGs2Znhogdz?=
 =?us-ascii?Q?eELKWwshVtRS35YsrRCC9iGUCalLp+ZlkGk60FBcyENMiLtYxeur/NXsOc84?=
 =?us-ascii?Q?W1ek08kLIRuvrXFM0J2sMC4KsNP98ZRoThktXiiMJ6fDjeUvEs1OVNxcEJTf?=
 =?us-ascii?Q?1PAy/ncHsCIXi3h2uT6MZ02f+FYOXeypjKjMJazuw4yEOOHe20wXiRt5POys?=
 =?us-ascii?Q?0d/J8wtQiWspHuJjE7Lejf2fD4I2gMI9B272KF7J7t/yjzdE5h+xRWF9TO88?=
 =?us-ascii?Q?oStlmRInh5j3bZBjJsb885i3NstJvlpEgfmFaaEdkAbISWTw/wAwCKxv1Nbu?=
 =?us-ascii?Q?ohnS4Y+UM7Iv3sOEnNz5Obr3bYXNdLF96zee9HjX17Magt4gAAVSV3Rz9+kF?=
 =?us-ascii?Q?yPgrU5fi4e6fhf6PV+6EdQSheHEF1iP3dpQceOdpJeWAAGu3RcxpnhQYuXqS?=
 =?us-ascii?Q?uqACb75Trg=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	NOYFA/BhWsp6ocwyW3O5UhCH9nXqPbO16+McYZEa/cdZbvCVj21hbYTZgU2ytHeMAMfD7rntjr7ihZZZlIwAHrl16kuOmw4JmrQKrvgphF99Us2bcp6KchEV/eZmxjRUipjL6RfdZ8pLPXloWoDveXxvfOnuHzd5Qhb3UTltOzvSJK9XfHPPCN+qlUdy9JSCjDap35d81lZA2sBZX9cRhMvA2BjVxqReRsE1my/ieTYiVnffojEXm9Iy+c92SioZskPJc01v5YyQHhj2M6HEeYeknkYeXuiO46zoAgiHvF6Ulhm4Vf6AHQm/eLvRE+Q2E+SaZJPt8+NTcXtP8eJWDA==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d10c17b-2155-4689-28d6-08de84483052
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 17:11:11.7261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgQ7FGooEvuhjk5zDrx2egz61dHQbhTy1fhMDIp0N9teIlnomQ2EhrkYoemdQQxYO/Lbf+G6/YLaHbLnPeRbZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1962
X-Authority-Analysis: v=2.4 cv=AIx+R2tb c=1 sm=1 tr=0 ts=69b98b32 cx=c_pps
 a=Dk/SSLe8TKqEEzXgjxQsjw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=Uwzcpa5oeQwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=W6z64dnQKVPvYeLC5f8l:22 a=NpUDEC63da1vOGE9rZHW:22
 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=dmF26TSAndsNLafa5AIA:9
 a=EFfWL0t1EGez1ldKSZgj:22
X-Proofpoint-GUID: vxRSpw7yoMmrUI2xWMvsEf-njrBMArme
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE1MiBTYWx0ZWRfX4G1gXNUUECw4
 lI2Wep3JekmujjA+crevW8nZppwYTNkCsDKhzKpF/zqu4Z3ncjSSwxqK1Zg3nffkBgjXb87nPxP
 I9PRW4a+nVouDxECqYhR4vWaBZ/zh8y+HC3+9mVVSTD/4TxA7SP2zJzMCgv+mEoW0XKxvHOftei
 daQ6AMRtgNKQCJ9GBJvkZJCDFiX3+GZ0r/MQ2q1Kc0m74V6UYvD9QbNOW4A8+UN15KqXziKdisz
 x7u/L6ey41UhXOCj73UQ2QLyDa12rw2Had/HSrFqLqYijw5sQCme+6kzPQdx6AO9JhKFhyd4vAj
 3mVpxVwqW2ws+00b8CdG+YwsD8Km4S/Bjj8dTTcrd7BmZ8uMCYCVkIb6nv0R14wdidada5lG5DK
 m9ugVBsrpKN7WEFqoAX5HdfV/mEEK1R2stLw67tVSftoFqTHzbRlKvnIwYpLDFwEO9iw7MXC/4K
 5akmZppz4O1S1WlDChA==
X-Proofpoint-ORIG-GUID: vxRSpw7yoMmrUI2xWMvsEf-njrBMArme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_03,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170152
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tdk.com,quarantine];
	R_DKIM_ALLOW(-0.20)[tdk.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226616-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[tdk.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tdk.com:dkim,tdk.com:email,tdk.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inv.git-commit@tdk.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 65B882AF551
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

[ Upstream commit ffd32db8263d2d785a2c419486a450dc80693235 ]

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


