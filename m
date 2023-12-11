Return-Path: <stable+bounces-5497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F24280CE7E
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 15:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542F91F21499
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D2548CD8;
	Mon, 11 Dec 2023 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qG6+bMF4"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B51E9F
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 06:35:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R83/MUIavwpnHC+sbdF674nrX62tgx1e4BUS5Y/I//TWPnzxb9uwujqLOJ5+WgqsvtAwT+IIYXMKP1xbPBjvUw+8jCEoXot9kk5BjI/1mrHdI8HkHJWZNoJ+PMcWok8lgxLcNITCiIWj8owtpCLDIr3FUWOmTlR4sVP4tu5UhpvnegB5hYDNmHb3WB9qk+IrYsFHK9Xkxtgvh1KfQIG0g2DmbWftsBB9E1kYcOVW+OnXejHy76CBb2u0TQ/dk38MagvYbkAjZm4GtBVh1ADGt47pzzEgmqqmWFmq+kKQhqGnSN/IxTZLQbKMc/bOmUIsUaS0+TT0QmY/Ayb8aRHusg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3gxWBG6Mok1q6RWCk3ZSj7Oj073WXJj+GM1bdn2tnA=;
 b=nKLkHXbtGbKGHocnAhD4RqS06jRTIlkq+l6BujWVQVRraqdp1+avvVDrEjtuaEZxrrko/UyyTM8aiRhryDn/dJKSne65iCAoIs5bKJkHSYcml5N1FVu4cF8nI33VjCVnEAQ5Z13LZvWoQaMV8ua1CWjXrJD0lyZ0+91Cfefpr/agMRm3PXUAoQhJOZpZsoORGKBg7DGG3m3FiDLfuOs2Vb1gGA2fSBzpD51dGG7sTH5MdeQG4zDCupE3zML1OzHj9G+12LpmbT6vnixRj8VwTiAtU31knzyWUNIir4owafdToxjEEd4iHgmbSVSFPZWI2pbBvLRRoJDeBdDcPB0i6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3gxWBG6Mok1q6RWCk3ZSj7Oj073WXJj+GM1bdn2tnA=;
 b=qG6+bMF4q/Ry9KQ+lqgdee3pnMeLjE8da5aO7q3tYUJR2wJn8i191q5gcsK1imt4OD7mlzoqZW7VpNGhE+N9QFDJdCLwpHw4wGUTqcRSQBvPG22akun8afJwj/rUIiETN7EyK3ZbOkTRDD/P+yd68L49BYhlIaF3XNCXEeJhCiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:35:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.033; Mon, 11 Dec 2023
 14:35:29 +0000
Message-ID: <a6a8b409-8fc9-4d1e-9612-0c860deea771@amd.com>
Date: Mon, 11 Dec 2023 08:35:26 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Disable PSR-SU on Parade 0803 TCON again
To: amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org, aaron.ma@canonical.com, binli@gnome.org,
 Marc Rossi <Marc.Rossi@amd.com>, Hamza Mahfooz <Hamza.Mahfooz@amd.com>
References: <20231209200830.379629-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231209200830.379629-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0227.namprd04.prod.outlook.com
 (2603:10b6:806:127::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: f9660be0-5df2-4eea-2af2-08dbfa566c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zzUyDk9WDmG1XUEby10T6uE60TcaYo/A1nXOucrzH1FiEcbf+uQNJrf1Fc+kc9mVS9eQGyG0ESJNkFi0jEgXOljbocafen2mYiHQ2ZyGVjqba373Bqv0MwigR5IouuL15wLC/1JttpLmVCJww1QfxM9RSPSCl6fhyzmt8UbN5cDxL40LK6JuZ/XtgFzUVQWtx8B1p5bXdzPvqju5gkvAi2eP/328k5qLzCFg/52uqbSawgjLO/EqPhL4ywZgGY33X8oI9cbg4u74F4q9QrV3e2OMN7BfpzNiHeHkk3S2kTUKz2hiEyTrAPXHABuU00dyx1O2DIj+xPyxGmV4hiY8c6X5WdsxkEdKqgj6UCpaTCGaKZygCIPINn9caneLj++tfCnwP4DMw7tiVHWJ5XSNi9O/pP8u8Lgp7F7hU8JkBVaIWpARGXRTaap8FwiExrdHsNQ29lpcTVbC8RFur5US76MYwufXkWK++Yk6Xfz5Pj+jz6/BCmxYgWRyNkjuDtKHSVjCeWA7NKXYlTPa0iXrQ65Ve42+aNOlCVCDrtAfYCiqGmo1dz2+jFn/9W8DfbY1kSXRamXIrecNvQhf1F1icm3FaKl4WKjmq46ZS0N3m3knJYMwtLgS4Yrb66Wt8njoDBWCNH4tWLR/8EevikJD7g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(136003)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6512007)(6506007)(6666004)(2906002)(54906003)(66476007)(66556008)(66946007)(6916009)(44832011)(53546011)(38100700002)(31696002)(86362001)(36756003)(4326008)(8676002)(8936002)(316002)(5660300002)(31686004)(966005)(6486002)(478600001)(41300700001)(2616005)(26005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEMzYUJHQXZWYm5ITWkvdml3QzF1bnBybVZhRjZLSUNoaGxLN3Z0TnFWcXdx?=
 =?utf-8?B?dnk1Yk51UHVyWDdXR3lLeHlWdkZneUY4WlJzT3ZIRk85b21paXdjUUtMU3VO?=
 =?utf-8?B?WUkvVWNJckxUN3N4K1lmV0haVlFSNWR0MlFycW5wbGdYWW0rcmZQdnpiSC8v?=
 =?utf-8?B?N0J5cWFtQnF3aER0eVNaNlBuUmN5ZVBwUFdlbThqMkdqL1RZekRadU5XTTE0?=
 =?utf-8?B?cWl0a0kvMjBJcU9ocWRudmpidk0xUDZYT2lObXBwK1lJYzN2NytQOGk2TnJz?=
 =?utf-8?B?YWYreVJabHJhMkZrcHR6WXZPU1p2c3RsNjJDYmZyQ3F1bkEyUzlNODc4S1U2?=
 =?utf-8?B?TXNoekwyUVZadWY5Z3hubW42b0N5VmU3UHBEc2tDZWY2UjlpZUpTSzlZQktI?=
 =?utf-8?B?aTE3c1pkVUNXZ0xXVHQwbWIrSGZrN0NEcGdxRSsySWJrWS9sYUlSUVNETTdk?=
 =?utf-8?B?TkFVZGdsSmhiY2l5bm1FV0E0R2NOM21pREkyaFQ4RklKY3RWQXRxMkJOa2JQ?=
 =?utf-8?B?cnZFWnhCSmpEc3ZUTHliV0NDK2V0VldDN3h6ZnFsTWE5b3NVU1FTaFFsUFg3?=
 =?utf-8?B?R3FqSWYxNFUxL2lxNG1EZFlYZ3NqdTUxOVFrdG9vUUg2TXphREpaN29yQWJ5?=
 =?utf-8?B?TkMxV2ZmN3kxYXZ0V09iTjE1VkZNSktta2JLcmhiQnVYRzU3V2cwQ1RQaUVU?=
 =?utf-8?B?cXVCZklIVGFtRFhYNVBkVTlJTXBHYUxCelo4Rlh0empiRHlzM25pWVhzSFJD?=
 =?utf-8?B?bk5yOEVWdGVacW1Xd1I5UUxoQzdrZW1pVG1qbDVJbkFRSy9aMzdRVUFHamZJ?=
 =?utf-8?B?R2RzbGNNQlBhTnIxdXJIbk90azZNMkhjZWgyMjZVL082eDNDTnZvcVBTQUNY?=
 =?utf-8?B?U05kbkZOL3A1TnAwYmFqRVo0Z0NSNDA1QTh6cXB6VVRtVmRyMDV1UkNXeS9C?=
 =?utf-8?B?SzdOV0o0ZjV2SERNMmVHcGk3TXhOcFBDeEtzUXBYM0N2Y0lwTnU0aXkxcjdH?=
 =?utf-8?B?UCtTdk1NYWM0SjAySWNUaEdVaGtIN0Y1bEdUL0tRS1NaNGxsR0tEbUF0ZlBa?=
 =?utf-8?B?dXl0c2F4eVRSK0t6em5heHdua1FCZ0dkbzVmYmVtSFh4eDFobjM1WXRUamNL?=
 =?utf-8?B?aXo1UzhyN0JaaXpTenBqVTBGME9nMXk2cG9aMnJTRXArcHJ1MlBTZ0FlZ1hE?=
 =?utf-8?B?MXVVVWQrVkwvditvV1hyTU1FUDVJZ0ZjT2tSNzR6VHNSMG8walRqV2VVWG5l?=
 =?utf-8?B?Zk5UbUVnYjNyaUd3dkFHVTl5N2R6UkY1WU1pbUZ4TzBpM09WU3JSN2pYenVz?=
 =?utf-8?B?ME1NZEVMWXEwZUNXcG9xenBYZmwzVDdoL3piZzdiOTZTbEJMa0pla0laaHRh?=
 =?utf-8?B?MWFnT05tdUdFR0NaSXhwSlBRazNaUG1WMkQraWRkTmlMVDhqMTZqOEVOQUZ5?=
 =?utf-8?B?WXYzQUVNMGtIVDk4c29YNmpNTkJPeEJCUFdrNnpJUG1helh1ZDVvQXlOeUNN?=
 =?utf-8?B?WEsyUGdoaGVtN0lLcWYxRkxxNkNlVHFRc2w4ZndBdTV5SVZzczJJK1hXTXFN?=
 =?utf-8?B?VlZvUFVnR0hDV1ZwSFFTdHdpNmd0UHhBUmJUNG1uUUxKYzNDMWFaTUlXa3Yw?=
 =?utf-8?B?UDZFVXJza283Y1FaM2tzVU5IZEZkRDRLUXBZSmZxbEpLQlp2MnBDZ0JVMVhD?=
 =?utf-8?B?T0pZaGNJWXA2RVorajBTVlI1RFFnNGlockg2WEEyeVBkSlI3UVdCeUJHK3lj?=
 =?utf-8?B?MnFrZXpmL1g2QWgrYjhZWGs0cVltVnpVOHlXUldFUU5OaVI3NE5QaERFZm44?=
 =?utf-8?B?UVZLZ2o2c0xuc0t3UGRTcDJyczlWQko4MklZZm4zK2hRcmp6aFEza0RjdHls?=
 =?utf-8?B?WjYwNlRVdGpZbTQrU2RzU2lMdG5UZ2NUdHpwQ0duK3ExK3lWdUJLeHJHZThi?=
 =?utf-8?B?SVN0UEVvYjZtUEs1cFNOM0lMWmg4RUlSb1dYTEpzTzR0ckRJbmxQeFVCWWkw?=
 =?utf-8?B?N1ZkeHIrLys0MmwyKzRzTXZLcU1jb0NIOUV0YTRjai85aU9uYmg1OHE1dHJP?=
 =?utf-8?B?UEFJVC85UHphS1NTYlF6M2RTenpjQkljOUFtTG05VWZUYk56eDh0WXZTVHRl?=
 =?utf-8?Q?yCa63HDEmW/NpCOhVGeMLy0xq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9660be0-5df2-4eea-2af2-08dbfa566c4f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:35:29.6033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbIxyFVZrf9zUCKW54Nr9WDjhk5JD9uOOnIBLo//3qEXmzpOohW5ODBuyeg44lVzDsBAp9LUNMsWG/E/Wh1smQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247

On 12/9/2023 14:08, Mario Limonciello wrote:
> When screen brightness is rapidly changed and PSR-SU is enabled the
> display hangs on panels with this TCON even on the latest DCN 3.1.4
> microcode (0x8002a81 at this time).
> 
> This was disabled previously as commit 072030b17830 ("drm/amd: Disable
> PSR-SU on Parade 0803 TCON") but reverted as commit 1e66a17ce546 ("Revert
> "drm/amd: Disable PSR-SU on Parade 0803 TCON"") in favor of testing for
> a new enough microcode (commit cd2e31a9ab93 ("drm/amd/display: Set minimum
> requirement for using PSR-SU on Phoenix")).
> 
> As hangs are still happening specifically with this TCON, disable PSR-SU
> again for it until it can be root caused.
> 
> Cc: stable@vger.kernel.org
> Cc: aaron.ma@canonical.com
> Cc: binli@gnome.org
> Cc: Marc Rossi <Marc.Rossi@amd.com>
> Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Here is a bug associated with this to tag as well.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2046131

> ---
>   drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> index a522a7c02911..1675314a3ff2 100644
> --- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> +++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> @@ -839,6 +839,8 @@ bool is_psr_su_specific_panel(struct dc_link *link)
>   				((dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x08) ||
>   				(dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x07)))
>   				isPSRSUSupported = false;
> +			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
> +				isPSRSUSupported = false;
>   			else if (dpcd_caps->psr_info.force_psrsu_cap == 0x1)
>   				isPSRSUSupported = true;
>   		}


