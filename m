Return-Path: <stable+bounces-230014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NzbHCGywWnlUgQAu9opvQ
	(envelope-from <stable+bounces-230014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 22:35:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BE12FDCBA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 22:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F335303B949
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 21:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACE637F013;
	Mon, 23 Mar 2026 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="OSclN+We"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020101.outbound.protection.outlook.com [52.101.46.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F94437F016;
	Mon, 23 Mar 2026 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774301675; cv=fail; b=bvai2XDTTY20Ndc+VNbLTOzPxLh3iQhy74TISaNwJ0xV+XxPwBQcSMrqkNmSIK9HifWqto94prxEIoTyBw7jM8bo4cPJHF1RgB5RLU6zejIkKKVO+5yUxtjNlkosWMbrgZStsCasmgxYOlOG0qh1nt5Qz8/VtDQWJu9aoBAZVUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774301675; c=relaxed/simple;
	bh=cmzDTRu5OW5QXYAIg5Fl8FCa6MDaO3pufgyr/svRp4Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rFKoucmpaYb4ZwsvLBUylMEFFJEQrLD11LHhJ4R6XKvdheQSb9Mh2pYUc4t6yuWqNCdvthPjScutgHlZ31/M4odeDI+TqRwhZKnqU5vSaCsflvn3T6ZkxE0WFdXdMWsvxu1hbWdvOHsl44jY4gqrIM2/MdVs+8/9AR+MURxuAOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=OSclN+We; arc=fail smtp.client-ip=52.101.46.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1TCRVY/061cq1fLuQ+53vDqZ0q++toC3eieHG0ItyRfr50HMvoEzwgKaYDrLDegsXHtcjjScmKJ3PLDegFTplu3AIM6WJTpVQq+Ra3a5vmuto21DhJYjW3VkmhdXCNXcpfZQih1DPArSGblN+KPjLbL2M/um7MumqXIxPynTSOywqvAkNsM0QlbAKqQ9QtQ7B1Q/sKrslcT1BKVAHvyFYcQ9rOaZEXiospBwLC8LbEey24NAX9KR++3MGqTYfyYeH8x6WdRUQtKzEbaVSNc3PROEcBkP5IlfGKhOwdBQonp3ujDwJQNCtVQzIoV9kTlwUxoGihU2IJ0FWC9NYboKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHKGou1cRoa9wRPIVYoOzzo1Bae61UFki/1j2H6dVvM=;
 b=Q/tyL7eWSOhsb06gDmiwrOQyDbMxW47kGjSpC1wvPyEGhuat23z+tx8VcVRyDG7R4RtQfWHXbXiMLtDHn66WoH20bc5Ly7ckVdQu+xyCOxkEfUsCTfJARY4ULFOpm+SjSonu0LheWsAe833SM6sTUzMh91vfKpWaK3SBRNAsbFgzpReA7N2b3n00A1I/yNHbkB3WZIDwAEeQIfnIA+J/mjFEmqcdiSDnjXzu8OaJFh4EC6hbM2deGuT9LMswiO/vP1ll7Hnix3OhAYSrQ0Wp2SNxGIeeBG/oLn/oLyI62WlBBgTgbUUjtvkNAM/4kFmV/1zkIVeHz/6s7uYqqV1dRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHKGou1cRoa9wRPIVYoOzzo1Bae61UFki/1j2H6dVvM=;
 b=OSclN+We2T3sTpAHxVTWu7+WV6MWx38npcAe4Lz30zL0YZKA1vGKS1XFuCqNM+z0VXfEr1id8T+J+sqZytksqZZlZOGxkCbf1Wwl/BfcWMDSgaBWshlBJSgZG8XFYv3TCMk4hY8FRCOxcdXmoU5Rkl14G29YSxfGqIxJ5lvEYYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CO1PR01MB7307.prod.exchangelabs.com (2603:10b6:303:156::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.31; Mon, 23 Mar 2026 21:34:02 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 21:34:08 +0000
Message-ID: <a3766dfc-06ed-4cdc-9c55-0dcc3638746e@os.amperecomputing.com>
Date: Mon, 23 Mar 2026 14:34:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] arm64: mm: Fix rodata=full block mapping support
 for realm guests
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Jinjiang Tu <tujinjiang@huawei.com>, Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260323130317.1737522-1-ryan.roberts@arm.com>
 <20260323130317.1737522-2-ryan.roberts@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20260323130317.1737522-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0144.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::29) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CO1PR01MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b6900f-c617-4c08-5833-08de8923e8f5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mOiABnVFeIGtLVflDlkV1WArvI+UbDxUX3by/ZvWOJiYSjcP6ar2y2ya03d2P8QVLgLpQBdf1DSiRWDc+L7f+QcEAy0nnUexUSRsBJ+1T9uVPnbh1TXPkPF3AdKOGh2QLfepftt4EhhU6ayZ6+u7nvW8gua7oRj2phiIMpASu2vmOSFq8Cx3iCxdgE04kZQje7rmeGSlOC/HxazScmzLCScajXvZiip2v/5b/i5B2P9GgdDPXc7U2RUYJJN0aI8H8BkTYe0/5stLuSoEHC+3wwQCIuFg5YPVQwNtOQ1aHEqshNkD7B8QDaIiwbugQA8CXrwNIMwqSY74XmyxFbJEhyc43JMMRA0qPvLL/POwUzgkS+p6bbv8NHQeHmI12ospugSvdz1fwXVwGFVNc05CDFyrk7yGG7RsPvpuo7kDGgciR0MD7Kjy1+3yKGZ1uM5/4JFeyHQI9r4WTsNP3GdLWTuwpZb9uU25iTLI/RelI4h0IFBOppiGrBW7N5lOBXHocnJvEPddoMhkxWhq7govKoUVgthLEI6WZhji/pd2pA3rqmigNpeXc2mIGHwbgfQ6EKJtcza0GhlC/AnENSaHS8ss3MXY4bc70vx9iaF+r+itG8xOFz3egGoIVA5BkF5DEexzrfraMNqYtdoqL/n1jNCNNCQQPX1LRHT4A6Ev2cWiK3/OlwqD68yzc9ruwu+N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(55112099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THY2N2hzaWxXZXFZbFR0bG9GL3hib25rVzF0OXpLRklQZmNvTmJnZ0VhT1hX?=
 =?utf-8?B?Yll4NW9wL0V2VjZMWHkyekVzNEtZRFJwTExUclBHajFYclgwYjFQbmUzZVUw?=
 =?utf-8?B?c0dMVHhTYjZMV0h2djd4cWhCYjdMVjVCYTVXQkJhZFE0YVMzMFNRaWNac3pP?=
 =?utf-8?B?SUptUi83T1ZOYWtoNFZjWFJnZTJycnpJbkJNSmdYYUxzckZTeFprK2krajE3?=
 =?utf-8?B?YmpCbS91aHo4TWtmenVBVWNxdUcxdUNpU1NQOUY3WWtrUTB3am1qUVpLOE9J?=
 =?utf-8?B?bDhrc2srQ2VHMHdTdmZMZ0VkVlZiMUVyMmlycjJQZVY1T3lvS2pEQU9LV2kr?=
 =?utf-8?B?WkNlKzBhZzJ3RW1XTHVRbGVLVVNXemtiYUMzQWpVdWpXZ2lwZk1jUWpwS1J2?=
 =?utf-8?B?anBYb3kyK3ROUGFLNEJnR1U3SzY0emdPNWN6U0lpbEQ1N2FIcStUYThONnRG?=
 =?utf-8?B?ZjJLWHZoNGFyRkZRKzNIRStKQlhwTy9UQTdtamZCUzRrbm1YMFNhS2tIZmRS?=
 =?utf-8?B?MXVTcWRvWWhnQ3RiK0pURGlad3p6RjFEaGx1Q2taNTAyK0ZHV256a2VJSmZO?=
 =?utf-8?B?RHowRnpWc0g2SmtydmxUN0xIOVh5WkJjUFFwMkJmVm1mcFVVMWk2VEVLeGM3?=
 =?utf-8?B?TGdyMng3MEFoRmVIQ09sRjRlU285aEJ6R28xMmdhTWFQeEE3dzBONU5VR0M3?=
 =?utf-8?B?QTc2STUwVkRmdlkyQ1RMYlBUVVBtaENUNzdRRzUwdm9qUERPVFRlL2l1VWlk?=
 =?utf-8?B?dkFWeTc0cW4wazNBcUJpSU9ZTVJtT2k4UHY0QXJhdEJ3K3E0ZllBR0NNNzQ3?=
 =?utf-8?B?NXFRbUs5QWlPUUVRMUZXYTV2WUIrMzc4V1lOdU01M3RTR0VOaXBVL3pTK3A4?=
 =?utf-8?B?UzBOTDdjTklCaEZTMVRHV21qQ3A4U0k0MWI5dFdnWHJvQVBvOU5LY2poaG5z?=
 =?utf-8?B?Z2svcTE2NlZOVGFoR25ubE84VEtUYnNKc3J6OEtmNmh3Mi9lS2F3NDB4OUY2?=
 =?utf-8?B?aXVIdGRxQy9VL2JmTFdERjdpdnRYd0gxRVBLQk1XYVFmemE0U2dQUVhGd2dX?=
 =?utf-8?B?THMxendEVm1vdXZSTERZaTBwR2hYYVQ5VDdiTzIza0tCVDdzYXZRSHMvQVBU?=
 =?utf-8?B?ckNla255MDdzZWZqMEVBelhpVzhVRkNqSTUyb2p4aGVKblJZT0dkeFgzcUM4?=
 =?utf-8?B?VUNvTWxvY3luVDhCSFNpam1WSHFwS3lSdFpuT3kreUhESk4rWGVJUmRxcnR2?=
 =?utf-8?B?Vnd6ZXdra0dvRmI2MUkxZ3lNN290WWtZUGp3c2lwQXVyWlMxMHRGZXFvVnBT?=
 =?utf-8?B?czFSREIyZVMvRURrQWx3cmdESHdneWIvMjgwN214UTBpb3hvcE10WWh1dlFW?=
 =?utf-8?B?YXNCV0V5cTkybU1CUkJnWU5sRkIyMFozZ1FBajJBeHlpMlFKQmVOT1U2ZFpk?=
 =?utf-8?B?NEpteUNiazZkb3VVemRnc0k3UG1sSWJsLzY3Q2toQzloS29iUWJPNTdnRXRU?=
 =?utf-8?B?Vi9pazh4VXRhVnFramtFS3RlZFp3dmNZRjJTZlVQQ1R4anAvOWI3OEswc09C?=
 =?utf-8?B?a2pSamYzalVqNjFEOHVTMlptZGNxWDQyMGo5OUxPVG5GbEV2WjU1REJ3d2w4?=
 =?utf-8?B?NXdPTHEyb2t0Sm9naUQxa3UvV0t1M1ZKaG45WXdOK0pKNU1JQ0lwTnVoREZL?=
 =?utf-8?B?SnJEMmxjSW1jOTloQVp0TWUzenJkVHc0cHRKUTkrdWJydjFuZW9TQU1mSEVM?=
 =?utf-8?B?U0hBTWRBVmdNUXRlSDVvTTJvZTVncnYzK1piRmRsVUk4cEdkL2RjcmRqeDRn?=
 =?utf-8?B?ZGsxSE1DUENkV2hORGZqNVJ5czkyYWVVOUlGQ1g0cXFENm9GdG9WNnVhN2hm?=
 =?utf-8?B?b2ErL3NzamhIRXM1ZzYzVSt5QzhZdDhuSHR6U203T2lFK09ucWcveE8zSjZI?=
 =?utf-8?B?N0tXTmYwd3Rsd3JVNy9lRnlSRjRUNGJPNWQxbkdmakpJaEJlZFJQMGczckFu?=
 =?utf-8?B?ZmtQNnJhQlhpYnlqSGxnbTNQN0NNUHhpK0lESjRsbThjSE9YeTN1NEJxNkF5?=
 =?utf-8?B?VDhKbFc0cStnTFNOclRSRE5KZ2Rhdlh6WU5TdnU0aURIQzBaVitxNFlkMWds?=
 =?utf-8?B?UHdNaGdTem1lYkNZVUdmMXdkYVJMY2FjUExqV1BVQlBScTNyWDgrWmRSOWw2?=
 =?utf-8?B?blBrQ2p0cEJxTW00VTJFUk5iUlVsem1jbjNZdC9MK1dSaFVwUXluN2xrcFZN?=
 =?utf-8?B?MUVTRnhDU3NsbkNoT2x1SGdBRzhPTUhKMFA2TkFKQ2M5Rjd5djExb1NNZGtF?=
 =?utf-8?B?T3lqREtvOEI2ZjhvdElaNzEwWHMyWFA4S3dtVHZ4NmdlaG8yWEtIMW0zY0ly?=
 =?utf-8?Q?kLDw+kgK8XWu7bMk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b6900f-c617-4c08-5833-08de8923e8f5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 21:34:08.0405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYO9RwfaMqnORZx01x7rFHnGYwClx7cTwqo6wle2pdt9pznZM1NRZGW1bIECWzSaZG/8hwaAHZp64qmkqzgMiT/VyUL1dlJsrBXgpAfNrS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB7307
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230014-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yang@os.amperecomputing.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,os.amperecomputing.com:dkim,os.amperecomputing.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: D9BE12FDCBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/23/26 6:03 AM, Ryan Roberts wrote:
> Commit a166563e7ec37 ("arm64: mm: support large block mapping when
> rodata=full") enabled the linear map to be mapped by block/cont while
> still allowing granular permission changes on BBML2_NOABORT systems by
> lazily splitting the live mappings. This mechanism was intended to be
> usable by realm guests since they need to dynamically share dma buffers
> with the host by "decrypting" them - which for Arm CCA, means marking
> them as shared in the page tables.
>
> However, it turns out that the mechanism was failing for realm guests
> because realms need to share their dma buffers (via
> __set_memory_enc_dec()) much earlier during boot than
> split_kernel_leaf_mapping() was able to handle. The report linked below
> showed that GIC's ITS was one such user. But during the investigation I
> found other callsites that could not meet the
> split_kernel_leaf_mapping() constraints.
>
> The problem is that we block map the linear map based on the boot CPU
> supporting BBML2_NOABORT, then check that all the other CPUs support it
> too when finalizing the caps. If they don't, then we stop_machine() and
> split to ptes. For safety, split_kernel_leaf_mapping() previously
> wouldn't permit splitting until after the caps were finalized. That
> ensured that if any secondary cpus were running that didn't support
> BBML2_NOABORT, we wouldn't risk breaking them.
>
> I've fix this problem by reducing the black-out window where we refuse
> to split; there are now 2 windows. The first is from T0 until the page
> allocator is inititialized. Splitting allocates memory for the page
> allocator so it must be in use. The second covers the period between
> starting to online the secondary cpus until the system caps are
> finalized (this is a very small window).
>
> All of the problematic callers are calling __set_memory_enc_dec() before
> the secondary cpus come online, so this solves the problem. However, one
> of these callers, swiotlb_update_mem_attributes(), was trying to split
> before the page allocator was initialized. So I have moved this call
> from arch_mm_preinit() to mem_init(), which solves the ordering issue.
>
> I've added warnings and return an error if any attempt is made to split
> in the black-out windows.
>
> Note there are other issues which prevent booting all the way to user
> space, which will be fixed in subsequent patches.

Hi Ryan,

Thanks for putting everything to together to have the patches so 
quickly. It basically looks good to me. However, I'm thinking about 
whether we should have split_kernel_leaf_mapping() call for different 
memory allocators in different stages. If buddy has been initialized, it 
can call page allocator, otherwise, for example, in early boot stage, it 
can call memblock allocator. So split_kernel_leaf_mapping() should be 
able to be called anytime and we don't have to rely on the boot order of 
subsystems.

Thanks,
Yang

>
> Reported-by: Jinjiang Tu <tujinjiang@huawei.com>
> Closes: https://lore.kernel.org/all/0b2a4ae5-fc51-4d77-b177-b2e9db74f11d@huawei.com/
> Fixes: a166563e7ec37 ("arm64: mm: support large block mapping when rodata=full")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   arch/arm64/mm/init.c |  9 ++++++++-
>   arch/arm64/mm/mmu.c  | 35 +++++++++++++++++++++++++++--------
>   2 files changed, 35 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 96711b8578fd0..b9b248d24fd10 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -350,7 +350,6 @@ void __init arch_mm_preinit(void)
>   	}
>   
>   	swiotlb_init(swiotlb, flags);
> -	swiotlb_update_mem_attributes();
>   
>   	/*
>   	 * Check boundaries twice: Some fundamental inconsistencies can be
> @@ -377,6 +376,14 @@ void __init arch_mm_preinit(void)
>   	}
>   }
>   
> +bool page_alloc_available __ro_after_init;
> +
> +void __init mem_init(void)
> +{
> +	page_alloc_available = true;
> +	swiotlb_update_mem_attributes();
> +}
> +
>   void free_initmem(void)
>   {
>   	void *lm_init_begin = lm_alias(__init_begin);
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index a6a00accf4f93..5b6a8d53e64b7 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -773,14 +773,33 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
>   {
>   	int ret;
>   
> -	/*
> -	 * !BBML2_NOABORT systems should not be trying to change permissions on
> -	 * anything that is not pte-mapped in the first place. Just return early
> -	 * and let the permission change code raise a warning if not already
> -	 * pte-mapped.
> -	 */
> -	if (!system_supports_bbml2_noabort())
> -		return 0;
> +	if (!system_supports_bbml2_noabort()) {
> +		/*
> +		 * !BBML2_NOABORT systems should not be trying to change
> +		 * permissions on anything that is not pte-mapped in the first
> +		 * place. Just return early and let the permission change code
> +		 * raise a warning if not already pte-mapped.
> +		 */
> +		if (system_capabilities_finalized() ||
> +		    !cpu_supports_bbml2_noabort())
> +			return 0;
> +
> +		/*
> +		 * Boot-time: split_kernel_leaf_mapping_locked() allocates from
> +		 * page allocator. Can't split until it's available.
> +		 */
> +		extern bool page_alloc_available;
> +		if (WARN_ON(!page_alloc_available))
> +			return -EBUSY;
> +
> +		/*
> +		 * Boot-time: Started secondary cpus but don't know if they
> +		 * support BBML2_NOABORT yet. Can't allow splitting in this
> +		 * window in case they don't.
> +		 */
> +		if (WARN_ON(num_online_cpus() > 1))
> +			return -EBUSY;
> +	}
>   
>   	/*
>   	 * If the region is within a pte-mapped area, there is no need to try to


