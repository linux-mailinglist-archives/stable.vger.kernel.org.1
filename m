Return-Path: <stable+bounces-120214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D39A4D6FB
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 09:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0663ACFDD
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 08:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456711FC7C2;
	Tue,  4 Mar 2025 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c7psLGID"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C131FC108;
	Tue,  4 Mar 2025 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078345; cv=fail; b=GdWU9zFtCvSf61cQVzkjaYeJEGQ/YhqOMIwBxK9uc4FBQ5AYrbeDkbY3VCWbxsCr59fUWcxP3V4KD2V4CibtV+4UczeLCmT1GC/mEpFr3qkzMAoJR1EwyZLUp28oEUq4bWo4NkpEAoRlDg9H+MQLJAV3lUbu9seeCOG2b+TZqPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078345; c=relaxed/simple;
	bh=s9KIC7l1gCCgBiLQK1pfYYc8LTmuAfgxPabcQg/EB90=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rS8Myej+XLJGCXxTFvsuJNUiHsXW24DzZdtxARgKiQDtTuHDvoR3pT5jRZ6lMRkn1Ndgbjqmq1J61b+ESftrjax0xUQ1j/NwFXuIdUWOG3XOTgs16vHuAw4P4Omc4Zs6HY8h9MgTngJ0nQXUtJkbv5jgYGW0QJiHZI3qsesThJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c7psLGID; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVIxVkvvApEbBTANsiaBge51mhP0mLWhqDijt9W1R2Y4o++JXYQjdgww+tzZRHpukUCd26b8wRvGcVC9cF5N1Lk+otodtIpm/38cYYAD1+52vKPYPYtFV4s0x/wY843vYGsd/g/Ph4BXAg06mAgppxyibsZCpTunB4faX3w1UNfS4wYbQrgPptSCHzfIshELDVwfl8bEbmKYgF8ELO6pCgwp9cCpHMUSYhmWGPJIgb9zwglts9raRns3QW4sxb7m0nvJvZkx6C+FjMG1qe4Yln1MatnEl+oZ1yOcmPygT5jPIzOgcfmd43cFBx/4rNROe9NooIuIDJmh4HJKrw7ErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAe6L4zOkZIjune8IJ9KuwFvdUSyMTWrPfq2G5pA5WA=;
 b=mriJ2SCH95YWx5Oqjh26DJnlc5HaI0OXYSeGR6UQs7qbRCV2BfrNlbzYTT4KaS8lmAcMcfBn7QACt9l2W0Gt0kL8+qOOgNxz5yvqzplZECiNd/eEjBgaoLc6OMT32q+wLI5b6S3a17mmtCuTWi9aWKUK7fk3f1zX9PHWumXoB4r9jnSqQ2iUjsqNkCXNNjQMcuN7XCd9AoQmfW9tgIn4lyrCIg7Nlozd1ZRhTbe/gc24f5eJgKfzWVT4J0X1pa6LavB5eieUhLDtJH576rKXOCXpQXkpTVbhHkeCx9QnpmZvod77ZmBvV3aMVDm3BaFRMZXZNHwhShVc5zcAntq12g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAe6L4zOkZIjune8IJ9KuwFvdUSyMTWrPfq2G5pA5WA=;
 b=c7psLGID46h5D7Ad5njuBLy/wJO0KZCvz4FD4iwpQwjqWjVfjFlkMDTFalLlpBuW93A+koXJztej+Lv9E9nPhCKiTWMMQavv5PnVGPmIop4wmUlfb0HurFnXDh6sKvUvocwy0mHDM5rL3xGvqG0rZplMp8dNRRMVFo8spUDMu7nIvPjyCR/nsd+QgB+navGhd3l/qxf6XMSmHshnfDAn7QJMd5EM8loBbReop8pozz9grro8zmWw7vSU8qZ4JDTkMiCdV3L/jz87fyDNj9qv9pKiXvZGWLqP6+caKvb4NU7ZEbdgXgxtbjWdHJoOAwtTFty/Lv/67bUa+FcL4Z56eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 08:52:20 +0000
Received: from PH7PR12MB5806.namprd12.prod.outlook.com
 ([fe80::8c4f:2ac9:74da:dca6]) by PH7PR12MB5806.namprd12.prod.outlook.com
 ([fe80::8c4f:2ac9:74da:dca6%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 08:52:20 +0000
From: Piotr Jaroszynski <pjaroszynski@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Cc: Piotr Jaroszynski <pjaroszynski@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Alistair Popple <apopple@nvidia.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	SeongJae Park <sj@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	iommu@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] [arm64/tlb] Fix mmu notifiers for range-based invalidates
Date: Tue,  4 Mar 2025 00:51:27 -0800
Message-Id: <20250304085127.2238030-1-pjaroszynski@nvidia.com>
X-Mailer: git-send-email 2.22.1.7.gac84d6e93c.dirty
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:217::11) To PH7PR12MB5806.namprd12.prod.outlook.com
 (2603:10b6:510:1d2::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5806:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: b5435643-a550-4bf6-1657-08dd5af9dfd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lj3621k4GI98mexXGF3neFexjM7brjK3oArDWOtqSzJIbNW4CJAlQjFhG0js?=
 =?us-ascii?Q?oI4nH5ZrDWidl21yys50mzon4qgXeFgnOTMkX7mRKO9zuZXlcQRFz3CZLTIW?=
 =?us-ascii?Q?ORXctWpbhPqncF8UdW+Xe6xctQVYupvjJvqXj3vV8MLEY7i4B23qefh+94wQ?=
 =?us-ascii?Q?Yn+F+s78yjMZdbOgCiyTS2ZS9jurBRUBQuRob9YesMhEbhjNWB7Nxc8SArom?=
 =?us-ascii?Q?jTkKa37m1DOB8HxYfAqvn/PSYIe0apf/9+HmUHkInV8eNhkncxLSbVqVYHJr?=
 =?us-ascii?Q?m/zdLb3vfp6/umUXMHZebjkn9z3EgZpVryROppPM/PqFyoJxgKLaKTHC9HXd?=
 =?us-ascii?Q?2m2xH7doCkaguJNhZuVkzHKIoWvTKJUmDtm6OV6v24T7k1xQHoxOLaRAL44p?=
 =?us-ascii?Q?558T5RQAfYKH5FZq3Eu6J4Olfg4+ZN6CINw6PwDCbVbuAIVeKSiKIiVSzZpn?=
 =?us-ascii?Q?M0Zv9TY3C06A2tuECXTb//xd+yAyZcZF2Ir0LGr2FBzVXCEVHM5ZOuvz257I?=
 =?us-ascii?Q?rO/dxU61inyzfCVNxs9lpGer+Bxn2VcMJjfEoRruYmhY91iv7IdSIWZuelX6?=
 =?us-ascii?Q?0/UJuWJsafwgfGEzETFjC+feqX+r2EdkE9u/DwowsYYwt+KS1hKnyDDTriG0?=
 =?us-ascii?Q?xlXaPZ3r7lrBcylfyMuKE+w+CH6aKetNjspAfbXKNwTHEsVsTkJr8DuBnW+O?=
 =?us-ascii?Q?iQ95ZONfpRoOcUieK1EM/b8zgs7mJJNLfTemrdiE6xQVcqahApqTaXoCMrG6?=
 =?us-ascii?Q?ChMnipyP1bq2PPUNm0s4zPXbY+H4Q+ge4CeSZYXPX8F7FEhHUPAA20ItB4hE?=
 =?us-ascii?Q?4nqsXe5y/7b2X/jLFvQFsTT4uK/8PzK22/DBE/wXabiBDhJn0aHEH4Hhw1in?=
 =?us-ascii?Q?kIghbZ/E4kRsKH8wZgg8vSGPMqehMFQOhHiqc6MU//C/OgudFLiQr5Ep8Wyr?=
 =?us-ascii?Q?Fyl7Qa4Z+IEQ5ItHQJlu5jxx8ApJ2VLEui3timk8lT0x6HeCnnwbzY5u3ADh?=
 =?us-ascii?Q?YT8hBsAo+jv+2K5i7E2UEIHaU1cENIrODaw8pLoXdA1FwL+t2/Afi0BTtb+n?=
 =?us-ascii?Q?b7G8OR1stdhAIIkiQ5nIjJTpjAMnbnPgRqEEmU+C1dT3VYqM2X1puObIXhqS?=
 =?us-ascii?Q?rlRJBO26zhSncUgoO5Eyms2pZTYjPGHo5YWEZSjs/yOqx6w/ZGUgBCpeg+bO?=
 =?us-ascii?Q?E4YRJnjMvajcMUQqSWXSb9Z0CeWUk1rKb/svNcshB4TngHxReNwdHsS4s6dX?=
 =?us-ascii?Q?G6ztvOOXPVoxx0rpEoAv22i5M1rauz2M4+6HKEZkH6MIc6+bQPwMgq0CMQb0?=
 =?us-ascii?Q?ffGqI3FTeWExlzkDVydLFChc4fPQNo9RLw7FHYKgjVCFdnQJXtJEzON5PykS?=
 =?us-ascii?Q?c+FQExOKvb1hUnm2fvMWgS/O3ddp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5806.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Pwpj2Y8pIgLVMwCtB3SLafijtTZqVaWTllOi7S3CV62vpHSl9WhK191KOKq?=
 =?us-ascii?Q?jcn+SWdRpVnBG/fDGyV438Ws/2NYloTsJdTmQ7x0D1YRcaDrv+CtU/3NfFtl?=
 =?us-ascii?Q?TtvB+VJrwd7pIGK7YdKW0HRhxkpDddnffaQOb6EkUXbNt3+BkCBlalMoezBG?=
 =?us-ascii?Q?0geATPHSdtTD/vtNgsOqrpA0CRgi03jjq5Qo35NY91f8Wkun8unCSoNEmLzc?=
 =?us-ascii?Q?8ATVqRwT/n9d72ylj53bPHBUK+pXJs0J44WMfmKF+DkDYIbj5RmymU08UbK+?=
 =?us-ascii?Q?3HjohQiJ5QwN5QgXGDJXpmuquIMH/J27k4KQfEB0uj0Bi7s+pf5Bl6ozQYWc?=
 =?us-ascii?Q?dRZdp4+tFUgcb4hOZqHoHCa8OvNjBq3QPdMiZwnyzyEwiEsXnOkClUZ71CTT?=
 =?us-ascii?Q?jBIRM6I+POy7SiozyrDwsCKwmS17wA4oVTPHIEs6YDF7VnE/6DMfm9SHwGBM?=
 =?us-ascii?Q?P35qAxVwqtfsinfnUKCdyLDMkoQPNSVZYM/VJ0bFAgXiByD0qjKN0kKNtXR0?=
 =?us-ascii?Q?mNNLdZ3M7gDwQqizO846rpVOuzH2xZtRCZZrLljYhDKa3ylHxI23Hh1ZRYN5?=
 =?us-ascii?Q?ZYowCgKAHyu4veMSncIcRj1oHxdSAdWvP2JhExgHqW0VE/GHEpLKVwjulorv?=
 =?us-ascii?Q?sjN5HvxWAMKAne6cCIi//I9yW5IstsdM0a6s3NndUfwrnyz2PZMdPmTwvimA?=
 =?us-ascii?Q?WBebgAa8hJYVPrGSG2aEuwnq265yj/sXue84qGdXuFus3eTOyJ41GO7qZoBZ?=
 =?us-ascii?Q?9NoMH7CAca8V9b93CBpnBPHRcp2P39qBMVOF2YLJqGE2HGoaBtpLrP8Sx1Ix?=
 =?us-ascii?Q?FLpZ50rnBFKSSYxdey3FRmM8uk6zcR70uXiHx0dULo01DsVyctW+jwStjX1D?=
 =?us-ascii?Q?sSEO1Z/KTutB9t/s81Ov+S374nfjLF+H48eDe5jLV7timAZTfgGwn85EoMju?=
 =?us-ascii?Q?REMN5XAvXvniSbZQw0w21yxVUmuIkmL25qh6cEvZWdCPXkMjYPx7vnald6dz?=
 =?us-ascii?Q?JJ/0Geim58BwXqRlVKTlsgnQ7IDeDJhr4nKw1/rz7s+Et8IPgsCp/ybgYJfD?=
 =?us-ascii?Q?XbzcMUzRDxc3TJZV7OPGtPJnwvM23oUpm8CF52cz+CJCSjN0vOdLAIAcX0s9?=
 =?us-ascii?Q?s87zqS05NeLFowqF90mAum4UUZnCy0IN9KZEMF1vM2R2DFyi3ZwiofDpimOn?=
 =?us-ascii?Q?iImvenCObRdB8ONuzCUnGkI0GwBiCyq6BmAqOZARfTJL+O1mIeMu1e9U1k6B?=
 =?us-ascii?Q?4fjuRH3gctVl1+m6WUz0a7qeRwGFWpVL6h2J4a11l33tTef/xcHCZKzR0iOR?=
 =?us-ascii?Q?tPBL0JLCuEr0AttMoc4fvcuGtAxA5ZI0e20At0Xepo0xa7UDGhngwr8wVVwz?=
 =?us-ascii?Q?c4x3zN0g6g2O5Cz/zm2G4A0iQwd9zUEhDru6hIfC17PgkaWl8UUR88OEqo9Q?=
 =?us-ascii?Q?SU+o46LkjI5hanwTlXwgRuKaGrl7Jc/5dWxRG+Qx3NMUzlarv/7CkZxiuQTh?=
 =?us-ascii?Q?4OBM8g9Sf6nRz5DQKk/hKxn0N5D/Oc+bkz0XpIyTVa55I/JcDifCMYcr/ApE?=
 =?us-ascii?Q?EGAykZ1xrFOfQL5rXoPhBk6pWgj40iVYFS78kJBIyVGMlqOWuckzIfmqAAmi?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5435643-a550-4bf6-1657-08dd5af9dfd1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5806.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 08:52:20.6235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0iF9Pks1s3DYFxh+YpzVF/MD8+aQvjnpTkeUsoSzb1uuUnZ3UsbFb2yAbolWelCPhU/bFhevkcoV8ANA8EuiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084

Update the __flush_tlb_range_op macro not to modify its parameters as
these are unexepcted semantics. In practice, this fixes the call to
mmu_notifier_arch_invalidate_secondary_tlbs() in
__flush_tlb_range_nosync() to use the correct range instead of an empty
range with start=end. The empty range was (un)lucky as it results in
taking the invalidate-all path that doesn't cause correctness issues,
but can certainly result in suboptimal perf.

This has been broken since commit 6bbd42e2df8f ("mmu_notifiers: call
invalidate_range() when invalidating TLBs") when the call to the
notifiers was added to __flush_tlb_range(). It predates the addition of
the __flush_tlb_range_op() macro from commit 360839027a6e ("arm64: tlb:
Refactor the core flush algorithm of __flush_tlb_range") that made the
bug hard to spot.

Fixes: 6bbd42e2df8f ("mmu_notifiers: call invalidate_range() when invalidating TLBs")

Signed-off-by: Piotr Jaroszynski <pjaroszynski@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Raghavendra Rao Ananta <rananta@google.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux.dev
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/tlbflush.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index bc94e036a26b..8104aee4f9a0 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -396,33 +396,35 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 #define __flush_tlb_range_op(op, start, pages, stride,			\
 				asid, tlb_level, tlbi_user, lpa2)	\
 do {									\
+	typeof(start) __flush_start = start;				\
+	typeof(pages) __flush_pages = pages;				\
 	int num = 0;							\
 	int scale = 3;							\
 	int shift = lpa2 ? 16 : PAGE_SHIFT;				\
 	unsigned long addr;						\
 									\
-	while (pages > 0) {						\
+	while (__flush_pages > 0) {					\
 		if (!system_supports_tlb_range() ||			\
-		    pages == 1 ||					\
-		    (lpa2 && start != ALIGN(start, SZ_64K))) {		\
-			addr = __TLBI_VADDR(start, asid);		\
+		    __flush_pages == 1 ||				\
+		    (lpa2 && __flush_start != ALIGN(__flush_start, SZ_64K))) {	\
+			addr = __TLBI_VADDR(__flush_start, asid);	\
 			__tlbi_level(op, addr, tlb_level);		\
 			if (tlbi_user)					\
 				__tlbi_user_level(op, addr, tlb_level);	\
-			start += stride;				\
-			pages -= stride >> PAGE_SHIFT;			\
+			__flush_start += stride;			\
+			__flush_pages -= stride >> PAGE_SHIFT;		\
 			continue;					\
 		}							\
 									\
-		num = __TLBI_RANGE_NUM(pages, scale);			\
+		num = __TLBI_RANGE_NUM(__flush_pages, scale);		\
 		if (num >= 0) {						\
-			addr = __TLBI_VADDR_RANGE(start >> shift, asid, \
+			addr = __TLBI_VADDR_RANGE(__flush_start >> shift, asid, \
 						scale, num, tlb_level);	\
 			__tlbi(r##op, addr);				\
 			if (tlbi_user)					\
 				__tlbi_user(r##op, addr);		\
-			start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
-			pages -= __TLBI_RANGE_PAGES(num, scale);	\
+			__flush_start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
+			__flush_pages -= __TLBI_RANGE_PAGES(num, scale);\
 		}							\
 		scale--;						\
 	}								\

base-commit: 99fa936e8e4f117d62f229003c9799686f74cebc
-- 
2.22.1.7.gac84d6e93c.dirty


