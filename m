Return-Path: <stable+bounces-241670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gExnJh7B8GloYQEAu9opvQ
	(envelope-from <stable+bounces-241670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:15:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C559486BB1
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82B313365BBF
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 13:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E870D45349A;
	Tue, 28 Apr 2026 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SDJA1Xl0"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E16F450902;
	Tue, 28 Apr 2026 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382881; cv=fail; b=QhVjU3i2keWf5RQI9GYavAO33+AsbuTSo28VO8yE+RQ+pDGNvYxPz378Fy2zuyy4lxtJsAiEoycm2cBWyB5gPEGPB4IT821uOQiiLb/qoIe6yjn6ELBoXhKz7Ojfy1j2sYsle3SVkfzOdYHziJbLh7w/zbTXUK9xm9WB6XW6qWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382881; c=relaxed/simple;
	bh=s3u5pXnAqbSwQ33lvafG4DUwJnzAYKdqklAORXGwvnE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JTzg5nYonAq+N+yLRUHE/TNjXvmCIW0VnrLOFZP8b4PkUnH7vFDdm76WMKOumYKKtdLPJZDj2+t8zndfWheRXKwAaqLCWH2E9CLWOp/XLWoFPxfNXF4m5w5VhQ/9ydFs4OY5xZQoVO3E7KeqH0XIQSgOcmddToZb7+/2oao21po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SDJA1Xl0; arc=fail smtp.client-ip=40.107.209.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQ4RaEYlK1asGOqOxtlqkshHCt0dG/tIsHUecACNgYMkEcBWFOP4501NVKRLFhVcXJEO6Nj3JZ4XeRLW0bPlu5r7h9UVNHvpI18395qPW+JhhUeiSWUJTb8LnCld6YsZIocfDpxTWcamYPt5PmI9eYm9TY8MxNQi9j2ZvFpjT6T9niJlNeOtUcgUEzeEuwYaUJQljtpxiv9fLjneB41Hp6ayitT8emqhKePm0Q8wYW8J+35F0QC/iQG2rxW/9/GprDlQP/9lhSIEbi9yFzwdSh+1Gl8zZRkK6hNEbSrDGuhfzd1OxlueDu1kq6qAT/Ppf9IGEOyFavSgi77BWkl2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Hy/1aeIFqZwgVKdv/8V++goEL6mG42CSd6e0bBQOOc=;
 b=uHRU/kyes1UECGPvReJ29L0SfEuwR6C2Su5VzKtMDbgxChzhJbPipLbx2sGTQQcbIaRpGTwJPVMCFAtTpw8qysgFTuH2jBGxvEa1Ms6GO6OpchYYDkUGdtZ0IcuDQ183kEGNDRLk/WgzldjnjvyqV7U+cdToFWA06eoh8ZClfvziDEjSy9udnHAORxWTf2iOJ3RnPBRbEbfxXmm4Y+12Ho3WYBDI2vQC8HNNIv0Z1JZpU3O0hNk2fTW9wyH2S0rjoifhfOD/HwC+0/etMDtINixM1xeBZeQvqRRDvY5c94IGhcxFwKtC3btaitnQENB0ZZpgOeUJGW42Ke03dPNIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Hy/1aeIFqZwgVKdv/8V++goEL6mG42CSd6e0bBQOOc=;
 b=SDJA1Xl0oGizbLP/0cD0imUkW1GmXom42uUM/K4kxlvQhS0P6w8/nfEUZZ/QCrN9/OdyJd7asUuJBh1TBbgkLDDRpUepn8WWNkW3XzPmRkoVSKQl/yFa5aQovWvTaTVk2b4c/h3BHspnimBwP/gG72onnB6sC5Qfyyb/rYMt+vw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14)
 by SA1PR12MB999251.namprd12.prod.outlook.com (2603:10b6:806:4dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 13:27:58 +0000
Received: from CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::9e02:c4dd:e87b:5a74]) by CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::9e02:c4dd:e87b:5a74%3]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 13:27:58 +0000
Message-ID: <359e10c3-3a06-d387-47c2-a0dff879e45f@amd.com>
Date: Tue, 28 Apr 2026 18:57:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] cdx: Fix double free when sysfs file creation fails
To: Prasanna Kumar T S M <ptsm@linux.microsoft.com>, nikhil.agarwal@amd.com,
 abhijit.gangurde@amd.com, puneet.gupta@amd.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260320101933.1554416-1-ptsm@linux.microsoft.com>
 <20260320102117.1554548-1-ptsm@linux.microsoft.com>
 <c67594eb-7e3a-9fda-858a-a9ffa4e3d190@amd.com>
 <32170102-490f-4eb3-bfe5-faa38848129f@linux.microsoft.com>
Content-Language: en-US
From: "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <32170102-490f-4eb3-bfe5-faa38848129f@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::8) To LV8PR12MB9205.namprd12.prod.outlook.com
 (2603:10b6:408:191::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9193:EE_|SA1PR12MB999251:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d87b96-8a03-4745-aae5-08dea529f5ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	EEX+e1/gqEmsb+f1ekH784nI5yWiMlyMyQdDpIxQsVDsxjdSDE36Qpfo0b+TeM4ARGxh+Xu4FQXagxFugBmAxsRu/DLvFZuxlq0ObcB1agsCCMlGcAM7eYUvRZuXVxcAqu74TyPBewgS02xRSMbXuac9QGk0gVWlxg5EomdqtR7zP/svwGYJqqKremuiWGgIzIbGIVHu7Z06Mmx4KJGDNpR+XrUM1XwMUPRfB+5RAhloZtdmUPiS+Qzpm5ICl0IJD7C/j/uKH504hi5zs2xD6s7cQRYh7aI2FSGvrHAvYTcyblD2vwy5A8syPaODDVgE784QcB19HBIpgSmuXWURXoba433KkVSu6CR+Cnics0oDnReuxnYrKrX+AxtDs9dbb+nN2cvNvd46NSu2mzNJyHdhjPF/7aCkLghodGFVNa/t+JbPSc97qzLQZDjBp9es578796ZVqRst4gIrImcsYtcV3Bj5uw86fbXBUeiqLX9DknYu+CbtrrpbbrNgsO8YH548k1cGwq3vew0WnVcHV2I2l1WtVjvd95MR1DRW6cRUAOKzmu3J5b55gVug1sRYyQpJbCQMBJYP1IjcCL1LdlqaQ0z5+Y4jgYorhF+B3SYZEWyz98XpafPqfl9oSdCtz/LxWL00h1eGC5j6lTZKqsgMPmRWRNQllY4s/Nq9b2f5zWhOLAKGxPRmJqacLTU3x7h7+FygJITuotDiGIObQUd3mcULXVP6LWa4jpYV1aqEIvjYrwk3K3vCY1L6jmky
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9193.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzBWR202dkFNeHdyWnorNDhmRStXbU9SYTJxcDludlhHeXJBS3krT0NRY1ZU?=
 =?utf-8?B?KzBoTkJURU5Xa3A5NHBzWEFIckZEcEVYeHYzKzYwMHFobXdRZ2hBZ2hxVVBM?=
 =?utf-8?B?Uzl1dUZEL1RJNFJMeS84d0R6dElWVHdaK0NVakN2dUhLbTQ1OTNEOHBaSkxn?=
 =?utf-8?B?YThYOTg0WWF3MGppY1IrMlJvSWl0d0EwUzhDUTZMWXRXUSsxaDZHMTl6Wk5v?=
 =?utf-8?B?ZEJRZnlOdndUYkU2L00wakJWR05BT2JGMm5ySmJNWm5oL2QwaEphVmNNejJ0?=
 =?utf-8?B?MzBsdWE4U1NuTVRhU1JkellLM2FhZFI4eVBhMFdLMHlna0Z5LzNXSjl2ektD?=
 =?utf-8?B?dFZVcmx1Rm1MM0UyTWhhcDAwUlZNQStWOGNxcmJ3NWhWYVdzVVJtQk0wd2sx?=
 =?utf-8?B?Z2RFVC9OYlRMUDZ6cDZqT0JOeG0rSU9TeUwweHhuUlpDQTRjQ25FKzM1K25y?=
 =?utf-8?B?UEhlUUowUGMrQ1pucllFYmRIUVNHaVpyTFRzRnRqNjJwdmFaR2t4cU92U2Vs?=
 =?utf-8?B?YXh5dG0xamtXcldUK2pMcDBkNjBRdjlmbC9QN05TQ2MzeXNIR3ZTRS9KV3BC?=
 =?utf-8?B?U2o1Z0VEcmFodDdMekFHRVNwWExJQnMyYmtNNGhpcUUwTHQycm9qN25Rd2Rj?=
 =?utf-8?B?UnBNUG81VCtyT0R5U09ndGNDeHFXRmR1eWQxaUlyVlJSNDlYbnNBSVpRajVl?=
 =?utf-8?B?SlhoTWFUaSsrK3dqYnBzSzVWcEhTZGtlaXd3MGlTa0hhOFMySXBud1BTaTZ3?=
 =?utf-8?B?MkY3K0ZFa2lucTNkc3pkOWhWZnU4RlRMSllhVU9kSXRpVU5HNnhpZWlkSjkr?=
 =?utf-8?B?bHdJQzFYUXlHMW5heWZHak4wTWo1ayt4bFdlOUxJdUJCbERkSEpZT1V5MkZH?=
 =?utf-8?B?V2lLd3kxT0xvZmtmRkFvaUtMRS9GMWNzeHdNY3cwalRiWFBtbG1KYWt5R21y?=
 =?utf-8?B?US82ZFdEZU01cldhZlVJSDF6OTdnS0RmRHNQVWg2Yy9EdWQ3TjdEcGpkL3pX?=
 =?utf-8?B?UDUwQ21kOVBSVytKWWpxWEhKVG1JSzZndDAvVnhUTDlnTGNEK0pXa2FTRDRX?=
 =?utf-8?B?dFFGdk9rbGVCYkRieVdwb2lJQU9CNTM5TlBnU1B6UG9uMUgxcytVU0dSMkpW?=
 =?utf-8?B?WG5lZ1hSQTVyNFZPdzB1dmNMREl4VWI1RjRaVkFMQzJTRVQ3S0FQeEl6SGJC?=
 =?utf-8?B?cGNCa3Fvc2srWmF6cGdTbys4R0kzVWN3WktId3BMclZYcDBnYzc5VnczdjhB?=
 =?utf-8?B?ODRTU0lCYVp5TDA2TDRwbSs1dHNkeG1Lbkh6MDRrRWphZnFPTHM1V2c1Rzc5?=
 =?utf-8?B?TVY3Z2xOUDVvTXdNRDdFbXQ3cDM3Nk83bUQ3d29lUDdWOFpSN0xBaUFYeEdE?=
 =?utf-8?B?dXhORXpvZ2NaN0RZcWpvendqblhqRzkxNWlZMHhUQkNjdVkrYTlFVjBLTllX?=
 =?utf-8?B?V2dyOS9oTEdpeGRXc0QzNVJUbmNVQ0J3WGdHQ1JGUTdiS2xHUnIyTmVqYVNV?=
 =?utf-8?B?SUduMHZZMWcxL2ZVeFc0dkwxamJSa1VJVXhLN2RKc1lNekQ2ZlJjZEZjb25H?=
 =?utf-8?B?WEJmYlY2cTUvYVJ6NU4xa0pMeHhWaWwrc01RUUFZcUVlSmJjMktuYVBmdXhT?=
 =?utf-8?B?UEd1K0VnakJwNUgya2lZSnNza0lkU0QydzZWWDBzdXRPVTBpR1ZFMUNET0xa?=
 =?utf-8?B?NEhmalNsNEVQd0xnUDNBZ3VIZWc5WEd3VHBXaVNkb0s0bisxUFJWVlJrTGgx?=
 =?utf-8?B?dTNBSHdtbHpEM01BVUh3QjdOODN1TW1rTjh2ZmV5S3hZcFpvbkRSbDkwdldF?=
 =?utf-8?B?MmQzSjlMM1Z3SzYzODZsNkY2NHhDK2Y4Y1N6bG8wTTZHUXl2UGJvWmphU1NO?=
 =?utf-8?B?NTVQNUZsc3pWMzROeXlUbC93ekNHcWdRSXZ4bGUwRGF5TGE2eW8zSXR4VGxC?=
 =?utf-8?B?TDF5dm9wUEVpWnRJQlhsMHRhWHYwK0hPaE1vSEl5RDJnY094bHVxUDJRV0ZI?=
 =?utf-8?B?cWc4bmIxNUtnQWNrS1NoZWViYzlqTENNdmFoVGxwTVZuUTUyaDEvUzNsV0Y5?=
 =?utf-8?B?Z1JjSVJQb0QzNWxEWVRjbktMUXlIbW5jTTlBWlJXczE1MTN1MytabFd4Zllr?=
 =?utf-8?B?OUVXWWcvRURMeUQ4cVAvTlhJNDJhSlphZksyYzJPS25qNlN0UUsvcE8rSEp6?=
 =?utf-8?B?RStaVjY3R09zdDdFUTZDb2k4NzJTSzV4WStBVXJtMG92azdGMldqcmNYOVlJ?=
 =?utf-8?B?Q2J3d1BienZYYkllczdUWlQ5UWU5Y2txVDFUSmlqcnBhOFJCQWRudWl5dG1K?=
 =?utf-8?Q?W0prQEsP4Q3ZPvMcMy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d87b96-8a03-4745-aae5-08dea529f5ed
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 13:27:58.0585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOT9B+9Ht07y02YkU5IADaxF07doPU8bd3Xd3zzKh27KESSubQvwF8T6bJ1NmBO6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999251
X-Rspamd-Queue-Id: 2C559486BB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241670-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nipun.gupta@amd.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi Prasanna,

On 27-04-2026 12:37, Prasanna Kumar T S M wrote:
> Hi Nipun,
> 
> On 01-04-2026 15:12, Gupta, Nipun wrote:
>>
>>
>> On 20-03-2026 15:51, Prasanna Kumar T S M wrote:
>>> In cdx_create_res_attr(), if sysfs_create_bin_file() fails, the code
>>> frees res_attr but doesn't set cdx_dev->res_attr[num] to NULL. This
>>> leaves a dangling pointer in the array. Then cdx_destroy_res_attr()
>>> frees the already-freed memory. Fix the double free by initializing
>>> cdx_dev->res_attr[num] after sysfs_create_bin_file() completes.
>>>
>>> Fixes: aeda33ab8160 ("cdx: create sysfs bin files for cdx resources")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
>>
>> Acked-by: Nipun Gupta <nipun.gupta@amd.com>
> 
> I am not able to see this patch in linux-next, although I can see the 
> other patch.

Can you please resend this patch as a separate individual patch so that 
Greg can pick it up. The other patch i.e. patch 1/2 of this was applied 
to vfio-next tree as a part of series 
https://lore.kernel.org/all/20260417202800.88287-1-alex.williamson@nvidia.com/.

Thanks,
Nipun

