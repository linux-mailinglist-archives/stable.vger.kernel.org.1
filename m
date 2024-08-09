Return-Path: <stable+bounces-66278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2E094D2C8
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 16:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF761F21D7C
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 14:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE4419885E;
	Fri,  9 Aug 2024 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tJmVXXx3"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62893198825;
	Fri,  9 Aug 2024 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215570; cv=fail; b=tHP02uqzKUakgLgW5JOzjaVgc43eccF5NxNwbvPJ8Jm7fPO4jM7VrCs4JVSjvdkaprXVQ3bW9jc/eMH+H4WD2F3nU08x0hBiE/+UjJkL5bPBbT18l+oTjaJkjiaifZhfQ1uiF7rVul70ElQEtCSsp+6rkPpDlVAuJh8zN6PyC6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215570; c=relaxed/simple;
	bh=iCFOykj8kWC9b5XpMMgQ8sP5n4+nkOSTnOUrzZguwDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BktTjhW7WxGuoaClZpUKweohTLNMiZu0mzKxeWueMJJyRdYqpoGEbR4a6ALi34XWEIPDE9aEVKl1Kn9Lo19sbDwsxLUrj+hvBRFmj6JtkDFf9IaNrC+JYH0rwcogO7+uw3YPIS8xO1yMqGVjP1ahKxZ4qEixqenIcHwM5S2tUTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tJmVXXx3; arc=fail smtp.client-ip=40.107.102.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJrUNknsdqer/ahxrBmkom08NyFnAxDLZoVTYRdkEfRdqj0xELHFfImwzbnnMrT29sdcIH1VbLU4mrZhjAceyAS0dLi13LtjFd9Emz6sjIMMbh5GiN22IVYVy1/5+QigY91gtHmcy3NLXcjcBTb+TIhD1k5gv+9DvWWhW2yS7JIflw99Vmcwj8rutB2SqE9YzIX72mKXMUoGLjNuIVINyK/BYv3yLtDP6iwt3pUz0dsj/mN8w9Np//U70BTsfr+8B9jgraDxrykCW6jCqv5nTRQpzpIbp0kGGnH/g6x4LLK4xiGPPDXvGBAYTQklUsLt5MVu132i6ef01n3SUHIOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XYiZT7rhmKPSP0vkQcCuc/N49agUoRG3Dy29+8nYjw=;
 b=pV0vlrlKIrYbcGP5gWNKDZyJX3AqSiJO4ZaeHNBGfCUwLGhg1WuPyD/fmpl41l6D7EmXSXxEnXfCnNKR2AL3CO6Wth13rhk1VFFViVJYR3MuaqNgx0UUjebABXJyRnGFQD59UJ1ovVPnZmaWDBuPIZnUw2PqMIoW3RozlWWyj/lRP3Ceyqoi7e/6rKs3e2Bb8qwXdLmAjFkVdcGSDD9PZKY1nGhZF1slPd8I+z0X9fb2kfShd4JR8DLpq1CshTWQmwq2Yo66dmnpvqRNwR9gpiQTNdLzpMGrX4LSvFoYu+wS1n3p4ahcOQAtACxcki2wabBE59Cu9J7tsXdwW1gr/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XYiZT7rhmKPSP0vkQcCuc/N49agUoRG3Dy29+8nYjw=;
 b=tJmVXXx3MSWTndsVbGYnccDdTDn6ExcqgngxFID5vz3Gn5Eft+rfhnOLIXdLpPR8xuYMrxOljBH6VRwUb9EFjt6ggZGpaJ30RkDy4Sbc2Q0PRmVRXPgHnh1acopDIMgayVZhPKldzb3KJnYP8x6jT42p3+5c88AOHbOb8IMALjH0mes257vYUrKeML0eRxaErnZE2RePoaswwq1W68o8InSAluQcXMDseROp0CR/ZD7C1nJeBpSiNP4jnyw93IgCJgIu69IblsT0PllLitse6cNAL7O1C93mSUpdl+AZJ711pisdlDAT5HPqRHaf5ppP5gXQUKbdF6hYvRkz5FEXpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by SA1PR12MB6823.namprd12.prod.outlook.com (2603:10b6:806:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 14:59:21 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 14:59:21 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yang Shi <shy828301@gmail.com>,
	Mel Gorman <mgorman@suse.de>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] mm/numa: no task_numa_fault() call if PMD is changed
Date: Fri,  9 Aug 2024 10:59:05 -0400
Message-ID: <20240809145906.1513458-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809145906.1513458-1-ziy@nvidia.com>
References: <20240809145906.1513458-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:208:329::22) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|SA1PR12MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 033aea5b-0b48-4cf7-4272-08dcb883d9df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kF8MiWo6w8j10A2B2YK8g5fFiggSqMhA9C6wS2D9hbbbgCW5lcX3tyURZDdG?=
 =?us-ascii?Q?c2Cho4TBGP5wbKO+inaCdtQ37VuR0irJakQG9mQchJIUPv6Z/XNwJ3xQYqZW?=
 =?us-ascii?Q?RFxYZc8Zp9S7kSqxhXKvrGe60LNh4FKF5DK5rndj8oM6efLQweGp0y2vZF9d?=
 =?us-ascii?Q?70RrSP+Xzb+tGoPsPs9D2QywvZO8/HXBgbLZ9hfW6XA7zhMDdgL16hnsBklC?=
 =?us-ascii?Q?O5kdpMqHyGPiUZn5yQ5l/lwwf1fU73AQxSv0KpG2ejPHbJtvWdBuMFBJ411N?=
 =?us-ascii?Q?DatOzyqHl7BuOvfeAmpp091VK5RblvmWZqSm3SLs2DhVTJDT9cwxkUw4f1+R?=
 =?us-ascii?Q?PYZVNkEXqvNgfWrEDWnioedgO/1m+VuVjyVfvNOOZ33N3Gev1flo8YVM14v6?=
 =?us-ascii?Q?RZQ8E4ElqtSG5eDmZCr3qwT7PBBfJbdb0RrHKK9ksPF8tP2cPuVJDWffYCio?=
 =?us-ascii?Q?dYrPFwqdfaSNC730nKJEWmeGKaRDQ4Of9q3R86Lx8EOLNKU3l5X5YH5yt+Uc?=
 =?us-ascii?Q?BgXjqtCf3k5xmI2YjR1OS2V0W5glf97IG0sD78joYtMTE4gOR3cRYbVGy4Lz?=
 =?us-ascii?Q?UDOxLRom8MtIWKdTeZCMqC0BlmXjwIQPNMXKmvdGwFTt8bRosu/FKCr7PzH7?=
 =?us-ascii?Q?F7qA7Vg1FllAJJeliAUImbtNzTqjO9fDY4jIssI/Y0LbMfz5uRvXflFk+6bv?=
 =?us-ascii?Q?sw+3XVFLTjI7F48oqgRt+CdK8phDwf5R2hc2/vUGaGcDS8cV+BM+iqhrmWDP?=
 =?us-ascii?Q?crx3ePh9V6n+BqIalUTZquoxEaOQclDaWfzu1OWdj7JVfeAAGo3dt8mGcNqt?=
 =?us-ascii?Q?KlUkXfVDknJeSfjWnIxyPw2YBoqsAFiGsunfKdH3LO5mwszMU2wvkIIhCV7J?=
 =?us-ascii?Q?CrrCbER0TDplCCowA7Dvr0cd/ldGxNW/yMVYd10q0VGGvi6b4PIF7E0i4mB8?=
 =?us-ascii?Q?w6Geq9tt+WOLg8l2rpslyAKDoWwAZm6Gwc80TqkfTR0tYKtF4KF8xfxNaZm/?=
 =?us-ascii?Q?KHNstDgZsatXkoIB3jg4LR5zNecm91y3hGvL16BRwTBRX9Xvf5M89V7uqyhP?=
 =?us-ascii?Q?LWNNKm0/zOCLfV5WRATL1Oqn6O9O2AyoVHE06D504ACrKzE5E51w1V1SdM0u?=
 =?us-ascii?Q?AF8ZzOroYqPEDrGo1m1s8QIcDZJ0sRere4KomNinM/ANYgtC9f+tzRe+Ta0r?=
 =?us-ascii?Q?TleIjsxldHi1ShYh5cM9D+Hose8Yi/2s8p5Pb8w/OfZj2g+8dFEENXdck7eB?=
 =?us-ascii?Q?HT4uuzMBCwl0K4lgf+d5G62/Z/rkx0cdM+PcUsFRowGqn+1unI68J74zphZs?=
 =?us-ascii?Q?RfhgjBPp8N4qieM0gQU+cIzB4o3ulK4Q/H5sV6jpXzsKZujdPJX/00+UkW4k?=
 =?us-ascii?Q?6FIr20M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?URpX3NK/YKDy0tNgoA4oxpJP1Y1xr0YYBSMaGZvS0o9NJTlywQwylPF/03tp?=
 =?us-ascii?Q?Q4RwNfX+LTsQK5T7Z3ml12100/LmO558upw1fvYtFMTa75yuwJpigx5uQNNH?=
 =?us-ascii?Q?U1qsAoqUG65PnOBQDRd2EKdeUjF35Wxe9kzmHZIN+PixJkNG0LW7sCxOwtBS?=
 =?us-ascii?Q?P5/MFgkUs+2bYOW2CSNKsANWEFxeFWDXzVrHJ5M54yFyw4TSgTljeQqX8hiV?=
 =?us-ascii?Q?f9AkyY7Ta6u1MFlAZrNkdVaE2bxQVshdhfa5C6xgy1UqGw814+2LPRNRfMSo?=
 =?us-ascii?Q?o/4hUF51QUPEwrpgezyxSYELOftp78+YZ8sNHWryZU7V/+7MxvC3TsWIMMbV?=
 =?us-ascii?Q?EbC2TI2nqnyGPQmcYB7LS3LbuxP8H1fGVI8w88CNE2EjFa61AwjGTkahObKi?=
 =?us-ascii?Q?+JZdJshfAipdBUMmnd8j6I6BFprcf4XJJwAlSMFWIZ2lXg0uHQ7msbKlY0lY?=
 =?us-ascii?Q?R4GMV9QjPfmXCTatQYWoMDpRC4FGbVOEjpXwSb0ST7gV5GOU3mufYcxs7seN?=
 =?us-ascii?Q?t9mIAVqPqJ4Vu6Z7ZCJgoQzpym5bMhoblBRAcPZm3xVjnsHhJ5KEiUeEwJMH?=
 =?us-ascii?Q?2SyiKHXTj0pjm92sZBIZB3oWNrrEtkgohNQvCd0kKLd7xiNkaq6wbj6EXPX+?=
 =?us-ascii?Q?i40ghAT1SAZAbNW9SJ3cF25OcJnkWp1M2TwGDhcHugj3Ynh/ouy6jPjbYq4h?=
 =?us-ascii?Q?h8jJGwhG8zIGt53IzOdOlgQnjhc8v3JGb9EvdY72vgtIoqVbG6x/liimxmFh?=
 =?us-ascii?Q?K8tMhw6BRVqQiBADYwamTI6uH1M6DlEJQGs/dKbmUeILB5jBGDHnjwd0nAIm?=
 =?us-ascii?Q?uWaE5qR8R1Otv5IM0H19b2JMZhtj/KUWlNIKolQgZdEhGh51TDZw2aMY8Bou?=
 =?us-ascii?Q?/BFPxluuK98/jOfhqSTT6d/VVnk2hGBdoyOwn2Zdh8wwddVJ2iGtevc6DKGW?=
 =?us-ascii?Q?WqZYDO7p5Ud/q+zPDNn5+Bn66cFK7rbZOro7xhjCIz3lGrTNtdVjaNNmJRtG?=
 =?us-ascii?Q?ZlIVbRN/Wy8qrhuLJ123G/VvnyY/6tuYsv0Sovd152EAchapGg8NKIOPzww7?=
 =?us-ascii?Q?yPningfp+bWRKlxoZvgb4n/ldcC0XkPaxZusBfNmiFnWbXlluXFa9/GTzVd2?=
 =?us-ascii?Q?WlGHqgOJlbhhqFtFNXql60xue49KCyPhVnU1vd4QLEGmIwsayIAcVl5VP+bS?=
 =?us-ascii?Q?tO93Sebt3qCOYAuUDKGLI5rxkyhoo3DyuAsi7pBnsWLXRp41kHQNUc+pY6so?=
 =?us-ascii?Q?UaUCmzpWfR5qaj8kN5/ZHxM7EvhBQ+F5DhSaKiZz4zNCRpvJoVpxECUtkEeT?=
 =?us-ascii?Q?cXXQCvIcL7q2W6xBr/yz6rkEFZsJJowrrUHryIQJpBo7RBV3W2q478O5hTAg?=
 =?us-ascii?Q?elmZRkQJ3Kjn6AmBiHAQpajjinmd6E/1TobdCiLeqIgI0olQTPiZkZA/km5l?=
 =?us-ascii?Q?mwDTaBPmfwnq5cEbI/YVKhJdAtStzDkjYSGrJfdV0QAY/RnUKee46y/IcRA9?=
 =?us-ascii?Q?O1tmYR/jIB6ufX7ikCZ3P/cZcUvJHRODWTGwA+9Np8qgtobD9NXllSD7J1v4?=
 =?us-ascii?Q?i50K6y6zgCThUjh+SUziUJCMv2YqINL0M9poWHu7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033aea5b-0b48-4cf7-4272-08dcb883d9df
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 14:59:21.6054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gu1i5YaaeqcuWRxGgDyxwsN9BGpuvjQIskos8790AZrQe4J/Zb+Uh/Fr2pp8sZeA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6823

When handling a numa page fault, task_numa_fault() should be called by a
process that restores the page table of the faulted folio to avoid
duplicated stats counting. Commit c5b5a3dd2c1f ("mm: thp: refactor NUMA
fault handling") restructured do_huge_pmd_numa_page() and did not avoid
task_numa_fault() call in the second page table check after a numa
migration failure. Fix it by making all !pmd_same() return immediately.

This issue can cause task_numa_fault() being called more than necessary
and lead to unexpected numa balancing results (It is hard to tell whether
the issue will cause positive or negative performance impact due to
duplicated numa fault counting).

Reported-by: "Huang, Ying" <ying.huang@intel.com>
Closes: https://lore.kernel.org/linux-mm/87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com/
Fixes: c5b5a3dd2c1f ("mm: thp: refactor NUMA fault handling")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0024266dea0a..666fa675e5b6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1681,7 +1681,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
 		spin_unlock(vmf->ptl);
-		goto out;
+		return 0;
 	}
 
 	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
@@ -1724,22 +1724,16 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
 		flags |= TNF_MIGRATED;
 		nid = target_nid;
-	} else {
-		flags |= TNF_MIGRATE_FAIL;
-		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
-		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
-			spin_unlock(vmf->ptl);
-			goto out;
-		}
-		goto out_map;
-	}
-
-out:
-	if (nid != NUMA_NO_NODE)
 		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
+		return 0;
+	}
 
-	return 0;
-
+	flags |= TNF_MIGRATE_FAIL;
+	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
+	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
+		spin_unlock(vmf->ptl);
+		return 0;
+	}
 out_map:
 	/* Restore the PMD */
 	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
@@ -1749,7 +1743,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, pmd);
 	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 	spin_unlock(vmf->ptl);
-	goto out;
+
+	if (nid != NUMA_NO_NODE)
+		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
+	return 0;
 }
 
 /*
-- 
2.43.0


