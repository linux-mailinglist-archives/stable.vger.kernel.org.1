Return-Path: <stable+bounces-240374-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INfsApAI6Wm1TQIAu9opvQ
	(envelope-from <stable+bounces-240374-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:42:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 633A5449508
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5F50302BE0A
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7067E327BFA;
	Wed, 22 Apr 2026 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p+yhe4yo"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013011.outbound.protection.outlook.com [40.107.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DA11FE451
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776879757; cv=fail; b=H5PynqNZTq6xS23kFrZk1LcoajW4njmxkTSlLD74C+nQzi5/R0d2E8DZlMmpVAdIyAiXnwxKp8ZU96Ej06WBonh2RqbaDmWnc5elUX2iCiQdKxKPKhi1m5129oumYs3GHl2Av8rFskM9CL8Zl7ex4B9Ts0K2LJgCch/FP9xsftY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776879757; c=relaxed/simple;
	bh=sM9qvSvm9MTxApAACDBIvbBBO4OeJgJhDSfR84boi0c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UamaJKucEUsPgtdzgT1LABJqGGYk6AbHr0DVamd4BHqVWxb4R0Wr95Mb8iyNarhmHpr8tYn5PW6ryduJpevbfp+NGyRdkYdczza1DaKoU397UwGZcITcRNq2w454ry/DljVzWRXo0nvN6ywXb3u5/PdcLpYgV0TagbHU1tRYpMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p+yhe4yo; arc=fail smtp.client-ip=40.107.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfbZ+gKardhYHiMmLweNXLsOJrlF8ViiFb2Sd4hsqMXwDPHJcmd3PaWzQhaBVy6jwKsxDK+xmJ5NPJ7SezKPMi7ODTkOgEVJksHr7taczVsA7ZV+bvnOjb6ctb3ld4m2iWHemD5eo+uHu0jNMBT6HBfqZ61why3pdMjfrJY1pv1shSnp2vxl9MjxelE6ar/EuO4yplZWmzU77GIyMQSzykvS6Dti7fxL5UgTuxArKUvtHIFCWi8aCGpZOobhqrdsOqCE8EMeDtJ+ta7kRjZfWBXZC7X0MuTxEUXTckT/L40q7hSFoexmwmCTmT2UYQHNh9bHEwCgq/WyLhCiOALdeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28pGvhyysYPI49VGce4rBVMGUaDqHbzlBf86LqLkG88=;
 b=cT8dRxXcHE3uSWKz/3utHzVV9d+sWNH6tYRqzxbhXaSSqL/CLq/5WBTd+vxi7RZOSeZ5t0TNeODG4mI+zEs6RNDABe1SnIMmFRbtt8/e5Lxq8jio3zCiKKAsEtbkfxCG8b/A5r0dCv2i/Fsa6ogm80VbDo3FzeOvr/srYw2vwPWsNS0/ejT9SwizTahZdd08VNV2lmlE9mz82NlxHWqJjKjR9JYUWpcjVr4dxDdF6z2+TnCwWsNEB4cqDbOXJ0vZ/gzO4oFcLSWlwiyTyOKfwuTJ9OBrzh6kw3mtNgr2T9VvYp5/ksB414wWUtOnSGz+gFwbsIOY9T4cjrKFDE5PKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28pGvhyysYPI49VGce4rBVMGUaDqHbzlBf86LqLkG88=;
 b=p+yhe4yoMhlFskyIrDOtdXlKgR5m7gTdPgqDMrBsHl+7KSRFBA3Nr10dyZ5dJSOsQX0laipOAiAQI5QefkUOwudsEHGBxs+8RjG1k24TJEtVDeQcjH9s92WfsXPuq7IB1ubUw9nTua+bznkVDy0Th8m3tEdMcbf1vBuVBGeSzMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 17:42:31 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 17:42:31 +0000
Message-ID: <78ef350e-b425-489d-8fd8-23df8a652e1a@amd.com>
Date: Wed, 22 Apr 2026 12:42:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs
Content-Language: en-US
To: Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com,
 Aurabindo.Pillai@amd.com, wiagn233@outlook.com, sysdadmin@m1k.cloud,
 stable@vger.kernel.org
References: <20260422162956.620362-1-sunpeng.li@amd.com>
 <CADnq5_OYNSoWteuXDJrCOtj4qYn2q+vyXUKZaHvgNN+5xFFg2Q@mail.gmail.com>
 <5b0ea1b1-40be-4941-b4cc-521a9fca8c09@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5b0ea1b1-40be-4941-b4cc-521a9fca8c09@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR05CA0050.namprd05.prod.outlook.com (2603:10b6:8:2f::9)
 To SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a9d087c-8494-421f-5cdb-08dea09687af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ViQvFmePmFoPlMrePJo5SwWP6OLkW1e/XYHwzP4y+R0UucHidBwBTfnN7NuA+5C7FEi6v9Mwh47d6m/usXQNkmLyLCcbHMcas4RMXNXmtA2K7v05sFVePB2400SRikZn3vjGHc3X2E4xqO5PINpjB6p+tMoFC6pYKDuNv2KUeERIw/+7+UKyQyQ9tl0iRm1tTnp0PJypaidgdyXaM39jcBSCU6Znk5e5kFFOII5daRJhpgQCJpfFURAhqV/PumuGbednUZB9ZjnQ+ov7CxwxN191xPuJTEmusSUQBE9PW/x2HFHm48rimDqS92uhRFSOhvAfWDTjhpy8Yxjt4rgR3P7kWHsrsYW2+liXzKfjFoXVgvNnVwnQxKfLfsKAjGkELAsTbZx+8tJe+BZ9UbpZSRsm8qLaamMQniun/ZFoqygfxdAGlIVA3j2P9mOhRBrJbjVGYriKSG5/acLAKifQuDHjQ/5VnqCJkUvg22gS7O9wJh/VEvdIRJsl8BVxa9yb5Gc4TYtDCpN7HBjqYzDsUCPh/EMyNAFvwtFZnm/kU08bho3Ae8acN2C9dJVhKXWil0DsoPXri3fhz448pG6+6IbzzbgjmDH+YEAq8rpsLFp4QkSQ41TJ1mD7xm7ildGqJGyDd+1VNld+hjZXdwhvGoet//j7t3F55AUzP5oTme070LhEP3OBksV+KR8IeIUX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHpuNUlPYWZGeFMyU3c4cG9Ed1IrYkg2TmE5eHZjWWdrWStlUnE0NWtzbmVL?=
 =?utf-8?B?T1hjK2xSMmxybzhuU0hRTVRrTEduVmhtV0pKb24zdE9wSi9udUFWRjNTckd0?=
 =?utf-8?B?azc0OUJnTWVyMUZ2SDlqVUlvRFUzQ00yR0gxUjVUSFJzbzFoL3lIa3VnMXQy?=
 =?utf-8?B?cERIdzBLOG56SlNrb0s1TlVnTjJPa2xsSDBCcHlhZ0lIanhxc3IrNTc0NkFW?=
 =?utf-8?B?WHc1OGpqT2V3ejRQQzJ4bkhTaWJlYTA3Mnk1WUFFNDFVNEJOTlkwVzB1a1F2?=
 =?utf-8?B?UngvUHhSR0FJckp1Tk0yMWhVMjF5S3ZOSzhnelovUithV3hnNUVoM0NWZ2l6?=
 =?utf-8?B?TTZGSCtDeDFMQVFVb3piNDNrTjFOaEhOSTdwYlI3dXE2UzZFajh5TmcxOVll?=
 =?utf-8?B?cGtWbTQ5b3dud2RDMkRUajZyWllpTHYyYWdQVmF2SVUzdlZjTFJhQlkrczJK?=
 =?utf-8?B?SDRsakU4MzhxMkppdFJpUE1jeHpmZDlqSEU0dDAxVW9jL0FxSjNjQS9UVllx?=
 =?utf-8?B?ODFnWHAwcUdHelhYbzBJMnM5aXFPNGFaSko1cmdYZjlTbndwTHY3eFdDby9r?=
 =?utf-8?B?ZnZ4WVU2eG11ZFRWRWRpUVZpSWhiVngzZHp0MXNGMjZEUVYvK2JrTUQzM1FX?=
 =?utf-8?B?a0xZYVJ4OHdHQUc0QzZnTlFtM1VKUE4ycitmbFduNjVqVEFMOUM1LzVhRGdF?=
 =?utf-8?B?YlNtLzZXVUZwbXJQY3A0TWZCM2FuQUN6MEhTUnNmZGtMaWVDMWpXVmo0WXcx?=
 =?utf-8?B?UG5za3RNbWs3NFZpVHRpQUVSZGdsWkx0L2ZqZGY5Wk9jTDRxcU1uZi9HbXRN?=
 =?utf-8?B?WEtjeEppZlZGR1FERkc4a2lmZmxIQllNY1JQUFJRNGJmbjRSQXpzNGJ2SUxT?=
 =?utf-8?B?VG5SSTJONjZ2aHNHUkxuZTdqZWZUUnVXSXhuSXlnajB4eTJRcm1WelphRGdr?=
 =?utf-8?B?c012QWpibUVUNjRtYjF1NmhtMTIzWWdrVFNxbkR5cHZXVUw0S0N3TXNoWFdQ?=
 =?utf-8?B?QVpicUNPUGVhcnVPSUtnOS84WE51a2FqSjhsTm85WGV4VWdFYnN0ajNEUG04?=
 =?utf-8?B?UldpTzhWZU1CRzdIS1hsU2hWdUdLSGVkMmw5VWhGUVFBa0ttciswWUFtOThV?=
 =?utf-8?B?MUtFUnhhdVdoNm5rY1pCNG1IdzhzR1h1SSs2QzRnY0JPWFEzYTFjVDJyVlVn?=
 =?utf-8?B?NTRENTMyT0p1MFVvYk53Syt6MkFCZEtvWnVwcjVGRnAybzhCQTJtTFhvYkFG?=
 =?utf-8?B?YnNlc3FIS1FzNDhyS0psUUh3UDNSTnZyUWFNQU1iMjd4UU1LcDBlTDRjN2Mw?=
 =?utf-8?B?MnZINWtsU0VweTRYMnVGREJFaFRPWjZ5dnkyNG1EUVRRQ0ppM3lCVDloT3dT?=
 =?utf-8?B?cW9laFFnR01wWGZkVytwTGxQT2hQMlJmK20zZmRoQmMwSDRzTW1raWFXQ0xH?=
 =?utf-8?B?M2lFc1VQNFJZOVpzSHJPVzN2Y2NGcFZHVG9Da08rWmdVeVRtUEJOTUJETWJv?=
 =?utf-8?B?RkU3UXJmL3I0VzhoMk1JU0lKL1pGcy9tQjU5Y3krRk9EV0d0djVSUERFQ0Ux?=
 =?utf-8?B?VS9CQXJFcFh5MUordVVqd0Z4QVZpV2NLTU0vSms2dWdKSm50SGxkbzNxQ25B?=
 =?utf-8?B?L0FPZHV6OUJOQ2E5bm1qeWppYy9YZjJEQkVIZjl4aWJ5ZkpmU1dTcHV2ZDFV?=
 =?utf-8?B?SFVYdVVUQzl2Y21USTZsM1dYQ1NNRklseVJGcm5Tb3BVdkVhQ3FOTnFHWTd4?=
 =?utf-8?B?YjdOMWlHa21pL1B2SDF2M0tFYkpINkJKRlFzU1FOV3ZTVVZIVkQ5QUJOdzJE?=
 =?utf-8?B?OW96REppWkpaVitodkIwQjZSTGtZTHJmblpEQUl1NzcxK2Q3b0xlbGJ5YUJo?=
 =?utf-8?B?RkF6dGZIUmdDd2hsYk5qVE1nR00xMlQvbjFvc1Qya0NVMDdGYi9OeWpVcW1i?=
 =?utf-8?B?cnRJQUtlcFJ3SG9tMmxabTZBZG5GT0pkYy9Ib2I2VmhESVIwVWdzcjRLR0hO?=
 =?utf-8?B?cmNpRXBaVkV1aXlya3N0eUhYYnlCVmNCQ3B4M2R0aEF0aGkvSFVNNGtHK1p1?=
 =?utf-8?B?STRGcm4xRUNTV2hHNHg4Q2pIN3V6bFMwcDBxZ1I0ZkxvZ0tTeXUxYUgyeVpZ?=
 =?utf-8?B?MjQ5YW9rdDIvckJneVM0MnNIRlZhVFprSnA5YmV5K1U3SjgreTc1djdkQmFY?=
 =?utf-8?B?MWliZDdacGphM1lJbGFCdmdGNXJjRVZtRDFBczU2ZUoxN1Fab3MvK0JrL2RC?=
 =?utf-8?B?Q2hkM3JSSGIxL1NZU0Q4SEtnRUpUMUNraGdJOStqL1dRNXBnTURUK21IblZq?=
 =?utf-8?B?TUFoY0hYeXRWREhtWG9EVjFBQjBKblVsMFIwVXhUNlpTYVIvMXZ0Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9d087c-8494-421f-5cdb-08dea09687af
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 17:42:31.6502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHP70UXgZtjdgR/MDfUQactxtLKw/saT6Ujt2E3cSC1fWZWqDifrpyY7DLx+yzjiOivWfoIHkpB3rVYUXDs6gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,amd.com,outlook.com,m1k.cloud,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-240374-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[amd.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[m1k.cloud:email,gitlab.freedesktop.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 633A5449508
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/22/26 12:19, Leo Li wrote:
> 
> 
> On 2026-04-22 12:56, Alex Deucher wrote:
>> On Wed, Apr 22, 2026 at 12:49 PM <sunpeng.li@amd.com> wrote:
>>>
>>> From: Leo Li <sunpeng.li@amd.com>
>>>
>>> [Why]
>>>
>>> Rapid vblank off is causing flip-done timeouts for NV3x and newer
>>> family of GPUs that support more idle optimization features.
>>>
>>> A proper fix requires further investigation. In lieu of it, let's
>>> workaround it for now.
>>>
>>> [How]
>>>
>>> For NV3x and newer family of DGPUs, restore the old 5s vblank off timer.
>>>
>>> Fixes: 9b47278cec98 ("drm/amd/display: temp w/a for dGPU to enter idle optimizations")
>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3787
>>> Link: https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
>>> Signed-off-by: Leo Li <sunpeng.li@amd.com>
>>> Tested-by: Michele Palazzi <sysdadmin@m1k.cloud>
>>> ---
>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++++++++++++++---
>>>   1 file changed, 15 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 3fa4dbda4517c..ce5063928413c 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -9511,9 +9511,21 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
>>>          if (acrtc_state) {
>>>                  timing = &acrtc_state->stream->timing;
>>>
>>> -               if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
>>> -                          IP_VERSION(3, 5, 0) ||
>>> -                          !(adev->flags & AMD_IS_APU)) {
>>> +               if (amdgpu_ip_version(adev, DCE_HWIP, 0) >=
>>> +                     IP_VERSION(3, 2, 0) &&
>>> +                     !(adev->flags & AMD_IS_APU)) {
>>
>> Why only dGPUs?  Seems like this is reported as least as often on APUs
>> if not more.
>>
>> Alex
> 
> Hi Alex, Mario,
> 
> At least in the case of the few reporters I was working with, this specific
> flip-done timeout was reproduced on NV3x and 4x systems running multi-display.
> The reporter for the linked gitlab issue was also running a nv3.
> 
> The cause of these flip timeouts can be varied. The signature for this
> particular issue was OTG failing to fire an interrupt that is expected to
> deliver the flip-done event. I'm not aware of this particular signature in APUs
> -- at least none on my radar. Do bring it to my attention if you're aware of
> them.
> 
> Thanks,
> Leo

In Michele's proposal 
(https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/) 
there was a mention that it was tested on DCN 3.5 too, which made me 
think that the exact same issue was on both.

Michele - can you readily reproduce the page flip timeout on DCN 3.5?

If so; could you modify Leo's patch to drop the IS_APU designation and 
see if it happens to be the same solution?

> 
>>
>>> +                       /*
>>> +                        * DGPUs NV3x and newer that support idle optimizations
>>> +                        * experience intermittent flip-done timeouts on cursor
>>> +                        * updates. Restore 5s offdelay behavior for now.
>>> +                        *
>>> +                        * Discussion on the issue:
>>> +                        * https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
>>> +                        */
>>> +                       config.offdelay_ms = 5000;
>>> +                       config.disable_immediate = false;
>>> +               } else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
>>> +                            IP_VERSION(3, 5, 0)) {
>>>                          /*
>>>                           * Older HW and DGPU have issues with instant off;
>>>                           * use a 2 frame offdelay.
>>> --
>>> 2.53.0
>>>
> 


