Return-Path: <stable+bounces-180873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EF9B8EC8A
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 04:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3316916B3B6
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 02:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE8E149C7B;
	Mon, 22 Sep 2025 02:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LMxL954M"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0CA288AD;
	Mon, 22 Sep 2025 02:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758508600; cv=fail; b=Lo0Aoq1JWyhLbsZyqaoy+A2nunurb2CKs8pGp34tgiQU97QW/LjxHmexNyYjM046Je+bRzsFmpBRvLSDN4N42YpwlnITaCCRAgDqf5IzpyeAJ9VpYuIjbeclM1lAQjJnC2rDL5qCRCiniDh2lpPbYqncyzUHBcYx5IvqWsIh5So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758508600; c=relaxed/simple;
	bh=QM2e+HJd0edLFPaDqrrUC5aVHlWIACoH53YJuZ8Et38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jo6Nt+vPaWgHNYgGpQD1jkPsYyCv7IPC/FPsKl8wjt2nJuOZFu5Es9BGuGg0kLvBcyIHiwumIWNnW+2XmPAuZW419EK0L+T9f8xbbh0d4pU8FopztrZuH6LwnRGvz25uAEsV2IfGiCAjuuTtmIIfH6G+MuSleun78nP4BRuImPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LMxL954M; arc=fail smtp.client-ip=52.101.85.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOGfDF8vmSToeWl5sZtzy+DGShwYfQcPBHY72lAWVT2YyVlcXGUGKepWtemwysAxqGPcArl8MA8N9IrAD9LW6zJsMUxGVIL4+POMjo5nymulTgKlKDqWMOWI9joij2CbFX+5FiX34oUOc/5LjLoQ9+k2Lj48CSX5W7RauILVuAaPsjppWn1JHFojSVg71eDtY8IKNbXLPC9z/Qho4IRF7v8cW28z+EjwqaxVPuJIkXR8ydLK/GAGMR5PLoNx0Na/43oz57scQMTddYLkjPSpAJDMCbOXUt5R0OrAV16ZiqAsPN5hQDY54jMGiLweAFiTKBIDAAvNIHDnBpny7MR31A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+o2WLpisjXCuKWaK6xhEk1hFN6SCrD4otNZT4TpP0M=;
 b=KqPCXS3j9EDfqgZH/lg5MXVlEIbTUPbRv7EF/DOqqqaESnpBo3oipaGRxE+0fHk8Xb5QkgpQeLfOZLhnR5ys7/CxWB3JODQvXtUbbKrTv4KM9nqt/es6gz65Wk0f/bBMw1EBcylSP1WLhqUeyIQBA+L5HOeBuNNDDZQz5jDhbGOwLpZ518C3l8gKfS19vebhUbuVzv76T7O6hHK8YToTDT0NMTJct8h0iIFMwu0VhweeK3myhiflBSt2z/u5XpdQZwE9AzvC1m8l007C9LdAeM939w2PugGEnqjAzXkJfduY3IErMY4ouCGw1Qi8z1E5lR7IWE28TzzynumE5gzhLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+o2WLpisjXCuKWaK6xhEk1hFN6SCrD4otNZT4TpP0M=;
 b=LMxL954MXtCrOz/qX9rdSYEkVlQiuMZ1TNAbPI+NORGoCG+wESJvmaJydYOeLNg8lVbT6B7L4bClE+TxElgPvi9bz4AwJ6OW/w9tKgCEYN8ahlc+ccVfwWD6JvOAqBjAx28/4UslJjL8FajhwTnWklDIQnXTycVxH89SGVJHo/ad3fI46SbSTyt1qwEzPx4wN2fm6sHb1hEt6Tb2rsupLgNiOkoMsrd1cz678uoo0+VOcznrFAyEEGm/gblqnyZn4NG2AaSnpYFQiLG29tx7frszNi48z17gj6xk/adBFHfY2TnATtyqlVTCTOwiyfmV0U4XV/ErYE45Iux8+R2Jzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PPF64A94D5DF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 02:36:35 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 02:36:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 usamaarif642@gmail.com, yuzhao@google.com, baolin.wang@linux.alibaba.com,
 baohua@kernel.org, voidice@gmail.com, Liam.Howlett@oracle.com,
 catalin.marinas@arm.com, cerasuolodomenico@gmail.com, hannes@cmpxchg.org,
 kaleshsingh@google.com, npache@redhat.com, riel@surriel.com,
 roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com,
 dev.jain@arm.com, ryncsn@gmail.com, shakeel.butt@linux.dev,
 surenb@google.com, hughd@google.com, willy@infradead.org,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, qun-wei.lin@mediatek.com, Andrew.Yang@mediatek.com,
 casper.li@mediatek.com, chinwen.chang@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-mm@kvack.org, ioworker0@gmail.com,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/thp: fix MTE tag mismatch when replacing
 zero-filled subpages
Date: Sun, 21 Sep 2025 22:36:31 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <3DD2EF5E-3E6A-40B0-AFCC-8FB38F0763DB@nvidia.com>
In-Reply-To: <20250922021458.68123-1-lance.yang@linux.dev>
References: <20250922021458.68123-1-lance.yang@linux.dev>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:408:f8::32) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PPF64A94D5DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3cfde4-1ff8-4437-9df5-08ddf980d8fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p0KjRGSrLNvVp1i3RJ9FTvfSF6r5ZYBTky2TfBUoTPycbsrZKNN70lyM007E?=
 =?us-ascii?Q?cJPkydl6xnzidx8ahaNMH59flsj52x4hTB8I0K7XhEnbxmMocyEkd+mBbYPm?=
 =?us-ascii?Q?QzvYCQbM5BF92q7tTxyVGT3po9nABYpkj46ryGu3tTwxxAwPnlSxt6z0MMTC?=
 =?us-ascii?Q?YwfRddtaA33gQKKVhjIzrulUOLzJ4f8K0gXI912z/SSm5+neiksB77r5fFe8?=
 =?us-ascii?Q?B+ZmNY0dN0aVjOZ22OFeJYv8TOlAz9B5q3aXELQLYqgeTk4OnJxZlqkDlbeK?=
 =?us-ascii?Q?Q7QUM0JidFaS6oAuNxrsP238P03lDqFM20NeMBokAoGOJICKojorUREgoCf8?=
 =?us-ascii?Q?fJDtW6nza+K+1ltEccENvxWUfupI29moNQzFFQp0JFfqkDuLWrGU160UAji2?=
 =?us-ascii?Q?Ceg1zEUeKDpjuuDdLdYlb3t0NVJN70BmsgbhnToiFtC1juIasqNL6o3lfcqZ?=
 =?us-ascii?Q?EQStuVNq+X6I0TnmegVBglmkpQvLFTQp5cw8dPss3+aN/OUukVJ9WSRv0ffY?=
 =?us-ascii?Q?aR6aJivM6YAEn91QKpB591XRQVObdRFMUSy6ZmNzsJFVux5tG19Zyqb5IiJq?=
 =?us-ascii?Q?zMMFc4X0iW8PN/k/SRUF2ltS4XP0pvmK651k78dnfKhfNudPeTn8t0BxUJzl?=
 =?us-ascii?Q?3rMz9YKc7mtOssi9vr8dDkQb/wCx6FvdziM5XDcWsq/sEA/rqyn2naWQKa0Z?=
 =?us-ascii?Q?0uC1/uTeLlvnlm6FanBGOh+wmzDgMljJNSMh3tgD44InGtsIMgQoJPYXQqiM?=
 =?us-ascii?Q?iv96fFwas9kNGZfAMa7x2kIksp/GVpwSd2+oGNiHTNKTwPe/fMqZ8kSwFhvq?=
 =?us-ascii?Q?Emk1B9ZspEsf0Vbm6lo2XSo92kvOkI/KesV+g2eoqlSqGlFdDGZJ64ruPGZT?=
 =?us-ascii?Q?nCz28q2FPdgCxi0UwyUcaSDRlE+CSxVUPhf1ahlbNe16V2LwYdbHjw0rU6Az?=
 =?us-ascii?Q?qsqj03likoFhGftD6TgcweKdqcQmfV9E8CA3cO0SC2rVJiz36H0WDBuuIvIm?=
 =?us-ascii?Q?esDeL+ryv4WsIO0Kwr2Tsy3QDPlc8mcVqGxgPS23xqr/Y4IvO8qEW+3CSpEM?=
 =?us-ascii?Q?tCO3mXof7O37LVuHQiLURoPeiaXdzsPBEWvSm8KVYDluacRirS7GltL9wsl5?=
 =?us-ascii?Q?PSK4c83R/8P1bJTcDHFbZpjBmUksMA4o6+k7L2QcxcnJg+JPSigjyr2PzAgf?=
 =?us-ascii?Q?9MQvF7j4vm6dCezA1Nmn4bFqonmEYyyjWWJpNt7PKzBmDjv6hyFW97DmskIm?=
 =?us-ascii?Q?vRId4D4sECUMf70b9V41yEBKjIrBYMMCxWChfyngmZPe9G6oP2UZFxToholt?=
 =?us-ascii?Q?AJPUk/P9jfaub2z1Iw3ydgpAJFTtzqSpkMMPNm4qDyveD45EAqW5CdWXstOv?=
 =?us-ascii?Q?t3rWI95FnWfUcCtOZLidIGq0sKksNOfyo16DFL94pT50+/OOmpfzYLi+xpQc?=
 =?us-ascii?Q?wwgSFuxiVuEgNKkOwxRSbLke3Ce6LlpG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h06pb4gdtSPKPV3NuNG/AZ3EjsaT8yFfczPs45kcvs+0Y/cR7oqpYdNlrQAe?=
 =?us-ascii?Q?yfJXidMHRYNwAk4GhT5pfYxHo3rmApIJa/CtGn9GviH4RzyPx4iz7vm2bYmP?=
 =?us-ascii?Q?RQ1vUW3c8M3qr6KWV12exNq4KZDpR8bBO2Q/BY124G1eA60vh0lltCoDJ4Hd?=
 =?us-ascii?Q?AjIjn20HQDdhgxqLUFPQmnNuT7WIBzIUTo/g1fECuI7OxgywBe/Id/NsIxC3?=
 =?us-ascii?Q?tixwhZslocl0I7U/uARcqNZRJqtxK1qKCDTXoNBR2xQExbHntb2fYXkt8x1q?=
 =?us-ascii?Q?4y/GCh6r5/OCEwlN6mUkegYyeZ8TGLLTFDlhFVp4xwtMpl6E3XpE68LJt+xf?=
 =?us-ascii?Q?XC6rjd6aDwMBvoQPEpaUKzeAE8NFcfVTo7NwaDH23w95QyNbAH4skjXKYNfC?=
 =?us-ascii?Q?DJsBXe69rcwV2CaLEvGJSrYZL4bZKDuCUQn4Q0ppDKTiWuYXlgwIOuxOnkrV?=
 =?us-ascii?Q?lY1dZk1PUVVjbCAA0TsnvsNz0vibcTFIxEqk1XoQsjYlu4XCaScZOiYQl6jH?=
 =?us-ascii?Q?tfGgZQu5tS3em7EuB80wlAnNRg1Oqd9bA9XqXVcgGytZtTODY+cZLd3duACB?=
 =?us-ascii?Q?oYHaRt8Qf1mJSZSehIbQUfO3TFigcEouyDKlPn/tRgKgym60VH5Xvx3PbwkW?=
 =?us-ascii?Q?OHy/v/7eKtVV47shTGm+SU8EKt9Ay/30nsOjKNLZhN8AYOehiVNjFlcxjoaA?=
 =?us-ascii?Q?t3iNKJD+e+6FOwqXSsE0F/ksbpsuIDAPlptuN4VJCmu0bn0gh3jqvc7zlP90?=
 =?us-ascii?Q?aK1NGyL4M13t3g259/Du0Uxt1rHMjXwt94fCagRoH6AxsQ8z+iv466AQaI24?=
 =?us-ascii?Q?ji8pbn3XDEucXD3sJ2bwz4KRketO1+OGq0XYqIkYGFlRJtnWNlTzJ7uc9IUa?=
 =?us-ascii?Q?Qk2PWmqLHLmmswv93hNmek/NB7oEPmj0oZ2wdpdRkcvA6f9ZRI8hZttc9Qb2?=
 =?us-ascii?Q?nDesRGSqffXoy4ZsEBCaOnh9UoxV0EQt7+tcQTpbu7/E6kTcxIeI/G4xS+2x?=
 =?us-ascii?Q?+/RA5lcSpWbgr6YVGGCPU2JNg0JWqGmU+i85EyWbstayvH3EwZn0xk7g3CIe?=
 =?us-ascii?Q?DeOR5Ie8RWK5jk1akz37xJs5Iu9bNIMF+1RPD4LIRd2MBy9DSovjD+8ivuvB?=
 =?us-ascii?Q?fXLDIavgyyBSAAVp9WE6PxQIJQLKFHhT3uqoFx2o96S55UHZRfWX9xwAWZRo?=
 =?us-ascii?Q?rRhxJdOEbdVzmp6XOwyPoo6rp5P7hnK5FtIbcIua2iw7oCVGF11aknPwU3IL?=
 =?us-ascii?Q?WRAsT3rPM1L4uVPUeE5OMO6sx9F/OjmCAni8+5cxT01xVokN/T28DDoq1OVd?=
 =?us-ascii?Q?pL2nlC8jGNo4/wfyZ6RZguIn9VbPU53Iiok28+/l97ufYzIOyH7WDIkyEOIZ?=
 =?us-ascii?Q?FPSodgjIxO7IzRCT590W8Y9gygZQRgP2FtUPjy/U9mxz3Q0psC1ypxEkbnY+?=
 =?us-ascii?Q?7wtml2WViJRb1V1u+Xv/tTJCIb+HfGHhfRSN1W2MBjr3wyOOUkgnp/95ZuUf?=
 =?us-ascii?Q?rnRGU7suPt6C8oBlz0e/1hxxYI7sAu8YM9ot8hXVNxIzl5nGLznV+1cEEC87?=
 =?us-ascii?Q?5jvkgr5Z4UwDLEZM0YY0xMmi3k2fp0vUuHOUnoNG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3cfde4-1ff8-4437-9df5-08ddf980d8fa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:36:34.9419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Fun+khF8E0k7+HGMzSGMHyD0+UuW7xmlMp5sxHpsVmRy+/7gc5cQsjWgL6Vnth7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF

On 21 Sep 2025, at 22:14, Lance Yang wrote:

> From: Lance Yang <lance.yang@linux.dev>
>
> When both THP and MTE are enabled, splitting a THP and replacing its
> zero-filled subpages with the shared zeropage can cause MTE tag mismatc=
h
> faults in userspace.
>
> Remapping zero-filled subpages to the shared zeropage is unsafe, as the=

> zeropage has a fixed tag of zero, which may not match the tag expected =
by
> the userspace pointer.
>
> KSM already avoids this problem by using memcmp_pages(), which on arm64=

> intentionally reports MTE-tagged pages as non-identical to prevent unsa=
fe
> merging.
>
> As suggested by David[1], this patch adopts the same pattern, replacing=
 the
> memchr_inv() byte-level check with a call to pages_identical(). This
> leverages existing architecture-specific logic to determine if a page i=
s
> truly identical to the shared zeropage.
>
> Having both the THP shrinker and KSM rely on pages_identical() makes th=
e
> design more future-proof, IMO. Instead of handling quirks in generic co=
de,
> we just let the architecture decide what makes two pages identical.
>
> [1] https://lore.kernel.org/all/ca2106a3-4bb2-4457-81af-301fd99fbef4@re=
dhat.com
>
> Cc: <stable@vger.kernel.org>
> Reported-by: Qun-wei Lin <Qun-wei.Lin@mediatek.com>
> Closes: https://lore.kernel.org/all/a7944523fcc3634607691c35311a5d59d1a=
3f8d4.camel@mediatek.com
> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when=
 splitting isolated thp")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
> Tested on x86_64 and on QEMU for arm64 (with and without MTE support),
> and the fix works as expected.

=46rom [1], I see you mentioned RISC-V also has the address masking featu=
re.
Is it affected by this? And memcmp_pages() is only implemented by ARM64
for MTE. Should any arch with address masking always implement it to avoi=
d
the same issue?

>
>  mm/huge_memory.c | 15 +++------------
>  mm/migrate.c     |  8 +-------
>  2 files changed, 4 insertions(+), 19 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 32e0ec2dde36..28d4b02a1aa5 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4104,29 +4104,20 @@ static unsigned long deferred_split_count(struc=
t shrinker *shrink,
>  static bool thp_underused(struct folio *folio)
>  {
>  	int num_zero_pages =3D 0, num_filled_pages =3D 0;
> -	void *kaddr;
>  	int i;
>
>  	for (i =3D 0; i < folio_nr_pages(folio); i++) {
> -		kaddr =3D kmap_local_folio(folio, i * PAGE_SIZE);
> -		if (!memchr_inv(kaddr, 0, PAGE_SIZE)) {
> -			num_zero_pages++;
> -			if (num_zero_pages > khugepaged_max_ptes_none) {
> -				kunmap_local(kaddr);
> +		if (pages_identical(folio_page(folio, i), ZERO_PAGE(0))) {
> +			if (++num_zero_pages > khugepaged_max_ptes_none)
>  				return true;
> -			}
>  		} else {
>  			/*
>  			 * Another path for early exit once the number
>  			 * of non-zero filled pages exceeds threshold.
>  			 */
> -			num_filled_pages++;
> -			if (num_filled_pages >=3D HPAGE_PMD_NR - khugepaged_max_ptes_none) =
{
> -				kunmap_local(kaddr);
> +			if (++num_filled_pages >=3D HPAGE_PMD_NR - khugepaged_max_ptes_none=
)
>  				return false;
> -			}
>  		}
> -		kunmap_local(kaddr);
>  	}
>  	return false;
>  }
> diff --git a/mm/migrate.c b/mm/migrate.c
> index aee61a980374..ce83c2c3c287 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -300,9 +300,7 @@ static bool try_to_map_unused_to_zeropage(struct pa=
ge_vma_mapped_walk *pvmw,
>  					  unsigned long idx)
>  {
>  	struct page *page =3D folio_page(folio, idx);
> -	bool contains_data;
>  	pte_t newpte;
> -	void *addr;
>
>  	if (PageCompound(page))
>  		return false;
> @@ -319,11 +317,7 @@ static bool try_to_map_unused_to_zeropage(struct p=
age_vma_mapped_walk *pvmw,
>  	 * this subpage has been non present. If the subpage is only zero-fil=
led
>  	 * then map it to the shared zeropage.
>  	 */
> -	addr =3D kmap_local_page(page);
> -	contains_data =3D memchr_inv(addr, 0, PAGE_SIZE);
> -	kunmap_local(addr);
> -
> -	if (contains_data)
> +	if (!pages_identical(page, ZERO_PAGE(0)))
>  		return false;
>
>  	newpte =3D pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
> -- =

> 2.49.0

The changes look good to me. Thanks. Acked-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

