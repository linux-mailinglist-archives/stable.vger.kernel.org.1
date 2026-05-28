Return-Path: <stable+bounces-255059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODueL3dtGGrcjggAu9opvQ
	(envelope-from <stable+bounces-255059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:29:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8945F5024
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFA5B3134AD2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B133F0745;
	Thu, 28 May 2026 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="uVfLewBE"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214D723D7F4;
	Thu, 28 May 2026 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984207; cv=fail; b=BEw013i9WKb2JzqLHOCDJiv8h+lv2iOfKDqnMI4D8Sb+AqZSjVGBuojknHPL8zZ9vLbBh40apSE/vD7yqMj7Q6PuZRCKHZBX2TcZ5w8RUnXHaRFdAVfUJfgzTj91v+5kpe/JRzeUFfHQVzgltqZ3ulwz6PoDJ2AYttoExEDvIpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984207; c=relaxed/simple;
	bh=VOWg7orddZhSwg/TQSd82RtSvyhARCCFiQUhGT1KUC8=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W67xabf6APlMLo0G6HrYKVIwG+BsxJuvLw/yw4B2dn27XAM8+m5ldnkSnT8XUeSSOIW2nmitAcQlhzZR/Gnqmrsu7hXsWo58ZUubfBpbmsme5Ftv6TSUKOqqsjyeuBA/phq/P31WuwNbUZR8ZYfYI+1D9ZaMH6FOhAlxkHprqGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=uVfLewBE; arc=fail smtp.client-ip=52.101.43.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PByIjO7U7dKrMDYvDWs7qA+J3CTSN+hT7wb3NU2a/jYAwQzexFUJWkgN34WONL1BxSk/1pH9hgGnpeioMh8o0zOXKGWEEuMmkY5l3phfw6B/lKKW67lEfNzr1/iIFxjguTbE+4UeU01UY8PDyFhypTdFrhzG+A2YGyajLEoNGjk6/hs2UpXby96+BrW/+RsfQxvep1Q+K0l3h+QBtHiAU5EDlhdPxcLErAYLLO1YDSaf4pidFJJHp/0c4QUKhOMmDoqmlfjjUyxY2Tk+IOYFAz8+D2EWROr4HPIsApMhW8nPWcDFVQyDj4lzfwQMpuq4FScOt7BNSp/Myl1SishDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bu6Wj5hySLV4CNbA1vRimNpIKcAE7W6N3/5KbYvMqDk=;
 b=yBb9x5BdbhuomIEhNZv12QUktH1g9uCKFi2g/VI8qZ0uRKxIE7oQkbRt+vf7YdRUmoE/JKr4dRyrnwgViKZXX7ijLgiH29xH2qkwMgiaFYLT5odGV4uH/XxYRyU7wNUkpMzN5+sY5mxZzuWWt/i5YxR2R4vHSmNmj0uEJa2YvCLx02bSO4Tu/17vzrP4nBwar91jXrWfVz9gNI4jNN5EIHfh3SoEbTZf3ZyElYV6wPMUWPlSHNQOcTWjR/V19EsqoOQUGaEMz+P5W5fi3BbiRxTu1nbI7nuyocVTRueXkDQEyidmwrncFrCsAkAixyzUM59t2KX5qUW48qIUYh1S6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bu6Wj5hySLV4CNbA1vRimNpIKcAE7W6N3/5KbYvMqDk=;
 b=uVfLewBEhOiSJ3+lVmzVzbD/egKtoMOSEORd4w3Jv0hvNpUoNg5AQfBc8kj7OsD6wNDQGILk10eFAQCQw2f7V7clrqQQod1XVkCJtC1T9OLtt1mfPQTCiBcHy9P8x7CKMoj+4wVjkBW1iFJACgQ1/qrLAOMICbubbs+QUmuO9fY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by DM4PR03MB6160.namprd03.prod.outlook.com (2603:10b6:5:39c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 16:03:23 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 16:03:23 +0000
Message-ID: <5b53ec55-67dc-45f7-b960-69bab3d38750@citrix.com>
Date: Thu, 28 May 2026 17:03:19 +0100
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, len.brown@intel.com,
 linux-kernel@vger.kernel.org, peterz@infradead.org,
 rafael.j.wysocki@intel.com, srinivas.pandruvada@linux.intel.com,
 stable@vger.kernel.org, x86@kernel.org, meenashanmugam@google.com,
 eranian@google.com
Subject: Re: [PATCH] Handle Ice Lake MONITOR erratum
To: Dave Hansen <dave.hansen@intel.com>, Jim Mattson <jmattson@google.com>,
 dave.hansen@linux.intel.com
References: <20250421192205.7CC1A7D9@davehans-spike.ostc.intel.com>
 <20260528030604.2669758-1-jmattson@google.com>
 <089e8bae-73c6-47a1-a046-6ddd8610d21b@intel.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <089e8bae-73c6-47a1-a046-6ddd8610d21b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0271.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::7) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|DM4PR03MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c45fb10-0096-401b-cb2f-08debcd2a4e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099006|6133799003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qyeaPKAqTDwxMQeuh0M6IZmhn0I4CmlaHaWmpflB6pPtVjIcxcoVpjc347wJX4WPaCzS9mFKVtYI6sb221EE4n/RNpTQnOVipU+bCLi0Q/4EfISaE6/uC43Qpd+LXj9QU0ntTGFyGhgendl16ZgJl40FOzzjwcqep9GrCjkImAzxSM7d2ETmC4Un2cig6w+uT6c4VHI+8YQLZ7xOd0ebVOwBoZ/tpB3UoDIgV2UFqpMe86dRTKgMHUOOHYiuIZwmN3j+Ugfk2JQGr6yg6fm3EWRzXXMafvlPTJ3r+AvidAH6HZ9byC3Ll4yqYMSiVtQ/bO3LGXeWmZou+CfFtym0NkA1YKtoNzMG8J6+LRlrKUqMzft3xzdplIK+04rPD4HA3qm423jDTUdnZCEBIftiXJu79JbeTO5wAeM5rSuGagM7hSvPSyNMokh2wySt+NvLb5YCAK+UvL9gW75YBLwcwDQ4cYPI9qRmyClAjuZOpMa+RbS6y81UCDS6MN6VHNSb6tynHjsQg98jDS4P1J8ipogud/iPwKSxOFIndhy//BWrspbMdlAC0UvJwHLZXNNXdU6RESFLxHRwyjudB5fQOocoy3uzdGKUDRQBR6U2v3Y97LlhgWRLEUOamJU3vlv9BXCkFy0j893PSwpL864TqypBDaDAC+zx1JrIQc/0qLBkNKipoQDISz/i1bTgUBEDQWU8W4NU6X6r4G8iQ6pefg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099006)(6133799003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlVwcERscEhxaFhENEdJSVlsYnJ3SmZGc2dBNlZHOWhOMjZPeThxcndhVXdQ?=
 =?utf-8?B?Q2E1Q05ZNTZyYTJJY0ZHeS9lcUgrRHpnN3VJQVRkeGloSGd6SllGRmhLZEw1?=
 =?utf-8?B?MGZ6Mm80Q3E0YkxaSXFKcDQycWk1Um1yZ0hrK1VzUUthYVB4S21RbFZsVFZW?=
 =?utf-8?B?bS9DT3FWR3lTMkZYUXNjYTVxWURla0w2My9aUHcxSnAyL3dIWG4yTUVBMHQ0?=
 =?utf-8?B?dnMxWTVFZW92R0NMOGtFKzFveW5YRS94ZXNYbVpQUmpaWEJBdTdxQnhaamV0?=
 =?utf-8?B?a2pQaWlYUldmaHhSQzBVQ1RaK0VjS1NHcFo5V3VBTWIxb0JuUEl6TUM1SS93?=
 =?utf-8?B?T1ptTEY4WGREWk1YbHE3MXU1TUVDck9qWmNmVUFKb3dVRlVXZDAzbnl6SVZr?=
 =?utf-8?B?L2t0M2ZQa0VBVjI0Tlp5Ujg4SUJLRko3eHdkUlMwUlA4MUZlbFlPQjdBcmJE?=
 =?utf-8?B?UjF6R2FXTThIRFJoWFR0clNCOU50OEpDVGk5VmdqZzlCMHZKN1pwWERiN29C?=
 =?utf-8?B?Nk9EbFl0bE9qWDl1NEtkamZ5VHo3NnZiMlNrWVdhQ3FtZElhelJOcnFoTGdt?=
 =?utf-8?B?cUpHRFd3YlNCN2ZsZVJWV0ZjUEt4bG4rU1ZDWWJxQVEwTWZPQ3FqTHcvUUZ1?=
 =?utf-8?B?dFIxUHNZVVZMTm9wZStpbXN4TXVGRk5SbHNEbmsxcmgrei9WbEtlVGloMGRt?=
 =?utf-8?B?SlV3VjVVYjQ5aGl1d1JzR1NsTCtuOFVKMnFDNktjeEh5d040OVJqN0g5T1hV?=
 =?utf-8?B?UVJFdVV3SndrMGYrQU9ObkMxaWk0Q0EwM2FmR0FqZkVWQldOT1BWZXpNOFpw?=
 =?utf-8?B?amNYcTB5TjVjMTB1ckhub0N0NEdQTFZ6VFdXbmtyeUR1UlVPN2NKMUtlVk11?=
 =?utf-8?B?YWVVRU50V01RcTJmdGgyWVJzajFZVW5JKy91SWpyVGo1bWpnbDJGRndYdlh6?=
 =?utf-8?B?N0hFU2dQVkVKbzlVQmJlc0NHQUNrcDhBenFsNTFUa05tUW1RU3Y1K2FMdFor?=
 =?utf-8?B?TWJlZjhkbU9paitZby9vTmpWZEpuQjNqQjV0MXgvNDNoSjJ0UGZXdUFDbnY5?=
 =?utf-8?B?T2tod0t1Q1krSVVUalJrZFM1TE5GSXdyYzV1TTVoVEZ4am1JY2NoeDRtZ3Fi?=
 =?utf-8?B?VWZTS0NuUmtadWRmZWNqdWNiR3lkT05ZOG0rOFlUU1M2WEs0bEN5WmFZbG5I?=
 =?utf-8?B?M29FMTg4NiszUm51L2ZQQjdvS1h3ZW9sS2pEMGE2bVZQWmcxRlhrNXJZWldp?=
 =?utf-8?B?TEd3bWx4QStLRjYzdTFkcEpMM2hzVVI5WkdBV2pabEFlN1ZIcUdkNnZFZkxp?=
 =?utf-8?B?alcxUVpybzNZRGZPQUNGRTFYckc5YXUwWEFDZWJTSlNxc3V5S3pwNnNMbGJR?=
 =?utf-8?B?NjREQjJRR3UzREFQNlJEUUo5RU1BNWNoc3NzYU1Yd2I1RWltT0d2QWFhMTZD?=
 =?utf-8?B?aEVZQlFzSW10ZUIrMXM2Z2FGYndZY0tjRTJGT2xRRFVWczRMZCtLVU9idVF1?=
 =?utf-8?B?L2p5Qm5jcTN6Um11SmI3cXJyT2hqUEYrSkczdnYrZC92Ulp4cDVKUkU0bXhG?=
 =?utf-8?B?a1dpOURUNklQZjVwaTluNzh2TjhqQXFDbnN2TUdmQlEzV0JocW1UK1IrOTda?=
 =?utf-8?B?L1lBMzNkaW5tYWljVVp6TEJvcVBkQ1kxWi9mU25mY0g3QnU3dUx5M2xoN1BL?=
 =?utf-8?B?eDVoRnJ4RFNhMHVVNDZnUmRFL0FUZWk2a01FV1dIUm5vMElQOXdMYmhKeU9I?=
 =?utf-8?B?bHliRVIwajBFaFlTZmZ0OVhZM1V1dGNVYzRna2EwdEZveFBnT2QxMjdFUUpr?=
 =?utf-8?B?UXp4MzFGVFQveXBFK1hJSTZEa3BiR0gyVDNSaCtweUZ2SmpJcGg3QVFDR2wx?=
 =?utf-8?B?RUlvbCtDL3NWSVZLWDRXSmg2SXpUMk5HdlBySmlHSzM0NHFCaHNsRDlsWFZh?=
 =?utf-8?B?ZWNxVDRKMEFlaEdUREI3ZDZiK09RcnhWRkFNai9NUzBHbncxc2JlU0ZLWlRj?=
 =?utf-8?B?MXpSdmViSDVsVkpyczM0eHgzYkFQY3ZHbXdCcU5uZ3R5UHdwVTNKM0M4K09K?=
 =?utf-8?B?c3ZUT0tpOS9CVTlMeURGL21VdUJKU0lBcnJKakZpNlMyWmlLbkV6SXdOOURP?=
 =?utf-8?B?UWtKZkxpNnhsalBQb1dmb2N6ay9URm9DbjAyMXE2QjFhc3I2d2IyUzVQQVZC?=
 =?utf-8?B?SmZxeDNkUndzVW1mckVnbGNLUmdUWGFNTjltNzF0M2dSamt3anE1K3RYRGZH?=
 =?utf-8?B?NHF0alVZYlA4N2hGcTM0Q25yUnA2ME9QWDZPUnAxZmpsaExCN3d2S3Vwc3Qz?=
 =?utf-8?B?MisvU2NKNUI3TmxRZzh6dzV3UWNDVkF0NDVtZWVkN3psRkg2bkgyUjdCNUR4?=
 =?utf-8?Q?pBXdWaDQ/8ziKmOM=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c45fb10-0096-401b-cb2f-08debcd2a4e4
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 16:03:22.9631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMBeFHtdGbBGVVNsZSeCAeWY73i8rPeCRnFZvXZW/kEua4sKPegFBEHOJX8IEyUgHGIFozLPtlmI2UmuJJQk0Ms3s6OYX909/cqMkGXoz1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6160
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[citrix.com,reject];
	R_DKIM_ALLOW(-0.20)[citrix.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255059-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[citrix.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew.cooper3@citrix.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:url,citrix.com:mid,citrix.com:dkim]
X-Rspamd-Queue-Id: CF8945F5024
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 28/05/2026 4:36 am, Dave Hansen wrote:
> On 5/27/26 20:06, Jim Mattson wrote:
>>> The erratum is called ICX143 in the "3rd Gen Intel Xeon Scalable
>>> Processors, Codename Ice Lake Specification Update". It is Intel
>>> document 637780, currently available here:
>>>
>>> 	https://cdrdv2.intel.com/v1/dl/getContent/637780
>> The erratum says, "Due to this erratum, the processor may hang."
>>
>> We are seeing some Ice Lake Xeon E5 machines panic due to hard lockups, and
>> then the kdump kernel dies with "Fatal machine check from unknown source."
>> Is this behavior consistent with this erratum?
> That sounds like something different to me. I don't remember machine
> checks being implicated for this erratum at all.
>
> My usual rule of thumb is that machine checks mean bad hardware unless
> there's a specific and compelling reason otherwise.

I agree.

The symptoms we found were a hang on boot while bringing up APs, and
there were no machine checks in sight.

~Andrew

