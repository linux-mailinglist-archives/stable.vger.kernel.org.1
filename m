Return-Path: <stable+bounces-23723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883EE867A56
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 16:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2677C1F23797
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 15:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D853E12AAC8;
	Mon, 26 Feb 2024 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5V6m15m7"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD42129A95;
	Mon, 26 Feb 2024 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961573; cv=fail; b=Pj4pcquhhm/YcfnYIwbHwuIV2Z9VkARiYZFQcTloqyN9oJL2U3NNMBm6johT/1YWQ6PGr3dXgomVC1y34bp0jr8dKfos7MZB0a8JEsxnkPIODsoyo9E8414kLXKGgZu+KzIJLJqnjk+GHrKqHEVMWX079L4rK3K4QR9dV5CknoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961573; c=relaxed/simple;
	bh=rJ1M/iD/gIjiRNOBpZNp5mdX5JC4IhEKwU/Sj67uMNw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OSf8AG8vfLcJKexIFNPJJzFfGtwWB3rTzitNlYhsQH7tp6S2UHlJ4FlBuxbDWM+iyc4imCRyn4AWU0P+6EPNgVi41ffLav2mQvM4dLq1PuW2CHGttAP7HkrXGhsqJqzAu72oibgPe9FBQ+aBg59mgI8S/ZDEA6k/zLbFq+eoSlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5V6m15m7; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZu+USfv6bxWCC1Icb87TAaj40JxJ08V6ryfZxl4ObCspsSbtt6wEsI8qhkaUOpPxD2IKGf+q6Wvx/xBrUhIO2gq8nygF5l/0VyyFpVezg0dllJcngHm2/VcoHu3r0YzJNgo5MVns6amrXWQBTJPMqvzl51R1p9cA6FSqluh1Gvey8ct7Ncv1LDCHrLBmLyDpX4xNoI82rv/kTZFrdvZswsySBj8HrCNC+woE8Rmba586TFf0D6PAg8bKTVd9KECO8jhIKqyh8c7QFZxfZLQ2fJSFmYDtaLfp4hHe0oRlM6RG3RHy8Tyb075UjvqOjPkGdslAhQNeOQni0XF5H19sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRwuS6fgP29IUzO6tT4wVidYg30g7Y0kdV0SSyAesIs=;
 b=m8r3jAPufSRNSEt/pdajYAyYfQuz58k+YKVRNU7rmfe2NHtn+6LY3fA82gtShpxZkIPT1alDO6L867/BNdbuxFzL7A9iPSmLxI3xmbKIO9tut0VPxtpZ0VQr3B9wZ0Rh4FojbTBGFW7uZREjeNpKR5zNrdn2qQcxsi3h8DpuMAnUw9fF7F+Qy38SCKgR1UlKOFWr+bzkwlfwk1wr9vluFqgHF6vhKoGCsUb8XBAIgt6vB7Etzm70d1ngwtfGDKcCvYy5G7kei2FqTADhSzjLDhwo5cTGEBmer6r1jSFHTm9Jfs0zVL4+v4eWOpHqn1tbuVGfUM5VT15M43yP23Sy/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRwuS6fgP29IUzO6tT4wVidYg30g7Y0kdV0SSyAesIs=;
 b=5V6m15m7dcvOWkBVw7pTJzOfniiCSrLevvWZRGxQ0DCsO57p2Plv+2KL2+raMnZfuFArAKnBcqQ2DVauCtClAzWp64M5wTCYxzaWPIWq+nlnOSe4dGcwQiFcGBN5Rt232oVmyiT2jPP3/Fh2MgWl+O8BmuB+nuX6f+UnaIn9zeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 PH7PR12MB7187.namprd12.prod.outlook.com (2603:10b6:510:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 15:32:49 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::f295:e439:73a8:c57a]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::f295:e439:73a8:c57a%5]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 15:32:49 +0000
Message-ID: <4bb05f8b-051b-45b8-9f3b-14cc30812fe5@amd.com>
Date: Mon, 26 Feb 2024 09:32:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xhci: Allow RPM on the USB controller (1022:43f7) by
 default
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com,
 linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org, Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20240226152831.2147932-1-Basavaraj.Natikar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240226152831.2147932-1-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::33) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|PH7PR12MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d11eae3-bea1-4a5f-1b26-08dc36e0308e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vksp2dI2jRh7XjA0fCA06bawZy8/wmdok/FYxTNOHzARLwrvrUbE8wV/hUXmWX2MM+ZENdjn3pESRx+rwDYqr5VN0Zl1kSMzPaX/IH/XvvlvM3kgx61HnpcaTCtU0i9TIpGgDwehxX2/PEtD8havnwQa9P5tcIMy7UJ02TDnQ2cEpJ+WdvUAAycoKwtrE70pzOpEmK8lRvYJA/muR3OIw3dihKWXeibvaz7kjPiKfV29nhy2OCHxBUW8yae0NIh438CxGI/k5kUIyK/7lZnJ4ERPr3snv0gZb+bCEXRopNJws3OMmDkiH/2zREoL9+eVcE1Lag8bg7p2RyvE5RelrgOetHaWAqn9oYT7zGA0z0pIblxK7hr9mfR2+1lXvaJHKw1HZ6j5Tt5/aY8T0e+N2EsSU7c6vSRBXFqjOSpaAGbuo5SRo5A8/xUpfgvUQXBfQxE1PYTdye+3cYQJ9UZ395ncwg8FbKH5I+Y1hzv8UEAjFeBB3SUQoRb1/Mbju7VcAdKjxpIBJ8/VQFJvYcT03GGW76k36UNDUJuPh3ePxXt8/7AKjbYw+7sxSkQVtIIaphH3jS6Xv+iyrJRq5m4VPmwIXXpnMxjtxxNCvfRSwMzNPXPJ52CF6lLMYwlLf/EJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkRYL215SGdZbXVOYmFkeWNYMXkwYmcyV1lkYml2RnJNa2lWbXdIN1ZWTjEx?=
 =?utf-8?B?M2VnU3ZiMGxZd3pWaUpzS1ZHU2FyWGxaWkw0T1FKVDVqL3F1dGhab21sQVhK?=
 =?utf-8?B?WDBoY1I4UmJLR0Nxbld5bnZiOUp5cGdiTUZsQ2RXK0g0ZWFHK2tmL0NwUE5v?=
 =?utf-8?B?L21aV1J2SEFGczh1Z1ZlZkNMMDBQeVRrTEpJVmNVUVNlVGxWRkpnQldTeEpF?=
 =?utf-8?B?cG42ZzFzWGd2S0lscitaNURLNFllTjlEL1F5VWhZMDRqa1VJNGJxNG0yQ0pR?=
 =?utf-8?B?RDFQenIrQTNQQU9QRmx3blhNZVVPeHI3aHA3TmpPd21wZHk3UVUwV2ZwZEY1?=
 =?utf-8?B?aGJXOWNNWmF2ZkxKSDF6eWwvcTUyUnJDSW8xc2IydVFjOFlwTWNPSXFYY2Nk?=
 =?utf-8?B?ZFU3NmtEUXYwRmU0WVFVeHlXMUpOVWZZNDF1WUhJVGI1bmloQUlTa0Z4RllP?=
 =?utf-8?B?VnFHYzFNTC9mcXlqWU4vZ2dzTlZUUnIrdldpZEw2VjlkSEVoU0FzZ04vZDIy?=
 =?utf-8?B?OTlZWVRXZFBRMFZmT1NNK01URk51MkQwNXZtc3N4eVlqN3VhbU9GdkxCb1JQ?=
 =?utf-8?B?eW0xZFN1SmpkNWhDMVB3WDJhS09KWk9iNHlvUnIzNnBCeUtQSkgxRXpxZmlj?=
 =?utf-8?B?d1JVajVFSWVscldMdWR0M0w1enU2UmxVcVVPd2JwcU9KWGVTQkxEZFR1MnZk?=
 =?utf-8?B?MGFvL21Od1FiaWx6RWtDbFVybE45eDA2SzBOazFyeXQvMmtkR2UwMDB6SU9H?=
 =?utf-8?B?RkdLWko4M1VONlFzeFYxNnQzZHN1ZjVINzNBYS9PWlUwK1U1cU1peHJUVCt2?=
 =?utf-8?B?S1FGWlRrTzduVUkxQkIzUlZIWURZandzeXNNN0ErWlNQaHZMdXJQL2Z1S0ZH?=
 =?utf-8?B?Z1NDdFdQREk0REg1aFFPWEFCQWFkKzNGd3p4S2VHQkFZcXZVZk1SajYxWlhq?=
 =?utf-8?B?NzhwYlpCZjd3cVJ5cStZTEphQWI3OE96amtJZXowYnhQbWp3SnhYRlZsTkly?=
 =?utf-8?B?ZlE0dlEzUHAvSGVVWXFCYklpcThRNUVreE5RbDZEVEg5aHliVDVhOEZoVXc5?=
 =?utf-8?B?UzFVcXRzRmdXNEdybkE1UTdEMkx4b3hpWmJYaVlmSDc2L2JDbXhjL2luajcz?=
 =?utf-8?B?V2F4eFZUZStSUkRRdTZ5eFZuSjc3SHE1RUxLT0dKbms1QTNuQ0kvR0tMVGYy?=
 =?utf-8?B?SzUvOUJBNStGMW52ZktvT3RGa1Q2NzJ4eC92VS8xSkxLUXBPQmZCQ0J0NEp5?=
 =?utf-8?B?M0ljOUIwRUJSbGZFbC9wL2pJc2VoeVRwd01xNVFqQ2lQMFlJc0k2WndDWUM3?=
 =?utf-8?B?YVpGNGNIUml6cmc5d2d1YmZyREFWWW5RN2N3S2lrMWNzTHpobWRwVmJveXZM?=
 =?utf-8?B?bGl0cVpXSVlWMkxQZWovV2RkY05rVS9STVJHNFRtSmxxV2ZZc29yL0xOeDcx?=
 =?utf-8?B?c0d3dEZ4NHRFcVhITHY2bStxcDhsSHFKU0MrNzdNaVE3end2VWw3UnM0cGZF?=
 =?utf-8?B?N1M0OXdCSURJRXVIMTVXMUVhYlpCYVFhQjB0a1EvZEFrVlZ1YjdGU2J0T1do?=
 =?utf-8?B?SDlORlE1OTJ3eXJZdHZrQ2FkdlRKQ1Fiem5odXRNTllVZnZkMnZjemZ0d3Fh?=
 =?utf-8?B?WjdPWjlwdTM3QWJXYjYzVWsra1BoZWJJbDdMbWxvZ0IyQjhvZjZrd3R0SjZr?=
 =?utf-8?B?RWV1MS9YRzA1NTRIaWViaEpvNHFEa3VYU0owa2pFRnl4WXVvMitjZ2krcC9Z?=
 =?utf-8?B?UTVhY3dPWmF6blBnL0xqTkc1WUpaenUwSlluWGJ1RktTTjhyalVVQkFPNmhM?=
 =?utf-8?B?bmlTQ3ZvbE9IekxUdlZob3BCSExlMFNDNnM1NWl3Sjd3WEYzbnpVY1o2Y0gr?=
 =?utf-8?B?WS90S1ZxZ3FudWNTRXpxQXZTaysyZnliU1RQMTc0NGkxY1NUMnZ5cWpSTUxL?=
 =?utf-8?B?TDNkN21obkdOS2ZJbVNPd25xVmVSSENBWjhMOUVlU1RHeFNrZDE1Q25Va1E0?=
 =?utf-8?B?VHVkMm5QSkNIVlFnL1BXWW5yZU9MUWdhbkNtdnEwckk1KzlXZ3lPRHpHVndY?=
 =?utf-8?B?N1MwY1RXNjEvd0FHUFZOclVRVFdKWEIyWC9ON213VEJ6WTRKZHVUNEptUFdw?=
 =?utf-8?Q?aG573EStLRqSVsiVPS7iV3IIt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d11eae3-bea1-4a5f-1b26-08dc36e0308e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 15:32:49.6578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAK8AhoFPdvvEhHxY63L3AG7+kiz/GLChePePv8Dmckvuq8cMVXkLhLc41pdLYudNVa/Vda4evCrGJWLUr5QjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7187

On 2/26/2024 09:28, Basavaraj Natikar wrote:
> The AMD USB host controller (1022:43f7) does not enter PCI D3 by default
> when nothing is connected. This is due to the policy introduced by
> 'commit a611bf473d1f ("xhci-pci: Set runtime PM as default policy on all
> xHC 1.2 or later devices")', which only covers 1.2 or later devices.
> 
> Therefore, by default, allow RPM on the AMD USB controller [1022:43f7].
> 
> Fixes: 4baf12181509 ("xhci: Loosen RPM as default policy to cover for AMD xHC 1.1")
> Link: https://lore.kernel.org/all/12335218.O9o76ZdvQC@natalenko.name/
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: stable@vger.kernel.org
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Does Oleksandr's testing actually apply here?  This is a totally 
different patch and system isn't it?

> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> ---
> Changes in v2:
> 	- Added Cc: stable@vger.kernel.org
> 
>   drivers/usb/host/xhci-pci.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index b534ca9752be..1eb7a41a75d7 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -473,6 +473,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>   	/* xHC spec requires PCI devices to support D3hot and D3cold */
>   	if (xhci->hci_version >= 0x120)
>   		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
> +	else if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x43f7)
> +		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
>   
>   	if (xhci->quirks & XHCI_RESET_ON_RESUME)
>   		xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,


