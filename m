Return-Path: <stable+bounces-231282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BeZN87oymkkBQYAu9opvQ
	(envelope-from <stable+bounces-231282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 23:19:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E22B336159F
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 23:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5652300ADAE
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 21:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DD13A1A5B;
	Mon, 30 Mar 2026 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j96iyUy8"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013031.outbound.protection.outlook.com [40.93.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3822C39FCA6
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905544; cv=fail; b=jaxi8EnzX4q5UUxRHZJ9t0OmNhdnDd7b2+WTJbH+3fgMRhhGNo3G9zhNoFiqiheihP91QVzF7FlJqgrFOMLkEkSK3CAKf/2066z3HeH3Gl9bmD5Z0xBXSEZGIKgBMXSLEOf/agvPc2P/7NpkSDmpfPLbjAIglNMP85C1CRv234M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905544; c=relaxed/simple;
	bh=kswC4I9KYPUIjb99nrLOUNoz/58FC3I0k5a+KeZcH40=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gWbPxUj6p+h3X3uP63RKMyXmiwxhXIPds25vn4oFrYKREkW30RzFz9wqGjqADZURCaiEl13dfYohblphCLIHwtCs55T8kD5zB71QpFpdGGRIguvG8dtlpdy/7Hrq2AQzOYU7yi4sgfQVmsDGWFBHqy7iZiqDVP9yZjt9BeaL/mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j96iyUy8; arc=fail smtp.client-ip=40.93.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INq3BO8chEWycvo0TJ6TFVdTYXgZSsvlgN9KmYod4t3FuiPtiVH5F+8Rrdn2vIGnybVtUEvqIkH2qWVwS611xS6/Y3WJzIljlIkcK+oY7lCgHPRkMLqRoDC7/dWdrkrZ5Kv4ghOwsANfEN7xWB/OeelHrAr5OJPP2ljLcG2wDNyIDwJzUUJWZ5GpuGXEOTjhmeMgXsTD6Zp5E+7EaAsg0JBvqTukHW3Zpj4xKElFGxdg3OyrBV5xoQNiHuPmxlrMOFNUjRyaALPNg2Ul9oKincADgQmLVNprXuDlXw+UkL6Af0idJBiFevrqMjkuA3DCkwemVwj7B7wvkExMcqob9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjO2lJ1+PRACXBie1SG6fBKqHejn1lDB5xytOPX39Vw=;
 b=PDZkDjwiVSFzrdWjV2OhavLpaslqxHgrxt/yPKYHzmzyo+IyPK514Ddjwkq1+DWZULPip8hJ6DM+xZHB7mbgdkDP3P763o6P2A8xzbakGnFW7D9G8eFO5t3MdhrWBSJFil/gAVelTCJfqNxvebtpgsGcaP3PWhQ4vclcmjiPfXqHMnPLcYJQxY11gGCoO7i7LQJI/zT1S4nk0oetzKXN0W6anDFi4vxll6vsRzWtqP+W+QuUI313kfRaC6oXARY63X3wc70HC8z6SBbbX7J97VuOpm/D1O3Usmm57mpFXvAYT53izqB0a7r0vLBYAbSLBGdMcNJoECmQXbxEKCtW8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjO2lJ1+PRACXBie1SG6fBKqHejn1lDB5xytOPX39Vw=;
 b=j96iyUy8mMMg8zXnxc7+6dihvroMCj6GojGRiRBbreI9ExB1WKx9wCM6MefNju+I7BxpsARxMr6mzosLXbOdcH8u2QwJbSg95RF7UXWVIMzA8vwtfjET7GUgveWYkuhlmUVC/bPeu3jJcNjETs3fFGpHIcLyMjgtZV8jPSMtTvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 21:19:00 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 21:19:00 +0000
Message-ID: <27e6fb48-51c0-4e47-ad91-c6c3092dfd09@amd.com>
Date: Mon, 30 Mar 2026 17:18:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amdgpu: replace PASID IDR with XArray
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: lijo.lazar@amd.com, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20260330191120.105065-1-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20260330191120.105065-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:610:11a::34) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: 65786270-0a30-4702-9b1f-08de8ea1f627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	f9Y8+XNJOpl/A9JkQOGJ8z1t/dwz3nXpr8cTPlzHYG521oxeaFH2h09cGmSzxQ86e2RfGljsLWrCqddS2YhjDd52exNlHFBhHNSAk8n7wq5YfCbuJbQA5EMp6BqYjkaaBs46I4ofzPEZz06OdpgXjvmc4okLDK+9KgBvLkmeAWMlZno+Qcof0TUWLbn3VjzsPjy/t4CsYDtP38hDJpXuZ9PcL/geo8E4Zveva5R7XxlXOMzr5vbYZQWmvz28rLXsraIpSceviGJkaFeS8L8epBrlIlKbqaLWPCpYJpLsxHIhULgbvPman9sBO5RYlD6ghqlYDn+MuoYOtUMV93DtiNw1VipacX6dMEyimJBV87Mm5F3OTjapRfnGyMSmFjg/8UYOEBRbbps4rL+ku9De88047pASdPJ1fwksha8AaJja21BM2LaAwhqMWma1bUW/QBew3qID7w7MTh6YVTzopck3IZbvYgwbKQ8wd2bmr4D4AxJEdHSWBx1h/onD5pa7S+tfyDftXLxt85tEZFa5xLk1vPel1MfsmYlT5HahRwZ/JiyHMYsapkvL37tbFbtH+uX9KBUTkIuTVmtuB33e3S/uIX/k6KDfySCY339IsP+ORaKyvmBJgTKVu1LykeTuYGJm8VvCg8Gs1V2KLxEDpbBMRHvdgKMtRHCMzoMaVPPwR6ibJptc2LFY71en8HGPGTPG1ZKaz1+AUuROkOY4ybZyTAljaUUGTBG4JyZW+U5VNRl9+MB5L1nahbSWi1n2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5336.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFVvVUhYSWRSdnVCTkpOZjYwM0hXS1RGMDhGK3ZtY2RzR2xSSVZta1dHdU9o?=
 =?utf-8?B?UGZtZWs5Z0Vzcm41QUNxUWpENFBTc3g5WVhNVzAxMldQV3M5QjI2SWJvazk4?=
 =?utf-8?B?SC9nV282eXgxN1A3Y0ZhdmhPRTNiSnBVZTBPYzA5bjZ0YnJubzVVSUlYdURa?=
 =?utf-8?B?MnFLZ0plWVhHZXBYSjhKR0xvWU8yb1k5OUFneVVKKzRYN0V0ejlPVWZCU3JW?=
 =?utf-8?B?bVhidkZ6UURDbE9SdEQ4SFRwVm02Sm1KcldZNEtQMGxsMENaU0ZlbzdYek9v?=
 =?utf-8?B?YUhxeVlSTFZ4L2VSQ044Sks2dFZqVE1iRk42VDBvelI4eXNlV1VUK0Yyb201?=
 =?utf-8?B?MkFqZCtZMHNvRTFaYVl0MzlRUjFwMDJhUER5NXdnQXJBcEtYVVVKRE43cU1V?=
 =?utf-8?B?Y0wwbktSdGJRbXZwOVZMVWFNbDI0VnJWM0EvcFYvcXZuL3NoREhYUEdvSTZl?=
 =?utf-8?B?dkRWTVE2R2VaRDhYMW8rMFllWldRSHJwWVFZdEZ1ME9VV0UxUU9SbDBMVnpa?=
 =?utf-8?B?UnZScHQ1R0Iwa3gvZXl1UUJhYi84aWdzM0Y1VHliTVcrNDMyMllLTk9EclRU?=
 =?utf-8?B?SU5SeVc1ZGR1RElVWERTRThQT1h4dXhRakRJdVhWdk9Tam9rVWxvVWdudjU3?=
 =?utf-8?B?QUtiM2V5Yi9IWFR0V0ptMmJrdDRuazdDa3VXTjVZS0ZYYmFMSGpIRHVUWnBa?=
 =?utf-8?B?MzVPdWJERHNzSXNrb2dEa3VpRjJEM0s5YTdKYS9LWDY0MFh0Qnc1VnpyWFkr?=
 =?utf-8?B?a0gzbzB4TmpXRFdFMlZ3WCs3a3FDbzZkT2ZDMWxXZTZUVHJCRHhpZllrVFRH?=
 =?utf-8?B?OXh3bHlsUVJUWWNyZXhZZkVXTnRkNWJNZVZJbWZWdzEyeTVpdlhGWGtYOVhQ?=
 =?utf-8?B?QjRWRGhpSThhK2FMWkQ1RWR4KzhZVzRidVE4c2xIRDVmTndMbkd0eDhZbDlr?=
 =?utf-8?B?VzRlSTFRY2tDWGpRSFMwMno4dDZIQm4rcWJFSi9BWnQyMkRuRzFOQlFVbGVL?=
 =?utf-8?B?NEhsL2dPZ0Fvb0ZBT2hMQ0prenpQVkdNdGJRMHNPMG92YkE3UG5KcnZWYTVw?=
 =?utf-8?B?amZnK01vUHFNakZMODFIT0FuTDQvMWVUZXF1Z2cxdVJLMW4xaFZLSzRLeUVP?=
 =?utf-8?B?RnNoL0Y4N25aWWFqTE1nNjh4N0JpKyszZWRTMXdvSit6VzdHMXFBNmIyRzJp?=
 =?utf-8?B?VDhQOEJPYndMUkk4RGhreDUyd2l4MHpSMDkvTk8yb1F1WHVRN0xKWUowVjdB?=
 =?utf-8?B?emRCejdJTTNCUGxkUUZnaHRISG1Sa1hpWkhmR282VHpSd3ZLQjBMRTJvRDVJ?=
 =?utf-8?B?dDlZTmFTbThFSWwyQ2lFL2Y3SWxYaGp0akthbVNqdWdLVVRjdzFtZThuNTNI?=
 =?utf-8?B?R0htdC9HbnN6SCs4WkYwN3I5RkJXSXhoSU9oS0wweU9Qa0Y1dk96dzc4cTIv?=
 =?utf-8?B?bWYrYWxPcWNyTTdLWkhFakxlMVZzVzAzc2gxZFkvZ2xjSmNRd0IwOVRUa2FE?=
 =?utf-8?B?WnVZV1NvUjliODkyVGtBVzQ1Z2hqRnlCMnNTQXh5eUU3VTU4c0Q2RlJBM3F2?=
 =?utf-8?B?NUsyL2RzMDlEQ3JkT2JVaDJrOG9CTnU4Z2JaZGVnMzVlL2NIVUk5YlZYWjFu?=
 =?utf-8?B?ZjBvQ2poWlFTWTZJTysvanhxMGNNRlk5TEV4R1JWTEVZMDZOcXJscWlrMnJQ?=
 =?utf-8?B?bXZEQ3hGaUlWNy9Ua3JDdGJrRXlUTmRBSEVRSmp5cFo1OHpXbldkUWxvUnRR?=
 =?utf-8?B?eTJrV0syOEdydFVJdGtaei90VlFnYzRxTFNZeUJTZFc1d2N1S3Rsa1djVWhD?=
 =?utf-8?B?MW9COEh5Z2txekNXMm92M2Y3anZNMU5rVHBLdHpsalNaYmM2NFQvUnJUeXR6?=
 =?utf-8?B?TGlRMFVpV3RuUlRnS1JTaHdNODVxMlRLakhkTHJSaXJ5d0hrZGNUYXpyN05p?=
 =?utf-8?B?aDVqcnZNcUNEc3l5TUtmZVB0ZDJaMVB0UEIybGFRdlFFdUIybUFiK3d5K3hB?=
 =?utf-8?B?Y1RwNFdhY0xPNWNZRXRJZjZsY3R0dDNxOEE3TjZRbUdoNWo3RXBnbk84OUs2?=
 =?utf-8?B?Q3FRY2d0ajZ4dmFlT3lneUlNVUU0RnFuLzlmWkkyVkxRRGo3TWVVU1VnRTls?=
 =?utf-8?B?SHc3NU9IbitDYURtdFJjejFYZ0xmVkRMVEFqNldRRDB6S0JMT05UM2lDc3du?=
 =?utf-8?B?bGY3M3hMcTRKS05nSGpBc0dvMmRNT2xUd2xMamRyWlhPRHk4MHVKT1hTak0v?=
 =?utf-8?B?Uk5VSll0ck5Say93cDVmbTdxaEt4Wit6Tm9Sci82QnlQOFNzb0VFSU1QbFdt?=
 =?utf-8?B?VG1KQkxtZWVTU3A5bjFMditjTjQ1ZEFQSVpWZUtEYzdSL0NmQ2V5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65786270-0a30-4702-9b1f-08de8ea1f627
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 21:19:00.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rwKAfBx4/ScI9jjBIP7ZTTqEK1JAjmJYpUuqSUJPnHC2r5xWdJHbu9PKIY7CsaSUJHPz9MvRnS+B3wESck1zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,amd.com];
	TAGGED_FROM(0.00)[bounces-231282-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jinhuieric.huang@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid]
X-Rspamd-Queue-Id: E22B336159F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It looks good to me.

Reviewed-by: Eric Huang <jinhuieric.huang@amd.com>

On 2026-03-30 15:11, Mikhail Gavrilov wrote:
> Commit 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
> converted the global PASID allocator from IDA to IDR with a spinlock
> for cyclic allocation, but introduced two locking bugs:
>
> 1) idr_alloc_cyclic() is called with GFP_KERNEL under spin_lock(),
>     which can sleep.
>
> 2) amdgpu_pasid_free() can be called from hardirq context via the
>     fence signal path (amdgpu_pasid_free_cb), but the lock is taken
>     with plain spin_lock() in process context, creating a potential
>     deadlock:
>
>       CPU0
>       ----
>       spin_lock(&amdgpu_pasid_idr_lock)   // process context, IRQs on
>       <Interrupt>
>         spin_lock(&amdgpu_pasid_idr_lock) // deadlock
>
>     The hardirq call chain is:
>
>       sdma_v6_0_process_trap_irq
>        -> amdgpu_fence_process
>         -> dma_fence_signal
>          -> drm_sched_job_done
>           -> dma_fence_signal
>            -> amdgpu_pasid_free_cb
>             -> amdgpu_pasid_free
>
>     This was observed on an RX 7900 XTX when exiting a Vulkan game
>     running under Proton/Wine, which triggers the fence callback path
>     during VM teardown.
>
> Replace the IDR + spinlock with XArray.  xa_alloc_cyclic() handles
> GFP_KERNEL pre-allocation and IRQ-safe locking internally, so it is
> used directly in amdgpu_pasid_alloc().  For amdgpu_pasid_free(), which
> can be called from hardirq context, use explicit xa_lock_irqsave()
> with __xa_erase() since xa_erase() only uses plain xa_lock() which
> is not IRQ-safe.
>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Fixes: 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
>
> v5: Use explicit xa_lock_irqsave/__xa_erase for amdgpu_pasid_free()
>      since xa_erase() only uses plain xa_lock() which is not safe from
>      hardirq context. Keep xa_alloc_cyclic() for amdgpu_pasid_alloc()
>      as it handles locking internally. (Lijo Lazar)
> v4: Use xa_alloc_cyclic/xa_erase directly instead of explicit
>      xa_lock_irqsave, as suggested by Lijo Lazar.
>      https://lore.kernel.org/all/20260330162038.25073-1-mikhail.v.gavrilov@gmail.com/
> v3: Replace IDR with XArray instead of fixing the spinlock, as
>      suggested by Lijo Lazar.
>      https://lore.kernel.org/all/20260330110346.16548-1-mikhail.v.gavrilov@gmail.com/
> v2: Added second patch fixing the {HARDIRQ-ON-W} -> {IN-HARDIRQ-W}
>      lock inconsistency (spin_lock -> spin_lock_irqsave).
>      https://lore.kernel.org/all/20260330053025.19203-1-mikhail.v.gavrilov@gmail.com/
> v1: Fixed sleeping-under-spinlock (idr_alloc_cyclic with GFP_KERNEL)
>      using idr_preload/GFP_NOWAIT.
>      https://lore.kernel.org/all/20260328213900.19255-1-mikhail.v.gavrilov@gmail.com/
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 47 ++++++++++++-------------
>   1 file changed, 23 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index d88523568b62..3fbf631e67c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -22,7 +22,7 @@
>    */
>   #include "amdgpu_ids.h"
>   
> -#include <linux/idr.h>
> +#include <linux/xarray.h>
>   #include <linux/dma-fence-array.h>
>   
>   
> @@ -35,13 +35,13 @@
>    * PASIDs are global address space identifiers that can be shared
>    * between the GPU, an IOMMU and the driver. VMs on different devices
>    * may use the same PASID if they share the same address
> - * space. Therefore PASIDs are allocated using IDR cyclic allocator
> - * (similar to kernel PID allocation) which naturally delays reuse.
> - * VMs are looked up from the PASID per amdgpu_device.
> + * space. Therefore PASIDs are allocated using an XArray cyclic
> + * allocator (similar to kernel PID allocation) which naturally delays
> + * reuse. VMs are looked up from the PASID per amdgpu_device.
>    */
>   
> -static DEFINE_IDR(amdgpu_pasid_idr);
> -static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
> +static DEFINE_XARRAY_ALLOC(amdgpu_pasid_xa);
> +static u32 amdgpu_pasid_xa_next;
>   
>   /* Helper to free pasid from a fence callback */
>   struct amdgpu_pasid_cb {
> @@ -53,8 +53,7 @@ struct amdgpu_pasid_cb {
>    * amdgpu_pasid_alloc - Allocate a PASID
>    * @bits: Maximum width of the PASID in bits, must be at least 1
>    *
> - * Uses kernel's IDR cyclic allocator (same as PID allocation).
> - * Allocates sequentially with automatic wrap-around.
> + * Uses XArray cyclic allocator for sequential allocation with wrap-around.
>    *
>    * Returns a positive integer on success. Returns %-EINVAL if bits==0.
>    * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
> @@ -62,20 +61,22 @@ struct amdgpu_pasid_cb {
>    */
>   int amdgpu_pasid_alloc(unsigned int bits)
>   {
> -	int pasid;
> +	u32 pasid;
> +	int r;
>   
>   	if (bits == 0)
>   		return -EINVAL;
>   
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
> -				 1U << bits, GFP_KERNEL);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	r = xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
> +			    XA_LIMIT(1, (1U << bits) - 1),
> +			    &amdgpu_pasid_xa_next, GFP_KERNEL);
>   
> -	if (pasid >= 0)
> +	if (r >= 0) {
>   		trace_amdgpu_pasid_allocated(pasid);
> +		return pasid;
> +	}
>   
> -	return pasid;
> +	return r;
>   }
>   
>   /**
> @@ -84,11 +85,13 @@ int amdgpu_pasid_alloc(unsigned int bits)
>    */
>   void amdgpu_pasid_free(u32 pasid)
>   {
> +	unsigned long flags;
> +
>   	trace_amdgpu_pasid_freed(pasid);
>   
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	idr_remove(&amdgpu_pasid_idr, pasid);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
> +	__xa_erase(&amdgpu_pasid_xa, pasid);
> +	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
>   }
>   
>   static void amdgpu_pasid_free_cb(struct dma_fence *fence,
> @@ -625,13 +628,9 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
>   }
>   
>   /**
> - * amdgpu_pasid_mgr_cleanup - cleanup PASID manager
> - *
> - * Cleanup the IDR allocator.
> + * amdgpu_pasid_mgr_cleanup - Cleanup PASID manager
>    */
>   void amdgpu_pasid_mgr_cleanup(void)
>   {
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	idr_destroy(&amdgpu_pasid_idr);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	xa_destroy(&amdgpu_pasid_xa);
>   }


