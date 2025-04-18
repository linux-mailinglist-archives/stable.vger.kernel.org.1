Return-Path: <stable+bounces-134534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB70A93442
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 10:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71FC1B658A9
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 08:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE2826B0BF;
	Fri, 18 Apr 2025 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gK/C2za3"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93CA26AAB5;
	Fri, 18 Apr 2025 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744963969; cv=fail; b=GXB0j2ut5yawVSBI2UyEi/WKQp6IRg2nNcVrr++9JIzFmiSwipSpmK3vq6XBCiDHowUaNmsaPD6WUykGrsa2RAEsL7TUKQWSP2/KZnaD43gRQBo8yPy15k+S5hjZ4Htl/yjZddwJwaeUMHdnUFmIVk7ie2EHoZzs+zcMpCpatbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744963969; c=relaxed/simple;
	bh=ddwu+v9kT+hApwwXJqxOjhnLngWZ1BgpzNSgZjoqoe4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NaFnx9FxRTY+pRaK51gmy1yqcpJUl9LIMFQX7Y8/YlAVUu2NbRBtDG+JD1LmDjOiLYQ/h2wybc9IE5xveyW04ew56/yGHob4jPp90T+/ccRhnMayHdhizNpbsRgIAmjAplVKpFTTvCB/3m6CPnQKc9Y9rTWKDyXg8v+9Y81WyZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gK/C2za3; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6WuLN+XjnUjB+JKYDpDXxl2/CNvqm/wsQpaIn2Cl9S/bkB6nO1KxU1HDtLORB/vwiRT9w7AIRiA0IJpKCrwR4hsfwUu0rvumey5yASnF7wSu9IEN1ITAJ4kfTJt7RVoJJ5F2jOt4gV9aMhD2SBXBPIMfMuPWwE3C2buoeHL8P1D2iZoNEWjEstyaD3SpL7XqTi0o/AZV8CeYzlFr/wf6Cm0JwuAr3zhIM0hb8Ve8JZwtrQJLX/LWUerz1J/BwMrbz6UhhX6x7A3jV9bTxa3QcyJDGaefnZc0LvIhkzm+uCvOX7HQ6UR3MjufHRf0xJgM+GgS/9vsf9eX8xncSKHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkqE60Oa4WBIVu9h/HvFBCrQWMaZ8qG0eoCVKfT75l4=;
 b=aoHEHumU92m71vcadcWPfxbCG2OO2BXprt6Xmd+ahzO5lNObgb/I4bUtiBfwOha2IibuGT75tPc8b4iDrTIwFOXKqD+GfvnrP04OriRWTB23NzLtCsw3+65G5HcYJyakidxLAD5WVxhVRY9OnngMpON3zXuH/yDBOxEcCsZZbXrQoqScH9008KbjgmBJD0kG2UeLs68RBXuS3cKzP/+NhvITWOh/nEOQVec84EHMJBmrq8VMX7I2OzkZjI9bnhsswAjNGRHAPsNK1y3uw00tx9JlfQdIP1VlSxfPAwyaqdtOEGjyodx9ZEhybHLttOGFPIgpRcnFCbUn+OwEDxNPxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkqE60Oa4WBIVu9h/HvFBCrQWMaZ8qG0eoCVKfT75l4=;
 b=gK/C2za3kyttw9aXJZcx8815yEnnQtnQHcZbP72KD9JQL4HPbZVhE2q1YTqqpnfsOrLrb9AiGgWXMy3t+oclkEV1+DvMFWK3yALiWDKIhLCZfGynqNTjCvF9puie/dnNRbFsYKBPVoi7XJ/Bq+BteSDDrWcxtOBolVVjNRE9ho9gSIAltNThOeBM8rxYd5Okpg5U/aPLGCIHlF4ici7m7zsIF26kvHIZOS/OF7bwt35mN4MKjGswIn25E0niAHr3Ruark4QMGhp/MOBTjC41VdSehOeapXcvsTRYQOw7WJYfM9v1Mh90IM7PLKlaslEWk97CMTHKMuFfOqhGRyue6Q==
Received: from SA9PR13CA0127.namprd13.prod.outlook.com (2603:10b6:806:27::12)
 by SJ5PPF1394451C7.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 08:12:44 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:27:cafe::75) by SA9PR13CA0127.outlook.office365.com
 (2603:10b6:806:27::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Fri,
 18 Apr 2025 08:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 08:12:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Apr
 2025 01:12:32 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 18 Apr
 2025 01:12:31 -0700
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Fri, 18 Apr 2025 01:12:30 -0700
From: Wayne Chang <waynec@nvidia.com>
To: <waynec@nvidia.com>, <gregkh@linuxfoundation.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 1/1] usb: gadget: tegra-xudc: ACK ST_RC after clearing CTRL_RUN
Date: Fri, 18 Apr 2025 16:12:28 +0800
Message-ID: <20250418081228.1194779-1-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SJ5PPF1394451C7:EE_
X-MS-Office365-Filtering-Correlation-Id: e978edf6-256e-49e4-43bd-08dd7e50cbd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?445AVd9nOqKC8iFsDDkp62MZ+9161lgd17JjSKzAF9JgoKnP/T+/ZZiBA2mp?=
 =?us-ascii?Q?ifE4DCDVLX49kPnvgKPiuZfEmNVPr+s5Oz6k+5jP22ohT+bFO/3eJFSXeRzE?=
 =?us-ascii?Q?qvgAAaIew5Ee6/00ml0MkSYUppI1d6gS0QN4nwhVxhHAm8gz+gVPWjeTQHx4?=
 =?us-ascii?Q?IHq2PTA4wN+ofr9bapmG3mAY6ommsuesQ3Bs8HMLFmxGzl/Dvc7OeIBMrzCs?=
 =?us-ascii?Q?nU2tUCmMwSbSnqk/lkGHv91ssAJndVyUs7GmU2JffFl0GQApsQAm0HImDEAM?=
 =?us-ascii?Q?bziKbfK3IlcQtPc2H5QNFFDNBqm1nqYcTyAtJfN7HU/cpY51/XdEEWMzZt1Y?=
 =?us-ascii?Q?agjlg0SNtNwH10rMz6A4BThdj43pUTztaXCdBsruK8ZmnNBIsuR+tbon9uEu?=
 =?us-ascii?Q?eJb7QQbwzdNjzxTLBvS3p2ah9NEGozW/CEEcXDvNIRyolYZb+Jqh53wiwqU7?=
 =?us-ascii?Q?GNDbE8cg2FSMnQPj3i0DtiZ9e/Tr7cqmvZuxfwQEzTOZ2DqpRRbdlRrKSZqp?=
 =?us-ascii?Q?IQIMBurqLnvGZmO+pkPEgwV+5VdtstXsFjy2ym8WPUgWUzJrSvtTrHKAU9OX?=
 =?us-ascii?Q?Fo6VEEZ98XwkX1/FWI8hig1Vuc+lAmhDdm1ZS1CqDRl1kFO7qU/By7GLXeX0?=
 =?us-ascii?Q?CHGijXFAsk1i2vozm6BmtI+rl4g5rya7W+k/J5GssrVqlQ+Tm5reiXe0bGZy?=
 =?us-ascii?Q?vT0lGP9CsUq8OYvdPOCOzi3n/FbCMsM3tscvR9rvmLVeLd1FHechtmxRF9GU?=
 =?us-ascii?Q?baTHY89EgcBk+pNtm9gv/cCDxyMnOvD63McBuXIFTNXwr424wbK5uSkcbmsD?=
 =?us-ascii?Q?mrsVhLRSuHq7FlE+KTga9cD5ehkSpl1PD7dptv0BphrnBAs/ZPif1LcGGHPy?=
 =?us-ascii?Q?K5Et3zr4BmvCeMi5zPkPH+pngzVW2bGPrdAn0G3I2YLA60ztrJTttzg7M25I?=
 =?us-ascii?Q?ZQPJ4vyjmN6pL8qukmUlmUup4wqsduRHxL+r+RNMytvsNhb4qOE6qFjsNXYT?=
 =?us-ascii?Q?q9qKsu3xl7CTaTG5xiDbKO3i3ncnJ1EmKsQpgdYl9/TNpBQFW/BZrwYhELrT?=
 =?us-ascii?Q?3Ir5K1k1dFSG9DdlStCK+B2r5IB0JnNtC40uPL4UHzh1auRjiG3BP5kGCPTE?=
 =?us-ascii?Q?84XTooEYDS1iFpxJQ3rC0d8NEcFWiEVM5QD1w/5tBX76scE48x7mX0hnANWU?=
 =?us-ascii?Q?XVjAwBv3hXoKu1m3BDD557MOMyI+XSTpL5A1CgaeQSamwTNSIf5je5ZJJebu?=
 =?us-ascii?Q?rIJaWchlFr27PD0DHxZrN2TgArssxmmNOp4kGd1OCMXiqk1gdvzCDRJcjJjD?=
 =?us-ascii?Q?48SfsoHwiI0AKV0KWr4wHVKheUW6ku7p3nB7acUSbQdnGtsdy8sbA6oKB1d5?=
 =?us-ascii?Q?iYVBEvZ4iShGAkbfnz2HmBQPLCuFHs3ZaD6ncbV1TFSQyBycrnVL+DXEe2Z0?=
 =?us-ascii?Q?y8PletZuHVTizlwwx4U1yweNwBtlQC4yRt+vKFfUex2kSiEakTr2hSaa1HX+?=
 =?us-ascii?Q?+QdMF2Ba3efgv5Piqe+O/97cG1R05LYMFiGh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 08:12:43.7085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e978edf6-256e-49e4-43bd-08dd7e50cbd4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1394451C7

We identified a bug where the ST_RC bit in the status register was not
being acknowledged after clearing the CTRL_RUN bit in the control
register. This could lead to unexpected behavior in the USB gadget
drivers.

This patch resolves the issue by adding the necessary code to explicitly
acknowledge ST_RC after clearing CTRL_RUN based on the programming
sequence, ensuring proper state transition.

Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB device mode controller")
Cc: stable@vger.kernel.org
Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
 drivers/usb/gadget/udc/tegra-xudc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index c7fdbc55fb0b..2957316fd3d0 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -1749,6 +1749,10 @@ static int __tegra_xudc_ep_disable(struct tegra_xudc_ep *ep)
 		val = xudc_readl(xudc, CTRL);
 		val &= ~CTRL_RUN;
 		xudc_writel(xudc, val, CTRL);
+
+		val = xudc_readl(xudc, ST);
+		if (val & ST_RC)
+			xudc_writel(xudc, ST_RC, ST);
 	}
 
 	dev_info(xudc->dev, "ep %u disabled\n", ep->index);
-- 
2.25.1


