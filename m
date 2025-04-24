Return-Path: <stable+bounces-136613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB09AA9B4BC
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 18:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7B53B9C4B
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 16:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2912820CE;
	Thu, 24 Apr 2025 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MXcfwH/j"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EC727FD53;
	Thu, 24 Apr 2025 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513821; cv=fail; b=XlWZj6laT8qdqUmm6q2370jXnxKKafivXi4sUfXr1mzyO+H4N9zHGKtvkiFuqXX1zZJFzO5cU4sK9vMdXKEYoqz+r2jGqumoz+zPBnvEqPxXXbWgqQAEMnCEBxv6yExRNInGBDHjzvHksmByJP5EWU4BZ6hapyvFzOx2RBsCBPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513821; c=relaxed/simple;
	bh=tqxCtp9lVwSwSSGaLIX0GDJ5SFtKu9DdagmBOGk4GFg=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=mt8evsHXdQEQfWpn24NTZRrT0Yxjajp6s4z+/VLapDOUmQeG1KtpasLXlZUzV74cAAbspmA+79E8JCuF7DThOC1pIusV9Q8Cka9bNWJ1+FJpt/oU4N141QL5z7coOUZdCXYj8hAFP6Mk3X8XeG+BKGb3JC4+zgwl2eg3qmX7YyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MXcfwH/j; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLo3EbFLreOar/am7WMYVJyVgkDve9YrmmIDTFBVCUP+bMtQ4TSSbpixc25xwtENQje3LvoRY1AZuMI3YXDiNKAQJOeqvSeVtwmsLqdJt8QkJrDesYAVQVFFXmijRAzaqk0WMWmu94smDoHbS0ymQWJ3ve9DH2kluPHEJGaaW5o2kbAirtbTqAgTfUND1HpLtb3pdnxMVsNeqQoaRP5dclkBjcvHqW/yQ09hGBTrt82kd2wCGvZVj5IGb3JSV5uG5+jekorXXIgLlFkOJ+FECBDRXhVGa9M9T+8PAASboy+VDl7QSbq1sVL+Lfw7txw4QvMoEU1uynZkjuPJUpdK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVJIz3WEPGZ7Oiu34zzovyXrHYy6Zw9EKaR8dXQO80I=;
 b=kFvVhilMR0NcLjnyArp/lOJXsu0KmSOMZ2CdEmmEWMKsQ8IOFBnAEwOvwzQfypU2zOYBr0f7KCu5xL6piZpzBq9OfcNv+I9w8hzvRadcj9dJ7xkTisPfiZiY3wjuFuo2lrpGUCIdLgZD/EATDMMV9y7zB2aEt0dv6v3XjxoXk0xHR2kxKGc3hjFqBhNanz/OZ4DRg/H1V13ivHgdF1KRlEktje/ssGw9y16Jx8vJHGs+IZcAXngzwD7KCkMCJmBn/yy2e4DZKb3Cq9VjcbzO/uNDbx6jz5pOhVMzKzagZ92mcvEi0HNGXIH39YAIcQ+gDh4Ijiutz1euRVolKoadLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVJIz3WEPGZ7Oiu34zzovyXrHYy6Zw9EKaR8dXQO80I=;
 b=MXcfwH/jVk8bdJrkxIP/MMSqjUxj/OJqGZd1aWuzJYr/Ws9kQ5VtViDj+dL8qs8rBK6A5KijTdqs0A8KBVjazjfCIvS2gHU1VnZW3Jf+uv5nbW8lhVSDG+x1MLC+bvSCh251BwLCzU1KrKDUojLgqHTugMgSwcMIVOsvq72u+wX0fDIWMkWDyWE+Px6vIBhwKwEEE1qcopWZ77kB8XDvzSouzjvdb016tf3IkPOqxNOLBuaMWupYu+xMSHTpedb0Wm8va3hkfESnrUXi/U9d51b386u4yXum7qNcuVNGCO2xuxVpoy4g4SKRHdKNLDuyVb8onaZcO6rwNg91mODKMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 16:56:57 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 16:56:57 +0000
Message-ID: <ec5cf6b5-a32e-4f98-a591-9cb13a9202e9@nvidia.com>
Date: Thu, 24 Apr 2025 17:56:53 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
To: linux-stable <stable@vger.kernel.org>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>
Subject: Stable request: net: stmmac: resume rx clocking
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0458.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::13) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS7PR12MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 876d1dc1-6fa9-4e2e-f14c-08dd835105ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NW52MnppeHFqRWZ2aVBMMWJ1WTJmbThqcXAxSWFCTUVsZGNHRUZsMFozaklQ?=
 =?utf-8?B?TjB2TmdUMWcvaUNBTWk4ZlQ0OGVCUENDYnl3M1FLc0d6WXlZenVieTQ4VEUw?=
 =?utf-8?B?NWxIcnA3QXpxZWcrQlNwQmRzKzVwYTc5cnNTUzFqekhreTY1R0tZTFB5WkxZ?=
 =?utf-8?B?RUNma3RsOWNrVjlsYThjS2JubGc2Qm9vRytDeGtaYWQ0Zm9Sb2Z0UTMxNTBL?=
 =?utf-8?B?cEQ0bmdJdjB3c0sxS2Y5TXFmbEVqekgwdEtsZ205c1dvVmx5Uis5cWwxWnRZ?=
 =?utf-8?B?cFQ5ai9YMlVGN3d0NmZLTjRMb0RER2wwZnh4enc1N0VWTUMzcGJYTkw3VGNW?=
 =?utf-8?B?Q2V1WEI3V1FWVnJhNUxsMTJoL1V0RVh3T3VwM2hDaDVsdHVRSzY2a2w1WlVU?=
 =?utf-8?B?NW1tT3pHWllTejZianYzTHVDSi84cEVodkRpY3dVVmVWS1BlaGtXRWJsQmcv?=
 =?utf-8?B?bHo5ZzVPOGlyN0pZNnlObnRBbE96enZzc1pOVU43eWF5TmJVaDlDejBUbURT?=
 =?utf-8?B?NEhRMk4xV0g1VUpWN2hVVzNxZTdpZVJrbGhuREFDOU5IL1FMZTNGYk93UHN2?=
 =?utf-8?B?cVhGamlwbGxkTUQ3WjlWcExlcmNVeXFTV29MejNXeFdMOGNFZDdQb1p3MllT?=
 =?utf-8?B?Q09NWVIyaXo0QTQzRk85OW9leFUwVTIwY3YrWkVDOFdjbUcwUFBnb3gyWHVn?=
 =?utf-8?B?aXNNREt0ZFhtNTk2Tkl4UjQweXQzL21Dd0trUjhMK2lPUlhhVitFanZkb0di?=
 =?utf-8?B?OEc1bmFjblFRZ0RvMEFHcHdoMDM1Szc2M01YOHRZM2lxTTZlVldPM2hRM2Jt?=
 =?utf-8?B?L09YZEpxcE9ZWlpOMVNWSkRFU1kxLzREZkpQbndIYkJkcHRiQmJEd3BBTmxY?=
 =?utf-8?B?U3RCYmlvSlRTc1M0RHh4cnpZM1FtSHllZEdlV1o0TmFzSk90djYxN3dsTjFK?=
 =?utf-8?B?VTZOYlZacXpFRnEyN1owdXF0ZEt2bU82TkJxRVE0NWFGLzlGbXZGZUl4bU1G?=
 =?utf-8?B?c0U3R0QzQ1BGVU9LcCt5d05BMWE3Q1cvdGNra2JQRjNpcjhINk13UFhGZ09P?=
 =?utf-8?B?bUswSnVibStxM2Y1bW42Umc3bTZTbkhySVo4MTZqQitOeTd2OG11SkF6OWRs?=
 =?utf-8?B?dk9YMUxJajMxcTEwUEZnemxjM21LTzJUV0JFcHZTTDROQU5DdHJKaWhrUE12?=
 =?utf-8?B?KzNOV0hCbEs5aktIem1JQ21Dbmc3S0h6Sko2bDArNTZqUTB5UGxaTDdGUU9L?=
 =?utf-8?B?bnczR0lrZXdBVUdzajFFOHRSa3RQejZDQjBzdDF6ZCtKczFvWStwdFE5dmJU?=
 =?utf-8?B?MDc0YkxmQTZ2SU1NWVJ6enVWREwrM2dsM2p2a01SZmlRU3ZSbCtJK3dMYnI4?=
 =?utf-8?B?MjBreVlGQnBQSW15VEU0WUFJczFndzZWYm1meHV1MVhjOUpqaEh6ZEVjb3ZL?=
 =?utf-8?B?VU9nYkFxalYzMjlRNk1xYVo0UHUrbXpnWXdtM1ZQR01KTHB5eG12MGVxWUJv?=
 =?utf-8?B?cGFtQjVxYTJJNlBvY2F2ZTdXdVR3NnhIbDU0ZXZ1dklUSnBoTE43MmRNUW9w?=
 =?utf-8?B?ZThqNnJZaWc2SVpiR2FpbFE5MEhKcUd6UmxwUndxeDB6Ny80d0JrZytzNUJF?=
 =?utf-8?B?bTFSc25Zajh4dkIvdjRoZWdRbGJxQ2l3c1BGSEdZaFpneU03SGdvV1Rrd0I3?=
 =?utf-8?B?bWJPeThKOVZDMHc3dXpIRUsxUm1TRlBKZ1AxUVZuZGh0NU9DTWdManpjbkZV?=
 =?utf-8?B?U25nVG9pUzgrOFdjWW1DRk8ra0xmdGxhY05sZ1l0OUowdVJyWXU1ZDZoNEN5?=
 =?utf-8?B?ZmNNWFlzazZ1OEZQTGNjRjA3SXgvUmFuSi8wQkJodUM1aU1lZGNKcFQ1MHh3?=
 =?utf-8?B?Q2YxaUlSRktsQXhZS1M1RytSdjNqOUlxRERoV2F5QUIxNGd3ZndXcFVPSzVE?=
 =?utf-8?Q?kRg2wBoDrXo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG5rOFh4MUkyUG5KeXUrbG5yUGJLYzltbzIrNU5LOEFTZEVxb0pWUVcvNkUz?=
 =?utf-8?B?M2V0KzBJa3NxVW9jajMyejBZV0VGdnZYYmd0ZjFKR25QdGw4WnVBdkZ2bnpM?=
 =?utf-8?B?d29Za08yUkhGYnVPek53bzRONnJ0L1ZQKzNURVlzRmQ5NngwajEzMHVOOVJC?=
 =?utf-8?B?Y3ZYRUZJODVJR2MzOGd5MHhlcys3YjJLcmJEdEMxUmNjU2JlQml4bjRWcDBy?=
 =?utf-8?B?NnNLRHU2YVVqS1RZd3hIL0VoV1JMK3Y5QXVnR213bitYWU5JYlhmcnpLS2NO?=
 =?utf-8?B?d1N2UTJZMFQyMFVVOVBPaHZOK2tLRDdlMzRaVFpwb0lUYzlsN0c0NHhvYXJk?=
 =?utf-8?B?UHUvTS93NmlSMStlWFZVMndySjgvd0xpZW1NVVBmQ1FISld2REUrSnYxNTd1?=
 =?utf-8?B?My84VWlCTTFGRWtselBhWDJyVlRtWEh5WkRwWjZyVjZyeHlSUjV1UVR2TFdo?=
 =?utf-8?B?U1Z2b1MxcEM1ZjBaNWpnRFQ5NmJPZXVlZlZ3YUFrMXNaV045TWtaMXZwNitU?=
 =?utf-8?B?aXAwZzhGNjRBeVNCTWtoVGFEL1dJMXRzQ1hsWTFYUit6NG1vQklFZlEwK1dr?=
 =?utf-8?B?c21sUjNObnpHNzBUM2ZNdHcxeU1keXpFQTZPa0xSRWFMMVQ5SlBJbHJzSHRV?=
 =?utf-8?B?QTUzb2U0VTN4SEZSZUh4Vk9SSjV6VVNDUzBFL3BvVlZBOFBSbHJoYUNMbWFK?=
 =?utf-8?B?VXNyUXNPQm4vUFo2N3dsREFGdjA0dmloZldsRDNaYnVUQVY5ZDVxVzk3UU9i?=
 =?utf-8?B?dy9ibUVYb3JmN0E5ejd3cnFncHFjUk9qYk44ZlUzRDI1MGxwdHRVTUJJVzAx?=
 =?utf-8?B?bUI3ZTYxZzhsUklMay85MmhmZXBkSURMVkNkbVVlNjNKai94Qnl4eXJ3QzJU?=
 =?utf-8?B?QTdIK3kydXN2ZDFES0U3RGNkUHFrNzZSK2Z5b3d6N2lxTFB3NHNXWmhlSkNj?=
 =?utf-8?B?REpjM2hGcUpWRFAvQ0NHb1k0K1RBalNUMEFUTEFTYXdadFdTWml3alV6a3pD?=
 =?utf-8?B?bGhSZlFZL0oxOG82Qkx2a2lreXU2bUliVFJBUENZSGUyUXcxb2p5dDl3NFFP?=
 =?utf-8?B?VmNTRnpROXgrV3dFMEJLcERTaVRtdngxc3lHaHNxNUlwMDRWYlg3SjRWY1U1?=
 =?utf-8?B?MGlTN3E0Zyt5b2NQRUlBcCtCa1dmdVk4RUpXSHk4SDc0bVIwZ005dy9GdFAv?=
 =?utf-8?B?OWF4ZEtaQ2d3MElrQkRmRTdoYWRmWVVtN0J1NStEdmVNOCt1MlVXWTk2TGpW?=
 =?utf-8?B?eTJSNUNVbk8wRk9QTXQ0cGF5UjUrUGFvSTNCVWg2dDNac1MzelFMdnJpb09w?=
 =?utf-8?B?Rnd6Yk91THdvUUdGejdCWDVPdEw4Uy9SZG8rVHdUWHlvdHQ2ZFNrVWQ3VENE?=
 =?utf-8?B?dHhzT0tId3BNVExOc2xlamhUOUtyVHlFa3piWGZ3RExYYXB3QlVkeGFKQWcx?=
 =?utf-8?B?QlFzWmxwbGZteVQ2T3RKYTlqbVprTlRJMGxLeTBHbVdFN3QwWVhmb3hpKzR6?=
 =?utf-8?B?NjlIV09qSi93UlJDRFRkbDQ2MDJrYlkwZ0h3eDFuelZva3FydDAyZTdyNGkr?=
 =?utf-8?B?MGRQTWY0Z0l6NDlzZXNock45c0lodVVSTTlTQmt3dzhWK0pjWW9ZUE5hSHNQ?=
 =?utf-8?B?K1NOTDB5dDdDVEEvVlV2YThaR0dJMVVKUGVPdGxSQjBMbDNRaEcwK2M4c2xu?=
 =?utf-8?B?VnNIWWcyYTRibnVHMVRteW5CR0Y2MzdONm95V051OHdoWWd0cnNuU3dLS3lP?=
 =?utf-8?B?N2ZDWkU3RW9pZTlneEIwSS9NTUxrNE9SQTMwUzEzQlRlV2lOK0hmOVFZTEp3?=
 =?utf-8?B?SDBjZjlybzlsZGtEUnVhdUpGYmNjVXRwOGMzWm8rSnMxY0FpQ3lZbVNMb0pQ?=
 =?utf-8?B?bUJlYi9OZ25Fcy9BNTB2Z3dSa3k0NUdkN3B5MzE5SUg3RVl2M0U1S05QT05z?=
 =?utf-8?B?RUd2RVhJUUFHcnZKcXlmWlYxMXBWRHI0RHE3LzNNSDJTRmtRZ1gxVWlYdXFq?=
 =?utf-8?B?eVdwbTVRd0JtcWZsV045YkxsV0gvaDhzeDZHTFdJRnhJL3NObGtJMmU3NmMx?=
 =?utf-8?B?Mk5YSyt6K1YrZ0pJTCswTWZ2NWVHRWx3dVNlcGtSNy9RQ0VUelpHRnNXd3hI?=
 =?utf-8?Q?t9C7bLLdQF/Xt49+kMGid0IMT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876d1dc1-6fa9-4e2e-f14c-08dd835105ba
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 16:56:57.1865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qH9GcQ2mytuWcqvM/G9QvemgdUo04q4zWyPH+4P8fSZ3vYpZuhokyGOKr9GH/+chtaBX9aZvzDKzX6z/YfRbjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417

Hi Greg, Sasha,

Updates to the stmmac networking driver in Linux v6.14 exposed some 
issues with resuming the driver on platforms such as the Tegra186 Jetson 
TX2 board. This is why the suspend test has been failing on this 
platform for the linux-6.14.y updates ...

  Test failures:    tegra186-p2771-0000: pm-system-suspend.sh

Russell has provided some fixes for this that are now in the mainline 
and so I would like to integrate the following changes to linux-6.14.y ...

  f732549eb303 net: stmmac: simplify phylink_suspend() and
   phylink_resume() calls
  367f1854d442 net: phylink: add phylink_prepare_resume()
  ef43e5132895 net: stmmac: address non-LPI resume failures properly
  366aeeba7908 net: stmmac: socfpga: remove phy_resume() call
  ddf4bd3f7384 net: phylink: add functions to block/unblock rx clock stop
  dd557266cf5f net: stmmac: block PHY RXC clock-stop

I had a quick look to see if we can backport to linux-6.12.y but looks 
like we need more commits and so for now just target linux-6.14.y.

Jon


