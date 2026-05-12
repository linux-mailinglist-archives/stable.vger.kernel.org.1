Return-Path: <stable+bounces-246646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAgmMU1wA2qI5wEAu9opvQ
	(envelope-from <stable+bounces-246646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:24:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69267527812
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A90CE3010BE6
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6302B37FF44;
	Tue, 12 May 2026 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UX6/Nj/8"
X-Original-To: stable@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46B417A2E8;
	Tue, 12 May 2026 18:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610249; cv=fail; b=Jj6qXoy3rVVOeo0noyyyWLJWbVeNZHOw/sJVOtZywBZGAA4FNV3Dfd/dmFf5X4/QfvCVbyYcNsgTT0cBcltZRwiSgPPBzBMmpsnf8WFawRy0GVGyojmlH7wLxk0EJ3QzOHKO3LMq9Zzx5BbzAgjZGt5vKOZpLxgMuWV7lF/FbIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610249; c=relaxed/simple;
	bh=54JjNWtccrwViwWVuZ5CzMA5/p1m31C+GlM8dQFcMI0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kKZ5kY6+MQpOiAXabA/6xICUzTYjPfhtwDh6HQu0kuZW1IZifjS5hAHPy2fBvAXB72vwfcQW1yoUvR+Ctw3uvMtkw9qwP9gVaSbbuqtB9LynraxPsoJtrMQYNfhdMr7FaS+KHEByA9GyccP/ZFixgjWTJiQPWnOaLEOz+qDIMIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UX6/Nj/8; arc=fail smtp.client-ip=52.101.53.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7R8KX3LAQwA67hWM//zuyJFqNaR0+XkBpEd71tFdJPmtCx7qqx6dmxgpqRKO1DVZjhtjIdxRRtoG5znaeCSgjq+rW0Big2mbiuPRQ4JR7w6nakwUpMk0YlTOtqR1i250g+4w2+gsoVWMZVXIlOWbTsUsiKrAyT7UARv5htcnC6lzr26PVYxWC98JpVJDaViBVANxhljhUCsN063dB2FVEh/hG3UQuVmouQM8lsZk5bYrH/ycWJkzVZNRJcpiYlKiZKHMaLWuneqKUIacC5X9tDV8fgq1OYTwj0to8DzqAyZIVKDxIGDmmDuAoLYXvFDxKwiPNQqPgA3K3ixyKjkBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2h0phEtnwzduOyQzdrXcEdZjx1OKdCL98nvqa9JoyE=;
 b=Ummd5ZnQB10ZqWJZTFQoh9vBuGahICTo87btWnFo46lfwEaq41CL9x5e0Y++Ioyt8SuLWeAOxoakYjpp/aIaSVqkPaQthbTc8FoNZ6ZsKH8YUGZ51FJTcd9MGdGZfmH8iBzlvDYOLqbnn4BF30CxMVcGA4JeLRNAs4sr5G3ot2sNG6QpR9F6WMR/dgEx/s16MTDGCwG9MAb59Qh9jLH0/eGtPVSQ4QoBV3jsaYdkU4d+UhHkw2MiUd7QeSotRMKvHKOw1XHj6zK8XT/ewNWtF9zUpOXlIG34MiahXnDyn/T8nXiNu8JL2nqfcusSmbE1I6D7rBeRXXdDLl63YkNThg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2h0phEtnwzduOyQzdrXcEdZjx1OKdCL98nvqa9JoyE=;
 b=UX6/Nj/8KEaRM+3fu3PoQeMu3bbG8guxSL3+rVQgRCmbGWpuztPqqDqgBDRI/gMqy5HrW+XnghbsfNGOUCXCWhBDz7ziQtpCpQODj3gIgkADCEyXWH8g7qcLumvxA/b+900qDIxMWYl+skul/XJJGc1oHoOO5dKDzSN8KVjN8Uzrw0b/zhqVjIjqj71GN0MofLwJWa30xRUJTmwrSWm3JbCrDfbka06m17bzHV6ByhumQQRvjPz4DFeSlGUBbJnJx4BnjwFIFbqDj1rDVeL+cIXdlF5S/3Pct2Wg9fOGbGoWrTWlDXnute5/lRvkEOkD7BHZC1gSnrZ8HZDKmRPLtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9430.namprd12.prod.outlook.com (2603:10b6:610:1cd::18)
 by PH7PR12MB7305.namprd12.prod.outlook.com (2603:10b6:510:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 18:23:57 +0000
Received: from CH3PR12MB9430.namprd12.prod.outlook.com
 ([fe80::3471:9f3f:761c:841]) by CH3PR12MB9430.namprd12.prod.outlook.com
 ([fe80::3471:9f3f:761c:841%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 18:23:57 +0000
Date: Tue, 12 May 2026 12:23:55 -0600
From: Alex Williamson <alex.williamson@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm <kvm@vger.kernel.org>, Kevin
 Tian <kevin.tian@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 Yishai Hadas <yishaih@nvidia.com>, rananta@google.com,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vfio/pci: Fix racy bitfields and tighten struct
 layout
Message-ID: <20260512122355.22132e61@nvidia.com>
In-Reply-To: <20260512131812.GA7655@nvidia.com>
References: <20260511221609.3837652-1-alex.williamson@nvidia.com>
	<20260511221609.3837652-2-alex.williamson@nvidia.com>
	<20260512131812.GA7655@nvidia.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYXPR02CA0056.namprd02.prod.outlook.com
 (2603:10b6:930:cd::17) To CH3PR12MB9430.namprd12.prod.outlook.com
 (2603:10b6:610:1cd::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9430:EE_|PH7PR12MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e9ed87-4016-4100-de49-08deb053a171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	u9beFSVecp64Yb8qLu7by1DjnSdmrhw9Uc9uzUQVRUSaXlbEsbHy5nE8LuVKkiOBJnaKV6CyPHS8Orq+2Y8/p7eXvxQcl7braUDQGEuH2s+oz9EJlE58ITQIG4MyubZKOw5UZhj8aCZrg6c9EzU5w69bqxkIu8E3YWrkxLdxGntHtCQH0D7PLkVU3RIBKo6gzSySqF+0h8GcSwulRRBHnuT4K6R69Qt4lnQC7uSjoYnKJceGVfdALHPiih1Pi39OAmOEi5lFWWwW+bnJIXrW4WtRwgyD9sZ/NlrEPC1/QBaZttxGzrMIdKAdk3HXqeFGJzoHfsPmEafS8aUSY3e1qt7GN+VVyRV1A40Qf6/Kz8DMN33b7ipV3RAIIom7JY3qu3EGH37kLff2hcbIhDkPtcl3IzsDEpucjO6EtOp4yquf+5uvCNH5VzIyg+4VJ7EpQpuxiPu1NkCwCD/2wccnRi2kNfpePdR/xaZsYTbPi+gi18eeR7yNyzbUGVKbzr2nChlfr0cV0LgNxvx6cMM/HC7wB9bYD8R/CT+ONI3rvA1gcR2EFgzRqmREGd+7xvlUxpB64vNRmj/rZE/F/QEwtCW6mND2fRrXAJQ7viS6hesaer1IRSj5HxzLl3Eu0F3X63MTzzYOruPyIPpd9KAVT+lLoPgCaK5HARPlMyj71iaWVuN+7c6ccEBUM4Y+Ic6M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wVIDLq5hcsg+5SYX2tts/1Tt6Hmr58kidRuZSIGo8OfB4aBjH1XmTrOqQlvb?=
 =?us-ascii?Q?N8Lde0btqbFesOLb+F9UL7sWi3uk2jcVSGV8boVNhK2ClzNtwEpYbvpEes9b?=
 =?us-ascii?Q?H8OyqvMqoA2Rqj3zM7B3Vv4oflymWjHt35ry3dtMshjMQnWCPTIqT42H72Hj?=
 =?us-ascii?Q?0mSHFny7pEe88Jm3VhyVyBSosYTMcjmqTpxfNaAJN2Je8v0bmKAe0p5uierK?=
 =?us-ascii?Q?WSXVWuAvs1BAC10ypVVQnMWvEmkOqnSRyNXt+pOzHUhKg3hOeVP09naigRAc?=
 =?us-ascii?Q?/IoroFS/A30e3jxBZmsUoVyEZFjxbxj3fSx/Jc1Gmh2m5BVt90z84pY7Jnoj?=
 =?us-ascii?Q?gRlcy1G6OZKmSXgB0Oqoli9crWEm5yQvLMOeWh8JDf2qoR8neaGaGawgQWp8?=
 =?us-ascii?Q?0q0punBbhbShiLqioZPkXgoeFZR7Zcgo+Jp9ClGKdFRm5giMf3aJkGVpcnoK?=
 =?us-ascii?Q?4oHeuaHYdAp4NwtqUW572UIpoNjqW0L4Vwxfy5k4DQYh3gi0qxuxz+uVqIbU?=
 =?us-ascii?Q?pkzouwLIYWWms76p2zCfUlw+2ggULEZjg7c1gX+N3n85jCmhjzwX9Fc7cYXA?=
 =?us-ascii?Q?DrL2lGfBKrVDcuhv4Cfv602ikx3pwlIqW3Sfx2jcXwHO36FI0W+FG+leKDew?=
 =?us-ascii?Q?r5CgEOwg4J0sgtNidPubURkAx06pEl0r0cMaosemz4s37lY9L2y+PwJtahNO?=
 =?us-ascii?Q?CqIPH00Inn43nDfxHR7cwQuBUhbE93/rR4CTlkT6Nmr+q1kGwT3TwhrFyzFt?=
 =?us-ascii?Q?TAoe9zSvG0HYn+ldJYYhALj0SmjG6J5/svQz2fb2PdYDnY3dAbj+t4DfpCmC?=
 =?us-ascii?Q?+bXbxKKVk2Z+nNepI6jgDvNaJCa9/rAy8OFOOtiDgyIqBurss5Mzsu9g6XU0?=
 =?us-ascii?Q?DddbLBTv5ZuILjEX3nyB7mRMR58eKJnALJv/oTTOxb/Y3wXeUaXb1EhndjM8?=
 =?us-ascii?Q?KUYd+s3+yDXExvvM31qBs7kKxmidniArNhkqwG8+0+FKokC4ijA78Ikt3doU?=
 =?us-ascii?Q?GEEALfEx6R0G/6eAhbHvICVQbJkrJjmwYhUSRzS7ppwC3fIbSqtAh4zOAWs0?=
 =?us-ascii?Q?srV3nb2HyTIK5qA3qRuFH6YHSqXPeYKaD3qO3Evbb8CJSqWNjlFIhFjVYgSw?=
 =?us-ascii?Q?EjB/CfUi4TM+aIx/SYUWJM5n54GSBgAsakP+A13fhqgFzpel+AT1RoRrSNrv?=
 =?us-ascii?Q?43KohItaxJ/4pMxAgNTnDk0qeX7eHCrYA51hBSDJFeg0NxUTul455KEzH9DZ?=
 =?us-ascii?Q?RuboLRQWPNZen+983Xn6fTUpNsSdPkWYdUcoKvk5EmJcmS3FYsyIRZsiYuaX?=
 =?us-ascii?Q?VEdaqNOdIt93Vqze74WvjoS95L/iSLYR9l6fYj5FV12KtELWXiH81GwOtdnN?=
 =?us-ascii?Q?qrLy8rWlJvI01oiSSsLmJWAmYLhNWTQaE+kmi7wszX5GW0nzvD6kH4Eg2Q4r?=
 =?us-ascii?Q?t7DwKpFjRKWGPqGZTtQpmrCoR6HpLS5x+Yu9D/L05jNI20zPx9VNi2Rwtvzm?=
 =?us-ascii?Q?rp9JYTo9sowMFFDW0Jw6stEnTBGNC2lM452yi0KmgU//gyAvy5iK0t0DLvDQ?=
 =?us-ascii?Q?Ap7hY3DyN3qyv2QxI1H+Sc2qcrtf6+emRuFGu5OE7DOndTyxqHH0ou8AiFCM?=
 =?us-ascii?Q?Vrp8qASD65aBR9+EhKyQrrIWqKoXHs7uG5vczCEIMqBRT9ZB4k9vEFNOvsVK?=
 =?us-ascii?Q?3PJqnYF1BvX6ZR8P1qdP/mFcw9lgiynEUtpBrjnB1fFEZqreqJODSzvC5PUC?=
 =?us-ascii?Q?F+QNHtdG0Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e9ed87-4016-4100-de49-08deb053a171
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 18:23:57.3882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1WmXJSsfu8id02IwLjCvr7eJzGDzbCl4tGEt1jledZk1/tfYhgRjpABQNL5l8jZr5EyidKWsXOmwM5TBTuf/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7305
X-Rspamd-Queue-Id: 69267527812
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246646-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.williamson@nvidia.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Action: no action

On Tue, 12 May 2026 10:18:12 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, May 11, 2026 at 04:16:02PM -0600, Alex Williamson wrote:
> > Bitfield operations are not atomic, they use a read-modify-write
> > pattern, therefore we should be careful not to pack bitfields that
> > can be concurrently updated into the same storage unit.
> > 
> > The split fields (virq_disabled, bardirty, pm_intx_masked,
> > pm_runtime_engaged, sriov_pwr_active) are mutated post-init from
> > contexts that don't serialize against the other writers in the same
> > storage unit, so a bitfield RMW could drop an adjacent field's
> > update.  The remaining bitfields are touched only during probe or
> > close where no concurrent writer exists, so they stay packed.
> > 
> > While reordering, place virq_disabled and bardirty earlier to fill
> > an existing alignment hole.  
> 
> I feel like a comment is needed here for the various bool groupings
> 
> 'write locked by XX' or something?

I can provide that, but there are several ways we can approach this.
As I dig into pm_intx_masked vs pm_runtime_engaged, there's an implicit
pm_runtime_get before pm_runtime_engaged, while pm_intx_masked is only
modified in the .suspend/.resume callbacks.  So those cannot actually
race.  needs_reset is set on close, which is already serialized, and
also via ioctl, which again does a pm_runtime_get, and indirectly takes
memory_lock, so it seems safe that it could share a storage unit.

OTOH, virq_disabled and bardirty are both modified by config space
writes, and while there's likely serialization in a VM, vfio-pci itself
doesn't provide any.

So in the strictest fix, maybe only virq_disabled and bardirty are
pulled out of the bitfield, but the dependencies are sufficiently
subtle that I wonder if it doesn't make sense to limit bitfield use to
anything serialized by probe/open/close and anything dynamically
updated while the device is opened should use its own storage unit.

The mlx5 patch has similar subtle dependencies, mdev_detach and
log_active are serialized by state_mutex, but deferred_reset is set
with reset_lock.

It's not clear the bit compaction is worth the subtle RMW scenarios.
What do you think, should we reserve bitfields for setup/release-time to
avoid this class of issue or handle these as individual point fixes?
Thanks,

Alex

