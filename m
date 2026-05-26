Return-Path: <stable+bounces-254260-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC2AOxNJFWq+UAcAu9opvQ
	(envelope-from <stable+bounces-254260-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:17:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9846B5D1A1F
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3119B3008D2A
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 07:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F71B2F8E80;
	Tue, 26 May 2026 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qTBwB20o"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010070.outbound.protection.outlook.com [52.101.61.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC90C372B3D
	for <stable@vger.kernel.org>; Tue, 26 May 2026 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779779817; cv=fail; b=IcGI+AAf/vZLFzgLptsw4oA7U8ZdFAbAMOTrJGPbetcbxErahiI5RjAWDP40IVxbb9h43oWaVYWYihSHdUr/I2OY6OCL5nXDWjD8YQX6ehcgoTLs0InS70yq273g7BpqrkRS4K0gapWdTajoL7dWpQsrqmigOyFq5NA464VzSig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779779817; c=relaxed/simple;
	bh=OpmwKP1CDostTO/1m4jQNcRh9HISqJLXbnfUfWQCR9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFy5i/gRxXnP5vdtYk5Z20asD1X3y1jnosZ0edECilimVUV/9e6q6MBQctKwMdlzYx4DQOQKU1zCH53/xPhNnVv6VCOAon2T6IxrM3BnH/NYOFBCSnt89mRq5+/fWGPxAxHYtDXQadVVpKUGH7o6hioIhP0Ul3qmS6WkVw8nR3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qTBwB20o; arc=fail smtp.client-ip=52.101.61.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFsPqH5eFQdNvUpq61LeoH+oVK1R71sE8GI8SV2dQpucJ72w0yLlwIS/kuG11fz7CfHdXGrJIqSBmpjIj5RAZkG/eU44ichbn+nGM8TTdEGoC010FoWeJIl7+ROS5NxPY1099X2U39PrqeO9HRtZyzq4MzN+Zv76sP0hV3gEI+uMGjm51T9J4eUNuoXQN7Poyq+HWTqpq+LceOsPGmUrtogQLczFOYdwVxCJVsPv/D8QGcXZggo7EP3GXI9/yA4O4fiKqgS/SRKNVu7lzdiHn1YyvH44ZBGOm36xKqQlYf8XWkUw9bnjTAdNuXL+B/Pi3L+Gr8n+B9ryw/xGEA4dPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0yzviac2vq1ATfHaOrvdzhNM0s+DUc9ahCUVh5ASHM=;
 b=Y/t0rTKGcreB+KUx5rLAatEepzL+hP9yJ8LhwpQmMKz4lxv1FOoW/TdcYxJzbHBI8gIdTTLT/gLUqpRQD9VOgNXXMXTB6MT5gOO3jt1l1y2pBiNwiSM/enI2zzrXJJf9erGyiKXrz5zgpp0q+bs4EH8Fy/KNW9HKn/J7Ccwju7uDQabtbDXLQ7ZQyPaCl9pcmZkB1zON+9bvBNOcmUHOa940/XQm2m0wmo+B7klYZnz96vfTDWCzzSUKKh6gszzFORa5X+EfIPhg0fS12aardQAaSf8oUtLwYXszAu9GIU+/qpOdDFDiVVGbrVfv1hyLBwGiafLJsXtQug2G6AOwIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0yzviac2vq1ATfHaOrvdzhNM0s+DUc9ahCUVh5ASHM=;
 b=qTBwB20o9Al0h7usiCOAR6ChxkrjR9ZGswNO0n6JhxRKtPYq5XFK5GJAOJ5yYfAkfP3QDG5gIuRlh1LE5PxMeX7NBiHRMRc7V50ehsefhP5fgwPSuuLqOCzWSPBljjoghcoJBA044051vliaoebHHYK6DiW8zYgd17r+FE7A0jg=
Received: from PH7P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::28)
 by BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Tue, 26 May
 2026 07:16:50 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:326:cafe::9f) by PH7P220CA0014.outlook.office365.com
 (2603:10b6:510:326::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Tue, 26
 May 2026 07:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:16:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 26 May
 2026 02:16:49 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 May
 2026 02:16:48 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:16:40 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, <stable@vger.kernel.org>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 17/41] drm/amd/display: Clamp HDMI HDCP2 rx_id_list read to buffer size
Date: Tue, 26 May 2026 15:01:40 +0800
Message-ID: <20260526071413.2181251-18-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|BY5PR12MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ac042e-f5a4-4ed3-381e-08debaf6c11a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OfD3nlvpuzCH/1SiHO44sXyvZFR4Z9dabcAai+q7P2/5OO05Lp8Lj2bSgCNHy7NhT+WIOXva2TdqVck5tsETEmSRHFdcVAVDp5u9FpmEtRACffiQNEmN7QE6YBJ5uXXveiJQ1LKSZHx1jzr/iK4UR2vy+Cg+u+Kh4h5q+ZaNyIyXLNkG4edmyToYQ0HVvEqZcF3pkETEzk9ZrZKZNLT/C/WHltghYm37EUkhMOQljYcAaOsFiwNAACJR3BU+q6xnvAqdtqxHxkQwu3HfPJX4QYWdFirFjkm809NUMPmkkGgXJL2x7hRZnL2QnbqHv6fv8EGfmHELkZ8jKkd0n/rF0YbDCt5dEV4Vr0YF/iQ3LJhDfgKqUJCQ03Yreb09WroesOAeIGBx72BN6gRe47eJIzQVWmB1uqViRTXoxOW1JgtEpAeUbXWf0/Gg/NfLEATJUYVUEjOU1RQoGWtEDGseRZPYmrBfW3oOY2AVBuM3zZiQtUL+vv3F5opkKY9VhqG0gBGsC2nEHinenLhL21uysWdjLHPbfKDmPbL/ERIVlKg7VC4k7GJlIcn6xHM6WBxVZEkEj01aBLxnAQrXYTYAFLKStrXxJxfnUjOH5W5gyY3BE3Do4wzb7DO4X4o1qdDiLrqXLgWPrJ+vd+C4Lz/7EcjDmchzDREZ9RJLoFt0BIMIbVto4w2WBOMqKMvaeAOSZ2iCnm1Ioj+t/SHelS+MUmZlgULQzpZg8eewzBSFFcQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LakOxn+sbzEVLvPm8nDU6NPaKezFVo5iNhfrkLi1ZAHSQ7XUHfu8c8EMCc4cxbVP6pPIbXkO3iaOyai43WORTemGOzNJohcRaZwkr5FZUujkV+lA1GdKhdszteEq6XoAx4SkKpn3MK2mlN1a4vRSesuLbWAJ+g6DVwJE3a66yJVM+xc8dHNaSkJcn4JIprAfI14KpQMo5NQZk3ksUaC5ZH67ct9fGOURjmcDnlqpRv/+OBVjeU12tFjnmCOcSfAsUXNN4FnifFZ+63TdGePR4BR+Q2MF240JwliIXwxQrh0SW6xjU8R9+W4Px6nB/6/enmIvsSRecosD2K+sGH0aElIXxyNWq6o7ebFGxe4/eimFF9ec0CU+kakYXZqGg86sFh6zmrpZp4ZK6kqSpNQZUvUcHd+jW0lHU6MA2RZ6GJNWTTFucCSfarZ9rcDlo5uw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:16:49.6767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ac042e-f5a4-4ed3-381e-08debaf6c11a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254260-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ray.wu@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:mid,amd.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9846B5D1A1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Harry Wentland <harry.wentland@amd.com>

[Why & How]
During HDCP 2.x repeater authentication over HDMI, the driver reads the
sink's RxStatus register and extracts a 10-bit message size field (max
value 1023). This value is used as the read length for the ReceiverID
list without being clamped to the size of the destination buffer
rx_id_list[177]. A malicious HDMI repeater could advertise a message
size larger than the buffer, causing an out-of-bounds write during the
I2C read.

Clamp the read length in mod_hdcp_read_rx_id_list() to the size of the
rx_id_list buffer, matching the approach already used in the DP branch.

Fixes: eff682f83c9c ("drm/amd/display: Add DDC handles for HDCP2.2")
Cc: stable@vger.kernel.org
Assisted-by: Copilot:claude-opus-4.6

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
index 0ca39873f807..324413a090bf 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
@@ -529,7 +529,8 @@ enum mod_hdcp_status mod_hdcp_read_rx_id_list(struct mod_hdcp *hdcp)
 	} else {
 		status = read(hdcp, MOD_HDCP_MESSAGE_ID_READ_REPEATER_AUTH_SEND_RECEIVERID_LIST,
 				hdcp->auth.msg.hdcp2.rx_id_list,
-				hdcp->auth.msg.hdcp2.rx_id_list_size);
+				MIN(hdcp->auth.msg.hdcp2.rx_id_list_size,
+				    sizeof(hdcp->auth.msg.hdcp2.rx_id_list)));
 	}
 	return status;
 }
-- 
2.43.0


