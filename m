Return-Path: <stable+bounces-40752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE728AF663
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 20:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6A01C22396
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1699A140368;
	Tue, 23 Apr 2024 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZZ+IPijC"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769B9140361;
	Tue, 23 Apr 2024 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713896015; cv=fail; b=Fn74+nTFYRHVGQ8FLB6R7z5mOHJsrhDjPV6DU3R3+aiDTmOtqURsg0Q8s9GE6Kiq1L7gJkvnLOaanoIv1RibFL1aYnblAdBrn1JkK/w8WIg6j5AsEboQUV+iV3KUZA6/X5Zv+yI9DWiVq5WMExX6PzHvGmQp++RCdgexpwsySog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713896015; c=relaxed/simple;
	bh=wlNxrNZT6VtVgr+St5xHk9CM9YwyQIld5BZC051NgzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LW1LjNY6Vct6dslJR0ihNtwOG4JMEizQp90Hk1eKCb19EZPsln9sg21DuqHMwvtDytzgdihTl/l+JSSwlGcDAz9Mx4uNKWPpqnO/OcMnqQsz27n2XHdy+/5Th9WLueu+engKe/go5uTatSHUUo/kYaIYFSGEMZh8bzCR6vNARMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZZ+IPijC; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIme1XC0EjHtVYFcQZDKyorpD0XNNe8B0PwaETGFBuOBGZ/UssZS00U3vJFsouWdFLqmh6u7mYUNT8GQdtYTocEpLUAoPXBGbRy4ID2CqKNVDHGUjLYtJSHbirTk6Qa5LE1W0GthpvLCqY+oLssc2Kx2O9q3UUcniSj49VuEhHcltt9CsVG1UwNxnk+PJCfk4TXcPujZp+ufD+JhmP7Xj0CP5iQRVVgwt9DjpqTNg0bGUYIsgt8TSO8DTYzjZHcxQwFpAfXnVpcN/kMaCeQgIGufaQ2+YwfKWpS5B36PPV+MS+CWsTyMYymfGspCqOGAmOmVpdtYfiGrRcVu0056ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCTQ4Tq6NI7rX1L0FMlB2I4qV4lqKOSFAGQSBwlW6oQ=;
 b=Tbt0mvSFn46u6sMDQyCdy/hCjw7elrW1oV6dNNgNwID2n73ggv+02cuRx6q0G0j4q8wULz4YLHdKTyzmX13mrgh9E91WclyTuVj0qOakhhhl1rEoT+8udg6hdDFCv+EhYmk6HrvBEKyiSyIR80tZP/csJvK7z0wugv/YrMm+pVi/HS/b0qDdHQv9KqQRHS/HYhwNtXS+ABQUb7lfFWzqtTmbJ3CWqKGBVwikE4hEPCwxiQhLnW8VcVbjr5RHGSMbMhX4QK8i7gQrQugy1599jaJzq/siXnpTgNFTXJBzTxjeECe11TfvRDsdIlgEjI8IatJ+XQvfb6ohIokQx2Kfaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCTQ4Tq6NI7rX1L0FMlB2I4qV4lqKOSFAGQSBwlW6oQ=;
 b=ZZ+IPijCH5yVh6qud+3fLAOiT2fL8+XLqHJFUUFQCchMRVdGkfRLA/GjhrVMbJci6rQ9z5OUruRX/7zdztFaywwCdtNTVSc+i7fZWFN6Qgm0L2OV8L//Cs+t2EaqIQLves8VaQWnff0wYT3nJbxFsK6dMolfZZ5/OfBrVwugjISf0JxWfqtsdoREoGv55EybNgnn6z5S2QQRaG9IFOeY+SVBsnyjevXT2iOOsVNNg7pTxwLAqqhGfVZSMR/B2i63Mef8P5zxYaWPTFp798QKOgfWS8CKVOnK4N6P7cJIWj3p4Ig5jhVxktNk9GMfNO+yr5qqm4to7vrHjACs3Z4rwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 18:13:27 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 18:13:27 +0000
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
Subject: [PATCH net v3 4/4] net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff md_dst for MACsec
Date: Tue, 23 Apr 2024 11:13:05 -0700
Message-ID: <20240423181319.115860-5-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240423181319.115860-1-rrameshbabu@nvidia.com>
References: <20240423181319.115860-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA1PR12MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: 160aedb0-501c-432e-f329-08dc63c112cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1WZBjjx34CR5DzcHSNmoduRNdc7BwSfIeX2BqUfUCfKhadf8qXB9xn7VSI1Z?=
 =?us-ascii?Q?UO7lGVx1WFkRWqbKmgJ36mliOhfnLnPFSXgclj31TPgm44WgZpWTf/7VmL63?=
 =?us-ascii?Q?ij6N0z9lZ6roLZmL0T/zD0zmE6C9jaMoApXXd2If6iw4bjGsrwihbLBFu+3j?=
 =?us-ascii?Q?O9FR4FXSfTicnRcWl4cvuvjd8JEGdWo4NnXrf3j3Yq/Lx2Q3GWWXCcAL+Ahl?=
 =?us-ascii?Q?a/vDj0444WCwKM07/AKbHirjWLcPjKbsVt0zLldsIwhX6ZSSg1yujeNeRt9+?=
 =?us-ascii?Q?ssH0f3SO/x2ETfqZupxEtBKSkjB2RGtnWZBHXJ3boGvK4e0Thc5LUd9FOGRy?=
 =?us-ascii?Q?3dXp9PAnNd6xWjHTEhF5yBlp2riog4Q3JSgQVbCKXxlSchXMYiDduupEquTk?=
 =?us-ascii?Q?nsrhltLc2MNKbXuIKA0fPzUoZZlWVgFjKheloKqiGt4MnSQUrJ+iB9g7ReJC?=
 =?us-ascii?Q?pACSeuopJnrtCjZsy/l7hLQR7L0VFtMO/uTlIUXMKqBAL0DHUiQgUrR2bykB?=
 =?us-ascii?Q?RlUGmu8hbXdKOAPZZufCjkGHAqmlZxwZgwDJMcU2ALNuA0wcfr8Hdm1xFntl?=
 =?us-ascii?Q?KYynRJY2RfXUmmr8I4oIf0nNTiMdBL7yzPpmSVYY3JAewAzorbgBJ0SivvvE?=
 =?us-ascii?Q?E8wIvybDq53NSridDv8rFS5rYAcwDURiqqOz53Xh3zVmcTjHz31YLUuYEUd2?=
 =?us-ascii?Q?pyxoYngDEZ/09r/pdRtDtnODy2zUkdmyytx5M2We4WW62SRW0fyElLLGoqfU?=
 =?us-ascii?Q?ZK1M5JrPRULuAY5c5SpkznIOj5WC6e8BSiBd97gEkNGaPkyXr1CQ9TV3cBM/?=
 =?us-ascii?Q?3MPQOxj5Up5DQYhjtWPUW1VaeMrzgufeKzJeNHSPRXXgAhJoQQcF2/0mSwMo?=
 =?us-ascii?Q?TKYKsKNeyKy4P5gYX0PCrp6x9DYNKC+eaYJ8G+XB/sgbScXXznLZEpSbzwY0?=
 =?us-ascii?Q?m0Avl4f/oj5cgygCg1NPd4ygJsKbkvimj9IR45spVU90WdDkTvaAP1mCtQXJ?=
 =?us-ascii?Q?OWZIAMWjnbllaJ7U5OkSoJx3eb92HBPhBD1Rr82ywsg8Wn5oR3MsmoqHLpo0?=
 =?us-ascii?Q?5Jh88fPCLt0LN4iRAuLA5OPqkPEzjr0amhAiub15L74bmo6kcGQfVIopuTP/?=
 =?us-ascii?Q?z6KZQOI15NnhwGyP+rG6r0sl9wjrJJykiHGY6aGVnZyYnIL1Oo2xa6oJxkuz?=
 =?us-ascii?Q?WRO7dZsMA2W1O758Zt1iFxOyYwz85zOMl81r+e5atYQXoIA06O9CS3K225Tc?=
 =?us-ascii?Q?RuKOyxaVEcSnVAlaP+9Y6cbul2HDlLoCSMxASsSmoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JGF7IkM09/gC6zwlKBB+gudBVJXeKhe3E2F4MRsYOLEHTi2mW352tumD8fyl?=
 =?us-ascii?Q?yLB7PybKnrU8VkJGkyEFiW9d3N6ZAJfVT3zS5EL89J4usTLkxV/Qdx6mbIbB?=
 =?us-ascii?Q?LLYgQuEDuSPYyFxFzqRULN8dhBkC2ikbwZ/wyHI8BPWA/ncNBGt9I/6ykn8H?=
 =?us-ascii?Q?9dHHl0Kma3QzImdCqPjseu18keuUVETHx+YZmzVv4EhH7NRhADK46jSIIYF1?=
 =?us-ascii?Q?fQrjzZRIwFBe3VB8ruYCPe9iCnhonypJRTp1mwaHzZg75Wn087SOuIsANe62?=
 =?us-ascii?Q?H5Cvq4Om2RMpII289EuaYEegHDwiNDWMBfdA3Q3jOcjFS5sAMuy8fBmaYLmZ?=
 =?us-ascii?Q?V0zRL7eGU59gOVRXJDnkUhhgmr/r6rxWPbDERztaKItZpIMbP6m6Lyhcw/WO?=
 =?us-ascii?Q?RXGprhr5wkHSLg0QZjLkrYWdOKIEQh/9fIj7kTx0onyWelJy0tYbFbE2bYz3?=
 =?us-ascii?Q?uJCOqYqRDE/UKOyp6u6IILHwHVdKct/6HCVFvBmjmz33c2Ga5B925RFrPv1N?=
 =?us-ascii?Q?EMMada9y3LIVJlXTAlZ5D0JL0FSVzcEgtr5Fvax1NOvYnbJaCyGjA4VBIWnk?=
 =?us-ascii?Q?ELlMOn2yGlvKqGAUdRUPGrhp4MLiZxLcMC0+6SnbrVh6V4EloRFcVHT4w+sz?=
 =?us-ascii?Q?UHfU1Vddzo9/NOY3ftTCsaWSS9GsP/yJeI8IDT2fkrNNAjnU/37DXJycEkQF?=
 =?us-ascii?Q?OiYqPXhsSLo6EGmNhU/2cmcB/Emecs03hf4QWsa37HHW1Z0IxeZoBV6/1awj?=
 =?us-ascii?Q?T4kCM9M8y1+EEtkK+VGHTC39vu9fZ1pDsLrmeD30cTY2rIcy+kRXU4CimcNu?=
 =?us-ascii?Q?4nxyOV/mRdq1OHOSfNuqg8o2ijD/SByCg6tHpXXgLKFc6OJySrJLrPzB4Rut?=
 =?us-ascii?Q?MoDh/bpnEcN82mJjtsiR7FYJerqsk9JO1IgtmHysH7iMg5mq3OUQHXEd5gkF?=
 =?us-ascii?Q?RPTkORhXKLyNFtwNfPazuEf996LKJ/OZPPHe69yMKH6jmtGeKMjTIL4M7JRb?=
 =?us-ascii?Q?4dx1+VEZvd7WOef+pOJXBz5hHD9KnKqkkzJYNkvoCRQU3/Qvsr2JmWSJ1kmZ?=
 =?us-ascii?Q?dpfAgeBdv1D4M3jHGhLZzfjBc5fLuucCxuY4pscrTlO7Y0FWfcGsYhHhxVeK?=
 =?us-ascii?Q?ajCTjuyPiOu70HHOUZu0GG/6QYsodtWwLBZBj9nP3pNpJWZsTsT8dUKXQ+SX?=
 =?us-ascii?Q?FqK0vNj0Ox1x38S/yG+QBmMwxecXgWreRfJ/9dJPUtt2lqe5ckIKPZp6hZ24?=
 =?us-ascii?Q?B6T3/j+V0vo0ocnE7EE5M7eDWNy1dWQdw8HqNd4e8CAZKzhQhQE9sFKKQPh1?=
 =?us-ascii?Q?oKmjVfGW8S7Lh2/gryhe0k9FfGHE4YpoJpzNShMt6lifL4qYt8PN5/hWsogj?=
 =?us-ascii?Q?s3S6pvb34ia8FmF4Ki7e4MkuPZsk3Osvk86UfxgzxmvqzCoFOSPmnxZAIwBh?=
 =?us-ascii?Q?hNw8rwokk9uKEFgqXp9NDUbdKaR6lG970FyhpfhiyROSiEx/CmNsN02YrJzo?=
 =?us-ascii?Q?9ZD8uwfgk+RSSgPTYa4SzojZXgzB+H9fsT1thqdQYEyX3wuQlUJWywnyqBq8?=
 =?us-ascii?Q?IDyAVqs5WHLl8UkUhlsDwGzRTg9HKOmBpmgcAQz/I964wGPE27Z4jfLyAMr9?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160aedb0-501c-432e-f329-08dc63c112cc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 18:13:27.6510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHN/d1yoU893ueeLkjUiLtOcxltqJISx9Gzq30lTttrE6fqyd9LBdZ8fbPjUBpwP5AeL6rDqKg1VUqRonhkgKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799

mlx5 Rx flow steering and CQE handling enable the driver to be able to
update an skb's md_dst attribute as MACsec when MACsec traffic arrives when
a device is configured for offloading. Advertise this to the core stack to
take advantage of this capability.

Cc: stable@vger.kernel.org
Fixes: b7c9400cbc48 ("net/mlx5e: Implement MACsec Rx data path using MACsec skb_metadata_dst")
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


