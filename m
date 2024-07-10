Return-Path: <stable+bounces-58956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6492392C6EA
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 02:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8241C22009
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 00:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859D3A35;
	Wed, 10 Jul 2024 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cjjkiuZG"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948403207;
	Wed, 10 Jul 2024 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720570215; cv=fail; b=lhFaIRSJUwspV8cKJbRgbGxUAYVQzaHKWiHWbkaUrf3ZaWh5Y3yLljKfN41rxsPNZVxXRPP26UekiccS/7QUpcy/q9AemNk5q2BiWFIsB3VaHOYXx3VtfNGFZMGMqG928voe+bWd48jxVJ7pgiOHxp6CyTdi8boDJ3JhKoIUlm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720570215; c=relaxed/simple;
	bh=qS8iHINxZ3mvkGHW/xIBLBoM52ojGzHirmlcEtnnugc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YK7f6AsZ9gMUdIlVKvy+xhzDfpgB1YO3C4hAPcbok7wWugQRk65V56IKHQGIlGFwTKs6E2PeAcMP6P+uaLsa0Ufwznju1BVVrNtheatBoEHr0G9NU5lsiY6C+YKWlI4dCrzdYpZw9iyciEuaxBEC0QyGKybxxV5mxjaNa/6ls2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cjjkiuZG; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oR8PxuEA5PTrhwvnpWzUm3EHSgGce/bFjDNs5y78NSsF3XMFZu0IlGH3Ga4IR6z9yiZL3dJJecGuLiJEIpIXS16mz/k4RBENOcHtT2kMUGP2SIsLLk2oXpu7KXaVfghfbqaxgv1/rCOmgteiyH2W3qYuJkPC3xMgbkJ0XERhGF3NAimMZ0NVjeJTVEPqM7+Wg5KECiF/uJ2hVVHhx1cf99Em6R8p85Bn70QPdmonzDuID08/NAbnhXyZzLHsqQJqmsjEpHk8lmDw77kvloY2XbIDGTh+8TvWapMuqPAy1qc7y3d47HnGG4z+7oRuaofmKWrVZx9ssyy7oi3YzFNEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lof+bzXBXOykMtp+HMsOA2Pdq23Msv5rcYBBUtfvQro=;
 b=hD/5tY4DJSpLWdpXXXCqmzAByioMQlzQZxjtkPXIwVePcd+F/9L3FwSQLn6tVDAgUBfYShDlMbMeKFGdYV+jdbSlr0iDJbftiWgmxCHq2nZm4W5PZ0ifM/d/SYlWEw5Cyu+dkJXeE5mLqby2dtkGZqZ3RC84uJgI3cAKI7BpaM+fJywF1O8Y55zM7ttRP9CFZOSKG6DuH7tMmBVWoLQMD56PQNADeHCe5TheF+o32X28KJ/PWRIX6JTdr0vknlJMPwNk37bbW04TknpwU0iMEuOKh8so1BUEpfTkoveKG6XogyjhrzxMiAN86F8KfsnjGA4ByQxc+lokVsqm/vD7SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lof+bzXBXOykMtp+HMsOA2Pdq23Msv5rcYBBUtfvQro=;
 b=cjjkiuZGbHgTtPw/fgWS1DP29TmOIKw/qDd0CQzTIq139jW3ZLVE+3ff+tZgQap5PAyfjYZRnU4vcv0vvE2sGfxBaFYH0LBHfRqzvLvNu8A1iCDtxdo85UdpgAkDPxNKhdiv7omEduTA8C5oY7KB/jQEzkvNO8pw9gslaXGxmjdUQ1rh5/h+rbhPvXqFmaCgad4AA9Dg8ae7eoJnED8cOocsF9hkcfwrdCP5tpcj/fUvVtbL54TdwlQwammctx13GsaedkG0RtO8EkK+4grMp1WZOCkYHHMBc1xChFUyLApAgg+ONfajzcpLRiF4XjOW5Mlvaio7P3aZQ3zn+hb50Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB4742.namprd12.prod.outlook.com (2603:10b6:a03:9f::33)
 by PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Wed, 10 Jul
 2024 00:10:04 +0000
Received: from BYAPR12MB4742.namprd12.prod.outlook.com
 ([fe80::25aa:41a:d2ab:7211]) by BYAPR12MB4742.namprd12.prod.outlook.com
 ([fe80::25aa:41a:d2ab:7211%7]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 00:10:04 +0000
From: Ram Tummala <rtummala@nvidia.com>
To: akpm@linux-foundation.org,
	fengwei.yin@intel.com
Cc: willy@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	apopple@nvidia.com,
	rtummala@nvidia.com,
	stable@vger.kernel.org
Subject: [PATCH] mm: Fix PTE_AF handling in fault path on architectures with HW AF support
Date: Tue,  9 Jul 2024 17:09:42 -0700
Message-Id: <20240710000942.623704-1-rtummala@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0119.namprd05.prod.outlook.com
 (2603:10b6:a03:334::34) To BYAPR12MB4742.namprd12.prod.outlook.com
 (2603:10b6:a03:9f::33)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4742:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c16e69-ea38-4d86-30d7-08dca074a638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lyjyua5EpxobPto9gxkKeG50d0cpEPm+/Lqx2NsJrJCIjW6D2HwlVKE3VQts?=
 =?us-ascii?Q?6MXrVZ9MdiWDkyAzqFkGn7m2IL1RQSpl0r2fC4hxMGChGPNi4TMbn4D8luvU?=
 =?us-ascii?Q?6Z4DrLeJi6jIoZqXmoVMj6hBrNZ0I0kG52W4+fdL1LqYa+9ucH5lLNef4rpf?=
 =?us-ascii?Q?RUqvqTnITYXSXuPWaLy/bVS9/RoSM1rCWumiWceFD1bOrO33v6gUFte6007t?=
 =?us-ascii?Q?oR2DiMm5aVEMeCRddcSDaTKjeDk/+92WGVn7EiE/3QPslxEBpkseGdPnEDnA?=
 =?us-ascii?Q?00z000c/LNQzZfA4XjOm9Xi1U+0U+VoJA0FIcbSb+TcfIIE2Ep5Prc2GdpfK?=
 =?us-ascii?Q?sRHnvr7Jm3pDV8SwNC9XDMvTUE+LJQhRn5Z8h2F8Poo4uKkKisazMU9Fc2ru?=
 =?us-ascii?Q?ubpctNQomDze7RdTAt4Y0KRqEjx1Kcq6apEeviWPy6ODYo9z40TzugLSaE44?=
 =?us-ascii?Q?uMTl5ClXYg1cF9BErQeEh9Rd/mTLuda6qbOAu/GR5nMQ6mhF42lmbT25+VoH?=
 =?us-ascii?Q?TSbwGxWiLfhz171X4UU9OwJwMgcEbFoUAqw/ScloNza81MEEf15rO2cVz2PL?=
 =?us-ascii?Q?e8C9ZsPGZUiPXgeh1f11UzrcSEntSHgESM5ehRs63hsAmPFN6OGAxtcXvgQF?=
 =?us-ascii?Q?gBRMqH5p6Nuhn+1B2Pik8rNNraD81PGodYb4LhSlVE3+j9DAml8FV8wWUora?=
 =?us-ascii?Q?Mh0Q49Pd+SQp1x9wxeb7RKgW/gqcW7EFNl7bfMKOatDenV8BRHF+teduPJop?=
 =?us-ascii?Q?XFWVWHmawFQWGxw15EPWw9+2zGz40+ZjwkVIEXkyuR/ooZJci9OFEOuv6TgO?=
 =?us-ascii?Q?pcwZoJN/Snnmvwa3sZnMgNBnyI/8LaHu2zbAYzIGzEEIc7JD/ZKZpLgU7whV?=
 =?us-ascii?Q?STtCflTQVQ/h6nOFXCG/imIkdLK99FGM8LbCkDqQTaJzEcPbKSaYFDcAD1pR?=
 =?us-ascii?Q?iLnZWRRJ8Xm9og5LqVz1NgFxgxSr1eMTEttxd29rJOcIKzrstdYaw9f9JZEb?=
 =?us-ascii?Q?ZV20FDciLAn2mX0uXPiyvFMGm4K82US/tPZG+92+jETiHHVJX+irR76/pH7c?=
 =?us-ascii?Q?Cf3/yXvNeF11IJt0p8kWRh06Vp/Rj6poMMEZI1JPg4E6yB5BDNWkqQZ4j08C?=
 =?us-ascii?Q?vQNyWzZJhl/Cc2fDsp6lS87VbxmxNy9Z/ruxl9PVQ5Hn3qWGOVfCgWxNA6vV?=
 =?us-ascii?Q?yPb1N3ibg9pHOzLfspyEM3XpZLKW4scnsh5W4Kup0nVHkxHjECmKWdPAuQAp?=
 =?us-ascii?Q?J8vWXWZAHQerEpUSmiXaBNheRUR2pXCYSdZd1IAU5EdMFZ//K7eLmMprmgN5?=
 =?us-ascii?Q?oHnjTgpQbPTvVg8hYxG4Cb14gyU6Q1peG1lL5W6S4PItGA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Ajuan7ffvHoYre3xFwLFpxxDtoyIcAS8bULouUfsPl7d7AWRDNk4H+hS7rp?=
 =?us-ascii?Q?HZWmQXh7Y5PMWIVjQH3WIUABwj3FbtqiLLi9Gl/troVI8P87QK8eK+FzOx46?=
 =?us-ascii?Q?/9IB3s0gUS1iwhXqKtMfLTz45JUV2eWTCiBroZQG09n2r1VrZvwsdUJYpdL5?=
 =?us-ascii?Q?uT5shuE9nO6oKRBMG0rwB7YVJP5TP8uAwt9JhMNJLyQ8gx2T16utpd+c1PMi?=
 =?us-ascii?Q?j1ZkhdW5zQj4QzV4UVTmHU5ULJ5TbV+7xf8ah+YoddzhWzQE6f/ABmnCIDeN?=
 =?us-ascii?Q?4kfJYarkl+oeYFXsfJ1BBnwAKjDOE7d3D+uoaRJ+yufYhkAZ4uSoR8A7hU5O?=
 =?us-ascii?Q?zU6dQ7fGYupRFqJAzJe2+wusbAIYFqJ0n5JgFBRwhfoes+stQJ/05k+zVcrc?=
 =?us-ascii?Q?gErmgUrdBaWGh8jA8NXKsEfakDYhHRF4xnqGJVT/lIf+PVoVsJJlTShpRrNM?=
 =?us-ascii?Q?LpQWOcWUfiQJjMD8c54EIW3Q9x6cxDW4Hf97X/zlwWhexSEvs42x3kgPtRsC?=
 =?us-ascii?Q?TYaYqJXOA3ushHEt2D6XinZKo02ZWatEn5ULDlDOo6Dv3Oq4dHz+FVqShFzG?=
 =?us-ascii?Q?cY10SLD6sDJelvFpKhECrN7gmQjol1cbrq0B1v+4xRQaTRQcHKd23yrfFVvm?=
 =?us-ascii?Q?CtTnDAoiquydAY8V8e5jyHmMbVru5FTCcLe4Vv0h+FcSBs6PJ2DZduKnsD5F?=
 =?us-ascii?Q?kIVSCz3LP1zLkRAqdxXdKaM54jaaJfYbPfJsjtQZVAFYz/Ff/3f7ljq9QJon?=
 =?us-ascii?Q?zL6yHdJdJDHVEXcDBl+W86Rv1ykKluJp+OYXjrwpCjLqZlH3QPaIFVglt3P1?=
 =?us-ascii?Q?kjrRwclHMH2ZndNcUrRFpMrJRSey5/pEJxJxc07F+jtI3VGcEX4qagznAHz6?=
 =?us-ascii?Q?5jeiRxMVC/f0A9oBcC63rZm925CWnzT03XORrGYnkGqyUTSw9AVNfgi6vwER?=
 =?us-ascii?Q?t5+geU3cIl5tCihncGZiBAL0oG6Hm/Q2cjZtiHCM9KKpV0aZ+D74iUkVSJ+y?=
 =?us-ascii?Q?+YYwHGPU8K9LnPsRVqqEcE+18IzEDgxhIsFa/wouo5bGzso3S3MkYoLorYkR?=
 =?us-ascii?Q?iiybhpI9iG8O8olsXt2oiZ1eAnVn7QEGDUvcIivSVtoe8/gXRwclgolqo3JD?=
 =?us-ascii?Q?mICuExCzFE3TXHt5VPeAfY8e8h0yDxgYbTS8OkLKxa5cufWYrp8HH9+GSc/Y?=
 =?us-ascii?Q?91Olcs5Igtr6KXugYnprddDKDYncaHq75ijiACw6/MS+n1P+YwGxu7Y2hBB/?=
 =?us-ascii?Q?66JFUIixZIIy1dgYfjG3s+1hB/WIE1YI6IVLe+rE3GOeeQDoEt49JfgZFcHU?=
 =?us-ascii?Q?vUTt1HiazhfDUr/mkJnN/y7NNiDYrQOEMs76xzKe8YqbUfIom+URPjO388T1?=
 =?us-ascii?Q?BuWVd49AHM48Ke3n1/DxLtlowbqSw7nqVf8WNHchokVVrndBiloVF2dIRCe+?=
 =?us-ascii?Q?Yurw3B9ygV5j12M2cYObUjToO6Gh92MImv3SAigyT8OnCfyx/xRUVnRk9dF2?=
 =?us-ascii?Q?DYcZtPoMKYu+SnnEyzQoWLTGxCt7UJrg+omgSnFVZ0V6q9sJpgiOtFTmPJWX?=
 =?us-ascii?Q?m2H5HBwJasJ6ytAwdxrHkE6eePmDFcTHnKm5AIbQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c16e69-ea38-4d86-30d7-08dca074a638
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 00:10:04.6289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2A8wIskp3KwvM851/dQRKRG1nNNW2qzg27GDWcEoxi+ilV3mw4XiVPh9TvucJ1CuUbNrSXQWk1+gXLKwQ3kZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988

Commit 3bd786f76de2 ("mm: convert do_set_pte() to set_pte_range()")
replaced do_set_pte() with set_pte_range() and that introduced a regression
in the following faulting path of non-anonymous vmas on CPUs with HW AF
support.

handle_pte_fault()
  do_pte_missing()
    do_fault()
      do_read_fault() || do_cow_fault() || do_shared_fault()
        finish_fault()
          set_pte_range()

The polarity of prefault calculation is incorrect. This leads to prefault
being incorrectly set for the faulting address. The following if check will
incorrectly clear the PTE_AF bit instead of setting it and the access will
fault again on the same address due to the missing PTE_AF bit.

    if (prefault && arch_wants_old_prefaulted_pte())
        entry = pte_mkold(entry);

On a subsequent fault on the same address, the faulting path will see a non
NULL vmf->pte and instead of reaching the do_pte_missing() path, PTE_AF
will be correctly set in handle_pte_fault() itself.

Due to this bug, performance degradation in the fault handling path will be
observed due to unnecessary double faulting.

Cc: stable@vger.kernel.org
Fixes: 3bd786f76de2 ("mm: convert do_set_pte() to set_pte_range()")
Signed-off-by: Ram Tummala <rtummala@nvidia.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0a769f34bbb2..03263034a040 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4781,7 +4781,7 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 {
 	struct vm_area_struct *vma = vmf->vma;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
-	bool prefault = in_range(vmf->address, addr, nr * PAGE_SIZE);
+	bool prefault = !in_range(vmf->address, addr, nr * PAGE_SIZE);
 	pte_t entry;
 
 	flush_icache_pages(vma, page, nr);
-- 
2.34.1


