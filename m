Return-Path: <stable+bounces-225214-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMTkDIAms2kMSwAAu9opvQ
	(envelope-from <stable+bounces-225214-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:48:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D662798BD
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 072823081D2D
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C343815C8;
	Thu, 12 Mar 2026 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pc2NZscn"
X-Original-To: stable@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012052.outbound.protection.outlook.com [40.107.200.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A2F36C9E3
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348121; cv=fail; b=G9QYrllTVLCAwPmpF0z8tkWzrBW/437QksRR7kUnjw+GO8asvZ7q5jCHlAbGiiBh1dBWEaSW10Pt/KWxwsGI/xzL4+Onjudz1c1I9UrnYgak2HuopUia4A+2ZE/Cnlg8hjiHrc3ycBM21EOTsRAIBcwwwx8203LDcVSBaARu47o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348121; c=relaxed/simple;
	bh=g601yN+ZLgPeeeVd63Xk5Fthmtdg6nHp5GvLhq2KpjQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=InsJ5OOqdXPtUIbm2OeImWt4/nj56EoNRX6yHWU5IizVpGPi4wv8qlkyuhkzANOf9cMbWjOJJ12YeILY0AN99skto7Zc7ayZhzUZyrCJPKmMDYqGjT3ymihzmvL51fE7OLX4s1vmu0mZ0JHwPE6jKseaGuE36S7oKdfCIBflWHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pc2NZscn; arc=fail smtp.client-ip=40.107.200.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a09gpEHHJWVekoKjiCDUEydrag2HSdpcjYnS54dDfeQBByBl1vLgFrS/ix15PMAlb3Ll4v+ZvE6ByVIkuOT2qtZ3I6RiZTPdNnU/QzGThSkHD54eF5fZVjqaFvSYXiOIhq0G2pxwjbaZb/roCs0q4d0BSQd8xRTHUGZ0zr0BcjsfOOz1ShmWCz1kRl/6tU64McIx3DiU+5zchUjbjtq4d5v8IA0ACvvMJ84cS8Fm51wQYCOm5M+Qc7EVrN8JtZOCcetzs7ZbaIL0M4iVkIc8VW5D/iHE4RMQjbuuumJMwsx4mQZkfgLqZMrs4PQOTDcjcK2kSNbTMZwc+JYcT2sOsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+KY8B5juyyE6Q5qeQHHQuQCXcQW9Gc70WTK45N1As0=;
 b=FHeG27LIcPWLWpuE4URRqaGG+n1XYHd9npf7tftr/ymU2BjLE1pqQ/dj8Uj5TV3ilsM8Gt578foiFdrze8CWrVTUkFZILIgH7TTQDBm7Ya4Gxcv+SRFgvpq5bzBdQeEnaBNnVdwmeiRCJcBnLacKVnd4InfG1lN0W//A4uBtc/gZr1E2fFDOpvGdC7S8O1NbgW3zELPP4CED0uZ3E0Iz+YPQhi1hNX7q4W9qWV/TwGwR7thSrikRoFijNPdPODiIl8YvNFYmvz28UsIEaSvx+FNCmzQq9XQALN4t6ZNJukrTI395PdXod72dnCm1VQuM2zloqI8MOvI2mL/zI4GUnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+KY8B5juyyE6Q5qeQHHQuQCXcQW9Gc70WTK45N1As0=;
 b=pc2NZscnCjeihIYSbIii8NkGNz9CgUSGstIEuWadh4BKVgkyUEE7DYHbkAOqjR9AB0SQp7tXNWF2udDtIFrM8CDuT0eachFTGP82ecL4l1O44HTsi4s+o42Krs2W7G5FZKr1+VPAIZ9eDEi7vAG9zb0KEDLgSyPh4SLFjarxhpw=
Received: from BN1PR13CA0019.namprd13.prod.outlook.com (2603:10b6:408:e2::24)
 by SA5PPFB2BF91BC0.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8de) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Thu, 12 Mar
 2026 20:41:53 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::dd) by BN1PR13CA0019.outlook.office365.com
 (2603:10b6:408:e2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.12 via Frontend Transport; Thu,
 12 Mar 2026 20:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 20:41:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 15:41:50 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 12 Mar 2026 15:41:48 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Simon Ser <contact@emersion.fr>,
	Alex Hung <alex.hung@amd.com>, Daniel Stone <daniels@collabora.com>, "Melissa
 Wen" <mwen@igalia.com>, Sebastian Wick <sebastian.wick@redhat.com>, "Uma
 Shankar" <uma.shankar@intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
	<ville.syrjala@linux.intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Jani Nikula <jani.nikula@intel.com>,
	Louis Chauvet <louis.chauvet@bootlin.com>, Chaitanya Kumar Borah
	<chaitanya.kumar.borah@intel.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/colorop: Fix blob property reference tracking in state lifecycle
Date: Thu, 12 Mar 2026 16:41:45 -0400
Message-ID: <20260312204145.829714-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|SA5PPFB2BF91BC0:EE_
X-MS-Office365-Filtering-Correlation-Id: 27634b8f-9862-431b-b2c9-08de8077ca11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cJx34eXi/vvPprzwvX2fN/kozHuQezDC1XhBcsC+u6f/rS3DozKBntq7I/c/cDGkNztZsEmuEv7hiMDSfAL+DJrm4GGuVCHnVziy+iUKjXrHvFsdFuagXN7yal5UWoCDLtu2pchNyOR8l6rvCWTXwlSGqb8wLjQGt6+0dbrJ4O87rnzB492A5Z2NJRg2wwCoWSugRZw+hFkCdlyqVwcm9Puna/ne7382IJumAZZckphR278ZQaIok1QxWH4zm+x1LEOZ/0j3orGSHlnh1KSwyr1xYkM54+vXr8GoEm0zmG84ZJvL+V/PXxzGTw4QhYTHl0VOyPZBpj4lbfOQLJ/rShOpIFqSG9bd8EoT/udhpytKBTYf8Zl9D+zGVbs3Em4yVHWloMMUIN3ukmo7ZnF37aJUpQwmORlzbZ+ufk/l7ZlvCWnMV+k+bRvu9WRPRbJNSZ4PhyfEErWA02LIMSSL8vzrA+nlQtDOylIPyfA5wzFBijfzodvgfPWUCycfo1fFUqg8KwJrhIudQWRpdTcrHIQriY9LiXKvyEOkFC/S5v8nrSFX1k00bcfZO8MIndV576Zxpb2mBUXcA31+CKcV7ZsCxFH/y1mvX/i+gaQ6Ak3EcBA195df+fUSihTJJKhXmtr1uiq6R9U4SUdmWbt/kah0uiBCPvEvvRzxXFySuyOfSyHZDoy0gg5aEW/a8WFB+tNaAgL5wAIta3CRHxjfw9EaBNp5ed1NJbu4HClHU2F6QBVl/aQ3/i2o8pIKfcuHd74W1hP29toOx4lPQrl9IA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	h9YC0aGmmmvU6ix14HpnWwwUzvzkAdWht6eYqRDFgQ018TEYvIBdEgoF16lCNlX+xh3vuLWEnnhybFsyxSuW8Cfqq/vGj8a2zr42C/yIRZkmlMkPRt6OAZEfpjwUOHUEX0MveE6g9hwGSzkzc1LL4CSMwcTnWYE6YhlfMk/Pu7okHb9P+3615TxaavQ63VqYSc6tMPwRGnxY51kGq7gBVeveMTyyGe1XB+e+rLsTwOeTucuxENe98ZZkvlAly3YODinVDgj/n0X43r6vqQwBVZMrTXpV41iiHsTZ5TTkWG8tdRMwK1vNN1uAZ7KzvbnezRx4E5PDf5Dkgsgo4+3UITz41NmAXIWxsK8gItocL1efHkTlgikmRiXv1HOvWnC6qSnw1T9ahzNz/trZoSkITuO1P321phaDCwgxvnLX0c4Nf7yFwNcyRaYGK8V1sePl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:41:51.2382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27634b8f-9862-431b-b2c9-08de8077ca11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB2BF91BC0
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225214-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,collabora.com:email,intel.com:email,igalia.com:email,amd.com:dkim,amd.com:email,amd.com:mid,bootlin.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.wentland@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 27D662798BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The colorop state blob property handling had memory leaks during state
duplication, destruction, and reset operations. The implementation
failed to follow the established pattern from drm_crtc's handling of
DEGAMMA/GAMMA blob properties.

Issues fixed:
- drm_colorop_atomic_destroy_state() was freeing state memory without
  releasing the blob reference, causing a leak
- drm_colorop_reset() was directly freeing old state with kfree()
  instead of properly destroying it, leaking blob references
- drm_colorop_cleanup() had duplicate blob cleanup code

Changes:
- Add __drm_atomic_helper_colorop_destroy_state() helper to properly
  release blob references before freeing state memory
- Update drm_colorop_atomic_destroy_state() to call the helper
- Fix drm_colorop_reset() to use drm_colorop_atomic_destroy_state()
  for proper cleanup of old state
- Simplify drm_colorop_cleanup() to use the common destruction path

This matches the well-tested pattern used by drm_crtc since 2016 and
ensures proper reference counting throughout the state lifecycle.

Co-developed by Claude Sonnet 4.5.

Fixes: cfc27680ee20 ("drm/colorop: Introduce new drm_colorop mode object")
Cc: Simon Ser <contact@emersion.fr>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Daniel Stone <daniels@collabora.com>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Sebastian Wick <sebastian.wick@redhat.com>
Cc: Uma Shankar <uma.shankar@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Cc: <stable@vger.kernel.org> #v6.19+
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/drm_colorop.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index f421c623b3f0..647cf881f413 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -171,12 +171,8 @@ void drm_colorop_cleanup(struct drm_colorop *colorop)
 	list_del(&colorop->head);
 	config->num_colorop--;
 
-	if (colorop->state && colorop->state->data) {
-		drm_property_blob_put(colorop->state->data);
-		colorop->state->data = NULL;
-	}
-
-	kfree(colorop->state);
+	if (colorop->state)
+		drm_colorop_atomic_destroy_state(colorop, colorop->state);
 }
 EXPORT_SYMBOL(drm_colorop_cleanup);
 
@@ -485,9 +481,23 @@ drm_atomic_helper_colorop_duplicate_state(struct drm_colorop *colorop)
 	return state;
 }
 
+/**
+ * __drm_atomic_helper_colorop_destroy_state - release colorop state
+ * @state: colorop state object to release
+ *
+ * Releases all resources stored in the colorop state without actually freeing
+ * the memory of the colorop state. This is useful for drivers that subclass the
+ * colorop state.
+ */
+static void __drm_atomic_helper_colorop_destroy_state(struct drm_colorop_state *state)
+{
+	drm_property_blob_put(state->data);
+}
+
 void drm_colorop_atomic_destroy_state(struct drm_colorop *colorop,
 				      struct drm_colorop_state *state)
 {
+	__drm_atomic_helper_colorop_destroy_state(state);
 	kfree(state);
 }
 
@@ -538,7 +548,9 @@ static void __drm_colorop_reset(struct drm_colorop *colorop,
 
 void drm_colorop_reset(struct drm_colorop *colorop)
 {
-	kfree(colorop->state);
+	if (colorop->state)
+		drm_colorop_atomic_destroy_state(colorop, colorop->state);
+
 	colorop->state = kzalloc_obj(*colorop->state);
 
 	if (colorop->state)
-- 
2.53.0


