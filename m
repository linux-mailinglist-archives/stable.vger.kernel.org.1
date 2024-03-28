Return-Path: <stable+bounces-33077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E1A88FE72
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 12:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83EDB23DD9
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 11:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423657E590;
	Thu, 28 Mar 2024 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bXs34ynI"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC4043ABE;
	Thu, 28 Mar 2024 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627091; cv=fail; b=UrXtSEZK2abr+uUkyOXcnuSNq2mzIsyc6y1YLO6EAL6rDH7pVMA3BPZBtW3T+UzXXi9+a44tEouM19CfkTy1HnGQ3lhAe/DrKZuuyj0japKmGMA54McGKtp9qh8DUD7cn3t9qoReKxthGmiDupBMDOM97BFsa24lUeMK1m9hCYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627091; c=relaxed/simple;
	bh=w1uhxUcWlzKVu0VF03902lVNSR89oWdMWYEfxYFOD+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l2wQqFdvlWsbWSOsgmJ309cTDQ7AkPSeDBsBuInWbW7NfkRb+x9HzJqc/SY83UsvuwNKapCkNmpM4IyaGs+U4XI94PzE67g79RsyZMFwQgJtfS0TIbFcajuamP5AxLpaWcXDaFrLFzvUBpKy3nBrk6aIqOZIobJaUYz1lcZ3NmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bXs34ynI; arc=fail smtp.client-ip=40.107.101.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUIXvHCw7L+G7MyvC6dSpXYm4jM9vxyaCAH4YiH4MZHZ+PAl5NzzHZI8nGdJZDFUyyXNcAkpIOOciSvKoL0aPwZD/VArn4R/NxbfdfiEyVxDQCr3FkSFuXbb4cmzf6ioEs0Y+m3OHvjpISUkeMkb0kEd/maeivQJ1gkcGDakoHdHuZ7yFhtZ8w8j7i5BIwpnuzmSi8EydW9BpfLmnezM2URy77DumoCxe0zqdFRUNHvZhzUaG0Y9+V+rm3T/3VR6vOSLuyuqS+UpoCYgdr9SnmjyELx0ldhFOrlU9Xu54nstawMTspqS0LJ7f44L2L+SBj2dWQBbUyU4Xm3N5aJjng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77dwfFDOr3o9xKY3OHQ6Xr8AdoIlGMmcjveSf5sRCrw=;
 b=IFWdWAr13x4d/1KW+t+g1MuYKEMi4Ncu1+qv6Wy4b6ku7jfATz4LCcybuRI5O27mVt0y1a6VbnTaSCE+uRxeW3fH7ZIItMn6ippHo44Ary3aq6O1Gjz2Wqdk5F/ClScJERl5EMXYowldUH5Fq7srIXJxpIJ8sv7mPjEgs4HeEYGzrpgBF5vU/BUBRR6A8TUqvDGHC0JnVIkIahIPpElTkfx+zM6RaZ6oQd40BwSNxL8WmaHrKIyMGQaUvBmQ+8kLWkktCPWiSYjsXRVQU58AY0ljkjbvZmaFhAyZ5ob7o09YAtZbwHG65YcDnqX9exWxD+TstxBnyWSOTHjE17Q4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77dwfFDOr3o9xKY3OHQ6Xr8AdoIlGMmcjveSf5sRCrw=;
 b=bXs34ynIZw81cSVgwdPbei+w56RHrfdZQjcaqFmBKK/4ME261YxhHhFDZCo8jBs8bsjMfTUYnJUpfOOqE0zBaCVhooO6seM1XKH4u05x/TwDqhmpj9mXCalLmsLhIhtbxcjch/vnttLS15CfZtqUj49nASbVpTUoUGBaKxTAEY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 11:58:07 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3%3]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 11:58:07 +0000
Message-ID: <8e5127ff-0ffa-495a-bd6a-ca452375f5f6@amd.com>
Date: Thu, 28 Mar 2024 17:27:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Revert "ASoC: amd: yc: add new YC platform variant
 (0x63) support"
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>, Sasha Levin
 <sashal@kernel.org>, Jiawei Wang <me@jwang.link>,
 Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
 stable@vger.kernel.org
References: <20240312023326.224504-1-me@jwang.link>
 <bc0c1a15-ba31-44ba-85be-273147472240@gmail.com>
 <2024032722-transpose-unable-65d0@gregkh>
 <465c52a1-2f61-4585-9622-80b8a30c715a@amd.com>
 <2024032853-drainage-deflator-5bae@gregkh>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <2024032853-drainage-deflator-5bae@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::16) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: d36ea1cf-3798-4a49-ab05-08dc4f1e548f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FLDUgYW4Dki8AamvucW7caFNg+wbYpv6M9mtEMDDyQlCDOa/EIIh/N5pWKxIPsElfyhPftYz0s434XGigEDXb72uE5GSABxbSQM3IXcZ5U9dp2+OTpmIvaeupOVJcF+g1DrPC8K1EypvkQgtt+1z0OMCr0E7xO1m1hhVDNQpNv6x9+7Q+SkKuDFa4hPyG1kK6IBdzkbX6cIicxYolLwihrU6wuXIzgR5hINorOLdGVnS/pgOkm9+M45FrYi2bou18j0PG7rTVSyHzJaoYsaI476SbPfSjLy1+mRkRfGvAcHrDFK5ySUtUwf60rhdEGY26aBhi/V9RhG/vEGKPwhlManSdRSUhHO4GkbKOYzH4tG4EcNFea33p3tKj820twTycNjNTr2gQKmhA0baoMaWaEObUDKrBENB8Dj0ciGB2/dIHjGyZA2SqB2XlPBNczs2rbRoRXIxHGjFXFX6grjbS+O3AxOHaCs1n5dF4bJpaH3CtUnwx0BpL12dGbpNcp8IVUrs+100IvB22VQXIdLxZjmPvlJEh+XB7rkjAAfGkeQfolFr6alnqN/OPqEug9JxPfQlzN9RM+ajKwEVID67BMwJLnHDCb8TAawIfQN2cs4bwGDx0TGkTHcuzB73x7AzRWymO87LoV/IFnOwjFNmuD7nszcehLQhZDnb4sXc6zU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHBYcHlNOEpKazdJS21zclFGN0J0ZzJKUnhTbEsxT3FraDF1SlBPTy9xQTNk?=
 =?utf-8?B?KzQzaVFaMmN3eStHOW5rMzhZbDN1WE5nMHd4dDZ2LzBvY3g2MVJTdW9vWWFh?=
 =?utf-8?B?Z3VFdUg2RTFUTEREZnI1Z0tDbFljNCtZWFZWekJWM0JFL0ZraGN0bk5mTkVO?=
 =?utf-8?B?c0VCQzRzalllUmxPajRnRFRhNGQrWjRVNzZPUWZRTVJrc1BFZjF6eHB3K1BR?=
 =?utf-8?B?RGNIWlJndkhpT05lYjRSb0JUODJOVCt0WlUrK0tHSUpJYkp3S1hRUitqVTJ5?=
 =?utf-8?B?T3A2M0QwTjFia0ZYZHNaSGhaZVNKdnkwTmt0d0l5WldEVU5pRVVXK29PL2or?=
 =?utf-8?B?NURRbkFVcGR3QXN6UnJaM3o4ZTU2TnpmU094U0ZDOTZYR3FiazgwdkFTTDNT?=
 =?utf-8?B?VDlTUVorWVgxVW5VTTREM3JqTjNYYjBOUCtWRUtUK3VTcjJjYnRrY0VDd1Za?=
 =?utf-8?B?K1ZncWl5Y01xWllUZGM5Vmd0aDFTQ2VYbXBIOWxxMGIrN0tVZEQ5Wk93U3I5?=
 =?utf-8?B?REtRWlEvRzZtcGw5M3NUQnBJWXdxbzNBaUFjeGNmdHRhTnNhcjR4RTVNc2JG?=
 =?utf-8?B?b3B6VTAvT0M0dmI5NDFJbllZTlk0OHRaVE9tMzhLOEhXTFI4eEtRQnVhbFdh?=
 =?utf-8?B?NUFjL1AxcHNDOUhXbmVNT2RGNHNBTnN6ajZuTXpYK1Bld0Z4VjU4aG0xUGFo?=
 =?utf-8?B?Q3JGODRaaXlIdGdReVZNV0ZiOWFsQ0FMNmppY1llTGZQRytPQlVKTlh2bVhn?=
 =?utf-8?B?dEVVMi81MWozUm9iQ292b0JNODUwNWNZMTMva2YwU0ZxVUFsc1lyNHMxYUo1?=
 =?utf-8?B?dGpFTzhITEhVSlBIM3hobitJWWlIbjFSdHYzMkFoaDNtb3lHcHBRZmNvSHhE?=
 =?utf-8?B?K3BPOTl3cWJQQzhLc2JENHlHMnZTZnlKRHhNSWluUzhkYlMwUkRUc09wOXl2?=
 =?utf-8?B?RjBDUThYSlZkZlZlSHJ1Y3hvOExzeDB2dFVrSGFOdldwZUJPZStKRWdMaVlP?=
 =?utf-8?B?SnBBc2laSHpFL0syTmphRzZhMFVWYjAwdmdTUVZNMHJidDZTVWtLd2d6WGkr?=
 =?utf-8?B?QXZqTktnQUpBNm00dnRxeWx1Zm5ZVEF3dlJDckpjVDJ1eXFORDdYbERCOFBK?=
 =?utf-8?B?VWpIcUNubHJrTE0wUmF4WjNYNkdvWDFiSVhyMUh1d001RmxVemhzWnM5SkUr?=
 =?utf-8?B?NFFXalB4aFZuV2dVcFB6M05xcjBPWmhCQ01nZUxLUkJ5NmVibTZJaDAwYXRh?=
 =?utf-8?B?U3pIaXgvSDhGeUc1Z3Q2bmpLZ1V0SmJxeklabVdQMUV2cjZrTmkxUWtIRFBS?=
 =?utf-8?B?RkdGVmpFSzJVeVFERkdnakFQdEFmd3loOWVrYlo3L3BzbnhnZHBYVTRHblBC?=
 =?utf-8?B?eWhlaVZiR0ZBNUxQaFhvVTVqMVJHQy9HRXk3ZUM2ZHVNcHNwNjc4NXc4aEx6?=
 =?utf-8?B?VWlHOS8yYjhrcitlU3Y1a0JwN2h2KzBSRzdmQTlVRVJDcUI2NnVIcHdBL0ZJ?=
 =?utf-8?B?YkdiUDVhTmJkOWdqY1ZLR2ExUXBxYXBXeDNKSzQ0Vm5zS29PQktoQm5YKzRo?=
 =?utf-8?B?M3l5VW15R3FhNTg3dllhcmdyTE1KblBacW9OcjFTYW5QUEJGQ1pKdEg4K2tE?=
 =?utf-8?B?L0puRk9rMlNTSlFxVHVHeC9ielkwb3pKZUFhWUY5VGdJQTQ3OVdwQWo1dS96?=
 =?utf-8?B?NG0wSHllY2dXWUtNZEFLdm5CSnMxYkdqOEFobjZqaWREV3lZMGp4U3NJWGpI?=
 =?utf-8?B?Wjdzc1hHLzlaZTFzVjVHUjM2UE9qdGQ3ZndTZDBaWFZucmdFM2lWSkdjUlF0?=
 =?utf-8?B?NEo0bnliMFk3K2JPenBlNHYyUWdXejhBY3BRbnpNcTlxV28wY1dnelRVT1Fp?=
 =?utf-8?B?UlhYU2orRkZzSVM3SmU5bmV3T1JXWGtjRzVXQjJkbklhTHFFQU1iTDRpenhU?=
 =?utf-8?B?MXpYekVPUmtsYklFaG05YXBSMGkxdVp5bDhQTTErZ1Y5TFhDS3hhaXBBbmhr?=
 =?utf-8?B?QWFIRzRwa0lZZWFoMGIrc2lJdjBYclpOWkNpaks5R3lENTFpcXdxc1QrUmZ3?=
 =?utf-8?B?am8xYmY2YTBsUklmNzBnMUUzeHdZaktiRkVCYWExQnQxRVlDb2x1NmROaitF?=
 =?utf-8?Q?7gGG13A4H7gPQs8pbzrcdQ2Yi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36ea1cf-3798-4a49-ab05-08dc4f1e548f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 11:58:06.9751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isFPZKpEl4MRPuwnfieU19Kg7B8jYgqQsZJpEenTNGkmzuFYZ321FLmSzHzYfUjk4hqs3TKCOPNLODVya24XzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230

On 28/03/24 17:04, Greg KH wrote:
> On Thu, Mar 28, 2024 at 04:10:38PM +0530, Mukunda,Vijendar wrote:
>> On 27/03/24 23:39, Greg KH wrote:
>>> On Wed, Mar 27, 2024 at 06:56:18PM +0100, Luca Stefani wrote:
>>>> Hello everyone,
>>>>
>>>> Can those changes be pulled in stable? They're currently breaking mic input
>>>> on my 21K9CTO1WW, ThinkPad P16s Gen 2, and probably more devices in the
>>>> wild.
>>> <formletter>
>>>
>>> This is not the correct way to submit patches for inclusion in the
>>> stable kernel tree.  Please read:
>>>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>>> for how to do this properly.
>>>
>>> </formletter>
>> These patches already got merged in V6.9-rc1 release.
>> Need to be cherry-picked for stable release.
>>
> What changes exactly?  I do not see any git ids here.
>
> confused,
>
> greg k-h

Below are the commits.

37bee1855d0e ASoC: amd: yc: Revert "add new YC platform variant (0x63) support"
861b3415e4de ASoC: amd: yc: Revert "Fix non-functional mic on Lenovo 21J2"



