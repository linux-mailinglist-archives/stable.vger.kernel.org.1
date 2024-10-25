Return-Path: <stable+bounces-88167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9C59B05AD
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 16:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F98284869
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 14:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A0C1FB894;
	Fri, 25 Oct 2024 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fhCVIkGK"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAC51FB8BC
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866190; cv=fail; b=PpiTF1ThUgg08WPCsMUOT+E4Jdh+Wr5pnabr8lFpWp1Gq41524ztoHbLrStE35+OrYyGveTML5EMaKgnK/d2LKxH4mCc7LO/r/MLXctmwsnS4D/w2UwTTIvCWkiUkSMTRHdlQTuN3ZKAAhuXrlVg1lrx9AfTLFK1FQumZrLrAV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866190; c=relaxed/simple;
	bh=QRqTenRxWStole3lwawvVM38gI3Y0e8bQDxmW++dGbE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h+ck+hA4kFoPqQpQv9Vfp/whs/YzvElyqqLxoCXJeS3SM+0udQZzlVL8Mq+njuaGu0fvWjfTZ0ZH5rths6U3B1pmoqXDUOGLuGPO7LkS9gibgcqkB5K1RWkVwpG3ygYSLKPpGKAjRrQsbzB8ekCefcNEu/5fiFFYzu/ec28BMeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fhCVIkGK; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIuq08M/myUhKBAd0VRjrXEt+4F6gL50MQf1ue2j7sFLlcjE7kfXZnuqz+XYreT2uuSysbxFtVYAsAKBnX4vcuj3w65RanCOOfKUV8p3lQyTygQscjuqlspNA0eTTlhsMY21kkf4F66DAMvkpdQcy9MhFhtPZbhLeptxQBLbofdjA39flarhVhdFSdICW9dEmXUA9VXRHE+FlQULdoQSllBp9mwJGl8fDr3k9fnI8PzIo4Iej9FieaOXw5OyqPjGWJevDPhc8aBZ/yyec0vTRtBz2PrvDKtPBhW5ihrwU9caKBnQ0nwkNfiREA1jkhKr/sC/jhB95yQx1Dl1h+a0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/PWItWgEEBSrCwGSUsV+gu7+UVYiMvwEkxtOlC7wl8=;
 b=LqaY/Wb2B4igxOf2Zx3eTf0xcvo05cTIu69qNISHsa3WG2Ks0HSzNA0GcxKU8Y74q/HveGsBUBbsMFbnpaWsFs5DkwneJzZEUUG/hqrSnwmLPtMCS8IE6RRwrT/OjPWFUGKgOkM9LXXww0k42WeJzVVvcUwq0IiYE9YRKY9Mdy6rPC/GxTZQMrQI4HeElxzSoreEQffZis6sjaV6fLZt4MVdu4xWH/LC4DLJnwsawGxnEj+0eqMnHDcxtD7O6evj1AL4R4fHJ21/aX+zNJjOPws64fWXEyiQaU6xaKfkC3biyZwrdqWi6IctwliueAxzGmWnIlBDWym1FlYShTqspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/PWItWgEEBSrCwGSUsV+gu7+UVYiMvwEkxtOlC7wl8=;
 b=fhCVIkGKuAjEs6z4El35ElHpPDSZlwGzqRutCC4zWx93xexj8Oc5GrYDiYODtTLA1ia8kVsWU05sGS1WqH6TDf3D2McfslBmonPbfitOupfo1fEuRekdQIpyuFMwQ9bpFLQOkriuXcVx/LD91ATLuLeyAA2/JiKvGRiGRR8XdtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 CH3PR12MB8545.namprd12.prod.outlook.com (2603:10b6:610:163::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.17; Fri, 25 Oct 2024 14:23:05 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%6]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 14:23:05 +0000
Message-ID: <9323eaf1-d5c1-4153-bd5e-1bc12a4b0bc8@amd.com>
Date: Fri, 25 Oct 2024 09:23:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Vangogh: Fix kernel memory out of bounds
 write
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Evan Quan <evan.quan@amd.com>, Wenyou Yang <WenYou.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
References: <20241025141526.18572-1-tursulin@igalia.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241025141526.18572-1-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:806:20::17) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|CH3PR12MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a195c2-1a5f-40b5-f9ac-08dcf5008a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUxCVGphMUhpVVlaNWhvUkprdGI5b0s5dGJtWVp6L29EQU1jbzJnWCtQbmNw?=
 =?utf-8?B?SVpleGNMdnVMamw3cEtmZ055a2tzc1dSb3NPVUJuYzZSZ05UY20yOEg2dzR0?=
 =?utf-8?B?dDE4ZnRvK2dYSFMvSmEzUnpCczVpK0tSR1dPSGN5dnZDV1k3aEg3QlBrQnEw?=
 =?utf-8?B?QU0vZjBQVjNJd2ovb3NBTFcxZ2hua2N0N2JUakFDWEpJU3lzd1RVbnhoUW4y?=
 =?utf-8?B?ZE9qZW5RZHcza1d0Zkx3aUFXdnVncDI0VGh1bXhmZFpuc0dSejA3WkJHYzl4?=
 =?utf-8?B?VEc1RTZiWjk2ZXk0dVZ0NmxBUHpFWWo5Y2RTTW1EbEQwK1dDdHlnRUlHdkdM?=
 =?utf-8?B?WEIxT0VLdVNMT2N6NlBqbmtXYzh1WkdtR1B6ZXlINVVmZWw2My9VaU9KdXhT?=
 =?utf-8?B?TkMrNnlzMjJvTTVjN3piOWpyZ3AzRnl6SUVsaVJ4WXE3Z1o3UGJkaE9WTDlx?=
 =?utf-8?B?MmNpU2JhT2ZkQkx1dGkvVm5oc05LeWg1L25nK1dqTDJJMzdMcmdWT3BQaUJU?=
 =?utf-8?B?cW1tVVFha3hsWk5ycWNTSUpFUzBYTDFvTFMzUnFuYndSNlpibnNUUjZXeHcv?=
 =?utf-8?B?eFNCemdxTk1tSVNqTTVYdkJCaVNrZENYL0RBRVJsYzBEZkJtL0U3c2t6M3FD?=
 =?utf-8?B?cjVGekFZRWdBdWV6alRYdllVcCt3cjV1SW5FMkdqZk5OVXcwcnhTOGhUK08r?=
 =?utf-8?B?Qk1vSGNVZjJtZ3BMV3JJMFo2S05MWHk1WEpqcmpabXc4ajNBNkppNjdQS002?=
 =?utf-8?B?Rkp1Zmw5UXZTTE1XanM2V1hSSkJXMDgzWVlQWXJPS2c2cXN1N0F0N3VMRXgv?=
 =?utf-8?B?dEpHbkJ1akVqV08rcWN5SkJOQkx0VDAzQmRTTjZWd1YwNXdFaTJGYnVEaCt2?=
 =?utf-8?B?cE9PSXVaaDBZZ3ZDR1piV0F5bi84T0pBalNTbnluQnRqTEYzSS9RODdNcUxU?=
 =?utf-8?B?VVBJdUZPQVFEOW9vdFdwV3F3bmcxMDA3RCtsZ0VGSVg2NllvS3ZMQjVmNjR4?=
 =?utf-8?B?Q0o5Qk02QjhKc1lxTUxQWXlKOEJkVmUyNmM1LzdDZ280aDRxckZYakZ1R3NT?=
 =?utf-8?B?Q2xOaWJjRFYyendnbXdjbFRzS2tPWWI1QmFERzJwS09GY2tJSDZjaFYxZGY4?=
 =?utf-8?B?S0pwOGhqNzk2czBob2xVUnAzWGpUS3pQSW43M3EwS2FqU3hSNWJweklvNFdw?=
 =?utf-8?B?WUw5ZFo5TXM0M2R6RFRmSjBiTFVNYW10K01LRzhLTko0dllUOUV1Qmt1ZjUz?=
 =?utf-8?B?YzZpV0F5WVgwVnJNbXFKWUJrQ1JEeGVhSHNaQ043MVpZZ1lpa2lzd3VDU0M0?=
 =?utf-8?B?eUFYVzBYZDJlWjcxa1IzajBBS0k4dzJqOGg0N25jcE1yeUV1TXdic1Z4MUdE?=
 =?utf-8?B?RDBza2tmWHJCS2NLSXBxWjNqTXNnbE9yc1Bqem1zQXUxR2lKZHdxRmoreXdC?=
 =?utf-8?B?SWNQV0d3TUVPemdzRWxXbEFkMStWOHE4V1ladEwwbGVrdnNBSXNPWFBPV0hU?=
 =?utf-8?B?emtjdS9LeFJhbVdGK2U2QmVVdnY3OXlvNVAwUUltdnVlbHRUTVNwVFV6TmNF?=
 =?utf-8?B?OVdCeWhiTkZXOE1PQjh0UnFKYlR6bmZ4dlhzdTNvUiszMHVoamREUHlnWVF4?=
 =?utf-8?B?d2lBWTRpOFRvRlJRUDhvRnBtZlhMVFhXMXM4b3lwT04waWNTUVZ6b01EcXpx?=
 =?utf-8?B?L0RBM095WlY0MGpLWFNzZnRyaG1YTGRBd3RoTjl4NFRXcWJaK3l0WXBvNzlQ?=
 =?utf-8?Q?9+3PGFlUZbzOri21DHOzyLP8gpxNv+1c1DtPpZ+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVByNXJqVk1STWx4dFNpVDlzcVhCbjd6WkFWMjkxU1RTU0VMUVJadlhVbmJI?=
 =?utf-8?B?c2w4TFA3VkdTdEZSWkgxeEp5YTcyVDhmUGFOUk1wMC8yWmxBdFF0NTdyTVpD?=
 =?utf-8?B?dExJeVFaM1hVSXVzUU9QQ0VPRVAyZ2JDMktZZU4vdUk3NUI1bkVvRE9ITWxn?=
 =?utf-8?B?Qmg3NTQ5d3BIOFNMNC9aczZuNHkwcmxtdE5LcXV3enNjNVNDK3gvK2I4dzFK?=
 =?utf-8?B?aHFFaVdyOGtUQ0JxWG5rOUI3WHcxRDVTSjluS29jdXRmdVRaRmh6ZGZvVDM1?=
 =?utf-8?B?NG4wTldXa0svdDFrNHlrOGZWQUlFck5WamlsaTJFNzV6UldqRWZTVFN4cWpV?=
 =?utf-8?B?MDZHcFptTVJIWEhNWGRkY05iam1uMHJ1cmhDZ2ovT2x1aWQyZUM4MEVJdDlF?=
 =?utf-8?B?QjJTZzQ0dTRzaG1Pd2lQWXhnL2tiOXpONWR3NGt5K2VMcUhTSEJjQlRyMHlr?=
 =?utf-8?B?YmRFYjBnR0VOK0JJUXJlcGc3SlpTVGcvS3dMOHlFNWV1ank4RWROSUFQZVo2?=
 =?utf-8?B?Sm1jRzB1Qm52NCtCMTFCWGpTOVFOWHBFMkY3bStxbm5lSFpUc09McmNiNytr?=
 =?utf-8?B?RDVXV1FIUlBEVGxaT0szei92am5sWHFydXBWVk9BOGxmeTh2YTJzeFJTMFVk?=
 =?utf-8?B?U09EdmFicE9wd2t1ZGI2YXpINWE2akt2R3BkaGlPUjhzSWVmR3NyZ1B5REE2?=
 =?utf-8?B?eDh2WTljN2FkcFFkNnFNcVB1dmJTeVJOU1lIMGRjd2wxMlNEYnVTT2QycEtF?=
 =?utf-8?B?OEpuTDQ1aVp3UXNWUW13QWt4NHZVRDJveTVZcXpWOWZhNGhVNnB3ZG11cDZs?=
 =?utf-8?B?MUJhcStmTk9UL2FvVGM3bGxmU3NveGpoYUVETXZnNVRQMmcwK0NyQ2NnemdE?=
 =?utf-8?B?eG1QZGFERU05b09lOStGTCtScXlpTUNKbmpCYnBoNnVUdEMvVEV3QUFuSkU1?=
 =?utf-8?B?dHQ3TDVCZ08wY1pJS0k4UTczWTNRVWRWdkJFN0E0L3lhV3pKSEtFQjhZM1JK?=
 =?utf-8?B?S0hOaGZGSG9RbDdaTnpzV0p2OEVzWGhsa1RzM3UrZGNlTEpaaUROWCs1bGJK?=
 =?utf-8?B?b1h5MHp3anpNMnh2SGczQnRzU2ZJLzBtRG5OdHYwQ0hKcWRqQS9KK1ZocmV5?=
 =?utf-8?B?N285SHFFUW1wY3g4LzV3U2xlQ1I0Q3p0dE5jaC9VeHIxUEF1ZHVadkZLcUNB?=
 =?utf-8?B?bFlFaXJLZUMwWHZ4NXE3VlNwZklSS3hwYWNoaTNVeXZGT3FEVUVseExHdXBG?=
 =?utf-8?B?bHloRUxlTDZBYWpVbklyeVZRdGc0V1UvWmt1VTE0T2hOa2d1dGMram11aVZS?=
 =?utf-8?B?Wk16SEs4T0dLd2ljVExUZXd4U0RQVytuUVE1YVRHNk9xQ3lXcmpuTjl1bHJv?=
 =?utf-8?B?cHUyRzlMQkJaazVPNGttL3dGdmJZT0s5dGc3MlRvVG5ibzFCQ0ZTWHBVb1Q2?=
 =?utf-8?B?R1FvdjBjOGxyWjBDVlRVVzlxcTd1a2toNDM1ZDdLRTUzRFUzZFZ6clNVa2xV?=
 =?utf-8?B?Uk8zUENvS3kraUVSTUhWOWErR1MzdUx5UjllUmU0ZStkMXVjdmF4eVZ3SXpV?=
 =?utf-8?B?eUVXRXhGWmZzWTc2S3pyWjRkOXBsRFM5NTIyKzltOEZxMVVPVEl2R0wxQ3h4?=
 =?utf-8?B?ZUloUVBjT1NDY1ZxYjlKSWdQYkFFOVVEY0pYWUprUVZVQnF4NkQ1QTFkR3hx?=
 =?utf-8?B?ODQ2NWpBaTdjcHlGQTN2V2FLdzlDZ1NpWmFJWFAwUWRrSnVMTlIvcXRBcXBv?=
 =?utf-8?B?cTJ4a1plNWFnU2lUZHN2bG95YUM3eWxtTk5zb0kwU29nR0wzVSs4M0dkY0RN?=
 =?utf-8?B?ekorUTlldUxEZ0RrVHRMVUhJbkFIazI1Z2txUno5QWhhN1ZhVDVwcm5TTmJS?=
 =?utf-8?B?TzFnOVc5QnFiU29Dd1lWUm1lbWRISGRIaExjMi9hUDJGOWFxMi83MUhrZUpD?=
 =?utf-8?B?ZTVyendXY0RsRmVBYkZUNCtWelpFM0N0Mk9VRVphekRXS01vMC9NeFVHaW9I?=
 =?utf-8?B?UnhlSW5xVVNwQ2xMYzlHMkRrV3BHVzEyWk53QTFmeHRLYzlDWllka0dMaUx2?=
 =?utf-8?B?WWpMUzhyb1NFWGVYUWUxby9ZRkZMN3VpZjQ3cjVWd29YYmhvQmxFM3R5MmlF?=
 =?utf-8?Q?MaCy/WnlSyzgQJ3dXA7CDLXuL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a195c2-1a5f-40b5-f9ac-08dcf5008a7b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:23:05.3314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sXnVWCbHxoj2Kz2sS0toehFIwRGe1NEzvb+20w9QLRFAvzuhXimEmKJfI299bbTbqXxc4ONJEOQng+mjiZe6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8545

On 10/25/2024 09:15, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> KASAN reports that the GPU metrics table allocated in
> vangogh_tables_init() is not large enough for the memset done in
> smu_cmn_init_soft_gpu_metrics(). Condensed report follows:
> 
> [   33.861314] BUG: KASAN: slab-out-of-bounds in smu_cmn_init_soft_gpu_metrics+0x73/0x200 [amdgpu]
> [   33.861799] Write of size 168 at addr ffff888129f59500 by task mangoapp/1067
> ...
> [   33.861808] CPU: 6 UID: 1000 PID: 1067 Comm: mangoapp Tainted: G        W          6.12.0-rc4 #356 1a56f59a8b5182eeaf67eb7cb8b13594dd23b544
> [   33.861816] Tainted: [W]=WARN
> [   33.861818] Hardware name: Valve Galileo/Galileo, BIOS F7G0107 12/01/2023
> [   33.861822] Call Trace:
> [   33.861826]  <TASK>
> [   33.861829]  dump_stack_lvl+0x66/0x90
> [   33.861838]  print_report+0xce/0x620
> [   33.861853]  kasan_report+0xda/0x110
> [   33.862794]  kasan_check_range+0xfd/0x1a0
> [   33.862799]  __asan_memset+0x23/0x40
> [   33.862803]  smu_cmn_init_soft_gpu_metrics+0x73/0x200 [amdgpu 13b1bc364ec578808f676eba412c20eaab792779]
> [   33.863306]  vangogh_get_gpu_metrics_v2_4+0x123/0xad0 [amdgpu 13b1bc364ec578808f676eba412c20eaab792779]
> [   33.864257]  vangogh_common_get_gpu_metrics+0xb0c/0xbc0 [amdgpu 13b1bc364ec578808f676eba412c20eaab792779]
> [   33.865682]  amdgpu_dpm_get_gpu_metrics+0xcc/0x110 [amdgpu 13b1bc364ec578808f676eba412c20eaab792779]
> [   33.866160]  amdgpu_get_gpu_metrics+0x154/0x2d0 [amdgpu 13b1bc364ec578808f676eba412c20eaab792779]
> [   33.867135]  dev_attr_show+0x43/0xc0
> [   33.867147]  sysfs_kf_seq_show+0x1f1/0x3b0
> [   33.867155]  seq_read_iter+0x3f8/0x1140
> [   33.867173]  vfs_read+0x76c/0xc50
> [   33.867198]  ksys_read+0xfb/0x1d0
> [   33.867214]  do_syscall_64+0x90/0x160
> ...
> [   33.867353] Allocated by task 378 on cpu 7 at 22.794876s:
> [   33.867358]  kasan_save_stack+0x33/0x50
> [   33.867364]  kasan_save_track+0x17/0x60
> [   33.867367]  __kasan_kmalloc+0x87/0x90
> [   33.867371]  vangogh_init_smc_tables+0x3f9/0x840 [amdgpu]
> [   33.867835]  smu_sw_init+0xa32/0x1850 [amdgpu]
> [   33.868299]  amdgpu_device_init+0x467b/0x8d90 [amdgpu]
> [   33.868733]  amdgpu_driver_load_kms+0x19/0xf0 [amdgpu]
> [   33.869167]  amdgpu_pci_probe+0x2d6/0xcd0 [amdgpu]
> [   33.869608]  local_pci_probe+0xda/0x180
> [   33.869614]  pci_device_probe+0x43f/0x6b0
> 
> Empirically we can confirm that the former allocates 152 bytes for the
> table, while the latter memsets the 168 large block.
> 
> This is somewhat alleviated by the fact that allocation goes into a 192
> SLAB bucket, but then for v3_0 metrics the table grows to 264 bytes which
> would definitely be a problem.
> 
> Root cause appears that when GPU metrics tables for v2_4 parts were added
> it was not considered to enlarge the table to fit.
> 
> The fix in this patch is rather "brute force" and perhaps later should be
> done in a smarter way, by extracting and consolidating the part version to
> size logic to a common helper, instead of brute forcing the largest
> possible allocation. Nevertheless, for now this works and fixes the out of
> bounds write.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: 41cec40bc9ba ("drm/amd/pm: Vangogh: Add new gpu_metrics_v2_4 to acquire gpu_metrics")
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Wenyou Yang <WenYou.Yang@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: <stable@vger.kernel.org> # v6.6+
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 22737b11b1bf..36f4a4651918 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -242,7 +242,10 @@ static int vangogh_tables_init(struct smu_context *smu)
>   		goto err0_out;
>   	smu_table->metrics_time = 0;
>   
> -	smu_table->gpu_metrics_table_size = max(sizeof(struct gpu_metrics_v2_3), sizeof(struct gpu_metrics_v2_2));
> +	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
> +	smu_table->gpu_metrics_table_size = max(smu_table->gpu_metrics_table_size, sizeof(struct gpu_metrics_v2_3));
> +	smu_table->gpu_metrics_table_size = max(smu_table->gpu_metrics_table_size, sizeof(struct gpu_metrics_v2_4));
> +	smu_table->gpu_metrics_table_size = max(smu_table->gpu_metrics_table_size, sizeof(struct gpu_metrics_v3_0));

AFAICT Van Gogh only supports 2.2, 2.3 or 2.4.  I don't think there is a 
need to compare to 3.0 to solve this bug this way.

But generally yeah moving the initialization to a helper that actually 
knows the size would be another way to solve this.

Or looking at it how about moving all the conditional code in 
vangogh_common_get_gpu_metrics() into vangogh_tables_init() and then 
assigning a vfunc for vangogh_common_get_gpu_metrics() to call?

>   	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
>   	if (!smu_table->gpu_metrics_table)
>   		goto err1_out;


