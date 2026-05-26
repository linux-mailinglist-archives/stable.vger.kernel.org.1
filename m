Return-Path: <stable+bounces-254332-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Nj0H/eUFWpSWgcAu9opvQ
	(envelope-from <stable+bounces-254332-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:41:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD735D5B05
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6757A302ED65
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566CC3FA5EC;
	Tue, 26 May 2026 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AWeDKFqY"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C18D3F9F55;
	Tue, 26 May 2026 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799192; cv=fail; b=Z88ypw2OXPl7w+uN3wOULWG/aWopexZfin/Zd8w4ZoK1kU+eHt/9gJiHKmYfGoxCdMnWs7sCGiIbKxmHNqjxi1boWkhUVJ0LL1Y/kYEz7T+P+BNNS0A+NtSaHn1kDDgAQ3WxGSNh8PYYhIy3F3da1/DUfLxiGb1wWNTXclsT75g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799192; c=relaxed/simple;
	bh=mL0Qu3Yq8B3VU0eXSNPu+qKKfr+Pd6djJt3K18P+z9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/+9swfUIXvNpsz+BZWHE3vz2ua9pXGbzSOxtfWtnPfqGoMcOqyH6QLJqAPIZO6dQlnFHTX0eff4SKWofg/o2hv/DgdFodsSYizP7Vip25ru8GlYYi5S4g/ok/4OP8QXYQSa8JIk+VDmEKv5PXA/feesrL+nbAHhusD/6W/sWJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AWeDKFqY; arc=fail smtp.client-ip=52.101.52.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QY0FpHgO8BxBca7T6LU6aKx4yU4zsbnxk8iYyhnpr/HvR/cZG9gmDSvoVShMrtF6kvgDik2ShW6kDnrZ2EQqwRgk+RXogqjqVyZ6y+bXKclKqwbNy9FGae96GG2YbtVWlRak4G0ovi933ka9bFxAZNinHbtGKWgE7Scn7wJ75bBQd9AFfEEEVUzzRZ7pUH/JfzRfUEIWERrxseSzoCAgU03qDFHxoOShIukLkQKjWvhpP6DhvH7eQx+JHbNOg8zu03eEtfyEBNnno+vh1ZbIyokWYqFbcoGABCNc/BFIouhViR9A1n3NlT2tBKF7IhD3fvVFPetJMnOYX4R34rWJYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnhxLYARIsVHXqilN74r75bQ9Very4swbgvddgWvfmA=;
 b=fYGadKkqzUGdW+ab9MYcFmWg97uhy0IhNFpkhCDbtVXpsN/yOzQgtgyrUGZVYXsuXEk8Ygp8gp8Zc71zgpmzRuJsoU0FpUU+cu46VRTzvNx8UNKDdu6sVFwhpfwNWXw/B3w0oboXu+6CEf2xDciM8oYfrYsZIPhgqnD4kIxj/4/HD8rOseHUwBOpxIYz7YqQh3oKBkQt3xb6vut5bt7r40EDGECJ8s28fxERJHFZ1b2b3V6EkOszgpa0QmLK6lwKWaIYn8qDBloKBelwZxiJHzRUoy1wv+kfa5TZyz1G5af1aNqnol+vp8e2rS7d07+m4Zsa9jYGnr37sHRD7iQbAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=zeniv.linux.org.uk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnhxLYARIsVHXqilN74r75bQ9Very4swbgvddgWvfmA=;
 b=AWeDKFqYGgY0KXrnq71FFwEk68mxZE3R24CYCnU1SNmvyZ7kRktCHrK2GC84ni0sAqFr/Mhef1XLYe2IpyhcRmw48Na9W3kmOk4wDlP8gmegb5nIi484t3cEO3a2YW3w6waYMqUExKsVYOaEdWZH2KTvOP7uiRBgMI/PotUWNZFw1zL652AN2itEyjXps/LdZM2+gufFBrkEKrvfQ4S4YaAp76s9eGf+mA7vJiZJcRnrXh01UDydPNrrvhk+VbkD3m3xhGKyxraqN5LcpL8tyIrgzgRGUi5gntTjZ2jXQ3XUpLBdBS8Lf80E5rwVgL9ZiBwFMdphfZ4d6CvGzRNtRA==
Received: from MW4PR04CA0098.namprd04.prod.outlook.com (2603:10b6:303:83::13)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 12:39:44 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::14) by MW4PR04CA0098.outlook.office365.com
 (2603:10b6:303:83::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 12:39:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 12:39:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 26 May
 2026 05:39:21 -0700
Received: from arpithk-kernel.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 26 May 2026 05:39:21 -0700
From: Arpith Kalaginanavoor <arpithk@nvidia.com>
To: <viro@zeniv.linux.org.uk>
CC: <brauner@kernel.org>, <stable@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, Arpith Kalaginanavoor <arpithk@nvidia.com>
Subject: [PATCH v2] fs/qnx6: fix pointer arithmetic in directory iteration
Date: Tue, 26 May 2026 05:38:58 -0700
Message-ID: <20260526123858.1683035-1-arpithk@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408173527.GH3836593@ZenIV>
References: <20260408173527.GH3836593@ZenIV>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|BY5PR12MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: c174948b-5ff5-4df2-a601-08debb23dcbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	RedTpMHbvbtNSTln4bjd5t3lNEKQYQofGKOJ7KxHHZCVJx6qpInLcG4Pn7a8YKunCel0BIleEVWSj7oCkBm7hWRhTkX5iG9p0FYpRzAgaeAp9g6HK9AX+IPkuZ84gY6vKt263pCeXZdj4ThIU0IA7ZTqKUUxfZR0G/496vW4dn7YJhu78as+CcC/4U4N1XYDEh8+el1mrHJ2v43C3sxOLmJzZg6GPvsqV1polHMR0gYquELo9ZODq+xwZPxdQuDsViur2vM9hivGjb667/41yXrq9cPw0NB2o4faPhiWdg+zAFjVgP7xI6a1q4S4eFyuQUusIUox9zYMo5S92mdNPfiSDhlW1LYp+ZbEvwTAKwuLE2V6SKaNtG3XVSHe9xpqB3yoNb0eD0F4V5Y4QVSGcadAZFve5MK83M6i4tj6MfWbJ6MHY5Zv6TU9ztdu9AVpkaMGQcI/dlbKE/KguSVj3vTlULMMaEkWv8ts2Pyx8egz4ZVrbmqi+gnMmmR66xtoaeQXk4/KVLqINIQpUT29hEL2IC4cr/7FB3GanTLS5g976Cf8Tkgnek4p9zpoVLrzrkV7aZvNbG04Q1o1lyt/j5pJaG7wIfsYDcimHEBP34uB6RgBqzEcPs6gQpmEbooSK3SHMlnctEAKqVyCH9iF9y/FbnAeLdSoTDOc3GBS5ixoA7Ks5BIMQdN2JcavM+voaU4/pd3Y4AEzbnBoc3Elkyt6v8+L9VIOcD7i5N+Hm5k=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(11063799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JZUYpBWAotwDMz+IH/9YJdiSyw3HNLTnKXuxbYvZJS9FRA2u7NoW8iFUi9zPT7SxAe04Ne+m90d247gpC1RpZ7vR8ijgYNSh7J39DMyN7mZWPGQ/nxGcMorU1k5FQ0EQ7E828AGhtVIJ756NnAIhmmrQogKGIKDK6XZGCbHgozgUmz5YSWfoqYE012llGIcGqbhvXIIJs1G7q+bfDkTveYzS33L0hiw8zNJK5w+2OhcYyu0BCQEeyGLsIBZAxRr0pERV/xX138yfUaH3efjZW9ZAk15laIHQhlMyJLObcdlSPD6CKU0/XSNyC5VMIBq/S+A3y7jHiMsSBXpXFXuuk0MmEovfi3MHy/6S60wM8qA6AwPGnlSQTa8Ewpk6OF9A72O3gcbwjGXvrreTw/S6Gd3lMMEtuAzMM01Y0WFJKQbqpsHvwwpkz1JZPFW6TM5X
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 12:39:43.4215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c174948b-5ff5-4df2-a601-08debb23dcbc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254332-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arpithk@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: DBD735D5B05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The conversion to qnx6_get_folio() in commit b2aa61556fcf
("qnx6: Convert qnx6_get_page() to qnx6_get_folio()")
introduced a regression in directory iteration. The pointer 'de'
and the 'limit' address were calculated using byte offsets from
a char pointer without scaling by the size of a QNX6 directory
entry.

This causes the driver to read from incorrect memory offsets,
leading to "invalid direntry size" errors and premature
termination of directory scans.

Fix this by casting 'kaddr' to 'struct qnx6_dir_entry *' before
applying the offset and last_entry(...) increments. This allows the
compiler to correctly scale the pointer arithmetic by the 32-byte
stride of the directory entry structure.

Fixes: b2aa61556fcf ("qnx6: Convert qnx6_get_page() to qnx6_get_folio()")
Cc: stable@vger.kernel.org
Signed-off-by: Arpith Kalaginanavoor <arpithk@nvidia.com>
---
v2: Use idiomatic pointer arithmetic: cast kaddr to struct
    qnx6_dir_entry * and add offset / last_entry() counts
    directly, rather than scaling a char * with
    QNX6_DIR_ENTRY_SIZE, as suggested by Al Viro.

 fs/qnx6/dir.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/qnx6/dir.c b/fs/qnx6/dir.c
index ae0c9846833d..8a26908f78c2 100644
--- a/fs/qnx6/dir.c
+++ b/fs/qnx6/dir.c
@@ -132,16 +132,16 @@ static int qnx6_readdir(struct file *file, struct dir_context *ctx)
 		struct qnx6_dir_entry *de;
 		struct folio *folio;
 		char *kaddr = qnx6_get_folio(inode, n, &folio);
-		char *limit;
+		struct qnx6_dir_entry *limit;
 
 		if (IS_ERR(kaddr)) {
 			pr_err("%s(): read failed\n", __func__);
 			ctx->pos = (n + 1) << PAGE_SHIFT;
 			return PTR_ERR(kaddr);
 		}
-		de = (struct qnx6_dir_entry *)(kaddr + offset);
-		limit = kaddr + last_entry(inode, n);
-		for (; (char *)de < limit; de++, ctx->pos += QNX6_DIR_ENTRY_SIZE) {
+		de = (struct qnx6_dir_entry *)kaddr + offset;
+		limit = (struct qnx6_dir_entry *)kaddr + last_entry(inode, n);
+		for (; de < limit; de++, ctx->pos += QNX6_DIR_ENTRY_SIZE) {
 			int size = de->de_size;
 			u32 no_inode = fs32_to_cpu(sbi, de->de_inode);
 
-- 
2.43.0


