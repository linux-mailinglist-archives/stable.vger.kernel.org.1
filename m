Return-Path: <stable+bounces-69829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6652895A15C
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 17:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6A5284F05
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 15:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E401494B4;
	Wed, 21 Aug 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fcjS2ZxM"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CAB81727
	for <stable@vger.kernel.org>; Wed, 21 Aug 2024 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253969; cv=fail; b=iPmD4oRl0kOFRTA6es+OCIWKi4/3OM60nVw8sanWxwqVOwwhnzlBdogJdFuiljv07VnBvoNIq4FfLmHpa76hwL+MNSKIxVJaAMsycRG5qIbCrFNDsxqbtgmoEp/P4MvR3Q9xKSxSH4pN3RKD/9u7ugnjBDBPQ93njMG1Kry0m2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253969; c=relaxed/simple;
	bh=Ci82zqm1rbGqq93XUKH0A2ek2xPOvagpJs/08QIJDy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZFij5YfSqa71MiX4AvEFV0XwnNjBCFrG2op5qdD7f8lbfikw+KY3gHSP3hDC0qYiQNRh8VQz55E0VNIUpg9vjHZifQbYMmjdxcsv3JMCEqcJpkcBZM+QEnSftheE68DcVQqkvDLepnFvAddqhMe+UzwenmKsqH75+x5+Nvz7vzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fcjS2ZxM; arc=fail smtp.client-ip=40.107.102.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afID/sFOf9/M7FgHW/vKLYllArWZx89TYTJkCOT2OiQt2nt4Ynr732XrSrO62sKiygGycRg21HRUVmjgZpBdafJH77MoPVfIApykotDJ0o4ot7/UXoRDN5KNW2J686NIbxj9EboJIC1MT+SbEDqJubqGo5CVjBqenWcQs2pLfo5TcCU55mUQmFAPYiJunfvpJa7q3OuMXMJ+MbJdmN3N8P57cMwoyCtBlIYj1m5cRJS+S+oEhWwjSZ8sF99wt8DtLweNFSBkxVdRZrM3QRux1rbsd82PayzQyDDwKHFV9XHpBUpFibIA40BVYCh5vAD9AnuLEFC19ePO8ZyFBpz/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zq/LiinxNAmgGDXs5M7aGPVVhQsd7FKnMyKivb63UEQ=;
 b=Z57eyeWBG0Tejhp0YZv52If1rB5OHUVcW0hQMIUe6LR5B832x6UKOG34W55U9r1IKxDk9HwpqJyYHQOftFU5ZyN42MUlCA/awZpr3/7cCUbX8rFwZFMWrvV8DNzZQ4N0CvJ9/Ktk5zB7sGT2k1GCEKp0TzrYz4RW9ZLJgTJ9ChVmlyN5B8Qx2onUWBL8ZhYVEz9Eswntp0iQTBiELjbRtNYj6DQd78VOJcUVb97iDLz1CmtmjRQLfqnRw0lWGHWu/8j9x8Wx+jzwNWf1PxABL8ZwnUx9KtK8n+0QR2DVkDQie/9fY9Bw+uf2TtMBix/Ri8kP3v+T8CWszdK/LcSyCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq/LiinxNAmgGDXs5M7aGPVVhQsd7FKnMyKivb63UEQ=;
 b=fcjS2ZxM9Sc3mfkEW82FtgUnhZ1Rn7Wxhbh0CET/l9c33e4EzjZHLgnXUwHUWFHCmjRxZCtwJdzHNAxv+qoOBzz2k3AS2D6bICAFxA60pPTKG+c57VMRJZ9v2GGByRyWUM5x8xaE+fIKMETi3wx4ITa8/OlUr1a1hNtJ1Hv72bdYe540DuZn1XFgWQ4gMfttDNRUpqkPQA3wc7HDzsz9lhnIy45De7y54DDb+V57GvEBzwjRIyFL80fQeecrHYmAubk6NQE6CIefEHFXzTW9nW3s7Qq6k2PAnsQZHj9dJ6UmXHBBXBeY48gkRn7rAbYB6XKejALhC+/BFrCdNkhQVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.18; Wed, 21 Aug 2024 15:26:04 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 15:26:04 +0000
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
Subject: [PATCH 5.15.y] mm/numa: no task_numa_fault() call if PMD is changed
Date: Wed, 21 Aug 2024 11:26:01 -0400
Message-ID: <20240821152601.2193954-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024081953-corncob-gab-6fce@gregkh>
References: <2024081953-corncob-gab-6fce@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0435.namprd03.prod.outlook.com
 (2603:10b6:408:113::20) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|DM4PR12MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: b89f4947-7a49-49aa-4e79-08dcc1f59244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p0hWhtt3L3ToCSmxYG6z1Wbski0q4Mh5qHgi1ZN8R5MbFN8z5BApHayNU2Zo?=
 =?us-ascii?Q?RQMDievHQ2V4VWOWM1ZsBdl33yaoQ181WAY7zaae9z6acx3Kr1p03BPXlmCi?=
 =?us-ascii?Q?54pptIfDwE6QKyWVav1Ha9HOVYzsdGWKy38WxFtDPepwYj2QyVQ6zl6W2DIz?=
 =?us-ascii?Q?77koOUVowRyZqRARU90ELMeKpZbNroKuJDRXhM6nEUK4vid9gWk2nSwMdLAI?=
 =?us-ascii?Q?WiivWld8OWAL+s8Tjs+kfKXRgHHL7oM3b3boNy/8NO8OftaKyTCSb2Xaxiai?=
 =?us-ascii?Q?1hTnKbarslG5n0jJyAPypfRVT8T7C46sEvlStNZtGBfFPGmVYaQ9TE3vtlfz?=
 =?us-ascii?Q?JMTSmkVwh4nv0/zpT4shJLkKGCypVk7VsjOZ3zXkUpmOsnyTbOxHn+mteVUy?=
 =?us-ascii?Q?f9P9h4+PBv9Jsi/m5odwuH0m47ZsN6X2RxUUlByBo5S2DyATsMyPxXHZaddq?=
 =?us-ascii?Q?uWUkQq6dPnlCZ0m+CA0AcouW8wvSWbjLo2+WIlnqzv/DlA/JDvDHmJ4saqbj?=
 =?us-ascii?Q?WxrzAsFmoyA5ZvSQ08ctPOio8SKw65e8cO/9MhULFEkY98qwyVIfv9GiSKkS?=
 =?us-ascii?Q?wXsxW5XkCXhxIiqdE55Kk/sP93vLV72q/3VLHdkZ4VgaNR661QO7VKtLYOD6?=
 =?us-ascii?Q?tIThZHKTFhr1942OtIO+LKrnBO98fTu9cjHFuGIRHx2IL06Y5oN7HpyZDruz?=
 =?us-ascii?Q?LKl+ZKesDWiDbGbBjsZ1LkgE63Sgu4Ost8nqraAAqcTR+qxPBTg7wwbcFm+s?=
 =?us-ascii?Q?h9vGnGF/N06eys0CanwyrlQF5ebp2Voj1W1O25uKOOlNAGWn+EJYchDMuno1?=
 =?us-ascii?Q?yjrNjsH/t93WBZdsK+fiB8G9qYE0aJrclnaQbzIRFFgPH42RX1rmcd7zv6bY?=
 =?us-ascii?Q?DsfzkZ6aJk/ze9SbWFkiPCsb24U4BQ6aziZe2JxC847rnT3msz5ofovKwRBv?=
 =?us-ascii?Q?f1gFAldLT6WHwIx8eHyknPzESypZmlplxeCumqADfQH2KwF6Cs8Sj4GOU87e?=
 =?us-ascii?Q?reQcuHO1cj9+FBwzRRbg+dtX4q5OH5F0xgqRvzBrKzWYppvkegj9gspdc/42?=
 =?us-ascii?Q?552VI+/wXbT9u3MbjXsvk3KuujjV7yyfij3VGCiqgKItuJ/ySLlYNj2FQ5D8?=
 =?us-ascii?Q?GKBIeKrcnWxgEe9n6q1DKbyxgjYRpQkXDFzn7lWPLm7KzjrU59dp9OYOIR3x?=
 =?us-ascii?Q?oc5CYoaqWW4cCUQL1x9FSnYC6qO+GbhhNEHu1BTSGMNdi3ebzkqVHIPyrTzW?=
 =?us-ascii?Q?wRzQxCdzGw3oXBVfsReAXbmkbLIOr1tCBs3dSoP6I+GIxrRTpoLwcteE2XwO?=
 =?us-ascii?Q?WCneniwA6qesCGA45QkYW+KkDrDMzpAmpLMO6luAI8mqVtTEKPorCT8/FHPg?=
 =?us-ascii?Q?G1BUdPo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j4oxIsxX1Pi7aTQJG/RXcUfrH8kWw51X3TZJePBqmhkHNJvMWhXia4HgtmqP?=
 =?us-ascii?Q?9Luh/uyo58bYMs/VRucMpFm0GUgCDmEEUUW7J7kGDCZEU/VIOdCU6uoowRLr?=
 =?us-ascii?Q?y3KhhfgLAKUSS4bpor1De2PG1G5qZcHe+oGm7rCdyGNJLSodCCQriSwh3iVd?=
 =?us-ascii?Q?6lY5qrr3dirATrpA2mPjIr6xRBE3j86oQK6uGDnz+8icansZwtAr/iPuheKJ?=
 =?us-ascii?Q?kAHbb2GVEyUIAX1i3+osmzj2Uw6PW9sYH+8lK7qeuD6hcNf40wKNegl2yJ8Z?=
 =?us-ascii?Q?uJMfGWi+gZ94mGdxwdlxg+gzd7/DWrYkdqzMk2cIeOgOVPyy16E/tdfgJnq+?=
 =?us-ascii?Q?xxngvWEZ1SYw140BeGPxTl/VtFFvNCUDsb5nuk6csWfoqRFL6j5NowLgXb6g?=
 =?us-ascii?Q?VJRg4mQf12b1FAzw0FkQ4vtRd9aPDCTOkPKRs2wuKN0+xY4QMSyNdHfqihxD?=
 =?us-ascii?Q?qd2yfFPcjiSjWSZcuOxnKYhWuqRxUsKlRiaK8Q04HnE3tC5RFEbtBn83dfaK?=
 =?us-ascii?Q?8SaRpC51Hg/VImAVfG//+fkb49Wg4SgpR0P5678rjyusKNigxX3nCWKE2mDd?=
 =?us-ascii?Q?6RHqezPwMbycDhDGZY192qzQ/e236OlFNswFS3la2ucWO2+JcV8OVJMSyoOW?=
 =?us-ascii?Q?MoABohLf+/LP4LoKsQx4jwPAlZKToAOAlmPU8cknPmL4cEA+EJco52JepEF0?=
 =?us-ascii?Q?ryf3TtC2lSYDDNo30IWOrZFVqjh9suMgjWUFIV7OuT4r80hjNkuKtgAW+A30?=
 =?us-ascii?Q?n+o6s6ZZMomnb0qLcx/yJOoufd96LlIHTxEuFa1GirTYMDg6VjY9piVDOqxK?=
 =?us-ascii?Q?ltP01ArFaWCut+nViNpvLlRC60WpgXB45p0T0ioqtVCzevv1zhVf0OrpjAsj?=
 =?us-ascii?Q?33OLudROetWhtuGPIi5v5D91KMRotQy8vdIkuIAnitClgjHeX4UrvjwYgWU7?=
 =?us-ascii?Q?92m6cUWKRmQzGLODkVp0J4YJLuU3fFSHoHWMfLQEXxnsUpy4gyePn8URt9g2?=
 =?us-ascii?Q?snJebDsjOQXZfaucqE4Un6i7iYvUxLOd/lRXaQSLv7pOGrJRXCM3+RG1IWMM?=
 =?us-ascii?Q?NcxqViEQdS536L1B1jb8ZQxRXQ9KU7Sgq1O2lFlgQOOtpi9e6YMmdr170tfL?=
 =?us-ascii?Q?tq7V3V3RRDjMm2+vFk5Yj7fzyYJUiulcxeQvKOjZW+Zb+Fq3WSIKO1vJemmO?=
 =?us-ascii?Q?OBNQRxvTuGSjUNT8YuvbMCRXGEkjXPnVMtbWxGQjD9NCUZn64Rbdqu2qkbYa?=
 =?us-ascii?Q?oE3YN1kh7vpurmwy/q8MbKzKLsgE9yJ5GjRVmoaXeTZZs1hL3x0pDFkfVt9e?=
 =?us-ascii?Q?ivbBtIidIuj8QkGKBqXZc/OMECKXPuan4u2AxxVk/7pa9eKXjtObN73tKOOJ?=
 =?us-ascii?Q?0T2Gc3hbHyUF1SLiCzGE0kHUAWg6fFDgCIVfTKuoFtboOVsToc/a+TNO98C1?=
 =?us-ascii?Q?Px1iRHKjZyYZ0W4f+x9r+PB+aDu2lgI0aB6htyNkQW3+XXtbGPoUu81Uwirk?=
 =?us-ascii?Q?IlOnf+CPYfe9xp1YY36A3IYgS1JbW+NqnP2vJXmqi98p/6QfybKvi4DuYYbQ?=
 =?us-ascii?Q?d8PPIJzytnUwgUfxQes=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89f4947-7a49-49aa-4e79-08dcc1f59244
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 15:26:04.6272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJ49JTf4v7iCyn9JxtKj9arNHdlJDx6MMoU66XRRuk+IfUPgbnQ4QFPbAfKe7ctV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062

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
index 98ff57c8eda6..9139da4baa39 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1437,7 +1437,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
 		spin_unlock(vmf->ptl);
-		goto out;
+		return 0;
 	}
 
 	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
@@ -1465,23 +1465,16 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
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
@@ -1491,7 +1484,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
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


