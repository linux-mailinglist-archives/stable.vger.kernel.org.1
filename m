Return-Path: <stable+bounces-96146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A899E0AB8
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CC31635BC
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 18:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8C91DDA00;
	Mon,  2 Dec 2024 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sZX9aaiG"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22561D9694;
	Mon,  2 Dec 2024 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733163136; cv=fail; b=hURUBG+b8UCbEMo9toZZV8uCXj8v/Xdz384cyTQvEc1GFyVLB/hs65ctq/Hx3JgyHZLofmKQE12Z+AGUYwdEXv//hNah0hiT1ju5x5KSVRW9yOSBykPIhdbXD4lYClQTDbkImrsPz25VQGuPjqakJQJNZddt7HYB8qXYVJ/PQ8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733163136; c=relaxed/simple;
	bh=whXt3smGQXQzNmrC4ki23SEp6otSPeI1Kqcm16mUcLo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y9bhAnApwOjNsG6J2FoMR1reurN69yuYBQUBLnykd45oSS5eXWFCpadN9OFzgwWTSjCPs8awOc3Kn9p/MS8fKQepxVfO3cT17jtTuBd2DCzAKw85cfC+Icl72Q4/TX1nYRtndoQPycJ83XtZlyAr6DqaqOQXWC6KZC0uIJ2qbxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sZX9aaiG; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKPM5LaeTMMo/rTnf5RktM1HXKwFu1DgM6Xx2IdNw3tw6WUJZfu56vdem9Ocm25NCDS7uL6+nPL9vVkHaYV3H9Rhhlta0qhyCx9NMJjhQyf7drOA/dYfoldEEsVNi5Dny53l6UgfnpZOT8AKSYeTstb8Bbo3OsY2Wxq8AAHRB+ZKa92Vhp5MP0hn1chqDZdAO7FZa8MD9wilIcudDnjz4lvYL2FYa0ToP2Ds8gn1tOArULDWUOODCkKg1VzLhcA6Z9PkPfjuu6dk+UTNlsEYNu86XxD9P6buWhuE8p8vnV6GADPgWOBijM6pp2m0LFwvdWLh80p7RwjPShhJ6os5Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2u+KRhwgC9PpLo4ffimzyQk7sng45JvvL7Bf57V0G4=;
 b=jSKXOoSanr8XZ/41nHBfV1P9yL+W6dAb1yI74xSUK+lPhGvngIEqpDoHAkbz7RzfM66sTPs6mK/x1EDrTwdOZJoMbPy2m8lTL8JjbpGmAEeD2GGeyrFw72X3+5iLUwc0GsB1L2Dxt6R8NOt5OV1+gJG/h/j5+lqXbNPUtj1o69wpxNSUYEjGduI0Ww61/vK3AvEzmTyBZ9/xMWQ3Cuuxl4DnuuY/Bcb/+0FW3nXmDTcnTRqD+3SiWUI4qehPF/998RewFo6lyVbSYFOsz4u8KQ4OdwgKQCkUpudxCyEDgMUMr1kpaXT//AWBmHixJjhb494OwB0McBkxmGlBDZoakQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=synopsys.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2u+KRhwgC9PpLo4ffimzyQk7sng45JvvL7Bf57V0G4=;
 b=sZX9aaiGOkC1OmpxYBuUAo7x+EhF2UHSZxbWAisWRlqO1yzZyKyiYfDWXYl0Rv28+Ee+7GOEVJZBNqWgO1Fz2WIk4On2f6h3EV3U0SEQVx8nb0KWqmUTpfY7vfbNn+X3+cbeduwlTflZpKh/AWMrC2ItYQ3TUnk223k491xepPw=
Received: from SJ0PR13CA0201.namprd13.prod.outlook.com (2603:10b6:a03:2c3::26)
 by PH7PR12MB7305.namprd12.prod.outlook.com (2603:10b6:510:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 18:12:09 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::ad) by SJ0PR13CA0201.outlook.office365.com
 (2603:10b6:a03:2c3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7 via Frontend Transport; Mon, 2
 Dec 2024 18:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 18:12:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 12:12:07 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 12:12:06 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Dec 2024 12:12:03 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>,
	<michal.simek@amd.com>, <robert.hancock@calian.com>
CC: <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Neal Frager
	<neal.frager@amd.com>, <stable@vger.kernel.org>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH v3] usb: dwc3: xilinx: make sure pipe clock is deselected in usb2 only mode
Date: Mon, 2 Dec 2024 23:41:51 +0530
Message-ID: <1733163111-1414816-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|PH7PR12MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f5dbcce-fe8d-4dd6-628b-08dd12fcd5ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G+0x3vrlL0oT3OJQW3v1JUAf5k5uQEs7/DTOZwcSzstOH62p89zrHn3rKJl1?=
 =?us-ascii?Q?HQgKfztVe73359Ae3XUhbSyj+5J6NsFyyJ+gpsHZP1raa4GdFUhfX+KbrMzr?=
 =?us-ascii?Q?OS+gSPbiwzeIOTcd/5yg7BZE6csOX6HnJh6z+sPCgLY99IRCNzmiEjTR4vQO?=
 =?us-ascii?Q?DCrrl044yM3rYYUIBDrMhbS+Ne0eyJpM+Q2CoJmp1j0z3dza5fpHgWTCiYY7?=
 =?us-ascii?Q?gIgeMGqG6zgyzj5XQ8OF1/wAJ1hG5a0v2QGTnKxwMEM3u+XlWo6AfwKHr83q?=
 =?us-ascii?Q?0pLlx1jk2w9Hks0iNNId0zeQxuECGRLLmFwlTmXlGca9Di7U0UdyCY76EY+y?=
 =?us-ascii?Q?NxcJbiDGzVU+PnqZyfPIzH6xSLrk7UnQ6bnVQJ7v5zt26q/Ua4gETzQ+zSo+?=
 =?us-ascii?Q?//gv3y9tq74CRzQwFHMSQUM5Fq8HhoO/ioS2YjoZuR29CIbPNyEmF01VkeXO?=
 =?us-ascii?Q?0kGeZYuqjE4l/v+VYxtdnxxE883hVDe56KXhGa+ha28RchoSOzjnj/7Gvm8d?=
 =?us-ascii?Q?AIdvUob6a2vYxm/ZGdOXu1urPFbwxhGc9N/Sd6o7PM9kBO4P5awytztl69Ay?=
 =?us-ascii?Q?I4YUNrGP/5IDyV2fR1NhIZU7NePo4BnGUC9XmXhYUbCtOZa9SrLdLyk/CRHf?=
 =?us-ascii?Q?dyNWnnvrfX9AmCxiCgABPtlO1/bWCFCK4UUPeXMc1rtcZDY1V56FRnky1yUC?=
 =?us-ascii?Q?bPhWMyxMhBwoeFXQO5uMs97aDsYHbBVB7wqWmW8W6gfUKHZL0oyl1xq8qss7?=
 =?us-ascii?Q?Xk5DD1ZLDBf9HGPKN5Y9ZLgkkJN2LE8GUaInN1cY6mK2z28TyFsmBE/sLPFA?=
 =?us-ascii?Q?yDk4CP/FS4ZKf3Fs0spgG6sKAjnLLNzifsJIM9RIkUYktvzr8J+HqVETehIg?=
 =?us-ascii?Q?LNvMN1kfqNrQoG4oh3xT/+RNLaDbsDmCVj1rjyQ21ttEE3/id1gO70JcvY/j?=
 =?us-ascii?Q?luI5h6ITMcfUc5rZ3yYVJrBrFxRU7ic7ydnsQ7MGEDHYFMosIgl88suJKMOx?=
 =?us-ascii?Q?0bEPlpnmQgujU/nuevTBIK+sy2Ykw7srzabnxwWNpU9AkuTgLtll9NbaUOIJ?=
 =?us-ascii?Q?Y+TMr4sLuWcrDJYQMdDMnjDkUzfeZ2+qZh92iD8YG2Veia5fsAuTIT2WnENU?=
 =?us-ascii?Q?v6j+9ycEuaNPIPS4iGGorbnVvhrrCdOmeqnKU2d6vRmZ1e2mTkxEgRV3UyYj?=
 =?us-ascii?Q?jQxYY/+2RbDLzWT1KIJLofkWeAscVQ2Cr5F3VYNBParz//oNEG6rUW/VgP23?=
 =?us-ascii?Q?wdNyzDEdXVD/T1ajbEzni4si4WnABfml24jKeE6P+hU+13PazwcAzdPaglZ8?=
 =?us-ascii?Q?t82H03N5Fyz8aAmrK6oUngLv/ePv3EGAUPN4oU9kv82X5fXj4d436kLyHrsW?=
 =?us-ascii?Q?cet5Pdgzx7suKF5SxWqEu4Ms3WfTKp46XyVHVkYzMQjRrrleYIFlvnamNoaW?=
 =?us-ascii?Q?myMx4Nc6sVvQSolFxALP6oQ1xUfuv+bD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 18:12:08.5209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5dbcce-fe8d-4dd6-628b-08dd12fcd5ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7305

From: Neal Frager <neal.frager@amd.com>

When the USB3 PHY is not defined in the Linux device tree, there could
still be a case where there is a USB3 PHY active on the board and enabled
by the first stage bootloader. If serdes clock is being used then the USB
will fail to enumerate devices in 2.0 only mode.

To solve this, make sure that the PIPE clock is deselected whenever the
USB3 PHY is not defined and guarantees that the USB2 only mode will work
in all cases.

Fixes: 9678f3361afc ("usb: dwc3: xilinx: Skip resets and USB3 register settings for USB2.0 mode")
Cc: stable@vger.kernel.org
Signed-off-by: Neal Frager <neal.frager@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Acked-by: Peter Korsgaard <peter@korsgaard.com>
---
Changes for v3:
- Modify commit description to drop second "is" and add Peter ack.

Changes for v2:
- Add stable@vger.kernel.org in CC.
---
 drivers/usb/dwc3/dwc3-xilinx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index e3738e1610db..a33a42ba0249 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -121,8 +121,11 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	 * in use but the usb3-phy entry is missing from the device tree.
 	 * Therefore, skip these operations in this case.
 	 */
-	if (!priv_data->usb3_phy)
+	if (!priv_data->usb3_phy) {
+		/* Deselect the PIPE Clock Select bit in FPD PIPE Clock register */
+		writel(PIPE_CLK_DESELECT, priv_data->regs + XLNX_USB_FPD_PIPE_CLK);
 		goto skip_usb3_phy;
+	}
 
 	crst = devm_reset_control_get_exclusive(dev, "usb_crst");
 	if (IS_ERR(crst)) {
-- 
2.34.1


