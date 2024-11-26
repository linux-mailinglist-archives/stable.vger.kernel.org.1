Return-Path: <stable+bounces-95495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705969D91FB
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 07:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0128F1652A2
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 06:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F26158DD9;
	Tue, 26 Nov 2024 06:55:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F2D1A260
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732604121; cv=fail; b=X894EjITmbmd7Z684LMGgSJMq/FngqINb/FKcnX3pNW2qpucdEfIVxS62uqefwbt92yTYXG9VCoT5sf19QDpcyE6lyTrcoIBxPUKey5dFiLXpfciHS4baCXr6obpQKTKfOdgUgzq0pCHhzdL9+24yc/z4YyFw0yRh0xwSMAMYc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732604121; c=relaxed/simple;
	bh=hvDDkdSxJe3HgTLx9pnpks3hvM+5QiAVc1cUtrC8+/I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qxDH4r7Wy/32OIW10Zl87ZkITne//JsC4yBisLLw4EirbUvT7ACclM0jLeLZRMl9XXcHUwnBJb8a/QHbJPCe+WdAIBZ8/AnMZaMLwUoFTWPe8c4gHyh6ksudWp0LuiwO76iGPqrZ8XT0kcgT5wiS9oi55sIVm8iyhfPKZPrjnNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ6Vwhn009552;
	Tue, 26 Nov 2024 06:55:16 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433491aydj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 06:55:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeqtuOx78eMqAF2eudRPDIrrX5cBLl5ig1umHdReG6pjYCDeS/RE7RUdrS50RYV8Gtsq7OaClSagSi7a3FCi/sbRN7ibai92Ca1iQVTNg26YhkF2cxD0HJjmD/jM2RfI1PRoADku6Vj9KjHkKNxwEVXCvlc/Ze3VXUOSTWFz1sbvkiv7cQMrKQgTFXIOcXtn5fJv2Kzx9vT+UxARCUJT7Z5f4/N1WvCAMdFagPIH5WbS779bIOwqUxmBYSZ0DhAgNSAdALW6KHUYBXt+MaIZUbGj4csyp8RJw677Edzb1u/4XWQUFhjKxzW9gUZuP+KaBcbSgQFzTAgZwqTofNFFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tP9HclzgCD++1sCEq+lJdhsF59IolpiLsoJnwn5nu/Y=;
 b=r25r6SQfAwNe6HRSUEDABd1Iytn/aXP7Ai4i/comi2wdGiJDRaNyVJF+pxCvS6dcJptmL1abNm5NSWuT435/4+thlxjjZuocZrgC5FWQs1H/1JSeR6pjjYAhIVGiOC2jhrq9xVsoiyAADtYUMDbZ+anODVXBO7K4oJ9CirqNmbXRvSJlLv05CTEPjHkn/9AArBX8owvPF/+ja1cRqO3jMs3rVAQYKT/X6cgBfbNHCnYrngHpUWy1672eiPZ97AP8Nodh4jYawNnP4kdZOoZxnKHc6lDF0FSNHrhYZ21g5zQr6awrOokbYl8LIMB12Kh6nUur/fdM26hPyXtDSLcepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CY5PR11MB6161.namprd11.prod.outlook.com (2603:10b6:930:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 06:55:14 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 06:55:14 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: srinivasan.shanmugam@amd.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6.y] drm/amd/display: Add null check for pipe_ctx->plane_state in dcn20_program_pipe
Date: Tue, 26 Nov 2024 14:55:32 +0800
Message-ID: <20241126065532.318085-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::14) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CY5PR11MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: 531ec01b-e6d2-471a-102e-08dd0de7475f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j8+pLWCNkSePg1CN5sdA01Rd+dDExXgdfOCbDRV/BpIbDFdmoVvdyf4w7SML?=
 =?us-ascii?Q?G4XQibcWriaXqlSCUKCBQ98hTwWoIWzcx+xzRUztTTlVnINV1Df1i2IZA1kk?=
 =?us-ascii?Q?LC7PW3toZENtFpqjAdkL9eKmZihNRv0anAX4637p/hIWkAAOHlrsQrD2NryB?=
 =?us-ascii?Q?1gcG3JLRJDRTOMDirAeh8DaMX1CruzsQbkpGQHFnl3kwNVrNEkZRvkr9FfxD?=
 =?us-ascii?Q?siGDIFzCdh7e5TZ7VBtR9KwIUqL5KJrqNpyh94jHML2nidsdxxcoM25hf8uX?=
 =?us-ascii?Q?cKeTX28q7ZPnxLtYgKyGewvRvpw0n7u0kgsrM7KMGAzU4SnLUeSd2DRmDA37?=
 =?us-ascii?Q?VuyL9Z5jTzbBZeIor3d6aSRbqCC4CZRGpHB28RHbto52ZPnTZVQe/T1l0C4d?=
 =?us-ascii?Q?9dC/8gfNoVgxlh2jemIYJKmJHtADH6re7196lTP4S/Xspp89hg0AwCQ7BvoX?=
 =?us-ascii?Q?4qPROXpfjMdd/A387ZmmuPCap0ylQoR8iO0DpsPtubJr46Lg9+9tKCKwUv/Z?=
 =?us-ascii?Q?8ZhahIpi4dYZeEodsrfeEB/xp2ldVtYMwoL5P9lSkdq0m+OFvNjmbl5nI7hZ?=
 =?us-ascii?Q?YRfD3Hhvllc8ARupJNyw0SXvdiA+XdVMARTB9TW74uoznW7QYCHMtRA3C8cJ?=
 =?us-ascii?Q?yrb+v/cyNBQvGDpfVAX1Bs4VcVsKrqdlLU/gFhT2cJVf1cyhef7y3gUJbbEr?=
 =?us-ascii?Q?pZxpaC+bVkL8Q5+A9AXrWMRdW7q7dfwVyZauPBSpZ6YmvU/axlq3dl08Jcmi?=
 =?us-ascii?Q?V0jHB2x9nNhsSZs66y5smQlZABBR018M2f/G6VcKZE9NrZFKjSbptL8Hwtf2?=
 =?us-ascii?Q?FYbOFJnyli+jc7abWsVuXzz447jR272FbK2uLAyKzLTx9ceDsZ4Hwm58PbMd?=
 =?us-ascii?Q?u3JF7cGPMFPktrc4TGT9ka9zMl1tfsBK5LzUbHEmymrVT5ZDtz+nXaL6cIX6?=
 =?us-ascii?Q?bT0WDfeiOFrcTdxGpeCWizXNmvlVBEGfP/i3BGo6GGyXpzgtPCs/N+dckGi3?=
 =?us-ascii?Q?xN15D/T8jfkwKqaCcbGs7JlKKihzQEKKUrz72BMAbEk4YnIn2x0LTGobLU2B?=
 =?us-ascii?Q?gmNFZ2mMKksHYXPCrS0fEnAlmIBnV6iXY0XOGmHr4uV/lS+97JdHkDMbg+Ho?=
 =?us-ascii?Q?s8cBzlbQ45wIM7FSZkZaaoGI91Sg2O18i83WmaH9yje8pBZqEVm8xNNuXBWM?=
 =?us-ascii?Q?HjQnC+iaPjcnnqBZtLOlGWrYKDzloYQc7ecMTlSplh1RJ6y9c6T1XocJcHK5?=
 =?us-ascii?Q?oQPrWsOnvnnHHRwKMpPKOgSL6wxnRZj/NUmg0YfP1M7tyTqG56U+Mvnx8eLP?=
 =?us-ascii?Q?ECwCIg6HnDG/z2+fAjCpvTOdCfJJGacRSroPwmyCHqGc4MFufrs30FMHiGY9?=
 =?us-ascii?Q?mQlvN/FUy5EH1stLClEqhFEWrA49YhGKIr0a16cTpXztW+OfyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ms1QM690Ei7lVMmnotkmWf9//B7XBNvPRR25s/N//0LK38PqcQ45PAwwylsS?=
 =?us-ascii?Q?QjoQIFyHN98+qR50P7yIR/96P9DA/nDGsR9Y9V1y5KMz66YMV8mchPxkgi5f?=
 =?us-ascii?Q?D8ugHODWNFEgnAUM237KRmy21MfpVheBXrDyBhnBlUXYg9bti97PiRK6V3qQ?=
 =?us-ascii?Q?p2xH3aYCiPdHb/5MTfZEKo4BXCoU0X/xUfDNkocqrE2G/8UgdkSs2VyWy3IS?=
 =?us-ascii?Q?ptW1kVY36q60lMIEi/HArGbya6Pv5zJCZZnGNKa0L+bfrd95QdiuHHgGA9hM?=
 =?us-ascii?Q?LgKQ8U1evXsa4rbuPMe9Csmh1r48vkzT/icjkslPNvNBVj91vMwmg6BhdHOi?=
 =?us-ascii?Q?iOGbPNpoobfqwcpEhgsrw12YGMdusAeYDE3ntnF3bj0aGj1ugTsqu6TbdzIc?=
 =?us-ascii?Q?Y5ldDu0V+1A3gvzekRgHqdo51UZnr1CKYHLWOdaHr+DTxvUAPj01mta1YurC?=
 =?us-ascii?Q?BIBd07gYqLkkjfrx/sx8mQBlbDVq/7BLyHMLPpfBjnCYKN0+mL6dgtgyGoN7?=
 =?us-ascii?Q?xZElv7Ts9pfxRAIHxhywZkJ/WNyspTuZxzOfqAM8880StUl+qfLkTmkxf7S4?=
 =?us-ascii?Q?vhVZQld9A3hhl1nHt3iiw5dzY+iYSEKjW6OvkG07JvDy3l2f5h8K6NClCnYK?=
 =?us-ascii?Q?a6bqsO7kUMbCfVcSEs8IrUG3sBTw6nmr5/JVk9SPYUd/7XlEDIAqQNKCKI0I?=
 =?us-ascii?Q?wGrITfJbhGJ/AP0pJuHTHr48HTo7L6ER8HIvrEvAD+DESSfrRdLvI1Sh/JiM?=
 =?us-ascii?Q?sO4anGOQ70KDclz9YNrG1lgkVEtPp9e1SQWtNorzE5zmi9B/USayBmm2+uxZ?=
 =?us-ascii?Q?katHdZpSsu0PL9u9O3XiRwLYNzUW8jiWdiY3zSukCY7kNIU2lv/75fOBcxIN?=
 =?us-ascii?Q?b4j0ROAu/Xl/0zxJo9BmVfpkqMeYaBkYAjM/MUtj6iU8yImdVg6ZJcdOm+tJ?=
 =?us-ascii?Q?qkpOFMmVxWd58wHcUyvgUWtmKuxFmOfBn5TPSRKkOoLvj0HTkHA5nsd7t2mn?=
 =?us-ascii?Q?RV0jL2uo56cSm3yKAqCIuMOHPuc6W1ygdPgoiPdDE/+igP9XhtjUqeW1ZUVT?=
 =?us-ascii?Q?svA/y1InibiY9soMS3gSsr0jcRyrgAMwK/AEf+dJzGFbCrJaekQYCtfwQL/n?=
 =?us-ascii?Q?huNexzVOkq0ojlH9kzBvpRxJ4buZif0JZGMDP2WG2tno1WokJ0RYpefA5Y5x?=
 =?us-ascii?Q?lIccmWFrTBxzexEm1GjlIFZhZ+aMPsHugUE1QoWGexh8VsZr6k0JEo78oQ2N?=
 =?us-ascii?Q?/t4CA9yafgKVC3pYCe36RLS27gAjBPJ1OrFJQ3M1wanMKxLHFZF+y296QVSj?=
 =?us-ascii?Q?4RIxdu418c8oOitBsI8TP5GoeNLbtpoJ4RZQoONBEQyenWqmRz0qJWwquSkB?=
 =?us-ascii?Q?D/SInCr6Sq616b2tEolcuIPoBHs+VULYUTq0RXng1mz0g3TbBV9QDi8rHMLR?=
 =?us-ascii?Q?EBC+7SWY1qAl1C18E/As4XMh4D3c+mN6PFJCZrlSwbVFjh6e+uQk0lqwuoF1?=
 =?us-ascii?Q?56KfPSCEFsBpM/Z1XM9e6kxCzSHjnPikn4lMWSQGH0lbcpVeLelZCiQsRbtV?=
 =?us-ascii?Q?dDfwg7YULwT/XAXeyBtYbfm75mDU0Jd/1udPlwKbJfSumj3mxAD8ss62/XWH?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 531ec01b-e6d2-471a-102e-08dd0de7475f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 06:55:14.4212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGagtxx0KoaHkIOR/RVgsr5sha5NPzSibH1Cg3sgirlTMK12uw5jUXr0IfMauFzmUuLcFZKJcO8jZ+CKLypsXKup8H8QBydtF2XSPPfuYMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6161
X-Authority-Analysis: v=2.4 cv=W4ZqVgWk c=1 sm=1 tr=0 ts=674570d4 cx=c_pps a=G0EMd8eUBd5ElxF49Cdl+w==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=zd2uoN0lAAAA:8
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=vA1BFXkpzZh7EkSCBp4A:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: ESyyW3mh-7dE9rceG9n5gPRPOqX671Es
X-Proofpoint-ORIG-GUID: ESyyW3mh-7dE9rceG9n5gPRPOqX671Es
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_06,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411260053

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 8e4ed3cf1642df0c4456443d865cff61a9598aa8 ]

This commit addresses a null pointer dereference issue in the
`dcn20_program_pipe` function. The issue could occur when
`pipe_ctx->plane_state` is null.

The fix adds a check to ensure `pipe_ctx->plane_state` is not null
before accessing. This prevents a null pointer dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn20/dcn20_hwseq.c:1925 dcn20_program_pipe() error: we previously assumed 'pipe_ctx->plane_state' could be null (see line 1877)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu: BP to fix CVE: CVE-2024-49914, modified the file path from
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn20/dcn20_hwseq.c to
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c
and minor conflict resolution]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 12af2859002f..cd1d1b7283ab 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1732,17 +1732,22 @@ static void dcn20_program_pipe(
 		dc->res_pool->hubbub->funcs->program_det_size(
 			dc->res_pool->hubbub, pipe_ctx->plane_res.hubp->inst, pipe_ctx->det_buffer_size_kb);
 
-	if (pipe_ctx->update_flags.raw || pipe_ctx->plane_state->update_flags.raw || pipe_ctx->stream->update_flags.raw)
+	if (pipe_ctx->update_flags.raw ||
+	    (pipe_ctx->plane_state && pipe_ctx->plane_state->update_flags.raw) ||
+	    pipe_ctx->stream->update_flags.raw)
 		dcn20_update_dchubp_dpp(dc, pipe_ctx, context);
 
-	if (pipe_ctx->update_flags.bits.enable
-			|| pipe_ctx->plane_state->update_flags.bits.hdr_mult)
+	if (pipe_ctx->update_flags.bits.enable ||
+	    (pipe_ctx->plane_state && pipe_ctx->plane_state->update_flags.bits.hdr_mult))
 		hws->funcs.set_hdr_multiplier(pipe_ctx);
 
 	if (pipe_ctx->update_flags.bits.enable ||
-	    pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change ||
-	    pipe_ctx->plane_state->update_flags.bits.gamma_change ||
-	    pipe_ctx->plane_state->update_flags.bits.lut_3d)
+	    (pipe_ctx->plane_state &&
+	     pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change) ||
+	    (pipe_ctx->plane_state &&
+	     pipe_ctx->plane_state->update_flags.bits.gamma_change) ||
+	    (pipe_ctx->plane_state &&
+	     pipe_ctx->plane_state->update_flags.bits.lut_3d))
 		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
 
 	/* dcn10_translate_regamma_to_hw_format takes 750us to finish
@@ -1752,7 +1757,8 @@ static void dcn20_program_pipe(
 	if (pipe_ctx->update_flags.bits.enable ||
 			pipe_ctx->update_flags.bits.plane_changed ||
 			pipe_ctx->stream->update_flags.bits.out_tf ||
-			pipe_ctx->plane_state->update_flags.bits.output_tf_change)
+			(pipe_ctx->plane_state &&
+			 pipe_ctx->plane_state->update_flags.bits.output_tf_change))
 		hws->funcs.set_output_transfer_func(dc, pipe_ctx, pipe_ctx->stream);
 
 	/* If the pipe has been enabled or has a different opp, we
@@ -1776,7 +1782,7 @@ static void dcn20_program_pipe(
 	}
 
 	/* Set ABM pipe after other pipe configurations done */
-	if (pipe_ctx->plane_state->visible) {
+	if ((pipe_ctx->plane_state && pipe_ctx->plane_state->visible)) {
 		if (pipe_ctx->stream_res.abm) {
 			dc->hwss.set_pipe(pipe_ctx);
 			pipe_ctx->stream_res.abm->funcs->set_abm_level(pipe_ctx->stream_res.abm,
-- 
2.43.0


