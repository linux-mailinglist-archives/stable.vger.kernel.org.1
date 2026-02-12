Return-Path: <stable+bounces-215988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAtdK+dDjmmPBQEAu9opvQ
	(envelope-from <stable+bounces-215988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 22:19:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 121F0131341
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 22:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 584F730E4A5C
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 21:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8608C2D320E;
	Thu, 12 Feb 2026 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="J66TR/+3"
X-Original-To: stable@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020076.outbound.protection.outlook.com [52.101.191.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB30233704;
	Thu, 12 Feb 2026 21:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931171; cv=fail; b=J0LDvLXZGaTvEglotshUQrLt8+F8bzPu2RkVJ2UDqQ+QRGIOzTDKe04cnBvyjftP33rFwlzLOnOvETnVjuwP057sK4J8WL1vt99De64Q1irSVDDOIO75jSjmKLmTTO+eLABtmcJWJ66zCvo4plNmwWAi1e6EEx4/aBolofpBLc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931171; c=relaxed/simple;
	bh=/TtEIukeyTiwbRcEpsNomdPFJBUHa3KxcJ7PPevLumU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rQq2WZObOx943Oy+eQ8ZjVpTudIddOw/5ecJ1K4gDh+GMBhi9i1+CGlcxUTmNdFoZQMcNR3QTlIzefB9YfXomu1Q9voxgZW67G2J2dVphaolbZlkRIBu10zBtUpM/NLqgqMEqzaCgWPBxrticZ6c43Mvg4/DXvh8NjwhpcPmSvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=J66TR/+3; arc=fail smtp.client-ip=52.101.191.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGNqFXP7LbIyjfiXKJ7dH0T+B2qDmBhhn7G0+m1EERRpSbWi6ai1M/ijPbYBPYgGROD/J6YK0za/Seuv+ol6U7nNUllM334pbmhOm/A53xg7xObtulsoLCEKnZ23UZ0VC4MXkEWjyGwPvx+HNQ6KjhdZIX9v6MPgpHmhRDJ8/4xl4JZk/xEiy7AUvbY3sFUc4mo1r1/U+a1/aZ/7VB9zGCn/Bnt39/Z30won/IysshhWAOYc/EtKg+C+cJUD8j4sBLoJyA/+pz6clGrp3C8V0a4loDCl7NtivpjgN/qGRFVHMpOpGVKO2mKrzoS0aK3NeOmMgD7pupHHa6NvRnAykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5Az7360PGaeC/jnaMrJNiZWoTr+rzyHgwycjHXl208=;
 b=tbdxuO6Wyh2mpawKW+4qKB7tAqUkpUXqyDpyzeFu2tWZ3i327ox4FAFc5lmEuTgBraMoDO9PhuYhHhdAtOHEppr7lnmFgZpmV7osAq2qHpLQjEnVvaY1LRgC47zTbB6K2q29WWdO9eO1jznRgUsQBedF2b6+AJpGhOxGZHu7RBTbS3o+iRDKCns25E6Kr1yj7IZ9zrWToSS/4YUsFdvIBmPaB/evajxPMcxuSD1GF8VvCpqaMoSafvD5z0MUHpyMhJ8UgBPbNBgCOhf8P9c4Rg6gkXhYiQo78X/RPWj0MC8aIsmzD9P27oUY7mdR/u9WwVW85SOKbNZi3uoXhCJMTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5Az7360PGaeC/jnaMrJNiZWoTr+rzyHgwycjHXl208=;
 b=J66TR/+3Ha7mt5Ow+EKRvehW19U1USi+13epRc30V62/OYJqAWU1VFiqD+ZQbIzUmpnWby1+RzctfTu4wPwg4II4L2BIXIGMAxtAoprUdd37d8NmssJ4VZTvuXe+IvxAUMzt7AcSEtUoj2N2Y+YpUmkQy62ST4SpV7Cn1y/yHr4R9vM0PQpq4VHlLXtVcM/ngn3DEiIxIbIELD0cDRlccTX7hI4jKhNQVPzGHqCKEg1b7jkenrOdjLQFLAFWuJ54YZZfs4easu+/4XlZazMVJixN0XySpXgY3XXIsBER5vYrfZurRFitp1urzRC3i8g3crXmtRPFfZkk7i1a611dsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPF36EB4ED10.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::524) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 21:19:25 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 21:19:24 +0000
Message-ID: <31feb490-c9dc-4cb0-80bc-951e9a6cdab6@efficios.com>
Date: Thu, 12 Feb 2026 16:19:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] sched_mm_cid_exit+0xe2: page fault on CID bitmap write with
 nopti on 6.19.0
To: root <admin@windowsforum.com>, Thomas Gleixner <tglx@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
 mjfara@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260212211213.F1BE52A1C1D@windowsforum.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260212211213.F1BE52A1C1D@windowsforum.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0029.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::15) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPF36EB4ED10:EE_
X-MS-Office365-Filtering-Correlation-Id: 6001c4f0-56b9-42d6-ba04-08de6a7c65a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OW1qdDFvZ0lPSS9ORkVKaVdJdURHNlVibndnSHZnL0Zvc3VheTBJQlJFeEpl?=
 =?utf-8?B?YkxOYlhJenJ1M2xoTUZpaEVrY3dRL0NGQXdhQlNtdDhzSFJIS3pGMkRKYks1?=
 =?utf-8?B?UUtaUkNxdm1tamZGZldHaDZ6Vko4ZmhxVEc5TXQ3TVIzVU1WNTA1VWlBQzQ5?=
 =?utf-8?B?c1l4dzV2V0JWekxleUhIc25ha2MxaitrT0JiS29SNzh5TmU0MGFvZTM3eVo4?=
 =?utf-8?B?Uit6Z2V6Y3piaFdOMGVQMWxNNWNaRzRNVm1Bc1FrMnVxSmw0VVBjditEamQw?=
 =?utf-8?B?bzJKcFI1aTVlOVcrN25DOU9WcGw0QUJXQ012TlA1N294MTk0UXpBV043a1Yy?=
 =?utf-8?B?RXBtbzBXV0pSMm5DYUhsRTJpdXhveHVmSG84bHp4QzByUG9lZExpZWVuZk43?=
 =?utf-8?B?aGoyam5KQlVjWkkxd2RZS0hlRTR3bXJma3dtb0tlcXJZTXl5N2wybTVjWGlu?=
 =?utf-8?B?T1FnOXg0cVR2cno3WDN0M0xrVUhPd1RPVEVDdzZHVlE3REZ2MVgrczh0OVI3?=
 =?utf-8?B?NFZ6Uy9NM252U3dnOW9kNEFXc0NVREFLR25IVUs5UjhqNWt1bmZ6ak1VczYv?=
 =?utf-8?B?aDZYSWhFS3FDVEJMbTVLTUtiYXpoMkFLUVN6ZE0vSkpHdkZmemJrV3VDQThL?=
 =?utf-8?B?ajk4K1RUQnJEUmRMK3gwV2Nsd1pMa0tRN2N6Nlh4NmpPMmhidEVMTGE2bk5j?=
 =?utf-8?B?WkpWNlBVREFuM3I0bm8vWEtMbzFiM0tLdVkzVHVmdytDcW1nTi9aTGk4MVIr?=
 =?utf-8?B?bWtCZDI5NlloaWNyQjFVRTJGVkdZV0E1L0MzbEVyOXJGWTRpS01EOVlCdmZu?=
 =?utf-8?B?ZFVWS2hwUnc3czkzQUt4S1IwbWg0Y3dmNVEzL2FEUUhyYUF0Q1Y1c1M0OFJq?=
 =?utf-8?B?c2ZTcE9HaUFkd3Y1emFrWGt2eDJCbHRmb25XNzNWeWNWWDRacjBneG1pdmhH?=
 =?utf-8?B?R3JSUWY5WjBwTFV3c0pRanI2OGxOSnk5MmtSNHRHRmRxL21UQ1RzcTJ2SkJW?=
 =?utf-8?B?OUxvdGVoSXlwQnlwRXlKM2dxUlhLbzByaFljR3VncFNsMURVSHJwWjBNay90?=
 =?utf-8?B?YjZFcjBXcWpsc0ZSNWhzVUZJUURqMUkwSndXYzI2dmoyVVZxVmdlcmRhWVNJ?=
 =?utf-8?B?OU5OdmhqRHlqcVRlOGNWdWRKKzVnNHlmSExMZmROYzNMMnE3QlhpbWdSZ1FK?=
 =?utf-8?B?M2NGU0VmMThLN0JyNGJJcHU2bmpFT0EzM08wYm5zMUxTRlRZbjB2ZlAwS2Iv?=
 =?utf-8?B?K0JSYlg3OTR2NDgxRmw2cGNXaXlPdk9UZnFWRXl6Qlhlb3F6QjdPTmczZS9p?=
 =?utf-8?B?RERacXozRkVFTE11WVBvRDgvc1ljK1Zwem9WdjFEaDRsb2hIQ2E5QjBhU0Nh?=
 =?utf-8?B?ejZBbjVFOUlBTDBkWSt6UW5rcGxUM0txNmVnR3hPL2dhMktFME5na2FzSUxK?=
 =?utf-8?B?YkNranUwVWF3ZzdQZWdWODIyaDBrMHd3cmhJTTQyV2ZTMlUxUWNLSmpEWENj?=
 =?utf-8?B?dkFQclVWQ2VSUE9GRXhXRTRRSjlGcHRmdkR1Z1VhTytmbTlqRFJGWlZCemdT?=
 =?utf-8?B?K3JNRlhBTUgreGVKbTlNQnJML28vd0U5d2dTZVdWZGYvdFJqVVNKYXFJS2or?=
 =?utf-8?B?N01naUFiRzhxK2lsbmIwMC83SGRQWjE2ZzBySmxNeVlZODRFQVlFMCtkZFlG?=
 =?utf-8?B?MlFBV3NRenNHa2dQMTQxZGVVazR2bmVBRy91bTNOSmVZS0taMmJndEtQNERN?=
 =?utf-8?B?akNnd2ZFQzRmaE43MUJBWGpXbWxpVmEzTHpIeTFMU1lQbE1YNmxJbEtCbXpr?=
 =?utf-8?B?ZjVhSnVPU0sxRm8zZXN5aGdFWE82V1VLUGFRYnlNOEFKRXRBQk9FcGo3RmFY?=
 =?utf-8?B?eWhoUnc5elNFQWYrMXRHSU1Cc1dTeGpDL0FsUGUzbEN5NXNMWGJuSFZzS1pn?=
 =?utf-8?B?YzNpb2Q4Tlp0V01ONjM0dmtYUzlsdTFzNHJkR0d6R051bk5XamYwYlhhZTNj?=
 =?utf-8?B?di9WbFlTeVFCNnJsODNHc3czbnF3MWxXWEs3Qks0TFRVWFNWN1gwZ0ozRG9F?=
 =?utf-8?Q?Kq46N4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHdiTkpuQ1FMTlBqaVUyMC9Fd2FWWWltaDJ3VW1WV251aGZhelJGSXRKSTZJ?=
 =?utf-8?B?UmYvaUlCZ3hlODR3YUhOOWEwKy9xdDlSSXUwbUxkWDYrNXRGc1ZLY1lIL2Jx?=
 =?utf-8?B?Q2luTmxXQ3o4RVJHSisycXRjUXpFYTdTdzZaQldMbEFQVmxIM3ZkRUdIT0RH?=
 =?utf-8?B?amtEV2RzdTFHT2VjZWFXbVhKWDNINlJRQlJoODhHRHk1RXd5TFdWdWJ1Ujhl?=
 =?utf-8?B?SlFVUXZ4QXNPN3BRMW1qVFRhNTM3dkVKdEhjVHdJYVpsRXBQSXZnbEYzRCtC?=
 =?utf-8?B?NC9TQ3lMSlBGZU1hM01yS1c0enBXWExJL3V5WjZlMDVkbmpNeTFSclpiNGJW?=
 =?utf-8?B?SHhoSGxTbC9TRUY3UUx6cjRSZjhQOFF3TGVDMHZtM05TSTd5NHRaU3QwN29p?=
 =?utf-8?B?N0RmdnhORVRsdk9tMnNWR2lPZ1RzVnN5Z1NCYm9DVmdDZmdtN2VCckVoNndC?=
 =?utf-8?B?dEVuMzNaWWdQblJvVFc3MUUvcU5pTG1BNTVUUndJQmQ4MkhIc0g4eDdDWDg0?=
 =?utf-8?B?SVV0Qi8rTUQvcElMQVozbGc3QXBYYlE4SHg3Y2hrcmpOTWxHdlVTdDRCek90?=
 =?utf-8?B?ODFYUjhNS29zSjhjdmRvTEJFeTQzZjI5SDJyOHkyZ214U0VkY0IzKzBFUmMw?=
 =?utf-8?B?ZHRnV3E1ZjhIenJ1ZkdvS1pac0ZNMlVqUmdGUHJ6d0lEdzhmdW1qckppZG9l?=
 =?utf-8?B?bU0xdXBBWWJXalRwZGVCTkdVL0xOWEt5b3RPcTRyS2Q4OU4weG9QcmFjRnlC?=
 =?utf-8?B?K1F4ektaM3pmTkQydjRqZDBmQ2JoWGJWanQzcHZOMEpwQ1BnK1hWTFBqbkQw?=
 =?utf-8?B?UkdXUnFQbWoyNUExT0FsN3cyNUlRdnd6aW1vRlJmQnhCTXh0Q3RqMG9tOXl1?=
 =?utf-8?B?UzZHcU8yVmpUMVpsUnh2RFJPZEthUkIvVm9ub2xuWExVQlBUeTRJSVU3Yisx?=
 =?utf-8?B?b0xMQnJqME9CUUJ3MGRkc1FlNU5lbEplbUNsUGQ1VTRXMkFJcWoxdjFOd2Rl?=
 =?utf-8?B?UGlmRzJpUGphSWoxaUs3WDg1ZGtMdmpqeTVzTkJ0U3hoVmtmS2Zad2c2Q3kw?=
 =?utf-8?B?N0VTTk9pRlFEVVpaeUN5MnFNV1RERC9SK284QUhLKzQrUktVWUNXWXhmSDJO?=
 =?utf-8?B?RTFER1JpUVBtaEJ4MkQwRnE2NnpUZ1FqcmR6ZVpvUzVjZWdvbVVLSnNzbkhV?=
 =?utf-8?B?emptNzBsTERidEQ0SUNCNFVjSjhJWW4yVmhBOUZzK3BneXJLMEg4S3hlZlpO?=
 =?utf-8?B?MmlYQWpnblZXQlF5MXRDUHBjQXZJcmNRSnptdnF6Vmo4S3F6OUU2RTE5WUZa?=
 =?utf-8?B?bHdFUzM1dW8xenZzWGl1SXRaejJEYzJyRDI1aVlHa2hqVjI2TUxrU3U3Qllu?=
 =?utf-8?B?VFVDMHVUVDBJVkFiV3F1bDlKQVhlaGorYlBIdDZTT3lsME9YT2hITStTM3Ns?=
 =?utf-8?B?aXZqdU8zbk5wZDBvQTBXa1VGRE41QWI2RzdUanVxUFdvU0pNV0kyMjIwUkZY?=
 =?utf-8?B?N3NKOVlmdkcyWFpzaEJsaGh6TkU4bVhEMFpFdm5HMEV4WktDSlBNQU53dFFz?=
 =?utf-8?B?ODNVSGFOeG1CUUd2VkhhU0Zza3hSOHFxOStENnFrbERJOGRjU21PNXpMSGpt?=
 =?utf-8?B?YjcrZTlrNGYrbmk0Mjk4V1EvY1kvY012cUh5ekxiOCtEVHRLNFFjRXg3WUxQ?=
 =?utf-8?B?U3ZlUjU0OGhyeUtwd2tJU3l3eWVSV3pSMGdEK3A0SXdEdWpyNHd1b3Iyd1ZP?=
 =?utf-8?B?V1hmM1EzZ0R0ZmFORUxtQ0tBRFJPQVI1bzN5OStpL3NkVFN5Z0xneHo3Zm9y?=
 =?utf-8?B?Wmd3STU0OE1sVjM5dWw2QnNybGtRYkozSE5WRkM1TUlKTEFkNGhna2FxYmhY?=
 =?utf-8?B?VDlwVXV5RWZxY2lxOXRJQlQveVpEbzZhNFZLdmVQSTZnRjUvNWo3dG0ranRy?=
 =?utf-8?B?SUloazVYMzVsenZ2d29zT0QwSnpBS3RNL2RBVTFDVGdwcHA0b05xaWhoMGE0?=
 =?utf-8?B?K2NtL1EwYnUxRk8wYzRzeVJhTTNrWEhLaE5CUHlQNlFZQVRrblNvU2JsOGVz?=
 =?utf-8?B?ejJJOFJmK0JVaVVCRzgyNUV6NGJOaEVTWGtHaEd2S242Y3ZvSWNYUEdGbnU3?=
 =?utf-8?B?bERjRUs2dXpkdGNDM2tzMFNOTVhQZE5CbnhkeEJqdWJYWkk4UE5zYk03NnVF?=
 =?utf-8?B?emM4Tm92L1pidGg3am84empsdnhtcDluaHcwRWpmYmNMZTkvOEhBTWhNVEVq?=
 =?utf-8?B?WjNzL3JRKzlsQTRybjJZU3VkS3pkZVR3N1pVZ1pGdkVBL1R3UWdDRW4rUDV5?=
 =?utf-8?B?VndQNE4wdFN1RkNhN3VXSzkvRkdhaVJGTXV4RDFwN25hOGh4eGVWbTVBemJQ?=
 =?utf-8?Q?Z3qWtI7lWGeOWB3U=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6001c4f0-56b9-42d6-ba04-08de6a7c65a5
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 21:19:24.8464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1eE7mia52B2Bp4OwR7aEZHmmhFp8WND6xTRpbFu9oaRsz0bRUUOXUjp66nrXRGjS0IF98cqHqMtdTXHG+iPAJeGP75238+wtlSPAGrKl4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF36EB4ED10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[efficios.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[efficios.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-215988-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,vger.kernel.org,gmail.com,linuxfoundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.desnoyers@efficios.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[efficios.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[efficios.com:mid,efficios.com:dkim,efficios.com:url,efficios.com:email,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 121F0131341
X-Rspamd-Action: no action

On 2026-02-12 16:12, root wrote:
> To: mathieu.desnoyers@efficios.com
> Cc: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org
> Subject: [BUG] sched_mm_cid_exit+0xe2: page fault on CID bitmap write with nopti on 6.19.0
> 
> Hi Mathieu,
> 
> I'm hitting a repeatable page fault in sched_mm_cid_exit() on 6.19.0
> when booting with nopti. The crash occurs during process exit
> (do_exit -> sched_mm_cid_exit) on an atomic bit-clear (lock btr) of
> the CID bitmap. The faulting address is within a 2MB huge page that
> returns a permissions violation on supervisor write access.
> 
> The bug triggered 8 times over ~20 hours on a single boot, hitting
> multiple unrelated processes (git, gce_workload_ce). Eventually D-Bus
> died and systemd became non-functional, requiring a hard power-off.

Can you confirm whether the following fix in Linus' tree fixes your issue ?

commit 1e83ccd5921a ("sched/mmcid: Don't assume CID is CPU owned on mode switch")

I suspect that it will soon be cherry picked into stable for an eventual v6.19.1.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

