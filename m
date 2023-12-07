Return-Path: <stable+bounces-4934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2CF808BD3
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 16:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86B94B20B8D
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F05E44C8A;
	Thu,  7 Dec 2023 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="39BZDF7z"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCD210C2
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 07:29:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Df7sfcvHZ63PaRDDr+5bRJ46zjjcRA9cG1CrvnbxN5bz56u6MdUQJ1h9X/c61Pcphwr3laKzl0E6AMRN+1A1CIaOGE2tL2MoAxTVSEGJkzRY7MaA9Vpu51ohjIKu4PlMGzj/JfjzgOD79ksemhr39bNQAqCO2F/dBVKFawtlcVl0rHHhSgPNujAdqmSwOO8t4+WsdjfOC4uW7NuuoCtxJz3tw6GzBhc6wD6RIgqz2CQOtO2hxs1YDA0wzE5wB8ofJBfv69tCphL62rND602/VmyMVbTy0gRKXUZs6w5L8BahdTDFC6/7k2u372ELM/ULeaRc1DHm+QDjUuuO1C6Img==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UT503bZxq/RZn3VGckEoox/jFwlNImTJqcpnkiiKZpA=;
 b=CPnLPiZIMHRAQaNsZK1unOkTzXRd+k+5a6P5zHqHl7wXCTWzd7SB4pVblE590ptQEA8vns9VKAKZ8oAbfET5OS73TB9sTpp3ur7WdCwTsGhuHCDewOZsoyhZNHhhiS85x4OKAD0I/y+4Cn4LeCeAWoEwSSRlPDwEm2MNUfNtL72MOzKAyHeC5WR0gIkl68ZYEtO0hVq1bTAj0kEg0IT4l2QMfBBF/yi0h1LbBUUoR9DsetnfiCMC5zi0Nfza8h87X9Gy9jlhfD+Ggw+KUzhUnRs+cghQin32XLUm5z7jnRZaGNHBhiCDVH8dw0O39QRUMCWALcDgMC0naFEQ74zQPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UT503bZxq/RZn3VGckEoox/jFwlNImTJqcpnkiiKZpA=;
 b=39BZDF7znJ3rHCTANGIuIkP1GDHogkPfBYhRYeE251jt7a7HkvLRFM7WSOhMdp0lMUajTmUSRfzbd+D/eVxdDtd/UCscR8aiFnedYCfcnuA2neAwjalO6Rob8Jy2jyvHR09lcEtXhhEvmGSzIKlgHndNej3wMbg5ATHvGSLN6yI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Thu, 7 Dec
 2023 15:29:35 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3a35:139f:8361:ab66]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3a35:139f:8361:ab66%7]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 15:29:35 +0000
Message-ID: <842b4216-5ad2-44bc-b34c-7cf59dc55e25@amd.com>
Date: Thu, 7 Dec 2023 10:29:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Restore guard against default backlight
 value < 1 nit
To: Alex Deucher <alexdeucher@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>, stable@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Mark Herbert <mark.herbert42@gmail.com>,
 Camille Cho <camille.cho@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20231206180826.13446-1-mario.limonciello@amd.com>
 <CADnq5_OrnkGPudqTtBOGm1doaWyaHfYBQaA_sJOGTw1zP4PCyA@mail.gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_OrnkGPudqTtBOGm1doaWyaHfYBQaA_sJOGTw1zP4PCyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::21) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM6PR12MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: 607d66ca-d843-4179-236c-08dbf7395106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KaAdzlMKXKCwGdkGyCABGJAgj92GoKoN5e7CvA17EmjmyXzIX2b9C/07MOlqOWIpcj1TvdOeD8jxseuBZecP8gY2TzM5AIgmkl2EH/Mt9+s/A0iMx85KGUTQQiQ3LDLLxuj7QWhJpPgijFuA8bIhuAlxa4WJLlGvekVelWmPgpbN+EXmTxKQwX3EJhJgkvpwMfCawATlxQ+mIFllr7YE7n27BNvQcrYSe3JlF6gBADXzgmCxratJhQkuhUO4aQ2hwz2up3LTKhtiSPr9NA06Jr/tpkQ/boUgSI+IpaSAlA37NaxsyTAfD2+dv/DEr5vh7lIwVTho+7tDa5Uyyo9O/N+uzh4llbtQ3NtJCCDYKRwbIXpJib8zvWO9Pu8gSwmWGyjSzzhpFYoHnMkSsP2SWjaHTahNAou8zEY6+aKUbG6KQ0oId4JsR9+mgJYomwWKYmSN8/N8B0CJ2DJfqV/uT/udkMW+TmdzgYgkqCXGtSEt6HWFTKHIZ2f+OCXitK1WWdJtP9PdCQYeXaq46KrOs2Vp2MKtJqKqeE8tX+VY+O8UH8k/mBl0zicE6k7uEifnEVRzm5bBZ4o+1uUKN0qXPaRqZc+ayTvqd3Sx7Fj8pfeS0SCM2bbk2UMi7Fj9jnH6Uk8abrDwStyk0KiXV2d5rg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(966005)(6512007)(41300700001)(31696002)(38100700002)(5660300002)(86362001)(36756003)(44832011)(2906002)(6506007)(53546011)(2616005)(26005)(6666004)(478600001)(8676002)(6486002)(66946007)(4326008)(66556008)(66476007)(110136005)(6636002)(54906003)(83380400001)(316002)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czhsS2t3TDUxQmxlQkRMSU9DbHFaYUl0R3pPMk85anl1YmRXVkp6Zno2WGxO?=
 =?utf-8?B?eVNyaExaR1JVRkRDNnQ0NURkcDBsSUtpb3N3OFF3Nld4SGNTTlBWZ3Rud1hK?=
 =?utf-8?B?OE5yN0dVVjVCdmVyM1p3blk4NDIyOGFlbFpSNjNYMjRxSUt0VU4vcXZ4ZFFs?=
 =?utf-8?B?SkFxc1dQUVhIK2JtVHFkdFREYjV1OGN0ZDRtckQ1elR5ME9KWlRQWm5KWW03?=
 =?utf-8?B?V2Z6OXlhWWM0L0x6K2dEZU8xMURYbW1CZmhlMGRwR0VpT1RHaGNlMlcxL0Vh?=
 =?utf-8?B?alJOTmpmTGRHOUJCVHdWeXhHdG8zZGZXU2ZwSnJoWU4ybHFPYitlSEwvWTNV?=
 =?utf-8?B?ZUh3eHI1cXcrRmFqamdiMDZVZTBmS3dGWjNzVkFyUE1udFIrTVpBZEk3L0dL?=
 =?utf-8?B?RkRZUGFicHFTWFhreWRLR2oxTzZRRFd2MStGbnprblExMDRtS1ByTG5BWFFQ?=
 =?utf-8?B?dVVZc2VjUTkyRXBwUm5XL0FoZGZsQm5PUlRUckkyL2tXU2xIZk1QclVrMUVH?=
 =?utf-8?B?UkdOcXZxeFRXUWdGYUVIQmhzUWQ3VjlyTEFab2FXYTlQWWJ4YkZLZmtOd292?=
 =?utf-8?B?MEJQejU3K1Y1UEViQTkvWWpHNWZmZ0Z3Ly9pK2N6QlFqY1JNdFRUR2NHTG1v?=
 =?utf-8?B?bEVJem1iS3JFZzRybWJGeEltbVlrYzlSRGo4U3N3aWRDR1BmVzRSWVhEVjJD?=
 =?utf-8?B?OVdscDVpREUycUtNVktlU1Bxa2RuVmZiTGZhMEdLUUJQelJNOXRTazNTNXJr?=
 =?utf-8?B?UDdwWTlERCtNVzUvdGZ6SjVKazZnR0Y5ek8rSWJOU1JoQUF6R0lPVmdqT0F3?=
 =?utf-8?B?bG04SXNCY043N2xLeDRROW5YYXFwNGhhL3NaUFh6RzhYbGJ5Z2diL05VWVJu?=
 =?utf-8?B?T21oUmxTcis0UHBlWG9HZEh5TXVMYWZHRVlIbmZsSUpXa0FwWWFEbUxBMGNN?=
 =?utf-8?B?WEpqRHgwc1NVYkZuWk5DeFVycUMyRWdVUzhRUWx2cUtYZXQ0K3B1MU4zbDFp?=
 =?utf-8?B?TlZGNDVLWGVNYit4VVI0Q3FhTVlDYk5RaVFIWjBLamE1VW5GWStGV0lTd1dD?=
 =?utf-8?B?WWFDeTh1NTJFWUVwNkFLQW80U3cwWk5PemYvdU94Szk3TmRib2Q5NXBuektu?=
 =?utf-8?B?eWJRSW5CRWRzcERQYVM2OXkvbEVJUWhyWVlkclMvRlFaQlRNQjRGbGRKa2lp?=
 =?utf-8?B?a2gramFxVkYyYmtSbHNObTl1MitJTXFaSHJyNyswMEhlZEVxWVJDeGNQOGdT?=
 =?utf-8?B?MzlmMFVLeUZ4aWs3b2dtZmdaanBCQ1paVEtKdFlSS0hPcTBsYnBtRkhLcmZP?=
 =?utf-8?B?eEZCMFRaVkl5V1p4NXJRQTRDTEY4NzlXWEtIbUxuc1d0aWZKbk9RNzJjbENq?=
 =?utf-8?B?NmRjS3pnR1ZnN1ZzTERRYmpiSFlQVkxBUEwyaTE2NGp5UnVYZWxqcFQwYjlx?=
 =?utf-8?B?ZzJQWW40YnRJQklqeXJDMW1UaVUwT2dydXpGM21FSnF0MGFlZk5UM1ZYYlZL?=
 =?utf-8?B?NFp2RE5UaG1mSldFVGNENzJmTkRtMWZNY3FyaC83c0EzWC9WUy82dGJsZUhW?=
 =?utf-8?B?OUNYTE5KZEtITmVQd3ZBakJYaTdmM0FmaFpQY3ViUE04YmIvRDJkL1dYc3pk?=
 =?utf-8?B?ZlROK1RlaEIzZ0JYRUE1ODBIclFicmFPV0tycjBuakVFek1hZVB5TFJMNWV2?=
 =?utf-8?B?eHUwL0dmTVB5M014OG93T0FBVXFlLzRVbUtIYmRENjVEalRwUHdoV0hjanky?=
 =?utf-8?B?MjdjMkxDQzVzTE02Z1BNUmxZcEFMV1h3MnZ5R3o5ME9zdEVRY1dnMjFPUHI0?=
 =?utf-8?B?MjBkbW8yNE5rNDN2UmUzcUdYODVoZjkxNjJRaHhSYjZHUm5OOWtWWUxCMUtR?=
 =?utf-8?B?VEVDOExML09CZEN5WDF4bm5DaC9xdTJIRHVWcGxtNkVMTTlSK0hjazkrc244?=
 =?utf-8?B?cEJaUk9mU2pIL3BYeWgwaGx6V0VyaVV6UmFsUGtnaGxCUlhOMjJZT000TjNz?=
 =?utf-8?B?MURSdHU3eEsvOEV1dTlOQVZTdTFzeEFqT1ZmOXQ1Mm00cnowZ29YcFpjZjlv?=
 =?utf-8?B?LytHNzBnYmdpZ25tZFNJV3NNdEVKNnl0bUViMnpLRHg1WXZEZGJPNXR1L3dr?=
 =?utf-8?Q?uJUBYhPLw8QaSW+IoaGxIggVm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607d66ca-d843-4179-236c-08dbf7395106
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 15:29:35.1038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xs0UGf9im0vNurjv0qOzc8e0Fip/3EqhZpFbEDQlow283pZIOVoNfz4ihoDb5t0VpCjf/B081PIs7SShKHRwhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313



On 2023-12-07 10:03, Alex Deucher wrote:
> On Thu, Dec 7, 2023 at 9:47 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Mark reports that brightness is not restored after Xorg dpms screen blank.
>>
>> This behavior was introduced by commit d9e865826c20 ("drm/amd/display:
>> Simplify brightness initialization") which dropped the cached backlight
>> value in display code, but also removed code for when the default value
>> read back was less than 1 nit.
>>
>> Restore this code so that the backlight brightness is restored to the
>> correct default value in this circumstance.
>>
>> Reported-by: Mark Herbert <mark.herbert42@gmail.com>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3031
>> Cc: stable@vger.kernel.org
>> Cc: Camille Cho <camille.cho@amd.com>
>> Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>
>> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
>> Fixes: d9e865826c20 ("drm/amd/display: Simplify brightness initialization")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> 
>> ---
>>  .../amd/display/dc/link/protocols/link_edp_panel_control.c    | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
>> index ac0fa88b52a0..bf53a86ea817 100644
>> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
>> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
>> @@ -287,8 +287,8 @@ bool set_default_brightness_aux(struct dc_link *link)
>>         if (link && link->dpcd_sink_ext_caps.bits.oled == 1) {
>>                 if (!read_default_bl_aux(link, &default_backlight))
>>                         default_backlight = 150000;
>> -               // if > 5000, it might be wrong readback
>> -               if (default_backlight > 5000000)
>> +               // if < 1 nits or > 5000, it might be wrong readback
>> +               if (default_backlight < 1000 || default_backlight > 5000000)
>>                         default_backlight = 150000;
>>
>>                 return edp_set_backlight_level_nits(link, true,
>> --
>> 2.34.1
>>


