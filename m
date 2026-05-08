Return-Path: <stable+bounces-244722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHBkH6at/WmlhgAAu9opvQ
	(envelope-from <stable+bounces-244722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 11:32:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBC94F4495
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 11:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C23CF3044BA0
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 09:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C69355F43;
	Fri,  8 May 2026 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="u4vhhPL9"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011055.outbound.protection.outlook.com [40.93.194.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7903A5E8F;
	Fri,  8 May 2026 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232582; cv=fail; b=QezuHHHGtyxgBzFufVrm4yIrX2JBQwsi1G3nd7gXcXkEEp0tAwKdLVTvfinkDUA9DQUCqKDtx0wafdasHck1Fi3RkVXbqfaFXTX4nUiWfX9r+dLzVP4i3LOWB10LFcN0NnL3YSfbfgPyIL0uSm9vjZ1i+xSkj9TQaplDRCWv9Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232582; c=relaxed/simple;
	bh=6JSPI1DCGeZ3CXyFmUqOe+VRHdbTP0bG6WjYatns9KY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FexxtpyO0OVNa3tr4yOInqZG06N9OBh6vQTnkl+U2hmdLvq6wvZncQvgJziqTIlxYTUePN5URLh9fuqxAOMIhrVMvBRgCtjXEt9JTpMr9BwD8NxMySwR+qtrP+L9aY+hao4MMFsNyJWX17Qq+P/3bOw0nNghH+UyO+ZGhLUREj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=u4vhhPL9; arc=fail smtp.client-ip=40.93.194.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFRaW3krZm6f6P77s98jXsgE/q/GcFZOeQmSeS5cm/bQQDEPtKsR+x560eM+APyYaPI2KWBoh8lv5/xTdZB1te/Sb5OEC0hrJxzT+IF3/bvBWAYOH/hZ7BrfqI7NxFW6+1AYkd0x1YdUawXsaAwh+pB5lq6VZQpN35oE1oBDvPkPA9veB94FGmdOdv0p1veQXLj/HUJ7UDAOv8m7uTM1+44ASzdir8wI6AaAohYf5UM6BBB904of6Kmn/3CmPsa862UlMDfkelrWmoubkjv7eJO+sqlKHKSGVlrAdN0ey/gQdnMCxrlqnGR3aDrcwpFWzyZDX0H+d8v2xiy8jxDBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxoC5n0vmhogcKXovAajqEueUzigAx8ThYjIPGkLJl8=;
 b=nTbNdmo+roPNAXHuwY3rGclTiOp8nvxXBVcG9qxaawT5FcGxSN4/0fv8oPiBouupUZNsbglcb4JFvomdz8/1O9NYfjsppX5jl/1e2lHsf1/mt+bsHg9gkpArtu6jebivVLxKocihoMvaY5PK+7it5hRXUgTfCivq7hFJsyltZ+jFrj9kgJJ56esXQyzas+/rC5YTDlTqyEgtMHagbzDO28RWaW0KKMi5CRB7TnrKpRjACo392O2M3GT8LmD9Jij+MMkQ4Kc6v1rurb0yPcjsQvioh33/zLVQJkVozZ/tmRNXncIAI53Tpw+zkdyomdlbhNHfxPPWeO7NMW3kG0nwSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxoC5n0vmhogcKXovAajqEueUzigAx8ThYjIPGkLJl8=;
 b=u4vhhPL9eY5np4DvN+twfK05TCzh/KEJjJsSvtEOhGFVXJIWQHvsDymPFM8qwyQQlELJUsVmtqq3YW41Hnk2/aPqNja/4T1EZSfbN6EfnJL09FSVR9xy6Hp1bYLW5uzXDvG4tH6ETG/yL0zWsu4Ch/Du6OjirZuimGIfo9BfOZiH+ryCIdkPIerFhR0/V694ytmjoN4+DjjnUVMFm5kZ6p202fhR2COXGIAPyABEYvcloa5k2jG8doiLDLomupDbGoyp9O6bEuNX+Bki40k4Kmy3CJOl07aMYM7mm4intk+G4zEPB8kuDuVuueFJU2gUf7cXjXOFQM7BWjOs4DKuKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BLAPR03MB5458.namprd03.prod.outlook.com (2603:10b6:208:29d::17)
 by BL1PR03MB6197.namprd03.prod.outlook.com (2603:10b6:208:30b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 8 May
 2026 09:29:38 +0000
Received: from BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656]) by BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656%6]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 09:29:38 +0000
From: Muhammad Amirul Asyraf Mohamad Jamian <muhammad.amirul.asyraf.mohamad.jamian@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: Mahesh Rao <mahesh.rao@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Anders Hedlund <anders.hedlund@windriver.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] firmware: stratix10-svc: Fix probe failure on old ATF with sync-only fallback
Date: Fri,  8 May 2026 02:29:36 -0700
Message-Id: <20260508092936.18380-1-muhammad.amirul.asyraf.mohamad.jamian@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0057.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::34) To BLAPR03MB5458.namprd03.prod.outlook.com
 (2603:10b6:208:29d::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR03MB5458:EE_|BL1PR03MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c1ccfd-96cc-4236-afe0-08deace4533a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bVqKzO4it03KgjNRavFEYTaJCRIhu3sQk7+xvYqbB1SUCJAv5o7tN4ZeIXnrnqWYDgrgiLMqRo7zCnhGumeZIK85k18xJW4QUT1IDNarVZiprh1USulGTGOP0d3uCV/lkqLCgE7RJoe1ujaXC1292fNPgXCqL5TVcESb50DgYwFUo/ne3iux1erN9JVAYfv+KJZY2f3QVJSeADt073huU2R0YRyY8W9TSwHYN3DlhgXb737Y83YgJgdTuDC+DhR/RHHPaTJB7qV6yPFfHbAJKPf8vsWpR5laozviwPqs9QkMnNFfHQy1aBaozJ3dpmuGFoZ7MeJT0YC4l3G9305Af8Tzz1YabYsyvtgw1yeaLxzmf3VayreB881GMGXnrDJ4olhdzEgx1lIhoiS6XERIbRIQUzYTIc69ooXK9GkApwUtrVvI5epqnDlFX4ghUvuSQSq8RWIsihiisdkvx5L9x/t2pKtkxQE0+PiyMD/UB4g0jBpJFuZvw83K41pDwWR1DMa4bWAxSxUZoGSK2ezCw/3sDR5lvI0mpPOsgWz0+5oVlLafxdm4cEXZivIN2kPsr8+Gd2LQlajRsSBzupu9gIjQq7wnsu7LoyrmWuWpVCn84rslL8lwe2T88+q8S8N9ATWaNVzkYULrhFySVeWc/QR/Nb014kujKwe2vVGWH+vnWyW3uxvDJoYicsNKyoz/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR03MB5458.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X5UcF2om08Czu3I6EHYEb4VsfSOdhCikeANbFBMrCsziLDmWBWDw58v6YMxq?=
 =?us-ascii?Q?I3U0ArE9i2cO7bN58seTtADjiVEoOuCEoMCsx36dlcFjiF6xD7hVvNa8NaG3?=
 =?us-ascii?Q?tQUQlKCqiDe3M08ZCkJ9lmb8cW6XE0nnjFNesOgleU+IZ0RHo2/i9TnWAIuk?=
 =?us-ascii?Q?n0ByH89Jc6lSGlaUl5lSzrJUkkbycJi4BMW9gvvxzNTddHPn/DbUdSUq7FLV?=
 =?us-ascii?Q?BZQgnN6drryhLBnQVD963cSsXcp+02UGsfoqRxWVrf2IFOH7qFftP9xAp/01?=
 =?us-ascii?Q?QS5kHi0eUeb3kReJOsat/h52I9OTsU/PaP5ZfuWAHSRcX3guuvrSMRyZWGeK?=
 =?us-ascii?Q?xyA6AQ3bCzEhoj5t2AJjWBYO8eicDSF2I2ft/7hyTt44ZWsolOuf6W7uaM3a?=
 =?us-ascii?Q?mneXTdTWe1JIW2qs40fzkBXvLrLSa+PBT7XDsaDDLSLr9QYUxmkJdk6O0wdg?=
 =?us-ascii?Q?pwbQv/HYEidC0yqJIodFfJ/K7Ou3Cf0mAGd0scMaw5y280YJ4ZS/fMD7bGen?=
 =?us-ascii?Q?zrVDAHvSCKPhyyZWksqF1WQfRJebrzDnQ/KaP0srRSP8m3viDe5gHdDoXrQW?=
 =?us-ascii?Q?YX6UiTT2JRg7B39Lh2rR1ptPaSqcN8P7t60Alu0uCmE7VH0HbihQJu1DW0n1?=
 =?us-ascii?Q?fqVhKvwHwY6f4cmHdJhE7BcRRwhifCHS3rO4ck+vfr6CZIuWjqFo5LZK4h/T?=
 =?us-ascii?Q?AihXkOQTflpkwcDYrpMTcR3I0xD4H3ziO053q4TAdgp1Aa37EHpVW4V7kMMi?=
 =?us-ascii?Q?41b5pIgXZm8OxyqNXuCD6YgTRFTS3xe5G2E592CY9yLfurj7IUHxscqyMIrT?=
 =?us-ascii?Q?6+DmZVi4u6c1YCk1ZoCcSNM1teDZ61r5X7CuK08qkmCTaiyxmGuuoPui6GL9?=
 =?us-ascii?Q?MmnJC5BOM0sRoErbrCEFcvRLzhkE7x7t89Kw5i9u+JAkPknefz/RlGXmXk+G?=
 =?us-ascii?Q?zk9hyIl2/4xhJOZD5smmVVy24OmvorbSWMzj9BBgde/VZSiqn9FJzqzSXAsc?=
 =?us-ascii?Q?eC15mpK/h01ktoS8e785P3cxD7PHMSPgiFXpS41rdQXo712QUhFNLNStzSWM?=
 =?us-ascii?Q?W/w2DtF2Q//2eSntTaGpZPfMtf+bSZJ6v4nMMmmTk/3BwYI/jzagYeqXcK8W?=
 =?us-ascii?Q?l7HBg8kE/f0YH0Th9o66tSQBOXY990nGXREwrnij2y2x8/v+fVaGgQU9m5c9?=
 =?us-ascii?Q?o6MF8qifhOVuEWpUx70MBlp4DfOBH8jOisfNdTRuVrOXFAiZNKRsox7/JY/q?=
 =?us-ascii?Q?6nAK8wY4BqmQvkj2YwcwuODHTHmDeba/vcnDMcNY69PzbR/cUvg5hX2WJ7xT?=
 =?us-ascii?Q?Uj0MKaez9biKvFpeOe21GV/D6SP9/kNM1hcCQGxaXVv5z5CgEOmimM5eb6Yi?=
 =?us-ascii?Q?6bnKF+j771XgzYa+CGWUPihfqqqvGBeA8DzH7YiBb3SHa9Y50zF6v9mMveWJ?=
 =?us-ascii?Q?ZfnZYinzMyO5Tei9wygMAyBpWY1ypBSVqa7mUcuLxI/G8vQ0cUm2Ho6pu5Vx?=
 =?us-ascii?Q?mxl/7qb6gHrilZvEJG6bb1lOW6p8RD7srBgBMRnGrS8j3TwgtRdEpQ4SA22O?=
 =?us-ascii?Q?ZKtGrcGJXNVyEcwsfUAn+tgQMlEdl01fPxMbLpVGnwiV8cp0dQWP//6gUqfx?=
 =?us-ascii?Q?Hqxvvf/Jxqdlfp5Zq8xH8mdnLt+MDSUhx5cCRWemFzj+bWaK6twTFHHBVBi/?=
 =?us-ascii?Q?UP/mnRxCOJJSFffochogP2dq0tY/AJTUpr8vUS9+wy7COfnHu4+wJ2hxyTz9?=
 =?us-ascii?Q?MNKEggz8FfR2LJTmabnXjXjfyHIFXKl4YWxikyeKUIMcXDuZPYAQGO3GBh9T?=
X-MS-Exchange-AntiSpam-MessageData-1: WRxpX8rPAOzqxgP50J6DkdoqMY2f1tJ+8zc=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c1ccfd-96cc-4236-afe0-08deace4533a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5458.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 09:29:38.7969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDTPyrF0kI/qkW3e2sCAvGwfln93Qj6DlWNPPyjMK7ErA71iMqb+NSkHsTHUDAVs8FgjGyskmRTCDGNE5GCUjDWotlnJ9+TQjt21dnFzCr2GL84N2gAKMg5vIROteBODfJqEj+8ZWUJ5BRO9iPYgaF3nOexwf+W7r59vZ1NgGiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6197
X-Rspamd-Queue-Id: DBBC94F4495
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244722-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.amirul.asyraf.mohamad.jamian@altera.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:email,altera.com:email,altera.com:mid,altera.com:dkim]
X-Rspamd-Action: no action

Since commit bcb9f4f07061 ("firmware: stratix10-svc: Add support for
async communication"), the SVC driver fails to probe when running with
ATF versions older than 3.0 (e.g. ATF 2.5) that do not support SIP SVC
v3 asynchronous operations. stratix10_svc_async_init() returns -EINVAL
for old ATF, and the probe function treats any non-zero return as fatal,
causing:

  stratix10-svc firmware:svc: probe with driver stratix10-svc failed \
    with error -22

This prevents all dependent client drivers (hwmon, RSU, FCS) from
probing even though they can operate correctly via the synchronous V1
SMC path.

Fix this by:

1. Adding a 'supported' flag to struct stratix10_async_ctrl. When the
   ATF version check fails, set supported=false and return -EOPNOTSUPP
   instead of -EINVAL. This lets callers distinguish "not supported by
   this ATF version" from "programming error / bad argument", and
   ensures stratix10_svc_add_async_client() propagates a consistent
   -EOPNOTSUPP to client drivers.

2. Treating -EOPNOTSUPP from stratix10_svc_async_init() as a non-fatal
   condition in probe. The driver loads in sync-only mode and logs:

     stratix10-svc firmware:svc: Intel Service Layer Driver \
       Initialized (sync-only mode)

Fixes: bcb9f4f07061 ("firmware: stratix10-svc: Add support for async communication")
Cc: stable@vger.kernel.org
Suggested-by: Anders Hedlund <anders.hedlund@windriver.com>
Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
Signed-off-by: Muhammad Amirul Asyraf Mohamad Jamian <muhammad.amirul.asyraf.mohamad.jamian@altera.com>
---
Changes in v2:
 - Squash both patches into a single commit as suggested by Dinh Nguyen.
 - Rewrite commit message to cover both changes in a unified description.
 - No code changes.
---
 drivers/firmware/stratix10-svc.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index e9e35d67ef96..39eb78f5905b 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -212,6 +212,7 @@ struct stratix10_async_chan {
 /**
  * struct stratix10_async_ctrl - Control structure for Stratix10
  *                               asynchronous operations
+ * @supported: Flag indicating whether the system supports async operations
  * @initialized: Flag indicating whether the control structure has
  *               been initialized
  * @invoke_fn: Function pointer for invoking Stratix10 service calls
@@ -228,6 +229,7 @@ struct stratix10_async_chan {
  */
 
 struct stratix10_async_ctrl {
+	bool supported;
 	bool initialized;
 	void (*invoke_fn)(struct stratix10_async_ctrl *actrl,
 			  const struct arm_smccc_1_2_regs *args,
@@ -1103,6 +1105,7 @@ EXPORT_SYMBOL_GPL(stratix10_svc_request_channel_byname);
  * Return: 0 on success, or a negative error code on failure:
  *         -EINVAL if the channel is NULL or the async controller is
  *         not initialized.
+ *         -EOPNOTSUPP if async operations are not supported.
  *         -EALREADY if the async channel is already allocated.
  *         -ENOMEM if memory allocation fails.
  *         Other negative values if ID allocation fails.
@@ -1121,6 +1124,9 @@ int stratix10_svc_add_async_client(struct stratix10_svc_chan *chan,
 	ctrl = chan->ctrl;
 	actrl = &ctrl->actrl;
 
+	if (!actrl->supported)
+		return -EOPNOTSUPP;
+
 	if (!actrl->initialized) {
 		dev_err(ctrl->dev, "Async controller not initialized\n");
 		return -EINVAL;
@@ -1562,6 +1568,7 @@ static inline void stratix10_smc_1_2(struct stratix10_async_ctrl *actrl,
  *         initialized, -ENOMEM if memory allocation fails,
  *         -EADDRINUSE if the client ID is already reserved, or other
  *         negative error codes on failure.
+ *         -EOPNOTSUPP if system doesn't support async operations.
  */
 static int stratix10_svc_async_init(struct stratix10_svc_controller *controller)
 {
@@ -1585,10 +1592,12 @@ static int stratix10_svc_async_init(struct stratix10_svc_controller *controller)
 	    !(res.a1 > ASYNC_ATF_MINIMUM_MAJOR_VERSION ||
 	      (res.a1 == ASYNC_ATF_MINIMUM_MAJOR_VERSION &&
 	       res.a2 >= ASYNC_ATF_MINIMUM_MINOR_VERSION))) {
-		dev_err(dev,
-			"Intel Service Layer Driver: ATF version is not compatible for async operation\n");
-		return -EINVAL;
+		dev_info(dev,
+			 "Intel Service Layer Driver: ATF version is not compatible for async operation\n");
+		actrl->supported = false;
+		return -EOPNOTSUPP;
 	}
+	actrl->supported = true;
 
 	actrl->invoke_fn = stratix10_smc_1_2;
 
@@ -1952,10 +1961,14 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	init_completion(&controller->complete_status);
 
 	ret = stratix10_svc_async_init(controller);
-	if (ret) {
+	if (ret == -EOPNOTSUPP) {
+		dev_info(dev, "Intel Service Layer Driver Initialized (sync-only mode)\n");
+	} else if (ret) {
 		dev_dbg(dev, "Intel Service Layer Driver: Error on stratix10_svc_async_init %d\n",
 			ret);
 		goto err_destroy_pool;
+	} else {
+		dev_info(dev, "Intel Service Layer Driver Initialized\n");
 	}
 
 	fifo_size = sizeof(struct stratix10_svc_data) * SVC_NUM_DATA_IN_FIFO;
-- 
2.43.7


