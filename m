Return-Path: <stable+bounces-238266-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKJoHyuP4Gl6jwAAu9opvQ
	(envelope-from <stable+bounces-238266-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:26:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 281F540B038
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3897D318E1B5
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 07:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D706338A70C;
	Thu, 16 Apr 2026 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="OzS9vham"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011071.outbound.protection.outlook.com [40.93.194.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5112137F012;
	Thu, 16 Apr 2026 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776324138; cv=fail; b=pYZOv4JIo8+cqbRGLGX3raTKBAb0rYb7a9Ixyah9b0gzNe4DyzEk7K4shltIvgYO2QlvUuLwkkBml3tJ1nwHy0hl+POQpetg4KEzU2aG1GDjSPR0yHY7QHPTLdkwXW/9ggbHcjtZebIZ3kZ0+5Aw4BA687IvrkMYqdDpre8flaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776324138; c=relaxed/simple;
	bh=KINaAtfYnKhn6OvGnj/gOH5WjLZwi/Q2OG+PoEoiz8A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SrQlyYTIDs9AtGBTes0JXfjLWIzBgznGxpuQ688jkNoZaZ2L78T//uk/DnHI9gG6FAsJ0HEiJRGJ/LUiCk2RepiOtx19MtlyoCV22SnvV3heZGLl8caz2yrgbFR58E6yWVpN5k94ExDIY/E9rh1gKh+2s1FOyEUWGceH+aynfFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=OzS9vham; arc=fail smtp.client-ip=40.93.194.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQrMbnZqF4p6LdooW18xApaytnet+2L+bs7vgjWQNmAUsuP6JxewQmJeLzMWAYXkIS5vpvoUnWRkScZJoa8TMlieB6YGaVlB5gr6Xmoi5aW8HqtBBhQGdodrdkmqWAvOOqqufAkzpSuym1d/vx8wJKjUF48kU+V8fdbFAwMbWtECqTNWXGhbsT7E9jdZOahVin6Q3dKmogI7bRD+Zoh0jV1rdw1R1TKLovRymwSNqYDDpmai2fXc+TygBSv4CLDwUNYGpliux/oFU6aiw9dYhvvC50bT1BF3gU/xbxhrNG7WGLZ91O98oU4ZkPrte9dVBsn0KRgFSbOE9ywvxuPn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Mw/uUnQY/FEZ/XJPjjeullVp2XPsV5J/WoaZw5guVY=;
 b=Edh1d8QCC0/vwCBxZ83xyRlpcKLqP0JluNn1pj4tyBb7H7hCg1y0Z8VzLogXsr0IXKwnKVMd4exRYQbJsa2sgo62+fJD5pk+yI8EmJ/8P+i8O0kCJUjH35cjcgatKo9PINRy5/dfnpyy0jNOROxHGBsUxEcTYhpi2Jmz85AkdPprDimomQYC5xJK4Wu3rQsXnJva/Erpgfwfa3zVhYnB0YTtkwwo8pK5cjfSgGrO0joY/R4qHd9KkIjLRKQVlqKSrNOAcihqYMHPP60B0HW2zM1YgMWamochn3a3xqtHalrrq+RdJDQr8y5wp7449K6yDhyp1V/03aLnXBkAs4Zs8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Mw/uUnQY/FEZ/XJPjjeullVp2XPsV5J/WoaZw5guVY=;
 b=OzS9vhamncXB8I4tVgqg3eV4p9Vgf/lS/v5Il6UKm84jZOgyLdbQuqZqZHNx2xfRMrxuW/aGi6BBXkta/4CUZXFbMgA0NnHwTfdZ86NKRWkOPMvIwlpEel4rGf1RvmF2tYB29hOXbAyoSl4T7qmi/4bibYjTHcA3yCLweEnEcMWtQj50yiteJyISJDnbGJ5+Pgw/BKtGWbbSK9jkHYk/ao7IMPn6wlKZ9TCn8WCG78mBEr/ZnmhhBhIoEvGRETSYJFwrbMvXYKynbPSgdmzzho3fZ1G/q+syC1DWu+hVHQxBCB89Hjqd3f0r48eiQ73cE+NAmQ+ABz76XKowV29bZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BLAPR03MB5458.namprd03.prod.outlook.com (2603:10b6:208:29d::17)
 by MW4PR03MB7011.namprd03.prod.outlook.com (2603:10b6:303:1a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 07:22:10 +0000
Received: from BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656]) by BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656%6]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 07:22:10 +0000
From: Muhammad Amirul Asyraf Mohamad Jamian <muhammad.amirul.asyraf.mohamad.jamian@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: Mahesh Rao <mahesh.rao@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Anders Hedlund <anders.hedlund@windriver.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] firmware: stratix10-svc: Fix probe failure with old ATF
Date: Thu, 16 Apr 2026 00:22:05 -0700
Message-Id: <20260416072207.27074-1-muhammad.amirul.asyraf.mohamad.jamian@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::6) To BLAPR03MB5458.namprd03.prod.outlook.com
 (2603:10b6:208:29d::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR03MB5458:EE_|MW4PR03MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aff7809-1fdc-48c3-9cc9-08de9b88df7e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	pT2p5KD+RUPInOs4Dcp3ck0nCiXLTyYTJfvOgmQOm8Dok1j6S7ZGXIpv8RYbBCrOQQ8aQ2SmvG38uj9WxGSTGh2k8uabDBQ+gk4i5gZ9bWqe3zRcIzew0kaE0Mbx9rw/R/Ur2K0xvy91DiUgXAgEBGfFOWO84r25VXffa+fEJgTXDHr5QrcrHjrxmNYD8m3zPQmXpYKeP3axmNyL2A18X/KNzBCmU34xRBOQ+FxtzXhx1kN+ZRdRDZ2x4yS200Cx4muXqfk08iCNnsnPFS3r8EOPku3FILe6Njc9ZceZioAI4mPupZqO1ByRTyHdgFE6IxlYaq3EqBjZOFy+gxV75FlzSAvhmw9qXvZpZS+tgrniJb+/ldjHZC+ihZnr9aoOK+dO5/cZHU8S9WeVw8Uqv5IsqAsi3WaANz+4gt3INWsNWidhdnCvmDh7OHqhGcn4VrmJNpMUH+c5UG5xl7aizFqLCnQW/2JncStPLBacvP7zAdyi0vwhk+b4+/+rnK6awU47gjHpz9/Ir7o56F/Oq1dvIOsQNWvQUAkb9a92bniNMAUnP9sXrraZKWegi6kYJc78IQrfIgXxb7fglIoKNXQ0IAwylP4zrQFvy5Ee/3mS0l+ZzRNDuAOBZ2cHEFPLA435bptDKuCLYl7gUi8KiriNesRllrsPnt9eINS4jHvqxNH6oI4nN5qWM1fB0w4IHV3ir3hn/CF+hP0ZlqCrcNtJ10VAES2o5PATsDQfQ6Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR03MB5458.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8xPxRrpmt7InyY1MwOu5mcIsdEoMT0T127HVv1qjMKDQvby8yJrDIGkB23zs?=
 =?us-ascii?Q?bIqSx1vQUzR6BpS/zj/ifoWkfvVm849izIflW3Hzy2DBJuD4ksVBq6nkwrko?=
 =?us-ascii?Q?vTILF3IlpvCH64KTcvUYwIbMNBwg34tDYW7Cao03Kf8bEomq3t/QhnlvJWVH?=
 =?us-ascii?Q?1Hqb5nUzqwLv37ia360pHp0Q6t8BJLVB/23wHEpvC7W2TIcQ3jtFQXKXh+Q4?=
 =?us-ascii?Q?7zUnbm100wihAqVURJh6t1fQZASKdds/bplAJatHNzNWUmk/2o8X8E6u5nkV?=
 =?us-ascii?Q?5gOE2ny17u7kjqWV7s796bBddwaJJhZ3DCeTxN2DL8bpCU0OJwNUZvop6Y4D?=
 =?us-ascii?Q?BnxkF+ogpwZ1sNCbZr1MBcrXQtDgSOX0teoO9QcnoXup9UEcsnzecvCuGdak?=
 =?us-ascii?Q?VDpC3bx70BJmaailZCIr8DBEj77uqdoERZ+DImGe7ttjplIMas/8K74vhdIR?=
 =?us-ascii?Q?0o9ozc4CIx2p9NEdCPAidx9k9p80Ryts/vUf+TTdJ5hRSfjUdKJsfLRJ1Tm4?=
 =?us-ascii?Q?qXBdtxZCjYtxOOvCgg0LWdDXJMRflcI1qWuObnYcs/HJM2eDISUxI7GDajLP?=
 =?us-ascii?Q?d6Jo92e6YwInD108KcXLa7pQlJnX8WIiuD6d17+C0+6WbPiRU3znuQiueFjO?=
 =?us-ascii?Q?BoONN+8WuGMgAqbHdwgb5XeUHNX7/BdAeuqkvMqCc0gE4QoGxrLIRvQ0SF47?=
 =?us-ascii?Q?bOmwqEmYdrkV1PjdZy+B75qx5qe/B/WMNpKKzDsC6XIrj20BGyrlRZRYwYoN?=
 =?us-ascii?Q?FnlsV4uwQCk/wW059Qi7gWuNGjDMmJyk4Wopt0d8mAHfb3SBfHhjRtdqXS7a?=
 =?us-ascii?Q?dJM65Xhlwinfdw4JL3t8Qumgr2040kSQs4+Cn/Q3Vgt1BhidGoXI9g21ZfoL?=
 =?us-ascii?Q?aIqp8f6p8mftO4VoGJLI5VOVxDBQPtvOiWm+c/rE6tNBZLznIFFjbDxk8Gci?=
 =?us-ascii?Q?s6hsF4uCAyyE1OyjmmFDrlGjIl9n8q2r1V7xmlH5NaAy7CixT8HmA719now4?=
 =?us-ascii?Q?r+crdESPjYT0n+OJ7FmOYP5MmhZHnhb4xytCkF7Zbm3yH8q/aIJtEFO0blSd?=
 =?us-ascii?Q?Q0uYyK0BYyM5YKoosXOBiF1HFsvxNBDmNOb844JWkRjTUCYxbsyocwS4DsAT?=
 =?us-ascii?Q?LA0VNCu8lSRg5qNBwS7MPEmfgFryVlOUrutZ83Ex6q5ZvwjoDr90awHUZmLZ?=
 =?us-ascii?Q?05X6IRkGEXkG4VWl/MCrAu4CBwfxpoQ/TTDafcZgOENNI6hgezos9ycC3Bfj?=
 =?us-ascii?Q?RmOyJMlBIjz3jF3WRmSKRWtHvo0XwSEy6kIr8U5IdFv+JeeYv1EMeZLkka0W?=
 =?us-ascii?Q?Pxwgz3Dit4WjIU+WVluPVnM3bwSL3/n1uvNqtpP9ZIe25O+42HgaIcFtI+Pw?=
 =?us-ascii?Q?UJBzhgfA0WFptfQSDylY56l8GodHlB9OnuMeAwGhDbNnneZdxgeHWoAsx4/o?=
 =?us-ascii?Q?VHRUz6zABli9t2dPmkbI67zZvnG+mrah326FEwR5RKPsfScuey+oXSeZCbS5?=
 =?us-ascii?Q?C12lmL0V6MiBP6y02LqAsI2KooA358G1FsWTay25YpGC4yvjs5xqYcK+YBgf?=
 =?us-ascii?Q?v2kd6r71TCzPO4FG2dMIJhyjPWjJ4Hd+Wsv2yfMFiBR+UBw/+1okIMiUcR/q?=
 =?us-ascii?Q?B/7ixVavnnSnH6bWGcwr20ZmCBnoCN93TpU+esz2On+0YxOUAtwaxd3BFdCg?=
 =?us-ascii?Q?N0rQmLqobb1d6TZLrp9WnOWR/zEpxoXyupXLAqCnk4X+MgK7qz4GZPlWuu15?=
 =?us-ascii?Q?z+KdwV3DQ3+iZHzF1So6Up8Cju1S8HKYlqEHIZLwHSq+RyuLJRxKpubGsA4q?=
X-MS-Exchange-AntiSpam-MessageData-1: 7jJvfn+yFc2B8yi2j+oApT4W5vRNdRiY27o=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aff7809-1fdc-48c3-9cc9-08de9b88df7e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5458.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 07:22:10.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfruNYzOLRq/r/oZ6TtfI0IG0JHUIJXlnxOO1XJZ1XSJ/aDNmvnSPuatw5UmmnhJleG5fWbYRSGA5XJfgT+YH1SLWVcrjXk03bXJgCqJpeIy4AaTsC7fsl79sw8mB0UIwlS2M/hUxFN5LkvEKJuFQ1LbQsOZQitiwNhcaC3gLNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB7011
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238266-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[muhammad.amirul.asyraf.mohamad.jamian@altera.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 281F540B038
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since commit bcb9f4f07061 ("firmware: stratix10-svc: Add support for
async communication"), the SVC driver fails to probe entirely when
running with ATF versions older than 3.0 (e.g. ATF 2.5) that do not
support SIP SVC v3 asynchronous operations.

stratix10_svc_async_init() returns -EINVAL for old ATF, and the probe
function treats any non-zero return as fatal, causing:

  stratix10-svc firmware:svc: probe with driver stratix10-svc failed \
    with error -22

This prevents all dependent client drivers (hwmon, RSU, FCS) from
probing even though they can operate correctly via the synchronous V1
SMC path.

This series fixes the issue in two steps:
  1. Return -EOPNOTSUPP (instead of -EINVAL) when ATF async is
     unsupported, so callers can distinguish "not supported" from
     "bad argument / programming error".
  2. Treat -EOPNOTSUPP as non-fatal in probe, allowing the SVC driver
     to load in sync-only mode so all client drivers can probe normally.

Both patches fix bcb9f4f07061 and are tagged for stable.

Muhammad Amirul Asyraf Mohamad Jamian (2):
  firmware: stratix10-svc: Return -EOPNOTSUPP when ATF async unsupported
  firmware: stratix10-svc: Don't fail probe when async ops unsupported

 drivers/firmware/stratix10-svc.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

-- 
2.43.7

