Return-Path: <stable+bounces-12353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C6B835E4F
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 10:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080011F21F92
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 09:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AB239ACF;
	Mon, 22 Jan 2024 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="priTPpCe"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6DC39ACC
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916073; cv=fail; b=LbOgxNDuuLEtuKs4ukcTa0p28Oisv0NNwissQi+bjH8LAH4qRoc7dptmfo4pqNffjgDPQoxNplCY7XXqO/4UMs86vy0XajX39jMoQsYxZXShtQMxewInX7VHg9hA7F6FqlChwAcVkdkMsITR4UNaVn1ZSL9BVveXTU0jDXXGvWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916073; c=relaxed/simple;
	bh=pm98BML9BDs0hs7C4w7LYQCTkhrykoQmZCbDD0ePj8Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tckq1lFITXvQYWoCHMG0J7JXPpC5G7y7+5oqPixB7EAPwmKQdFI7sz9hgaFv9/OFibAXQyaPRnnKFhTb8ZeGj8ScqJGYx3wZE32t/vqeesDUG2AA1AAj8ono4ttkOES/4rjzNO1ycq9py3kV7nJdFMvqE10WvPLadx0BvV/mrnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=priTPpCe; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/fQlN1N4oPD2yUQ2u8HKkKUtPYhqXcWZiJarUft+WPAnLD3S8GFu96Jg95lHEHgPJmOIdWslWIgFCkwoh101ZlRmjsdrsqId473UewsHRcYr3bxAmowooibnDse2Ysnp8Y3HPNzySYZz5MRjH8aEWWU9gjjmPx1tEza0w9Ue1P0Ug4CUfwoXFk9ea5hwyh9LMnb8udm0AuxmdA13EzRTvVp7FPPK7WFXEL3nYUzQbBDC9UL+Uzxvtp00rf6Vdw3+1kvNY4kAzuw8uS4WLdE41UnW80ykaXkKyYar+SM6D7cwUvtqlaDIHUzUfjmfFvi01COaHOdH+UyRJA+bVO8yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldI2rlenWE7pwzxmFW31i4lRvivOBJXk33dg4aj1hGM=;
 b=RBv78RmqgSRADF+a0K6lHfSmcDpT4NkVHlg4HFxPPtkJ0Sorw5N8x+Fx+AKJCETM9Y0IqMdLHV4jX2PTVMiedALu6BQKidDdyIqpQyFqQOYARhjNetVBdDh0ZjwEfzvLa1Is+erhjVEtNpta47lME0kzQsuChCnpJdyiFERKE6/Z7C6B7qfNdWUHvGDg+P93U7s6RXyYvapTWA+Nvu1YPJkd1wgM/XnsCaZ7Y3J8cnIMaHnvMLvlyPZofHR+R2jnYwWJyhjmBLKuZ0E6JoglBigmniC3+PWFo90VxdgxYm5aMXMQeSM5ics+RhlkJ6pk0OU1ayXWJJLPpWQphJVcBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldI2rlenWE7pwzxmFW31i4lRvivOBJXk33dg4aj1hGM=;
 b=priTPpCef22IGuQYwJSLwODhPT/uqdIwy+rpwWjx2EH+6mmf8fy6xth3sGL2fC+x2ToMtgYxLMXsA02PBYI8pbi1orBV02hbHBU2mkRY0OqR2FZsPD+exn4IQRn/Y2e9+P84X6lNwtCIUZLA5eueQ64z+BYGz7R4l8hCT8JK9Dc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8035.namprd12.prod.outlook.com (2603:10b6:a03:4d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.27; Mon, 22 Jan
 2024 09:34:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 09:34:26 +0000
Message-ID: <d142f9f2-29a9-40a9-8ed9-9b0e6df84a80@amd.com>
Date: Mon, 22 Jan 2024 10:34:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Friedrich Vock <friedrich.vock@gmx.de>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org,
 Joshua Ashton <joshua@froggi.es>
References: <20240118185402.919396-1-friedrich.vock@gmx.de>
 <c3d81197-a2a6-4884-832c-d0b8459340aa@amd.com>
 <CADnq5_O6U8DSGJOUk9_sfL2bEUGgLej-nLsVH_ep-2BKZL_Bng@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_O6U8DSGJOUk9_sfL2bEUGgLej-nLsVH_ep-2BKZL_Bng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b3a9e4-3bd5-4350-f351-08dc1b2d52fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xy5zt3qKZMK/pCpW6owKd9SIqxKigMovXyNuDIwLRhBeBaUJKMiTlF4wO2Q4cP4hjoZ+6ZaCosnRrhbZAryZs8JBafkxeQ/O9JC/xNri8O1vws6p2rQ3P2NdqrCPN/PJWs+jTH072nxfira/4hNzPJdbbJeA8JXkNe7hKggm4VQgj7gxXWJMnac+P7UrmZPt+vIuyFwjk42pwTlSvW71iglbA9vuP1Pc48bltWSIVnx1evPbfIQx4oNPiwOdxIl+Tklu1chppNiJzxOejgfMsVGeZtSUA/jwS0H3lm80P28UqOx5xOeSa4R1f5uJApQQTQBIK8k0RfGvaSRwZ2j+EpZ6Ukr8rPUML+/vlqe3exuQrN91IQ0UDt84/B8ecNRvt8WqJ/IqXGbL6ceLUPev7IcVWi6KUOJt3Zm0sWQsN8i3MD8gnjGQ28oCi3WVC74QVLNJdLOCJfYmQ8WV++i5qH1/g5fDEg/d5BSjZVs6Uih0xlHj7mx1MtsvcS2t9WuJaDyt1yt8L6REHVyLmfe7/F/CxMftORd9nZTQBtVOExWtNYd45cBqxtP1G+ew5q/2ma1UMIaFI9yHU+kPb5FH6tywfFX9bA6WOczKfpxzdO+eCO2eIipG+V+CQbhtGWU8ertCSqJeVeCpUuxRYQY4Fg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6512007)(54906003)(6506007)(6916009)(478600001)(53546011)(66476007)(66946007)(66556008)(8676002)(8936002)(316002)(6666004)(6486002)(26005)(2616005)(66574015)(83380400001)(5660300002)(4326008)(41300700001)(2906002)(36756003)(38100700002)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjRvaHQ3S1dWRzNVM1MvVGFPZDBaaVJUV3FiaDZDKzExVG9CU2ZNcnNuQ3k0?=
 =?utf-8?B?ZUcyeGxLaUJObldWbGFLN0p5UHdYY2ZUa2ZsM3VkWTVmRUsvT3NCSkttYWFo?=
 =?utf-8?B?NUxhT3NoSnZicGFiT0gvNlVJbnpCVms1RU5VZEl5dGVvVG5PTXhyZVQvRjM2?=
 =?utf-8?B?WjEvOGRha0k4a3FGNHhGQ0NqV3M1cFB3Ky9TeUV4ZStxNGpVclJ4dWoxMndE?=
 =?utf-8?B?Wkk5VUFEbTNQVHpGTmRxOXlqbzRIWFZpbElIRWU3VTJoeDdUVlBudnBSTHNj?=
 =?utf-8?B?Tjd3Y21IOUlGTlFLQUZJNFJ3U3Qzd3h3Q25HMVRMSE9ITG9mOXdhVjRTWkFj?=
 =?utf-8?B?RExOODZzS3FGNXZleFdBTVA3aXdVOXZCUzVlNGdqVWJGVUJBL0lsNm1WSDhV?=
 =?utf-8?B?MmNYZlFwVXd1VU1TV05OcWpHVVplRGh0UnJDZklzYlMzVEFkMFB3U2pJSHNk?=
 =?utf-8?B?TmZvNTJrYVRrUXhEWEtUQmxZczNsd2czdVl4b3hMclJpbjUxU2NjWDJML1ow?=
 =?utf-8?B?elBCOUQ0bitPRHZ2OUFCZDdWbTZROTFuZHc3aWxObUg1a0VrbmJEMUVlU243?=
 =?utf-8?B?WVhjMitURzJjM3VtMDNsakZyTDdvaWFwOHF4WEpGZGFiRDBtU2dkNEQzZnR3?=
 =?utf-8?B?NkhsS1RoNmRlZ1NvVFBRRyt6TkMzMFFmN2lEc2dtcWJhNDM1UWEveExreUph?=
 =?utf-8?B?TEtMWUIxcnhDWGZVa216L1FOaVBMaVJwR3NQMzBhV09VMGhTdVdGYnhXbE5T?=
 =?utf-8?B?TXk3c0drNVVrb0ZnVE1DR2szR3dpSjNwZER4a2tUN1pwMGdBZnhGR1hCN1Yx?=
 =?utf-8?B?SERBdVZ6MzRoQ1ByTHlURXB6ZVF4bVNhWmVOOWV4d0NuS0lMOWQxK3drSkE0?=
 =?utf-8?B?UWhlaGc2SGlPOHJzRkQ0U3JDN2Y1TklWQmZ6MVZiRWQzWTFObFJhTy9TUVZx?=
 =?utf-8?B?Ty9DYzJ6OVZWR01JVjVSVzVHZlFMRjlRNTg2UW9KNVY4K29JNm1xUHp3ZDRh?=
 =?utf-8?B?SmNPM1FmWHJpWk5ENkpvQzlEeXJyVlM1UE1KSHV6UnN3VGF2TldtVzZTbDlj?=
 =?utf-8?B?Rk42SDFmOVFKRDZrVFhVbi8zQ2dhK1NOZEo5S0Q4dUx0MTdZN0c3QWdLbEhK?=
 =?utf-8?B?L0h5ZS94VkhmazFFcVpIYWFBQTFlWWl4NVBnS3owaVVJNWszYU9iaU00TXI4?=
 =?utf-8?B?YjMybHNmelhNMVFHV1luMnVKWVZiNXU4WVF0NkZ5RHd3ckhQZVFxTCt5aGtC?=
 =?utf-8?B?MEQvdjgzWHY1SXBRZmJWbVRoSnlvY2NOWFQyRDZJSFJkOEYxdWNGLzlrQ1RZ?=
 =?utf-8?B?ckhwMVFOTGlGczhNVDQwOHRGUXdCbGpGTVpmNmNObjEvWE9WTXFVZmJGenJo?=
 =?utf-8?B?RHdLNW9rblhlS0I4Zk9xVEVjTXRYY0FnUnZ3QUd6N1NEWjk3TitMd1JERDc2?=
 =?utf-8?B?RzI0SjhhdjRFaDJpQVlpcjJsWjVpUFA4QnY4WDZSRW5Td0ZkS2QxdHRZYnFR?=
 =?utf-8?B?MVY2bko5amY4ZGJKTnBrcmRxaDhUYVpoc2dFU2VTWGlwbHFldTVscEhrbHVm?=
 =?utf-8?B?anZEVGZiRC9RK3Awajg2a091T3ZyWk9QeXp6dXRKcHFuUGttQUlQZGxlL09n?=
 =?utf-8?B?MllLb3NoVWhZem9tbVhvSUVrd0htTUgyU2psZjQrN001aEdsZDl5Y3hWWklK?=
 =?utf-8?B?NUl6c0FTakVmZVRyQW54V0ZBQWdrb3daa21lYXdpOEVnRHpzMnp1S0RXNzdQ?=
 =?utf-8?B?ZGlPaTlPMjFHTk56VHpsTUk0WS9TNW5jWE13NmdVcjVwK3VhbjJ0STNRcTVL?=
 =?utf-8?B?SjlRdEFlZ1pETkNIYU1JN2hiZDB6RWJBeldzbDdRMzlqamtOZFl2KzNmQUJj?=
 =?utf-8?B?N1c1Y0UyalQ0Tm5mSTRxVGdiM21BaytIWndGRm8rb0YrSlJWNkI1REd3MWRH?=
 =?utf-8?B?OG53Y25qekdOWm1Gd2xoSTdJWHlqQnlPYnpwcmh2dDMxNi8xbXJZeG4vcklZ?=
 =?utf-8?B?R3VuY0xyNUlwejFvdTVVdllHcFZVUmkwVURvS2JkZ09IMHdpMXdiSGJUNnow?=
 =?utf-8?B?a1MvcE9HKzJuUUQ4di9uUGlnSnQ1c1RSTTl4WFhiMEdEUU1sZzhEZllzSTdS?=
 =?utf-8?Q?b7fDsEhl0TKXHe3sR4IlIQvqF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b3a9e4-3bd5-4350-f351-08dc1b2d52fb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:34:26.2065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOGEUR3Z+QO03Ikp40BQFNvDT6aWYz1FJYRgj24sn4Flm8VRZjZdwM0isMD60ocq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035

Am 19.01.24 um 15:38 schrieb Alex Deucher:
> On Fri, Jan 19, 2024 at 3:11 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>>
>> Am 18.01.24 um 19:54 schrieb Friedrich Vock:
>>> Allows us to detect subsequent IH ring buffer overflows as well.
>>>
>>> Cc: Joshua Ashton <joshua@froggi.es>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: stable@vger.kernel.org
>>>
>>> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
>>> ---
>>> v2: Reset CLEAR_OVERFLOW bit immediately after setting it
>>>
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 2 ++
>>>    drivers/gpu/drm/amd/amdgpu/cik_ih.c     | 7 +++++++
>>>    drivers/gpu/drm/amd/amdgpu/cz_ih.c      | 6 ++++++
>>>    drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 6 ++++++
>>>    drivers/gpu/drm/amd/amdgpu/ih_v6_0.c    | 7 +++++++
>>>    drivers/gpu/drm/amd/amdgpu/ih_v6_1.c    | 8 ++++++++
>>>    drivers/gpu/drm/amd/amdgpu/navi10_ih.c  | 7 +++++++
>>>    drivers/gpu/drm/amd/amdgpu/si_ih.c      | 7 +++++++
>>>    drivers/gpu/drm/amd/amdgpu/tonga_ih.c   | 7 +++++++
>>>    drivers/gpu/drm/amd/amdgpu/vega10_ih.c  | 7 +++++++
>>>    drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 7 +++++++
>>>    11 files changed, 71 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>>> index 508f02eb0cf8..6041ec727f06 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>>> @@ -69,6 +69,8 @@ struct amdgpu_ih_ring {
>>>        unsigned                rptr;
>>>        struct amdgpu_ih_regs   ih_regs;
>>>
>>> +     bool overflow;
>>> +
>> That flag isn't needed any more in this patch as far as I can see.
> It's used in patch 2.

Yeah, but patch 2 is just a rather ugly hack to process the fences after 
an IH overflow.

I have absolutely no intention to apply it. So this here doesn't make 
much sense either.

Christian.

>
> Alex
>
>> Regards,
>> Christian.
>>
>>>        /* For waiting on IH processing at checkpoint. */
>>>        wait_queue_head_t wait_process;
>>>        uint64_t                processed_timestamp;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>> index 6f7c031dd197..bbadf2e530b8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>> @@ -204,6 +204,13 @@ static u32 cik_ih_get_wptr(struct amdgpu_device *adev,
>>>                tmp = RREG32(mmIH_RB_CNTL);
>>>                tmp |= IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>>                WREG32(mmIH_RB_CNTL, tmp);
>>> +
>>> +             /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
>>> +              * can be detected.
>>> +              */
>>> +             tmp &= ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>> +             WREG32(mmIH_RB_CNTL, tmp);
>>> +             ih->overflow = true;
>>>        }
>>>        return (wptr & ih->ptr_mask);
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>> index b8c47e0cf37a..e5c4ed44bad9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>> @@ -216,6 +216,12 @@ static u32 cz_ih_get_wptr(struct amdgpu_device *adev,
>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>        WREG32(mmIH_RB_CNTL, tmp);
>>>
>>> +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
>>> +      * can be detected.
>>> +      */
>>> +     tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>> +     WREG32(mmIH_RB_CNTL, tmp);
>>> +     ih->overflow = true;
>>>
>>>    out:
>>>        return (wptr & ih->ptr_mask);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>> index aecad530b10a..075e5c1a5549 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>> @@ -215,6 +215,12 @@ static u32 iceland_ih_get_wptr(struct amdgpu_device *adev,
>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>        WREG32(mmIH_RB_CNTL, tmp);
>>>
>>> +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
>>> +      * can be detected.
>>> +      */
>>> +     tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>> +     WREG32(mmIH_RB_CNTL, tmp);
>>> +     ih->overflow = true;
>>>
>>>    out:
>>>        return (wptr & ih->ptr_mask);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>> index d9ed7332d805..d0a5a08edd55 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>> @@ -418,6 +418,13 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *adev,
>>>        tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>> +
>>> +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
>>> +      * can be detected.
>>> +      */
>>> +     tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>> +     WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>> +     ih->overflow = true;
>>>    out:
>>>        return (wptr & ih->ptr_mask);
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>> index 8fb05eae340a..6bf4f210ef74 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>> @@ -418,6 +418,14 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_device *adev,
>>>        tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>> +
>>> +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
>>> +      * can be detected.
>>> +      */
>>> +     tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>> +     WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>> +     ih->overflow = true;
>>> +
>>>    out:
>>>        return (wptr & ih->ptr_mask);
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>> index e64b33115848..cdbe7d01490e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>> @@ -442,6 +442,13 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *adev,
>>>        tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>> +
>>> +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
>>> +      * can be detected.
>>> +      */
>>> +     tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>> +     WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>> +     ih->overflow = true;
>>>    out:
>>>        return (wptr & ih->ptr_mask);
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>> index 9a24f17a5750..398fbc296cac 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>> @@ -119,6 +119,13 @@ static u32 si_ih_get_wptr(struct amdgpu_device *adev,
>>>                tmp = RREG32(IH_RB_CNTL);
>>>                tmp |= IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>>                WREG32(IH_RB_CNTL, tmp);
>>> +
>>> +             /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
>>> +              * can be detected.
>>> +              */
>>> +             tmp &= ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>> +             WREG32(IH_RB_CNTL, tmp);
>>> +             ih->overflow = true;
>>>        }
>>>        return (wptr & ih->ptr_mask);
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>> index 917707bba7f3..1d1e064be7d8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>> @@ -219,6 +219,13 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device *adev,
>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>        WREG32(mmIH_RB_CNTL, tmp);
>>>
>>> +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
>>> +      * can be detected.
>>> +      */
>>> +     tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>> +     WREG32(mmIH_RB_CNTL, tmp);
>>> +     ih->overflow = true;
>>> +
>>>    out:
>>>        return (wptr & ih->ptr_mask);
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>> index d364c6dd152c..619087a4c4ae 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>> @@ -373,6 +373,13 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *adev,
>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>
>>> +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
>>> +      * can be detected.
>>> +      */
>>> +     tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>> +     WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>> +     ih->overflow = true;
>>> +
>>>    out:
>>>        return (wptr & ih->ptr_mask);
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>> index ddfc6941f9d5..f42f8e5dbe23 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>> @@ -421,6 +421,13 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>
>>> +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
>>> +      * can be detected.
>>> +      */
>>> +     tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
>>> +     WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>> +     ih->overflow = true;
>>> +
>>>    out:
>>>        return (wptr & ih->ptr_mask);
>>>    }
>>> --
>>> 2.43.0
>>>


