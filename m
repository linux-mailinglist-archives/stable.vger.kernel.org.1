Return-Path: <stable+bounces-3855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4DC8030E6
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 11:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4A0280EB2
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 10:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41815224C9;
	Mon,  4 Dec 2023 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="03cenSo8"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25DFB9;
	Mon,  4 Dec 2023 02:49:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FH3QXCbXf+ql0yl3H008xqapU2dQiPB4DvAAMnq24rYvm6C2I2h1FuhhU6ouNAdF+lQOdn0lT/9H7fKCk6FrnGjiOQD0Q0jDDdHnn/yOaFRegn1hhXgjjzkJJ6Rlx/oIVkay3nqaR71QcueyosJ8DRhc2HI/7fcgvqNZgwoYWPngrHVoJwWHiibjkyYtQQLU6W4Aji0p6ENgAD1yxU0BZBJN/9FDaAwBR122BX6hOhH4JQ8aH0XraFAXDTUAqeMf0nUINaI2ItR+0aWBfVAKcP2kJVooiITSGPMeO0g/ZIILF1WRjdwyZy11qF5eKY6uMEJxC1qz4kYCxjXvhHyyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sr2EMOCVW7q2kcVhhOXRkREKvFrjxM1ME8o5EW1DM6o=;
 b=LaFrUfkPK8p0HyeeSSzm46zWLSKAUA4gHplXuRzQBrnrCUgcC9HsDV+a1m1Kwb4iL867VVB+SPrgfiesCdMPKmLVXbrqoyKZmqYhG2cRtzEmyqZcxRQ3p01JeEvTKw2hq+uA0PWqdebjGwnK/F7K3Z1w2TWfh62uIOX50RiCwt+W3MIgYRBo8bVYweubzImmmbLAyVmGHquKnysXwvRzT79v9eufaK/nqX3f82nCHZCwznPIot7mDJ1jkgqZjRJbZa6Qdb8ZoIV45XscxNqft6jR055PuFwQwPs5FN8dyb20ST1AyUHZuX/2cFk5vqUyFQUfQF+GeacIEqOYwuW3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr2EMOCVW7q2kcVhhOXRkREKvFrjxM1ME8o5EW1DM6o=;
 b=03cenSo8Ugx1mfw3cLJ71W9/S+La9/YQem0ESHYWDTWKNcMCxRQefnhp9Gmkm58c2kL7O1L8QNo+SkJw91EzqEQ8yCjQXQZUGa1/mOq0gbfaWMDmhp2x+O81NBMe7WBUOrK5XCWdOIIblkRwmuFkDRiBAMF4grvxKOqODrBDun8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MW4PR12MB7311.namprd12.prod.outlook.com (2603:10b6:303:227::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 10:49:42 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 10:49:42 +0000
Message-ID: <070b3ce1-815c-4f3d-af09-e02cda8f9bf0@amd.com>
Date: Mon, 4 Dec 2023 16:19:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "xhci: Enable RPM on controllers that support
 low-power states"
To: Mathias Nyman <mathias.nyman@linux.intel.com>, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 mario.limonciello@amd.com, regressions@lists.linux.dev,
 regressions@leemhuis.info, Basavaraj.Natikar@amd.com, pmenzel@molgen.mpg.de,
 bugs-a21@moonlit-rail.com, stable@vger.kernel.org
References: <3d3b8fd3-a1b9-9793-b709-eda447ebd1ab@linux.intel.com>
 <20231204100859.1332772-1-mathias.nyman@linux.intel.com>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20231204100859.1332772-1-mathias.nyman@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0128.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::13) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MW4PR12MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: 563312ab-8210-4c08-5638-08dbf4b6b843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3jg5E3IoYP6gwY6smLvKCawbz4vfJLbLkYTmr4Es2twDREy79AE3G8kg8HWIN13HR9DFKWbxxH9fZWNCqWlaRWKwzbgFYJj01TBzWO7c0YTWZ+Xw8jIfLLugsWfZS/1a5szRXMfVxTlM8c5cwyAyUjbuevbEUVgVPHUWklcIAAHeUN7jmuLblmf1y2RDzBy/l8u4EBQplQBCEBMW6SE/nJkd9nTufrCkTlHclO98H43ChWI2V7zWWFt44USobkItNMw8PRN73W8j5p5JNpAu7VQOYRaeu4Ylyq6WWehivMpWimEz6rlaFd5MXndBXyBo4aABZy1Z+3sg/ICXFXf0gGtgNrfXO6YcisLOXkIL6yMU0DPJc4fpgRHiicjYw+Wl6YKrOtpoh3LbWw0hUSgHsTeMoScfChS7rpc1tqTmIbGxe89Nk9PZxRFyXLFsc+E1Sv1K34ki0N3wP5OYqtIIcGuCVbrG6/VZrnM4VG/thpsT4GHCKovK7RhOgY8zXwyFZTF3st5KOEoT7rPB2P9NZ9YkhORrpcIEbsPm/UIsXTR9KRx5QSfebFiQzC104Rd8XUnwiBfFMl/knUqF32WceZb9OmrBBeSwykLxWyHFSHKLhNJ0IAbSejOjTNEm2jRrG9g5oLImu15kT037nMLZBMD+P5pKd19ta0KS6YJNOxj535MS+w8u5eeKxn+vq/hscd6Q/kXJA/aCeWEjd6z70A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(478600001)(26005)(6486002)(83380400001)(6666004)(6506007)(6512007)(53546011)(36756003)(2616005)(316002)(66476007)(66946007)(66556008)(31686004)(38100700002)(5660300002)(4326008)(2906002)(8936002)(8676002)(31696002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkcwRC9rK2Z2ZnBBQW1qK2lpSVc0RUZ5RVN0MXdPNkJiRWZ0WHp4SzR2a1M3?=
 =?utf-8?B?cDVBOG9acy92TkpwTWx0RFRaazNzSEFreFpJS1UzdzBtMmJ3ZmEzT0g2S2Iz?=
 =?utf-8?B?RE93QVk2NXllMEVOR3ZZcG15Z09JYUtLM3RzSm1NOWQxdGdZNFVXaDhKdTBF?=
 =?utf-8?B?dlhTMm8xQ3hjYWYyM25DcFBTL1hwa2VPeVRaN1Znc0ZqOW1vK3ZobERJeDdQ?=
 =?utf-8?B?UEpJbXpjVndvNzVDSW54VDJ1d3NPdEltUnJUdmZCLzNTY0tUOVRGVHpqOG5E?=
 =?utf-8?B?M3dmdjUvTlkxc0s1b2NmZ2RlNUNQTU5zckRRcmdsS1E1b05xeWZYaGRsaW4r?=
 =?utf-8?B?L1FrVVRUVGk4SUtNZjkrUFFVWm5OVHNTczFJa1dkYlVYajY0Z3RhRUVFejd1?=
 =?utf-8?B?STJjeHBiVVQxcFZrWUd1cDNTeUZ5djNIN1dycGJWY0NldnBrWEd2dEFQeDlK?=
 =?utf-8?B?Ry9rN0pjaUM4QU5vVTY3Q1h1czJWVTFUc3BpQWxQbFQ4WDZYWUlsQkx1Lzl3?=
 =?utf-8?B?T1pxVkVuVWRiZllhcjlPaVVTK3pCalZhVFJtV0hldElXcFlBc1lTTU9rTFlk?=
 =?utf-8?B?YzhnSUlCRXgySTRzaXdoODBBekV5RjlxME8yNU9yQThFb1FrY1JtbWhveDhh?=
 =?utf-8?B?ckFQT2IxVnROUWdreUtYNDhWNUpxOTJEVEdpUHl4THhJNWdqUm9PMFhjbFJh?=
 =?utf-8?B?bWx5N0F1elk1RHdVUE9lb0NBQVV1RVZpT3VXY09aaC9TNFVoK3k1WGtJMDN4?=
 =?utf-8?B?YUplK2ZBOC9Ya3ZiZGt0S05NVkYyUjFSNlNaZ0xtVWhvdzlJbWwrZVd4b3lq?=
 =?utf-8?B?MXZoQUFQZERvT2NHMml1RXNXRHl3Ynp2M0xEZDU2NGx4bmpJNE5kV1NTVHQ0?=
 =?utf-8?B?eDRGSjdudzRNNDkvUklKK0tlNy85eTNxZTRHR1NEQkUzR2NoNUNqNDN5UzZI?=
 =?utf-8?B?ZG9BWGpCY0hFQkpYK2FzSjkwdHgyMHdIRTBsTEJSMjNnb2pEcGcxVHZBbS9y?=
 =?utf-8?B?TTRmZTc4RldXWEZpaFVTL1dRL3lXTDBkNUdRUFUzT0RuQnNJWFF1NlNYc1V6?=
 =?utf-8?B?eFZSMmRrMUdObW5Td2E5UEY5bjhMOUVzWWl0aFZKTHhnSk9YSURrUENPMzVi?=
 =?utf-8?B?T0ExbzRSMitxa1hYRWVpZytObFBOclAxY2FHM0h2bkFaRVdDQ2U3Nmd4N3BW?=
 =?utf-8?B?MEFNbUZ2K240N1ZWZGNyYkFJOXh6ZnFENFpyWUVKZlk1Z09ESlRCOTNXWnU1?=
 =?utf-8?B?NnNadnZHQjY3SnQxTmdWMnd1OEMzc2FYMW9qS1dMOUUyQ2k4Yk44bFdnbElL?=
 =?utf-8?B?SW1HclNRaVFZVlFhZUZtZ2dqNmxwRFp0dHMybVQxZm9pVFYwU0NJSnhDQlRQ?=
 =?utf-8?B?bW03cS9rR0c5cXdRT1VrRGdGTVhtOGh4SlBvK3ZkY0RhSXhFTk5lSnlnUmNk?=
 =?utf-8?B?c2VYUS9mUjVMYlhoVTY2N2tWenZtT3BXaCtzb0thU3kxc2JhcnJDUVptcUNF?=
 =?utf-8?B?WTdkZXFFdTlJMVVVMlBkei9acHRYWHJMZUd3SWhSLyt2ZFZTR01sYytMWGlF?=
 =?utf-8?B?Tlc0UGtTeWExUlFGQTMzdHJqaXdJZUlNbkdzRlQrNEM4QUxwQzgyTW5vYlBG?=
 =?utf-8?B?dGZMYmxxVm90WVZyVFVCUHhlT1lBUk1zc1N3SWVtWlFRYW81YzBjRGVYRWZ4?=
 =?utf-8?B?WnExd1JSQUR1bWo5c1NrdGdNa0lIRUhuNVEzWEVlS3grSE9xcFRaTjN1enlO?=
 =?utf-8?B?NFp6NHFBWFp0Rm5SZ0N3L0ZjK1BSVmVlaWQ5clBnbXVEMGpBVmp5dytpdXZy?=
 =?utf-8?B?N0F2R0owQkdGbkhTUHBxTlFod00rRGk3VEFvL0dWTEdFcnZLbWhHYjQ0SFJW?=
 =?utf-8?B?bFVTUjgrUjRLbDk2YVVCeWFiTDRwbjI0dVgzZHg5bjAzamNTeEF5OC8zT0pC?=
 =?utf-8?B?VjJQeXkrbWF1Q3B1TmFwaFVnb25CbE53bGFiRHZXaGNnVkJNcWt2SWNRRzhD?=
 =?utf-8?B?aXBrek1aSEJ5TW1mT1FYTkhnRjZRWW9GVXpKMDBsNjdZL0RCcnh4Q1VoZkxp?=
 =?utf-8?B?cFRhU2JqellCdTZEYzhucWR1QzdCNGVnK1pVZHVIV2d0M3ptSmdtOUMxaGE4?=
 =?utf-8?Q?EM6a/MxEgcyWQk8rgupmISy0g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563312ab-8210-4c08-5638-08dbf4b6b843
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 10:49:41.9337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbd9MLsC8SU+7n4Z7QAQpF68q8/NUxShJm5995KfkjCO0JsyEQIdolmciy8ri75Zppa2eJ0TIW7B4DZBhIf1oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7311


On 12/4/2023 3:38 PM, Mathias Nyman wrote:
> This reverts commit a5d6264b638efeca35eff72177fd28d149e0764b.
>
> This patch was an attempt to solve issues seen when enabling runtime PM
> as default for all AMD 1.1 xHC hosts. see commit 4baf12181509
> ("xhci: Loosen RPM as default policy to cover for AMD xHC 1.1")

AFAK, only 4baf12181509 commit has regression on AMD xHc 1.1 below is not regression
patch and its unrelated to AMD xHC 1.1.

Only [PATCH 2/2] Revert "xhci: Loosen RPM as default policy to cover for AMD xHC 1.1"
alone in this series solves regression issues.

>
> This was not enough, regressions are still seen, so start from a clean
> slate and revert both of them.
>
> This patch went to stable and should be reverted from there as well
>
> Fixes: a5d6264b638e ("xhci: Enable RPM on controllers that support low-power states")
> Cc: stable@vger.kernel.org
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> ---
>  drivers/usb/host/xhci-pci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 95ed9404f6f8..bde43cef8846 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -695,9 +695,7 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	/* USB-2 and USB-3 roothubs initialized, allow runtime pm suspend */
>  	pm_runtime_put_noidle(&dev->dev);
>  
> -	if (pci_choose_state(dev, PMSG_SUSPEND) == PCI_D0)
> -		pm_runtime_forbid(&dev->dev);
> -	else if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
> +	if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
>  		pm_runtime_allow(&dev->dev);
>  
>  	dma_set_max_seg_size(&dev->dev, UINT_MAX);


