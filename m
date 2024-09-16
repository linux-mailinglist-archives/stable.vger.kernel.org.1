Return-Path: <stable+bounces-76205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CBD979ED4
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 11:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB164284807
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 09:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E59114B965;
	Mon, 16 Sep 2024 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cwf6HcyN"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35991CF83;
	Mon, 16 Sep 2024 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480544; cv=fail; b=um5FKYndzgqnwc4p5P5+1Eqz66lDHB0QQlsL6K1idD2wOPQOPEWwyJTEvg+5XWd5JDI8tH/2hDwxJDyaMsZFO0nmV8LFSiaKXk++cq+83vAPEOkcL4pU431qCNLTn4ea/alCW8on+RL6+MUwROjOZnbiAxNAdRYNyIhTvQVvoWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480544; c=relaxed/simple;
	bh=N1tm6HN4zEU2Hrcj6s0R6d6MUIeyLXPUfa67sqp0koQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tKCq3WrQBlgejpiZwtoZIrMR8KLrUrRzeAv6ijB4s5grpf6KEMHtPZW0LvhOmFkGXSwDhhcp15+bxoK7KJiS1EiIwutiUUM5uRir6Id2vjFCrbUZPin9TEDZxTMjphJx7axtk8FJP+StlNmH+8rtsDLVh3z5WS5Y1xs63C2mLqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cwf6HcyN; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/PijElXJUIjeojEi6KxbM1v9qy/ULNiuLxFE4F4Tna2vNOvHNWOFHr4pYYWRLWI3/refSiA53y+Dl+H3PYzN4s3IRC595hzyKz+pSS5Wbk8Cm49PTE05Jlx7uzj1V+6+kMKvVE6aZrF5VS53W/utrXFv++UglNh1zwGMADhQxXIycF6zDG31Sqr02HhnSWKugvcCABLT/8gONoA2blg3XCkIPVKHNqcYA9C7qCXvKDW4jewmojqE58RfTztIdHwf9InEW3SSlXrbvHNhoD/xDjNnty+fWUbOY4iLlLaqh7/PDiFJfLfW5rxwlj33m5QvzyIk+24PjSiruTv4EdLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TktiFjuu1K/f/0IVchAk0yvPcb7wzMAVWame4/lAKJA=;
 b=g2BQufVWKaY1cz7sILmcHFYDsSnPrrLu2fMdFOrYf5zpiQFrvwfJ3aV4ZbT/Gs3jDGO+/VpuBUuhlumCsiT+SJnoXeHdutw0JMx9YZ5tF0aaMPrX8mdABsu3c82Yr8ZMAXQRmRydPyc2yXP+iQ6WlfeFmaozCDDtJjS5m70tQ2Cc1svTEKrmuwvvt/k9spcvzB7vNMo82Zz8dYQ5ECYzQ6Y/QNXLI9lEbrWKuazyTEd/AjS4DBZQIucMMKQE/vJ1ysv5ANq1iuCBdADH+MQsFT/uk8KmJ3tb166E7qASdaPEF/gDPP8D26nl/vHR0XWWXShjgC7eIqiguOx9pdB6HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TktiFjuu1K/f/0IVchAk0yvPcb7wzMAVWame4/lAKJA=;
 b=Cwf6HcyNt1L1Z516XPrHjPFk5mhNWdMflKAG23Tl9iHJKZDZqGtOkrYZXAlDaS+4+2lSta9aHgtGyk2BEkW8uCQDOfaHdCyMFWhq5X9qC/snSUeHiI5goll6C1uj4CCtPLDuWDDDG+aw/pGOjQEPdNeO/1w18vLcXf5avHLZGU8=
Received: from PH3PEPF00004098.namprd05.prod.outlook.com (2603:10b6:518:1::44)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 09:55:37 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH3PEPF00004098.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 16 Sep 2024 09:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 09:55:36 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 04:53:53 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: <stable@vger.kernel.org>, Benjamin Gaignard <benjamin.gaignard@st.com>,
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "open list:TTY LAYER AND SERIAL DRIVERS"
	<linux-serial@vger.kernel.org>
Subject: [PATCH v3] dt-bindings: serial: rs485: Fix rs485-rts-delay property
Date: Mon, 16 Sep 2024 11:53:06 +0200
Message-ID: <820c639b9e22fe037730ed44d1b044cdb6d28b75.1726480384.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2095; i=michal.simek@amd.com; h=from:subject:message-id; bh=N1tm6HN4zEU2Hrcj6s0R6d6MUIeyLXPUfa67sqp0koQ=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQXDMwqk1fdXWiiXGkxKYw7JJNJ9lf3HYEW+8KITX8u+ 86+1Xa6I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEykpYxhnumKu+Zbt8yfaXK/ 6fbDa90dm1NFfRjm8B77d5jhtLYM8+XY95NmC9c2rJt+EgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a66ac1b-805a-48f0-a03d-08dcd635b6c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YEQqtxm+c5E4QoP95o3KkiKyJauaNRvMJxi5mo6zSf2JBjAsG/Csyc1PNBvP?=
 =?us-ascii?Q?nBF/J2liQ7eRAn1YGaHh5UEv5j6vfUVmLgyVjK6O6BYUSLr9iF3wVMdK+i8Q?=
 =?us-ascii?Q?6bp7GzIRUliYAtE1G+JcYvSLxACUo+x3s1KUYAVrwWzlWPtU/Q7qsp+n57V/?=
 =?us-ascii?Q?ofTawMsloVUsj7Yw6h0DPKk+p3VSxhYckaoujrM45v3OannRjuTNXChe6Nry?=
 =?us-ascii?Q?mOgUujPZ5aFgqR4VA82i4nia+k9VwR0u/vQyZlLw8EdGB/uaWKlGOdwW3eCk?=
 =?us-ascii?Q?8gcSo1glvrQrUccInnoQS1KL4gjrHhGWnSs9J/cH2kdVZ976TVwc6Op81ZTh?=
 =?us-ascii?Q?XxL6ww28+3DombPLPG9aeSyCENFPapwuYENmvOgwlyEIjwEO6kK5UwhUbNIS?=
 =?us-ascii?Q?jUvn7gT7XfXAy1WmkDsfpXMJTDgHs7IIwdHecYEjn6pbqnmZnS6cpcj+R/Db?=
 =?us-ascii?Q?o+Kdb/RIOHx9U2Vs9G5P8eX2WrBJMt9AdMkn+mmc/jTADF1ZZcqKcixpE71g?=
 =?us-ascii?Q?Wl6yv2JT0TPB7TgchqUzbdhhPSYEjRYXHBKll93Z9XI/eS3Ht0K/x/HMJItB?=
 =?us-ascii?Q?5dB38AESDLMQ+aYGqqNsVPcFsvfu//y8e30W9w7kGocjv155caXSu4/nztv1?=
 =?us-ascii?Q?J4SvWsX+0aMu4Vaeeh4SLmsmXtfmx9NMHiGeWKFfTUp/xxH5eoJFONzGk5op?=
 =?us-ascii?Q?oqXr9kPlcBlLwMcLq+/QG/C7Q5k0DDSdHdg/Jv8rFdAgrmpWguEpObZLugs0?=
 =?us-ascii?Q?78mw+EJssmD8yRsX38Vj09PNnHZHJysabDcNeq4kw8c2WfPTMPucgAwL36uM?=
 =?us-ascii?Q?j7Aw2QNxCtNG0eYRuJr1wH6oVKRsE/Q18mFyRo+7bsBIS8pkNmj0lJW55HSF?=
 =?us-ascii?Q?fO/6dYuhrhQOIXZDEKSHh4NVGKNyG4qxY3KQ/A1mtuT27P/HvgDd0rLOImkm?=
 =?us-ascii?Q?gKFVcJIZ03Jeeh47MqzE3vmvOucqsn1Pa+Mu8WAKCslQwkmV3Pya9X4Nb4rH?=
 =?us-ascii?Q?qCgoAhrgjv7BDNVZpWzw5uax6q5afDCDPwnzbPbVqLsuAJ/zO/Tcpm0yIHmi?=
 =?us-ascii?Q?c5pMV39+B4fNd43fj0cuavRmYppYjBDPbC49Oo9SwKxV3hL7CRLzd71Qqqxc?=
 =?us-ascii?Q?7JGAcGKgBr0Ws74JPvVNgPqihZStRYaAnyUwPXkFD2Tq+o3ANJkWx701a5I0?=
 =?us-ascii?Q?i2LAjow3yMlpe1YFdTp7Ul2k7Lj890q0ZvRQyZSFyw0Ev+emLR5Paz3cJgDU?=
 =?us-ascii?Q?vC4QbOiqfxl4iZ1Fw2UrR0TDnK/vQ/UtaRg/c6kpYKgmQLUoFhtnORpYAuBS?=
 =?us-ascii?Q?0zE9h16vc8fHdXU5pkXvhidUnkVUMlLPL+mrLg5XcKYdBq6lVhU3ALPY2PJo?=
 =?us-ascii?Q?0hTvTkObpiNqkH7SWIiYW3ZchtqdIuO2uDoxvE629FQy2yvFGqUdg6VLTtM3?=
 =?us-ascii?Q?UBI6FZU2PCYEIMqS9oZEGGh2eY4edPHo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 09:55:36.5011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a66ac1b-805a-48f0-a03d-08dcd635b6c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101

Code expects array only with 2 items which should be checked.
But also item checking is not working as it should likely because of
incorrect items description.

Fixes: d50f974c4f7f ("dt-bindings: serial: Convert rs485 bindings to json-schema")
Signed-off-by: Michal Simek <michal.simek@amd.com>
Cc: <stable@vger.kernel.org>
---

Changes in v3:
- Remove incorrectly assigned value for the first item 50/100 because of
  my testing

Changes in v2:
- Remove maxItems properties which are not needed
- Add stable ML to CC

 .../devicetree/bindings/serial/rs485.yaml     | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index 9418fd66a8e9..b93254ad2a28 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -18,16 +18,15 @@ properties:
     description: prop-encoded-array <a b>
     $ref: /schemas/types.yaml#/definitions/uint32-array
     items:
-      items:
-        - description: Delay between rts signal and beginning of data sent in
-            milliseconds. It corresponds to the delay before sending data.
-          default: 0
-          maximum: 100
-        - description: Delay between end of data sent and rts signal in milliseconds.
-            It corresponds to the delay after sending data and actual release
-            of the line.
-          default: 0
-          maximum: 100
+      - description: Delay between rts signal and beginning of data sent in
+          milliseconds. It corresponds to the delay before sending data.
+        default: 0
+        maximum: 100
+      - description: Delay between end of data sent and rts signal in milliseconds.
+          It corresponds to the delay after sending data and actual release
+          of the line.
+        default: 0
+        maximum: 100
 
   rs485-rts-active-high:
     description: drive RTS high when sending (this is the default).
-- 
2.43.0


