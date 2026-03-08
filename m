Return-Path: <stable+bounces-223450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLMnNMtIrWnN0wEAu9opvQ
	(envelope-from <stable+bounces-223450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 11:00:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAE322F43D
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 11:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69D7B3012274
	for <lists+stable@lfdr.de>; Sun,  8 Mar 2026 10:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C31335063;
	Sun,  8 Mar 2026 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R/29zoFT"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD88267386;
	Sun,  8 Mar 2026 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772964035; cv=fail; b=DLNJMFSx4+1PrbJ2Ot3bs4kx98lpjafAxYdG4xBvxSVDbe1aMluSaseoBx5PoUkHN5GwaW3UX3Ic+TbU8OIFAgpZqHVcUGus/aJama/0mbW3nTNzxP1gpyz9NEIeDKz9ePAsN9HNVS72KoD3n8vBJuElyi5YN9ufZDI8yddUGbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772964035; c=relaxed/simple;
	bh=ukEqim9tNNLcDR+oWXh9lCgUSprSxIFsRs//W7lpZP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a0EO6sOhGxaAwubQUS8NzlQsmbKJ61OT36W60lFH6yZLnE4oJmkI44teWfnU2wWZBzy+KCUVQXwWIC5NkaStdMCYNRcWBrNWitB09Jm2I561WdZa7F1F3d1mZWarDP9vNhJfmsGeodx1cdBf3usth5WY7tevvOdv78ITh4Bz/xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R/29zoFT; arc=fail smtp.client-ip=52.101.52.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOak8S1WDGdq8QYu3M5MYsEKPCbPry5PUJwWJVyZktoAIfwaqCCJxWwnbU+emLqDwYOzKg1YZMGYxVRf3GrreV+yv8HGQ28rMvq8ZJa03m+pVBdKLKF5W9LgAjt2oWnPyTOiLAiyF3i9QHqXOkZVnrrDt4vJEa7mP+00Na+hpjhhCXGHUzp3lj4w47gORosqoa4xKRhv0PTOwJFp7MzA0Q17cnVOYwrzJnAK8f32XNOXw11lQfBfs+qGtJIuQa4rMsQWPJmMlzTzrX/9enKk/lwrIF6+AG5ruUTOV0i4CqCkXvcBO84SBFb4WSrSQfdVSKP7VnY+yH6/FHOmH+vO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIdMfLacpj/bvakjJKDqp2pha9Ot/CB6Xz3LCvvwC5Y=;
 b=CgROvbzrEZyRzFJujo0odlPmvVsGfBQXGeADb+Y6OQUTzUB15MvvUpB2AGT+vzvHeR+SXZQABMzdD7BUVpOZmI1AAY49ODdSpbCa1P5w3/5M0eZL5ga+vI2t32uJJcu4X5BmAtJe3eRzhkI8BdACdxZtDsooB2dS2iJI8wtUkzyCx+7xyj+72Bgdg/P66D+M55LJBHgfftKxXFR0TlDNUHHD69hr3qCtA0Hogypno9zKgebjsGeGD1TZFwOM6sSoqknfiMpqQNLI3vjXIo9CtOel7JWAnwlZHyunCU394I1ezFLAgxeliIXt7/uLh7E3BfxyzG0TLyudi6X5+pUJLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIdMfLacpj/bvakjJKDqp2pha9Ot/CB6Xz3LCvvwC5Y=;
 b=R/29zoFTWUReaM63CmyKO1ULCQbiGzll8jV8ETvQXEg/5PcMB/yznC96HgkXRuhsVUq81MQGKwbJ1+nzJj6hXX7M2J5YxQACKn9WRElt6/ER/wqNx+ptTotfqqP83ZZmQtNzfl5x5g9UoEMPDbjB3FhgtndZB55lWwLzAd/w/8aTYlKm9vAXAywTyXF76qGIRJDuQqEKWUFpLHU6n3AfMBHPQjnEZGma4b6J4WWzkFbDaAQ7vOvMRgbc8u6+Az3C6hgipCWpZPb4mHEJZA03ugI6p/C8mZCUhaGXthGZN1kgzn7pC/0bSgmvKHkjBq/x+qu1zklUNL2G3AV3QhxteA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by IA1PR12MB6530.namprd12.prod.outlook.com (2603:10b6:208:3a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Sun, 8 Mar
 2026 10:00:30 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9700.003; Sun, 8 Mar 2026
 10:00:30 +0000
Date: Sun, 8 Mar 2026 12:00:20 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Mehul Rao <mehulrao@gmail.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	petrm@nvidia.com, netdev@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: nexthop: fix percpu use-after-free in
 remove_nh_grp_entry
Message-ID: <20260308100020.GA1582491@shredder>
References: <20260306233821.196789-1-mehulrao@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306233821.196789-1-mehulrao@gmail.com>
X-ClientProxiedBy: TL0P290CA0007.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::11) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|IA1PR12MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: 45259f5b-1d8c-4a69-c918-08de7cf98803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	dgsrEf2misCE9LLVPGFFZpUaPUMBe5KBF0LsH5qTBnVxz97JRJoRqBv9U05I+ulMZP14S1YdmulS7mf6GDx/1jLlEIuwCyT9Q2jhegF+gpTDpDxkF2oVmuiHOcewBAHXXH8x/z6N4ki7JNaZPMf6bIBDEySZHdOKqUG29IzrTcoJbhWF+jeG8F7klzR1zn98e+AiEJcYbmL7AN6fO/4iszHp8tvlLZCjgqjY7ClWD35fYm7PjGKSqc99z9dbRCdkkFlsj49MA1UILrgaaUGCBcFSNEuN3yna/4B4BnlFw5VILcjInrYHWyNqHlM7LA5DzGA7LTKRuUOWm696vyAvecXsagryIxqUICRu9chuRaidp1hO8TJe6tjcRPlBP/txNQpHPssM8OVHnhvHmuUUfDUuY6eGMk0xUx1LsR7zMbzdRf4YutqOA9hKL2spr1ALkxsRMsxpHipfs8kOZbUe5Hz+j1BqjSRkhAFDtnQsit2BiwUOJKyhaoQ5hh/UFe092bnemXEvHivpE0VkUbPiy2vJM+GRxUz/yF7bJ0oYyZZ7m7t+N24aDVUyOOp2hUZ+M9g1RdZlPc2P0KHy2VR4R0BO2rXS91I+//Mdcu3s+UlIJIBZYNm8NUNYr6ZDTpTY9wLrtKWJA4Qk69Q72QNBr6F383qPjnLK3rbUVZAiZz4rCI5bfXeDFoEpjtqTLv80C7fiFaJIO0HILefgW+VBFnKN5PsUoiYCx/yDKbv3Z3o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/PK3cAvnuPMjt6XAk5u+1SbC2cK604OPXnhafQ8KiKcjb9RKPlA7mr6vrYi3?=
 =?us-ascii?Q?kvwdPtIRZcslgqO+n5+XRVStCFAvR4kTtIGEOcz07sIp/LqzC+D707AXDWEg?=
 =?us-ascii?Q?oB5aoIW1dSfr8vyLWdLP8x0m+cmBPw/kZGU5VKfXNHtRDBuHGLogz1Cu0saf?=
 =?us-ascii?Q?ySckMQMvMVTNwK1t9juffA04MsZ2cIuBCDZhFRcIfRBYY2DrUhOwLr5PoX7E?=
 =?us-ascii?Q?TklOAZot2/cWKJken2yh4zrlvh3pXXg6ECxhGxTIC/ArGMNHJNRLqVX2nCv/?=
 =?us-ascii?Q?gxnLqT0UAlKreRHu3klNXbPbJFlOnAYHRePZQ4okWxmOTvEINPw5lPR2W+PP?=
 =?us-ascii?Q?8kWKkLplyurA0KfitrREl+BntCYSHLJewOkOnVfmRJ+VAD1VvA+80aZGmcNk?=
 =?us-ascii?Q?VZkWRVK1fOqYVXOv3sN0xWrX+nrL2V711tDMeQK8kUmYRgMIhdQE9Dfgvz+K?=
 =?us-ascii?Q?B4cu0ZocOH/a7n1Rq4SOImmabEQI+RJTjCXcTwqqrN4kb2/QMS9yXzmL2OPj?=
 =?us-ascii?Q?UcnKp1wQgtm4ndUtSTuEwCVTSV6lZWN/t4NifVm8TpdXlAxShbgaRrbZROk8?=
 =?us-ascii?Q?fYcO84kbGN8sCvLmUkUVzPzRzyhEEzMjq9JFAAAHypXfc7oMGvZ22O5LLKXg?=
 =?us-ascii?Q?iOG5RaevxevckQ5t91HrlAryPvXQRNAry8b4MO8Xv3O05qa2e5YfDaXABREM?=
 =?us-ascii?Q?p6NFNfeNPbQulSUXrONW6RDNr+Y7MThgh9RqLsNgABtAOhD7+dUkJXv3v/Ju?=
 =?us-ascii?Q?37CFlETUJkMSChdBxVdNKa0arYtA8sJRb3nc258rVm1MLmYXjV8W1n5XEmfT?=
 =?us-ascii?Q?OU+JwXe8LeD46oViLwaXvl8xEbSHJKRRTmXcWeSH+DBIoOPyp40gSfQwvt4M?=
 =?us-ascii?Q?Oz7aRj5nC4BNlodgZXs8KB445WgTrHi0CXs7nRGqiVd0MrUtaDgQbb/FENdz?=
 =?us-ascii?Q?A5/j65TJoUrvrq5lsh/k/x87UpHIIhcqoolfVQFbdfAA6VQBxE5O8EWB0E06?=
 =?us-ascii?Q?UenGwfJCAB2gYUnSXqxMX9zoMzD6IrGu4ElFIbcz15ys1f+qVQaufkxH5BFD?=
 =?us-ascii?Q?9vgu5GHx4FC7knVkNSAieGZ5uNOBW98Mj0lReLjEt2GqOELzzg8RrdT6d7My?=
 =?us-ascii?Q?+ICYN77JapWg1S5eilfHWlXPx7zn0PlyMdlrRJOezwt9VCaGQJdLbAOiyodZ?=
 =?us-ascii?Q?EPGAk5ydcivwY//QzUG20YxNu0zXNOrj8ysf4fVHafiTwU9cJDaP04R9ZWDi?=
 =?us-ascii?Q?UGOUDxZHLisJQ+s0RhAnszXlYQ1scSC7I/w4gilwXEltAT7+rJy54OlRijbU?=
 =?us-ascii?Q?c692m93BQNadVWdUIKiOPq5LP9qyjgRHEvfAltzpRiP6+YMug4h7A9vSbDE8?=
 =?us-ascii?Q?S7Hmo/GMxjNjveJ3zXFGHZLkMXhp5U+kjqx0VxGu3bWRwzOxG6Yrdt04nGF3?=
 =?us-ascii?Q?Hi7gznQbxeQrFXqjiYizZfspDEx9XtUeseQbdv4KhpzzSbyHf90XOmCXHccJ?=
 =?us-ascii?Q?JA2VuHmTZMOV66NM8gIMQEZUFPXJt8u30EiTkIR3RdIvGqUpDpUzY9s1ipwC?=
 =?us-ascii?Q?BKdLwFcOsXybuUgTmcCz8HBb8TByY3cTJFesn3ekbRsZPt4xvnxfYcz1fnq7?=
 =?us-ascii?Q?PfDHUTKU5qBdWIrWZhpWeQRvm0EmjRvFwto0bspjj6nFjJKmuMBzATZmDW1j?=
 =?us-ascii?Q?mU1Y0h5yHcbALrray+E3btAwiXT0KbHUC+bs8BKI9hx2NNtoEZ/QkbuCygvT?=
 =?us-ascii?Q?lDgCsdSKaA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45259f5b-1d8c-4a69-c918-08de7cf98803
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 10:00:30.5847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+FrEoxeXE4HWNDqnaLf9B1ebGxfE9MvekOoymMtd1z8ak/HInOSzFQX1Xr66tQ+85vnhjAT4qo4lBZkCbd0ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6530
X-Rspamd-Queue-Id: 2FAE322F43D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223450-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.947];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,fib_nexthops.sh:url,Nvidia.com:dkim]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 06:38:20PM -0500, Mehul Rao wrote:
> When removing a nexthop from a group, remove_nh_grp_entry() publishes
> the new group via rcu_assign_pointer() then immediately frees the
> removed entry's percpu stats with free_percpu(). However, the
> synchronize_net() grace period in the caller remove_nexthop_from_groups()
> runs after the free. RCU readers that entered before the publish still
> see the old group and can dereference the freed stats via
> nh_grp_entry_stats_inc() -> get_cpu_ptr(nhge->stats), causing a
> use-after-free on percpu memory.
> 
> Fix by deferring the free_percpu() until after synchronize_net() in the
> caller. Removed entries are chained via nh_list onto a local deferred
> free list. After the grace period completes and all RCU readers have
> finished, the percpu stats are safely freed.
> 
> Fixes: f4676ea74b85 ("net: nexthop: Add nexthop group entry stats")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mehul Rao <mehulrao@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Do you have a reproducer? I would like to understand why we don't see it
in the torture tests (e.g., ipv4_torture) in fib_nexthops.sh.

