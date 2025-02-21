Return-Path: <stable+bounces-118576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742E2A3F4BD
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 13:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1EA4212E6
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 12:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1641EE00E;
	Fri, 21 Feb 2025 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="b/RMm9St"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013054.outbound.protection.outlook.com [40.107.162.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EFF1E493;
	Fri, 21 Feb 2025 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740142541; cv=fail; b=cjtBnwBaGz65bCOsW/c70Qsi0NQgGX0SXed/huMgy0wX5RBBBgLO7xlFUTTNLGtPeZtFmInVHmFTxCotlTe/PDVQpLtdDHF1j6Ts4VL3PS8KEQMfRVedLKcINymcRp3LAk3PvzJs/5IhaEiwRoZuMiVDdjn9qQp9H6vEx0nLHVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740142541; c=relaxed/simple;
	bh=y81lR8Xs/2rKIQK8/rdPv7cr7i7gUEQhNo12cnDaqD0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BNWw7wk8WQK4fXbT/owV6sBsYmzdGA4y2SwJhtAjQoNWSjLWx9JRrAiRvfslzgSZRO50KHq1QKKwVmGnVUnLu+Sgx6rt2t5FnWKVaLp0+S49QEROZfwlw5cOKQqkuLhpX4KxmNY4R6ljzP6rvqIKRFZZo3eAXJuMvaelX7MwSpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=b/RMm9St; arc=fail smtp.client-ip=40.107.162.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwDKK2RGX0e8a9lYzJtiUludL5w9czkluJnkjcBHzo1LO+5Z0ttU7SgQrZsh0wVufE2YWxk5tgWEt+qFCZAx9tk+b8PM10kqAJO2gzDRahAysvvdUqH+Z0I2Y/m9/YLS5uQpRQtOa3g59nT75vAgOe88Cxr/8xVM159NUq+d1qLh+Vpe4nRkUkMHq695IF3dMST0NyJTJr8wjhJ6U6CL1Fl5kKZpzKyOZcJ6h/EkCFOaEkRs+o2jwkFrA64+hGNorPwQGgwQCJxeeQC1XS++ZdZnkMx8qxyY/uHExhNiuygj85H7/Z7r979XKtE3xy2a4uCxFoHWpmVwoXNJkBWkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qv5nltLguhf8VP0j0Yf25MMoJWeRS1AwCTGtAbKQeI=;
 b=ojxblQcgesr+i89MkS8sjxZYRjM9R60TkJkoInPD+V/OL5mhONJUp38CUVnHNbTXCzwuuNp55ewTwMe6SnYPIHloN2sPUiBpDfgzJsE4sny2uflryYVijTY5zxLGFjy+TD0EohkoG6L5JIrIen8J+752qyVgdLsuoCaYXcaom4ZLpH4rQV8y1JdQASmA+PmJSZcKGR4B8D9o0kC0wDx44MYVFlFM2rKo1qdzwGyWfgVRLbHOR4JzLPlwAeeS534SK+1mcRgAv1XOVfnu+4Es/m7bZivzY4mBp7qgkKipLY/YCCtVZamT/cWu6yQ+knWRUkdF+rDfmbIIUhNk4R3Nhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qv5nltLguhf8VP0j0Yf25MMoJWeRS1AwCTGtAbKQeI=;
 b=b/RMm9StC/WfWzK2WL5ovIiaX0C/kYEh19j9Nzb7JAEYLTR+ScQAeb32JGZbTGAdo7fivEImG6VlIAcBFoyZ+Od4jbV/ylX5QvyjpaJawGZuI2sNv0nwBHpX7SRF5O7eiJLWJ3MTWrPyo38uqnTwTXc+czKAj3qQSuLkOgN/HFo=
Received: from DU2PR04CA0203.eurprd04.prod.outlook.com (2603:10a6:10:28d::28)
 by AM9PR07MB7921.eurprd07.prod.outlook.com (2603:10a6:20b:30f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 12:55:28 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:28d:cafe::f) by DU2PR04CA0203.outlook.office365.com
 (2603:10a6:10:28d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 12:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 12:55:27 +0000
Received: from N9W6SW14.arri.de (10.30.5.8) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 21 Feb
 2025 13:55:26 +0100
From: Christian Eggers <ceggers@arri.de>
To: Russell King <linux@armlinux.org.uk>, Yuntao Liu <liuyuntao12@huawei.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Arnd Bergmann
	<arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <ceggers@gmx.de>, Christian Eggers
	<ceggers@arri.de>, <stable@vger.kernel.org>
Subject: [PATCH] ARM: add KEEP() keyword to ARM_VECTORS
Date: Fri, 21 Feb 2025 13:55:20 +0100
Message-ID: <20250221125520.14035-1-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|AM9PR07MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dadabbc-ed0f-4d54-3755-08dd527703a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oD7ubDZyQb6ske7mFEo3vP8NJSb/WBdO87/cFFpS+/uPnlKl/q3egHLZWBp6?=
 =?us-ascii?Q?iWjlBzK0lHHKRiNE//6wWNqoOyJloZ4PJmNaH567udOhCE4hKSo+cUBr24LK?=
 =?us-ascii?Q?hM+cNhlaC/F9WwLXvwMYEBOkwj65QKt5BNfbLwN8+3gaafqxsLUmEaqJbXAh?=
 =?us-ascii?Q?qst0PdGuuzpJtgmfP7BxGY/d3/Yx6tdEIoTjn1ltpZrSSUcWY/Q4lBHsDm/7?=
 =?us-ascii?Q?d9t37JmakdKoR0Q66d8OWLrQMxqdzhcSuuo4MiBekg9mAG956mme2rdzDrbh?=
 =?us-ascii?Q?+crFhHV0QWgrHmGf1UoPka2Z+z+sadA/hAdYe1dHvylwg1+5+nme4Jw3QQty?=
 =?us-ascii?Q?AGFPRVclIH+ou/54PlaYqjbpM2Pcc0FB2CwozgOr2hzpuhpWjbmLzWfJNjnO?=
 =?us-ascii?Q?vmk9zr2Vyu7Si95gdpUATKaNy5XVA3MYU77E71i7PvYT+zw1XPoBuZdNdOKJ?=
 =?us-ascii?Q?gJyXiVmgLA9GjULtU//2beko8yhilVMWjFx6Y5vNdUiA6sAE2z60DMM+xVur?=
 =?us-ascii?Q?xuicQI51fR6WshhhgHkXPsqyvCjXZTtrUQffNLVHDdIctM/7QiWXCOjdppJO?=
 =?us-ascii?Q?uWtvFI+PUsQM+YcXmtRJwdiboMXaKdQDYADzatUEkXd7Fs0pl4wO3xScDbAj?=
 =?us-ascii?Q?k5HL2AK1b4Z9pGshcMkFOKmzjGI03Ijv7I1SXncXJ5u3tdNcrRRFnFHKts1y?=
 =?us-ascii?Q?0cWBX7ixiQsF7u0JtGhG5wO8ekR9IWOw+8oncTrfdkMlj9YcFO15RrxHKUS6?=
 =?us-ascii?Q?GCJ/0lqz2Lrgu8wseHXvU7O36GYXAmAm/YkFBEq9lbsDQnWLQqfxxFkG34+j?=
 =?us-ascii?Q?VcRdd3FkM39PGx37OMw7RjdqTObX7Xi/smWYNzz/O14p5mMI50qq04Meo5YE?=
 =?us-ascii?Q?MOz6kgRZiW/XQtKyvm4rf06M8esf0kjaiZukUeQv+Jb5N1uJol6+UARSIUrE?=
 =?us-ascii?Q?JARDiOe1dpn5Vgp4qXxprKdzMC04uMLYfrAo7J7xWA7vTbbYSqjiPUIOv0/R?=
 =?us-ascii?Q?CrD0RhXR9lw8RbfXJwkQPbnJD6cAxvbBE+OCtLvi75MTb1UEsV+4wDwqua1z?=
 =?us-ascii?Q?6DOmnu5o7WySTXuyJxeRmIr3PnLWxudB0WB42PNRFTQ8cwVuxwV4AwEN8PNC?=
 =?us-ascii?Q?mCMsy3rDqWuLJu2MkOIh86o7yatUtEOeYIHGcqGtFVWKl4uXt9omUKlSpkfv?=
 =?us-ascii?Q?agBQ0J3Yyr3A4xrRcVJqRmD1Ab/phXXtYEnzhAyCfAokvDiORxEsINxjeijV?=
 =?us-ascii?Q?XvJzuuhDas1QwwtZqvI4W4cT0rBeyu2b9kR6KQMoRHhJWe+gFoHj9a8h5mFh?=
 =?us-ascii?Q?UkOQrcaDwBukIcZqDVzBnigIlx5n8OfDAsHHUR1r6eq6wTAtA67k8bI9L1Vz?=
 =?us-ascii?Q?c5ChAqtQc8XXdZ7JcfIn2csQDp5RH1xG1qQ8eXZnKNvHrZPsHd4cxiP0JNGX?=
 =?us-ascii?Q?AYp22jcMFuZLKUyeAIW3Pz0ooAIZl1cM+qGknCz2ahaDTK+xEO9YPzqOdWnm?=
 =?us-ascii?Q?gLHBUF/nYW78pZU=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 12:55:27.1638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dadabbc-ed0f-4d54-3755-08dd527703a8
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7921

Without this, the vectors are removed if LD_DEAD_CODE_DATA_ELIMINATION
is enabled.  At startup, the CPU (silently) hangs in the undefined
instruction exception as soon as the first timer interrupt arrives.

On my setup, the system also boots fine without the 2nd and 3rd KEEP()
statements, so I cannot tell whether these are actually required.

Fixes: ed0f94102251 ("ARM: 9404/1: arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 arch/arm/include/asm/vmlinux.lds.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index d60f6e83a9f7..f2ff79f740ab 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -125,13 +125,13 @@
 	__vectors_lma = .;						\
 	OVERLAY 0xffff0000 : NOCROSSREFS AT(__vectors_lma) {		\
 		.vectors {						\
-			*(.vectors)					\
+			KEEP(*(.vectors))				\
 		}							\
 		.vectors.bhb.loop8 {					\
-			*(.vectors.bhb.loop8)				\
+			KEEP(*(.vectors.bhb.loop8))			\
 		}							\
 		.vectors.bhb.bpiall {					\
-			*(.vectors.bhb.bpiall)				\
+			KEEP(*(.vectors.bhb.bpiall))			\
 		}							\
 	}								\
 	ARM_LMA(__vectors, .vectors);					\
-- 
2.44.1


