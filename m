Return-Path: <stable+bounces-246654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDFUMG2GA2ot6wEAu9opvQ
	(envelope-from <stable+bounces-246654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 21:58:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19783528E3B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 21:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E87E6303FFD0
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFAD39526B;
	Tue, 12 May 2026 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fpt2izl+"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D093921E7
	for <stable@vger.kernel.org>; Tue, 12 May 2026 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778615912; cv=fail; b=tXyhfdYqYIjrdHRmETxJ3Zs5w7CvTFWaxRgC8WqVlEtWzdJtDc1fLB0qTmOb3/iKLRLoDH/bZafZT/MbYG4CqDYzbsbJ+zIFplhwchOQ+WKkve/TexdokBsKwJuL9r6Toih+lWkNQAtp6fHV75ZTObVixFKCSIDEpsLnm1oTmbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778615912; c=relaxed/simple;
	bh=aW0SbrlWxagNFVR/nEYGAH024pAxH6E4fDQahPP8SKA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Npl6ncCfB9bMyYh5VJUzrThXf4wKNxk8bfBxIqJ9xKFuRiU+Ai3SDOSqJNX80U9cI6Xo6OpyJSdkqKvmias2+ZAHSSSGQPlBC8MdpgXlejUKMyEmie/llknaOKLNXKutyBROMNQdYh2MBAAik2uzjmUrpcMLRrS95U6TAzz2PSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fpt2izl+; arc=fail smtp.client-ip=52.101.43.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vi35x4hjjoivKIMo3kzUNn0LLDZkqFYVo8pDbaV+S2chn7IyxnNuttHBugcYxkHkNhJTw7Bvl4Kst/qvC4jrsX+V/AsL8q6ghWniXqjvYVxQATl348wHlY+1/avk8NTZABgJ4MXmDT7RYsdb3dQ+GhbvjOJp7ZZPeC0aTBvgTiczT8Pfhiu/V337mo7LNz0NudJ9WPXCU+Zx/1Oq5P/EUq7EQ1BxgV4NA7fhYavS/0sFZdP78t05VSfOCKSLl4XjHDtMQwiRZLRgB+mKFuYHUnQ/sWDnHRfuI2MBEOuPYU3LeN7r1rrMUdOn4pfVHBSBFPXI7R2bKTOfGaFkru5uqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8gKLHVCBTEgNOEa+4iKa/nx5zKJykNq0rWGM5jVzgI=;
 b=Ygk7M6s2TtzgH5jcsWiHviKKRDf8XT+i4Qkl58zA4oiPrYHvhNPnYPI0Yu4bCy5947y1bIAvCI/IHQlgNyNeeR9lutvw+SIajFi88l+2QbVdrWMDScnLaIGUYFhHYxHgqgF0DZFTrFOLqVORYeRzE+s2fHkwAUM7o9mquAN1f9pLVZ5iPPu0x7mp8udC/1qEyMpE3dZPHoQs0E5AWKND3y+7FN898s2FurFOHk/TCQcFPvz8Gdn8k/lFUG/oi6Z8A48tDzeYhBf/aSteMQxxnuKxVhFaYHxSwrJEm0FNWt1e/95VwiBXFcDbvbBN2NX3IWhA8rj11oBcwYkznFuywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8gKLHVCBTEgNOEa+4iKa/nx5zKJykNq0rWGM5jVzgI=;
 b=Fpt2izl+i9O8vMzeLqJShv8MqXvnQJIZGtqkQrkogKppsF1xjldLAi7iKGIo3i+LUFRKTBVD/O/nXeqREabhTF2ek4hCrFp+sgdFFsYzsYO9iFK0obFUGBCm1Tb6VY9TLbHrEOLPvTHg9bvM06e53Hq/zatVOzRCTWn+2qpTGJk=
Received: from SJ2PR07CA0007.namprd07.prod.outlook.com (2603:10b6:a03:505::12)
 by DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 19:58:23 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::c6) by SJ2PR07CA0007.outlook.office365.com
 (2603:10b6:a03:505::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.16 via Frontend Transport; Tue, 12
 May 2026 19:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 19:58:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 14:58:22 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 14:58:17 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <Christian.Koenig@amd.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
	<mario.limonciello@amd.com>, <stable@vger.kernel.org>, Christian Koenig
	<christian.koenig@amd.com>
Subject: [PATCH V1] accel/amdxdna: Remove mmap and export support for ubuf
Date: Tue, 12 May 2026 12:58:16 -0700
Message-ID: <20260512195816.556882-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|DS0PR12MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: e304368d-ac36-469c-7c41-08deb060d298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	OnsOlZu7n5RhOcwChn+wPBg95Zf8i7BbCJ7O1IWy0EOTmimwbX8teA9n+s/UQfG7VM4cb1F/XQ2zkHQwZb42kkJnw/G4wRK76s0bdSkQ0DOTk09vd/tUkojii5U9+aJfoOdwOYmdbQ9o0Sjz1jT7Qkj96LduZj3qYMVvOf12cOG+375qCQJaCnsszjYMUemFrR5SAJB6/J51S9BdDa8Wj8VUptkGaexo+AU42stcuQLiO2zx8mWEFyMaFSHn3188qQdT5Q4BHJ+NBCRYV6PoOcE+zfAZTunSzwSteKECXZA2CKwSF8zjHrReVJaxjqvmLCuZ+KsORn0hH0RsonsjM8Mm1c2sly0KXV3xOJkyelFDGd9outA8A0/tAf3VUwceEf0nLzZeOfge1Pu/2LRBion8XODyUkKh8c7DyQmcYSI8orvenrWU4ZghDvj/ac0MRPmz406dq/qhx/zuilTN51WYGNyt6Kv/vtlckQNQT/DwLbRVmmy7ZhxOblTPN9JxYjHNdsa9WrcI52sV5kuej0/90Yi7a+mrPxKkNbvOqxlJAm/5LKxe6eIerG2xVaVQL2jJ8coc0OfrvpddYG1BEuoA60JlpXKUfckFjSM3My5cP79KmLCqdk90ssjIlFHfZQmteEqyrZ2Y2jSLvEuodPZKsH4wcef7blpmpJ1Dk0EMsqbc6cQef2KMLtOM58gMts9xC9HPCbKT/8z8UKqrzcALMAjY+PIF0VH4gCliWJs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NNf+5ZE8jsVOMFqjKTqpxhHlotUl8gb9UZYBCyRv/k95XW43ILVZv4r1uPYkQhmVMaF5YuLlS4fBv3e1x51YFc0W7+P7seyCpzPGrDecXfFe1lstHjoIPuWEiktFKJaXCYpQn9DY8WIls4U5UzRGtF7hLmRiUSrwg7U9csXpLSIHKmnTjaYQTl2GQMRV7azWguUNTXtH92ot/DWBSDlMoAzXP1l8fGd2+slbogFabYQF6XCdXtHZhiI+Bh73pvX+rluChN+OCpWpFOtH3g3fyuwvBL4WOKBqczWgTsYs9sgC5TyFTf1H7aweBXbRwbmMfsfA/yYgMk2QzECJ5NWR5aPVhu/s+vKc4gvjchTcBML2bVObTzjBooKnOw4AK+ZA6d6RCrgRfJoqZ80h4gms7Devi4LHYpsWm2xW8KbYz9cBEp8cnZvN48Fumutr6sIP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 19:58:22.8287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e304368d-ac36-469c-7c41-08deb060d298
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8443
X-Rspamd-Queue-Id: 19783528E3B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246654-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi.hou@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:mid,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Ubuf pages should not be mmaped or exported. Remove the ubuf mmap callback
and return -EOPNOTSUPP when exporting ubuf objects.

Fixes: bd72d4acda10 ("accel/amdxdna: Support user space allocated buffer")
Cc: stable@vger.kernel.org	# 6.18
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c  |  9 +++++++-
 drivers/accel/amdxdna/amdxdna_gem.h  |  2 ++
 drivers/accel/amdxdna/amdxdna_ubuf.c | 32 ----------------------------
 3 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 319d2064fafa..6087264ba1b5 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -492,6 +492,9 @@ static struct dma_buf *amdxdna_gem_prime_export(struct drm_gem_object *gobj, int
 	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 
+	if (abo->pri)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (abo->dma_buf) {
 		get_dma_buf(abo->dma_buf);
 		return abo->dma_buf;
@@ -716,6 +719,7 @@ amdxdna_gem_create_ubuf_object(struct drm_device *dev, struct amdxdna_drm_create
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(dev);
 	struct amdxdna_drm_va_tbl va_tbl;
+	struct amdxdna_gem_obj *abo;
 	struct drm_gem_object *gobj;
 	struct dma_buf *dma_buf;
 
@@ -742,7 +746,10 @@ amdxdna_gem_create_ubuf_object(struct drm_device *dev, struct amdxdna_drm_create
 
 	dma_buf_put(dma_buf);
 
-	return to_xdna_obj(gobj);
+	abo = to_xdna_obj(gobj);
+	abo->pri = true;
+
+	return abo;
 }
 
 static struct amdxdna_gem_obj *
diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
index 4fc48a1189d2..162e5499f5e0 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.h
+++ b/drivers/accel/amdxdna/amdxdna_gem.h
@@ -54,6 +54,8 @@ struct amdxdna_gem_obj {
 
 	/* True, if BO is managed by XRT, not application */
 	bool				internal;
+	/* True, if BO is not exportable */
+	bool				pri;
 };
 
 #define to_gobj(obj)    (&(obj)->base.base)
diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
index 3769210c55cc..df4ab225fbf9 100644
--- a/drivers/accel/amdxdna/amdxdna_ubuf.c
+++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
@@ -87,42 +87,10 @@ static const struct vm_operations_struct amdxdna_ubuf_vm_ops = {
 	.fault = amdxdna_ubuf_vm_fault,
 };
 
-static int amdxdna_ubuf_mmap(struct dma_buf *dbuf, struct vm_area_struct *vma)
-{
-	struct amdxdna_ubuf_priv *ubuf = dbuf->priv;
-
-	vma->vm_ops = &amdxdna_ubuf_vm_ops;
-	vma->vm_private_data = ubuf;
-	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
-
-	return 0;
-}
-
-static int amdxdna_ubuf_vmap(struct dma_buf *dbuf, struct iosys_map *map)
-{
-	struct amdxdna_ubuf_priv *ubuf = dbuf->priv;
-	void *kva;
-
-	kva = vmap(ubuf->pages, ubuf->nr_pages, VM_MAP, PAGE_KERNEL);
-	if (!kva)
-		return -EINVAL;
-
-	iosys_map_set_vaddr(map, kva);
-	return 0;
-}
-
-static void amdxdna_ubuf_vunmap(struct dma_buf *dbuf, struct iosys_map *map)
-{
-	vunmap(map->vaddr);
-}
-
 static const struct dma_buf_ops amdxdna_ubuf_dmabuf_ops = {
 	.map_dma_buf = amdxdna_ubuf_map,
 	.unmap_dma_buf = amdxdna_ubuf_unmap,
 	.release = amdxdna_ubuf_release,
-	.mmap = amdxdna_ubuf_mmap,
-	.vmap = amdxdna_ubuf_vmap,
-	.vunmap = amdxdna_ubuf_vunmap,
 };
 
 static int readonly_va_entry(struct amdxdna_drm_va_entry *va_ent)
-- 
2.34.1


