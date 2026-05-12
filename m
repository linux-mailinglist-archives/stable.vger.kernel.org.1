Return-Path: <stable+bounces-246700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 440tOeWxA2qy9AEAu9opvQ
	(envelope-from <stable+bounces-246700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 01:04:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 441E152B2AC
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 01:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26CF6304DEBE
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D84B356777;
	Tue, 12 May 2026 23:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kOoCPtAN"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013047.outbound.protection.outlook.com [40.93.196.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DD83EDE6B
	for <stable@vger.kernel.org>; Tue, 12 May 2026 23:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778627042; cv=fail; b=UwCOjJEEUd0ID/k7vaUCXNji2QrA5pX6XRKJqi3BP5V8nqBwd7zYWYDC2WTPIuiWtUgm3XqyTbfjc7DrLju3PXCPI1epRR0DmFnVkLC6VbZ7bFAbyetS2MjXaNUBlKZyTWSjEYcXzzlgv6e6MhLvqNkx1k54L/Ch/OQkEs3Z0SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778627042; c=relaxed/simple;
	bh=5NVx5E0bu1tPegqFV/BdGX3Vgz1cevlYfP81H/NO/jk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NSH/cFt20ibu+JczFglzFWrdZvHw00SfLY4Y9t+2hhVnZIEWEfjdBVr+MAw9h2TxxwxJHBCFJRecjEbPlQHWxK9nUMCP5rpTScnvbHGPUoNu6Edx0Qley+hudkKOdp4xZVk3jWYfF31omlEvYaNM7sQwoV95/Rh4xdtrdMfb7IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kOoCPtAN; arc=fail smtp.client-ip=40.93.196.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACfRMn26f/7expVtAhOYyGRknnVfW68BQbBc0WHsqC9sJWyJ36LtulinNQ0WY25BIoT7QfnVmjCrCSwiYRzmnvO4njhUikz9X3U35CZBW7ain8Bd4tP+4g4OR0C2SqXFcWGrHusP5n7O4i98uY2qBpFVPLvFVkZj5Dx57N+EOHGHZPvakBEMUXrzLdcOZILZHhOXT827io10i+x+mMCxxDHpEXRXGZQ/uioZ9RX/g9N9TelQvpbJdZH8qRZ7CjD0g8YScUV4wcBhrMJWL0vtYLvRZ9qJVye4mhuTNAKHXVp2/EEi4PirlrEwvgDUaBGJN95j7rfVWe1Bxn3LtpiVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tts3hbUM2MdYmXBzjRmryBqfxlNZOb14ssSamLeJzWc=;
 b=plnbM3EV9bSN+6gQ3EVlYR3XIOV1Y7xb11FHw6t1XJaiG8Lyhiz45KJ4xEIZ4uj9JdHtYxpLKKVmZON+SLHVrkAqDNbz1TcNe9tkA4iU230BiBFyKrpDadpiLHMacr+GIW7gkYd5cPMbV8HNVgLBqGk0r1VOOkHjc9M9PnpyPEhn+y2pgAHjbKxSPqXxdTGMUpMV1/K83oFWRGnM/4vbpQ08W8ZO0Ry+96PJDfqYXWYgQ+4NiszatykZNcB5eJ8OW8WJ5WNFtxnZYOilXHHRpx6vHHiYOA2dFPdO5jZaYpF4Bnx7WNIx36hRtM/8+CoO/Wel5egdNXLbBHbsxpJ0kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tts3hbUM2MdYmXBzjRmryBqfxlNZOb14ssSamLeJzWc=;
 b=kOoCPtANq1zL9lIAZ9mP4X3C8+GrGYgKUwdxG9vEc1m4ouGo5cI4TMOmH/b2EK0Jwv5YHuWv1PWG8DpcT/NSHxQj4jS3dJtKVK2TOX6JNgNgtaMlUun1VaYDB4uS3wUtVfbeGUmOzpsF5b1w7Y/Tg3sGrsFJOKwzgFsSj3y3TCzmeHWSj62Sia8wkUD++3YllSCOpbVGeBC2iv/iqqyve5B+bpxt/xxxrnAWisPzBB3GQ/HmCBtLSL0IQOGBpeRHmlXseSA9y3QM4mJoAg3kIenXiBU/qospDR9jFC9pzQqnF6bY89EXDDtaudau3w1J/S+2bnRK8x+TmA/3Z0xBkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by DSVPR12MB999191.namprd12.prod.outlook.com (2603:10b6:8:496::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 12 May
 2026 23:03:54 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 23:03:54 +0000
Message-ID: <9a56d762-ebe5-429e-9fc8-a9c9e5d0d434@nvidia.com>
Date: Wed, 13 May 2026 09:03:47 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check before
 return device-private pmd
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, ljs@kernel.org, riel@surriel.com,
 liam@infradead.org, vbabka@kernel.org, harry@kernel.org, jannh@google.com,
 sj@kernel.org, ziy@nvidia.com, linux-mm@kvack.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, stable@vger.kernel.org
References: <20260508013728.21285-1-richard.weiyang@gmail.com>
 <5e9ee072-b927-41e0-ba98-c9fdf11eccbc@nvidia.com>
 <0aab59b8-71c5-4059-8281-5dd876946528@kernel.org>
 <20260512143542.izpp3gu4iqxttw3f@master>
 <113dddc5-27e3-4e9e-a90c-f076a4629f51@kernel.org>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <113dddc5-27e3-4e9e-a90c-f076a4629f51@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWPR01CA0087.ausprd01.prod.outlook.com
 (2603:10c6:220:1d0::20) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|DSVPR12MB999191:EE_
X-MS-Office365-Filtering-Correlation-Id: f24ddad2-ea62-4f72-becf-08deb07abd37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	sovHheCj0g29URLrSTb58ziT9etRwM1XnpD2XtDGtwxfM77OfPD71UzuDOsaV1Xnihyaqn6kII+C0a7djInD/KCqlW2YrZVYtJspMWLPjgHoGYTRRWvSqmAnLJ+OXnX8Zla5u8dvxSHcHLlhSm2siyIPqv0GYgu/SuEM8r8gzuPHa7dw+Y0dYfdeEOW0WeiBPPB5/YwaBXjw7/bT0jcWt9JIqUk5A3+I+Z88AivZk1Q9ANHeG8ucT4XtTIDJtMz+GiCo/PYWyFjV55HAFLV7OyNrt1vcCaLsmDX6PZIu8ceUgif/f1f7PsffWhoHCOeN76cOXv6SNd6IjfZzlOQVIje/YQV0KzSwzB8jOwKJ1wbS2/ZUwQ4qNDdFyV2yNsrV96SpoTYFAOQhJMawGoJ2h2MYy3dMUM7TW0eDlbnGk+dwGGgdosCubS7hMA0gOEa7xSHhim4kvjx4FVYFxI7PTQpzneVQQ+j7F1dmdr75rz7kKtPBUu5le55b5aiNWa6dyOCvkMEqZb8YxFU/aqkRoWg2FbtznHRtIINNhSTmlUsDqR8MVHIjIlqc9b5e3t74aU2lo2LqIjgljKn7nIbq5/w76Mpsbqe8dzUEI4R+v/aW+GL4O8IIObvIQJ/Fp8Akw4MPgayu71jxhULMqYzFvPCJifO6bsngWzSVo5zzDNy1Bz/QX/WU4I4RsWVZjPwz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aC9BT25oK2FNclRmVUZIbmRpeHdyeHhFeFB6amIrd1ZkUXFBRzg1NkxleGl0?=
 =?utf-8?B?cktNUVlUdEw1ZTQ2TEtpdlpQc1JDU2FHMlQ5OWFvM2lpNWxMWmdUSVE2S1B6?=
 =?utf-8?B?OGcrRVVCVVExdmRuK253Q0M5eVg4cForanBiQ1pwNzRUSXFyYU82ck5EempU?=
 =?utf-8?B?c0tRZkphdUpJR1Buc0lTTkVETGNPZ29YdVJISG1xcllJaFJlK1Z3cGlNN0Q3?=
 =?utf-8?B?dFhZdWo1OFlMYTZrbmRnU09PNGNQcjFPMk9YRlVXWVZUbjJiVTFWYlhZZHpr?=
 =?utf-8?B?WFRrYWFJL2Y4RkJGUFZqMnc5UDJ1dlpBY3E3WnE4TnJEa01FWmJsTGxUa1Zj?=
 =?utf-8?B?d2RIQ2phOUV0NDNkTnduVmN3a2ExOXRiS3hCQjltS0IrclU0c1ZjYnlqemkr?=
 =?utf-8?B?WkN2VDhEU1lsMUNEYlpmVk1uTGlOSHd2MVBCc3E1UzM3ejhVODk3SUxOWU9O?=
 =?utf-8?B?dmFIR0ZFYnBlaWoyTXdCcGdTSWNEV09aOWptYjRqNDhtWURrMXhUdlJySnNH?=
 =?utf-8?B?aGxKdDI4K3JGYmNIcVd0cnhEZHdhZ0VxZ25BNTYrN0RsS1M4STRKUlFQaFdF?=
 =?utf-8?B?Ky9RL214c1NCS3V6L2tWWWpOZUlodGNac0hQblg3WktRcjAwdEV1TFNTaHdF?=
 =?utf-8?B?KzhEZ2s4MHVRZ0wzeDJ5MEdDdTRSOUc2Qnl3aThVQ2M3UFVvMGJKRUpKMWNV?=
 =?utf-8?B?ZXFXV0U4UVZsd0RTckRkNnJ1a1hudG8zUjNnNDBFdEp6V05NK1pnREErTVE3?=
 =?utf-8?B?Vjk2RUo5ejdkQW04V1VvemtzY3p5TnZVWDBLaXlIcDI1ZFN0a0s4VGhjeEZr?=
 =?utf-8?B?NGpxRUpIaHFUc3hJQ1hvUDRZZ3ZaeFdkQW1tOXBlNUw2ZVRMVS9rbXIxTUly?=
 =?utf-8?B?YjhQemYvcDhoRFFaTUIwTUdUL1NENWlXeDF2aXR6MG1pWTFIK3laKy9ycWx1?=
 =?utf-8?B?S0x6dnZqUVFxRDVMVVlHYkJLUlJHYk8wMzBEWEEvQUFUYzhES0hNS0k4WXFw?=
 =?utf-8?B?emtuY0hhSUpJUGRzLzY5MXZhNzJLYXlaeTNwRnMzczByaEQvNWhZeVMycDRS?=
 =?utf-8?B?S0MzT2tpRjZ2VHROcGZwVXk1cllmSVBWNU5GWTJHY2NFTUZLQlQwY2d4MUll?=
 =?utf-8?B?enhxYTMySk5EMXBxS0FqeWFxNjBZVXpaWUdyaFAxRlZTc1UxNXpjWS9xd3ls?=
 =?utf-8?B?VHIvUTg5dksvS3VRRnd0amRnRWxmVFJYSTVoWDVtVlRBYWxxNWhHRzlOMzlJ?=
 =?utf-8?B?YmJEQU8xaGx0dWFaek5BMXkrVEo1YkxiN3luSXpoRnNCMGx0QnVtNDdFZnkx?=
 =?utf-8?B?cnc1R05ackQ3WEhuUFpIaHVmV3FWVkcxTDM0ZTVyazkxSmVDdTl2VkZ0emxZ?=
 =?utf-8?B?ZzFqK3I5bXJzMmFhVUx0T0E4REJ1ZmhGdkw3VHhxa2tDcnp5SVc5VGVBc09V?=
 =?utf-8?B?Q2g5ci9tN0g3dk40WHNUWTZSRmJHSmR2clFXUUZmY1FWbGlqeGhUc2N5Z3h6?=
 =?utf-8?B?MHlHaUtVZjIwc1QybWlJVHd1bzFqTlppM0RVNVNwYys1U2JwbGdXeTNvWEZ2?=
 =?utf-8?B?Zk52OFV2eEl4b2ZFUmF1blpzQWx1L1hXWXl6Q3dJcHE0ek1tSnpqdEdoanFZ?=
 =?utf-8?B?V1lYcUlIOGY2ZUdoY0hBUmlWZzA3UllLVytrYjJSUUZqVTJhdkxtSjlNMnVM?=
 =?utf-8?B?bFBXa3Q4c1BKQ3RBM1RJWC9LUk9GR21WeU1lSkZVU25zMzZsLzJ1dWVHQXZ0?=
 =?utf-8?B?OFBjc01CajdkMFltQzFhL1E1Uk41QTJPSHJHTmdud0Vmck82M1VScWFRK3Bm?=
 =?utf-8?B?MlloYkFhM0huRmdjSDZuUHZob0dnVUZPWE5RTDR2SloxbllUa3FYMFp6VmVm?=
 =?utf-8?B?TUNKY0Q2OVhyT0p2NUQrM3YxQmExV2tLNkNPQzgwTGdMZnFKbFpQVGJuWFlx?=
 =?utf-8?B?Rm5MTXYzU2xNcXdwMkE2Yjhib29pYUZZVFZnVFRaY3hxcUxwRDVlL0Q5Mi9w?=
 =?utf-8?B?U3ZwQU1YVDBDSmVzZ2pBTmY2LzU4VGFSREtFNVhMMmpMd0FKQ2wvbEVmRnVH?=
 =?utf-8?B?RnZjT2F1eXB2Q2p0cE5SellDNEFKNkZzT2RDalROZG91bVdSRlZwNHFZRVZ2?=
 =?utf-8?B?ZVU2RFpaYzhWSGQ0VmJhRW9EWDE0QURVZkR5TDZtWitPZVJnUUhiY2RSTjlN?=
 =?utf-8?B?SHJieGhPYkVnd0dRcm5jL0psWjYrSzVBNHdBNkFxRjZsSkd4Rk9pZHltVXQ0?=
 =?utf-8?B?eFZsREJuNDIvMjlaWGd1eWw4Vy90bXdONjRqT3hsTHk4TFVIS0FVMlh2YkNn?=
 =?utf-8?B?SnFycGdwd0lwdHFvSE9EYWtPazVDNHFuSXpHN2xvcUVnVUpPcUdBdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f24ddad2-ea62-4f72-becf-08deb07abd37
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 23:03:54.2001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTzWgpvb1Zfonc0VZjG79L1ct2bwup4h7KMzzyhDyd0l9DswfVaiyH04qgFHcmNiq4Ermj9rW1nbdYTz+aN1Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999191
X-Rspamd-Queue-Id: 441E152B2AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246700-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[balbirs@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action

On 5/13/26 04:55, David Hildenbrand (Arm) wrote:
> On 5/12/26 16:35, Wei Yang wrote:
>> On Tue, May 12, 2026 at 02:43:54PM +0200, David Hildenbrand (Arm) wrote:
>>> On 5/9/26 00:48, Balbir Singh wrote:
>>>>
>>>> Could you elaborate a more on the improper situation?
>>>>
>>>>
>>>> Do we need to check softleaf_is_device_private() twice, can't we hold the pmd
>>>> lock and check once?
>>>
>>> I think what we try to do here is, is to only grab the lock if we verified that there is something of interest in there.
>>>
>>> I wonder if we should rewrite that whole thing to just do a pmd_same() check after grabbing the lock.
>>>
>>> Something a lot cleaner like:
>>>
>>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>> index a4d52fdb3056..de6a255cc847 100644
>>> --- a/mm/page_vma_mapped.c
>>> +++ b/mm/page_vma_mapped.c
>>> @@ -242,40 +242,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>>                 */
>>>                pmde = pmdp_get_lockless(pvmw->pmd);
>>>
>>> -               if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>>> -                       pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>> -                       pmde = *pvmw->pmd;
>>> -                       if (!pmd_present(pmde)) {
>>> -                               softleaf_t entry;
>>> -
>>> -                               if (!thp_migration_supported() ||
>>> -                                   !(pvmw->flags & PVMW_MIGRATION))
>>> -                                       return not_found(pvmw);
>>> -                               entry = softleaf_from_pmd(pmde);
>>> -
>>> -                               if (!softleaf_is_migration(entry) ||
>>> -                                   !check_pmd(softleaf_to_pfn(entry), pvmw))
>>> -                                       return not_found(pvmw);
>>> -                               return true;
>>> -                       }
>>> -                       if (likely(pmd_trans_huge(pmde))) {
>>> -                               if (pvmw->flags & PVMW_MIGRATION)
>>> -                                       return not_found(pvmw);
>>> -                               if (!check_pmd(pmd_pfn(pmde), pvmw))
>>> -                                       return not_found(pvmw);
>>> -                               return true;
>>> -                       }
>>> -                       /* THP pmd was split under us: handle on pte level */
>>> -                       spin_unlock(pvmw->ptl);
>>> -                       pvmw->ptl = NULL;
>>> -               } else if (!pmd_present(pmde)) {
>>> -                       const softleaf_t entry = softleaf_from_pmd(pmde);
>>> -
>>> -                       if (softleaf_is_device_private(entry)) {
>>> -                               pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>> -                               return true;
>>> -                       }
>>> +               if (pmd_present(pmde)) {
>>> +                       if (!pmd_leaf(pmde))
>>> +                               goto pte_table;
>>> +                       if (pvmw->flags & PVMW_MIGRATION)
>>> +                               return not_found(pvmw);
>>> +                       if (!check_pmd(pmd_pfn(pmde), pvmw))
>>> +                               return not_found(pvmw);
>>> +               } else if (pmd_is_migration_entry(pmde)) {
>>> +                       softleaf_t entry = softleaf_from_pmd(pmde);
>>> +
>>> +                       if (!(pvmw->flags & PVMW_MIGRATION))
>>> +                               return not_found(pvmw);
>>> +                       if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>>> +                               return not_found(pvmw);
>>> +               } else if (pmd_is_device_private_entry(pmde)) {
>>> +                       softleaf_t entry = softleaf_from_pmd(pmde);
>>>
>>> +                       if (pvmw->flags & PVMW_MIGRATION)
>>> +                               return not_found(pvmw);
>>> +                       if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>>> +                               return not_found(pvmw);
>>> +               } else {
>>>                        if ((pvmw->flags & PVMW_SYNC) &&
>>>                            thp_vma_suitable_order(vma, pvmw->address,
>>>                                                   PMD_ORDER) &&
>>> @@ -285,6 +273,15 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>>                        step_forward(pvmw, PMD_SIZE);
>>>                        continue;
>>>                }
>>> +
>>> +               /* Double-check under PTL that the PMD didn't change. */
>>> +               pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>> +               if (pmd_same(pmde, pmdp_get(pvmw->pmd)))
>>> +                       return true;
>>> +               spin_unlock(pvmw->ptl);
>>> +               pvmw->ptl = NULL;
>>> +               goto restart;
>>> +pte_table:
>>>                if (!map_pte(pvmw, &pmde, &ptl)) {
>>>                        if (!pvmw->pte)
>>>
>>>
>>>
>>>
>>> There is likely room to clean this up / compress it further.
>>
>> I tried to compress above logic like this, hope it could look cleaner.
>>
>> 	if (pmd_trans_huge(pmde) || pmd_is_valid_softleaf(pmde)) {
>> 		unsigned long pfn;
>> 		bool is_migration = pmd_is_migration_entry(pmde);
>> 		bool for_migration = !!(pvmw->flags & PVMW_MIGRATION);
>>
>> 		if (is_migration != for_migration)
>> 			return not_found(pvmw);
>>

I got some time to look at PVMW_MIGRATION, remove_migration_ptes
is invoked for device private pages, would we want them to skip
device private pmd pages?

>> 		if (pmd_trans_huge(pmde))
>> 			pfn = pmd_pfn(pmde);
>> 		else
>> 			pfn = softleaf_to_pfn(softleaf_from_pmd(pmde));
>>
>> 		if (!check_pmd(pfn, pvmw))
>> 			return not_found(pvmw);
>> 	} else if (!pmd_present(pmde)) {
> 
> It's more compact, but not necessarily cleaner. In particular, I detest
> pmd_trans_huge(), we should phase it out.
> 
> if (pmd_present(pmde) && !pmd_leaf(pmde)) {
> 	goto pte_table;
> } else if (pmd_present(pmde) || pmd_is_valid_softleaf(pmde))
> 
> ...
> 
> Might work as well. But once we add support for other softleaf types, we'll have
> to touch it again. So I'd rather just list what we actually expect.
> 

Balbir


