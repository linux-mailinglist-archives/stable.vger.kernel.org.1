Return-Path: <stable+bounces-238347-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLaWDVUl4WkBpgAAu9opvQ
	(envelope-from <stable+bounces-238347-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 20:07:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F65D413867
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 20:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13B27302A6B1
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 18:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B721D32AAB3;
	Thu, 16 Apr 2026 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ukC01TRH"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E337A32D452
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362441; cv=fail; b=Kfevi5LuiQ1rkd+UbbRtO7wDQ6R5Sfhjat9Gs3un8ctPj1bz1gC/vHAonKUwGt+JZKcdNmg8JZm30FwK8pY25NKQCkjRHWmqLm8Chw3bV5PMBXL9zOTt6VH6ElgDzFFYl6dZC8M4SLaNCPWqGQlb3lS4l5Vem0ZWOdlpMM8vfb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362441; c=relaxed/simple;
	bh=NjLuARZJpC2YinZcq3mTjRUqcURSD6jJHj21fuOugQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VvcnZeiWClu765xM4loFowjPn3GabjHzsIxLWAZV/YkO98VqO7nSjegOTimYfggjFjMwzgq0ZHm6wffOBmZF8VzJx3kGQg2DX1S55d1A2uO8Oj/smh+fjVYO+LjcIvperA8CRVmCMt3BKumAS1D5uzWQ38YGUko0/c+Q2qWc4ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ukC01TRH; arc=fail smtp.client-ip=52.101.61.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krwTMroiGrvTFImuZmXOmKzkxsv9LtYRkH6OHzkOZatxdCNE1HtU2MOavGY9m01jkCWGPMRI5F8oxDlY0CRFtDUc1mdLthwHcX5EgST6GY+LAtjM2ibvJh61DFQZzFCLhfuF6d42BU/eAcCORsHG4WchnN6IGgG8dnfxJWxbCg+6TP7HoIVExJs7+wzf0BYN4COj/xqcLD4U+Fac1TodQVXK3RDYrr/ZFzzNCmC4/p2iC3S15bNdpAYq7lKmmMzzrWf8tRJZqI0BdAGrrJW/qI0QPkM9+9RIIWATTpJ6IGDH71D//TGkxS9fGUKUmtnPNlq9vukrYUPMjZpZYdozaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHrJS4HHX07K7husOSYYA5GyKFAxmjCH4nRO0rOFj5Q=;
 b=t8qXfzOSxeB5DgPvMqcy5ALgMiSaAz3vebXlwb0U4Br0J+M/lszDlz2gs2Lkg9Hk1vGtfBDUGe3/UQW42AQJztWy+Gd86Dqn8oaO1LynJeKVJX63bzApAG+SxTfbYwPuTdxInwxl9gErAtsv13shnHNJcvLqYs4OUvovzLqVnt3xQ9uQgwmx/CaohKrSWP8twuL1sWpgCKS3EudwXRmDguNclhecgs9nbWuEKgN0VBv/hMigpBl6ULjIDuwwCrbXYgUgyxe2Q4jJqhfzp2n028uaX3M+mU3nPEYccSNE/5jh4uNu1r9pvD8KvNk9bYvEn5s2xGq89b26jOR0yYMYrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHrJS4HHX07K7husOSYYA5GyKFAxmjCH4nRO0rOFj5Q=;
 b=ukC01TRHOkuT+4QWzQrBIVuoqo/uq2Uwq+TOyAXV+0Cc2t+pzHbGj7tulZTmFZ4BtrDVkuomAGPjI7pneAg2xQ435X2xsPEB86IqqMAbRLANJRGlRqmkYSIQBtGw6i/Vlmjkdbt8JMZfM3qGGar7hNTP/85IJe3/x8wSBOei1wrgiUhAE8EiQnHldN9N5LIhrNDcqc0b+CIDyHc+S/QYn1WPJOUbV8fNHhLTvsOtKlxV9mPRDXDqo7PorTCRRxl/694SXMXGMyBrTCPXM187uBygbG5syp+g4LRBV750L1Sx/mQ2p/pp29lJ5pProfRpda8nRuIvYk/VRrQZN531og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 18:00:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 18:00:35 +0000
Date: Thu, 16 Apr 2026 20:00:30 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Prevent RB-tree corruption in
 scx_bpf_task_set_dsq_vtime()
Message-ID: <aeEjvvOdQBNPdHA4@gpd4>
References: <20260415193459.933175-1-yphbchou0911@gmail.com>
 <aeEi0X4Fn70bUgva@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeEi0X4Fn70bUgva@slm.duckdns.org>
X-ClientProxiedBy: LO4P123CA0260.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b736a0-129c-462b-ae1f-08de9be20f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yM/neaO64GoiWPy91C9Vy/3GzRoqLiG8CkLeZfca0PNlWL4bDPez4XOQ6OMjYtr2HW/EYuF5wB3njfZkexepbEiyEEjwwIHfntRVhnUFV5fUIsDiA0E8U80wqI+mYV7LFkQV3LLZK9sritRnC1FAUMNFJXu+rdnH+HkLoSi8lJacSDHO3TNr0BFO4igz0x/M9+5XG23efAZRZH/MwWXDF3XcT63Bs5gt9Y06yOtXFtiOjcGPB4y2WtKGWihjOhYbjazz3YoecUFn61oq326BJV3yPiBTRc+2/u+gY08mO3hvNFVR6upoT25m1Iv+KwDZouh5OzJ83DkG8gSltMKqfZXXa9kWwBQLU+p6MCI6QOTfjur0DZpjcVgGTC4zqRFNHXqpxph436XDbLAVOvDa2J8nXPUiZjtYqI/u7o88Q2+JOGbNGtUULlIgbBKajdmDM3PLUIlNYEfNKSXbWq3dU/fftmoWWrVCIDerSTcblJgdZ+jBP4J7x4+cwxhn1Ms+SIvtDKIgsE81iiyu2eCAHe+9sriNKzP3MBR5vNwqp6mysLFsVpI20YwEtZOGWlJmmxaWbCWzGJ90bsa96giBiUpZoPmUONAMxDe29YpXPu+2qw6x6NvDYWBQgYDqC5jfF6X0vqggJhvx4zsjPgsextYH7aysCBqNmQdBVUMK/L1Gty2rWIfJR8jfNqLHbLNR3/KGwe81srJVCwciwIl3wKn+oHbSnbqmxrtN+DpltYk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4q5noFCFPFyjkw3p6Dw07U664VTMS+T2ENuD2cDFkWaNpPOgAvWwT432UO02?=
 =?us-ascii?Q?NpHbc4ZC2cw55OYWMKjqp6nJrQg4OemTpsWTCoUhgdliWXWhIJxBxez0DdYh?=
 =?us-ascii?Q?lM+uBrDGLuvnU2KgEQUtvuRngAyJe/pzMLs2u/vJsHGrP1APeM26wprfWrgr?=
 =?us-ascii?Q?yblbBOcwHI23y8EDMrqkilNT2YvSKnudv9lRWf845x9V/cvklVu3qd/gDON5?=
 =?us-ascii?Q?PV6ydm3dUUF7eletnbmA9RLwv4gjpoGL1cuFAmhQ9OaQzBMoDwoxL1gveJXq?=
 =?us-ascii?Q?MYpHxiXGGajt81rYeyFAHdcz/n+HRgo2ep0XA4RgxaVrhfpI1tDLIXy7taZX?=
 =?us-ascii?Q?rrrQWAAgVowvp8jgamMOK18yGLtBBgho+AMcIrnCDzCbCJhf31w5VcXy0Ff4?=
 =?us-ascii?Q?GI5jPR7gmsplEZwq52QUi89ohlYdCeu3OW6PVi3cLcKnZXAptPnIz1xfePP2?=
 =?us-ascii?Q?tyH5+Ip5L3IK+/sEzBm1XBU5o1jpwGCQSy6infRsYiyVSUJN1O9c0jDxOOgg?=
 =?us-ascii?Q?PgEgk9UnHHuWthlZMZNIBgYkmR1bUnVhvTXQNgLMok+ZfxU1EKe519YOWBLE?=
 =?us-ascii?Q?tx0ke55sa5Hn3ZLMsE73do9eEteBmBFcPJWtb4/ncmE4DmnXl4ZWX1VZ2gvI?=
 =?us-ascii?Q?5NiNg0a4IbOnOjT90cRiC7JEBKNj9i6EYW5cHxW/1ZFhkXAhEcyidjl144p0?=
 =?us-ascii?Q?b9vLNgZC2MprdW14vl+HcS78n+utDoNCGleDNSafYgc8jnQ1jClogFEpYgc9?=
 =?us-ascii?Q?phXutMY2juSA2e2a2wI0QtUSS5NAOjkJgfWHuxH+pnJ2n0lCUfMvNgq73A60?=
 =?us-ascii?Q?1Td8avSqZOX+BatX7SqE3nq9iPYS7GkTYgkR0wdeq1HPW0ETL5BtDVlqBZ9p?=
 =?us-ascii?Q?eAvim36HJeDrVn5joiWeMKmRJsIrlGCOcoJNLMNGKrl63MoyS5GG4SiW7IaX?=
 =?us-ascii?Q?DP7QYoUL1YCH07ptHmsfJWTROO/kmoeeKgqp2cMNzA20CEfDPJxSzwUaj39V?=
 =?us-ascii?Q?ymIHaCZVnQoGbglK6v20Tl+4wa0YlPHhFkD35B3u473YIDZX6nXL0JsGVycm?=
 =?us-ascii?Q?Xh9WUAUL65xXhsoJm9yokaxZ05yrUfXOoMHsipVL5hCtj7GM9xnpHSCQy4S/?=
 =?us-ascii?Q?2Ktj7E+JthGHZgeyZTy0RrwxiKo05YPXzyBRlCHzWKzPw/eAdFGDch8OmUXR?=
 =?us-ascii?Q?5LZwwmLNr9xtU/yenVOOw9v7nYaTvt5rMlenSHcSX5xC7XagGD9BSPHTa+Lx?=
 =?us-ascii?Q?W/4FuNREYoC9+s6fMzMjWuyxqb43Is67oxtiWGX3fxCh1HIaooQie0ruKgY8?=
 =?us-ascii?Q?2E8/UnM4xClpDmp9tkO4wAmhdfgy+4G8WhTzU/Ly3LpDFwdq2Gx8JOpLsgmZ?=
 =?us-ascii?Q?+lrwUS/6B/l76YRNv2jB9nnOLZNoo4TsmGvwt0eg1fFz7u85GfW4EgZWELgQ?=
 =?us-ascii?Q?l7kfNija25aLgUWR+SCJJ6ehaD+ljvv2wdKf8X9UgpeypHndM8+kETVY8+Sh?=
 =?us-ascii?Q?aKHTt0y9IXMOtvfAD6jRgk+ZQts6APXYlRcFqv/TDfMLO+n2HSRiAtOpAwVb?=
 =?us-ascii?Q?01BJkFOhnZ+PC+Y5zSL6klxIQfxABjRJQnaNYM/f3fPJVFoSEJJlCGjBhtG9?=
 =?us-ascii?Q?GvVL8lZbyylh0869iZUPA0WZ11LbnN247U8r5+QTCubbXgdD60SVUHfxA2nH?=
 =?us-ascii?Q?CFTzA9vmhWkZrFTFku79PzDxN1OjpH5lyZQ2NKhCssbyrlaRMrLnfCFbalBI?=
 =?us-ascii?Q?tMvfue2qJA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b736a0-129c-462b-ae1f-08de9be20f6e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 18:00:35.8524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9U3RiyoL4UGLE/fM13/mn879Skc/kl+JwBz4JkSyIYahD2y7VxLKF6XRhWTm9Csrc+VRELCErp3LRusDGGxRCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,manifault.com,igalia.com,ccns.ncku.edu.tw,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238347-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arighi@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 1F65D413867
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 07:56:33AM -1000, Tejun Heo wrote:
> On Thu, Apr 16, 2026 at 03:32:44AM +0800, Cheng-Yang Chou wrote:
> > scx_bpf_task_set_dsq_vtime() allows modifying a task's dsq_vtime without
> > checking if it is already enqueued on SCX_DSQ_PRIQ. Since dsq_vtime is
> > the rb-tree sorting key, mutating it in-place violates the BST invariant
> > and corrupts the tree structure.
> > 
> > In ops.dispatch():
> > 	p = scx_bpf_dsq_peek(PRIO_DSQ); // Get a task already in the DSQ
> > 	if (p) {
> > 		// This illegally returns %true
> > 		scx_bpf_task_set_dsq_vtime(p, 0xFFFFFFFFFFFFFFFF);
> > 	}
> > 
> > Fix this by adding a check for the SCX_TASK_DSQ_ON_PRIQ flag. Disallow
> > vtime modification and trigger scx_error() if the task is already queued
> > on a priority DSQ.
> 
> If the user updates the vtime after inserting, the tree looks wrong but it
> won't cause crashes or anything. Later insertions might get confused in
> terms of ordering but it's a rather obvious user-shotting-their-own-foot, so
> I'm more inclined to leave it as-is.

I agree. This looks like intentionally breaking the tree. If users do so, they
can keep the pieces. :)

Thanks,
-Andrea

