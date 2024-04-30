Return-Path: <stable+bounces-41780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9FF8B66FB
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 02:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2C11F23382
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 00:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0540C1870;
	Tue, 30 Apr 2024 00:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JWkHX1it"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F2D17F5
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437901; cv=fail; b=Wrv3cyPpvadiKv+gOzV7n57l9T79LS9ysFzcXgDy1nBOEB/IYzkkE5UbJfGvdse8KYht0cFqq4MjL26fNqWGFsaeCBMcjbjVM0itZIArh7C0mf/JL/n/ZKhzAKLPYKuu2JltjKwU/QzQiTb9s3GUsXmgMpu47mOsEWddabU7Ioo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437901; c=relaxed/simple;
	bh=Nv/6Y2otXJKCOK5TA3n8noCdSpD+Dx8YBfSB1ZZNpnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pv3umgr+VSone2TbtYMF6alZyFyTk6lV+5vzNRszJqF+kNy9tZNRnbDs3Q1A1LWtz4c4uRvSWPWDAjxKm/Wmodx6rf/ugJbcwBfzeIYA8Qf/2wiMZFchtARd0fNV1IstJhtb+nxnJfRQXwAde0YaYM31HO8I1SsP8DLoBfG5COM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JWkHX1it; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fktvF8j8ZGa84ibO1XViKo2MYr/MpOA6VPR1DKXyT4fQ+COk4QvddfjYGbQJcAiUeifZOBCMQBUFizkS2S1imqFWmKjEdQQ10TsyqyqRd2HvVCtV0HOI9FgsSQ8+6LyN1rJ8Jwbp/yePYcnR3aqHA4Rw81HF2W3bcsDY2/hLGUPw5sqv6LFUsmYdUSgFpqald7HrJq8017v5q9axIY9eBMe4D/l9HxOtbYzkuUEpMPmLdMfV3qsg9lDFBF6Amk+e9HpYePD65lwXXqfSvJiOzl7tDC0g+rAP4H3U2iwjLj4N3vWaO8wgX5LnHEx5GSJFAIbkFSeCELk3RRC0BnHJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cgMzBqKN8Tqyo2JCVfz+h7cAzkroaHr6L5yv+7ZSGA=;
 b=GvOK2J3A8es3UWMycSklaQLvoQtOhSpSTarNYZX9kmQqL1ndcC0ItrwlY47+gWXb70Xi0KiiLcgKVnplwDacLY3V+hUbJX6aK1jG1blhtjyy32y3EBJl5oGc3T9vCNrcF39icVH6h3EgY2w2g1EXCu741vyJU/ezF14cWA0m0sJLmGthJKvZ0dQHbVBzxnQjYToQ7MF22g1FJuY7JHo1vMHiH3M0oUiW78civo0olrgons9d4P7AgP78iu5khWLLqO7aWEzP48c/4a/MIHQy1WPks6kS56olHRwVbX7i+NLEK9uxtrIwj4j5DTfmZg+cT+iQw5WHX2EgYEOXI09j2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cgMzBqKN8Tqyo2JCVfz+h7cAzkroaHr6L5yv+7ZSGA=;
 b=JWkHX1it599eMEn0dYN+bWoVA+WfxjYTHrO/lpC48EbeCmqlrGZHen+Eowih2wFjm+Bdz/oU+enOY/SvYuoc47zbUgD2H9Pc2mZthLXH5m7y7SjJBood9DetroUDrneGHM2pCIBLCmi5tAmkTM8zD3YWbAfwEY3wd6jFF8y+iPoZSL9xUlLDLGAJgunigViImMNxeo7M2pZc/sZervgNtBMxG/bwTZhVnpvM2N0qbhF926NKoBuQ7y/s4jeUu3hYjsCRCrHRAn6J0mWHaKOduIVVgH9I/04Zx2Zw04O6CC1ruNIpkj/thQ0Ca3KwAKXMzg9hdAlRlsctiqvppWjN6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 00:44:57 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 00:44:56 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	bpoirier@nvidia.com,
	cratiu@nvidia.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH 6.1.y 4/4] net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff md_dst for MACsec
Date: Mon, 29 Apr 2024 17:44:24 -0700
Message-ID: <20240430004439.299386-4-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240430004439.299386-1-rrameshbabu@nvidia.com>
References: <20240430004439.299386-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::22) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e7f1ba-92eb-48d0-02cc-08dc68aebe15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?giMjw1dunnpDfvNyRQOBpME7Fb+s+i6qw8CFCju/H1iuHyir3Xl9e1wjrY0J?=
 =?us-ascii?Q?pVVhlu0QlYeNZ1pcYcq+S+SEbgZxFhWNdLEiM1Ov50ZGmR3KSrA0Apn/E0Pv?=
 =?us-ascii?Q?zClinYF/ScPrvKjm4JpHgJ5cW5cjGlkKmSilT77HcMUQm1tfLHpyGOiGvnsH?=
 =?us-ascii?Q?/5J+RnbnqowFHrNJ+wGfVqBMsqhw9O/TS4mFi+6sdJkUqdsLO3ZDh0B1QxwC?=
 =?us-ascii?Q?SuoFfCyoWXHbWbBWcIvBledGjREmAND6ya5IkF1URyk15BjnOFjZSKlqYafL?=
 =?us-ascii?Q?XrCmVNtwsfsgjUJgapfvTS6OGX1AKb0C6VGkHWAK52Ur9luY2NbnY3BB3zVV?=
 =?us-ascii?Q?uL0cYRrndjjJ/CfFFdhnNJonOVC5N+2UB/5ZasfKNb4GcKcL4vjvySLgKJ0R?=
 =?us-ascii?Q?6LgZ4qaMLw0pND5EkbK5D58nEHiuilUgStle7vdwmj2qiVfpO2aPEwpFrpCT?=
 =?us-ascii?Q?q5I4nEEGgo/QeiW/BeXOvKzPV+k80kTaGB2U8PDazUjFFzEyxl+gHO3Nu4st?=
 =?us-ascii?Q?54jyI3k10Fw6wUnWROvLn5VZBzuGtb1xpvCgCr11rT3jl8Bka+mAobHC7M2+?=
 =?us-ascii?Q?8F2hEwL1s1hcl/R51RowvEjQNt4xISH3HPFUYCbYg5/QTf5LSI9VUWMx06rv?=
 =?us-ascii?Q?st3TiErmGo6ZujaUoOM6WgZbuB4SiFK42X2taWjOkTa0oBVmTlgkbT6t8D2/?=
 =?us-ascii?Q?vksHIbq0CHu4mrKt5knIo+C4Rb2g94kjIRUefqRMw7DF3r0tfieI156/iTzi?=
 =?us-ascii?Q?ZIF6+SqrDdeuz8YW/srBNb7wAlTExhtPM7Km+4fdl0qFiDPyz7QgOws6qh2f?=
 =?us-ascii?Q?x93e5YYxozBEPNPUeSssjewof+oao5HaZrWLtGgiZTW0qoUG1ap2hQtrUihH?=
 =?us-ascii?Q?rrwzWge9IpdXtIMFMmGrNx4KulncejEV2t0gJJVfjgwFsQgM/zxUHrMJpLEH?=
 =?us-ascii?Q?ZKjer5QpjZbojVtoWNCXnjiw8WeH2YtRuNy7nlhBainLk4eHQ1Yu5yD/ZGyO?=
 =?us-ascii?Q?xKZMxtxA1itwjFMdAHfKukBXdvIzdwyskcJnVHGrDpM3yHGhVoEq76uDx51Q?=
 =?us-ascii?Q?2ZvnlmTMGsjvG5IDZhc3U9+TuKDBiGJwwxlDWdZNXJO51STtldt5HVduGycU?=
 =?us-ascii?Q?M2HhOge19yo60/qT4qoWI77lixaqiG2Om9Ao6THF4VvX+Ih6ek8lP+cc8zvG?=
 =?us-ascii?Q?FKZib8BUDot327wz2QjeguNwVSTqw9G338GXcO5S82ly64dD5HnCmnOUFFAU?=
 =?us-ascii?Q?yrfLL47vOfacTB00+I4/UAwrzHUBemTdl/zsfbji7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EvBdR/BC3KNCT9gMJR3GokmxZtN914bk3J+1mSOgkQqXkvuwaY0lxiJFR/MR?=
 =?us-ascii?Q?dpd4MaeD6BN0hEnXZA3NmIX77S879Hi0nC7Y55BivKJ3w4OGzF8nculmE6TN?=
 =?us-ascii?Q?0dvDlzo74rb6TPreNeVl6fQS533UpG7SlqUK6+nVWZw0DwRvoOf+TBeofWZR?=
 =?us-ascii?Q?1Q3txmBpqdk4AZbQXzar1Bju57EmR6+jtSZZQhGJTvku+A/gl9T+7SP5SFPJ?=
 =?us-ascii?Q?3lEM61t0W8NFGSzAeKP1nyUuqruqCg0QbTmBQIqex3rdAtZjUPeHe6pWKWQt?=
 =?us-ascii?Q?OzzEbjPRwQ5MsKHLCRTEix2lnr8x0NXqwHORjc/pMNe5pJCWn2JpmZuFBI+q?=
 =?us-ascii?Q?fwyevbjI5GXG6YhX6e5tIZqb8QK/AgTWNlN4fcg7x9CXoyb6M5fYhgKJnqb8?=
 =?us-ascii?Q?W0huue6LpVmCRM92hvek22nAIC/bee1rbHVhAYjO6qhBku3TbJw1HlkLPxxB?=
 =?us-ascii?Q?QC8ak9nyS0lQpjcYhL8SMJnSfMtbdRQweUMHJ3gR/Hv2NySO+1tMY6yoAB/o?=
 =?us-ascii?Q?WlA/Y+GgcYJacaQ4UErI9PiXpszOuAo3LkU4V+K1iRqgcmt513c29hNoYRfX?=
 =?us-ascii?Q?O8sS17VYwizKnQiWMNihhpV7meCwCaMJjgArubMMRiLau7TCS0yfxq2OvanR?=
 =?us-ascii?Q?fwdLOumBK2BID3jBk6GLIG+6FPuAlTG/WK5lP3LUQUjc8yE8+Mxl9+TKgGKR?=
 =?us-ascii?Q?/SkHlQOnT/HHRMqa8Shmvw0ks3LBxp1XrZAxzGd+gl72CD1DNQJd+2MJGSNl?=
 =?us-ascii?Q?tKjf0go3Yct3ciaSTMceJKm3yvmFOogMOvLe1t5O0tiooa3r7cKyZKhLOgVf?=
 =?us-ascii?Q?1JFa+DIDhPj03mFW7RypXljsogBk6krcgmRn9kWEybOiZbhMzOnsUdpJpLgB?=
 =?us-ascii?Q?kE2le2zrtVJdZR4v4h7bC+xoD+HHvJkjvJK9efWo5R7Q6T1i2b4o9haRsOo5?=
 =?us-ascii?Q?bq8p7giPWxA6Lf3PjfQx+2QGtZunoGe+BPFqfse7vgv458Xs3O+CHu0yzKyS?=
 =?us-ascii?Q?gfKyD4rJrgx7TnvAuBiiR3u4ZJc64NJu/6WU8islxMFOTyygjHBhjbh0GJQ5?=
 =?us-ascii?Q?g4jMm4LPcLYahXuRW1OGzHRDy33Wz1oNLmZG81LJJi1S8Xvv9ZXg0nO2n6I5?=
 =?us-ascii?Q?cwcu74ymNHwyPHhRr4bOeQKkteezu+nLz957iu56t5NngAjvuQyVGW1+yF4p?=
 =?us-ascii?Q?4MuFByKnL4mqZSc9/FCcuAPTndvgVj3NHBHG/kSc0PBcNNotZlwBIUpZMPVR?=
 =?us-ascii?Q?rlruIKc5ZBKbMAVfRxp7lnnfPEictt/z1Ra4IR9GvwCDcZJXZO5nrqTAxnDP?=
 =?us-ascii?Q?g25NnmB+P7eOHgAJJSDl4dILILL1GVNk/82oU1FL8acnQYrc5YwmzGrJHl9H?=
 =?us-ascii?Q?nW2A3QPikBpXnKdt+gQmloFSZvIcODc7oJKWRB0ThJfApUrwOur1pHdkrDT2?=
 =?us-ascii?Q?j0taXGiP3Fhr9GObB5YSw8WBZqGbG4kLPrm5Sp3ur6JsfqWxh6TSKlMnQv46?=
 =?us-ascii?Q?KJ3Y0T2sJwsUEDWLwSQME+xxTd3rymx4dtHULZSymsZj0l5sDeAyUbC2dR7z?=
 =?us-ascii?Q?Z3d5mkqMVJ+XW/7y9bn8FK3aIAkDpQ+wYvozNzkqHMVUjhWQszuaRJ61Xz/O?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e7f1ba-92eb-48d0-02cc-08dc68aebe15
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 00:44:50.3529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8Rd18xZi1P5vj9xYdHMQxdaYQhb44krvuYOhEu1HfrKkMJQuV1X20zrMp8fDpfDJbV25KDDcqatwsgjY8u2pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969

commit 39d26a8f2efcb8b5665fe7d54a7dba306a8f1dff upstream.

mlx5 Rx flow steering and CQE handling enable the driver to be able to
update an skb's md_dst attribute as MACsec when MACsec traffic arrives when
a device is configured for offloading. Advertise this to the core stack to
take advantage of this capability.

Cc: stable@vger.kernel.org
Fixes: b7c9400cbc48 ("net/mlx5e: Implement MACsec Rx data path using MACsec skb_metadata_dst")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/r/20240423181319.115860-5-rrameshbabu@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index a7832a0180ee..48cf691842b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -1703,6 +1703,7 @@ static const struct macsec_ops macsec_offload_ops = {
 	.mdo_add_secy = mlx5e_macsec_add_secy,
 	.mdo_upd_secy = mlx5e_macsec_upd_secy,
 	.mdo_del_secy = mlx5e_macsec_del_secy,
+	.rx_uses_md_dst = true,
 };
 
 bool mlx5e_macsec_handle_tx_skb(struct mlx5e_macsec *macsec, struct sk_buff *skb)
-- 
2.42.0


