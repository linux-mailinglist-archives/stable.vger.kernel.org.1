Return-Path: <stable+bounces-222869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBopJkPYpmnHWgAAu9opvQ
	(envelope-from <stable+bounces-222869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 13:46:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9817C1EFAE3
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 13:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84AD23023D9F
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 12:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4B9344DA4;
	Tue,  3 Mar 2026 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Az/ekstt"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7172035AC29
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541941; cv=fail; b=NnqVdtDa5c++3NC4byvWdc8ptRHSqM+oViaBOgoGTtpbcjHfXsxop7sUdsVeveGf7czlzwWYT+Lg8pWoOPC6fVVqqbrakHau5FY66w8L1AqF+DmyGkkEwPlF+BfJrTEBwwl4H81AY7sujeuZRn74K/2LobNTqTxKT0cN47NzS9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541941; c=relaxed/simple;
	bh=b0+EyePJigODkQCX0fGeJySIjStyI5vrn7wuW0Uzxuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=edCpVS0qOsm9s39ePXFGRmDgHML5WrhEAfhyfcFuz14Di0Qo2b0ZF2VesGu5qT+w1xi01KfJBpSpf0LSCvKUI9nxxO7e8M5YL0oSk1R/5CFzXcZai0eAtX9XfYznNhJzikV/s/Z81oewugF2F88IuMGhkCnoyK8fJItgUhWrkAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Az/ekstt; arc=fail smtp.client-ip=52.101.56.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=heqh0n7uV51CYE4xQwwKpAU252aNQcXrXulVsBCAyV1mA1Cw29XoDkyu8pVCKVRAFP8SOcVNvdEyrwxhRS/H5ReGQsj4CVlT4Z/Lk7cpN6WQRWdhy+BKiswGbe7n3yDPINji3IiXdlLkoMHbaNP+kX1xxE65quXzp/ofrZGl17t/ddnwGOoBNHR0huxIIeKyR7e95o8bHe5OC1CqFf1aYi+U8jLyA2I018N7kS8cZBstvR5edvQ6uYO99+nDpLKyjnkA+Gbmc4vcAFfB4HOGWmuQcTSN5tNhSfJ2q5CHbIPQkzqaaEuU9IBqVEgiId3b5At/a2Ar7f2ypmTcqZkJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0+EyePJigODkQCX0fGeJySIjStyI5vrn7wuW0Uzxuk=;
 b=TeUtbclmynPSF/aGOYPIVLEg0uNtK8D9iYr+A362wl0zwfakMdk8uWfNqTKCJ5U7GTHDfvclvINPDg0T837OH16KXpV+B7dch5zBCA26ZICWZ7VEN35VUbTlUmuzTFLyyt9dZcZbLoUPp7FvRC7J/F864KQrAZUsxbnrLcc2ZCF/xQI4sim8m18/HcWHdwK/RcPu4wgA+Wv7C/jTlPuZxxfglEpdxxdm+FAKyF7E8MEgNgmbqZpG2xl4SH2jmeZsoMNXFQtHyPPlO47EKh5AHPrKLeDNfwWGoKFNh3rTGSL/2oBFJRV0M/Vw9xYDqE466XgtC73huaDPuUzo1qqJig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0+EyePJigODkQCX0fGeJySIjStyI5vrn7wuW0Uzxuk=;
 b=Az/eksttVohjSIo5OA5EE6gGXDh0I0tpQxKJQMgTtlPrEO9UjdulY6DmB8pFbJ/fiOLPgYz5tqSmlnPMtcGHgtBcS/ze2mFHhh/OUHGuKx3F1rizqyrpoCBRwsfOZOFvst5By3ewGosLqzaA04+We15heAsNuaocbBYR3FAxB8lVEyy6ZubqewoywWd4+LpE0YowG0YtqdM0UgSI5SvoRepKuUJJDtWd7knkPFVGsYdqveZKVNNDK/CQOVy6FlMs29HEHXUq0eYQMdtJ6/ebBX0FBZp1r1ORMW42TjCkdHSVGvDOI/+0tPUkvWRvfCVY6ul1JfxZu4eW9cJ0oSMZsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Tue, 3 Mar
 2026 12:45:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 12:45:34 +0000
Date: Tue, 3 Mar 2026 08:45:33 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: James Houghton <jthoughton@google.com>
Cc: Piotr Jaroszynski <pjaroszynski@nvidia.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	Alistair Popple <apopple@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
	Breno Leitao <leitao@debian.org>, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: contpte: fix set_access_flags() no-op check for
 SMMU/ATS faults
Message-ID: <20260303124533.GA972761@nvidia.com>
References: <20260303063751.2531716-1-pjaroszynski@nvidia.com>
 <CADrL8HXaTz-TS9rYiQkZ6NoRWhHm0t4Tv0t=TtDXS4purLnDJg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HXaTz-TS9rYiQkZ6NoRWhHm0t4Tv0t=TtDXS4purLnDJg@mail.gmail.com>
X-ClientProxiedBy: BL1P223CA0044.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: c543519c-bc9d-411a-aad8-08de7922c2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	tRx0n676EuXLC/NbCyBMEKl51emlF1LR/AAwcGVLl0egtzwca/EbWq0LU89OmZGhWb9XjBTA0Zv/nuPDyzwAZCK9zPLRUxgt1kYXTXPO0wgFVS9zgcWpYwJbSuzzCcZjdbzYuTq66GVpqnIB6aVRYLgCrex9oHkpX5kUDvImwVqiNgKvCeVQ0GME4t1TnFBz5po+Skm+S4ZK0ujDHdoSap3o3eXJHhdTdih6unEaHUXQ+AY+IWoPLlALivOsWyIew2cvRKHv31kEkf75qfG+eJ+Ty93vxGs7zed5nQHtyoXVNsQlP4jrr602NFO/TV3pO8rB9RA1lBsjPuaTfRrkXb5Lj7HSTvlKLuOY13UI02E9FboSFIxwEKylYFkwhQjVQfNNH4siLc/eMv9D24nrgNZjxEcQYfWPnfhbYQs+nswtQjGnYpQqvSALNZLM5u/aUWYd8Q/3EFi7jEtz36eodf/AGi9cRtP2ZPQlAgp4iFiB2iNCOf0VWp447m4AehCghlhjDqD2DZEf0xdIsv6zsPKe19Oo/wo7EEHq+SP5F5z3N8RMzyyCIw5wxOIpg1xL2FSilbiI9igXqJ8aZYnwewMOkNHjuaadI18CGiYuL24EBhOId1a+yzj87p/zqNSw73ivKA3WxBVCo3NkPsOFGTnIbvy6FtlHKJKpsYSdeuKq8KGv8DWAuCQ9/vLkRWPMiBsXIhOXgHGAQFrpdGt/7ILWE7X6tmYOK5zoi1uJTWs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zw906pUMEcMxm0DMnLPRCWicrl2r/TItvInbdoE8rlO+FAVIVa3axc0WYI/4?=
 =?us-ascii?Q?tvNlIG9PuafM8Y+hIv7AW/x7vtVIeuS/WpyzCYqCvhRGjwl8u0NIcDwoGB26?=
 =?us-ascii?Q?gH3tpmryLOiYZk+VBG0w2DzhHYP2TUNuMQK/NL6bE2Q4qLR1DTHuEl25QMm6?=
 =?us-ascii?Q?W55KDv7LMTxPCINqHfH2j/f7nP8H4ZLSW6uatSM1d1hOi3HDE9XRBKYTg3ap?=
 =?us-ascii?Q?mCGQqVPU+N19RJ5izbSHyaoE+9ioas9jKV4bDVyiilQ6R2+70Qnxz1CmBIan?=
 =?us-ascii?Q?j4djIJFcmK1hirslSNy3e1MMIEuHjzmI26tL+cbuhIViBWtm1ZhL+QNybpwm?=
 =?us-ascii?Q?XJVl6AV763LUHf9NyWHnFbz5bB9MN4g7T2jJf4S7zF5DgGeqW2c/3AL04JJT?=
 =?us-ascii?Q?uC/oRPdEfEZ7EDPYWu2QZnLoLrqHTeovpWiB+GCbiQrYWRLYjWRkesKO4+fR?=
 =?us-ascii?Q?3VAqGIiimltU/shwbz2HqdK/qGe5B9A0m7rqYLU8xefeMkvGUv4rh/h985b4?=
 =?us-ascii?Q?frlSmKtTHDhMZUFkpxRjeFvkDov/+KeLYnhvutT0BeN1YFlBoXFMDHe6EclM?=
 =?us-ascii?Q?OUv+L/aJJDBb6+hWOVzEp4oErRHSt4riRoV7HlFF8FS1Fb3buYaaYZdtqVoz?=
 =?us-ascii?Q?OVEZDbmsi4vEzSLZCKhDqEHiOBHwcKaG3NscQHAHLYgQqkOFzSOjn6YiyzJw?=
 =?us-ascii?Q?CozcwmAhLJNRixgTCAQAt0D9mVE2zJ8kYhJYMMv/9MJiDotCLikRlmkUD0sH?=
 =?us-ascii?Q?TZip4/lafo09bdvN/ZGAmtQCSEc015oYMp9sLlCbfgtNJYW8lH58U/vrNcWu?=
 =?us-ascii?Q?GoSl76CHcVePSQTSLJSPOwlkoo9XNNThL7kgFJjuJGNR2pnEsbaYav+WP5ld?=
 =?us-ascii?Q?aJiV5S9tAUZ4Zmq7m0TCGqiscjvBD5+Rf7Q3WqRfvNtn5MiDQD3tkqJ3+T/q?=
 =?us-ascii?Q?G41mxYgEDQQ0GRTjAq7FeDVmP0P746m+MNTzn6r/v0WA7zLg3r5N09QneMaZ?=
 =?us-ascii?Q?XNvGlAVr3mOmMPSsmTuOhwptCaFd69rR96L7GQG1X5qkxqAzGv5Wwqb7z8TP?=
 =?us-ascii?Q?ZbP0aCPoNuRK5o0jo6BywVfCoLCEPxkwee4fM62XUgOt3sXeeozj0Yv6qYKs?=
 =?us-ascii?Q?LTHbQ3BVR55GiYdiEDAOaZCNVQRMq+okCuzctJJFuaP2IDPAQP3cZ96rQ4cj?=
 =?us-ascii?Q?gvLKozcdCRIhsMNDth0CpnZJPnOPuYc3AxX1dla3/V39xXHFSYVLKxxx94ch?=
 =?us-ascii?Q?yaf0IZtyX2ed+iIJLKZCjGppxWjY8S4gASnZOrmwNX8HSK27Uaux6hdUs/GZ?=
 =?us-ascii?Q?8ZsgBxGUEKISBNr7uk83h5+NG+d7H9L20FItc+k1wJfcpr0plZe9Ge+DJOcH?=
 =?us-ascii?Q?tBf7Zqw268KmixAcT6VZxB/x78hMwZR5JgW3y0g27aQtNUuFZVVn1gHUx0Gt?=
 =?us-ascii?Q?XMy5ksYePbqofqEXFbVbGYBysf/B5HSO8zE6LKbVsJ59r9HmPHlJk/xHiTYZ?=
 =?us-ascii?Q?YTxDnGucCoYO8Fmg8myvqludGsipsROLdRt/0a4rc9KooRF0PoC2NseS73LL?=
 =?us-ascii?Q?NUdRC+nd9YjrMI+bTAVJqDz4TiER7I7yyuHRnbJr+Z48/AKe4p4IHJqEjCCf?=
 =?us-ascii?Q?YrWrq4EuPZ3iganDgr27RY53al1641dTEYWbSZhb3DCmvyitGAfTruUx0/4g?=
 =?us-ascii?Q?tWfXWvk3tkrLSRzQqRLEMWG8JlkWFWDfGzYtcxKN24u2McL6sBxZG5bh7kwP?=
 =?us-ascii?Q?0Q/4XVVzwQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c543519c-bc9d-411a-aad8-08de7922c2f0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 12:45:34.1200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkDQhm+eNDHeEoaBDNe26YFIr3SDrQZqRJP3E/T3vcWtelmz/VrGnAerPMRBMC3B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271
X-Rspamd-Queue-Id: 9817C1EFAE3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222869-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:19:46PM -0800, James Houghton wrote:

> This is similar (sort of) to a HugeTLB page fault loop I stumbled upon
> a while ago[1]. (I wonder if there have been more cases like this.)

We spent some time here looking at what the ARM spec requires, and
what kinds of HW implementations are possible..

I think the consensus is that SW must never write individual CONT PTEs
that are different from each other.

For example, a possible HW implementation could fetch a cache line of
PTEs, see the CONT bit at the VA's PTE, and then always select the
first PTE in the cache line to load the TLB.

Alternatively HW could just always load the PTE from the VA that is
faulting.

Since ARM ARM doesn't restrict this, SW must assume both possibilities
and that means it must synchronize all PTEs since it cannot predict
which PTE will be loaded by HW.

DBM will only write to a single PTE, which means HW can create
inconsistent PTEs. However if SW is fixing a fault, especially for
different walker IP (SMMU vs CPU), then it must restore the
synchronization since the PTE selection of one walker may not be
compatible with the HW update of the other.

Thus, I think any place where SW is creating inconsistent PTEs, or
leaving PTEs inconsistent after a fault is a bug.. We found a Rule
statement that seemed to require this as well.

Jason

