Return-Path: <stable+bounces-25482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A50D86C71F
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 11:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD36D1F22AA9
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 10:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC8A79DB0;
	Thu, 29 Feb 2024 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5KR4gYti"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F365194;
	Thu, 29 Feb 2024 10:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203362; cv=fail; b=lPoAaSOS5cjasX5Y2AYu8vSLVKcuLgqMlh25iuX8GsE/CLsfDNofpI7yT3Aa3tCbd6ArYXGc9kv59kCnGX52918BKxTJyxBsuIw80FqS2Y5YbpojHK6tllBeN4IKYkp5Q3ZuoZuNNEO3aBbaS8NoaQwz4IO9TYikZQYmqP9/jHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203362; c=relaxed/simple;
	bh=5vnUgc346TA7TYyb0SU+VsCG2O5u2p4D1FGfWhXB4hg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HtmAZgfiVyeBn3GJFT6JMmzt4DqLvdmabN1TqknMk/iYAd/3CBo+GipwZv7Aop5XngvES7Rg5Phzph1c7OpNg9hwJDd0/WRjH4nWwt7oSqGHrs/fDiBORsC5hukGeBoJUT4ZTHpiBhXUyPxL6vwz3n1vaqgMINoCwGAOv+bmK/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5KR4gYti; arc=fail smtp.client-ip=40.107.212.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dv87DWmCBz8x+wrFkhxGm5o4OHbLnkfHJFalrUAjQc4zcVeyBA2PEnpRM+64BRBQK+JH/jAdJS5JRHSefE8fOqnhfXZOoM0nsiW0lzr6+1I9qAuSCovktkeaM0OT/0a4lIiLiqgJ5n8ut47JnlX2C+OBuwMR3g+Ov0EuuR24O0xoKGvGpnYuBCMK8JeKu3PnMG/2OgG0AXxZwlZg5bKE3TpWZeu/XEiUI+VXlY0L9VMUP0y0prp8QSGOcX5gbfGwiVQFjhseXdynaU+ewowmVFyFNvr/mDsPwnTHeAnX0/71YtVAYzuZ5rvQn0fJ0ZKK6H2bL9+P4Xo+vwtoPSo2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vnUgc346TA7TYyb0SU+VsCG2O5u2p4D1FGfWhXB4hg=;
 b=SSQcFHYIU6xpUH02T6drdyx82l1VqCzYMuJ/sI4rQhT7q+cNFBeqMN/oLdi38tLHFZJS8OrU4sDN8yL270XJtatZI+C8pxqPpsPOiXPxjWmX5qvZgmHJ6Pq/j+3lH6Va8fv7sSa9I4vGg1HYa8prMcXyePnJFBImhF0awSR3y6QU/HEoNP2cW3F7hfeSu0bvR+ZVqSxyn3EKHGzHFiNlsxHh2LtDU4DljQwKUvHseZgibcTrvqsvRvv2h2WHJ0jrxy0j0M9i8QPqcdi2a9iwrRLyiBvh1SEBot+adlalE1JkBsehl0AlreZ7ginQoAWG+4J++aRVNtV7T1aRM82wIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vnUgc346TA7TYyb0SU+VsCG2O5u2p4D1FGfWhXB4hg=;
 b=5KR4gYtiTjDT9Ym6ziy1jqX5fColwrb1quioGgFmFyWkSLLJl4zBOe+lmo0SR9u+K8HMdHi1sal06V0nEX+UikiXZpnftsuZjD96B5stC6kBq86IQRYwjUGVu3XMPOkxZgxw2Sx0UTQek5XsAKNxwITZvzy5ypa1+zX+noUTLxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 10:42:37 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1%3]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 10:42:37 +0000
Message-ID: <0c8f1292-fbbf-4555-bd6c-ca6d704eb99f@amd.com>
Date: Thu, 29 Feb 2024 16:12:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xhci: Allow RPM on the USB controller (1022:43f7) by
 default
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, gregkh@linuxfoundation.org,
 mathias.nyman@intel.com, linux-usb@vger.kernel.org
Cc: mario.limonciello@amd.com, stable@vger.kernel.org,
 Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20240226152831.2147932-1-Basavaraj.Natikar@amd.com>
 <a1274e8a-c761-a39f-20a4-06989e8144c6@linux.intel.com>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <a1274e8a-c761-a39f-20a4-06989e8144c6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::13) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c65426-ec2c-481f-471e-08dc39132555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jjuldX37fSpG6CgAHzD503Tj8MtZenDtDLxrCsfylL9A/QYPsAQ5t4My76gFNfr41pX7EuKoF/Wo3KkWfLLs46xai8uwGbXAgo+Kj20r5QpVnVcsTMvrfFsXgDBiQBGTMUdF40Ln9NkbKDx/lmtI1tb4Kr14xhZOCE6iSK+sB7tWivQoVYsVvFZ0TE0qTIwHHjWQ7ObQDPQUDGHGg478SCg6WPjujRQpdMFQcP4Irr1e1g0kkGzj36MfFd0SwNwiRixUjXxdFCKqV9qdb9pU0l9KSulZJ4XBZoQYrk7KSuSzLdFv+KkfhgPUEaOAvMqIUp90Q1+SOxv4iGYySto8aVOD3vO7GEqKnKMhFUlO3Wx7yDu+aN9tmUpGIdSdwSVTxq1CcikBKNtCAx4UpZ+Y5mLO1mbSQh0bgH9mOl29B5p2GtVfDj8OzQJXXjWAMpfKybvF4eVvzDAUUIrbcg1/TNus9DnrjTnZeyTpuD1h5K3IYqMk1BnX7222EYiuLpOkbwW53eNZgK0EhnN3LNMxXjaPUm1Fjsga6SUqwcBNqXTlyV6CK9f1ysrGFt1L0kI2ZtYenB2Ikzc3qXdqHAddrw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1VtNTJ2TjNTT21KMVRucThQRHlwSmI2ajFOdDdjdWZnMzd1ZHlQaXFGRkxD?=
 =?utf-8?B?Uk1TZ1gySldRLzBoYlVVL2h1QUVhOENtVFFXS1pYMUt6Z0syOFhUNmw3eVRT?=
 =?utf-8?B?T3RaSGJoZTUzNnVzaXZwYURGSWxWMXhwOFlZNmgxRnZ0ejVSdEZoS1JzVkdx?=
 =?utf-8?B?eXJQaFR4TW1OdHIyaWZGRW1LZ2JtdG9DUHFEeFA4TWYvUEhGZEpQd3VTbnBG?=
 =?utf-8?B?cU9ZeEVXOVQrK3pWc1RuazBqeDhvcmxScTc3anI5QkpIUUdGSTF3Rks4eU53?=
 =?utf-8?B?TThBQTJUbVhQQ3FBK3dpWGxBdHZPYmxidlNMNlFrcklBaFlyY21xRGxTdWlH?=
 =?utf-8?B?RE9vOExBVmFtN2duaElCOCtlOWlEajZVR3ZIQUt1cjgwMG5oSlVGa0FzZE54?=
 =?utf-8?B?STNHb3p0RmkzWTJGRzZLUGh6Q29FcDcrVXhqak00akZPcVRvVlRDalUzQkVo?=
 =?utf-8?B?aU1QYWNtQjZhS2NxZm1XdVZCNWdTYzhOdWxrRmJlK0JVaDI4dkxJd0JpZ0FR?=
 =?utf-8?B?Si84RG5xMkZ2aGhWejhUNXF2M0dCazNlSVh4NDgvUWZxanBJaml2QjlGZkZU?=
 =?utf-8?B?bXRvdTJKakk2Tmc0azBGbEVUWnVUTEYwZlNhMUVvK1I3d2N0YXhSWVV1cTVO?=
 =?utf-8?B?ZzVYODZpbVNmaXZRODMwc0daenJIVjFhSngybzl4QlkwQllKVWNJSzBubGxs?=
 =?utf-8?B?VjgzMW5OVXRXblhTcTFVN2ZvbWcrNWN3cm9JV0dKYnpZS3gzcEZPaENkOFZh?=
 =?utf-8?B?eWlscCtrUXNKZm1KUWVqeStkTStKMkNOOVZpd0RIUFdFci9WcWFVT2g3cVBZ?=
 =?utf-8?B?MzJoYWtXYkZYRm1ONGdRVXJnbTFGQ1l6SnRjdnJUNUcyVUF1VDZqWmx0dGpT?=
 =?utf-8?B?dkl0UzdzVjJYYllROE1xaEkrSnRDTTh5L0UvZUNiSVdIc2RDU2toWVdYczlC?=
 =?utf-8?B?cDYreGpMUnFDS3lPYU1SRjJXbjlaQ0Q5Z2xGUk1lYW9pa2NzcnZGUC8vT1FP?=
 =?utf-8?B?MlYyRWprMFQ5OGR0b2FDeXovS1JyOWF4NlZBeDZaaFVGaCtaVzg1akFTSnhq?=
 =?utf-8?B?dVVSVEtwdzBtWlRxa05WT3dQRFg2WTdGcTlhdm9hZ202elNwZm4yUitDdzJH?=
 =?utf-8?B?dUZNcmZ0b3Zxc3AxbTZYZllNZWVPcHRNenJ3ZUVXWktIaXFaNG9JTWM5RUNr?=
 =?utf-8?B?Nmxjc2ZVclNNdGZiU3gwY0JFZkN4MXN1azAwa0VtMVR6Tmo1M2FyTW9SeXBy?=
 =?utf-8?B?OHdmR25HbHI3M1ZuZStuQXFrQUwwT0xLaWdTaVNLajJvMWxvMzNPcmEwR1VK?=
 =?utf-8?B?ajlLdmNibEJsYWlUcWpxMHgyeDlnV2pQMHhqYjVWL1VJeTFMNzRBVXNBMHJz?=
 =?utf-8?B?N3NVbFcwKzVHNmdRNTBwK3E0blBscG9qckpFTHZRSlUwcjBsYWhRS202ZFdv?=
 =?utf-8?B?RlFEY0FISGZXdk85YnFCbUt5SVFYcVZudEl1QVFxSCtEMlc2ZWxiUTVDODBC?=
 =?utf-8?B?NjhlMUtPN0tlRFkxSnphbDNyMHRpeXhybURNUmIxb0t4eFRGRlJWWFJxdnBY?=
 =?utf-8?B?M3BXWS94eWpISzFGQWVLY3BzWWlwL043RTA1V3Z3S3lwdGZtQmJCQUo0bEUr?=
 =?utf-8?B?WmN4cmtVOFdJT2x3emtXczhZbjhSZWhsL2loanhSQUN5RTZ6NkdIbCtGd1BU?=
 =?utf-8?B?WUFyNUFTWXF5VEU3RithMW1pczRNSW9Ua0RYNklDQ0NuK21LTmFlNktXZHBz?=
 =?utf-8?B?UmF2cC94cWFsUjR0elRPcS9QeC8zaFcydG9lbnBsSUtjVHdWY1RKRG4wZjky?=
 =?utf-8?B?QzRnZXQyZkJIeW1GemloaHBZREZxZjkzb3QveFVzbnJBMHphYXVuenhHbDJN?=
 =?utf-8?B?SG43RHlHaTV2L3BPWjdVNnc0TGd6RDRrZnhaRWo0Tm5QaFJiYXlycnZuVmJB?=
 =?utf-8?B?SVFrY0oraDJaaDM3cGtmQmJUaXhKaVQ3bklRVUorUjFWKzhuSXcvaVp4UWFz?=
 =?utf-8?B?WmNudm5RY0MzYzZKeUg1NUJTeUxmRm51NGNhaE5rbWJJazRtd2xvQ2xLOTgw?=
 =?utf-8?B?REwyZE5XOElRZDdXcDVwa0VuZzdTTEVWSDYxTlRzMWgyTll4STBabzBHUy80?=
 =?utf-8?Q?G4CUAoCS81sykOGH1e1xR+HG8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c65426-ec2c-481f-471e-08dc39132555
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 10:42:37.6883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTqVV8xQC0j8FLO5Kx9guaB3Xdd9V5eklZ2b5ZSDw0usymBjralwPWZaeJdprzBgF130OHzfdzfeCCWwbma1Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735


On 2/29/2024 3:16 PM, Mathias Nyman wrote:
> On 26.2.2024 17.28, Basavaraj Natikar wrote:
>> The AMD USB host controller (1022:43f7) does not enter PCI D3 by default
>> when nothing is connected. This is due to the policy introduced by
>> 'commit a611bf473d1f ("xhci-pci: Set runtime PM as default policy on all
>> xHC 1.2 or later devices")', which only covers 1.2 or later devices.
>
> This makes it seem like commit a611bf473d1 somehow restricted default
> runtime
> PM when in fact it enabled it for all xHCI 1.2 hosts.
>
> Before that only a few selected ones had runtime PM enabled by default.
>
> How about something like:
>
> Enable runtime PM by default for older AMD 1022:43f7 xHCI 1.1 host as
> it is
> proven to work.
> Driver enables runtime PM by default for newer xHCI 1.2 host.

Thank you for the rewording. I will change accordingly.

>
>>
>> Therefore, by default, allow RPM on the AMD USB controller [1022:43f7].
>>
>> Fixes: 4baf12181509 ("xhci: Loosen RPM as default policy to cover for
>> AMD xHC 1.1")
>
> This was already reverted as it caused regression on some systems.
> 24be0b3c4059 Revert "xhci: Loosen RPM as default policy to cover for
> AMD xHC 1.1"
>
>> Link: https://lore.kernel.org/all/12335218.O9o76ZdvQC@natalenko.name/
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> Cc: stable@vger.kernel.org
>
> I'd skip Fixes and stable tags and add this as a feature to usb-next.

Sure, I will remove the above Fixes and Cc tag in the v3 patch.

>
>> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
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
>
> This would fit better earlier in the code among the rest of the AMD
> quirks.
> See how this flag is set for some other hosts.

Sure, I will make the necessary changes accordingly and send v3.

Thanks,
--
Basavaraj

>
> Thanks
> Mathias
>


