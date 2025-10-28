Return-Path: <stable+bounces-191514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545ACC15D83
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 17:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0613B243A
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 16:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546BB286885;
	Tue, 28 Oct 2025 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IFowc0kq"
X-Original-To: stable@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010017.outbound.protection.outlook.com [52.103.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206C320DD72;
	Tue, 28 Oct 2025 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668879; cv=fail; b=jsMNZZM+6V8xbIOVYDIHfxwczq8yfUQEwMxcJGBrhf9aQyzc3Rw81yWA5lq+ERPgtg7d4glP24Y6nOqv3ikWOuL1wgXxgQ5Aqf2gvwjebqmdKTrT0DooiDx2fYcda6gjHbCLYU9ek0f2fbqv3nJMRGZODp58qh4WcGwc1pEiG1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668879; c=relaxed/simple;
	bh=8VLM/Ez7Dr9J6m/tw0wkEKTf0u2MENeGtMZrTZwEsBk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ta1X0Cl7ote79gDpX6wTB2cH9gR82ToR2iIhkGA8eCNuq4b5/LK+9b87d4PORKiltLKCNm30SJGDq4DzkfJEKS6PpDtEEFJvmEi/zJsPCfHLhmIwPmoV4MiZADeSOC9MfnNu68r05RXEwEmPkT0ahsuFT0RWxhfVcfmeoOrmEck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IFowc0kq; arc=fail smtp.client-ip=52.103.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CixACVl4OfMu1NJKupZdF2GuM1sz7wn/ks0gIv81D3RZfXaAY5I3QiP9TEK6IN/zUx8D1jPUNYviKFA0HLPaIm/HEjuFC6GkLAL9SGZUfizidgYCo1nbtfX6ZINXugB+Td2sIBok1xbf8HT0b+FtqbYqFjNaoCR41fWsTAV+RyEa+NAxfs5RXkiLQ0u3ODiKg9bx32PHi48moF0wGLRWjLh1zzDy7oAWLpxZVM2uNm5wRKuQxk0/yl28vAGny2S8UHbgOmEcWYlyThdiJo3tFUY46rpfsI6ziIouFF4MOK7rld3wdvcFwlZPiVW8w00gmRpDOjdv/nXmlqYuEWGA7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eR8YdU3jvu1Q/TsWebPHi+3Qg2h19I52Bia3DyufsCM=;
 b=HzBTaECHC7tr2HmX2pFu3zVDhabnD2Ax9Hr1KL9XiqT4Nf+51Nz9Kf7f2oSOhPnQnY5ABYt+KlEMzNAtISH+/QNCrsBaukLeSU8cx6frLTAtS3Wd8oHPgcNSOENRfRlYcUrd1g5QpXnV9G7HEiPhXP5oEckRerlBMXOd/IYw+2QBOoLjaCQ7DDRH/82yLwksjB8oxPWSfc11qUIr5zX2b6GiNBOfS/fb8oaiV8PyQF1DaAxbkRSaU5cdpDOCacN7RKc/2TP6XOfBUtflqI2hd7sZUIi1XmjUY6V4MQOd5j+P9E8gJ89SbCDqFBlbQcJwOO0saja1i7TIB/+T5mbZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eR8YdU3jvu1Q/TsWebPHi+3Qg2h19I52Bia3DyufsCM=;
 b=IFowc0kqe7ooQqy5KSuatm007rpTc3m1+w29aIea4v0MgtLO1BTcgHqwS2o65zRmhjh+mbRRKYO7ECPATMnSkxna29Bjh9p49dbrFFPpTYKPORJ1vZ5Aftwdzrr3VXInvaCpsDrtfXCVofcG/oLd95x5LEIn2hK0kaqE9dSMXCSIuejUQwbRr01jUhHK0xZFbmTQc44Cd7925BBXyQEKLYkR4iCvXjCLKxdMbgkcMEITPmU5dGhFrTCf5trEqpDwZa/1uQ4jK3BOgoMqTWDaQpLbeiWfsRPDeIcCk4wgRHhdpOLE7Vosl3pRI+A8+6PgE69NiGD76m8Citdx3ZkvRg==
Received: from ME2PR01MB3156.ausprd01.prod.outlook.com (2603:10c6:220:29::22)
 by MEWPR01MB8833.ausprd01.prod.outlook.com (2603:10c6:220:1f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Tue, 28 Oct
 2025 16:27:54 +0000
Received: from ME2PR01MB3156.ausprd01.prod.outlook.com
 ([fe80::443d:da5:2e96:348d]) by ME2PR01MB3156.ausprd01.prod.outlook.com
 ([fe80::443d:da5:2e96:348d%4]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 16:27:54 +0000
From: moonafterrain@outlook.com
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>
Subject: [PATCH] ALSA: wavefront: fix buffer overflow in longname construction
Date: Wed, 29 Oct 2025 00:26:43 +0800
Message-ID:
 <ME2PR01MB3156CEC4F31F253C9B540FB7AFFDA@ME2PR01MB3156.ausprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.1.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::29) To ME2PR01MB3156.ausprd01.prod.outlook.com
 (2603:10c6:220:29::22)
X-Microsoft-Original-Message-ID:
 <20251028162643.44453-1-moonafterrain@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME2PR01MB3156:EE_|MEWPR01MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: a5791d70-501f-4719-ef4a-08de163ef204
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|15080799012|41001999006|23021999003|461199028|5072599009|8060799015|5062599005|40105399003|53005399003|3412199025|440099028|3430499032|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FcSCAKgMnmyjJJ4JGgLKVeQfVM56aiUm+9Q7dHvAoh2+hL1HNWTOtI5ADm/o?=
 =?us-ascii?Q?CZILYVH2TDDOwrPB5AQMJz2utbNQAl0bwr5B4alWiAy14YDJSGXOxpC5xB3M?=
 =?us-ascii?Q?hm7Ijs+Fo7AanZQv/T7l7vKaiy/KeoVykTKiYHvU48cquRC1qHDoBy9p/yrZ?=
 =?us-ascii?Q?FS276iPXC4GtWo7pH6vvG1WikYrflQqtfROcTiZch1kAWuiJ3RHDtfdhjww1?=
 =?us-ascii?Q?7h/hVn0867RLzJOZwC1sliJw1Ib/2pJCdvs3qFCF+dRqPHSfK8WPdOxZs5Mg?=
 =?us-ascii?Q?vVk/ubGUxXBa3PwhPq98RHHyFTSAheSro37lsfY/yHnZPY9SMZ4keXBMrZ/P?=
 =?us-ascii?Q?CeZ8wQWL44+v0FfdHJk0QPELEhlFpfk+DhJ9vW1CVgqYhPWE0eWoE9kJRYov?=
 =?us-ascii?Q?Vw29wTj9+TSVjaw+1ynzgEUmGY18NLtp5VIQshlQGKNSTcqL15Xr+Z+GNFoH?=
 =?us-ascii?Q?RT5SZFqbNS0jokZFHrwYPE/zRv6YMLomv2VwxzqPBVQFZQlY5pESqeDHkhKI?=
 =?us-ascii?Q?fXVD/A+NVlXlgmEMMEUU2dnZbGx8Vw72Mhq7ml9QECKguQOOZHzjxF/bdktI?=
 =?us-ascii?Q?dqJd4rA2unTq0xeLxYMK4wqQV06nxsr3DDXYJ3kwHqDTlP1IZJNj1rplAQya?=
 =?us-ascii?Q?K+Tnqy0I2SJ9gq5ClVpsUb6qbvgdBzybWRS08COAMR+/uWk0cQQtIX7V2YnY?=
 =?us-ascii?Q?CopfjFzBeK2WPT8TP69YxFk4ZhPKb8rWRRX/as6UW21qo9GaaZr2CxOfL3ve?=
 =?us-ascii?Q?AMtoPbPFRis5qjlLuQmj1asQp4ukN5aE4+28uFl8/l+3I3ST5kWuKBwAyM7a?=
 =?us-ascii?Q?lswnuohtBoAW79Cwf7HP7QV9byXelqo9sC0R/gVmHu3OvDhiOCTE8pJN87/O?=
 =?us-ascii?Q?4A2mZoRwTXGdcQxw8InCK8Q+FWgzlmjR0kS9lpSI00WTvcxr5ao/sDjhV5Tx?=
 =?us-ascii?Q?MlscjF2UeiEhKOAOUTgJ/OfP8GPCaMf85fCbbo/WXq0lzCX5wK753xxUW7v1?=
 =?us-ascii?Q?HpWDQmLSmVlRMQNKAJ2yMBhEGSIa6hdabdyP1PQqAnb29mJEV20kpWM63F16?=
 =?us-ascii?Q?aZtt+ObYCI7NGyh5x5yZrjbaNJwjYdlDx+XjSG9sWObWQtuu2S+W9zLnio/X?=
 =?us-ascii?Q?wnwEa8+qSCuz49lOkYdsh7OTis+MD/31nDob74dKDYyNj/+NT90qDEuNfMGb?=
 =?us-ascii?Q?jOxlep7qfiSH1hVMYf8u1aENPhSxqOS2qVjyP59VGLJBF9fa3T7L+ViUR/rd?=
 =?us-ascii?Q?uwXVsoRDHjakxkv5wHnfPASbC9YPBkAlJjI7BADnjw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PltOBdQV2IQ8DfKYrtvEy43+X5kvyr9eXdSQZ/UgthXLD2D7+qoIos+1vM0/?=
 =?us-ascii?Q?Sr/g4Ls0P3WtY719VDqElM8fkA4v3EnGkY7la6gHo0GzZOpYUpwJ2pmvV0x0?=
 =?us-ascii?Q?1oh/lwU3S4VpUlCKhXQifCSJfYQCJGtKRQz4t+m32f1QaXs4Koz2zPWE06FI?=
 =?us-ascii?Q?wOyevJ627IqIMkedmpVwiskwAXfjc+Otyg22YyFokTBtU1U5xZvs5Ivl8zHK?=
 =?us-ascii?Q?mm2jSQZVcMXuoFWKOmsLeksj1MLOD8u36kXZloHHILuBT0EbeUS8MmZNpQRs?=
 =?us-ascii?Q?XqSnnNfhVgMES/vRleO1sjvyaFJORPjEyNETAIM0TOoMSPJ/GSp9sgE6LUpc?=
 =?us-ascii?Q?kHpoVLX6PDUhS7eaN6It+A6iOj89a0iR+/ZVc3cELAWVvSnB4IqYlJDTrAEu?=
 =?us-ascii?Q?cgA4waHMdEIfS23VWW2LVQ+cRB2gMlaUQzbCW1A9xkGiECo1VA80HatLr0Hk?=
 =?us-ascii?Q?IrR0Ba/JKqWUub3zB+/psu7z17bVjNIKh4UQqJC8F4lTNfPU4EBD8Cd3NbYt?=
 =?us-ascii?Q?QW+pWx0wjNOeD5f/j/HvMIE47gz0cw+iq+PTq8qTAmeBHZ6YX83KAe5DkLVI?=
 =?us-ascii?Q?m1hM2HF3t6emIEqVlF+xEOKV5aqXv4oQRzDJtoyKMwRmYfoT1Vf1ENu7adZF?=
 =?us-ascii?Q?ohLb8cC9D1et4ziMA1pbtbn2ShxmiHAKElI/hD0ksSnQRalzgABta7to5imU?=
 =?us-ascii?Q?HlywTqI5ZEsqwBJOeZak2NW2nNDMOPnpi3mwSH3UUSc+ltVkph+5FK4hZSZ4?=
 =?us-ascii?Q?BScknfGo7FONTOmS3ocBZ7l+amyCrHonM6sO6jJSR3YvN3Lrh5Uk6oImrsBA?=
 =?us-ascii?Q?3u6EwVyC4Hw7S8jlESNr417ID8mGijleUWPqMSmxDLrOM1XtSnwwpqk8a7p4?=
 =?us-ascii?Q?dOqOEyi9avVMH0TovlRhbfvoBhbtDCdcNHS17PMErFK17kNSi8Q6HsCrpPPs?=
 =?us-ascii?Q?h17rkllEo8qn+yzvA7E45xnZX4JRKnzkJTi84Vo0k0JDCun+5CfQP5FS/atv?=
 =?us-ascii?Q?T5LwnvDS2DGx8BWYFLpl87+Nxvgr6ipgC3Lc51OFt0gXD0uUDBHE75dcr9Di?=
 =?us-ascii?Q?16qnqNXym7gxpAQxM++x9+1mpMlt+ohQ5TLNqIig9YLLyBe6hHc63nSGvCst?=
 =?us-ascii?Q?3iFuhS1ve4e26EjQer5K6NeunFZLGYvXqNRBZ8sBHgp7RNVXhe9Zxxx8GDNH?=
 =?us-ascii?Q?x+LiWCLmuLxM4Nd81GXEE5O2Y1JBQiki6tRSJPbLV/DJRtwwtsRPVhs+6q+3?=
 =?us-ascii?Q?52PqF3ZiqweYSrh1N2lZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5791d70-501f-4719-ef4a-08de163ef204
X-MS-Exchange-CrossTenant-AuthSource: ME2PR01MB3156.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:27:54.0504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEWPR01MB8833

From: Junrui Luo <moonafterrain@outlook.com>

The snd_wavefront_probe() function constructs the card->longname string
using unsafe sprintf() calls that can overflow the 80-byte buffer when
module parameters contain large values.

The vulnerability exists at wavefront.c where multiple sprintf()
operations append to card->longname without length checking.

Fix by replacing all sprintf() calls with scnprintf() and proper length
tracking to ensure writes never exceed sizeof(card->longname).

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 sound/isa/wavefront/wavefront.c | 40 ++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/sound/isa/wavefront/wavefront.c b/sound/isa/wavefront/wavefront.c
index 07c68568091d..74ea3a67620c 100644
--- a/sound/isa/wavefront/wavefront.c
+++ b/sound/isa/wavefront/wavefront.c
@@ -343,6 +343,7 @@ snd_wavefront_probe (struct snd_card *card, int dev)
 	struct snd_rawmidi *ics2115_external_rmidi = NULL;
 	struct snd_hwdep *fx_processor;
 	int hw_dev = 0, midi_dev = 0, err;
+	size_t len, rem;
 
 	/* --------- PCM --------------- */
 
@@ -492,26 +493,35 @@ snd_wavefront_probe (struct snd_card *card, int dev)
 	   length restrictions
 	*/
 
-	sprintf(card->longname, "%s PCM 0x%lx irq %d dma %d",
-		card->driver,
-		chip->port,
-		cs4232_pcm_irq[dev],
-		dma1[dev]);
+	len = scnprintf(card->longname, sizeof(card->longname),
+			"%s PCM 0x%lx irq %d dma %d",
+			card->driver,
+			chip->port,
+			cs4232_pcm_irq[dev],
+			dma1[dev]);
 
-	if (dma2[dev] >= 0 && dma2[dev] < 8)
-		sprintf(card->longname + strlen(card->longname), "&%d", dma2[dev]);
+	if (dma2[dev] >= 0 && dma2[dev] < 8 && len < sizeof(card->longname)) {
+		rem = sizeof(card->longname) - len;
+		len += scnprintf(card->longname + len, rem, "&%d", dma2[dev]);
+	}
 
 	if (cs4232_mpu_port[dev] > 0 && cs4232_mpu_port[dev] != SNDRV_AUTO_PORT) {
-		sprintf (card->longname + strlen (card->longname), 
-			 " MPU-401 0x%lx irq %d",
-			 cs4232_mpu_port[dev],
-			 cs4232_mpu_irq[dev]);
+		if (len < sizeof(card->longname)) {
+			rem = sizeof(card->longname) - len;
+			len += scnprintf(card->longname + len, rem,
+					 " MPU-401 0x%lx irq %d",
+					 cs4232_mpu_port[dev],
+					 cs4232_mpu_irq[dev]);
+		}
 	}
 
-	sprintf (card->longname + strlen (card->longname), 
-		 " SYNTH 0x%lx irq %d",
-		 ics2115_port[dev],
-		 ics2115_irq[dev]);
+	if (len < sizeof(card->longname)) {
+		rem = sizeof(card->longname) - len;
+		scnprintf(card->longname + len, rem,
+			  " SYNTH 0x%lx irq %d",
+			  ics2115_port[dev],
+			  ics2115_irq[dev]);
+	}
 
 	return snd_card_register(card);
 }	
-- 
2.51.1.dirty


