Return-Path: <stable+bounces-254256-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IC1AOFIFWqLUAcAu9opvQ
	(envelope-from <stable+bounces-254256-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:16:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6128B5D19D6
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 465CD300874D
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 07:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F78C3090C5;
	Tue, 26 May 2026 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wG8jNbPo"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012036.outbound.protection.outlook.com [40.93.195.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114AD3793D0
	for <stable@vger.kernel.org>; Tue, 26 May 2026 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779779791; cv=fail; b=PyrWCuo56AKk7R8O/7SJo8119hIC4Y8/ivYvbaAPQyoK/CX+CBF8PLktmgi/OBa5KHI/VD4edKYUegK0rydpW3ogytq31QVbl4W/52tVxaIHo+TdNsq+RfeEndxAxfqlRtVXA4OYh1BvoLHc/n4RjeupJVcD7LokmXUZda2h6n4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779779791; c=relaxed/simple;
	bh=M4BLKnrneJLRoyNufVAmR9Ae/AxI9O4E6roSwLPPmaM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWuX44LsmVTNCSWRXrqt5koGrzb/VCXGm+me0Ca3Ef5bUowtVnYMAHtBWSoTn1QEOx+OMkGONa8gpVi3H3LtZzWpP4x9QdJF6H9fyhzWbXpKasbE2A4Mx+s0FQE9i/AXxHICdLJkr4YqtNY4sURDzCq9t2NFFu6pxUrNjaL2s7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wG8jNbPo; arc=fail smtp.client-ip=40.93.195.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LT+iQF0XgXD37rBaHy9LIqlOOGIJeUMIjawpypA0myXNTGFOI+Xy6ut30XxdbIhJFZ3stXzULojtkozd6UB3IOvocsC3dbYyHnlWajelU8rnjm5MdV3/DcMTdr1tjdi1RS5BUCdKi5S5AmIZdtj/8swdHQ3TqKzgx3NrECWs0RonhhvXtqYJzR7W77cRrGsio6Eecwa+tEbxlBTh9Vzh8/iXpW5MQslg36JI11RZkwrNlDwEBaOEN4NXdooaN3d2xcJ2VreUF3fQUSpf7liAAKwvnsQ/HSdPebfQ3GDyal89MeDS+xz+h2MCRATN74t95e8hnc7VwcrVwf0rvMGHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgIwH4rOPlZ0FHmNus+lzv5e1uP49bWAjFGzHhOcfFA=;
 b=m4IDQvClZjndy5HNs41djYujpHr5rgTWu6jtmm7OzO5I2U4pYQ4K99ut5JUvUrB0nCNQYY6vfZfgIk8BgVPqt/D7f/A5Zj7YWPRPmMdxxqdwTymvtI8Uby4HgpjZ5WiLcFB5DYlyTX5NHA15u9Fu0aLmQrarnztOICnc0iJX4U3IQJWWopYxD1S8NIpvTrRyS9J9yMqzjwddqBeSGNk7YfNOZtwWnvJBMPsEjMlRy9lUXMZHm+lfGLaRuOIW7EupzLs75N8GBfiH8madVBDO9Siaa1k3Ceh/QRpe5fB+Bnutdoe+s75UOC7ET7ofCU4EoZ+8x69O/R5e+XhFptCmrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgIwH4rOPlZ0FHmNus+lzv5e1uP49bWAjFGzHhOcfFA=;
 b=wG8jNbPoBgZKkqfXj5i2xr/NQFd4mW/5hDFdn8Pvgn3Rvf9WYEcje+ZEBupBh4saMv4+1NsNdJCmFp8OEHXN7VdwdZblUhWmjICRUaNkItEYrTAdtJWitbNs+UDOsWUSZX/UwMkJ39GqernOrgQ8kXEsoCmgRJkpZo47buaMGsI=
Received: from PH8PR02CA0038.namprd02.prod.outlook.com (2603:10b6:510:2da::10)
 by SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:16:25 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::c8) by PH8PR02CA0038.outlook.office365.com
 (2603:10b6:510:2da::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:16:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:16:22 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:16:22 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:16:13 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, <stable@vger.kernel.org>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 14/41] drm/amd/display: Fix NULL deref and buffer over-read in SDP debugfs
Date: Tue, 26 May 2026 15:01:37 +0800
Message-ID: <20260526071413.2181251-15-ray.wu@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|SA1PR12MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: c60f876c-d024-41ed-1488-08debaf6b257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qKjdzSF7Kf8OsiDb6YVf6f7cMYHirQqz4DwCsCG9pRzo1wlAjmcf9V0bdm5BuXqhmsHWWPc219R4RglcBt8G/Pe+EkBH3GAJ+9AvxUXNpUU10dYS3/m0ZNaOclrbIFyKnGQ2Y5VAmsta1gcNQ+Aqxr7M3DPxFO2/SxAF0PhQYBH33XCabHu2wllvW24bWnTiQDc1hRDNJfl9PiaGR3DEad/MY63DJ2rQPLEr9XKxRy8AS/XFSmS3C6zSH23GzNv1WZ7A7/+SMHpTi6DpYR3FgtPAmz2J63R4u37go7UENSIRxjKrgy0V6X4J54ZHXjwgn6serpwA9J4De+AIXgbX6zl0GUk2Fgi5jvGmoEhSmzzs2336aNTA9900ZK1cpXG8ifrSrR2iIL1CPaLzgbVqTY++6YDPiXGgQb8jfoDCmsh670UMV+6wMgZhzaCt+LD/367NMxEiLf2y7sMYSY8KCxhqZ+QM7iAbq6dp1aJbZVWaMoS6oY35LU+2qF8wKL7U8aElA4fdz5Z0NvN0p0AN4Y9zGLrToEGcHDTnXlRFgd8djmnty1w/HGq1seof55Yz3RLwlXpAs5JpxpO5Ewe21X/K8kU+QJI1AFqOZnc/5gDbLKM2XZ3w+stvQ28WsWZDBW9ZhwdQWn/Sv03tltUFZ/WzGJKWnh/kBPOHKioySkLgNl6yT/vjWjHAlw0pM67iTL6T8Ozt0lFosDnDIDRy1Vay7BbgXbku0Be2vKNJBeE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(11063799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/wuzpMrL4vL5eiu2dv2gArNuPVhI8ahreSqAR4vwXK3obz1dwMX06zxGm0VThzO+TrOqhv1XYaopaPIHBUJNaMzgZWSl4laIlQVSBgK3dxJfDXfq0WddtG9IffNUZpd+LMOYfCKboRbB1gkItBs7NbXUKMoVB42mtje1aDG6FnPzbPREOhrrLTpcTR9X3IJH4zREkgpQSIJrNyciZef7ShXBXyzecQMa6/8QVDtosiXGp8lg8hDVw7yKELbGaMl4fzM4Pw1UNyw8hlwjGX/SK+9lAIvQT/UkMCYCizARBElprR8Zx+uwpv8gx78ovo/f+VIF2BUY0Foivj3V8V9Q72b9L0UyiKo9R43wzeBkxjAPkcI+otl6ccg8js0maBmmPJGyFQiaT4UIGETVR3f4D9HHR+l1G0sZKGakYVoi7IgL/Y7ob9lYyAPlDxZXAxDB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:16:24.9088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c60f876c-d024-41ed-1488-08debaf6b257
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599
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
	TAGGED_FROM(0.00)[bounces-254256-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 6128B5D19D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Harry Wentland <harry.wentland@amd.com>

[Why & How]
dp_sdp_message_debugfs_write() dereferences connector->base.state->crtc
without checking for NULL. A connector can be connected but not bound to
any CRTC (e.g. after hot-plug before the next atomic commit), causing a
kernel crash when writing to the sdp_message debugfs node.

The function also ignores the user-provided size argument and always
passes 36 bytes to copy_from_user(), reading past the user buffer when
size < 36.

Fix both issues by:
- Returning -ENODEV when connector->base.state or state->crtc is NULL
- Clamping write_size to min(size, sizeof(data))

Fixes: c7ba3653e977 ("drm/amd/display: Generic SDP message access in amdgpu")
Cc: stable@vger.kernel.org
Assisted-by: Copilot:claude-opus-4.6

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 4e68a3541639..3ceeb322be12 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1345,8 +1345,13 @@ static ssize_t dp_sdp_message_debugfs_write(struct file *f, const char __user *b
 	if (size == 0)
 		return 0;
 
+	if (!connector->base.state || !connector->base.state->crtc)
+		return -ENODEV;
+
 	acrtc_state = to_dm_crtc_state(connector->base.state->crtc->state);
 
+	write_size = min_t(size_t, size, sizeof(data));
+
 	r = copy_from_user(data, buf, write_size);
 
 	write_size -= r;
-- 
2.43.0


