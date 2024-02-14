Return-Path: <stable+bounces-20208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 469A3855258
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 19:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF121C21D45
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 18:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27E712CD95;
	Wed, 14 Feb 2024 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p4ftiaEo"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26DC13A87B
	for <stable@vger.kernel.org>; Wed, 14 Feb 2024 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936044; cv=fail; b=KjRPcN+hMZLkgPj7SKtDhneAPyPFZg1a4lfjzAW7OxNe+jDHNlP0TBFIxlUHn/WTqLdTWZjS0YraioA1gBdbc/THSTzFghLNyl0rJBBWbvKilCZWQzC+TcA5O/aV5Zqt0XZTg0rf3vGN/b0tfB0OdUjaBACRZQoiS22TQ1FRZzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936044; c=relaxed/simple;
	bh=XJej2TsCszCNkxcezdVasJws4ZoaLmrn/ahlySGq51k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZeCVWs82ToGD7S2oftd59N3rVdp6sRujrs3kwxtRVnZ4gaNWrmXfHtuxn0hpCmwWKCOJ4JvKYNEbRBHftb0yiQbCNWhMxzfi/XIyTco5F/I3WSIolU+XMgpYxuh2abuheC/njyDGTtBdaXlE+RsNRyc+UxzEFixDduZrHk5Dc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p4ftiaEo; arc=fail smtp.client-ip=40.107.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cftaZqLwzcVg5m5j0+oY/FFEUbSZv02qnRk/XI0yF09I4twxomdJ0FeCNEYFwtlNgGar9erD6oqZKXbTwYzI3uxSki1wBRf0XLIjygWDhnIKdIz1J9jpifw83iyf+0fC1KoWdoaV1KREW3zIQtbZSmqhoOXUUaq/erjZnjdix3G/CrcGOMRXFJX1ADORjBDD6KwJkVnCdTSEfnIkamSV9yseZZ/OJasZ3zhmNH/MznVBzmwKcw40KGfNBPw9+/0O7u46ptY9PeTrmC8EMSMJ6+dRO9rh5PLvGk1FMvbVbVoPUqlDZ5QFQcqNES8HDedLMlVnRn227Cef24DC4w14JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M947VMqw3HisNhk8Fr7w0lcNAFcqtdLviusP7HxbP2s=;
 b=URsBljXmK1QIOBYgq62okCT8FnQI45vEkLQzSjqaPeAUZKXUjEe0hUESF1xAeWPUeSgSByKw+jypKGZAr3AOjJOT1bCEVXYGWwo6h/n5O0laydH1W+gQL8XhLCJpBKcL1b/kP+tX1aKhOjYQU0x/iMrs1ZSTFcIFrT1KxR+Rh5Jfti1CijCoZHPEbEJb2SnUZ8Dx6y6pc3fQX7Iw5auUfFEOhMRC5I61glfuPE/y75wBBNesrjchy6IksoU7UAUH3jDFMkfyf8xs93FodJKAGu7VwmBPP6lJxS70jJbqXwbm/3DIhskFNPivBAWHTchGLpWUQe1/zQIbT0DdW2Citw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M947VMqw3HisNhk8Fr7w0lcNAFcqtdLviusP7HxbP2s=;
 b=p4ftiaEoMRlRFxVi/IN5ZbyU/wf04PO1TWBzHMWD9/1Ce9yJk/Hwk8RRTo0qdDcPEGWwISkx2gPxXhX7skgfRrxJLdiGebkfzBLEk5557PLJxu2sLiWr5bISTnenhJ1A+1oRkwiBd19MFsKwdgC2A+xfOyOMDMkER6qliBOw+DM=
Received: from BYAPR03CA0025.namprd03.prod.outlook.com (2603:10b6:a02:a8::38)
 by SJ0PR12MB5662.namprd12.prod.outlook.com (2603:10b6:a03:429::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 18:40:39 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:a02:a8:cafe::5d) by BYAPR03CA0025.outlook.office365.com
 (2603:10b6:a02:a8::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.41 via Frontend
 Transport; Wed, 14 Feb 2024 18:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 18:40:38 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 12:40:37 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Stable <stable@vger.kernel.org>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
	<rodrigo.siqueira@amd.com>
Subject: [PATCH 06/17] drm/amd/display: adjust few initialization order in dm
Date: Wed, 14 Feb 2024 11:38:37 -0700
Message-ID: <20240214184006.1356137-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SJ0PR12MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa494b2-0366-4368-c971-08dc2d8c70bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wCDiLlOkG/Ya14hUDqk4rytwVCjp8Vwkup1d+yH/oro33+0KAj+gWoJhrbePIcDtnyiezJMcaTIoke3sqLX4nx3UUhT9p5b6M5730yw80b+MjXmJ1q1jDv07hxLZNAEtYCm6fcHHzDFOPQOYmkCY8zTXXsDN84xkOBaxXnkiuUsHIoCV/t5YMy1VAK4nKtrr/Lm/WB8fd3QixuRsHsyOcMIPRePJyditwljBoJEeftaFqase7whDJ9l/NRVcdC5HTmHoJFqrFTAFy5H6+ISEvP36emCQdyZEXR1yoo/HzDLsB316alx8Qc9dqAH0UtCtPJWHkLSHFH4989CEZkBcxtyTNdMTkdYcaeE2/2R3NE2JfBogedi91wGnBMTdtO4owrwTz2VhEixgn5f4PcdKFLxSJ3gdy3/tZP4R9uM8NlK9yQDG7DODHODkSDTF3deRU2hRz9766OzpUgG+tSLqWksyucf9x2UMJIGNJ8kzaI8tfILN27Pujuuakw71Zu25RIOPLfJML9VP7GYV25BUT7P29LAX1oyDBKOFtHS7WrFl6/Y54kYxcLlg2xbT7tJ2YsJHQUi8XCb78pHzLZ30xWi0zal1qKZRwkYgox0050A=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(82740400003)(356005)(81166007)(2906002)(5660300002)(4326008)(16526019)(1076003)(336012)(2616005)(26005)(316002)(8676002)(70586007)(54906003)(8936002)(70206006)(6916009)(478600001)(426003)(41300700001)(36756003)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:40:38.9144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa494b2-0366-4368-c971-08dc2d8c70bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5662

From: Wayne Lin <wayne.lin@amd.com>

[Why]
Observe error message "Can't retrieve aconnector in hpd_rx_irq_offload_work"
when boot up with a mst tbt4 dock connected. After analyzing, there are few
parts needed to be adjusted:

1. hpd_rx_offload_wq[].aconnector is not initialzed before the dmub outbox
hpd_irq handler get registered which causes the error message.

2. registeration of hpd and hpd_rx_irq event for usb4 dp tunneling is not
aligned with legacy interface sequence

[How]
Put DMUB_NOTIFICATION_HPD and DMUB_NOTIFICATION_HPD_IRQ handler
registration into register_hpd_handlers() to align other interfaces and
get hpd_rx_offload_wq[].aconnector initialized earlier than that.

Leave DMUB_NOTIFICATION_AUX_REPLY registered as it was since we need that
while calling dc_link_detect(). USB4 connection status will be proactively
detected by dc_link_detect_connection_type() in amdgpu_dm_initialize_drm_device()

Cc: Stable <stable@vger.kernel.org>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 37 +++++++++----------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b9ac3d2f8029..ed0ad44dd1d8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1843,21 +1843,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 			DRM_ERROR("amdgpu: fail to register dmub aux callback");
 			goto error;
 		}
-		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD, dmub_hpd_callback, true)) {
-			DRM_ERROR("amdgpu: fail to register dmub hpd callback");
-			goto error;
-		}
-		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD_IRQ, dmub_hpd_callback, true)) {
-			DRM_ERROR("amdgpu: fail to register dmub hpd callback");
-			goto error;
-		}
-	}
-
-	/* Enable outbox notification only after IRQ handlers are registered and DMUB is alive.
-	 * It is expected that DMUB will resend any pending notifications at this point, for
-	 * example HPD from DPIA.
-	 */
-	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
+		/* Enable outbox notification only after IRQ handlers are registered and DMUB is alive.
+		 * It is expected that DMUB will resend any pending notifications at this point. Note
+		 * that hpd and hpd_irq handler registration are deferred to register_hpd_handlers() to
+		 * align legacy interface initialization sequence. Connection status will be proactivly
+		 * detected once in the amdgpu_dm_initialize_drm_device.
+		 */
 		dc_enable_dmub_outbox(adev->dm.dc);
 
 		/* DPIA trace goes to dmesg logs only if outbox is enabled */
@@ -3546,6 +3537,14 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
 	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
 
+	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
+		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD, dmub_hpd_callback, true))
+			DRM_ERROR("amdgpu: fail to register dmub hpd callback");
+
+		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_HPD_IRQ, dmub_hpd_callback, true))
+			DRM_ERROR("amdgpu: fail to register dmub hpd callback");
+	}
+
 	list_for_each_entry(connector,
 			&dev->mode_config.connector_list, head)	{
 
@@ -3574,10 +3573,6 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 					handle_hpd_rx_irq,
 					(void *) aconnector);
 		}
-
-		if (adev->dm.hpd_rx_offload_wq)
-			adev->dm.hpd_rx_offload_wq[connector->index].aconnector =
-				aconnector;
 	}
 }
 
@@ -4589,6 +4584,10 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			goto fail;
 		}
 
+		if (dm->hpd_rx_offload_wq)
+			dm->hpd_rx_offload_wq[aconnector->base.index].aconnector =
+				aconnector;
+
 		if (!dc_link_detect_connection_type(link, &new_connection_type))
 			DRM_ERROR("KMS: Failed to detect connector\n");
 
-- 
2.43.0


