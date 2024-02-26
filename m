Return-Path: <stable+bounces-23728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 153C3867AB6
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 16:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342641C23491
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 15:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E342E12C53A;
	Mon, 26 Feb 2024 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YHDErRkc"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF6412BF05;
	Mon, 26 Feb 2024 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962568; cv=fail; b=pHkFvwuMAQzp2hbghx+F5nKoAhXJpXFaUAlYUnygrHX3tMq+ait+gKTKn7aQRO45FWZHDzxV0hKei8Vs8/AKxAHL1b7B+qZQvQ11fioQU8OFxn8BsYBCXr7gkuLRS6GF/VVsNQse1EtgYbUJV+ZBm/H4ulfPgsaMe0y7hszLtz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962568; c=relaxed/simple;
	bh=zxb7ZlRMY1DPfveOJvuK2cphwGRkMRUARsW/0Z2w/OU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gQ7oK5IO4GBTP3feqarUg6Wxn3xeE1rpHBVgztDibzbCdns4j9/6HcXpHYuBiTX6rBShj6E7frlg5VUR0Mt0Ol4+w9ifqtnmVOGqgw9KgQEZW4JJBq53LokoJ+PI/gBTHpvvbL/lnG5JT7mvznQQ2BeBDQ8UQkmsGPWfQc0LiWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YHDErRkc; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXTtZbwJyn99M1y3Nw0tffMBc2Z2hqr2WfIkG4vpej9iGWjT2x3NmpxDMM8exbO8t7rchM8zaPcO0YYl3R2XXApvWmpIUNV5/aukMeNYO2XKo6aoUCWq4jy9EB1XcRRytJrAbpZGAhGXdNQQw4r6sekf5lzqzzGNrhp8MSPAVTmmbntVkB2rc3m80A1HQmOpSMreBugj9PRtdTe6wlRGhcAHKpRiJ/dDCKAjYiT7kIZHjUXiyPmIvQJ19Tha2l5qk4dA1Vvr8cE0lNURVOc561tM7RYg+Z3hDJK/43QA7G0g5TM5Qf11F/myZYmZ4GpHg/q7UOCzEf4G7KJJoOt8xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9p8sJ/1sYCRh27DGMjwk+y9wRM9zmXp829iMsdmpX14=;
 b=ZL7kRcoLgTznrUhmWRQ9H/U4BHRQHoBPdrXw6H7YJsTcueqfzR5Q2zeX2L/ovrqT6BG+oMr6TH3S8ytD4ZN4qz5ZzXl8cvttsIvXLvty7ajycpMr+DQsjXIjx2Dpa9x1YrTmxg19qbB1QkdipJv+YmBC5mTo1/YJu8DonvKC7sxSw5g5Cnh6+1Af8nzptkZRSgtY9DuovWnoGJTZQEhHn2S9loiIYjR3yv8eUttopfFpWoMy8o3GOgz//E/BnP2EaW73wbvWtUBv0WV15hngn7fHTBNNbeWKBtsHzUSGWABD1/q1lzEWe/371hzBifJRw0BZXuikcuAFQeN2xhuGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9p8sJ/1sYCRh27DGMjwk+y9wRM9zmXp829iMsdmpX14=;
 b=YHDErRkc+5yQlsDWeqUku6RbnHO3JDry8/ceQrTkgv714IrLnNryyvHZmJkfbvf342meYn5PG1BUU8ookjnpv6NCQv+FgQthEVb70JyqcT7mS2rxvb8q3Ss7nJ3GiMmRdUQ80Diz60HE5Wc4zkkZd73uWmQ9CvGn7ILwEP1WJf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.33; Mon, 26 Feb 2024 15:49:24 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::f295:e439:73a8:c57a]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::f295:e439:73a8:c57a%5]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 15:49:24 +0000
Message-ID: <946643d3-5498-4f8e-bfd7-6317852b77e9@amd.com>
Date: Mon, 26 Feb 2024 09:49:22 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xhci: Allow RPM on the USB controller (1022:43f7) by
 default
Content-Language: en-US
To: Basavaraj Natikar <bnatikar@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, gregkh@linuxfoundation.org,
 mathias.nyman@intel.com, linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org, Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20240226152831.2147932-1-Basavaraj.Natikar@amd.com>
 <4bb05f8b-051b-45b8-9f3b-14cc30812fe5@amd.com>
 <b5523bdc-3516-40a0-84fe-9cd6a315eb89@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <b5523bdc-3516-40a0-84fe-9cd6a315eb89@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:805:66::41) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: e9523ca9-02ff-4201-dbde-08dc36e281a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IanrkY5nPpkFbqJdpzjXRgOp0AuU2w3XGAckjjTPbjAKGiv1XsT1CwkZNjCoqwCDrSw1AAMzMZ0XRxZXeQ4jb6WDz/SW22KvpP0G9j9Cw41Vxhr7MFpR/0M/fl9N847i/uyfR7Uv8dIfMnIl3GXzJdbwwCuccCHLAgZlDG+I46iZREbowv3jvV9qulPuWKevbRarIJX9sspzsj1mTQ4kU6IqPwFlH5T2RNG3rGqR2JF44nUfNv5XEPaRPf71Hcovb1q4k2tR5Rj39cyDWL36vlrFxL/klwhKT34b+EQ76zhaBjg4BQOiokxKnUVEU6bXbq9B1nQLg0FM3gh1zHR+JX+Oj7RJCNsl5UtgFC1JoF/VfE+bGi064Kc/21OtCNXGnOWBmIGO/4BQ28gdSR7Dw6ak+WmF+l+BOOdaqJHjrtkd3A0gpf3+W1Vih3oubZLSMkmMKZyvaWsw5ImUQbIwTdzmlCLz8zCZ3Ta5OqLrlhBFlJENBqEZ+vvBGsZdXvW3nbzJvwvis5pjgo9jDhn2g/plJo8v8OooHb4JjMAT+OTeV+l0kqTwBEambCxGsDGaxgE4LIp2m4M99on8VK1c1qP2VpF0vCbBleg8tgBwZ1WWN1Vrpu9o1+aLRwOUHonY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eklZNHEzWmsxczRTUklMUW80Y042d0wySE15Y1YvRVd6WmZOMFdqOFpXakVm?=
 =?utf-8?B?N05aWmh2eXlreVkzWTltejMxbCtVS2d0QTh3L0s4WUpmbVNEelR6a1NkTGxh?=
 =?utf-8?B?QlNVdzlha1dQQnM5cUcrV2poNDlLdGlKZFFWcTF0cHVvSDNsMXNMc25rRmY3?=
 =?utf-8?B?dWhRYmJONEVIWDVtdDEyaGE2b2hCc0F5YUlZa2E4V3ZmckRXYjVtWDk5eGox?=
 =?utf-8?B?MjEzazZHelR6SXJKMEI2elFBTjQ2cnRmcEJRT21Cajk5c2owam1UQ2FJKzFx?=
 =?utf-8?B?WTlkTWF4TzgxMDQ0QThXRG43ZjVVVGNJalpjK1pJTHNYYWZ3aFcvU1I0WGpw?=
 =?utf-8?B?RzZXOUtSYUFhNE1zd2hzd0xGY1JldlM5ek5lb1pWODZXSWxSRlROaXVBSDd1?=
 =?utf-8?B?ZDRnZG9qeGIxc2ZFUXZ2RDRsQVNVcVBWaUtZSW1YazRhcHJVandvcjdBQm9I?=
 =?utf-8?B?RlFHUlc5OTNQb3dSSTdjU1BLS2ZCdFNvZkY2OXg5ZXpxQllmdjRScFJVNDdD?=
 =?utf-8?B?TUtONHdGcCtrSTFmNXpDS2F6a2NENFI4dTJURUNMZkRzcVVjZUFnV3FZSWZr?=
 =?utf-8?B?M2JTUlVQUDFqMUdHUS9DSm9CUTJ1eXUwN1Zxa1lWU3pkeXdGK01jTlV5Rkt2?=
 =?utf-8?B?K2pMR2hpQVlvQ2xHdGxIKzBHVG50WFdqRzhGYmFQeExLb2RjQVhhb0pZTEVn?=
 =?utf-8?B?R3ZoKzhQcEdpTTg0R0Q2dnBFRmNEcXhSSnlXcG93MTN5NmVXRjNZeFpHVlYx?=
 =?utf-8?B?dGRBWkFxeldtcVUzQ1UxWW5IUkNQNWtMMkgzNWdiNzluZTBhZ2w3RnZNcUpH?=
 =?utf-8?B?dWVLK1Z5TGVjME5hMWFLdWZUeVBIcUlSSk41aUt0d29HWTdySE55NHVyQkFo?=
 =?utf-8?B?NVcxTFI3Umc0bnJrb2lnSlEvQlZXMXFlNnpRb2lkeXJCQVhmeDZoS2hiTWRU?=
 =?utf-8?B?YW9JMnpzNmNEZmVZZEREN0J3NkRYK1hwVEt1dVMwZ1hvblIvNmt0bnpKV21t?=
 =?utf-8?B?UkR3YzQrMGhUTWduQkU0aSt4aU9aWm50WmdEU01ObFhMRHk1NHVUcnpOb0Fs?=
 =?utf-8?B?d3lpY0VuUjJka0tML0FWZXg2Z2xMOGdZYzZTN2w0cFNRQzFleVMyVzRNZTFv?=
 =?utf-8?B?cUozY29VV01Kc2xLaGhZbjYydmc1enFwMVdGa2N0RUF1Q08zOFJTRlR4NzN3?=
 =?utf-8?B?UFN5RnZqME5JalBaeFBVYmhqdmw0SUNQQlJQU0djMU5zWmE4WUxrZXFLVHNF?=
 =?utf-8?B?Q0FHZTJkV2tHRUQ0ai9YR0FPdnRCaXBnQTVqSmpFdlUvMGYybzg5WXhKUG1a?=
 =?utf-8?B?d0pyRWlyaldtSUtRenpUaGd1MHRNOERJTGVzUU94RDZzdFFaSSt5QW9uUUpK?=
 =?utf-8?B?SHdUSUNyYStHNlE3eFhpZHhJK3hsTm5VUVZyK0RhSnoyenBMdGpOYkprcFpM?=
 =?utf-8?B?Z2NkNW13ZWJpYy96eXE1K1lNU3JSelZiZUVxbXFVV2hmbmM0THp5YlNQdzJ6?=
 =?utf-8?B?cytXQVBPcWFsMDFUV1ZyRWlGZDZGTEF4K3V5ZVRjazFJcldHUE53bUFJQ2NN?=
 =?utf-8?B?dVZ1WlRtVXk3bzRVTHVMNFNOSmxRQVNJemh3RjdkTUQ1SGZuRlkxcWF0RHhL?=
 =?utf-8?B?eVk3S2NWVktkQkRnU0JWcFhYcjZwLzhOZTdQY0xpc1ZUZCsydTJsVlpFZnhv?=
 =?utf-8?B?dGNWOHBZTjdtYlgvNWF3VER5dGVRR1N6R2hZYUJuSmlyWVR3L1daNE1ZZThi?=
 =?utf-8?B?ZCs1ei83dEtFenBLSDlsaUpMKzdJdnZLS2NmNkFWWGVTc0tMME9LdDNaZ1Fy?=
 =?utf-8?B?eFU3Qml1c0MyT0JVSEY2U1J0WTFzcDRhSDFLM25NVlFMd1JqWitSOENkOEJV?=
 =?utf-8?B?TFljNytWRnV2eDJ0YVJjNTVDMnlHY3RBb2hUUGwzbkVTSy91MGtwNnYzbGZo?=
 =?utf-8?B?OEhVRkYrZERzdXNtNnplYk13U1hqek5xUHlHUFZDbm0vZWJ5U3hxMDMwa2gr?=
 =?utf-8?B?Q2N6MlRwMTZ5czBlbDdtdFoySWN6Q3dPVVZRQWQxS2xINitWcTNNK0QvZlN2?=
 =?utf-8?B?ZWw3aUNhSER6MDZTY0VmTGdJUis0S3J2aG8zS0tXZkZFMkE1MjJnbDdVUnZs?=
 =?utf-8?Q?LlkUejQmnmX3ys0yboQAm5pCv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9523ca9-02ff-4201-dbde-08dc36e281a3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 15:49:24.6612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RI7gDhJFyy4GZSSm+WTUYM6XFfv/uFHb26ORr3/LtTdRTRvOpKyZtXOTLCq3/YVyCzD6+xitnG3hyUHGLk4FqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763

On 2/26/2024 09:37, Basavaraj Natikar wrote:
> 
> On 2/26/2024 9:02 PM, Mario Limonciello wrote:
>> On 2/26/2024 09:28, Basavaraj Natikar wrote:
>>> The AMD USB host controller (1022:43f7) does not enter PCI D3 by default
>>> when nothing is connected. This is due to the policy introduced by
>>> 'commit a611bf473d1f ("xhci-pci: Set runtime PM as default policy on all
>>> xHC 1.2 or later devices")', which only covers 1.2 or later devices.
>>>
>>> Therefore, by default, allow RPM on the AMD USB controller [1022:43f7].
>>>
>>> Fixes: 4baf12181509 ("xhci: Loosen RPM as default policy to cover for
>>> AMD xHC 1.1")
>>> Link: https://lore.kernel.org/all/12335218.O9o76ZdvQC@natalenko.name/
>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>>> Cc: stable@vger.kernel.org
>>> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
>>
>> Does Oleksandr's testing actually apply here?  This is a totally
>> different patch and system isn't it?
> 
> This patch is added in https://lore.kernel.org/all/12335218.O9o76ZdvQC@natalenko.name/
> 
> And he mentioned in link https://lore.kernel.org/all/12335218.O9o76ZdvQC@natalenko.name/
> to add Tested-by
> 
Ah got it, thanks.

> Thanks,
> --
> Basavaraj
> 
>>
>>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>>> ---
>>> Changes in v2:
>>>      - Added Cc: stable@vger.kernel.org
>>>
>>>    drivers/usb/host/xhci-pci.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>>> index b534ca9752be..1eb7a41a75d7 100644
>>> --- a/drivers/usb/host/xhci-pci.c
>>> +++ b/drivers/usb/host/xhci-pci.c
>>> @@ -473,6 +473,8 @@ static void xhci_pci_quirks(struct device *dev,
>>> struct xhci_hcd *xhci)
>>>        /* xHC spec requires PCI devices to support D3hot and D3cold */
>>>        if (xhci->hci_version >= 0x120)
>>>            xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
>>> +    else if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device ==
>>> 0x43f7)
>>> +        xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
>>>          if (xhci->quirks & XHCI_RESET_ON_RESUME)
>>>            xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
>>
> 


