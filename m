Return-Path: <stable+bounces-223012-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHk7OeLtp2mWlwAAu9opvQ
	(envelope-from <stable+bounces-223012-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 09:31:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 884311FCA4B
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 09:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C229300D336
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 08:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7973914E3;
	Wed,  4 Mar 2026 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="hZz3AK/P"
X-Original-To: stable@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021110.outbound.protection.outlook.com [40.107.74.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E79390996;
	Wed,  4 Mar 2026 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613039; cv=fail; b=tgqAiJDwxmw76DD1GFebXkRFJcncf8hQEKJVZuC/mWEhNBXvx941ATrXRP0ibzD3WXYwRZwk6J45VkBUw3HoZGCMVNz4tNV2sS+QbcVjUHqJG3UHXCsLkcCgMuQQq44QrZlL/5HBZ/PaijtjPgms65FI7SRYpO0g3KrrSRQlfKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613039; c=relaxed/simple;
	bh=ulNDbJJF004z2Ab1T/uQnGskS5+3wdJFzx12leluYg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f/MipjvxT1ENSHJ8lFkR0dcMh9UxpwNf197vBaI+vx2e6WVRcoxDpJniiB3p+7yv9vge4NjNgEFgX0d5Fr4Nn83jgsiS/dyq3V3+hVDtXUVrOXZjJSeW1B3brEoR6mkH9OLsNs+ZZWsKv1YuVDqsz0jOPm0nj6cJghGg+6BgJD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=hZz3AK/P; arc=fail smtp.client-ip=40.107.74.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6QC79rK/ETT3x1HfCTNZGJ6iz1XNxQCnH1SzgjJE9g62ZZfBRmQM4fpV05aak5yc2diJDqvHswo8CAZDhxc/oZUBlBltI1VXMPaDtxOC7Qj8LWOUggOYbY9KKCPLs3WDrh8FHwIZ9UncnSYfmSDYJHNDYmuflMfbKJ0Ws+MQUvL6HDU978ayunC7Z5OoZbaViC1gCXO6cMbhjCGTH9sSMvIGVcZlnC+xDKZ6j1klqyWj/wvNGv+7EvxpJRDDqd9JlOrCLGBCKAkuK4Wn12f5phh8RmW2LvcDCcdkhUJbqgMT9BD7HEx4E1cNRjkrvrSHNHN2mJYXK4voPd5gAxrTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6vdORUQV+oV4mQemK3U3U4MiqoDV8t2hdNxctpL7xw=;
 b=KCttleENwN0qXj0ghV2QB+TEab4IkbsmsE7pFjEUsVjol53VsqQoz0yGph2/4ZhEk/85pGNuK7yOvES5FJ4pQNZxM8FF8uGdu9gJjYU4T4aRSyGD7CtUsqDulYc1NiuCEXNJlxTZzf12LUDhqrKLTJQ1O2RA1bFKAJDID0UIRUiaXOXe655ywbt7VKLU9deGqSKxZ7gwGlhAgq4Rcyawh3f8Q68IXnAZ5aTXB/Yg7NJ3R8rmRGB1whSgsx8brtZlv3ZjDMYyDAONy3uP6HhYaxnzoxpMIu/gm4eaUycuQivjmxunLyy+Xd2dcn1UV/JkYyH/pBVPxaWSzNsOa24WTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6vdORUQV+oV4mQemK3U3U4MiqoDV8t2hdNxctpL7xw=;
 b=hZz3AK/P4SPzr4LSuhAmkMifF4KTBqph40x3/bD6PBT1dWacnHh2mpjR4+N1TETDWhKXwNFP0yBGZJi4NNHJcgiHWGe7j4p73Kb2AjCTupNbD+9E+WNGd5HAUG6DfD7Hb3DEX2vx+HWMmtbjs8kqmpl3SM/OefdjRVNkMW42QEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5686.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 08:30:34 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 08:30:34 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Frank Li <Frank.Li@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] NTB: epf: Fix request_irq() unwind in ntb_epf_init_isr()
Date: Wed,  4 Mar 2026 17:30:27 +0900
Message-ID: <20260304083028.1391068-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260304083028.1391068-1-den@valinux.co.jp>
References: <20260304083028.1391068-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0216.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: 42416bbc-54aa-4180-416d-08de79c84dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	woGsb6YrxXrvi9F93cYmIS9XMZsKtbI6aTn2/U8T/BZAHoezPqqDMcZyMCH21B/8mQ9Z410GjoEWiKtT7tsQwyMwLVbxcxYSGzxjkeDNz1TzHE+OI9ffQwHBaQq2Qr1LCmbKWdT2gtB8DScVm3sC6wZkd0v4BJ8al7WKyqBeiyGJ6+a2nheuzhglOQw4WvrNGC31EUYewqlITQEXKe+RXxoK42k25lgCUlY4g/wYgpA6Nh84syftI2lvZY5pxGd+LzRwybBzhESTCxRaUPI4Q9FJGTyv6MUzlPniyEif77Y9RRbNdRVg+Lkz+IvEL0wO68cvix3wouhygTHs9WZ2MlDpQN2XSHv4BVgvPt+z1aHZU4cUfLij4g3+xAfslKQNBOC2rePbGGsy1CedWyNSOt989r84wFrJTy6KTpvkfxy61O1pc64UgDdnSJsZmNuIMRktWdR2BuhBMv5Nj3C4mtSkyPGFxnM7GKg4Cx5rWKqw37wZfxiBZVLL+06AfGil2xM0o8oQnIe5lSCvPMLMO4I9WKGB8LwluO23DEhHoWBPnUNV1xAmhWtDu5SK3Rat+oi7x83au9M58Bo/Yx8rcqncJ/E8AT07QaE1mCZVPp2fVsLFZXg5wc7Al00xEtUmkFjQRTa4m4/f+JI9CGS77gWl/TILEYXVeJX0NWRwgjCz4J30z8o3N1GkOGid0DXC0gqkiVmVUtPcfgGVP8iK/Js7h14ZcJlvkLppcj65Rr0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1q8FXHgnhl08/rtjs8O3ZL3yO0sFDu03zbbR+dNIPSTxsnvBFKlo3vl1J1d/?=
 =?us-ascii?Q?BjswuaEs/aK3u7nUPXFB+MgQEoUxqzDJp2n7r/g9FEU0rtjDZdHynILKuio/?=
 =?us-ascii?Q?3vxhQsYM/j5wgMqSg42/bBfHNbWi+yeHfzZ0Ts/6c8whtWxloSOsahKbYW9Q?=
 =?us-ascii?Q?00yjm2EcHHRnYV8EsMi9px+YIQ86D1kmGgXggQYI7sp9o1YP926WKZgtC3ef?=
 =?us-ascii?Q?+qVIMyizyohJ8E0oipUhUMJQuuLCH3n3nxF7gaf5YZ6xAiz2r6d/4VGPD0KC?=
 =?us-ascii?Q?uWUFWJ+MdX/8FsQNRCjruFtmrFkV4SsF+bc2pt5fl+hKyVv7piHylbeE0lht?=
 =?us-ascii?Q?JMldlMxfSrs0GKmH0iP2Ju+99NaO4oeypCpNgekKiaQU/Nmqt+EKgiLNJBhb?=
 =?us-ascii?Q?CA3EQJAlf8yuH2afp/jM6tOroNkgapNRwq/rztiJquL8XhFNVaY6jHag7z2b?=
 =?us-ascii?Q?1/MKGzZrr2Vdr7Z+mVrDggCz6jTWt0/SX6sOHqEAr+mwI1TXg8hW5L6OD8ug?=
 =?us-ascii?Q?m0To0+naJSgINI79WSZ0r8JF6mkYzlP5YGVZIz55KZ0EjQIHra+d7S08F4Hv?=
 =?us-ascii?Q?XPpm9yz4TnQs1sNxGSo3mHMbsJhSg3MgTMY6h71whRDuHH64t4s5Q8Mg8WSZ?=
 =?us-ascii?Q?wpt0D+As+w/V6FzhnpFHkxIlYbrIcrXbxl8+4Dv5ApaN81jnmkGuCct43z5w?=
 =?us-ascii?Q?DHJK1CbABO7O9fUfpJYLDzeErl9tbT0RppqIasOyeEDX94IcVR4OinbDbDbi?=
 =?us-ascii?Q?hhGQ5CjVXPfDlPOMgqK3WaG4md90Qcm9oluY9xivV0KRlYc55OdXoZMwaCrB?=
 =?us-ascii?Q?A4c1RWIGrjmDSw6/D7WzDRAAGJbwcSd9cSaGqjorLRb5m2Zpckuw9cEMF3+P?=
 =?us-ascii?Q?wHPDKBqmZCdASxc+v0OFJ4MXIpCybN3VoXaMkBduB+cQJobqRUSlJKAwa8iI?=
 =?us-ascii?Q?lodQrey6HtDf0HzqNy7Bphz8aJJGEGtadpGEhb8HkUqd+pSSGr3iXVj6Eqeh?=
 =?us-ascii?Q?2CSGSr0bOhjy5mmdf44p8imXziZtiXFVOZVmOTQXcvTR20SVqwwg7EAtRNb9?=
 =?us-ascii?Q?9atypyxzp9khpitWLTjUDI5f4GT4dHQnR6s0TGIO/Dx3wq5F98SoBX7Nat9I?=
 =?us-ascii?Q?pkR0OTkit7VeptOKuh7+13E2GOD+p7RClK5sSS3zkdSXAaPNU4uOIEJFJ4U1?=
 =?us-ascii?Q?l5iievrlYQmbe3STiXXjH51eb5dgx18ase3e+7oxZcSk7IDMttqutIRKaAIl?=
 =?us-ascii?Q?5GWf2QjXT/LaMeeNMyed6JFIz0UpmBTAJWwJLc4QqwcrEBrbVf23UUZIhzhf?=
 =?us-ascii?Q?QxPm+nZJZe3UA+xtXpdTZiw0V208JfGujQV5ks8JKW6wuyjtaJ5JoNAk9fNB?=
 =?us-ascii?Q?4c0ylhpefkNgOWpXkaJjlI6+NtEscZ9F8J4plHH4kEkrMkwKU/D29FfRCiOU?=
 =?us-ascii?Q?5sJFRCY3JHeGLSYBJ+iGIyaHMC5YpkoHshoOM3qTGcYadZvJIhpubsYhR/In?=
 =?us-ascii?Q?twOPrxKtXv3Rm95VtifOXt7Em+ZWVs6dtZWw0uF3UI5bCsFjFi+kuUv+sTGj?=
 =?us-ascii?Q?8+cUCAbQgWMF36ST2FMxkKeFhX/mjP1MX1imLD/mscSzhFOYbU5PWsPB464H?=
 =?us-ascii?Q?F2hxBEKrrxGKUnKoVrIzQjsui5DhO/YrKEMjFJXdX3X9Uc1OFxf6+J9/VUUP?=
 =?us-ascii?Q?8hgEn/8c9nmFZbf69jTLmxYGQ24rlScoHB7TyL1VT8tuNbkl9lNaj6gTZbl3?=
 =?us-ascii?Q?OVwXqQB3lAnLCHkENsMczi02abpvsjwPS0Rz+cFh7YQmUzaFIgZJ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 42416bbc-54aa-4180-416d-08de79c84dec
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 08:30:34.1523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+HAjYuCQZvVU6GXYFLp4mPeAwws7d9qzwSncVMCrsiqwwUncYepZcoK+i6UIgaOd/rRt35PhndRX0xdG8IjkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5686
X-Rspamd-Queue-Id: 884311FCA4B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kudzu.us,intel.com,gmail.com,baylibre.com,nxp.com,kernel.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223012-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

ntb_epf_init_isr() requests multiple MSI/MSI-X vectors in a loop. If
request_irq() fails part-way through, it jumps straight to
pci_free_irq_vectors() without freeing already requested IRQs.

Fix the error path by freeing any successfully requested IRQs before
releasing the vectors.

Cc: stable@vger.kernel.org # v5.12+
Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index d3ecf25a5162..5a35f341f821 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -355,7 +355,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 				  0, "ntb_epf", ndev);
 		if (ret) {
 			dev_err(dev, "Failed to request irq\n");
-			goto err_request_irq;
+			goto err_free_irq;
 		}
 	}
 
@@ -365,16 +365,14 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 				   argument | irq);
 	if (ret) {
 		dev_err(dev, "Failed to configure doorbell\n");
-		goto err_configure_db;
+		goto err_free_irq;
 	}
 
 	return 0;
 
-err_configure_db:
-	for (i = 0; i < ndev->db_count + 1; i++)
+err_free_irq:
+	while (i--)
 		free_irq(pci_irq_vector(pdev, i), ndev);
-
-err_request_irq:
 	pci_free_irq_vectors(pdev);
 
 	return ret;
-- 
2.51.0


