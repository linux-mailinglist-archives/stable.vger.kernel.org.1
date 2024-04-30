Return-Path: <stable+bounces-41778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22E98B66F9
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 02:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891B82838B5
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 00:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B3C10F7;
	Tue, 30 Apr 2024 00:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mw3zNlhC"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84591843
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437842; cv=fail; b=MyItjcpC1lAxpRvMoqendJq+xxRRXygnwKN45FQrJXMyVRyojzxOfNOmlWJUl1e4v5mYIMeQXEi2tgX4ZGf+57CbosHuucIAWGtm5LYBG9cAf+SToG2RXa8M7T/4VmrHOnuozu4vaXl09FK4z65wiH4J/d5RbaLOTB0LPHMSMQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437842; c=relaxed/simple;
	bh=sWyMGg7ErpIroyIQoJldWJGd2do291eziClBflbrMok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DuHN8hfy/V/OgPd/rLAXb6I1kovCtKEqo1Gw/fhR3mU09k4ivGYFgvINMsX1mZGWT8xiimBt6AXPhETuwP5YxYimHgDN4c2EgVEoUtOfPzXD9xb9vOAciwu5HztszxqYbIzgGx3O6jEnUw6lq5h/vAz90IRZ4HAT9nqJE0XqsQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mw3zNlhC; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZF7pr4H3ZpXV72ceyNDz7O09J4vBRlgd4fz9eF1SdBjz9uxuu2wj7Gj/DHoSa7IryAUpV6zlXjeuoWH+b0UweTAP+7XliC/rtOjC5oflR6xG6npRSAwY0jXPOCmzdxFaFtKaAZjcXqt2Mhq3659DeGDuXdUBgYrOlFgJFuvxdMgfkmUR0K4+Ql42CsMGEZLKmR9D2dpyRIJCH+PXghmdlA3v/JtO3ndtHLpJRxya+VEjkG9NeTR6Rj7WLEo+jfCPyE/HOQ9gUUBLZQGbw8TBtd4PGKEWVFeQOGeZ7wYwnWkly3mmIQRSNUyM5qP1AOcTzVu+X7ypM73a9QFvemMRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxtiVm3fjPtOYo6Qh0IyJzQ0bjnsQKWa3wAUZD/YYb4=;
 b=OZ3Uxrf/LunKXYeywkitvRzdLbF1n3Z4sgsDx5D9AB5hsdmtrHOWWhpQsiXDjXYgG7aL4R2tdIYwAYmr4Pqp23wsB7C16opKdH71p5WigqFLRpTRM1eH8n7+CUcaWRV2brsIr7vATK8e5DVrh9rkIxrPEfW6xsJ9jlt57xgF7AlAJ+B0zDG9zCHlGWwPS8u8z4V2k19krtMA9C69l8q0EgihLLOsRpLdMN5SyjKR9v1UbmQs2aNrJ2egGc+MBYulBuLPwZGj3FF4NN2w0QNo+fO5kX1lEfQ6P5wt72f/IHFAADNVBGEsqLBVmVQBrTUtyEJLUIA6KkVE7QxehOJ44A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxtiVm3fjPtOYo6Qh0IyJzQ0bjnsQKWa3wAUZD/YYb4=;
 b=mw3zNlhCcX9pDjuD7rGhY6DwaI6UWlUvQtrIE5uep7aDVtlZQS6V2aPkiAEOiO2LmJ04p9AHMnsAir1KOhLBlqZym4J22nCAV5Zt3NSmaV842Zj7fQEM3UHqc7br3cL93jrkHuepPTsjPePLJeEVtQ1Wp1dlX6vUMCR7Tst0MuHaSvXqywFeMGMxMDvHkDaOVh1ku96HMEG17BgmIOl6KHUGiTcohgKSYgckNN2xYbUexfgH4JzTJN7lbusLs7V7hNZU+6UHIlwkuTbdmbpwTtT8smanWdEeXkwzwDfW7yw7s+S1jVrYrzr8lI7sokQB4N+AtNB6xZYEOW4jnicKvg==
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
Subject: [PATCH 6.6.y 3/4] macsec: Detect if Rx skb is macsec-related for offloading devices that update md_dst
Date: Mon, 29 Apr 2024 17:43:04 -0700
Message-ID: <20240430004312.299070-4-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240430004312.299070-2-rrameshbabu@nvidia.com>
References: <20240430004312.299070-2-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::19) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM6PR12MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: 856f8a6a-0854-40b4-7d12-08dc68ae9b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bf/pC5y1mpxvt/8UL/lvbHP4RAObxkvC0n9LU/vPhfKk85fhKqV199F1gbWr?=
 =?us-ascii?Q?fWEN+CCTnGyhNKMdCiz5SBSl7IfbZANDjq3CtZSSBC7vVs3HHZP8v4pu3N/h?=
 =?us-ascii?Q?BITufWiUwdr6eAZ5yoMxC7okwBOczVJg8NzJCPk29HOTEVrhsZJeAKI4UKI4?=
 =?us-ascii?Q?dF8oEeaF/TkpMfVgI3Fqi7COFVIIy9jpu05nkzlWbkc+KvOlamfw6NabCebE?=
 =?us-ascii?Q?eLVo3dL5g3MZzUv+jPVOO6/NS0feeVXF4e7HNKyEuQpKmn6xxzr5f4rsw958?=
 =?us-ascii?Q?jf/j8/zbO+cSR/HaQtxcqCtXVEiQ9xnUviaD2Lxc9toUCcfsUJSujFAY7RTS?=
 =?us-ascii?Q?nB+OFavotQ7MfK/ddxEyl1nAKnAcflA0q11k8Zn/dsXJc4O9Gi1OST6T0KM6?=
 =?us-ascii?Q?f5mVulcjS+ySeSVdkqsTAfx5S4I930Fn/qq8eiOZi9zIHGMlzDS/Sr7rp057?=
 =?us-ascii?Q?1K4DFeANNBZz0kwkm/r5jIL0j5YAy6/0Sb4Mm9xl73S7WW04uP50Sn+gmxNB?=
 =?us-ascii?Q?1UvMMT7Ujti1Fo90O6Spl/HtGm3q+Oz9ESJaUMxoFmgkMfm/Sl6lq9byGklp?=
 =?us-ascii?Q?NQS3RDTbUILZRwqY7+phMM7Z7Ck6tmS300s2esOIub/Qzui8Q+cvHg+Imr/U?=
 =?us-ascii?Q?PwQVVPByEQqLqEGpgRxmYshZ1wLb+H9NHNTrOWhI3sT4FS8pmiMheO6WtRNc?=
 =?us-ascii?Q?m2JANTuvTk4tFVlulasczoVW3Rd3YRnRFjZnr2xnk6kQBuROOnXGSSZysG6+?=
 =?us-ascii?Q?VGhiICyPHo0FGTlHokK5NS/jLPkX8p5R/f+o/RzJYTMFtBhC645gtT9FG3t8?=
 =?us-ascii?Q?JlFBwM1ZZmHhDMOj97lfVMSjDocomtr6D3MFqOaQ3T+xHJhUIBrQQsROuGUt?=
 =?us-ascii?Q?9ErHGwzVtcgW+Ygq/tLzN9MKm0a/0Gzoblbhb/kJ7D2dyuXz/+RfaLv3TPRU?=
 =?us-ascii?Q?eXi9vLNri9FR3K3umyvsOWFjmzoxs3axYRuAoE9POvsuUUkzexEmdYS71RdE?=
 =?us-ascii?Q?FijlIrCeM2KKof2cpUNUL0bKcVIPiQhb3HJzWwRM4Q95p8V8PD9rSqlf3eeO?=
 =?us-ascii?Q?NquxYyOuN3D2QfwEmhBoKcvcuC0r9JhXjXHIYHAbSAHe4xHUzC3y8lIJrbZ2?=
 =?us-ascii?Q?bPPFM1E6RWanU0lvDAgVQrf7geLM57JX+V+/SOzFhGSHvdzk8Sl5CeQUIixQ?=
 =?us-ascii?Q?azMQa9TxNPYf8aaZLDQqT0cl+dMpZqIqIMLoqis+nFSzAB/yba8Y4LNQvl4i?=
 =?us-ascii?Q?DZ5gzlfdj7ITfpbZOV0r3gXmi9hxCpcsY3VbI/Kt3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WY8cyQZPHzdLQpvCOmh218+1WAskkq6mFXGTb6BerMBejivdH8+uV8Iy8/1y?=
 =?us-ascii?Q?COd1pr68Ha0xoccY8DGeCs1GEyEsOCTjJU/qZP7MODVhZp84tTOyVZziDrvn?=
 =?us-ascii?Q?UdvFq77eRe2mOyKzKDQh64TT1PJQ4uPpDV3JKeQ3UhSdGGZ3P+xEhgv1DtSn?=
 =?us-ascii?Q?zTGCowR+pUA1ETTHhOrPn+pjWeJL7NUsfVBw19vHAGUm4hrbLeYsE2XDmlak?=
 =?us-ascii?Q?oyQpUa0DmYecCnGoqrqlYZ2kRNaJctzNwiXygC2NuFbNDkX3z8cQcSwqJQJ2?=
 =?us-ascii?Q?TqRzLfXO6L8VnGOxnFMgmFkQ4VisKEdcs8/HSmBmmgOrgc8Kke6ze/kMZZDo?=
 =?us-ascii?Q?LzWYbPtNRrf/0a9377lVAsT8eGj48TKGQYHbbCUeC+XZQIaEqB+uvdhDGgQk?=
 =?us-ascii?Q?Z0jsQZAFrwfLeCRBv+Q8GvFCgwXsR6G4B/q3fX1E04twT5ccfQvRcrtO7Jyu?=
 =?us-ascii?Q?0xBqibdnTj8aDs2i8K44y/H5bVm/xsiMX/v/Y996k7knI7k0alj/dZHzDqEl?=
 =?us-ascii?Q?c51iigx2utIa1WvyPjkbYRE4osE4NBWF0xHH4CK/Mj99VcbPMKY1DT+mhS47?=
 =?us-ascii?Q?pd2pgCcgIkQsrQkJPxCL1n/ip+lOIllYplLfVBVuDR7K/58OXKv7ytre8EXG?=
 =?us-ascii?Q?Fu9IRiDwHzzK7md3tEfhI5PiRSZxQIY8RCBB0hlOhbJBsvbdpYIw92QObQGB?=
 =?us-ascii?Q?fmbx59S7cUL6OxAaotfR5Cb1fEaLZUd2UeUmPpVazxZFZXyDcC2AIQd6GV1f?=
 =?us-ascii?Q?wvtsW5cF3qe5+cjEtgfcc1Vm97hgYip/T0285noWZv+VNflSf2ZLArGCd4UM?=
 =?us-ascii?Q?A7r+idCOimmPe6tjBtA2srd/uD7UTGj3e9NwANgf8m/6qlxfZZQwB9UQJYuM?=
 =?us-ascii?Q?jvKUb8h5MDBjSZAguAgdH1GB01eelTkNqhJNqvdbgY2OLoZZlMB8HQROixv5?=
 =?us-ascii?Q?pIOgBftBBCbeivh6EA9NbAtlzwFeB1x5thg/w/cXMCmSD3zkUnuzZRYvCh0N?=
 =?us-ascii?Q?2G5D89V9rH7yymmCf5mKcAtvX8D6WsJXgMUVmEltjMHxWprm0nb3zdimUzn5?=
 =?us-ascii?Q?dQ5qiRJ3rToRfbnIYATUopCTo0NxgdxYjMrtUtXi3soLTEn63nhHsksSqTJf?=
 =?us-ascii?Q?ItgAxJ3gr5Ap1ZkXLY5TeX2/7w0c/Jo2BE0Mwk4HaNg/o4nUm4ZDCE3rsGcg?=
 =?us-ascii?Q?5YuDkIQD5vWh9+f7/mCxlO1nAORtL+uj6uC6cWYIqZuq2yeCH4KJifqakUd6?=
 =?us-ascii?Q?d1fqRQPvPR37HvgTUJbVJQU3EcoiHbcrv3aurMPuaMYoeLn/CW6vkdnn9+RW?=
 =?us-ascii?Q?piVz+yaHPMGSdkyxhQ750jmRewe0j8fo0DZxqaajnXd3M1Ii7uoDuOV7YruZ?=
 =?us-ascii?Q?9+oGirei8pKYk8TfkIcwAUPhG/JIXfJ2HFl5Nuv0Z0Ip4bQkcjOG2tSQRopE?=
 =?us-ascii?Q?QvLaZeYuXq12bS73GtJn2SevEvP2AN1lnbGcdlWeDj1uTaRHldviqW+vjReb?=
 =?us-ascii?Q?zXEW0rq6nwiHzu2Th6ACpLYMYdwGY/Uxp9kZSmlAZB/fXtMIdnRPkqL8ULmv?=
 =?us-ascii?Q?aHJmo6UwqRlwx0wAx++fgWJVkYxvUqfv/yHiALuhic2JJ8KHFC7xv9MVWgkf?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856f8a6a-0854-40b4-7d12-08dc68ae9b75
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 00:43:52.2658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8fSkUsYr41Opijte7dmUYKRkn40pmgJ0yi39h8s0sM1hbVrqmt9vaBj6WjaYGklQ+BJQ7J/RgJ/SCNjsV8FLg==
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
 drivers/net/macsec.c | 46 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 9663050a852d..778fb77c5a93 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -996,10 +996,12 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
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
@@ -1010,14 +1012,42 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 		 * the SecTAG, so we have to deduce which port to deliver to.
 		 */
 		if (macsec_is_offloaded(macsec) && netif_running(ndev)) {
-			struct macsec_rx_sc *rx_sc = NULL;
+			const struct macsec_ops *ops;
 
-			if (md_dst && md_dst->type == METADATA_MACSEC)
-				rx_sc = find_rx_sc(&macsec->secy, md_dst->u.macsec_info.sci);
+			ops = macsec_get_ops(macsec, NULL);
 
-			if (md_dst && md_dst->type == METADATA_MACSEC && !rx_sc)
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
@@ -1033,14 +1063,10 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 					break;
 
 				nskb->dev = ndev;
-				if (ether_addr_equal_64bits(hdr->h_dest,
-							    ndev->broadcast))
-					nskb->pkt_type = PACKET_BROADCAST;
-				else
-					nskb->pkt_type = PACKET_MULTICAST;
+				eth_skb_pkt_type(nskb, ndev);
 
 				__netif_rx(nskb);
-			} else if (rx_sc || ndev->flags & IFF_PROMISC) {
+			} else if (ndev->flags & IFF_PROMISC) {
 				skb->dev = ndev;
 				skb->pkt_type = PACKET_HOST;
 				ret = RX_HANDLER_ANOTHER;
-- 
2.42.0


