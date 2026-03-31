Return-Path: <stable+bounces-232570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKY8CjkozGkmQgYAu9opvQ
	(envelope-from <stable+bounces-232570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 22:02:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C90DA370F0B
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 22:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98CA1301B702
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B106E441020;
	Tue, 31 Mar 2026 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="upFKk1EP"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010044.outbound.protection.outlook.com [52.101.193.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F04343DA27;
	Tue, 31 Mar 2026 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987137; cv=fail; b=Urfit317OOHgpaAaUb3KXUl4DAnyVPc+E7jJPgCYQMSaeer3pbXP0S30SKbFtxz6CTn8Mo2rtD9jjHKZc940eLbaEmlhoYPmG2H0WHStHIzSpxfPjTU3w2vyslEtgp4XwOX7mw22DoADE1F76UvtMA5yLJWRtOr/DHcos0sipbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987137; c=relaxed/simple;
	bh=qdj3MbNVayYQcQ0BLeqx1Qs8mi25fh79LGUqSD6RiaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OYP2QCkjeI+xKmazlggOE0SXbSvd0FQObhkN+O0eK6WrEsM5FOf2z5f4NHcbr4zqw08KtsJ/n/RXDmh8PHjq1Y80WnrX3lW/o6Z+qWz7e0rFl3lYeW2NvfTm5LRagzjAjMMyzUUQCdAUQu+QpZHf0Y50vf12eM7DMXMp2X5pMbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=upFKk1EP; arc=fail smtp.client-ip=52.101.193.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtwAMMKcKiG4n14hPP3McN6QpWRFb/6sKb66DO9+y+nzE3mQVShnv/In5RGGKxJxGpTqtnGTiOUEVxLeIVYd8QT5XZenVc887WdK3uaSDvK3hWe/T3x5913rsRpY1ngrGUyaI6Zdnsgk4odDY2WBlLKakUnaC2aWUiT7ayXMExtl5r04LmbgaufNJYXs4AfzjDJrJZFOebgba8W7OvCilRCECpsXSAU6rw2Hd6uvbIUSn00AD7TA/PPKQ+ISZ16vSs0qopQD7NF1T2qrGnXYPunhOWQ+d6ouIvX1CmbvejDSsSV1V0x6XN+lV5pPiHn4OSpDttgLxHyiYZ7wCNKCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ncm9WJJ42JFGt3EUPh3kQgJE17tTiF9YzPoIoBzrEH0=;
 b=FOR342WEaw1XVZS9OSrSdEsJWQxGWuk9CiMKpJmzLOtPeU+gVmzzqUTGsGqDWFuMuDZYdU43IYmNARDbBCrIyacZy1U2gmHLdvcLuchFkkZDgIlczrVdP2Txm+X0p4d8AAsByAb0tkEJYVPp68JOeBkERTibfcEaJZFxttWEOSMctYa/0J4Rdhv5pYhMaYo5MLZoRK/jpqyF3x/rpi2Q5iTF+ZyAmPooRpi8h4OW7PpgtU+Za2TYkG1ef7RSW198WPRHejG80+f3fJeNw6QuEZZztq6B4emp2PB1CGAKSZO626EyOaCisJXdZwrm0XtMWUmq6/CMt/GlpitdWStgjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ncm9WJJ42JFGt3EUPh3kQgJE17tTiF9YzPoIoBzrEH0=;
 b=upFKk1EPP9AjoUtyX60+gO1KL8ctbdPgvZAAiyTCbFoFRKq1iER6e8brbcusn6mKWvFhnQHaxxr3H7EtlapCQ4j8rzgBVXOGyLZ66Rl8uQyQBVRM6dwn7Gpjqf/uBxt/TXh0/GBlJn4Rlxk0JCxngpQzG71yvOM/oEBl4WM4MkCGRpmIHVuAb2AdwSq9EM3mCrQEqYEjtftfnTWSH5YoB2o7M/QRfnVaiYmNMJzCcu0S7Amyh67nGLog3CmlrFvTyzpXmtlt0fToypGPPoEtnqi0Ulj0XKS4jAOjtI9p9AOrihIoq3kII+vveOIG4HKAykgD8zy52qOlsM0SULRN4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB9053.namprd12.prod.outlook.com (2603:10b6:930:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 19:58:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 19:58:46 +0000
Date: Tue, 31 Mar 2026 16:58:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>, stable@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH rc 1/2] iommu: Do not call drivers for empty gathers
Message-ID: <20260331195844.GY310919@nvidia.com>
References: <1-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>
 <8800a38b-8515-4bbe-af15-0dae81274bf7@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8800a38b-8515-4bbe-af15-0dae81274bf7@nvidia.com>
X-ClientProxiedBy: MN0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:208:52c::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe74466-3903-4b12-fd88-08de8f5feb0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4RBGAG+lgkj+0Gd5hp4prejrtnnehTZjod0+Stl55NthvNfNbwpM/BewBYW11hpqQKLoBiJT4seJPt5R1gRq4n2xfN+o5KMuc4JYvwpPxKhGP124hzEHqb4KFufRKWwrh0TTbP6+LTAgi+2Bbz7N/KkXIelfyEpU0CdyWBA7BM+csh/oJLbEmfiOG1Jey0WX7bbJ9OZJeyVNpNI8E/arBYObj12rBEy3APSRC0LihQu/SFMNLlEYkSi4BeyZpLFJfMfViX/wyg3kt2l+sejBhH0+jJs842VxCN8rYZhMHRUObTdqRvXgz4YgAUWnoZSeFQ4z+qzzUOQq+hNpTpFhV+LjynxfRFDMrydYJ0mq8TMmdHc/FqmkpcJfyPGEtChyLXg4xSEVJtfrkj780RXmj3FEG8GcMXJK87gEbg4WeD+Jo4/YJeEvfhvatAxtccCDz5oU4fSCRpP/EYLfPeV3zYZ0pK/H4eKP5PakTqGtaaIomrTnPzLK8Il6oa0caSlEI/o5pxkTJF32uRbZVkzykDk6KUCH8Yh6y3ey3k3FXVWZt8ePXjQsgrXylJ/WJ0XcnKj+jTguocnwu2NNvzAh5CioNvWXvo8k6O6iry6q5+SYuO+ESa3cNX0pRcVemf+cBjBCZwUQNKUbb32XoKDNoibcfdIl7MBEUnTIRdZoqOVmvO6sEBY6vV5QIIzJ4DouHP7tK8gdtjvqCOq8FtUKa2vxa6T/ELw98kShnDvOkjAtGTzXNrD2YdN42WL4x2lK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dWtnGGp/elCDsCXI6iZ6TndcByYN7GNMeZT3XvfQIGhSIdWcUWHu/lQx3o5/?=
 =?us-ascii?Q?jEkFcsGFnNw3ZKLFfMmJFjRYNmYDgRnA3Bb7IcADGCTb6R986fMVh7RdDFcn?=
 =?us-ascii?Q?xqkEfPFWjQfj4pZQkku817FJaW4Skcsncxi4nl3VlsBJiZSMm2zlOnRNiDWi?=
 =?us-ascii?Q?cBTlt8oca7P25v5T4gWjbwev1Ve/Z4RMvyIQGAs9uqMyYk0DEP6Qh/BQ9oFC?=
 =?us-ascii?Q?2P0EZR0IkXofMj+2IG6rbEOTvwcFw8zbn8p3UKYlU/tXpcvhoreM3+ibpzYw?=
 =?us-ascii?Q?Ol8nlPVoAIpTl+GnkY4XfTUH4EWnqq1AoQ4M7IHS7QAnF63oRuBojTlsjrPg?=
 =?us-ascii?Q?G+llhh1r9gTv48HwMQqC18jCeSgxGDGog7Ocxx7oyIneCj7H/iwICIDW7zIh?=
 =?us-ascii?Q?VqxpKsOm9NqwGgELC2Ue2KVDDsPZeTt1U1ZDozi9yQyracLUAW7BcGmWwUdP?=
 =?us-ascii?Q?Hv+S5H2EXN9hLuG8idIDOurs+2ZXo6ReF13fgniFRRF2Uaa6eEqk1wG1mJxV?=
 =?us-ascii?Q?TfEUeJwnPflasUYqDdLHQCXR9Yuf2F3xHy7Qh6xYujj6hp9Nb3PuMnYz0PQ0?=
 =?us-ascii?Q?6N+uKnRTb7v2Gs3ggZFgcF0PloZdTiYg954o5GFlP7sOPBnHYblOTNr4UF3a?=
 =?us-ascii?Q?JBy9gAw9Q0FimYp+fSoW24dKCq4UMgJLUMGIIeWij+ZYnxR2cV9PtDDgEx0I?=
 =?us-ascii?Q?cDMoy8v/CNkrFhkhVpQyd4278e/LWD+dPniC4jmHWoUrFRXVmNy3jdBFGOJQ?=
 =?us-ascii?Q?ARFn/5JR4OgjsCLSHb29uRRRODaZZwX74xIV05/qVOIHqDqKdsjwiAY4C+xQ?=
 =?us-ascii?Q?QI1RWl+sKu0sTsxtANf80vOs596a8DE6LdUX0ngW3HjUnzNpd8WHOGDQXyjv?=
 =?us-ascii?Q?10MD/U3YapLQxmMc89CUJGSeFov5PkKFDwbQ+Be1S7CmSfU+YEKxoSWujyLg?=
 =?us-ascii?Q?o5ARoErcRH1xugsk9HvK0tGEGWK8Qy2x/shfkdPQLSTjJ6EwLGkwNGYj689T?=
 =?us-ascii?Q?5Tv57KHgSOPlPNHvIQg1r/SDMv86wckejHLilcJlmUSzE3u8KYJkt2mehYLS?=
 =?us-ascii?Q?IHunklLEZkCwOaCuGHon17kEfEYNY9uUa9F7BnH5TSW+wSqeV/KDUqBsmKD8?=
 =?us-ascii?Q?wZHOnQFBtvEGNi8OWW8zz+52LjvcqeNLKvuvCk2kYL6KKubSK+IwD7qvU8bJ?=
 =?us-ascii?Q?0OUqpLDKAtJk/OTgk6ObkWW/C/l3w4BATYyfTPQfwtVr8GJxeZ2T2GuoZoIb?=
 =?us-ascii?Q?i+3LRl9J9BAJgmQjikSFzWjDE3BsPB7rBxXn3Sesufoue7e6uQHwf+02j9vN?=
 =?us-ascii?Q?Y+zx1bkeocjHyEZoLwrde+Lry23N14zsyMaBlht0PAk03D4dB737TjyiIuVi?=
 =?us-ascii?Q?rajJYfjj7h8rlWkt5WETG1Zs1HrWrmU8XiHc7qZSpHMeVO1MyJlmLlZO89hB?=
 =?us-ascii?Q?TrGkI7qqm8gvlcpSm5laLME304qccf7F5nXo5MHl/E47KWMY4mhxhhFc/BXm?=
 =?us-ascii?Q?82TDGU44ryu2ToHIi9Lc/0ZKBDdNT0g3h5n1JP5Siv+dFn6HHTX70yB6E77J?=
 =?us-ascii?Q?+LZEQFqrVsABcH/w5zqwdyo695phNN4ToBMDq5baXF1zOnQ06m3XiIxmDwaO?=
 =?us-ascii?Q?HVeV05ET+XiHmcykbn8ayftGx+Y1XsKVu3EgxYVc+jXG04uqU2HWP9+zKXWM?=
 =?us-ascii?Q?0quza0yAAj8S4O+aQUa+LUh5Ptkr2FivRLFbDs1ZiP5XJNIX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe74466-3903-4b12-fd88-08de8f5feb0c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:58:46.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsyEBU0OPrxxcsXChRXM/t5m59octsFr5rN+m4uHyc7nahW5WoP/35X6aou1Iuf2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9053
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232570-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: C90DA370F0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 06:12:18PM +0100, Jon Hunter wrote:
> I noticed that a couple of our Tegra boards are no longer booting -next and
> bisect pointed to this commit. Reverting this does fix it.
> 
> This is impacting our Tegra186 (using nvidia,tegra186-smmu compatible
> string) and Tegra194 (using nvidia,tegra194-smmu compatible string) boards.
> There is no specific crash I see, but the boards just appear to hang on
> boot. If you have any thoughts or things to try let me know.

Thanks, I was able to guess what the problem is:

https://patch.msgid.link/r/0-v1-664d3acaabb9+78b-iommu_gather_always_jgg@nvidia.com

Please let me know if it doesn't solve the problem

Jason

