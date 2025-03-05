Return-Path: <stable+bounces-121109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F3DA50C2C
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 21:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5953AA975
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 20:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05636254B0F;
	Wed,  5 Mar 2025 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kRFcqL9s"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37513255E30;
	Wed,  5 Mar 2025 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741205054; cv=fail; b=qtnrPUuapEr0ruVYyGvzhaWk3l7bOaEVSuskm+dCJxy6+E0xEN6MzjkrZjueE6UAa1zAPXRcTMhJ3peJlJQLyXnC+EFdLPYHNFNCVqMuuW6BVQnjxVcVrP1kH12Bv8T3EGi/YFIBXW4C2C4mHo3kayqesHTDluWiRCnulzmqbJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741205054; c=relaxed/simple;
	bh=nUGV1D2DbTcRaAkwDUKCLC2l/kLhu93vdGEabhyeEE0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AWDB5d1cwSwuu5qapRKUl31+ELKQM9VsHHqeZ7xgMbhcTQhnRpaS16LJo4PXfW+la9IgUCBg1ozwSsC8xxrH4EXfnx8Zk11fwkRPo700gO2/NA1/ez2CdQHq1N8oJKqOFY8VW95EmMBa6hIX32HUTeQlk1xoZ8NmEYROte3PBvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kRFcqL9s; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfEyLVZSlqYpZpAcCVpp6BK7En2Y6PnCLjPKJ9OyoVA89ACX0CNgX58yKZkv+EAEDV03CvOl9yZICIuxUFhdz5DHAT+cGS8cls/ELvAWQLTFCKs4JyGyqPO2NsmCzYly/vL8G48TcZyk9JpJ4xDeMrW2Obd+QQKRAVBUqF+u6DKq+um/iB+zvSjAIoKFir1xXkWtKGa7Y+wayVJ8R1mbRSZbmMJLCTFFmaQcHpC5aQJFZpa+k/l1a0GB1oiKWW5pz+hZTPXh23lG1QDcjpGwYsTi8Qv/2dgZ7zFWOVq7fXg+a7K5mhksiCiwOGmhTQeaiJ1sT1SD7/mMJrV9QgLMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9b7xLe2/Rg5u3rqX+HvFsWMspIKPnYn00fts0/59II4=;
 b=ccHNlOB4C+OUpBjdymOUZTdmqOBGb+GECXuqHE8U8F3nMEBuJxdZF+Ra5VYMu144UE2ZyoZAl6SGXRMn5w+PcXLKQIVOGmK6XxU9SGmaBbj90LkxneGLvqHZTTGtzLrrRENqxE1PrNlJ1ekLCS4kX6x6/TyM9k1vVvI+joGlFHzUYhqr8LdLWJeeCWdLCF2X6ARXORvOKFBMvVH64Zjf3jMsTiIzCfm3CopGhE2jql1igP0xonCI0eNTyjkxVdna9283uKcf3VKc+6K4lWggE8hlXsyhASjUCABSxJ7IggYX5Ozc5TaXyBsx3RXcxTFExaVpqJ0b/37dE0pwgUlpfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b7xLe2/Rg5u3rqX+HvFsWMspIKPnYn00fts0/59II4=;
 b=kRFcqL9sB/DEDLfhVYjyRwCuAWk4sxbRgcDdEeJ3Ngmziz6ogTb4LAHwvlr3UqZZ8C8v06N7xHJuuEJV4i8Um/wTL22I+tfkTvEPdqTdKRPNtsQO1fAS/anEB3Pwlt4xUdXt5N3He9+JLim9DvW0cbo0lIlbYvCOZq+kt0iK7h//2jN6mBy+NAsgoMmOeRmzfQfpbC6NjKzHZdgcJSI729OBaEKz2A0O3fhbES/70wk1GloeAoCZZXGjnNQQ/nexe4Ogf9zJn1kqHY9IlluNTcQxN4Ec5NayKyiecpCcH5XnS9HjRc/25g+KGsOZh/aQd8a5Vb21hF6RreRuFH3RFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ2PR12MB7847.namprd12.prod.outlook.com (2603:10b6:a03:4d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 20:04:08 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 20:04:07 +0000
From: Zi Yan <ziy@nvidia.com>
To: Liu Shixin <liushixin2@huawei.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Lance Yang <ioworker0@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] mm/migrate: fix shmem xarray update during migration
Date: Wed,  5 Mar 2025 15:04:03 -0500
Message-ID: <20250305200403.2822855-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:208:23b::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ2PR12MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 81039196-c359-4fc6-dd50-08dd5c20e33b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EmSKXN2a16mPpvYTZUhhMQWqu6fTIX8xMjmZHqkPrYH1eaNoF8q/iwryRSkl?=
 =?us-ascii?Q?726OrKG7iZAs4u0eRiJjklW45m1OwuYb+6nNjKafWllqGWVKi1/gxwEPVVTH?=
 =?us-ascii?Q?vYtNZ2438ZA/Ja9dneSkk5H0O0s0AQecfTT5UkLpg/YjFd6uBYnZY7TsJQg6?=
 =?us-ascii?Q?Rv2dC81msQeVXG0Cb+4i4H/o5i/2IUppaYxEGXO8ui4ITe+zImYF+la09Sm+?=
 =?us-ascii?Q?NergKcEOnkVgszn/0BPAoXQw+Gwvo0a6rwqcW2NdThcHz86oirr4ooHCTU7q?=
 =?us-ascii?Q?RSCT5Az7JIPjofv1CaMbwa6HmATKKK/FpZfYkjF5GiRPddo2iv0tw8GIdOa9?=
 =?us-ascii?Q?cOedy6vn3uTMhGdXczNRcP4FpS3t+TsXi0mBbxlgj+XMb7sVPReJi4U4/WcW?=
 =?us-ascii?Q?JFEILvJzG1fuwYkT2K7EPy5HjF+BOkBCwaTp5wqcJTmjj5yiME0gCkw4BoEO?=
 =?us-ascii?Q?g0wD6jQLaSuTRzjOm1OGWNQJSgyX8XLMeqG5A9S+JCzW7P5p5Z+2FYJj7/SZ?=
 =?us-ascii?Q?rFgpQ4vVvpvte4nzZeMEQtYvxtyK6FKTencUfsBX+m7PACc+lhlz7Cidx6US?=
 =?us-ascii?Q?OBRNf5OavG/zbeXQb6ralx/TQVCwU7yu6EQA4EMY95FYOq/SL8m/prenJawk?=
 =?us-ascii?Q?U8JB7FOjq8e65DYduqcwfIGGyRDf2KzbIFqdVVzl5F083R6UUd3yAUAzAO5C?=
 =?us-ascii?Q?l1ttErt7lD8po6BcZHo12wkMQ5r5VCZ82uoykrcH19yuVJ8IPc0joM2V0FWj?=
 =?us-ascii?Q?Da9nSmKmH5ftL4bHt28OYIZFBB/U5nZWoxmWoRAvrfNv7yrAHCxKrLe7DTjl?=
 =?us-ascii?Q?thAsVlQQQnvBL92mtwnOdU1Jg7rWqlVB/kgz22lIigDSs6luCpirNeSkD34i?=
 =?us-ascii?Q?iK+0HhC9N8QKHCjF9MhHoclwJpzB2LagK+a8KKemHjERxJd+Qm666KKEkAkS?=
 =?us-ascii?Q?3pW6wI2KKHcN/nLIP+xrlfiy7nfgE30QYQzLgaupKr9mLFiNM8Yqi5M2Mx5R?=
 =?us-ascii?Q?+VduuMsiQQ+R4wRcmWNuuauMlp877Y1fRU0QWJTvSFe2+bla00f2pBHbzg2o?=
 =?us-ascii?Q?+fHsgnwJ+6Ep8MrJQRzECh+feAt3+WEhWGLNNuN4AahWoMElD2WGY6GjJPDj?=
 =?us-ascii?Q?9GFLr5eGqMwWgYBxwaof+PgDT+8WVoMUJ3R+yBUzd8hWdlkS5h7xc1aMg3ap?=
 =?us-ascii?Q?oi+OdLVgg92yPXZP2jiL1Z1nTe6VvNzEs6KY60iUqI6BAday3tMpqpyH1nxg?=
 =?us-ascii?Q?H8KsOOq+zQmtR7KaFo2uXp7zdrn2Pjykc89Q1pFSWXbU8IT3AOILPb+MR3/S?=
 =?us-ascii?Q?Zklnu7rne2VMSm5IoRDOGPBcoNRCbgzcUObLsF8zDxZXWT9GQIiMh8xNGuMm?=
 =?us-ascii?Q?yzJgRqY9fthugvEA/w1EY2N1RsnU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zSef47+drS4G6wcMn/AaQWx78si5jIrhm2aOoo3x4lL4cLCzUZdERlj2MuQR?=
 =?us-ascii?Q?GOF9IW7PFFDqv92RgcLJ/nDnCfziMCJoI6uXyLaAG0pMGicYoaZyNQzfYvtB?=
 =?us-ascii?Q?+ykmaQpAowFrBhTISh4jwnCpmRKL3tpi+MwfwDo+rqWOl6+GuqEb9kquaNuO?=
 =?us-ascii?Q?ru8RdQ72REGDGO/wfH7wVUSTYvEoJg6O3l+aBIFlfKQ8YR55Qtb9OAGiERnh?=
 =?us-ascii?Q?5r/C+c2mhMhQxrduGQSxc01ze12g9mHHHrOrDdjE+WOUPZNBeiHRit03s0Dl?=
 =?us-ascii?Q?x+d6GCUpcKhUsVhJ72+YqM6WxiqKkFE86i4fnZv3SD2deGyPH693sOz1QHfm?=
 =?us-ascii?Q?gtLKNW+h3ddc/67ne2+GClGCdbWhvBCjJQdyJKtEBCFYMs+bxtbxhq9vV1bT?=
 =?us-ascii?Q?XufAdg25mA6R/Xz9T12W2JQgCxYjxXtHUJ6ARGHhO7tm/WdlbEeUqrWRBG2B?=
 =?us-ascii?Q?oIVDuLEKNN9b6pO/HDH+Lvi/ZnoSH+KE16g24hjz6GLDE6agKzEstHmcdbOF?=
 =?us-ascii?Q?yKv/yPsPUBEGyD9PVhhbTTyyFkkXHGT4UvpBXQUr0nS0B5VhFB7PbpU6ofCs?=
 =?us-ascii?Q?OWLS/CiEOYNCKkx2GFwM+TzfCTZTJ5Os3ZX8lZQfOv/Mk1JGO3WNnpxoJE6q?=
 =?us-ascii?Q?A5tX4JwtzQjDHV1Aeao7FFgSFVw+hEKH8rwlcxPfLyssSRgHYxmAP6BCXJFa?=
 =?us-ascii?Q?FVzJUCN8yTKhfx7opGBNX7awU/RwYxPS4rQfcDCcU4PLTYeW8jLTg3cCOW65?=
 =?us-ascii?Q?ZRTvogpPSc51J9ey3L1V7Y9RWkFaK3jp2MQtFU1xD3Q6ptyPWxAR8zU9NWbU?=
 =?us-ascii?Q?SyB2umBVQErUFA2TRygCValr7q+KO7luQNBSwUnUswFDRFs1/pwGQ16WhB+3?=
 =?us-ascii?Q?rylovRcE6lXOhFLE635rhwj9nnC8K0ozQzuIcuONb115Dkl+WsKXXoPCTwFA?=
 =?us-ascii?Q?MApn868u5Jq6PxCC1ya/4Y8dHbihSWFL3MmQaQIS+v3E+hFkR9RMU8m02bqt?=
 =?us-ascii?Q?kExKQ1EF1Et6F1hLUmeFhklk4uhUPK/hHSEswsAO4nnuIZKJpsETQCR3MRm3?=
 =?us-ascii?Q?kq7MJjvQGuRoOMNsnSutCacWLd7npNSseKu2DqhX8vuUpIGKhNmOa+RqRBAk?=
 =?us-ascii?Q?ZD6Og1czE/1p+tXGTSJ63GKExV5hhd+dVtlGw89D2m3LJIVs11kjmqWif1xN?=
 =?us-ascii?Q?tz/fJgp4NgZgXoFf3eC3Mo7pNLueVGEpBQhiCGw970wlIVGJX7UgeLJFfhTf?=
 =?us-ascii?Q?azV+m4/xM/ypG6AXHpJ36+LqkrhDNncZzGCksguke5uX4qUutNIb2ZHFDcN8?=
 =?us-ascii?Q?ienyZzfzcjFMrpac3iSumiNs3BAWl/BYtGJlSzYXTu1aTKLFRECtKwh/ogzh?=
 =?us-ascii?Q?oD6g2CMLbF833qyd405Ph7mgJ50KwFRFRYoSDMPSYb7dgDnBmR0XORMMa/zG?=
 =?us-ascii?Q?C3weUxrz19jwgCVDignyUd3kNg96cAp6sUuIBclAVCLVDPJ5/x+grYW4lCQw?=
 =?us-ascii?Q?Nn+2p0k6hnD7V9BuQc7j7z3v+E0vr6UZyGHJDpJ3hZFN6rCPyClN240MiDyQ?=
 =?us-ascii?Q?oiYF6sQLLinT3IZp/ss=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81039196-c359-4fc6-dd50-08dd5c20e33b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:04:07.8722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBq0lXMpyuon4CKP41vmW79zekvUhSVLwWc6JVPV/rBsHcqIQ08sD7pWIYYLnp3O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7847

A shmem folio can be either in page cache or in swap cache, but not at the
same time. Namely, once it is in swap cache, folio->mapping should be NULL,
and the folio is no longer in a shmem mapping.

In __folio_migrate_mapping(), to determine the number of xarray entries
to update, folio_test_swapbacked() is used, but that conflates shmem in
page cache case and shmem in swap cache case. It leads to xarray
multi-index entry corruption, since it turns a sibling entry to a
normal entry during xas_store() (see [1] for a userspace reproduction).
Fix it by only using folio_test_swapcache() to determine whether xarray
is storing swap cache entries or not to choose the right number of xarray
entries to update.

[1] https://lore.kernel.org/linux-mm/Z8idPCkaJW1IChjT@casper.infradead.org/

Note:
In __split_huge_page(), folio_test_anon() && folio_test_swapcache() is used
to get swap_cache address space, but that ignores the shmem folio in swap
cache case. It could lead to NULL pointer dereferencing when a
in-swap-cache shmem folio is split at __xa_store(), since
!folio_test_anon() is true and folio->mapping is NULL. But fortunately,
its caller split_huge_page_to_list_to_order() bails out early with EBUSY
when folio->mapping is NULL. So no need to take care of it here.

Fixes: fc346d0a70a1 ("mm: migrate high-order folios in swap cache correctly")
Reported-by: Liu Shixin <liushixin2@huawei.com>
Closes: https://lore.kernel.org/all/28546fb4-5210-bf75-16d6-43e1f8646080@huawei.com/
Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: stable@vger.kernel.org
---
 mm/migrate.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index fb4afd31baf0..c0adea67cd62 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -518,15 +518,13 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	if (folio_test_anon(folio) && folio_test_large(folio))
 		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 	folio_ref_add(newfolio, nr); /* add cache reference */
-	if (folio_test_swapbacked(folio)) {
+	if (folio_test_swapbacked(folio))
 		__folio_set_swapbacked(newfolio);
-		if (folio_test_swapcache(folio)) {
-			folio_set_swapcache(newfolio);
-			newfolio->private = folio_get_private(folio);
-		}
+	if (folio_test_swapcache(folio)) {
+		folio_set_swapcache(newfolio);
+		newfolio->private = folio_get_private(folio);
 		entries = nr;
 	} else {
-		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
 		entries = 1;
 	}
 
-- 
2.47.2


