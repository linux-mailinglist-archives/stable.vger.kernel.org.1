Return-Path: <stable+bounces-235780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIILO0r62mkP7wgAu9opvQ
	(envelope-from <stable+bounces-235780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 03:50:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E083E26A1
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 03:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34B70300DA50
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 01:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3D529E116;
	Sun, 12 Apr 2026 01:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hRsqTl/G"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011067.outbound.protection.outlook.com [40.93.194.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CD528A72F;
	Sun, 12 Apr 2026 01:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775958556; cv=fail; b=kgwai4Vs42E61zahR14aI+CFPxFvXnaGcaWE4et8mph2DHzW39EtpdXIWAvBIVWyQzKa0Q/Tx/jNKMsOb+khX6lbPfxroEhX0DR9uGx9oHCV4/46ETdrNmjvRdWwqap2Q9gH4p5NgTqv7jgwH2wPmNwsH/J34XcP1kPW0NAt+z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775958556; c=relaxed/simple;
	bh=0g+6O/UGzbrj9Om83NAahTedM3Kg6gFTbJKi88jV2OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BmiJw0+EzOAbs0mLo774XZcu+6xaQaf+TUCmsrInKOKBKRL/7B9Eik0oMKVEPC9FRuqGuC/pOdKxMBMS5WcLjYyjcafL2jqYQ/9Sm8007wZ5jwNX96jyhDGzU0b0QHqVzW4EHLsvz7VUiXqtLLsokTHkqbAi22KhMwIn+j9CxuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hRsqTl/G; arc=fail smtp.client-ip=40.93.194.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhwqSdZYeGkvtcf1soPu2uo7ks4sQOLjMz2/EtU+Ucl6JJMAd3KtpBC7Nj44e7BiqXQ2tDdvE5SsUoLFLUZk0XjgIB+IW0WuAcSaRAlaPTuLK4PrBgUB2Rm17C3460cLFUP34ScThEYQw5yE0gjWx/9yOwPfEtH6e8sCbuKMYJW3VpXBqFasbySrNmt9uqh9hhAuEUH0990h/8MsFxs1VcnSAtYfIOf+xzrg8sAS/6+nk9sgHnIRL/8tR7sHUOQ+yKXPzWNfmHmjJp1OER3Nk5R5TQ8ac1HkOhvBCv3YDX5mc1L7V4ntxg98I+oWi+5cONR6TDwHsS0iQHIjX8HBvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oO/rLQtYSN7jhq3wMLXrZEevzd7E30nZCaare0ODyL0=;
 b=uWwc5T4XJa0icVJeYiAiwxD7KyeF/oLW7OaLWkUgJWNJuSVq8FibCZmXdxv60U4XKMxjmJVXWLJLvrUHAoZwRCZpK5AZxHWB/SSB5jqn1tAHdFmfa5tzeJyc32vwWhemHh+PUElFjR8+Epcj24zl6kcnMWpX2m4xhChTTyNU+R8PwGekaqt7GpQnpJa8mJiqK+9WeFctjfoWcKTOQg+dECAVgZe/arjYI6ZcoRZpnCuY7o0rqaTnoDlWa7kS0DIuDi6tILZ7QQcOrIWWSLao/2HQeLeBtm/74lWy7iElLhtJPfrqYYtWiyIrRVkHdDjnnDiDJuQoqsmt6xOarLW4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oO/rLQtYSN7jhq3wMLXrZEevzd7E30nZCaare0ODyL0=;
 b=hRsqTl/Gk/O1FrB/D4Tw0upGsPcsF1np9i6RgMKqSPB6YRqscnVlOKcPt70lkObgiX2SIymA0IdzICZ+Dwo9dUtnZvds/nE6w/UdzvrBiFymmiFY4R8V0SsTLZi/Wr7ofiVH7oQn2Jjf4yJrqIC5Ag2GIkU/UyXTHwTcGUyt8Ix3wVAzuP/id9x6OBMV55dBYFNJxuPEEITAKx7j3D0ZyWdUkMgY4Mt/CRp7yWyyYgZS/vEzJOKCvD4ENd8Nfk6W2PelmEn9bz+cFiMGuCdVxC9PvIENXDDy75ZqPL7bels3b8p36GELwGOR+ZK20zWBqj8G+XNR0D7IDF5L2hAgwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.17; Sun, 12 Apr 2026 01:49:10 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9769.044; Sun, 12 Apr 2026
 01:49:10 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: lgs201920130244@gmail.com, akpm@linux-foundation.org, david@kernel.org,
 lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: thp: Fix refcount leak in thpsize_create() error path
Date: Sat, 11 Apr 2026 21:49:08 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <848180C7-F98C-44B2-AB1F-579BF9EEA28E@nvidia.com>
In-Reply-To: <20260411142858.85496-1-lance.yang@linux.dev>
References: <20260411062152.2092967-1-lgs201920130244@gmail.com>
 <20260411142858.85496-1-lance.yang@linux.dev>
Content-Type: text/plain
X-ClientProxiedBy: IA1P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::16) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH0PR12MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d20eea0-092b-41a0-fe0b-08de9835b100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7oTuzmpqBfmiIt0hyzMFoHsJOPMxhqp3keLyGdCsKg/yGJyo9tAikTLpmC60ew6kgxRrAghVmoQNDz0AQbIPNZWnnOaJALRPDUAYSMIWEPGl0bpPCWXwnSDfGQBtDnFmE768pydsQ1AawIhLI0kKYGfOgr2OCa0+20143jn7zgGvtzVrWdpjIDz5hfOPV9SfdFg99pE99UYeayBWlFLg6VPwUuM3273LXeWFFuFt3+ASHfjRxsgF6scElqVtC7Q6E9Zo5q+LEg3ALtaJdEy1LPM3BJlxScXS7uzMyY9Qu2F62xJ8BOjjhsq2tBkRAqaWczOZ8aL2EdMFaBc8G6D21ac7eVNv93nlqHo/Yv9Bj88itJcGjU86Xfu41+xVW5V2R4y9gDKUP5yC2BVJGj7U7tHdGYtQLMFTaQiFalgv9KvYI3CCiWGL/ygJ6OASYipCZ+NNyG9FpLYztHnmX7VAnfpDXTSfyhmx6r4MQmBCh0TLv6/EBOoOZnNsF4CbI08ep3GG79BswBpdJXkywTeAvTeLPT8U3J7/iQpIjWOZtHHwL35yhFASQAkfPrD4P/MT7T4USyrY8kHOFH71PhNc9JJHWUI4UVAYnXEJOp8jHiqP7Rd4s4LSM6u5MtDbEXxHvZBI9KdbTjdZF4QD1egKzjZF9LuWXXSk2cJ/DdTwlfMWf2+HBid6o7gQ4eTvObdISJMhB8NX1TZNP3krgGgZAVuxVhgFYLbENLNjt0FYnX4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d+9Vau6X/x2ObzfKxpw/2bqu6FywVqr7MqKX8ZRNTIjsJYc5EmCu757FL7rk?=
 =?us-ascii?Q?KaJtRx1Ijbz8I4lLWu6aUNTZTtzjnFU2v+KJtiOz7bzg/cDw5OrZyS9V6zhk?=
 =?us-ascii?Q?YzrTtcmHYPFwBVWN5Wf3X35OnUImBJ1aC/oYmU/26P0oLHIpl2nhRCFWglZo?=
 =?us-ascii?Q?bMZ96me339bNIqjqH9f6JJCUXko571GyO0DE2gt+nWrrznmq3npilIp+ughu?=
 =?us-ascii?Q?1LfDkaoR06HJHlJewxMCVzDuL6R+ziEFFTBsSv2ALeDBFiCcuPF2vUHNXIUC?=
 =?us-ascii?Q?awQdkBnnGuLN4HhIRQUaGvkwmauvD3G++l5f2LQr8qUVhSJUG6OPRBp2HNdY?=
 =?us-ascii?Q?0kzjx8hqnbyv4U8Sboq6TEg7ZcMWRxHFKiHCiq6pIvjcWWH+NPG9athtmGMY?=
 =?us-ascii?Q?4FAGm3cT5R2Qhs8zCalxgea0AqdEgv6TDkPWrrfaQ65AQp6nH71gK7zY0Uml?=
 =?us-ascii?Q?3s68WDIIaM7LF2ARkRwbxT0cSB5GOw+DondIcrcXcTtdnbe2QzbWAi1KLSYy?=
 =?us-ascii?Q?pPaDVQlfgGIpfNlIrxhWR0hAwkZsc4Bs/dJ5G/t7wiNSFH9YicEuVWR7mGAd?=
 =?us-ascii?Q?HoTnLA0sT48qUY/jZ2jBslEjdz46BojnopFCYW0mBwjCU8aBZ/rxx/D3YMul?=
 =?us-ascii?Q?VY5Wi9/KJ8Q5nYArAD7a3bU9xXQMG8KrNyDtxkBHBMglJEVFhy44z8Fg5/SI?=
 =?us-ascii?Q?Obk8Vaoj10w9VIwV2H8USSnQBjsMH5kG3qqZYzcTwE0Kb7CrbZR3Jhr7SHp5?=
 =?us-ascii?Q?Z99H/LeNwmtDmWak7DsUqbTvOfRGyf2ERmHfpPER1tbmR+nbD1YI5N8ntQQz?=
 =?us-ascii?Q?fRsJusx/PZ4KbaMwWAfVABiNG7LaRmjWFGYTQdNPX0Go+64Kou0do/vzxLZW?=
 =?us-ascii?Q?81VfmwZxEsRwgll+CY/gRbdNUQABZ8c7xI0sI+6idrB0ldkghiQtJjgsL+L5?=
 =?us-ascii?Q?7mH6a4sLRbyI+RERsK7Vz4KXfQn76AXEXcTwHbKYfW+8TjLlJudf6LpToZHJ?=
 =?us-ascii?Q?hW5g5uA61LCHtuoRpxLoiPt1aLL6TM6XSXd/og58ySFWUFEeblmRUVBf2YLH?=
 =?us-ascii?Q?HVRZymeBR61R45nZqVRi2qJxpoTQNE2RJeOcZSu6AgeQPZKINwrBIkNepu5T?=
 =?us-ascii?Q?uIDwkWq4tHUrTK+Zk/TbU1yHBln6zmsgsbHrGsi2S6Beb7K0on+R5YOvviH6?=
 =?us-ascii?Q?GgBmRvRph7rCyf6zu4nwZi9IPbBbTYbbnkE3QQ7KZW9Uh5/e8fc6MwhlmZKd?=
 =?us-ascii?Q?rlAcG9Y2JQn5Mv00bNCToGlV/X9cvkyYBQNMLpezAhyzTfRPW2rQhaJ+eZOK?=
 =?us-ascii?Q?o/av+xbZ5bRo4iaWjrs7Q5XvLpiyVqdQ0AQNNCUZpnfMjMgE3/IwQ6zhQcOh?=
 =?us-ascii?Q?AehJyhvFz0wTI5elqwS82/JE/oQsCdsVxVHPiXX1zmyk53SsIVEyeLKCrEKI?=
 =?us-ascii?Q?nvefrllS8WBI9gqf0pv3Zvo2DbUOc9co0SlFA8ARzE4ACh1z67NRK9F7aybq?=
 =?us-ascii?Q?izAtLeALyIb+qrogrHJAQNfdL0+AiBHOxq8udS2YzbBAMW3ccWqDxqSYs+pu?=
 =?us-ascii?Q?j9NYJ5oP9qOs4JzzEWPlM8QEh49/64D7lezvttwcrqKqNXF3jXhXw1R4YpcW?=
 =?us-ascii?Q?jMaOdtL6eQF47kncFTNhV4y1JP1dTASoUaJ1MlBbwOZtYgITSY4ZmGoIU72S?=
 =?us-ascii?Q?Kxt+CBJyfSjhsWzi51Q7kxuA1rl9c2Abu6FBlGhmBo9qaLO5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d20eea0-092b-41a0-fe0b-08de9835b100
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 01:49:10.4511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPdWkFin5FxsvPx72r3lGC5cmV5DThoivI96nZN5qki29puo3GkOaGN4cbTTPrXo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,oracle.com,linux.alibaba.com,redhat.com,arm.com,kvack.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235780-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68E083E26A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 11 Apr 2026, at 10:28, Lance Yang wrote:

> On Sat, Apr 11, 2026 at 02:21:52PM +0800, Guangshuo Li wrote:
>> After kobject_init_and_add(), the lifetime of the embedded struct
>> kobject is expected to be managed through the kobject core reference
>> counting.
>>
>> In thpsize_create(), if kobject_init_and_add() fails, thpsize is freed
>> directly with kfree() rather than releasing the kobject reference with
>> kobject_put(). This may leave the reference count of the embedded struct
>
> Right. As documented for kobject_init_and_add(), once it has been
> called, the error path should go through kobject_put():
>
> /**
>  * kobject_init_and_add() - Initialize a kobject structure and add it to
>  *                          the kobject hierarchy.
> ...
>  *
>  * This function combines the call to kobject_init() and kobject_add().
>  *
>  * If this function returns an error, kobject_put() must be called to
>  * properly clean up the memory associated with the object.  This is the
> ...
>  */
> int kobject_init_and_add(struct kobject *kobj, const struct kobj_type *ktype,
> 			 struct kobject *parent, const char *fmt, ...)
>
>> kobject unbalanced, resulting in a refcount leak and potentially leading
>> to a use-after-free.
>
> IIUC, this looks more like wrong kobject lifetime handling and likely a
> leak, not a clear UAF :)

kobject_put() ends up with calling kobj_type->release(), which is just
kfree(to_thpsize(kobj)), equivalent to kfree(thpsize) in the old code.
IIUC, there is no leak. Let me know if I miss anything.

>
>> Fix this by using kobject_put(&thpsize->kobj) in the failure path and
>> letting thpsize_release() handle the final cleanup.
>>
>> Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>> ---
>
> Apart from that, LGTM.
> Reviewed-by: Lance Yang <lance.yang@linux.dev>


--
Best Regards,
Yan, Zi

