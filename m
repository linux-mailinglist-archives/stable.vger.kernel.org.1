Return-Path: <stable+bounces-120097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB11A4C67A
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D67D189A19B
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B6B22DFAF;
	Mon,  3 Mar 2025 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tRt+muLA"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4869A21ADB2;
	Mon,  3 Mar 2025 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018112; cv=fail; b=tPG1SXCRTFpMbz0yARbGG1Joq3W7R6Oz4Riwju4Z9yOaOCpnaD6/UyxAEbk1RcF42TZt8Fg1YTl0VDyUNV4PyLwvyyPUrHNDrRqRNJsxBN6b0ptq78DF3Ju+wteYgOLfZwBb5ACXjsjtjgdPjezUMq7LgcvYfMhbC2ni6Raqbts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018112; c=relaxed/simple;
	bh=TGygY1q3kDKT3zYxQuVu+vtp6xAMV2s8isHb6BQsNeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rEa1a5hzUZw5KgaIcF/00Jszq2eIn1kKdfa2ZsTttTO0srjxXh6BRtsFYlZxVEQ5Ii/fjPspVGCtdmEfOiqUx9Kn/1CT/XR+JJoiiG1LwH2x2QOAahG6Iy1Rj9xIMGVXAiyL1vT+2JRSaWFRtJ3S/D0637gT/OQBZbeBJnQSCHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tRt+muLA; arc=fail smtp.client-ip=40.107.102.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6dMV5brHeEpkcOCfkgozMVnZYDz/LOypz0ux5P33qu3hg/4e2Rm8P1cVNTQXaX8LQ84K3mlRxXiq7NLFlmxnGuQ4llAiLqTA09O9qBEsfiraks3pBiWBRka69CJGk5AQXN3D5Pj60ZJbFyPVQBlKC4fKMLfpnOhKl2Zd3BtbQTDL3lZmjU4nlcghl0GD/+9dgmgBTxfMPgGINxRuGhg5nNjONW8nDP85XeCs2ZjKeOxGLIO4pdQyMOapoouMoRo02DRBmVS1vMpx0JaVO9LUEb5KSob7wDbVdv6Dhv1TmCDsXhP8Xp8Yai/ZK8fTPgSh6jQml97DvXufMAgLwTcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gf2cLeXB5UpVcLxJi1EID+7OruIH338S5kiopVl/VKo=;
 b=sBdYF/9Yf0cFOSUXWkGz2BSxENDNbf164vUklVXGYzGaMsTa7/Mw1RhNc2QFT18JO6DGRNw9VEh+oCg6OhMwaXUiOgvbcRWG1bD4y3bpmm1JVlP7AmOy5O+yJJLWt0v/34F0oVclCxifJ4DnlLzyidZqjLruzDaVekR09WTqi4gJBe2z9PCcRzcvw+4HFauq2HVx8kFW44syW1X9rXjH5RW9fqSu7Ej4zYuzgQ+iHKTztMXT0kwhDxFeEdyipqRSw8pApQ5lpDaWfbR+nV1j/Dew97mmmXf15rQuIqqvRjvDxDofLEGsbjkEEOVLGvFImoAU5gDFWEfgwhTg1Fa2eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gf2cLeXB5UpVcLxJi1EID+7OruIH338S5kiopVl/VKo=;
 b=tRt+muLAaiRUXyNrBmBhHBttPttcTZhfISNnGFnAzpYz0TMuTHyWVNqgoLhU39G1xuOWMyPu3jDpJNcU+l+BKtEYGibqacBHcsuBtU1vNtwZKxYlqJXmn5i9fblv8y/Foi74dSjvo87xiXqap3SIL+Z2FbjhIXGt3M+OQkgXS4whxpXSpshQx3jiOCuWyi8y4NyYSui78s6dtQKuLjRzfwHYqcUU4ne8dzSX56zCJaaswcPPBwhVoBDXFzT3Q1A46IxJI4Ah23FpGu4C5H7lEJKtS3zgRXRsf6KR0J5XyS1LlSq9pjKGy4PH+8U/NWnJEwavC2tEZRkRaRXobs4vwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB8073.namprd12.prod.outlook.com (2603:10b6:610:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 16:08:26 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8466.016; Mon, 3 Mar 2025
 16:08:26 +0000
Date: Mon, 3 Mar 2025 11:08:24 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v1 2/2] mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq
Message-ID: <20250303160824.GA22541@joelnvbox>
References: <20250228121356.336871-1-urezki@gmail.com>
 <20250228121356.336871-2-urezki@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228121356.336871-2-urezki@gmail.com>
X-ClientProxiedBy: BN0PR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:408:141::31) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: 32638ec6-b30a-478a-ba94-08dd5a6da132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RfzDvRaQVebI1Dim3Xy0/PcKz758xcnPL/YmJGtSqKI3aIEEfsdD839fONn7?=
 =?us-ascii?Q?fLD2ZVkvdeSnHTd8mLVGSi4ARnivyDfhGpfHNjUK958wB/OXudjN0ewCDhL7?=
 =?us-ascii?Q?DsnBSvcndq6W8Sk4aELw+IhG6DwWR8tqhIUo2+Rrp4mRmjBkAJHRcqe+31Vy?=
 =?us-ascii?Q?sTMFqcHAFZ0X2MZoH6B2jYnNWjbln6a3D6fFV7yDZ/ve964m1FedJj0pfb43?=
 =?us-ascii?Q?ltC4mEvzEJE9+FDGvvH/wziVJEENBC2OHxM6S4ZO2ffllBGqdIKqLAbQCjUS?=
 =?us-ascii?Q?xnN5ib8NMrhGxJ9yJyPSgBl6rfxZVnYwA9B5990ykSyHc0hf8Nz+zQ3Ky8gs?=
 =?us-ascii?Q?Y0JKcVXObpx/W2cQGDm8l+t5+15qOzGMW5krSavJ42b8hcPUKgjVg0XHe4hE?=
 =?us-ascii?Q?Lj+jxjomPPdbqKRg/0paFTDH3S6r6HVqXMMElEgTqaWKwm6+c5CBG3rHpqVa?=
 =?us-ascii?Q?EJRipKrKmXrnUA191IT0owmLxBV7LZ1VvE9sxtBk4ikNl3M6tYq6FXOEFmCm?=
 =?us-ascii?Q?1rDknbophpCNZBCF4MWUMochFr94wXvKZa96mXF/FJ4MNncXV+lFtK835WPD?=
 =?us-ascii?Q?DFo6BP2VKHmrRrMFaH4W+qfWPA4mPWt66BFjMEXQAu+tELp3e7DDsVKwSzMu?=
 =?us-ascii?Q?hYxIB6afgfiaPtJ4GSqi6WXmtEIx9K/j6Km/E4lRXVmDIVP6wsWPeXlB1nV5?=
 =?us-ascii?Q?KIZTg7o60xRZFbOumUCoWYzB9MJtr5wtY03o/kD89He4kRcNX5lzjmO14r8W?=
 =?us-ascii?Q?K0Fi2dJh4RWUyhvrs3KbSHsJY0GQhHieyL/3ghzGPCNFU+fgad01Ot98UEqz?=
 =?us-ascii?Q?mwUVV8GqkDVcSx61lQ+HT4X8YRcAnKr/OJ2vXxdLgM3nSDlLFDxRq0x4z+y4?=
 =?us-ascii?Q?IzTQGWdW0SrjRaaHcUnzkKj484IkJTRc9mQt4fSDKEBLdleGC6Dy2K1A2bof?=
 =?us-ascii?Q?QnOzN6ouTBES1nvG15G5QP7GS3tzdlYs3hZLHIqdNvWnkcTHtnyREB5S/Uk6?=
 =?us-ascii?Q?Ub/ILwIdd1XLPrneCsF1XZUC8gnlXo6kKqczC2+66fW5JxPtTvmVZf0rKnFm?=
 =?us-ascii?Q?hb2Si9TMmxtZlfaUfXFo6P0nG0xxoKv4WHzO1AQf1suWt/BtAYxpAdSFXLVY?=
 =?us-ascii?Q?OfwgO+kNWN/eLVUT3d/9ZlPKEZ00Vdl10sZqD7XJYctfyytONeZMxVRz9D/2?=
 =?us-ascii?Q?YDe0htB3U+GW3VhsRMS4n8PM/CY16tu49MquosrbGsd4KCAc9/mYcU/dM872?=
 =?us-ascii?Q?MpqgmlQygTO6o4tO9LHsaKiQZ/K7J6d3aHspDPNxCqwP0tVH0Djnml9GKGK/?=
 =?us-ascii?Q?/I6fgAD9SZSwk23wQZnwMhCmvV8sz/hCd7M/ZSVaxa/I46SIaN6pf91MC/wc?=
 =?us-ascii?Q?+T0ZppG3sRSATfSdGluGr07c4BeO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ALpRRD8Bvt0PzdsfM4nOwbsPo9BH2Fbbdv91ssYVsahF79/m8GbvG3JOjimo?=
 =?us-ascii?Q?iwMWsNLA3WikvkIurMFA8/PCEmXZ2OastM1VhdIAzsQIbVKyQa5zhmYH09k4?=
 =?us-ascii?Q?SHRSKdqU2P/vdZK9CQAeOfC9VnVVUEihgx9QZvMNrj7Uh2gW64hWpYHnaV/S?=
 =?us-ascii?Q?LeCkz0rHPnmzLuUtTS96fD9vhlBs4ZyYbwbYrG6v8E4+TgRLE6Z6lAcP7Gjv?=
 =?us-ascii?Q?BkriAMd0950Ce+PIF6yvrZiKaPqCnT9N+LB8GCqGESwlDjG4HHsRCKs1oFY9?=
 =?us-ascii?Q?vah2hkjMkgzUBdLTYq9xUJyDD5F8dkPAESOlmDTi5luQXXN4RJmHZW/E1A+Z?=
 =?us-ascii?Q?X7doJJpr1pmNAu4HRTuwERIhnSCw4RDyaOQ9fjz7bk3Ybd8avexNGkRU73+M?=
 =?us-ascii?Q?7mtMDeejPvqC1UHC4emWKTDyPuxY84UPk4DU1nJ3m3DPgLmK7gCE/LrsxlyW?=
 =?us-ascii?Q?c+a7CE3JX+8ImpjE3rcQdqLTwLrhsZFfd1FN9Gbz58ilbfPB0tqImkfU8j4f?=
 =?us-ascii?Q?mh2zaxUR+GZrcWe22pwyN/9TVHsUrHWWr+4EG8b4sE3nQPPDOv7w/d7048e6?=
 =?us-ascii?Q?MaXlhF/etOrdw561gkDSUfybV5f2DMQlXtRx8gDzOCpXS0IULmVas4RfLJIJ?=
 =?us-ascii?Q?nuRZOmVdHR9TCFRfVMM6oeXC1yYBH6HjwtTQW86pu2s08RQ+O3KHZ3Qqi2yW?=
 =?us-ascii?Q?4jkd2v/c+zyTtNbTqFDdInVxr9VxUu8EkACGIfoSp6PEFUCrPE0U7maFSM7e?=
 =?us-ascii?Q?J/R34EttRlYaMYUdy7B6XLaMrj3SGFaNLfBvGM/STmiElgQqg0stvt9CfGm7?=
 =?us-ascii?Q?F+ZiyRztC3bcquISdgjt2cebvElmHlDQPnnuHhgnhcJIdHz1VUiXksNGbr2O?=
 =?us-ascii?Q?XFHqL7FlYo5KJjcPEGRp8le6lw6nYZMRZvW9Aomt8uxoBgNiMOdL/9EH/qcM?=
 =?us-ascii?Q?IHyCs7zia6gUsnDr31L1/fWsqk2QRHjeyJ6bJNMxqxK9k5Img/Og2FINjUAD?=
 =?us-ascii?Q?sKR0GrPqVhBAfAghbri2PNgm2Ujr/aJ2RJdRHqe4gSpBwakkREnPXrZwD8hr?=
 =?us-ascii?Q?g4hS3v3Vuk1sVfIixdCJtf5ISLaSgYo7iCwAKgvUbbmv6GVATORAd7ijZ4zk?=
 =?us-ascii?Q?NZUiDJUGcJo4mjEJnBfv8gTn8WseOHkyqPrAv74MwYJqfPBGFel+DAYQFJCk?=
 =?us-ascii?Q?mi1oiwQKXJTMjiHKcHc2kEkLEpJk81pLXNCP0v1Phq7nOsBSxJXpfrJ/0lOQ?=
 =?us-ascii?Q?rgFy2uDobR6bdGrjBCpiK30jt8vcZJyTrwZffZgfPwJXc6/4xryra+7Zb/3B?=
 =?us-ascii?Q?WCfP3rXL9OnAikjGct2194RapZowAw/1MV8fqAsep/ZJ/EQxDrxTJT7rPhRU?=
 =?us-ascii?Q?x1mEZh+8ZeOwR4MZ/N2Q6n2R79FteBLmbQulUWhZTMgiV8ZcRktTGJ37UqTH?=
 =?us-ascii?Q?LzPjv7EXzBDNOtBW4R0D2vOpAHQPDdsZPa9JpD1FEcJ+DmjvQr6LJ9Fbb9vt?=
 =?us-ascii?Q?hL0mRl2DxTcgr4z5C4ryRHL+4fzQu5heeNVh4AqE8aVFoA2hqmhm/zP1A9W3?=
 =?us-ascii?Q?xl9BnwaKepSm9WXkhTuRRevdkN7khRc86Uvycx96?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32638ec6-b30a-478a-ba94-08dd5a6da132
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 16:08:26.0126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuzVzG5too6w7z2XMuFMlNQXBQylk51Tg2WHKHqr9RXj4A9Gdnw6Whlbg+ZX0j3vQv86g3BRiu33aDWwnh9hwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8073

On Fri, Feb 28, 2025 at 01:13:56PM +0100, Uladzislau Rezki (Sony) wrote:
> Currently kvfree_rcu() APIs use a system workqueue which is
> "system_unbound_wq" to driver RCU machinery to reclaim a memory.
> 
> Recently, it has been noted that the following kernel warning can
> be observed:
> 
> <snip>
> workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_scan_work is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
>   WARNING: CPU: 21 PID: 330 at kernel/workqueue.c:3719 check_flush_dependency+0x112/0x120
>   Modules linked in: intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) ...
>   CPU: 21 UID: 0 PID: 330 Comm: kworker/u144:6 Tainted: G            E      6.13.2-0_g925d379822da #1
>   Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive MP, BIOS YMM20 02/01/2023
>   Workqueue: nvme-wq nvme_scan_work
>   RIP: 0010:check_flush_dependency+0x112/0x120
>   Code: 05 9a 40 14 02 01 48 81 c6 c0 00 00 00 48 8b 50 18 48 81 c7 c0 00 00 00 48 89 f9 48 ...
>   RSP: 0018:ffffc90000df7bd8 EFLAGS: 00010082
>   RAX: 000000000000006a RBX: ffffffff81622390 RCX: 0000000000000027
>   RDX: 00000000fffeffff RSI: 000000000057ffa8 RDI: ffff88907f960c88
>   RBP: 0000000000000000 R08: ffffffff83068e50 R09: 000000000002fffd
>   R10: 0000000000000004 R11: 0000000000000000 R12: ffff8881001a4400
>   R13: 0000000000000000 R14: ffff88907f420fb8 R15: 0000000000000000
>   FS:  0000000000000000(0000) GS:ffff88907f940000(0000) knlGS:0000000000000000
>   CR2: 00007f60c3001000 CR3: 000000107d010005 CR4: 00000000007726f0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    ? __warn+0xa4/0x140
>    ? check_flush_dependency+0x112/0x120
>    ? report_bug+0xe1/0x140
>    ? check_flush_dependency+0x112/0x120
>    ? handle_bug+0x5e/0x90
>    ? exc_invalid_op+0x16/0x40
>    ? asm_exc_invalid_op+0x16/0x20
>    ? timer_recalc_next_expiry+0x190/0x190
>    ? check_flush_dependency+0x112/0x120
>    ? check_flush_dependency+0x112/0x120
>    __flush_work.llvm.1643880146586177030+0x174/0x2c0
>    flush_rcu_work+0x28/0x30
>    kvfree_rcu_barrier+0x12f/0x160
>    kmem_cache_destroy+0x18/0x120
>    bioset_exit+0x10c/0x150
>    disk_release.llvm.6740012984264378178+0x61/0xd0
>    device_release+0x4f/0x90
>    kobject_put+0x95/0x180
>    nvme_put_ns+0x23/0xc0
>    nvme_remove_invalid_namespaces+0xb3/0xd0
>    nvme_scan_work+0x342/0x490
>    process_scheduled_works+0x1a2/0x370
>    worker_thread+0x2ff/0x390
>    ? pwq_release_workfn+0x1e0/0x1e0
>    kthread+0xb1/0xe0
>    ? __kthread_parkme+0x70/0x70
>    ret_from_fork+0x30/0x40
>    ? __kthread_parkme+0x70/0x70
>    ret_from_fork_asm+0x11/0x20
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
> <snip>
> 
> To address this switch to use of independent WQ_MEM_RECLAIM
> workqueue, so the rules are not violated from workqueue framework
> point of view.
> 
> Apart of that, since kvfree_rcu() does reclaim memory it is worth
> to go with WQ_MEM_RECLAIM type of wq because it is designed for
> this purpose.
> 
> Cc: <stable@vger.kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Keith Busch <kbusch@kernel.org>
> Closes: https://www.spinics.net/lists/kernel/msg5563270.html
> Fixes: 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> Reported-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

BTW, there is a path in RCU-tasks that involves queuing work on system_wq
which is !WQ_RECLAIM. While I don't anticipate an issue such as the one fixed
by this patch, I am wondering if we should move these to their own WQ_RECLAIM
queues for added robustness since otherwise that will result in CB invocation
(And thus memory freeing delays). Paul?

kernel/rcu/tasks.h:       queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
kernel/rcu/tasks.h:       queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);

For this patch:
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

 - Joel


> ---
>  mm/slab_common.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 4030907b6b7d..4c9f0a87f733 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1304,6 +1304,8 @@ module_param(rcu_min_cached_objs, int, 0444);
>  static int rcu_delay_page_cache_fill_msec = 5000;
>  module_param(rcu_delay_page_cache_fill_msec, int, 0444);
>  
> +static struct workqueue_struct *rcu_reclaim_wq;
> +
>  /* Maximum number of jiffies to wait before draining a batch. */
>  #define KFREE_DRAIN_JIFFIES (5 * HZ)
>  #define KFREE_N_BATCHES 2
> @@ -1632,10 +1634,10 @@ __schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
>  	if (delayed_work_pending(&krcp->monitor_work)) {
>  		delay_left = krcp->monitor_work.timer.expires - jiffies;
>  		if (delay < delay_left)
> -			mod_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
> +			mod_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
>  		return;
>  	}
> -	queue_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
> +	queue_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
>  }
>  
>  static void
> @@ -1733,7 +1735,7 @@ kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
>  			// "free channels", the batch can handle. Break
>  			// the loop since it is done with this CPU thus
>  			// queuing an RCU work is _always_ success here.
> -			queued = queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
> +			queued = queue_rcu_work(rcu_reclaim_wq, &krwp->rcu_work);
>  			WARN_ON_ONCE(!queued);
>  			break;
>  		}
> @@ -1883,7 +1885,7 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
>  			!atomic_xchg(&krcp->work_in_progress, 1)) {
>  		if (atomic_read(&krcp->backoff_page_cache_fill)) {
> -			queue_delayed_work(system_unbound_wq,
> +			queue_delayed_work(rcu_reclaim_wq,
>  				&krcp->page_cache_work,
>  					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
>  		} else {
> @@ -2120,6 +2122,10 @@ void __init kvfree_rcu_init(void)
>  	int i, j;
>  	struct shrinker *kfree_rcu_shrinker;
>  
> +	rcu_reclaim_wq = alloc_workqueue("kvfree_rcu_reclaim",
> +			WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
> +	WARN_ON(!rcu_reclaim_wq);
> +
>  	/* Clamp it to [0:100] seconds interval. */
>  	if (rcu_delay_page_cache_fill_msec < 0 ||
>  		rcu_delay_page_cache_fill_msec > 100 * MSEC_PER_SEC) {
> -- 
> 2.39.5
> 

