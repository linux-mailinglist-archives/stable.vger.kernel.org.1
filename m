Return-Path: <stable+bounces-195405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB6FC7619B
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 7ED422BD46
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097663242C5;
	Thu, 20 Nov 2025 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GdnSlQ1G"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F03030FF03
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667485; cv=fail; b=X4SjVCA7wnX8XH0HdFXCORRm95fWOF1EGlX70ttSCicNOMaqz2y3YfdSHCgIS8TST/VOrqubdCIN3CKC2RqsOp2fx8QhTu+dDmX8BcxOeb54K8GNMFJKRWMt0jsQ6Lv3iyNxWFFFBs1wguKZQTKFm74a2btAJT6TPbrkjIZ3a98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667485; c=relaxed/simple;
	bh=dbzviyW4u1MgkTQFTIE9d98avfIQzAFoYqRezX9YfLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WYFfh5MZag0rIOoec69lw0kdzQjJE+NjQttHtzHb/WR7K3wQCkUyXUE1y0HyvkJ+k2pduXsPng/X8DLro8Mz4dpVh+4o5T++OW3nx7rvg6TS/NbnAjYMfMWDe58vJXsyAMZ0bFSeTuqUxXU9TSsgv4RBMK6Bz7/cdN8Xq5LNaWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GdnSlQ1G; arc=fail smtp.client-ip=52.101.62.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaZGX6KQa8edn3ejMP1Q+YMqhKofO5+Tr6SKF574jzrySuLWcHxm1P8gEkmCQ3KJ48isV+ezpUL513e7vmp2qqVg9oW2QhMF7hEpeXHIaKGQameSx2TW+2ovZlUqNTqbZp8DRbY7jtwk+IB0/LpyOtojABEpCQp4y9RhF22ANQue7wBjiAhMIqu2caZL46vo27wM66cxgyBF0oqxzrlPC/ws59aAnMtc+3ruB2nIr6AsspHFlnjI/FCnVIMXn+QCQZb+V0piqfgN/oVRJvIq5bQ0rffpoS6jagwBFzwSFBjOnEeckD40tE5/Y+Lkw7egLQnQXWqcWkNLd6w6GZBZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMgiNdv8h6IkxAKQpdIIqXTN+xEG43JiK4/5CD9l/BU=;
 b=jaldgibQzvEbVObFFRkJ6Q6/hod3lxAzv4tt/p6OuwZlt6PPbcyXXobYJ7ZElIXAgLzz37zxnacNgUzvEQtAd1CDzL9jsM5aOLFLQ/nsq9TNV0tNE7u0OoaDyYt0nOimQTnrRKASn1O+Mni2Vdghb9Xl+Qn/7E0ZtwrOA7tT9YsMq8EFT8mSyLdBKaV+jrui1Gxoj5iY8/2ZIrjLIKnfA7iyTe3oR9pabQQr8eJmHAgaaW2GwnA1a87VO3l9NNprKU/cWHob/kfJvntslxwSyCsstGPj+UB+3Aor8ZZyEl5MXV/DYk5m58TaAa1DfB7gedK42OEv0efnaVCpvokiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMgiNdv8h6IkxAKQpdIIqXTN+xEG43JiK4/5CD9l/BU=;
 b=GdnSlQ1GkfGXMaCkorhNIuJVsJkqGPfPxIZy87x+/C8eHn4qHIFBstbKRL7/PKbRwnvXb5xS33RN9vswW0YS2U3UQPky3auQc+Y+X1o037xc5mA0ZwYaXSjTJuO0eJl2V9iByMGrXiD6TZ/D+32y7yu0sWmwmvxoQZiSf3ZATxnMTmf0BvL7XgAmMtQGo3ybutobtdphhkZaqfOXzAjz6PbORkxfTt9khvqfXzxDnKBM4bD2QhCUOCJEoGJlEeMXER30tGB9dBSHN94wX0bRb1/oCYzZBhYLBT8W0MesMtqY5+E8C5vkp6/VUSlLoUGxO79MRk0tEj3NJ2k0K21Mzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB6969.namprd12.prod.outlook.com (2603:10b6:806:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 20 Nov
 2025 19:37:57 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 19:37:57 +0000
From: Zi Yan <ziy@nvidia.com>
To: stable@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>,
	syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Jane Chu <jane.chu@oracle.com>,
	Lance Yang <lance.yang@linux.dev>,
	Liam Howlett <liam.howlett@oracle.com>,
	Mariano Pache <npache@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/huge_memory: do not change split_huge_page*() target order silently
Date: Thu, 20 Nov 2025 14:37:54 -0500
Message-ID: <20251120193754.1337801-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112015-revolving-professed-8d2d@gregkh>
References: <2025112015-revolving-professed-8d2d@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0243.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::8) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c97a78-79be-426c-2e9a-08de286c4e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mCfFYAQQcd4Ela/V8se48tFMej+o0cUKAAx2wHyT9Z1izs1vUkQPu7z6AGTa?=
 =?us-ascii?Q?VznMbLFoR/x4qgu3IuRLhXjsMX76UjmqiSxMymhsXkTaEK4yqUhQFzwZtMeg?=
 =?us-ascii?Q?B6QSDmRgdBmyqwG0lCrVrxm6HJvlVVdzO+2Q/0uWi61mdTdzgK1pDKayPOZ4?=
 =?us-ascii?Q?HwMtKzrIPM455CUb9zYLDGtiNAZWtaZWGHEHcLpAzFNTUFpjLqovgV9PDunk?=
 =?us-ascii?Q?meul3VubYUUru7YpNlAGRWns7iQ1jFT3cPT2tYkBM8e7UQw47HYq3DyohdUb?=
 =?us-ascii?Q?E63GoGL0iSeFALO03zBk/GiBEqqMxRgaefgv8OPTKLsRrfdVqNSqh6LzthGs?=
 =?us-ascii?Q?ra7UOYSVZgyUmbUlTVW9TCY9AFuitwdvriqo6yJ0uZjl4BwTbNl/iSNbyZMY?=
 =?us-ascii?Q?VHTnPYYx4SAmSHTWBUEBlKCqEkasvqApOHJ4rNO2TsYAxVOhN+qJ+jRJutl+?=
 =?us-ascii?Q?JHY4LIW2E4SmBD89Hm6RyvZuC0fDIYoQQCyUhtgOSUwuX9LPUo6S5XHkTEF3?=
 =?us-ascii?Q?kgkGTZ241LYw2QAyacqrZnLM0Fve2LaTXekdH1EQWPubAQf28WR28WUXeT3g?=
 =?us-ascii?Q?x95QIPxz89JbruT44oHgjwE+3svARfN2gAmZ5PuWDEeJO4a4VZdFNZMI0QU1?=
 =?us-ascii?Q?KN4AtDm+0YcFuXRffhhFRqkRqa/U3bp5wl3kI/BwQX8BrYnd5aEuTPkwnEQs?=
 =?us-ascii?Q?3iBDg9ayPPooGnvqae9JaZsfdm+AC08rBBcgvbtEig7bTa0If2yObwpzQxwq?=
 =?us-ascii?Q?On663MxixAMghBBv9DoAiioN0fptxqC35RonzoES4N0q8zC+gpGsbnf7CazT?=
 =?us-ascii?Q?Izzbw+NfzGQALMUMCpcwnnbIz+PjIrOuLVGBxnl3XiOzASoUKd4FKk0jZzz9?=
 =?us-ascii?Q?5CKJlVDeGu7fKRjqhHYm/zJJ+ntXX9/yUQKCbTQDkQGOv5yWMJk9TepvqA7J?=
 =?us-ascii?Q?VJo3g4jzgPr6O0+MEDhfaaEw5xPlzrgqVGRQ0vmrqpINYA+9LuxGSwJJQ3HX?=
 =?us-ascii?Q?WLMc79cPGRDO3ImPWef88gsr6wPfqXKfv7GzpEWs2M01N9wFm+Kqpbhca/fM?=
 =?us-ascii?Q?IBIeVlNgeCaF1I6ZmYg18OSQPC0gcJCea9TVosbNOls+vWVjjDAgyko3wbk/?=
 =?us-ascii?Q?G3WbEZsGAWGxVUVfbPaSnYpywstk+tHpsGaoVqbNoHUPWPXQQq8/XJTZ5Lrw?=
 =?us-ascii?Q?tTIGYK1oNhci7jolvA6Dj1UV/0yc99uI+1XUzxoL81ydd/0LdNndbDds/I6a?=
 =?us-ascii?Q?8KxwA8ELMAESiBi/UBKnTV1AX5MUp9uAzM0yTwoKeKgtpiHAq9931jCMF69F?=
 =?us-ascii?Q?RsWEjvqgtSP7b5JyhQ2FZnx8XR2dGkuJJWVF30lKqB07ZGyJ05dmkcaLrHwb?=
 =?us-ascii?Q?6ogm3CgFZ0Q5aecKu372zoHYxRzFlMcDJPaF6UogULih8mi9MqqFghRL2qVg?=
 =?us-ascii?Q?Y0KFfU7iCdN/wQiuAdHvAm+489Y6KwSJOzs2Er16aZl9BLCkoCSoIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dgONvGpeOqfIabu2BDRo9sYbE5dCNqmfZ3nELrHxCanStCFYzByjHo4QONPv?=
 =?us-ascii?Q?yuIwq3nFk3kil5qB2yo287yyv0P8URmrApSmL2AbxiQaDIM1yzUcwONPafQ+?=
 =?us-ascii?Q?HMliorVVoLQh/4fabnFJVSHMAf2UIl3RkDcoNHWpYOB2+8Ni/a9UNHccl4T/?=
 =?us-ascii?Q?HdO8j6lZZyymQV3aK6A+Cw5R86Q1+qj8+lk+VSirmLvcE6XiVidCG0HjRFPI?=
 =?us-ascii?Q?OhSnoPLMQSWyBeQkzYjGg6dSqIf6/DB1kEuc/0bd8u2d4xlnGDHsDhkSOjZJ?=
 =?us-ascii?Q?OwnlipRgzjn+AS9ovT3hCrUhV6KW+CKUS6Qr3c8/uwHuWs7mDGRL4nFjCUWR?=
 =?us-ascii?Q?NhvHbUKk/rFd/axZlx5Xt+YjGYk49Hns5GptWgmbZV6duf2fVm0Wbbj9SuAF?=
 =?us-ascii?Q?Rsb8anilYT0q62P3pb1TDzjs5zkvyYcVaRrYBMIcDFgtWuI4iTKyATPdp8WM?=
 =?us-ascii?Q?kqzYB3etuISOXPPfY7hlSBRw9qpnJuRwe6kzY5NwVXSdxt7SUWSVGXfuqZkz?=
 =?us-ascii?Q?oPJp/dolpE9wN6qWMLyQDsPLYEBhZoyGOJ29CKe/pA68UWRIR35L7ejOcgYH?=
 =?us-ascii?Q?7040j7RjLuPXp1E3kVae5JIYmuRI4+eeMm6ApaaZ+WxshN8h4ENOV3rAx95T?=
 =?us-ascii?Q?pCW8jBSPS83AaiIWI23MvaZ4uz44Rd4t1qJ5Am/MebEzPlOIU8iuDaxfSEjv?=
 =?us-ascii?Q?E/CjI1tkzvOfB/O1YFf29R1dMeTXuROs6FKHIADqIQfh99gabcMD4ZDLnHAv?=
 =?us-ascii?Q?BA5KbYB+mnHdQ0mFa8mi5SunCq00O4KWS0EQL1lhFB8j6KzeLUhLaooaaBE7?=
 =?us-ascii?Q?kEeGQ4q+kIsoMH5AouiCx3fSDrH3D+Pw7Hu1l1q04Repwda8+hX3KJ/p2VHq?=
 =?us-ascii?Q?ym4eO9Bx6gYCIdMpzfdi7xrbeYMsJNKe4qPWc7XHSBfYOezOsunqsrIiJoiq?=
 =?us-ascii?Q?frGTiIdXR6MIaESBzcbQmde5XGEOhjpVOruktvxii0cFVP+ip7w1Bx9gl5I6?=
 =?us-ascii?Q?DwzFP0lzLpFUJmbL9Nn1EHk0DsQ3PmY0FsU2MxrbTwb/TjefSs9gqshaa34/?=
 =?us-ascii?Q?nB4aeiNCBFMgyHxVSXA3EZD+nLwLnm8BAMt8UxZ4TwHLgev8VvR9CWL6MT2b?=
 =?us-ascii?Q?5dHyje6VELb/9kXzAo5ehKHY/1E2QlnvrNrB4cNnVsST+mPzeZnz2s1v8I3B?=
 =?us-ascii?Q?mBhCWbA7UbRYqzAkoEuZZhRO8hjI9UfkorsekWCSZz8jQEib0pUE6K3dw1Ve?=
 =?us-ascii?Q?dTxMEEJSUsTUOPRPDryAUq0S9eCPAbu4ETLO9Euv4Vd7Z2eaWRtPSlOpMNnd?=
 =?us-ascii?Q?vuck94JhrmE+43Fx4+S+FEtp9S98+E9L0XsmsDO2nf0u+lHxoASSA5a8gZXb?=
 =?us-ascii?Q?A4JzaQJyu0+1/w7yEhdLa/5i+4NqPRsotdlEMy5nuRAHUaropn/aZ9zgh12k?=
 =?us-ascii?Q?R2kTrSkjM3pdMeAI9jGbM858nhd0kMJ8d5erhvsO+sePyHT8okKfnMms6m39?=
 =?us-ascii?Q?uFYN62DPaKeYopYuEmlmz+GoE8oU1BSsLJyJTEJzxjMD+SKVbMy0WvTauDE8?=
 =?us-ascii?Q?aq7Uq9Acd5HxZ3sLhW3OjSj37BBtSAA1BmdpSvLR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c97a78-79be-426c-2e9a-08de286c4e8e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 19:37:57.4197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfxlNVE+3FAW1wr61UBLy1NFkxmsNiv+qYRMlBGWPTSGtbss41EFoADQ/V2OL/8e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6969

Page cache folios from a file system that support large block size (LBS)
can have minimal folio order greater than 0, thus a high order folio might
not be able to be split down to order-0.  Commit e220917fa507 ("mm: split
a folio in minimum folio order chunks") bumps the target order of
split_huge_page*() to the minimum allowed order when splitting a LBS
folio.  This causes confusion for some split_huge_page*() callers like
memory failure handling code, since they expect after-split folios all
have order-0 when split succeeds but in reality get min_order_for_split()
order folios and give warnings.

Fix it by failing a split if the folio cannot be split to the target
order.

[The test poisons LBS folios, which cannot be split to order-0 folios, and
also tries to poison all memory.  The non split LBS folios take more
memory than the test anticipated, leading to OOM.  The patch fixed the
kernel warning and the test needs some change to avoid OOM.]

Link: https://lkml.kernel.org/r/20251017013630.139907-1-ziy@nvidia.com
Fixes: e220917fa507 ("mm: split a folio in minimum folio order chunks")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68d2c943.a70a0220.1b52b.02b3.GAE@google.com/
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Mariano Pache <npache@redhat.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 77008e1b2ef73249bceb078a321a3ff6bc087afb)
---
 include/linux/huge_mm.h | 21 +++++++--------------
 mm/huge_memory.c        |  7 +------
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index ef5b80e48599..f70b048596b5 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -353,20 +353,7 @@ int min_order_for_split(struct folio *folio);
 int split_folio_to_list(struct folio *folio, struct list_head *list);
 static inline int split_huge_page(struct page *page)
 {
-	struct folio *folio = page_folio(page);
-	int ret = min_order_for_split(folio);
-
-	if (ret < 0)
-		return ret;
-
-	/*
-	 * split_huge_page() locks the page before splitting and
-	 * expects the same page that has been split to be locked when
-	 * returned. split_folio(page_folio(page)) cannot be used here
-	 * because it converts the page to folio and passes the head
-	 * page to be split.
-	 */
-	return split_huge_page_to_list_to_order(page, NULL, ret);
+	return split_huge_page_to_list_to_order(page, NULL, 0);
 }
 void deferred_split_folio(struct folio *folio, bool partially_mapped);
 
@@ -538,6 +525,12 @@ static inline int split_huge_page(struct page *page)
 	return 0;
 }
 
+static inline int min_order_for_split(struct folio *folio)
+{
+	VM_WARN_ON_ONCE_FOLIO(1, folio);
+	return -EINVAL;
+}
+
 static inline int split_folio_to_list(struct folio *folio, struct list_head *list)
 {
 	return 0;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 92df29fc44fd..0bb0ce0c106b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3597,12 +3597,7 @@ int min_order_for_split(struct folio *folio)
 
 int split_folio_to_list(struct folio *folio, struct list_head *list)
 {
-	int ret = min_order_for_split(folio);
-
-	if (ret < 0)
-		return ret;
-
-	return split_huge_page_to_list_to_order(&folio->page, list, ret);
+	return split_huge_page_to_list_to_order(&folio->page, list, 0);
 }
 
 /*
-- 
2.51.0


