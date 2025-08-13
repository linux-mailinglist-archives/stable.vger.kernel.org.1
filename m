Return-Path: <stable+bounces-169318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F341B2406B
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 07:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAB8724968
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 05:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1622BEFF1;
	Wed, 13 Aug 2025 05:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="J7408CVR"
X-Original-To: stable@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011025.outbound.protection.outlook.com [52.103.67.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470762BEFEB
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 05:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063565; cv=fail; b=BTpbt3Va/BZjO+eL+6hDYry7WAmIaDOKnvkZgy0kqGdGxueAArLdi+wBgkOuLGniCRVtaCdSNSnrOnVBSEvTe6gM4N6NOAPGdWzgOnVxgu1VMbZO0gIEP3gkPHYEs/4hlk9GXmc7wrhm8aaYM9ckUsF8XAqGssjpNmj/YPID6s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063565; c=relaxed/simple;
	bh=4zeehl3WCHNA9TwSJm0xdSVRnCekPTa6EdxB0WOqBsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V8un2RhYr/HThQx5I6gqyDbPl1n6RfyWc0v/cEQUYzPhOO/tZ+ha8l62YUPmKwelvMn3p8J3XSlqWJfI4T6gZ7+lJCyjGHKRtTyjBn291ApvqhKrsjKFGsk6ECjg0CNALirinyOtldroq1m6DKLoy083JHpfdyrFn/wpXcGPb2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=J7408CVR; arc=fail smtp.client-ip=52.103.67.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2JWcnidnGbW6wSepLbbLdl5WrwbfpA0yYIbrWoq2fs+t3eSaR0K/pvbmYsIsZRtiVcYUnjLVo2TW9gN2pXLqToN2SDN2FqDCobTDjlber4VmeE7pZbondlNoLs457w9WFRKoRTxUcLR0FZNhLf2N0iLovob7I980FJoO/ljDJh0sBNHbOoIMTOzREIRRpO1OoQpwTuqX6L4Lx7OFW+3KaWsUyr4Qs7DtDVeh7SPxstUMVePboI2fRl5rgnNuQE/oPiGGGg/vCCcSqTSKgQbKs8EANbuTCeoEaOkxeEhMH+yglgSmQ3nnmoufJcQoztpZJbtQzhCZIIm82zaszYB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYHvCK2IBk3bDF926244PyDvy6evKPXvtiV5VnsrUeA=;
 b=jO0lgdzzgXvc89jFTtZw/NSR2RgIjUpB8A45fIpywzoO+xrnGQ9ZSVc1VPuWkNY2sZi8E0+Nd3ZR1uUcYIUv9iO/a/4Q3/nIpbyD4mC1OMdLUvnGqmGXaUN88p/GofmxYDxaO+r9M1T1PBGq2qlg0+KCjX9dBIY+EENlprUG2NYKI5Eo/AMgCpNSxByL7+sTewn8GkSdtX1d0ADtvgwXJiBqzw2GjwF86a9A5rIZNsKSVgDfgSzFfG5iFw0X9DgBZNfKFwUZoHoZcfq9IjM2n2r0rDTlC3uRPqB8L7are42Ur6qdazWVmsZ2AxaDTRDYFdhcb2XXWWkwtkxDOFrtFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYHvCK2IBk3bDF926244PyDvy6evKPXvtiV5VnsrUeA=;
 b=J7408CVRTDQR6fi0ZqJjVBK4CPFu9Rp5A71I8+1j/NRX03+kPvbsnf9NCYIyx2LjeRMF3XdxX1iORbOs34zi/bFkp9YsghfTBzubYcEN/AciM1PZH4eECYxs9wYLUhqAcfOIYheCdc246izp3CwiqDhOXHSybg+yotHwWYgHPOuUFObiCZVUiRjOrdg+dQLHUHiphbamDqJ+Izhn5w5uZCL0F1Me4FTaCD5Vzk67T0WVnVA/cmj2Slf2V2KycE/FIZ5CoVAf8/vC2tiSAjcDqMMUySWCm2tFWveyy1TDwc8oCx9LcsDDLTBrpLCtVN+xMjtw0ghThOkNpBvksptlVA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7358.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 05:39:19 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 05:39:19 +0000
From: Aditya Garg <gargaditya08@live.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jkosina@suse.com
Subject: [PATCH 6.1.y] HID: apple: avoid setting up battery timer for devices without battery
Date: Wed, 13 Aug 2025 05:38:56 +0000
Message-ID:
 <PN3PR01MB9597CDF338FF40D8D9E84BBAB82AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081202-delirium-stubborn-aa45@gregkh>
References: <2025081202-delirium-stubborn-aa45@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0111.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250813053856.14782-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: eadbca20-a3dc-42aa-64e3-08ddda2bbf7f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|41001999006|5072599009|461199028|15080799012|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1k1xC0//LCZHx46SgdOCOhnehX5YYweadfHRY800cmev7VcX0v08O0BD7fIi?=
 =?us-ascii?Q?A6w/PPDgFRXoQ15WKxIo8jeCDNnKRi/bImS43x/d0l1LXlXoAkuvPVol3anp?=
 =?us-ascii?Q?QlH8aDr3aWF+ayE7j5y3nYqNOybHLKsAO1/EXLRZU9KtrS3R3xGKtzBBI1RL?=
 =?us-ascii?Q?PNyBB6rjkP/nOtxTvpwnL8wM3gviPxH7204oE/UaLo6s1zyx9WodulRLs11p?=
 =?us-ascii?Q?Ntaya0e9z3tkR2c+djD3+MGZpjnGaDD+WzFtt3iXcPMjsOXtkP8CSarU034P?=
 =?us-ascii?Q?EfJJMwgjIOTrnUWBrHvT7iiWVPi53pWLaR8kiJBUbR70598wzoB6VPH885AR?=
 =?us-ascii?Q?suWh0Uy8UhqeQMBlKHSW7TEpDwBZPSRzUg/Tg0fcjVeH8B/cDgvJ6DWO0Ku2?=
 =?us-ascii?Q?FITrTvHafsa+TE+bhuhzbenj8L3KIxQsMYZ9nMimwaEIFMku/5lt11q3iZ8p?=
 =?us-ascii?Q?Nt+NF857R3VqDFzkWlj0G1ix+AaI3BjGA6ZQp+cw8XNMxHTcrkeBfWTBmTpB?=
 =?us-ascii?Q?5TZofk/I1wAKOjqDxRYOmKQzclh0uPDIsbGUJSeMIko6FG1z0m+7+RlanyNv?=
 =?us-ascii?Q?kP4BCIMyQjeFHN8u8w7y8vewVKI8Ts3DrWqW3HpTIfNe5CNdl5mLm/f3FLlT?=
 =?us-ascii?Q?+7CGh0ohOqO4B8fecb04hGwfl1Iq3s5Xeeivi9cqfTT6H4phgS9GFKM6kiEw?=
 =?us-ascii?Q?xPzXE6yrZxhHMwX+Y5WgmBZDJFpVoxEXpW5rON74A0MwnjA07YJXrmlL+vl5?=
 =?us-ascii?Q?HtXyFo2aTS7jLdhtqvTtNbXDcJPARhDrwRwUkl6Ss+d/KKsO626tk35zzCQn?=
 =?us-ascii?Q?XNJJnPtB7h/u9ek6qqRBuHdAsauZDuQyu48BCi4gu4oInu21gdOZJjOnG/Os?=
 =?us-ascii?Q?11C6URRPpfQqKwRjYF9H6aMLXQyK8wCcGhWdMDa0dgMpZj7PdXK7XZZ0bY+U?=
 =?us-ascii?Q?iLlqi/l7ZKzJfa1YBNzO2X9RyHEpjfJdzqEJLGKBBhqzaMZIZSilMeGT+zUu?=
 =?us-ascii?Q?cBo1BoYxKcVVBw45Xs2v93/zb7lB+w4SozjdqDzJHLbdAyHe581EYDQAZ4e/?=
 =?us-ascii?Q?cIJVL7tlLjeLXENE2MMSy/rLU84zTO8srxrWq3y8A1yUx+r5WO8EneG8r0oe?=
 =?us-ascii?Q?g7cPRPFKZu+1nMLYetlW6hu0xnchWlZFzw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AH5OhTqMYecFn8cpRQuniU20s1qT6d6wiIBoFPr5hVO8cA3dI2abUwuzbxXq?=
 =?us-ascii?Q?YVfuSNHvvLcpUyNHHl37LF7mIZFUHeVz9l1Y4U2IjCrgw97m475Q+b69QfgT?=
 =?us-ascii?Q?JFje5+M3vRYiWivNgJ1TW6w/7angF5c7vQq0xGpJ2ZoLWiBsIrqH4wq4wj4x?=
 =?us-ascii?Q?zZa7b5EEaWsZb4sZ23uBY9FLte5owWUwPLZkfooW/29ggVuMVwpxAKl2df/k?=
 =?us-ascii?Q?haJINrMaYGqpiK/uHz4OlBKiYbamxvfJY6S3XDPElPuZZtK3NVN6pYhmWQv1?=
 =?us-ascii?Q?KnXNzUljgNL3qHavUh91VxPqqGpHRol5ir0RS5jepKLxwFuF8UIWHctwhja8?=
 =?us-ascii?Q?T5dZ7CmEB15F+dVCIaV4u4KaLDNEyG8AItcqcyuBsQDFEXqhoV79zgnN7vkq?=
 =?us-ascii?Q?1OaB14yljHaVnkypHw9BR2CCO3ZyH9iHTdHaMg0nsUZjhoXFZD4gCHg7hlEM?=
 =?us-ascii?Q?chrPwUAF+SKZFxonVgyO1NxN8PoWnYj2cTgfbL/xPnns74XXO3vdBKnDJVnO?=
 =?us-ascii?Q?mm5W7xu4vo4Q52EY18qrbWRMUYcltu4LyNZWRVXrhiKxyFYugNRzeb9dprEO?=
 =?us-ascii?Q?eNoNdaxPk0BSFcj/nsm/fkcv3+wcRhxfpA/I4KbzW6InuhxdQQ4sokO/bUBR?=
 =?us-ascii?Q?62dO5sV70ibC/utsbZOo9WQC8bIK0edznFflMnhT4yax7V3VjI7tV5sfDisL?=
 =?us-ascii?Q?c8WFju6VC0tZKQL+HOusAlogN7+zagU5y3sw28mIJLfl6GA/E4acOTfVq838?=
 =?us-ascii?Q?q+L8Sqgi/IMY/tvRqJA0I/347aOhjSFrtNl5visqr8KPBiZ4gO1DzjlqCgFV?=
 =?us-ascii?Q?cXuxz8SMz0skjUVALjraLVunKYJG8t9v17tH06FNdg8cGbzsDmyWj+DviM+Y?=
 =?us-ascii?Q?3eo3j+/BXAMP3M11tLFVQQRIfvo+I9EDzIsfkNMVfEbHQyynDUYbZmbmI21R?=
 =?us-ascii?Q?kZdKlyEmwTj7LMz0QbNy7A+ND+LqA5cBsGy3cOeVKgSlHIrReYgz0GkGEc6H?=
 =?us-ascii?Q?MvhoNZFTdO6BKnFj4xx7riLNvDTtUCE0Rak3tkiKVioTK3SovgW7syWefdRs?=
 =?us-ascii?Q?yWIBCCi3uxrWghaJ2X5FKnN9/iBkoryD7lc8vUBFAzM+0eQb6xmg5IJ0pCO5?=
 =?us-ascii?Q?BtPT44B5CrPUI5Ib7NxeMvhN7gWGRTJK78eOZcg/+Pebj4lpO98EoDPVoVJ2?=
 =?us-ascii?Q?8+i3cEwk7rSDMP68+/QFOXpzT4oqx0WxieL39faZhDXhqJ+hlZFekBKbEzE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: eadbca20-a3dc-42aa-64e3-08ddda2bbf7f
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 05:39:19.3388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7358

commit c061046fe9ce3ff31fb9a807144a2630ad349c17 upstream.

Currently, the battery timer is set up for all devices using hid-apple,
irrespective of whether they actually have a battery or not.

APPLE_RDESC_BATTERY is a quirk that indicates the device has a battery
and needs the battery timer. This patch checks for this quirk before
setting up the timer, ensuring that only devices with a battery will
have the timer set up.

Fixes: 6e143293e17a ("HID: apple: Report Magic Keyboard battery over USB")
Cc: stable@vger.kernel.org
Signed-off-by: Aditya Garg <gargaditya08@live.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/hid-apple.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 746b2abfc..76b76b67f 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -824,10 +824,12 @@ static int apple_probe(struct hid_device *hdev,
 		return ret;
 	}
 
-	timer_setup(&asc->battery_timer, apple_battery_timer_tick, 0);
-	mod_timer(&asc->battery_timer,
-		  jiffies + msecs_to_jiffies(APPLE_BATTERY_TIMEOUT_MS));
-	apple_fetch_battery(hdev);
+	if (quirks & APPLE_RDESC_BATTERY) {
+		timer_setup(&asc->battery_timer, apple_battery_timer_tick, 0);
+		mod_timer(&asc->battery_timer,
+			  jiffies + msecs_to_jiffies(APPLE_BATTERY_TIMEOUT_MS));
+		apple_fetch_battery(hdev);
+	}
 
 	if (quirks & APPLE_BACKLIGHT_CTL)
 		apple_backlight_init(hdev);
@@ -839,7 +841,8 @@ static void apple_remove(struct hid_device *hdev)
 {
 	struct apple_sc *asc = hid_get_drvdata(hdev);
 
-	del_timer_sync(&asc->battery_timer);
+	if (asc->quirks & APPLE_RDESC_BATTERY)
+		del_timer_sync(&asc->battery_timer);
 
 	hid_hw_stop(hdev);
 }
-- 
2.50.1


