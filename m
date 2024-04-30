Return-Path: <stable+bounces-41782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85698B66FD
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 02:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73381283955
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 00:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125DD10E4;
	Tue, 30 Apr 2024 00:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z+4WtZ6Q"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BD4205E23
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437904; cv=fail; b=uhM84yuMUZtNv/wBRhXdPpzbWU4k04HQg3dgcb9JAy2v9sg2X03XkoROYaV5Qkgd9wkIMmCWOk+nQUSN9c7WIhY7a8fVXp1/MMFa5X8tt11svJReF/+35sxx6QzkrQ9iv0zfKPNdFExvTfL1Dhc+Qqai2a9eG4pUhco9E38vBRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437904; c=relaxed/simple;
	bh=tlUeoKhvlaahcpZP4MJZYBhxCkVnpMl2UeqSAza7nmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ErejOb9Qar+MM5mvNjOlW3Demd/jMDppgyo9Bs8faaUkSnyn5bo1E2tqxZ+esd4P6/fe6lZM/yJ+Cgck2xjlCEcyCM1/scZOLLOAWs+cQktt/XpJxnJ38StpqrH7FrLOi4WACsKSi7ISezE/gNCyAGMuvTi0s0SGOmNaHxG6I4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z+4WtZ6Q; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6P3A+u9palnkpV3kC64ybdcKZRwzsKCc3VjE3ld0VScm1I8AecknFvjkPwhiCtQs11osmOqlNW0Xsl+QHf5uC0ZmCTIAEzmGThHeGoRUaKK5awonqnPuJmmLjszrs0LttlXLpw4SbWMkCHK4IFknpzopWq9ecdsf6YX/BFypqUBG6uyzhXP4Rzzdf1qHJXZ7rzWDZS/PXFsyHmcLFMaXqpEvPh5JGPYz5K82my9XM2JuLDLzxCe0VLAqi2LuDJzpvO1/EGejsSQQGYMH9Z2vvSEj66JgGoqwFS+jtwNEGYsEWAOYj4iJWY7wFvszDUxKE+3nkpqItOmzD67WaLHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJVMftZ7+n6cSoGf9683SjPnEemQGiYDZ3u/y3M85QM=;
 b=RrpZwiaOsUe9SUHo67/qK5eHVCQTG93hYYCiOgeKiZHKjgApBsGh7BDn93vbkLh6u6eK13SM28KaaPAGCJ6AogX6Bs1EA+IbkvPmPHgukRXqptQMgjHQWQI74h6iAyFgXmYGE1sbdCVGSQwNsBgy0PpUKrlaHfod+Xo9uiKHWdSQjsJbh7cy5NBWVJZi8PYiiXxDe/6hBuewpWM3hOHQNIicB0oBUXTkX4avYbKhmb3gEZ5Dgjb7LnjKE4JufPS5ciz3QtZ+KZc+pYtOca274UfEcRxz5e9Q93PDTadnQuW+2vx8mXFFkrEy3fstznO6Es5GDtcBb9BeRw9+53pP3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJVMftZ7+n6cSoGf9683SjPnEemQGiYDZ3u/y3M85QM=;
 b=Z+4WtZ6QjTEITFMNpwACVi09771vg4Y3HYI6uxR9lLDZQSRbz4NUGbMaw/gczilkK1sSGMef1ttLja5hdUWWl6BLpDF45Y8vMJDFG4NEptQ1DMfoOLShs7d/1URq1SzyL26lGvZ2e7fPblIvFuhmZuk5O++4Br5LRQulBmQUyTD5jWGJsOSW4xOrTSdFGgiYraAqkw9L8QMQFsTwx/tK0QnyKtE8aj6iRcv9AynusiJjpiNnXiohGvzWduqD/yUmDlMQUtyGrpepFxIF+raF9uHkK36fonKQGHbJfpNPvhCCisoxHjqQZmfidKgfvk/h8MMjIkUfVM7rG3WfN4nglw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 00:44:56 +0000
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
Subject: [PATCH 6.1.y 3/4] macsec: Detect if Rx skb is macsec-related for offloading devices that update md_dst
Date: Mon, 29 Apr 2024 17:44:23 -0700
Message-ID: <20240430004439.299386-3-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240430004439.299386-1-rrameshbabu@nvidia.com>
References: <20240430004439.299386-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::21) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM6PR12MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b4f2eb-6c68-4063-e445-08dc68aebd9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?blclOc2WTIeSntgylNTfcIUjPNT80yj/xeEtd+59sgkuXHl5p3xGK6LJawdh?=
 =?us-ascii?Q?1bXt+cEoa8lP+k0CgYxfWvgGxvp/S97Gszl1xzy/iwaFtBkjVUK0MU0AMlpX?=
 =?us-ascii?Q?7xBGsiymr1llrZ2gbpF8oAZvp31jQm2XTrExPo/zcJy5VrutrNSikWsI9H4e?=
 =?us-ascii?Q?oSzcCiv9Q1znJiAvCPLG0GjVwpICT4Aqm/qKNhR+dKAcHPo1MDAvrmsnPwY5?=
 =?us-ascii?Q?B+2e1levzLi1CNLbkN08qYNP4D2TYOsugtPDG4VTwmEhwiJMYEBuUgK35aX3?=
 =?us-ascii?Q?lt/LyezkiafdfVcsvvNMK/53R855GN7/1EZmj/gsiHcSi/orAVF/dZIDPLz4?=
 =?us-ascii?Q?wjKxRQHWCP/QvGG1JHrvL0qYYu0L2uHKltdcirQVury5eV64KcYYXl5/RjqH?=
 =?us-ascii?Q?CIWKNiMy0ggANE9wf/7izJ0zxp268M3EBzhtXkSTQDsFX7JgA0gnJY7oh66S?=
 =?us-ascii?Q?eVZ5/wpy6qHKFRDtziyIpOhEX5X4db3HCRFoP3/pn1k0MAv1eh1jKhKRgl3w?=
 =?us-ascii?Q?THW1Kj7ReEZIKvHP86M+LTShqhlpqGCTI+mEvsBZ7myPc1hc/mG5v/M8FxZ9?=
 =?us-ascii?Q?gIKYaox+leLbyJwAHEcc5hOGc98osSbqVuq6T+05FBS27KC10HMv2r70yXPj?=
 =?us-ascii?Q?C+FQDYBCMB2Zgd4pFyxPYrAQ1fc8VDJHV/ot+7kc1vRn/LkGj60LWiYj3WzN?=
 =?us-ascii?Q?+we3q9X/s/5wZqiIwqTpStSxjTUv3pPZZWfdRAx8UTEQ0wYkymIfAytXB8W0?=
 =?us-ascii?Q?rWu10/BWS89VfNe8ZvqHfwfwvR0EtZd+YIuyQUEtu8cwMU14tJ4oyCPXCI4c?=
 =?us-ascii?Q?Ziq8QVoy3kkDc1V8ShYFNGp7QY8rJid4iX0c2LwLw39WmXgk6LOZIwcNptk3?=
 =?us-ascii?Q?DQzuDND1orcd+ecSqgOvafYx0Jl6KE0CljNRXeuBzBKaz2/5gpoYU9hjbOi+?=
 =?us-ascii?Q?6Nw8ku70dG5MkFXuowXmdtmCmLNQXpotHKTnRbkGvVfzlZzBzX6IeA8ldJxx?=
 =?us-ascii?Q?kc7WsCI2q4VAz9zJXLRCJcDc0NUXOUBQ2CCkMNx6WGRyaTVuKPbPpqOzqyle?=
 =?us-ascii?Q?JCVUl7ewLuZnTMi7IQSiXw5D/VKXLNMx4agoCmMa0vX4ZlUqOcZ7DMXb2gdn?=
 =?us-ascii?Q?+Kt+K3BR54Eeuh4PT/2ebiOYgo9y3BLYaq1ujKbIklUGPhEuoVBT2ot9ujW1?=
 =?us-ascii?Q?3W6Teo9OJXq1qirn6OP2GtI3Pdy4UDjWAKjRJbIMEhVZB60B2zC6O6C9rpAx?=
 =?us-ascii?Q?7y+aDcuFxSpYogU6LqrHJmVu3fm+zI8XSt94d0VGXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BZwf04PmxNzjr7ErO9t8V33xOsurmBMsblBMYQkNrF+zWk3/6gJXfNxgmI89?=
 =?us-ascii?Q?FF9YAc5ddcYy7q4GzKyw6/SijYlXDJTPfJ2EOShaquRjjPfhfme0hytlpiLg?=
 =?us-ascii?Q?hf+YKtYOULI2Nvk+jPHIdxR07zIbHks1+aG8CekEZgwkJZhIO7e6iWRpGSTt?=
 =?us-ascii?Q?ZrcZ1HHbhQQHKR402qFhkuDoEUVbZGTlVenDXztZeGAZLTKeuIA15dwt98k4?=
 =?us-ascii?Q?V+6Nqddy2xG6DQQZ4o2YcxO2wObOOCl03vzBicFk2YnPJBt2QuhLweDE/Y6z?=
 =?us-ascii?Q?Mz1D26zekNsM36sWBUcMbD4Eww6SoLrngl9wMjYpfqbbguRhcW08fwHpo6oj?=
 =?us-ascii?Q?WfFQCDKd9pXvro7oOcGunYtaipm9gdOlzFl1vAorFG2519z6j6EZV8e1cejp?=
 =?us-ascii?Q?BI+jqG11LZ1ESEeq/498Y0ElpCcQnyeKtR7UoXY3NpU6EEQm+xiQT3k6qTXU?=
 =?us-ascii?Q?YYXxr4wLWXU298PRRaIV2OfwR6MMpHZL1y5AG+L46YhVwUOmsiDYScaPAry3?=
 =?us-ascii?Q?+y4PXMsc+Ep67kWjzmisIiT0SQBlfmuxC6Md3oO2Kipcppj9n1DJLUqJ34s+?=
 =?us-ascii?Q?XroHBiCQyiNFSctmmcUO9UEwQeGZGxoQoLRYJc4Uuhg5ZvU/qVW9XcTrm+js?=
 =?us-ascii?Q?/Oii3SbvWTe7FpldVOfjG5Au/vD7gRrCg55hes38AIWvHkq6VeBGbi4DVPy/?=
 =?us-ascii?Q?uSJS4murjxH7VpxzLBUGe77ti1YshrqfK9jPTuFFG77hA9ojce41ICGnaFNV?=
 =?us-ascii?Q?GSriJeDzmXBjXFFoMVPItxTB+lUJ/+NWonXEM7Vq6s/40k32BLDenEBfrQLX?=
 =?us-ascii?Q?Rr4FRlrl8E8oq2fo2t57NCz4auTZXZgZhxUAbvjAR9HV2VFU7cFuM5g48mEF?=
 =?us-ascii?Q?HW1jnw1ELUYwwWh4uB61K7IvUWLXixijJzrVRzt5l7q4rMdecJpPXKtGHr61?=
 =?us-ascii?Q?0hC8T+nHfVRgPdM/pb0G9yiGDf/s0/UsJRH6+Zy+qz7w/OrKN+G9y+dfdQbW?=
 =?us-ascii?Q?wFQuFWVVU9S7CUaGZwJrPOuFX0r5cwq+jNC6IfeosbkcLSQhYZ16kY0y4gno?=
 =?us-ascii?Q?pSqiRPgKUB3WH7/ulgjEC03VUaslUe3GQWW4QJpi2tuEpW6y8StzS6hSUuaS?=
 =?us-ascii?Q?NZCMs8anoextM6WCJ8f+DyF09+fkGAu9mBrzKeRwDxYmKn+aAjp4sYIfBDxM?=
 =?us-ascii?Q?EIywlwkb0vaxHntAYECvz9tiQ6Yci7Fb8qUg/+Qa9uFbWUZlu41AXl7yy5+m?=
 =?us-ascii?Q?KX3IV6Bdxf8386eiP3PQe8ykQd1+EOijvVyoIaft+L1qTTVF0vrOM5LXinfH?=
 =?us-ascii?Q?FFJPbF4faIPs1b0fjjvqCrtht2H3F+FdsikYzA+pBCr38WieyUiYYhXNKGJ9?=
 =?us-ascii?Q?BRWC4L6zj70AkG6cu7mWIv7QbdllftcPZ7syqvCs+WyXk123hh/7wdHCKBeG?=
 =?us-ascii?Q?5s/Q4BYc/TWIPEysjppciiJhgBggoeCOojmfUhlDnHKIsVAT4hVwCoaGHZOr?=
 =?us-ascii?Q?wtPHhpElw/8vrjTsMspOddUgbJ5AKwJnjVIWzebMEA8EaD+0brJ1VP37650e?=
 =?us-ascii?Q?IKdYhg+FqTcoIRTrvaCA9WhoD7VtIBojndpwz2rf1Oi9YVn8YoNyj5kl+VdO?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b4f2eb-6c68-4063-e445-08dc68aebd9c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 00:44:49.5748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n48pvq1sUP1FvsSJd3ptvssH54qjurMXLhx70hi4S1opexJryBHZEleu5vFuESoVLc6EtROkU6/Ys9KkTOtHUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468

commit 642c984dd0e37dbaec9f87bd1211e5fac1f142bf upstream.

Can now correctly identify where the packets should be delivered by using
md_dst or its absence on devices that provide it.

This detection is not possible without device drivers that update md_dst. A
fallback pattern should be used for supporting such device drivers. This
fallback mode causes multicast messages to be cloned to both the non-macsec
and macsec ports, independent of whether the multicast message received was
encrypted over MACsec or not. Other non-macsec traffic may also fail to be
handled correctly for devices in promiscuous mode.

Link: https://lore.kernel.org/netdev/ZULRxX9eIbFiVi7v@hog/
Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: stable@vger.kernel.org
Fixes: 860ead89b851 ("net/macsec: Add MACsec skb_metadata_dst Rx Data path support")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/r/20240423181319.115860-4-rrameshbabu@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/macsec.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 209ee9f35275..8a8fd74110e2 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1007,10 +1007,12 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 	struct metadata_dst *md_dst;
 	struct macsec_rxh_data *rxd;
 	struct macsec_dev *macsec;
+	bool is_macsec_md_dst;
 
 	rcu_read_lock();
 	rxd = macsec_data_rcu(skb->dev);
 	md_dst = skb_metadata_dst(skb);
+	is_macsec_md_dst = md_dst && md_dst->type == METADATA_MACSEC;
 
 	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
 		struct sk_buff *nskb;
@@ -1021,10 +1023,42 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 		 * the SecTAG, so we have to deduce which port to deliver to.
 		 */
 		if (macsec_is_offloaded(macsec) && netif_running(ndev)) {
-			if (md_dst && md_dst->type == METADATA_MACSEC &&
-			    (!find_rx_sc(&macsec->secy, md_dst->u.macsec_info.sci)))
+			const struct macsec_ops *ops;
+
+			ops = macsec_get_ops(macsec, NULL);
+
+			if (ops->rx_uses_md_dst && !is_macsec_md_dst)
 				continue;
 
+			if (is_macsec_md_dst) {
+				struct macsec_rx_sc *rx_sc;
+
+				/* All drivers that implement MACsec offload
+				 * support using skb metadata destinations must
+				 * indicate that they do so.
+				 */
+				DEBUG_NET_WARN_ON_ONCE(!ops->rx_uses_md_dst);
+				rx_sc = find_rx_sc(&macsec->secy,
+						   md_dst->u.macsec_info.sci);
+				if (!rx_sc)
+					continue;
+				/* device indicated macsec offload occurred */
+				skb->dev = ndev;
+				skb->pkt_type = PACKET_HOST;
+				eth_skb_pkt_type(skb, ndev);
+				ret = RX_HANDLER_ANOTHER;
+				goto out;
+			}
+
+			/* This datapath is insecure because it is unable to
+			 * enforce isolation of broadcast/multicast traffic and
+			 * unicast traffic with promiscuous mode on the macsec
+			 * netdev. Since the core stack has no mechanism to
+			 * check that the hardware did indeed receive MACsec
+			 * traffic, it is possible that the response handling
+			 * done by the MACsec port was to a plaintext packet.
+			 * This violates the MACsec protocol standard.
+			 */
 			if (ether_addr_equal_64bits(hdr->h_dest,
 						    ndev->dev_addr)) {
 				/* exact match, divert skb to this port */
@@ -1040,11 +1074,7 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 					break;
 
 				nskb->dev = ndev;
-				if (ether_addr_equal_64bits(hdr->h_dest,
-							    ndev->broadcast))
-					nskb->pkt_type = PACKET_BROADCAST;
-				else
-					nskb->pkt_type = PACKET_MULTICAST;
+				eth_skb_pkt_type(nskb, ndev);
 
 				__netif_rx(nskb);
 			}
-- 
2.42.0


