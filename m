Return-Path: <stable+bounces-3894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 257E48038D7
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 16:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470191C20A93
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 15:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80E42C857;
	Mon,  4 Dec 2023 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vWI4x890"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE86B0;
	Mon,  4 Dec 2023 07:29:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTd6QpQxFZnQxy9FusKqZh72sGevdEcw+KVPhDMm1CFmBqGpjpm/vfeXDXY27VIJ96hbCDN/8QkmRBxtn5dGh3uSeS/iLLqza5vBmFQfQOLFufX9ZYaqR/e/GPcPf/Qcec1ZZDlqbV6bMpfCEj9ssP2QT8Pv4n5IEngbfSpdPgG8aLSCQaVirRHwRwDKCK3Qi86NKlaT5geX7VajHrdCnEXOs5mXWONe8SaKCfEGtOgaGBKP2cnDuu7zNz2Eg//fGYlcajXik45gQRY9tTjyJO3XoxT1O1jzWemjJBje+NI9ArohTkz5976mpl/6K0slTJQC9f0J7tLDOVikpL4Rzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMvQhM8RWERdywVGGf9d6GCnblKibINeViMgxj2/bHM=;
 b=EBZL78V43Fux0bAkDRfkJOJkXJHeH1Tf8ASJlha4eOHDHwwmm7gdH96JPcjlVW8ScDLV2gsbiY+ZvCMK0jwzWVzeanVn6rFvn9rkHTm8I2mYyEEd2HfyaElCF8nUTbAaEP0iT0z7KxM8zDYg+KhFTzS6XHC4GrPft1oI+ekWDvjp1iIfXYWQZB0ItFpg/vDerz05t6cwRgm5sfLsX2t66Z5QFqpYi0xkddiDO+jcTgZL4FC2+lZHLcwT2wAzgts/771thNJGuprbiTNl9GCYQZN3kAPVzSYtbCP7JaHdEKQdj816oOsBvtQ6OJK6yaWhSuiSapt5w2x01TUH4yjF+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMvQhM8RWERdywVGGf9d6GCnblKibINeViMgxj2/bHM=;
 b=vWI4x890dKl4j2vNujxujEoCmOTOXTsIc5bim7s288dmzOIZG5Y1KxQvtLZkcRZyv7kl9b3KPNzzpkbhns1sW1ipqZFoe24mDcCCz000F+f/8TIwqTh+7rd9DGwXjMN9jFmwMSBFhpXSduns28JpjjlH7U7NSKBZ0P1fmxGvSTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Mon, 4 Dec
 2023 15:29:46 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 15:29:46 +0000
Message-ID: <e0781c30-a22e-40b5-a387-bae92672c2cd@amd.com>
Date: Mon, 4 Dec 2023 20:59:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "xhci: Enable RPM on controllers that support
 low-power states"
Content-Language: en-US
To: Mathias Nyman <mathias.nyman@linux.intel.com>, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 mario.limonciello@amd.com, regressions@lists.linux.dev,
 regressions@leemhuis.info, Basavaraj.Natikar@amd.com, pmenzel@molgen.mpg.de,
 bugs-a21@moonlit-rail.com, stable@vger.kernel.org
References: <3d3b8fd3-a1b9-9793-b709-eda447ebd1ab@linux.intel.com>
 <20231204100859.1332772-1-mathias.nyman@linux.intel.com>
 <070b3ce1-815c-4f3d-af09-e02cda8f9bf0@amd.com>
 <db579656-5700-d99b-f1eb-c1e27749eb7b@linux.intel.com>
 <f28b4e98-dd9b-458e-8a72-a9da3c0727cd@amd.com>
 <273a8811-f34e-dbe7-c301-bb796ddcced1@linux.intel.com>
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <273a8811-f34e-dbe7-c301-bb796ddcced1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::14) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e88b695-44a5-4aaa-08b8-08dbf4ddd8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1NQrg7FELx9AuSg8SUQlJe/fme2f8+nxUJLfKm+fkbYYnP3tlmRqJWj7Ztv9wesHffjR53Y6vhvDCgB5y+DRVuC37bbzQQUlQ0+h3VtHR3WsYIkKI0zKmbQvZoz8TJ6GTZ/vPeyp4f5q14sITXymOgLKq9LOawfh6xnOe99LFb1R5mIleHjyt056wKwxXzzuS0obKrGTu7oZ8ItSJM7e0ki+RZ1XXONPL0R/zMslFR29NHU6k0OwCzseZ2nZNUnSOg7h5RA/tHtqeuUbg5OP/pMgVmTMRO20ryNuqI5yNFjn+n2pbnhcFv0FG99/ikjz2hKMh3rICkscaKyEZPfQuvwWbmFohi0GmHxdQcqeXqolcoAImoleribgUbhH3VsuzCowmO09C/yOR6MiDlTolGnkE3cp0Qf9bOGhm5busLuNwoesmRnRNmRpA8R+RZcEeB74H8IctByyyp67Gi/dwPfmwydTzVaiGbnSrAYUsATYfe2BnvguHywLXk/z5nCVdj7yvr23FyZDZzBnqv1pN8U0pphnp7XKQRhMR+MEI3h2zxiI/ysIi5LmNnUUiJe+MvLvwYBHniPYCpiOWJ143mBaD+7uRuJllNpXDTTwGn9fEhkug7oxS7keXr5EQCP0YaR0znJ4SvZHIsh31Hux1Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(6666004)(6506007)(6486002)(6512007)(31696002)(53546011)(8676002)(36756003)(5660300002)(8936002)(966005)(41300700001)(478600001)(31686004)(2616005)(66476007)(66946007)(66556008)(4326008)(38100700002)(26005)(316002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUhIZVhqYnRnQStueE5OQ0tMZDZudnhtSVRrZm1nM1BvR2dHc1V6RUc5bDVL?=
 =?utf-8?B?SHFsb0N0eTNtMVBtdEt6Vm96TXJvWDIzU0lqbkJBMURoY2pVVHppd3JCRHBH?=
 =?utf-8?B?RzRJd0l1UnAwTGpWakI1V1dTd3lpb2o4VXJ4OTZiQlZUbXBNTnMvL2RNUDJF?=
 =?utf-8?B?L3ErZHQyM2VnOFowMGRWRCtNT2xUTTl4ZE9OalU4eXFTQ1RWQTFta3V1aGRI?=
 =?utf-8?B?aWJYZ1ZxSGkyUEhTdWFmQVNidDRTWjF6Zkt4L0JFdEd4bEJwRVRZUGZpa3dM?=
 =?utf-8?B?OWozMnh5clY1eHY3d09tRXlNY1oybVdZU29JSjVtMktaYmgyU0Zua3pMQTJI?=
 =?utf-8?B?MHduTFNKbVJUZllJTytDYnEvMzZUbHFLNWtGT2MxOVdEdFpRTkZvS0tOL2p2?=
 =?utf-8?B?VnhEUmtpSzI3S2ZxNWFPbGUwQlIrNzQ5U2RKTmJPTng4K3ZXUEk1dGwyYlJ2?=
 =?utf-8?B?Z3YrWmJqQktab0liTkJyenpMbGtUTktMaVpvRkpmOHl0U3d6VnNTanR1Tzc5?=
 =?utf-8?B?NitjMXRQcXgrTHVFTVhHeFpncXV4eXhoSHU3OVJTK2dGVU9Xd3NjUXc2Tk9F?=
 =?utf-8?B?eUkyeVIrcEdTTXBLOXJ4ME1pUmI3T0NvNVFKSks4Ny9wekVmdy9raUZDbTJD?=
 =?utf-8?B?YXBnTTZiSGdKRCtCd3lXZWVJZTMwNmZra3J0R2Mxd0hMT3BmZk44NnNTZ2dC?=
 =?utf-8?B?dE9TNVZpZmNXMFd1TmhHVVZnZmVoWXJ2eHUwdy9QSlhxUDhiWDRJaVk3VDRO?=
 =?utf-8?B?ak94Y1lzZ0Zva09LcTRXNU9Za0lxVEdtNVdWbC9Sc3JjS00vZkUwYmVkY2Rs?=
 =?utf-8?B?eEQzNmxBT01kVE1Yb3AxejR3RFhWbXAvUjN5NVBvd1NTN1FmZDFRZm13N01N?=
 =?utf-8?B?SG5ZSmU3K2szc2UrL0FRbUd5TlRsdWMwM0JqQVBIaHBqY3FmT1I3ZGd5YXly?=
 =?utf-8?B?N1liTmFMOUFZa1RuZkZSb0JoMjRubUphMHdNaitzMENpNnREQU1Id2tCQnQv?=
 =?utf-8?B?WW5tTzE2anFHOXVaMDgyUm12QmZKeDZFby9VcHZIK01HczgzSnFHeVdMWnVa?=
 =?utf-8?B?VGx0NGl2SUJVL0J2Z1BjMnBuK2kvY1E0TkFXOUhaaWQzK2ZzbGpaWDJZVmxP?=
 =?utf-8?B?U3BZZXc4ajE3Q3FjN3NZcnBLYTZMNmdSZEwvWnFqRExhaUc2ZFMyR21acXVr?=
 =?utf-8?B?WStwTnNLMEE3Y1pSM1Fya3c3K2NFczBzTDFuQURlOGlkampGaXpOWFE5dDV0?=
 =?utf-8?B?WnRwa1pNM3R2L0swM1dkeTlWYk1HQWVoSDZqOUtaaW5iNmplb0JRdzR5VSty?=
 =?utf-8?B?REliMHZ4aEc5ZTNrWGpKVXpJcXN6VFhXakxsU09pWk9KZFdMQWNhNmc5RXRF?=
 =?utf-8?B?aFZmZDJxVUdKbk5ZWjg2T3p5V0NUQjBCMXlUdlkxNzNJQVZicmM2YUpLaWJn?=
 =?utf-8?B?bkgzeGwzcE9xaW9kU0VxdU1xWnRSMEZTaVVzWGsvTVVaTklRYVduWmI3ZVBK?=
 =?utf-8?B?R0crNlJDV1U5QWtGN1FEV1lRR3YzbWo0bURaY2Q4UlRsYnBZajUzOU5iRjln?=
 =?utf-8?B?enIrN0hxT0NTb2ZWN3RhWUZieEZPTWVha3lSWmhGY2RFZ0V6ZVFYaHJ5NTE2?=
 =?utf-8?B?LzB4MlN3Qm1Na1M2L3lEbnhDTGF0Q1UzSDNrWExvckZ4amczMWxFZFhmanBC?=
 =?utf-8?B?STY2dHhiTGN4czVLdlNXWkdkZ29Tbk51QTJIYXpSYlQ3S1FwdkJUdldBZ0gz?=
 =?utf-8?B?VE1JaEZlazNHTUpqNnZMOU1QNlRmMTQ5VXlhbG5nVmgzckJKbTJaUWJ5K2pw?=
 =?utf-8?B?ZWFtNDdkN2Zveno0dVBLbWpWRHpXK1JuZTNyODNSQjhva1FxMDhXdlhTbVBm?=
 =?utf-8?B?c2dFbndQbHhUejV2WVZmU0J3WTczbmZleERRS0VydmMxeVJ2OGk5Y2dmVW9u?=
 =?utf-8?B?d1pOcUl2WDdpZ0pYMm9aMjFacUdDQzh5aEl3T2kzZWIvSGRwdHhlT1JGc2tL?=
 =?utf-8?B?cVFmY3Yzak85S1g5OW9LSWdPYThRdW9oaVlRRkFDWU9mSEpVSDd5QTB1RmVK?=
 =?utf-8?B?U0VwaE1jVUxJb3lkU2RmTnpwaTM0dHQ3UzVhcHhSMURhSnFtdWpJZ2ZMT0kz?=
 =?utf-8?Q?NKmg3ocUuni5ruYLteCzaRjio?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e88b695-44a5-4aaa-08b8-08dbf4ddd8ac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 15:29:46.7027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gznxtr5Q4knTROAHH6e5ed3jv2lNpCwCXuETF58RZBVodnSqF8Ki7YTyxN3DdhYbW72dmB+aB1+JmkQoWULRDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561


On 12/4/2023 8:36 PM, Mathias Nyman wrote:
> On 4.12.2023 16.49, Basavaraj Natikar wrote:
>>
>> On 12/4/2023 7:52 PM, Mathias Nyman wrote:
>>> On 4.12.2023 12.49, Basavaraj Natikar wrote:
>>>>
>>>> On 12/4/2023 3:38 PM, Mathias Nyman wrote:
>>>>> This reverts commit a5d6264b638efeca35eff72177fd28d149e0764b.
>>>>>
>>>>> This patch was an attempt to solve issues seen when enabling
>>>>> runtime PM
>>>>> as default for all AMD 1.1 xHC hosts. see commit 4baf12181509
>>>>> ("xhci: Loosen RPM as default policy to cover for AMD xHC 1.1")
>>>>
>>>> AFAK, only 4baf12181509 commit has regression on AMD xHc 1.1 below is
>>>> not regression
>>>> patch and its unrelated to AMD xHC 1.1.
>>>>
>>>> Only [PATCH 2/2] Revert "xhci: Loosen RPM as default policy to cover
>>>> for AMD xHC 1.1"
>>>> alone in this series solves regression issues.
>>>>
>>>
>>> Patch a5d6264b638e ("xhci: Enable RPM on controllers that support
>>> low-power states")
>>> was originally not supposed to go to stable. It was added later as it
>>> solved some
>>> cases triggered by 4baf12181509 ("xhci: Loosen RPM as default policy
>>> to cover for AMD xHC 1.1")
>>> see:
>>> https://lore.kernel.org/linux-usb/5993222.lOV4Wx5bFT@natalenko.name/
>>>
>>> Turns out it wasn't enough.
>>>
>>> If we now revert 4baf12181509 "xhci: Loosen RPM as default policy to
>>> cover for AMD xHC 1.1"
>>> I still think it makes sense to also revert a5d6264b638e.
>>> Especially from the stable kernels.
>>
>> Yes , a5d6264b638e still solves other issues if underlying hardware
>> doesn't support RPM
>> if we revert a5d6264b638e on stable releases then new issues (not
>> related to regression)
>> other than AMD xHC 1.1 controllers including xHC 1.2 will still exist
>> on stable releases.
>
> Ok, got it, so a5d6264b638e also solves other issues than those
> exposed by 4baf12181509.
> And that one (a5d6264b638) should originally have been marked for stable.
>
> So only revert 4baf12181509, PATCH 2/2 in this series

Thank you, that is correct.

Thanks,
--
Basavaraj

>
> Thanks
> Mathias


