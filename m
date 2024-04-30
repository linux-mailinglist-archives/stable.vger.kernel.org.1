Return-Path: <stable+bounces-41776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5F38B66F7
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 02:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4E528396F
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 00:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A37B1870;
	Tue, 30 Apr 2024 00:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D0CTWiKi"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFA210E4
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437838; cv=fail; b=b6kHtZDbMXy4xZdhuSJnAI9pxWGyPUUfaJ1wGiazsAvP5AAPvobmIwE8sgZFL3m0JD2iUYnNSr9a8zjKJ69BBzJ7X+VopXOWa3fq+f1wjQpJeBhw6FRQVVZ2Cg9BMNMDU8pn0457taSG9qJcc7iGBkAi3hoQClqUPXStWk6HT9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437838; c=relaxed/simple;
	bh=bCqSjxTFxE8q6PhPVpsk8ZFl9lGdwoG0XFOfRI4Gt54=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=K8YTLzO8hXs/Kgo6E0wIhsxwKsakjntVtMqsl1T70Rq19Onrd/I8p97fvSsJ7ZFBFnX8A9AYAXOfgu9b3wuyEc7R/R3IzkL55BD5kNbYtfuWT3nGOfF/TzMz9HiU25kwXd/y7OoGt4zq7CLPDisjS6PdmN/xNB4Vg/VkH7QCTwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D0CTWiKi; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEeyI/bacDw4glvDSUxujYcW3beRR8kVN7ujWrNTR7APgBHStk5GDqc9trl9RC13hayWTKAPGnq7YKnz3YPqyUgeHiRpwOBV+GQvA2rLnAYsBfwors0M9uzM+AtlnURckN9q/UbooazyXRapnZU0nS0/cS5MIfX3XmTdGcUJCMj0G2eFN7HOA8Hb4APEgK+fBvh5v1s1cTn3r8VWeQ/iAVOv6rSiTvDI6FlxzfHCvz1VHMGJ7LCArgxx4wZsxhLOsrgiCWRe3B4XyO0vz6qjMFpW1V54rsgn/G5eGlHFYYIZdqF9ljI7Swc/6rcJzKN4HLRZ7tWSut6AbE5G6XuvWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UV+LIxLgjkgwe57F8qjcawHA3/89Pn+7fIWxfs9w+ZQ=;
 b=I+Wpx+xVjKX6YKLKq5vB6u5nHQd9GvKrIKL7K+lxcuTkNO3LPaLR5WMOGL0WTbKQgEd/aVolqrGQtkyJ7rAGNGLSCEK4806+P3voce58/VUD4lb0f1HMp4tdrsKISh3slihJKglInnU1yuv1oWWz4qWzf+viVNIRb6CnMglBaFd7OAxhDj6ItOL492N9i99rgDLzpFSMJ3qYa1K5FcjwkZ40Lnkw9Rsv22GafJ6KkpVmfa9i7z2mzOQ0I0ExNVu7pPvcECFnK3TEUvVU/bi4yZ2X4MPtEh7rDz/G6kKNF0q+XiDjwdYVpfcmnHiDfEeJE3H5dV2Y4N3HWB98+MIn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UV+LIxLgjkgwe57F8qjcawHA3/89Pn+7fIWxfs9w+ZQ=;
 b=D0CTWiKiyfoepWK8D8/bUHy7y/5lD8nM2XBS4QdsJA9zohVh4mC6Wdu/GRmhomqMuZtgaAAArnemMJJ2Vr8VIoMLoG053vyQyIWpie+HzVh6xIP4kuMgzjvuYnPhm/dPeFhRZGPirjSMXvm7Bo1esD7eVJZGvWkgQkzrtYya+gMIwQ2nfRnkdXdEfZwdQ7BQLbv2YETIXi+SGFHIIp7xbH+aqL+XBJosyQmFkMSM4gHm/TAFc76wC9qN/tpbDf84Xxvk3QBQUtesrMr9f811urArVppoghbqIVjBq12ad2nVyG8twRF5Cy1xXz2zX89bfZKga28lxRuNv+foZxS9VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 00:43:50 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 00:43:50 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	bpoirier@nvidia.com,
	cratiu@nvidia.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH 6.6.y 1/4] macsec: Enable devices to advertise whether they update sk_buff md_dst during offloads
Date: Mon, 29 Apr 2024 17:43:02 -0700
Message-ID: <20240430004312.299070-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0020.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::33) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM6PR12MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: 15dc9ce2-2916-49a3-7cc3-08dc68ae9a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0WLoMihA5IPnWxjIllrU/YVPwrBl8Yq7/uRr14nAqMXuIFD76CkWqLz1/KOY?=
 =?us-ascii?Q?tBWMY1rvegbIzyHRoV2DR6K/VlFtu/dhIok77IO/2GAzpmNKB+M7IadwowKl?=
 =?us-ascii?Q?wSHC19ZOrkwAM1pb/IJbw6usQ/sZSTtgcobo/a7tncE0eVImt4s1ThKJ0On0?=
 =?us-ascii?Q?LEx3AFMYgjD5d8Q7B2dnqnhUOLuii5Q+8FwppFwHWQbdvrMwB71utt7J19bZ?=
 =?us-ascii?Q?NCqfAu/gv/qCAODT7l/7Fxuuvy/sQ62NRzfs9+096h/K2a8xW/qoryfttY3N?=
 =?us-ascii?Q?QwlZhRueYUgX4tGBjrgU+EtVDUZsYniB5NbB7oMPtxs9q93KR2DZyZq8v8Pz?=
 =?us-ascii?Q?Fdxfe6phvzXcE0fmbqja18PBNB5ToRZJF5XRWWHmXGubSlgF4yXKZ3SddqTH?=
 =?us-ascii?Q?PI1TLplu9fQ5VvU7r9BVnhhuLBYh0SVPpIfLpuiHfggQ4xLDnbPBODceo0Vl?=
 =?us-ascii?Q?mbgBWFcb8P3MWj/utsruhZhR/oOG39zAma6rQSz+71Wn32yq4LtzyveM6P9B?=
 =?us-ascii?Q?j65wXQ8btur54T/x1Fv8V3/R0dygirntf7Gw9Ovl1FRxfgXB8JJ5XIaxFXZ8?=
 =?us-ascii?Q?F66luFF1fYYST7xa7xFE9jI00E9F8kWJILqX7Qbh4yyzs8D5ULOEd9LqZs/I?=
 =?us-ascii?Q?AajWieMR502ssYDQj7uequXvLRJMHgHhya6VkcGN9Q6mmM5gp7jrGCjly9+6?=
 =?us-ascii?Q?gS7WiqOFa41K28qf6UsZiqoZbMCxJsIBzHbLQkqyvnNrqURBas4a+H3Uo0Zw?=
 =?us-ascii?Q?FmFcguH3Bcwak7skak2IwSDTkssNvh3u4cG2ir66Ko0wVTLRhl1kJtvdrAeG?=
 =?us-ascii?Q?wyCE84yD8B9G3ezdYTljzTwFnjndWpSsJ9xLmlURl1QXRqvDF/0M3n0ZVZaO?=
 =?us-ascii?Q?hTmuIDgvwixeBQEDGm33cVqp91i3+5zFu6rlQNzZnzmzal4R0+04eVvT0MoG?=
 =?us-ascii?Q?jEXYiUbboNDFtDliuiWDSusqF/O2Zmmh+gbkEm8r8zAqZpkVQ2umpLFv01RE?=
 =?us-ascii?Q?tRe7BZDTYCmgOO10GaAoEO6T8qD51LXuXUyMClvFz9kt/cdubkAndjUWpy82?=
 =?us-ascii?Q?7qblHHP2wgEo9zxxhXOc590AYO9U/sOycg+Hpnme2Br/dVy3hVOGCAgzIGOj?=
 =?us-ascii?Q?AxQtD6n03a4WiRkbyLLr12o4mNcnj+JHDAkLUzYBJJpiVrJY0AJhfBHAejZy?=
 =?us-ascii?Q?05nbQU9rm/Yn+ieprSzWJV9/DeoksSVp4Uas/o4aGD1CjnuCedurSh4EJsxn?=
 =?us-ascii?Q?4BB3rBMvDW5k/SO4HunwgO2HDpgNiqQnZ3b+M9clnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qOvKUM88GggySH3k8/S6dQfIPGerBjSNYloMh9F6++qLMrjkRHFPib1WEyvV?=
 =?us-ascii?Q?bqIGHR6zxTDGYoRsfFzJao73lzWf8R3Jur/RU7+8WMisvIENL4Jw7uP2mnQo?=
 =?us-ascii?Q?2UdGv0BZH7ONCa4KlFLimNWQ4ukX8U63tRHt9999lSzDeRLMQfA4vbGb6J4M?=
 =?us-ascii?Q?vCA1RnaUsIx66Dti8OSpV5sRWisuOI0gHxgdQMEX+peLGUl/ZxQaQc42nJ5S?=
 =?us-ascii?Q?9Fi2XXu9iLfSiCOK93sEWPLS5LezkrXrC2OsUXb4p+tYd0hnbfdk1Z5xsbQ8?=
 =?us-ascii?Q?CbxxueSuFYb8jctHp4+L95m4trBqaE1md9Ad1qWQEinbjfSKv3pXoR+zwL7N?=
 =?us-ascii?Q?07zz6if0QhyHvbosGxN25oRPu2xpbmd8ty9QyAw2Lx4phz//y05wehtMuF9G?=
 =?us-ascii?Q?iJ7JeEHXj+yaEj16U2bcsq7guV8BfM5uQQJNv5IUZN94COPFk+9Reakm+OTx?=
 =?us-ascii?Q?bQY75zp7Ta9qvzlPHvBGn2OAbBrTjVkWNjPpYdDWS/83EBFP9tSe1c9btDiF?=
 =?us-ascii?Q?6C0i7QALa1pNxS8WPnRjlFSLHMVWd9kGGcXUJWTOdGoBRH7cw/vhgQ0PQEfM?=
 =?us-ascii?Q?XOa2RgjmtHeuy4Z7XqVG5m+SBUTr5OY9s0p8s2TC+PYdpQM2oETo1nLW1cAE?=
 =?us-ascii?Q?UCVKFbHKdAH8MPhxNTNImi+w9fYhHTtODk5ND3s+mOdErPBW4BqmSGXoscgB?=
 =?us-ascii?Q?sDLRSQLhv4LjJQB5XyCbRAmDQeeCiqi7U2NQfQ1hvhbc5hnaVEyXyAoKaj0N?=
 =?us-ascii?Q?zG36YmKXYkk2m+Bx/1ITbEyWWPjvE9a2S43AKdeGJfLXpCFRAeSHxD2nFGAq?=
 =?us-ascii?Q?FDsMhGKnDGJ8LEaX4Yo2PD3UsgvPV32/ag/uq92lVd4pQ2YFuzw8X4xXSIi1?=
 =?us-ascii?Q?/XDfpigo5veqsCLDQzJ2IcvEH7t8kOAJ1Jt7CEaaVFzGQc82HYDekDz2j9Ux?=
 =?us-ascii?Q?5dFGDvZAnpRcvGk7TeP+pbDxRXmbHjYSkPaWmvRYZFF57AErsocrDM4zSGQR?=
 =?us-ascii?Q?vhqqpPkgg3uU9SZiyRW54g9zcBHIW2doCC85Qq/0020UMq5kQ2Bj8MnimJBZ?=
 =?us-ascii?Q?BQ2wvLu5QVI3kU7P+88LEKC67XgJ7CBAQ6GNx61seD66DMS5h3SnRsVb4jGO?=
 =?us-ascii?Q?MM19kA7YRQMALxtMjvkytoS5Jug6EYgqDDOJ/qBhw89Mi/ghlcl3/cii2bso?=
 =?us-ascii?Q?oXBS9Q3pTVnp4aM9preHZlLsqpX5ryv0Mcws3YohN8UTePZHZbV6JCCPkT7Y?=
 =?us-ascii?Q?g0ZibRhkso/WyILzfdC3LSYeCCvsdES/+R/2LQVZLGJ2RzpAu79iPGZS78Qw?=
 =?us-ascii?Q?9HGkaXo1b3AlvdXrCJVzHkD0XGKvjE1WkGaxz2VJ0e0DQ6305+4SXnC9KFEH?=
 =?us-ascii?Q?ZGF+6+Y1LjoyI8gUkbEQw/t7Qqapft4HLk0ekS4/dgSBx22JbAN4fvmFpBmC?=
 =?us-ascii?Q?2GeM5x07irj5TXiZeS06Xspzf2D1bgczARDEyPHQIbJ/fLPskMUYUXT/kzXO?=
 =?us-ascii?Q?5By9HfJD3J7ioINt4CGxNqMIJhnkneD2LS+cOZk7YPfYjmXmPdyKmApXNZqN?=
 =?us-ascii?Q?w74sW+uHtQhTRygVvTzqxvqCK9K1Qy0qRHKNRqC1woBP8a3TX36MZhWNXKYU?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15dc9ce2-2916-49a3-7cc3-08dc68ae9a58
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 00:43:50.4065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OEU1NlZWBQGLj9ckTujxWlHufzRlUiI6h95Xps5roc/xKmUkyrtOd1vTUIcS3OHhU+yiuK7Kjw+Uuv+FU8m+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468

commit 475747a19316b08e856c666a20503e73d7ed67ed upstream.

Omit rx_use_md_dst comment in upstream commit since macsec_ops is not
documented.

Cannot know whether a Rx skb missing md_dst is intended for MACsec or not
without knowing whether the device is able to update this field during an
offload. Assume that an offload to a MACsec device cannot support updating
md_dst by default. Capable devices can advertise that they do indicate that
an skb is related to a MACsec offloaded packet using the md_dst.

Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: stable@vger.kernel.org
Fixes: 860ead89b851 ("net/macsec: Add MACsec skb_metadata_dst Rx Data path support")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/r/20240423181319.115860-2-rrameshbabu@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/macsec.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/macsec.h b/include/net/macsec.h
index ebf9bc54036a..75340c3e0c8b 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -303,6 +303,7 @@ struct macsec_ops {
 	int (*mdo_get_tx_sa_stats)(struct macsec_context *ctx);
 	int (*mdo_get_rx_sc_stats)(struct macsec_context *ctx);
 	int (*mdo_get_rx_sa_stats)(struct macsec_context *ctx);
+	bool rx_uses_md_dst;
 };
 
 void macsec_pn_wrapped(struct macsec_secy *secy, struct macsec_tx_sa *tx_sa);
-- 
2.42.0


