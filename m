Return-Path: <stable+bounces-230209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOrRAJfWwmllmgQAu9opvQ
	(envelope-from <stable+bounces-230209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 19:23:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B41F31ABF3
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 19:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87737305148E
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 18:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F18538D69B;
	Tue, 24 Mar 2026 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Hai0ijOf"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023084.outbound.protection.outlook.com [40.93.196.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7531E5B88;
	Tue, 24 Mar 2026 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376416; cv=fail; b=a7qlnr5P6OJzWFCo4v3Uok9+F6v2pCLXrQC66NZRlThvGAG4VUzLvvFFzxFqqUfKt3vUK7roYsPoEf2aEJ40fydfZFKOmisXbA5dNzd6IyBOknTIXx4i45UyJzjBTjmZJyz5wG7MwcYDLUqZkdd3tUrUDYE1u4x2yBuhFnTdIcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376416; c=relaxed/simple;
	bh=o29fHlvOgeAadAiWQzYTNwnhBFfdX/HYUX7y2SEuZbQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WPQtKBEiiuY9pSCsmqPHlc3SolT8qcompy4aT5HpC7u+2QqQdk+YmpO6NjGtFV25IOPLEwLR8imME/QInSt6RfJKGTYnmqiNwD6T23oq8ZLZ8vokhEAnt4k+CCOtFg5/QG6UVzn7VMNdUmUPxwq8B/Xp/wQmNTobK/cBHswJ0Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Hai0ijOf; arc=fail smtp.client-ip=40.93.196.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EK1DG2SLJ15OtxEbeQU/+FpZanwuZD8psMAEHuqaFvTFKwsYshB/wiemzwFsCNepccpFW562z7CxCOcitU/+uK1Q6V5twtxB/0JdKaK3wZHMLYEISab+Q3ErrBni3xwd5MVHDuNWFU7YXfvsFu6P2K09wL6/ikU+Z+AV7aAM3efCVP8qEYM8hFbdV4QHsnApr3zTd8EZ2zHWc5cwoIlLY+ldMgVxmEtJNgOkL0wBWVvDKQ5vW+g7lR9dyLrw6esICab17uSrw6nY/55wWfJ8ssGeDLly/HkkGXYY3mgSQ/o4CnAvN+C0r+0VkuL84CPHeQxLv8l4XQkXaUCyBgj/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSJjppG7G15PEbCmP+x/HkZ/Vz0jXnKQx+vBTUnOVDU=;
 b=laD7qK+G5T8ogmoPH3Qd0e96GtGyGo+Ixo1Ll9hvb+cG506ann6/06+RescXefLyPEUFrhO5lM/h200wzaK38zMjv8+tJt81wHx9rKpNadkLi3zvCpX+eVGQZK2GvybhEsoCS2/2kqHpKbDBStlsdNpZaPi1UYi9hYq1OrMwj3+NNYjj4hcZ9UBD7kJxw0l5m9a5EbWOcbt6U/FJMYS7uOmine6/jRWN9XRelXBd5xzuxMqx/96VQA8E9f5fCY1Utd0fx9p47t2qXGDzC3t/xBmevnLQKX1izmsaQlgm+3ll+c3OxG3NqZ86GP3PtfnYRyr8fTcmmkWM+y2v5b9qrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSJjppG7G15PEbCmP+x/HkZ/Vz0jXnKQx+vBTUnOVDU=;
 b=Hai0ijOfwnTjtwgmcN/4s3IOKc96IrGZ5LqqUm6mkksY6g5LmyQqYGx96GTgk4Rn6nBXrXfDvR9UBWW/RxQM33xO99RpM5uVCBZHGeYVVFR8nZG19UfTeS5nsfNAKfqQbhuvkPZS0OlUNR7P1HXdComB9xmih/IYgZ3h5FVpnzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 LV9PR01MB9398.prod.exchangelabs.com (2603:10b6:408:2ed::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Tue, 24 Mar 2026 18:20:10 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 18:19:42 +0000
Message-ID: <401073fd-3438-419d-8287-35eea61919b0@os.amperecomputing.com>
Date: Tue, 24 Mar 2026 11:20:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] arm64: mm: Handle invalid large leaf mappings
 correctly
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Jinjiang Tu <tujinjiang@huawei.com>, Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260323130317.1737522-1-ryan.roberts@arm.com>
 <20260323130317.1737522-3-ryan.roberts@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20260323130317.1737522-3-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0062.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::39) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|LV9PR01MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ba8d33-0956-4cc3-52f8-08de89d1eb19
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|55112099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KW0RVmHyLdqYY1lWWNl153NmwhWi6SfluXEmemagpg6JZ8xty+KWVfgoejMFRpE8S+fRkdNFbcikIGJO9F2NQpCvnC+tmCo/n+KB+ixM6JeSZa7urLHettzwqTiT8I4EN8Ka4s9ZxCATm9RKzUieU0M8pmj3Hb2LX0HR7NYKys6eDGwXFlG/TQoE+o+5NMQ3jpwmAK9bQ0H2enZLfArcv4VObBuS4Ei3+gdLRMT4PP8WtwKP//ijjw3p0C6gyn4oxGir6w5d1lHjNJRZQUqZe4CyZrQAaWgE5Bu47xUZJ/aDt6efQL3RvKpVre/e6T3RuOGYYt6iS5bcmAg3CaErdPZPPkED7R7BwmCbz/4zah9ysEbHAAJu/6ayeHVOwTzbKNNOi0eGujvrRxQnE0qF878subaNyAnbkMp3UGsSKPmaLArvJGL/ExMAdwHrk7b944GwVeM6tbMrVVB6q8zy6oIKMv6/3idLmLYt3y3o61VSBq6S1/IRUgkwX+q+rTCX87KrmvtFHSbMewegj2SlKGCwd+6C33G6GMe1ZOR5ze7tUmpt3AX/Vqsx9lrnJs7N+oFhfH2Uv5MEHLP3GUUl4jdantFsHdQ980nKK32Ja9DWj3mSf7ZaYL/H3kQqpOl9+bQrD+wcKQhBX6Dkdn+qF3Euk9xuxCrZahZImmKB25IYRWgzIoHrgECbIl3fdBqKo/PpPZzrHNXcDb+YRID4lr/rOiQgj60+Az6Z3IKy2/o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(55112099003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVhIRzB0UjFTZ24yUTJPYVZlWWN5MlhITStWWm5EZE9sWCtRM2ZnN0ZER3dL?=
 =?utf-8?B?YmswWmhZVlRzcWEyanA4bEVWQkd0WEJIS1lKbTBsV1ZaQSttZnZMbmJJS2h0?=
 =?utf-8?B?WDVERHBzVDRBTWE2REZMbEVZaFFHVkNYVEthV3ZtdmZoUGQ5ak1yK20xS2ht?=
 =?utf-8?B?YXFVbmdhOWJGR0xDQTVmWmtVc0hkZkFGY054N2ZSd3EzeEtzaWhJbE5aYTNa?=
 =?utf-8?B?UTZSTmlNR3o4NmlBWTZOaHZ6Umh3Sml2VFFPUTg5YWVpRGtOOWhtQWRTNGpN?=
 =?utf-8?B?djByYWdDZW9HSzBnL2ZwdU9GNytuajJyaFZPZ3VubGpkdm1lcHRnS2xlSHc1?=
 =?utf-8?B?MHNSY2RhdytBVW0vWm04cDd6ZkNwS0NTc3huL3lwRjNodFFncEMxMkZxanFT?=
 =?utf-8?B?bWE0WStrYmJmU0NoNVZBY040cnhsUVZGRGpaU00welZuMUpzcjV0cFNOd3VD?=
 =?utf-8?B?K0RvSDhvSmtaTlRrd2M3WWpCRk53Wkc3WnZqNnpzbHduL0xSVERtd2NqbjBm?=
 =?utf-8?B?bmJsYTl4Wk43ZnZwZWtVaGJuTlBKVnV2WXVVVzZxM0tQcDBweEx2eUVUWkxG?=
 =?utf-8?B?TkpFLzlES2xOQ25DNmhCbGl5TFNxZDQ2UTB3TGl0NWEyWEYxMjFvZVVyNEFL?=
 =?utf-8?B?dEl6dWRvbStrVG1oNmNINW8vdGZIOHoya3JYY3ZoNUdBTzJudDc4cCtYVHVq?=
 =?utf-8?B?WVF1d1N6QkRDTVhidGsySjFQbjRKRVk3Vm9PS2ErR3Eybk9Gd0taWHptMUMz?=
 =?utf-8?B?eVhFWXNBTzJMLzAzNXp1b21CTVZzcUZ0OStxUUFYK2JGVk8rVm1SbkhjNDdG?=
 =?utf-8?B?WmZ3c1J6d01IOGN0YURqSk9iSXlpOHpzN3A3T1YxSGp3QXVWb3hOQzdhQUFJ?=
 =?utf-8?B?Y2pRLzlRWnBqMmNOcVRKRHVQbmRMeGtGN3NMUE9wNFpYcGsrNkNoZEhtVVo2?=
 =?utf-8?B?RVJ5ZVJEaEMrTXhQK0VpWTgyYzlLeXJRdzZVTlZsTVU2eVZKRFBUeTNzd3J3?=
 =?utf-8?B?ek5ERHdKbG5SQnpCeVdkV3ZETWdCcCtBSXNTZmdGS3QzWFNwQTlvaFVJTXBR?=
 =?utf-8?B?cWFKaDFJck9JUXZFQjlkdzVUc3BJMVFCLzhQSzViM1VZMXNYbnF1blNRNzRZ?=
 =?utf-8?B?QVE1WjF4cGQ5NkovUldGSjVUZ1kydmJvc3hodW9zalZVeHg2Qk5obnlxMjhp?=
 =?utf-8?B?VDZ6d0JFaE5WMC81SmVySXZreThYMVZWUERPT1YxL1hwblBPeENDcGtmRktK?=
 =?utf-8?B?U20zQ2VpRUxYcnh3R1VLYnF3MXJUR1o0R3ZtQ29TOUhXTGdiNFJhcW1jbkJZ?=
 =?utf-8?B?blpYbTg1dDlnT01nc1Zqd1h4aFVEYVRoK2R3NE81N0FKVXRnM3RlUkttZnQr?=
 =?utf-8?B?TENOemdBN0VUMVlESURXcldYUUNzaWx5cVBQTHBWNllaUXhjVWJFY1NqQXJv?=
 =?utf-8?B?MEZESC9uTVkxZ1JnUmJId0hUMXRJcEQwVE95QlYvZTYxNys3RFlBbVhRSUJK?=
 =?utf-8?B?TXN6WENUeFFtY042YlZLOVNOOUVqakFtQjNvQnpOWjVLekVkRGV2MlhVL1Bq?=
 =?utf-8?B?U1hZdVNOMjBSUFp0UVh5SmpMZHZ3WDVWcGpHOTd5Z2tlSCtHWlkvamRjN0hN?=
 =?utf-8?B?eVIzL3VwbFdLSmhkb2Q3YktWMDh0eGlzMHQzTlNwS1B6QXo5Zkx3b3FHV2Y1?=
 =?utf-8?B?aG9MdXBiRWRQREhPOWUxWDRNa3YwUktZT3ViQUxWUmV4eisyN1dOTjF5SnJ6?=
 =?utf-8?B?UlFuemRVc3R0V3p1V1JpalVSaUtkcDJpMHhRam1sN2lzL1BsTElScldCeTZp?=
 =?utf-8?B?L3NCNkFMRWFMSEROcVFhcmZLVi95VThRUURyVks1NW1xekoxdjFoUWh0dlN0?=
 =?utf-8?B?WlRldGVlQmpzeW1xbmlGZktEWDNoMkdwWk4zZGhnYVBaL1QzL3ozSlMrcUI2?=
 =?utf-8?B?KzZXYkJudlJXbEdTbitQVWtOTjNVTHpTUjl4RXBTdGg5TWh5c0tOUzYxR2U1?=
 =?utf-8?B?QW8wdTFUWmNZYUNycDJ4d0RjVU5PV2FjY1RFSjRmUjM4RVlKeEFnQ1lrazJ0?=
 =?utf-8?B?YW96c0hWOHk4OHFyMDJzUXRSVlF1by81YzR4Q1B4SGM1ZG1LSGk0cE9KcUFo?=
 =?utf-8?B?S3dMV3BiVGs1ZkxZUHd6aFVXNXNtcWdzNWtvb3drVXVzSTZiZHFrcUwyYWp0?=
 =?utf-8?B?MWR2emNaWmFSSzUvRWdrZVVKdHMrb3REb3hBb3JkeWJwY3J3ekNaSXMyNkxy?=
 =?utf-8?B?dVRkb1JKOVY1dUdrbmY4K1lac0dyYVFHeTJvalAxalZvSE5UY3FlZFArbCsz?=
 =?utf-8?B?bFo4TmFQYlpZVTFWcVRhOVYrU2lEVGEvYnY1TzhLT1RsTWo2MkNtRDBaU1lq?=
 =?utf-8?Q?G9I2Qh5v5xQZQL3Q=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ba8d33-0956-4cc3-52f8-08de89d1eb19
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 18:19:42.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30T/DSrt4T0KLRfbBIi0fmN/gyvB3tvs0MiTnTZDz9xt91/JHxn463XnrGnyzbPR+cWytBMZP8VS7S9hTHy2NXXnHEGe/LZYYxE+evRgL5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR01MB9398
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230209-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yang@os.amperecomputing.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email,os.amperecomputing.com:dkim,os.amperecomputing.com:mid]
X-Rspamd-Queue-Id: 5B41F31ABF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/23/26 6:03 AM, Ryan Roberts wrote:
> It has been possible for a long time to mark ptes in the linear map as
> invalid. This is done for secretmem, kfence, realm dma memory un/share,
> and others, by simply clearing the PTE_VALID bit. But until commit
> a166563e7ec37 ("arm64: mm: support large block mapping when
> rodata=full") large leaf mappings were never made invalid in this way.
>
> It turns out various parts of the code base are not equipped to handle
> invalid large leaf mappings (in the way they are currently encoded) and
> I've observed a kernel panic while booting a realm guest on a
> BBML2_NOABORT system as a result:
>
> [   15.432706] software IO TLB: Memory encryption is active and system is using DMA bounce buffers
> [   15.476896] Unable to handle kernel paging request at virtual address ffff000019600000
> [   15.513762] Mem abort info:
> [   15.527245]   ESR = 0x0000000096000046
> [   15.548553]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   15.572146]   SET = 0, FnV = 0
> [   15.592141]   EA = 0, S1PTW = 0
> [   15.612694]   FSC = 0x06: level 2 translation fault
> [   15.640644] Data abort info:
> [   15.661983]   ISV = 0, ISS = 0x00000046, ISS2 = 0x00000000
> [   15.694875]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> [   15.723740]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [   15.755776] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000081f3f000
> [   15.800410] [ffff000019600000] pgd=0000000000000000, p4d=180000009ffff403, pud=180000009fffe403, pmd=00e8000199600704
> [   15.855046] Internal error: Oops: 0000000096000046 [#1]  SMP
> [   15.886394] Modules linked in:
> [   15.900029] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-rc4-dirty #4 PREEMPT
> [   15.935258] Hardware name: linux,dummy-virt (DT)
> [   15.955612] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [   15.986009] pc : __pi_memcpy_generic+0x128/0x22c
> [   16.006163] lr : swiotlb_bounce+0xf4/0x158
> [   16.024145] sp : ffff80008000b8f0
> [   16.038896] x29: ffff80008000b8f0 x28: 0000000000000000 x27: 0000000000000000
> [   16.069953] x26: ffffb3976d261ba8 x25: 0000000000000000 x24: ffff000019600000
> [   16.100876] x23: 0000000000000001 x22: ffff0000043430d0 x21: 0000000000007ff0
> [   16.131946] x20: 0000000084570010 x19: 0000000000000000 x18: ffff00001ffe3fcc
> [   16.163073] x17: 0000000000000000 x16: 00000000003fffff x15: 646e612065766974
> [   16.194131] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [   16.225059] x11: 0000000000000000 x10: 0000000000000010 x9 : 0000000000000018
> [   16.256113] x8 : 0000000000000018 x7 : 0000000000000000 x6 : 0000000000000000
> [   16.287203] x5 : ffff000019607ff0 x4 : ffff000004578000 x3 : ffff000019600000
> [   16.318145] x2 : 0000000000007ff0 x1 : ffff000004570010 x0 : ffff000019600000
> [   16.349071] Call trace:
> [   16.360143]  __pi_memcpy_generic+0x128/0x22c (P)
> [   16.380310]  swiotlb_tbl_map_single+0x154/0x2b4
> [   16.400282]  swiotlb_map+0x5c/0x228
> [   16.415984]  dma_map_phys+0x244/0x2b8
> [   16.432199]  dma_map_page_attrs+0x44/0x58
> [   16.449782]  virtqueue_map_page_attrs+0x38/0x44
> [   16.469596]  virtqueue_map_single_attrs+0xc0/0x130
> [   16.490509]  virtnet_rq_alloc.isra.0+0xa4/0x1fc
> [   16.510355]  try_fill_recv+0x2a4/0x584
> [   16.526989]  virtnet_open+0xd4/0x238
> [   16.542775]  __dev_open+0x110/0x24c
> [   16.558280]  __dev_change_flags+0x194/0x20c
> [   16.576879]  netif_change_flags+0x24/0x6c
> [   16.594489]  dev_change_flags+0x48/0x7c
> [   16.611462]  ip_auto_config+0x258/0x1114
> [   16.628727]  do_one_initcall+0x80/0x1c8
> [   16.645590]  kernel_init_freeable+0x208/0x2f0
> [   16.664917]  kernel_init+0x24/0x1e0
> [   16.680295]  ret_from_fork+0x10/0x20
> [   16.696369] Code: 927cec03 cb0e0021 8b0e0042 a9411c26 (a900340c)
> [   16.723106] ---[ end trace 0000000000000000 ]---
> [   16.752866] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [   16.792556] Kernel Offset: 0x3396ea200000 from 0xffff800080000000
> [   16.818966] PHYS_OFFSET: 0xfff1000080000000
> [   16.837237] CPU features: 0x0000000,00060005,13e38581,957e772f
> [   16.862904] Memory Limit: none
> [   16.876526] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
>
> This panic occurs because the swiotlb memory was previously shared to
> the host (__set_memory_enc_dec()), which involves transitioning the
> (large) leaf mappings to invalid, sharing to the host, then marking the
> mappings valid again. But pageattr_p[mu]d_entry() would only update the
> entry if it is a section mapping, since otherwise it concluded it must
> be a table entry so shouldn't be modified. But p[mu]d_sect() only
> returns true if the entry is valid. So the result was that the large
> leaf entry was made invalid in the first pass then ignored in the second
> pass. It remains invalid until the above code tries to access it and
> blows up.

Good catch. I recall I met this problem when I worked on a very early 
PoC of large block mapping patch. It took a total different approach 
than BBML2_NOABORT. I didn't run into that problem when I implemented 
BBML2_NOABORT because nobody actually changed valid/invalid attribute on 
large block mapping granule so I forgot it. But I definitely missed 
realm usecase.

>
> The simple fix would be to update pageattr_pmd_entry() to use
> !pmd_table() instead of pmd_sect(). That would solve this problem.

Yes, I agree.

>
> But the ptdump code also suffers from a similar issue. It checks
> pmd_leaf() and doesn't call into the arch-specific note_page() machinery
> if it returns false. As a result of this, ptdump wasn't even able to
> show the invalid large leaf mappings; it looked like they were valid
> which made this super fun to debug. the ptdump code is core-mm and
> pmd_table() is arm64-specific so we can't use the same trick to solve
> that.

I don't quite get why we need to show invalid mappings in ptdump? IIUC 
ptdump is not supposed to show invalid mappings even though they are 
transient.

Thanks,
Yang


>
> But we already support the concept of "present-invalid" for user space
> entries. And even better, pmd_leaf() will return true for a leaf mapping
> that is marked present-invalid. So let's just use that encoding for
> present-invalid kernel mappings too. Then we can use pmd_leaf() where we
> previously used pmd_sect() and everything is magically fixed.
>
> Additionally, from inspection kernel_page_present() was broken in a
> similar way, so I'm also updating that to use pmd_leaf().
>
> I haven't spotted any other issues of this shape but plan to do a follow
> up patch to remove pmd_sect() and pud_sect() in favour of the more
> sophisticated pmd_leaf()/pud_leaf() which are core-mm APIs and will
> simplify arm64 code a bit.
>
> Fixes: a166563e7ec37 ("arm64: mm: support large block mapping when rodata=full")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   arch/arm64/mm/pageattr.c | 50 ++++++++++++++++++++++------------------
>   1 file changed, 28 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 358d1dc9a576f..87dfe4c82fa92 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -25,6 +25,11 @@ static ptdesc_t set_pageattr_masks(ptdesc_t val, struct mm_walk *walk)
>   {
>   	struct page_change_data *masks = walk->private;
>   
> +	/*
> +	 * Some users clear and set bits which alias eachother (e.g. PTE_NG and
> +	 * PTE_PRESENT_INVALID). It is therefore important that we always clear
> +	 * first then set.
> +	 */
>   	val &= ~(pgprot_val(masks->clear_mask));
>   	val |= (pgprot_val(masks->set_mask));
>   
> @@ -36,7 +41,7 @@ static int pageattr_pud_entry(pud_t *pud, unsigned long addr,
>   {
>   	pud_t val = pudp_get(pud);
>   
> -	if (pud_sect(val)) {
> +	if (pud_leaf(val)) {
>   		if (WARN_ON_ONCE((next - addr) != PUD_SIZE))
>   			return -EINVAL;
>   		val = __pud(set_pageattr_masks(pud_val(val), walk));
> @@ -52,7 +57,7 @@ static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
>   {
>   	pmd_t val = pmdp_get(pmd);
>   
> -	if (pmd_sect(val)) {
> +	if (pmd_leaf(val)) {
>   		if (WARN_ON_ONCE((next - addr) != PMD_SIZE))
>   			return -EINVAL;
>   		val = __pmd(set_pageattr_masks(pmd_val(val), walk));
> @@ -132,11 +137,12 @@ static int __change_memory_common(unsigned long start, unsigned long size,
>   	ret = update_range_prot(start, size, set_mask, clear_mask);
>   
>   	/*
> -	 * If the memory is being made valid without changing any other bits
> -	 * then a TLBI isn't required as a non-valid entry cannot be cached in
> -	 * the TLB.
> +	 * If the memory is being switched from present-invalid to valid without
> +	 * changing any other bits then a TLBI isn't required as a non-valid
> +	 * entry cannot be cached in the TLB.
>   	 */
> -	if (pgprot_val(set_mask) != PTE_VALID || pgprot_val(clear_mask))
> +	if (pgprot_val(set_mask) != (PTE_MAYBE_NG | PTE_VALID) ||
> +	    pgprot_val(clear_mask) != PTE_PRESENT_INVALID)
>   		flush_tlb_kernel_range(start, start + size);
>   	return ret;
>   }
> @@ -237,18 +243,18 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
>   {
>   	if (enable)
>   		return __change_memory_common(addr, PAGE_SIZE * numpages,
> -					__pgprot(PTE_VALID),
> -					__pgprot(0));
> +					__pgprot(PTE_MAYBE_NG | PTE_VALID),
> +					__pgprot(PTE_PRESENT_INVALID));
>   	else
>   		return __change_memory_common(addr, PAGE_SIZE * numpages,
> -					__pgprot(0),
> -					__pgprot(PTE_VALID));
> +					__pgprot(PTE_PRESENT_INVALID),
> +					__pgprot(PTE_MAYBE_NG | PTE_VALID));
>   }
>   
>   int set_direct_map_invalid_noflush(struct page *page)
>   {
> -	pgprot_t clear_mask = __pgprot(PTE_VALID);
> -	pgprot_t set_mask = __pgprot(0);
> +	pgprot_t clear_mask = __pgprot(PTE_MAYBE_NG | PTE_VALID);
> +	pgprot_t set_mask = __pgprot(PTE_PRESENT_INVALID);
>   
>   	if (!can_set_direct_map())
>   		return 0;
> @@ -259,8 +265,8 @@ int set_direct_map_invalid_noflush(struct page *page)
>   
>   int set_direct_map_default_noflush(struct page *page)
>   {
> -	pgprot_t set_mask = __pgprot(PTE_VALID | PTE_WRITE);
> -	pgprot_t clear_mask = __pgprot(PTE_RDONLY);
> +	pgprot_t set_mask = __pgprot(PTE_MAYBE_NG | PTE_VALID | PTE_WRITE);
> +	pgprot_t clear_mask = __pgprot(PTE_PRESENT_INVALID | PTE_RDONLY);
>   
>   	if (!can_set_direct_map())
>   		return 0;
> @@ -296,8 +302,8 @@ static int __set_memory_enc_dec(unsigned long addr,
>   	 * entries or Synchronous External Aborts caused by RIPAS_EMPTY
>   	 */
>   	ret = __change_memory_common(addr, PAGE_SIZE * numpages,
> -				     __pgprot(set_prot),
> -				     __pgprot(clear_prot | PTE_VALID));
> +				     __pgprot(set_prot | PTE_PRESENT_INVALID),
> +				     __pgprot(clear_prot | PTE_MAYBE_NG | PTE_VALID));
>   
>   	if (ret)
>   		return ret;
> @@ -311,8 +317,8 @@ static int __set_memory_enc_dec(unsigned long addr,
>   		return ret;
>   
>   	return __change_memory_common(addr, PAGE_SIZE * numpages,
> -				      __pgprot(PTE_VALID),
> -				      __pgprot(0));
> +				      __pgprot(PTE_MAYBE_NG | PTE_VALID),
> +				      __pgprot(PTE_PRESENT_INVALID));
>   }
>   
>   static int realm_set_memory_encrypted(unsigned long addr, int numpages)
> @@ -404,15 +410,15 @@ bool kernel_page_present(struct page *page)
>   	pud = READ_ONCE(*pudp);
>   	if (pud_none(pud))
>   		return false;
> -	if (pud_sect(pud))
> -		return true;
> +	if (pud_leaf(pud))
> +		return pud_valid(pud);
>   
>   	pmdp = pmd_offset(pudp, addr);
>   	pmd = READ_ONCE(*pmdp);
>   	if (pmd_none(pmd))
>   		return false;
> -	if (pmd_sect(pmd))
> -		return true;
> +	if (pmd_leaf(pmd))
> +		return pmd_valid(pmd);
>   
>   	ptep = pte_offset_kernel(pmdp, addr);
>   	return pte_valid(__ptep_get(ptep));


