Return-Path: <stable+bounces-211195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE77HqyxcWnvLQAAu9opvQ
	(envelope-from <stable+bounces-211195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 06:12:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E877961ED4
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 06:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 390AE54436F
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 05:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0F539283B;
	Thu, 22 Jan 2026 05:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zFYy1ck4"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5451392B65
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 05:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769058460; cv=fail; b=kay4e1KjHA3OtUOkRsS+DmVdMTqboUIU11/i+npFE/5Nl4ZlBijQQGBG2itFx/3LgJPUeXAHzIe6F2PAm4wCbQNDrCyKxip3gxj0HGSMMs2rcyHoqIkNEUZpQS8r1kFadZTxgaLCpiT+ZYLQh5AI6E+rPOMeJV5W4zDnI3ejpVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769058460; c=relaxed/simple;
	bh=UeQHX73wf3zWGHdVngT5525mevVMWIqSB7pS/Wyd4WQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t3ArlyJHxcFzdcaEbyZG3vwECwJA3o03izwRe8qKZcXP+s8cZAeCO1vvi0uJmxWoG3z2l5c5NJ0ihStvgYl659lcW9o5mt1slMKCjjC5CdUd2LO+GAsfe1StVnp0KuZnrl+Mg7zSPmTSTVqlcrm4zSMNmVwuv47WkoS7PAOrwLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zFYy1ck4; arc=fail smtp.client-ip=40.107.209.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBcyg6JBNQzZqaF3DFf/y/4VsHlCN4nJxMK8jJ2VQA8K0ncGGEBLpjEHCxGzuO0ENM3S1UzQawep6aDJfn3brc7G9swZ3WMGVVQZOyC3DaXtwuaTMXo0kzoEQw7fiLnkoQNj+OsVNdKJ+BnverS1yGcz3x5GG9CTReFZdCnw0nGh4CfRS89KrR6foAG/RKR5jKTrAn2Kv4Sf7OIqIJAa9/iqYtFrpAjP6N5a1cn4aC4Z4AWIO3FTN+rhHo53/btsaRvELr1LxgIwQYUF368PlVL7rDA2PWdtXoc6xA2PvQ7pqp/XUVQZ9Oal01qRaaLxWumiVtFTURPTKCg0Y0bJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlx52PnlxUj9+6uFVLh1FvqCeYieCrxE8MHp/YmBxzo=;
 b=XLe1Fl1AMYh2tFd6jwelrb22zYK44K3a7q8kbKv1gffAHFsPu/uUrQck1MHV+UQ4jTz8NU/eT7xvc/eT8qzEaSO2PEeJ4fZ2bHwSMu2Rm5++ZCtOZEMyM3b7jWELwp3KtDA7tR7aa/KoKtwFrB0nQIsxZ/F2139DwMBro+ncWPNMEpTmfgur8bgnAa7sdEdGDjcF+ivJjLxlLGyV+Pa0UgVRfhFcWAr1+WsgPKOMwFFaA/4Nf515ZxO6WHJ+oZ1t+ogP1Fj8SAHf+nsBp6Xx16fKH86rnqHT3XGENevMkg4GQvZ4QLrcls2NDT2kUGZZ3vehmkQn8DKMac2GOsKgaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlx52PnlxUj9+6uFVLh1FvqCeYieCrxE8MHp/YmBxzo=;
 b=zFYy1ck42sVH11/wNoMm4XfCZaTC6p+MDFVLnVNKgX/apKrm5yIWa1KeStEJsjJNPH8RtJFCpn/7ry2vy6V0wQhcRCVyW7rt0zDGDULWGp0zSv3yeBzIe1FWEJwwUsYM6BP15OYdy80KMcgwdDWq8mXOjFEfSe89jJcqtiARJHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA1PR12MB8540.namprd12.prod.outlook.com (2603:10b6:208:454::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 05:07:35 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 05:07:33 +0000
Message-ID: <9d5291d6-9e1f-4df4-ad0b-ba7543d8a2af@amd.com>
Date: Thu, 22 Jan 2026 10:37:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer dereference in
 amdgpu_gmc_filter_faults_remove
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Jon Doron <jond@wiz.io>, stable@vger.kernel.org
References: <20260121182447.2434085-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260121182447.2434085-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::7) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA1PR12MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad16bfd-8f85-4d84-7ae9-08de5974262b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTZzb284azlHZEhxSENYODVSZzFhd3NaZnN6c2k3TXF0MHlVS1g0RW93aDdU?=
 =?utf-8?B?M013U1UwM3VJVDl3aWpZd3N0RTF6ZDlORGQwdlFKY0FLL2lUVkJxQ1FTZFYz?=
 =?utf-8?B?YU92Sno4aUFhN01LeHRmWHIzeEdyaFZQRDY5Z3VYT21VQ05BL2tZSkNHd3Ux?=
 =?utf-8?B?aU41U2VLQ2NUVzZkZExLM0FWWURZZnlyR2l1OGFVdE1TanBoa0t4MjRTQlgx?=
 =?utf-8?B?TjNPWm1kZkY0TGEvV1BmQktFeUw5Z3BVSGFWeUg2dHVZcFJNOXBGcDNqUEQw?=
 =?utf-8?B?UWZHdTd2ZDBOQSs0dzlRaHVnZ016OHhqNlZPRFRhTFpwY0ZTS3dhZnNmRU9X?=
 =?utf-8?B?Yk9vT1BZd2JENDIvalV4M1JLZTQ3RHR6NDRpajM1MUljbGh4NHpCTXRDUHFP?=
 =?utf-8?B?dHpBb0MwMitzVXgxY0NyaW51TzE1OXB2dGFDRUk3V2lNb0FPeWpyRFpJc0RY?=
 =?utf-8?B?Zy9YdzV6U0EwZzlPaml5dVlZZVlFL3YzSm9iRXp0NUVQQW93Rzk2dzBwV2VT?=
 =?utf-8?B?ZTJ5Z1VJSjhjcUhIek9GUHMySUk1Y2wybE1FWVUwOXk0dnoxa0ovWDNlWEFD?=
 =?utf-8?B?V1U5SE41R2cwTHJGWGdnWU5OVGE3S21SZDEwS1NpRFdMbDJOZVNpbE1OTHlv?=
 =?utf-8?B?bE9USmltaWNvYldSU0pEeDVQZkcrcDh5U2xBRFduTHhubWI2WU1VczdqOTg3?=
 =?utf-8?B?eGN2MU4wdTA3VGFmWnFFWEc1cEdGbXo2cFRRK0U4bkU2WG5mby9KTG5sdHNa?=
 =?utf-8?B?eTlMU3hyU1oyQnpNb1JQU25YT3JiUE5HUGo1eDRObXJPOEhiNnA4alRRU2hv?=
 =?utf-8?B?bWNNTXFzd3l1V1FCQ2pFcmlMQkNxUjN5ck41U0M3NU9vdUVXb096QldvZXFL?=
 =?utf-8?B?WERWSGI5WThVa3FxSll5YVZUR2FLYkhtWlQ3b2EyTUNmaHpmSDJOOFA3MTZw?=
 =?utf-8?B?TlRYaE5CZ09sRHlvOERQaHJUWVJ2dGJTUFAxUGZ0SjdNZ09MSjNnTmlVV1Nm?=
 =?utf-8?B?Rzc4VHI5eTYrRkZIQVh3VkQrRDJNNy92d3hoaFRaTThGa21STFBIMURtTElB?=
 =?utf-8?B?VnE4L2xqT1dqU2gzZlZCQW8zTW9VK3E5dVowWVFzVEx4WENZei9ud2lHZDBl?=
 =?utf-8?B?b2lXR2hlWUc5L0w1R1V2VmdYU3d1R1dtbzM1ZDA3MG11aDZGVForSXVQaGRR?=
 =?utf-8?B?TWpVNlRjcmRxUzB6emlCR1lJRWdQNjRkRG5KVWZHOXIvamQ4SmpSTWFNUkdD?=
 =?utf-8?B?d0EwL2EyOGtYNmVBb29EdmdwRGhTY3U4eHhqbzJEOE8xdVpKdnV0T1ZEaTB0?=
 =?utf-8?B?ekMwOXJyTm1BenlHdHhVQmxxVG16MVgybmhzNlJMRW9qWGQ1enNsK0J1d21C?=
 =?utf-8?B?SWZPeHVKWExxb2FMUVlnZkJpS0tOVHE3WDBVdFg2ZSt2REdkeGx0MnJGai9i?=
 =?utf-8?B?bDgxTEtQWjdQL1p0bXVva3lXZlNhREttNlRoVC9WMWdlM3pWdmxKMmFiV2Y5?=
 =?utf-8?B?S2Z1R09WMFVzQkxRZ3E3ZUNBYlBVeGVhRm0yU2xscHdxWW5paGwrWG9xT0NL?=
 =?utf-8?B?VHJtTCtBS21kcTFJVGxtcG5RUW5FL082SmpvcUZtZ3BQdTNSUGFDWGhobDVP?=
 =?utf-8?B?ZFFLR1MzVHZPVEdmWVBTWHZzYmV6OC8wZlhKUVI2SnZ4Q3RDek9xVnNiYXlW?=
 =?utf-8?B?K09tMEVTR3MzSzIzVEI2b00xd2dXZjh2OWRnSm1aT0F5bENHTXYrTlhWYkNi?=
 =?utf-8?B?WmYvL2dYU1lwSkRoV0dEWGFoWlhyQVBxZllVenpMbFgrd1VGZlN6TTJWRXZn?=
 =?utf-8?B?bE1SR0ZydVZ2Z0tTSTZIVDJzcTFITGV2QTBKZ1NVYnc5SlVqQTFJT0hPcHky?=
 =?utf-8?B?Z2RPMW9qV3dQOWJoSGR4TG9MbEVJS3JCcGYvUXM5T1ZqSVdvaCtrOFltaWNa?=
 =?utf-8?B?cFNnWm4vSHZyZ1V0b2RRZ0kvMGZVdkR1aDNad3pFVVFuT0c4ZWpUWkdBWTRX?=
 =?utf-8?B?akU2bzErU3BoTENEWWxSODdoeXVRRTMvMFNrZTV4N2NnVVgxMDJscURDa2NC?=
 =?utf-8?Q?I/iDDa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7091.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHJQaVZsMGl2NkRpZHdBS2lFaEZOMnBELytVczZmRm45VjFDbUw5YUtpcll6?=
 =?utf-8?B?ak9KbzcrVHYwR004NDRYUWRSbEh6WmFrRE1OeVRNbGExT1ZlSWI1WTRlUWxW?=
 =?utf-8?B?NWZ1OU9ITEFmSk5xVXBDQkZ2NkNpbXJxcWdHZ2Rsa3kxTEs5VHR3dkVhZHp2?=
 =?utf-8?B?dXZlWDZVeGNuWDhGUXlLbGZSNk4vS0ZNYUZ4OVZ3T0N1enEvZ1RZeHZ1MUNE?=
 =?utf-8?B?UnllUXZtdGFtRTBLWTFRTkVBNGlIU2x2MllHV0paSFZkRHNsSnVIMnZLcHFY?=
 =?utf-8?B?ZFNOS1FTSHF3VTBHc1lrUW9RR3FtSzBISFFsdlRac3lkdDNuN1BYT3p2ck9t?=
 =?utf-8?B?emc0YjFQd1NFbUV3TUw1YVJraWI4Q3dpelpkaWpmaHkxMEs0eVVEdjVzKy93?=
 =?utf-8?B?cnU3RkRnTHJMQWNTeHlrSldsQ3EyRWkzOE53TTVkLy8zdUZCR3F4NmhkdXoy?=
 =?utf-8?B?WktnaG5YV2RVcFYycmVmS0NlMHg2Szg0M2hJMzVVTWZUZ281WjAwZmc0T2Zt?=
 =?utf-8?B?ei9JcFIva0Y1cVRkdHRrSVNjM1pHeU9HTkpIdXpzODZtQW9taGtUTWtmZ0pw?=
 =?utf-8?B?dmRxQzNNdng1Q3hUd0dWK3ludEpaazlUNzFNT3FCakN1em9KSTE4S1RRWVJW?=
 =?utf-8?B?QUdESjdrd3dZaFEyZHN6cC96dTY4UHFZN2xTOStQeUtwV3NpcW04UEhVbDFY?=
 =?utf-8?B?cWljRWRBSmFtd1YwZk9tOFZhYTlTZWFrT2psZDNpanc3MUtWY1VINHBtNmZ4?=
 =?utf-8?B?Wi9iczZzbUx5T2t4SDRhQWlXSi8yMnQ1dGJzTmJmek40ZFFEY3E1d0JadnBV?=
 =?utf-8?B?ci9CeS9XQStpeDlQQ1NxVkdDbHpxV2I5TGN5Q21iY0dYakpMWk03Z0RqeTJT?=
 =?utf-8?B?Z083WkdkM0hBeXQyY09ucFk3WkVMelhxZ1NsbWpFRE9LTzUwVzNvNWZRQnZy?=
 =?utf-8?B?Q3Mwc0F4cEIxaU1WRlZzalV2eXEyMEpOa1BMR1QzUVdISllqNGUzVmk2TGQ0?=
 =?utf-8?B?OHpIaWdwbzF3WlljVk5rbFlGTnZyT1g4TW9kNHZOTHZxdmZCdWJ6N0lQdnY2?=
 =?utf-8?B?OVVTc2I3dGpkNC9jUGxaNTM0NExFRU1mbG5aMk1EQjc5UnhCSVdGWjlDajhw?=
 =?utf-8?B?cXVKK1Z5NFRyczlkd0xEWDYrZ1R0OXh3YjBhL0tJeStpKy90clJuUHkvbEdT?=
 =?utf-8?B?a3RnR2N6L1BBWUN5UStzcE5iNm5vbm5Yb1o3OGhGaStRTTVtU1ZNUU1CYVds?=
 =?utf-8?B?UVQrOVltUFpYU04wRjJtM1JtY2ltSjIzRWROd3d1T0pCc2pIN28ySU1GM0JX?=
 =?utf-8?B?TGY2QjRJQnl2anZOVm0wMkR4ZEJ4LytsNGZCYjQ4ZzkxS3AvT3RTRHlrdTVD?=
 =?utf-8?B?NUFiWjZQSlQzeTl4ZytWdWg1RWIyTHRtaU9ld2JsUEtzRS9hSkJUQUJpb05Y?=
 =?utf-8?B?OUVUWDZUeUFpOFBHSzRGQzZGUkppYWJSMG4vL3h1YjV2eWU3WmRJVFRXZU54?=
 =?utf-8?B?UmFma21sRHJIRDYwMUhyWjhTc2IxanhXazk3WG1wY1FSUUlEdis3akpVYk9y?=
 =?utf-8?B?WXczUVpNODVDclRnYzVRV3d6YjJDUVNhT3VneFJ3eldhUjlKRlkrWnUrT3dX?=
 =?utf-8?B?a000OE8vTGJVaVBDY1ZmTS9WWis1QkVyNGlpK3VQdGo2YzgreVRScXpwNDJi?=
 =?utf-8?B?Vnl1L2VweWVPYm1DT3V0R0RIS1gxczBzQmtLQjgrZ1VLVVJHWWV5OS9haDRZ?=
 =?utf-8?B?MzFFVUo4Umh1RzVuWmxsU2JzNTU5dGJOSVArTHczU3E1RTRvbGY4L2M5YjI0?=
 =?utf-8?B?VUdPQU9NdEo0Z2RTbll3c2h4SW5VSXNHRDA3Y1pQZEg0azlBZDZieDF6TFdm?=
 =?utf-8?B?UHJ0SlFvbXJpNXpFaXZRc1c3Y0VZRlEzWGlLQjl2KzhyNTJXRUl1LzNJVzJk?=
 =?utf-8?B?Njdxc2phQ3c0YzRRblp2M1hPZ2JmbjFlNTJFUWxzcklvaUV6VFIrUHhwSTBu?=
 =?utf-8?B?M1h6NTJjM2tkMkczVUNRVlRZc0ZieHEreUFoRlJXdnNrYkdnMnlvUGJ0a0Za?=
 =?utf-8?B?WFdEekJES1hsZ1BQYUxQUlUvZkplcXhWWVFuQnJpcDZzTUVBWERGNHNPKytm?=
 =?utf-8?B?V2h5ZlJuMWdQaEl5KzBWazc5M1BadDg3YUtsckZ5UGV5cUIyK2h2a1NhOHd0?=
 =?utf-8?B?K2pBTE1FWWI2NlkxdU13RS92Zm02bGJvQ0lkUUdmUmVZaUVuK0NBUGVwSGZV?=
 =?utf-8?B?czljU0dTazhObU5KdHhiNnJGbldmOXFzQWhSWWt3ZWNOWFNzWGlMYmgrdnRL?=
 =?utf-8?B?NWsrajBXbEppakZxK2xyVXVTc1BUMmROZjRnTmJDbkhZT0FRRWxsQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad16bfd-8f85-4d84-7ae9-08de5974262b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 05:07:33.2537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvlR3IteD1+SlND8GRhiW1W+RX7IiO/alp4YIT3k7V3kLttIrmA6NhmWrQu8LHNU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8540
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211195-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[amd.com,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lijo.lazar@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,wiz.io:email,gitlab.freedesktop.org:url,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: E877961ED4
X-Rspamd-Action: no action



On 21-Jan-26 11:54 PM, Alex Deucher wrote:
> From: Jon Doron <jond@wiz.io>
> 
> On APUs such as Raven and Renoir (GC 9.1.0, 9.2.2, 9.3.0), the ih1 and
> ih2 interrupt ring buffers are not initialized. This is by design, as
> these secondary IH rings are only available on discrete GPUs. See
> vega10_ih_sw_init() which explicitly skips ih1/ih2 initialization when
> AMD_IS_APU is set.
> 
> However, amdgpu_gmc_filter_faults_remove() unconditionally uses ih1 to
> get the timestamp of the last interrupt entry. When retry faults are
> enabled on APUs (noretry=0), this function is called from the SVM page
> fault recovery path, resulting in a NULL pointer dereference when
> amdgpu_ih_decode_iv_ts_helper() attempts to access ih->ring[].
> 
> The crash manifests as:
> 
>    BUG: kernel NULL pointer dereference, address: 0000000000000004
>    RIP: 0010:amdgpu_ih_decode_iv_ts_helper+0x22/0x40 [amdgpu]
>    Call Trace:
>     amdgpu_gmc_filter_faults_remove+0x60/0x130 [amdgpu]
>     svm_range_restore_pages+0xae5/0x11c0 [amdgpu]
>     amdgpu_vm_handle_fault+0xc8/0x340 [amdgpu]
>     gmc_v9_0_process_interrupt+0x191/0x220 [amdgpu]
>     amdgpu_irq_dispatch+0xed/0x2c0 [amdgpu]
>     amdgpu_ih_process+0x84/0x100 [amdgpu]
> 
> This issue was exposed by commit 1446226d32a4 ("drm/amdgpu: Remove GC HW
> IP 9.3.0 from noretry=1") which changed the default for Renoir APU from
> noretry=1 to noretry=0, enabling retry fault handling and thus
> exercising the buggy code path.
> 
> Fix this by adding a check for ih1.ring_size before attempting to use
> it. Also restore the soft_ih support from commit dd299441654f ("drm/amdgpu:
> Rework retry fault removal").  This is needed if the hardware doesn't
> support secondary HW IH rings.
> 
> v2: additional updates (Alex)
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3814
> Fixes: dd299441654f ("drm/amdgpu: Rework retry fault removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jon Doron <jond@wiz.io>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 8e65fec9f534e..243d75917458a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -498,8 +498,13 @@ void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
>   
>   	if (adev->irq.retry_cam_enabled)
>   		return;
> +	else if (adev->irq.ih1.ring_size)
> +		ih = &adev->irq.ih1;
> +	else if (adev->irq.ih_soft.enabled)
> +		ih = &adev->irq.ih_soft;

Faults are delegated to soft ring when retry_cam is enabled - 
https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c#L541

That matches with the original logic in d299441654f ("drm/amdgpu: Rework 
retry fault removal").

To match exactly with the logic in above commit, I think it should use 
soft ring only when retry cam is enabled. Presently, it's returning 
without doing anything.

Thanks,
Lijo

> +	else
> +		return;
>   
> -	ih = &adev->irq.ih1;
>   	/* Get the WPTR of the last entry in IH ring */
>   	last_wptr = amdgpu_ih_get_wptr(adev, ih);
>   	/* Order wptr with ring data. */


