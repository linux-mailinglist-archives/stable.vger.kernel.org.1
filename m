Return-Path: <stable+bounces-254258-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJE5CgtJFWq+UAcAu9opvQ
	(envelope-from <stable+bounces-254258-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:17:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8123A5D1A08
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C54A3302AC32
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 07:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD4033F585;
	Tue, 26 May 2026 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XTOCGCOJ"
X-Original-To: stable@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF682F8E80
	for <stable@vger.kernel.org>; Tue, 26 May 2026 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779779801; cv=fail; b=IExmsfaJEFN4FDNI1tdI52919lx8OLDBNGujS+CmL/DJ9+jwQzZxiNlpxmVG0LVwqtnDV6E8R+gzpgo0r4W2+1NwhM3y+YjbQ6s1UFbQj7i+r10h9tZRaUwIo16DfaeJCnfJ9+SBWa2TcrT828MSQhx330X3ceBmm9IeAnZ4RFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779779801; c=relaxed/simple;
	bh=iK3QLBxQ7RZPajNQvK8TZo4ptOOdbV3jaC0+t76yqKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDbE3EOidFaVybeVD6Bz5IWIl5z0YUXzs9OXtJFvKoNa1ob4cP1IKi19RsjmJVLkPkS5s7Q2A0CxnNmaj8WFGEQit2Sx9HiOIkxF+GyAgzvsnxhQukK6ZEDvXDO2WxLVfLtIreq+dBJierd11N0fVepNCpiVGKo9316CnmEV0MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XTOCGCOJ; arc=fail smtp.client-ip=52.101.48.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgxad2ln28diAwRlv3iNhL+spWwTw44tt6OekIkOKIZ5mUmfTUd8C+MzpAlIO6sTp0KFW9AVHH8wYxMMp2vEa8+j0r4vyBr1PENLxCjK2jCmcbm+fxdfTW8Cj7oZGPnpQB/INvhOzEzuD8F5+CuqV12ecj7Tzmf+8iqKwlC7Qu/M8dRjgocnNiJRPjy5e5q4J9hxf2AVm3yc/07fTy/ZQaj44P9ZkJHcAbdEtk1oaMFVODM1gFKxvkpj8D+qP0jdL/1j0oOc9z+23om5H1SnuEimOVEC3jTFb04VPB9gVpHWXi7Dwbz9ExwuD1AHSdze+jvM+Q9F6030qRHq1zZcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NN/B3EWD4X+GLrRtdnPUgwILAgLqEcFmEo/GDuhMGg4=;
 b=BQEEyLWeV7PcRMCF9RXS2i2EPZOv639zp9O4t6Y5WWNo5zhrIPxL/ncINg1c3E8Dg5HQhzEJ8iEJB8tpeVfFFj9xci7IfvKSc+F+rUAcno/1ANeW5xjB96HSEVJvcR+vJ8yjFT3ai1ZmggwMD147HGiImVdvZFdiUqMW179inuUbwDPo0h8vvI3L2T5+PmlOEftP6tAayARqxXK+FTPemYSqVsW0TlsrcQbfYU9gTJ/7sbzpBBAVs0ZM45+dEEYcf67YyHRRUTySg6dRKjXbrSLG5XlKAEXBcxTGoZGNFA/3+ntM+MaVr/1yR11N1FqpaSOSgHUay7w8m6CQtpnzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NN/B3EWD4X+GLrRtdnPUgwILAgLqEcFmEo/GDuhMGg4=;
 b=XTOCGCOJoGfWrO2YOp9zziMUtHVCGdSwim2Z7jTiNHOT3kZGjYbt6nR90mshB9/uDsSLv7ie2a1omStyv4JqoKpB0jqvzd+wkWhimAB33M9n/wzwOCQ1lfHKmCblWFRZIosuMeXL0nr+U70o630/YzPgx+E+zChqamWRFKO3CLU=
Received: from PH0PR07CA0065.namprd07.prod.outlook.com (2603:10b6:510:f::10)
 by SAWPR12MB999165.namprd12.prod.outlook.com (2603:10b6:806:4e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 26 May
 2026 07:16:35 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::8) by PH0PR07CA0065.outlook.office365.com
 (2603:10b6:510:f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:16:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:16:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:16:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:16:31 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:16:22 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, <stable@vger.kernel.org>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 15/41] drm/amd/display: Use krealloc_array() in dal_vector_reserve()
Date: Tue, 26 May 2026 15:01:38 +0800
Message-ID: <20260526071413.2181251-16-ray.wu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|SAWPR12MB999165:EE_
X-MS-Office365-Filtering-Correlation-Id: e40a04f3-6e0c-45e2-4869-08debaf6b7ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	mL8jbE5wxLfqHUvvD3W8v3UYo5BfL26JswzH9tsmXsn1TVYJoUB+kIG6eNrzQw1ilw4ch+A0cXdfZsL7wJsH/NaGr6Z9BzZtp2ph/Ts9TtHAu45N/b8lzoFlCYR1BOwxzHh2wgLWEx/SyCl0ySuzagdZ3bhbKw9y4Vsp6p5/29BVD7s0v7cVgxeLgMiKuwJ1NCLtDaTPhFlU1wGvg0o0+iFrUBhAjD61uTEa//3D2G1tQToozmAErbnhnV0mkyQyVmvGp9kPOACH558WRdY5VyBQ5VQo8IO2Y1JbmjutjccQcqUZcL/Xs9/YugjH2M0FTYRpv1cV8XIwYYNUmWR2VCA5NYCJtgUPZvgG8YWy+J/GuRnjuowT4qlN2W+Rsd2XwFuSPKxC/GiyVja/PvjYK1dVeBbC76RXTYeOhaIgjYDu+vgbndpWPcLb7S5iH+XIczFTugsrfsMIJj52GOrejOmP2xrAyIZ8XwSY/xP9ILAnwah3Wx0bA/VjewNrLZyscxzPuNJ3Z6EdYhNU2KHBgCbzj2PEW8oY1WgiKpP31hs79yC16SStugNH3cQWiOPrhL+fbZrEypGjJgStS1zGydYpe3HtlnKc3Cp7UL7Kgg++U2ALRQd7/Ipwv4K2BJPeMvDmBgxD++O+Se5277PXYZWvLEDmSh6zs8cm/JvCy2hj1QzUOz99/LNheWebKp8UQzoEjkZ13nQNL2FcFCfsOkWYFYzaOpEz/w01054CQtA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yAbm6d9hrQxawMBe8BMaqPti7UPp4SWZ0gpZLfivIdOxVJLgc+7QHr1X7aLgYQHUqTU97U1piNabLSB0Y7F/f3+ykA8kYpIpEgd5oo48BTpbxFdILv3ZIfcAS5gNrjHH9vhLlBlza7y1LCk/n2/Dlmm1BoMAsVkqyxMmBVwOW3GqvUawzlZLUiQ6Or2QBlzdZkS5Q2KGatyGPaPZ1kaSwXy9ryHmOeSgcE6HDv71jlFFGzbwMh9cW8F3U1KIDEX3WOw1OnkU3x/4Zdasr0m/ytzRWhq6DXmZPMjMBJ1Jw1yVRBLWgZqaH49/z/41lz7jJSj053bBE6qVTPcTdjkYEq6mwzX6d3VGeGgKaGilN9qSXbeCmAXvwwmNRVr8Ls7rzvzhsvaSLJ2eAxYP33ohEZDOO9Z8WiqY3iWBGT37K3GF5ER8bwU+5Y1H3i6TTrR/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:16:34.4457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e40a04f3-6e0c-45e2-4869-08debaf6b7ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999165
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
	TAGGED_FROM(0.00)[bounces-254258-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 8123A5D1A08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Harry Wentland <harry.wentland@amd.com>

[Why & How]
dal_vector_reserve() computes the allocation size as
"capacity * vector->struct_size" using uint32_t arithmetic, which can
silently wrap to a small value on overflow. This would cause krealloc to
return a smaller buffer than expected, leading to heap overflows on
subsequent vector appends.

Replace krealloc() with krealloc_array() which performs an internal
overflow check and returns NULL on wrap, preventing the issue.

Fixes: 2004f45ef83f ("drm/amd/display: Use kernel alloc/free")
Cc: stable@vger.kernel.org
Assisted-by: Copilot:claude-opus-4.6

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/basics/vector.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/vector.c b/drivers/gpu/drm/amd/display/dc/basics/vector.c
index d4dcc077854d..4162f1f0383b 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/vector.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/vector.c
@@ -289,8 +289,8 @@ bool dal_vector_reserve(struct vector *vector, uint32_t capacity)
 	if (capacity <= vector->capacity)
 		return true;
 
-	new_container = krealloc(vector->container,
-				 capacity * vector->struct_size, GFP_KERNEL);
+	new_container = krealloc_array(vector->container,
+				       capacity, vector->struct_size, GFP_KERNEL);
 
 	if (new_container) {
 		vector->container = new_container;
-- 
2.43.0


