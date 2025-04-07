Return-Path: <stable+bounces-128775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA00A7EF42
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 22:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7741716B17D
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC0220E31C;
	Mon,  7 Apr 2025 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iS2ZmAgy"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39B82116ED;
	Mon,  7 Apr 2025 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744057446; cv=fail; b=m3nqM805aTyQVMxKfc5dZ/kYEDYhXyciRmmFrMbBdAUESu/Nl+NeNs0R1SsKrLRGOd+d0rWUKRu6IwrDdNcSc0i5N3WV2Ubab5FiSNs5QTcLjE+/X2nZ7XFkcSU5rOJRZ+cQfSET00DL3QW+AH/UZsENmV9/XSG8gjw4VC2wMTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744057446; c=relaxed/simple;
	bh=rpzyBDhcJGMvyRutBGGF0u9+Bt60VDzucniMK5RuTws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MxIW4TsFKsUtHllIz6T6Z83kdYl4ioJZgd5aFNHKQKHY7Mr1eZVu45gzAJVY9gpT9F1kn4pqJVWSQKxuTHCFsO//kX/WBypDrT/taPHHLYzUCSKb0fdKAa/ZL94THFLjbdwk71aJyBV+ICmviKVYX6hHnODngj5ZyPJqxSGugKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iS2ZmAgy; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9AV7w4VC8c1A6SNC/jubavuA/lOiykk5LVK7k9Gnkk3Tuy3jEVtPZyjT7cduTeFGPe73olttUQO12ft3t1Uik71TOTNhdguxGyxvLwcrb2Zv4FZv4nZmE1n2YMQsrhck2SjT0P1jrq4erHL6/KVi+gDh4STRF4IaWu3C7kVef/HA4uc91fOabjtElRW3NT8Ab1RqO8T+6bUuyQCN87G20PKepEg6hB9FxwVQGeI5jSxEi+uZe8yaynt8ZKVOvHDycDokx0MOzP2zJ61d1Ajg6IB89cT+a79+SMzHUyOi+7wu02Wm183B5hJX6NV9auLGB3/LVAlxhmPv7BfiSaiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aaw4dgmvnXO+BIVgfKXiPQzAqTaG2wskN3ds+K1Gb6Y=;
 b=KvUEPElb0e4UkUIvP84W2glCesF30tQFykoCuGkQoj4u59N98udbyHrRBS34gnnPNRpUwNkmHYOBJC31I3OblYHm1RGnodiiUcchfQn1mGM84NKr5lBaC0XmhLZvgGAVjKaxDssa/4V+/L9iZbqvvj6GObvmid/z3O3n+/EceP6lG9Asy66QxnoRPmStTI9cC4CosheWu3VncAfOm2LI6/uXSkZ5EPiAR6+CgBC77UTvtjqSSysXBn8+zDh39mCGFyhRP2L1K3jCRnC3wDHvIx/xYEkJeXfvbDvnWZYw+IOvllMTo5LLzaX6DaHX4ouJxaLiZiTuvOokFF/nOxKl+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aaw4dgmvnXO+BIVgfKXiPQzAqTaG2wskN3ds+K1Gb6Y=;
 b=iS2ZmAgyfJ9CXFTK1gw8dlaF9SYh4rZtnzk5B0FT3PmAza5SMbu6wj+EAPDLHGGsNk6g+lYLc9nxXUwdMsYRYqo9aTaSm5W1k4yu/B2g/puXgj07BO0upTgS4jeYx9vqtSW+kIzDRKAnVJLYisP4VNCN9SwpLF03BuRPMm+tVe8qYe+yOtJA4L5SQR2LgsKKZh+Zfu4UzkNbgmsaUqLxxuzyHrkYO09pNo3b6JY8bEuw2UZwwFaEBosAtzqGvQrF+BBjTwPBL7cZ60XPSImH6mYmUUoVnY1blrU6Q9i9gl8z3GMg5kbfQu/97PTVom4a2RU0ENiXfNsvPAV+1kzCNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 20:24:00 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 20:23:59 +0000
Date: Mon, 7 Apr 2025 22:23:49 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Breno Leitao <leitao@debian.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] sched_ext: Use kvzalloc for large exit_dump allocation
Message-ID: <Z_Q0VeRgMRJCvYnh@gpd3>
References: <20250407-scx-v1-1-774ba74a2c17@debian.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-scx-v1-1-774ba74a2c17@debian.org>
X-ClientProxiedBy: MI1P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::15) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: b76d4869-01bc-46d7-8b20-08dd7612211d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oPPC/9IxWwxqH5+9tK3Qwq9vIB1Innl8tLeve4XERCfQ2yZIGm/7RzU1XY9b?=
 =?us-ascii?Q?SJf8EV4QtxS2I/C704AVIpXWv9zAg8wR4Doq3XedyQE1b8q4uX2AMmrELgL7?=
 =?us-ascii?Q?Ulj8GeqXgNbnAQl9cWznVfIG7s+Yqup/wXBixqIJTWXN9HlFvsNcVjE8YBlz?=
 =?us-ascii?Q?y9hom5wU/ZzPoldbQ/0kZPhdQppMF+diH75VqCEuO7ieLAUE0i8hgC2oCYcj?=
 =?us-ascii?Q?gHn1BzVaWzxYCQxGqaOh8ulGktEcmyqNyx5g6RB0+ir6ucBEAYYmLHpNFUSr?=
 =?us-ascii?Q?XRIunJczeret4tE1zrv1yHWrI8NgJe24DcI699+BLkolOCrRtNmM2F7GwZ75?=
 =?us-ascii?Q?lbqkBaBtQ+ARNuMif3KeCXyyD3rIsaQYRedZ1tQKXuJwlgfNn+RD82WSpN5/?=
 =?us-ascii?Q?Efj0YtRqXXsWeHOgiDNlyBvyvXI1wVBp6gz9RF8sHsM96UiWbzWkjthzhMIC?=
 =?us-ascii?Q?tUS0oHNM8zqtJAzSGqQTOBbu+8jFfdBOYixKiIsUncRT99GGLenDgFTxVrE7?=
 =?us-ascii?Q?lUeHSdvcKDTiYGV+WlI8fFygj5X+ct0DVdvARVACjvf97EXyIhDFVe3MLkel?=
 =?us-ascii?Q?DuS11+80YZhK/fdaBvdgtrtaKcdnfAsKd3+RsMMgZKjQrlUkj8/KXSz3BH1j?=
 =?us-ascii?Q?LQh2aVj24v1oBRpLlNU3uquR3lNrZbCj5JLRx6YXyCsMXS56FNPcfFlttk9A?=
 =?us-ascii?Q?JeCDi9J6+2He/O8J9bWwytxN9FayXh9uLJ6xL6Ryifah6AEbETDZPVcVXhrb?=
 =?us-ascii?Q?3sSGiORDVdj3hmP9hOGFfHTz7pW2tHsYJ+zQF+pjBZ+NQijI6sVDDVXsu1/0?=
 =?us-ascii?Q?Dyizmgx5akLbItQcaoaQYJXqj6RbbTQOo8H9FqhFF0BdFYMA/qM94nVqYBWC?=
 =?us-ascii?Q?91Yf0we3erEN18XVVehZOzpOp+bjCJwqFPMZ4Te1TMlAidQjT5X5AcZiELnx?=
 =?us-ascii?Q?+AKQWlaZvMkh0ai33ZvFJv+FAo6A7oSXVUXnmrjtbahxkmUGR9jWquyqbbdH?=
 =?us-ascii?Q?htrXvoMuC0H/TEfJ34A2KEWuoJfNVXiD5Dm8mAsnxvXCkw+RunscT8YdKGHK?=
 =?us-ascii?Q?r6Gt/znTH+yr3s4HWlIwEca6vMAl1JOwFOtlVGNAdZxtXuTKKGXw9y0bOvcp?=
 =?us-ascii?Q?GkTWOTIcjvUWqgqBFnN6HLr1A6UsjsUPv3ewbSFhZLJMR9SnWQEriVJyWJhe?=
 =?us-ascii?Q?OkBPM6og+fv/3yRLQRiIlLiDAB2HRu0COl7Dd+kTew0Em6wraFq6DbX8F06Y?=
 =?us-ascii?Q?ITouhhWh0oKx0UM3BSXvmBBRirnmEPrLKjSTgH1oHeJRiXHOoFxqK6oLex/d?=
 =?us-ascii?Q?0Qu/k6XkcE/K/qLhLMaLK54+N3lrvsstozKmPMzf2OQHnqyqKuB7SpTAd7aL?=
 =?us-ascii?Q?vg11in/r/3kjJQDz6LTIYOs0S76d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lj92N61GDCwpcjiD/UUYyT/BAshZ0ho8OYewVbKrIxnin56RMC/LaQX9HVXY?=
 =?us-ascii?Q?oqKR04dRGdLv0RUU+cilTQgc5XRxukUBRJhS8n8bJn+qwazSVyrohihi62En?=
 =?us-ascii?Q?VZRDg+U8LRKv4P2jMqOC0dKeG0pF1CakSHXImp+gLO2rskaIV9jkTWhgoyZ+?=
 =?us-ascii?Q?jgrvezgq1DtOJEbtGEND69gr7hpCYsRoWSRPErTmZ6brRX5Dl88mLaHktuTL?=
 =?us-ascii?Q?1XZVcO//i3Nzojcockw4ozAzjEPu4MD6hcLc33Oj8i5Yr2I7Nif05ejBxJHh?=
 =?us-ascii?Q?E0OZZiYLZI0PHjRlpDARvwQdDArua6qFKyCT2w0Ee4ypq3gSwRHS9ChRo3s/?=
 =?us-ascii?Q?D/KtDlU0+Ddpg9AeYszhl/UoyiCHXc0Afw1REpRCMEFtIxTtsa1A89DiAA6W?=
 =?us-ascii?Q?knpbOUdfoSaUuVZ67knfN/opoSpzRk/Hky/2MwlFjIQIqREzZWC2V3otqSNi?=
 =?us-ascii?Q?2EDU3rBmiptQB9hNz4Q/yV1vnpHSA2BlPkUpAKrQYWlRIUn3YsUN4IGcnvDH?=
 =?us-ascii?Q?N2PutGQqoD44raA/S0ehC3Efrzc82mkDr4AzuRY2JGSDrFUROwmbz+cTzEiR?=
 =?us-ascii?Q?c7OoLL4H8bh31gbYrYWwQ6LeRB3itWa/xMsSz1OpbAVlbe/mjlz6IlsRKsLf?=
 =?us-ascii?Q?k8wY4xx48SHL+IS2aIxJt4IZ9z9BstuxSTFPCjQkYp/nC46/qHYrmKtxzhUI?=
 =?us-ascii?Q?/X2xs/EaXgsoOpyzmn1jACbnzQiVfUNIhaTIZtJUWgns74wKFF5LN0AguwCL?=
 =?us-ascii?Q?XMOvMAzIwKPyxDLf8WGkSHPR76j/ijWFgwl+SifE9CBkxlFceZgiPIbCYKAP?=
 =?us-ascii?Q?fRM11WQq9EMtmgamKQsV+YQ1pvZcO3tOuRbcp4uiLDCPBzaPVHtABE05WPd2?=
 =?us-ascii?Q?VNn+Tbp6ZXjeHfMHAUOHzfMwO6cqRAhkihPCZ6xr+wHaKVNedXsAlI1QJlAf?=
 =?us-ascii?Q?7g7G3dR3NYiZWF68KOTIfJP6uOeoT14qG5jdZC5P2pPOTSZhmd9udyMRBy85?=
 =?us-ascii?Q?M4xMnD/X+gUrxUN+bk7PLeE6qDQRekQ8ljC4Tx8orMIsbDN34++R1EBxvZ6p?=
 =?us-ascii?Q?oVklm/xxRuOVqIXZiKTtC9CUVThYmDi+fZ5WLvHokaCAac/MmhQx8skQvGtS?=
 =?us-ascii?Q?ixLVyVPWZcKMNngQ+b1fHvM2i9qdv4xxda29YyXRcOq8seRbrsX93+URcJk8?=
 =?us-ascii?Q?aptolr7/mnMQtj0zKOZ/y2LDZzRaP99CEmojOawUHUrqvvrSk7O2xXNeE2JY?=
 =?us-ascii?Q?SakYoJzApDWpzVnNuuHiXCePP4uEy9CfmyGxA/lVNil45pEDpEsDE0g+1agv?=
 =?us-ascii?Q?OrtNuRJJrjGq6ebRh3nhluQrl7VLwpIibgwYgivZCCrbIRuLQnlefvBCSsec?=
 =?us-ascii?Q?eFdmA/2LlpAWqY+E8nawyZ58uUqWzZ3hjjKsoeRgJYFuTUK62/OgsRjNaXrs?=
 =?us-ascii?Q?wuy6GZQY3met2rgkoqmostKtISSu5TCvEnvaLCEbJX/ZeLi8AmrHGXqS3dJJ?=
 =?us-ascii?Q?rJcmbe4SFsuvU3FIhv7jr2r86/6qUlz+caQfY2eyQsGFTlnOkTT21sNz1L69?=
 =?us-ascii?Q?mePKdoHOvZEgwDzGH4Yb6syJgUl0ZFgrmiiTt5oy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b76d4869-01bc-46d7-8b20-08dd7612211d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 20:23:59.4746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmGUPBjIg2Ru+knPDpGx32J+3HAVebaeiHNkEI8WVvqt9kqR52NZ/o2l6ilgmLYghvjnQcgxhPxBYyABwp5G7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480

Hi Breno,

On Mon, Apr 07, 2025 at 12:50:29PM -0700, Breno Leitao wrote:
> Replace kzalloc with kvzalloc for the exit_dump buffer allocation, which
> can require large contiguous memory (up to order=9) depending on the
> implementation. This change prevents allocation failures by allowing the
> system to fall back to vmalloc when contiguous memory allocation fails.
> 
> Since this buffer is only used for debugging purposes, physical memory
> contiguity is not required, making vmalloc a suitable alternative.
> 
> Cc: stable@vger.kernel.org
> Fixes: 07814a9439a3b0 ("sched_ext: Print debug dump after an error exit")
> Suggested-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Makes sense to me.

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 66bcd40a28ca1..c82725f9b0559 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4639,7 +4639,7 @@ static struct scx_exit_info *alloc_exit_info(size_t exit_dump_len)
>  
>  	ei->bt = kcalloc(SCX_EXIT_BT_LEN, sizeof(ei->bt[0]), GFP_KERNEL);
>  	ei->msg = kzalloc(SCX_EXIT_MSG_LEN, GFP_KERNEL);
> -	ei->dump = kzalloc(exit_dump_len, GFP_KERNEL);
> +	ei->dump = kvzalloc(exit_dump_len, GFP_KERNEL);
>  
>  	if (!ei->bt || !ei->msg || !ei->dump) {
>  		free_exit_info(ei);
> 
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250407-scx-11dbf94803c3
> 
> Best regards,
> -- 
> Breno Leitao <leitao@debian.org>
> 

