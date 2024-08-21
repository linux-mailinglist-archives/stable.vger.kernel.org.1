Return-Path: <stable+bounces-69828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FB995A129
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 17:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA73281A5F
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 15:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A872474040;
	Wed, 21 Aug 2024 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LRE3ACWn"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F651C687
	for <stable@vger.kernel.org>; Wed, 21 Aug 2024 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253331; cv=fail; b=h1JB56PDPCn+14DKY9eoPcL/lCSyIUA2enNJ0TfxipaZf3UvG3plV2FdtcU1eQLWes/TlaHE0nFf6Px5Pbfy2Du3gDG1U9AHdv1DjHPEovqcEnI+aJ16jyCbBp80CZeBUFy1+y9k7kG6wPTXVBGcEbUE54w8QRoC6jRQviQ2gZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253331; c=relaxed/simple;
	bh=f884xPAHpH7QiHumCAOym8xBmU0f+BljHdUfRJ133NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s4JpCAWx1I5kNhUT8qydbPkDT4Odk3oTqgz13ZD+KiE8K+aIX5EHY0oZ3vaMx/TIZidbefb971GWtUFwXPkdwVqulscJtU1YyDijKIkcsBt1d6yZU/e7ASmkyoIEW7sqLvQLW9d1VVAlwI9sqbqMkiYaZIFsnkh5L9Rzuov2jzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LRE3ACWn; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h86QvXptdLQ8GIVTEgcUs8PZeV/9CtxxQU3K1GBINe2V132ugVRCVbAXoZIyOW3JnwroFudmoS3WQttwvDv7JUh+M4ZSIdpN4NDLEdbsECnWs9TlmAdJUcyqm7D1san7Cl9oHl8RHhgJ6yntpPhjZAftB4lrzrhzQk1iibA9m5r1fsmvokrljISoTtH+y1ru1VpHMjszWSYp41w9BkDst4rB2oQPYx2nsQgrqZ8fu9Q2OqNcb/DzLhrSVujZIZoZfj9/cqpPAisNZZc3/aALMBtv0K7lJQ50qVVStzmMMgWPfi4/bi3q4ixjfsnCnJH9MnnsNiQAk3jJ/0VOMfeg1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVA6KBJHKKtKbry8gmhyMvQzfJPuBrVsWp/Fr7f1ksY=;
 b=YaxkP5nO7+/oNCuJhKeQcjSK9Z4UxxhyE+pu/cjjZRmBwWy3K7mqT/7i8yFayMfKl+P/okn7nsq/5J8eGrRkKuCwcC7iUK5fDoGfB6hCBFYIQFXEEik8guZ6D1VJVPmL9e1Mm5JpenYUQ+OdvbydR+R3y8EXmvAdEbJjQxv7FfLF16kJPZmYRyEOL7HPbn88HuEU33Vg6Cd3nbD+5EV6d19VZr76+CLqAVh2Uix/vKRwOGy9JLL4nx8CaTkFGSOg0qaRVuJCVM7u4hhXTlvixv69YIE7ev5TqldVeGM3efaVU01MdE1yyLJuvZ3f6x7rmsuCskK9+ZSzemF0uElMxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVA6KBJHKKtKbry8gmhyMvQzfJPuBrVsWp/Fr7f1ksY=;
 b=LRE3ACWna/rN3zEZERqe6N70V48r7UWbnp7UJRkZ/CaqFSiO06GwpI3HHIcx6vn6TNT4Lk6Avj2vjGry9Uliqahr+kENdl+LqYahb2786WnqyGoV/BH7UmHC2lie9IM664owOuAlQCfoxfmMG1IX4bGkj5Ubk76sAaL087TnFlmKEP4cDQ786xAoEGW0C/pUq50ZsfYSa3YwLn0dFeqj7KWksfzjR9+fZphnwWDmPz2z83+XJKtmQx/EF0LBjYXnXXDjAYLRFQO/PeIqZLbNae8Rhk3DbQv9TQGyhk0Aj7wxcT1q1qmUaqX5qtQrT4YxpUAGoW/XQ99TpxUeR3qf1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by SJ0PR12MB6736.namprd12.prod.outlook.com (2603:10b6:a03:47a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 15:15:26 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 15:15:25 +0000
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
Subject: [PATCH 6.1.y] mm/numa: no task_numa_fault() call if PMD is changed
Date: Wed, 21 Aug 2024 11:15:22 -0400
Message-ID: <20240821151522.2120968-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024081952-handstand-rematch-5948@gregkh>
References: <2024081952-handstand-rematch-5948@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0456.namprd03.prod.outlook.com
 (2603:10b6:408:139::11) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|SJ0PR12MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a96f7d2-3112-4bc9-9d23-08dcc1f41569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MB3fI5k+Ie9HKJrPi/c6Ok14lt/U9c+dqf9omnXOFGiQ/2CSfpo6MC6dXg4x?=
 =?us-ascii?Q?vfl8uhV3f8dBb3shVavc6BLuEPM/YpdHucDG8BDbB2Cn6xv41VuWcHJyI/In?=
 =?us-ascii?Q?ILtSv9WEEYlCM/LHyCOhpQ3OBg9TpDnPxfWhhyaEWa9GPuHlXmz8Rb4z2u/g?=
 =?us-ascii?Q?///c1ZulFZU9//NeXEsA+DaWAIOEW+F+zD9YxCx8akCOKvp6g5p3mx582H+l?=
 =?us-ascii?Q?VwK2gBG8X5fy6z13EPdrvMPoDIDuSfRDQO9DQ/NCTEQrRLvON3W6nRT3KSbU?=
 =?us-ascii?Q?R07c5I3yPRB49GURZep4yL3xLT/VSc8Rf7Og/nbWX/D223HI4xbFBrwNWhQS?=
 =?us-ascii?Q?qw8rW8kcVzSxkLEBMzIpMQNYd1Lte3vmSLzlfTSw19T1jCdcHOYaGWjfM064?=
 =?us-ascii?Q?99agzUtJ6RaZmzDFEXjdQFTh/tLLQnh2yDbU96LnB9v9RaMTFk/ddz5G+0MJ?=
 =?us-ascii?Q?U76zRVITh4StwW8NMWTIGu38UMBwAF8u+6xgoyONtvVCWY43ms12PbhDsefz?=
 =?us-ascii?Q?xSSA8VygzwAUY3HqgbHSt5YlZPLTqedSftAVyDV1f5B026gBmuIQhYnW+bKf?=
 =?us-ascii?Q?xCnwBcuTueSbOtX+A6OefHQt78LidXhyM1h5vbT1qgZqMJC8BAqnfBH74YgB?=
 =?us-ascii?Q?/kEzfVLki94uRtQwYuDif4kM3LyKNsph0zga+cfUftKJOeerqdfl10DU1G6I?=
 =?us-ascii?Q?6UXrNDhHuHa9gTtfRmXpzjZdvZ90JKjHVMiZkPnaZvZzWfzDjh+xv90YS1Ai?=
 =?us-ascii?Q?jKAoeQ2iyoZiP+0xH/YriYWtGOGICG2f1JVG9+kLIZAjAWrlMePTC676LbyT?=
 =?us-ascii?Q?ZwVvrXTX08bG4IN0jBiZZVf4eSEPBYJO0JK9C1SvLZo+m+x22aBhGHfQItMN?=
 =?us-ascii?Q?AN0S3tvDc69DV55UsbzRVv1zDvzcRsSNUeJ+rLHDkV/ncQjPJF9OO2MZiZCa?=
 =?us-ascii?Q?M7WpRbnhhQhOJIkQIi06QmFH080uBQhjDMstFVsSgeaHWPf0FAdg/RZJxuv4?=
 =?us-ascii?Q?LeR6zKKVhPh9Jva4mzK+aInuJFGLpNTlQYi3+J1XdiYwUfamM5/RSJhMdW2j?=
 =?us-ascii?Q?w+0BXeZ3ONpMsodzy6fO49jNJexaoOrmQUIkieAuNLHG2UhuIcfXaUE3SDOR?=
 =?us-ascii?Q?rWbQ91HqCcrcUn1daOJDCiynP89Fe0zV2vp3EIjnzn+0wLORgW1//kn3UW/w?=
 =?us-ascii?Q?W3Abf0d9JcHdu1WM+QOiZfEJVbeJZ+NiSjHO4B5sHh821Ig1NJ6kYb+fFaX9?=
 =?us-ascii?Q?yLIgdgN5DaonyheuQDkABKsKhaxAY/0pnd6QAZfuuT5VchYC1MB7ihQFoJU8?=
 =?us-ascii?Q?56XO/2JVjY8qlO6J3/+R0wrmKRkTv4D19eUnAG9bhSKRLlAR0KC5NQ8XnU8K?=
 =?us-ascii?Q?mbttsrc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pw5oAgGu6LBm4TSwpwtmcvz1G00HkJS8kf7sfANMM/0PH2PzsLOxYRIpGNdv?=
 =?us-ascii?Q?ivI+jnrjURnc02WZYVKjaVRYDGHk0wqBkwf9Y1OLOq+xX2hGCggYs4QiSsuV?=
 =?us-ascii?Q?O2Hl3fmytTZmpV57PK+kZNZ7hNovD/KVDY5TRpmKz3KRY5rUu3XRi0FI70TE?=
 =?us-ascii?Q?HeQ8OIUftk/PdCnnnKf/CwEEYVSzJPNbpdFagk7wWA4IH/aaYtLuNORTziJY?=
 =?us-ascii?Q?BUoI5F5kveJPzddBfvpVMhipmmgREt2zYEoWPlDZ5FnFbxI96XIgyjZLxWjB?=
 =?us-ascii?Q?5X+FyGDBZUQ/ZIGF4wdaiFc9CyP7vuL1vjbVHTkn1cXCmWhzgZAnTK1t9xp3?=
 =?us-ascii?Q?Aec9MWaOu0yWY1nGZnvw3CO9MGpaFoxrX7hyxMuIGFVZGK+dSE5EUmBrB/Ee?=
 =?us-ascii?Q?ayhaRqp6ryHwifK2D9VS92AcoVMgsHx3CdcEIQ1waU1LaiXLBee4vizbPoz1?=
 =?us-ascii?Q?whurapcpm5w+fse0N8rs4jH4dyU5ayuU+lTMeaIdBL2QfwCPP0Iux4pVgMsL?=
 =?us-ascii?Q?uETvt6uME4K02efaagYUi7/aVnGpB03VoWiimrdoUjMT8NtOWawt302R+ib7?=
 =?us-ascii?Q?pI7RL5qVlh+1b5QQhoqKCogMWKP8Sc2ZwhEUrGRxQMuvIkqWyzRzwkniMJUn?=
 =?us-ascii?Q?ndoEggke3UFSCApe7iO0/oCBaKBTyLQo1ku4rF0OSWnSKUDHYL5SpXjJi0Vz?=
 =?us-ascii?Q?Vi6u4YSpiG9GNZAUQCwAtd6JkvKjH0EBSp7eySTB2j1RnoKqZWw7vZJxUDFD?=
 =?us-ascii?Q?YNdtWY22xPZRSZXwXQEXg/4E/5wLNUgx1UW9gjZtxB4F6HxEB5vFTa4Hr5lx?=
 =?us-ascii?Q?IgV17PjWs2+trje900mABkLF16HaB/Q7RbXMaZZcrkI+y9GMXDtI0dqpbswF?=
 =?us-ascii?Q?wDXQ6pBCwN0ddoEKO3SZNr7rHN4JhTt8QrzqfQrb9+cfPR8pxBHxwWAdueT9?=
 =?us-ascii?Q?liSAOQGx2niQGuyZwIDM1Tx89QmQbKuZiKI4Z1GWgHNePmMMiG8bMqli55zX?=
 =?us-ascii?Q?lIva1IBPuM1jG0j4xfSuXKxzadJbJUcKntqWxYK5psBYO8paBc9EC1hx3P5O?=
 =?us-ascii?Q?RiRCv78P4DRMBcP+bHo/3d27ywaw05Bco+pNyjq3NUzqsHGkekFuLtUNr316?=
 =?us-ascii?Q?nbhWWYpUcGPa19g4kjC1tdSRvci/IU0sh/TA0TAZqjgSpkYujmkqvH9hqWNH?=
 =?us-ascii?Q?NpCEeGlD7wDP4T74S3UFx7Tq8rPTGe+mMXVd2P8ZokPhdD+vQXWdp6pUHi3t?=
 =?us-ascii?Q?SEOBXdJrq8yxGl17gC80YLzpzK5vILCX7kc5uIWIH2z1VsK901Yjt2hluimT?=
 =?us-ascii?Q?E2sMLCvO4kVZJnxQL5f+5Md0qrxPJG47cCNlg/tGvq8FrLbvKJuvxtSRXkrQ?=
 =?us-ascii?Q?qdqynQIygKLK6g3ft6P4Zi6DP2GkZpwUzv/M4N6Z41tujX39G6Di1VN38OwG?=
 =?us-ascii?Q?plVjnxE0YMtqLWr2TXf17VTMe2j5JfEToN3+wZM0ukNUP2w38pCJzx5DvgRn?=
 =?us-ascii?Q?E7Dhr0DJ4ywVV+SSiYoS9CN3YQPSXbXrwf6BCGbGb59bFVf852T5aCQBpTRx?=
 =?us-ascii?Q?98+RUawQkPXzYqw8WVE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a96f7d2-3112-4bc9-9d23-08dcc1f41569
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 15:15:25.6714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYgKiKLH4ofBip4umycNazIKPgjbwjKcz5oAsv5/MlfrbLDHVQ38zCAMyK0pvCL+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6736

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
 mm/huge_memory.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f97b221fb656..98a1a05f2db2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1492,7 +1492,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
 		spin_unlock(vmf->ptl);
-		goto out;
+		return 0;
 	}
 
 	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
@@ -1525,23 +1525,16 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	if (migrated) {
 		flags |= TNF_MIGRATED;
 		page_nid = target_nid;
-	} else {
-		flags |= TNF_MIGRATE_FAIL;
-		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
-		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
-			spin_unlock(vmf->ptl);
-			goto out;
-		}
-		goto out_map;
+		task_numa_fault(last_cpupid, page_nid, HPAGE_PMD_NR, flags);
+		return 0;
 	}
 
-out:
-	if (page_nid != NUMA_NO_NODE)
-		task_numa_fault(last_cpupid, page_nid, HPAGE_PMD_NR,
-				flags);
-
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
@@ -1551,7 +1544,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, pmd);
 	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 	spin_unlock(vmf->ptl);
-	goto out;
+
+	if (page_nid != NUMA_NO_NODE)
+		task_numa_fault(last_cpupid, page_nid, HPAGE_PMD_NR, flags);
+	return 0;
 }
 
 /*
-- 
2.43.0


