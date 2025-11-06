Return-Path: <stable+bounces-192568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21511C38EB0
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 03:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA963B0AB2
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 02:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8655C21146C;
	Thu,  6 Nov 2025 02:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="thk6Jhmi"
X-Original-To: stable@vger.kernel.org
Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011025.outbound.protection.outlook.com [52.103.72.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B5018EB0;
	Thu,  6 Nov 2025 02:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762397470; cv=fail; b=A9+4d/BCMZNNa+Ks5mW00wPDv8Pze66WLRe8bGucUCNCmfjxY6EP8LFA9AXKfkp+YKERybesZQNUeXuFGWwYXpia0nqK7gZ6ehSMiM/ZEvtL7BBiFm4de9BY9o07dPY9y4E7sCH2YCxuxv5WeTb4rCMJ40fz4h9qULIT8CUdaTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762397470; c=relaxed/simple;
	bh=LK/7ls6zseqgpz3bjX2Xy1E8tnxUuDRvgFtW3ZxE8hw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=N6STfmJvp6rB+LuRZ3RuG4zLAmwiGZ6F5lvPrJRpNM+IRXYBH642pVWdL7kPELVnCyyOKiWqQmS+g55yg/SyqoNci5YC7lHsPe4gt9FJIhDaiwe1/AvlEt5Txr2AJBt+vQZDEKZ8IqTJ3DwvBmeT2OMfK7NWeeBpx1ssOP8xDN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=thk6Jhmi; arc=fail smtp.client-ip=52.103.72.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXB5hxjjieBnH0Tx6XwHVRtOq9t2xA0kiZqSLPKuijPnlpVaO+MQWcoLV9keRzNuEUq85HMLm8IwKwFgkViA+mwTrs2g9/fRwX6RaEavIWpsNvU2T2t+aCdPt4W+DjwZNgu3RwudrRd2qHAgBjotIuokRl6f4gFR0aEWu7oaKdZC+dnJ6UhLzmlB1+EoAigK8dCyn0LioIzPpJfMAcFkULR4645pYfg1UczbPi1St4nX7PPCLVkTmA/WPCuqdLQIQJccX9ftGfDxiOOvjXupEOfDQaBzDJGF8Xnt4mpBMktuevh1lpKLPIegS0UDCn0lLEGvUmKgIRqXCINJpIkwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foS4ilJBGVnuLDvnfR4eHS3cekX4hoFhunMlzcga308=;
 b=ZqcS07ZZSq8jQs2ty05TkHV58jOv77tEmancbpOEPblJmtepHIOv0rYJg9Snbgz93tmURmOxkslYHlAaoItlsMX0bcAD+Q7vA4Aat4xAyep7vI/nCXoxLAgRR1DUPRalApRrolChbBs1isiIQLUqn+55N+H+KmxkfQE9zUv6f2fULJluBdjCzYC/SdlmclLOjH8jAv8tpRTGWu9JxHvD0EbHnwEtkjW+88ZZPw98nPfWSz5l0wJln6XCfkFmQYltf5CzjPX5tQyExF4xhlO6qN/uE89nfnqhLYeYy7FVViT+UJZu115zCTYZHDGEhp2lW/0MbGHevPvuaQU4V9lT+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foS4ilJBGVnuLDvnfR4eHS3cekX4hoFhunMlzcga308=;
 b=thk6Jhmirzr1Dx2QFhPpS3ZTGAKZVC9CrjZXX3X5EzqVYWqnPoUNt37LzKdZ3zMD+KXavNKp3W1osfrOnQcN/L9BoONh7+5iLPRI7XP5taUKlaWRsED4+sB7/66lisgYTdvIRV6GgRwne7QCA3WxoQ4FHbgx5HtNMohiOlagd9XCLXUuMjgs2btz3hSgG4q2p+RG+0jUf69C/+sHNP/ioxtaqgQ4XTiWIOMy42S8spAN5Q8RF9g30VA+WhD2wk5ctmK1+sceis5lCOBxW6sScWyITY/alkn12fz5wowEbNL3k8OSabTeMKcJ5o1NMVrV23t++2qoQuzQdN61nrOkwg==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY6PR01MB7492.ausprd01.prod.outlook.com (2603:10c6:10:173::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 02:51:03 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 02:51:03 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>
Subject: [PATCH v2] ALSA: wavefront: Fix integer overflow in sample size validation
Date: Thu,  6 Nov 2025 10:49:46 +0800
Message-ID:
 <SYBPR01MB7881B47789D1B060CE8BF4C3AFC2A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.1.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::21) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20251106024946.11478-1-moonafterrain@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY6PR01MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 78dd4727-f00a-4e4d-2b51-08de1cdf5343
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5062599005|5072599009|41001999006|8060799015|15080799012|12121999013|23021999003|19110799012|3412199025|4302099013|440099028|10035399007|40105399003|3430499032|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?avl662zeOL4Fspd8gnCuzOVZ8kH0pHrDMEPtXQ4sp5fE3DgJmRtTB448KGgs?=
 =?us-ascii?Q?1fzKv2tp+qEylLDeiNe93i8+Shi9hOd58ZHuZJFzrr83l1Hd5TYmyO7lTw8m?=
 =?us-ascii?Q?vP2Oi4uZzW/Tw5zRhRzFy5jzvOvHYj3Q2mmmejDc6fXuK+aNc4noh4nc9xHw?=
 =?us-ascii?Q?PGKe8e4pVVCb8mslauT5rPBBN/ZuHWGCQPdioQRVhGRgmITJNwTTW0+M3xlZ?=
 =?us-ascii?Q?O1lm4Lz0S6JpzAzXEtE1skQJEXDM+nobjf/npJSQI0iaIfPs+/F8VOd27TCy?=
 =?us-ascii?Q?VSF/K7banK152edqJylgPtiAe6A68YPkvrHWplEzUPoNuPqehvXIqiWotVn9?=
 =?us-ascii?Q?UPasU80bjuAMwPUb+dJh2bhHc9fh4cL87V/BC2nrXcuajBx3j+U+JqpqoOcB?=
 =?us-ascii?Q?dSsGVMvtYs6dcb+8fzJkGLmNaWWtkVbNWz3lZlmpizidfaUXZ0hzG30l7im0?=
 =?us-ascii?Q?746O9vZyM3yQf3Q86FK1rGEE93ki6e5adpBRrtzeEqAZNXK75a2GoCdbXp+k?=
 =?us-ascii?Q?5qT8pP9ojuF3wABs1gn9ocFTrLdrF+F3Q9xs77ap9aKSU11MqnxP/XctXsTm?=
 =?us-ascii?Q?/zbjZb/9tZVsFGKDvufDNzA1tvgEa1rVbaDe99lNmapnv1blG6c4DfH8NH+f?=
 =?us-ascii?Q?iDuGquav8/7bCkUSGoHPEHMZXutH4Db0J4p+iyOVf2HKlKlCtc3d2ME4AUjL?=
 =?us-ascii?Q?XpAH1OjiGfMNIkwRNg1JEKW4hqD2gvwAqQvOBBj+knyaxx75gkQqvGWaQccX?=
 =?us-ascii?Q?8VoKevnaEcrGbVZyG9do5VziOdOBMhGQ6uJxhiTENGB5GRk2vas/VTtqOk/f?=
 =?us-ascii?Q?L1XD9ttM2aWbMSuPFy9Hvm7S8ysV/ddeyTqreW8vt0N1H5Vj04pGU/UPIMZQ?=
 =?us-ascii?Q?sUUabiT7WU+Xp8jsMCszLVMXqzC3vPD4Fzk0pQgQVbMuvxT/QrbLae1JvJ+7?=
 =?us-ascii?Q?Yyvy8MQoMix2PwX87NXGcJDFGOM+ho37t7QbYgrRYnf3gXKYLAWaWexKu5Nt?=
 =?us-ascii?Q?e6Pu7QwhgHEVgTqP67ioZvqJSyef/rbkfUakPaBXnn1eFWvowNt3TwChp7FV?=
 =?us-ascii?Q?dU3wfXvT7XKnOjhOJmiEXEJ1lOmdVlDWI9BPKEGbOUGJjjWlv9Oz21/H95DN?=
 =?us-ascii?Q?k9cMMdQvFiPtHP2CsvDQFGFiWpeTQadADduvP8chhVReyxWO3An+Ijav/sDc?=
 =?us-ascii?Q?W3W8CGW8+rlBSq5mZ2XwBn62QZcxxek//Y9QukXLzc4XKTdoApK32N5kMx9F?=
 =?us-ascii?Q?Wl3yRZy6aqRGvyD3AZq/ae4BUo6ursqZETsQCl2Qk6q9ATm6loeKIPpAqfju?=
 =?us-ascii?Q?FDm/jWFYQZBfHzVmrOa8syv7sXrnjSX69hXGjEB/ft1oL/xrr5usDFjkL6jO?=
 =?us-ascii?Q?AytqKwjnYDFEJIJeHfi0W6lgTk7JGdwSR0MkboqldWOl7wbHlQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jk4/+F3qgR/CAAn2ML2FYdtlmXuhL+LD46Y860dTfPc1VwPFgXTR+bxuTkHa?=
 =?us-ascii?Q?6cODDkRzLtkqX2b1ziK1a3JFWhJCaZ0gU7xSuqOiAuFouUg9kkK0A6BZYLSy?=
 =?us-ascii?Q?g+XCLRsn7WAlKlsKW8lrERp/4pmZeGT6ErZuWeLPbkVXt/6G2+ce4XAEsuaK?=
 =?us-ascii?Q?pGwYVWOjZtCosDFWyoc3g9Sm1QcVZmkgXroFXF6sPYp1PQCTlSBpxz7oqBiz?=
 =?us-ascii?Q?/1qfNkFYeB8ZNmlps+YT13StPefGnUYZb2Be3HWmrpBq6kqU3n0r9S5yIMx/?=
 =?us-ascii?Q?CyJWVDzMSuyCUhjChH1S4dUPlv06S09up7dGu3pDz5m6/AXboPwDSiH/d5D/?=
 =?us-ascii?Q?9FdodqY6Lt38h7/sv8imFey+A2BsAJcIb00l/1xUyl9sSIchpshvqZDZH9N+?=
 =?us-ascii?Q?cqvK/esG6kR9+cM4kZw2/fe9S/44BKawvGCdCsxrqwpBP4aA416RjdwsFm4H?=
 =?us-ascii?Q?g3Yrkn1PAItdVts5j8rD83IsaLQyJg94TLEyAo3V9IGyxjR9e8HPOBIpgzlJ?=
 =?us-ascii?Q?FTG/LPO0E67Szt/i2yjbcKD6UHh4rdcEQssVxhZH64Xj4YbGI1lHeIgEGkrI?=
 =?us-ascii?Q?2P61ALtGsfrFb7hzqIRhZOg6tHYZX+Gu0rmcgIfgsgmyZD3CfaB35HpQa858?=
 =?us-ascii?Q?4sKLKy60ihle3TRj/nyfhOAjW2HgTdoie3HG5ysldIuHWiaymckMC7EGCRhq?=
 =?us-ascii?Q?8Htk+memX9bcExxOASqMpLqcCdXzX+ep+ZmegUKZy/sZaBjE9/0ZcI6INnJK?=
 =?us-ascii?Q?1VLTp00+mL54LoaZ9kblOR0bJUsMhpsVt9rVu8Eknnso88bC0tcZpKJVlYWV?=
 =?us-ascii?Q?eId6Kw1G33bnXSfPI+kfjCD3gT44yqvE2HqzZsJcyTjcWqCPrlYXY+txFanY?=
 =?us-ascii?Q?RFBCzBM/G6wb66QULMe7OEwYWbvUoHaKs0WW2owCIY8vf13ARsmZhDTRtngy?=
 =?us-ascii?Q?oCqd54YtpL/3WLR351NwW4lUJk0+OfimhVa0OUsmsC45NKskdepZeEhWB4Y+?=
 =?us-ascii?Q?jS6memShxaNdAetWMCQuXQgfa3aY9fXWzIZvZXbRYI6fcQx6ryiM6fsxxYs2?=
 =?us-ascii?Q?sol5MQ52sAtdtD8+wfV2+cxpWKsZ5mnRYNRRAZYI+rqumCpfY0iaGBmxtyIz?=
 =?us-ascii?Q?Vzux2EXERDQxXDs6FMt3ephDltRxXXd9Uz7+pjN+tAd1S5+ozNqWx3ooClFS?=
 =?us-ascii?Q?MHu00azJp22kSwk70Y6ldn3sIJHwguQGwpafyx+8XEzRH8nHr3bfda9b4r4I?=
 =?us-ascii?Q?j2yxYRcIt79VJz/IRDMq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78dd4727-f00a-4e4d-2b51-08de1cdf5343
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 02:51:03.8712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6PR01MB7492

The wavefront_send_sample() function has an integer overflow issue
when validating sample size. The header->size field is u32 but gets
cast to int for comparison with dev->freemem

Fix by using unsigned comparison to avoid integer overflow.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Changes in v2:
- Check for negative freemem before size comparison
- Link to v1: https://lore.kernel.org/all/SYBPR01MB7881FA5CEECF0CCEABDD6CC4AFC4A@SYBPR01MB7881.ausprd01.prod.outlook.com/
---
 sound/isa/wavefront/wavefront_synth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index cd5c177943aa..0d78533e1cfd 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -950,9 +950,9 @@ wavefront_send_sample (snd_wavefront_t *dev,
 	if (header->size) {
 		dev->freemem = wavefront_freemem (dev);
 
-		if (dev->freemem < (int)header->size) {
+		if (dev->freemem < 0 || dev->freemem < header->size) {
 			dev_err(dev->card->dev,
-				"insufficient memory to load %d byte sample.\n",
+				"insufficient memory to load %u byte sample.\n",
 				header->size);
 			return -ENOMEM;
 		}
-- 
2.51.1.dirty


