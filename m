Return-Path: <stable+bounces-192684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A05BC3E7FA
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 06:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 921C73450A2
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 05:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AF9261574;
	Fri,  7 Nov 2025 05:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BbeI/rUt"
X-Original-To: stable@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010078.outbound.protection.outlook.com [52.103.72.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB51482E8;
	Fri,  7 Nov 2025 05:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762492753; cv=fail; b=dqWcGNFyV+qK3B95r58QqL9aPIvZq98RNwN6w76Zi2i+cwAKIXn0J+IQ9jP3n+4LUFeYReQlXC5mbfAmkHemBtfKDzmk5ilYv7dZBwDwJ4xtzvqhYtVWGL1sHFiaktB1B7B5fRGihTb9BICY23bi8dTsQzurF3qYiu54xd1WagE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762492753; c=relaxed/simple;
	bh=ulKYf+SVRj36effopHVOZGLV6MyScsgIKsX/vf4TYEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jhk3f4ylwmhRLc39jRlCeGig7ArgGukwpHf0INiJQapsIggL2KzOk3gKM5o1lUjAL4KS4fWrZnrRq1A9qvZd1HPy/tSjLkIRALugdqEP1KIoZ6aBHC1o6QgjKuytnN7kMWFlQUmUauWYG0QwAYwVfyaC7OVz2Bzxt4wJAgd6Ogk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BbeI/rUt; arc=fail smtp.client-ip=52.103.72.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZpep7mdpN/iDZzTMpu9jqBYcpKO0zE3lF30F/IpVTdFsoRDHbZq4WrOiACKDfU32dwvF4DvLwrj/oQVLn74AzFMf/9MyuU/x92V2CFCz+6laBqFz37yXX96YVH9r1CmYULzUMc/eQcRMmrntiD563snO+OZqGdURaO7bNQeTCRULuIlGZ2Qd8mDZb3g++vCGOOpRHs3SdPflWSCOi9TJgezNMxCw2kIz1SGZj5NDyI0ryQxhs97Qj8I/ZqQ+t8NKUGtzgOFnNQWR9YejYksUBJ7o6JtJP9mKsRVhjYvu9AgQCqBznK3PHUYgdBl6Mo2rIXjQnp6HcAjVCcE39BAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBs2cNLro/YAUjr7dlht0PU317REn98BYRcpMoMpzg0=;
 b=xCTyfZ0KJk2Ln3OZFeO+xHWe0W8WCJlB87fr1osSYTMBuc/Sm8bfoMMfJuKVnswkxq3qx8uXqruNcWCT1iPAekZSXEl2gCCJWPCf/RNihe6cPbAyVIOexgK/gUNyHV7MzpNNHb+u81TW3VheF+R80ReWWzYYqVJSJ7oREPJNIzxNMtrDDA8s8uTv6b4DT3+c56YY4np6Hu75kF+2fXvqtqzwitQngIVWWxtC7+QsO1SzwSeWMUIDmfeJxtDfZWw/FgyK8W1f8GRiYjm7RU1uM4JLIhxaTwT7CnWizfMddTAKhcaSxOb3VaZCN+UQr5U5nBZNK78Ia6ZYDM0lvyVfYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBs2cNLro/YAUjr7dlht0PU317REn98BYRcpMoMpzg0=;
 b=BbeI/rUtWXDJ/wmy9QDIx62JbSAvTn769jN1kEomio8hgBDOdTCwoCg0J2Csg3FE9RZpzf2lZmcf4dZXtps/uYOnh6syBm7Sq/jl7gLw3KtGcr7bgEUljDIoW7TDxVg29ld1LkQLAgy/tjIUOw03vLi/Eh+jcYrF6j/34jgD07+tJyR6zd9hRCn57GMdWMYxCzyzyeTYSa9k+hsFm72EsgZLg9N66WItSc8120DyLm1aMgZkf956pftEWkbHuJAyAQyWdpqRdXZKDVYs3ALzddEYpR2h9HKfExvO8BRxiZ41m0Hu6y/PKApfZVcSRvS6FUmjWA+Pg+RFbyAU2lV8Ww==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by ME0PR01MB9633.ausprd01.prod.outlook.com (2603:10c6:220:248::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 05:19:01 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 05:19:00 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: linux-kernel@vger.kernel.org
Cc: pmladek@suse.com,
	rostedt@goodmis.org,
	andriy.shevchenko@linux.intel.com,
	akpm@linux-foundation.org,
	tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	mchehab@kernel.org,
	awalls@md.metrocast.net,
	linux-media@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	Junrui Luo <moonafterrain@outlook.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] ALSA: wavefront: use scnprintf_append for longname construction
Date: Fri,  7 Nov 2025 13:16:14 +0800
Message-ID:
 <SYBPR01MB7881DE52A74110DCBE520098AFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251107051616.21606-1-moonafterrain@outlook.com>
References: <20251107051616.21606-1-moonafterrain@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:510:23d::23) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20251107051616.21606-3-moonafterrain@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|ME0PR01MB9633:EE_
X-MS-Office365-Filtering-Correlation-Id: 627560ed-fefe-44f0-1716-08de1dbd28d9
X-MS-Exchange-SLBlob-MailProps:
	igNrEvV8uhGuzD8bAbgKGQnyFtPUXUTVuJ0EJ88r3XNjYGrR+cLPqf4vX+3Dr4VEWC9VVtk073rabE1ZvAV2wfJcqKnO7NLEVU0HIiWfI150EApjY2M3++UrJ1M8e6iW2abofz9ltbVohSKanCbKfKxJCsLAXpACC7HiMTdZIEGiUe9aZdDugL33lRJ3n/5+kLaHX5foTOyu5WeHCerIqI3g6r7DrV1nSjrrIc68sFfvniZQS+tL7ZCFAkt0DO4Dij6+3hweKzzJ4K5nlt+rdX5xO9UsFafO76cERKlPpaRZF3AnuKBVYX67fMbZn6rs4BwKKy1VaomB7vFItnsMc7Ck1khwwR9YjbhgmYVhpnvdgm/izWS2TovLYFfF2gocC30H/0Nw7w7OQwD9HIW2IgJi5oT/bIJfvPtkyMRXcaJRAYKHG99FI3VLGrCrXNqMSuBdUaEbCZYppY3agaNQ9exYEr4239hUQF7LNT+iCWN7o1saiQKQzhgXX/7KFB5HVp8gXdF0RXSMvH/VUFo+Hbsy1OQfuuShWqokl3wBZNGgk0w3JUNsq5LroBBCoVamRiYqRJwJx6QbQP18e1ql6R0XxqpXnlW3MJ5ap9lhK8kICPWYG1idJOLOnZP+JVAS1il99VbtOy68mvrlm//cMA5DoKgUk5VlJEs3PAyKvU07cNZvpr0uyJ9SDlO2UioUoQZ5Cd4GWek=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|5072599009|461199028|41001999006|8060799015|23021999003|15080799012|19110799012|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ByTVNUa396dSRodksjytQ9oTVJdbPrP0tgrMsI8JLZjxbkVeaSvPOU5VORPI?=
 =?us-ascii?Q?HzED5PWz/D4Gk6mS9LG1UZ+QbeBE9C8Zwg3f2DCUPN6GxL5ZJ6UhJ59e+6wM?=
 =?us-ascii?Q?Q0k2ii/ONsAf7TE7kc5dCMnk7eJnD7TPPLDg2w1djmUlp6s1Iq+LCmCV/1Ce?=
 =?us-ascii?Q?rRTzJJLTIqsut3P1S4Tkry+pZ2IDESfOScpEyrfEWUjQBhi0/aD+coVxzWz5?=
 =?us-ascii?Q?FlzYhWR7zT/MBXXZjIqLf/UxBPnQ6BOKLcTaA4c6kTp+gkeXfu/mSBf/jImd?=
 =?us-ascii?Q?DU55G04JUyJiGd0zePN7cv0HKVCjZE5weYeGgRyhujyAPfzDzflZWAy0m2nJ?=
 =?us-ascii?Q?qty0OhBUr8/bVauXB/ABh62xhBByN6x2KzOBqYndARwCQBYh2Vs7Tydi/BYQ?=
 =?us-ascii?Q?LmlPh/YGicAJmgBtLV0bfRvBnNOvFvnd9HrjL2sF6y0jPtwxiEvvBaH2XwFO?=
 =?us-ascii?Q?uvPTNLQxDcdOCLyzOQ8FtgIV5FzXOadHlu8m3u0YwMEMsDM0by/fvDUVTF4W?=
 =?us-ascii?Q?4VAgiBg3EDjqlqV5NiHO+R360mU+9YnkLB5P/EL8MUkAvbv5GvGH8TNMjbdg?=
 =?us-ascii?Q?m7M4fNWHXMVC31ob6mrOcCX5KOoWcoHzo9tfqWrsVy/8jIaj1EBPVyZA/qMF?=
 =?us-ascii?Q?f/Gm27hsIHMwgSHBU0yCeX87CdoriyHOgR2msRMV/ZB7KacKPo3zaUK75e8m?=
 =?us-ascii?Q?QsIywtyanfbAHmzTsewE6XQjSujR8wLy4yetKxPR3NIIq3+aKRc0udPKYntf?=
 =?us-ascii?Q?vEt9RiDsJ/KDNvoHzPvBvUcUrpDLdDUcVqseXphXjrRICN6Zw40kzx2UouIm?=
 =?us-ascii?Q?DWfGahW8TUqDmuMW7HwKXk5tT3VolYO2RuJ5NlEShvSA48r1ih2lvDQAG8o6?=
 =?us-ascii?Q?0+H5yD0T6Irk6UT8jTTxdnj/r5pB+fakvHm/n44kq2HgV39okdROsiHgmt2s?=
 =?us-ascii?Q?KO/VdWfRUyIFA/3Uu/5iNZkEnYuguCEJSTGDjFRjqkFEC/BCrJghHbPOOULc?=
 =?us-ascii?Q?SSLEoa/Kdsas7ZmO/ndIOfr6i25um4hAx4hBnox2vALy22nCYou2h8DmhyD7?=
 =?us-ascii?Q?Ak/FtDv4Axsv3/XatgjioHRKhMKupNpNuzFcv9WQMwvBAsnqelkkrWB2kQgV?=
 =?us-ascii?Q?LCTHlYTM2T/WtAoj4n9nOIDlD2ZjlRZI5VaTu6aDmrtB/BALt/EXI5h3JH0k?=
 =?us-ascii?Q?PSuPN/av3NGEQ9CAyHwE93jQx5NG0k8w1hPi7evpOIb3zPkig1sY9sARFCM?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2NQcOzz7E/A0Zie42NyZ/NcAvoaS35r882nwsY6lJIq0N7+u/Gg14Vo2pEkb?=
 =?us-ascii?Q?i7rdM5OWGiBNYSFRwuvFuDdqt+gEHvrYzo8SUha/wtfaO6OgnvvdElmPEwr0?=
 =?us-ascii?Q?fx1jo56O2je0483mi1PnhwOk0MmR2zJMM09X66AJJ+Am5SN9Uc2Gul+YkecU?=
 =?us-ascii?Q?hCGj8kwzhqxE5aZHKeXHDWmdFizvGiMrJHgzTSv115Gg4ihz172L5KgEPxG3?=
 =?us-ascii?Q?lndbBF5bMdY9lthW+MgmB8i2PSshlPZDxmTiJidaG7tIsks2i3EduN2LnLbZ?=
 =?us-ascii?Q?szrmqh8SOdOlb/CQ5/+4DRjvvwbFsv0varF5N+RGNwYHlda2ec72EQcl+pYY?=
 =?us-ascii?Q?AeescYer2OAPPxGOkW0xaQ2nQ66e2d7OygKy+FNRLbV+tOIrmG1G0VZARL4c?=
 =?us-ascii?Q?DnUeNGna7jV+4kMAkAfIkk7lSvoUTTc91ibEubXfSFIkyqSL61o5Gml4odnN?=
 =?us-ascii?Q?h7tsXEt/6pjKz+3HLuBLTCtkQNp2uRGWHk4pVdAPdTfVhAnDwOHs6vI7ePBQ?=
 =?us-ascii?Q?6ZcEtnMOS/xljNQiv7Yj5PB0zMiT0HynGjFlnriPh/6rERL3TNZkPelh4ClZ?=
 =?us-ascii?Q?1tWNIUfIdfQYXpauC8iarSKGSgIQdI0EiceAHPho29Bz8hiLnrB8h7vA7Z2s?=
 =?us-ascii?Q?ce8OwVrrYQc5rE9J3qSJGd32i7K4OOX4RLCcyQwhle9/Dqs5aC1NFEmYBI8i?=
 =?us-ascii?Q?UAMxaONeEAqiBzf2VV1vH0KHRuDjHMTGkiW2jY9+fMkNhPYxugUxXEmzUy0w?=
 =?us-ascii?Q?Ar4wA7CdmpiPf/wsbiCMo9ficsEkCZ5TF89Q01azBQ3XR7xERCI09DB6vbm0?=
 =?us-ascii?Q?7qzrGkqhemGn+34Al1LarVcM63jw8dxyWFAI8OriMb8wJcFLxqH78Ip5fE+M?=
 =?us-ascii?Q?koDw1hJrCvHORNew7nJg+YjoPi5GlrQ3HEAGjTv0/z5WQqwCuCoaaEzrftyf?=
 =?us-ascii?Q?gWU96arMlU85Xmxs/JSDF252v/w1mHxYXVzMteps9PqcQjMPvR4nVFcHbeKc?=
 =?us-ascii?Q?tcMEB1bKe7T8NAxtIBqZnCK4OigrK5802lMvC2z8B68lSnELDp2XP6QVkCV2?=
 =?us-ascii?Q?JOeBejViqdLKEu8eOxqnvhyNXyplNHXagnL91t6SW9DOlWHMFKmNtwDISibc?=
 =?us-ascii?Q?zXBO9A+6bPtFUQSBicaPP5OJQhY6gTMsvuF8tLGpw7/v0DeLzel+Ir2ZnjJN?=
 =?us-ascii?Q?M8/QV3BJ6Nbyycp52FabwqVGyRA5uWPH2gKF2RLVnZo77C7i7BM7aZmxOImn?=
 =?us-ascii?Q?ezEnSdbSZ3bAJhmtbzVX?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627560ed-fefe-44f0-1716-08de1dbd28d9
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 05:19:00.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0PR01MB9633

Replace sprintf() calls with scnprintf() and the new scnprintf_append()
helper function when constructing card->longname. This improves code
readability and provides bounds checking.

Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 sound/isa/wavefront/wavefront.c | 37 +++++++++++++++++----------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/sound/isa/wavefront/wavefront.c b/sound/isa/wavefront/wavefront.c
index 07c68568091d..eec4be5c3217 100644
--- a/sound/isa/wavefront/wavefront.c
+++ b/sound/isa/wavefront/wavefront.c
@@ -492,26 +492,27 @@ snd_wavefront_probe (struct snd_card *card, int dev)
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


