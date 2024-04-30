Return-Path: <stable+bounces-41777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79098B66F8
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 02:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5972838D1
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 00:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6C11FAA;
	Tue, 30 Apr 2024 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LTdJke+x"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D32205E22
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 00:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437840; cv=fail; b=ng95nChnqEXN8KUhZxRywJaXJ1NpiFLAP6j4A8cwMTSWH98fHl6huiymRFLOnDisWLtnbSiMLtir1f9HmS+fPjt/s77AwhYsJXCIXmA0Y9X/lO6o1CmhdHjn8MOHb7tyh5iLUBkq32vijB6F/cyImRWliWYikg+rFsyFSSQMRQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437840; c=relaxed/simple;
	bh=GLu13kFojut48pdVM4bbESS6+1iapstrK6v86uPyFoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bbcMCHOAH2c7+oYjDNII+DixN/akq/iQ6ruhf2pkomiVyJ7abHnyyjfSO7WaivzDng985vNbde2IUzLPgakfTnNJR942FBgmdxUKLdvFVjNeIk4JxMV0Jl09wU87KFqojrApc53icYaTj4+1sGkBs9xb5UXif25pCBS45+7FZVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LTdJke+x; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LElzoM+4mpvM6U9McDCUpqucIFOg+Y/iRmgI8O64GAfGSQxqahyXAIrh5UFf2WpnEqxkVPCRD7gacm2PpryD4olaNFh2e9lKKuIqFE1dNA5j6FAA5AA4e5L8w1N+VWIux8pPsx/apudYXIXfI+u9UO/klEaclYTXD9m2XrFxwkeCjJSGUqKzRkKIU7++NW3CHanLtIIzljB5s0sFwnhupvCFQ74wQYpTaly5E2ecssZovHAPcKc975uH+moUXDblmzXUwZGjCVh8N9vmzgz+m8KYHthroN0BJUNYmIBe1QttbalzA2XczlTlBfw3IgriCPbAzNwxJPwv4rLQtdbC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yUSYsKBVpfJo3S237qV3WJsoGAiwkde0dnvFM4bM0o=;
 b=XVkrUIB3yRBK1ysnBJlpL1vjIaYgW8OoxplrEZgrwn5rh/tFA9WEET/cMwZyn9joYaQHseQ/q6WY0czhFd+6ZMNPOAOWEjP1WNExq2C1LCU9cAlM2ek3iIecqATSDw8DRT0IAyY8v1xPqR8y4Ut0Gwl2wjIptKQfUNMpE/MEwAYxqKGq541TJrcqxeqG2nSF7FVcayWEK9C0Ys9SmL4TDPf/yyr74+V07b64e0Gyy4R4s/g4H4VOgGjrPAvNpNsJUOM+46aMONvfAnf4QCklbXsA9Y4odIgi8wSUX7BVPdXFXXkeBTUorUkZnwFdWD/T0VqwBc4NAYKBsEaqhvMMTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yUSYsKBVpfJo3S237qV3WJsoGAiwkde0dnvFM4bM0o=;
 b=LTdJke+xedqGj9Xgf5en8iCrb7InJ3FrlutMzNMxL/SZaqC3andfkPW7ZBDUV0F2SJV/xaKfd6sMHOoRMKYzBEHrRbbnGYcO8br+q5SJrHqHbIyUijk75xn3sgTuQM8MzSBCrF1pXtT3Jq+3gVTE+XNpf565YuWio5+EGosW7UeZXsFjgh+9PRpM5doETloXEBAhh6XHT815RVfqPb2rQJQjo3QCO3BB/sLTreNQZHEb9UNxZf4qb9dip2+2dpmS+f4y25iWyWhRZk1eznUeKteuyEz3YJ+WLjNbaZLULCZmqA5kq5KVZrtXSebj8fax+Y9Us96nfrOL49uz7LZIsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 00:43:52 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 00:43:52 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	bpoirier@nvidia.com,
	cratiu@nvidia.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH 6.6.y 4/4] net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff md_dst for MACsec
Date: Mon, 29 Apr 2024 17:43:05 -0700
Message-ID: <20240430004312.299070-5-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240430004312.299070-2-rrameshbabu@nvidia.com>
References: <20240430004312.299070-2-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::10) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM6PR12MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4f8f3b-06db-425e-fa30-08dc68ae9bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qhWgEeLCvWZuEf+vA14KNptc4Sq/gHQYckWIDu5rVSEclRSlIC5/80Hvt+TQ?=
 =?us-ascii?Q?Ve679dlo/M4uizN1/7oesaSk8Za2oXmtnXJR2G1HEUl6r1ySGZBKJNvvBeBn?=
 =?us-ascii?Q?WvEBpn+msyk6WlsiaD4q8umhbuKqRn9uJ0ZvaoizEqALrK+CeagAZd2eZKy2?=
 =?us-ascii?Q?S+LrNQt97TgGSj+2LVkij+W0OQi01aNgs5n5TIIzBLub+GFzVpDk611Zgtwf?=
 =?us-ascii?Q?M2oTsUZHgAlGaaelzNxeQHt/95dYqLqOtoIc669CSWxzZunPzpIR/FQjEFGo?=
 =?us-ascii?Q?1O35Zh6fUsXR4oyGnnQ1d8n2uEy57QqYrNB+my/y+Np6hqhlHtzEO/Vuezeg?=
 =?us-ascii?Q?SXdOef4G+cS1sGpjJSdugJ/XJXDuKTWaQqSyMNt2VURxjgyVNjCdP8t9/I/S?=
 =?us-ascii?Q?4Cq5etM7T8UW44ZX+y/CO0TvIonmXyu54pDAHrXdp7TJMIX5wGFNVtGNWNMr?=
 =?us-ascii?Q?/c2lKARLmfhrWXEqTvpgPub48dn0tGjBHvNIjJ06QabBGvE9RIL1snXJc+MW?=
 =?us-ascii?Q?z07EfxR8ZdSZtlOG7k9LSaT+skR5HC7+QHfcbR0/vTAW+zr5pwRA/6vDZtc/?=
 =?us-ascii?Q?2rMSAxsp6SxWSjYKP3jVandSXz111uPt8YiUmFFekebK42KmBTQiShJkueuh?=
 =?us-ascii?Q?uva5JbYQHn6vAoe0TnDzbdGSZxiNcO+Dn76qPBxw8eDHPvN6Epoe0SYmD5cW?=
 =?us-ascii?Q?f3B49JXv3tEAFyD57yT3MiqxWUMRNDV11nnzHmJt1i7gcHdusZSWQGSZ4xRE?=
 =?us-ascii?Q?jfeqE9mlLebO5DdyzRLpiv9Ka1tP6/hWAD9ttClAUlB2d49FhpLEI4QfV3C6?=
 =?us-ascii?Q?F9s23CdR6qSTMYou7RYf3te8xlUXo+S+Cug4/NO0qtd+y+dRNZNg1v/DZkm0?=
 =?us-ascii?Q?s0qteeOWuDdv7NbFOhtyBPBvpzUXqyXnB5gflH4hGReqckx8YTNOeLLNrq1T?=
 =?us-ascii?Q?t+V/IHHSjBgwb0tRyq/1maeSykxWNhWRFSUtJUN98dzCa/w7gjCS9QdiuFDR?=
 =?us-ascii?Q?E+JyF80ZsPcOBzoF1qLY/lMxw1x8Ekz0vp9BwU48v8u5kqdMg/cEH5eLgCOO?=
 =?us-ascii?Q?vttR71oYk8jvhcEYNVoeTAPicSm6RgrqeGKRY8I6WCrnLQJozYhJ8rQu4cza?=
 =?us-ascii?Q?ed64sf5TDQ2r0vTUh/KDP0x+HGrOsGzvvVRvPDp8wiXNAe/+rYYwMISRpEPg?=
 =?us-ascii?Q?OeqsyAlt0PzJCuTsHwYQX87oTrFY8gwS+nW9b5a05MDcxKklccRSEbfVHHI2?=
 =?us-ascii?Q?0WwvjR7wVgvw9qYVH2MOEx+qxevPvBS5iw0qHVKiHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?erqVETtUxniCpU2LYZQ/lAUVYrQS/12sepVKia6g2BxO5et99iA8BQzOBbQr?=
 =?us-ascii?Q?KShCH3PX9gM0k5jpblvSBc3+UYT1O837j5Ugr7Xm5n5nUEjcysyH2p0yIalB?=
 =?us-ascii?Q?n7RneB3rpleXbcL5AZruIKoD2DzH68RjEEvzptuFqQ7pnLBO7nUabrq2fXU9?=
 =?us-ascii?Q?0CdvhumQpEGcy18MUkSFV4I+Oph43gFnMNT6sV9PQfpoHh8bMWJaUPo8ZI6o?=
 =?us-ascii?Q?3Wc305sUja/XYwtjRN4U9T0+pcgfB3c5VsDuGZ+sZItwkC43fW97rXhzdEoj?=
 =?us-ascii?Q?5riI2Yyjc3njIUUKC5iWYad3iv6aGV+2zxcI6m4ggD1WTZqinIbC8YoOiPcF?=
 =?us-ascii?Q?thK3H82/XmAZyNesKkL/bNVFM/iwZTPFWIzXkaYaKJzjtYv/KS7zeHB0BbI5?=
 =?us-ascii?Q?iJgE2TgIBLA5KkPEk/uEstMgxF7/qwkc2oOLYqZg4zliPeknn9Lx7lO84JuG?=
 =?us-ascii?Q?d7ReD7hEGcDiFdVNnffvQipK1ngvoZbhIwoUFRotL7pgpuiEY20nNBoga9CC?=
 =?us-ascii?Q?Z6s5VBzaTMGpZYEW3eB45cNJi4s72zv/rT0qYTT7WV3okhhg6vn+q5O/JYLX?=
 =?us-ascii?Q?gh8iPGpOdx21GC11Zj6Ttnj4ftVh7LDhQjhQ/QcjID3eV/ecnBHP0tu4sGs3?=
 =?us-ascii?Q?dLpl6E0fywzUJcAcnpJQQtyIzqyhJ6tPYMHO289/NkrvgJ0rMPw5PfL60Ts0?=
 =?us-ascii?Q?DwORUZFyKT+/hwkAhJ9xytOkcaZDHWV4FjSa8bvGrLDXyktG37Gdx7MW7J7h?=
 =?us-ascii?Q?BVaVgC2BkocnThgO8hnD+BnKB6T3hxNMb9wc0AgwsWmQDE+Sx1I9n33EbWF/?=
 =?us-ascii?Q?lK3CfNul56rSgNE5FQ9NnNEDkJd5O/x/1/H3ylI3SWyfSdAszN3NUEnZwGwK?=
 =?us-ascii?Q?cecMi7a/Vq3TwaX8KktUgpzgzWZyroD6bQ/jkGlO07S5pwzS/iB+AuRjKJd7?=
 =?us-ascii?Q?XDFpoEp9OnFwWpThaOOGHm1rp0RexvG36SWEdlQLu2G691Bt0L8uCs6/TWN0?=
 =?us-ascii?Q?v8AZ2ValHCgcpVLOL/SzsIQ1E/uShAKdei1u4Wh7GkZ+QVAhNZIcbT02QjRz?=
 =?us-ascii?Q?zVJBnwICGWCO+Kbj9s1TdlctGT/UL4ycw3xqbV5pAy+MYP7kweGjJlOxLCGX?=
 =?us-ascii?Q?BWBRwbyduq3/ozPAigq/kjGRcXcfkLdZkJDqnPTkh1phdPVaayx8IzgQknoM?=
 =?us-ascii?Q?Ov/B0roVFTSBoxj2wdjvXscBB6yHuMhNdYD0qDcLRKBX8ROXSIw2KVCxL3Jy?=
 =?us-ascii?Q?xVdA9b4TFdSvKM7PURpewyX4MOTH9C+bR06cK8JQdgfzfE6pDInG1WGOsfsS?=
 =?us-ascii?Q?o38SZ/EQ+nEonoYq4fFywQkDabHaR5bXkkOxzg3rRfKf2CUi3SQhLiZp+ZFe?=
 =?us-ascii?Q?4QutsFTPMnP0OFAyVdDGcvwHGvUslliF+HKmDCA+iJwKSk08Cg01Yvd7UyFr?=
 =?us-ascii?Q?mY0213v1nnaoNfBz5/nTV9A1X9wprao8oh3ugIteLKbB5++UwnXFOzZ+LCDF?=
 =?us-ascii?Q?paCGN3rVsx38p3k/72sRJA3B/lr+5CaUX4uXzz0KNE/gm5aj7lYaCaSw+XWX?=
 =?us-ascii?Q?epKGWKXk3IYGZ1MpFenD1Xfu5DeQYJMlFJV7ON2I+PnEifQSZP+fwF3rpC32?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4f8f3b-06db-425e-fa30-08dc68ae9bbe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 00:43:52.7300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBslLJ+ZYNlbKdygdbd2jaHgLCBCYXimoKq2RbKntLRy8gmLqWPt1AzfopzvysPzh9ZfWP9A1pAik771aIUHVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468

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


