Return-Path: <stable+bounces-249362-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJawD0tdC2ppGAUAu9opvQ
	(envelope-from <stable+bounces-249362-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:41:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A9257262D
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFFC5302D097
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BC234BA42;
	Mon, 18 May 2026 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E3eV7hHD"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011011.outbound.protection.outlook.com [52.101.57.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC134A76E;
	Mon, 18 May 2026 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129372; cv=fail; b=ONOWpfa1H5h+krVyO77aKqEZpSTumSFvITKLNIMkF4RuVvCZ9fDPX+AZFQajy6Jz65iqDO735sm4AL6LbUIQ4SqwOkJzz7+iyZAR5jEHsqrXQlKt3n7mzNbM/9or/N3u3yan0zWWvys0/LMWZlQAndfIk3mHmOu4n2h4vCWKEtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129372; c=relaxed/simple;
	bh=GC3U40mWEnNl2jXalRkE8K1TgYPjOTqF0CXB33H+B0g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kXBGvfgJKU0ZX7wk791gtXyLksY9KhA4G5Shlm8YAlrEyjNgvejUyoxI/t4cJwQDz655R9K+59wlCft1J5dnjdTSpxmq0ndtqxbrikD+L53avkL87bhAYoZzXP2hudzEL4twmOv5gijE/sw+obtL2o4Ayo4/ZqdnpYBbjhyW1tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E3eV7hHD; arc=fail smtp.client-ip=52.101.57.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVxMZELzTtJfBDcPfk3TABgHLXdD2xAZTgubp25zHLTKDRD4KqAgEn31qMJkHm1/VFSB1xPLLlxuJ+F+khfAW3Ee+um9sjwsQ49klP+tLvOtQOyWhDugwVvb4Km18hiHQhvZdInWReF+D12iWOsF2x5DQzQil8KCPXDkJobMgKPE/HHjQwX+ivhxofQwqAuZKbANpyGyI4mKj4i/iCHyj6ssXOPSc58Auxrinu5FBDfSY6IW15eA/M+XZjVj9sqs+GXAm8eeD8uTGnYrNmjY3qez8Rd1bonuzRSiJGDrxQuCVsaWfTGBP8oDY6Y9UfFmsrFmuZMiTlL05IHveKpmbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFN77vBD84VdFY8hMET+OtS86GWCduAmYRkSo0u8aFM=;
 b=GFo6VX7vi5JsniUqf5dKrDtEOJ/ohv/esO/HUkNcz5HiTvNuvw6WrtBzpsAzpsEeFHyEOCJRg9x22WpLrosbbLEwdZ3Kbw2NRHon0rRdn9f7eg9GHrPAm3xNfhDv8Jt/8ZS2uMqsVPWYIb46R3r5/cDnLBXiV1SHPmXk8vMUdw0fd+WNUu9C6MymKUkZQW3XLTdUkgW4R5QlJCCbyLjskjEUuR0zcyx6XjgX70+8zv2Lr7RuNARV73jl1qjfCNMukAhqb8Q3OAmgF1wqa+glAqVdRd76dAQUhil4S5phCmqoy0bzewVJSARrGb+qDVRc2TTHcI1qGYGTTKbhsFJ68w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFN77vBD84VdFY8hMET+OtS86GWCduAmYRkSo0u8aFM=;
 b=E3eV7hHDwB4PvuZ47l1DAFk5cLh5qItvTNJa7f3/i7C48vNh2WncUaNk80mhmfMitE2KlyNwctM7al0iVuVmIqG3ZJEB8YP34HTzTgfwI9khVpXM+ogITVcIoLNRkMKdKrGd6K7ZkOGiMisparGArSNnbsM4hP3OWTTrzSwp1Us=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 18:36:05 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::4eda:ca5:8634:5b27]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::4eda:ca5:8634:5b27%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 18:36:03 +0000
Message-ID: <d49232e8-304d-43ef-86f2-11bde2170250@amd.com>
Date: Mon, 18 May 2026 11:36:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fwctl: pds: Validate RPC input size before parsing
To: Heechan Kang <gganji11@naver.com>, Brett Creeley <brett.creeley@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Dave Jiang <dave.jiang@intel.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260517062232.1858747-1-gganji11@naver.com>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <20260517062232.1858747-1-gganji11@naver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::16) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: da5eade0-2f78-4c38-8e28-08deb50c50b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	5Qoek3leTg9zb0DDplCSChtstvmfE2vBbnVnuqST2lY8EX2GNPvdvzIht2q8MDe+JQvvfUsEh1hP23zTLx6/rSdLYnW2qEjcj/MIQDXxz8t/KVhYnWZrITOdSw3/PYFIU3hBrLuebFJPvg3KQX4ZzP7Xbsiiu8rGp8ztEuJZodoePKt+AtWuIvDeh99WFW06G0ihDJ8jDi7/HSTwC946lrnOANpPvAcDxbu5UyIrk9jeLwp1CJQ3oKoUpUTStInBdhQrz5MRC/Z89cbP3YGiY1UH6vhdIzmzOwjSf7IPiJsvdNq0rut1lPEwb9YSVZVo2N6zTiqfrkgIpWFUj8F2B6qUL72TZ1xRDvXTnKkq/UyZVcA075SnLvC7sxExLTs+Dbt7qGeoNVAtjznrtKatUhj8vIutltkDYuyExNxI5s7mSe96ZS4Ta6V0VhkEtuA+lrxcS2Ky/tvagqJSSW3nhwoLOGRH51IGOPf2vc09ErMR6tuiVT8NU5O8bEDXrvk/cJB6VKmnCQjhp4/Oj1Qto5XlfphTWeGv0B1Rf5ULzauwZ8CF96g9lxjtExI9Y9Bubwr6peQtsRH/WDjYliRE8K4H4h6zG7arPqtj3xRQJn9K6wBslohMbgPmqXjeg/i4owxSnyPy2gwiMLswY9nP7nuGQcIRYkbORp/ebN05QWDT7ooi7uG3P19cGmLYzBe7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXdWM285VUkzTFVoTmxaOFpJbHJLVDhsNWlwa0dLMzVPVkw0Z3NDZzlMejBU?=
 =?utf-8?B?THhQMVd5VHZDbVJqMkxpdmUzZkRpMzNGbFdONEdKdXZocXNuejFleHhhTUJB?=
 =?utf-8?B?UXlrSjF4S3VNRVExUzF6R1BoQ3d6a1YvYTgvU1dwSHhRT1NMMEw1UXRrQkVB?=
 =?utf-8?B?MFNSK0VZRCtZdUY2QmhQYTZBZ1EyZWNBbDZrMTRXQjJOUW95RnBjQjBveHE2?=
 =?utf-8?B?N0NYUkdqb0xGVU5FOTVzVnluSzRwdHJSdU1kcVMzUVhZTFN3MWZkSVhseTFp?=
 =?utf-8?B?REliTjlKWGU4OGdDM2VHUzlycmxQT0lDVnJpdmVaRnhscXRlOEpXK3gvL1N0?=
 =?utf-8?B?dWlkY2U0cnl1SEdBZWpyRmpMUkdwNU44L3BjOHg5ZFl3eDJXajYxT2d2VEc0?=
 =?utf-8?B?dG9FTFdnbG1lajJzZ3o1Z09GRWsyZXhBRVF0bTByaW5lSXJGNE9kNmczblZz?=
 =?utf-8?B?S0FXNHA1QUlEUE1ETlB4YzJDR0k4NmdRSjQ3Ri9UNk9YbittQU1PNDJNMW1Z?=
 =?utf-8?B?REdtSklWN25MTEVGai84TU1VT0dwNmRkVXloeVU3N3F3U2ZEanNSdjN3Z0FT?=
 =?utf-8?B?WnFUUlpqQVJ6VTVOU0VrWEY5WWY1ZmtqZ1Q0c05wQ1E2T1g0SVVyaUVKTVQ4?=
 =?utf-8?B?djBjdWtGT3hpZjhUYnFDNUM2dkQrVUF2Y0s0M1VWSFRJSWQ0QXZrTENPdlZU?=
 =?utf-8?B?Njlta1B0TlNEVWY1WDB5ZUZycWs5TVo5cjJ6Z1IrUlBGL2t5UnpHaFJ5U3Rz?=
 =?utf-8?B?M3AyRWZSUmdkSWZIaTRndSsyTGRWZ25zdU16bDFEVk42TzhlUXZzYkpYbTFV?=
 =?utf-8?B?OUlXUkpKd1BoOWZDT3hOalNnYVFya3hKb0RhYk1BaDNFOHN3eWxiN00rTUlR?=
 =?utf-8?B?UUs5UnRCeVdYSXRSL3FuV2VEekNWS0pJTlVwQ3lreVpRbWErYUptbzk1MEM5?=
 =?utf-8?B?UW9pTFREWXBvT0pJODZNSGRqdGtPMmRaUHJXWnFZdUlMdXpTZXpuZmJ2cmNp?=
 =?utf-8?B?elZMemVsb2ovVGVnaWFqMXlHTGFreFpidTcwUWlwaUtaUmNVaXdBcEZhUWdy?=
 =?utf-8?B?TVo5MC9BaTdyUU9YNE00NVJsMCtRWG51NmQ3ZEVWdEd3YjlSOEdNUGRaSEQr?=
 =?utf-8?B?UXNyRjNpYW12V1Q2Mm90YjVrNWxvSndJOUdSdkhNdUxWUkMxWS9KZy9UcjdV?=
 =?utf-8?B?dHNFc2JxRWpzeC9NYTMxckJnVWszVVBPQ0pBdllDLzMwdjRCeWJCYnlIV3Jq?=
 =?utf-8?B?Q2duVFc2Q1M3ZG9QSDljNWI1OXRnVFNYQjM3dTRHdDMxNHlIRlF2akZDTVNj?=
 =?utf-8?B?VnIzYVpLZnpscFgvQlgvTWJzRDNqeWQ2MlRmSUZIL0o2L1M1QnQzV1VSNWZF?=
 =?utf-8?B?ZjQzWUpuWnFuRHZ2aEFLUWE1dmloaWNYY0ZIRThJWFZkWUgremtxSWd4SndI?=
 =?utf-8?B?N2YvTmxGUDJQb3dCT0tKeWdhVU1zMjZXa0sxdGNxNCs0VkUwUzNoL0x1d3pI?=
 =?utf-8?B?aTdvVmV5eTJheHJNL290Lythd2NQaEwwS2lUazg5OWQ5Zm5zTnI1eGJOaE45?=
 =?utf-8?B?OEM0L09NbFVvbFR2TE84QnpGR1kzMUNzc2p3aTAvVk5XaHFURUdiT0FDWHZW?=
 =?utf-8?B?MUp1YzVtTEFsVC9MRjlPVVQ1TVMrN3I2N1JIT1RFV2xwa2pHR29pdjJQMExN?=
 =?utf-8?B?MVI4eUtLS2o5MmN2WWJQTW41a1cyWXM3QjdGSXRiakJCdUtXUWYzcUI3dElK?=
 =?utf-8?B?ZUw5SEZwb0lFbDg4V2ZxNWlqdnJIdG5HcW9rVk5VaTBQMElYbHU3d1kvTjVP?=
 =?utf-8?B?R09TSVpzSGtCa0lnV3oxUkJOSDVJOVVSU2FhcndmZ2NJL2t4RkxjVXA5eHd6?=
 =?utf-8?B?N2l4UU1LVTB5cklQcDFEYyttMHFGYnpQUGRKT3JocWFuTmx3bmNvUFlTT3dw?=
 =?utf-8?B?aFhGTnB3czZOUU1pZUFJbzdxN01kZG1yM3kvS3FDTkxrQUgrV3Q3T0hXczgr?=
 =?utf-8?B?Ykk4aW9DNzV2RU5ldjlDL0c4L3NuZnFrMk5yZUJIYzhidDF2V281TnNwVHRm?=
 =?utf-8?B?dDZYOHF2bGdrRFd6YjBKZHlkbDZJYkJSWVp0M2xtUURsSDJJd2JacU1PMC94?=
 =?utf-8?B?Q3ZUbVFqazEzQXN0bnh0RVFxejl3bllhR05hS0lLT1c0NEJFa0FOclY1U051?=
 =?utf-8?B?NndUS0U0aVNGZ0JIbDF2SXFZV1ZnY0NPeDZDaXRDazBiR1JSN1VBaDE3M2pH?=
 =?utf-8?B?TzEyZFVxd1c2T0FLTDJGVVZpNk04SGNSR1BqNkViTzNLS2lHMjNDUjZhNkpJ?=
 =?utf-8?B?R1NReHZQbUE0QlkwUDNNeENFS25IdTdpS25JT1BzMXhkV3ZLbzBtUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5eade0-2f78-4c38-8e28-08deb50c50b3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:36:03.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRu8jiMXIrZNHb85IIjDUjzUat6mDfp7WfyKr2P867u+mmotOK4WODEsMy7HcnNxVenMGAYJHNuUStM3mBlVEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249362-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[naver.com,amd.com,ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcreeley@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:mid,amd.com:dkim,aka.ms:url,naver.com:email]
X-Rspamd-Queue-Id: A4A9257262D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/16/2026 11:22 PM, Heechan Kang wrote:
> [You don't often get email from gganji11@naver.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> The fwctl core allocates the device-specific RPC input buffer with
> fwctl_rpc.in_len and passes that buffer to the driver callback.
>
> pdsfc_fw_rpc() casts the buffer to struct fwctl_rpc_pds and then calls
> pdsfc_validate_rpc(), which reads fields from that structure before
> checking that the input buffer is large enough to contain it. A short
> in_len can make pds_fwctl read beyond the allocation.
>
> Reject pds RPC buffers that are smaller than struct fwctl_rpc_pds before
> parsing any pds-specific fields.
>
> Fixes: 92c66ee829b9 ("pds_fwctl: add rpc and query support")
> Cc: stable@vger.kernel.org # v6.15+
> Signed-off-by: Heechan Kang <gganji11@naver.com>
> ---
>   drivers/fwctl/pds/main.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
> index 08872ee8422f..68fe254dd10a 100644
> --- a/drivers/fwctl/pds/main.c
> +++ b/drivers/fwctl/pds/main.c
> @@ -362,6 +362,9 @@ static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>          void *out = NULL;
>          int err;
>
> +       if (in_len < sizeof(*rpc))
> +               return ERR_PTR(-EINVAL);
> +

LGTM. Thanks for the fix.

Brett
>          err = pdsfc_validate_rpc(pdsfc, rpc, scope);
>          if (err)
>                  return ERR_PTR(err);
> --
> 2.34.1
>


