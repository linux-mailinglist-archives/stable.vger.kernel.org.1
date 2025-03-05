Return-Path: <stable+bounces-121121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2A9A53EA4
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 00:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB241703BE
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 23:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3065C20766F;
	Wed,  5 Mar 2025 23:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VXyqVFM9"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F67C2066E0;
	Wed,  5 Mar 2025 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741218581; cv=fail; b=i209EgWcRyftIxjW/Nkt7/zKYvT62OaAOVOGCWMZheuhz2+Vwzxrr7aVXAFC9uM+BlU6WQjjNT2JoAPTdfsKIzhqUuPyAjd0kTwEP+0FH//X/gaHJgXdFODgkAIXmVBiFMjUABlxfi+irCC/NgdLDTqjqRTcvcOHEeQpuSCGhQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741218581; c=relaxed/simple;
	bh=sRWQWd7HVnYZQOYq2+1NXSiKe9R7lIePkS0NDUuyPZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SswBJKi5BqVmBul7dMWQws1MSGHK9ATaafxI9bYRNCIfZCiVOycEYrHb1MBumcsOzykeq9XFlOT9etGB1RQE3Fx7GNa+uf8pFVzp81Bl4HotHhhKPXKH1lUInwNSMaE/3mGK3hesMfl+jE676dUtakXYDSGWwUqyy4MoSeN7Cb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VXyqVFM9; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihDUQxYiS5XdxEwCvYff7KqUoA8RIYaumZe7oaW6Ndl8tR842+9QV4HyZ2nXMRILc0j0vpuePdcyjCyS9u6kMHUM3T5VsdGEEkxjmRqTVmLhygYJ4qds7e2yarCVhLexGXVmDaUA58ITqy4KLg1lUQoIyf4L6T27x7eZyzSAl0qIId8Cd7vmJIwUcczGdTgFJpidoDvhgd/IjEFUpifhj5PoFy1NMbaL/adUk89A3wrZ27/oP+aS12qVwqOm/RwaWiFJBhlobiiMfK1oKboFcxJC5Gkl6YiGq6R7/OMRQEVW7H7yQdJFAOVbKVrVzZjERbLmW01yY23iLCXezRuhjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qvQNskuO6Np7E218JAvUDDNHnxxzV0YzVQEeuSkkLU=;
 b=Oso0FgjjenqPBHU4YFZ7Fne4bHbTjL+S+OOJohJDfM156qxo+gPfQjKEk6+QPZfUneCs4j4uTKml70m6nJaQKxp5UuWXY8aSsD2gGyq7OCaSr+0ms3oq6e+8Ori5H85ZG/RE0Cv5TPebrcSv+RkfTdUcBZM2MusDlvAfkc9uMiK/fn6oUOGEQjr9by6vGH/5edgmqTEH+N6M+shFwJx+yL7ImzcwWX/NkIgBnEkBi775KJM5ZO/OFnfc3Qv1d4A8Za7/V54YP2eWLd0A5M5JsIgxXq9jvkTKtNOkzK4XbdbpFXln+/icHKiRYOaevVttVDrYg6Q2Uf6A7lcdzbxGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qvQNskuO6Np7E218JAvUDDNHnxxzV0YzVQEeuSkkLU=;
 b=VXyqVFM9P0ykaAzpE/vHC4VT1GX17GIjsMWTz31kgvcLlapetrIfAdImkb7uWS3B4F/V48rQ0mu1R0Bo0g2okv4BsEpdCGHcjtRjgHi3Fd+mp/eNxcRYtTYmZtVssif7gBjS66lswN4vZnJttdsk0KaBGv1tWPtt1v1hJm47Exjgr9/rQR4/M+F10zLAHFpyxY0JnI9dJcHVvhck04mOyRTBG7N+DpxZExW5gYEjdb/NycC/VCRLWxllfDDPbb2rREMnSxnVumB/wq5NO2uYRq0nvueRXK9Ic6pBQtavlVHXYnwil1L03XrIxzCgjj8383JjHMJ+B2oE3ufNdUYsKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.29; Wed, 5 Mar 2025 23:49:35 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 23:49:35 +0000
Date: Thu, 6 Mar 2025 10:49:30 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Piotr Jaroszynski <pjaroszynski@nvidia.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Robin Murphy <robin.murphy@arm.com>, Raghavendra Rao Ananta <rananta@google.com>, 
	SeongJae Park <sj@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	John Hubbard <jhubbard@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] [arm64/tlb] Fix mmu notifiers for range-based invalidates
Message-ID: <3wosp7lqbcwzspgv7gq25ii5hdr3fztrvnhcha3uqcyellulro@xyz7gx7qjkq2>
References: <20250304085127.2238030-1-pjaroszynski@nvidia.com>
 <Z8iccxCo7tkqvE_p@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8iccxCo7tkqvE_p@arm.com>
X-ClientProxiedBy: SY5PR01CA0104.ausprd01.prod.outlook.com
 (2603:10c6:10:207::7) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH7PR12MB9173:EE_
X-MS-Office365-Filtering-Correlation-Id: ac77a4fb-090d-4a46-adb8-08dd5c40621b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2KkQx2QyI8NxNpNgZcsr9DB66Oqhazwm4//RAEEJ4yS63d+LWZfcXhw/+EsJ?=
 =?us-ascii?Q?Tp5a/IGV/ciK2URrH68uczAKpmUU3FKrx0LYA3dg4l6W6pI1be4ct9jDVK9J?=
 =?us-ascii?Q?gX32pi4BUx1chbl36xzTQLwhZcaw0QLdNhSC845MGDRBOKV6++tR24k5SMpv?=
 =?us-ascii?Q?eCoGWIpOLzH9uYUtDjACBIcQsXWTS9nTSVCgwOhxMiq5NA1e8Hck5VV4o3YF?=
 =?us-ascii?Q?gDJ5IS29qy2NxKFSzi4804QTunZ0c5Wf1FaVHUQ3EO+lXDPDaaZ8ozfNAOIr?=
 =?us-ascii?Q?xDGP9culkp/71uRsa1oFwJzivg5qejTBm+uRzfdgGTeQ5c0v3G3wMM3s0lzB?=
 =?us-ascii?Q?huL2GzwTRkK2oJU9+bhhhUEtSmWMloejMWO897IT0FeRSnuZqy+tpkWs2Yc5?=
 =?us-ascii?Q?iIz+mH2eh8BfQQGZfKrCtg9BbmlBYRknbKy81ttA1ibrF0AFnYN8jMFzfXzc?=
 =?us-ascii?Q?ajyokkFN296JZv4pLHJdvxxOw5bhzrUAIxCkfTabIkCmFcVi/lDtPVLZUO7o?=
 =?us-ascii?Q?0A2Vuf22BREuWh3/KZ6uFWiUQjXqHL3GeDLpa+wlDpxMx8BvyUCV8IoRjbhm?=
 =?us-ascii?Q?RaB/4wX6ll5sESx4koJhhBbPEsg+UpgZ4JJOzdk4M9vfAzTmedX4I+uQMDJQ?=
 =?us-ascii?Q?svCTlL1SXtmcPhBCa/fOllC5YBAjeL8ChzYNC6arjW5LlZc0W0x88Rols4Ch?=
 =?us-ascii?Q?x3gtzKwzHM98eoyh56LE+zHlxcTzM5W5OhBEQb8lUOoUUT0C5yU1WW51Iy9g?=
 =?us-ascii?Q?FosumCR6D1I98I0XsGYiudtiZT32WoPudAQ7visN/0BVsub9YRfQBNuU0L4g?=
 =?us-ascii?Q?X6vVlnA9Ziamz7TqciqtsYIDMiALWamyrI0oFwiJKJe3CekPXlvwI/8wyZWd?=
 =?us-ascii?Q?HhuUbuuFyYShUZNj9ILiTP6Ic4pbdFCniE5Rc9j5EoWHwk+FqawTcYUo/t0/?=
 =?us-ascii?Q?wcViCl3E6809A/FI3Omu6dIHSb5fjPsifjljgvYTDANGnqluWWaw/81ViI87?=
 =?us-ascii?Q?6cp8xan5FYUX0elgwyVPvOaNB+bRVZiuXuVZUiU0XXEM5frSi9rImBKZrdyu?=
 =?us-ascii?Q?JDREIyEieQcXb2lArcd/7yT/betAgT85zBYit71Ss0dCdHPCojLLoNEMHsCG?=
 =?us-ascii?Q?jOztxaweFZrSCjWSjMSoGge/6xzIQL6/NYLLPJQuxQ1a/9m8qqwUi3JpqFAw?=
 =?us-ascii?Q?PoS9lnd9FH7BaEVcjvXqMPU/iTPhqRVLTZuPNDNcGrf03mosNA4oNH+MpRmC?=
 =?us-ascii?Q?+Ntm7SoxQFtv5/F63Kf+ug0+LWUZVe9JT2tNyerJH+bhKDVw3MewqYu6Ct3w?=
 =?us-ascii?Q?c7eHU7p456/weQIk9dligeF9A7KlneNX7Ftrv44T3odwWaBE+uc53boFjSyg?=
 =?us-ascii?Q?oICWuh4p5m9uuOthOuWvyjUdbLWh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1+y33tXG+IFgLXv+2If8XxGH4fhMBtfM4uZW9OXYsORrEGY1EUko2xOMPcRs?=
 =?us-ascii?Q?YGTgZTnbGj1a2kHKea0x74MqtwMxiBntocjvKrGnuU8WHdGNUh1vCRKUT2jV?=
 =?us-ascii?Q?n119CJPrA+kebhvZ5PKcuuv/piJyebL2nNo/SbSGIFDjgJUnAeJIKN9gRh5f?=
 =?us-ascii?Q?wLqN2IDIL82xWqbX8grJchrQdlnJI0yGPWwuXOVhb+fDLY0SJg6Xk08wBGY1?=
 =?us-ascii?Q?Ujnmq9ZVL4h5di/fKwjH7LsZyLBpAWIigFF+JvwjoWP+ph4C+ufdl/dnx+Bd?=
 =?us-ascii?Q?P1sBdZIzmDDwO1neaaEhSbIpwtmKvYo25jhzednWyJXG008sWKe1B7DYBGYi?=
 =?us-ascii?Q?SBdJx9zoD+xLOztLn5stGKa1BVNvydCecnn4QG/Y/U6Y4D4pwXgB033FfLED?=
 =?us-ascii?Q?YFzRVOKnJB1P7cehWIY3QN2EEQ/35OKPyvtHhe1wO7Ps6VWM+qks5KRVFple?=
 =?us-ascii?Q?uszTkwufw0kBO8rBeu5cuiPNxbE0WiyFNW3k9qqe07oePaf6U7w+lNRUiUXQ?=
 =?us-ascii?Q?TnOsU1ATC8Mi4XMDQCM4IISm+tkDqSy0wHYlhmlo6wmJsMezuZuDCAMWLcG0?=
 =?us-ascii?Q?6HbO3I9nSwtLoXQwT24Ay7msJM10xq1AyBRucRJWESqL2FicUDiHIrKkvJ27?=
 =?us-ascii?Q?6yUNwCmiPpRLk2NNiClRq7o0dKrzHlAqe8jT4UQpP/ofI4I7QzWuq1LnMmwz?=
 =?us-ascii?Q?VId0uphsBIuQACv4rNyC76NW21exUflQrpk0gdB+vOumPzjV2vyIZ8c10Ezh?=
 =?us-ascii?Q?MuQ0f/qjHdd/whGm01jde9VTXOxuIqe0eWGVY52W1HeKx/TfY9j4S1urXHBY?=
 =?us-ascii?Q?+SwWLmPV1fqnianWJXx7wrlYYDR480AWdXnRfOkN1iU/2hkFGujJglqVT6Fa?=
 =?us-ascii?Q?RkUt8sPWo8pVVCYlcn3ENmKdoKZ2gDtDfs+HuAhb/kVz5dMSZ53+A2mkkeJ2?=
 =?us-ascii?Q?XnLJ0IBPDgyLKFRXhaKvr0x31azB3pccOaKTlLvUDqhGutxs7dFjilAL9bcQ?=
 =?us-ascii?Q?/ZEDp39GvFF0QtApVVE7E2QCmQtVxlrE7q1WTGQs7AD4YjsfAHFPhkCvVmve?=
 =?us-ascii?Q?FhKr3j5p2gKXkyumtqD/AfnboYoKEl+kmclOwoRzFp0jBT1L6+7oh8ukCxwp?=
 =?us-ascii?Q?8oW5CFtZdx5byTQg4Y1XYiBjW7TVQ7btR8iZFeYYFtyxo6CxlyNgfOkcMv1p?=
 =?us-ascii?Q?3hMtrN6S3mKt6Jq/VgeEdEotl2tfByCtfLd8zzQRjQ/4P/cu8dQ03s7VFvP6?=
 =?us-ascii?Q?L2fkZgTSz+1TVgOvv7bcyacrFDqxdGv3rieO6/NCdw0SWt1AXZDA85YTMwmn?=
 =?us-ascii?Q?pnN3ZtTq6rP+mXXA2+Nj/mHannyuL+jQtDym7X1Ixa1nodz4/hDdYE3CF+4x?=
 =?us-ascii?Q?aD8MowlKAJPWJsxQuaSlA5dFtdwCn7figBGrFyQWMo0kx9nEy8fZxI5iQD7l?=
 =?us-ascii?Q?UveRQuFYtQCr+sURp0UpUGZy0aoO141Mhf73ByRDOoulHvbkUZ3fD6mH8dus?=
 =?us-ascii?Q?ymvP0mtz/4UG3SuiEI9lMKGXTuCmbQJHK3wuiNKOQAfc40rXJMwWAXeqbOMz?=
 =?us-ascii?Q?O0Prk029JWAtpG8h69qfOyxlXTupeZzMN3mI7Hw0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac77a4fb-090d-4a46-adb8-08dd5c40621b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 23:49:35.3848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEbo67y/dSxFBKMsi/A1p8CL9BpfEbMuDy/C2rDHMVnMEb3gThgLzmJrRWmpsgfroh34d95qQ/4URSrRBXudyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9173

On Wed, Mar 05, 2025 at 06:48:19PM +0000, Catalin Marinas wrote:
> On Tue, Mar 04, 2025 at 12:51:27AM -0800, Piotr Jaroszynski wrote:
> > Update the __flush_tlb_range_op macro not to modify its parameters as
> > these are unexepcted semantics. In practice, this fixes the call to
> > mmu_notifier_arch_invalidate_secondary_tlbs() in
> > __flush_tlb_range_nosync() to use the correct range instead of an empty
> > range with start=end. The empty range was (un)lucky as it results in
> > taking the invalidate-all path that doesn't cause correctness issues,
> > but can certainly result in suboptimal perf.
> > 
> > This has been broken since commit 6bbd42e2df8f ("mmu_notifiers: call
> > invalidate_range() when invalidating TLBs") when the call to the
> > notifiers was added to __flush_tlb_range(). It predates the addition of
> > the __flush_tlb_range_op() macro from commit 360839027a6e ("arm64: tlb:
> > Refactor the core flush algorithm of __flush_tlb_range") that made the
> > bug hard to spot.
> 
> That's the problem with macros.

Yep, that's why I missed it when adding the notifier call. Anyway:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Will, do you want to take this as a fix? It's only a performance
> regression, though you never know how it breaks the callers of the macro
> at some point.
> 
> > Fixes: 6bbd42e2df8f ("mmu_notifiers: call invalidate_range() when invalidating TLBs")
> > 
> > Signed-off-by: Piotr Jaroszynski <pjaroszynski@nvidia.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Alistair Popple <apopple@nvidia.com>
> > Cc: Raghavendra Rao Ananta <rananta@google.com>
> > Cc: SeongJae Park <sj@kernel.org>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Nicolin Chen <nicolinc@nvidia.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: iommu@lists.linux.dev
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: stable@vger.kernel.org
> > ---
> >  arch/arm64/include/asm/tlbflush.h | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> > index bc94e036a26b..8104aee4f9a0 100644
> > --- a/arch/arm64/include/asm/tlbflush.h
> > +++ b/arch/arm64/include/asm/tlbflush.h
> > @@ -396,33 +396,35 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> >  #define __flush_tlb_range_op(op, start, pages, stride,			\
> >  				asid, tlb_level, tlbi_user, lpa2)	\
> >  do {									\
> > +	typeof(start) __flush_start = start;				\
> > +	typeof(pages) __flush_pages = pages;				\
> >  	int num = 0;							\
> >  	int scale = 3;							\
> >  	int shift = lpa2 ? 16 : PAGE_SHIFT;				\
> >  	unsigned long addr;						\
> >  									\
> > -	while (pages > 0) {						\
> > +	while (__flush_pages > 0) {					\
> >  		if (!system_supports_tlb_range() ||			\
> > -		    pages == 1 ||					\
> > -		    (lpa2 && start != ALIGN(start, SZ_64K))) {		\
> > -			addr = __TLBI_VADDR(start, asid);		\
> > +		    __flush_pages == 1 ||				\
> > +		    (lpa2 && __flush_start != ALIGN(__flush_start, SZ_64K))) {	\
> > +			addr = __TLBI_VADDR(__flush_start, asid);	\
> >  			__tlbi_level(op, addr, tlb_level);		\
> >  			if (tlbi_user)					\
> >  				__tlbi_user_level(op, addr, tlb_level);	\
> > -			start += stride;				\
> > -			pages -= stride >> PAGE_SHIFT;			\
> > +			__flush_start += stride;			\
> > +			__flush_pages -= stride >> PAGE_SHIFT;		\
> >  			continue;					\
> >  		}							\
> >  									\
> > -		num = __TLBI_RANGE_NUM(pages, scale);			\
> > +		num = __TLBI_RANGE_NUM(__flush_pages, scale);		\
> >  		if (num >= 0) {						\
> > -			addr = __TLBI_VADDR_RANGE(start >> shift, asid, \
> > +			addr = __TLBI_VADDR_RANGE(__flush_start >> shift, asid, \
> >  						scale, num, tlb_level);	\
> >  			__tlbi(r##op, addr);				\
> >  			if (tlbi_user)					\
> >  				__tlbi_user(r##op, addr);		\
> > -			start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
> > -			pages -= __TLBI_RANGE_PAGES(num, scale);	\
> > +			__flush_start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
> > +			__flush_pages -= __TLBI_RANGE_PAGES(num, scale);\
> >  		}							\
> >  		scale--;						\
> >  	}								\
> > 
> > base-commit: 99fa936e8e4f117d62f229003c9799686f74cebc
> > -- 
> > 2.22.1.7.gac84d6e93c.dirty
> 
> -- 
> Catalin

