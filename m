Return-Path: <stable+bounces-223084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHehIVNTqGnUtAAAu9opvQ
	(envelope-from <stable+bounces-223084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 16:44:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E865203135
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 16:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C58A3024EF5
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 15:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34AA34F49E;
	Wed,  4 Mar 2026 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DSxcRgi/"
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F4434EF1B
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638795; cv=fail; b=uw+rV3Ucw645sIpKsOLecFVVtbgYVNa7K8iFEG5GdQebgOdVioUo5cmPUK7oRIe2gPEXhxgdY6noeo389D8AolMkcyLNrcSRNCMBY7pgJvXr8dzDh/Cw3x0uQjQiAQ19n1iUWWVQPdyIZ7H/3/F2G6rzizblDZtVZL1+8leKRtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638795; c=relaxed/simple;
	bh=gBhLNfjeQcpvDCOYwwQVAxVWViVjgZOuLS76JnZmy7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SCNwMpzkWWPwlB4sQNz/hCsbh+G/Doz17g3s+cOCHIYjSYjlNfjiBZKfYyGouWSBn7NCjmFIkg4aSlmiNRmzWJqRbFGhmZJg8gd9Cpr3B90PVG0KzmHwnLpt5T0RZSzG2gwFk8rE++70x0P3zTn1JysPu+zuC2SODX8dpuNi/Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DSxcRgi/; arc=fail smtp.client-ip=52.101.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QL0YZrvHcQAK4KpWdxvxHTXHdnXJ4lyVLafotAmqs7bTEylaY6mphWZnyPNQml1fHLxE54bcGgFkSGb9Yx9HbzxoOpeOJNU2zbKjBj8/WdVVx1Ekw5yEQpMGAA0ENhSq7e4d6CVcsKVLw+Lhjn7G46pxuJV1GyfUwX0/3yZi1lYdbxFdxdU0I3zPUYhXfSug1jRXYsEqgOVJ8Chl54N/7zOhbQvEWXLBDPRuypguoBtD9rJf5VTg2GgN/j1GQYV+xhaJ/0B34plC8thb/pB684w0oh8bhSod8LXjG50hRY91vxfGXCooOcgg3DYFb+RaqWMw+uPmY/gH9Ci5E6akew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBhLNfjeQcpvDCOYwwQVAxVWViVjgZOuLS76JnZmy7o=;
 b=XXvGGDaRhqgePe/b4zDaghfUgJpBu1tq1HM1KbRUHFjtzFmen76+k+WjsJadS5BEbJ3HmXHxowsUO+9Lo7Y0L6j9ypUrY9+N5FoXM6HJmYQtnP7b4kLhBwDkbEyJnK+YPpQ2tnyNtyadtCquff2hq2ll4pIs1hD1HWn73s01EzNIFUOJsen93XNU7+JY/7Ma5FkaMbwa8INw8q+liCUhUcnzmyG2BREVBGAvfCxehLkTcpUgjHI1wbE81skgPQNm+a/dQpxnxAhJq22tGMu9IG3iLq1Jety4+I7bJdWNDeKZU7/yg524FGkoTn3OIQwL7w1CK00lV+wSZGnjrTUrmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBhLNfjeQcpvDCOYwwQVAxVWViVjgZOuLS76JnZmy7o=;
 b=DSxcRgi/ZZzXwTdYYPn/6tW/vOpzQjXPaDZglkBioPDeycOJLkOV/MHSrNSTGiiVx1gyKbOse+xL+nuLPR5DXxTsZXF5am7GOUk06YPFy4rPclV1jwEYVPe71uB3ShTaEFvkAjUNu02ak+Vv8J/GETBexhiZ0JiVG4cNGCcV85wacoCjHP9rW98dB4orqIK2lnnTWuqASj3vX/s7n4hPMBDlrutGSI/1M4H4bK1/iS/K9ww40ooaErrqIWFucvLhvAPWBDBqrTc6tN3bfPngLYrT5MQZi51bA25If6cfer9ic9qR/u3lWzgpw07CmrVAwlshOyIy9RmHpMj0kI6HEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 15:39:50 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 15:39:50 +0000
Date: Wed, 4 Mar 2026 11:39:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Piotr Jaroszynski <pjaroszynski@nvidia.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	Alistair Popple <apopple@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
	Breno Leitao <leitao@debian.org>, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: contpte: fix set_access_flags() no-op check for
 SMMU/ATS faults
Message-ID: <20260304153949.GP972761@nvidia.com>
References: <20260303063751.2531716-1-pjaroszynski@nvidia.com>
 <aagUtDTca5d0le2Y@arm.com>
 <20260304134313.GM972761@nvidia.com>
 <aahJX0NwtYHy1ILe@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aahJX0NwtYHy1ILe@arm.com>
X-ClientProxiedBy: BL1PR13CA0160.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ea628a-a0b7-41b7-08a6-08de7a0445ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	6AcMF+UVVdT9JH5mu1xZWCbVgNPwlAzTrI3+r/BL7Of6PXGcxeZxIJM4YLtAXJVewhQmzLV55sMoJAm/Q8SYEkuDCqS4C+c7zprMyhkrHrGCgiv2K0x074F0eH47B94reLDc0L0w2CNnLPvyHMl6wpRAGBtbKlJoF4ibBAsSeGRyqwOkBYp2puZQ4rnwisAS8M144SZNMyYzBztxEdlj/QjBNT+7Woo3G+OREJtHX3EMgtUrSwYfToe6Pb9tair+WI1pTRlugTawXNJFSbCJ1QyepXt9xqp29G7V64TPaJxx3/vX1ShqDOcEPZYI64Bn7yBQGGo4icYZZoXBlRMnDBkm/+ioWZScOmrfqaJ/jPfsp9WVRwLI4xFHwRYr2nSFt+a7602uOQZq9BqiNxJVsjYye2htIIHbZmb+4Z3HVDWO2b8F6u27e8HZ3KYyEDAqE3CRlspWRUnr0eCMo7v6rjU1yHuCPWeML481rEFtk8Zvjqr33SybEcHWlQb2d7C9UjfDnq8EJgWXT5WsoNoz2MUMaquHbiWobIYC+2Z4FTteDrQqKtnOGKTWe8gYgJf+YrVhFD4vJiZJFPNc4sSWE0fM8i3p6YuPh9sfHsqIDDoIqVM+cgZNqlJRRzQBJgXuFmfdqYqF2K6U/nnoBEdX1U+5+721fgBgK+5Y6yupXwpd4WJbw7JCORx1MH7OxYfwa2MntAEOKjyjH2jZCMbrQKZnIoae1r9Xn1GOF9y3PTA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BEPD6asbSJFNf3TajnjC50CD+Q1h1UqkotvMuomoXenhOS3ZGeorALfz8Mnw?=
 =?us-ascii?Q?qfhmpw9NvmnS5cq0RmJ5v2AToV5XkcK6oyraUtU5f8O9oq7g1sfGEmzc6Djv?=
 =?us-ascii?Q?a7p+A7kRwhyPnhOemO6mES0GGrECRJrCJRH99mda3zjBnWVx8xj8hwVbHYbN?=
 =?us-ascii?Q?G+sAenZ3P3ONBGyVTvn6EMn1IiiucLG1+5pWiMKgkjO6jmiBURVTJy7U0+lu?=
 =?us-ascii?Q?0t8fGctbYsGXoSHqWPxiuWuERcSZTaNLFuibzEoSwL9TSFGOzk84jmOF+d15?=
 =?us-ascii?Q?LFj/qw2suELJIpcD3aPgil2MOe1un5TbPCibxOILIWzZEORT+dE3ykOjndb3?=
 =?us-ascii?Q?23ZrnEF/Hi5nib3A+sombSzJ0HhFTlbXcMepw36PIDzaPeZwZUleQFnuijVq?=
 =?us-ascii?Q?uaTitqB2Q4IfXRJkVHctWhFLfF0Wqgrf5BuZotbS6YOcIuSYP5kqlw1IjoBC?=
 =?us-ascii?Q?l0onkzNdr5f3o6hjspzJFqMY2OZU+Sd5D68qL5LOuOpFCLboN7+ZUbnXFxX9?=
 =?us-ascii?Q?oj0yv4JGnOWpuGhVfkYyv1L/ToomfLGP1v72UFLjceuFrpNOIDzP4L9Nm2Ae?=
 =?us-ascii?Q?WsTQW/WefY8Ugg0WHeq2PVbbaAe2eYbQ4mVEN0M69r3kac8pWSRK5ND5JSU6?=
 =?us-ascii?Q?7acNFjVd0Xajty/STM3uMlzYUAqygFUFzsnrQqsWldK+lWSCSzbFCXM/IhWP?=
 =?us-ascii?Q?z5esZrAVh/Ys1W2Py+npc8N74v+kFjnv2sqMGvX6lQfdqDzXLBDPon3ylHXa?=
 =?us-ascii?Q?iRpwdj31IinZTl9loweSpXcoQyiKmpm4TiKnU9mbTyex/QQGMySGg/zlXKai?=
 =?us-ascii?Q?Xpw+XnTUZ0cK4bjJuSFvR8MxOoEPhrh2CnI0pcU2e2q2JSoaFOZnoLUurz7w?=
 =?us-ascii?Q?GgZz6fVUcCATit2GEGHxd2PKD4/Y+0J/wWaSi4Ezx6jeYuyd9WojeM+pls3h?=
 =?us-ascii?Q?wSMWsGvmtjgo/lSTAVBXAmwIK8iFmzcQOhSPg5TU7V3EOpGIE43kc9DMA6gn?=
 =?us-ascii?Q?XfoxeEzikAVNoyS/B3RUOqHWTJ7imJw3iJaIDpCwx/VlMML9QaWne3LNaMtt?=
 =?us-ascii?Q?jooBdM37454/+1qOVcZn0TxOZq9YUT7R/ojEBDdK/At5j2tJmBEhTjlgu6z6?=
 =?us-ascii?Q?I+ctkU2+TJc6VdQbkMin11hbC4wCBNemj5lZgoHiIpk71Rhj0cNw+ukne+OC?=
 =?us-ascii?Q?ukZRg3Acy5yagprGHCZeUID4OZA6izcixG692uIf2xz+uniNdxhHhTOSWLE2?=
 =?us-ascii?Q?iBtUbRrRFfhNkJw5/UQ8OmFPTwf35J4S5o9sgC3nzffg3kOGosFwBiAeV3Fd?=
 =?us-ascii?Q?4hnErwZ5uezf6cn5+0ViCSGtW9m1vLjeueLnR5ZjyxEMfc6gRX411qIw0SlL?=
 =?us-ascii?Q?3FL6fm58hJan8PLCicQ63RvoQ+UP2cbm/iOawRmqTGnmx+lzUQfxUkbOjnqj?=
 =?us-ascii?Q?y8IRWiXy2xiec2LGFBXL7b8Z/xX+rBZR8jfCcGB+0iZ9EE9mbMF6bxY6DRSO?=
 =?us-ascii?Q?TpdqPQAzDAxh3qhwI1ofBBzKqLrxgNslaKxWtYVDrUzwXZGTy4c3i6AuYHRp?=
 =?us-ascii?Q?EUHDEjAlPHkpG48of2Cnw1pZinD0vlY66vz5e1LBfT7FkZcJb4/YJTRgFzi3?=
 =?us-ascii?Q?nfJsRWi9wKTwf1lIJk0VeJMbNlEvsUAg84ejlgFxbQyZRRKKbBFOMLjAFh0F?=
 =?us-ascii?Q?AfCQhW70fIYRqqMDiCWyrCkWFTGNW5AYBlOI5sMRVZVz3konv1U4RyFk6mu9?=
 =?us-ascii?Q?g6IMTv2jEQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ea628a-a0b7-41b7-08a6-08de7a0445ad
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 15:39:50.2748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XtOZ2GTdLE4x7pGLZVBciviUecr3r8zx94k0oIw6HlhMJoriElq4/RNhI7HDEqq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149
X-Rspamd-Queue-Id: 4E865203135
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223084-lists,stable=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 03:01:51PM +0000, Catalin Marinas wrote:
> Good point. For the AF bit, the hardware is not allowed to cache it in
> the TLB, so we can't get an AF fault for an unrelated VA nearby.

The way we have read the spec is there is no restriction on what PTE
the HW accesses when it encounters a CONT group.

To be concrete, the spec seems to say it is legal to make HW that
fetches the PTE at the VA, sees the CONT bit, and then always fetches
the 0th PTE from the group and only uses that for permission checks.

Therefore SW should never assume that HW will read any particular
sub-PTE under any scenario.

It seems current cores don't do this, and it is a bit silly to do, but
I can imagine an optimizion where the core does a cache line fetch to
read the PTE so it can freely snap to the PTE at the start of the
cache line for permission checks. Consolidating permission storage to
fewer PTEs would reduce atomic memory traffic if the TLB is thrashing.

Jason

