Return-Path: <stable+bounces-58960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E65DA92C809
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 03:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57223B217B6
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 01:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6743D7A;
	Wed, 10 Jul 2024 01:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F2+6l3S0"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A27E1392;
	Wed, 10 Jul 2024 01:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720575948; cv=fail; b=KzQaTJ7llTfgEXjxcYk0e5S+QmsWNXpXYFR8y11A/j6SH5qShBqODdBIFJ4jfKLz/wb8MmiIwEeu5fuQ7F0ow12isT5TM3SkzoMa7MAJbDEpmU/eB3ErAROle5QnqvrH3/3y9Duj5DVyNE+TY/sFXxMSWJVfNyd8uvcbmxkg8Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720575948; c=relaxed/simple;
	bh=04h1HKRo4Vyr9EE7j7aCS0zMy30IDzVKCyNrOqastE0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZxJ1yMMOlDlXfq/Sz7x9H1HcQyQj6QsrQ8PqUA9tiSpThzp3WQkp/33rDwnHuzmKijf1wK/gAbnEcHvR7dXN2Jl7S3MMCfhxaYNpgZ2DqSi4j6Qya4g1PBc3aWWz0SPg9Rfw0aM11HhZOR2nOUvdZAm+E3WfYTDhQ/thwyLSKRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F2+6l3S0; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8m9vTY0uLXwR5itiImB2No18CaAmMqdR/Kham4LoJYcOIkhtLHWlMXf23fA5jEXc9mp7T9sJ2IRGuBm0jPeCGFz5v3ppEVVdqmE16690mDuS0XWTlqlWL8xbN8SsPEqFFY30tXfuKZ2VPExFo83LR/KrjCC/T63NbYl6kMUM8PWeuz1LDm/QjaMhoNAcIMx1TAyuJ9flGXm3ExZnziG8Es+7dkJTOEUb90nobPkanffmnNkxDOPGfbl4P0NsleX5ttCZeNIY+SPI+rltS+jHH7fNEYrxHpUuk7zeHVvKq4i32b5gvv7W76vnYSYzLCBP4TQaNLK4/qtIk9jHqx7NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfWWcoqkoNVKamJFODHTfyIUszaC68KwFCmQryHF41M=;
 b=MTxaqgSRLruzZ7XEiAlJmw+X+hvLzfOp4zRJx1Vhg7ngz2EsbtNt2TA1f8yO5Nf7OXXctmQ5f4u+JY/01qMA6/KZws6BRPlRb/KinoFgSzipnKHMBKUNZVH5eiS0UhIVqJwrQk/GSgdIZxNlvxn37SkX67LVi2A8e0blHLa3OC8LTYydKQd9OGirlAUcmudQpRZgovMdS7MKKKYRk4n/CxNyrfaTGhVTTvKATa8S6Ey0x1Wy0TkM68n7vM6iKfDSgWsePAzOzxK5nukAcQIuyGrSeF/q6HyF0GaO5wcAg0rsxC03NRNhEnXclJBI7vYOpfSZDmb8vKMmZ/GB72V1ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfWWcoqkoNVKamJFODHTfyIUszaC68KwFCmQryHF41M=;
 b=F2+6l3S0RIbxX2I7QMc3MavU5KrpaQUQfiKpds3sMILQ0+xg17wYLb763LlzBuda+h8mbeDouNJMeQqgIlnIz9eZ/PUYOVlJSY6ymjmqL318S0KsHp03f8tp/znSbCmyLAWo9T7yBnOAf6eFDAoeQPYWazgDgtKDsdy4a0GqOMDIj01mOgl/aOSx9NE0RohfMp53D/j9LDoTJfII9p25u62wEKS8kkgop0rk7yZXqiOnFzFjFjbGIdvJ/D1O10cz0/lVROAknvY1jGznemwgQ2RvPr7Nw8sI5Yo23y3uGPvI4LP0/a//x9al3qJKk+bOMkZIkqsQ9Rnldksww2eAQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB4742.namprd12.prod.outlook.com (2603:10b6:a03:9f::33)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 01:45:42 +0000
Received: from BYAPR12MB4742.namprd12.prod.outlook.com
 ([fe80::25aa:41a:d2ab:7211]) by BYAPR12MB4742.namprd12.prod.outlook.com
 ([fe80::25aa:41a:d2ab:7211%7]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 01:45:42 +0000
From: Ram Tummala <rtummala@nvidia.com>
To: akpm@linux-foundation.org,
	fengwei.yin@intel.com
Cc: willy@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	apopple@nvidia.com,
	rtummala@nvidia.com,
	stable@vger.kernel.org
Subject: [PATCH v2] mm: Fix old/young bit handling in the faulting path
Date: Tue,  9 Jul 2024 18:45:39 -0700
Message-Id: <20240710014539.746200-1-rtummala@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0371.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::16) To BYAPR12MB4742.namprd12.prod.outlook.com
 (2603:10b6:a03:9f::33)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4742:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: dde37fbd-2d00-4ea9-8a92-08dca082024f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zxi007yEo3qZ5B9ujM3w1r1uRJkq3hdx4rXviJh8iTXh/ngq6T1jVbwMkery?=
 =?us-ascii?Q?HwEkX+CZduXfOfyD9KbhNsMAdO9Z+rq0al6cz8rss5RfOENSzr8FMJ+zAM67?=
 =?us-ascii?Q?YOBb5c/fQ+dNmJvCQK8iHjTOrHATn+Upy7zs33kXT/D+SfZmOXvz4bZZZd01?=
 =?us-ascii?Q?PkMjB0awDaO0csH3/SsQ60limpE7yQyLZKaB+hOIs7F2lF3XQqDBIvLYgMR0?=
 =?us-ascii?Q?NHga7SgThA/0qwYWrKkapaLCIXDPeLDTspJTOO2Ee7JaOGNPILhbDTU+YU8n?=
 =?us-ascii?Q?rcnJel1cMJ/nVsYlFAyCSE5aDeJt4FLNG9t9x5f/3sXvzApT7crssz4mV8pe?=
 =?us-ascii?Q?zRbpm0EFNnUcZ+saBOOJbEOrg444WWeGIWN0PKwPLKGsNXT+0GsL2czIbGX3?=
 =?us-ascii?Q?aGcBEqtNwEvMB+sTlu3JOrt3Irby/qfkxp06/2jcUq5p1RHq/0hcF6rJrr8z?=
 =?us-ascii?Q?5sGQoDd4n+BwYRc3MGiwEg0fnWDyRtJtRJfSP3qM/6tjr94gYjX2MCGibt/Z?=
 =?us-ascii?Q?jgjzFI5vzeBLtb4u5XJGHRgKSFvtCQ7skbippYqFKY5vB17+YzXwzPWpDNSQ?=
 =?us-ascii?Q?e3cYpxNhdhD501BO8j8ywP1y16nfc335fAVlakOWyvQTM/Qr0Hqp5A4UNbh8?=
 =?us-ascii?Q?APa+gw+DzwD4jSbzW4Bqi/p426i/KsYkA6rvr7PNdKTtoBzWd0mUb/2mLyqU?=
 =?us-ascii?Q?s5piwwQEhhcewPLjrMtvmzoCNS9Vb0Uw3aHwNQtGGTw/PN64OqtY0jRoGVsd?=
 =?us-ascii?Q?DCJhF6ez5LWo/dflhTJ6F2apI+aVUNay1mJi7W4rlz3KbrPZdZkqO/7MAB8y?=
 =?us-ascii?Q?s4pf0q3KRGmtUWRvqsags3wBC2Q2MhSlLfSwFXD9WsBWf3+NeQj/tDUyJIIQ?=
 =?us-ascii?Q?+zFu1iS8qegRQI2I0O9S2I/ngG8g5wLS60B7LX2Xew+kOzHVn1HgGHDq9UfY?=
 =?us-ascii?Q?XOOdK5/5jfNbLw1rhb7TimEkaPE6JNwTL2HlM88XggTuAQtiEfZehWUnwd/0?=
 =?us-ascii?Q?BY0k2f38dWrH1fPAVIvZ9EZOHG5MPam/OFY8teJgCh9Xat5a0Y4vsgy+xjdr?=
 =?us-ascii?Q?+gHnm/u3cgjjUEmez1RVixIGjIwUV3nLz3T1bwbtnrHqXnHwaIlz0FKVTmM9?=
 =?us-ascii?Q?kxPPvisU+yJ55PeoJ0KVf7DrXR1A1wyoWBr4DXusQzasZhh5N3wxnj7mrIMu?=
 =?us-ascii?Q?GD9JEH0k039djQ1lSDfLz9rMRkYvPnSNM+wjXeASMjbc0p9fwTImMP4cUFI/?=
 =?us-ascii?Q?0YLHU+FqUoDsDNKt3R9bMEb/MmF4LqgGZYSLvjWytgCwV/Du5ioEuXImaKO6?=
 =?us-ascii?Q?CMKeC7vK1KghywmzucRVh0XbkOewlTJGHDRPeNMntjqkwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OsvBjTkd7lglJqJ27tdCa5LGqKv6uzKwnD4binT6V+bqExHU+S9gANb9oX7h?=
 =?us-ascii?Q?2cqNXOGY7an3wYYevzFwsBMdYyT2S1vBiOygSfI34GmbBj0kl9W4H8ChRD8i?=
 =?us-ascii?Q?nv/HCVHLz6DL+3d+CFMJoQGKRsWVOeS5WgCTR17EWRj1cESr229/wgqHVflO?=
 =?us-ascii?Q?Sgn80v+/nx5n0a3O1IJXz59pRtmv+1jzpFGyE+7il3pSRtVLZ0vI/SGSeauG?=
 =?us-ascii?Q?cXwFdzclPcDiMD/jerofMKBvIzjOL6d0hA9/LJck3KFsfvfNkNHI7+/YMW50?=
 =?us-ascii?Q?pq3XybnAJvcnmGChDLSxubIRsL2hxgFPwjY7q+aQ1A9DTL1kCybC8xeTF7AQ?=
 =?us-ascii?Q?4EeGIJLG3fdOCcH+u0BGWsvugW7dGxoxtDrjiD1HTnsIaxvWq5nZRYQHtrvR?=
 =?us-ascii?Q?i3S51rrjrSZzc79jLPqJ4vyjkuSqGztxHIYTyqAfnp5TzjsVA8B1GO01Y7qR?=
 =?us-ascii?Q?Ue+Qi0dhUeiFEJPr03sQVnuGYFsY9gA5diugV6gm8AkJTnCtA+BEH8jWxisM?=
 =?us-ascii?Q?B4pc0hNDG4EVOExWtyUSO4KpDypJ5j5JDPoom3qUhTmNcTYo6HDNcqAzGs5E?=
 =?us-ascii?Q?XYEHdRLGJZkVqQ0aWcnrrgqFz9ZCpXlWqiHxU3x5Gm6lSgAW+aOhSoS8CmMY?=
 =?us-ascii?Q?PeJOhDKqxngyCfeMG8+7Cxl+PD1RxTwDkPKBq0TMgpdLeLO0BO8gIFrHHErY?=
 =?us-ascii?Q?KcG4wo5to9LmNrBfmaHIsVz/6piSfVq1e66W4KyHn75Csml2m7N/sc7p7Df9?=
 =?us-ascii?Q?twLJsy1JebGT/xOCTrfSB9ujgMigTUyDlGeVq5dbk4shOC+ce+Qska/ZjMg1?=
 =?us-ascii?Q?/pdl9lvxhoTH22ZhVn9QQeec5XRuAlVpnD5PljaM2R7ZPV8mip6RyAPFo5DK?=
 =?us-ascii?Q?ZcF5a3h2SVU7OO1HKeOFKi1DILwSWU98tLQhFs4o61knauQd4dhR6BSiENlT?=
 =?us-ascii?Q?j8zOhfqW1uRB5veehjtwF9jpvXI1Q0K/VC7lb1ImBNGUshceuc5QHnOv9bsx?=
 =?us-ascii?Q?9Cl06KxpLFMXiJjql0BdF4VhqEh62oTWRKtQNe2OJvN0ZaQ9P93WeHlmdJ8x?=
 =?us-ascii?Q?kbqH6nGUTKGvsv/lGV/PWZ2YymlXIgOdrTMS99beiS/4m8tO1GCpvVhLLRZb?=
 =?us-ascii?Q?G1uE8xSESChCmECtrl27wFVGWeoUk2T07dwPduD4AU5Q+Mpv+5DBAJbHKNFo?=
 =?us-ascii?Q?moh8eO3Rt49SblNrgaR1yck06PyhRPTo1UJJsjCGBp2pNGXQr9SrntE7Jjyz?=
 =?us-ascii?Q?eESxW4f+CcgF459a/tBH6UhI2hp20Nn2tP/rMtVA8qlZIYQTEPrHSYQbclcz?=
 =?us-ascii?Q?Nsqliound7SO0uPf8wxUeFHUOhqJ/hMY0OR7Js7uYt5ZAfmszdzM45s9pZep?=
 =?us-ascii?Q?kRHT4Vs/yIWffwRxKgn3Sl0D3+TSFAdIlxkF5NSnlsgSkH7J7KPtsSzsM0U8?=
 =?us-ascii?Q?cxRERrpIk/gL2VWokJLY9wlNvz/xTZ2SwAbsDTrzI83F5K9sMJ7a395Z7t3c?=
 =?us-ascii?Q?i3uYoJ0sqIuVWrL1sa1LGXDtxYogTzf4gz6DWhN81lnYTaMm4ZMwSSlADVty?=
 =?us-ascii?Q?Ecv4eEVdtT808FAQrOHuTiTO7DCtBaGFHSFuBlHY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde37fbd-2d00-4ea9-8a92-08dca082024f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 01:45:42.5446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0QbR3Vv2Z+vo/PL98WQc5DIoV2gry3qB96E9jFZ1LS3pfq6QQJt5poTAO6dwuv/aTd/+FP0zo895h5QHtrWTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656

Commit 3bd786f76de2 ("mm: convert do_set_pte() to set_pte_range()")
replaced do_set_pte() with set_pte_range() and that introduced a regression
in the following faulting path of non-anonymous vmas which caused the PTE
for the faulting address to be marked as old instead of young.

handle_pte_fault()
  do_pte_missing()
    do_fault()
      do_read_fault() || do_cow_fault() || do_shared_fault()
        finish_fault()
          set_pte_range()

The polarity of prefault calculation is incorrect. This leads to prefault
being incorrectly set for the faulting address. The following check will
incorrectly mark the PTE old rather than young. On some architectures this
will cause a double fault to mark it young when the access is retried.

    if (prefault && arch_wants_old_prefaulted_pte())
        entry = pte_mkold(entry);

On a subsequent fault on the same address, the faulting path will see a non
NULL vmf->pte and instead of reaching the do_pte_missing() path, PTE
will then be correctly marked young in handle_pte_fault() itself.

Due to this bug, performance degradation in the fault handling path will be
observed due to unnecessary double faulting.

Cc: stable@vger.kernel.org
Fixes: 3bd786f76de2 ("mm: convert do_set_pte() to set_pte_range()")
Signed-off-by: Ram Tummala <rtummala@nvidia.com>
Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
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


