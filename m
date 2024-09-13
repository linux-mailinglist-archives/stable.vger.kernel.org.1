Return-Path: <stable+bounces-76057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC37977E0D
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 12:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495541C249C5
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 10:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73DD1D86CF;
	Fri, 13 Sep 2024 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TEOdKZD9"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A973533C8;
	Fri, 13 Sep 2024 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726224936; cv=fail; b=sNuQGwfux4jnjeQp9KSLJhR7mb9BBfpWXRi4vvqTFzKsj/kWRuu3do/nYydJrxuJ8uEmI1xZAEIn/g/uEVSlhS4o4539vuR80X4jdfzt9Y7xI2WBffKx6u+jtvLn1LW8oppqezSRLi5YvjxpmAi890Tc/UzOtxoC8EKr1lt11Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726224936; c=relaxed/simple;
	bh=QylGNLablQfr3gXMb+17pyvDhVX9JCav3jMXTa+VDfg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CgPGTWvwOCpNqqBHeGz0wjEWbUgIqIlv4f+p0PkqQXSyXmpCE0JXm6CfDt0lozZKgTjBptdJCpMMq/4JpF8oiUcIgzT29fhRhUf6nqumjfyqo0aByMukRNCCPDxWd6Umf/n91x2Hku21scgSIv1R4pHgopje3VOK7rseMUXjPnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TEOdKZD9; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnrhuZ+HQP4xBx4fUzl081j0gPvrH4c8qpFa2fPyjNBO9sgN0cyPzpUPAI/iCrm6shHSTXyUqEU3tYAs4h+2oUulzKN06ltqPuRAgkJdPGycmJn7czrn+e9BivDQumQ9qCwX7Ju+/B4sFG0uTNj8gEw7DB3EMlxDoA4PynfQsWFmsVI3gXrSJQiu3BDHSbru6DYIVk4Tp37r/67z0VkV1rHLzgyrhZll4vfircJ1k1YPlufyXMcWcB6G2v1TcTEBuTk3CBqaWpEtJKLG/KYp59qEGqgdltfbWOAOiyLltdzm/qVzafTLO8GYqG/+w+jl/UhZksED4tBWI1DaIXw7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eo1znd6lWL9yQN7KhhyLBKgAkuEnCXjCKIWw8CUGF0=;
 b=ivR5byDMfkJ4h/1oYVEA6cgj3FaDzgcXZzBB7pvdotPARhF56ryXbV36+rxZQGfaqQfTbAbsUzGqxhPvy4+ytbO0c5ypcHpcbs3wRoXWp0VVMnEv4Pzzf5ur2EB0fmGrPuQF7eKdnEa73T92Sfeu6Ubz75orPdErpPMs5AwR+hzOz0DZeBA0EC9DHzE5lS0Oe3lC4sEjF/v7gmfY3YuVhXKW69tNxO9BJpb2657dxzfB2Jk2ZDSB+mO9SVnhWLuyskNPqsTQhvLcvBRVVYACiRRIjZ3WUl+qUh6QUKzUPdEM9B/jizVNanx5rKefpbvnsD+nDcmeYZ4Crpzc5/Cauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eo1znd6lWL9yQN7KhhyLBKgAkuEnCXjCKIWw8CUGF0=;
 b=TEOdKZD9vHMmPCPcOcKJmonv2GaCs/8AnNv66IRA9HLvolzoUe1QrvegadpHqG68XbhHgpcIHIyiWR4f7LU+14KEVyJNKn9w3G3y5cgybnjX2KWEeGdWQQn4aiIQov601KRc7mm5YNdg1F2TupB3ibZgRw+a+6X7sCLPVpM7I9U=
Received: from BN9PR03CA0198.namprd03.prod.outlook.com (2603:10b6:408:f9::23)
 by PH0PR12MB7929.namprd12.prod.outlook.com (2603:10b6:510:284::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Fri, 13 Sep
 2024 10:55:31 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:408:f9:cafe::de) by BN9PR03CA0198.outlook.office365.com
 (2603:10b6:408:f9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.27 via Frontend
 Transport; Fri, 13 Sep 2024 10:55:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 10:55:30 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 05:55:27 -0500
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
Subject: [PATCH v2] dt-bindings: serial: rs485: Fix rs485-rts-delay property
Date: Fri, 13 Sep 2024 12:55:23 +0200
Message-ID: <1b60e457c2f1bfa2284291ad58af02c982936ac8.1726224922.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1988; i=michal.simek@amd.com; h=from:subject:message-id; bh=QylGNLablQfr3gXMb+17pyvDhVX9JCav3jMXTa+VDfg=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQnUjJZ39bf4RVqPml7Jjsrb2H7XuPl9Qe12t/Ify1d+ X39o02fOmJZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEdtUyzK/MN798u3hj85Js k6/bQ13Xv/olkcgwP1L3D68j1/VZl34wdW7bnZnZrDhHAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|PH0PR12MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d24bf4f-a935-4add-0f12-08dcd3e29604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IDKSojHV3i2tF/Oc5DbEKxXs49H5+J4nRH/cn28ENCiPMa5gwG+1eRqBbqCo?=
 =?us-ascii?Q?YBAW/2XhWpBqhkM31mauRqk7ReOMPmM9C+WuCwu0tOiXXI5yWO7KA5fxEG59?=
 =?us-ascii?Q?11sJMQyHBLLdb9gq5gbqr3maAwN8O/filp3iR7757yaeTRwtXYD2nA0sc6vl?=
 =?us-ascii?Q?V5xy9S6hC8iJZ+EjRgnFxCUI0TQUpTuVP/JIdrVqCXDW4DD3Hy5HaVX9LQ8B?=
 =?us-ascii?Q?vqpT3yfADhV8yXiIXd5DIcjzvW8l1gvtLZtX29chriUTnzxbp8uftUvZHl3L?=
 =?us-ascii?Q?BxxZzisk5t2Q7taccDcCZmkjSKDlL7WPmDw5qknTPjJEeUshLZdMej+3/qdd?=
 =?us-ascii?Q?gn/BvLSKF9+hZMc7rsrB2+kOLoxx+13q9ygekhyikwofTRakPNiB0NQgWCqZ?=
 =?us-ascii?Q?ofneextXvm4fH2GdKHLE5rxazFqMawNk0IiNysauxg8KQsx+8RHUCUHfyu4e?=
 =?us-ascii?Q?T+w+mBAGIj4DxGz1NyeQ4AF7IiUacFqdd867/P9pwAMKEBXBEnpytpnSs8/Y?=
 =?us-ascii?Q?Ked74AC0qEYI4py/Sco4Bz56nkV17OuqSfudyoRWW1DYF11RkUZgG0MKwEo+?=
 =?us-ascii?Q?uqO42w6eh6dIts7HbGGG41+vZ7G9oJvdBnSckYvHLJdYtYXIDQ9BRMDXIJN2?=
 =?us-ascii?Q?4Lkm129McgnE7kqR10E4RIBd/3YcN3TFE346yZnbLhg+/ILgifccBJlHYTWl?=
 =?us-ascii?Q?LvPR130hE/JvD/vNp3lUFSuVASm+atY2taml4l22uDp5n7NjSPu/+QDAuGoa?=
 =?us-ascii?Q?IA3Hrroxu4PggP9+HJKf6/6wvVq58Bfbiuogw9hSePYzOW23HR5wTVdyO09l?=
 =?us-ascii?Q?CA9YMV/Iz6Q3oNAY/9/soW6O3x6eQCgAxdN2TiAG5rW3v/RYjhnSutfVgIq2?=
 =?us-ascii?Q?qQxu6yDC8uFmHj20DeQrianwAK5OGJd3nmempipb19TWuKU/pyuVptEVX1cb?=
 =?us-ascii?Q?6BEqo1MzP5xkqI7Y7yb/Hy3l6ZUuA9DJBTBboMElhnt8wBTRD8RuO2Np+szE?=
 =?us-ascii?Q?mif/i95BGFJXB55FFsEZ78cyqVwsrRxhmFswHJ2Ifp10Bd9NjQuIFvtE5CDB?=
 =?us-ascii?Q?85c846QwPrKqJ/Vq+6OB4qUsss+nPFYbymhCftF+/pZszThoufdYzQHIQeOF?=
 =?us-ascii?Q?Dca/s+QQfbRbSUGMCJOqfSLTLWupfl4Gtww4v/QfJtTVapJjjrkaFCKlFaym?=
 =?us-ascii?Q?b5KxsRYbDWGDXpR7us8T5bCuW4W64Mdl+ePpjek9bV3eJ0hr/YQ1OJl0aYWF?=
 =?us-ascii?Q?BbcCSkB7czPEyjZlfW193q9HDfTZWm0uOzbivI9n7n8xu4r9si163ukZu+SA?=
 =?us-ascii?Q?pskQ5wzIYkupDVK6AEHQVeeByoKmkH7jEFWfxq0dfYeV62dXWd/CXMUixr3E?=
 =?us-ascii?Q?t5W5BrHRkeCUFADRVOZJgYLkEj6Fu8KWibP7qOx2ogR0CssCLgAWbFf7JKde?=
 =?us-ascii?Q?oqlsQA4OdyLNy94H7CpnanIygPOu+Hca?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 10:55:30.8623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d24bf4f-a935-4add-0f12-08dcd3e29604
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7929

Code expects array only with 2 items which should be checked.
But also item checking is not working as it should likely because of
incorrect items description.

Fixes: d50f974c4f7f ("dt-bindings: serial: Convert rs485 bindings to json-schema")
Signed-off-by: Michal Simek <michal.simek@amd.com>
Cc: <stable@vger.kernel.org>
---

Changes in v2:
- Remove maxItems properties which are not needed
- Add stable ML to CC

 .../devicetree/bindings/serial/rs485.yaml     | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index 9418fd66a8e9..9665de41762e 100644
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
+        maximum: 50
+      - description: Delay between end of data sent and rts signal in milliseconds.
+          It corresponds to the delay after sending data and actual release
+          of the line.
+        default: 0
+        maximum: 100
 
   rs485-rts-active-high:
     description: drive RTS high when sending (this is the default).
-- 
2.43.0


