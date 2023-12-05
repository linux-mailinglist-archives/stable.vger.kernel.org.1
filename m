Return-Path: <stable+bounces-4751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41335805D69
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 19:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2493B2121E
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 18:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D816A02A;
	Tue,  5 Dec 2023 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="48raQKNb"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E79C194;
	Tue,  5 Dec 2023 10:36:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2lKjuEwbHY+YkXcNDVPExd4tdBdi/QuZl7nDpzt3KhCDePdazK4JtnBAZKPOZzSkLYqsiwRIiMPbwqUPtxji3DsgI/yOfxh5ccekVIZke9IP/uGvKsz/dbCEEDqNd2zpWJMsS6Ktv+orHKer6X1rqEodxRHOxL4ePxsyCAL3WQwPyoq0gEsteTp5QiNHiq2Z8uCD6QTi1+55EuN5fDzCIjsO4VkjTiP8jDvCC3RP5Dpk+iyRUuCKEZrMBhhDcNsmEWkhi+PWRmaSXuwr2ktUFWULejarSpIJx1LdlKwUIIiYWp0ndYaSACZGsghWCy+1m2M/N2Kivp2iQGWk3a2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AL/aFOXPGYv+Tr9umGpIKzHUj9JIXwoO/1e0Wu6aE8=;
 b=U/XPJmhcMWbcquHhWKlh9/EsuBGw7H2IqQQL94sWYEcGI46y2EwG5HQjoIuwUcVjKWoIZX8cauDGESUezD6l1R8cEV1MUptz7FNOWtAt4Aqcx/pD+xmyx94kccI7pecYG7aRy/1UzPLTZA6K/E8FnZA6NfjwJhPUX1IuBoZLBn98Fhxdn0ihDFB5gTXmSKK5ecT7htzB5l7ENtjjyuhHiFZi7NgncxMm4cbQ2KnWpvN94Sa5F47bRIlq/Wlb0c7Zv6uA12t2nbZ/hHbPgsb7JEKJYEot9DlxSIg6lb4CkNnGJ7ckzqkAfD/6banDqJGjSKSXsyvGVrZuW0nIviqrpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AL/aFOXPGYv+Tr9umGpIKzHUj9JIXwoO/1e0Wu6aE8=;
 b=48raQKNbF5JH9UEJYyjWCpYkB9IZ1KPHeKBeyIlaGQVD8KJzne+HfOyfSm/TBrxGZdz+/GyPhkrPPxc/UFpDqdFoqL2sPysvDCobkTWaoCazIPdUmJqR2BYRinyj4zY/7nEjrzJtcJ2qWjpARyK94lx5qcDhNN4elHy7Bh/P6+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB8462.namprd12.prod.outlook.com (2603:10b6:610:190::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 18:36:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 18:36:29 +0000
Message-ID: <49673f11-ba22-40f0-b3c2-75b3e621de96@amd.com>
Date: Tue, 5 Dec 2023 12:36:27 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "xhci: Loosen RPM as default policy to cover
 for AMD xHC 1.1"
Content-Language: en-US
To: Mathias Nyman <mathias.nyman@linux.intel.com>, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 regressions@lists.linux.dev, regressions@leemhuis.info,
 Basavaraj.Natikar@amd.com, pmenzel@molgen.mpg.de, bugs-a21@moonlit-rail.com,
 stable@vger.kernel.org
References: <2023120521-dusk-handwrite-cea3@gregkh>
 <20231205090548.1377667-1-mathias.nyman@linux.intel.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231205090548.1377667-1-mathias.nyman@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS0PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:8:191::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH0PR12MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb8b927-dbdf-48ae-d6a5-08dbf5c118c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ptFhR8QQ4Ffw+yD0KIc76usXhilWYFFqEVsnwVH2Y8HWMUTP6w3ByUnJL7DWx+TDmwl0ggQjt1ax+QnEtjyO90XwRmFLtr+61HCfipnefyuLmUNw1V/NOeyRP734RXyFridGZiVU52+ELOnsez5zNuhG7nPo+5jrT17vG0tR0VWiyNiWa1b7tyKzESl25g9PZ07hUGqhGqR0+GayODlXjiJBN18f7kPH9oMProC0H80AYmiNJvZh+ckHrGUT/9xgGCOYdnb8f2JFdwal6rVe4nPvGlY1lWeoDDC+P1yuv7g7X6G099iOJSI9ZNI9A5xiXAA2lHv4cJHWZ9tVR/wDtb6t6q/KaOC/os/JObrI5khFFnfvjf8P5P+Dv+8gHQYHYrpyzQ3wgi7qFzIz8/Mhh3V9irW+nOdnNvHe91ql9SLdrQ4owckmC6gAC6Jzv8h+AiNJWB/VUKKFGmSU/LiWNm7biqIid+1Ive4s+yoY6d+u7Vz50BYzKRmCht01YbEmdw6pUElCSdu9hV0OAIzKt1fSMlplRDevP0Q15GWMR5jPkJqYdYVb/Kkxji6akjy8708pvJ6WW98E/DDGOMfc6RtKk/PmPCwywWM0eyTJSrKB6DTYaFX5za4FyeOuJjgJ8xGRleK2/eF7PBnkfdZC5A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(26005)(2616005)(6506007)(31686004)(53546011)(6512007)(38100700002)(478600001)(6486002)(966005)(66946007)(66556008)(66476007)(316002)(8936002)(8676002)(4326008)(2906002)(41300700001)(36756003)(44832011)(86362001)(31696002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0h0L21ZU0QwS0hXU09WWVFSWlhsTFhVMkVlWDNDem9hUzQ3dmZyd0Nya2pz?=
 =?utf-8?B?VXJKeFBrbnRsTG5ydTJGRmtyNVZ4MVFJcGpFVDRETGNpNVd2MEp6SEU2MUtm?=
 =?utf-8?B?Y2xuZER4ZnZNLzMydkZab1JrMzBnczVXMFVFNGVkc0RlOXpDekpkczUrSGdj?=
 =?utf-8?B?OGxkaS92MFRZakFVK0NjWi9OMFBaTnhTQ1hTVG91cEFOV1FHdmdGK3pKajRK?=
 =?utf-8?B?TDRPVmdLbWtPZVoxRlVkeDBFdVNMWUJheW55VmFMWlpzcEN2ZE1Kc3F5L080?=
 =?utf-8?B?NUZJWnRJYXRFbVV5WlhNS1hHL2M0NGN5ZnhNZ0ZsamhBdWh5T2k5eHFXa0pT?=
 =?utf-8?B?czRCMnlhYk1USFYwek9sRWx4Qm91dzJDUXN3TWpFV214YjZzMW9hL1hnWk1o?=
 =?utf-8?B?Z2QxSkh3QlpCZjIvdXdxMTBjN1BGeHU0RUdpdTJ5SVcwc3E3ZlQ2SXNneEVk?=
 =?utf-8?B?SlV6dmJWSERUU1VNTEpIRTc2RW9DdzR2OVVWVVIyNWpzOFk2UVRhWW5CTndG?=
 =?utf-8?B?dEZSNHF6R2N1SSszM1NLRnZjUnd6M2drU0J6d3Ird3A0RTJROXlDMnpBWXVE?=
 =?utf-8?B?SW9ESkVmR1Ywek1VWGE1RG14bXZId2IvOFdRRGxqSFdCaTlJdW9ZYzBsT3p0?=
 =?utf-8?B?L0VnYlV6TVVmbzFRa05tRkdqcmhYYXBDS3g3UGoraFR3NGZhdVc4Kzk2MFdD?=
 =?utf-8?B?eGltN3hvQzFiNTcvc2E3NncybnJUV0hnL0lNYkVNVmZhdXVyUjdDb1pCZGpt?=
 =?utf-8?B?QzQ1OFJvMUxreHdaYWNqdEY1S3RHTWlJWDJkTWYrNmR5dmdWVURWbUxKLzlN?=
 =?utf-8?B?b1ZMYlVudjlBenJwRm81QTNnUW5BS0JURHF5WXZXWGZsNEN5YUtjREM1ZjZC?=
 =?utf-8?B?S1VhbFZtejlzcS9OLzM2emdwNjl3MWdQNitZbVMwU0dETThJQ0NjZHo1dFF2?=
 =?utf-8?B?UUx6MHhSc3lDNnJjQURiS0NQOFA4NEFpQWRyNHRSa3d1cnlEc2l1T0ZsS1Yr?=
 =?utf-8?B?VWJjaGFOUlZhOWlLb2hRRUt2aVpCOHBaS1JQY1BBcUhQSUZUTmk1YXV6a3Fi?=
 =?utf-8?B?Ni9pK0MxUFRZeUpIaWlON0U4Q0xXak0wRmYvN3pXWGsweXJidDZ0aXQyRnZh?=
 =?utf-8?B?RXlZOU5CMWxNTjZRUTRsQmtxQzJGM2NveGhkWkpDYWJUUEs1QmdOQjRuZTlZ?=
 =?utf-8?B?YUZ6RUkzR0lzWmpyZlRuUHdXbFJVangwN1NtQURhT3IxcmsxU0cxOUNZdEh6?=
 =?utf-8?B?dWRCb3VpUENXeDEzZUNKc2JjSTdWQVI1NnpoYk8yNmtwN2tKZVNhVTVRYmts?=
 =?utf-8?B?eFNiZktIZmlPNXhhdXBJbWp3a3Nzb0x5UVBkSDArNmdRazEwWWZ4cFl4YWhu?=
 =?utf-8?B?Z2xZMjRJbkxnZVNUdDlpU214eURYQm1PeFpydTRieWsyU3M4S0FIanozamdZ?=
 =?utf-8?B?OE1vWU0xMlh3L1F4c1dVRWFHSVdDMHhOU04xMjZwRW0yNVRRVXpiaUtGb2t2?=
 =?utf-8?B?QXJEYmhtNFFxSjVGUjFWeVlZTXNtSVdOOWtQS0ZQaTZrdkNUMXI4NmNjZ2Zh?=
 =?utf-8?B?TzFYSlZOZ1dYelI3MzBKS1JYcWNZcVBROGhndmlSY2RqaTFEZkVqR1hJeVgv?=
 =?utf-8?B?Y2R3ek02b09Ybzg0Z2tDdERNZ29OWWNOcWcyU1VvUWloTjBkMG9NaWQ2YXZv?=
 =?utf-8?B?QittekxDUGVwTjRJSlR3YW5haXo3K2g3cHlNWEdGcFB1UGFFWXd0Wk5XM2dx?=
 =?utf-8?B?Z1U3RDIxU21FaEY4WTk0UVZzZTFQeVdMMkpWODYrTVRiWWhBaDhpQlM4YTM5?=
 =?utf-8?B?azU3Um4rVnBMZXBXQjhIVjNlc1hHUDk4Uk4rZ3l3Qld5T1FoSDJYY3RISnhl?=
 =?utf-8?B?bTNoM2t1RnpRYVg1SlpCVEJ0cHpzU0JiZ2ZJb0E4WXdORDJ1QlhPNGRUYTM5?=
 =?utf-8?B?VlM3ejJ4OXpHdzRWV01qVCtQQWtpczYzU2RjWGlDOFdZSmlNT1RQMkx3M1pO?=
 =?utf-8?B?K04wbEh5aHRvMTlYaTJvMzNzVUN6TXdlOFpNQUxnNFlqUTVzMTFlcDJSSXRK?=
 =?utf-8?B?a0tPZzBiYlhNUzRYSkJRdmFPSWx2YVk1OXVycUFZdUNJem1DWkFiL2ZVM3N6?=
 =?utf-8?Q?DF/bsJUhHF6UG55NCdktdwCjB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb8b927-dbdf-48ae-d6a5-08dbf5c118c5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 18:36:29.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsK6hjbkQ9AOvpxgmfk9MFb+yTImjbJ8Mws5p3ImifWsHHJgLpGyf2a7wQDVfmFu4/8rMEyZiINBFMRtsx0W6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8462

On 12/5/2023 03:05, Mathias Nyman wrote:
> This reverts commit 4baf1218150985ee3ab0a27220456a1f027ea0ac.
> 
> Enabling runtime pm as default for all AMD xHC 1.1 controllers caused
> regression. An initial attempt to fix those was done in commit a5d6264b638e
> ("xhci: Enable RPM on controllers that support low-power states") but new
> issues are still seen.
> 
> Revert this to get those AMD xHC 1.1 systems working
> 
> This patch went to stable an needs to be reverted from there as well.
> 
> Fixes: 4baf12181509 ("xhci: Loosen RPM as default policy to cover for AMD xHC 1.1")
> Link: https://lore.kernel.org/linux-usb/55c50bf5-bffb-454e-906e-4408c591cb63@molgen.mpg.de
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

This presumes that Basavaraj is going to send up another patch for the 
ID it for sure improves, works and is needed.

> ---
> v1 -> v2
> Revert only one patch, keep commit a5d6264b638
> Minor commit message changes
> 
>   drivers/usb/host/xhci-pci.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 95ed9404f6f8..d6fc08e5db8f 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -535,8 +535,6 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>   	/* xHC spec requires PCI devices to support D3hot and D3cold */
>   	if (xhci->hci_version >= 0x120)
>   		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
> -	else if (pdev->vendor == PCI_VENDOR_ID_AMD && xhci->hci_version >= 0x110)
> -		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
>   
>   	if (xhci->quirks & XHCI_RESET_ON_RESUME)
>   		xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,


