Return-Path: <stable+bounces-210611-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHgpK7wCcGmUUgAAu9opvQ
	(envelope-from <stable+bounces-210611-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 23:33:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABE04D064
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 23:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8084B26F39
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 22:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358DF3A89AC;
	Tue, 20 Jan 2026 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2U0ygfKG"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70083E8C51
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768947272; cv=fail; b=OjCM1BnMZKkgfszoR6/j695LBXvj4AMEwNsjGGpDzeys7/jJ5zIcGz/D3Y8o5sBdopbGRx+mWz3/sjAB75WxfpWOxhoE/S1mXE/B7BJmXaCo3Xn4FxGGzXG2qrWhqZNx+tzdueNeDxFTBx0GvUiuGHBctcmdcniqE6/cUuooD34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768947272; c=relaxed/simple;
	bh=xOXhjlH1SK11OuhvucaXl5Cd6fs3xXJ0e/v7Y0lve8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dl7Ew0H8tO6vEtLaPJqhOqlwufRuT0YFrI4E4LmUnlnaDbkpRA6dxvC3vkRwf+e7E9yS72f5XQVW+5V6+jrHQ6XvEUw/xtVjZA1jHhq0ZR4JZARhLGw3iYXT0MB1yPe5qcikSMvRGSSoUAFlfMXYVlnw+OZ2HFJ5N6gwjaiqF8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2U0ygfKG; arc=fail smtp.client-ip=52.101.52.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4rGj7Ulc3KmoMW00UjSYbJol6SaMqsnkggNOXupdBALnYH73PmhgIOruroONk4kXebWjJyPjqlq9dr38lb6eoOQ1SqLinziCyuAMEp3ptVY1HE/nk/db00qXC1xu+Nq/+cUDe2J2jpUWP4KNJsw2lLvyjmE+fRmsAmUtBx9BoqDPxXIvXwW373+SpZf8Lb/vwqd3OUAsUVMMWZzXvmLTAFqmY6lFBtVpLDGyGcuaQUIx42xzdgq0ntQCHczfQmxX3+76Po3VEfDcfbrrqPXp2a6n+A3ce/PAgES+m2BdqHubeURL8WeND5u9JbV0ceLrNmI6VqMuoYb3639YB4HVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaAOYtJZLP2zhx6bDrsQ+B22yDQF2jtDX73sj/b736c=;
 b=mj3FGDoIS6Sl5ffuu+qZKvUXw3pPsGY92MJqyGzAnLi2hGPAVtRfM8GDcbDGLXQRbOabxDjj+x0rtq04afjiUqpqVRq6p8Y3DCU6W9SwJdCcHMNFC1j+AYwF0bjJddtze46ULHSucvsLs3o5TlkviUkePfN7+tM/hz/sgK2W2yi9NTuTVtniM9VFMdX3Dulwez5EmEnKmpCkTNEcsUrFMtfxS0CGawyCt601FTouiDImU2Podx5zfihGeSw4u1vQzk9lr5iSlntH0kh2nSTs3FHyBSmU+Glf4m+av7ZDIT+OwnpJyqLnIGcYbRh0BOHoJk/9y/eXy95ywSoqNAh8Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaAOYtJZLP2zhx6bDrsQ+B22yDQF2jtDX73sj/b736c=;
 b=2U0ygfKGUxEUF7OQ7KSrfaXQutE1YA/Og9zN+ApuV9ctPHNFBW53b9qNJs8wM+XTs/PJVyQhJBcRrDiGXmVH16Av7CeFpz+l4pPlHywhXAIw684fmo/pvxNbbRK2reycUDeQuZXXVg9YOkf4zyoXRdNeFQNlLz+R9OBb2Yw2GK8=
Received: from PH3PEPF000040A5.namprd05.prod.outlook.com (2603:10b6:518:1::54)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 22:14:23 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2a01:111:f403:c902::a) by PH3PEPF000040A5.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.6 via Frontend Transport; Tue,
 20 Jan 2026 22:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 22:14:22 +0000
Received: from Harpoon.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 16:14:22 -0600
From: Felix Kuehling <felix.kuehling@amd.com>
To: <stable@vger.kernel.org>
CC: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, Oak Zeng <Oak.Zeng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1.y] drm/amdkfd: fix a memory leak in device_queue_manager_init()
Date: Tue, 20 Jan 2026 17:13:49 -0500
Message-ID: <20260120221349.3213956-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026012022-worst-moonstone-878a@gregkh>
References: <2026012022-worst-moonstone-878a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2bc309-1288-45fc-a22c-08de587143ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d+qRBia9MSuhwwLRNnM2Ewyoe+KdZT6kVTcGJgdNQ/yG811zdeYd67TsH1Js?=
 =?us-ascii?Q?rMwWOvP1UVlgAPZ8r/fgSaawSdMRC9YwM2nMiNmJ5dNqQ2116AqyXZH7cHg4?=
 =?us-ascii?Q?g5x3FqhBuLljaY1WVYofUfoSIzssExMbBjPvJXf5JTiKCJ6A6FBM8la7oEgC?=
 =?us-ascii?Q?h6jhZ9GS9vCuiWQ8aXbfx8SAwK6KWgckytszlI7nD/MwgWBPb5NePjYIyAZp?=
 =?us-ascii?Q?X+H0UvTx8bHdoZw7DZgQ8abUCcAbCvs0QekTL4YdA6S68RUOaDgQsr6jG2U/?=
 =?us-ascii?Q?kNLjeiXF5tLwgGSjaz8+xXKwa1XvR5FRtHs2XQWbJ3LEPUVulwgwXtMw/5jE?=
 =?us-ascii?Q?ndCZwCxLqaAteL3OTg1rDVfaABCQv2IJyvHLcSDD/4pNpD7gYHiuwtGo14+o?=
 =?us-ascii?Q?bLSWZ8QDHJW8aidIH2GXJ3AsWZbdBkpx16VHmkX58rn6BrRWPUxUNPE/+T+t?=
 =?us-ascii?Q?Nj/k7QIj9I3pSGoVSh4rop+1yfFrxxFOH6bIg3PMWnjOg6qu7HBZScMdENcV?=
 =?us-ascii?Q?6HhuGrfZtWsuNeBjy1WjCS2B8rziFnzdM5aIDLqc69r5ph/VrErUFppncINR?=
 =?us-ascii?Q?aoD8pmvUmc0WCGOcsZo7emZO9dWXqMzp8qbKxjSJ10DMijPMdNuk2BVZofal?=
 =?us-ascii?Q?kZnM2+49ik0tA9kdG/aQgIpzYmbr5EPZdPo+h3ov43Y87uNi0B0zsBoRi6GI?=
 =?us-ascii?Q?nuXHhi5meSgWM+VhjElYG4l3bT5l9iGubd8bMS7xpWDv5hq4xpZrSuUQ/App?=
 =?us-ascii?Q?jzbD9iwtp+p/UmtHpBtzkfnYIzPqXD55glWdLrtsSt/+GXKEOeSy57c4ttlH?=
 =?us-ascii?Q?cMPJXUqGYodpODjklNAuKjbIvRn9FfeHk6AQPD04Ytib8P6lZv4xRUiRv7ng?=
 =?us-ascii?Q?xSqJOTe/+3LCGNwuiUQZZg9g52Xi7MdYn/NXmQZ4e1uukB2q9EArYh3K4eXw?=
 =?us-ascii?Q?WFeA3eJX+43M2Q1oQWpyphXgXanDlasmCr1QSpHKCeYvS7ENzgzu3qygqEhj?=
 =?us-ascii?Q?efuruKKhW1Mwh9c5pNJ1lOwY8oeceOuxP2sPoHTZ+V8X6GBR31Ee7Cs0SM2U?=
 =?us-ascii?Q?YOkyGnDvhRZ/zeoNKIbbIEfUxasfqDioNmIiyETgi+224iDWDu9SEPwdzl5X?=
 =?us-ascii?Q?Q7G9D9gzMeQqWZagRfMdrS8b2Tmv/OKs3L6dWNbXoQ9fHtuxzYeOjQ5WOYoN?=
 =?us-ascii?Q?EUkWiF+T7JlJf1YttBuLP8d75zzsAE3d3lfwkayxJPE8CAEMAz6+0asYvxqo?=
 =?us-ascii?Q?YJZlnET2H3ZEsmjxGi1P6gq1j58v1kIR6Lkwz+NsrJsC7PeiSAhxLlBiEQhq?=
 =?us-ascii?Q?xRpUOkToSkPeJbahzaX4Y9+36mT1lL8/pNcv1KXrr7lRwPI9Fsq/D+Qwmn28?=
 =?us-ascii?Q?cNBGroPsy1nO/J3zmFC+VUEx8/Tlqf1erPjB3bzxyhHJFNrANl8Ne7HGU25P?=
 =?us-ascii?Q?w+85lStbYK6cABy3S1HbzPrxvTEFqbAY8yGZUzwEbtw5L4UyZmm/ki4ll5k+?=
 =?us-ascii?Q?5tNvQ1Ttf4pvm4xM7EViE1IORJaX+3v5gtHzYiAn5CfKgpQN1jPlhZOSiUBp?=
 =?us-ascii?Q?yaOHSKs0z659kYUqmeDckNYbKKQK189jKjWcyxLHR7oIH8xRWngN24WtTMMY?=
 =?us-ascii?Q?yCw6ix4fFee33TQioMDzMY1gyFJEqP5qiDdW2D2Zj8hOf8oJQmPa/nswdTAN?=
 =?us-ascii?Q?CbCQPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:14:22.4239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2bc309-1288-45fc-a22c-08de587143ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210611-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[amd.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[felix.kuehling@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,amd.com:email,amd.com:dkim,amd.com:mid,iscas.ac.cn:email];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2ABE04D064
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

If dqm->ops.initialize() fails, add deallocate_hiq_sdma_mqd()
to release the memory allocated by allocate_hiq_sdma_mqd().
Move deallocate_hiq_sdma_mqd() up to ensure proper function
visibility at the point of use.

Fixes: 11614c36bc8f ("drm/amdkfd: Allocate MQD trunk for HIQ and SDMA")
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit b7cccc8286bb9919a0952c812872da1dcfe9d390)
Cc: stable@vger.kernel.org
(cherry picked from commit 80614c509810fc051312d1a7ccac8d0012d6b8d0)
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c  | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 3ab0a796af060..4e754e47bff36 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2257,6 +2257,14 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
 	return retval;
 }
 
+static void deallocate_hiq_sdma_mqd(struct kfd_dev *dev,
+				    struct kfd_mem_obj *mqd)
+{
+	WARN(!mqd, "No hiq sdma mqd trunk to free");
+
+	amdgpu_amdkfd_free_gtt_mem(dev->adev, &mqd->gtt_mem);
+}
+
 struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 {
 	struct device_queue_manager *dqm;
@@ -2382,19 +2390,13 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 	if (!dqm->ops.initialize(dqm))
 		return dqm;
 
+	deallocate_hiq_sdma_mqd(dev, &dqm->hiq_sdma_mqd);
+
 out_free:
 	kfree(dqm);
 	return NULL;
 }
 
-static void deallocate_hiq_sdma_mqd(struct kfd_dev *dev,
-				    struct kfd_mem_obj *mqd)
-{
-	WARN(!mqd, "No hiq sdma mqd trunk to free");
-
-	amdgpu_amdkfd_free_gtt_mem(dev->adev, &mqd->gtt_mem);
-}
-
 void device_queue_manager_uninit(struct device_queue_manager *dqm)
 {
 	dqm->ops.uninitialize(dqm);
-- 
2.34.1


