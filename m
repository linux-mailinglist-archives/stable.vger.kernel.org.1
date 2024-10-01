Return-Path: <stable+bounces-78493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB21D98BE18
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 15:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5B3285800
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440841C3F0E;
	Tue,  1 Oct 2024 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ThGS9LBZ"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F11BFE02
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789935; cv=fail; b=rrMZlExvT1BPdv/D1PtzgQ0D0B+xjTkvhXpwdGj9qkf855/TZsvB3Urdkt45DMCA8LxADvQWaHW9zslbYRzyyq7lSeqf74zcIJbCLZ4dfx/UyfEes/gvKS3agOlAZWs09pJ03SxV5XgmYUW/zAMI3UbKyh52VYfdu66dCpWGrv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789935; c=relaxed/simple;
	bh=FVf2h9MOsuRzbTkQWD3xChiPVBwP6D4GMMDuvHnHaxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JoZJP9DGW6knKHiR0+c5GGMNU4WUVBzYnhWwLePoXUEcAft3ujclzwkiw/hwb8GGa4IUD8Wx47B+Io6UfJAh1OzEfihS2UAmkQ+YSY4X2Ut3uL3NYDG3T965EDCZ9EwskYMx8r+qyEiZYkhza/j2fRnz2NYt76rmuAfLkxA6iY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ThGS9LBZ; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KG8Yr5Keps/5pLhHwbdxdque9REHgUMDi0OJuLZMxh4r2I6R9FWrjLjyXGgHOiz2rKiUi96JVQFQBmG0dS1nQpiQxXZofIsBEVaB7oRt4ehPE2Hs0PPjf16p3CkTlqcSFi8YNEipX+JMt3anyOhQvam0rZZuUSwK52XxwTJ2i+bCX8ENSt6659UrTvEE0HKtHB7GF/vevye7VrNN1MvdqZMIk6LSr5zx7Vaq18G9u0e0X5SBCYLQ5w0g6XP9RA+XbInycDid0ht9ilDWjo3Mp9k702UtiYtQH8+tMLtWaZEk4FB2fJDRu2mLKNmrhcDTq4Pi6opcNEgj7p1RZG8ONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6Y1nYFBTMNgpSRpxkSd831hjPcgv66BleQ7neVGHZM=;
 b=mQVfBN+SxZpeS7pqtwbihefM8WrT+0h0o2aWHnRICAXhKeA/QkjjInFlN7tBsRg3kisAsjLZpTlMe8ChkYLP4aPhb8q2rk2BlaKVOX6dcV/E08RsM3i1Afn37CW17capp8zXil/Vx8DqpvNsKJYGF3IsuFucxTBGa6pKnKTtqv2gNuYEzblPtX8gr5fUEJX0QkYLrKPXFCKcMKSSLFwz/4ayi0CHlIIW98FRwkZ4wQiFaUfQNXjK46BqwBUGakTCogUOZAWH04Gp5y2EqGkWRbaISzIuQPtARrYARJ/VdwLJFzuGf/vmGI5o6QpeT2H/H2KWumKZdmFJa/YMJDW5TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6Y1nYFBTMNgpSRpxkSd831hjPcgv66BleQ7neVGHZM=;
 b=ThGS9LBZr0p7KXt1Bre1PWdTK0Zu47u7XjMhs/2t09hLDWaQPgMi5LoYJ6uIxGDuXD6A/GNvwBb8gKKaEaUBhicq97QmaMlqU4GEslAW9OQkY7lBO0M0z9VVGcgyfuSc61v1JC5F2mRdhDGKDceNULttEVa8TL4TlOQixHDwg6pFCkry/b9udAGOMFPzI8R3A7L0ipa5ONbrlV8fqBQgZqBxue62rKYjNU0TR8A867paotqxhxOfdSi4Z07WjyDRX8W9KjTIrJnl/j7KBgkuzt8ht6m8RiYrYE7bYMhskjr9Ow/77rnHd97uKv/75Rxc8FZJQcqQMsxpCS8/nFC2Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 13:38:49 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 13:38:49 +0000
Date: Tue, 1 Oct 2024 16:38:39 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Greg KH <gregkh@linuxfoundation.org>, jiri@nvidia.com, kuba@kernel.org
Cc: stable@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, sashal@kernel.org, vkarri@nvidia.com
Subject: Re: [PATCH stable 6.1] devlink: Fix RCU stall when unregistering a
 devlink instance
Message-ID: <Zvv7X7HgcQuFIVF1@shredder.lan>
References: <20241001112035.973187-1-idosch@nvidia.com>
 <2024100135-siren-vocalist-0299@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024100135-siren-vocalist-0299@gregkh>
X-ClientProxiedBy: FR4P281CA0277.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::9) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ea6deb-c72b-4c16-0bdd-08dce21e61be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OBvzQbmc+Y3KAVnrZCC1TMBNoOBf7FkpnYagm1GWezmQX40dJ89aij8odiXP?=
 =?us-ascii?Q?QnRYPs8xgYYHqqRpDKspuxEKeL5a12RjRW445zWX8NYmwumMcZFrUD9m58Qs?=
 =?us-ascii?Q?FRJWzkBVjqRiVe7yNhwxCxDt5JS496L5eNRfBOnmY79MywkN7lls/Cy2vxu8?=
 =?us-ascii?Q?KPBhDKpuJMMOmVxZIRMG5X7qXD3FFoFH7AdmRB2cWQncpURyShOF4zzABPCr?=
 =?us-ascii?Q?MRkrkI7QjwAPlNezvSNrMzRbTpzocmlQ5hEQl1L1A2Iu7bV2FXg55+8d+qA5?=
 =?us-ascii?Q?eHTks9yT8T57WT8T6J40Lp2JM+Ve28vbYksmaTi/Gb7hbSMqSPIxqJO/0mfi?=
 =?us-ascii?Q?DxvMqdpOyyHO1EcY2SWCWB5Rw62m/GqqldjVJiVv1XE3F+u7NuluBdvcgl8v?=
 =?us-ascii?Q?Wnk5NGkLUCQcVQmjUsbtl+EFCgQmCQYd0NCYxbm8eym3/7wOo9xG3EitHhZg?=
 =?us-ascii?Q?Lm2A6aOX3Q1WG7rIoYvhknfY/GlihVrc4ehB8IVMpcgZC5f8ZNyVI5U+ZQIY?=
 =?us-ascii?Q?+jAOnrYgHt1vpw89t5LNJzY2ubM0VtVLFB1DGN/2acxitLT7FOfskLgeipGt?=
 =?us-ascii?Q?BV/BmLS4BsC4QRnUnNuFlr8pftlmBjGewxbL6HAVN2gktf+RhpTHn9MdVk+R?=
 =?us-ascii?Q?ldpATYN/enoxB+fAtUDsMW7+GU5KVH4wRmfArAyNfGiyJQsYfkUqHi+ZrDk1?=
 =?us-ascii?Q?HyCHM/XDJbHvaqsio/pNL2fw7PTIa8BxSk4Bf7qsk3EB4scd0+ttzY+hCKg7?=
 =?us-ascii?Q?OQoYYS8gR5eG1t2JYQZdAe2IKAVaEVGnA9qYbOMF/q5Neic7fyQ2Tx/R/c73?=
 =?us-ascii?Q?KN6kwpuu+9tmOjIWyfqmiOxgb0iFWN16X9sMrIdhRh5PMjpglzE9V2JCj+yN?=
 =?us-ascii?Q?AW9xIWEqBnpTmICV2bVYzjnEikn+vobsAAWsjGweDD+IJ+qT0ZkObGINREeD?=
 =?us-ascii?Q?KzVsEBnKrZSRZ/sWZW+lh0a+sI/jJDhezH4R4k8bk4hOwzM8UIBu+vPNGHwH?=
 =?us-ascii?Q?UuD89+vsvZccdagwxLllnE9UrHnWGEhhSXtqZR+8dXzPBIuK5RRgz6UOdwmj?=
 =?us-ascii?Q?WNWaX0SktANg+e9IdBqCoX5ko/FdJut9uEe5A4fGEqJ0cCCZOPH/Lh/YWoYw?=
 =?us-ascii?Q?YvkRxvdg7cqtnRAcH5dIjPBv+jzGAk3m4uupgxlcKAq1yVmf/avQs/Jrvr8n?=
 =?us-ascii?Q?C1Vl9ZLejqg9taGCUgqut8D5QgJvmdXrnjvW4am7i9xotBcW2kH39/l/hbDD?=
 =?us-ascii?Q?JpoGxgLZfc0nWi+aM3ido9f573xrP5STHvacAylQF7LeGheJ0jmZKRdIsqit?=
 =?us-ascii?Q?DhzdSFkEulj18I4nhPunRuRi1EP8EmGzek0dQp0I7YFClw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xSRJrUdP3vTtAn+XrFvoqMbMJivRrUAh89b6nL3y8wfiiO1RzNPCnGd1iemr?=
 =?us-ascii?Q?YMo0imajNtO/siS9gL0EUS0hFeIZyg4sdiXec32kx74Z6IDwrAeG1rKyJbRE?=
 =?us-ascii?Q?hrDiKfeGyMK/EaGLctEw24skWASDYHoOxUtpY3U35jaf3DQxegQtbW2zuDSe?=
 =?us-ascii?Q?vuALSs0RsH4URR59EvvgvRua80y/zmZyUh99GCBGNAfohwZJ30h/nnxNvyS6?=
 =?us-ascii?Q?WySU6yPq1X28Wu/M+zLEkLZsuhR4IJkLSUuVERzN4LktxIRlhAJyOOnSHe2z?=
 =?us-ascii?Q?0lSGO2tjW5ZIpQLQABTn4dtFqlturX0gI9twW3bL/D0xupEA4GM8fXeC9zSo?=
 =?us-ascii?Q?FM57NBk/K7C7aPjzfxtv0Po3svfrhy8VXqUQ29ngDsXh9B2XFVTy1YyjI44n?=
 =?us-ascii?Q?oRFeKdz6dO/MQfSV9klHAhDMUCYWyWA8qox88iSB1vn196QclVrahUePWyX3?=
 =?us-ascii?Q?YYNXiiFRKWu1sFg+JQ4bu1+MXT4blIbuWY84FhyN6nDDO5FmhqA5ma9sAxya?=
 =?us-ascii?Q?Y3KI/dRLPfVrosZh9AkNgg4Bo+VbBby0fNIbKZugZ7KCmRNGr4kN5Si2bhu0?=
 =?us-ascii?Q?Nkx7WB5gV4LLyrzlmWKELWYLph3w8XzNfVDnLzIpVwF12THhTnjsAmOZlmZW?=
 =?us-ascii?Q?gqbSdvNu9XH57xl9Kij7/XVn12RGpevxOtY+HJSfSY1cMzuUQBl4TKUCYF8g?=
 =?us-ascii?Q?ebf+NvRNRJKufNymOG5dQoel3WCo4bMLDoX3rLsY7divikn+USDVsjrwJ1rd?=
 =?us-ascii?Q?h4H4CocljB6qpg2CS242DpKpFOzUgwmerf4G7PT3dCEZJnMH59DaXJMIse1B?=
 =?us-ascii?Q?vO4Ovw4Bqr4ilCEGnjX4OlyX5XSsGHvv04YMnkLMJBlJw+gmSTJ04i+bcvhx?=
 =?us-ascii?Q?cwx0/FSDsca0QyqhLP2Q5xx6uBoYv1pnJdW9KwIBzKQp06LofpWAW1duqmTA?=
 =?us-ascii?Q?zuifvfrnRZOVgWyllfcq/bYfjR7Q9Gg2dgvlulr/8WGYruxE5va5GDZdBU2q?=
 =?us-ascii?Q?mMN+3h7LPUK2qyhDmtPpcVAmh2arZAA9/zG2nyin+qiHW9eGUGVT/MOT5RKE?=
 =?us-ascii?Q?seq3oUqeIaZt0KqmSQT3ZmuAHJxF4yCq4fCTa3Yv1iEASbSJNB5KOV6WlXD8?=
 =?us-ascii?Q?N5aagvbGUBHyZM9a73fslUXzCUMisNgAVMf9Q/exGy7unqn7wOabVmpN/oUu?=
 =?us-ascii?Q?mAhmUnfIbYWeoxdvT0lV4kPs3tQqM6mn1yZD8gsSqI4eOkQo0ooap1BjjuAo?=
 =?us-ascii?Q?SSHzT53LCmuxI76YuZ03xlNyxpvhhIrUovP2njcwLdGTvXVQCueyfnr7lCoc?=
 =?us-ascii?Q?WIYV9+qf0hGogKk7Vsh8tCqRMO/ZDv+lcqbI+KpRZJbxq25rVLck0+wl0gCe?=
 =?us-ascii?Q?WJtd8yrnbE+Aam7ryAImpsxc3QZ8ZeM6gKukv5luLoIAB4yJWu4fXkUSpcm0?=
 =?us-ascii?Q?W7zQutCYf87O59+yRfgKyqpb23E6qZzYE5wFYb111yJ/YIcgIokqBfZUTqUf?=
 =?us-ascii?Q?idejAIzu2N4QelKn9QST2RZailUHy4skcR28Ax8OipfAegnLDW7tXOjTvyrC?=
 =?us-ascii?Q?siuDi5N7WoydO3z8UeaPLK5izbRcMhU215YIlklG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ea6deb-c72b-4c16-0bdd-08dce21e61be
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 13:38:49.8242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNJq7mmLed9DtZ+03SP0+xcuT9vdkW6F+Lh0jgz3VWEp7CphJezYcW3bYA3bauLk7siRIMYkJDsRyY6iHc47hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875

On Tue, Oct 01, 2024 at 02:11:27PM +0200, Greg KH wrote:
> On Tue, Oct 01, 2024 at 02:20:35PM +0300, Ido Schimmel wrote:
> > I read the stable rules and I am not providing an "upstream commit ID"
> > since the code in upstream has been reworked, making this fix
> > irrelevant. The only affected stable kernel is 6.1.y.
> 
> You need to document the heck out of why this is only relevant for this
> one specific kernel branch IN the changelog text, so that we understand
> what is going on, AND you need to get acks from the relevant maintainers
> of this area of the kernel to accept something that is not in Linus's
> tree.
> 
> But first of, why?  Why not just take the upstrema commits instead?

There were a lot of changes as part of the 6.3 cycle to completely
rework the semantics of the devlink instance reference count. As part of
these changes, commit d77278196441 ("devlink: bump the instance index
directly when iterating") inadvertently fixed the bug mentioned in this
patch. This commit cannot be applied to 6.1.y as-is because a prior
commit (also in 6.3) moved the code to a different file (leftover.c ->
core.c). There might be more dependencies that I'm currently unaware of.

The alternative, proposed in this patch, is to provide a minimal and
contained fix for the bug introduced in upstream commit c2368b19807a
("net: devlink: introduce "unregistering" mark and use it during
devlinks iteration") as part of the 6.0 cycle.

The above explains why the patch is only relevant to 6.1.y.

Jakub / Jiri, what is your preference here? This patch or cherry picking
a lot of code from 6.3?

