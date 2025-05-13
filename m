Return-Path: <stable+bounces-144192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0C9AB5A65
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD081881F4C
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 16:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5C62BEC5B;
	Tue, 13 May 2025 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xjzdO+HM"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7955012CD96
	for <stable@vger.kernel.org>; Tue, 13 May 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747154414; cv=fail; b=ZjzLxaELFuqBqpvFxkzQDv8FOHvy1aeWeT4iraBao7M54xE1vAwQWJW8pW0x62x91UEO62MSfaVPr3fBZYSmnhMKtUobuA5r8iPRLP6CuXh1xQeeZ5BqjG/ipHwou2LbKO9xKHrIkBBELCqCLcEkt5h/WNYA2kaZz1ug9I24Dkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747154414; c=relaxed/simple;
	bh=YRBwjvBEv4f1W1y1u670Pl7/lKjUuc8jeR2Bx4oq1QA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nqz0tlj7ZzSopeLPSo87iFChKQZToXq7oFCEPjZujV3ZA1jP05xP/sN2npo+HszkY075Jf4O2xspoR2UPe1UGZkhD6mLuA43RhMKk/mmXdYYS+1x41QklnAVHC/2B1hNn7UZsJUC6wi4bJiy+4LIli4upK8wbSwRHclzG5EIzjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xjzdO+HM; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsXL+FjsWRrhiPI+I/hFOv57pBQ3c5fWAONfg2iq8rDKwYg2N4eGoaMRBuFdeJvDPHVDhoRyO7L+KWcdwqlL2AtMov0QhOT1lTOl+JTYbzvwAR7WZiQOTouGHwOh39YOv7LQjaufe0olqSCeyu2u7Vky5dLMzArGAtKPJi2qPHd1TR6jT/8Q6+uPT3dK/jNTK2N/uR+uis5dzlfOTsms6F20kq9VeOcuDccgKGHouZ5cHQ9o0AElyTdYzAo1D301ARJeO89YkUZDzwCfgQo7Vtov7XIbqHuPD2141+wtXOaUyNNkTdlypZbOo1I2wOPWNQOZVnPrk3RJSbZm+2Ymuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Fj73A//OMlF8+jgAvtMRaR70ZTj2T+GWZSnNIWL7YA=;
 b=r231ezFdlSg3kR7EztzBuoI5w41CLYYR9JOj606kypCISLCTeV6KiLAxMuXNU3Shx0Tyw43sqTG3LmiENes1jt6Fz3ASmZkhMGc0l3W2Z0ONjdpeQCybhHEtZ7Whs6qEx4CWk8VMI7mgp72BcFF15Iv8Cx69ahcaq65WF/15nA7UAqbr2YYWwmbMXp33Wrzeog56vXTGQtSGmtjc6c3kmlArY/49Y7Ub1vxAgqEXUy5i89W32A0uv6cckFGAPcWImnHuDqjef9Ngcfvs6vtkAbIr12HDK4LNa3iavjL/BUtOrIa0yDnGsRzXNcZRI1cqzetd9B/Xx6r4uhMpCYeiUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Fj73A//OMlF8+jgAvtMRaR70ZTj2T+GWZSnNIWL7YA=;
 b=xjzdO+HM+9vpN8ENqdOlzgkvW0vDp47xLI0Lafk8pk7MUn4VhLxLoafNnBJzzBBKM9exuLwA8/cSSKuvgW+iQSh3p+ZlxC1lKKNhVL04xF8tr4mDL4csPGZ3MjeIE5wr34gXzjyntKEpb9ZEs4+v9IowvPM3aP+5oqzYvSLTfDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 16:40:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 16:40:09 +0000
Message-ID: <ed626b21-d1e5-4618-a9f5-b484676958b8@amd.com>
Date: Tue, 13 May 2025 11:40:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: read back DB_CTRL register after written
 for VCN v4.0.5
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
 amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
Cc: alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com,
 ruijing.dong@amd.com, stable@vger.kernel.org
References: <20250513162912.634716-1-David.Wu3@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250513162912.634716-1-David.Wu3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: 37043f4b-8d1f-44eb-97dc-08dd923cd2d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rk1jdnRTaTVsaHRsamZFb0lhR1ZxYjEvc0lmYmJacktublVqQUFBK3Z6OHZm?=
 =?utf-8?B?MlNnMmhOc1M2YXFLSHhKMHlMZ1BvcHFhRGlRQzdnQ3lycnZlcnFISmdCVEdx?=
 =?utf-8?B?c1FWY3AzTVEyYitYSXlFY091VTFRL2pnZmx2SkZkMFhSdll5RjMvc0FUK3p5?=
 =?utf-8?B?cWZzR29sRXEvdjZyZVdINVRHWWgreVRscXZzdzVpY3ZmKzRkR0xMWFU0OFp3?=
 =?utf-8?B?MFB4Z3NuZXBaQnBGbm9WZE9Vb3V0L3h4VTZQc05tWVRYK2sxczcybnJtbVkv?=
 =?utf-8?B?WFpJVDQxTW9pdEpkeHI1ZTNTNFlOOGl4Ukd3KzdOQTk1TitTOTYvL2xUMSt5?=
 =?utf-8?B?V0ladTcxQTBsV1ZwUlF5L2MwV1h0Z1c2V2VSQ0lsVTdzK0VoUWJ4Ujc2ZHZX?=
 =?utf-8?B?MjE0SDZoNmNqbzkxZzdybWdzTWdrYVloMFFtYlJFRU95VTQvV0ViQXUwQThU?=
 =?utf-8?B?MTBZZWVNSVRvT3ljay84T1lmQk9sSnpuSTdPS1U5OXRJRldKUHlQR3V5czJv?=
 =?utf-8?B?K0w5NkVkeHNuK0U0UlVOU0F3cGJ1TkVrYjVodmdaN1RiUWFmcitHaEZuSHZp?=
 =?utf-8?B?R25TMFQza1V4QmJscktYWUUxUUtxRWZ0T3d2Vk16UmpQbXFVT3libkh1NFgw?=
 =?utf-8?B?dnNZY0tHUGhoeUJwdTBmWmJsc0Q3NU55eW9uQ25Ob0RRQzlkWXpxTTlBeWFV?=
 =?utf-8?B?WlA0UVdTK2FjVEVVWnpTU05VU1BYeGFQMnRPVmxDNG9KZU55N1Znd3FzNm9k?=
 =?utf-8?B?UUwydUxDdHNPcUJCTkF5clNXSlJ5cVEvUzlqeWlrSmZmWmRXWE5RMStLbjZ0?=
 =?utf-8?B?VnNNTnBucDdvYXlPTC9kWi9yeUJlMlJoV3g2WkdmVnlNKzJjN2dkMDZMWkZJ?=
 =?utf-8?B?ay9KVklPN2pUYjhCTHZoSU9TK1gyV1Jsc3c4Z1ZiSit0aFhTd3RadWpqc1Jz?=
 =?utf-8?B?VW04NWRrTlh0WHB2KzY3N2ZrK1V0TkpFd0ZYZlNIRTJ4dUZKdGpwbkZhZmdF?=
 =?utf-8?B?MURGNGRISTdPTkRsTm4wRHlLaGR5VzBNSmFza29iYVZWdU5nbnR4d2dPYytV?=
 =?utf-8?B?MlJNNWZrZDV3anZNWnJWMEtrWnNKNFhRSnMxMVBtdlhrS0FIaFBURHFMZzlo?=
 =?utf-8?B?d2tYUXhzZUpNLzNjTS85QlRFR3dPQ1NiN1EzL0dkSmNBUXI5ZlBOS2J2MWV4?=
 =?utf-8?B?VWxKelFBKy9oV0s0cmhoaXBONENTbnp1anNhT0JHOWp3eEQzbDRtSEJydEtG?=
 =?utf-8?B?amFsdUNLa1hzSTBGTHh5NUUrWGhoSlVhSXJ1SzlTdW81OFRac3hBU3pqQTlt?=
 =?utf-8?B?dUlzb2lUNlVpOVlhVHh0Nks4MUZib0tUN1RmM09WY3ZXaXp6SU9EcVA3aC9Y?=
 =?utf-8?B?M2NFOVVubTZzbUxZeDZMZTViMU0rK3RNRStvckRMaWRTTkxOTlV5TzMxVlhw?=
 =?utf-8?B?UkxFV1dqdmhuUVZuc1NHQTFlMjNyallTZWtjcEFVQllZM1FOR0hJc3ptRWVo?=
 =?utf-8?B?cXdTVlBucWp3SjArYjh5VU1WenlHclloRElTcEtubEVjNEIrY2l4b05DNlVr?=
 =?utf-8?B?c05BMXZDdWd6NzAxWllpeElUbWd0aTB5cnNxTEd0R0dvcUl0QTZ0QkdKMU9r?=
 =?utf-8?B?MkpBT0xOZUNtMnk1SGdmRWdUY0VYRncyeitlZ1dWLzhlTUZvSThYUGMzZTI1?=
 =?utf-8?B?RlJvekovL2lESGtOT0FZOWI4RmwzSTljMHB5NEk0RjliV25VZUhDSHk1V1BK?=
 =?utf-8?B?clJqZDVlQ3FtL05DSGN0MFRSNXhHSWpEVm00Y05VU1dzVlZhaXRsU1JUaXJn?=
 =?utf-8?Q?VvuuG689NhiDxhejfN/WMI4bId32aLV/lgAwc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2cxQ25LZzFZNFpITjhvL0FicGZJcUJ4RTNlUTRnRGRaQzVwSlpxMnZlakIy?=
 =?utf-8?B?U1ROYmtyU1V2ZGJtd0NUSGo0Zlp1OHZPUmVWanRQQXRyQzdZNUpVRE5SeGRm?=
 =?utf-8?B?WFRQRHJkV2dqS2laN1RUcC9wSllXK0lXQmRTTzBUYWxaYytvWWxRRnFGcnBT?=
 =?utf-8?B?ZFVJZnN2T2t1TmRQblFtaWZPanVMWWo5UFIzZGZpczZ5ZFlxL3pQT291aUZM?=
 =?utf-8?B?YS90b1BKNTA3cUVXWGVtT1J5MnJrMVgvN3l6QkhFU1puTTFoaUx4UzVhUTM2?=
 =?utf-8?B?SXhDMzlabU9ibG9vRVJldEpzWTFoUEVXbmNWRHVEd2ZEZnJ3OUtzRk5halMv?=
 =?utf-8?B?MmJRTndqbWRXbDJPYUwxMFhwWHdVcjhMdHR4Y1RaWmN2ZENvVDczeWNlMjZE?=
 =?utf-8?B?UXduU2cxUGlxTnJ6M2s3cWtsR0V2aGdvb0RSNDVzc05vbDdBaXpENUdBYUkv?=
 =?utf-8?B?L0RGY1JOZWhFeTNrcENuVjBYUEpJeFFpelVvREhZdzJxVjI1THhzMDFUUWZJ?=
 =?utf-8?B?aTJkMk50KyszTW4wdUI0blBObzRqSnRqZWNhODZhZFcvZnVjbWdzZ2g5OGZF?=
 =?utf-8?B?RFVCNDkzQ2puK2tDdTdMdHgvZUxQWTVvd0QrOWdScnNGRzJhL3BNS3d4U25w?=
 =?utf-8?B?RDRvZDY2ZlRieFZxTEppd2pZbHp2d2JsUkw5andEb1J5dUdJVSsvZUo4azMv?=
 =?utf-8?B?dFpERCtXaVN3WllQQ0NFWGVFZ0NCMDRDTXF6SmFLd0hXRGdqQjVjenQ1cERr?=
 =?utf-8?B?WjlVUHVOU1o2My9URlArcEhoQmluRjA1UmN5UDFEK1Z4VEQzb3BSdEE1TE10?=
 =?utf-8?B?U1JueXdPQnBQTmwxWUxTUFlaTm92bGRYNmRFaGxaaFJRR0Z3MU1MSmlRM3hK?=
 =?utf-8?B?UUZ5SUM4R3pYTUlOSjljN1cvSWxlRit3MXR1QUU5WW13WkhUOUxlWWtzNEx6?=
 =?utf-8?B?RkZpcUVmOFBBZ2hJdk5IV3dCWi9LdnViS2Z6RVByMEh0N0p0bk8xRi8zSnZt?=
 =?utf-8?B?UnErVkZmdWxMeFpaakRWOU9DQlZaTnNZQ25FSmNlTDZmOFBPUStCL0Q3YW1q?=
 =?utf-8?B?STk4M21seG5FbUZ6dGI4bEpZZWZ2bVlYRHk3U2MvekxXTk52aFZsT3FFRnlx?=
 =?utf-8?B?c3ZicFJ5Q1ROVVkrd3crdFRPclFHUlowcHRkcitTVGpTZWkwZWN0cng2d2w0?=
 =?utf-8?B?ZTN6WmNqRUdwOFVGSHd4YUU1c3Bhcm1zbU5OaEg1T21vS3QrNVgxdjMwczVU?=
 =?utf-8?B?YklpSGxvQjI5blM2YjNtbU41S2ZnWElYcDlzbjVTNVFKYzNuZHpsbmN1a1Zv?=
 =?utf-8?B?Q0V2SVFXUmZXemNtQXh6YVhnN0dnMWZxUG93eWZGdUY3bDRlNWtpRmoveHFw?=
 =?utf-8?B?ZnZkOUhYcDUzNW5HcU54WDZmZVY3NEpJNisyMlR2QVhqY2M1eVhtVmhDNWU4?=
 =?utf-8?B?eGFUQmlySUgzVzR4UXA5SmpGSXdiM2NzOGVyQmtnanVXc0k3UFFCamlsdnRv?=
 =?utf-8?B?akNYQ1kyVE1DYzNrY2JPd29rcnhUc1JUcmdYeXMwd1IwWlppT2JrdHlmSG5x?=
 =?utf-8?B?bEorMUVkbG5CNW9Bclh3R09idnM1NVFtRktrTVZKV3Nmc1VHaDJWNFJ4SFFo?=
 =?utf-8?B?SVVvNlB3SVRnZ3l1S3g3SUN1WWhRNzFaS0JWMjhpY3V3b2w4VTJ1aEgrbWVB?=
 =?utf-8?B?bUZGWWFMeTN5dlJZL0FHTWxtT2VSeE9mb1lTQzdsTGZON1NJcllWL2FFY2lw?=
 =?utf-8?B?R2hQejVPUitkV2FZN0dOaFdCclF6TWR2OVdXRjJJc1FzL0RNTDRvcmVRUk5V?=
 =?utf-8?B?bTZjRG1XUXNrRTdiME9CWkNKbWk2UVByaXZ6NnpEbWFqQi90dVhlQjNqelNQ?=
 =?utf-8?B?TGZSa3JzM0hHcmRMclIzbzMxZUhOYkUrZWU5RXl4YWUzZ3hWSFo5dG9xNktR?=
 =?utf-8?B?TVhhRXB4aEo4WEdKWTZDZ3BkQUlJTkpKMzJNRkhSRFhhOTFyaGZ4ZjZld3JG?=
 =?utf-8?B?SEVLUVp3Q0dkVWJWc1EvZVEwMFZGMXYvREMva3BPRVZXM3FDVFpuRjhQOUpt?=
 =?utf-8?B?Wmx4cVBlV0RTWHFrYUFHUGlSVHVweFdQS3NxaUQ0YzhZQms5N2NCYm1IWXBo?=
 =?utf-8?Q?D9Hd6tQtV7PVmrDqg4zAqjwbV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37043f4b-8d1f-44eb-97dc-08dd923cd2d7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 16:40:09.2649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XGVtLUj7hUcFGuP209XfA116UoE4PkuYy4a7lyHdI5GeUXzK7GBEU/NJCyHbpP/nStUvG0nm5dZ0E09XjQz+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303

On 5/13/2025 11:29 AM, David (Ming Qiang) Wu wrote:
> On VCN v4.0.5 there is a race condition where the WPTR is not
> updated after starting from idle when doorbell is used. The read-back
> of regVCN_RB1_DB_CTRL register after written is to ensure the
> doorbell_index is updated before it can work properly.
> 
> Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528

As this is a proper fix this tag can be:

Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528

> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>

Make sure the commit message has the stable tag not just the patch email.

Cc: stable@vger.kernel.org

Otherwise:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index ed00d35039c1..d6be8b05d7a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1033,6 +1033,8 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
>   	WREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL,
>   			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>   			VCN_RB1_DB_CTRL__EN_MASK);
> +	/* Read DB_CTRL to flush the write DB_CTRL command. */
> +	RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
>   
>   	return 0;
>   }
> @@ -1195,6 +1197,8 @@ static int vcn_v4_0_5_start(struct amdgpu_vcn_inst *vinst)
>   	WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
>   		     ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>   		     VCN_RB1_DB_CTRL__EN_MASK);
> +	/* Read DB_CTRL to flush the write DB_CTRL command. */
> +	RREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL);
>   
>   	WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
>   	WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));


