Return-Path: <stable+bounces-262618-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jp16GoNTKmrDnQMAu9opvQ
	(envelope-from <stable+bounces-262618-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 08:19:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E665766EF90
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 08:19:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=MPyOZdaQ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262618-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262618-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F416B30DBBCD
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 06:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2817C1DF248;
	Thu, 11 Jun 2026 06:18:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C345F33D4E9;
	Thu, 11 Jun 2026 06:18:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158695; cv=fail; b=N1FjhvOzb2R5UhM4gQwscQ2JKrnO5xA2Eubq0Ot45FpzXDBm9sg5e77+rbNwb5c4qizQbcOdkN0sp7h4ScH+9WpIht71eBVZsUNJBuECl8wbPR/5rUpMU+JpKchlpEZpnWxqUjONB1ing1Yb7p9X5kAVZH3XfPctWHGyCba6cqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158695; c=relaxed/simple;
	bh=mLBSG/kcSwHoi4/uqe9tAjIP8yRVMk711Uvt6DqiONU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rpGJBYSd1lVy7CGVQk/vKifMJjAdZXLSJpDDb+dTjNHUTN9XnJLIEbEIhcu1J8rorIZHyFn9PMKHzgsHjNsx+U3jH55kAS5VfB/s6s05qM6EGm4G4BKU9Kzl1fpxVJQLzD0nek57TM62R+2PD2Vx3Sae1jGwYVI+ImaAH/cy6eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MPyOZdaQ; arc=fail smtp.client-ip=40.107.208.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQMH+boY7gpNoPe0DodiXBx4BvCl3lhILYtrO/QCdrIK4hDdkbMcS2GvyQHHMul1UH2Igc1s9X4/UId6B0OvF3jAcCmaYihqeWbQe2VM4VCEkEOK4GB6jF+8mZ0wxKET9zvyFNKfSO3hpxiYtiMdsi+omoSsF6Mjmmvc8zuAr2Aln6xN8yIm/FnF4blQXBsOfMBbUqmBWvvzHc5QQYuzJn/FKICYr6uzKU3sxw0UufpiB0N5sftgOQJcRRzVxq0n9yDJ4spFzoPnwGyhTF17xiCNkGbYzLxjycp8oUNeTuYxax3mmDrCFbnHJI66OWl4weq8RH0PtDds5dS6LKFtaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYr6CWVaqP4QkR83UGk2GnVgV/5YbaNortM+Jh//07k=;
 b=SI4ccCRKQxWYlboY0yePhPYPbD3jorAxHcdUKPbMzClaqwIlmsb0ZmtDawtH0GHjqdfvPRYKdRBVG//nXtQ+cS3SPijhmaWwk63vbL1uHKR2/U30qfN5IamM22yNRHJQElVybe1EueH7axWu3lxe+mci9YHjBiLgUbc9/BkKHfkb+PMiywnd4kDMoM1QzRLxsythz3bUJ/EC9DFcRBweaYKf1Bqdu9azdoC1efkj8O5LK6gyqDZFFXh0wR9JuU3M2V5KOuFfCJeSD1Vtujn8dtGzNT+ek236/0WwrJfstKcCDTXUrh+cYSjnoHFZAVrZgehi2jV/1sG2rNABTi2WVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYr6CWVaqP4QkR83UGk2GnVgV/5YbaNortM+Jh//07k=;
 b=MPyOZdaQq+RK85ddLQksWU4FOsubvqtRnDYmNVCyQ48FPKpgT6zapgykN+nUYptcr8ANmDt1kmGzoNnip2RX+pmmCihOdJ67gt69ANjEBjJcjM88KzxaPH6voJEpcuKGsxLPp8847LL6zLEuR1UYjBH6rqKX1nqSWPosfZ3CA7uCwDIFkxWnaYLbC/Iw4bTV1cYYQRBQEAVmTHjmQ2A7VzhJwJJCKhHJZGmuRLx7zha6PXtqjlZvMOMbPl3bpDCNp8W58VsrKSeDove4OPCRPYU+5Y5tRgJvnKKrnBIuM7VC6nUeRrKNZ6/Hx5bSo8GQ8TuSfjGc1NnqJrhwYL2cOA==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 06:18:11 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.010; Thu, 11 Jun 2026
 06:18:11 +0000
Date: Thu, 11 Jun 2026 09:18:02 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: petrm@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mlxsw: fix refcount leak in
 mlxsw_sp_vrs_lpm_tree_replace()
Message-ID: <20260611061802.GB836457@shredder>
References: <20260609084730.215732-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609084730.215732-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: FR4P281CA0330.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::8) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: c3498068-975a-4e4d-f65c-08dec781368b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZiFojvmXB/hhT614oS7z67mXRTwuuihr4/Fs+SkItLd5fhZ/LjlNwp6zPRstP6Q7CNyMoD1/jgkOgKbjuhapPrrZDwxOlmLNFHu0weUtVtVp+FBvyjYFXw4pkXvILYmA8ITVndwC0SGv51tkZqXsyPDBM3ZWT8arkVwTlkN+WYkQT+Y/QaN5Iy/iE+M6YLzr+q3CaX7oChcGgjgkiRuHx9AGy49BhO4dYNn1idZ3dk67HjZRjUzCEV9Dj6cjAlimaPzb78cfcmup4k5fhiQFUPvC2PhmM4mF0mWo1q3k8LI0kVAymIvgtM2PNBNjWyO76KpmAXRqdoXcU7f4RnAWVCRhhXloZ5mXkmw6dsVGYDHv2bMY33LjG2/hBA0qEcJY3nfmjP8x/QySaLJEVjIncxk7s6WcKEvkOEAnupG0ZY2HBULX1gwvHsc2pO3QJxG1LuhFSLUFqNdkl8FhNpsBYcf2n5Ci+c6BSTdK6lI2rrawG32O+EJiFEe9emWH3FDI7mREi+Qc6Lv1B3MbahUYGbtafhon26Qd4vlDwaNkY1ATB64JrEEwIcR1+N3o2ufkay9lUBSdSIvyWvu3pFjONtuMBxRa849uPxolQfrjWegPOemBRUFNC4atKP/1yJ/TAcyBfDnViCr2oY+qW6zGsSUfG/AJ9kLTXK/kXAw94d6MHOiXtJzOlHuq/G4dMtia
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pskkck1SXDT1kd1w4DSjc7hZjO7oFUE8jHnrYZtmYZONsk1LrgflEhtf4Uox?=
 =?us-ascii?Q?uVGhbWRD4VYXvcn/P+/WMEf6te3Zk1kKSS/3V99boZGhthAQ3hUa0OCXBrBF?=
 =?us-ascii?Q?r9KaJ8Nq1zU6D6UG6jIwD+nddpALfhADUlQqEYwMwzWSYcPMNgqVB4goT994?=
 =?us-ascii?Q?Dcf77bPx/Jx5I6VrNiwm7lh8l/+9gU+IRpL/f+Bj29/XxO/ccSc0Pgj8GBRZ?=
 =?us-ascii?Q?rK0GmVCRXMmT5chSSBoOK/86L3SKiMc6ynbZ1Gin5V4trs6FIPw8nzPzygTF?=
 =?us-ascii?Q?0zZuvuacvW6sbQAStA/uVAOqGo8FlMAUAMKLRSTrnjansYUnheiaW1YGUFpa?=
 =?us-ascii?Q?CFqi8xUA+ZON++NdJGEI4OHDwGjfA4HHN9KQEd5b3T82LGpwHTPvkIMLk7gj?=
 =?us-ascii?Q?6ZFy+f+RZT7TsOLUTxvh/VfUyPHuG2ntXN2nQKR9Vb/axZkt0D5tyKfCAEOm?=
 =?us-ascii?Q?bS6e9TyFkIHYr8C06EsU6Jf4TIlwXjM6ysLsYQcktrLyRCTgapyUMTQV4wMD?=
 =?us-ascii?Q?2n4DkdgIBuHUXQ6pf8dzl8zcWRAtDeBqssjXwj/SK8d5eDrNOO1p90J9u4xr?=
 =?us-ascii?Q?BWk2n+2SIQhbpotJB6lUStqNcNPO+kxVyI9cwKhzHDIrqc8SB6HiLU8Izk27?=
 =?us-ascii?Q?ukhVlIGkhgRJU2iiLQ8efw8ldhxJ/yC+2Fgk4rFM2uk9Xz53Jgr4zUQr96zl?=
 =?us-ascii?Q?X0dmkwPU6lAriugdfwWIBqYYNJPgajMWpJSuHClXbZdicw2f1EUu0Z6jQIvD?=
 =?us-ascii?Q?c2l23onNbrk18MAoKvMeTOmVVktBnTnM5CIM4mNALHLkF3+pkSP5QCadKHYh?=
 =?us-ascii?Q?mBUxo7l0gqkQiGcMlj5v4jCTLPEBwF2TYzjFzWWz/Px0aSEpzZUKTNCqx6sn?=
 =?us-ascii?Q?53/KvanHvKGhhUr+EF/0voHvkgHlofO3kkrxPyPn5KCAgxLLJ8b/llm9VBtE?=
 =?us-ascii?Q?m+uFyZLadPwW0pvA3qhA0EoEWoVQXhsPl6JCUZidesLP+rNTr6omn9vSsU9v?=
 =?us-ascii?Q?jp3UYe0hhM0Rp3GT+iN35qnJZctIgY2BI3l5w3oCI4tpDzRncRL0yLaHcKvj?=
 =?us-ascii?Q?sB7SmXWqgAC25tnVySM6hRXr9Oe5VJlaI5ydpAouhm186kiMdk9KMVM+BBhf?=
 =?us-ascii?Q?Q9Lba94uEI60d2KvAnvu0bpDBp+1cl7NdxdXqovQ35Q3w9gMlaBsyB339X7Z?=
 =?us-ascii?Q?k34+237QY3tQ4nowoYF5FpwtCeHNdMiMw4n4Euv9qLV5bXrTi4XtCyWEYTiZ?=
 =?us-ascii?Q?IsXIekZD4umEBA5L6KujpVa4p5TEVAPBk4gBrikPn7SOsXBEp+d4CO2DAabH?=
 =?us-ascii?Q?E1YU63erWeFNwTdrypGrpFMQu9uVRgKyChlHJSs0yEAHaPI14/UM2sh9PbBJ?=
 =?us-ascii?Q?piK3JS1GZw+fYdel7+2RWHr6pjvU+41pxtsrkz3OfGONfRnX46jaXiA0a3P9?=
 =?us-ascii?Q?iN3ml48w2Jr0d7GLgrpTy2xw32Dknb8cEND+1xrWOUMM9G+Vk89gAvFLXUqp?=
 =?us-ascii?Q?tSBp3LjgqqqcqAVv/H6VAD0JerXXs63EbYjab5mlS3WWq1sK6O7KeK1O3Dfj?=
 =?us-ascii?Q?aGNYf4IESiF4k6iUQph/AwV4S+liBtydQGVCxE3HSS28JZtMSLgQxY45oPvo?=
 =?us-ascii?Q?YMg/CnKoyPF/QTogdAWNYb/g+1773cLb9o4oWtHjDPrQ0KTAv1koffdsEGfX?=
 =?us-ascii?Q?O8heZJHt3ZMkYh1nMiLh3ypdrdv/dnRzXgTwljAZaBJqIbbr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3498068-975a-4e4d-f65c-08dec781368b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 06:18:11.4008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFO5iwofuNAOBCM2BgLiuvUZzwAScGeWPIVS7+M6lN9046aNCjY9Ddh11upI0RPtybbaEkWEEJ7Q4bfkWrwr4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262618-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:petrm@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,shredder:mid,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E665766EF90

Same comment as on the last patch regarding subject prefix

On Tue, Jun 09, 2026 at 08:47:30AM +0000, Wentao Liang wrote:
> When mlxsw_sp_vrs_lpm_tree_replace() fails after replacing some VRs,
> the error rollback loop does not correctly revert the preceding
> replacements. The loop decrements the index but fails to update the
> vr pointer, which still points to the VR that caused the failure. As
> a result, the condition and the rollback call always operate on the
> same VR, potentially calling mlxsw_sp_vr_lpm_tree_replace() multiple
> times on it while never rolling back the earlier VRs. Those VRs
> continue to hold a reference to new_tree acquired via
> mlxsw_sp_lpm_tree_hold(), leaking the reference count of new_tree.
> 
> Fix by reinitializing vr inside the error loop with the updated index:
> 
> 	vr = &mlxsw_sp->router->vrs[i];
> 
> so that the loop correctly iterates over all VRs that were actually
> replaced.
> 
> Cc: stable@vger.kernel.org
> Fixes: fc922bb0dd94 ("mlxsw: spectrum_router: Use one LPM tree for all virtual routers")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

