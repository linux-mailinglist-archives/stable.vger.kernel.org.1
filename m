Return-Path: <stable+bounces-49927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6978FF5C1
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 22:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA622288421
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 20:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B066EB5C;
	Thu,  6 Jun 2024 20:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f4O53C0m"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2BB38F9C
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 20:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717705169; cv=fail; b=Bs1F2Ui59Cm/FdPwtDZXwzgt0iF9wpLIHtExnbjoQ34pP3Q71Iuexgkn53lerZnIbBhZhvYSrMIdg2fUrEQN2dcEdsZUW1D53PVYmhjt0h1Nc2wCWi5na0Mtdo3wygcPdkBdvG6jufFOD0/sz+jwzmZAzR8ZpO+KPpgmWvO/eVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717705169; c=relaxed/simple;
	bh=Lhj1HjSLzG7hNyjWKCcKAluX1rrYvtmTzlMTt8A7CK0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fuqU0yCY92AjVmDqaTwegZNUIJygnuGyenpam1ycRr4eamdmrqKcLGzUom4joct+GPtf9FzFIKERBRgYioYrDg7kOg4ySVquYn4ZGxrf9p6ZfgL6oH6H3nsb/vnyb72qVjL2Ww0WeRS7SWEyf1Pt0zAzvLuGD1btrIS5nlngBjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f4O53C0m; arc=fail smtp.client-ip=40.107.96.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5pIlsAdaixgxb5lkBMZq7xMt2ueNQsq5khJcOJjoCMcp/uoVsMqFmBgLvjQ86rAPbQZ2D49PIDmEZ+7aspk1fa3N7s4+RJgi8VZSCEZDqpd9mCplzOeq4U5+xC4CW/n2gLAhIoVqYDGRgGxvTF3/8J5H1s+aqdRS2ZQZ+xq8du6U8RYyBkJa+I6iY31ywM09+a3fK5e+c5YdE2qh7Emo0m/I2pKjT1oqSfKrcpirXTmp9L8nxM32sGHvHdRmAklZcj3jwp4xQZWL/xWAUJCFFkCQgzFYbzTL4q5GVdd7rM4cBrqdIiVp/JDIxmmUMDwxMLaH2P5clD1uXVMzgEMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcN+U/nxw3CmGxLyBbZ0t+0qNU8k5+b/+tjwGR0oQVs=;
 b=OuiFcVpIxr48FnPpEV190oGUezr3VW1+b86+kED5bUbFMqO2iYmVY0vTZ0UN97pUAJ5zN3tju50KD4d8fSD4DNZDf4/9Gc8v7fyVWKpRXtMYacNR+9i8ABK9MInspubua3pBpyCoFjnZrufPUnAntBi+w7CFqOCVPqpjncTy1EyXSob0M3svDbfx3AoKBX2YPQFyPPBsxXFZTHeN6qTDoZaz4UP3HxAjeOwMTOWlrU4kAhiYP7bjJZL9uvxspsP5BNLar7Bb6oK0JauLtCg4Jc6gochPe+Wh+ySLhzo60lUwnakCsN8qMi++bRX0JF5Vf3l7yzUxG0mfCqIG5Lec7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcN+U/nxw3CmGxLyBbZ0t+0qNU8k5+b/+tjwGR0oQVs=;
 b=f4O53C0mr9DEOTUW97WWxzbmYhGFCeFMrwFqTpHd+SvrXsspTPYOqsCk14tZyrQMdups4p8as99lLFXj2ULJvNExnZqL33IXEvTWwH1U5pVXqZdrP3nazKPRIFGmManb8JPMD6MpkPVNIZlLW1iN480hNrkkKKrqQal8sPWSHT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Thu, 6 Jun
 2024 20:19:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 20:19:24 +0000
Message-ID: <a1c9e7f7-fd1d-4e48-abbe-0afea6c4c10b@amd.com>
Date: Thu, 6 Jun 2024 15:19:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix the BO release clear memory warning
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 tvrtko.ursulin@igalia.com, stable@vger.kernel.org
References: <20240606200425.2895-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240606200425.2895-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:806:20::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: b7383a9d-4727-4038-0fed-08dc8665f4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWJTd3RDQlpGWmpLL0dhSitlS0hrV3dlZFQyV0tOWTgwTzEzSk83d3JrNzRW?=
 =?utf-8?B?RUo0dDhRTjYwYU1saHEzY3UwMFlrSVRtOVVBQnhwMGZrY0x4TCtRdlNDdGxz?=
 =?utf-8?B?M0hVbXEySFVqbEpEMlBLRjBIWkt5Q3BIMCs4cy9oaUlQQWppZ2JDK1p5OGc1?=
 =?utf-8?B?ZnlRZ3B6bTNmZklLMDNxVWJQUXpnSW56MktpREVOTXZldDNpazQyMENrcGs3?=
 =?utf-8?B?eFNSdWRLZlpySlRLUjd4b3NqdFZFQXAxVzBSdjJvQTZvdi9OdFBDT0dXWGt5?=
 =?utf-8?B?YytNUEFQYzhnSmhDdlFhYUc2Ui96Nm81QjE4dnJrSU9rRDJDaDNuK3FrMFNH?=
 =?utf-8?B?UmxhalNzdHlxT0RESXpLdFcyWGVMaEtDRml5bXRIVUZmS2t5emdWeDJwV24r?=
 =?utf-8?B?dzZ6ZVMyaytHSE1kaUV3QnJteWdrQWpIakp5UE8reG5aTlJIajU3RjhCUVBK?=
 =?utf-8?B?WXRhakNScFAyT1pmV2U0YVJpWXhURmVsa1Z4K0o4R3lWeGdsa0x4NlNBTnIz?=
 =?utf-8?B?WFhhUlExWm1kSnlaR2U3V3NPMEI0UzF0N3ZGandHcGFuMUtnUWZPK2d0QlVy?=
 =?utf-8?B?TzRZa1AyTmlEZEFpeGllL1JvVGlQKzNqQ000d2NlclFBTHhaUnA5Z0dVYjd3?=
 =?utf-8?B?RXU2Ym9INk1JVXJBdzc4MFRFc2JsRG9uT1FoaXVGSmRSeEZKNVBYV2Y4dXNt?=
 =?utf-8?B?QlczSGhxUTh2bGFIenBDRm1mSm1nMGY1bUdLeEV4N1hDdFBGYlU5cm1qRmZE?=
 =?utf-8?B?Vm5pa2t3b3lYNEZDdnFKeWNuTk11Vi9STW52b3FyMGZUZjNjcUJLOHBZT3hQ?=
 =?utf-8?B?K3Y1Tk4wM2tuYkJScXEvQ3UwL1hwWGJSZVpXbFFsMXdudUhnTDFUdzdRaTAx?=
 =?utf-8?B?UlcwSWdsVzk5alQyRUpRK0oxaHNIcDRsT0Q4ODhWdGpJRW13TkVWb1lITFFR?=
 =?utf-8?B?MW9RZEViRGQyd0pzdlBBQ3hyWWdQdDJ1QSs2eTduM0lPVUdDaEtwRHJUbGdY?=
 =?utf-8?B?KzU3akJabjF6TFR2MDR0SHloVzB4Nm9Odk8wWG1sVkNZeHZHYlFPYytHYzZX?=
 =?utf-8?B?SEUzNVlXN3g4WlU0SFBvQjFDdFUvbDg1anM5UDNoRGQzYTRueFVvVkRPYkZ1?=
 =?utf-8?B?b0J5TVNEQmw5dURoY0ppTE4xR3RZYUlNUmpjdW5UNmRtOTJjMGR3RnN3bGN3?=
 =?utf-8?B?N0gvUFBXUUVYWjNrNHJ4N3RybkVXSkdIZlYyc1VGOFpoZVkwY2FEb1FFOXRy?=
 =?utf-8?B?RTdpa2lBZ2tmRC9KZVlCTzVrOFlZdXlISStpbEhhN1gxL1lJWmtMYUY0KytK?=
 =?utf-8?B?dTdoRXA3czRDMTU1QTlqUjliaGdxcVNjZTRGUTg4WjIyWk54bGhkUTVKTmJw?=
 =?utf-8?B?eXg0RlNyZy9SVmQweDlZZ1V5TVVyRTZEdnRMOGtSZWxSTEdJSVF0VGxMZkZS?=
 =?utf-8?B?REVQQ05pbnhFOUdkRlh0OE10MGFxUHozb2J1OG9iTnc4QjQxeEhFRW1rZlkr?=
 =?utf-8?B?WlVBd1BkUUNYY2ZjUFpyMHp4bUhFSk4zVERhTk9sSWRkTW1hUWI4NW5kOWQ2?=
 =?utf-8?B?L0VjYllkYTRoYUFjTG5hS2ZOMEp1VktFVlM2WTlsakg4N2hmL00yaUJmdk9V?=
 =?utf-8?B?SnZ0YkpvNzlHUFMrSmUwTlRiQzdtc1YvbHNCa0JpKzJsOFZCcDdnRjUrZlI1?=
 =?utf-8?B?ZDVaQWtLckhZbU1yOTVaWm05ZHNpZ0NHemtuRG5OV21qOFdmNVFGOFlGUHBX?=
 =?utf-8?Q?T86ayDeNgUF2OitHSfQhc+WrZ13+gD5Nlr9orpx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emI4VjAzVW9aU1RRak9vK3lqdFQySDJabXByVUdFTDQ0QnVFNjAvOUhybjNW?=
 =?utf-8?B?YlpnZnR2Z3V1NnFaT1d2VjczUE85QWoreFBNcDROeUQ1bHY4QlRYT2hnVXRH?=
 =?utf-8?B?My9vV09HbE5LKy8zWU1YakthL0lrbzFtOVVZaXoyWGorWXJNN3A2dTdXR1R1?=
 =?utf-8?B?OUFmS1RkaWVySVdmRW1ETGplUGZpYlpJaWNRU0M2Q3JNUUxiaTVMVGNLelRz?=
 =?utf-8?B?WmREWTZFVVhCcmZUUS9tUURMK1M2TGY2WDA2TmJ6UjhLdTBOSGZZcVF0c3Y2?=
 =?utf-8?B?Zk1zdCtRcW1USm1NMUkrNzgrTWQ4dzBENU1uSi81ZlRqSmxuZzZyOTRhY3hj?=
 =?utf-8?B?M3hjSXRNQ1JRYjVDZnVZVm9IdlRadTkxa3NiZzdia2YxVHk0RDBLMzVmM3Vp?=
 =?utf-8?B?VVV1Y1MzQmdZL1Y2NkZUMWtLSXphZUdVZ2k3S1h3UVJoM1R4bHlTanJMaHBt?=
 =?utf-8?B?M2puL1dGbHMvRCtrUytMdnFMRGFNYm5EQXFzZGp2Szg4dEFhSlkzT1N4S3FN?=
 =?utf-8?B?UStscjkxb2dOVW45MnZKMndOMFZDMHBJUWgxN05BcHVlMjZOb3BDK3NJdWNE?=
 =?utf-8?B?SWdSbEpDaDFESmFMU0VFTVZaN3V1Q200ZytSN3NOeHV0MWU5KzAxQjlwaERo?=
 =?utf-8?B?YW52OVd4cWo5QUowa2NlSWdNN3ZCOGxmVWZIR2RZY1hZV2RoNTBYTEdaWnhr?=
 =?utf-8?B?ZGRFYjFQVWo2bDl4dXBWTGM3RXRrWllXNEw5VmRwdWgydUk1RFFxQjROdjRI?=
 =?utf-8?B?S21icDd5UU1IWE1JcTRjYVdVSnI0dkdnbXFrQVFqdHZWdDhDTmp4TjhUQmpn?=
 =?utf-8?B?dlJWa20wZTQ1dDl3bnQyeTE3enE3aldXbE54dVBJbENnVndycVFmSVcveHZX?=
 =?utf-8?B?MEFmUXVPekhqNFkxWERJbVp0c1U5TDhxYmRvWHM2YzJHeDAwd2tWYXcvNTEy?=
 =?utf-8?B?TUJPb0kxQkQwNms1VXlIT3d5Y3l3ek9OZnlWU05Rd2VYYTVqSmFuOXNpZUJu?=
 =?utf-8?B?MmtkcjdINHo1aVl0QVpTUW1pT1BwMExDbGNIdXVlQ1ZyRUlIVngwNThzbi9G?=
 =?utf-8?B?eGVBS1pOTDR4WmVXSkxvMkhKbnZZQXZRcHVWZ0t3L1JTY0dLeWVUVEdBSDdx?=
 =?utf-8?B?VTIrbDFsMXdtMFhyS25IV2J1clBHYlVaUllVQzIyM0drRlZDWE5lSnliYUNY?=
 =?utf-8?B?dTFvY1RWSHRHUUFXclpzUGIzWERvTWpSTVpMbjYyTTFMUURrQktWZUtWY1BL?=
 =?utf-8?B?Y0FtUEVSOFY3UXdONlJpbkJocDhvNlZJYzFUR05XN1g5YVhFQTgzcVhZSFpt?=
 =?utf-8?B?MFhoZGZTUWhNMlRqSVlHOEZOV1FJUEo4UjlIMGt4MFoyVExwOHdBZkRlS0ds?=
 =?utf-8?B?VEhyMWtLTnJCUWlEZTZaUFFmdGRlazlNNWtQUWJjNmV4d0dlMXNTbzNzbzA1?=
 =?utf-8?B?MnNLN3hzTTJxSjJLdXNQcDdWRU10dU1wdTZvak9tVHJQQnk0ZXV0bndjczJP?=
 =?utf-8?B?QUcxQUlMa1NsSENEZGsxQXplekV0SEFRbitMNFZTWGRSZ1FnaWV3N3RMekFM?=
 =?utf-8?B?cE5FbzFsbjZJZlowYjRWOHcvWmliakozKy8vSXU1NzYxQ3ZUbUZQRFIzQkk1?=
 =?utf-8?B?d0J4V1ZsUUIzS0J0c3RyTnJtOG50M1NrR2daWFRtTnVXem1HVTYrcjZSb2ZK?=
 =?utf-8?B?b0lkYnVidjNsRzdBUFNOcXMrdlEyUTFaOWU1V3lSck05UjNxVkxKWlRHNElF?=
 =?utf-8?B?cE8yU2M1L3RQWGdzR3dxOEZ5NkhFYWpQWm9KSG91eWswdlBzT0tGWm1Rb3BJ?=
 =?utf-8?B?Ums2eHR0c25GSzFya2ZpRTZmRUI5MzNBcWhFTTZjRXNwbzl3Q2o5Y0ZvNUtC?=
 =?utf-8?B?ZlFJK0VPMFMrb0VvanRVU3U1RlZTbHh0QnM0cVcrajJVNzJxTExSUFBTMHFE?=
 =?utf-8?B?S05XTEpRVFFpem9HRHRGTzJnL3M4MjVHOFZmc1NqdGVvT2JrTnkzNkNsdVNR?=
 =?utf-8?B?OUhwZmZHSVVEZDNVOUhWOEMwU0xLNU1WRUtDZmVWNTQ2emtYM3NoZE16UVVZ?=
 =?utf-8?B?cTlVMWhwdm5XcFl0U3dMMGxTNWpyR2lSbnQwMUw5WnJyd2J4b2QrdnA1SGZn?=
 =?utf-8?Q?IWFcn20kEuc9BdLmpONLAf4nW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7383a9d-4727-4038-0fed-08dc8665f4ed
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 20:19:24.0253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wycJgpdGbAp41uRA7Gfx/hc8FgnaduyYIDYtyf7iZwxPUL1mwGO5exkTwArB93aA3X6142N8d5hkJ+MUzrZU5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873

On 6/6/2024 15:04, Arunpravin Paneer Selvam wrote:
> This happens when the amdgpu_bo_release_notify running
> before amdgpu_ttm_set_buffer_funcs_status set the buffer
> funcs to enabled.
> 
> check the buffer funcs enablement before calling the fill
> buffer memory.
> 
> v2:(Christian)
>    - Apply it only for GEM buffers and since GEM buffers are only
>      allocated/freed while the driver is loaded we never run into
>      the issue to clear with buffer funcs disabled.
> 
> Log snip:
> [    6.036477] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.
> [    6.036667] ------------[ cut here ]------------
> [    6.036668] WARNING: CPU: 3 PID: 370 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1355 amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
> [    6.036767] Modules linked in: hid_generic amdgpu(+) amdxcp drm_exec gpu_sched drm_buddy i2c_algo_bit usbhid drm_suballoc_helper drm_display_helper hid sd_mod cec rc_core drm_ttm_helper ahci ttm nvme libahci drm_kms_helper nvme_core r8169 xhci_pci libata t10_pi xhci_hcd realtek crc32_pclmul crc64_rocksoft mdio_devres crc64 drm crc32c_intel scsi_mod usbcore thunderbolt crc_t10dif i2c_piix4 libphy crct10dif_generic crct10dif_pclmul crct10dif_common scsi_common usb_common video wmi gpio_amdpt gpio_generic button
> [    6.036793] CPU: 3 PID: 370 Comm: (udev-worker) Not tainted 6.8.7-dirty #1
> [    6.036795] Hardware name: ASRock X670E Taichi/X670E Taichi, BIOS 2.10 03/26/2024
> [    6.036796] RIP: 0010:amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
> [    6.036891] Code: 0b e9 af fe ff ff 48 ba ff ff ff ff ff ff ff 7f 31 f6 4c 89 e7 e8 7f 2f 7a d8 eb 98 e8 18 28 7a d8 eb b2 0f 0b e9 58 fe ff ff <0f> 0b eb a7 be 03 00 00 00 e8 e1 89 4e d8 eb 9b e8 aa 4d ad d8 66
> [    6.036892] RSP: 0018:ffffbbe140d1f638 EFLAGS: 00010282
> [    6.036894] RAX: 00000000ffffffea RBX: ffff90cba9e4e858 RCX: ffff90dabde38c28
> [    6.036895] RDX: 0000000000000000 RSI: 00000000ffffdfff RDI: 0000000000000001
> [    6.036896] RBP: ffff90cba980ef40 R08: 0000000000000000 R09: ffffbbe140d1f3c0
> [    6.036896] R10: ffffbbe140d1f3b8 R11: 0000000000000003 R12: ffff90cba9e4e800
> [    6.036897] R13: ffff90cba9e4e958 R14: ffff90cba980ef40 R15: 0000000000000258
> [    6.036898] FS:  00007f2bd1679d00(0000) GS:ffff90da7e2c0000(0000) knlGS:0000000000000000
> [    6.036899] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    6.036900] CR2: 000055a9b0f7299d CR3: 000000011bb6e000 CR4: 0000000000750ef0
> [    6.036901] PKRU: 55555554
> [    6.036901] Call Trace:
> [    6.036903]  <TASK>
> [    6.036904]  ? amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
> [    6.036998]  ? __warn+0x81/0x130
> [    6.037002]  ? amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
> [    6.037095]  ? report_bug+0x171/0x1a0
> [    6.037099]  ? handle_bug+0x3c/0x80
> [    6.037101]  ? exc_invalid_op+0x17/0x70
> [    6.037103]  ? asm_exc_invalid_op+0x1a/0x20
> [    6.037107]  ? amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
> [    6.037199]  ? amdgpu_bo_release_notify+0x14a/0x220 [amdgpu]
> [    6.037292]  ttm_bo_release+0xff/0x2e0 [ttm]
> [    6.037297]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.037299]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.037301]  ? ttm_resource_move_to_lru_tail+0x140/0x1e0 [ttm]
> [    6.037306]  amdgpu_bo_free_kernel+0xcb/0x120 [amdgpu]
> [    6.037399]  dm_helpers_free_gpu_mem+0x41/0x80 [amdgpu]
> [    6.037544]  dcn315_clk_mgr_construct+0x198/0x7e0 [amdgpu]
> [    6.037692]  dc_clk_mgr_create+0x16e/0x5f0 [amdgpu]
> [    6.037826]  dc_create+0x28a/0x650 [amdgpu]
> [    6.037958]  amdgpu_dm_init.isra.0+0x2d5/0x1ec0 [amdgpu]
> [    6.038085]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038087]  ? prb_read_valid+0x1b/0x30
> [    6.038089]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038090]  ? console_unlock+0x78/0x120
> [    6.038092]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038094]  ? vprintk_emit+0x175/0x2c0
> [    6.038095]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038097]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038098]  ? dev_printk_emit+0xa5/0xd0
> [    6.038104]  dm_hw_init+0x12/0x30 [amdgpu]
> [    6.038209]  amdgpu_device_init+0x1e50/0x2500 [amdgpu]
> [    6.038308]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038310]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038313]  amdgpu_driver_load_kms+0x19/0x190 [amdgpu]
> [    6.038409]  amdgpu_pci_probe+0x18b/0x510 [amdgpu]
> [    6.038505]  local_pci_probe+0x42/0xa0
> [    6.038508]  pci_device_probe+0xc7/0x240
> [    6.038510]  really_probe+0x19b/0x3e0
> [    6.038513]  ? __pfx___driver_attach+0x10/0x10
> [    6.038514]  __driver_probe_device+0x78/0x160
> [    6.038516]  driver_probe_device+0x1f/0x90
> [    6.038517]  __driver_attach+0xd2/0x1c0
> [    6.038519]  bus_for_each_dev+0x85/0xd0
> [    6.038521]  bus_add_driver+0x116/0x220
> [    6.038523]  driver_register+0x59/0x100
> [    6.038525]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
> [    6.038618]  do_one_initcall+0x58/0x320
> [    6.038621]  do_init_module+0x60/0x230
> [    6.038624]  init_module_from_file+0x89/0xe0
> [    6.038628]  idempotent_init_module+0x120/0x2b0
> [    6.038630]  __x64_sys_finit_module+0x5e/0xb0
> [    6.038632]  do_syscall_64+0x84/0x1a0
> [    6.038634]  ? do_syscall_64+0x90/0x1a0
> [    6.038635]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038637]  ? do_syscall_64+0x90/0x1a0
> [    6.038638]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038639]  ? do_syscall_64+0x90/0x1a0
> [    6.038640]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038642]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    6.038644]  entry_SYSCALL_64_after_hwframe+0x78/0x80
> [    6.038645] RIP: 0033:0x7f2bd1e9d059
> [    6.038647] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
> [    6.038648] RSP: 002b:00007fffaf804878 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [    6.038650] RAX: ffffffffffffffda RBX: 000055a9b2328d60 RCX: 00007f2bd1e9d059
> [    6.038650] RDX: 0000000000000000 RSI: 00007f2bd1fd0509 RDI: 0000000000000024
> [    6.038651] RBP: 0000000000000000 R08: 0000000000000040 R09: 000055a9b23000a0
> [    6.038652] R10: 0000000000000038 R11: 0000000000000246 R12: 00007f2bd1fd0509
> [    6.038652] R13: 0000000000020000 R14: 000055a9b2326f90 R15: 0000000000000000
> [    6.038655]  </TASK>
> [    6.038656] ---[ end trace 0000000000000000 ]---
> 
> Cc: <stable@vger.kernel.org> # 6.10+

I think the stable tag really won't be needed and could be dropped when 
this is committed.  This will presumably go into a -fixes PR for 6.10.

> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 --
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 67c234bcf89f..3adaa4670103 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -108,6 +108,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
>   
>   	memset(&bp, 0, sizeof(bp));
>   	*obj = NULL;
> +	flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
>   
>   	bp.size = size;
>   	bp.byte_align = alignment;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 8d8c39be6129..c556c8b653fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -604,8 +604,6 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   	if (!amdgpu_bo_support_uswc(bo->flags))
>   		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>   
> -	bo->flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
> -
>   	bo->tbo.bdev = &adev->mman.bdev;
>   	if (bp->domain & (AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA |
>   			  AMDGPU_GEM_DOMAIN_GDS))


