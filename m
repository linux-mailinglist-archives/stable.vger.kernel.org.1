Return-Path: <stable+bounces-253704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFEJFKoHEGqLSQYAu9opvQ
	(envelope-from <stable+bounces-253704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:37:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E86255B0116
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 020AC3014824
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 07:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8713939B2;
	Fri, 22 May 2026 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CiDA+3yt"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E755181334;
	Fri, 22 May 2026 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435431; cv=fail; b=bW3OmaFSYi/3ijIsSS4h5H++G60h/SERdR2c+ZCcOqMNbTHBHiWpwVdVrWMEKTuE6bzhLo3kgUvt5iZkc8RxztP6VJCzSLXOkPt4Jplbv+HrGDsRnq199M/0bnNEBkqlOqUUd+We61WV8s8pp0Zhp8m5KWY1OUv6/KV7lyaXvpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435431; c=relaxed/simple;
	bh=ZInSJJJ7/3ZUaEnE8q9npwaHSblQaROZIDBkMHXwNlE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=STDrkRx8JaVDW6XVQ8ExaCo3nItoAzw1gBZ0Y87FlFM8VeWkPSk1pw0BJYMWquOtDP6yK16u6sTsXHtvV92OVq2W/dshUsCOB/v2kYhZzmBeD7awDmieayxwLw1mOlZffzSfuCrxeiTY3mleidzZd4RTsqbUafieTyCNV0fXQL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CiDA+3yt; arc=fail smtp.client-ip=52.101.52.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lW3tjWi3M2QLgzTKD+Tfuy+yuNe/foz7pGCDzD0gnLHXF2nJ+vZjspP+kQy7JswuY1wdpZDmBVkV+7T0oPd4NMw3tVVHNwjVJ76VRFMq/7jBcg4gyZFHCGK41sz9U8SziJ4OFTPMOXsXsj4QbZowilzRLUMtBtLDlgE4POOh3MeNUagXNiZQXREnWn1MxIm1iP6VEZfjWkr0ng6CMvJ8EdmYzBhr9YUOENtzMikxwCh9ZSuWZgP5O1dOQ332weIym17PvbI5nCpx25X1XU42wO0NVC+1rjDgMFVXHqI27XURTdb7z0Gm9E1fTO0Ht38aBJc5uT95KHdaNEHmUrBh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0LZflDPRucNTXJw1MRfJ8nBQbkvAg6Iyl3zZfUdqnw=;
 b=dQPv0Vrj5jSrsbVdetHmnS5hbwjUckV3H+PwQnbEotmfxNcyKUblEYF0vxNCo13ajQlzH8S13DMBNdxVFqGFBiIjy10JxU0ydOm1cQhIgQV9LTkeTZ8SaoyKAhZElC//m7itdJWjUuSoIjgzimc7+79ao+9DNMXIxwfwIv5pKGXP/+ZKRb3l+cVd1ryCkCl6OUOeyvPX9vDAnKpKwxAUFl7CoKfhPLHbf6Fxg+7yILh4IDOymPqb4rxYSfKmNxRgbLQ9gcr6CRwUHSMUrrTk3SW6N6NzAoMmJicGaN5/3jZ6VyMpmH/SnYqH6jGyy3vDnakO+Kq+hNq+WoyuQuNjhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0LZflDPRucNTXJw1MRfJ8nBQbkvAg6Iyl3zZfUdqnw=;
 b=CiDA+3yt8lioQx9Pi4dxiXhFvX5aokct7dIUZg5kPJMHrJbakF/GAyA7equHtGEi3L7cItODeIZI9O7T2F818g3JQTHdHkNrOcbEhHsfiOnTuOsETATKjYuY1NzN+lgvvcEWPHBl5G5BJF+jA769CvCh4wcyldOCVF21nXg9WG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 07:37:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Fri, 22 May 2026
 07:37:05 +0000
Message-ID: <b2d8b281-a8e3-43a7-a4a8-b112526070e2@amd.com>
Date: Fri, 22 May 2026 09:37:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: Use kvfree instead of kfree in
 radeon_gpu_reset
To: Dawei Feng <dawei.feng@seu.edu.cn>, alexander.deucher@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, stable@vger.kernel.org, Zilin Guan <zilin@seu.edu.cn>
References: <20260522033254.3602281-1-dawei.feng@seu.edu.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260522033254.3602281-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: d23d7db6-5163-4493-741d-08deb7d4ebbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	uzfKDKqVgQLF6ifQc4j1PDZK7zpWjmvejtp7zbnVXbkyjJVkSMUxWrWMhHT8i9/og6O9hTY34vh9IQNGheUYho7MLDJch2sGW61vlg90KM88vRNAFR6QfVe+Wug51XSEFEqx8a8BGF2RM9anK2zHRVQOnvjdwrYTy3PgCj0R6mOx/r+RAx8tCQ2vDjkzP3FrJJse/FpyoF9d85qBI3Sgq4RQfZjK05wcnB/Jy7YS5VvVDVzSdX+8j5W9e77SbzmGh3uVuQKv1MjVzd39FAwHGTLzUpfUlL7r2TYMZiMAvNhwYQKTnZa5UeoRmLbsXElq8ekSZIw7mGCLqkXg1AD1+c9odwu7FsH5sNQNKafcXwEImsgx2YEQKU65ZO4PlKWpWvjm01QqW0HEQ6e2gGRombqeHKCXCQ6i+XloL8BV3we2JNwsJY2YrPC55wrkP4LrTqaDzsPJSHSUD/EzESuZwLAaM/NPSXP7tfutr9pwNDuBwoT/e51Kk2c5vKvlcq3AX4wrQbzF67TGZVG5ffvmYMiilrlTFbf3ka/shWHvXWFtSyig+x7h/DwZE8lV4agTk+iGgFbTY5tq5prmxFDd2JFNqAUo3vdS0piZBdZ6XnHcP8fJhERGZ7hZtNNtOEcC9d4yhrBma+JbTaxTn8DRFx5QZ5Y2lUHEwzBxR9LboJ9R0zxMLwxMbxS1wghDfjoD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFZ1L0lnanl6NkI3WDJkRXBpQk8vSE1aQ2R2aThBRnNkSGhKc3k4bUh0ZFR2?=
 =?utf-8?B?QlU5NUl3MXE3NnR5VU5xWi9rR2NGZjFxR0pCRlFlWFdWV2RBaHJHQklJbmtt?=
 =?utf-8?B?QVorRnB6R1pvRjZIZlZ4YU8vdURHcHNBaUROSlZ2TFk5UXJVa3dPS29kZkNL?=
 =?utf-8?B?Q0g5eXBXYi9lQjdCbHVtMmZOeUZRWlBKQ2NoWE5zLzNMS21hd2wyNkptbnpN?=
 =?utf-8?B?K1VtYzZTUy8xazVpY3R4c01SM0IxaXRpNmlNdTU4dGtSdlFyRFV2Zlduek15?=
 =?utf-8?B?NHdwVjByenk1S2dCYnFrOHZVU3JjNGtBbHBsSUgyamFpWkNERmZmblNCcUpV?=
 =?utf-8?B?UzZaKzM3dVpKT3QxOUhxbmE3TnA1dFg1ZFc5Nk8vWmNSTDcyZCs1NExBRi96?=
 =?utf-8?B?UkVtQ1NCOWVCMjQ4RVVXQ28rb1EzTXR3MWZndThkZWJDMDFwN0dUdnN4b0Fv?=
 =?utf-8?B?VmxIVEQraUpEblkwU2xpNitwZUZ4dXh4NVBDT3NTSUVjTHNTUEJWU2l0TnN4?=
 =?utf-8?B?TmUxOCt3dDdmWmI0dStwTjRvM3d4OXlvcnphVnBTWU84emtxcVBKSXpkM01q?=
 =?utf-8?B?N042ZzB1VXNvVFhGb2xXRzNBaG9vbHZ1RVRBY2VORzFJZG1pdGk4NDlSenBZ?=
 =?utf-8?B?Q21vR1ZpUlFyWkNZdWovQ0Q4MklWRUQyMVF4bVNORXl5Qml6SU9TcktDZ0JW?=
 =?utf-8?B?eS9CY2lMK01peHV3S2VrSkl5emFic1NHMDN0UStzWlE5OG1uMkVFWXkwTy9r?=
 =?utf-8?B?THc1Ym8yVVRnemtOQjdMZzZKQnZ3L1VFa0pNZkpCNnVpYVhSOVpLZnhydHhy?=
 =?utf-8?B?aU01eUpPMnpOMmxNZjdSanVuaEs0Ym56SGh6QVR5MDh6eXJhanRuUnRDbTMv?=
 =?utf-8?B?Mm92aGtxUEtWNUZ4ZmF6eGhSWGNpcWV5R1puUHlhWGMzRXJGMlBhTmZBTkFS?=
 =?utf-8?B?THFPR0w4YjhOekdxbDhNVFNwM2VoRmZ6cmR6QW9QZnY3a215Z3haQVlnK2JB?=
 =?utf-8?B?bGdlSW1jaHliMmU2SzVwWVp0THI1ckJYMnVzZ1FpWHhYYnZ6U1lIUEkvcW84?=
 =?utf-8?B?KzRGM2UvTGZaaFFmbFM4cFpHWGZzbmV4TVlEV0hqSm5JRDQ5d1pNWXZjWms0?=
 =?utf-8?B?M0RqTG9kVXFjWlNoRTkyZjYyNVR6OXpYQjhXbWJ1MHZ4bWFHQmxLRjQ5Y29l?=
 =?utf-8?B?cVdDajZpRzRtRkJ5OXUyYmorQ0RxUUY4M3IxVDMwUmpJbERDVDZPb3ZTRDR6?=
 =?utf-8?B?TjFrK0JITkZxL2l6RG5jWE12SS9XdWRUT1greWF6K2NGLzIwR25YZjcyUVNN?=
 =?utf-8?B?Y0crdC9xWWV4R211N3V2bUEyZGZHcUVIYXNta3lmbUhEQzFiQ0FnMGNoNXBK?=
 =?utf-8?B?V0RvRktQWUpKREdWNStHYy9JcmFhMmpWNlBHcDIvMHJwd0hBWUhIbnBDUzRJ?=
 =?utf-8?B?OVlPWnMvTjc4VE5BM29tNTFhSmFncWpJWDFOMk9yVkhwWEg4OUtDcFVOM1h3?=
 =?utf-8?B?UUNrdm1hK3d2emFLb2FzSnViTXFyRkR4RzQveVJYaUJZTUxqbk85bTg5L2o2?=
 =?utf-8?B?L2ZKSzh2UUdWbXBuU1FXSmxDL0N5Y1NjN3I1WTdBNkthb2hFdXU5UHNkbnF5?=
 =?utf-8?B?MUJrRUR1UWhJTGE5WjhnQXRRSGhva3E2ZUtsQk01YXg0L3lUeVpkejJISFJX?=
 =?utf-8?B?bHQ2Z2tJejV2R3JsWC9TaFRudUFBaHRtK3FyK1laeEdlbEdPUWtJT1RIRFcx?=
 =?utf-8?B?OUhmRW80Q2hpb1B6bXdzRU1yekp4eDdzQ3d3OXI0MUk3cWRNV3VOTnFVRkpu?=
 =?utf-8?B?YVc4eWFBTHRpYzkzOFE0YWdXNDBRdHhPUU5NcjBCcHkrZ1dPc281N3R4T0p2?=
 =?utf-8?B?OW9pM25XdWlBUmFSUy9WMkFpVlMwUFhNaG1ycS93bFBPd3NZM1d5eWlRa254?=
 =?utf-8?B?OE9ibWt0a0hiTHNKYkYwTC9HVUllanBseWhwVFBRRmhjaTdxdGFSbzk1bng3?=
 =?utf-8?B?cVpJM2p3bG1ITEE5TSs2Y2VUS1ErSWZ4MWNkbm0wVUZKQUVWYjRqS3NPQTAw?=
 =?utf-8?B?V2JLdVQvYkFWMDdEaG9ncEl0TjlESXcydkxORVYvTmo5dHFXMndhVVduOEpL?=
 =?utf-8?B?MU9CeEttUE92Q1c2SzdQTzNnZFovVWVqenZsbThPLzhFaFUvS2ZOOC8rYjMz?=
 =?utf-8?B?V0FYaWx5LzlqNFJiOGM0QTlzblJOQW83MU1FaFBneUNKQWU0clp4dEo1Mit4?=
 =?utf-8?B?bEpUL2FNaGJob2ozY09lRms2ZXNHWVBXVGR3RGVWYXljenhub3BWWnpBazJt?=
 =?utf-8?Q?u7tqAnwBkAbEllL+lX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23d7db6-5163-4493-741d-08deb7d4ebbc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 07:37:05.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6I32zomr8w0tjlEcCmaZ9eBgx24xj4wuDo5qjMtOhmFQcyfo6kbCuoiUCT9eVBI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,seu.edu.cn];
	TAGGED_FROM(0.00)[bounces-253704-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:email,amd.com:mid,amd.com:dkim,seu.edu.cn:email]
X-Rspamd-Queue-Id: E86255B0116
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/22/26 05:32, Dawei Feng wrote:
> radeon_ring_backup() internally allocates ring_data buffers using
> kvmalloc_array(), which may use vmalloc() for large allocations. Using
> kfree() to release vmalloc-backed ring_data buffers in
> radeon_gpu_reset() will lead to memory corruption.
> 
> Use kvfree() to safely handle both kmalloc and vmalloc allocations.
> 
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still
> present in v7.1-rc3.
> 
> Runtime validation was not attempted because a targeted reproducer for
> this GPU reset error path was not available. Compile-tested only.
> 
> Fixes: 2098105ec65c ("drm: drop drm_[cm]alloc* helpers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>

Good catch, Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/radeon/radeon_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index 705c012fcf9e..1f0f0d0eb673 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -1800,7 +1800,7 @@ int radeon_gpu_reset(struct radeon_device *rdev)
>                                             ring_sizes[i], ring_data[i]);
>                 } else {
>                         radeon_fence_driver_force_completion(rdev, i);
> -                       kfree(ring_data[i]);
> +                       kvfree(ring_data[i]);
>                 }
>         }
> 
> --
> 2.34.1
> 


