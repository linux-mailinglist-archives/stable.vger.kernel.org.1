Return-Path: <stable+bounces-55830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D24D917B55
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 10:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028E82844BD
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 08:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5229416A37C;
	Wed, 26 Jun 2024 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f9NFJUZm"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BFD168497
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391757; cv=fail; b=t72gURkQeExj0WMyWU+nJujttUm55SZqnfqsVj5YRDuZfxqwfKTHQ2UQJZM6R+OnuJ+ftTFewQAynKJQ448h3+IerAm30689G+ixSOLQd/XFNh3BSdqJSroj5pkqWrvlE4DzIcK/+krrSDtaOo1HXEVB4BFzKSMZBs9Y8mEioK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391757; c=relaxed/simple;
	bh=uLRjLOA3FSQ6VlDfnNIvrHKAJGE9RL10B0JyUr/iOGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaVazxk0oql7LZu5sqpWx2rsl3LBVHV8pTOESIuXWarmwo6o4YfMDFlcOQHmlJofm33NYyeT38YhSv1thL5HtsRrVHuZDJM/j67UMqicJJGRj65tTJG+ouhGJL4t0rTzefAiAPMqtnw64lw9b8H1QlMM+cPwr91wBSUr1jz+VDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f9NFJUZm; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBIP2w5PMEpZwIHmBOiImrNxwZqB8xZ25HOnMpPqhr2z+STNbN4DdaDoyNG+iRFDGE9V1TdOkONxA3a/IQDyHynNmKmQ+8aXlJfWuq6ntGwuKRj8IWg32OM13NHELnNL68IxQkQ2LUkFRatxe8ufQI2R2+vZ8w3UroSNnTlUYsPsz52mBscaeiiHQWoa3qhbjgoQ1c1zRQAws9IcZiFIUlmmNAaU1yTNrhG767PT5jzwyYzaYcMDtJffFrv8z9laZ6Ob9AxOOQk4eaMDOucAL2n/p7/HuguzKxSrJWTjx0MBnN8aK5C42OQ3Onqb8DA0ML91+o8hDDlh/bo7puCDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgXrJ/U5xkSIHrJJV/Fa3UKRnhMG2KkqaXAgNm0n7wc=;
 b=B9VnmwLKEtlQd6FSwadGqMBMazz4A/+GIOlYq/oq7Ln92raUR/9d8FauMzDPK0ZTrlz4wI7MWErNTz0894F7c+INe+2gd+geamxIbbmbVK+Tiis15u1lOqTsEXrSGjrobaMTPfruwvcYD2OLKU8tILA4Lz+yXljX5POEZO3x77gpupr1LHjGtlroJZPySz9d++v06nP81hGhtzHCJBCBZfjV3N61JoBKbHddEuAk5HXPjD4cs5GO4DHS70+BzfqBhtweCiTY0y9g/1ee9BgE0l+i906syRcZh0t0CImiDDgCEGDwPCueZnBs6GIYKbnlkD0GWPjCpKCIZ8hhfLNJTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgXrJ/U5xkSIHrJJV/Fa3UKRnhMG2KkqaXAgNm0n7wc=;
 b=f9NFJUZm4x7MxEHACAh/JpCXJmlKlc5qcjF4rLZjXraTLcr96OKV4cyicGwR/Z1SNBSB3zlSS8JM4ybwl0WC+2ZFi5ppKV3gcoQnvaTEFDX/+pMXzfBtf9Wr7PWDVgImykoDxT4swB/VQ8Q08L8i3qJ9hbkr4NVTuCkt1nH7PHc=
Received: from MN2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:208:239::30)
 by SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 08:49:12 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:239:cafe::34) by MN2PR08CA0025.outlook.office365.com
 (2603:10b6:208:239::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 08:49:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 08:49:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 03:49:10 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Jun 2024 03:49:06 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <lyude@redhat.com>, <jani.nikula@intel.com>, <imre.deak@intel.com>,
	<daniel@ffwll.ch>, <Harry.Wentland@amd.com>, <jerry.zuo@amd.com>, Wayne Lin
	<Wayne.Lin@amd.com>, Harry Wentland <hwentlan@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 2/3] drm/dp_mst: Skip CSN if topology probing is not done yet
Date: Wed, 26 Jun 2024 16:48:24 +0800
Message-ID: <20240626084825.878565-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240626084825.878565-1-Wayne.Lin@amd.com>
References: <20240626084825.878565-1-Wayne.Lin@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SJ1PR12MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: bff7334a-12d9-4658-93ad-08dc95bcd9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GtslV3eotBhlvYLhMa1lP1bUqd6e5mPYdPYtk7roFKqq0TV3aUI9GRQAUIPN?=
 =?us-ascii?Q?RvxTz1GIenTN9j6uQ+CBzcCbv+d8LRv3L0XdqCwmS9X82nwEsCJXtle4oqLx?=
 =?us-ascii?Q?p6CcawEqrH0zr1QHJPrK2/aHO6L99vNpyeDCxaKhOq+/9MkNHKmiCt5YycE+?=
 =?us-ascii?Q?UjLFwqmyBKdPRhpNa8U2SvZsRtTbbNCBMXl8Sqp+HIwyZlTdstENlrrJ4dP7?=
 =?us-ascii?Q?ydLtqol65wyM8ZA/NJ8hl4l/B14mx3uFAox6AFm7y/dHaExgVWCNpzwLCBZm?=
 =?us-ascii?Q?YrWAGCHg3NRyVTidEtWOIrUSGVCTw3WZgQ4+f1z+LbNw6fiKxz98YjPHxriC?=
 =?us-ascii?Q?XlvrUF3SRgi0Jn2YKs2p28w/5h9irCpw10Ryl1ixPn/JYzn7iKU78H7YNPq3?=
 =?us-ascii?Q?dtlb97CRLxRpuSvrdIwRzUjjYfE4xqY7xvCHhmiE/xevEX9HJiIYx4myX6JC?=
 =?us-ascii?Q?YdqmBW/MoP7sjpo0HBwr8kS8iJr2eR14WcbU4bCxxJhY5HUq+Ha+mO5k7j/n?=
 =?us-ascii?Q?4I9UUqw5MK9uqr4wyp74K2tYL1pPlIhRP4trpmEbxNOMDOk+cZWVeXdq52wV?=
 =?us-ascii?Q?NnVJn0ZO2Zj8UCMASZwFwJOV1kgZFyJbpFqjQP4Fzn5yoHyM7nu8Za0bYGqs?=
 =?us-ascii?Q?ZlGa/8PZBQF8dI1lTXkFuweXQsL9+FYNFA+bbU+nBilE0dgdOfbsRUJmeFCc?=
 =?us-ascii?Q?6W+3IUxo8qQ1fFHCZl8x4KWVmoyjv485aGDtTr7K5eYWxwyqgZetQhpj/9ra?=
 =?us-ascii?Q?rtQNcjlyOmgXUGQgL9YovpPnFDFZAtw6S+4cYRaDTtXxHvXaX3jX6Nh1r1Hw?=
 =?us-ascii?Q?u4WQshpqbG+9WGk7FsWHL3xAb6Rx9ADplG/wWKynkda8YZzovHfRdg3L7P0i?=
 =?us-ascii?Q?GV2dbpaccFJ7guGYE+LdB9qn3o6L5DZo5wOHY9aQE1oHfG2dWRhWUtazTFux?=
 =?us-ascii?Q?RalkgAwfm+jsnoakMIGI8R0Vm1SvNUqEt51MFSre1x5E290w/NS3G5lzu1gn?=
 =?us-ascii?Q?t2t2KNbr114yFesCSdvEGTN+kjC0YhfAvR4YLZ4fLmpty3TxncY3dYfkgkNo?=
 =?us-ascii?Q?wCMqOz8HRJZE2m/VgGkkx9Q3nUcUbwmiJLhH+nnq2AT5DtV3mKPW7ZIlqRP+?=
 =?us-ascii?Q?EcgfGRstuNyUkwVLiXLiVDpEug5S3xHpOEZNA1JweHZSmHGMV5bGsLq/1jvH?=
 =?us-ascii?Q?dCIc6gYR5qOg9ydVK1KDLpkhs01Gt7gaTpP76YyUaXZhNenawfyD3sUaMAT1?=
 =?us-ascii?Q?2Sure2O/LlAo1em0qcwqHjhL6dG3aZLCgxd48sOzXmPVaytLASr15MIBORUf?=
 =?us-ascii?Q?aSKrL2YIma9uqJqYpgKKXA689+6hxZH/cDylgNMko4zIYrjN9zGFGBDgC8wM?=
 =?us-ascii?Q?GCEz+cIhnNFPn+NQkGRg3eI594jlQSZWc0bKMZcidA9i7eYlwW1aruIBW+6X?=
 =?us-ascii?Q?wCOplejyf52Jd+CxI46C8V81pOPNxmL/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 08:49:11.6818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bff7334a-12d9-4658-93ad-08dc95bcd9a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051

[Why]
During resume, observe that we receive CSN event before we start topology
probing. Handling CSN at this moment based on uncertain topology is
unnecessary.

[How]
Add checking condition in drm_dp_mst_handle_up_req() to skip handling CSN
if the topology is yet to be probed.

Cc: Lyude Paul <lyude@redhat.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: stable@vger.kernel.org
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 68831f4e502a..fc2ceae61db2 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -4069,6 +4069,7 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 	if (up_req->msg.req_type == DP_CONNECTION_STATUS_NOTIFY) {
 		const struct drm_dp_connection_status_notify *conn_stat =
 			&up_req->msg.u.conn_stat;
+		bool handle_csn;
 
 		drm_dbg_kms(mgr->dev, "Got CSN: pn: %d ldps:%d ddps: %d mcs: %d ip: %d pdt: %d\n",
 			    conn_stat->port_number,
@@ -4077,6 +4078,16 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 			    conn_stat->message_capability_status,
 			    conn_stat->input_port,
 			    conn_stat->peer_device_type);
+
+		mutex_lock(&mgr->probe_lock);
+		handle_csn = mgr->mst_primary->link_address_sent;
+		mutex_unlock(&mgr->probe_lock);
+
+		if (!handle_csn) {
+			drm_dbg_kms(mgr->dev, "Got CSN before finish topology probing. Skip it.");
+			kfree(up_req);
+			goto out;
+		}
 	} else if (up_req->msg.req_type == DP_RESOURCE_STATUS_NOTIFY) {
 		const struct drm_dp_resource_status_notify *res_stat =
 			&up_req->msg.u.resource_stat;
-- 
2.37.3


