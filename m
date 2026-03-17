Return-Path: <stable+bounces-225739-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC+aHT7juGnEkwEAu9opvQ
	(envelope-from <stable+bounces-225739-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 06:14:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6FC2A3EB3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 06:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A5F730046BB
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 05:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959BB36E49B;
	Tue, 17 Mar 2026 05:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LMx0R6xe"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2299531353B;
	Tue, 17 Mar 2026 05:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773724471; cv=fail; b=l1cPtHA+EktZz5OOkPHI6kY0MymDpY8OhYsTrwGPpj4i6JlD5y+0VqnULZzDsc4UoS4AW544AoIbUu0ORWiyibtSLUYpqwC6JDO6//NAxr5+TGXAbyj54POiK+fzh3Avl1ARUrtEJOmuhSFrCLMipO2sj9tbwVnawgk090b3bUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773724471; c=relaxed/simple;
	bh=HfbZj9AxDMqCNqfSyzfinFR2UiW+BnuQLHF5IbENP3c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QRlASyRk2Q45eEQ11fn/8HyorrYH7Iq1aH8pbMqnlKslopo5YhX8U6BKwetLucxnkyp4PMsNp5hy1V6/z70sKPP2GouqT6VeaMp0ZNYu6LiVT0Rmk8auwhiZZKQxV35ZTk86mksF9cF4EIZ3ZreQqm+W3/BpK6PdcCOZefowQ+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LMx0R6xe; arc=fail smtp.client-ip=52.101.62.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhekdPZteLm+PC926u9hJxVIJ8rk5c5ex4SQ7P8cOSTiGjCQ1yRLHb8+O+g9bAq+LB6KyFwhsH7bf6iNVq1cXVgVAjE9tXCzDfqBfiS+m0lLfjznU5gIB/5wCk2sboR205E1tfK9CN5iUEiW8jRxQaYxY4irB/vNHaBlFvRo8AQ9SZJm1ulWvvqynThhXbhcB5wKFGYajns5P9vWnHSnXipl+Cd8BhccRXGvOPPEV6qxRIVEHKw9hJ8GKBbnJeexAk+RYtB2yMSlimtWdWfrDAZoft70lxSCd86BHEa44VXf/24jvGY0R3X9uD5UU3J2ZizzSpedJtA+o0iRRnmhkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzMZwPfS3e12E6Fyv9T6SmEA13fnw1TtSbUNKwLi1Bs=;
 b=w4bvBllDezJ0M8yvcSXMQVzD9PkMjZfcH/CJHfNZSvSJ2i2WOVIKewsn48iVFuVtBUCY72yGSRm7J2aDEBV0CUaI+4oCxpcWzYutO5GvUwng7Gdc73Ekgc4u0dKgMqNz3gO909Tjn4+RRCJ5U4QsgP4pJ7/wo0sPs4HSyIxJ7l9y38yH7Z7wD4wCriwSzlsbdoUhpFzUjldIncGexmGP2tbeyFV7hdtpnPy0L9A9eP+WM7NE2jHIwrHeOgFbuC4re7CUyKe9cowflK0m8rsB9Ff5tyrg+o6B0Xfqwth0mTTC3NKLeqrDQtlHSqfph0svKg866+5NQBqYNzs4TSW+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzMZwPfS3e12E6Fyv9T6SmEA13fnw1TtSbUNKwLi1Bs=;
 b=LMx0R6xe643K4m90bUTQIEKkL8Qs0HCBVsIr0viUajF8X0Bmzm75nD+d9irHV0dGlbfyTOdbRHcGOaNM+z+lWoTNQX7l0t6qMqkD+7GDOtoyEpJ3/hTQJ1ml57SBp8A6JY4G4i5+piStrjabC1oFQZNG9imaMI776c2FRQVURiFt/uIXj1PRtDNYe4kV36rMOjghdgW5OrAJ5aR2/z3z1fHKmFdpzkjVk1i9OMPdZcYzG78bs+Eg0kz/YxdEiGzsCKmOoNNnT1eITmICElSpkeyi9Y0vedHtrzMBa9mBbOpMSYLm8hNR1EjP4FUPHDi49kf0z4MYcuz6mBOlEkfGRQ==
Received: from CH2PR07CA0056.namprd07.prod.outlook.com (2603:10b6:610:5b::30)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 05:14:25 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::79) by CH2PR07CA0056.outlook.office365.com
 (2603:10b6:610:5b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 05:14:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 05:14:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 22:14:10 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 22:14:09 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 22:14:06 -0700
From: <mhonap@nvidia.com>
To: <dmatlack@google.com>, <alwilliamson@nvidia.com>, <dave.jiang@intel.com>,
	<ankita@nvidia.com>
CC: <kjaju@nvidia.com>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <mhonap@nvidia.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] vfio: selftests: Fix VLA initialisation in vfio_pci_irq_set()
Date: Tue, 17 Mar 2026 10:44:02 +0530
Message-ID: <20260317051402.3725670-1-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: bd5ba854-cad2-4633-0b1a-08de83e40e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|13003099007|7053199007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	daXKRTU9YMlaHb1R6gVp6jEPEcFvq0afpy8a3M6QUw1EN3PXTaadiUzmW6PYWNTBfR0l26B3465IOSBc5V29OvfPLhnZORrMDSb6jKLrEU76zuyOMfDCXLjHsjH6DxciwF4i1930fnGjHL0pzU0Q5PF8KqHOiuPzHFTicyqgRa9KGxPEhujtKYG8drO+dxWOBhQpTKOnpKuKzNRmCO7v0imIRImhyrq25c7WgRqwWp19WrP3O2ylGqFlQn4aXP6Crbp0pjVKECyzdqMBut6SJcUcltDb/m0lFsBRh7Y9pWk7YnScMIeINq6a8Vat0rqt7g58GDZkzf+EhtiKY/OeGiUmtOI3HUAcjyLb7oK71ZD6mvqVkVR/Ruox85NzZr9NhPrhDkXa4pbhN/wTMbN3AXQQMGgz9hCbguBaA+DoKY2OqqJvtOYEymbWxkBiOJn8roJVoAMxjTepJCstCdDnul+OibbomOywBYTo2xMK7AusAuC0lIIoJwKzCLDsbLAiR3K4UMXFhmQq0L+UvSSkSHRimeCNEZ7cvtqRpkWEbncXaVKf1v/PIEd/AHlW7IartZ1pBbv5aBMYELJxn1yruuX0R4GtchEWxjQj9ngR695RV8zkF1BQBPdM1lQUVC9DjFcwYEb2u7EkXn5FbjitY5I7zuSrF9oKj21e2kCBT1JgkxBKtWCsf5tA1oQZcJgBI2c8gUmcpghdDDfava1X8LWOHCrjl+4bR/oWk2djwjGNcLkVSJampH8ta0uUfN+bWnL4+r7AkQDk+jcL+XVHkg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(13003099007)(7053199007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CQMsyyTGL6h3poBePYdWGQYoJX95jssrMcvQ4d8CSsznXjpFh2wo/YND4YRhjscLwpzpv2/eAXqPTwiPzY6VAL8C+EP6Bzl1WjIaKCYzk9AYxEMOGctb59kCkNND2V1fLDneSC2L1KNvWXu/DVfAJ6r+bDys1xyGb8phjdmv1bKHleCynZYGXN9BchZNFahXfvmdyHs/GZwasz8N7AlhnJfUJqEWT5dMDi2oNsQqiBThr0ebYobrfyu65fqrOphS0dsJu6zkYQ8rE7G3DoerSQCr8VEhv2OSvP1gqERQTugMmhgCtXo2QGDvZzZyjqz0L6zwgjkQuLfe9Wrc3ZY15RxjU73DCUkNznOzqODEgxMx/ISK92YNfTfBCxm8JfOg3DJnf6d5BnPOYkfWcBKPRSkV2zGdoxTV3GsU3+WsJccMi+83SnLfPSuh3lgGhwh9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 05:14:24.8167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5ba854-cad2-4633-0b1a-08de83e40e59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TAGGED_FROM(0.00)[bounces-225739-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhonap@nvidia.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7F6FC2A3EB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Manish Honap <mhonap@nvidia.com>

C does not permit an initialiser expression on a variable-length array
(C99 Section 6.7.9 constraint: "The type of the entity to be initialized
shall not be a variable length array type").

vfio_pci_irq_set() declared:

      u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count] = {};

where `count` is a runtime function parameter, making `buf` a VLA.

GCC rejects this with (tried with GCC-9.4.0):

      error: variable-sized object may not be initialized

Fix by removing the `= {}` initialiser and inserting an explicit
memset() immediately after the declaration.  memset() on a VLA is
perfectly legal and achieves the same zero-initialisation on all
conforming C implementations.

Fixes: 19faf6fd969c ("vfio: selftests: Add a helper library for VFIO selftests")
Cc: stable@vger.kernel.org
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---

This fix is self-contained: it touches only the existing vfio selftest
helper library and carries no dependency on any other patch.  It was
originally included as PATCH 20/20 in the CXL Type-2 VFIO passthrough
RFC series [1] but belongs on the vfio list independently, as noted by
Dave Jiang.

[1] https://lore.kernel.org/all/20260311203440.752648-1-mhonap@nvidia.com/

 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index fac4c0ecadef..3258e814f450 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -26,8 +26,10 @@
 static void vfio_pci_irq_set(struct vfio_pci_device *device,
 			     u32 index, u32 vector, u32 count, int *fds)
 {
-	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count] = {};
+	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count];
 	struct vfio_irq_set *irq = (void *)&buf;
+
+	memset(buf, 0, sizeof(buf));
 	int *irq_fds = (void *)&irq->data;

 	irq->argsz = sizeof(buf);
--
2.25.1

