Return-Path: <stable+bounces-167037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13528B2096C
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 14:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D9B18A2DE5
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 12:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8272D77E6;
	Mon, 11 Aug 2025 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RMLozWsX"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A62D3A71;
	Mon, 11 Aug 2025 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916968; cv=fail; b=cdWUVDM+fr5+e9hfHRX3nakwB/rai0Q3Ymdrom4cdcEYGuOlr/h0NAAlhVL2jpQzafkqoQqt3QuvsZNYy4JIE7BmBvjKYlVORWKoU6aHmGydTBa0dQIkjMUYG+ZwEgX5VBRzuZhsUlQdRUh2Eqr3nNzmqyzfOkW7raYxwNLjJMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916968; c=relaxed/simple;
	bh=WxtkKzpMcRvDe8cko7LUHMMObRtWwKUlPQwcDjlBAKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kDzukhzedGogHwF0jq+2qsZdNuNlnIDbWW8VQiPYqNVb1ntY36kMbhtFUF4N2rzs6JNOD5cpC9FL9LVASQJB8mwbk+R3MzNHYxXnsO3jy1n4LNqTXLT72ofUDwM/8llmTTsSpP0joqnIP5+vwJkBJ286rkj5W+M+MZzao70Tsrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RMLozWsX; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUJWgYR8mmMZnvpzM1sCCXJHqJSB8lo/RXxmEQbxgtWfHuaPLVIpmWz7hPiTZEBBtTiGY0g+pV9gWRzaplvb6ccPpkAKtaU2rGbYPcvAIqcPfsYPRz/CPe/hsgOqVOXBlVeOYvA1YSlClf5hv+d8iNWuPqIkDR5ULi43HGhA8l4IvcS2Dd1nVL1P4uh2zWBT7bsxiGXkHmjNH6d6nzBaNLBgfxAtMIHpdPtTuR5K7/O42ppmSdvDZtMmLqcqCIpSASuIgyj8DN2jWr/u3lDm7UVOuEFkNjBPcP/9i7b8itLUIPecl+s55lURpjz//7VuA/IKNLOcIP5B8UKTD3YFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxtkKzpMcRvDe8cko7LUHMMObRtWwKUlPQwcDjlBAKA=;
 b=ODXDbS3Y+vRf0ETiSGr5WZ3S0luRXfgDtrx7T4J7IYOVHh24B7cbn+DyeSbctiNyrxz9ExZXg6Dbq2sQRR9U2oZh37CUNO/mhGmR97iCoB18HnhhHtcX4sTV3SM8yz7wPdxiE7YcV/J9VaNEMJThqYria5Wju21jZOvBVm84cyeNVWG2MfOopLikZT3ST7PetptTgWi5gIhCOf5cmj4se4W+7yj+5z59GvYuXuE4YWc/BcumMVOFrAlbZZ+11lBr4zfUkLLfGggXifb6OTWJasD4f0zCFeoxR0fhpC2xz4UrUaNpxs2djmK2acnEKLI1LPBTwiGkdHKqJRJ/UKQ15w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxtkKzpMcRvDe8cko7LUHMMObRtWwKUlPQwcDjlBAKA=;
 b=RMLozWsXAqXBtxcXvGefCLnZwVH3NghQ7LlQ118f1VMYaeyfe//LYV3pcC/xA4ADGI6FlFSRPhxnubK5TlMUxA4e8Zhb/xUdcvA3R18cxkx0pnkHfKYGMtGTiaw4EcMzOf5GFfWwxlgjlx3Mb3scu0AJ1gZvcXDU84MGhUl9rNA9k7hFJtOAli10HAs/Mgi5V/9nJUjL2XT43hB6pjNkPud01pplBpPdZaITVGkaeEHpOgXK8YpesUbzyeqDOT1zU7CncGtKdu/78NlHYfTinwe13KRvrNLeEkfr2ixkRyOR/hzMySu48CXEFfpUwBI+6uqyuaUVmax7kzj/+gMatQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 12:56:01 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 12:56:01 +0000
Date: Mon, 11 Aug 2025 09:55:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Ethan Zhao <etzhao1900@gmail.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Message-ID: <20250811125559.GS184255@nvidia.com>
References: <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <4ce79c80-1fc8-4684-920a-c8d82c4c3dc8@intel.com>
 <b6defa2a-164e-4c2f-ac55-fef5b4a9ba0f@linux.intel.com>
 <2611981e-3678-4619-b2ab-d9daace5a68a@gmail.com>
 <aJm0znaAqBRWqOCT@pc636>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJm0znaAqBRWqOCT@pc636>
X-ClientProxiedBy: YT4PR01CA0194.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3ea749-0a85-4bad-f675-08ddd8d66c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TE6qV6q1GAzK80WIn6v6lzpjz8RVzK4oMuotihVMMQyc6a9cf82EBgpPY4Eq?=
 =?us-ascii?Q?xEV7Pm7labhO8kCepANkvVSSQ9ntv+jyjwuAbB05o8Bos5mL/FhyEr5h3xtn?=
 =?us-ascii?Q?/nU0JnrgHSpSeqWX2VT/+tTDzOaN8qIPcgTPiTQiej0S9E5Tg9wIX9k9goiM?=
 =?us-ascii?Q?NjlL4DZH6cRIswxObtE7VQcsCcizYtuFjDQbTuHHus2rRLPZwZB5gvv/Nlrp?=
 =?us-ascii?Q?ft623jk97MAZ+Z564FIJKYwBt3F3pvXJ3r0lMXZDObZ7lTzbFv72QoEI969l?=
 =?us-ascii?Q?vC3IpQ5ZUF8wCuZe0sIOABiQZSUkCApED5RihDCoESZE5gOJZPDfkV7WPrEh?=
 =?us-ascii?Q?JDnAYIx9/UyAVxx/tepospndoZ6lafb+JO+dq+S95a4B4bMvqeh8Z8vAEMEm?=
 =?us-ascii?Q?/f9EKnfqgpNtP/Vw5HCNhhNm3YUfMJdiWfyAOxyHFCxhf8pagnwPmCEAvDFD?=
 =?us-ascii?Q?bRIpdPygr+qxOj6x/Al9UFoReZRFgiWxZg4WJeGWHOnk9h28cf2ZSEYZZwop?=
 =?us-ascii?Q?2DJhsLCIOPqILQuFiSWgauMxAxvuMGJCwTun4wZia1RFyryWL1Sy75aR/8pu?=
 =?us-ascii?Q?AeqxM0IxMjw5UpDUuaRLuR6sgv2BBnFPDml6il0EXxoRFIzP6Pceewe8+6mX?=
 =?us-ascii?Q?J7cdG2KkVPBA+9vIa5tDlycTCuPHrJjG6OYBiyBU41ScElPm6ZQgLwRnYD02?=
 =?us-ascii?Q?yCkIBjNCx12oaocijXrCVaA10bSTDSayYNAf5v2DFrJDnDDyCKExKn0sDmEA?=
 =?us-ascii?Q?ICJBYKYlF9S7lmhPJlufQEi+J2814/rbSvrM2EheIilSBlFeB/YJ9dqd0nLn?=
 =?us-ascii?Q?mxUEiIA98xXkriNBQbNGI6iFjyn/lJfszQ2/WVDd9ltVwaFP8CC+Mh+zPjno?=
 =?us-ascii?Q?gMmaWpRqAQH/5iRbPwMWazvp4vYkBX1aBkuqhmEmlNRNtiltEfQqJoRMIK7Z?=
 =?us-ascii?Q?vAOdNh+T8dsB1DEjfLdx/jnO0tKkAvGAWp0V7g09A2YugVn0EI2dwUNVEJNv?=
 =?us-ascii?Q?3yov1Mauwoqy4pFTfRVOHhZfPkYdnb8A/DxMWyiiltiTdRqHAyF/A2OUzyVI?=
 =?us-ascii?Q?nZqxxjmX9hJVfhbBwgWJB29bY83Zssof/0CgI5B5VHKWFGmi3DdvHdgyfJtl?=
 =?us-ascii?Q?CoXA5InwjoGwZQwh8G+UsBGweK5NxPXLDQkQllouKgFePYQLolDLhXV8Cyko?=
 =?us-ascii?Q?WWZBnZUCGv3q+fI4j9AF20mB9n0YycIYXPPoPFNx3amI24hZ1xntWum9IIJJ?=
 =?us-ascii?Q?ihxzmeXNUJJC8HLSuxobaMGE9is/Try5C1Twgki18gBc049XSDu0nPZ734Cr?=
 =?us-ascii?Q?84UqhKFaUY9IVEwIqm9fUkK1s8gQuxqKryrfAnVIG2loPcFsOESYO562JqJ1?=
 =?us-ascii?Q?TR0NDi5t/I7HdBvcFtY+pjlKSxftrKSyo3RjjflLB0sg5p0yAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hg9X1ss6zA9OJsS6L6cn0fT9XTZjVJGn17QfkOm6/J3uhAT94Nqe2E7qbaqL?=
 =?us-ascii?Q?flrFH/slMELLSaBFW0fpqcozb+TnAlvsFryJVLowlR8OoBLBLkHY1Z0fRDMK?=
 =?us-ascii?Q?OeNlpnzXKM9yOSaSszHXZzhrsbI0S7PGgwbIXkLAESxdoriOJCuW8ckYM7KH?=
 =?us-ascii?Q?uxmVKLJYlhxrviW52VvaqoydgjQBD2HEUpALN0v8ZGWlQswra64XFNXmBfpv?=
 =?us-ascii?Q?R2K5vr9EyjApO0YN4S9cMaCjv8SkoOXjh5HGkAO6WIovcIynO4GzHznd//Pt?=
 =?us-ascii?Q?BseGlhS9E0AbEQM3A9uOpGFvPcULaaRObLYqTU75s1gWxgunwVOZXRFvF2g5?=
 =?us-ascii?Q?//wpXLpg1pavUCopeeSR7RGFYyzCRWojkPvBvXe50hkSIbqKljMtt+fK+ZtU?=
 =?us-ascii?Q?Dxwo0E6XMijdLOiowFzyJfwiVBAOuiTgICsJ5Eo9DIgG/WELBcesgKQS2B6c?=
 =?us-ascii?Q?kG1+hSNKf8q0ILGumtssLvnnmBsXDFQmK5Sw1NYCgpmjnPGbQHm5AFoFMLUd?=
 =?us-ascii?Q?jQhas0veD4VxujtZlJcjRr0rL5u9G68VZbMLmUsPY0u/NsQhK1+p6tUjPIhE?=
 =?us-ascii?Q?lLRmArxUs5TTUCIPx8siV27thgUyztafUUaVAmjgNX83ihafvlzvoDYMAcBg?=
 =?us-ascii?Q?0urZiK0vCqpcH9T2T0Wl9c2IiRIevaAqt3z21Jn36obGCWC6/gXikouzboNg?=
 =?us-ascii?Q?2FCVIhkZMekQsGjlzcWzjeyt6oKiJOK29QbaIe0FSP/WR0cmb5wYbKdIf9Fz?=
 =?us-ascii?Q?CHY5unE9YQpNsHIq02KEF6l+AbbT956zMWgGsnjuDhVrkVSpJxTHybAB7C+C?=
 =?us-ascii?Q?WxhhYDd9+w78QBAMKT7Wp2J/x/a1vszctqX4pMtpYTwiwV7Hb1EQPMF8sHlG?=
 =?us-ascii?Q?QF0PWAchX/4EQJkhEy2UKY65d4Ns+o/qCEx/K5oskABB3R5ioGO10Mu+lbLH?=
 =?us-ascii?Q?z39853ZFMb0axYPmou4ugZEiY8jT6v0xjZEALvCLPOpefDUmR1barjwD6Ndu?=
 =?us-ascii?Q?Cjf6ACmXxlGIEGCHQ0KE93quY5vPim3GHP2fRDdQu6xQyJswVK7C3gpNdYXK?=
 =?us-ascii?Q?ybF8H5QERNKW602KKRFgAXH/LGxeWlKERbc3bdpyCcRPH+sDbWz2cvKnkvtG?=
 =?us-ascii?Q?l4J0+Fe5LTQTf7/Ams7VIY/AJ37q9oJHsMC8N6FFSmLVM2aMzbu5tMBgb2a9?=
 =?us-ascii?Q?4dFli8t78avpNAcBzlnkyIfO1T27U+7t68gg8dxuWrBNoymu0d6seTBOkvMJ?=
 =?us-ascii?Q?QO3XTt2sPJryAzY7M9fTQCkgHoHvaM91/k87O8ZUqhU1t6We2gE2vCjOjIlj?=
 =?us-ascii?Q?rxs4ncF0J4t/RbnHvuEe5v6vDJKdAzgX4Jaba5FGDpCujZs7IC+OQ8I0xnXE?=
 =?us-ascii?Q?J2Bw2RE1ccxwOb9beK5Dfs4UzBkbNPPkR7E/KCJTpftgDZhswDK9cd9Ucaod?=
 =?us-ascii?Q?YWYVn58WSb03IhNqg18TF7l7p5ttg+9GPV8IXwWzwlC5/nBjZj4LyWAXnGBH?=
 =?us-ascii?Q?6crpAGgyH2riyTa8q3POwVNiMakOOBH97TdyEun5WAvt0QtkV36XtVGo20UB?=
 =?us-ascii?Q?Etw26SVhKI3fP/ygzeQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3ea749-0a85-4bad-f675-08ddd8d66c40
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:56:00.9368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXX//RGK9fTxi2SvOtGppsfqMvrLMrFxP1CrJIStW3nNo7d8lhlG9HBXGryKoKry
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183

On Mon, Aug 11, 2025 at 11:15:58AM +0200, Uladzislau Rezki wrote:

> Agree, unless it is never considered as a hot path or something that can
> be really contented. It looks like you can use just a per-cpu llist to drain
> thinks.

I think we already largely agreed this was not a true fast path, I
don't think we need a per-cpu here.

But I would not make it extern unless there is a user?

Jason

