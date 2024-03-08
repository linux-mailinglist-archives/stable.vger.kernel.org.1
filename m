Return-Path: <stable+bounces-27132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8998875E16
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 08:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3591C20FD3
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 07:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413E64EB29;
	Fri,  8 Mar 2024 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kFYP3BZh"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEA0441F;
	Fri,  8 Mar 2024 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709881315; cv=fail; b=cCFRzzI0MjslErDBA2+EhWoBeYEX+yUmuGj7mLMUwXw36UixU/Xfyap4m6Y3VrvmENQgi91wfyZH7FT2jp/HwlHlWmUVWkRZBu6LuInQ/Cd9A1WuyWQi31Qlqg5oQuUjLKLRBsUNCJqXtNPwJb1iVd/mnRr1/Lk0GRZFBMS7jYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709881315; c=relaxed/simple;
	bh=OfZ5rWYSryMLRRWv82fhDUAjNW87wTAlHAt9A/YLxyI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VS5QIxdoFXp7ynaYII5sTiBsaKB3XXkFkDrvi6Cg+pf8t6b2AjOG/L0v0V/65oRUEjhMyz8LGVRV3HHB9OcFUOmYzU/khYop1uCKlB29tawFVO1fQJP/2vMNErkn6AmSjLJFSOwq7132XiaPfLbTSRgSsPuUNv2b2CqMK3hp8Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kFYP3BZh; arc=fail smtp.client-ip=40.107.212.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDBUk8wtkrNMRLXjzwYz9a7F1ACBaiZhMJ96des203vIPx7wljbqUJxHOd4S+wLna/OhYkDXme21+vx3/g3GgNrt1xT31NhTIfLMIhMyhmxVDuKo0ZfGpaPDObJ3MXiGVBaXT9FAFwDuQ6Q1qCjT5UnmW1nnihkKTaAkXtE1gQC7/UhVaICr4Ho7B+HyJku2WDJcDjPGVbKruQflwzcr5D2trk8Ktm6U/8KXkfD0j36VvfGcaOKUZHvBggHM0eSuUVIpd6EeLUV6y/oJIlAKZCoX1lg8f1VSwJlGfzxWW/4N/O5OfI9FCs8LKdNSD3ttEY/SN81werM8bJD/GZvZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoVbIc122meiGXH/WDpuy6l0c77j8opqBRE2Oa7E4RU=;
 b=ILxS8jgozHYDZMUCwjUyWi8XWnLqRmXU7BGrN2KCdZGPOQ9AMMrH1EWxeGVmZ500d3DoXA8OeE17QuX6RuHfJ1jXcL/bf+hSZ8Cs9NzkwW98K+t91h3Xa1DYCvSkhlQvKD+TSGrWPm6rfdKzDLIdzKG7+IyELI/MfJb4n6swauWSRhwV82kGiEfIPx0plxeuo1tN/S4PQ508Su/L7mf+ExNofnePaVtcHe6XaE2aPqNodBtZXPOJ4SYe8nrgc31+76fX97OQwlmAlHebYTIdw3bc9sH0R49nuaUtQlvVJefoUmA5VpsfJ5gpGRJRJiC8UCweOK2jFt8Oc0JnbQuFFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoVbIc122meiGXH/WDpuy6l0c77j8opqBRE2Oa7E4RU=;
 b=kFYP3BZh0APuL6p+ml8zcmOQRUSahOI0VYBRc4GR/orvMzJdJOGWqghT6ANcJNiV7EZqkKEgtcf9pN5BEHT2w3tPT5DStnCpMhKkK/6CTNPNG0ZD5sH/T/nxkMbFTxvwYNsBOoHoreHgMycjHYEj0iwNfMVNRT0A0ob0JmmFG0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Fri, 8 Mar
 2024 07:01:50 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::fb99:3ce2:7a26:e36]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::fb99:3ce2:7a26:e36%2]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 07:01:49 +0000
Message-ID: <ecf5c9e8-4ef6-34d0-824b-a5dcf66cc0c6@amd.com>
Date: Fri, 8 Mar 2024 12:31:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] usb: dwc3: Properly set system wakeup
Content-Language: en-US
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: John Youn <John.Youn@synopsys.com>,
 "Guilherme G.Piccoli" <gpiccoli@igalia.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <667cfda7009b502e08462c8fb3f65841d103cc0a.1709865476.git.Thinh.Nguyen@synopsys.com>
From: Sanath S <sanaths2@amd.com>
In-Reply-To: <667cfda7009b502e08462c8fb3f65841d103cc0a.1709865476.git.Thinh.Nguyen@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::10) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|BL1PR12MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 592aa5f9-12f4-40aa-2ddc-08dc3f3da063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pKOi8il6CT/hNKJSrAmUL8iUC2xCv1fGUIlmY//pEAwJRPnCNe46kOsRu8gPahxwxbdALO/bz2R7cBiY5oijZ++htcjvqAT2V2cQbPaO7UOlirPKxBy4Zl3uC+7aUF9mV9OESbLYpKYDzrn8pQhNEV0eznm2RQoocSozQKx7h831jNmSNSBl7GZPa1WO1sPyZvFqHeFe6z5mLtO/35TRikxt4GUhFkoAWywEYVCyJVS5VioxJt7HKk2s8MqnGwceAuRB2yLOMAOdvSSv3f3MMbOvGeVcPMx8aKZCbNMxNY7kt4zrysgltgVFPfTmyS82D6EfeYY3DKGKmyqXgsylkyBFV7heqeEv2TjWw6tojaka1mVGPHmrdHlmcpYO0d/p1mKTaptNMKHTOZwUlSsYqLOBL7PnjOyWKbvjhXknRnxyb1ltGgwuJftuUJjtyu7bKOuuBVmgTNmy/I/1sCxH2d9YbrMtJH5d5j3GUj6ObQtpGAbAf9pJuqEKBrFhOIP/19gCBx9lqgtmmdvgPXEFFc2IyhmdJ1Jmy+Ykm7tL0FimJ3/AJubiAbyRGBR0Sj3E1B+Yc8dcVrXLgF0t0WO0TSBgf35/LeN20ALw5qsrZOU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2Z5aDBKekpFVERhbFV0NlVVWFB3Z1BmejFjNHNaeC8xYXVYS2xTRWxVWkww?=
 =?utf-8?B?SzM2dTRCL2cwMmFCT09iZFE2cTBSSkFZQmMvK044cWNXZGViOEt5ZTBneFhG?=
 =?utf-8?B?dXkvcG1mY1RJYW0wdVE4OW4yWmg4L3Nqa3JQdXB2dmhxamFwZGFUbWxEdytu?=
 =?utf-8?B?ZWpOZ1RCMDVrK1pxRkJjZ2JYRm5LQUh5OGNyZ3daVkFwQ2h3S20zZ2IyQi9x?=
 =?utf-8?B?N3JSYnd4UFRPc1BueWtSdGsvWkI5VU5Yb2VYdVF3QStXVjgxVjIrcFQ0MWtE?=
 =?utf-8?B?MFlHZndkZ3oyOTFVREtXWTJoNlVSSVhFekRYK3dwQUtoS2lhWWg2SytNTU1v?=
 =?utf-8?B?b3RHSVdrMjVYOHRyNVJpNTJCaTBUUDBNQ0FpTVhmTmxhZERSUkEvL1FLUUxp?=
 =?utf-8?B?RzNHMUQ5bkZLam4wOC9oV3FLYytsRDhOZ201QVVVOU8wQWJYZkx5LzV2bjJo?=
 =?utf-8?B?UndGcVN0Ykx3T3ZYbitFRmw0YmNQaFlycUhySVZ4eFZ0K3ZrcHNPYTkrVy9q?=
 =?utf-8?B?SFNwQlZnQWtTc1BzYWxsMlE4Tnljd1duYm16V1pTcFluL3VBSGMwd3p5ZzVM?=
 =?utf-8?B?VlZyS3grenMvcHJacUQ2SlRtelZzZTlGeXV4WVZVV3ZCUEgzWDR0NzY2K1N5?=
 =?utf-8?B?MzMrR2wrZkxPNHB3cC9XeVVBRjFUN21VWjN0NlNnTVd2Zk5vTkNsZ1dyV2FG?=
 =?utf-8?B?Z2JhMHlsT1VqOStXZGVHeGRES05RR25FNHcwTGhlL2pZYkFpUEI3UjlKVHpp?=
 =?utf-8?B?a2V4QzJ2a2NnK2o5c05vNFUzeW1WcnlCNmVvYUZXM0xabjBhYjgzOUJqeVpu?=
 =?utf-8?B?Qmx4QnFEbEtka0JNanNJdWlCZHJURjBobHZLa3AzY0dQU2VydmVZYlhDdTFy?=
 =?utf-8?B?bC9IVHZLUjJDbE5NYUFzei9DdHFWUFd5UUdYenlvSGUwcmNGbmZkbG5WSWZv?=
 =?utf-8?B?RmhXNTB2bFpFSWR5MGtlL0RaNklIenpUTTFUNzNENEI4WHZvVWN3WTVkK0k4?=
 =?utf-8?B?VnlaYU84NkFsS3UxRE1BUVZMenZidHZLZ0JvaE5NOHhFNkxmMnlRQzc2TUNF?=
 =?utf-8?B?R3l2M1VKU2czZk1mS2R6Tm5FTUMwQUVPMUI1dE9LcWpXNlQ1REJnZFZERmla?=
 =?utf-8?B?ZVpnZXlleDZCaWYzeFEvbVBSd1RXakpKUTVha3VGNE50S2N6ai9ZcE9xNnJL?=
 =?utf-8?B?b1ovdjJpRGs0SEpTUWJ2b0xmQTZ1Ym8xWmhOVU5KRTB1OUROMlU4VERpQXRT?=
 =?utf-8?B?clJQV3UxQk9xWnpwY1lRQkkvdlNOTGQxOU9HcUdDVFJIc0Q4dTNCUFlENnVF?=
 =?utf-8?B?S0NINnl2UTFnTEMya2tISEZTb0ptbXd0bFJlNFZOWDkzckQxcUlOczFHZXF3?=
 =?utf-8?B?cGlETXBONmF2NS9HT1JBTSt6MjRlQ1M2ZjA1SHlzZCs1RkQyYUVCMThTUW9O?=
 =?utf-8?B?djNFY1pQQThwM3oyS2RuOHFpeGVVV0tTcEpmVExBR0R6cmYyQzR6WXFYQ2NT?=
 =?utf-8?B?cHFXcm40QzR0VEozQjU1cEZFODZOT0xkNFovYUR6ejNjaGxaRFhnckNGem1l?=
 =?utf-8?B?NXVkaThhYVBtZEZ0a3F2bm5teVUzTzZZQXN2NzlxRzFjUkFHLzRad1RvUkVz?=
 =?utf-8?B?b2dNZkc0NXN0WFRQcWl0SHQ4elZLaUFzQjVvSjVxOUg4c0t2aS9JcnpReUNz?=
 =?utf-8?B?RzMvK2ErbEg1blZDVUZUUEJoN2E0ZUhnODJPcGhZYmpSQVRsanROMWc0U3RH?=
 =?utf-8?B?NVJ4NFBPT01jcEorcU1rbUJwMm9hQytCNFdUVC9EeXNSdWRpQ0xROXNHaEtH?=
 =?utf-8?B?djlScDBOM1VUTmxLZTVoTlVqWmZnSU9sY2VkcWFLUi93Vmx6SmtPYnZVQ0dt?=
 =?utf-8?B?VWt2cjNyT2hCeGdvV0V6ZXdaVWxja1pQc2Y5SHdYT0ZGQW1haUxTWW04NmJB?=
 =?utf-8?B?WGNzWGRWNXVkUHRuWkp6VlVhdU9Wa0szS09KdWIxUHhBdVJyMWw1d1BPR0tr?=
 =?utf-8?B?THZnT1VlWmEzRlRYR0loWWozL1lCYVdVaDFJN0doaGM3Qk85MnNuS1I4TnNo?=
 =?utf-8?B?aEtxZkNzVGtjcGhnNzVsaDRaS1FpRXljbjZqK2lWU0FzdjdoaUlQcTN0aG4v?=
 =?utf-8?Q?lwCrg0a1moc3nTws/9nyqs+PF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592aa5f9-12f4-40aa-2ddc-08dc3f3da063
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 07:01:49.9078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDPUGp2GGRyI/rqjmpeN0C39RP4RRTH2RbXIVmRXdXnBUzJ8xS1/mSxcY36qWgLNEx0DbljZH1CcTAkwHVs/Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778


On 3/8/2024 8:10 AM, Thinh Nguyen wrote:
> If the device is configured for system wakeup, then make sure that the
> xHCI driver knows about it and make sure to permit wakeup only at the
> appropriate time.
>
> For host mode, if the controller goes through the dwc3 code path, then a
> child xHCI platform device is created. Make sure the platform device
> also inherits the wakeup setting for xHCI to enable remote wakeup.
>
> For device mode, make sure to disable system wakeup if no gadget driver
> is bound. We may experience unwanted system wakeup due to the wakeup
> signal from the controller PMU detecting connection/disconnection when
> in low power (D3). E.g. In the case of Steam Deck, the PCI PME prevents
> the system staying in suspend.
We were chasing down same issue at our end and found this patch to be 
helpful.
Tested on both host and device mode. Patch is working as expected.

Please feel free to add my tag
Tested-by: Sanath S <Sanath.S@amd.com>
> Cc: stable@vger.kernel.org
> Reported-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Closes: https://lore.kernel.org/linux-usb/70a7692d-647c-9be7-00a6-06fc60f77294@igalia.com/T/#mf00d6669c2eff7b308d1162acd1d66c09f0853c7
> Fixes: d07e8819a03d ("usb: dwc3: add xHCI Host support")
> Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> ---
>   drivers/usb/dwc3/core.c   |  2 ++
>   drivers/usb/dwc3/core.h   |  2 ++
>   drivers/usb/dwc3/gadget.c | 10 ++++++++++
>   drivers/usb/dwc3/host.c   | 11 +++++++++++
>   4 files changed, 25 insertions(+)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 3e55838c0001..31684cdaaae3 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1519,6 +1519,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>   	else
>   		dwc->sysdev = dwc->dev;
>   
> +	dwc->sys_wakeup = device_may_wakeup(dwc->sysdev);
> +
>   	ret = device_property_read_string(dev, "usb-psy-name", &usb_psy_name);
>   	if (ret >= 0) {
>   		dwc->usb_psy = power_supply_get_by_name(usb_psy_name);
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index e120611a5174..893b1e694efe 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1132,6 +1132,7 @@ struct dwc3_scratchpad_array {
>    *	3	- Reserved
>    * @dis_metastability_quirk: set to disable metastability quirk.
>    * @dis_split_quirk: set to disable split boundary.
> + * @sys_wakeup: set if the device may do system wakeup.
>    * @wakeup_configured: set if the device is configured for remote wakeup.
>    * @suspended: set to track suspend event due to U3/L2.
>    * @imod_interval: set the interrupt moderation interval in 250ns
> @@ -1355,6 +1356,7 @@ struct dwc3 {
>   
>   	unsigned		dis_split_quirk:1;
>   	unsigned		async_callbacks:1;
> +	unsigned		sys_wakeup:1;
>   	unsigned		wakeup_configured:1;
>   	unsigned		suspended:1;
>   
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 28f49400f3e8..07820b1a88a2 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2968,6 +2968,9 @@ static int dwc3_gadget_start(struct usb_gadget *g,
>   	dwc->gadget_driver	= driver;
>   	spin_unlock_irqrestore(&dwc->lock, flags);
>   
> +	if (dwc->sys_wakeup)
> +		device_wakeup_enable(dwc->sysdev);
> +
>   	return 0;
>   }
>   
> @@ -2983,6 +2986,9 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
>   	struct dwc3		*dwc = gadget_to_dwc(g);
>   	unsigned long		flags;
>   
> +	if (dwc->sys_wakeup)
> +		device_wakeup_disable(dwc->sysdev);
> +
>   	spin_lock_irqsave(&dwc->lock, flags);
>   	dwc->gadget_driver	= NULL;
>   	dwc->max_cfg_eps = 0;
> @@ -4664,6 +4670,10 @@ int dwc3_gadget_init(struct dwc3 *dwc)
>   	else
>   		dwc3_gadget_set_speed(dwc->gadget, dwc->maximum_speed);
>   
> +	/* No system wakeup if no gadget driver bound */
> +	if (dwc->sys_wakeup)
> +		device_wakeup_disable(dwc->sysdev);
> +
>   	return 0;
>   
>   err5:
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index 43230915323c..f6a020d77fa1 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -123,6 +123,14 @@ int dwc3_host_init(struct dwc3 *dwc)
>   		goto err;
>   	}
>   
> +	if (dwc->sys_wakeup) {
> +		/* Restore wakeup setting if switched from device */
> +		device_wakeup_enable(dwc->sysdev);
> +
> +		/* Pass on wakeup setting to the new xhci platform device */
> +		device_init_wakeup(&xhci->dev, true);
> +	}
> +
>   	return 0;
>   err:
>   	platform_device_put(xhci);
> @@ -131,6 +139,9 @@ int dwc3_host_init(struct dwc3 *dwc)
>   
>   void dwc3_host_exit(struct dwc3 *dwc)
>   {
> +	if (dwc->sys_wakeup)
> +		device_init_wakeup(&dwc->xhci->dev, false);
> +
>   	platform_device_unregister(dwc->xhci);
>   	dwc->xhci = NULL;
>   }
>
> base-commit: b234c70fefa7532d34ebee104de64cc16f1b21e4

