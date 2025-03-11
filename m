Return-Path: <stable+bounces-123165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274FEA5BBE1
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 10:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FF716FBAA
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FD222ACF2;
	Tue, 11 Mar 2025 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="nnHJ0Gse"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B46E1D8E07;
	Tue, 11 Mar 2025 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741684711; cv=fail; b=tZt+BtCLDXL+Dv2I+DK+Z7BQpT6mGUe425EKyPF92oGboqKIaLN0sjBbY30dBilRUbIblGe7rbhG/35JVCga/cXc0DcyQRYLE4piRLh3BvbNo1xphGugVy22g/VXBGOi8wj+myU734QHjhrHe5Wm6CVvckFyFKFtIXOsB1ivBr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741684711; c=relaxed/simple;
	bh=6ZRbs4se1Vvn2S1g+/yV4Mzs+CtFoM2S2jBaAo7skkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OuV3py8Pd6D6cE38ent4bhXfchbmW2M5FxPkab8Z4usA8Ozx7B0hHxOHfFcNmJIBEYHcLEIcEKfj6yCOj2mAdoJfczDJNnh4udYX3L+ykmnGbViwhZQ53nkEZJ74l5NCSl5qInuH2RPB2nBfD5Tprp9s2EPhniX78ECo+E1WwRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=nnHJ0Gse; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsVu9wUZVf+tj9EqZO0Bq82g+dBtFgnUUyCKdllUI1uM/BAgoyHjU0oxlXkO+uZoLTQz5BnUDu4en0dsDQyz0nLgIQLG3ys/wIhoMAmfPLp8fiADbm2DBViilp4TrBD72nwmVJFSvNlxMXFgkZRTvNExYAsWWp6TPoF3SHHWBVCU8PYdh578q6vM9cgllh9nnF9EwctAiKDLwKiD15LuiZYhwC4Wl+anL7LezbT3NadqV4DzghyQATtwlt+oI+aEhKs03QCwLbfIEQFQkTv4Yms0JNDuOD5T5LGsLQretqIO6secLahXSzWYQJCVerAvagJl2oMeKz3dcWlhkou2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6SUTBCPdiexjIAc7UqFI2opZGz/mQVEmkSFSbGFZe4=;
 b=KNZrwxozJnycowcz06lmmK5nbGI6zJErFn2XLjwJ8/XZtgpwR/rsGguVMXpY13vlC5AiPjYUNbrKryE7a9K8k6WbZFfUi5ak5nKcqsTMh6yixAcxv9VvjLSra0d/Mqq116Ccz7ncv+l9Hnxsew23L+qqOoh/wZMxiss0iiZ/YqsBe4gHef3FnnAEt+9tpC5uSzhbmBmxr4FjGgY7YKGHTLp6aQEjs7ZWMTQte5yyaxmtnVq61ifbzFfc7nMGNSLlV+RuvKi1JSALd4Tx8YwO7Vt53kpoJ6boJmcdUS1L17RVfJOdExMpYS5qXmO1zWCnu9OHPx7YH2rjophrznUH8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6SUTBCPdiexjIAc7UqFI2opZGz/mQVEmkSFSbGFZe4=;
 b=nnHJ0Gse1MDmnV3k3BXLqTtVgPq0MtaObipogWd3lMDrAjdq+6N51IZAYIp5n4GUW0ZwQNKoTaoq5rhQhM0CBSJWKs/mbG6mptVz+qDy4uodzaAR4DJMMm+/ZEvmEI7gtIiyy/6/GGJCG9GU2wfUUzkuoMTJKOqRtO+jWpsaYzU=
Received: from DU7P251CA0012.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::18)
 by AS2PR03MB9049.eurprd03.prod.outlook.com (2603:10a6:20b:5f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 09:18:24 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::d8) by DU7P251CA0012.outlook.office365.com
 (2603:10a6:10:551::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 09:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 09:18:24 +0000
Received: from N9W6SW14.arri.de (10.30.5.19) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 11 Mar
 2025 10:18:24 +0100
From: Christian Eggers <ceggers@arri.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
CC: <linux-kernel@vger.kernel.org>, Christian Eggers <ceggers@arri.de>,
	<stable@vger.kernel.org>
Subject: [PATCH v2 2/2] regulator: check that dummy regulator has been probed before using it
Date: Tue, 11 Mar 2025 10:18:03 +0100
Message-ID: <20250311091803.31026-2-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311091803.31026-1-ceggers@arri.de>
References: <20250311091803.31026-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|AS2PR03MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 4315abdd-03ce-4662-017a-08dd607dacee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r900KQSM/Q+VRRtxrf/Wsb+aK9vfKMP1t2nV1/I2UWJn7YDEdAjKFott3sD3?=
 =?us-ascii?Q?4VZABvitHB4n60V942beylV/Wc7mjxMSUHtaeNNCB2InOy7G2GtP6/34GOsh?=
 =?us-ascii?Q?bctM7E+IKBMbTF89+L67vSjSbIqgMi8nFCPfar2/LXIm8TIVyk15IjQ7Wryq?=
 =?us-ascii?Q?RKxfCtygmEaKcBthtuRapHH869UOOqPjxJtDWIo7yziAxkYJ371zFbsg3AVY?=
 =?us-ascii?Q?xPkBkS+wpOZyVh3bEfhjMxuIkKClSItbV2x/H+DL/BukpjIHCKDE0OaPUZse?=
 =?us-ascii?Q?0+jgybKPk0it+p8CgJVODkTPByWlWYxKA6h9nAId03SAriMwSTeO/RI+Mkel?=
 =?us-ascii?Q?mUmuaYRlKKn1PlCa2eMoinshG781GPdjTIB1GG0yDxeE76nQ3GWOGLUgUWXY?=
 =?us-ascii?Q?r0obkmaxfnmFzD+wY30XYHRIogutp+Nirs/BUjYpMfb6fL+U6JU/2JmidKc4?=
 =?us-ascii?Q?wNaHGsCj9rOhqDcXHBmEDsKcQ5qWPugmxkiNgHzVaQPAkEXuYxmbaxv9N5h6?=
 =?us-ascii?Q?IrGf5qzLv/UUWAQW12+s2wHDhZX1oKvMn0ajGeCVemPKx34/0QvuQIlwPZYs?=
 =?us-ascii?Q?UwfJ4WmiZJYxpfFBfFdnRi/E/ST3BRhAhTpuI2DWnrI7yd/LrRn4CpfidhgD?=
 =?us-ascii?Q?bkENmF3LgpFWw4/r/4S21BJm2/L97JRB6w1cVFVmUCpEOUPfBm9FuB+afOl/?=
 =?us-ascii?Q?6lHDnUWfn89+ygK6Z1NW1GZuoZP7Ql0P6aYw+ZqoX6GYfY7OM1icXRmWK9S4?=
 =?us-ascii?Q?ctKyyy0FOz9W6S8647daeuOkTujBXrpiKWoMxVLYOefEVgmjC9/ZO6naJ0za?=
 =?us-ascii?Q?43dGIfq2XkJyD8V7QLI2dBan6V6wa5CvHvgFDXfahV7P70TMr8JvFYv0Zv9S?=
 =?us-ascii?Q?WQQUQTZc/bz2baTEwHqRempZcxF/P8nrPNUtchYM6coRYFTPxvGoMhDln6Bs?=
 =?us-ascii?Q?VPh1BIwHCnjJgGvhR1bveTugJ/vqC5wYijHbjQpZ0Z5EqgW7QerVZpxJ9/rC?=
 =?us-ascii?Q?6UIWr8ggUfDKvkgSVL9mDeOgnGy3cTYOe/X8e8F/G/ERNZ+1CdQWHm33+S0r?=
 =?us-ascii?Q?Z8X3BY0rW3bgsyPDznWKmG6dcmKceOffXEEYDIKlg9utaLRlFcMPqnYh20AQ?=
 =?us-ascii?Q?s16BgKq8jrnNAmRbaD6OqqAJFgllsNNmjvhjFsxW5LqpRiDWKdZOaYPbWvT5?=
 =?us-ascii?Q?BUgRWim+ZSnIZQbgy32cG0eanRo+nUro2TPtdorN1X3vlf0cKXC989FkTWsL?=
 =?us-ascii?Q?44AOb+D10yerFmQ1JSIUSV7l9vGI/F3cIt0Oi8Buk5SCPgY15E7/eBQnW84Z?=
 =?us-ascii?Q?q4j9QmZRyWOg53M42Yiazcr4VtL4vOpXTkRvbL8XxmdjQHgMis8K7nfH6exm?=
 =?us-ascii?Q?LI/IG+BBK1GWDc10ORja0sfHh1ymdOBgED6n3uEyXvULDDyWEvApyraq0tvW?=
 =?us-ascii?Q?u8uSRbjRcWWAhtJQezS9C9SN1zoDLnnwD3MHotwlSXZtTpnSf/AnGCsyPNBY?=
 =?us-ascii?Q?jPElLaAbQgbn2nk=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 09:18:24.4154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4315abdd-03ce-4662-017a-08dd607dacee
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9049

Due to asynchronous driver probing there is a chance that the dummy
regulator hasn't already been probed when first accessing it.

Cc: stable@vger.kernel.org
Signed-off-by: Christian Eggers <ceggers@arri.de>
---
v2:
- return -EPROBE_DEFER rather than using BUG_ON()

 drivers/regulator/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4ddf0efead68..4276493ce7c6 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2069,6 +2069,10 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 
 		if (have_full_constraints()) {
 			r = dummy_regulator_rdev;
+			if (!r) {
+				ret = -EPROBE_DEFER;
+				goto out;
+			}
 			get_device(&r->dev);
 		} else {
 			dev_err(dev, "Failed to resolve %s-supply for %s\n",
@@ -2086,6 +2090,10 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 			goto out;
 		}
 		r = dummy_regulator_rdev;
+		if (!r) {
+			ret = -EPROBE_DEFER;
+			goto out;
+		}
 		get_device(&r->dev);
 	}
 
@@ -2213,6 +2221,8 @@ struct regulator *_regulator_get_common(struct regulator_dev *rdev, struct devic
 			 */
 			dev_warn(dev, "supply %s not found, using dummy regulator\n", id);
 			rdev = dummy_regulator_rdev;
+			if (!rdev)
+				return ERR_PTR(-EPROBE_DEFER);
 			get_device(&rdev->dev);
 			break;
 
-- 
2.44.1


