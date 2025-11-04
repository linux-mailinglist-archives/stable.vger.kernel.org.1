Return-Path: <stable+bounces-192400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C758C31752
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 15:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B524647A6
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 14:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE09632C938;
	Tue,  4 Nov 2025 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="U4JlUqOE"
X-Original-To: stable@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012010.outbound.protection.outlook.com [52.103.72.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843BF32C33E;
	Tue,  4 Nov 2025 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265474; cv=fail; b=flcewF4zWQJ7jI4iXIvnRSKaNIbKAC8UQSXL/0R4uujYvbCemdF4Q2xKUcGPhqD+L9WuYCZN00BfVDB91M9hbdmuzmgzcUNSk2jnFLum5nwVUsIvwvgI9EpJO+zeLcZTP1dxWrph4axvbsFPGFKoznwdstvxTCPvjRebXLLBcwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265474; c=relaxed/simple;
	bh=6n0HPL4YuiKxTXpe9Qs93YMbAs9dF4qFyDyO2/lRLTM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=b8UXtUqjdvFAUhB5ZOj6nFNCCX9VvTT3E5mHr46wFDOq4+j3BRwzXxSeiT5yaOnlL3VS0OVpHr59kp/p1lgkGAqRS0Vm/wim0n+MpNUTopIqdbw2izZ7guW9AijSQPlwmwA093U9BfCLlz3OTkevwxlQ4Tu7iUDce4OYTSthe/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=U4JlUqOE; arc=fail smtp.client-ip=52.103.72.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZrrW5FpKDKl+xQHO1wyVzkP7c0eWDLzahFyfJjUICxMI18BjfMoZ+rXw2LVQnAQAWdLrj9VM/OmF4vZ7MGxX1VsoxJt9x3x0HiTPw3koXW54qfaQFwU2B+lXCSs+H4m2V2bB+oBroEpkwglKBqB2pp5OOiC5YpCW8ZpN3udDmqE6Jp1gMZF7kpd1cDXb0iYOrp2i9micRTKoeEjR8K4oLIDRlrpe0jjpPtAIEfU+3SVixw2uFecIykj4MU32KB1vjhrBeQ/69LioJfgbuVYGgYAcl1Fo3wpVWlNqI1Moo1gHqP2Hvl4IWYnScTd29KZLmyn7vKFbDVQE0Mne1AYjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHwjFmobxv7I14vXBaSRU1kHcQ6XVKIM6YoF+gMK7nQ=;
 b=YwE6xh3ZKftgRSi7U5TiJ0wgx2PGb7mGdEtFPbq+fmXuCnyVBAHYapwSdHsbXKzlIsmyUj+2P0JlkiuNS74Y/9zEIWX2Ke1saA6x9E6Hy6zFx3GeEG6K5VrcEbsNclnMBT9MLUed7GgnUOWRHk2pk4mddAE7hngKVNWJwniLLp5MWSXj03YWUtFn5Utqw8eXRnukHnkO69KdL5UrVT517l/XxxnjLue5yi4Nmq6WYasowon4fA0b6UJGGXYmhPwdYWsVMV0Z8M+z5kH2fy0r/r/arqpP/Z47rLdf3SzeBkO5rSZB+n+Cy3I+/HPRyEPd6akPWJuex22BE3b31qKrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHwjFmobxv7I14vXBaSRU1kHcQ6XVKIM6YoF+gMK7nQ=;
 b=U4JlUqOE8RGl8mGGgVObd36c0z4aydB2CmyAM4nwY+sUSDpIaYj0gAwXetDv3QBF7dPMByCeCMTf+NzqT5GUF6eoMOqNqTcebfZNdPVjZ7sOHgVPYmNYXwwC88XrdWH31B2XzGQSeEUF8TlFgiDvW7eT0MoHkAKdw7XUsG+gSBEQyek+gJL2beTFFyy7plXJfmz8p9ORVkWhC8bcbeMusJd4pFyJPxdZUvpQghEVM8/JfJ6DCyt3PV/bzDOWmqRoP+L61ZoxmK7LgyWYuBdIVEUiZcq8BImvl/kiAQlWkeWhLYT4tiu47YkaPL/WIYdJQxGlOBUD7+2QX2niDzMTuQ==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY4PR01MB6345.ausprd01.prod.outlook.com (2603:10c6:10:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 14:11:03 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 14:11:03 +0000
From: moonafterrain@outlook.com
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>
Subject: [PATCH] ALSA: wavefront: Fix integer overflow in sample size validation
Date: Tue,  4 Nov 2025 22:10:18 +0800
Message-ID:
 <SYBPR01MB7881FA5CEECF0CCEABDD6CC4AFC4A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.1.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH2PEPF0000385A.namprd17.prod.outlook.com
 (2603:10b6:518:1::7c) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20251104141018.21817-1-moonafterrain@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY4PR01MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: c2de8085-1138-4ed0-387e-08de1babfce6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|5062599005|41001999006|19110799012|8060799015|15080799012|23021999003|3412199025|440099028|40105399003|3430499032|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JK+Qb4TJG7XZp+foZdRoCHP3W0wb2ISuWNYHZ4SZGhcEVCTXXjrn8+1G4Gy4?=
 =?us-ascii?Q?dtjbsKHok/mv/eH3lyZcOsAHkYTUUyk9yfeAuD0n440nkKLv8+N2OKDErCCH?=
 =?us-ascii?Q?5VLqLwHFlW+gAsC0PEjUkb9LAqdGR2/Zyr6zsh259P/oPznpHJCGx9uMW2mH?=
 =?us-ascii?Q?gVKbrx4VkgCfgYGTIVKaiN3YO35DwYpeHIlOu9SEYv8379e5MnNSQa7TwXu3?=
 =?us-ascii?Q?jMsN4rYw4Vq2miMI3s8YmhdEIQC2cn4nJPt/1W54Ijr3I/4RyI4B4gk81/pw?=
 =?us-ascii?Q?3/R0QJix9Hs+5Qz4OL5wa3iDjWaVZDfKGL/I1147Kv4elVpYem8mZjQ2AjDo?=
 =?us-ascii?Q?EgtlouMuoZq3SuD5GPBvHdld+R2O4hvBrJ97+oGN7v1+MHkn9BkOOFzkMvIY?=
 =?us-ascii?Q?WeWl2XEf34mdswKGAor0ZmaQaA+s0xcAiytFPM5ElU6vLtXw66KOruFB2xgV?=
 =?us-ascii?Q?972PDaHhDWr6ACq369H6h4NlCgBOID/CnzGkgQ2Ag+V4P3jBUaBe+p0jEChW?=
 =?us-ascii?Q?aWb/0nrkn8B9u9rdHJFHPwtEVXkj4dYPKzDuJYwuBtb9lnM5BQlVAumk5gfx?=
 =?us-ascii?Q?9Vv0Ao6yCIxCm0eYpWEvDOP1wYfgL5FFHGveNTev/KS1OdrSE42A4lk8aevI?=
 =?us-ascii?Q?Dqg1cKAlqitsOAu1adurcSNOQ9oSX/MneOho25vaMCTlJogGqnpBLmB/plPL?=
 =?us-ascii?Q?S6K6TRa+7OTutJoarve4wGRm/QkiJfs3hUJtrApnPWpD5PvFAiv1nC4JmPl3?=
 =?us-ascii?Q?uTtL6MymqMVaqFbeuIfIwSg91OSC8RmnGF59VYjeJyRuFqQSF3EsANe9VbX+?=
 =?us-ascii?Q?T+jgruXJc8S9bm41F9bWajcyCJEzORe1TFeXDwwMaO6N4i4lo6zU26aHM3QA?=
 =?us-ascii?Q?vRjouM3NUPzy9xLsvhlWtO7IsK1FSm9SHzu3DQqz/gBUz8y6RAIRnliPxaBw?=
 =?us-ascii?Q?h5FmcUdeK+b/k5Olum49a01ZitGF+yfWcSGur/OtPkWuBOsCsWgJvZPvy3/M?=
 =?us-ascii?Q?3HvtUO5kLkZjt3AADte0KeHgxVqxyNM8E2FF01liDvkSVP26U1mI800i7Dx9?=
 =?us-ascii?Q?m+hfJqVcBJKlnSB2PLMuOoF8X2XqJYqVr3mYWMPpk5q71fzEE8Z6j4ySlVTE?=
 =?us-ascii?Q?2sxRMSburwRsHtNMzQU74O4Of0pptc+JHYy2WaEtPZySRp3ELgwqr0s5dSKP?=
 =?us-ascii?Q?pNSe+3mo1gqvgtkmulUCOOINogLLiX3KiM9cQWZqmZo3WG/NzRgZ7siOADg?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kZD4CpgFUKQ7G133Ye4kXIgVlM7s/rkX3TcqA+OPVDgK3YZ3Pftx/D5r8MRC?=
 =?us-ascii?Q?KmSFT41ag5CscWsE+eDaithre1wTbs5+hDFCUEu5zVqhx/w51lteiIryoEKk?=
 =?us-ascii?Q?9UsTM8HkA7etUalrtzNco1/vv9KWeji0nLAnEm3DHaY3i11GML9QqFRMWwkW?=
 =?us-ascii?Q?2douInNXOTuCRk11zkgED1sXpI1rtHYVL7qS3WJlUYcWilm6A7P/sb4eJHAW?=
 =?us-ascii?Q?HG7RNCEtdI63rGjSskSsLGJy0QewRqEn8VEtZxtsryByRm79pp+NN9SLiZRQ?=
 =?us-ascii?Q?/JCv0KcUVdg7CPGzx/FbNm0kmYJwm18RXhxy0dXM6AWNoudTecuI6HXIijy3?=
 =?us-ascii?Q?kTSacGxoyNhPQsIuTLx8ZJowMK/PMzngk7u6haVn1lya2EsSL76KRvKS7Itn?=
 =?us-ascii?Q?bTaScG1PaSTBzH3ywP9aG7BqwltA+XTK4iZMwpw4XZ2AItMer3pSlalLsiQl?=
 =?us-ascii?Q?qSim9/221WNYF7qeOj+YU06Ksb+jioebntBQJa8pV7a9nPUqeNeTW7cMfWkO?=
 =?us-ascii?Q?hsqwktj44f79Wnv18qsy5zB8YU54RwFFT5tC2XMXVM7DWMcBBGHQxCmX2/Nj?=
 =?us-ascii?Q?WAg6XPE8m6+8XZQJ5T43hYiBTgINS0E8DB6pgLqBnNb4gLOf71DjyFSEbd8n?=
 =?us-ascii?Q?1eWWQC7LHgN32fIO2vTfFCzIc2oGsz3mRnlWznL+ghnqPCIMX7TR6Ks9aj1A?=
 =?us-ascii?Q?epv25z5tIT4VZyt8/qJw2OGms54W/seTjCx8R18Ok58n47hm0f4Ts1v7dqcd?=
 =?us-ascii?Q?N3gCLkunKC2UATskcBsWrNnTBuUDn/ctQl1CRSGkFARL+G1HCJVoPoE2PY1O?=
 =?us-ascii?Q?CpkEq5Zi80tUIG2z2RBItlDB39pvCEiNq266Ze5yWZYEFNeHiRNqwW70Z9WU?=
 =?us-ascii?Q?Nden/DwG1jHHM2nmBTLBqu6Ps6iFUvHZ+26hQUfScCEJTny4B9qkyybeOeii?=
 =?us-ascii?Q?JhWOFv9UOfpoKkeFxG3ts/7/LlJ7/OVyK3Jka6Kx9VudzG2r4T9gEaGNXM2m?=
 =?us-ascii?Q?eRdUrZz6jD5lJoMShVG4LJCnGA2NA8zDqFLGfCdBlaJl4e4CNp3D31Vweixc?=
 =?us-ascii?Q?9N87BTLBoePlgVNAYRm/tuaFZCITUcFvV8/mtR9dX17G65AAVsENo/QA5Auc?=
 =?us-ascii?Q?+op8CmiQzt5v9CShnF8nyNALPyLC20U7Mq/IwJookBbVE0v5GIflAy3USuDr?=
 =?us-ascii?Q?2I3oNkkp6ZRmk9+q2thy4bt9Tw88d0sUZkHYC8k19ehkxMq9aDR8E4z7EMAg?=
 =?us-ascii?Q?GeVs1EwZ70SGvEQMfrnW?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2de8085-1138-4ed0-387e-08de1babfce6
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:11:03.4293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4PR01MB6345

From: Junrui Luo <moonafterrain@outlook.com>

The wavefront_send_sample() function has an integer overflow issue
when validating sample size. The header->size field is u32 but gets
cast to int for comparison with dev->freemem

Fix by using unsigned comparison to avoid integer overflow.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 sound/isa/wavefront/wavefront_synth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index cd5c177943aa..4a8c507eae71 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -950,9 +950,9 @@ wavefront_send_sample (snd_wavefront_t *dev,
 	if (header->size) {
 		dev->freemem = wavefront_freemem (dev);
 
-		if (dev->freemem < (int)header->size) {
+		if ((unsigned int)dev->freemem < header->size) {
 			dev_err(dev->card->dev,
-				"insufficient memory to load %d byte sample.\n",
+				"insufficient memory to load %u byte sample.\n",
 				header->size);
 			return -ENOMEM;
 		}
-- 
2.51.1.dirty


