Return-Path: <stable+bounces-195376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD29C75D96
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD15F363E3E
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176F621D3CC;
	Thu, 20 Nov 2025 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ht9qldiI"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010019.outbound.protection.outlook.com [52.101.193.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0213C36D4F2
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661323; cv=fail; b=Omh/WUxXkMf2zhHsovMi9Se0m8/mo77fWOewWBRaR8bCbeG1q2CsgjIU6M11AcyVjR0Z3nMQi87rsdZ6WCHfRd+Q46wsdcjNpgDWEQcJFg/bD+uQ/37UdSihpit/BLy6k1cr4spXOrxh2Tiznrwu96IuEIBseI4UmZmhiiIjSbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661323; c=relaxed/simple;
	bh=hPeQVixFlcG9iHElYfK/5QtSFdmdeZHOawSkkr3w/OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aiiWh9QGsBH9Jajm2zWiR3WXB+tL1GvlH1TUh+BcR2SmntUp3BIw1TGb6qP7CyZTW/3yiwGMdrCjfDEMUsObICNt+apQo5nq3pdUnPYu3sutiOTIejyt6e9uy7FZzEj6tW7rYrdxEklwjBJK4qnpDoYfd7dF+pSw9/58y3udHTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ht9qldiI; arc=fail smtp.client-ip=52.101.193.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTU7/iBbpm+jBW/p3DX3EsoOXsh9BaYvIX25/y/z1CklW0dxyBETopfSyiRZIStU87ft55E6Y2NMRTvFbkOQyF+FRAzRAm2vsZWyQIJ/vfsYBCI8PM8jXc1DgkPSLIAilsUXXHlpJjLAV4IHbapkBhP7R9y41CSpnh+rzjTe2BPnsdww51zfwIUCjWqVJpUEOyuVCcMSGaZalW08Vto++TahP56qo4dVVxM9ERhRl1x7MnXuKxmlhSsJkxFxwtZM3kIDn/n0MRo+MJA2diRze9X7V3dCxkJXBEyMk/0wG7nQppI2MWvJSZmIoAhSW5C7HUQdW8EGLvDBOTtV6QIL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WQHYZsQusk/V74vsNadM+1afb3lMY82BZfTMocAYGI=;
 b=S9CXWRNXcodiAyGgc2nm1EfefEDq2VLGYDcSETGUCQE2NCFLEuACjbOyOMPYjRFP5eyd6JFSq/7TH0dkH5B57SjZHkWJyNfFfks+ZHgX9G/eTJXUGE51GyG7DZ0rpHvlJ9yp8Yo8gKN9H7CsWzfcCsAVNhq7iBGbeORl67Nnkq/QKJO/+nuN/bJi4nwas4q1W2iThFoj6XMI/J1NhOTiQxFlx+++DpAf5mqPEdsfzziy/voJTh2cJ6NfH2TTs26C25cmV/aUuTjUB7qI58kfnSkCBMdgJtQZ8RCH6qsxxrqQ8OmLvb4dSP4Jzb9gbvZkjJcS+vEpYuH6hEQhSt3ZoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WQHYZsQusk/V74vsNadM+1afb3lMY82BZfTMocAYGI=;
 b=Ht9qldiI1wyP6keZLvELJqAJW7ERFukCrc2C8diqGkYqa1/kIUsLS8hfCXVsgGt7/HUCEMIvACP6eK8npSOxTufhVPaaCQrqJvEBI6PVChpr90CI/2GdDIooXgecSxJlpGwdBJGPo0nkeCPRydkDCm7rDLC0mnqzHKF+XnHMh+UnwGq/SuSrlCXk/7uLSL7OjMDU1deBD/TdRhlGeOt+RUi3fSxt7GrvS2P2PjYsrHFw0dtFQamU0Bbb1v0HPFz1XzLoI6sE9fAiAVuTvBDKLp7zxtL8zZEPq6FZ6FExVfPNHpwwI+R/hYgqb3ixx8SieWgYzgckgRIFwgShdwe/sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Thu, 20 Nov 2025 17:55:17 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 17:55:15 +0000
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
Subject: [PATCH 6.17.y] mm/huge_memory: do not change split_huge_page*() target order silently
Date: Thu, 20 Nov 2025 12:55:08 -0500
Message-ID: <20251120175508.1129948-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112014-photo-email-c834@gregkh>
References: <2025112014-photo-email-c834@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 353965d9-ff59-4c9d-f2c9-08de285df5b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rsMcTKFMT+lGuU6uVMrChXGyQLfmvy0/x7eZp6A9YwnSEeOJSm+d/aElm1af?=
 =?us-ascii?Q?qyrU6ShacRfhf35As+jC2nV0jCCGCFDw0zBcrBFDWW98KpyQ61xjZogx7yMi?=
 =?us-ascii?Q?rNDLEmME76L7x48IT7xxGPSfBTQk+W7naY83WS7PsYQdtq2/sfeajudU9lNG?=
 =?us-ascii?Q?B4qoBsPHtvfoCVw0B5A/9RcVSsahcaZo5Be6pGL59g8Jb6186XgId8LdypgX?=
 =?us-ascii?Q?DhXoq35usj72F+yIqU16xyuJEkGYPYN4c2+lZOOjAsIpQCF/Osv2ESZNtj1l?=
 =?us-ascii?Q?edQibOvIX/6sYpsR5gLoozFWj+85J+FAYpvFGP+VbA9HrZ2ubVn1LhO8badS?=
 =?us-ascii?Q?gGNcUpf7lu5d5maFpPDjOJEeA8vGdtnjNkkZ0kqsbHeNfD7BJ4QNPt5SJUua?=
 =?us-ascii?Q?xuGTy8w5HtpBSlhL8YCSyapBb/KwL3mcqlBo8gnZmdV7N2ruVbnsF9afuV89?=
 =?us-ascii?Q?Uj3lTfComjfXDrBhYPPmlApN/EzAdBGWAqEwGWMQRTUw3s0SNAiFxJEYmQFd?=
 =?us-ascii?Q?YO9xjhqpZ6ppitNAgLcVdBGFwDw9gwfmj1Ihx+sYvj6X6MgYNhiVd0B0+N2j?=
 =?us-ascii?Q?R8IqMR3hdxRmSelguq1NSj3QxnaEKsUDcR2Q2rfz6TxaLP3wjA7Qsa+9lxuy?=
 =?us-ascii?Q?22mwDHqsUCv5FqHAfjM3gUZOGd/BWy4XbyV6hcagsrYWBIWieBdmmiPV0laj?=
 =?us-ascii?Q?wrzVzWIg0A8kZMi5YcSxc0JvgdkjbirD+aNnoXSyqKG93CnfUsZdXZ5Z8q0b?=
 =?us-ascii?Q?H1EE0FwUC3vEVsV6d3SV+dAYMzFuUML6AnHcoIJqgwvLbL7UBEYuXFos4TXG?=
 =?us-ascii?Q?oKmFbjl6niASt/OFy5T1eIGaBxFo4zjVMZPG1yYd00Js8keQp7DcCZ6ViS9q?=
 =?us-ascii?Q?7b4xULBsFY2AxNS7uqIYh6qk7WDSOZKWEb0E7TT3zQCeR8H1kcFY/ZOy+WzB?=
 =?us-ascii?Q?tgjIHgLsiyvSeo84T3f/xQkGsFk3ohm+0tPR99OXFA/PRlk6vP9yddR/NNFl?=
 =?us-ascii?Q?VkTdaI4s01zGDfV8f9hgLJ7R5BPl6zDIzhbA+gfHZDXZ4o/BkDWX+r/bRQy8?=
 =?us-ascii?Q?eCfpTXUaXVt3pBqzeZR8HVTeCilHfn/lAu0iXFt8eounDahx4hsKZAeJPsvd?=
 =?us-ascii?Q?CxCOpxOPtbzV0McMlvQyhNMH3BA2sk1bfwKNleq4LpO9J4ELy7c6p0DneYxs?=
 =?us-ascii?Q?kogLzSr/JHOqhpNezvJ9LUfNnoOebW6fFiwBJQL+Ke09OyxRK7OYVzBmlsP5?=
 =?us-ascii?Q?gZm4kV3yzURqNQiST7GBB9JZkXl8NOAZBtK0jarPy2KtNwIsswoW7X/4PU4C?=
 =?us-ascii?Q?eRNkIDtFe91P4oadASX81y/PagLdTYxsBz/5+l8EKDcqES2BHJMUrCmRUCim?=
 =?us-ascii?Q?l5TmCZmqH37x/PFSznrTmFv31yIp/iE7hhFDM0uhr0XQJiwGRQ0Ne4xe2Xjc?=
 =?us-ascii?Q?eUIZXVR8QHbdM6ybw2JJY91aoXp1jrd01gN57chV5PcE+Xy7QN+7DQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jh9upnEBsZWUIOM+EP/02XLuNhMjuq0wIaL0v+Ur06GysQDcZNlrmHhg3KYN?=
 =?us-ascii?Q?k9DJMs1djcPx7gXZ3qkTq/KgPnHWr2FgdMUrv8/aIuuaxwfeU1EtY9Ybyydp?=
 =?us-ascii?Q?Pfd7MTgpC4PhvWr/oSUZUwL+tXMXgk4I4paU0LpDfzSSEZkvxZksvdQWwU5+?=
 =?us-ascii?Q?TOwD0DmvWsddffT5e2q6jgun0yvjFsk2ABx2/OgwxhSuQktqW8exXLnfs/Qp?=
 =?us-ascii?Q?3hMK3yal6UzwHKrdNOqcc1X2CWvgzwH9uEByysfQtAu7+NsOG6U2J9/vdCto?=
 =?us-ascii?Q?d6A2YBF6emiX+5x+ui1f7zq+75AiPP647A3YW9bkmOYLQHYy/wM/oGiKG83X?=
 =?us-ascii?Q?la65r95bd8/9ROhM/fy6RR0WGKYzar+ag14NqJUa59f3GypBbZk3+JGf5iGs?=
 =?us-ascii?Q?AZQylMnSqIbPTBOIO/9kZomrUP08FDcLSedfGA0V6Himv7YHrFCX1pKMObdV?=
 =?us-ascii?Q?Z/v0Nb8HJ6RSTlmydAPhAyhd/cn3qnKoEvJTO+9XW2ATvfvyxBggQFRHBZCb?=
 =?us-ascii?Q?FaSGGx3AvDFaI4xWrRtmmhk5Q/Hen42v6P9FRqKAkADv48oylVXkDPy3dOZX?=
 =?us-ascii?Q?LGLaok5Xgp/9US6V6Rt2TmaY6nHRh0n3E26R92fmHTFaL/vaDdIiFK5tbosd?=
 =?us-ascii?Q?gses54454ATLV1RZoaD+MeQC2uqkcoZ/kU78+fTbA+voYFq2P3N4Nod4KDeG?=
 =?us-ascii?Q?xfbF2en8AkzM6C1m29n0asv16gieFZMgSfng6j0iVHjtcfyoI3MPSW6hBlpw?=
 =?us-ascii?Q?GaU9rfxcLBoZCQLp06qVWAqINTHvtr1oP3Ib7/0J6/d08Jmv8BRYfqmVuT5j?=
 =?us-ascii?Q?S5ppw43Ynh9CnWGfQ+0FSHOIgFbrCrO0n06vK5u1uAiMRr9rTO5SnXAYEf87?=
 =?us-ascii?Q?edbsGZXbMK+Wl3gna4c62jjCU6Uc+/ZstjRpNcTwpdh6JONPBousV6fnduJq?=
 =?us-ascii?Q?7UhwuhtMEQICqBiPFZ5eWNyKBquxS65cziFQYEFTBBzOP7sBg9LMvj8D74L1?=
 =?us-ascii?Q?Et2o04NNX/E+j4QLroN4uXHJvmN9gaIpTW9prGES6s9XEwa9VFQqHPOk86hQ?=
 =?us-ascii?Q?TOF+4sEWrHKfOB2q55HNdmwnATXL5B6jEUZEkvKr9BL7VFvH4d+i802czS9A?=
 =?us-ascii?Q?Yy1GlCRWYiC0iCsyxPYkYzzjF4aNceLh46Sd8aIV/xtFXbNUm53FUYqbWNTd?=
 =?us-ascii?Q?o12jLp5yq5D/gCrCss4TVpcLIKGvQ98YucCj411+blrK6R79EIk16ANGyhBm?=
 =?us-ascii?Q?cgSOotGrWnmivCGlG9EOmSLnn7D2HKn7bBiC2Nc8RJPq1S+AV/Cc0SZsgUEp?=
 =?us-ascii?Q?N81EosQ91RQ2FJUTCmjER5BbJRx5DZm/1uzBtnIS5JZangB26/0W+NfDfYGh?=
 =?us-ascii?Q?f/JKPU2cWyNZVJH0f2h70dkoVChFvkPEyui6edZ8Qn1OLPVuTdmQMG6FlfLW?=
 =?us-ascii?Q?2PPzLFMXMkbRGcPOtIhEUMMRo5lunx+y4FkNat5qlCKGXVsnY9o1nnCIwElT?=
 =?us-ascii?Q?CKRA1nLi4Ze0K7ngi7d/cuB17KKrBLy0USqF++pCyr4XTl1enAm4K2p9l+US?=
 =?us-ascii?Q?S1Cf6TABG1skmQqoAYr1md5ztNuOyLEZZhLXHhYp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353965d9-ff59-4c9d-f2c9-08de285df5b4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 17:55:15.3725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYleZ0msWaFrpMS0i2GEBh/PXSzGcfpkoYFdKBW7RSMWv3hILQRaqw0FQpH6rrB4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272

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
order.  Rename try_folio_split() to try_folio_split_to_order() to reflect
the added new_order parameter.  Remove its unused list parameter.

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
 include/linux/huge_mm.h | 55 +++++++++++++++++------------------------
 mm/huge_memory.c        |  9 +------
 mm/truncate.c           |  6 +++--
 3 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7748489fde1b..6c92f3fc87dc 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -354,45 +354,30 @@ bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
 int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
 		struct list_head *list);
 /*
- * try_folio_split - try to split a @folio at @page using non uniform split.
+ * try_folio_split_to_order - try to split a @folio at @page to @new_order using
+ * non uniform split.
  * @folio: folio to be split
- * @page: split to order-0 at the given page
- * @list: store the after-split folios
+ * @page: split to @new_order at the given page
+ * @new_order: the target split order
  *
- * Try to split a @folio at @page using non uniform split to order-0, if
- * non uniform split is not supported, fall back to uniform split.
+ * Try to split a @folio at @page using non uniform split to @new_order, if
+ * non uniform split is not supported, fall back to uniform split. After-split
+ * folios are put back to LRU list. Use min_order_for_split() to get the lower
+ * bound of @new_order.
  *
  * Return: 0: split is successful, otherwise split failed.
  */
-static inline int try_folio_split(struct folio *folio, struct page *page,
-		struct list_head *list)
+static inline int try_folio_split_to_order(struct folio *folio,
+		struct page *page, unsigned int new_order)
 {
-	int ret = min_order_for_split(folio);
-
-	if (ret < 0)
-		return ret;
-
-	if (!non_uniform_split_supported(folio, 0, false))
-		return split_huge_page_to_list_to_order(&folio->page, list,
-				ret);
-	return folio_split(folio, ret, page, list);
+	if (!non_uniform_split_supported(folio, new_order, /* warns= */ false))
+		return split_huge_page_to_list_to_order(&folio->page, NULL,
+				new_order);
+	return folio_split(folio, new_order, page, NULL);
 }
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
 
@@ -560,13 +545,19 @@ static inline int split_huge_page(struct page *page)
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
 }
 
-static inline int try_folio_split(struct folio *folio, struct page *page,
-		struct list_head *list)
+static inline int try_folio_split_to_order(struct folio *folio,
+		struct page *page, unsigned int new_order)
 {
 	return 0;
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 24cb81c8d838..842f48905d26 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3661,8 +3661,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 
 		min_order = mapping_min_folio_order(folio->mapping);
 		if (new_order < min_order) {
-			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
-				     min_order);
 			ret = -EINVAL;
 			goto out;
 		}
@@ -3997,12 +3995,7 @@ int min_order_for_split(struct folio *folio)
 
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
diff --git a/mm/truncate.c b/mm/truncate.c
index 91eb92a5ce4f..9210cf808f5c 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -194,6 +194,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 	size_t size = folio_size(folio);
 	unsigned int offset, length;
 	struct page *split_at, *split_at2;
+	unsigned int min_order;
 
 	if (pos < start)
 		offset = start - pos;
@@ -223,8 +224,9 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 	if (!folio_test_large(folio))
 		return true;
 
+	min_order = mapping_min_folio_order(folio->mapping);
 	split_at = folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
-	if (!try_folio_split(folio, split_at, NULL)) {
+	if (!try_folio_split_to_order(folio, split_at, min_order)) {
 		/*
 		 * try to split at offset + length to make sure folios within
 		 * the range can be dropped, especially to avoid memory waste
@@ -254,7 +256,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		 */
 		if (folio_test_large(folio2) &&
 		    folio2->mapping == folio->mapping)
-			try_folio_split(folio2, split_at2, NULL);
+			try_folio_split_to_order(folio2, split_at2, min_order);
 
 		folio_unlock(folio2);
 out:
-- 
2.51.0


