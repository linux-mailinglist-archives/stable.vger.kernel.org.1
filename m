Return-Path: <stable+bounces-233380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEUSFWW+02m4lQcAu9opvQ
	(envelope-from <stable+bounces-233380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 16:08:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A933A3CA1
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 16:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 587F5300825E
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 14:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A8F37E2FC;
	Mon,  6 Apr 2026 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="InQPuYqZ"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47B37E2EF;
	Mon,  6 Apr 2026 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775484514; cv=fail; b=pQHalAMAbHtPbR1qjmBwVjIfluzcK3cAA7ik5oXZShJ0gOwdh42z4vX5X1OLyqaxLKL1ROgNDh83+sFdl+537yrx5T+MUxk7aUFxbOGI4LIehQm+9AKZsMrbdnwBbn3+22uHnlz7f8m45NeEJ6rsmkjF8usg3FgEOR9uciVrr5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775484514; c=relaxed/simple;
	bh=RFjAy/KzKX9FJQ2DXv16orm07g7Rfmlu/35Qlta42v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GMkuI6ggcuCPNAF6TMZHzgPPDxfRvfsnrCrNEAo857a2vPJT86LN46DcEo3DpLplHkWa9HC3qbv+q/bZ7aQt/FAmrXBy8MV9focxiwCaxXPBRDpyyInJmcCweKrLrUwA+gt9QJm8Ci02UodCf2oZ1VR98UCf+5pvTmqIKVb0xqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=InQPuYqZ; arc=fail smtp.client-ip=40.107.209.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYtkGQK1Gvvbjh88FWJqBRT8o1N9f+Ipz5nKzqZCmXw8cE/57RUpZEgsaNbPHlmU7HlM5WRgyMFCxXFLiZLc0vGr8DfiSHKN+9gINDe1WnHTqICUWdMugPEl0FSuwEpznaV7gxI30qUcQmyEQx/ZGGDQS6oojNkrrh9yz2tGI/Ig41To2pHD0rvC9zjc4iGv+SBMxxxC+bMJGa6OTeYTcYhj6lF8KxYzOmOvBaC1Nh99HP6xii65IyMqUo+32KkbrTp6KSRzuGlPbe/w2A2O9VWvSDUUaicQaB/rFf96GgzPNG78rJHunKKS1GaB4/hvcytm1frJwcy+ufZNZi9e6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOKeyxeKGgyLV4uLMeXwtycoYeItW3cGtivo//NHBPI=;
 b=TzMcgfnWchOEmoTW2xhCT4lhYShHSScjycgYFnWAGSldMzthld/OtgDurxF/EY8/rtLsNJYHHMCw2YAQQyQQ9+EUk38uujuIGaOo2lX62/IkrIOphkrGIa+wWWTOTN77KMgfmdNXh1wezT3UtTVaqYEwy0lAAjS48k1F/8C7ihDKMKfdkyK6HfnIfseSIeHt74QzEk9t1SPzpTw4tru3/6sfJSeJK4jQyEylstRHbl464+Rl0C/l10Zfi2R/gqjMSaAghp6WMmkpTLY70RZgvtX5u3zrJHnljoYxBSn289qH09xeRh6MaYsVMwhHGjHci+QUfzJdbFg01cC/leWB2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOKeyxeKGgyLV4uLMeXwtycoYeItW3cGtivo//NHBPI=;
 b=InQPuYqZT++jpnxRurPSvF3SBD9EtERD9QVdV5alhYSSCjGF7zMap+aUl8vRqgapqmn5uXYmRwVl77LDm/pX3nISou9XZUbRbc32j8Nm/LiRjoY/MGdoJS3VGOeFdWmW7od1KFhnVBfrR+tXY0Wt66zb+HGywKP11HkyJ59TmwwDjMLxY8JDWP9NqX3bPNnP0xWSaNlHNwfjSHFzy6J0WF8JnpI3EIkQmTX87o394rW/4tl07hhMTA+EmgxZ8RyZ5DwXmy6j4Gfsf2awJTgjwPnZJXiK8tBFH/viXMtAdVd5a57GxpmtN4tydQwO7LzjsDQS9GwlNqx/qvHbyXTPag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6443.namprd12.prod.outlook.com (2603:10b6:510:1f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Mon, 6 Apr
 2026 14:08:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 14:08:27 +0000
Date: Mon, 6 Apr 2026 11:08:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	intel-xe@lists.freedesktop.org,
	Alistair Popple <apopple@nvidia.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Brost <matthew.brost@intel.com>,
	John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
	dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v5] mm: Fix a hmm_range_fault() livelock / starvation
 problem
Message-ID: <20260406140825.GN310919@nvidia.com>
References: <20260210115653.92413-1-thomas.hellstrom@linux.intel.com>
 <adOqU0UDzpxvQuwA@lucifer>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adOqU0UDzpxvQuwA@lucifer>
X-ClientProxiedBy: MN2PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:23a::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: 1475342c-d895-48ad-07ea-08de93e5f917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8/GNt2JF1YuBL2Y1/psEBRVIEZUvmXMGOVg/VcO85CneVu0UODOHTgnL0G1i35NRMgqjAG4ZEnSVTYc6NgZRbRMFcfJ8SybwgjJesShnvFf661ZktmidILIQo6cEUasJSYoTrwUHbPIa6kDRE2MPvVIt1UBonJTaHpV0A5KJi9b+0uYeWi+cPpNJj7RbzG1pr2TylLKayiZFGt3ZwJtnZL2x1SWw2qKnIBXRmMP+UmUsPZYJRM7t/CUcpFyvXJUtNnCgfJg17OlPu1EK93EmKD7U/6JnvlGWQcSCRbSipPLfJITYZ6OXrTDgsv1KzLisPRIR2xcJxI8pybJcUpYwUdUUDTvQ5zdIrrh9EXSiKFhNoJ7cBv6sM/ggbdop8XOvW/FVZCtn5m2gT/LbUWNaCnjAH6rr7AwS790HRRRh3nsfTGzdX9GdOm6l1stDNTkjOpslbK2AsMFi1owcW+TcoPs1iBBqCToTA9mjVZ7q7lFLLJ2Spt8OqXerYQPjUvbJel6oT9ClGcAgoGtoKVSIfZe7lVXH0FkEYr2Ym4aDgrkIq7eh/RccfPBGkNxqVfPBCR99iDiwj5L3PVFNqxWbZh9EwLCWqFLIu3JHJXGYimLJn0KZfAQIx7l7d6iy+JNLH/SfSx0SJehxi9gMENtc6JOaVZZcye1d1rMWM3MLWxeNHdHL7Fds+mjr82P4EWvTORwEiVGoEyCM/WXlN+ow5g867T01coqjHbSUkzUolrk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/pRu3OKEvHe8DNs1KGp1W/EwXwKYG24CIY0xy1gEsTbhdnp00B72ALVw04kw?=
 =?us-ascii?Q?bK46c3pmwbzPtRd5zHCYcpFBPxTVEolbnRJVViPe2udGKFE2/Gu+Gzi8Yq/m?=
 =?us-ascii?Q?Z0RkFBRYXS4DzSxjeYrqTzPUoviarTIxuzVP8cSkejT3t61Tt1/YZTk7o75K?=
 =?us-ascii?Q?agd762M9Zl+YHB8+N72LlBq4ch/kdbw1zi61Pd76zKKnunqQNtd7+wGpJTuD?=
 =?us-ascii?Q?MZoV/cllmv8aNPAE+opeaTFZA3Xu0nph/h1LrxMiRVo3YtSEOU3pqvGttywY?=
 =?us-ascii?Q?hd/c45X8ssmxm4NJWC7ebZQk0BQtbgrZfZW2I2Ft5OsPTRJn9HZPgDnBJmKs?=
 =?us-ascii?Q?iCxYZ22zUDn7ikaJUzlv7dJiLRxGnUjeLuohGHP9s6q0YLkMLYRvV/gkFxT7?=
 =?us-ascii?Q?bC/yGS3UTjL/qCz9p0EjEzxKVBkE6NmT5hYHTYUdZMYzptPRHKDq/lx+6TEh?=
 =?us-ascii?Q?w7NhE0e76HMZS4Y920ytbGPmtUw42Zcu3lNn7Jze1/gGjaK123RmjJO5jqcA?=
 =?us-ascii?Q?XMbSJ0p9piQlbcgJhFmSyfXDOhK9J8WCrjD01vHFYBC9y4EmG4pXMixYVSgg?=
 =?us-ascii?Q?POi1E2HUYo/ZHLq191tTK0eGjGS3HxQchNDaGSd9VypbIDOtrTJkgGhBVzSL?=
 =?us-ascii?Q?Zs8lgo47hU7PpLeIxF4wDIR3Qtxst7e33p7NwjXdBD7xnLjPhPRMZ7GanB5O?=
 =?us-ascii?Q?YxXvk/Z34LLS6cHVTh2wz1+uoyQcUoWV1Flf1Ngp2jXbor6BVvqlPRk/3hiS?=
 =?us-ascii?Q?Od3PyJIoWXX0R1J64TIyuMGhKKoUVdX0/7ODRHDBe+XV1XR3Cf1IANvshtTO?=
 =?us-ascii?Q?2cc6BCVZTCTI3KMnq3YIgZVbADhG0BjM9DlDTJT/Jxf4i3BEODPmzr7iUJpM?=
 =?us-ascii?Q?q4aHRZNe0oRozmREvcC/vCzFmk8zWzBMvpJz+W4446GpfENYpi6Wu3zUk4qT?=
 =?us-ascii?Q?R6oyg/x141+sdL0x6PVa4mq8tijOTY77aknNPb9PDoqed9fK0oNTEKF+D2Mv?=
 =?us-ascii?Q?69TVSclkF7nHKDxdeu6/N7GXhzOgtXU9lGLSHPpEq32Rxysfa/mNre58xQCO?=
 =?us-ascii?Q?ZQ1nEAgrUTWKDwhez8Mjnwn/Z1nkACOSQD6/uUnyYIju2dHCiTknIas5DAFm?=
 =?us-ascii?Q?QVgcTfliSNNBKWbhPu5U+4u+JslPRiYqc/fsSvdXotMwVEeRTysqxzs6TyzU?=
 =?us-ascii?Q?bvNJgPJYomXuz1/957S6ZmYDH2g62LXZfVfY12wDAGSnJg+fNLiXRvU2cmlu?=
 =?us-ascii?Q?XPzKKsZXZNKE/agECTp85HkODxsxqkP936cgFMf38Qsp/QTLLHms7yoxAf/Q?=
 =?us-ascii?Q?yFou9BS5dZMV3bYaLMBEz69wh0H0eqZMBG7FOo3UQUjAOvxBPKx9U0TbQyRW?=
 =?us-ascii?Q?KlA4xqKzOnQYjL5a08SNWPnT6OAEjlFvWmjG3mMJdDvIiJRKStjqZjeIAcIl?=
 =?us-ascii?Q?q/LmmL7dGZAhWibnWEXc8KgJ9RksgUe30kycwrv39GqfoT4xyLpLZR2BZn+k?=
 =?us-ascii?Q?rlnXLL+nsTYu80SEsBE7caGkNFE5rRTubLHm8GuTtC67doH4+IPT2dbqJhfH?=
 =?us-ascii?Q?QLKOrrx7CI0Sl8NmqHySy2/eJJkW2BWE3FnBXG+uHBOej0hoe2OjfqtPyjTX?=
 =?us-ascii?Q?3hd+ngVJ7nPMt92g3LsZk3r/akB9DQLpSp4s1tdHCK8BCUpVT2GWxTjdWixc?=
 =?us-ascii?Q?JLJ2mkYfadsqOviiICL09SyiubGUhpRjqod4Jr65tXRNWLDG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1475342c-d895-48ad-07ea-08de93e5f917
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 14:08:27.0926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/K5klymPC8+pTNvxXyUhJHIWLN2eUXpElcEMRU70J6yDpArASyaBDLiYXqJDF+N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6443
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233380-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,lists.freedesktop.org,nvidia.com,lst.de,kernel.org,linux-foundation.org,intel.com,kvack.org,vger.kernel.org,gmail.com,sk.com,gourry.net,linux.alibaba.com,infradead.org,oracle.com,google.com,suse.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14A933A3CA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 01:54:13PM +0100, Lorenzo Stoakes (Oracle) wrote:
> Hi guys,
> 
> +cc missing M/R, fsdevel list
> 
> So this was merged upstream, and touches mm/, and even has a mm:
> prefix... but was taken through a non-mm tree.

Also, how come there is no email on lore reporting someone accepted it?

Jason

