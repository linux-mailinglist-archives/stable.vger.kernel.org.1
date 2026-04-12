Return-Path: <stable+bounces-235820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKxeJzef22keEQkAu9opvQ
	(envelope-from <stable+bounces-235820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 15:33:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F13E73E4030
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 15:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A2CA300E24A
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 13:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C9337BE8C;
	Sun, 12 Apr 2026 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ur7k4J8c"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011024.outbound.protection.outlook.com [40.93.194.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D99627BF93;
	Sun, 12 Apr 2026 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776000818; cv=fail; b=VkJUbLUvMUJ+Q+0CPrbIxxa64g6cYFdMm133F1JL1PCHRsBpE7VBpW03DPeTdKRKjlm6vqwEe2W/giRkJv6mMKkkIRKGuInZr9r0QFF+tThRY4l4aankzVARYWo/wQ6Q25bFXkdviofz6hUDxqYs2+GPT5YxMvfsBYC760mzHVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776000818; c=relaxed/simple;
	bh=gR2COM4bHnKMhh/Dr8v7u0nNr+bsbYEuI2+NVElsyFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N/oTjE94NdZXrHGbWIWhaE/E16ZqDdp/iVsAOxrY2/DP3H0W6R/vz76cwRy8RI6mRVwCfC5mN1v0R59rx7GZxW8pBouoQkfomw28h/OxINSKeTterg0dIp7/2qsQBjicQCMhNcncPjGD0K5LViXHj7BIZBBYr6Dlu6t+SoyDrZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ur7k4J8c; arc=fail smtp.client-ip=40.93.194.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbXuhoIYc6q7+cLsfkYgzdwAchXix2QUmCEPcb0gtx9KjBdmbaCudSv1mztCCv2VJbhTflipHNt+nXeL+q6T+o+woeTKbRqQO6TH7FRpwznfKEBs41d+tBHd91P6kKxzDC/ThKi920ALkpItVVXJ4BaZCZOT9hvGmHUjOvhmhqIE0im1pJ48RSU+SHipozIZZMRt4AYeeYCrA04myGGh5OmhhDSQxHAA+AAeNFdMP4mc+GcKREOmcOT2Jw8fWKVffAGwNOItBqLA9wRNiyz/6KItgwF7X7vgE9fXsVvLutEx0f5uR8nSD5J9HBngISFIeD0W+ph5/hdGsKt/mFbQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpBmBlPdRX4ZLoUEr9DehrQz8kVTuCblfio2G47yQNY=;
 b=L80owmyvYmrTcLwQIRGm/K88gVq6yX/sPFMb0+QxIH8EMyHv+AE/gpy1cPQg37w0XyT5TtXjYR36wO3FjoWsaMpc0yf2CI4ynP088jBm4v9cIk2lJm3fLlKXRw4g0WhRwAp3zcK4eP70D3jyfN6uG49JQxo6lok40cM73W5E/SlshjxmXBrts/nhUegckb/tvD/OR8zdTrQRxa0yraHGynrmx4lJssByUb83kohklrPYe5eZVvSEoJdah3zcaaj51WLv7yQwOymS3v78KMufjpnBTv/FXMCdvCwsr9rnoxuw3Czy+Bt4SMG18Ko+FDYcLyfs1vVww9OQhCwWk8K6fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpBmBlPdRX4ZLoUEr9DehrQz8kVTuCblfio2G47yQNY=;
 b=ur7k4J8ceZleOg+UjVMzGgmHGefuRgvdXv1LxXV10aEVCFky4oksjgv+jENZ+V4HxCUjD9zclyT/FvhNYfHaClXGak/ky9V+6E0v/TGtG2M9UYA0ynKHviSH50MHiFy0mpQDduNKo5yTLwWEGnw/KS+Og2fgExNki2U5lgLSKrerhlpfiYsGS4qOFnxbmOEPNZiqnW857qOxVpRYkPGMIYXuiyRcGJqJmW40/2jVUuJLgQE5NSSqlad2Z/WiBn3hG3kmolQBR3Z5HxcLCBovT+uNA5D1egE0baUvCAbhgvXuDsbzvDF7Zc+Mm5Ox+0pPwwZ4iNqdmPhe1VdJKzcOvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Sun, 12 Apr
 2026 13:33:31 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9769.046; Sun, 12 Apr 2026
 13:33:31 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <lance.yang@linux.dev>, lgs201920130244@gmail.com
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: thp: Fix refcount leak in thpsize_create() error path
Date: Sun, 12 Apr 2026 09:33:29 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <75F536FE-6710-4AE7-B6DB-2997D846237E@nvidia.com>
In-Reply-To: <3e688ea1-05ba-4e75-9d92-2751ff6f3b7b@linux.dev>
References: <20260411062152.2092967-1-lgs201920130244@gmail.com>
 <20260411142858.85496-1-lance.yang@linux.dev>
 <848180C7-F98C-44B2-AB1F-579BF9EEA28E@nvidia.com>
 <3e688ea1-05ba-4e75-9d92-2751ff6f3b7b@linux.dev>
Content-Type: text/plain
X-ClientProxiedBy: DS7P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:1ca::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f6b9b2-f075-4b38-c323-08de98981688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2FZKZWxOI/YM400zFEZZNXBo8GOWPVcgzP9/t/p/O2RLcUlk2LH8z8ZFS04w/nHvYgolXWsDMCuEuB3KJEsgJLuIUJpsg6A8dPcUWYhCOTRiL9FeRGDfqDsOrBwfmfVX9m8VHLeVMofzwFXBql5Ahj/4TNWp3cdiRoyN2zLU5A3Zyeez9yGyGcyQN+GpNpy1TEY9H/tGJ64v1TWwcVl8y+CldJEckXpbgxnQdwjNXB0DwQJyeSgNn8zlSnsp3MPFGQSteXA8YdNtX+HaYTXNwDg6u9vyPY6EDhyrrq29FmfX0dLBBZJoA487Y95PyEo4ZRylw5CtGC2yiMxi+oiwxAu0WqFyZWyHPuCWYbp0hAU18/3knfI9d1DgUcyARoPAuC7NuOdNMXUFpMnnJRRgjLiaDCh0qYbIE4ctUpmG9dSDwZNe9V5QhA0UoR9RmqotoDKMjY32cJNpRvUR1dITct3KVUSMCRQBWSsG2dkjg57qQrJ4vgLsDt8O3Fcm9Zt9hKXE55EGTc8oNtSaMcS/oNELlGw5Qba2RpySi+itXvczfBE9f+RwF7Nv/aXt19RKRW1DIqUnm5A1nqhPucRELFcJd5n6LGIhX5IRPmuRJNG0KCcrGMjDGlUswGoTRbOyEpCAeTPgIjgi424j5d2sINX3pKQ9d1JuCRsw1+khxeYjoNPM7J3sNBBXjbEGRyDobn11JvNpQwge9MrAOvIA8rt+Jh3e8Lkm6WT2Lczt0V8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ioTfFh8/wE98UQNx8Mhp5QI2Ta9OksjEy4pmLWGHDkeW3ffmOpxRCFn81Q/?=
 =?us-ascii?Q?UJvxzz0rZO6yXUE5IvbkCpZ+o1rHBAKGWSbrttKl+jEkBKrrReCGjOvYKLK0?=
 =?us-ascii?Q?3+4allELL7mvlR8owoP3+3jP3wSwuSoLatvTnVtVg2V2jwiH4Pu6eL6lLgOw?=
 =?us-ascii?Q?na2/AuEaZFST2K9qK0bsESxshMbvodqUogFFdmv1jpdItT6Uuv4TqT6EpD3Q?=
 =?us-ascii?Q?6s4wPf9AXoOmkW3KXISaoT6aAvQ1vzw8dpBlySDZWq3Tg0PVZodoDQ+vjWbM?=
 =?us-ascii?Q?smwWsYzyMEJli0Unq+dmm0JIUgQLh962DjrCr6WAE1Q6ncyIp/t1rW4htmd/?=
 =?us-ascii?Q?Nj3T/b4nWkxPwnVB3NhJu2cng3FAgBIhBJvcG44vNu3IY4HG8jU2NdzJxxPs?=
 =?us-ascii?Q?48m6YrWC6YTxBGgLORL6gGjK8mQPKR+L/Hw5EB31XNSb1v5HRN30+jA0HFsH?=
 =?us-ascii?Q?AtBhuSfWp+n/ntn750iGZXMZq8Xklge0zLphnaW4cLHaqxKE1nc6KETiJisy?=
 =?us-ascii?Q?HHNXYIPutXvLZe3/guML/iNOlXO6v2DSxqD/+YN6Jzpu2MZ2v4GkuC7hgc0x?=
 =?us-ascii?Q?tfuo9vXVXcZc0jC0NBdydbcfYuKC1UF+AuZJRG18S49q/qmSrX7wb6ZbJP/o?=
 =?us-ascii?Q?l9fHe1mPYlm+4xo4pk8UcYuNaS3t74gA2EpalkU9P8jpuOyMgXuQbdnHaNvd?=
 =?us-ascii?Q?1r7QMZAfJP8YGtOaC3fkyfmUVp4M4nZmYs9GdDAYj9F5PvgpIle7L29ME1oZ?=
 =?us-ascii?Q?mHb4Q13oi5ttiMzK48hwkBW/kTREvWcghpqOephew/P9l5fqHITPRDVe9RQ8?=
 =?us-ascii?Q?cXNk/xOy/EeUojy5tkRLgHjIVzZl9MKCSvlOJCDQCNBiOKQvs3Bz/MJl0KYh?=
 =?us-ascii?Q?BLHPGpet0hoJOENcAmgjqY6n/Fy6TEePf5xXaoxus/uQTXiI02X5srUuwyhD?=
 =?us-ascii?Q?qomL8S8Gl6OafmVQtrCtgJUB71vRFXq9PIsl+jBlH2sA/UXaunYz+/MyReeA?=
 =?us-ascii?Q?vpdMR+r8n+q2H0apRedWVWN8MdFUnzCVo4kkGBJfQ+gLLuMGon6ndv7K0D0p?=
 =?us-ascii?Q?XFpe43S+CCJlsDBhCJ0VrVt+yGPcWd4hWpNKhvjR2B3wS577v6/YJBpsrC+H?=
 =?us-ascii?Q?fgV/fhKkXyFPRiTyV5VpgfcVLxCJBsfxklbZlor6jQupgETwgFu3Xm/6rFWm?=
 =?us-ascii?Q?2vCek/+6rqkyjYA92NctuKnEyOIR/g8o4Xc8J8pgfjyRS8VqLCPAC6RTskat?=
 =?us-ascii?Q?Ylgfdvqu8cO9UmgDvRGDg9igxvlDE5l5xdcHbgSa/BaDuMCrEioaOWFowSsW?=
 =?us-ascii?Q?Z6sc7dazJPolGeP5QcPf4JccdFvvEweG/8xknrVZO/V6/sgQFE3hMFcmDDE+?=
 =?us-ascii?Q?MEFomo7EoBjr2yC2esMObOc5FsNO1iORnZvIkLcFKr4jZQ5ALEYt0gc7boTP?=
 =?us-ascii?Q?myp7s7OLPXRbsZt1bh35Q0cOva5XNzIShjzzy2wpK+5Lp4e1Kx33H7hABAWw?=
 =?us-ascii?Q?1wrRpelPFNFXs/RhviBKa6Rko/YGch/6joY2ji76h4oLgs3nF8viC/dewGSY?=
 =?us-ascii?Q?Is8YTpen68dSUr7JqWCCjFNO0odgGdP4r1De4ExNt2OPidvlLsQ0c/kE8R6r?=
 =?us-ascii?Q?WI2wWwSYhuLVFHvcLja83aJQZ7bqH2ByeFMNP7tcjcVrxfwxG/EDFuxV3AbC?=
 =?us-ascii?Q?9ZrTIhJGkchEXGhhWqjLAz2GP3jdHzuQvFZpR2tvkeUZuWZB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f6b9b2-f075-4b38-c323-08de98981688
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 13:33:31.5008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1RRuVH1pc+s5Z/VXgwMzlDbnhIkDP3vpjv7rcRZc5wVoiD2hZV9Ls1RTv3t2IMs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-235820-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: F13E73E4030
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 11 Apr 2026, at 23:24, Lance Yang wrote:

> On 2026/4/12 09:49, Zi Yan wrote:
>> On 11 Apr 2026, at 10:28, Lance Yang wrote:
>>
>>> On Sat, Apr 11, 2026 at 02:21:52PM +0800, Guangshuo Li wrote:
>>>> After kobject_init_and_add(), the lifetime of the embedded struct
>>>> kobject is expected to be managed through the kobject core reference
>>>> counting.
>>>>
>>>> In thpsize_create(), if kobject_init_and_add() fails, thpsize is freed
>>>> directly with kfree() rather than releasing the kobject reference with
>>>> kobject_put(). This may leave the reference count of the embedded struct
>>>
>>> Right. As documented for kobject_init_and_add(), once it has been
>>> called, the error path should go through kobject_put():
>>>
>>> /**
>>>   * kobject_init_and_add() - Initialize a kobject structure and add it to
>>>   *                          the kobject hierarchy.
>>> ...
>>>   *
>>>   * This function combines the call to kobject_init() and kobject_add().
>>>   *
>>>   * If this function returns an error, kobject_put() must be called to
>>>   * properly clean up the memory associated with the object.  This is the
>>> ...
>>>   */
>>> int kobject_init_and_add(struct kobject *kobj, const struct kobj_type *ktype,
>>> 			 struct kobject *parent, const char *fmt, ...)
>>>
>>>> kobject unbalanced, resulting in a refcount leak and potentially leading
>>>> to a use-after-free.
>>>
>>> IIUC, this looks more like wrong kobject lifetime handling and likely a
>>> leak, not a clear UAF :)
>>
>> kobject_put() ends up with calling kobj_type->release(), which is just
>> kfree(to_thpsize(kobj)), equivalent to kfree(thpsize) in the old code.
>> IIUC, there is no leak. Let me know if I miss anything.
>
> Right, the fix is correct. I was only commenting on the changelog
> wording, especially:
>
> "resulting in a refcount leak and potentially leading to a use-after-free"
>
> The old code does skip the required kobject cleanup path, but is
> a UAF actually possible there?

That is my question too. The original code might not cause any real issue.

Guangshuo, let us know if we get it wrong. Thanks.

>
> Just a wording nit.


--
Best Regards,
Yan, Zi

