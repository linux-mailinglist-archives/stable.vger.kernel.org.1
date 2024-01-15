Return-Path: <stable+bounces-10864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1853182D631
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 10:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2FC21C212D6
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 09:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E784D2F5;
	Mon, 15 Jan 2024 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qU3G86wE"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C520D26B
	for <stable@vger.kernel.org>; Mon, 15 Jan 2024 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWyf1+vXxSuJlleWOlb+/7VMZro4d4D9LsWOB7DuFE+SBjZnNTjCxzK+p6iKKPsADrU4IcSbBrz0r2KiYb74n2MfkG14fiHi1VmlRKquEUYrQqFDuScLRrjcD2nMwrGpvcOSHP3eXGlGppHH9JdXQO5GYKQg5AAR6YFc0aavnuEau2SsPvWmarp4RTT/Rnjk4Q/FqvNI2amahcJgC/4iz6DMSZMbw30wZj9EuCOBDOdh9n7VCuDrRlfl7xj/mwInvLcvIpfS668gtHyb4AExXEgtrtJDxCmLL1dd8k7N8cNmXKeqMvJK09dCEKowOo9wq4604P4DKTbCuOjelMhhfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQSG/1dL4WoIINryByQd1MGlB+dhyAIqVf15EWPdfWM=;
 b=iu8acjkzM+1CBOr/rosdkBvMvpxn+G2w9uJHuTACklYxDRufzp2IMB4z6UwWCkFPmp29vUV6vEEIvZkEGAvdDiqIx8FNV2r2G5F9gg/JPSbp2/DPg0TRQyg6uLMToL9+NnwoWVm1M7PQklRLcl2o1G/KCp/s4hpYyIeTHEDYDJUlabM/01I/IVIT34wIEekIdOaOukiXgrEwAmXUvtQasW5o4fSqwORPU66Q6AXWmnQ8XPGcTBfp2z0c1W4PSd1SzK6gfy6HseLhfHI6mFoNE5v2/YxUwCdO3iy5+QlZc0rZ1vGLNpB8PlJciMXfY9afp6R5ds84W0B32sDyf0Rqng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQSG/1dL4WoIINryByQd1MGlB+dhyAIqVf15EWPdfWM=;
 b=qU3G86wEeeTnh0N5Anoxp2iAB06dmshI4q5DK0tiRyDnI+l29TAQKqCHuYl3f02Wg8xLRtDKXLaok75w7jCOyxf3Hn4hKkrBy6gOj1OPT2dtjjfLU+NLxNOp+g0PPZnNU1/BRUx5GdDUnXCbRx74lS3byYluj7TbE3JWa6Ukou4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 09:40:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7159.020; Mon, 15 Jan 2024
 09:40:31 +0000
Message-ID: <c9b839cd-4c42-42a6-8969-9a7b54d4fbe8@amd.com>
Date: Mon, 15 Jan 2024 10:40:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
Content-Language: en-US
To: Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 stable@vger.kernel.org
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240113140206.2383133-2-joshua@froggi.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f45e50e-9756-4e13-e7cc-08dc15ae03db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bYReAU3CaLT4a8BSIgHCw2sN+zIQXb2W61Zohrjsk/ulPICY/lMXqJdsxg8LYq0GqYbjrvolh6Rmdx6LhnzI/irWq6M4tL8NldSJf/HJ9QWKC0lK8ePqhPPMdkz0am7pfCMKS9E7ZytZoPr7GuHRp8LUQEDLKihUrh1p8tClQ8L/47NZyi1AuuPupeUbo8TarO317vdBTliymDQdWq5k3t37THSWzp+zwAQsenJdhgGw1WtLrP5OTJKsjJb5Yjba8DMNimv0ADFgdwvTe6wH3zCr9N7Ob1rMXiRUPOtWXlkutupwuABuPNwC90X7GHbCGYrcEmixzB6lGc6d1rvm9FNwK1meXhqQVJ3tJL1SzSvhZWw4unchahsYkS6A48Sz9IfS1O2FhVs3ZInnXqQZYgm/AXJ2kIn0GMYaQH/KjpRR8VU/Uluv9AzAyD54OZOOTr75LbrI9tScf58/cntHw1iXUaJfxCXBQIgGsJFpkm92wb51CaqUTIKUFJmqA6m8tiOgDgV7uEPfbOVdxwJYB4086OEN24wo6E0ISJmsz2fhd+xIZGrRLXJmOAaSbznjEJQAebVEBKwxBLy6MthF3o7MaEbQU/zcLWNTp9wl8pZ2fS3vH5ikIGlcvRkUFeNa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(83380400001)(38100700002)(86362001)(31696002)(36756003)(41300700001)(26005)(66574015)(2616005)(6512007)(966005)(66556008)(6486002)(2906002)(66476007)(478600001)(66946007)(316002)(6666004)(6506007)(5660300002)(8676002)(54906003)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkE2QVZnMUw5TDhBVVpSQjFtZXJqMGtRQy9PMnhxcHl6eDRwQWZZdndMME5x?=
 =?utf-8?B?K3hGUVRWUm1aYjFqZEtYeEhoUUhIM2JPT1V1b3UvSzFlNlZSV2U2c3pnR3hj?=
 =?utf-8?B?RVFMbEZBREk4ekhGMlZ5T1ZmZG5TdjlTWnhPTUZyS3lIT0pSV1dmcWxvK1gz?=
 =?utf-8?B?c0g0RzZQYTRjTnRaZGxlT0dkN2kyYXJMdWNrU1E4V05aYzk1NXdQU29mTE5k?=
 =?utf-8?B?MGJ0RVp4SzNWMHJ4dDF6cHpjQmlKYmFMWnozMHdodFFYTWtVdFRCVW9RU2l4?=
 =?utf-8?B?cStZSFVNazZVL1FzY1UvM3RYdDhsaW41Q3RxMnUyV1lZQSsyc2ZEN3gvTUxh?=
 =?utf-8?B?NUt2b1B6THV2SllsUWZ0VlZGRjNsellyd1Fib2NBOUQ3MWdBN3lxYWFuN1B3?=
 =?utf-8?B?VzVhNVoycjZBS0oxRVpXZnBPVFFYUFNjaU5mK1RJRUo2SGIyL0xtRmhRSWxR?=
 =?utf-8?B?WlV0RWtaVnM1M0JhTDVDMXVFMms5d0owSDBMYzVRNXVoM3hrZUZWVkxiNGlY?=
 =?utf-8?B?NEc0UlVWRmhobjhSK2dZRTF2ZE4xSERPNGRDUzdxaWV3SXdxMlU3c2o3am1M?=
 =?utf-8?B?S01ycXcyN29DRkJDQzFTR2FMbUZLZkpCZDJkazdxcldVWG9SOUh6c3lIK2gv?=
 =?utf-8?B?WUhzVXpGSkZPeXB3QTh4R2tjVnpkZjNRa3d3amVtODFZZmNnZDE3MGVZa3Bn?=
 =?utf-8?B?cWcvT2VRekYrSHlYSnRidUVkWk9UQi9OR1pPN1dtV0xHUzVEampwakhNZTlQ?=
 =?utf-8?B?eHk4Yng1Y2xvM2NsRWNlUkdsUmVMelhWWGNmK0FRRTdhbjJ0V1NqMUkvZTNx?=
 =?utf-8?B?YmZBU3lMdVJKZ3I2RDhLM3lxTSt3MEEvOWpBVFhYOVFsYkEza2JHbkdRSFBS?=
 =?utf-8?B?RGJQK2MwWGF4VFpyZ3F0VHk2MWM1dE9XZ2NRK2JmRWVwc2ZTWWZZU0ZQWDV6?=
 =?utf-8?B?WkFRcjRXRWxuWXAyZklDSWZIVTR0czl1TGJNcURMRDZoOW1kWVRuQ2J3aFFB?=
 =?utf-8?B?NlBOeEVwMlJaMTk1azZOaEhQbnIyMTI2b2d5MDh6NG9KSldzRitqdEtHaFlT?=
 =?utf-8?B?SWhSVUdwRXd3WDZhRGE1TXB4VTdsRXNPUHpXWDlhYldKSFY5Z0hlTTZPY281?=
 =?utf-8?B?TTZnRExtMVFiSk0wbXlKQ2phVHNkNjhpcHZ0QTdPL2RPTS9qZnlwRmNnWUNp?=
 =?utf-8?B?N1dsREhhS0d1WmY0UjN5WElxOHlSOWhtOUNiS1BzcHRyOXVzSjlVVWd2WXU5?=
 =?utf-8?B?dElEcUdvZ0VCSy94b0lNOUhZeHRCYkVkQXFLVDJtMTlWak9NZ2Z2b1YvL2pC?=
 =?utf-8?B?OG9mWnJuM2srS1lEOGlVQ1QzMm9NcU10bXJHU0hqUCt4UzNpMUhMc1oxQzZX?=
 =?utf-8?B?eXhZenZ0MG9iNWEwVjRSMllEcjRiZ0RSRzF2SjdONzQ0SHhGNE9sNllVM0Ex?=
 =?utf-8?B?VDdiYysvYjRwMTcrcDRiZ3V1OGdValhNMzZWQ1hJeDlXcDNCTXlrMml2QTBq?=
 =?utf-8?B?dGhtZzJRSlhIemcvSElDQ2FyTW84cGlVSG9Rc3dCRzBrSVZVZjN0aXl4dUJF?=
 =?utf-8?B?bVg3OWRMVWM3S3ZyWTZCM3JMZTV2elBoRDE2a3Fyc3pHc09pK0xlMm1GYmxE?=
 =?utf-8?B?MXdhcmNLelNQTFRIZnNmb0FnQlFKZmFpMVVVazQrcG1HV2Nqdk1kUzQ1bUda?=
 =?utf-8?B?ekFlS1IzSHhrd290blJRMDdmOXlNNWpyV0ZaV3FyRnZNdVVOTmMwQ3ArNWVa?=
 =?utf-8?B?RnZEMTFnQmV4S2Jac0dFRE9hd04raWErZkN3QjRiT0ZNUVpYNGxEdHYrb3VX?=
 =?utf-8?B?R2ZTazNFcHlqcngwSko3Nzh2bUNQTFhzMkJHRE5pNDNxcXVKSjJuaE9paG81?=
 =?utf-8?B?Q2s4UE12MUFzS2xBMTJXb3lMN1E0cW9lNTl4eFdhWmppWm5jWUtZV2N1QmlK?=
 =?utf-8?B?b3VjcHJ5OU1JQ0hWVUVmTUN0TW52OXdBbzR6NDU3dWg0ckJ0V0hsWW10WTZq?=
 =?utf-8?B?bmVITGF4UTNpMnMwN1lDUjBnaDRudzBOK0NqcENNem44b09ZUWdHbEEyL0FF?=
 =?utf-8?B?M1BvenpqOFVPV2YzcWpkRkR3VzJjV3NYenVETmhmWWdWVUY2czFvakJCdjhU?=
 =?utf-8?Q?schELsNcM6JuQi/61L8T6zRNM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f45e50e-9756-4e13-e7cc-08dc15ae03db
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 09:40:31.4320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zi9Opi5wwB51n39nXXKpda/5OOg66fTZcXg0tAoxnBhFfdASAOw0hi1nxHLbNkX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451

Am 13.01.24 um 15:02 schrieb Joshua Ashton:
> We need to bump the karma of the drm_sched job in order for the context
> that we just recovered to get correct feedback that it is guilty of
> hanging.

Big NAK to that approach, the karma handling is completely deprecated.

When you want to signal execution errors please use the fence error code.

> Without this feedback, the application may keep pushing through the soft
> recoveries, continually hanging the system with jobs that timeout.

Well, that is intentional behavior. Marek is voting for making soft 
recovered errors fatal as well while Michel is voting for better 
ignoring them.

I'm not really sure what to do. If you guys think that soft recovered 
hangs should be fatal as well then we can certainly do this.

Regards,
Christian.

>
> There is an accompanying Mesa/RADV patch here
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27050
> to properly handle device loss state when VRAM is not lost.
>
> With these, I was able to run Counter-Strike 2 and launch an application
> which can fault the GPU in a variety of ways, and still have Steam +
> Counter-Strike 2 + Gamescope (compositor) stay up and continue
> functioning on Steam Deck.
>
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>
> Cc: Friedrich Vock <friedrich.vock@gmx.de>
> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: André Almeida <andrealmeid@igalia.com>
> Cc: stable@vger.kernel.org
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 25209ce54552..e87cafb5b1c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -448,6 +448,8 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, struct amdgpu_job *job)
>   		dma_fence_set_error(fence, -ENODATA);
>   	spin_unlock_irqrestore(fence->lock, flags);
>   
> +	if (job->vm)
> +		drm_sched_increase_karma(&job->base);
>   	atomic_inc(&ring->adev->gpu_reset_counter);
>   	while (!dma_fence_is_signaled(fence) &&
>   	       ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)


