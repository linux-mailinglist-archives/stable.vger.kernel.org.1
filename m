Return-Path: <stable+bounces-114726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1FAA2FABB
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 21:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650743A8B8B
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 20:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4980F264638;
	Mon, 10 Feb 2025 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="XrwmZvsy"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4916C264634
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219299; cv=fail; b=eJ3Xi2oSkrPgYsEhodmV+tJ5CeckLx5YEMtgl6YnlrOB39aDDQL+WZz0h5pCVOB7NofoIucMjYFM3HkaK5fdEJsurN1i7wV2YZmadSBXe/zSE03jAYLe60ulqejqWJ84z4uf73IMM9BTsLsyiEpyAkqJ31g3qxBKd922pRVbdio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219299; c=relaxed/simple;
	bh=zJEil7cma1jy4p8U5n1/pIsuBQqGnZhH0M87X/FOlpc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCyYOwMz7Cl2VC6CYMWMK5XMxA++4LjCbvMqEYlyiOshJUx9J+fn1KncilxPD3m6GNSsgdBomd15EgbDJ8qNOf21Oxm7lTKDnKYKxJGUpaJSIg0rxOHXWfDuoqZHg6Qb4Nt159klStU5LlepR272dCoqut+04eZoTzTdOPjHP74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=XrwmZvsy; arc=fail smtp.client-ip=40.107.105.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZMHIwF7uiKjQcNGafyBZaB8r8ckQNIuugRvR1MK2tPptXrqCsfjo3dQ0vvRSjdLPxQ37Ydr371nky/DW8iZGHGCsH9VZ573L6hOE0xqh6cNwQGI/6BOGN0x3nFCbUpCEmZ1SevI7GnejaUlmd91YSzcplhIvo/Cq7biA3UxVT/A1fuSXJzdNYEQ+eAW5TqaDM9f/VF+MfUK0R7gpu6MX+dIQdX+R6p+IsS8iAR4MOUWHkFaLLJGq/rS1NhsvU+fuuLtApxLdr9+WtCV1C+Qc+YlkhrMrT6ds6Iajz+IJyeXHxFvCSgcLDYTYCr5Fy0KGEc7AvT2YY0GM2D9/fBhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4gOYqjiB/0oB78kLCTTdpvRH3XDsUfzgujJfx6NIEA=;
 b=xPO2Pms/kqthEQVe2ooVBrPs2D6ADl3u91LPPH6+2Cpi2suIlL3pdKjw8eFiuH2vHaqC1i6pGjx45NepdQWPsaYJEd1eZRDDHmsk3s79G4Vj6Gl4/ols+JXIWBPDWzySa/dTK3RNX0qP1lYiCx0KdDaqQ641OZD9K0t2bX0ah4BvgOkFdmk7aQ+7Qho7mXbgEKM2joxdsAqhHEmwYA+YyiHQ8pLed1ePFekKTSbnZ4SJa/6xjoRc3rWzkS0T852hFyke99mjeYYm3qPb3fV3rGlF53irafVAA3DwV94w7Uza+S3zk8erg7MyGicdOa/X6E0ztqcitDUvSW2+GE1j1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=ionos.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4gOYqjiB/0oB78kLCTTdpvRH3XDsUfzgujJfx6NIEA=;
 b=XrwmZvsyUhdHoVk74sScYaUErhKzfHKGVndJ+vQzuEr8UF1UrzGyKTT3E7NjXjCfggAfADo3abxEnDmr1G/LfsRx2foX2bw6yPWgU5tJR1g4WIp1mWvAsd5E88MN4j1kbX/W2vpWQizUOC92urUkFcJ/Hp/f+zne2kLfpC8DIZk=
Received: from CWLP123CA0124.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:87::16)
 by VI1PR02MB6255.eurprd02.prod.outlook.com (2603:10a6:800:17d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 20:28:11 +0000
Received: from AMS0EPF000001A1.eurprd05.prod.outlook.com
 (2603:10a6:401:87:cafe::fb) by CWLP123CA0124.outlook.office365.com
 (2603:10a6:401:87::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 20:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001A1.mail.protection.outlook.com (10.167.16.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 20:28:11 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 10 Feb
 2025 21:28:10 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 10 Feb 2025 21:28:10 +0100
Received: from pc36611-1939.se.axis.com (pc36611-1939.se.axis.com [10.88.125.175])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 8EBD31E1;
	Mon, 10 Feb 2025 21:28:10 +0100 (CET)
Received: by pc36611-1939.se.axis.com (Postfix, from userid 363)
	id 8A70962794; Mon, 10 Feb 2025 21:28:10 +0100 (CET)
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: <stable@vger.kernel.org>
CC: Max Kellermann <max.kellermann@ionos.com>, Christian Brauner
	<brauner@kernel.org>, Michael Forney <mforney@mforney.org>, Theodore Ts'o
	<tytso@mit.edu>
Subject: [PATCH 5.15.y] Revert "ext4: apply umask if ACL support is disabled"
Date: Mon, 10 Feb 2025 21:28:01 +0100
Message-ID: <20250210202801.2415267-1-jesper.nilsson@axis.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <171468877064.2998637.14217086529278734176.b4-ty@mit.edu>
References: <171468877064.2998637.14217086529278734176.b4-ty@mit.edu>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A1:EE_|VI1PR02MB6255:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f2a83e-dd92-407d-a753-08dd4a117012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yb0v28pS96ffHSYEGisZrKavl7YqJMuQe4cYx6fZnJA/NakhZndl0Sr3HZC1?=
 =?us-ascii?Q?GbSOQWdfzguG9mzJYcsjkjr9P8Pyio0i81hW5Qns0JhLo5SoGTp9ofJAT/Z1?=
 =?us-ascii?Q?oMl9IrB5E+33jYdjXuNjLYSce3LvXNZsSfaxpKDMCtCr3gF/vHODMrE/2gNN?=
 =?us-ascii?Q?qXYhrp6PTe7ejzVu6Q7+orOp+t3Qig+KljWxePJAQQzU+uAWvM77pNTv4jWW?=
 =?us-ascii?Q?AUpkMY1uGkf4dOihjOUhDGBaI2OYAf82YVAvz+bFFhpppIT7hwMd4Fyo+vok?=
 =?us-ascii?Q?HyqYcqMDu2HVLyu7izGj2gCxGwr+4u9WMYdMUwk6dvXOJtnsslFDvCcz+jEo?=
 =?us-ascii?Q?VNmnXAsfSkLjlvp+Ni8vmq7C55Ea1T9BwGNZmQ/cuBwqVCPzD83paU4RvDOd?=
 =?us-ascii?Q?et8tWeqavZ441ybOu/nCXdptbFA3nEFvbx7srP084DR2Rj+Ulo3UjBc6nAK8?=
 =?us-ascii?Q?pGtOqIx1FKy+U9r5NkJvFhui3kteoPjZVRkQZC0dA6ytqdeo7OOyPQMyrV6k?=
 =?us-ascii?Q?dYOCn7YO3Kp/qL368mBveZbI2/jYtlp/caKzBIX3hSYyFRNu+2nSUEi9x0mt?=
 =?us-ascii?Q?hh27WSlcl6vCTWzLi/GhYfc8LFPN/SSl4ZRnqK6cQdtYS3/aEC1XL0xhHIFY?=
 =?us-ascii?Q?EgApQcsJx8VOYkMPxWg44frGrQlT+p3mt+6XX7fZ70NkmIh9f46zQs3Y6eMr?=
 =?us-ascii?Q?8DkSmgHKkNXndOG7UFcDXIuHycKIU08PQnz9Tmdx0Ey73gY9uU2BcuOmqKUQ?=
 =?us-ascii?Q?MzoiuLM/jcYLJh/o2k7bfOz25e9C4LIIgQ6rzA6sBStZ9CB1h73321XmeM0N?=
 =?us-ascii?Q?eJGakzTPYkkWAZp+WLW50tLx4go5hxiKc9EahDY6GzXQVUy8fbaVmiqji+VU?=
 =?us-ascii?Q?+xO91IlBfb0oDwAXWuCbEVokzMbayZfJ+PrRDJv1L9SbtcomXhH+9jYqXRFR?=
 =?us-ascii?Q?UscFRN38Pp/6moW7eG8fhqEZNXkhHZvU80SSSz1mGatcivQTqqfihBpMUEzX?=
 =?us-ascii?Q?864v9dFX9O/jPNAWhmZdq7+0/YBYBsTQO9rv9c9Lg7RJw2Z9PBJrpQEA7ryA?=
 =?us-ascii?Q?FbptTRk4MmQdHVZG9uuFGVatys2B91mWdZTQl30sbszkrnnW6MFi2NDU7ayz?=
 =?us-ascii?Q?Ey7LnUj+NJKZSNNv5aP0bzoWRI0M2E64c3Q9nBgtcyN6Oc7wIotPzimZvxgH?=
 =?us-ascii?Q?8rfbV+RPb80ctbYK7hU/mBO6rSeZRbdEpOBBIgkijB4aOJs5onjjNfx1LLZe?=
 =?us-ascii?Q?BB5SnzIDRLHZkENNIFCefSi9GY37hCrjdk3+gm4vjpZIiC7CloV2WC4e/Hnw?=
 =?us-ascii?Q?SV2HJ2j/ZrMzo/qNtjSOywcPGURPFLNWrlyuBZ/443lbbXJoc3uoGBDtvKjq?=
 =?us-ascii?Q?UP8SdRZ/r+Z9O1btHOLeNBCumiX1Zuf/6PpWBtYqwgYrTJMgzC7ok4ilVeJd?=
 =?us-ascii?Q?Ouz2jVbn7jA9za/0ALKmV8/0uPtBilDya8o5HYhEKwG04ayJpFV+OwzvZWp6?=
 =?us-ascii?Q?6cdKSqgpin6DQKk=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 20:28:11.1179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f2a83e-dd92-407d-a753-08dd4a117012
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6255

From: Max Kellermann <max.kellermann@ionos.com>

This reverts commit 484fd6c1de13b336806a967908a927cc0356e312.  The
commit caused a regression because now the umask was applied to
symlinks and the fix is unnecessary because the umask/O_TMPFILE bug
has been fixed somewhere else already.

Fixes: https://lore.kernel.org/lkml/28DSITL9912E1.2LSZUVTGTO52Q@mforney.org/
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Tested-by: Michael Forney <mforney@mforney.org>
Link: https://lore.kernel.org/r/20240315142956.2420360-1-max.kellermann@ionos.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
(cherry picked from commit c77194965dd0dcc26f9c1671d2e74e4eb1248af5)

---
This revert never reached linux-5.15.y, and caused the same regression
with symbolic links. The original problem is just as the revert states
fixed and the test program for O_TMPFILE works as expected.
---
 fs/ext4/acl.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
index 0db6ae0ca936..3219669732bf 100644
--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -68,11 +68,6 @@ extern int ext4_init_acl(handle_t *, struct inode *, struct inode *);
 static inline int
 ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
 {
-	/* usually, the umask is applied by posix_acl_create(), but if
-	   ext4 ACL support is disabled at compile time, we need to do
-	   it here, because posix_acl_create() will never be called */
-	inode->i_mode &= ~current_umask();
-
 	return 0;
 }
 #endif  /* CONFIG_EXT4_FS_POSIX_ACL */
-- 
2.36.0


