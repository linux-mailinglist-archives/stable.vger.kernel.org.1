Return-Path: <stable+bounces-5503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8007A80CEB1
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 15:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8110E1C210D6
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0679495E2;
	Mon, 11 Dec 2023 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eZwJBXw7"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443A4C3
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 06:53:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJ0Q6I0gnHiwddy8zeVrgJjLYzb/wmuXuCr2Onyvl+gJtQfa4D4tiLZGiR1xGkq+q09iY1wmbL3S7K74snC0qLtiZKd+fL6KZlmphJ6ad+r9jbnliEGZuY3uhh8tlJ1p5LJrKqYy9DX+KZduqReJzF+aqhuBbjBEtAdl9ld0KN1TbozvsK8eoP396bVzU5O/co74lCcHU4ZEhr7l/CYWQ/WIfCDIdUy0/V2fe+hDXlTu+L9WClUddkL6uf7oCccq8DDXlbp2fyv9IxYtrDxYmnJIFHJyZDCUlAOckoydEw3zKzl0jwXdfU2ouJtP0nX1XFN801AlJqtP3DXXXpl32w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S966qLAg5vnXvdduIr/ayP0VC6Jtwkt0lHJwbkGQA6Q=;
 b=I19N7ywaTPJCt3HRjzsuY4hQkC/2rJNboryqvXBbzxOuseRWUAnR6h/D0jHs9b9QKYjIXd6MjXNGg9sDd1cE4B29zJDo8zvnYU/Rche6hwt1Uj9+xCPmhELNCXMpt4oI47e0gc5Oor+N89Gxw09OshOnauke4C46OUK1lRTDpt8mIWKtiJlwsK0907pWE6elD3B/+mjhIMuBAFDmlUaOp2KNIGQZMBuh/ieUmfgnZRj+jNv5SZAgcFVrZMLpmWdkemqN4gMCb+6ZhE3b0idsyYtvPUcN+NuAIBKKu8/sAodf8lJaYLFkr3C+MeIWZFg6ETAtoe+UI3Xf742UYE+lWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S966qLAg5vnXvdduIr/ayP0VC6Jtwkt0lHJwbkGQA6Q=;
 b=eZwJBXw7CRZAbSRM1F9weceq1ndQ7ZnELdstK5jvh1EPRrqWkObw/VGM9Hcy8g1iS0DVlBGTMWv7BgutZBEHgQAIKwQxocWK5T7VWm5p4wRtXPUsBsv5cHSINC1QcoIc8y6WcBBei0wNJXc4AXnxYX6OxV1/3PnVbjVYGX2uy9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:53:39 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3a35:139f:8361:ab66]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3a35:139f:8361:ab66%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:53:39 +0000
Message-ID: <d5a5bdbf-ba02-4968-806e-1d5fde62af4b@amd.com>
Date: Mon, 11 Dec 2023 09:53:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Disable PSR-SU on Parade 0803 TCON again
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: binli@gnome.org, stable@vger.kernel.org,
 Hamza Mahfooz <Hamza.Mahfooz@amd.com>, aaron.ma@canonical.com,
 Marc Rossi <Marc.Rossi@amd.com>
References: <20231209200830.379629-1-mario.limonciello@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20231209200830.379629-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0030.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::43) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MN6PR12MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6a6d00-dd73-49b0-212f-08dbfa58f5a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TFTXZ/glj53KnDCfp/pb537S1pEC7azHfTAWrEWwkDIoYUK6cegypQzO4viiKMtZ11kgWJRRdQcMa6OriO91gSxR1UgsHmKzbYZswMj7aTP3pYie8oodHgvyt1xnaE4+kSX3i79Uu8zfcnofViSDy4zj0R+a4g4yiwbw0omhpnhnVSuD84F5BbBL37VVnfmbF1nc+n5Vh6UlD79LPKJsIAw+h24fjXY6oapgCICzOc01tr+LBWLaWcK/5vYuVOazSci4OUz0mVH66D2ozfsm3k8dLAHkTlGmlYgILY4XMnIGLxbU+i1YMbx6WrHHxD0KgxlXSBp7oS88NaTVow7inDZXi+Wo88ic6YThlUKAdmrR/u8iaDAfPIFwVEl0W5OXQxAmAMECVnbGbXqNzyk7B33f6EWBoMqfFB01MtP+R5vWG7JF8SLe1kheHtTNF+Mc9CoYuQzingyr83AGDXQ75C1xPUIzbtxkWuHD59sLgBAp7JwtKQ/k/3rKfGfpQrfkewTDH2WescGhi7KvtWcGfNeSIWddo9lslMwMUFDj1C/kS+KRpx7BjLZ0xSLf0Efl9mZN3dVjizc41tRQlPZLPqLU1s+2T9nlrSG+lspNFBonAgMymKQ/jTobRlDphmELZO5JX3suEmCZfPTc5YDMgg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(26005)(2616005)(83380400001)(36756003)(86362001)(31696002)(38100700002)(5660300002)(316002)(8936002)(8676002)(4326008)(2906002)(6666004)(6512007)(6506007)(53546011)(44832011)(66476007)(54906003)(66556008)(66946007)(478600001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFlrV3dWZEZhcEdURnJSVjhlK2VPa2I4YWJZUXFpNWlJR3pCZEozNVROTUdJ?=
 =?utf-8?B?OWM4RUxneEs5WVh3WFd5M3BrUUNMUmd5Q0VHZlU3SWxRSDdaMThHYzJWalps?=
 =?utf-8?B?UGRnNVA4eUY1Zk9udFVaWW8vK2pnMFBFZytlRmpLR0hTMkg5NzRJTUVMM25X?=
 =?utf-8?B?YnNLUmE2WVptMXRldVhoOGZCcVkwSE9zWldKYlFYVVd2dEtpanU2WVBHa2F3?=
 =?utf-8?B?ODFiemp6aUpoVjJQY2dLWUVZbW1SVllLb3lMdGNUaXZrdnRXWHZaUFdPaXNB?=
 =?utf-8?B?NENuSTBRLzBpdWp4cXVzOURURHJySnI2ci9IMXJNNU5DNmJHRjMvVjc2YkVz?=
 =?utf-8?B?UFVhY1FMb0IwMmlJaC9FWWk2N3l0OXNUOTJOcGhpazZnSHFlSzQzWmFmKytw?=
 =?utf-8?B?dUxFMnZxK1F3cHU3SFlzL3B2NnBmMDVtVzViYzVJT3JHZ0txQ3NpYmgxV00y?=
 =?utf-8?B?cmJlYTZhZHlzZHZHZ2NZNmN4RTNjVjAyNXRIaXo3Y3M0cXBHdVhnYlhCQ3hz?=
 =?utf-8?B?QnlQWkdDcEc5Z29vYXllTW5qM3lMRkxTSWFCK1NteWwyU2UxWGJucVFHSTVE?=
 =?utf-8?B?amRtNGNxcCs0NU1xL0c2SzBUdVpwWHRsZCt4OFJsWWQ2aUVTaThkaVRxa3Nm?=
 =?utf-8?B?aTE0UzZyZ3ByaUZqRGdYT0FvT01XMGtteGJ6SU1wNVhPVHpzeGJNeWdlRjg1?=
 =?utf-8?B?aTIyMlhSWHpWVERSeU1LcXZVL3pGV1dIdE03QkFIc1R5bzZyRlFqVWVSc25v?=
 =?utf-8?B?UEdVZGludWVoa1orLzNFcDJ1eDlFZm1HYldqWnc0VXlaWFBTT09Obnl6a2Nt?=
 =?utf-8?B?ZEp5NXFpZ3U1MVZzV051dkFoTnBqdVNobkNmaG4xRTNsdEpNTlY1MXlyamJ4?=
 =?utf-8?B?QlN6WXUra050RVNBMVlwYTc1TG1iWlpjTHhWcjUxdDl5T2NleWNHS2dwazZn?=
 =?utf-8?B?WnZwV09UZWVYV0JwY01hWGRYRHZabXQ4VnBCTGt3Y0V1UjdRNTJ1VjFybEJH?=
 =?utf-8?B?VWpTeUQrSFVRR3JYMjR1N3BtOUpUR1lBcmlKd3BzaDBWTTZZMVNuUkRMOVQ3?=
 =?utf-8?B?ZU1weHJjWExhWjdiTG9LVWZRRlJ4R05yR2kreWx5RkgraENqaXgreWNCRXZC?=
 =?utf-8?B?MTI0MmkzeExWNklBenc5Sk5UczhxL2tzV1NkelZRYlFsejBvVFo2d0g3WVZO?=
 =?utf-8?B?Y20vdFR5eEZCbGJ3aWJEM2ordmdsSDVIMjNGUnF4YkdRWjBKMFhnc3pCc2hW?=
 =?utf-8?B?RFdlaFF4ekx0Mk5xMUd3NE9McDJWRkpMZlV6b0pLNjgrUUNnMEZLMjJIL25i?=
 =?utf-8?B?YUNGa1NVV0o1Y3BjQ2ZpbnNmN0NncmJVUFlRamtLQml1eVprNlRDVjFDVHJZ?=
 =?utf-8?B?U2ZxKzMzQjZJZmdSWmRNdHcvM0xCNHMzNVM3QnRDZ29WSk9pc1dKOHZzQnpV?=
 =?utf-8?B?eHNSY05JZkVsRGxwSkx6NFdoU3YybXppMkZCMDVKMDI2U1ZBVWVVdXlTbmVF?=
 =?utf-8?B?UGd5M2EwazNneGgxaXBBTEk3UUtOV3hEL1dRUWNCcEtJVU9JQmp4VW5KVTIr?=
 =?utf-8?B?WVJETHpWbGVKWkpSODhtUkwwbGlORE9qelh1UnZBV0R2NlBqS1gzWTVRT0xI?=
 =?utf-8?B?KzlWMHJVL3g4b0NGd0E1OGpNdFZtVGRoY3NocVN6SWZnT0JsZHlmY1BPNW1m?=
 =?utf-8?B?eUF0WG01dFJ2d1lnQ1QzbFc2a0V3M293N1F5MDJiVTgxNlE0SGhUVE9YUjNz?=
 =?utf-8?B?alVvRENlKzNIK1VDaitLWGFpMDRKQlB3OEhtcGFZeDhtWFMvcHFxdTFxMlJO?=
 =?utf-8?B?bGpoMFFvbFFvQmlrZURaY3preVVMbjdZNmwrTnMrOWhTTkpnV2VRUWFsVG1a?=
 =?utf-8?B?eDJmQUV3WmxISE9kSm8xdno2NDM4eDV6Z2w3bXpWbUhsVnBlS0Y4a0RMODgy?=
 =?utf-8?B?WDlmMjVWa0sycXpqWW93SUlxcUo1TWJOWVZZN3FCSHNvN01UekZLT1BaZ3Bw?=
 =?utf-8?B?dytYOWR1SDhGMUw4U1ViWi90Sk5RcUlpTHY4bFZNT2RUS1ZzV1c4ZzQ2Y1BB?=
 =?utf-8?B?bWhyYTZ3bnpsZW5NMW1sUnR2R2FmUlFZdG5MYWRpYmRpYmRJRGUveTBFdGd6?=
 =?utf-8?Q?p1YT6xjqsnox63DoMrUkSjo5r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6a6d00-dd73-49b0-212f-08dbfa58f5a9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:53:39.0305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIZo0nulRW9Wf/f8dv4fQY0mmcwbZonBMZlAJo3faiChAzktsO7ZdNedB696UPRIdBd7hQa0IWbnqvligD6Sig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8472

On 2023-12-09 15:08, Mario Limonciello wrote:
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

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> index a522a7c02911..1675314a3ff2 100644
> --- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> +++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> @@ -839,6 +839,8 @@ bool is_psr_su_specific_panel(struct dc_link *link)
>  				((dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x08) ||
>  				(dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x07)))
>  				isPSRSUSupported = false;
> +			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
> +				isPSRSUSupported = false;
>  			else if (dpcd_caps->psr_info.force_psrsu_cap == 0x1)
>  				isPSRSUSupported = true;
>  		}


