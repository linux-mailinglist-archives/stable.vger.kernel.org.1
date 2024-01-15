Return-Path: <stable+bounces-10941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1517882E242
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 22:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934671F22DFF
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 21:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27051B285;
	Mon, 15 Jan 2024 21:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VK84YmA8"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC81B27A
	for <stable@vger.kernel.org>; Mon, 15 Jan 2024 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6zt05XnX0v6/kf1bPQ3mSy9P4PfO+ECYMJkFi1ca+3Yz6mmKlNQnLOLZqubhoL0+WMbZrG+DvC/2IYQNniFvpPjwX/Fcvl66eA729GcgnT/j9CHGeOqEQw8PwerzwG95bH57CC4jm+ggLZ/Mg8W2TLWVWPnaYEAo6nNsf7hb6AXwKkB4ubBFjsLZthx+khhksEDO0EbH7gD5PHqy7mDF26YEH10kXDu7ALyOvmVheAA1bEI6/qQz6yCkinrBZO6RrRV3iiHIBJEa4z6YlygyqkOkuG73GJKDX4RZGL9roN26Hi+HAgXHChhfJ7aj49QbwmQwf/BjjH9YaWh4OjzwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tm1IE6OQMC0XPdM+3ZJ2mCUW866JAuuHXkGh+ZnIpU4=;
 b=M3aBwk+r0ob4nQeUduahLT1aJ6+KbuzWbt+8h2y3c4EdHfNcyy5u/chn6bu+pv8gDeSF6a4i+VISz5uLYDUubS8BYx+ztGgv2in+T/daX5J95idTuxg5EpNCE1l/ycNA8JYCR1MgtsPv4X7qhA6/GAvbzGdqzH7dYZO2hzel695808qX51gN905fk1AqDibbMDMfwdb2r2wtmhdTfRVTB7WVkkRDSJ+yz2Lnjv00ITKtxG1y+4eG1Rz+j6YC4epTjaDmwWsG8HatNFPwRImBGy7bzwZdAzLDHdB+4oofpXA0zlZqIYeXV426+oJViN0XWGR7zmtKqZWvHqCB9+g3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tm1IE6OQMC0XPdM+3ZJ2mCUW866JAuuHXkGh+ZnIpU4=;
 b=VK84YmA8JZLzCegBqf1/XalALnZXfHvj4A7LgOZSV4vp5mNhfxS/tOsrXkfDqPA07oeLkNMtrDwkpzo7nLqcNfrlmmcsdKdie2kGqwp+LMpbI/alWgDqX/CjFtr8CjkaRzKVsrsBUXdAFxfoEFHocLavJoD+Pkux/qzizBcVtvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:312::14)
 by BN9PR12MB5210.namprd12.prod.outlook.com (2603:10b6:408:11b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 21:44:39 +0000
Received: from SA3PR12MB8802.namprd12.prod.outlook.com
 ([fe80::dddd:2ab0:972b:603b]) by SA3PR12MB8802.namprd12.prod.outlook.com
 ([fe80::dddd:2ab0:972b:603b%4]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 21:44:39 +0000
Message-ID: <a76b4095-f588-4e71-afc2-aff6eae6c037@amd.com>
Date: Mon, 15 Jan 2024 14:44:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Drop 'acrtc' and add 'new_crtc_state'
 NULL check for writeback requests.
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240113091101.3428373-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20240113091101.3428373-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXP288CA0012.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::21) To SA3PR12MB8802.namprd12.prod.outlook.com
 (2603:10b6:806:312::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB8802:EE_|BN9PR12MB5210:EE_
X-MS-Office365-Filtering-Correlation-Id: 061d608b-d0bc-4f25-32f9-08dc16132d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xLRgy5rDnU+8IcyKtu+z/vgvJHoRsFj56y8JHnG6M57sOafpwiPAvMv285wLfkRBdIHfTWm3YbV+OfnyEUTil+MR/9GrXV58GiG+UfjuABu/v5vPxGGNlPRraSq+9xmzRtDTxMouEbnAHx/3kalCxYI6BV5ZeAilIB4vOALggPPWrTPVQ57wQeerCWhCUvH/LKZsH/6mYXnKnLWl8otF1vz/jLf3ibl7SnxarpxNTPC52nw8erj1sClElUsGa/bXw7oeJO6gVmjRY9DrJHll8tz+DC1F+NQCa3Yx0Ssx3EHur6DHDp/TC5TSuS/3crlOblWqPI8qfs1RmJxXkqHgeg19KfpvlgDQMv7lzIIQhwIeip5Aw1Hmkd1avIlIUw8WS0fNCPV7g4jDdebHL9/T33d5v17kRS+5RWiDi+1msjo7BWXzAoJXe9+kpezoWWO7WzzwIK4h/6FLMtS33k5jHhkKgBAD2oX4aC4WGr2X9Kr0sKHjNaKdmuwcWsP2+igYeTbx2PasHl6dA4cs5TQJR7kbG/FnUVOFpAvEnIPUBoaaef+CzKoDximLEzI6TIQaoSI0tb6Bn+6DjEFBuD2OsyP3G/SWOtvEC4bl1cGoCLuQYpJZfrc6UQaJ81ed80aMzmKFvyJy2Km6vNbP3qDt+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB8802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(5660300002)(31686004)(2906002)(4326008)(8676002)(44832011)(6512007)(36756003)(6506007)(31696002)(478600001)(8936002)(110136005)(6486002)(6636002)(83380400001)(6666004)(86362001)(38100700002)(53546011)(66556008)(66946007)(316002)(26005)(41300700001)(2616005)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1JneDBCWEtCbkE5OEhZU1g4MWIzRHNTZk1UZHRybEp1cVlTTVd6WnB5YXNJ?=
 =?utf-8?B?cWZONWl2Vjh6VXNDMzBmTkJaVHJ4TzNhcHE1ODBqbnFpUkY5Qk5RZUhrUFRB?=
 =?utf-8?B?Rko4N3ZZdWlsL3NkdFBZOVRsVnhYTS9FNkMvT0cwM1NsT25reTZMcStoNzBv?=
 =?utf-8?B?N3NmMXZINHQ5QjIxVm9uT1JkMHBDbFlhYldUM09xNnpUWFpLclk2QnV5TXNl?=
 =?utf-8?B?U0ExZk5RSThiMXdRKzlIcFZwQUZxZUpKdnlCNWdUb0dQYmxEWFZuMGl4dHVt?=
 =?utf-8?B?cjdCaDVxSlZwREN3ZFhkeGJsS0NVNzNqQTFma1hSV3ZEM0hsdzgvVXMzM3Zs?=
 =?utf-8?B?T0NXM1ViTTFxaHhDVGlBSnEwdTV1OVZYL3Vrc281SWVEQTgxZERqNnk4OVpJ?=
 =?utf-8?B?OE1GSFhpejBEdGJrZm1pdWNqWm5UR0l5ODlFZEl1TC9uSzlHOC96Um4wYnp2?=
 =?utf-8?B?dmUvWDlwcGlNVk9FYTk5Tk1keGxraUhac1F0UGo5SzIwUmo4RTZJZ1dONWpX?=
 =?utf-8?B?VjkxVlBYWFJDSGwyQkZ1d3NwdFdWQWU2Y0dsK0RscTkyN09NWUUzZmNmVnBM?=
 =?utf-8?B?UzEvbHpJa3RLcVhxQitSVTBJemNZSmZwOUtCVHNUVCtFUzdKV1lvSnIrVG94?=
 =?utf-8?B?ZFVqOFM0clpERUp3SVgxYkxtTWJxTzZaNVJEMHBXRVZhTnpwTkxWeXZsQ1J5?=
 =?utf-8?B?SDJQZS82RjR2R3ZQbHB0QUVTOXRISlZDUTF2V2pFOFY3TEpySVpvSVpQMEUr?=
 =?utf-8?B?cEpscnROSCtBTUdoV29WVnZrYnBHd2FqdTJUUWlxa0VzYW1NVnhZYnNpWFM4?=
 =?utf-8?B?Q0FaY3FDZklvYXFNeFlpSzhqdkt5WDZteHBNcTN1SjAzU0RHNUZMVmJ4UExH?=
 =?utf-8?B?T1M3QVJGZE9wdWV3SG5ZVVcrT3d4RWdOamk2eEZOcDhrcU1JU29qMjcyZGt3?=
 =?utf-8?B?djUxZUJHZ2QxREt5MlM3VGQ3SHVWN3NUTkpON1FRZFErZkR2U0hrMDVQbGM2?=
 =?utf-8?B?SThVb050T0NWUktCUFZmcURjREtHcjZxQTlMWHNOZXloZUdqMUNYeks4WXR1?=
 =?utf-8?B?VHdXQnpJdk9HSXVTbFRzRmpmY1YvRVdwZkgwcGFOM0xhSFhmaCtpMkpCWnBl?=
 =?utf-8?B?U21UajBxS2R1Z21RR0oxdnRQRUZMMWJjdnFGNnMrcUswWFd2TXE4VVMzMmQ5?=
 =?utf-8?B?YUtYZ2pqTVlSY2ZYSkI2VnI0bGRvbkFtKzJBc1B6cHA0aXpkQzkzT09qK1lE?=
 =?utf-8?B?TzlhbHRjNzRlVzJIbkU4UG8yZE9Jb3I2bklrSjlzZlNQalRxVSs4UDE2SWFZ?=
 =?utf-8?B?OVVhZnAwaHdTK2tSRVZ6YkNGeFNpaU5MUGdSbFJIWS9FeFY1MFRUZk9XYklW?=
 =?utf-8?B?UnJKWlVzdjRhUlMrZEtSVEREdnk0N1c3QWxUcGhValEycWtqdXNXS0tKTlgv?=
 =?utf-8?B?UE9GSkp5cGRhWVF6NUVvUVNObjM0R1VyY0xJcy9ZQWFPSHNFY0ZscWxyTTRi?=
 =?utf-8?B?OUwzKzh6M0F2djE3aUY0OXh1T2NTWHJ2bVgvdkd4c0E1Qm0xZTExMG1tWHJ5?=
 =?utf-8?B?SDJZK2dJdllMSlo1VlJZNmNDZHdtOHNWejBDMWo2MUJwdmkwNCtCN1h6YXhP?=
 =?utf-8?B?QTZIemNNMUNxMERwd2IwQm1QNFlqMUl3andrUDVpaTZJWnI2UWJoTlc2UWFW?=
 =?utf-8?B?SkE5ZVpsVE4zakptemVEZ1MzOXVieDIvL3Z6a291eS9KRmsxSzZnZ3U4VUZB?=
 =?utf-8?B?dWtEZFp4dXFwYWZUenRySmpNbDRaS3M5UElmNkEyU3F2cG0rL1dNOVlIQWFP?=
 =?utf-8?B?SThQTGVPNSt4NjI4U09TTUV6aU1TM1l3OVU3UnF1b3gxOHptYTRId2I3ZC9p?=
 =?utf-8?B?a3hOZ3hubEJ4QVFpeXVnNlRlSldtU2tzVGw3OExpeVpzN1hQUnBOdE5DK2pr?=
 =?utf-8?B?ejV3cVROL3A1VFduQm9aQ1MwYmRGWi9Lcll2c1JHTnEwSElWS0p4b3VCVDlU?=
 =?utf-8?B?MEF6clJhYUxxM1lpcFNQMlg1U2dPNVhiWkZ6OTc2YzVRVUFnRWNCZzJHYzEz?=
 =?utf-8?B?OTNNbVorNm11S3RNQlFSaElXR1dNeXEyRDhiNUZrZWoxdFZxdnd3SjhMQUd2?=
 =?utf-8?Q?DWU5tIE8yJCpTUf7rYEybjx/f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061d608b-d0bc-4f25-32f9-08dc16132d0d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB8802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 21:44:39.7729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: le4dOuARRJOQGST4WG7OC06/m/OJBqylBTVrTPBoQ444UVdo2zWrb0B/NqbbizXnzb6D6XArUyKAQkp1T1licQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5210

Thanks for catching this.

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 2024-01-13 02:11, Srinivasan Shanmugam wrote:
> Return value of 'to_amdgpu_crtc' which is container_of(...) can't be
> null, so it's null check 'acrtc' is dropped.
> 
> Fixing the below:
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9302 amdgpu_dm_atomic_commit_tail() error: we previously assumed 'acrtc' could be null (see line 9299)
> 
> Add 'new_crtc_state'NULL check for function
> 'drm_atomic_get_new_crtc_state' that retrieves the new state for a CRTC,
> while enabling writeback requests.
> 
> Cc: stable@vger.kernel.org
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 95ff3800fc87..8eb381d5f6b8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9294,10 +9294,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   		if (!new_con_state->writeback_job)
>   			continue;
>   
> -		new_crtc_state = NULL;
> +		new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
>   
> -		if (acrtc)
> -			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
> +		if (!new_crtc_state)
> +			continue;
>   
>   		if (acrtc->wb_enabled)
>   			continue;

