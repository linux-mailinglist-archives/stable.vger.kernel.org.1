Return-Path: <stable+bounces-100455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100ED9EB5F1
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 17:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39EE816594D
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 16:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DB91BFE0D;
	Tue, 10 Dec 2024 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PJJY4BcB"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F651B423F;
	Tue, 10 Dec 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847465; cv=fail; b=dkOJL+UVe8Pkt8KlS+ewROKu1hN6NIPfuOVylLjp8MFHrt4Iwf04BwhAOLbOBbx62qiqrsJ0HM0PmWSYCY3M1bWsJkWJn6YfULpiEix0wdM7iAu/h0PB27C/Qpz6TQy3GZuMp597VchvegY4CwrQiwhOs7G9R6i0JrPK2n5ASu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847465; c=relaxed/simple;
	bh=J5OJl7H1gZpx7UO0jWKHyqP0MMYPRHloDX39SC+bM+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ipv1KGg2lZ/2UXElWRO8N91kdkCvutZ+PnZzklOi/gEaDI2DH2ZZ3d/T+hgBLKgF1Ho4AOeOd2waM4ZiSvwdwV/TbbEteQyF5zlGKdQdDInve5dwbgt5B38/46ZhqzZwZMe+MkVu5AqzaYnTCvwdMe5qBtOVv4Cv8/dd/nWtPI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PJJY4BcB; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9i1u6zpMAQQgWO9nRhen1IWF91cRMwaG0N8hP5PIksC0rhnut3GqaKpPR80aR7L0/adPSw8BLy2M19fdAsofbbHcX9oknhYobMlHRFePYHsNmngzznFup/6dPMtAUW8/87m6l+v0F2S7UJyhKm4xVwobhXmW47/lPYMaKTVzJ0v12/YrEiEqSAhhUqDEtRu9p8fRyZpiZ42Ju6NYh5KgbsjOWRrQd4IgyPouzwGg+tRzh73WVQUlqMMfM01vJye1TEbKt6tcrQpbwLaxmbRK05I3gsXnYjxH1keYc8kxtv0pp7upGnXfa7VgI7oJp2NgjmplhHYufo6et1SDyGclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5OJl7H1gZpx7UO0jWKHyqP0MMYPRHloDX39SC+bM+E=;
 b=dCkjOLHZxEaYFMdhdNq5wHwX+cdx0cA4ofDvq8LutAahFAfGN6dEbGwzfqVs233/pRAcvx45HFbE55fCKUPUKKE3vfo2x03tIQY/YzG7Ep95yFaZ6cIKGW/xWua3JND+85zqzVs/c3I749Fdv2+vZBG9qWfAVfRos2GWWJASZgCXf4/d71TszrwsgMBPDskPT2nR8Ey/ISPD3WBoFZsLwWLEJJJg6eeAahpphZqfzEnci0hUs3i0j+YYxWyXTDuCUQhVQjRz3e8Y73cKugJ7XPw6ItYlgKPdMDciBHHCS55FG4DBRMbxgdaiM6i+0Q9M6Dm5QytJ9YJJBMrBOS3TPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5OJl7H1gZpx7UO0jWKHyqP0MMYPRHloDX39SC+bM+E=;
 b=PJJY4BcBIfIfIJTtZlyGhT3z7XBpY/IACsuuMuOlnEO2EZ07BreREmkxuuZ9xjlzzq6aEBiliJQicU1+A7Rin5n14KPz+cg+5O+eclEs5plr+1EQoccx2IJzxVzZhcFhh+RiB49oTGayiGK8rIgNk5bncj57A9tz3mB1RdJn/fto810DTn1kKNAOdHqdNK0U6Tdf4fsQfgRdFEzEpcqZxYSE73qXmuvby5uKMksB9bmlEGb/tHM2WMvE0CU2SHg8l+gWViJAP868cfv6yOgFenRbwmGkXRJDUhsSOTY+jVzln8SqwZRVWLzUX9i5XLQFFoIGNOQGQxJPqVnwGf6dkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV2PR12MB5917.namprd12.prod.outlook.com (2603:10b6:408:175::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 16:17:38 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 16:17:37 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Yu Zhao <yuzhao@google.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v1] mm/page_alloc: don't call pfn_to_page() on possibly
 non-existent PFN in split_large_buddy()
Date: Tue, 10 Dec 2024 11:17:36 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <9EE9FD55-991E-48D9-9DE2-DA7F7E850352@nvidia.com>
In-Reply-To: <20241210093437.174413-1-david@redhat.com>
References: <20241210093437.174413-1-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0289.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::24) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV2PR12MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b5fd8a3-04bd-4a25-e400-08dd193629e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G5ipUqfkMZ4ql14HXwA8kOYfyal9AnsMQwrFkP3bIwnul+10iFTCdkAVF1GQ?=
 =?us-ascii?Q?KtGDg0V1soHA+BgHzPzL5mDtuESy33lDcwv9mLaJ0Zv4KpQfD//pvuNZDFiB?=
 =?us-ascii?Q?PgxuHfB0N4JAuqTRZDfsAbglXF7Avg+Ris0koRcxrr0EbUtso6QIrMS37h5S?=
 =?us-ascii?Q?ePVeQwHBSUhyWmhx1anI6Odnf1A0KHbdoN1vcnc24pGHIP0QYb12QOK7nQz9?=
 =?us-ascii?Q?Lhu1kCmwgXv62ezTtqXGMQ0jF+C+G7x4BidANmXXTX2ruERABq1Q1T1J802m?=
 =?us-ascii?Q?fUu4YDdWjIMJkRL7bGNFnqWQja25hIiuFwlJEr20HIooGuWdZ/uFnim/Q0n0?=
 =?us-ascii?Q?RnmdvOppkKWDcSI3bNvEzjmVVJeCMINOaDS/n7Ed1A7NmPPRTis12DroetYC?=
 =?us-ascii?Q?dc9OTzmcJ+qBHw/34i4Jy2jnqHZkunuWIJUTP6sATfwX6CmCLxWRTbrdZWay?=
 =?us-ascii?Q?6++YB575pv+Vi4Ja/WPVzJAqaT0107mIzZbR3I2rJ+sDfDiAbXOOBSvXMc0g?=
 =?us-ascii?Q?Gjdt285h4X2ATwhJfs++Ajdgfc0IuyGeH32zFVmmUo3kw3p+qNGD41nvX/nr?=
 =?us-ascii?Q?5rDIW64STkfWC6gEtcYOZxobb2bY475WmzUTR+cEqaHkTnydgqdL4ohigy5e?=
 =?us-ascii?Q?8fUTUdL9ZSOVntOEwBquW2WD7ChCxaU3AfSX3Gcr+tmNmCkcDF/AYRQbAJgf?=
 =?us-ascii?Q?ZBcCe5d+kLdiUvawL3gW032QnQKPguti91RMdDHGQfeMzIUQNPd9MA1drDsi?=
 =?us-ascii?Q?aiOosLGOzZaBjbzi8XF4BviNQ/TDsswi91zj9en9XWLp+SlRp2fzaMTr6U10?=
 =?us-ascii?Q?3S/F8+0QufRYAJfk8tCqGUwiJx5yU8uj59U6l+g8VAAT5f2jqDVvDwSAl2gH?=
 =?us-ascii?Q?KBkhnsbYkESYOdEKzkTuUo6hHMzLkQ6G5wotdjvXhAzZweABccP2rNU9fEZx?=
 =?us-ascii?Q?zet4i+PdpN9lXVUfkOm/IluFL8srulAnyKNuobqBFj76Futh2Vym77cM+1Ri?=
 =?us-ascii?Q?FljpVzjNJdbIOhY3Spj4BvS4HwtJDLUmaeuCVTkQJXD73MOeS4nYnHLFfo8N?=
 =?us-ascii?Q?4Le8n1Ipu6mbt5E1tnOXWC57bXfTNg5yyXWGE2sMTw7iBeFxNNluszqkoG9h?=
 =?us-ascii?Q?UlYZkhdC52PNwA1wXvOg8HKetljP/YqaG5SkACXorm9fpiGv8pmg6X8Oq1FT?=
 =?us-ascii?Q?CEavLUihUFrvUq7Le1P7lNIqetIph/5I3yf63fiVQnkU3UOcHmCb4qGGv8GD?=
 =?us-ascii?Q?AAXqUYHo1efP/mYXf39T8YYRlmgi6IWWy7wx7lrTZ5SI6j5yioLZq2IPhYyr?=
 =?us-ascii?Q?rOcHywpcA9kCEMzsC98J4Y5kJgbUoBi5I1Ifw8QFKE50Bg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iXJH+0hWCxScNzNFDahJgfcf01TYgU/7JTxivzD3D1KWwJoCsoZsvN2l/4we?=
 =?us-ascii?Q?FLhJEol8RKAZ9heBmyHEp7Jdq4AIbQSu4lAl+HXA7Tm6gCX0yclRHa6eMsHP?=
 =?us-ascii?Q?/lUXILCE2fqypDf2ZzeY9N8BZjaIX7qWW4+RTHZz8Oir75Y/ObuWF0RfuhNe?=
 =?us-ascii?Q?6h582MdhXHgpyN4TuBsul9WZQw9QvZEOXwm9AzYRvXCGqzD9c/17YiDWymdC?=
 =?us-ascii?Q?aLSpaGybv4brCb1irr6TjwrXLsvNMWn1BlbV6G3LOFLCn99oVmB53JkSdF04?=
 =?us-ascii?Q?9JN68WbNEgnnl2OCW/LkCU0u9wCR1ZhI5TBdUFLxqyMxh4GFiU3GmV7a5FDx?=
 =?us-ascii?Q?JKO5S2VPo2YOPjYHy9U1i3Oxwn6IM6WbxjNWnIWPRu7T0MSPXTwrqFjpZ08S?=
 =?us-ascii?Q?NbH3vNeV/UN3yZAwNISIS/edSRX7xeeGLUIGraVPeK20nGG7RBvYyHGc2hvi?=
 =?us-ascii?Q?N+w08+lUjAANePZAtHyu5XUbQuLlLjtyXakMWihkBwvPriTYVpuEWqpKyCUF?=
 =?us-ascii?Q?nh+t4pK15GazqTPQF5scCKPcq5D/SC/tTWNH6PuDEsfy9zHlQxlE8kIcXele?=
 =?us-ascii?Q?CDaJxSo4l3WdQhEQAfaiF6KXMwBTV9T7m0ls4sRfCmQY7BIJbt6Nvmm8EyoL?=
 =?us-ascii?Q?kHyclWIoGAZoVg9Y6SL4IB3+UJNWBEWQpJz0Mzw9zHgPF5Oybss/lNhNgyGw?=
 =?us-ascii?Q?XvjTkYbjfCWB3pFxUF7pUw7wad1GV7JIn04z9gTh3N+feDen2n/MgeiYD/mL?=
 =?us-ascii?Q?M/wcWTIXkLmx/dRBtEVl5eFNUY6PtKpkdA3K8AhAHigtbcC8GpdT7X5DA9bn?=
 =?us-ascii?Q?opEBhXn4iybqOLx7aYvgSnhJ+Vo/USkYKydo8JSMgaORLFR0x6M9zRtowKmL?=
 =?us-ascii?Q?7tlhWUfvCBHJIQgalLmOWVov5fJ7p4yQ5HVS0Zxl25n5G4O2Q+kLPi8vg9Lv?=
 =?us-ascii?Q?9wwXDvlNrwh9KEn2jvH10LL/6882bbMjO579FuLmeOfTQLyJb67ebq/cJIIE?=
 =?us-ascii?Q?MQTAZifv6zdP+t+R6wV4g+qFSOvMbTeoGY5YkwjGPA5I4pkAW2og5q8dpoTp?=
 =?us-ascii?Q?/5OSom8lZd9AE0ZwyTjg8B83yUTwHcSCV5cyH1zxBROko/oH6lat69unU+he?=
 =?us-ascii?Q?vMH62/Ou4+Ztkas1m2TzmXZ2snQkv5FUOj2WqLRcvE9lvsNp5X9sbTdkFaZs?=
 =?us-ascii?Q?JxsnAvRXXMmvV0PZ7vXpBomHWQxuNRao5ZLL6J+OawhUi8NkinGkeAIMbYjM?=
 =?us-ascii?Q?8F6PL9SGo8JohLKc967Rhk8E3CJwLAU4JXPSZ5t5uj3XgZnociKoi2B5uKrl?=
 =?us-ascii?Q?i5H7RgDNaga+885fMPR/vhoULGHGl5slNbWOT517YQ0IE/HHcdaOMl/3rk2o?=
 =?us-ascii?Q?Ucgi2xAwoRZ+AMeyjKpx7YQRlYSMARiZYmiOFTbJQ0A24QIpYaTybV1KhQwW?=
 =?us-ascii?Q?8f5MNEfgRyXvZ90Q3Wm8PmHjeMMKRvQ8ntK9tj21wfXKj+ehF4Og3uj+ht1s?=
 =?us-ascii?Q?LeDvt6OuYbr846lQ1rJjnTq8lx3Fv2TTX/HcHNC3Nn7y1VaGapNznDiYZHXp?=
 =?us-ascii?Q?wxfJmNt+O18YbOP3JadY7D+h2QYdtU6La5RgZ2ZQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5fd8a3-04bd-4a25-e400-08dd193629e0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 16:17:37.9027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0sUzS4Ma8P59opKAn5tZNhaMafi3oefC+Uk042uEi6F5uBYB0AYXCYdtrQR6H27
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5917

On 10 Dec 2024, at 4:34, David Hildenbrand wrote:

> In split_large_buddy(), we might call pfn_to_page() on a PFN that might
> not exist. In corner cases, such as when freeing the highest pageblock in
> the last memory section, this could result with CONFIG_SPARSEMEM &&
> !CONFIG_SPARSEMEM_EXTREME in __pfn_to_section() returning NULL and
> and __section_mem_map_addr() dereferencing that NULL pointer.
>
> Let's fix it, and avoid doing a pfn_to_page() call for the first
> iteration, where we already have the page.
>
> So far this was found by code inspection, but let's just CC stable as
> the fix is easy.
>
> Fixes: fd919a85cd55 ("mm: page_isolation: prepare for hygienic freelists")
> Reported-by: Vlastimil Babka <vbabka@suse.cz>
> Closes: https://lkml.kernel.org/r/e1a898ba-a717-4d20-9144-29df1a6c8813@suse.cz
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

