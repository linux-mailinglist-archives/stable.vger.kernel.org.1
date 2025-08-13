Return-Path: <stable+bounces-169319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F93B24078
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 07:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C12188CD69
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 05:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAB32BEFEB;
	Wed, 13 Aug 2025 05:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="GZMYoO7q"
X-Original-To: stable@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011025.outbound.protection.outlook.com [52.103.67.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0B62BE7BC
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 05:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063639; cv=fail; b=Zhdyfp3IeUCkYOT37BaTDVxwv6gkX1zwzF/NAVMHIqsVTs29JvaiT3mbScq7PE18gBaLUvUWXrKn56lSNJoMvhUU7vjTgB+YLsTS6EC93jjvzTqeQqC0z6EwIJSiEP3ryp9M8K8lBIvutp21KXdBkr0Ig+x2FsM+ONaGpM9t7LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063639; c=relaxed/simple;
	bh=TpcIektxn3Yr5YSXZd5WkFLkoqSKV3uXQmtXjEUrQJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OEp73/6E6G7vYXZSP4uwzdXHnr/WvzhC64fQyronWieqGOeHFBC8JV0zoiczPjpmpbjux4GfQ4YMcFuYTXmMC/DlVTu+ZPXn0ujeRlWiSfLMXg6BLpF0zh6VASEdOj7WxNH8GwSZlJs1kjeiCaKQV702AY619pd/tmUg7pgAldg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=GZMYoO7q; arc=fail smtp.client-ip=52.103.67.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHJLly17D2QHQ7Ro6qDCdv4IY+VqxmwaXJ793XVNozOGtWacInp+I6ZEYb3i8xqbqqH1IBEIhSPelpfpznT9Gw1bkRLt8xRDpr6wkBzoGESm+/5cvp3smrWhVBDhpbx/lRqXnD/lQrzeGpy+MxX18ECoPcDK5yyOZygmCc/Jaf+jXCykJsERJO4hp3L4hoIXecKNAMdhc6ZlWYTfzf0gZOZhBxQQ+g8KvUVdxtjDYGQfvT+ftPGej1Nc1Krvpk8/O3G4aj7Y9E7DnIsFAk2oBbiemEo+03TAyiJ6AO3j7JgScO8gMwAgZD+195IGgWhdNVNgJzmXbXrYxh6ThaS+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q02yy4v7gFGL3MWZeJT4jm1J0TLIsMy6KL5VDQRNUsk=;
 b=RDKV2FQCYY9KGTmS1bFJGk5juerOfGh0khx83Fx9/qZp056JJCv/QN4VJp/hUvUTW16w+yPDYDHdsCGj65IynG5Fszb3qZ5w6l662IrB6v9SnEnQKwOAx/W5brG1q3adukubkc+DaYuemlOT6Fdb/fsHTG/uVN93NNcrziBJjyWegc2W4VPgZcWvGK0Nw/snTRM2ld+gm5SiHg2DCEN6DvSz1KIBIoFYKBUQzKmm3G0BSDgXwk3TpyrOvu+y86deO5MSph1kfMpIMDLM35Ol3A3eKdNeGhZ9GHTDb24xjhHtqMydziLuNEQ8udtAAs3iUs+AinR5s8u7BvBA1tFRdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q02yy4v7gFGL3MWZeJT4jm1J0TLIsMy6KL5VDQRNUsk=;
 b=GZMYoO7q1ClzWoAO5T9T+9E3DAT8aZzj2bDZWUyil0EgxwdEsWkXovSYp6qBm92DvEP8Hv+C1CAw+FtnXBfiUml1uhK+NZm4/fyh3I/D+pvPvXo+ix9hS1C9dzfdDo1eXR3OMEMbzQY1ADlmZpvMmpeS5tWQ0610JIDDIOmfk7SJLpqYN3C3dmmd/5lEzFS6azeMNt1JzflSdzreX7qtY2i1kbWxCHD9cNGZXVC5SHMoXWVa4zoQZv0KIe/JRVqVsOMmME0EVNuaGrNRydx+TqQzvqUEtL4rII9/FxWrPEC1DrFoJCZ3WOPwuWX7FGX48JpKw0w1W/ok1eFF9astqw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7358.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 05:40:32 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 05:40:32 +0000
From: Aditya Garg <gargaditya08@live.com>
To: stable@vger.kernel.org
Cc: jkosina@suse.com,
	gregkh@linuxfoundation.org
Subject: [PATCH 6.6.y] HID: apple: avoid setting up battery timer for devices without battery
Date: Wed, 13 Aug 2025 05:40:20 +0000
Message-ID:
 <PN3PR01MB959751E2363A71C9F1CB01A5B82AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081201-undamaged-referee-deb6@gregkh>
References: <2025081201-undamaged-referee-deb6@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0035.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250813054020.15530-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7d678a-57c5-4dd7-28ac-08ddda2beb46
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|41001999006|5072599009|461199028|15080799012|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A4ozSawiEAkw4ime75XqnBDVc8Z4EpThifP5eRn5actTACIsaiQ6srIaBbp2?=
 =?us-ascii?Q?OGz3nkQqRZCzrCyuy/Ed479Uv5JxnZ+ghG0eXiRAJvc46FbLewfnIIu4Oxek?=
 =?us-ascii?Q?k/n/ZuvBm7T/1BEzCrl1Jhd/31WRjdQzCA6bDvh4Q46t/JZOPqsMu5MfpeJS?=
 =?us-ascii?Q?xaQ4pn69YMpL0QD6PodVdG8LD34OJkBcxdgcVCaGbLFHQQmg8X3swOOzrrAL?=
 =?us-ascii?Q?k8OhuSyRaLCbIrzUSFJHe/AtGCGIHLIcbHnw+hW0Un+YSlHNHViIfyyFyAaJ?=
 =?us-ascii?Q?y+JTSqPpduPveJRRS6gvJKZ3savxyXR4wpKnpfgFPlRzaTRNpHyluhopxd5Z?=
 =?us-ascii?Q?OM6YVi/Tuol6REMTBXJD6Ze/aVCxMBogekg6QHjsY5f5H8haaAYevOj24Dwc?=
 =?us-ascii?Q?xNOayHFnHPaYK9x0TBc4dV6eVLOuDxq+Ypoe3f/iksi8l4yF3MKq0M0OcJob?=
 =?us-ascii?Q?uUs1Ng0s3VKqvI2lYn/BNtHOHsbEzu6PIN7VqzbrOaifwwE2i4t6R37AOym+?=
 =?us-ascii?Q?LVOZ6W1TcGt0VKIwAiBwMclEk61hVaT/mxqkZ32i3M9zm0WUI+oDL01B8OYT?=
 =?us-ascii?Q?WQMATkQKTLXXUvP/KlKIG7ziuB+5ozj4rC5UiPgf0txjhSUf0kFXTq2Hezwl?=
 =?us-ascii?Q?vKauuvDMQSAUhHvHYmeRWj6hTw3nI/+WArZg1SPWjF7yI0vi1PYL6etIgQoW?=
 =?us-ascii?Q?ftrkB228vB4visG9Awl3r1JSAiUogadSPZ/Yf+ckfsQ5DVMxlGTDdjkFnKHU?=
 =?us-ascii?Q?b8tIetBEQLQASSAbDeFN7p6qaB1vq98cgCdB3I5GjD0nSyzJTeZbEcXkWPb4?=
 =?us-ascii?Q?uNV3LNf51XDPtexeZ2xuSewEVyZYjdWAgpbfFWuk8zCEJ0NOCqPhUTcgCMk6?=
 =?us-ascii?Q?VERJdbS1OOv/DB3e1G+O8c7bEZTr7g7HHZz2ik+ki65NHACRiqgT9EU6fvU6?=
 =?us-ascii?Q?dTS1DYlmHTjs0R2auOs050H7TtTAiFkS6slHMLh9Pft7NBfZcOF93v+NpXPa?=
 =?us-ascii?Q?VM28fLPG/0KFZ5AWr/PE88PZWCEyox1gqnzD/EDCbmzWLS5y2SxKLi2vHzng?=
 =?us-ascii?Q?GVMFW5kgfap5FaP2EB0A9wLo1xKZ8EvI0P96AUFfW0FMxyWPky+DFIvMkAa+?=
 =?us-ascii?Q?nVhuTd5nwouSyXfDdA0PYM/V8GYPsfEiSQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nq6X0l4GoWVvH4DgzZ6Vw9VR29OdahgNk/KTM0hfhTeMMp1EYWxPRV8RROI8?=
 =?us-ascii?Q?sXccPyKUi5NYjm0h10WEykUx61b9zMa7InDuDBSwoTZzlcepTIGOtA3BkSvD?=
 =?us-ascii?Q?eg7EMYSL0tQpe1eNdIvWOcUAGu7kPJA0cpSfHfu+rbtD23tpY6xQ2EqClKLE?=
 =?us-ascii?Q?W+dJDIFxLDFpW3RHwCfpbhoojxZ1MnHeh2TkRL/R1NQFxIpMAZTNREUUK1WD?=
 =?us-ascii?Q?7Ff7ZaGCHk6yDYCG5KRmE4CCeUPey3nZijL4np40B+zKEzFGIcAGOxyQeS3R?=
 =?us-ascii?Q?WDAmKiqDkhik7ML0UIfjLmsJ6SQZwa8Ix0PPOQJ+Ml1se9wGZCGE3t8lvS6j?=
 =?us-ascii?Q?fcyxeNt2kQmVxH1rm4H6vf9lwS5LWZo4J0OYv29fS3jAYhcNCP7H8wgXAVxD?=
 =?us-ascii?Q?pK8j2eUzLoDIc+b+uwLJyMvQLrhnzqXMEyUGqcgK34gzREE/OqnOEOPs8bCY?=
 =?us-ascii?Q?igfaMWHS6VhwXbElY6s185qDUNt3GfC+skqj02J99KBbxIm3tFVqq3bO/dQX?=
 =?us-ascii?Q?pcrJ4JjGoKnWDqDFN2df2AkqHc6To06xJdGrH21BvCx6khUbiQ/XcONrus0o?=
 =?us-ascii?Q?48D00WvsE7cOCM/G4Q0GyCD5li8ZeCZDHbGUn5tmdJxaS5Hajqjob04XXezp?=
 =?us-ascii?Q?rvmW2XaCO9m5i/zc/rAC4ThA0zPBOTx7ZLKzJMcdm94G5XWu0uuI6bHISnqW?=
 =?us-ascii?Q?n/XXWeWZUAfgluju7n8YnF1ZTm7kpStiPRTtgNb+UwGJuiZRU4MOUtrGrpRE?=
 =?us-ascii?Q?xdOPKh3u2kwaiLBcKDoxBnGA7KAc84r3hcdFDS7zpGdTm98LYUswOqh99J6/?=
 =?us-ascii?Q?DlmLOSe/1f+TvA+/sOqOFj59jtGn5CzmDwFdj9VzxiRb1WTMvE8jXNCFNFlK?=
 =?us-ascii?Q?nT9KHSa6I3l5sV8gu5oGpHrgpJvk6UqXCjonbYDfK+CipGDstrmaX1Yf8+iK?=
 =?us-ascii?Q?u4v9B4WvjfmR33Sy7vWcoC+Vtzg0qeHMk51Ovht25gf9vWcDjaQ8bU0+tnuB?=
 =?us-ascii?Q?22eP/qeikNl9G8NRpzpSK6vyo2evS62LlMltfOmeOjR3uwaFPU4bKCSIXCxO?=
 =?us-ascii?Q?Irh0N+ErDqVPVKUVLpTVZEJehIAwZtI+LYRuzTUKht17ywwh8CsETVP7JRyu?=
 =?us-ascii?Q?qUWLCapXKVf2jC+09y5LcVIxZyGX4Mr8a24IQQZthxbLnsXFpSDdRHXT9ize?=
 =?us-ascii?Q?V5+Ug3y43gZR9RO+96H2swQP9z6o1AKAo6oZ4jJ5cnpkdE6e+S/tOsIbRJw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7d678a-57c5-4dd7-28ac-08ddda2beb46
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 05:40:32.4485
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
index 0b561c1eb..7cf17c671 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -858,10 +858,12 @@ static int apple_probe(struct hid_device *hdev,
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
@@ -873,7 +875,8 @@ static void apple_remove(struct hid_device *hdev)
 {
 	struct apple_sc *asc = hid_get_drvdata(hdev);
 
-	del_timer_sync(&asc->battery_timer);
+	if (asc->quirks & APPLE_RDESC_BATTERY)
+		del_timer_sync(&asc->battery_timer);
 
 	hid_hw_stop(hdev);
 }
-- 
2.50.1


