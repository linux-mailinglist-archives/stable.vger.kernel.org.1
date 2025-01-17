Return-Path: <stable+bounces-109315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B90EA14711
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 01:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3748F164448
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 00:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5916B1FC3;
	Fri, 17 Jan 2025 00:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PBry4ld+"
X-Original-To: stable@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazolkn19011030.outbound.protection.outlook.com [52.103.64.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560BF25A629;
	Fri, 17 Jan 2025 00:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.64.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737074464; cv=fail; b=d5w0n7MZi0E/l9lu0SJpQo8ZbCDOa4Uub34DZ8TiA5Nv+BoSyTPZgSprdHSfRUwSuOwrnYQZzl7bXEXtIz49Z5jY6VxewfuVQITFfMbtspJGO0Rv7eByMUuqH5SBhKc+w/CS/UzFtAmPxYbKszTpLrbK718HDMDx/ZmHtRDrzKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737074464; c=relaxed/simple;
	bh=cCGREMGmVyNsPMw+p7QKQemGeTL2lHvzgF5/50lp/OM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F+74/SGB8Nyl6r0BO2Xi+lmkGCbvyFXnVbVflizmszjTcTtYEvuZ74+8L2d5LHWaOke8whQw5ah5uUHJLsP7ieoR6jT8xif9vzEHqLHJrciyJxXneZaaFzm1RoEaZZ8DJXB1iQCUYFivFdhaciso28rgO0XS1hFll26T+7eGWOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PBry4ld+; arc=fail smtp.client-ip=52.103.64.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fb2UFw47Yx6NwUnME9+YNl6SZzVSr9G3XdyJRQ9EmAd7owq3/y3LPpOXzKaf5R4AXDWzCai+xMVlAt1q1J/3Drqozr7C9UoHYsNSQUUixhVU1ZAi9BJDbnrIJRIVceXQHOThznktkM04cVZ4tVBmtNkYtY3nSwzmfZsTTQuy7twcHZaK96uI4fvm/JM9phmdFMRXo9vZ9zsbx1/FSFpX8sRlFsAT5UrSt2Y0R34HISf2VIR5zt5De8wwSgDwMlypYbg05SqL3bqHfPJqnAAFVKvOvgEvoX2UQ6vThpBsW2uuyxKf5zAJ0nqcHYyWEtcFy3owZ1YDddC89sfXAiKBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ool+dKfQsSlCb6CoQa2uGpwrmtTZwyM358Q13VQeYiI=;
 b=TFOwa2vDCA1CFOtmwRnU9iiV1mVJeeRbGj8PQ50B+K0TFY+e5ZPMt1u2uOsDCSwWgpPmupkFpwu/Shf60LAMVChrftGC5NQkow7FD4FF7F0Zc8DwXb1pYc6Rc7wAZRYb/TdNwYf01H3N6yP2Slnp45vNbiBFKbekSUjDXkaPRKgsOnukbBbS5jLutIyLCqx/IheeJJw56D0+0GnQTCyIewjuSwtsXJpD0KjzO3+yd5l8/kt7wA7ezclJMGHHc0kVc5Yq8aWeD1pTC5ukkJxSM7y+w6A1maCwrTxg73Bi4chPhseU2SqePGunZXcC1u/grOc8csNavCPWu6iuRkjo0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ool+dKfQsSlCb6CoQa2uGpwrmtTZwyM358Q13VQeYiI=;
 b=PBry4ld+XPvrjGtg2k0Hgv5PcXNIUsj9r+/Lwyj+GxvrFESerMKc7Wl4ChQ1aGBsbmG8+GTG+4vbx0KweJ9Zqs/RbbcCh07WMnHttnwrDBD1xIi2zigyFhsTvjNi1+3JzAhj4iBB69vpFmlpUp+qAl5MfG1ois36gwdXcGabOfia+znJkrlJYy9zwqo8X595xHPXGmmCWBR+AdXcliK0FlBQ5E4CCQa+ifwwRBxI75nGNDKqeaA6UnAxxYrdsXEWnKh3WdThqitUQ/gTlbPrMFx+EGstUFPCuMhS9emjbzBFchnK5SzW1wIzTbviZ+ePtxY/Fh/N1F3sIBsx9fQasw==
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com (2603:1096:405:a1::8)
 by SEYPR03MB7628.apcprd03.prod.outlook.com (2603:1096:101:13d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 00:40:57 +0000
Received: from TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006]) by TYZPR03MB8801.apcprd03.prod.outlook.com
 ([fe80::cb5d:6807:7a00:5006%6]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 00:40:57 +0000
Message-ID:
 <TYZPR03MB8801DBB1463548FD1AD818D2D11B2@TYZPR03MB8801.apcprd03.prod.outlook.com>
Date: Fri, 17 Jan 2025 08:40:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: Optimize the FRED entry by prioritizing
 high-probability event dispatching
To: Nikolay Borisov <nik.borisov@suse.com>,
 Ethan Zhao <haifeng.zhao@linux.intel.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, xin@zytor.com, andrew.cooper3@citrix.com, mingo@redhat.com,
 bp@alien8.de
References: <20250116065145.2747960-1-haifeng.zhao@linux.intel.com>
 <8cf5b264-68be-42b8-b435-79b8d682fd7b@suse.com>
Content-Language: en-US
From: Ethan Zhao <etzhao@outlook.com>
In-Reply-To: <8cf5b264-68be-42b8-b435-79b8d682fd7b@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0118.apcprd02.prod.outlook.com
 (2603:1096:4:92::34) To TYZPR03MB8801.apcprd03.prod.outlook.com
 (2603:1096:405:a1::8)
X-Microsoft-Original-Message-ID:
 <596fa004-880c-4aa5-b17c-139b1258acfc@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB8801:EE_|SEYPR03MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6aa369-d115-4e0f-4f07-08dd368f9b86
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|19110799003|15080799006|5072599009|36102599003|8060799006|41001999003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N29vZlRpOXlJTlV6TndSRVVkT2lEZ0d5Mmc2SFg4SGs1ZWl2TmNsQ0tvbjRF?=
 =?utf-8?B?d04yQjB2SW9zak9Yek56QmwyR1BwL255aXVJaVdJaHdSV3I3THF0b2tzbVNm?=
 =?utf-8?B?aUJtd3RSQnorc3JRTHQzNU13eFZHb3JoSXYrQm5iV3lLTGZMQ3NucWFOOXgy?=
 =?utf-8?B?VlIzQndaeWxNZTR0V05aZS9kZnBWaUw4NjFYOE5kVHg0NEpWUjVWVzF1Z3Bn?=
 =?utf-8?B?cjNjL1oyMWxhQTJEckQ2eit5SlR4WHlVVFIwSlVHSndVOGpiQ0swM3U2d3JC?=
 =?utf-8?B?Rk41dis3TEFYa294KzN1MTZTWEtkTGU1Z2xjRHZPdGxScmZxem9KLy9Zdk9E?=
 =?utf-8?B?UnhuaytqUGpwUjhNY2YvVGVuVUFEZW95QmFlcGthREZpVEh4cElQeGJ6UDE3?=
 =?utf-8?B?T3BXQm5GVjliczJkWkhsbmxHdmlEcnBjeElucmRFY0ZlNEJQRXA4d2UwSFBE?=
 =?utf-8?B?NmFXeDBtbDBFR2RBdFQ5c2hsZUwxNzJ4Rnpqa2RmS3VPRloxWDJnaUR0VE1N?=
 =?utf-8?B?amphck53c3VuTm5NV25nZDhBV2FBUHdXZmYySU92eXNQVDJCdk1Ba2ZkNDdO?=
 =?utf-8?B?ZUtFMk5hV0liRUlyangwZWpOVm1CNXRMWU5qMU9zUFZiRDF6aURZbG1EeXoz?=
 =?utf-8?B?VE85STBiR1pWMXVyNVNvZXhqaU9DNTB4cUNNZERrd0s0YWpzOE5QRXVBTnph?=
 =?utf-8?B?Sk9ISFFBcmtmdEQyb1ZSeEdLQW9FQnVURUtLeWlHM1dTOFJGTjl4cWhWVGR2?=
 =?utf-8?B?UkdPdzVjejJscklHbk80YUFsK21mNUZRbUNDTUJkYW92YW5ldTc3K3NLNmEy?=
 =?utf-8?B?bmczdVI2N3ZCNDhWK2piVDNSU085QUxQWThSNk14ZmJ3OEwwUE96Yk5WQ0tR?=
 =?utf-8?B?RGJ5UCsvSlJpeEg3YzNaRkhBemNUL2hFSWVFODZZVG5jVkJXaVdxWEpKb3c4?=
 =?utf-8?B?aTNjem5Gckd4Z2hnL1N1QmlvZ3JGOGRJWmt6Q3I2RVJHK0JUKzl2dGZaeE5a?=
 =?utf-8?B?cmVJb0k4VDVZWjFNeGhha0s2S1pZUTBka3dueDhqc2h3WnE3NmFEdXJRVEVS?=
 =?utf-8?B?cXIrN1Mwd0ZIdVV2MTI2cGJhU25HM1YxaXFSMEVYUk91aEM4ZUhDRmt3UjIv?=
 =?utf-8?B?NDFCYnJxMG8wSThVWWVGQ3l3d1BEbnlPV2lienZxWS9Ld090QXlJbTQ2WWJI?=
 =?utf-8?B?K3Y1bmNXYjNCMmt2bW1jTUpnSGdlT0RnczNnKzBzUkV4ZVd0SkJpblJuTVJD?=
 =?utf-8?B?UmFqQ0Z2N3ZzVWphOHNMZmpJT0tTSjZmS294Zk5NVFA2bHBsaGttTW9XZmVw?=
 =?utf-8?B?TmJXTDI0QVZjNDB3c3NMa0p3UjgyenJqWTBGT0cxOXpxUGF0WkZtUmNSSTI4?=
 =?utf-8?B?NGdDRFJITGgxbnV1RlNLMmsyOVY1SVVpYVJiSWhQVS9GSHlndVI3MVlFRmtO?=
 =?utf-8?B?M2tPZWYxc2ZyLzdSaDJuMG9sMGlzNDNGT1dPekt4K1crbktQSmRERjl5VWJO?=
 =?utf-8?B?cUxSOXVoNjgrRjBuajJIQkNVS1hLdUJJZFVLVGlPRTZVRVVpdFNuMUk1SGJP?=
 =?utf-8?B?MzhPQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjZmZ1BqMUk5VitOTVhmbUVuRmhEbjlvYXFMdEJYYlE0MkpyOEc0TnpyaEk1?=
 =?utf-8?B?bFpYR1dMSWVkUStEbmx3N3R6dlJDSEtVYlJWWnVkMnMzUkhYMGFhd2h3SzNJ?=
 =?utf-8?B?dDFZWnpFUjFMSGxLUHc2Q2tHQmhMekZLNlFnNnh1NmpXalUyZzNON1BmQmkv?=
 =?utf-8?B?UlpJdnZnQ0N6Y0hjYU41eDh4Z21xQkpSK0REQkpIcTV3Sy84UGNoUkQzbnI5?=
 =?utf-8?B?WEdCSU8ycTh5ZE52SjBIc3doS3lnc2JqV1RTTGo0aFlmckNqdFBJUGc5R05B?=
 =?utf-8?B?LzBqWEx3R2taV2dmUEpKM3ZUZ0F1V3FqUHhEMHZSS0lFVGwzVmJ4TFFaSU5v?=
 =?utf-8?B?cG1zUTUwQjl3bG1mdnhOL1dVeGVPbmJ4Qk1TbEZzQ1NMUDJTUVl1OWFLOWNi?=
 =?utf-8?B?VXhVYzM5RVpSKzBXeXNPUWNYcDJsNnVvcWt1UjloUkNmQ3dGMFl5WGFzU1VZ?=
 =?utf-8?B?TzdKZkZmZDlhNWR6VFBGSGtzbWI3RTlGQUtIa3htblZ1WDRhUkwzbCtmdHpJ?=
 =?utf-8?B?bXJWR0RTWE5NbXNsVitQejJnY2hhZmwrRTk4ZUZFWSs1ZlQzSjZvK0R5bHF1?=
 =?utf-8?B?UG5Lc0NrTzUyRTFVQlA1L1NkVk9MQ2ZoWTFlVzY2NXdtQno3UW9YbWpoK0Mx?=
 =?utf-8?B?SXhHSUgydXlBQ0FlWkFkU1VpNFB4RGpaVWc1RnhLb0ZPcTdTUFpsTU45eW9i?=
 =?utf-8?B?eHYzV1drekZiTmk0VWdWcUNFS2U0TVdOcFBiYlNpWGJEMFplMmRGRm5WNUgv?=
 =?utf-8?B?bzhOM0t1NDdDSzFLcTBTT2c4cm9tcE5Nc0kzd1lKQkEwZTFVZWZLcm9iVmpW?=
 =?utf-8?B?dmVXR2dzcWRzYWl3d3JWT2JwSjV0YytNVEtacGR2UkR6K0U2Uk1SWlZlWUNZ?=
 =?utf-8?B?V3hXM1NiNyt4Wk9tandFR2g4NmhpZWkxakQ4NUl3dlh5OWd0NVZUOUVXMWdn?=
 =?utf-8?B?QnFjbnAwYWk0Q0FXWHdIOXBSTmVTUlVvQTQxa2g0OXZ4MEQyMWF3citlWW1I?=
 =?utf-8?B?UUNleGlQWGNzK0hlbHUzWGtkTW93YmRzQ3k3OTUxTWFiSjNhekhwZUJtVlhj?=
 =?utf-8?B?L29RTzN3Q1Z3WVB1K1RrQjZUejJXN3R5YXF6VTIySzMxQjNGbnpCOU5Na0Ru?=
 =?utf-8?B?YnJJSXh5WVQ3aUNhVkxwR21lU3JwdUNsWExDVXptUlk4VFpzY21leDZGZHhV?=
 =?utf-8?B?NVNYbHJoaEVsbGMweTlYem9JazRWWGVLZTVqeDFVenAvd3Z2V0FSSmlqOWIy?=
 =?utf-8?B?MmVrbS9vOVZhcnphVlRuYy9JWnhKSmRidy9OcWJxTFMxVlZ1U2lmUUVWY1Yw?=
 =?utf-8?B?R25UUjg2SXhVaWh1YUtpbmlhRUlDUThURGRUT2drUjN1RzZRZDVjcWF3S0My?=
 =?utf-8?B?dTNWUEVMSWU2aEJ0SytZS0dYSzk3eWhIVjNHWGhYU0Z5KzU1UXV0VitpaEpI?=
 =?utf-8?B?bzdHYkVFOUUvVHhCZlp5L0JqZzgwdnFheldodzlGclZIcFFwM05QVE04Q1pQ?=
 =?utf-8?B?cFpnWE1Uc0ZCWXBwdmdKV0trb1A1cGFDc3BETU9majdPUzNWMkJIeDZSUDEv?=
 =?utf-8?B?WDUwRzJhNTVpOW5NRTNMQUhuZlBZbCt3cmthOXVtb0prbXRCT3lVSlg5MC9Q?=
 =?utf-8?Q?Y5n9uWhUu8EDcVEOZU3oTexFyE3XqKf5zhm3sljh1gF8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6aa369-d115-4e0f-4f07-08dd368f9b86
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB8801.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 00:40:57.6603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7628


On 1/16/2025 11:08 PM, Nikolay Borisov wrote:
>
>
> On 16.01.25 г. 8:51 ч., Ethan Zhao wrote:
>> External interrupts (EVENT_TYPE_EXTINT) and system calls 
>> (EVENT_TYPE_OTHER)
>> occur more frequently than other events in a typical system. 
>> Prioritizing
>> these events saves CPU cycles and optimizes the efficiency of 
>> performance-
>> critical paths.
>>
> <snip>
>
> Can you also include some performance numbers?

Of coz will do when timing is good :)

Thanks,
Ethan

>
>> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> ---
>> base commit: 619f0b6fad524f08d493a98d55bac9ab8895e3a6
>> ---
>>   arch/x86/entry/entry_fred.c | 25 +++++++++++++++++++------
>>   1 file changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
>> index f004a4dc74c2..591f47771ecf 100644
>> --- a/arch/x86/entry/entry_fred.c
>> +++ b/arch/x86/entry/entry_fred.c
>> @@ -228,9 +228,18 @@ __visible noinstr void 
>> fred_entry_from_user(struct pt_regs *regs)
>>       /* Invalidate orig_ax so that syscall_get_nr() works correctly */
>>       regs->orig_ax = -1;
>>   -    switch (regs->fred_ss.type) {
>> -    case EVENT_TYPE_EXTINT:
>> +    if (regs->fred_ss.type == EVENT_TYPE_EXTINT)
>>           return fred_extint(regs);
>> +    else if (regs->fred_ss.type == EVENT_TYPE_OTHER)
>> +        return fred_other(regs);
>> +
>> +    /*
>> +     * Dispatch EVENT_TYPE_EXTINT and EVENT_TYPE_OTHER(syscall) type 
>> events
>> +     * first due to their high probability and let the compiler 
>> create binary search
>> +     * dispatching for the remaining events
>> +     */
>
> nit: At least to me it makes sense to have the comment above the 'if' 
> so that the flow is linear.
>
>> +
>> +    switch (regs->fred_ss.type) {
>>       case EVENT_TYPE_NMI:
>>           if (likely(regs->fred_ss.vector == X86_TRAP_NMI))
>>               return fred_exc_nmi(regs);
>> @@ -245,8 +254,6 @@ __visible noinstr void 
>> fred_entry_from_user(struct pt_regs *regs)
>>           break;
>>       case EVENT_TYPE_SWEXC:
>>           return fred_swexc(regs, error_code);
>> -    case EVENT_TYPE_OTHER:
>> -        return fred_other(regs);
>>       default: break;
>>       }
>>   @@ -260,9 +267,15 @@ __visible noinstr void 
>> fred_entry_from_kernel(struct pt_regs *regs)
>>       /* Invalidate orig_ax so that syscall_get_nr() works correctly */
>>       regs->orig_ax = -1;
>>   -    switch (regs->fred_ss.type) {
>> -    case EVENT_TYPE_EXTINT:
>> +    if (regs->fred_ss.type == EVENT_TYPE_EXTINT)
>>           return fred_extint(regs);
>> +
>> +    /*
>> +     * Dispatch EVENT_TYPE_EXTINT type event first due to its high 
>> probability
>> +     * and let the compiler do binary search dispatching for the 
>> other events
>> +     */
>> +
>> +    switch (regs->fred_ss.type) {
>>       case EVENT_TYPE_NMI:
>>           if (likely(regs->fred_ss.vector == X86_TRAP_NMI))
>>               return fred_exc_nmi(regs);
>

