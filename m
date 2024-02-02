Return-Path: <stable+bounces-17669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E69D3846F12
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 12:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB9D7B21CB7
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 11:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A1213DBB9;
	Fri,  2 Feb 2024 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="IKlQdwE4"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2136.outbound.protection.outlook.com [40.107.220.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2265613D4E0;
	Fri,  2 Feb 2024 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873873; cv=fail; b=pB3MkRI2B3O8heLsCL3RqyTQeDcZ1E2HAZovnSvlwzHdujcGKnEgF1Y9HpEEzU+SiKeOUqDEbp3oPTRSr/e6HygzZB3dma4QYrMnCjYipr3P0jEQAkW2tb9Ivwqyblk7/z1AW2JSrBHL6jXlEfd3xY+v95eUiauXgEsiR+P/87E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873873; c=relaxed/simple;
	bh=kEwq2qL+BfDEayPAuD/dodl2Lg7SpUhSY0M9b8GahHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jEb9fFWJ9VFF+w6gYZmRfokxFIPDH+L+0vHSXvk3OcKktMIu0z1zN6mIGMwaliVjCX4owqYKsXn/yg3i+ctKE/TyX/boxLBc1m4Q+qajSYnw4OIG33Vr9IB8m+EmW4QU7OrGl/EV1f4WGJCmWa86V/dx0gocKFouKB0lGiauu8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=IKlQdwE4; arc=fail smtp.client-ip=40.107.220.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGTGvZnBXkjUBIRMDiaHz3Kl4ceASuhU6gdaQQ/D7XNMuwbPEmjTGjdin+OuE4U+Aohn6L++FKsKO2AGY04VRYxFq+cafyvs6sTq4wgYFO95zf0qDFk/lsYD+97WVoq0WywwABS2cOlJ4OrKxcwDHJLLoZyjE2hnFYg2wgFKHufzj+BVhACHXdHTaDugjlYQYL2jQXkuRPavUaH2qu765e7QvPTsc7NPk5panTU7eqKPiI9JGcMUXh5Oc4JW2eEPwRmER/QVgMPxZJZNEaGDIgrnk1w2qzzuaLGYs5ffeMoiko+YGmfKRwuJIdkbvaRuhZQ+zZKA+EQcbPBl6q+tpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyTJuwV6BXlZoTMQ6lZauQDBgXqUOtjGzkERhO+NzAo=;
 b=PZ04NYUYbQKFLvTnCoCHaUfhIQ1reT6ko8VMAfF2v2M2kHaw32zWN1vSeQjzXeQdFY/n9OXIkdEZtqEVw5SYnvCjTqMZy8HIiOu36CxQssiM9GOyN5B2LKMkF2E1dUhrqzv5c2XQuMHu7XoUQ4ytNUDzt+xRf4BG5mVjfGPEy3cbBkCrz/65N0474hCby2oDoxOtATMSRUc95zAGG0WYSIfZdJH6lpbwXWqyEpbeJ5RN/rkbT43arscBIE1QYZA/HGRv9ADBWdXlWyStHjED5PqkkK7n7ThlBE75kpDS8N56NZJ19V8jU198I4mGFsQeROcyqWVul0ioF2Wa4/qqUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyTJuwV6BXlZoTMQ6lZauQDBgXqUOtjGzkERhO+NzAo=;
 b=IKlQdwE4ymNnxxRUZdtcDP8lEMOvlv8AqDLcTr5qNdNXYJOzFzGIvrWt8wA11loLMr2WbkeHsLfryPqf3j1TfHlkkf5UsHO5Llu37OgMjx2vMeTnQRoGre8lVgrpjgEA5NFC8orlZw7YSW+5dPQQtqLGjitCvX7R06ZlJhOn1RI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
 by MN2PR13MB3853.namprd13.prod.outlook.com (2603:10b6:208:1e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 11:37:50 +0000
Received: from CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::a58c:f93f:a7fc:c3bd]) by CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::a58c:f93f:a7fc:c3bd%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 11:37:50 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: James Hershaw <james.hershaw@corigine.com>,
	Daniel Basilio <daniel.basilio@corigine.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net 2/3] nfp: flower: prevent re-adding mac index for bonded port
Date: Fri,  2 Feb 2024 13:37:18 +0200
Message-Id: <20240202113719.16171-3-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202113719.16171-1-louis.peens@corigine.com>
References: <20240202113719.16171-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN2P275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::27)
 To CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR13MB4411:EE_|MN2PR13MB3853:EE_
X-MS-Office365-Filtering-Correlation-Id: bca6e2a5-ee3b-4bd3-e0dd-08dc23e36295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o65jxrtEH/48lHaHGG7+CE/U6xWLj83UdpwrZO4wPMnqZviH3GtiIBSN3bof2r5YIWBk18b0MjxVuUD9NKFiG/P/kgZdJGmhx0rkYjOuxoU6Dt2qRTDuatYDptqz9Zk6k4y4+2Nr28UZ45djg+DIa8vvdtFzEs4Elw50VXambsiLGYca95Ipxe+IG9Ge7cyJYAKpYR8Fg9if9THy69Fy6Ietjfjp4ZTKKlSapoEhGDoIxH+HDxXtk52A5ncwP8+J+fvKA7vSw/9vz5JUeGQPtc+6suHgTWMeMXD8s1zbBSyj/heU5jRbxfmdXteJPC4GcPWOSEVNeM2yi3Pfpih7Kxj0kjMvi+1Qc2BYcZcVyNLCDAiRksH0CEptBSi7iOpos4qICU6+z4WRv8txTZ5i4lFuA+hoDiK0oH8T6ZyB4kwEuexGtTUrioGZZfgbNi/uO9td+/icXAM6BHXdDRXT2PCLiDuxFJzZ3b/gt9GeR4cZoECWBufRykvqd8ueycEjiB7g0Ms2j/q/1BNRt+eT4wb8zT5NupDuSYfJqEu6cVQT2I4q2N3tS/3xGZIzYlo0zBORnB0hR6FcgRhrUK9PFXzybzvrhNFddLNLlVOey7+MLQcF1BuIimocmQJ+LDGy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB4411.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(376002)(136003)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(478600001)(110136005)(8676002)(83380400001)(66556008)(6506007)(6666004)(8936002)(316002)(54906003)(6486002)(66476007)(26005)(2616005)(6512007)(107886003)(1076003)(52116002)(41300700001)(2906002)(5660300002)(44832011)(4326008)(38350700005)(36756003)(66946007)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rPrM72i/OIrUL6Pi3XHjjcpwj0sf4uq6EDUE2U6B7SGb/36T3I82glfaaPJ3?=
 =?us-ascii?Q?XB7J3imk65eYm7JuIZjHpX2NeQHbFoVhfWzmqLwxR+NjePDkzlEplRbgJOWy?=
 =?us-ascii?Q?7rWZge2+FiX+XQDnvb+7lZZq45TchKVGkROrc7CxRRprA78f+/8tDthlEnzj?=
 =?us-ascii?Q?AMsF+h9loXXM5jwzXZQ4BqWCl2MDK9jWYmUofJ+eaimJfI5QLnq5LZV6h0r6?=
 =?us-ascii?Q?6K0+R9XrhT4QZxdmBkIBqmWuNOzrYJsngUgJLRQ4u2Q2pHFteos39nxZhZNb?=
 =?us-ascii?Q?9p4Mnw6wBG8oTplAoe+E59rGXQ2lGMjWkGoAj/xvvdxG/7tN3TzZTh4tQJ/L?=
 =?us-ascii?Q?/kFwKNXR7Oz0RDFo6JRgZkxLNkBSPhWBu1sCSEPYFGfkag8W0xLk1kqSYFZX?=
 =?us-ascii?Q?9E6pCdvNkRDoixeT36VbGLWFBeaNc3C22BKUsocNM6/ANamQq1KaVDOjGw27?=
 =?us-ascii?Q?HPSlmoprI2YsCv04tXE9y50aLes4KxWlQbr8JQIc7zgaPpi1SoRng3/27A/8?=
 =?us-ascii?Q?wfqtMlMFozjnqAmtu2qCQUbTIH+q6HLK+CWcrDSJlFNJPl7shmgvm3N0JzCp?=
 =?us-ascii?Q?o83fUro+8jkbF2NAZGF7IC/cgz/KxCQxHoyEonjBecuFYbPmMnGVEx7Han28?=
 =?us-ascii?Q?zcqxK+zaVu3s+fK9JqJR6WPALESPwatICfl/4EGSHz02SxM0PIfYYMu7CbZY?=
 =?us-ascii?Q?dYqo23lQL2Gor4fvQQ/huZ3+/8X7Zm55Hw6dqE3uVwfr0AGGl7aY/sKj2EMK?=
 =?us-ascii?Q?usL26UutrSp6De1Z7Y2/qy9jrZFekifD7lSEmtoUgRc3gUGx68Z+JzkJB/lV?=
 =?us-ascii?Q?4U6DXOR/TJFBhsiG9P4xPk3/BrC14/KQmdiROy8AczGTkqB5k5XAQ5o4t5ab?=
 =?us-ascii?Q?XO8suUT7WADUp69pG7+Uqf06seq4dEbPmNCbkhlOdQ9ZHqetGbdo0aKMx06G?=
 =?us-ascii?Q?i8AmXqPVlsh8bc93v7n8+3UtNRlG1XUe7ph0kzmmgEbOJjtylnK0HsMiZr9r?=
 =?us-ascii?Q?LsAZZxpiJ0hmdbI35T2fjziQkUlaOR8G3c/ij6UjPO0it15SLueiu6H7yWG7?=
 =?us-ascii?Q?COQPpKXVIZxkK8MlNFMkcJQU6v8R0ixfAfE9WzllLifHZLqZICylvfSGjEJN?=
 =?us-ascii?Q?6f7j5FrsVuIV1us1+qjhhVASRfueyP/BNjk8gNe20eV0yp5Mi4fYdclFgV9X?=
 =?us-ascii?Q?s1kExxIB4Wiu+9C0A+UGJoh3chpZoIG0fmA3HBIytrp5N2EM+drzo5DZQY04?=
 =?us-ascii?Q?wj/i9sg7FJW/aMUJItqqM80tr458GFegNhaZZC/y2CEurzv77kBeWBc4N/RY?=
 =?us-ascii?Q?ER6ZcQq7JxALfTOdY7tD81iyl7lfBRXOdfOfnr5cfIK4ExolmY4t+3hEaLEe?=
 =?us-ascii?Q?BvPF/cwAHPl85tbZvVnK5qhMwS4/A7bgQ4UZ+gLcZa2d+KheqboP6MueJ+ej?=
 =?us-ascii?Q?2lA3YxVcv27deGL0gr9Jmt3jC8dvitrbJ8b0DVpLdNMt8P+WccJgUovAWp8y?=
 =?us-ascii?Q?5shKATyIFsMVc7O1UipK/UOQrlkbdQxtqVUSyaaDuxyrgzwNIFsvstUeX7rU?=
 =?us-ascii?Q?JqWzxDDsC++yB0czcPmINZzg/7YHlgRbr9G6Ks1ey8nvd75hNHFCgmW2meRs?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca6e2a5-ee3b-4bd3-e0dd-08dc23e36295
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB4411.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 11:37:49.9278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPx6otPnp/Fr86nf2IJEV4jfdewWYEiKAN1HiCMntsbH69pU39ZdbN3ikI6gGVPNFZNTbzBMSWPw7mBLTycNoOwlAXK4OKXqrWJKZr7uNg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3853

From: Daniel de Villiers <daniel.devilliers@corigine.com>

When physical ports are reset (either through link failure or manually
toggled down and up again) that are slaved to a Linux bond with a tunnel
endpoint IP address on the bond device, not all tunnel packets arriving
on the bond port are decapped as expected.

The bond dev assigns the same MAC address to itself and each of its
slaves. When toggling a slave device, the same MAC address is therefore
offloaded to the NFP multiple times with different indexes.

The issue only occurs when re-adding the shared mac. The
nfp_tunnel_add_shared_mac() function has a conditional check early on
that checks if a mac entry already exists and if that mac entry is
global: (entry && nfp_tunnel_is_mac_idx_global(entry->index)). In the
case of a bonded device (For example br-ex), the mac index is obtained,
and no new index is assigned.

We therefore modify the conditional in nfp_tunnel_add_shared_mac() to
check if the port belongs to the LAG along with the existing checks to
prevent a new global mac index from being re-assigned to the slave port.

Fixes: 20cce8865098 ("nfp: flower: enable MAC address sharing for offloadable devs")
CC: stable@vger.kernel.org # 5.1+
Signed-off-by: Daniel de Villiers <daniel.devilliers@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
index e522845c7c21..0d7d138d6e0d 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -1084,7 +1084,7 @@ nfp_tunnel_add_shared_mac(struct nfp_app *app, struct net_device *netdev,
 	u16 nfp_mac_idx = 0;
 
 	entry = nfp_tunnel_lookup_offloaded_macs(app, netdev->dev_addr);
-	if (entry && nfp_tunnel_is_mac_idx_global(entry->index)) {
+	if (entry && (nfp_tunnel_is_mac_idx_global(entry->index) || netif_is_lag_port(netdev))) {
 		if (entry->bridge_count ||
 		    !nfp_flower_is_supported_bridge(netdev)) {
 			nfp_tunnel_offloaded_macs_inc_ref_and_link(entry,
-- 
2.34.1


