Return-Path: <stable+bounces-40232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBD78AA680
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 03:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674D5283A45
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 01:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4545664;
	Fri, 19 Apr 2024 01:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r6JTQ9HY"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439064696;
	Fri, 19 Apr 2024 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713489483; cv=fail; b=Ylrzqiw8HNSCMMWabbdKRXtWiJESinIvXUfNf08QNVnh4B39PHg1bEiunxhR2iNeMuRKjiMh+M8JNjdP5E1q36rFdbYjmRBVkU0LAXBzwHHddgdgpV2W9o5LAUlXu7sYH1G0FyzrfFc5NuphJDfltUQCxJPups6lj2GrZYpWrSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713489483; c=relaxed/simple;
	bh=ngvh2qc4htDMIy6YBph6Cs5B2mv5a/73cwIVLNEvUg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MUF+V6XkTgp1tm7wr0qgYYKXlqfgimqczUZ9jBtrbIiB+YDXCwgAud8FxftujUCfj7KKMreG4Sjp/LB8yf2uX0GWm8PZYik1+YZmn11dhYsJVAZOj5eEPc2AixCdtMpn1Xa/+ewHcVfmlp7OJAmJHLM3jsp/PpU+lRWJUcErswk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r6JTQ9HY; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwFqww6+HnKSElj8HhDAyGlIkvrXebcSa7iByh4vzMHuNaB2hsrMt0RxSD7KvKAI9NaOj/ggT5ZOGbzwbM8Lm2nu5BwkpRLQfT13mv+WBy8AruBHOqhw8eGb+FkhR9MCS3vqn7zdSIoCPTWnLW/myRimRuQ2TgH1W1PkwMTYAi8T8K73u82odV0NQunLrNNL6UwiLztb+YAEE1LLdZ2OxW2Y4JcPI8aDFysCq1Z8Dkjlt63WD15TYPZ416/tGp4EE9C0EQ/RItnxrxPjrbdrySwIk5at3P/StMDepMVAtIQUEyItVUIYUTejRkh8TueyTN6mQwKr5fhMjSeIiyTDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16IWn82d0wSU4/zaNVShA83xDTy+3kxeAB0bDaf9BS4=;
 b=n/XYCCK2bBHXQsF3xCnyApsvcifyX+duS6atB+ZZFYIWFYWAV38PidyG25WvDWPRVHhtJyYAPW0YxGnlD7ypWAdE1oUYHtzyMQ9EZ5s/yb/1G61R7SOWHa8cwxpgM3L8hngoTEWjVRe2ls32lcGKcCWQaYuxUlpV/rq4cxISVkQHoOJKq2ZRe0JdLOIXvATY4541l+Z2vv0yk33CMkXQD93JZE1tUK2/r52aTXqtwehpsZWmvyXtdcFj0f5kbMZPSGShkIqO346exb9M9RmRrTHbr5qRIVMknCCXBILV6OvCSpB/3V7wAenp6qn40qEGyUfHTk2bVexxAmfzhWV8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16IWn82d0wSU4/zaNVShA83xDTy+3kxeAB0bDaf9BS4=;
 b=r6JTQ9HYFGdLJXE0el+DIfPuauA6wiqPS0oIchRGUn+YnSTCQptsWASE/E3VwiSqcOVOqYBgtVST778zXWtkRPsTTSqwlTUoZk0YsWx0ZUCNKRKmXpGpQ8cpTTXKgg7NoWrc1r9yFGRccg8DeSJdlDsHqiZa1vwCTyIZH5ua8ggLN4uM++sLFIw5c8SLnAv9aqPKD73NEskLE7HwRUDUlH1fyXqxDc6lfza6jO9frfNwadQlg8mcWJcMuBAsDim7jaSZNlEVvslGz9+R7ByHJ+o9an86ox2EwkJbTl0LkqH7B64p29CeX0e6sdg4j4qBEYBca0Ty+ti9B+H+wqOplg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Fri, 19 Apr
 2024 01:17:55 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7452.049; Fri, 19 Apr 2024
 01:17:55 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Yossi Kuperman <yossiku@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH net-next 3/3] net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff md_dst for MACsec
Date: Thu, 18 Apr 2024 18:17:17 -0700
Message-ID: <20240419011740.333714-4-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240419011740.333714-1-rrameshbabu@nvidia.com>
References: <20240419011740.333714-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0061.namprd08.prod.outlook.com
 (2603:10b6:a03:117::38) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f1a788-b84f-4626-b228-08dc600e8ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dOrrNCCxsFCheHzWX9s+q6NPa8Lp6Eixn+3HUJHI+U/OT+u+r9pVTZZTET1c?=
 =?us-ascii?Q?6vGDZEMJkjKlj8vZZ7Enf8YAVpng9ku8KQz+ma8GJCrwc571bWc9bOzZ06p6?=
 =?us-ascii?Q?0PsE6oHBM6uiCnuyQNYbuKR0Nar4BlYPgcbfJm2NjK9vUMtNc28PkMUF1MaY?=
 =?us-ascii?Q?1/ZFdLiMUqFQFsG17BgWoleoDo15zuUQfPPudNbQ2gFKTo3qjEKnGz/YGOz0?=
 =?us-ascii?Q?mta5SJMlAP25BSrz0KuNb7w/aHnxfk0CcyjnuvODCY3pzaQ75Bf0578xGS2H?=
 =?us-ascii?Q?qL6YpGKe9LTCy73EdBPu4FhRrgopjWbVsF7YQWc1v7LOQEr46G84Sck43h9W?=
 =?us-ascii?Q?lFvLY3enOOvl20+w+877Qw8a9QMixAEEZKkJASFYuq3se8I6X4ikN6q8hh8Z?=
 =?us-ascii?Q?rDZl0ce0nJA8keViAXjCJA96rGmE6EXAU5hLwXMYBoHmou8MOzGjqh00Lktn?=
 =?us-ascii?Q?DR52/B12vIksgI8E17zLNdPegdV46EA+Yblfwv2I7LsDZOSeuO+NeC6tKRHX?=
 =?us-ascii?Q?y9pUK3z4i2wzKZ+ubW2KevyJeUrb9c3HJBebmPwAPW4qxf7QtbTiLfYYcrtr?=
 =?us-ascii?Q?reMmi7e7ffL5F3xROyzOkE9cNRNqJ5Jta03uNetRAxRbUI6igFKpFr0gqAI9?=
 =?us-ascii?Q?9EFLeTJHib63AIunXxCxbnSIKMDP9WzueXuZ23Rxo8yqxYvw8nkymTW0Ezj7?=
 =?us-ascii?Q?ql9ZdJUi3hkmct7KYDOwYE04xfl5lLT5PCcUA2PpEL9FIU1MkFX2Qn0LdenG?=
 =?us-ascii?Q?LTRjqa7ap7orRXjgu8XC3GveADhwTzeCXjbejh0JmQmQl+WZgJ9t6pZZYCkX?=
 =?us-ascii?Q?BKHiy1x7pfqX/VN7gCrBXGp6vca6jkiDCrPNhKPUhhK478s/AwaqTFhDAAB9?=
 =?us-ascii?Q?ejPV6x0dPmsnpzk9ofNFKteFnNW8+oRzSp/UkII5FMU+rN6HwGuKxJDM/+xr?=
 =?us-ascii?Q?w3/rvMKaocjoSs8fOB4nMOERXSjbdYC8eWgCJAd/n+umfX8O7yhw96QGTb9o?=
 =?us-ascii?Q?gxuVtpbULK7zu19MrPWqA473kzDMUfI9MHwurZAs5gDl1XoQNt/KkZ3NOKzk?=
 =?us-ascii?Q?SoRK4hOGm77u5im8/jutC8ezEU+DbZuMDrR7fMMRdrLB4KZVnZnUmoq3jwRz?=
 =?us-ascii?Q?13kIFWwQiRftuPqvjNXXsFmnUL57W7kJb7ncfrlvyU2kBjQb3Peb06JAGzPy?=
 =?us-ascii?Q?7ln/Yr6OFsnjLZB4jncyeKK6pXgCuEuG1Wuz76JHwJNEmarrtDGqF1KuTuVv?=
 =?us-ascii?Q?52beNKyUZ60dOf0cjB6LZFUmJ64mK1HvfzOkQCk2kw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cUutMAcN2nXBtlBe5IO2Z26CN4gAMIEjS3HymXwCKZN7BkB3v+8Cet4l2+1J?=
 =?us-ascii?Q?wBbotYANqsam4WdcRorgrt8c0A0WiN1Hm8qiRdXNewfS3jDNRaBfExEbspRt?=
 =?us-ascii?Q?cRV6K2nxxUL4rjQBmcdXe6+yGXqvIfBaeI09Q+1IWa2iEkwbe0Fa/lzhHNdX?=
 =?us-ascii?Q?ewRBVNGog9S3D6S5de9I5Tg3QefrfVkdCBfaM4RX4Laxocoafi7gMw/EbW9c?=
 =?us-ascii?Q?IMWNKRs5HOecxcjwolp0Oo0M3MzsXaKerGFaEwY5PAOrJa5nAYgT22kuafMs?=
 =?us-ascii?Q?PgNNGJOwwTbvTzH2D9BrpoktUM11R6FTGMn4Q6PelG1DL6l5hKdyrBHPl/3P?=
 =?us-ascii?Q?Crh7Bnp4UqMpYhDHLoaUWY8B4OC1vfgNsb0ml54BU5Vo7v8YaVmNNZO46dNi?=
 =?us-ascii?Q?aIPNflpW0z2MuXaCUH3+qxmva0kT/UCCdyPN0/KZFtXziBPQ4wm+/TW6ppSb?=
 =?us-ascii?Q?hrwa8ZpH2/tggiRx0IyAPYpFZ2AnZ0QHoGfKjD/Bb+u1BWVRtOTofs2LlmtE?=
 =?us-ascii?Q?FSqxGCc2tYeSkpyviPmBOdPMlVv5mte02EvaVRZJzOsSc4NhqQx++ZaRIkMm?=
 =?us-ascii?Q?WL6SMld+rxV5kWMNFtqSAg3LVueDLEUoGggFcVOBRLvJvYwLWcGo7oLLk7W1?=
 =?us-ascii?Q?59vO1s+WpsVaNzNnIhTu67Vf0ijerivQNsSJD+7gg0teqCmxwiniue7IYk61?=
 =?us-ascii?Q?zH+skpw+L1zN1dQMFhzltTU8Y98RBU5PlH5KvrqR/iMkkxecoT8mFqCf4jIC?=
 =?us-ascii?Q?Y+ZIEeONo5i1nw2sL/DwIucZUdSaZkHMov1FQudsIGdcFtmyFymgd31oP63D?=
 =?us-ascii?Q?W5XNByDrbhVp5j2Ep8j2E0ILGmzZwvQrwLgkPnhQNxkz/jxRnU9mZS81w140?=
 =?us-ascii?Q?hSp9kmgm92Xb7rCJcD2Ul+fcUUt73ldHsuCUjJb8on4gugZi4ZW4j58Wfj4h?=
 =?us-ascii?Q?5NjR0WtH81jbthDzSN2ArD94aKSoaDbFws1iD+zwz1QyBvx7T7nqCMtcPryt?=
 =?us-ascii?Q?e74R235SVFvZHAuRC7IVLuybox2gGsJSvs4sysAFeQbdeoKBomP5kDlgCtzg?=
 =?us-ascii?Q?N8oVvqp2BySKs5oSx8CuklyVoCqjE78z/LPYijllVFwADkWcOBXNzn5Anmbd?=
 =?us-ascii?Q?S2UORLF0m1Yiuh+8yhJyMTNmfW9w3CY3skodtovyN5nElQlAOAvC9iNQA6QF?=
 =?us-ascii?Q?MQ0Ycc26vCDznHZt9EnmsnjiXhDBpWYHKcEgYL50aJ9oHV2rMf5RkTNc6jBV?=
 =?us-ascii?Q?AASoG0eUR8BNhrt6BFTBeSc0jVIj1a6lLiH9yY+PhXlvBkikcjmWZBXj/16Z?=
 =?us-ascii?Q?qSnSNpv5K70Bte2/Fj/gghb98J/p3S2Coim0CCOwpUXRS833z+zkC92WzSh3?=
 =?us-ascii?Q?gKi6MgZ2rJwA+BQMNki7IyfomstYaomzmJo56Q0q4S4/ZYhAzp5ZC+ut8C04?=
 =?us-ascii?Q?U7CnaF4ynfRM366lsz9aisC5BUhfuLT5Q7EN75bBTim759MIPG9tErmWOWDp?=
 =?us-ascii?Q?d9sLoB69KT8RVAHA0sY/irGGhEAZ65jOIJcIy2gMWn+O1AVoUozc7JuWnSXy?=
 =?us-ascii?Q?tQuhXs0dkBNd+yqu9FmHH5ywSK57J2ptrd5QF2P0nRaEFgondVJrzdeBaZph?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f1a788-b84f-4626-b228-08dc600e8ac2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 01:17:55.4665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FctHSoftRy8oITPdjCghCmaxINbHVoJUuKHVILdG5XgHiGywzTmPaWTcuBPelpK9gfAtIa/pr3IGi4WiBof+tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656

mlx5 Rx flow steering and CQE handling enable the driver to be able to
update an skb's md_dst attribute as MACsec when MACsec traffic arrives when
a device is configured for offloading. Advertise this to the core stack to
take advantage of this capability.

Cc: stable@vger.kernel.org
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index b2cabd6ab86c..cc9bcc420032 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -1640,6 +1640,7 @@ static const struct macsec_ops macsec_offload_ops = {
 	.mdo_add_secy = mlx5e_macsec_add_secy,
 	.mdo_upd_secy = mlx5e_macsec_upd_secy,
 	.mdo_del_secy = mlx5e_macsec_del_secy,
+	.rx_uses_md_dst = true,
 };
 
 bool mlx5e_macsec_handle_tx_skb(struct mlx5e_macsec *macsec, struct sk_buff *skb)
-- 
2.42.0


