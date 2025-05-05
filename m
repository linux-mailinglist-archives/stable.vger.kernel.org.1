Return-Path: <stable+bounces-139715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8485AA973B
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 17:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6893ABDD3
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EBF25E451;
	Mon,  5 May 2025 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lGZFnZ/u"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC01925D204;
	Mon,  5 May 2025 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458225; cv=fail; b=cI6CDtBNgarAkhMiLIZpDr72vs2bTf9ah61JydiMsVQ41CIrDcpjXkdgGyXbr4IJI9mxKcfF12KB+F+oJQ27KdDdHJ81+/kfD/NT+6vFz93gyuvWxdUkteK/um5vwFuP8VLyW7OsC6Mny1qmp5kdwlSh4n+0ErrXTKwF7PtWKv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458225; c=relaxed/simple;
	bh=ssvYvf+y7qLbqQ+DfwNV9cEzm1ITJXh0yHHHqf9RmWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DyMEtAC5GBYgApP4q9kKwIJPsKh9tOrskNETBiYqB4Nl/TaTPdjZ0swGYDEgV598tpeUoHe3/Pa8gf/yO6UsxpAhDCiv3LGHlEIv/s0jEhk7AzNEUUQgfg+k9bPdPzl0z19len05PFxX2Revua9TT6fUit4SxVMOadg0/EYPx0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lGZFnZ/u; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmOplgHY/CUJEVTPWW6Gd/nMEE2wfsgUiS0JYIDqTr82/5xh3/8DG8P6NzoINDlBneiHga+tZiJTwXzE3/8Yh/bfRHuMd4TsUWopndS1lh3G62VAgz/xq7HmtFXgX0dXxsX3aoAmfVPTkS8liUNeE8BDNUnmPMDHS+iA7XPpXcvrD8/OkBg3ElnsOO+1xGWH9FUnguP/TDiAaBZt8QBFECxrBaG1uq1QZGvt6HwM5gDoXYVflEehFRFAJOnb/Q14TqaIylPHSG/Kq/U7ZpwgGvYXY5PfhiMeSzTe0BtfOXYXPLI0ZUCgnWd+7I7Z0kmln8zcNy0ISjdruQ1gES5GyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RITeO3OU5xuXoSWtA8CFCZu4L85vJraE2AkrKVKaZIA=;
 b=OaYpFyU07YLhgs6cjLtr9vK5r+fcyDvcX2OUE1798dh3it2AUJRjyQJW355xGxOJfyYrYn+k8q5Yfv2H0xl5q8NYJMDfzCK8Rd61FiZCzfVrCN0MFtCuNRp8GnKhPBxmt1DX1o7MX6UEghVrEuu2WMlr1uN6PmsT8KW7fQ+0nW9y9uFwywR7VsPMf/fcEhgMUX0eb6x4K4skQXHFK4TneL7+LmQseFwlbk03wA4SX3fKTTxqEy5m4DiiXpfW14CQgn/LNfV+QISCl031qSufaXVY6yK2L7owFSA5cghN6zixi8z2Y4mYsq29/kuwBCdK4+mVRJB4dMK8URXkwwPFrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RITeO3OU5xuXoSWtA8CFCZu4L85vJraE2AkrKVKaZIA=;
 b=lGZFnZ/u1qSfp3cllqZko6ldg43FF5+rZSMtqx3Ef719zWBcZ3E6uYhqCaQ96sd16gtLsbMYY/J9u2Ig4T5/3FJDh0TLjbUZYtepQMF7/sf+6wRWXEeZ8qNVAq36lCR7EohR6Abfzk2RwZ0JqD4hRilXqhHLoJ72hs4wSSdy2T8=
Received: from SJ0PR13CA0107.namprd13.prod.outlook.com (2603:10b6:a03:2c5::22)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Mon, 5 May
 2025 15:17:00 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::d1) by SJ0PR13CA0107.outlook.office365.com
 (2603:10b6:a03:2c5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Mon,
 5 May 2025 15:16:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 15:16:59 +0000
Received: from [10.143.196.137] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 10:16:53 -0500
Message-ID: <c0e87c08-f863-47f3-8016-c44e3dce2811@amd.com>
Date: Mon, 5 May 2025 20:46:51 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IPC drop down on AMD epyc 7702P
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: Jean-Baptiste Roquefere <jb.roquefere@ateme.com>, Peter Zijlstra
	<peterz@infradead.org>, "mingo@kernel.org" <mingo@kernel.org>, Juri Lelli
	<juri.lelli@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Valentin Schneider <vschneid@redhat.com>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
References: <AA29CA6A-EC92-4B45-85F5-A9DE760F0A92@ateme.com>
 <4c0f13ab-c9cd-42c4-84bd-244365b450e2@amd.com>
 <996ca8cb-3ac8-4f1b-93f1-415f43922d7a@ateme.com>
 <3daac950-3656-4ec4-bbee-7a3bbad6d631@amd.com>
 <CAKfTPtBovA700=_0BajnzkdDP6MkdgLU=E3M0GTq4zoLW=RGhA@mail.gmail.com>
 <de22462b-cda6-400f-b28c-4d1b9b244eec@amd.com>
 <CAKfTPtC6siPqX=vBweKz+dt2zoGiSQEGo32yh+MGhxNLSSW1_w@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAKfTPtC6siPqX=vBweKz+dt2zoGiSQEGo32yh+MGhxNLSSW1_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: fbce4191-9508-4995-ec9f-08dd8be7e1b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V05lSzhuaXFKWkpKVHgvTnhGUHV0YVhDYmV1STlZYy9aSFRYRkNxU3h6OFhq?=
 =?utf-8?B?Q1I0SEZRMWZNMXdmTnl5REVnM0JkQytQd1Z3WE1rYU1iMmQxV2EyUC9CTGFL?=
 =?utf-8?B?VnNBV1h5cVNNU3hMdGtRZG9SckxjbnYrd3BxSncraVVJWTE1a1p3UHR0OFg5?=
 =?utf-8?B?T0pPbWI5ckd2WmVGak1FbUtYZDl4N0hYYzV2VUpUbU9EQTZQY0x2Z1BQamp2?=
 =?utf-8?B?QlJmeGo0RXkxaVRIams0ekxhZEZNWGVaR25JYWJuajJKK3YvVlhaY3A2UWsv?=
 =?utf-8?B?eWtSKzZZRlRKZHN0RTNqV3JoWjJuRTl5THBTZmtmeFFBR0syK2dZcWZ2SjZu?=
 =?utf-8?B?V1Npb1BhaDlkb0xkaEpuek1MUUgxVWRqelFaSW5jT3cwR3RNa1FnQmxrMEts?=
 =?utf-8?B?YnpCcFhiL2ZxK2llSU9BalhLOTQvc3AyZG5xVFQ2Y1hNQnUvdWJvenZJUTJ2?=
 =?utf-8?B?djlQajVyUDVLTU9zS2h4Q1g3T3pudk8vZ3FzQVcrNmRmRlAvRWRPd0EySGFl?=
 =?utf-8?B?Z3pJN0hvUElWK1YyenkrVklXS1dOMHlHZmZab2t6T1VnaEV1Zit3cXc3R3U0?=
 =?utf-8?B?ZUF1WnQxSG9TNXdUWW0yT05qUmpMV2Q0UHZkSVlUMTh0U1E2VUJxWkJCYVZF?=
 =?utf-8?B?dnM5bXdqK0JnYTA2QW5qcUpqS08rYVZYaE1nNUZ1YlE1REZmcTk5c1hJdG9G?=
 =?utf-8?B?TkNzU1kyZGhmTWRWTVBDUXFrWjVpei9SYVRBaU9wT25mYW52KzVJTGQ5VjNI?=
 =?utf-8?B?WFFBR3UrMTRjcmt1OFE3Q2x1aWFjdHlObjZrY1JFTkx4QjFPRnhhc2xHYUIw?=
 =?utf-8?B?VWJ2T2poQ1JmSFBqdC9rNzBISWNCeENtNEprdG1lRmN5THZKOGs2cnNES3l1?=
 =?utf-8?B?MzJBVWo4bUpBdjVaRzhYRW5hWmNlUjZVeDZYUStvb0dzUWNkeWVOV1NlbnVh?=
 =?utf-8?B?L1c1a3ZtSFBCdmRGeCtKTU51amRLWllqZVhXRkNzeGI1dW9UelpPMGJzREdv?=
 =?utf-8?B?ZytkZkNEcm8ybTRoYzRnOFdRaGJxYVFkWW11M0U0VkE4S0dMSkFNdndvMlln?=
 =?utf-8?B?MSt5bDk4OUl5Tm5VUnVMMkFSelhqVlhOMnVDaGJrL05FcXd1anhJcnQydjFB?=
 =?utf-8?B?RFhwTEtRQ2ZTYWpjN21qS3lMOGNFSDNoMW9ldkFlSzhIQUlNUk9EdmJCTWhW?=
 =?utf-8?B?V042Y2RuWHNtOHZBRHpCKzk2cmV4RG1TMStRNFd4cVh1Y2JzZi9VVWt5S2lL?=
 =?utf-8?B?ekRGTktTNFBUNmxwTS9hVGpIZXhNM3ZVNVc3ajh5TlY2WFdtbm44UG1MczB5?=
 =?utf-8?B?ei9mZ2YvZkVpRTRpa09uR3RBbXBSS0Z1NWVvalZrMityT0hmR2pYeXYwUEZl?=
 =?utf-8?B?aXdXZXZmVUZxblNMclpid0FmdzhpL3lHc0VVekZxYUZ4bGc5bS9LeG1CelMv?=
 =?utf-8?B?QXZvMG5XUjdhMVFBZ1pLQi94ak1lSGE2N3RYT3dMVENiNkc1VGplSEovL1F1?=
 =?utf-8?B?WVhqc0FSSEhrZWJTczc1Y3FEZTVIUGdlRCtSeTdrZ2owRDcwS3VNYTk5ZG9L?=
 =?utf-8?B?YVozVnN3aFliY29VaW9zcmhLa3FSaXJ3R0RaZzFNYVcwb2h2ZkY0WTRwSGtG?=
 =?utf-8?B?WVFoTHNZK0pMZkd1dXBIWUlPTzZxcVVDaVh1NWFWV2gxNldWVWpzWHNDV0ZT?=
 =?utf-8?B?UmZ3RnhGcUZ3U2tZRmZINC9IaHdvNGxQT3JNYWlETjkwR0FWMHFKbldCdU81?=
 =?utf-8?B?OFhwc0thbEZNN0QzSzBybmFZUy9YNitqMTdiY0dCbWFneDI5aGpsUkFuWVM0?=
 =?utf-8?B?MDRHWWJ0cWk2aVltTy91aE1hR0pDYzJRc21xVXVrMWFzZXZOTm1WSnVpVFRD?=
 =?utf-8?B?anpTU3ljMDlnRVdFUmdkdWluKys4N2ZnVEwrVDJGL2krdG9TcmtKZ1RZVnBZ?=
 =?utf-8?B?VWRtay9tVlVMSTNaTEkxV3dKdXRjYkFHbVV4ZWpXMnJGWGlKZnRheEhGLy96?=
 =?utf-8?B?YndORTlpbXNWSnFQWDFEdGRoaHdJVEFScld5QzRxRkxHSzdTTTlwWnd4MXA0?=
 =?utf-8?Q?EfgUe3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 15:16:59.5187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbce4191-9508-4995-ec9f-08dd8be7e1b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788

Hello Vincent,

On 5/5/2025 8:40 PM, Vincent Guittot wrote:
>>> commit 16b0a7a1a0af  ("sched/fair: Ensure tasks spreading in LLC
>>> during LB") eases the spread of task inside a LLC so It's not obvious
>>> for me how it would increase "a lot of CPU migrations go out of CCX,
>>> then L3 miss,". On the other hand, it will spread task in SMT and in
>>> LLC which can prevent running at highest freq on some system but I
>>> don't know if it's relevant for this SoC.
>>
>> I misspoke there. JB's workload seems to be sensitive even to core to
>> core migrations - "relax_domain_level=2" actually disabled newidle
>> balance above CLUSTER level which is a subset of MC on x86 and gets
> 
> Did he try with relax_domain_level=3, i.e. prevent newilde idle
> balance between LLC ? I don't see results showing that it's not enough
> to prevent newly idle migration between LLC

I don't think he did. JB if it isn't too much trouble, could you please
try running with "relax_domain_level=3" in kernel cmdline and see if
the performance is similar to "relax_domain_level=2".

I only realized it later that "relax_domain_level" works on topology
levels before degeneration.

-- 
Thanks and Regards,
Prateek



