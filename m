Return-Path: <stable+bounces-23724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C63867B52
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 17:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1E59B2E530
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 15:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C409112B15F;
	Mon, 26 Feb 2024 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m7kTvhwF"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0302512AAD6;
	Mon, 26 Feb 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961894; cv=fail; b=d+FSE8ASl5P3MBYDA2XwyMBibo0ytlpuk6mwYDjBx6A8dVIEjQ5dL2O+3AjxAqIfPrwdL5t7WbtCPBEkKBzZdHMXZ/8JZ8QQJiu7v6/gBEzc5YnCfBbA54MTW0bMkFgrqDXduTI1TKpcCaLMpqL1cPqhfYlXGdLAZpdd8+IFR6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961894; c=relaxed/simple;
	bh=IOi4V+w3JjXhcNd4FXGa8EcVltIZCS1FEmYol3CHBjs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZkTSR3w789E0aye6Jpb9MmYNUhp36rqMuoV0gz93E70GDM2ZjP2TcwY80bI0X+9nh2wyZTXuPX1AnzFYQbpo33H+29S/aBp+E9meFK0eudrkefxCHLxi7VkneAu04pURzZwHHwJA/HanCH7xC5xMrTqOrTaFwFJhvb8GZw9XyXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m7kTvhwF; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDMe8v7buuHr1uJaRu1lVF3u1GztS7cEM+NgrGVkWa/YLtacqBh0xnY4rQEBhrwfKK1GTe/no4qx6kalo/q0+WQIgEJADAcO61gWOoRt8/fl9UPrfQZo8wFDCdvDABF1JKyWWtcHH1EhIe6yMusxgdezQ3mSxoOjbpAmaAnIFXXtVr3/+5AfsV+ZYgxcPmqmGXW2eZsUwgZJfP4tp5tcWDJg33+pWtjiPB3BSAscKEaeRxHLRO5uz5TPseqfyasrMe9Z4Z29fXcEFWyYeKpR5+GOfMd3UbhHnBGBsoEcQVcmIzLDf8sa1oaNtxYzg8gpXQhExoA7TGCwEFTMW6pUZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CogSi3z0ozdI+McMtwP4x/4hUYMdC42PzYnL4EG1XqQ=;
 b=avspfbrqG0Vv3jNp1MW7NcWXtfCFC5TRF33Fi7OKgL6uI61QZJD+2MNRhblpA8IBjOkOZAyc9efaLGoJxSCjJlhbHoUyxLg9iIt1U2O7FWUuqRTMaZoZ4yDDWw0IcpBvqr+ZVPjWPuB0F+OSfHZ8z09pY0aEcr9VG1M1Ui+FR5v2th9BcFG2qRfNlDI812qkuujpzmqRU3g3y16Lt6zrJACXazWUWIU8JOML9EdSFuP5F4ZyeMJ7FLX8/mvyhuTSkd4H2jgfHrsHeJP8cLCBLD6yt2auMUAuGkl5RP6Lww5+34GWJp+AXtgUqc0/Ou9DlRRouI0yPh7eRCqvRJ/F7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CogSi3z0ozdI+McMtwP4x/4hUYMdC42PzYnL4EG1XqQ=;
 b=m7kTvhwFISCHwnKca8Q5U9lV3waaYhfZnH8hvJiSknYcz0JAfth3psiN5zyIaswLr+oWjZr0XZhDt9Tm2NAmKrA4ENta+e6lROKoAzDfmeA+3LzS3NGMxRvct6gh/mJcHLwii3jFePZHh/uyrbHf8fICMoacuZGorY/m1KBPLVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM6PR12MB5007.namprd12.prod.outlook.com (2603:10b6:5:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 15:38:09 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1%3]) with mapi id 15.20.7316.035; Mon, 26 Feb 2024
 15:38:09 +0000
Message-ID: <b5523bdc-3516-40a0-84fe-9cd6a315eb89@amd.com>
Date: Mon, 26 Feb 2024 21:07:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xhci: Allow RPM on the USB controller (1022:43f7) by
 default
To: Mario Limonciello <mario.limonciello@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, gregkh@linuxfoundation.org,
 mathias.nyman@intel.com, linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org, Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20240226152831.2147932-1-Basavaraj.Natikar@amd.com>
 <4bb05f8b-051b-45b8-9f3b-14cc30812fe5@amd.com>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <4bb05f8b-051b-45b8-9f3b-14cc30812fe5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::9) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DM6PR12MB5007:EE_
X-MS-Office365-Filtering-Correlation-Id: 3365594f-fdb5-407f-b6d7-08dc36e0ef03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UlcRLA7F3HjX829CZIr7CtlyGiwZ5CTuiUQu5VPhhZ3QWcMF9zgN5+pmP7crbUE1PNIpM1O+oGksCuwzB6PXTreSCZfDB44XV7bHO9PhBiv6uvcat8WEQcazUW5jIoE7iPYAwhX4sIGWZKHIJw2a6X26LKnlZZDlefa5NbbP7YT6LJEYK5ZMDqK4fkNuW334hLXJucJlC6VTtUcYk6siPRjLyi0nluVmbBK4LIzTYka739OMKkYF8UvPyddij8PckJVsLcj0SoJnK49Gr6mSJfMRB2BzTnqU5FxPiB45Zj3dBnwJhspJkYMVjzCNc4BL8RFIOzlyqpKVnPWnCJMywNugZSnXR9nxK/4m49yQbCqmQzmiORI1OblxYojoneQ9grU9rMuaZqN+d8A/sAGt/O++Scxdexkqvij/+SK7T+TqFtoe7gWejSo0l6PeiCkqqcegNQCDQQ/3I2AE7hqLVVSXzeLO0yXhfV3syr2ALeaSIrvVpL3Nxw7osIoKKIoOhAt3Wo7cYlxyylLCet1vmBYmTstfkaqJF472RbXOWtE/ZSw9rZbKxG5+HglHB50AIn61baNKCCpQCkFc8Ww4D0f50ukvfIAP2Jkw6Z10OIzXoQs6oAnJ68NoGfCEdj+7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmVYRVU0ZlZMcHZCTUM0SGJtMGJWVWRTaWlKNTJPZlMrUTBDMVN6dDBkT3Jj?=
 =?utf-8?B?akxBMDEyZ3gvVUtweGJEeEhFSk9xQlJHQjhXZ0RKYkdjdFdUT25ZSWgwTkk2?=
 =?utf-8?B?dXBrWGhjVm8rNHh6UTZJRHhVRHRKSVNHMUYxTkJQWFpJVXZQZndhcE42dG1Y?=
 =?utf-8?B?TlV1TXdFRWN4aW1NcTdGcTM3bFAyOTl1QXNnVFl1VE15U1FLQUUvTkVMbG82?=
 =?utf-8?B?aW9rcWJQcjhTVVVCQ2Z2WGdZL2MrSDhVRXEwRWdJbk1GcHdJRmZ6bHM5eWJP?=
 =?utf-8?B?MTBCdlJ3MWt5YnhRa0Ftc29WcFgrZklpOVIrU0hrTFlsRU5GMDFDSGIzTTBw?=
 =?utf-8?B?eTdRNHFhNVRoMG14emhBa1lNcEFtV2FhWW82ZVJPeHBCSlpHMVdYbEhmS1VM?=
 =?utf-8?B?RWIxamdyOC8vOVdqWm84eW9sbjMwbGxJSmJVQ2tCRkhnSkQ2akpLNE5pVUtq?=
 =?utf-8?B?MXUrRWFhMGV1WCt3ak96UzFjS2F4by93YkdHYTJUUE5PTzNmUUZ3Y0pEMjNJ?=
 =?utf-8?B?Qnh0MFBJRllPNElJSld5K1BsTU4yRllKdklzMWZMVHRNbWNLdGJEQ3pieG96?=
 =?utf-8?B?TG9VdUpkRW9EZVVPY1ovTnVQK2lIR1A3UHZQOHUrc0pHU1RrekkwWHVBQ0x0?=
 =?utf-8?B?QmZSbkcyS0lnVjVnVE91T255L3dYcWVjbzNhNE1aOU9Ka3dFL2NRVGhwVzRq?=
 =?utf-8?B?dW93K2VoaDE1TTRLNTZrd21kSWcyR2Y3eVVOcGNnUUU0N3FNMjZoYmQxSXFK?=
 =?utf-8?B?YzdhQy9lUUFBSnhXYWhEZWpRTE5xQjBlcTg2MGdXOEpEaFlLQkhsSDBxL0pY?=
 =?utf-8?B?V1VvNlBpenlka2dnQWx5MEhwNVpLemZ6M1QrWkxONjJxQmRaRmJaakFacmU1?=
 =?utf-8?B?N3QwKzZWRmtSbWh4ZkJFYWpBZDlvcGdGdjFkNFcyelBhNkVQS1R2NG5tTjFO?=
 =?utf-8?B?TSs3djdNSFQreHpkN1hTcGZGVEhDK1BHdWV6KzVoYUplSVFUQ1ZqYXhwbGhW?=
 =?utf-8?B?SUUycTVUOS9jVzlCWjN3b1g3cCtmczZlRzh5RDJXbUxtMzNiQzRyQmF0Rnph?=
 =?utf-8?B?Nm02bjN0YWpIU01kbnk5aEhYdVJmazFETWtwd3o5SG00MkdCdms4eVorZnNh?=
 =?utf-8?B?MURQNi85bDBYUFdkSkkraFlsS2ZhbVk5SHVoVEdBNWV1THJrZm11MFdGQ21t?=
 =?utf-8?B?L0lKdWpMaFNlTWhFWmJOT3Z0Um15aFA0bmZoSGRyT253WmVNdld5bll6dWJC?=
 =?utf-8?B?MENLWjd5dzhjSzBpYzE5OFRUS0ZFS0VuR1pWK2Z1WWxDVmJWbWZoUUczVmJ3?=
 =?utf-8?B?MHpYMEFKR2czT2ovaHgwQTRWT1lEelY3NTdFQmJieUpHOG8rVWVOM1NoNEZl?=
 =?utf-8?B?Y0h1ak9MakQrY2VSNElUT1RUQzVqUkUrOVp6d3FXazhqNk52eFo2T0tScTU5?=
 =?utf-8?B?S1loT2xhZ3EyMnFob1dNbGJoOGdJVHE4bmIxWDluQi9CR3dSV3YxZnNneEQr?=
 =?utf-8?B?M1VOOXRkcmNTV2ZzeGJRUEYvVnB4OUg5NnlqTEFvTFQxbGR4MWt3UzN1NG02?=
 =?utf-8?B?ZEwzMCtDZUlwSjh2b0hIWUR3VzN5OVIvSEhqS1ZlVHZyUEVBbm1RUmkrYmhK?=
 =?utf-8?B?MFdvVXN0azdYV3drdGxpZTVoMmQzanhMeVIyR0JCdzk5ZHVWaUZqSXZ3UXVJ?=
 =?utf-8?B?bXl6NDZDV0JZM2w1dWhSZkhlU3Q0Y2VMUzJScDdNc1kwRTBvRGU5VmxCNTlY?=
 =?utf-8?B?Rmc0UXVBKzZ1T05HTUx4S1BXdmNRNWtGanU0akV5aHJMKzM5YVBhMWR3UW1Y?=
 =?utf-8?B?T0hscm5Tck10cDNUeFh5ZU5odmdrZ1cwS1hFQlk5MmNMNml1bi9mbS81dWRH?=
 =?utf-8?B?SzgzUzNJdkRjVWRJOHY4VG1NY20vN2pWZTVOWXlxNnR4K3d2ZHlLK2FTZVBG?=
 =?utf-8?B?QVZFSDJyTzR4M0o3Z0xQY2N6WUNmWG84NlRuMk5NajhQTU5NUWVwS1FyV1li?=
 =?utf-8?B?MDlpRzhsYU1ma3o5QzE1NVV5d3c4TXI3ZG02MW9mZ2UyZ3RJV2ZXYXQreWJN?=
 =?utf-8?B?VFBsV0UzSnorbG9wbGQ2QUpNQXNoRXNsYnVIdXlUMUhwSVIyQ3hoZWQzNDF0?=
 =?utf-8?Q?TMGf7sKjvNWKMbuyGCcBzfJrq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3365594f-fdb5-407f-b6d7-08dc36e0ef03
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 15:38:09.3656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFKTbQJBdQTRYZ4ZzbTtH6ftMHlYb5KoToHX6X/JyANKAXfXkIKqCsIF02QXUlaKlgzR8DxNuxNUmVxptGUq4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5007


On 2/26/2024 9:02 PM, Mario Limonciello wrote:
> On 2/26/2024 09:28, Basavaraj Natikar wrote:
>> The AMD USB host controller (1022:43f7) does not enter PCI D3 by default
>> when nothing is connected. This is due to the policy introduced by
>> 'commit a611bf473d1f ("xhci-pci: Set runtime PM as default policy on all
>> xHC 1.2 or later devices")', which only covers 1.2 or later devices.
>>
>> Therefore, by default, allow RPM on the AMD USB controller [1022:43f7].
>>
>> Fixes: 4baf12181509 ("xhci: Loosen RPM as default policy to cover for
>> AMD xHC 1.1")
>> Link: https://lore.kernel.org/all/12335218.O9o76ZdvQC@natalenko.name/
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> Cc: stable@vger.kernel.org
>> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
>
> Does Oleksandr's testing actually apply here?  This is a totally
> different patch and system isn't it?

This patch is added in https://lore.kernel.org/all/12335218.O9o76ZdvQC@natalenko.name/

And he mentioned in link https://lore.kernel.org/all/12335218.O9o76ZdvQC@natalenko.name/
to add Tested-by

Thanks,
--
Basavaraj 

>
>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> ---
>> Changes in v2:
>>     - Added Cc: stable@vger.kernel.org
>>
>>   drivers/usb/host/xhci-pci.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>> index b534ca9752be..1eb7a41a75d7 100644
>> --- a/drivers/usb/host/xhci-pci.c
>> +++ b/drivers/usb/host/xhci-pci.c
>> @@ -473,6 +473,8 @@ static void xhci_pci_quirks(struct device *dev,
>> struct xhci_hcd *xhci)
>>       /* xHC spec requires PCI devices to support D3hot and D3cold */
>>       if (xhci->hci_version >= 0x120)
>>           xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
>> +    else if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device ==
>> 0x43f7)
>> +        xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
>>         if (xhci->quirks & XHCI_RESET_ON_RESUME)
>>           xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
>


