Return-Path: <stable+bounces-71526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAAE964B45
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 18:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC41B2676E
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C5F1B3B1D;
	Thu, 29 Aug 2024 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="NMEf22hg"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2120.outbound.protection.outlook.com [40.107.241.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E481B4C35
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948087; cv=fail; b=K2HpZ2t2qzBskfJdrgA2xmgnNWwO+POfw8Vtsf/tMQ9vLnbwxln4+K+rUfP3/by53jL5XVKw8dTQY4DzBjys2Zr1M3aGsssISs5HZQfqbJMFT9GoTIGDKj7uWFXZriDHaYDGiVlN/uM4sysUar6codTXMz1gtujfLwx1esOYOko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948087; c=relaxed/simple;
	bh=fuKbMo4J3NJnMyvx6dLP7tMAKRQb4+r3XQIunKca1g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VA7FQsNNvwReMsImsP8/h3kSG2JFbl3Pcniu0QZagYdFHbi7LCgnSqiNFsqYDOC+OZJbQm1H2/27fiojJVeuDMyAwhlJINZwqFwbteb9uzCaGOtGJZYfqMkGKi5kPr39Vrt/nKRsGJfKZoz5NV/rXpRiVRGJWbmnj4kMcfUMV7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=NMEf22hg; arc=fail smtp.client-ip=40.107.241.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2Em6VB1gqQ6KX9HoxwKyyh3sMDit7ra5d1KdHmAiI4hOkEREnDRRpT96MiJFMDpiryuoMaqSHxHO/rpXh2aGGSdHyArU2TVSaGo5kgi30tcZDYzwOC3PPjrb2amA7tJevooU+B9PaP6RmKe4AQITp1bAw3/4CX9SNKz22uI+H7Y2nGHhT2Z5d54Xw1wTYFCWWlpiKGdSNILndGjgL8CFhq+BRsvyKUj8KwW2ywK5qC3Qku3VA1FB3Sm9m7mhH05NBMhnxR1PsOaKee/rekXYiT1NshExSEmwv1bHuabGoZMFME/5a1SHziyJqi5EYYF69baRIzk7sw67XmZy6PuHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQHGsqIQQnGhXSv2DWDDvVESo6SOdEgz41qpjO8h0JU=;
 b=CPqqij5pijEeWPEIOmpN83pHj0duTqB/K9052FIvGPnGEvQiKJid84RS5xCyaRqspJ+43/4J26WeeAOJdF4i5vszibQ/uBxdMfaj+kUEb99aQSEYyuqYgTewWlc4nsJ6yza5S5jlsm2wyera6gVDt0c6epKGhRMC2qEaueqDMxiXRkl3+P5cne6z3sSqT8e0myz76fWj1RCQAHbxU/1SJh9ZI9gra23VvyIDpYzmhXntYyu4G+I7zb1COgiNpeyqjYBZqIEgVnvgezGCMGYknXLFrWI62/nkOd0Tp51XhGhdxIVV1L9VnFuJHolMT4xHdI0BpORKyzNIz1UsqJGpvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQHGsqIQQnGhXSv2DWDDvVESo6SOdEgz41qpjO8h0JU=;
 b=NMEf22hgXv5S1vGyGhO5/jvt9b74HqzhMlm8lHA3t1TUwH+Mew0DLEjAi4J4XaWde6meqUJ508Fhe4Opdn+tmpdMrzQm5bWfNt0jdbPpjR/F0tXEP7xt6xShWpqf0COaI2slsnqYuP9s2c12k9A8pxFnP2kS1nKpzOanjZzK2YrR/F/UGmwBOzKugb9P/E1gRaXAXmUPyA7vZ4BHJvdasSsxGWMaOUg4IaSw1piPK+FNb6hLKaQ+SPNyKnUjVwyW7oDIE5O9a5609C/tXnanLq7kxf3ygQtYkDJtwUC2XGWj2FlwdyDSU1xr7w47KPk3fT8pJrOq/KQaILCaKIRrIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS2P192MB2094.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 16:14:38 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 16:14:38 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 4.19 2/2] fbmem: Check virtual screen sizes in fb_set_var()
Date: Thu, 29 Aug 2024 18:14:04 +0200
Message-ID: <20240829161419.17800-3-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240829161419.17800-1-hsimeliere.opensource@witekio.com>
References: <20240829161419.17800-1-hsimeliere.opensource@witekio.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR2P264CA0027.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::15) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AS2P192MB2094:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ece6b9-453f-42e0-d48e-08dcc845ae24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DlZTu5qIali6G1ba6wSggl5RTo0Sk3VTksL65P7SRcOD6dYxp2hp8GKs0Lwd?=
 =?us-ascii?Q?GHLCe9aDAL6wUfUXykhAWrIWfcc2BupaNUKU7TMfjtQOHgplNXCP2U43JkjA?=
 =?us-ascii?Q?lM6bYx1+4dKn9yQA6cSqlyZFoShwInVC+aE9O/VVVJ8VkVORdYW+V/WJFemU?=
 =?us-ascii?Q?RhJR4IoR8On63veLfA+SiDcxl7xMxPnZgyZThOOV+23Zwv2OpWpB/Oucu1rA?=
 =?us-ascii?Q?TOYUSQ8HybVyGLIMpQJwNjXf7y3rX+Ims5s9l570nyTuh7nUVeUssjn4M329?=
 =?us-ascii?Q?iBwS832IwtFsVU47oa1PLLpI4txjg8wptSap7YwGwR4fiq5LOOlov1JidRTt?=
 =?us-ascii?Q?y5y+hqKcBobaeh8arrVS1gpIjADD7ajdxjYa3JKHAP8BCGoc6XtUcp8HeTtI?=
 =?us-ascii?Q?zldXt0TtRwbex+EBTcnDpTCyclKgOwz29zOMswT6xCebsSSEfRhfAhWwr5jR?=
 =?us-ascii?Q?CABmzBp8StEf5WZV/T1gT57GQvY5lobvHiEPCxgcMQDOSzX56fDfjWhi2nww?=
 =?us-ascii?Q?9VTsgemxfPttwSK60TrsREzYlkfS+xG1NXKeO72K05daQxqLsDccrsrQvPUw?=
 =?us-ascii?Q?oWRPIp9hrLvrB0nWV36IMiLKD5pF4ahYURdN9CMJJkfAr5jjNG/LA18gJ3IQ?=
 =?us-ascii?Q?5Ay9uUiPbvPMcOZlwv7ngmHTPr1abe21CJtRqnVMHZysf5ZzAn02hFn/XYVl?=
 =?us-ascii?Q?ogTWCVce9bpRz1rUcz9rywU5TUwW8mEmCXlYW9IBhPccsEuy0zz6kAy5GxFF?=
 =?us-ascii?Q?Yjtqwr69hy9IOsbtb5afj1SIAta16xUJCMKBKWWvMz/d5yx/Odq9kRDud5nQ?=
 =?us-ascii?Q?bsQxTFnG8T9HYgMpPtSPtTfqfIRUqagrQP/tdfULqWd1qrqu8olZIb6aSyAb?=
 =?us-ascii?Q?3s4RqmPKRAv+1zsEu/4pYwhhmiTztn73esV79B88C5evXUflCgHefX7ku4A6?=
 =?us-ascii?Q?xOwhBjct/82wIeWRsFjx7arLcat72tTclnmXEHOpF8X8GkgNcK2JGn2uIqW9?=
 =?us-ascii?Q?9MQTCy9mewxsh0NOQkJOPc03n/+3eFm6zEYLlVoMO6/ZjbrR5GIkrhio/6Us?=
 =?us-ascii?Q?2t/MNG45hQrMf0igXDH4AORCE0653gpGb7SVkYDDear1c8yOMnRCdS5tlrM/?=
 =?us-ascii?Q?lAihtcMAHG4oUASzx7itVnUURyr8Mu/wsuhw/dWoSg/wn9bhidGxyeNr/+Jf?=
 =?us-ascii?Q?8Q5O3jUiajq5+xEqaLEnHxLvKOg8cKjRTrDyV9edpt66jnSEWRPFEUMyU1+S?=
 =?us-ascii?Q?24PJD6KRrFluOrLWKbqDbTcGEDvRkNxtbYfkWMO8k1cfcDdANGWQOi1U0y4n?=
 =?us-ascii?Q?Bp9/ogi62TMaDJZATVDWIbKe0c2VX4k0KyQ/QG+gwVfrFSED4ODxy0Y5jXY3?=
 =?us-ascii?Q?1rDISRcljV5oc5ORWLGqW4e5OFmlMtPWBhyjPacqSj1S5Oqgqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UxtQAHFmAvHt50BM3hHzhoDvoAm8RgmXsj5/bqeIRAJlYpRk8RgadrSCgFer?=
 =?us-ascii?Q?AiMfKKQYhfg7EYaSGaQTn28r4wm+i55YGMqQ55YAwGDdHAi13v+l/c0+T50Y?=
 =?us-ascii?Q?vl8U2kpIP6XHXQIsdUi4MZoruurG6UggETdDFGEwy7c7YPIz0dYa3pvwF8Du?=
 =?us-ascii?Q?gJsgRbmyK3LAguvAJmt81Mj/IaiGoJrm9Im4rdtq0GQeqT1jWgZBnWGHK4ag?=
 =?us-ascii?Q?8Sd2Rj07YIGyxSl2ThewcLmvLLAwb5GTpTvg/2onMc3aQ4BdsY4RvUETq3ts?=
 =?us-ascii?Q?hqBJkOfoAmoztbVmbkUGXnG2yrb2u7FguJ+0pAi5+G9VB0HTTrQahRAZ1nf4?=
 =?us-ascii?Q?5QgbazoYa1MOluuUzcOvYoG0/msPlwDv0tO7ToLDtzruOOhmujghM8CpCLpY?=
 =?us-ascii?Q?N0Lpf+Y1zEAA2gZzXPNu2N+9xm1Fjk+prC4A/a/iucBQlvtJLILNWFu4zpVJ?=
 =?us-ascii?Q?JOBiUhy8xCmaZR/LQOz9LKmXDaSxNspUfuAroqoIjJClzP3kGnvBuz6v3Mk9?=
 =?us-ascii?Q?RZStTmOmxNIW3fHU6uoVrhNJZTmzQ93QjGntU98vihhLlsqzNtelY2wq0f4a?=
 =?us-ascii?Q?kenwNBq8RXogla+4yYlV4kniFD49pCKbF8OGR4d/XikqMXYFCMf8g1rAyTQW?=
 =?us-ascii?Q?VYTJFWi07qhuOO0qgOFvlqDxbYDWPI6oJRd4wcnpvbdv7JSBH4Grjj1UK60i?=
 =?us-ascii?Q?ViDW31wTOVI7VsQTS7FoH8sDwsqvNYAlFTpwf9zLyH3X834eSoxy+rB3sO0D?=
 =?us-ascii?Q?7aCYNTRD+AoQAH+yTATyA4RwQFy2TGdqs1k1hCQvUoff+q2xj74HW3NKF+6M?=
 =?us-ascii?Q?1T2FJbh3GvasWCQZsTvxD3I3Mu1AnW6eszhrJwcx9+qcEh3F0cab1IC147gQ?=
 =?us-ascii?Q?+/0Emi3vDabRKzmsSp8BUAOpibmKiDEvTtalsrpYrk0NJ+mfCs5tzfoTjFeX?=
 =?us-ascii?Q?i53TRay5CIwDhcgTmuM9+xD7HGf0V0hVHztEsbDP3IK18J78N6Z5MVYB7tqa?=
 =?us-ascii?Q?mVd3lwcWT+pjWOWJVlJF45egFwKeiDGz7Q32TFTeQ9Rc9ySx65Mi20/pcVfR?=
 =?us-ascii?Q?RwBxXV3jmeFsaG73OqKUZhZveyI9QvgHpbeSIZztjUZq03R2Ru4pyQt/isg/?=
 =?us-ascii?Q?rUOsbU7m6rHYHOEVQdPysro8FCZpfL1zTV8OVInlCsxBi5/IL6vvIwxYKJti?=
 =?us-ascii?Q?+hwOmfeZm48biZMK1MWUnRslm6MlaRJOcIWuRr6fdq/P1f9AnEGDYyWY1x9j?=
 =?us-ascii?Q?sqle6R7zjTb7o+NWTNzydocs9DCIeb9+OzKwgeomw2cUwQMbxfRUdmR5jL7/?=
 =?us-ascii?Q?OKp75OBJ+tepZwZqVuVczXwrxanBlfhqfYT8+fHQtaO98RRkcTfWy60P+Qei?=
 =?us-ascii?Q?cqVU8HkMWAMIc5qYmrRWLNoQeZGTKfHdy/Oj0wF90/NPoi/SoMAWrTaK/TKB?=
 =?us-ascii?Q?o2wlGXdNcxUxG3mpbruLgoZ9X3KpW+CFrZYEbKCbkxFWPigkp4t90LLtAN9a?=
 =?us-ascii?Q?Ifc6Z5wW/09bXKKCzl8TimLYz2eeCgjgrI3UvfnWc63U7hderYzD3jPmW8Zc?=
 =?us-ascii?Q?2tCCTo37WLrhLNZlUOZtvOeCPsIAR8clJmih0U0w/QHuI6SHUN5ISn8vrpTR?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ece6b9-453f-42e0-d48e-08dcc845ae24
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 16:14:38.0704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPOlGIQPcL26NTUNzm2xXVTEry1eF21pfHaPyOGtZKhzHHZfXkFjgwQzIytqaukLO/d8J+9RYYGdQ+aMyMP5gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2094

From: Helge Deller <deller@gmx.de>

commit 6c11df58fd1ac0aefcb3b227f72769272b939e56 upstream.

Verify that the fbdev or drm driver correctly adjusted the virtual
screen sizes. On failure report the failing driver and reject the screen
size change.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 drivers/video/fbdev/core/fbmem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 4449c1fa9f76..114a8c534406 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1006,6 +1006,17 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 		if (ret)
 			goto done;
 
+		/* verify that virtual resolution >= physical resolution */
+		if (var->xres_virtual < var->xres ||
+		    var->yres_virtual < var->yres) {
+			pr_warn("WARNING: fbcon: Driver '%s' missed to adjust virtual screen size (%ux%u vs. %ux%u)\n",
+				info->fix.id,
+				var->xres_virtual, var->yres_virtual,
+				var->xres, var->yres);
+			ret = -EINVAL;
+			goto done;
+		}
+
 		if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
 			struct fb_var_screeninfo old_var;
 			struct fb_videomode mode;
-- 
2.43.0


