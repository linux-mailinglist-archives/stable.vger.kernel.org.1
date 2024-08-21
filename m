Return-Path: <stable+bounces-69806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AB5959FA5
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 16:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699B41C2042E
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 14:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC1D1AF4ED;
	Wed, 21 Aug 2024 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UZYIuT//"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC801B1D50
	for <stable@vger.kernel.org>; Wed, 21 Aug 2024 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250098; cv=fail; b=a3B3gm6JLMaEatFWGuN58cFfEcqdCKq2q5yAudlq6ZGKwwBmMgAJwKxIgTSetvlEZtyeiPaSwHRnWSQIRGdXFGIZOVp40CLRlMipOc8HMOZL1ikD0/+uAWYzK4qyN0U1LTC4RcsJCBr6t9stVADWlEr2YGqffIUpZm7MyAWBCG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250098; c=relaxed/simple;
	bh=5LK10JEZD+jFnjZHuU0IAzJmDvHC7UVNTIwr0T7Dt3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fujidKaS9XeMNJZwdeM5ezVVZ8oCUinAnYW93S9wfMfIIZy5g9Ks3FaQ0i6cuaPfBK5N0LVpMN5hbR5vQNcz6CzP+R/fj3Own7Oz9gxtjxvfu5vryatQI69qKwMOHT8iVerD7dMSoP15NbwknaRcoE6BcBn/yYttBkYPs/RA/XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UZYIuT//; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waYVdZaU7ifP8hEa2rGfFm/HjhTr+8FTRUrPmhLSjm0FAVlOGApPvgRiKoJp95YriGYKj5D1ZTBL32dwgdELoopTPlXE9Bj+sOV5MR+w0bucn6yPieL178bNe1fU8Mq3O01OrP5B08WQSsnaSyeTZGfDRSxMpWxTaFNl/r21Vzc9uhZO475sV4zdjCW8jKX41KBam/y/kTl2i11M7mq5CFtPn2KQsIG2toHzlNWslgWhyHqivy+sCJK7JhxdS74GL6EX5U2meWzGAf5K4t2Ide3I6E+L/Li5OCGYFkouimnAHfEEwCFD+0xcoqySfVfm2EwByS/4jQ6eA6aTB5dVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfZDa5XfPBiV2sq9PhXWiE/dykayVRPm5qNTGXnYbbE=;
 b=jHyBcQwMVyaKNs+x3kvOMaR/BJmOEZZR8f/o4B+bc7Fxhi+bMG2UZd+STcZ+g1tulgSlFxMkS3ArNrgvGiv8el+uzD0lGqZKxTXMtjHMNcChDtNaMtjbE+OrYBmsmuTxtsWQ5UhzjBQTQWZJnmYfzf3ZPerq3XcSI5/G/WI/Lrf8zwIEbyki7u36own/V7XsuSGfvDg82KEK2+aChoJWxUYEOu813Xqd0ta7k2mcVu2AdE8zNN5sAkSStp3zr/Ub+fMVBvwSCLwmNCqarIFtxIGcn02GLyBPdbOlwAZdxoAAdnqRR4rad/MoKaVB9ps6ZuJHOX+PVR5HIOnA6IGq5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfZDa5XfPBiV2sq9PhXWiE/dykayVRPm5qNTGXnYbbE=;
 b=UZYIuT//MiZVQUKy9X3WIMPLCvh6qvxgWK5JPptXpnDk1eKkuapD3NtcV44emir+UPK87H9CzT34l/t/6wBTPOG9ByAO+BVcCrxcM4VeRIFB8kLM9g/U39OqXe+WekOKU9LFnyBYuJE12ysaTNFkhxYJW56ouYFtSwRKjOM6wpNgDVLnpmgvHkM5j8tS0o6eeWoDHMe+2aFD+PnxikN3EZsQuvkPjY1iKaFR4o7JbXGDSnVSbu/lPjdcujBk/EydKPn52FPKST7+FFV6d1ihn0ZRPn0n+TySmj6IrIXcftWJnVAKDEhs9g5xbYPZ1L09xEmPaB+5KTjVPb78zkbDmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by IA1PR12MB6626.namprd12.prod.outlook.com (2603:10b6:208:3a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 14:21:32 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 14:21:32 +0000
From: Zi Yan <ziy@nvidia.com>
To: stable@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Mel Gorman <mgorman@suse.de>,
	Yang Shi <shy828301@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.10.y] mm/numa: no task_numa_fault() call if PMD is changed
Date: Wed, 21 Aug 2024 10:21:29 -0400
Message-ID: <20240821142129.1981470-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024081950-jolliness-crux-7fe1@gregkh>
References: <2024081950-jolliness-crux-7fe1@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:207:3c::22) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa7a44f-c326-43c1-e3ee-08dcc1ec8e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SKnumPRWKhp8yAfxrgtjI+X+4uks5jsdTmBkUrpdQ19Gmkn/ZmNxrVcegyuL?=
 =?us-ascii?Q?VjFqdejqMRHgt/V0LWZVS2Rg0V/izhxhihwQZyK4gkpM2WYBP1MS2vG4XLBo?=
 =?us-ascii?Q?iHsFcJu6P62Uqa7CetpqwC5BW4x080waaV9Zrenyb/AP63o5qudxqeIBjeBx?=
 =?us-ascii?Q?laAsV59Qnr8+gyO6A5fKef8wXALu0jwef7LFZsRTGCe2SaZ9anuWQ2O5tpA/?=
 =?us-ascii?Q?bGjIAJHkRNOYQIiZEly5IissmFEfht0k1clTocgSKt7O7YvcDSXzgjan1uiU?=
 =?us-ascii?Q?m3HXEMFhvLBTQPbdv9Ihwy5lYbkG6zQvwnpXIMdE85w66HS69RpcbWEPc0G/?=
 =?us-ascii?Q?nJ8F0rIwZG0Y2SyCED6fxzkzKs7sDGJCAFbyWThpV/ey+fQgiVyHPOEN//8P?=
 =?us-ascii?Q?BebTWSI6dFJv7j9u7PMB43A60ojV8YLHtsmfM7AeLlaBYbAX9iNtl+397bv9?=
 =?us-ascii?Q?aINg6Ub5Ct9JKmiebpJLHHE5MDgnQSQ2KXnWHSXfcpGHYiMY1UJzlqBSILtr?=
 =?us-ascii?Q?JWNL93PjnL+zx/uBqKZJgusTGS3BGWW+8jT1n9WsN26ywohlaqDTmH0fqyaG?=
 =?us-ascii?Q?s6iWlXQJGMDSyfcXrVNRRSbXVnmDrkp+YpWEVIy+0bRX4pMv9VLdNe+EAjKt?=
 =?us-ascii?Q?MfMyq5fHfiiONKaFoAvlnhqXy9DbPLPfiKvZzlAc68uFtqsfM+sG4D7UvrnF?=
 =?us-ascii?Q?CO5GcBDRp3zSAUxagbFq807rTdt1OLAtbW9udxEyBUX3OoGReS+EXJ+kElD2?=
 =?us-ascii?Q?h/SL1eaHMTQsWMPRtTwsJe5UMmdG0lSB/O1dS4mh7MEr3FrG0Wv1bQYsqOvL?=
 =?us-ascii?Q?BTcyfhvLdlfDxF4AIvGafXqaTQb+IRCIa1czZ0gv7d9puL5V3pFtpbY3iVFV?=
 =?us-ascii?Q?pEvL6eZqmXcYpGRFaNJHDyhmENcFB1q40OInPzeCSpk3Vn63lWu6FkMpcM3W?=
 =?us-ascii?Q?2m94mcXGAnonnb5sKJTG31+w7N1VOASPWqQWNLYDuhwTbp4ulbsLwfY/+F6F?=
 =?us-ascii?Q?038324xo7BoIfkQXBiLklZYKjfv8JKO4xqKgyxreo9JGGHN5lk+4gZwAshU3?=
 =?us-ascii?Q?FHNhRo0Z1FmTdW3bDOJ0MBlxkCvz8DdZeq+CBow6cQSxg01rUX9FGSm70GQe?=
 =?us-ascii?Q?RWH+p5DsgGh0HpOu5Z2SbTtFdgcNugoMClOCmJ5tEyQCO8m+iQxlwiTsMMLK?=
 =?us-ascii?Q?TZ8XQWG0Rk0K7wc2ymYBVXUsZee6IJvaSNnrR7QO63/vc1S90U5gc0P585XG?=
 =?us-ascii?Q?nLWFHJQKaV53aZOtA8KSk4/z0AazKesNNuCkBPc82ZOph/V2NIBkGhUpP+fd?=
 =?us-ascii?Q?Qcur22wdfsMy7gBcxRFlaBMlgwP/e86khPT0qu1a0LOmD6C6aj9NCG69DZrj?=
 =?us-ascii?Q?DuQLWQw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nn75gi5g/vu8Q9pLff0oDIeigWRz10kWMl/pwNB9/j/Mhv+9UcTQuPqz8jBF?=
 =?us-ascii?Q?z2Arx0PBt+O7n+I6/tgW4crtpm5cWbaqb5/taOWea6nRuOqA8a9iMenxibis?=
 =?us-ascii?Q?0FffSFbsDmRpVroneM4xGiVrepkf2BPueb3oc9Xdvqk9gWVauXCYiiBlr7Gb?=
 =?us-ascii?Q?4N4wAYg0q6bD0lffIrtjAJBzEoeSgOq6IEzZn+jjzQF7JY2ETjYJHIPwNkd4?=
 =?us-ascii?Q?WKpQm2d4URABWM3FVJk+2z7lx+vzJIrXMiU8vXp7/+JIC54UbAqhOpixtreR?=
 =?us-ascii?Q?za966FVSBHuCNC4xgPt5myuw3qE5hwnFuvd2WLaPfaingmheZn6qrNt/B81L?=
 =?us-ascii?Q?hcJehuDRt7FttnQ473uUFAsS23Tr1+v7gJygyD08uqlGdt1s1Qz/YVYS2IcI?=
 =?us-ascii?Q?sfUh+Rr1oneOR3bk379fVBwzMHTqWzfGX7sl5qheOARjaenVkkaZH/rGRNTN?=
 =?us-ascii?Q?OALKF19EL11d/lHTAxW8vtdhGjwFqUarAA2N/fMpSjwY4leHDYOmvqrtnL4w?=
 =?us-ascii?Q?DmHOJl2JPf58VtYGlIY75LXCTOSLvoVoia1JxQMyoEtK2SGDkHSTMOlDo2rU?=
 =?us-ascii?Q?8311Sr/SquQ1P437bXaO4GWW5bB1zz/PUF8lI/oqFrpntgab/Fbz7JchPMHZ?=
 =?us-ascii?Q?tw1+WNcYavVowPTUelJxMPvPwMgE+8ETMOB8VuASdeZLc43te1EeJAahAjx9?=
 =?us-ascii?Q?wys7VryaIL1oxtYiIdsSQEGWTrjvOvfwstgLvqIas8lDxUQ7kaLuY0etL1Ne?=
 =?us-ascii?Q?dP3ZyF9BKIXsJi6iv7SZqTWHmTArzPAtvA7WtW6brqW05vlG7E5DYJg0aA9L?=
 =?us-ascii?Q?JMnNEN2khLQl9U9UkysrBNRuBmmmDxOpn/Zh4hWpqkTWuJJXfS7DAylvkVml?=
 =?us-ascii?Q?/LOg6aNTLg/cnC6jPI5mesngIc+nc9dGu6nMrlMbCMK899vCqq8G2oTZ7SLM?=
 =?us-ascii?Q?kUO4BBGNwba76+u2keED3WqHTds8LsLiDASIkGfRWe2Yqm5DrN606yYWJTlQ?=
 =?us-ascii?Q?xpTKqhJEBMVZITBbdmU/ZfRiq3hdo699HKouoFCJXd/VcZPzbt4DVieEelxU?=
 =?us-ascii?Q?ECei8p9DOQoPOepZzF9xitR2b6KguLi45pSV65oPYYULjopt0IUL+9+F2qSf?=
 =?us-ascii?Q?sJ1ohJaVWR/GvPg43l7KV2rs60Yf3QLxPOsQzUXHNCWEMkZroV37QVdw9/g6?=
 =?us-ascii?Q?04hxahfK4EtV2+Vafr8sKIObbwQIvt91IfIKVC+A2Joq12Oq+lPAkTYSD9fQ?=
 =?us-ascii?Q?lRwxBfq93RIK5sph4rBavoCLvls5r3X0vRKTdUw350RGueh2Dmn1C45NKp9B?=
 =?us-ascii?Q?pxJTRmCqcygYz8s604ng3c+7D7r2oOXWAlZsGYw2hlJMb2LVV6qkGQPm4FFz?=
 =?us-ascii?Q?NjWxWJXpbpsP34adFOLTYsUmbM6CddtLcif3EBk7GqdmAQ3tvL4RSIEcg8Xb?=
 =?us-ascii?Q?GCcuobMjEt9IA/AT+DatF6W8WbIQu16PlD0U052v80FaL5NNZn796QQEnOXo?=
 =?us-ascii?Q?sq2uBdiUMX2jF6qMjy7BX+8UzDAenLEHAzvRaL7n0n9qKKBckkN5IwJPnXGH?=
 =?us-ascii?Q?HjOydX+AAcb/AbPu+oo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa7a44f-c326-43c1-e3ee-08dcc1ec8e1d
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:21:32.2034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNeb2/yMu9vcUPxblIz9fsNYqprU0QbWO/oQc2AnGAewtT9kfsz1AihzqXHJHZ6k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6626

When handling a numa page fault, task_numa_fault() should be called by a
process that restores the page table of the faulted folio to avoid
duplicated stats counting.  Commit c5b5a3dd2c1f ("mm: thp: refactor NUMA
fault handling") restructured do_huge_pmd_numa_page() and did not avoid
task_numa_fault() call in the second page table check after a numa
migration failure.  Fix it by making all !pmd_same() return immediately.

This issue can cause task_numa_fault() being called more than necessary
and lead to unexpected numa balancing results (It is hard to tell whether
the issue will cause positive or negative performance impact due to
duplicated numa fault counting).

Link: https://lkml.kernel.org/r/20240809145906.1513458-3-ziy@nvidia.com
Fixes: c5b5a3dd2c1f ("mm: thp: refactor NUMA fault handling")
Reported-by: "Huang, Ying" <ying.huang@intel.com>
Closes: https://lore.kernel.org/linux-mm/87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com/
Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Yang Shi <shy828301@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit fd8c35a92910f4829b7c99841f39b1b952c259d5)
---
 mm/huge_memory.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5f32a196a612..4d9c1277e5e4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1672,7 +1672,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
 		spin_unlock(vmf->ptl);
-		goto out;
+		return 0;
 	}
 
 	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
@@ -1715,22 +1715,16 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
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
@@ -1740,7 +1734,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
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


