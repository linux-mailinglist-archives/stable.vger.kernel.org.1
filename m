Return-Path: <stable+bounces-49929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6FE8FF62C
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 22:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0099E1C2231F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 20:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BBD6F08E;
	Thu,  6 Jun 2024 20:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ciqwbALB"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4911C4AEC3
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707439; cv=fail; b=PhuDlb3wiY3PGUVLBhqKFKNwNcjZd3FEabfIp3o/Hi3dv/bnleGbMvfup06EAMo09jmoPQvt0YYvm69H1csxAvzeLJoCXL2jUFi0jQ/C9m0+xcwqzDmqtPid+c7vmfdn2KlU1x8Q3JlsSUP3dcwGVanKW2YAiyL9f93WfJuexK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707439; c=relaxed/simple;
	bh=xK/ss6Ge/IW2dL9tkPRGbgBko3nWUNKcpkGoQWGKYcQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DDIcpw0uqZ7TAMoeR6e/LjOS+o9/polMM+NyizIhDHS/GipWM5hW0OORte2JKCVQ3oWDn2ZYm3dSUpA8VSwTVNhcZ/i7iCVrUetCNhpUBc8+5uaKvOWzysaIxE+PZOmLTOPlnMKcTzvdGQPQEG5TmMlrFAw5/3YDk0V4Ts0Lz20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ciqwbALB; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4TvHuINgxeEpnbzKgCAcPW1EDk3oc2Q0dKmVT0/de2e2V6Qmo/tRa3b6ATS4Q16o6bgONBzCkjyf50SI3+jCqr4OfUIizR5XSPh86xL0hzEWY/kTeHdkKtBQk9uN9j35SKLifqa44xvY0BO8lLC8zFOnP0Trj577bc6Sl163XemZnPREsym3QQRQkV/r2blUWNMr/t++TBv5TrgWVYdmsQ32Mq95Oo9pu3Uqg3nLNj9j8ZJr+0Mvrch7X2qQibndwH+4XZwxwKPZmpd3gpbRYXfZQiZrmjFI8tuZksxkSBtL564wmKKJW91WA1V05JARwfKLIrKV/vlxid+LnXxIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GM8fy4FFcs+X0BOtC/A4FW9kKCx/mgGzbB4NycqNsZs=;
 b=nm8tZO+vE1K69vdsFua5pOlINy0ULe7SOMAP4GBT7mrthObNm5+l+APQ8Ic0CGVHSKRbAksUkuFk6YySZchRiGvAMmLrBUCJmolgP80PbLwqJ+B5ma4dOwPwnVneeglS+7hRo9ehmVkGAvjizgx410xN9aESbf6iXBVs2OLDEjNHcgGBjE+o/1iEPLWJGzH1KhcL6x0k2+U9Jpf47rWw2NcZsRP8qUTqHk5EKMJNVcUYuuX0T/cKcfJ++qo3lbYZ2p8wzNq6+kEPVrKUNboZdIuLfrSZQ4zQ16fl7ivFnxswir4R+TDr5PYsamgRr7/7xzQFw2dl2ndMy8dwWvrFqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GM8fy4FFcs+X0BOtC/A4FW9kKCx/mgGzbB4NycqNsZs=;
 b=ciqwbALB9a5nL7C8PbXf4qOFnr5wXirRf1ivfrND/tD+KHciBfx1KY/g3Klocoh0VI8Y3klV6oog/11OSRfHefB+BUkz9dLWnqfAT6p7bcCmxljMDnBAb1BKG9iUMBKYrnRCPB9es9Nx3CdkLL/DVPkPrYlQHmXaaipPOVdHUuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) by
 CY5PR12MB6178.namprd12.prod.outlook.com (2603:10b6:930:25::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.33; Thu, 6 Jun 2024 20:57:15 +0000
Received: from DM4PR12MB6253.namprd12.prod.outlook.com
 ([fe80::53b9:484d:7e14:de59]) by DM4PR12MB6253.namprd12.prod.outlook.com
 ([fe80::53b9:484d:7e14:de59%4]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 20:57:15 +0000
Message-ID: <7f46d6f7-2ef7-4977-b97b-d644de950a30@amd.com>
Date: Thu, 6 Jun 2024 15:57:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix the BO release clear memory warning
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 mario.limonciello@amd.com, tvrtko.ursulin@igalia.com, stable@vger.kernel.org
References: <20240606200425.2895-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: "Gong, Richard" <richard.gong@amd.com>
In-Reply-To: <20240606200425.2895-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:805:66::34) To DM4PR12MB6253.namprd12.prod.outlook.com
 (2603:10b6:8:a6::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6253:EE_|CY5PR12MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 7496bc2f-5f0f-4f2d-b0cd-08dc866b3e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3dLUEVkVnZPc0tSRUlrSk9CM1ZsMXY3YnFaNExwMXZwbWxjcXF6eWJ3MDZi?=
 =?utf-8?B?QnY0WWhSYiswT2JuQ0ZEQ3Q4MXZVTGMrZzVpcDdIdGhVV1psYUNDNVRRb0xJ?=
 =?utf-8?B?cXowTnV6ckdVeGt1VEsxODhuTlRvWXB1b3VsZ1V6Z294eWFONFpjZGZWZEd3?=
 =?utf-8?B?Z1plVXJiOUJGWFFyaDRDc0xmdDZ5SWZnYW1NcjM4a1pnWkZNWnhwMVNJeURK?=
 =?utf-8?B?VjhJVVhSV1N5ODRsN3N4dWhSb0dZSUl6TEM5d3Nsd3RITzd3MFluZE9Iaksy?=
 =?utf-8?B?SitQZnNPUW1QQUhINkdlOVdMN3FSNUZ1aHJHeFROVkVQTnFFcWhoY2pxbWNJ?=
 =?utf-8?B?TnFtYjZta1NFaExZUWtJYVNxbnVoWkNtbkVIR05QNkFUeFhxeVhWQUMrWGZy?=
 =?utf-8?B?d21rUlBPTDgzdTFzZHBoWTZTdlBnN1BSeTdDUC80NnFyNGlEekdRbjNjeUNU?=
 =?utf-8?B?RUZsbFd3aHpjRmxJZGwzTndTWXdkNUwzekEvUjIxRnBlMlF4UCtIWVlQZVpr?=
 =?utf-8?B?Vk1BaHdGWUo4cFd4UVdSTS81cnlVWjhwWUUzTGlialFQUk4wemEzOXFlUk5Q?=
 =?utf-8?B?TFVaYllCZlRya3c3K1B6TjdwWC9XRURTa2pEZEJyZU9zamo3cmRIVnVyTWx2?=
 =?utf-8?B?WWtuYzh5QXZ2KzBYTUM0c0lORGFtVGpUd1hhRzdOSjN2RTRnMHNqTElDMmFE?=
 =?utf-8?B?R0JzbFY5WkRyQ0c0MVIvRC9rSTlSTU1WazdoWlBtdU4yK0VlUUZhNi9mTHM1?=
 =?utf-8?B?SjBnVnF3TUJBdVF1eVg2RCtSbWFhaXhaT2lNUTF3dmIxYW8yRzExZTFmVi9T?=
 =?utf-8?B?Qm5zUlRXRVJUQ0pMc2FsZmNWTDFzeWtxUHdMU0ZTWTRFYlJHQzZyb2N6M3Rk?=
 =?utf-8?B?YW8yeFJRSmxibkNrd1hYMWJNT0QzTHBDY0pTN2YyaVplOWFwOUxrbmh1TWtj?=
 =?utf-8?B?UHNVQ05abEFQRDdjb0IxYTZCcVplcUlQN0dUYnJnZEZneXRqc3ZWVTdRdDVp?=
 =?utf-8?B?Y3YrV1hKZWs5ajhUeG81N21FUkJ1V1liVTFiSjQ1YTdGdktFM3ViVzVkUjBP?=
 =?utf-8?B?L1pvaDJlZlJwUkNkU3M1a3U2c1VIQUNhbkkvRXd1bFVKakcwUjQ1MC85SGZt?=
 =?utf-8?B?cU41b1FxUGlLMEdKRXdHUnhTTzJURHozSHBqK2x6T3dGRjlVaUwvM0Flbk9l?=
 =?utf-8?B?aFFKRFBUSXpyZ2JuWVFReU1vKzV1SmYwRzNQZkdIVGVvbWpZWjlYNGFaTy83?=
 =?utf-8?B?NytqRzh6K1VQZXRqVitXZW84RXhVN2hpcnVwWURienhqK3VJYzZpK0lqdzRC?=
 =?utf-8?B?L3ZsVlhwVkE2eVJiU3hFM2w2UlhXWnBXSUs2c084Qmd5V29EY0U1MEpFenlM?=
 =?utf-8?B?RUo3QnlCVVRKVU9Cb3hhY0VNTWtQRW4yaVg0QXZ2ejZZL2t6dVR4am9oWFBs?=
 =?utf-8?B?UFlKN3hNWVFIaEpwUzVabVI3Mlphd2w5cW9ueE1tajVrUXVZYk41Ni9uMmkv?=
 =?utf-8?B?ZEY2L1hKUklRc1UrTWFXemROTjVlMHlzM3AxdVc1WDh4MmVTdER0enNtL3M4?=
 =?utf-8?B?VHFXdFBxdzUxaEpXZ29TL0FLbmVKcWZXS1RueG83WnF6VmkzaGZnbHkyL0hp?=
 =?utf-8?B?K1VpTXpNMW1td3dSRG5HTSs3WmF4TVkxemVVeXBNUEQxTUtyZC8rUXJFUXYz?=
 =?utf-8?B?aDFORlhUUkUxNEI4VGtxODFIa3l5T25sNlg1dkJpcElrTU12ZzI1WUh2N01w?=
 =?utf-8?Q?MSHsnOathFR1h0ODFkTmX2sJZ0Lv8bWRWvMNCRk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6253.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djFlR3UzTzUvV1l6REFqVHFidVJKUStOdWRVemNQcWtDVEQxQThNNTQ4VFpC?=
 =?utf-8?B?SDNOUklzVEVXZEswVjVyUkJyeVUyVkxYcmp3dHlHaWJlc1FJMEo5elBUOWV0?=
 =?utf-8?B?cGJMc3FZbWtTRVZwQllFaHVsaVpYWWpud3BLckM1QkhOSE5pMUx5U2xQWnhn?=
 =?utf-8?B?b29PUUd6VmtUVkYrQTMrRHVGbnRHQUhGTC9iLzhqSWVnNm5Wa2hjaTJ4engx?=
 =?utf-8?B?TmpQOXlicDVsNjYraVpkV3hZRnZNUzBjOWl2cFV1TVNaVEJGVnc3L3I4SThR?=
 =?utf-8?B?b2RxMjJJcnVoeHMvTmIySlY5L0tPeWJLSDg0N1JCVHdkTERibmx4R1lvY3VM?=
 =?utf-8?B?VENJYStwdmp1U3JoTVVVNmFEL3NTcWwwb0tnY0NiZm9uemFNajdBSG9HcStT?=
 =?utf-8?B?NmFLYWdlS2xKSXgvenIwMzF4dkV0UFhYeVZPd0dad2owcitKNGlIbjRsSHVF?=
 =?utf-8?B?Wk1NTjg5RDU2RWpxVUZ1OWJyZzBWbGplZU1Bb0I2R3EzRFp2N3hqYlRWOGdk?=
 =?utf-8?B?UmFJcEZrWXFkSE5PY0FUanEyTzNYYUJlQ1R2amlCWng4SGVYaDFGb2JGZzBB?=
 =?utf-8?B?bDZSM3IycGVIVVFSa2lyQjVaZDF0Vmo1S3d3cW5IWCtWK1o4WkdCWWk4SEU0?=
 =?utf-8?B?REs3bzdXYy9qRzYyLzFQN3dCZWJ3b3llbGdYUS9yMVc5RDlLOC9vUGlFM3Iw?=
 =?utf-8?B?SndSVUpsVWpxK3JUcStIRnN6YzlZNWlHc3J4OUFVUnF5SnRTL21aclA2YWtq?=
 =?utf-8?B?U1d5T09VaEx2VmNodHNLUjFvR2FPY3c5SEozQWdDUSs2Nkd6eTRjNVJPRDVQ?=
 =?utf-8?B?SUhXTFV0NXV6RXdXdFFUUEtGcXlIZGFKOG1COVV5UUNKM3g5a3FXU1Z3ZHFv?=
 =?utf-8?B?U0U4RlhUTGxnK3ViSXlzKzZEaE9mdVJPdWJ5dVRnTko0UE5lVnZ0Zks4Z29a?=
 =?utf-8?B?QUh1K21qM2N6K0gyUUFybkVEZS9QcFNoK3VCT0x3WjlBRm5mQytKWU9ra3E1?=
 =?utf-8?B?RFVjVDJWQXl3dXF3Um8xc2ZVL29ZNVYrcjBPbmVrS0JHNDd3OEpZUnYwYmVG?=
 =?utf-8?B?Z3lZdkRob0E0MjhVSGk1eitRMjJ5SU5JeW44a0dQV1BXUDB0b3Z0cG15b0F2?=
 =?utf-8?B?YkUrd3lDU0trZDBVYmM0VG5xM3kwejdQeGV3ZE1wWVk1L2phUHlPd1dCRElP?=
 =?utf-8?B?cnBsbk8vM2txZ3JYOGt0bmhTUklQaGtOemJjc0Fxbzg4RFI0U056RlJTUVFp?=
 =?utf-8?B?K1MyUkpsVEVMOEtNRW9vUTlmSjBBZUcxbTBWZm1BWmZCUHZiUVFVWG15Zzlz?=
 =?utf-8?B?eU4wWE5adVZXNk5DTjRkMVNWVnhiY3BwQWx4TTVDbHhaSXB3NjZYaVRBcUhk?=
 =?utf-8?B?dG1WTFpYRzBKdGx4MWxoREJUakMxUUFBNTdpeVJRWjV0VTJidEFtYUxQd3E4?=
 =?utf-8?B?NkIwbm1GbUN1WWVEcnIzWmJRWnpWK1h4Ymtwdndhb1EzbmlkdlUyWHg3dUJQ?=
 =?utf-8?B?ajNsaGU2LzBNeU85aVZqWVI3YkZaTTNXTjU2VG9jUThYSzBvc0hRLzIwQlZM?=
 =?utf-8?B?Q2tQdXYxSkl6ajluUlFSN3M4WHQ1bUZKUEZTNWIrV0tDZzh3d2tWQlZqdVJT?=
 =?utf-8?B?ZVlKSE9Fd3orR3B1bHI4N00zWkFQMSs3Vm9KSkpibVhXODQ5L1BoakQvOXZR?=
 =?utf-8?B?M3pvT0djSmdJWHE3d08yZFJrejAzbnh6MStGQ2xBZzhWcUw4dFM3cUYrTXVq?=
 =?utf-8?B?Ky9mT3V4Vm41U3BHaTlxcmZabXFpMy9KYWk5bEszOTFkL1N5RmMwL0NJdjE1?=
 =?utf-8?B?QlJMZXN4STJUUWMyWFlvNENRd0laUWpURi9PcEQyTitSamRlOHhCbFZFclVB?=
 =?utf-8?B?WEhrQmpVQTZ6VXQ3amRySkFPS2c5S3VDNlJJd2xRcUhBN1VsRFRjMlFDN2lI?=
 =?utf-8?B?eUp6dlh4R2ptT25naEgxRk9yM2JHQytDQlp3dVlYZENWZzh4NUJicm9Va25r?=
 =?utf-8?B?Q3NZMk5iemRlWE1uYWRDcGVnMGlJQnB5aTRkUW55YWc4V2VhaXBSRU42UzFM?=
 =?utf-8?B?KzBINkZaT2p0ajNJakpXQzZsaFhyZWE0VDd1ZVNwUzVMalpiMUZYdHN6SXg1?=
 =?utf-8?Q?K0cPnUzQFZlNuTh4b4zMWChfe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7496bc2f-5f0f-4f2d-b0cd-08dc866b3e7d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6253.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 20:57:14.9642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRl28HP3Bc4v95uTD8hd9R1L6JBR1ixT7gmtAUHzU7aZ5Z5KUCTzF7YXLkI4WVakobJsCVZKn5NfSOpnXZFfCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6178


Tested-by: Richard Gong <richard.gong@amd.com>

On 6/6/2024 3:04 PM, Arunpravin Paneer Selvam wrote:
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

