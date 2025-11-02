Return-Path: <stable+bounces-192068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E020FC2911A
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 16:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861B53A79FC
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 15:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C631C8606;
	Sun,  2 Nov 2025 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fXgSxAw7"
X-Original-To: stable@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010008.outbound.protection.outlook.com [52.103.73.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500BE33EC;
	Sun,  2 Nov 2025 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762097602; cv=fail; b=o5wDUuOYgg3Hkil/pyGqC5LXxkYFTQCoPfZs4YTFWzZPzSovNkT8Uatc7YZykyGzahgsjypEulwoZfTm4ITj+XclDYJdNKIUTsiRTfQ961yr0eFc5/qoWgMEh3YB0WR3MLRhycd049SpQt6sHP+EqUAdP1rp9QMgphfqrFYvOn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762097602; c=relaxed/simple;
	bh=qSyxyO1QwC3ALPYcSHrwe8xmDF7shVzCg3klIfp05as=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=K6PCW/PUveJnLJyIOyVUirdY6Cv/uj7elg+2L3tymoWEOUh8aOG1EWR2ZtiCdkne2ybmMQg0IGDBYs5Ht8xNI2oW8oMVaXY1mEMgd1/GdnPYWaxARJautDcmN7LWp683PqGKx4K+2KJ5W23G/D4cmxBxQSYw76dky2MZvwg9Ek0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fXgSxAw7; arc=fail smtp.client-ip=52.103.73.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ii3jFeyJAAPPEYvE7AsWocQjPtiYeyo6enJgydLN0GnFtuomCLBpKTtSUYUTbVMM6KZ8nNqvgtvHuK3ZgQtyrYOqjArcfxTbRQ5OVIAqN2DjLOYIlab3ry6hn5d8yNN6MRlr8VZWmwNY4F6qxA7EzT8CvrlmNYWkdiTLzaglay2NDoZ0CuyG6OKBuPpYDYwDScTzjzMAAPCtT4A19gDejrw9Dg2+qO/9OJptVfCJrLM4F+OZJ74J0QUMjF0zp4vjJDgFr8HtuDmhcNTPwCbPkAFAPjpWqlIxg86udcoZeot3B+1Mvl5Xvox2ZVuQwYh346sEN9NmvHcVWUk5zxpIUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xtl31g5xmC8E8REFN7hEc+AlTk0V5PThLhIiMbSAWT0=;
 b=jsVeCeaASFWXqiwrFjxn0opQopw/cR2ugy6uVYE+T0JaEOBIBhYzXEi+Cczb4Sx8fM7nUBMo+ZN4yqRLwrL7xnJ90TG7gzfEKHh1CNB/t/MyJmYEf5uzhTx7XMASAPAx03YZRTZYLPPiWid/FM6IsMH9uAmk4TTyaEaqpXMfDCbvew6jH103D+mTtex6VEjKeLzklmQ1JqU77UeHFCVB/ULeuzgDMWX+1Urk2UTQmojNivNITp9J4Re4aGMvSU+qoFE5gcDM+CE3Yue9sE4sXRLA6uRclKZvORX5PjOo0nYaVHHDdCMtdeC8a2MYViJmIH8jnLRKKeuPtnlLkp3unw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xtl31g5xmC8E8REFN7hEc+AlTk0V5PThLhIiMbSAWT0=;
 b=fXgSxAw7VKx1U/A9c8j5jsMbSEppRnMMvBv9esf+folBHmbC/KqIqYlvSBChuno8xXCJ7LJ0fwyD88gOwzV20IpGd1VwmiVByxTNk4JNSLxK7ObBwBTpa85GcmG8z0b6GuknL08Eid6PnUu6Vp/C8jwI/uf9qIxyaMtjUfZOaGrlT/XpVW4B77zlpLWmzjrEs0Vczy/I2tXX8wteD9lPzdHnuJT9V4PN3QbqsECYJoA27tGLIj4X8jkmyCHBf7Gv9ZnZN8lAeNSuN425Nh87x+0zB8UucYh83BC7NXhL+AHv1qbpjwDUFD+2lY4XqK8iD3b/LPPj2QbEPbWu4rPb7A==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SYBPR01MB8585.ausprd01.prod.outlook.com (2603:10c6:10:1a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Sun, 2 Nov
 2025 15:33:15 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.20.9275.015; Sun, 2 Nov 2025
 15:33:15 +0000
From: moonafterrain@outlook.com
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>
Subject: [PATCH v2] ALSA: wavefront: use scnprintf for longname construction
Date: Sun,  2 Nov 2025 23:32:39 +0800
Message-ID:
 <SYBPR01MB7881987D79C62D8122B655FEAFC6A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.1.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:510:23d::28) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20251102153239.8034-1-moonafterrain@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SYBPR01MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a0e94d-88a9-443b-d4a9-08de1a251f6e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|5062599005|8022599003|8060799015|15080799012|23021999003|19110799012|41001999006|4302099013|3412199025|440099028|10035399007|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yCVPe75vcfdk1YmVLQxbWw7dusOHbgU2t6ZFMGAcvdf90rmWd4YEFoT/nOg2?=
 =?us-ascii?Q?6DKXltkSGbtnRc3yk/s5mzcntHeL6rqI/n1RSsT3uPJpQ3U7a4IgHSnTww7B?=
 =?us-ascii?Q?00wkWvuiJfm2uPOzlhny1X100cuThiHvDkBENTp1BQZ0zT0CZA/1WY9LbWRx?=
 =?us-ascii?Q?JldEHgkw5+V9k83Gw3YGTaISOFzkjycphvveEe9SeRg+Kb3lVn3r0R6tQlA+?=
 =?us-ascii?Q?3mJa0Fel9csBDnJvUjFj9iHc6qboS7rSRW+vGHpMVSYlyE/k8lhMgcd3E4q0?=
 =?us-ascii?Q?nJLcxjgGSQ79AWaIk/sUa5AkKf6hW0ZT4BusgKE3emGqrKafSCQACi+Kmj4h?=
 =?us-ascii?Q?eDKu/ioA95P1GQf1CDEo9Q+ViZqkhn9mdcY7ls47E+WQ53KAsmdveANu470n?=
 =?us-ascii?Q?yBle/DdLylg/CLul5bnU7xh+StSrIYtIwBi7F+olUehgSHOVebx7o2TDUHDS?=
 =?us-ascii?Q?ACeHILhTVN3xkAFFvOcroP3sPbft4CItcvimHIB7zJXoH3jjfmQiysDT/1I8?=
 =?us-ascii?Q?o8u1OvcvyuGMO0ezaeTAuHJ/SbfJusTeeMyHQJyg8H9v24YHpROG0xyOz2jl?=
 =?us-ascii?Q?vVvT3gdcHBcKtCu5bYJPy2L4ew/453j3hjrHmuFSQ5i68jvyfcqbTh3R+g1R?=
 =?us-ascii?Q?CvJkD75z82d0/UupAn5jmBx74Kad/FeaZQqzqAQ0bA8YoiCYMdbgfdH+EPoa?=
 =?us-ascii?Q?n3StsYfpK0uTyuT8ShWSyJh4L7EM9AXZEr838rwEAi3V2b7Lnok/ZR0MB9LW?=
 =?us-ascii?Q?X0Oj4mU/xoztkY9MxiddEFTPBsmN0UrZfc0uKRpJSdnyoO+jaYpKuueYdR3F?=
 =?us-ascii?Q?T+k5Tvy/60aPqbIx8TFE5sM+AL2Y7B/YdNS+PkQJqjgFyhktxydyCof8ZRdk?=
 =?us-ascii?Q?n4EfvZWctbAOOefzh+6u5DvWlKtvfzImw8Y1LZxZnzg2jSN/Ec5G35wEr2e+?=
 =?us-ascii?Q?zuz4vwajCm9y8PGmHA312YHGzaZhC5G8X0zH2/RLbbaC3sJ41XsWZsJsLnt4?=
 =?us-ascii?Q?IoN36l45vUXip86aFtyPWTUTBa+pDCuBBntV/uOSHlSdmr8bS9CdKEtwn2th?=
 =?us-ascii?Q?5mpu9GLjwi018s3l6WFUk96GQ3FUFigduwFVwt6hvI/VgibX6n6R6ssFus7D?=
 =?us-ascii?Q?wvcIJUEBTu6prnePpFb40Hd3qsDk6OFUmZTtbgWza5qI35GEUjgEBNBw1lwI?=
 =?us-ascii?Q?0DwknDL2Hdgu/iVsrid+JWGfEkc3h2mpsTZF91v41givmfRIJ1ImdUH5ISzx?=
 =?us-ascii?Q?L36x5r9iG4Ll2bSqAaqLRa4Vqva81Hoo9g0xCEHKQtRHFf1+abTfbz2XqnMG?=
 =?us-ascii?Q?BQUewa7chNkwTjFjPFx3cGgS4c7vdp/tu0gKHTVaGS6x2GLA3PQtAGXzc3bJ?=
 =?us-ascii?Q?tAmbWAw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p5/PEUEooTGH0RYmkSNBbB4lC/XP4f209nx2rU9poVH6PMDRJgTypSlz++hz?=
 =?us-ascii?Q?lD86b1lsiEh8EevCSL9aytSu3MGWsovHW+Pmjb1lpW9VP8uA0LGobLson2Y7?=
 =?us-ascii?Q?9w9BVkSYeonNCE4Xx6sxXseXw49dOtvXwphhgjTp+m5E/eEMGcxzh1csfqCb?=
 =?us-ascii?Q?bUvr9F1VEddFKilE8fpG6S5p5KdX2krgBnOsntLaBqUL6zYHjEL6ccxgAsPX?=
 =?us-ascii?Q?MFs4JyAd9uQvQC0qsZDJBaYJg9+40A7Gh+6S/rFdRApYI6y52ES5Bky5MI4Q?=
 =?us-ascii?Q?vp+fuUdDzfS7fNZOPBHi0qsXJSiAo1AFKQ3bFAkDqgeqObl7iHYKvdg7VsEW?=
 =?us-ascii?Q?N4XtytqlicAuwiov7yJtlVKYEMJuQfq0PHO+GLDVFdtaUFii13hgbF+W9Ba1?=
 =?us-ascii?Q?L/WSKwUjJEcaierK6cwrPbOfNpJ0F7OEsGAUyZPICeiS/p/kiiSXvkOO+qus?=
 =?us-ascii?Q?5nhrKA8KUL5ntE/PKDJ29wQqQ+mgPV+eq766/kdzISnuXHcLOq0xMFJMS0vW?=
 =?us-ascii?Q?JLnmLi4VRMTRsq737RvWX58xF4gJMqIeVwEHO5MmdKgqX/Tdc1bwvqWtdBLn?=
 =?us-ascii?Q?iFTdo8iDR0wPYYnSixI7w0A+x+QfuQVEm/lITmX6LfIwCi9ffb/ImpryJfaS?=
 =?us-ascii?Q?0seAkmT1jo87o2SGlsBXnVVVqPQLXulnTFeEVHh3kre4prHD4Jf5H7ZFRgi3?=
 =?us-ascii?Q?74HcmeYr8qm78/5jeMuwt8/OtG8dBBWikJNSIo4omXYG6TqmWSljKYOTruK4?=
 =?us-ascii?Q?HeutIxofeo9xZ6sqZNRrjMeeXxzCpm9z5uBzGWhtn4iFJQD6ODEDXHZFY6Ub?=
 =?us-ascii?Q?YM0TQGZ7j4UezpnckZ4AJ7BxMzQ1PYVZdX0RVGoV145brDmJMNDmoZ+mAfzW?=
 =?us-ascii?Q?Cg6HbtouWRXHcubYlBySxvmWgHpocAumWDrR64JBveWluVddDxv5zLzJbold?=
 =?us-ascii?Q?gMd2ZlTsYZJKtqid1++bjcC1BQsOtRNFkKU+4h2ESQO9cg+2HB9yl+1YjSKR?=
 =?us-ascii?Q?/BBvxwNG+TliBx+jqY3OkUGavpNTTdSvvnTxyI8cy5epQnw9iXatrYJiZ7JR?=
 =?us-ascii?Q?LI3panJfIZIqP3iV+zZpJxtfYDtPF4YkiIL9spGBVBrhe6LrFTa/GTFnkFvg?=
 =?us-ascii?Q?BgJTZo0Mao1qrXbcrcJRauHxw79lKwy2OSQVJchAwwmjN0MEElTXWaR/Y2ri?=
 =?us-ascii?Q?aF2SbO/9TLregge3KdILyUb1uwuwoXWZcgZ2LQ34Am3mzZ0gyKY5eHhaKbZC?=
 =?us-ascii?Q?p8AP6rq8dYqNpPaC9e5A?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a0e94d-88a9-443b-d4a9-08de1a251f6e
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 15:33:10.4433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB8585

From: Junrui Luo <moonafterrain@outlook.com>

Replace sprintf() calls with scnprintf() and a new scnprintf_append()
helper function when constructing card->longname. This improves code
readability and provides bounds checking for the 80-byte buffer.

While the current parameter ranges don't cause overflow in practice,
using safer string functions follows kernel best practices and makes
the code more maintainable.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Changes in v2:
- Replace sprintf() calls with scnprintf() and a new scnprintf_append()
- Link to v1: https://lore.kernel.org/all/ME2PR01MB3156CEC4F31F253C9B540FB7AFFDA@ME2PR01MB3156.ausprd01.prod.outlook.com/
---
 sound/isa/wavefront/wavefront.c | 50 +++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/sound/isa/wavefront/wavefront.c b/sound/isa/wavefront/wavefront.c
index 07c68568091d..047dd54f77d4 100644
--- a/sound/isa/wavefront/wavefront.c
+++ b/sound/isa/wavefront/wavefront.c
@@ -333,6 +333,19 @@ static int snd_wavefront_card_new(struct device *pdev, int dev,
 	return 0;
 }
 
+__printf(3, 4) static int scnprintf_append(char *buf, size_t size, const char *fmt, ...)
+{
+	va_list args;
+	size_t len = strlen(buf);
+
+	if (len >= size)
+		return len;
+	va_start(args, fmt);
+	len = vscnprintf(buf + len, size - len, fmt, args);
+	va_end(args);
+	return len;
+}
+
 static int
 snd_wavefront_probe (struct snd_card *card, int dev)
 {
@@ -492,26 +505,27 @@ snd_wavefront_probe (struct snd_card *card, int dev)
 	   length restrictions
 	*/
 
-	sprintf(card->longname, "%s PCM 0x%lx irq %d dma %d",
-		card->driver,
-		chip->port,
-		cs4232_pcm_irq[dev],
-		dma1[dev]);
+	scnprintf(card->longname, sizeof(card->longname),
+		  "%s PCM 0x%lx irq %d dma %d",
+		  card->driver,
+		  chip->port,
+		  cs4232_pcm_irq[dev],
+		  dma1[dev]);
 
 	if (dma2[dev] >= 0 && dma2[dev] < 8)
-		sprintf(card->longname + strlen(card->longname), "&%d", dma2[dev]);
-
-	if (cs4232_mpu_port[dev] > 0 && cs4232_mpu_port[dev] != SNDRV_AUTO_PORT) {
-		sprintf (card->longname + strlen (card->longname), 
-			 " MPU-401 0x%lx irq %d",
-			 cs4232_mpu_port[dev],
-			 cs4232_mpu_irq[dev]);
-	}
-
-	sprintf (card->longname + strlen (card->longname), 
-		 " SYNTH 0x%lx irq %d",
-		 ics2115_port[dev],
-		 ics2115_irq[dev]);
+		scnprintf_append(card->longname, sizeof(card->longname),
+				 "&%d", dma2[dev]);
+
+	if (cs4232_mpu_port[dev] > 0 && cs4232_mpu_port[dev] != SNDRV_AUTO_PORT)
+		scnprintf_append(card->longname, sizeof(card->longname),
+				 " MPU-401 0x%lx irq %d",
+				 cs4232_mpu_port[dev],
+				 cs4232_mpu_irq[dev]);
+
+	scnprintf_append(card->longname, sizeof(card->longname),
+			 " SYNTH 0x%lx irq %d",
+			 ics2115_port[dev],
+			 ics2115_irq[dev]);
 
 	return snd_card_register(card);
 }	
-- 
2.51.1.dirty


