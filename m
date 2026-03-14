Return-Path: <stable+bounces-225426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0twTIzl8tWlC1AAAu9opvQ
	(envelope-from <stable+bounces-225426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 16:18:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA24028DA2E
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 16:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CFC23025148
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 15:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666D81DD525;
	Sat, 14 Mar 2026 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="h872dEBv"
X-Original-To: stable@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010017.outbound.protection.outlook.com [52.103.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAD410E3;
	Sat, 14 Mar 2026 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773501491; cv=fail; b=Y7m2os6DAlg4XkYa+EQwa0r41jsss2eSPbr5IEfgvBNqudKNDCArFwvedZOYabmVucUvkeRKyg4O0Bdfmcb5IFcVd5bLtXNdh3ypUcCvOR6MyNVUvDUEjRozYEy51duUckIoZG8LnaKvk1+VY2R9FngCtCxE1lGyq3ZTQmjdZno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773501491; c=relaxed/simple;
	bh=ofXfQgpvO3wZGnqZKpRRfKy/oAYH8vR2ApAobAq2ZXs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VMGLb0m8HhkunHSFS/otQ+QRBnAvJ81ukxFyCXDjg6gc6ZkQw1XTuu1WHH3jD4QHLYbtRlvdmh+W17nXUjgS22femKZvYmvUmak8TH7Tg6LuA8GdWIodGSa9KNFh9SI4pQVcAlz30L1cXzXdyZcTPRKji+wdNgp0EBHfaLp9xdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=h872dEBv; arc=fail smtp.client-ip=52.103.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U00cftG2nF2r0ZUNYfdKErOe8II+EmgJPEHre1YTC33H5uoEe0ZGsR60lE/6Ao7wVD6fwJ50C/lod1dkXB6aC0Je6PJLQAGgP3eIvCV03nJ6yy3wpFsyG3MAdXj9mNRAWa1RkBcUjKC8rsWFmOS2t3/UfH9HUqSz4BMwePox7v9FR/3qF48Tz1YAZNBCjr3LwefIwP5D/jXE6t9LZAKbgDFQg+axfA4XIRtEiHVEdiNa/xIiVrJbAiMyhk2bGZbU6k/dldSy6X2K0Xlk1yW2jlbYxq05h5I/L6w+ofWi0OyzdRGCW5XRau7UtiZnNyRRYlgAWRwcpLdxXaN+QdIsHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ca0E11IJMrV5LsyIdodFktED3eWZesnD5UuitYPbUI4=;
 b=r1EWb6rPW59UfJ8aEsbxgkOpY9HHoDIgUIiqK+wlOUuZUharTZCvAr8ZUFC7dK+3Ydb3fY1bArS5jD2mK6Tbz7MDbawYl10zvd5EmRpsnKYdk4RiKXapovdpbkZs/nMUKJo1gypl1wk2PEAN/TNmo7uDXp8aoZ1qHPTS409zXnVxxIWWB/ffFvDQvltn3f0bCZnDr98GsmOPKxA3VHP5bmDKGubE8p+ShbCq39qxGNlLGmZR1jRbGg97IH6HEU5KN/2gV0iA3SrYSZ/+L4LZobMJp9177sIJrY9NrFOjpp4zQMFTrhT7MJejJ1HE8e+visxqiYAWcQufDdzYUxUr9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ca0E11IJMrV5LsyIdodFktED3eWZesnD5UuitYPbUI4=;
 b=h872dEBvNka4c5vmCEX9OKWFOJyfn0QWNtCHRcwkaAbwJCGWl+1WG1Hodu/8E4Zi9HGBHOt6ZWLXaccNDxEcGyf7tdcoWBhK1ZzBtzAqjekbDq+SWTZBseAZ5VKjHHhYxH9/FIHbGBkiDdkpzyOmNeZpyF/5gCaV4+KowAO/nS5UtQ7IXIq82noX0Mdh46WLD+AR5PkEHAqulmIH5/ZW3N8c51UZKjiRMkfQfp0zE2BUPIVknR1ficYyzS+VPKdtHMi6TXZ4XKMjZijOepzJ29ZJwviEs7MLZQBeyWZ3pzC4lQAWywmbCRuI6cs+MucZtnizdiST04VxsfJagVNCmQ==
Received: from SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::18)
 by ME0P300MB0617.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:229::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Sat, 14 Mar
 2026 15:17:59 +0000
Received: from SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM
 ([fe80::bdb1:7cdc:238d:2bda]) by SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM
 ([fe80::bdb1:7cdc:238d:2bda%4]) with mapi id 15.20.9723.013; Sat, 14 Mar 2026
 15:17:59 +0000
Message-ID:
 <SY0P300MB076993EA12677C0C730985D9C642A@SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM>
Date: Sat, 14 Mar 2026 23:17:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: do not use kmalloc_nolock when
 !HAVE_CMPXCHG_DOUBLE
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr
Cc: ameryhung@gmail.com, linux-riscv@lists.infradead.org,
 stable@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260314-bpf-kmalloc-nolock-v1-1-24abf3f75a9f@outlook.com>
 <dfa065670c02c16c71cac4773c62208f2b031198d9cf070d1b69a5ce0ff3d7ab@mail.kernel.org>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <dfa065670c02c16c71cac4773c62208f2b031198d9cf070d1b69a5ce0ff3d7ab@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::18)
X-Microsoft-Original-Message-ID:
 <4aa9be4b-bbe2-4d47-894f-1a8efb92efe0@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0769:EE_|ME0P300MB0617:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b65a61c-bbce-4bc0-1bda-08de81dcdfc0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|39105399006|8060799015|15080799012|19110799012|23021999003|461199028|5072599009|6090799003|10035399007|3412199025|4302099013|440099028|1602099012|40105399003|41105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzdKZVNHZ0xHb1gwQ2xZQ005ZFpYNEE2bUhxV3V3MWxQSTdKTFRMZWhyMDFH?=
 =?utf-8?B?NExHMTB1WmcyYTI0N2ppYjlTNlBmN25QWXlVdTFLQXJBYmlqazZaQzl4Z2dF?=
 =?utf-8?B?WmdKT2JmQUVrS2VTcnp0b2J1OXYyRzROME05c3M4QjllNFUwVFl2TWJBenNG?=
 =?utf-8?B?THBIcXg1UVRCWkFoaFFoNEFKRVZDU2RyZnNrUk5rSHl3azB0MVNXQW1SbjBJ?=
 =?utf-8?B?b0duUGtFWG9pUk40Y25WUEMwb3pGYnoySWJhUFdmWUtCWElKMG13Z2tOSTln?=
 =?utf-8?B?NGZldlZUekFpdmJFQndINGpSQStEV2xaV21FbnFlRWhkNGtwc1RnTmJWai9F?=
 =?utf-8?B?dWFMRWhMeTQ4TmJwV1M3SEY2RjRxMjQ2K2hoZjZlbkZVbjB2Y3R5eWpHOHhW?=
 =?utf-8?B?YUhnNWVGV2Rwbks5K2tsbHVZZFc0TGZxelZuVURMclI0M0FuWjl0MDdmSXN2?=
 =?utf-8?B?SG10M2srK0lCTDA2ZzBUeWJVNHliUkFCNEFyNWxTSWpjVDMrejBWL3pJRjU1?=
 =?utf-8?B?ZFRRcFkySEpHUlhvR2xQUEFnWVB5bS9lYXIyVURtZUZZSlRNeFBCVFJvUFBI?=
 =?utf-8?B?MzNzcnFmQW9FSm9Oc0NKMzd5bXFuYktVNXhwVWNVNGpBMzB5TTU0VmgxaVE5?=
 =?utf-8?B?SzBOeHd5dHlGdFFaNGpXaUZBY1VRYTdDMUpDZkF4Z0pnR2paTEI1K1JnUWZB?=
 =?utf-8?B?V3A4UnlETVZXeEZTSU9zQ0VmQ05VQXE1Vyt1K294Sm53WUFtTXVJU3N0VWIr?=
 =?utf-8?B?WERrZFg2U01vdzJORjZFcVRUdTNSN3VYOHgzWnJlTFhDa08rcWhTSGdTbDBz?=
 =?utf-8?B?UDBiWCszK3h6bjhOaGFLSytMVzN5ZXNyNllleFVqL0hQOEFhSzV2UVYyWlZQ?=
 =?utf-8?B?SithREN3M0ozdk1CTXd5bUp4aEtxdW1RemRGcVBhS0RNcExIMHE2RCtFSHJH?=
 =?utf-8?B?b3hoUSsrS3cvdmlLV2FoQ3RoVFJGZ2tlU1owbURyYzg5MGg1VTJmVlU2aGti?=
 =?utf-8?B?MWQ2Sm9SK0Z0dXVVYjY2c3o1cFRaZy9NM0FaUzVkWUNZeCtRRFo0Y2NkY3NY?=
 =?utf-8?B?MnZaZGU4TjhIWEFmdzNjOXF2QWJVTFNTcCtZQWExYytwSXpmYXVaYzh6NS9a?=
 =?utf-8?B?cWxUQWk5eCtHUUhPRC9PQUlYZUNOUGhvdFJOM1pDY005K2Q0L0paMXM0bkRK?=
 =?utf-8?B?d1crUWRnSEowek1HRTdUWmJ3WEw5OHA0ODhkcXVTQlBaMlpCWVUrWENMQ2p2?=
 =?utf-8?B?Vm0vNWlyTnJ1aU5UOHk3Wk1JbG4yc3ByU3lBRlZRVlFhMlBtS2JqL1B2VDJC?=
 =?utf-8?B?dnlETnZkb3RRMGF0VklzTDk4S1EyU1VyQmYyWHBVKzRqeW0wMGRsOTA2c1o4?=
 =?utf-8?Q?DhxrBtS6KhNbOgkVH56Qj/T+oKj6m7o4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3hrSzBHZ3FHZHlqWWEyakc1VkJhRlVVZGp3YmhOZFpnM3Z4Vzh5WWEvM2Jh?=
 =?utf-8?B?c082OHE2N3FqUkFSNVJsSDhEMmhTMU96L0QvaEZsL0NqVUozQ0RCdDVNNFo5?=
 =?utf-8?B?ODVsT0loUzF5SUJ5Ryt2VDRPaDdNMkpwNHBDK2JxRUJleHVPZ1dXczZuZTlq?=
 =?utf-8?B?b29zRmtzY0I1eEVhZTFwRjRqbjJVOHN3a0tEcDZBQlptdXh4d2N6UHBkYzJ1?=
 =?utf-8?B?U0lNQ0w0QzA2Ri9OSEZWYWpQbksxTld6TlRQLy8zUy9GcUJnYUx2bjB6NzVR?=
 =?utf-8?B?REcwV3BVcHVtbUtwdjIrZktjVUZBQzE3M0RvSG9kdjdPLzhFUEtUSDVQcG55?=
 =?utf-8?B?enhwendCcmI4ekFKTTYvUm1VUlV0QW1hT0dremJQYWQ0dll6SGgwMGdMTDFC?=
 =?utf-8?B?WEc4enlmK0lpUXZUdG8vZUN6TkpOYlVKTjZOQkNRcVJWcE1MUzd0eUVKOHdR?=
 =?utf-8?B?NUF0QVJNb0QyNTQ4a3dWUVV6bFk4TDdYUVdHTkxoYjFKb3prZncwdEo1N21D?=
 =?utf-8?B?UmVYRUh6SVdBb2V2a3lHNDhCejVCQmN5WGtVQnBCWGJseTlVNHRiTTdGa0RY?=
 =?utf-8?B?bVVQWWRZS01ndzFJZklWTU02QzQ5aXdqdlNVaW1KNVh6TzBLRUp1R2RaTUJ0?=
 =?utf-8?B?Q1IvZUxMQVlUaEhTeVY2M21TZEVCV0tkWHM1Mmd1ZFBtcWVFSlFSaUEzYVlG?=
 =?utf-8?B?cWdFR1Q4L3pBMDFFWVJVRHE2Z0lHeG9PU1ozZ2k3YTRhSnJXejVZSWIxNzNY?=
 =?utf-8?B?U29Ya2g0cEQrZ2Fxd3I5czdNcklJdWM3TkZIaHpiUjBMUlg5aXZBSml4Yy9q?=
 =?utf-8?B?MFREd25kTktVdlZuRElvakdkYXNzeU5iZzB3T1ZTUkxUUzhqRjFJMnh4NkFG?=
 =?utf-8?B?Y3kvc2JyQ2orYzlNQmtYTlc2NHZPeHJ6bmtaR1l0N1Jza3g2MUNWdlhRUzgx?=
 =?utf-8?B?RkxQV2ZPeEZGYzUxSWxVdHJXT1lOOGN6K0c4ODVkeWJFTTNuMXdUNEZ0SXRm?=
 =?utf-8?B?NmI3bVRRQVBRU2NCdFpxUEp1dTZVdldaR1M1elZrY05WWm14K2N4dEtSbUM2?=
 =?utf-8?B?dkZWZUZjRDEweXBPc3F6eVRrNHJiYnNPWGQzTUlDdy9iMEd2YWZrK1NuSWc0?=
 =?utf-8?B?L1hldzY4VTBuV2ZyWmVhdDJ3OEVIY3FEZ2dONDNXc1BqeVV5VzFYeXdmc1J6?=
 =?utf-8?B?Rk1hcVhTMTRsT3ptNlpyS2hoQlRoSDFWKzdoUndkZGtON3VQV29rZndoeEh2?=
 =?utf-8?B?OFFtTWcxMjVMZGNJUC9jUTVkcmgzWXFOK2pDYUJSNVJEY1Z5OXFZaFJ4ckhT?=
 =?utf-8?B?aHRzcFN2VzN3Z0p1bDhvdGZ1blFTaUczcU8ramlBaEt5SWRoN1lSUlhITjM5?=
 =?utf-8?B?L1JKdWJUSFhGaUJPS2JsWER0dUJrRUcyZnoxZlg1a05aK3lyZlZJYUxIZWpw?=
 =?utf-8?B?bHZMalg0RHRHbFEvUVFkVjZHYktFcnM3VnNFSVdvZkpZd0F6VU5kVkExdzR6?=
 =?utf-8?B?K3k3SDlEWGV6bGgwdkNnS2RGcTFtc3E5amcrV0o0QllqOW81M3RBcnFWZjVs?=
 =?utf-8?B?elRESksyV0VTQWJmWnJGM0ZtTHhCK3Z4YVJhdlJtdUplZ3BlY0xsT2RHK3FC?=
 =?utf-8?B?TzNsd203R1RsbE5oTUFvenI5RW4xcHRrbkp0cndpM0RudVRMWE5nbTFPMmVy?=
 =?utf-8?B?TFZDd0Y4OWQvWjhDNGtSQWJyMDR6OWU2NjYxbWk4NHpxaTRXdmlueU1WN1hJ?=
 =?utf-8?B?VXY2SjlLc21lN1BTZ0dBOXl4L2R4MjNYZHBqallWY3MxQ2FSaDgyOU52emdm?=
 =?utf-8?B?OVFpK2liK3VIS00wMVZsQ0tHdzFqOE9VTFI5TDVzb0RBK0dmTTJOTVNDbEk4?=
 =?utf-8?B?d0lQQ25EeFFXQVcya2Qxd2RTSjd4MDBUYWNjNlQxT1RDUkE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b65a61c-bbce-4bc0-1bda-08de81dcdfc0
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2026 15:17:58.4238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0617
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225426-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_MUA_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,linutronix.de,goodmis.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rsworktech@outlook.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,vger.kernel.org,lists.linux.dev,kernel.org,meta.com,linux.dev];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,bpf-ci];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim]
X-Rspamd-Queue-Id: EA24028DA2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 3/14/26 7:09 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
>> index 9c96a4477f81..8e4b0fe6d12a 100644
>> --- a/kernel/bpf/bpf_local_storage.c
>> +++ b/kernel/bpf/bpf_local_storage.c
>> @@ -894,7 +894,8 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
>>  	 * preemptible context. Thus, enforce all storages to use
>>  	 * kmalloc_nolock() when CONFIG_PREEMPT_RT is enabled.
>>  	 */
>> -	smap->use_kmalloc_nolock = IS_ENABLED(CONFIG_PREEMPT_RT) ? true : use_kmalloc_nolock;
>> +	smap->use_kmalloc_nolock = IS_ENABLED(CONFIG_PREEMPT_RT) &&
>> +		KMALLOC_NOLOCK_SUPPORTED ? true : use_kmalloc_nolock;
> 
> Should the comment above be updated to reflect the new behavior?
> It currently says "enforce all storages to use kmalloc_nolock()
> when CONFIG_PREEMPT_RT is enabled", but the code now only enforces
> kmalloc_nolock when both CONFIG_PREEMPT_RT and
> CONFIG_HAVE_CMPXCHG_DOUBLE are enabled. On PREEMPT_RT without
> HAVE_CMPXCHG_DOUBLE, the override is silently skipped and the
> caller's value is used instead.

I didn't give it too much thought initially. So the kmalloc_nolock() usage in PREEMPT_RT
context is necessary for correctness. I will remove "&& KMALLOC_NOLOCK_SUPPORTED" in v2
and add a comment to explain the current limitation when PREEMPT_RT is combined with
an architecture that doesn't HAVE_CMPXCHG_DOUBLE.

Best regards,
Levi

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23086356774


