Return-Path: <stable+bounces-245581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAa/Eo0uA2qd1QEAu9opvQ
	(envelope-from <stable+bounces-245581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:43:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF3F5217DD
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F77D3044AAD
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F623A48FF;
	Tue, 12 May 2026 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rHdV2SIJ"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012023.outbound.protection.outlook.com [52.101.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D633812C8;
	Tue, 12 May 2026 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591899; cv=fail; b=M7FhMb1+Jf6uko2eR/uLQf/Ayah2R2g3lGaLmPTxeWhxkF0WPxCMu/WlVgW6eytr0p9gFnIb7XlYxbDB+KCqPhQRks6cN94AbPAnBtgl+d2trmEUl4pRmd7hVYjFN5X3n+97yHGOXohz496yzIEf+kYObUYIVaG5oyVOvNNqD9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591899; c=relaxed/simple;
	bh=VKgRaXa3c2EqY0xkhZWKX0GEebsJ3faM1WNAr/7Usbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sEvLaqlUOp9FIwMX9zt5PUPiUNyq8m+84TnbIh9Y591Jky5qFPZoeyoVUHsTkckCBwsR5WhfTq3HTvPlhUidrNZ1g8gKQ7HySwp1/PtW1wOowVRvaAHzsJCc82Wsnm8rjy0cB2baOWAVYFXKuaTqxoiTcygxZIpG5chrkGOij/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rHdV2SIJ; arc=fail smtp.client-ip=52.101.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pauzWEVpJ49jijlaav/AN6CnH34cG3EmdxFcTugeQjnQG8QVknCNg5x/uJsI4SumbdT2ILo2Ez56k9hh7ZCu8s9y8T8vtHZ2TNmaXTJ/c6sMO9QOf/hcwpmtiuWb/zNsY2LSUv+Qxv9dgrerxAY2S6NjclRTCpVJjXxyqgZ+i01mlhjzRlGxkJKPhqntd6KCAXCmKXH6c7htwyHNEF18JSaIuT3ZkjwFHIK4X0pQI1gjJBVWzHt4fSnBvo/TP6qtX/LJQ3TBk8lMxg05vOp82QoKJLuZXUlC1LSs57y1XnpSQQaWJAblnxuvle57opLbxNZYXZbIMWmzQHv7d5Gabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krP2cGmL4+nSullHj77Q/IRlTnAInqSbpGBz7ZxwWx8=;
 b=WE9MP7sbcqc03lRctE87BgkkRjqxAyyIkicsRqMEBWiRxVNajFF9ahsaAHf+3y++GiCEcf0yxhy+UhBW52zMhBH1iOBs3Kr/gO72/wcXWKW2dfxr5GP3hEMIe6yVBHtPcE0tkJMw3f8kpH7PPN8g+KzwAs4uF+do/h1LF5+NJ3G5oB959/MmQ2mfwZTPhhme1nOm3lrym49erYgvf+K33mHLhRlSIEOl04YSzXovWZd8gl88FyWC9RrCFUYUnXYiKHwrcLiybBGJ5ncAXlPjyKrcep9sai2znEPvm0Bapiu4tEEhi8S1twxm8jnw+Xt53L4tNwf+bnjsWQjKjzYJHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krP2cGmL4+nSullHj77Q/IRlTnAInqSbpGBz7ZxwWx8=;
 b=rHdV2SIJ/F00fWhpogyqXusMaM6u/MDOA5w+Kt/KgkTHAgMA1Kabn+taadLwk+wYAHpOjk47TUwE/oTtHttiXp8gMtVNjzb5wJOxTMTKa3AAbRVgm+vxu3Ye7ij+SSIe51WtKjX2oH0aTXCf9lsUueMbLh0PRaxz5/wOkPkJzpi7kWjVI4mxh8VZIFIQHHtsr8Abvt+af92B2sGMNdtKgINIYBbbL0DSlyVw+v0acLudP5lQ1u/FyQN8gefLRccsS1aUuutj5MLz32Dw3zlBcNdGFZat+N+DtbFwcTP6UQhhXaTQ0rD6zYpvLHykpygvSDxLiNk8EgVJHf+wOTqdhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 13:18:14 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 13:18:14 +0000
Date: Tue, 12 May 2026 10:18:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm <kvm@vger.kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>, rananta@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vfio/pci: Fix racy bitfields and tighten struct
 layout
Message-ID: <20260512131812.GA7655@nvidia.com>
References: <20260511221609.3837652-1-alex.williamson@nvidia.com>
 <20260511221609.3837652-2-alex.williamson@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511221609.3837652-2-alex.williamson@nvidia.com>
X-ClientProxiedBy: MN2PR16CA0050.namprd16.prod.outlook.com
 (2603:10b6:208:234::19) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: bcea04b9-1321-4dc9-668d-08deb028ec06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|11063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	j6PT549mhPqtejAe3OULGfN6vuQK5iv6lyz83bOyQErSNjsssKnSe12cJOi20ac2L8khascjyxmBs29Ixt0uih0oWk1C+MFAGZ5S5vtVl5DdMtfoaVrpSS1721kas2cfjmpN2j5taBDRmlG/o2ND/SR2k3avttEQt3GCwnTqGgkBOXyjoT46RXh3v9au26FLF5dFAr56Cx2Jj4rkSOsrHWQJcgRVsQ921BR5nm+tRLbT4oOjYkPJ9edvCF9Sx+FC/fltBQL5xG3K6HfzDjdmmZZWSCc3EvQV8Os/HdQERGyDhUFYzPKThPhVyJzQ4CpgzuwBhJrwjoWwiNZE6k01gwryNnpuQd7aMtoZ6KOXz7ItURgtfK+jbX8M2C3/7fh4QUdowXrYfEdTz57IfPHIhc5ardDrnsu9r2zY2aK23q2x8SxNBSCWj/5y03DZIZjnt0b5p5w2eKeySEeUCNGQWP1OzEjPqczY5RWlsaSpW9J4F7OkFe4ypmltaSVxBFfaNKrIQ2imDS4nlvwFFQjlZTpheYAQu+yhoz9CtBRgm7VLVEh1Kex38eFhVsdg73y6ZYOMgonfCHtXfFbVArV85ifyL4x4r466DUg8TYyBcVmIQjX1MWXlRLmUs0Q79T0ff4jB9uJzfYJDUHNJa6mbnRGkE/6ANYs0sHKjiwNSC75qHehJBu6MitgUoHQfBS+h
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(11063799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zPCBJeHe4iQ/pmtV/tAk8cBXhj+gYYCWZy3Z0TpYYMjnD66wVGAFv+G9IfLx?=
 =?us-ascii?Q?FDY/55iGmpa9augmSSMYcImsZfApEwCpDBdurMkv4Gp1PbFXvwGc0QoYYU7q?=
 =?us-ascii?Q?dj/IRu2seqWbvLNLUBX8lDjRJjjf0wWfcrlqX0VO+TjtQh5SHVhPSUqQbcFr?=
 =?us-ascii?Q?dbvkdezmhg11UKlX+nk6BLxJuBJEBXGk/paDatxO1YPXhQeH9wdpOTY3Exxb?=
 =?us-ascii?Q?005u120UKo9ZGm8RhlQuBn4miJkGEwdZKN8Skbzio7yxXzVZQlqmxMELdp5R?=
 =?us-ascii?Q?900ltbhhBteAAQVDqLCsMgZEEWpdmndkRzrI+T7KUe7+kLLAYziJ/Royx9GV?=
 =?us-ascii?Q?N0u5BxHreU2N1DXPKUFUVw321jwf/T6H2xqRJ/45YUjbx/OAHB5DupZ3snzB?=
 =?us-ascii?Q?jLpzz7zFk3WpiEIR780sXC19PRKZhv7eZLcth1cpeNNyHU4ZdKbyFjG2LZrZ?=
 =?us-ascii?Q?yrPhgbLPGLvseuDCMxnjEJnAqTpUb+/hzBOb7jpu3WaprqTsOlZdGhPL7Tp+?=
 =?us-ascii?Q?dELCYLyZg7su0YqnKY8/BaVhs4E6fWFV9yzG0qyDxCrMh3ykZj3XxpNAqOJO?=
 =?us-ascii?Q?NvrklUkiVpVwlaa09fqQICFLY6RTK7cbA0/8CALI7JY27k+bdNf7BHymoD1T?=
 =?us-ascii?Q?1Gi4lf5e02CYyyCbAWmcnZBWikLBzKGy9Hakd+gqQlpK1vSQtEMMZxxBvZZ5?=
 =?us-ascii?Q?6tg0YspIoPo0JctEaJnRs0np92nKY9dHqPDH3J2qFfi76fKFeUg3xB7Yejkf?=
 =?us-ascii?Q?apeibxb8rUq/cmHr5w9piTXwOBuLPhk80cQbkF8++PMTBxDwPcxOEkXVGgv1?=
 =?us-ascii?Q?ROJPv5oU6EUnEuUWYgSsQiTRxabZqzUmAvEuJCpybf1WGoiC5jLox9bRn5yH?=
 =?us-ascii?Q?6D9kWGo9EscJbxQSADcIylYDgrKXWv47jzsrJGOORi078wItyuc7JQKhngfS?=
 =?us-ascii?Q?fu+EkJFVZMtEbNV0t1G47VvVsFQEasoDmRqdn6zNpGF7S62HztBXzqN3Bm3i?=
 =?us-ascii?Q?LCBe2yeW/3dzrUAp9qURDIuvuSHi2aGkCp8mgWmt3NJkDtBhocETrWKh6q73?=
 =?us-ascii?Q?pTl+dfYjFbsZbIyE7Aj6HFQl4sq2oXXIpZDxADHaWYYreuj3CZr4wtPKUUsf?=
 =?us-ascii?Q?wIPMaZKsdplxQpPsuOB5dIn8chxOTCdl39s3rPKRqgxWo6FnVPSr9qa9I33d?=
 =?us-ascii?Q?9KbJTQ7qlAGZTkgq90938I98+ZEGyU5G6DzmcMXgSJWUoJWwDqWT5x4bLHln?=
 =?us-ascii?Q?tGR155N6hXr6q3dUcg9luCnLLqYKREEj+bS4OQFal7y0J8S3pxLH3JDmq+Az?=
 =?us-ascii?Q?n5Wo3WhoU8hUA1srE/H5h9i4AhpLg2rXW7dpGBDjHtOd6AcOhfDCd1co7jxq?=
 =?us-ascii?Q?IHN/MyQF1oOb7L/kv078kTM0BMLGThOnwcuMAKF+qzUTisamkEUKCiMUjmdE?=
 =?us-ascii?Q?QrcdzMVFKmiwH0rL2n6rNKeZw+ZfLx7Ljfi29pWbAXeTVgW/p2x9kSRJzaLt?=
 =?us-ascii?Q?fsZiVbAp/Q3oNVD5FjTM4TLMEskWhIPv7eI30v1zQzO1Mal6zSzu4xwcQefj?=
 =?us-ascii?Q?ysLuhSl7WtUlsj2zRSs+ejiHCq7DuPKi7fO6aFhH6nnKCmLBUdqeA5N5cOvu?=
 =?us-ascii?Q?H1Sll7wnOoxZ72WfStnam7gWt2FOyYFSMeqZkwchcat1ABTWQra24W1+aH7f?=
 =?us-ascii?Q?H46ABn5udAtvKluxqXrlzTarSsqcKR4khgGQLuJbBuBWWTYN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcea04b9-1321-4dc9-668d-08deb028ec06
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:18:14.1813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t87DDHW1CegJVlbt5xYX1EzdmdJDETR3q9dvGfuGJL8FR9NoRvJ+Mcr8yn+YJFCP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510
X-Rspamd-Queue-Id: 4EF3F5217DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245581-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 04:16:02PM -0600, Alex Williamson wrote:
> Bitfield operations are not atomic, they use a read-modify-write
> pattern, therefore we should be careful not to pack bitfields that
> can be concurrently updated into the same storage unit.
> 
> The split fields (virq_disabled, bardirty, pm_intx_masked,
> pm_runtime_engaged, sriov_pwr_active) are mutated post-init from
> contexts that don't serialize against the other writers in the same
> storage unit, so a bitfield RMW could drop an adjacent field's
> update.  The remaining bitfields are touched only during probe or
> close where no concurrent writer exists, so they stay packed.
> 
> While reordering, place virq_disabled and bardirty earlier to fill
> an existing alignment hole.

I feel like a comment is needed here for the various bool groupings

'write locked by XX' or something?

Jason

