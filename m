Return-Path: <stable+bounces-231021-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPlgLRInymnX5gUAu9opvQ
	(envelope-from <stable+bounces-231021-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:32:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8C83567A7
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CCA93003828
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BBF3859C5;
	Mon, 30 Mar 2026 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sCZg6bxm"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010052.outbound.protection.outlook.com [52.101.61.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E1039E182
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774855912; cv=fail; b=Cb+0l1dams8rONDAS7Q40RJdAjeAAlhV96WNSopaPbo4kf7ZsCIgXP9VEN2yeVG9trXud4ZzZxvqZCBnP44iAbzToqbIe1TeZ+7oXartBMfjGwKrnmsiK54xXC9I1zKlUhYsKhnwjebcrzissKCVblUEVzJjcFeBzEeDz60o5yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774855912; c=relaxed/simple;
	bh=v0x7fi8rACUzKkzZbi6zuLAwJxHYMhBcCAG4v6IHss8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HsMw6pkIhsHOaOT+hYaWmYB4ovir+d8110ybbTb/a78bMbcp3vD18r2Mk5a1Ct4Qln5es/bW0s5CcGhXHYoHr0oWECc8NuRzzPzT4NfiAmRfr8h7V6u5/GHqkLXfB4RrHgTSQQ49+VhrKc7ZQQefvZ2Duf11E6kCtcbmk5rYQro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sCZg6bxm; arc=fail smtp.client-ip=52.101.61.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mi/hNV8qnGc7c5Piyn+18DsMQDbufeKCXWu3YpY/mn5CdCNqlHiAGEHejZ5O4M3b3KpEHI+3nsGUY/wNrURN+VEgDCv3AEceACpxQc65ma8NY7Rr1I9hrGi9uodzysOguud0ok5GPX6+QHpJKQ4e2025c1HdX4S1CcVzColTajH1J1S6z8wZkxEx+h17+cC6N0Z80JlwPcCF6jmIQmjSCK2/fi5WYwVSV+MmQnbd2t0wJgpEAc64KKNIxKb6RLP3oKkJ/xA2ZUFBuauTFmjj67/iXK4wrwKx8ZQuGJ/M106PpMjkaXYpE1BOPfwpXhaK5iqZmJGk89a/0qBa7w4bJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5kFNRmR/Plb0CBarPlcwdCUxkZeiCJk2khsWYjHBUw=;
 b=fxE25yoyz1D4AxfGMMZOOx1uxLFKE0BqU76YaTlSfZPfCKR4m+EyE2yg3PmaXGgHgS9f1oqAiQCF8FxQoocHtBDvqQTsfbxln19zLzJCoKyT88PsZGMVSMMMhxpIdCEFWXdq5WR2dfQL4GvWLLemAFnhOiQoVchu2ImDHIyM5E3Mgu4Tlwuls5sSw/67UW3egb1vv9LmWmjPueNz4E/k+GKevuBfM5/vKFkus0Jq+G8Baqpp2MNMo1vaJhlpmMb901r5wpHEm9Bx763TQPZck1mMZOur4+6E4n88Dfk7r34qNXFtqH5+xGLEg8kctylg7TDGdyrZtTq4Q5IRn8EMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5kFNRmR/Plb0CBarPlcwdCUxkZeiCJk2khsWYjHBUw=;
 b=sCZg6bxmPlLWi+Ud1xzMgqMzwxLMtgJK6l0ffHXxiNVtt8w2UjNSCLm6f+DOgJC6MAXeAqjC3CmSir+HuWe7AsPRKprr1q660gCKuXw0KzOv8uEJWmo/o5w/b/gpb16S/5rpvryhYevg9RhoRxKUyeHYYQ/ytQJ6R5mRN9FRUhw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 07:31:46 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 07:31:46 +0000
Message-ID: <dbf1994b-945a-4064-b294-5771e2844caa@amd.com>
Date: Mon, 30 Mar 2026 13:01:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix sleeping allocation under spinlock in
 PASID IDR
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20260328213900.19255-1-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260328213900.19255-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0229.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 97563ed5-5788-419f-aff0-08de8e2e65b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kChjQyrkiSiN0qteojGNyJK1hsg9rvrRgkIU4JW83T5s/gftb7ZVJ+QSQHUdGBf3Mcri0xami6+edmSMA/e7wvPt6tAhvskdhAG4OsyC0hGbiiiECOfxQiLQB4aAIj2AwO0q1+pcuBQLuYJowWmz9+TC8aX64H+vi/6InRDkjWyrAPRe6EcT2lriqotkilPXT7rSu9WL45B/BoG0azHjUlh/Js3wjDTf8i8LtZblQuMlfGqKEOlEvU3jCihntsU+GUqfzvInbzGyqLl8rYWTc++Oz/9jIHGI3EpU+uYN12tQ/PH5LcsfHIsqhRFIR2LmQCP9ofWdv/CgD7nUtGGIBiMya6FdwlJyjTI4O3+KkhSJhdyEglExxHb1DlFbY9iyNcHblV82eCwPXLV7DoIi26ezuwSSoIxBcaRYk1OeDrk3g8NuVo1eaiJHQ7axCTGtr8Ul4fE4d+FsAxvQcrQ4tbDjzlyrROoCvtWhKAd37k5ynyoXo2+RIKzA55md9gZSiM/kL6xWGGvwN5vxt0zAR1Wnjvah+T+jZnhgDxUgBTm+BvlVrAwMc8+jTCZDQh3snJshD3IVtVLnp6bcJdvrRXWGHg3ugkvYWg/wfcUWSAuvjMzxk3OYpsBIZRKVGE1UtVPJV65y4DmjId/icWOZeKKQ/q8h2U7DDc8n1i8rNqnwEoemzLI/DSkS3NI9pu5wVlgvKl2TSGAFqUG/NdPWAPmbhndHXDrypuRfL0jBxwY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7091.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHArdUZ3TG0rdm1GSTVUTTB3ZjJFYWVLbldwenRnRExjV3ZEK0cyVFplakN4?=
 =?utf-8?B?aXhRUXhTOENFMy9hblFQSlVJSlBveVVlRTFPTUZ2ZjE3TUlBOSttWDdSSklz?=
 =?utf-8?B?bDhFNTFneTJXRGo1WnJGU0VGWFB5elI4SzlrUlBVMVBUbzRvQnZhLzNpejdS?=
 =?utf-8?B?OE5mb0RvRGNtVDJHQnpQZ1BObDR5bm1sYjl4bk4rSEtLbmpIRFZ4L2hOY1h4?=
 =?utf-8?B?S1VxM002YStzWXMrdTFBLzVtM3VNOEN5YWpERDdTZXllMWNzLzBLQTNvNWFs?=
 =?utf-8?B?Zng3RndqcUxlY0I1WUU5R3BTeThDQU5VSStiNy91bXpKbjdZYXFJU0VHd2RP?=
 =?utf-8?B?T1NBNmVoSk1WbFhhK0tlQjUvallLSHE2eW5kb0Z6eVJlWDd5czhtRUw3S2Nw?=
 =?utf-8?B?aXJOSzFwNnFCK28rYXk1QTRLSEdqWXMwenlXODhtSncvQlZXeEk3ZTZkZ0JJ?=
 =?utf-8?B?cVVCeXIxNnN2akR5R3JySkhXb3p6eVNDWjhzZVRrekVqelMvTVo0S2dlaU1y?=
 =?utf-8?B?RmZEUHp3NW9Ha0JMYytaTXdZc0xLMDdBYkhZcHVTN2xrdlFSY1JsTW1HSU5C?=
 =?utf-8?B?OTZvRldSTEJzYjMydC82Z2ZiMHp5RnA0L3R1dmFUZldLQ2FMZDR0dnhSSUxD?=
 =?utf-8?B?YjRMV1lLeDRUeTRkbm10c2h6UVZjV2JVS3J3dE5VR200eEM5cTFJY1ZsS25s?=
 =?utf-8?B?K1RveXdINThFTkRIekpZMGlxM3FvK202a3c5ZmVYcW9ETFNyUmlVbzFRRDBt?=
 =?utf-8?B?YVVIRC9VR251dHl6OE83Q3VhSnMxaEdMU0hlTVd3ZEczRitqV3hua3lWSVZv?=
 =?utf-8?B?SXR5WGtRMlFTT2FuS3VBZ25ZNWdLSFFhV0ZKZHN5S0JML09uNWRFTVp5Z1ZB?=
 =?utf-8?B?bXlSS1pac3ZPV2ZpQnZGbFVNS0lxNHZRcVpUUjhrcnQ5aUZPdXBPM21RRk0v?=
 =?utf-8?B?aHk5aCtPRGUyQjVmTURoYTNkRlY0eG8zVWZBbFFZbFVCeS80WnI3VVhwRWVG?=
 =?utf-8?B?SU15aGJIUkZWbVFCQVYwQnlHUE9IaEwzUmN5a3hONllWdEJReTBMSXFTeTcx?=
 =?utf-8?B?OXJtLzgzbzcweWdhVnBrS0NhYW1DNnVZWHhRS2hYekFxekFtQkdWdDdocGpT?=
 =?utf-8?B?aWtVY2x2RDY3WXF5Y3I5bWxLZGl2cVkrZzVOekNzSHUxSmdiV1RmdngvU2Ns?=
 =?utf-8?B?R053cmgyaHZqU1RCR1FmUXl6SktNU3lWT0JsSGp0VVd3MmNNbitDZFc0a3Ax?=
 =?utf-8?B?RThuUjV6UGVYYkUza2tXdXFkTFQyMytZb0FzMy95cWI0Wi9Gc3QwMG5sZ2NT?=
 =?utf-8?B?M1dKTHpDVWpvTTI1YmRPYlhOanVsbHhvQUdnRTNIak5UcWlDS2w0aXhEMlEv?=
 =?utf-8?B?dDVsM21LMjJXdTBxL2M3QjQxbUxsMDEzYXIwdEtOQkhuYWYramNoUzlOQVZ2?=
 =?utf-8?B?TVpoNFBiWkJrR2dIT2ZRVzVrZDFObmVFRzFRbVJQRDRCVS9JUE5DVHg0NmFw?=
 =?utf-8?B?MmdXVlJqdW9uWW5lemtoWnBOZUpqaHVsSGlRRnN5akV2M3FYWGVjRWFRd2VK?=
 =?utf-8?B?Ykl4VUxlcmkwakpCYThSekdCSU8wRjBkck9KQXpsRVF3MnBZL0lVbHhkWHJV?=
 =?utf-8?B?b3BkTENPN09JWmxpc0g3YkFSVlV0NWpFaEU2YkRoaFBiVW9tK0xrekd0UXlS?=
 =?utf-8?B?WjNNckxtY3VCY1pUOVREaFhUREh4S3kvTGhpK2lCRzB4N0RvVU8wU1hmNFk2?=
 =?utf-8?B?dUh0dUxsenBzWW5KN2lrM2V1eDY2YzdCWHBDQlQrZnNKLzNRcldFZlZaWFc1?=
 =?utf-8?B?dWRDQmUvcnYzZGx0T3RzQk41aXFCQ0w1dDRPRWFaY2JpN0QyK3pSUkZVaFYz?=
 =?utf-8?B?TTZaaHJXdHRsaDlIdXlaay9uQ3lpcm44czY3dHFSYTQ1SFNxUm9KQ2ZXaU9T?=
 =?utf-8?B?UVFDSk1IZ1I4b1p1bTNJZ3RoZGs0SzBMUUhlWXFBVlFTcFp2RG0rVGRGY2FH?=
 =?utf-8?B?YUtxVGltbzJONklXT1lPbGxkZ0IwSXpFTlBWdTJNZ2ZaS1JweEpiQWM4SFZk?=
 =?utf-8?B?dEJRZ0RCd2lzTjhMU0M5WWFhTUZOVE1xTkhMbzBGbXFXVjBSWkNtZWszRHp5?=
 =?utf-8?B?bHBxRnJSdVp1bjgycGdJTWVUUE5HZzRsa2RqNXRzVGxSdnJZczAvbGhMc0FS?=
 =?utf-8?B?SmJNMUpFcS9SWEVpTFZPcnZVbys1VDVzWllSQnBZQ0FGQ3c3TVVlSXF0cG9r?=
 =?utf-8?B?ZEtkZld6K2Vzdm50YVlva1JSYVdPSlVVQ09INGJpVVRJYXFNVFppU0ErNDU5?=
 =?utf-8?Q?KzbKjb/6ol5LXqXfkE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97563ed5-5788-419f-aff0-08de8e2e65b8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 07:31:46.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82revO5E6Elv3bRzwp79zB12zIV5nH6uokKS0jvGq/QWepp8z6+DQTCvDlwY2+4U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,amd.com];
	TAGGED_FROM(0.00)[bounces-231021-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lijo.lazar@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid]
X-Rspamd-Queue-Id: DC8C83567A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 29-Mar-26 3:09 AM, Mikhail Gavrilov wrote:
> Commit 14b81abe7bdc ("drm/amdgpu: prevent immediate PASID reuse case")
> switched from ida to idr_alloc_cyclic() protected by a spinlock, but
> passes GFP_KERNEL to the allocator.  idr_alloc_cyclic() may need to
> allocate radix-tree nodes, which with GFP_KERNEL can sleep — illegal
> under a spinlock that disables preemption.  With CONFIG_PREEMPT or
> lockdep enabled this triggers:
> 
>    BUG: sleeping function called from invalid context at
>         ./include/linux/sched/mm.h:323
>    in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 570
>    ...
>    #1: ffffffffc2cd24f8 (amdgpu_pasid_idr_lock){+.+.}-{3:3},
>        at: amdgpu_pasid_alloc+0x24/0x210 [amdgpu]
>    ...
>    kmem_cache_alloc_noprof+0x41d/0x780
>    radix_tree_node_alloc.constprop.0+0x56/0x3a0
>    idr_get_free+0x330/0x830
>    idr_alloc_u32+0x14a/0x2e0
>    idr_alloc_cyclic+0xd3/0x1d0
>    amdgpu_pasid_alloc+0x51/0x210 [amdgpu]
> 
> A mutex is not an option because amdgpu_pasid_free() is reachable from
> dma-fence callbacks (amdgpu_pasid_free_cb) which may run in IRQ context.
> 
> Use idr_preload(GFP_KERNEL) before taking the spinlock to pre-allocate
> radix-tree nodes, then pass GFP_NOWAIT inside the critical section so
> the allocator draws from the preloaded pool and never sleeps.  This is
> the standard kernel pattern for IDR allocation under a spinlock.
> 
> Fixes: 14b81abe7bdc ("drm/amdgpu: prevent immediate PASID reuse case")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index d88523568b62..515775eab2ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -67,10 +67,12 @@ int amdgpu_pasid_alloc(unsigned int bits)
>   	if (bits == 0)
>   		return -EINVAL;
>   
> +	idr_preload(GFP_KERNEL);

It's better/simpler to replace amdgpu_pasid_idr with xarray.

Thanks,
Lijo

>   	spin_lock(&amdgpu_pasid_idr_lock);
>   	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
> -				 1U << bits, GFP_KERNEL);
> +				 1U << bits, GFP_NOWAIT);
>   	spin_unlock(&amdgpu_pasid_idr_lock);
> +	idr_preload_end();
>   
>   	if (pasid >= 0)
>   		trace_amdgpu_pasid_allocated(pasid);


