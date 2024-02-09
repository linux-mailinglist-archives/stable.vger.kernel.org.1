Return-Path: <stable+bounces-19382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0802184F85B
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 16:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB851C21993
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 15:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635056A329;
	Fri,  9 Feb 2024 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="acc8kzb8"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6310628DB5
	for <stable@vger.kernel.org>; Fri,  9 Feb 2024 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707491960; cv=fail; b=nQcvEYFVYHVUmpWGQeXarEkNoKx4LNL106OD1Z/w1tCWbGfOEzosXZFL19gUjkRb3qqT+92UkaTKz8rt7VL0owXC542wDMZX1T3roceDB7mPRc1a1IAnhKlOHP08BnJDG8W/aVNsSFsI4o1aoAaLVJUIp5taU4dOJWWn1RFVrj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707491960; c=relaxed/simple;
	bh=0MgLBmyyKTNg2xjBN3zdSMHZGXrPWql34riNSHsC8LQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kyAtTBQ2Irs038NMh5DcsSdNPPfSjCNN0vUTxsGGKC5rCt/d07b3o/4B840vZWeWk3URFiYZqHrPBYJNBD+5A8/YvS8C9o0H8pSye1FJG+4sjvCqBuKHsJPjgBNFN432coq4mj6WsOIe0qAj/kdb5sZdSKf9IZ3B7MYZ9hClfcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=acc8kzb8; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StR/oWnxTjpr7YLMZG9bCfPNUVx4hb5K2K32TfKx3ACpEgsJlmHBC2JdClZMY69ygo9aPTkIZTrNnbXq3tKS5QiG2bMryuLNWmyleQvLHAz5t88CLFLgeQ/bJGwN9M3mfFgVL6HxvNxMcPd7VPKn8pCY2A0BZ1H9Ytvcxmoyh0gEA5r/BCS1rBaXf9kVayyjkrreBSyp3Umu5pltgDeMSChxU0ro7DcEijEXAuY4uyOoYViXzqIBSuRvcJrlFhMPaHgMAl5GRXdJJTrX9zTAiJbGc577qtbb4dzKCiOgqMBM0oEkG+/Jdr3rdprJwpId06TxJmOGP9QdWoYRkF5Qzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOKi/AnzingsugwJpWyU60BSPTcIGERc7VvHneATWM4=;
 b=MqSotjR0lkJ9e8AKUO8HMZpvStH1zw3wcmqwfyrmMlyku0rTQs+ptNYDPqLaC/mhcChDfyNRFY7ziQvw61qe8a61axEBqugmXPZg5ZGgXAc4sl78n87ndcr4j2lvzLY9wVYtasM3w8l+Q1fCmZ4+usG5/pGdon4E43VUwvonRM1yYNxPz/5vVW7NwIF0Nu2S7CO/XHc+XC+65Ul6btc7Nqd0XwN3b3FYCZSBEDQqGA32JFwmmBWOsHCJau2kB17a6flYD4THzfyrfxK0W1zqZgOfH01MmmAR6GLhKBTUKr30kqA3uI+x1he5BVEoySl4GfCf9JKNuHHtYI1esaZjCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOKi/AnzingsugwJpWyU60BSPTcIGERc7VvHneATWM4=;
 b=acc8kzb8Z7U1KZf+LGnXlz8GwCk3iPv/UpL8zeCvlhYIi55UfrsjGhSDz+5GP9FFcDyBAC4HJO2uwKMwY+dsOgQzycq4thKHLHDGbh8DoVRsW0saBxgSTc3qozXwb5exSdcSeqHt7TGT6bgEcvPDVUOd5joFkdhkLWa1pakjN10=
Received: from BYAPR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:40::41)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.14; Fri, 9 Feb
 2024 15:19:12 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::fd) by BYAPR04CA0028.outlook.office365.com
 (2603:10b6:a03:40::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.26 via Frontend
 Transport; Fri, 9 Feb 2024 15:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 15:19:11 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 9 Feb 2024 09:19:08 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
	<intel-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
	<matthew.auld@intel.com>, <mario.limonciello@amd.com>, "Arunpravin Paneer
 Selvam" <Arunpravin.PaneerSelvam@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/buddy: Fix alloc_range() error handling code
Date: Fri, 9 Feb 2024 20:48:51 +0530
Message-ID: <20240209151851.1811-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da4db65-97a8-4789-8094-08dc29827808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XyC1xwrRqIcgm9q4mFLRQvmDf0mzYnbhrJt9CpIYY0CTwJWtnjbJ0TYCuwFyzfbKBG2QlvLal58D1l/95vMHyN7PnzAcq93xdvrtyyas5uo1l+E/reXZD1+BSLtBbeMzjaNfO0btxcYcdKJlCN6mDc6MHAT5U8pfIpm13lFYVxwN/Fu3mwJi1tv6r4DQ3zGU6e/DChOKwXDwSLK0gCV0bhQ0fCGEbfFYEmclil+1lZVG/0H3pCWzl4nxdNltXnYkOd2rZFOlwNrcmq00cr8EGLKJZBvKVrxAHfzo4Z08yoBeSr1w0KN+WwNxZUMfravadBT7IVF5T9HcrmoNeEU+Ook4G7yBtOWbGqVuH7oq52irwuYc9mdX4DGMYSHQXmdPEqDZoDQj94dSA5nfLyKIHZW+hrfFQK9sjSq1MoKGLZL85mwIYQQ/2F2a5DW25xnLPk4OubE6DUG17z4CBjDx6vyv8ptKRKoX6djvtNsyuZMSrittiL4sZKRR5659zlkzYX5h4W4eHwDBwYAfnuITc99DThNgN6wBLV53X1GLqOAj54yeilxF/44R1fmQriuNTYhEokw+PBr55UCgUXSpgR7rzermGgMtubGuGcjgRVEYhjkCHVA+gzE7atPq6qmZ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(110136005)(70586007)(70206006)(54906003)(316002)(41300700001)(2906002)(5660300002)(8936002)(83380400001)(86362001)(4326008)(8676002)(966005)(1076003)(7696005)(6666004)(36756003)(26005)(16526019)(2616005)(81166007)(356005)(82740400003)(478600001)(426003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 15:19:11.4515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da4db65-97a8-4789-8094-08dc29827808
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443

Few users have observed display corruption when they boot
the machine to KDE Plasma or playing games. We have root
caused the problem that whenever alloc_range() couldn't
find the required memory blocks the function was returning
SUCCESS in some of the corner cases.

The right approach would be if the total allocated size
is less than the required size, the function should
return -ENOSPC.

Cc:  <stable@vger.kernel.org> # 6.7+
Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3097
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20240207174456.341121-1-Arunpravin.PaneerSelvam@amd.com/
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/drm_buddy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index f57e6d74fb0e..c1a99bf4dffd 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -539,6 +539,12 @@ static int __alloc_range(struct drm_buddy *mm,
 	} while (1);
 
 	list_splice_tail(&allocated, blocks);
+
+	if (total_allocated < size) {
+		err = -ENOSPC;
+		goto err_free;
+	}
+
 	return 0;
 
 err_undo:
-- 
2.25.1


