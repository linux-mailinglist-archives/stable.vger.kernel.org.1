Return-Path: <stable+bounces-238482-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HX7HWAh4mlX1wAAu9opvQ
	(envelope-from <stable+bounces-238482-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 14:02:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE22641B0A0
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 14:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 464DD30A8BE7
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 12:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC5E374E4E;
	Fri, 17 Apr 2026 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AwIIx7sZ"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA89E34678E;
	Fri, 17 Apr 2026 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776427204; cv=fail; b=ViYIlGMTlqHGLqhV4nv1e/6LDuCm/sYaRpXsAF0WLem6xVtOmS6fqx/qCoRcWSTbuxKqPYu9Go84V/DYAxgWyJY2Jwd55ZzlQvN0HjBpMQqy4McqJFoDJayLjeTQGXaG74FB5142ah5BeBSYD1u0u46nKKR/YdaYkwJUnRFQUz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776427204; c=relaxed/simple;
	bh=Y5TEBoniMXt7Fz8UniZfKQXWszXttkj8zWtxf+U5MD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hdcubEyi6lEFw7Quy17JmPZwoKcbwCzBWo5Z2lJ8xFSza8Fa19ORi7TK1M0idnUbUo6JRTl4W1MonM0tTwl3Dj2bZGtNEECS37UFAO8Ua8UviLgl1H6UyKGBDLomjz/9LquA3PiNLPbmrv2E787LGnXl3COmVmV53zrHqDweOsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AwIIx7sZ; arc=fail smtp.client-ip=52.101.46.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFc+BN4DuAMt6vgUji77mNS4GUfQVKmXMf8NHtuxSRJ4hi+BP02klxkJZcAO6ewTgomvW2K/3xhF7bCxHhfalMGjWtgDLwwks6HGIUyF4QsEu+i5svbawAN6HnET8hazE1vizLFzAF/xXwwYHt8h50YXP6Vai8HRSX1htYJotkOvmw6Ef2d3L9VoKUa8Re+gmxpqjnyUCssGpRgrU6dQ+7oSck7K1F/OsIUgvQZ6Dj9QLP9n5Fck42LOmVbEDoAbAMkplx0HgogthKhgLb+6VUFuzuCDCWlsD2Vyp0poXFtZ6Q0zTv9UmSnQgfsSTs/qBvEwhOTdiWMWryFdQi4qkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qf4/PptYrWrkqrMhg6IPO7W2cBk2pY4WWM9BjQBQvhM=;
 b=nugaTWr/3DJmqhI1C0n2dmOXb89eObYmaEl1EU8+ffXWN0xGKn8PCnHx8txRI+e6PgtP4diYuCUYcLILzmKtX363YnUcclYBcCS2aShjSMXJj5I0DgqhSwGcNV7K9OyhIVl65JU4sgkWyFeY9shgp4sOapt5YX/7bIISOUbA44nDFoK+fzzaebjjUSVH4DxgWM7vsI0HZwElNu1Pw/mjVfEpUzavJqnijtnUF97T8e6mCbeY34dcfHk9v5H9Gn1PEClO7f20cQyzwojOYmZ05kLF5P5OQhjScRSSqc6pS8mkVI8SAgqVFNnZRal+L/7I7f9PpyidOydhMd9I58R91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qf4/PptYrWrkqrMhg6IPO7W2cBk2pY4WWM9BjQBQvhM=;
 b=AwIIx7sZFBvKvxrmE2vLtfF528giCNF3VleKyIFxLvbW3T6UG++gMnhRtcT5ZJmgIQLFM5zG7NFezVa0fO+8thcdvAFkK3pET2BkmXU3jAHxR7Kn/jPbczXAvJXy49cDH0BgHPCnn00IiThkbXGHWOxKRNYFVXbPKGLsWBoqXzwZqBhsXfUfapjRjV29cFjoBHlMZ8goUEKrUAwqmtUUbd+rSlV07KpX9nqhZxuLnwJ03A/QftHweKcEqRVQgbS8LTpIpGM4ySZeS1QnGF5Aevz8p+LBACtg5XmNfrcIy9bIVXnJpZ7b3Lox0oMVLFRB0FrQ9n1fNq9etso7ruv3Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 11:59:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 11:59:55 +0000
Date: Fri, 17 Apr 2026 08:59:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"jamien@nvidia.com" <jamien@nvidia.com>
Subject: Re: [PATCH rc v2 0/5] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <20260417115953.GE761338@nvidia.com>
References: <cover.1776286352.git.nicolinc@nvidia.com>
 <3eaf217f-8e1e-4d64-983a-6b888886f157@arm.com>
 <20260416172005.GB761338@nvidia.com>
 <BN9PR11MB5276A13A8014C5C6403FB4EC8C202@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A13A8014C5C6403FB4EC8C202@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4P288CA0075.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: 191e914c-c20e-415f-e6e1-08de9c78d6e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KJZUceRqcqFznDkjj4xr2aCJOjGKNSWCw1skmfjiwcTqmy18mizl4BNYdnWfiRFPAIaNO3DTRnyze76u40DrR/BZnJGap9ZkIxsXbswbIql0EBpZffVkjiO/kVR1/vv91uEb/qmivEFhlUMwwYvbYrAFinH7VnbRTZL6wsEMGLQumvfGN0MMiB9Z66SQx6cvyVvgGVY+bvFo4PPLwqYUWM7/AcVWgM7+QTbnJ+6tbmazkAeIKdFhn8LZiQhz1ZXOQ5jgWlMkR3tpEBBDi8WIqc3/6yS3PBj+tEcAsKzv5tKlBPKPfZi84wJSKGS1JvYd+WC6xyV0PLgQZ4ASkpURIaiAPpFj8ZeQ5BIoXJtBRYnt84v1XuCpRThFW1+fa8rmedpjaQuJDIYdHWNmPXpWu47CUKCYmvtHRbDTd6yDULdufFxKupq99XO5fE/0T43yUMefIVJqL6ZrzUwaj6qE0kajhLg51oKJlBosEtHqeNohfYH+hhZ/1Uk8UcUMTVTQId2SCw8BH0FIL8+oCs7U1grGvydtC8YFJq+14TuXUBe5TjxYmfXl/UcMUF9fgnh3OArdMJh5JN6huC5trxxPJUtxoZLEW4KxtpTbsk2W9m36wWVj41Fg3Ct18TXFakqsim9EnK5QwdX0Z3NuH6pcY6E2XDDxx6UKU2Y4wmdMrTcQLpUWJlqw8Adp4njUp8rWR2VDrwK3wco2oFw2ucDStVoNji8qANUCioQwnpaQwZk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EGmvuirLtEpBK3vGJz9SDQo8DaKKw+Pa+OgPEe5VxuJbXDSiJ9bWpCEwauOQ?=
 =?us-ascii?Q?ahkCH8BAvTZzYOC6sNXvoI+/WtXlUMwIp2ksoDRypDpBkXUTSvg/KmSd3msy?=
 =?us-ascii?Q?GvvXDrnpgRYfrCwqIRktXTJF8nAfZeOrUDmkon5PXQd4rzYisgJKG5yZWaIz?=
 =?us-ascii?Q?OcO1NPv/lxin/of77CPQx3tuQodhf2PTkxcRpp4VJq9kHrgqGAlRXD0EYK4+?=
 =?us-ascii?Q?KlmV5GSlZojx+ZFpYQV5iAu3BreowtQRYv4ZM8Sz4vnyhyGRvUZnc7+UgWYw?=
 =?us-ascii?Q?91r9uWDQqFDHaGBpDcb9sX2AlszCrx0emJrig+qbAZaZVWUX7MeyfX+8pHNI?=
 =?us-ascii?Q?q9duIEWJ9gh2weKUTCMisppeaZOKwaOMVMcJyKUWHMcsInbMFI6CHIR0UZqO?=
 =?us-ascii?Q?QHZ6RccdmZDwK0677rs67Ou8zf1uii1jLWNC4PIBempUY8U1Tf/PpZIzDQJA?=
 =?us-ascii?Q?viVaFxbbyj6ey3KHqRLpOyzcyZn9fiz4K/EhAWfXT04iMAsTkMXZD2u5SVKm?=
 =?us-ascii?Q?L0Dhq5xOau6gFA6HvaYDrMmCyL19ffpclzNps77Of+f+4/8K799A/UKrqvsA?=
 =?us-ascii?Q?c8vx0/x/2gn0mi4nbLfe9Oj8KUbGArscyJKdIaIfNwFXyHYaadpmtz0dcJCB?=
 =?us-ascii?Q?Zi5iJeUFg+JeSOxOHPc3CqiNMYamGHR4EbJ2s6+n6p+8lNeL5RlR0p44IgEz?=
 =?us-ascii?Q?dJ+ElHzVMAbGBzJa8pa2V9if2q/Nck0fkUdPUmhHImuuS4l2xTKVhkYr7J/H?=
 =?us-ascii?Q?W5D93OqRs/f5Hg9aTgtAgspo1yvp69qsO22i3uLZgw1aKWyrSAdd4bbOEe07?=
 =?us-ascii?Q?PSIenQ9AyDz+yS50oSaSIo838aAWW1cfPIehIRbeYMu4yiqq+xULgcWSQW3l?=
 =?us-ascii?Q?t4/aqW1s8zBdd2QQ2/RhZr+6fzK9ovTVNpoTEnC1tNSiqyOx4cQKA5mzHNo6?=
 =?us-ascii?Q?77/wPaRxL+oqpHHdgaHcKCyr4O+l4z3dCdTCJ6Mxf+L+XJkAoHJTUcnAG5Ex?=
 =?us-ascii?Q?xhWLqbf1ALbR7gr3zPOm+jUrIiSG1aZHbodOZJ4tzrP9s/rMYplHRPcYaT7l?=
 =?us-ascii?Q?2vLV3QkfaNw71zWJaqWQm0QzJ6d46B3FEzKpJ9bUvQ+uczkxWv3AA4PntNBT?=
 =?us-ascii?Q?rCPANP2cMzoO8/tYZ1pCc0AOgz+IvnBVK67KeHFwWE0O5woycdLaRYMh0qRJ?=
 =?us-ascii?Q?InOVLzcD3DCwAN+ihD1JTBgD5c4HLZwts3v0Xm8kMGYCWG17mVXt5XJICJiN?=
 =?us-ascii?Q?B48Rl9cqBbqotBJXj4HSW58hrezuZDeEJNHpdAJBb3SW7Hx9PL4PO+/7LO29?=
 =?us-ascii?Q?nxUvQkiqtHJI+RrReSrtYFJMzDNDxh3h0bQOsUMikJeFrszCCPzTp3Vjc6ex?=
 =?us-ascii?Q?Pe4B3xMy6QHtagkBIJCo5NySVid5r1U2RffVSSMXak4QT3xLShMGzflszaHT?=
 =?us-ascii?Q?liufT1e5WUXY+qOLXBCyjMhmdrHNDTjwG+FXDj2ifOTlxUvPnYz4fcL+ntLf?=
 =?us-ascii?Q?UziZsV8XzeJyAF8TWCVLl0O/2yCW7dTn2d6sZh9tUu36aYEJhsbVvXZ12rn8?=
 =?us-ascii?Q?z7yPlA/rD8KehPjkQDgyXPShUaSnHwsJRybfoop4pSLIVYPyDUY2N2P2x0iV?=
 =?us-ascii?Q?yEC9rBtG4naObttzwZkSfiIfuXLnbY0gp+1WWDvSCMXuxCjlOT63KWJFXsqE?=
 =?us-ascii?Q?0CkIGLXKvfQLeqd+1MJrsE6ubbLTq2nd7MMIiw/AdagqCKwW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191e914c-c20e-415f-e6e1-08de9c78d6e0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 11:59:55.0483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POt+Z3JM/gxLHtJJEtAcrDtGXch9oXiK63eX6vyyFquKaWqJQka3kXXy/4I+yW8/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238482-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE22641B0A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 07:48:46AM +0000, Tian, Kevin wrote:
> is there any report on such systems? It might be informational to include
> a link to the report so it's clear that this series fixes real issues instead of
> a preparation for coming systems...

Yeah, we have an internal report and this was confirmed to fix it.

> btw the DMA is allowed after the previous kernel is hung til the point
> where smmu driver blocks it. In cases where in-fly DMAs are considered
> dangerous to kdump, this series just make it worse instead of creating
> a new issue. While for majority other failures not related to DMAs, 
> unblocking then increases the chance of success...

Right, exactly.

If DMA's are splattering over the kdump carve out memory its is
probably dead no matter what.

Jason

