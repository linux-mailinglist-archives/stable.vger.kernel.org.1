Return-Path: <stable+bounces-192402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C227EC3171B
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 15:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23D584F4EA7
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 14:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D153632D0C8;
	Tue,  4 Nov 2025 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gyPYf8Rr"
X-Original-To: stable@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010072.outbound.protection.outlook.com [52.103.72.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D48313528;
	Tue,  4 Nov 2025 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265531; cv=fail; b=le8zbQl74F80XSww4MKrIhfw6x/hCzto82PMgcPIsqqKpUlJniMpNz1RIoyuRHorp6YNEoaEZSuzPPCFHKBPepDqxiQavuiLgr3GYJtpvo8Ex7sF8Cm9C0bWFh72qkXTzjBJVx+gDY8oSN3wCYpcrqAfebGx0xhEqGdYwUZ+37E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265531; c=relaxed/simple;
	bh=I34HPnKUuuwaaKEV1yAfhVvDW1WjMc6Au+VnxhIef4s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dHrCBLa9UPKGAcUxbFiBMLP5wIx0rTT9p3dgRw1Q5v0cRiBlOm6ZXflCXmsk9v5vraawdYcT/Y2y8yF3pAcjXP8qMLV2JtINSAyrM4uRv5akUPNII8zC3kNx0q8PplfLyWPv5GaqBbCOzuP3WUXq9GoLFTrkVmZB0Sb27pe00wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gyPYf8Rr; arc=fail smtp.client-ip=52.103.72.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyfDW4SY/q6oJe1+0yqAXF6oNTflyIFnrEuWD48VkWGFYIh8MdeQFXmGrJoDHghOl0XEDh/qc1kgpHcGDKAOB5JA0E5W19wlwHFJpKYJV+ih72tDUx6apzJYeiATpz9kODAJoJf2hirn9FSbfZTWDLRmbGWHmyQy+n65Gq7CtpBw6umDezCT/dCMb35xrHN7to2iLys9ufDGIZ7/WzeAL+FIl7qkcAsxFx/5nWzx6D0X8FhO8OdV5uSMYMYfhTg5lodf6xkxBmFtA8IYnS2I0+U39gQF8SrvPuZkxP+EKJpuV1mijiWbPcXKTAo7D8ZXZo4D+woAOQ1UoNVLeUoIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPcRhnhIaNmjmiyUP/L+EMCxn+LrpFWtf+3uxJd6UZg=;
 b=w3ABH71vjir5RRecMSf7+Cxdu4EqHHovqsLC+Bdf1Q77aOLn96xGmvhnHRgpL78G5rqK3CMpryIiNzPHxo2V5XwR1rYLO4W5fSBA9qPxD4iMR8pmAtewP7inbopCSizRxNZPybjcdZXbVcqwizdofIEzM+/32hWYNAv3DD4REQ+fl22VsCSRZaGJarCT0PpjUNj2pjx+2/dxWuEOS2OmFBuYR1as4IF7lKI7EN2qKrg+SjGOieptbP952cb7WoRKQC9OxxipkmgtHE1lUzLpE2yTaAwEWFqXNp5yWSmIbT+zPZOEMPINVKspPOzam2Cf3K3Em5Why4NyuvPJkVbgBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPcRhnhIaNmjmiyUP/L+EMCxn+LrpFWtf+3uxJd6UZg=;
 b=gyPYf8RrqzqDnRb80YDPvzcl+E9uYuCiM+nNjsiEQFOIHuRzB4TDxoqFOc0QOIi3pMS14S28+aoqoEzI/YDSrxfkcVGI3NA0n3gBFJyv07IpO/7V+5ao7k079zdfC5jPGAoYU1ORECP+FUVJMqp1R1/jyt358ONqu/gndIR/eByYkB2HNR0GPLSXv4MBC/uQmfF1gvv7/cFAwHUo07MhCnwAwWG6X7LQDT8zSscfHi/gURlua1OVhjhpdQ+YZXGV+REXwX0Rzlo1LCaRaO30Zj7LQ9Ni0pQ2aYTUiN58UdFqQ1hNMKI4bxMUEO4VqGf8Gfor0XTQ8+W0gRIDNo2IlA==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY4PR01MB6345.ausprd01.prod.outlook.com (2603:10c6:10:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 14:12:03 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 14:12:03 +0000
From: moonafterrain@outlook.com
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>
Subject: [PATCH] ALSA: wavefront: Fix use-after-free in MIDI operations
Date: Tue,  4 Nov 2025 22:11:55 +0800
Message-ID:
 <SYBPR01MB78812BAD18C71593392C2C31AFC4A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.1.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:a03:114::21) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20251104141155.22098-1-moonafterrain@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY4PR01MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: da4c578c-2053-4322-c2bd-08de1bac20e5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|5062599005|41001999006|19110799012|8060799015|15080799012|23021999003|3412199025|440099028|40105399003|11031999003|12091999003|3430499032|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mgo5G+y7rRiXIECXRzPAsnkXpoVv0T4vH6yg3BfTKZeNR7G6Kbfdx0u4WbTb?=
 =?us-ascii?Q?ZuucDHz84AKLVy3ufx7QZjcI7pGa2JOomwVJHaJCOvWwLF4ETZspIwFEA3uZ?=
 =?us-ascii?Q?RSaCSXJNLBqiRBa5yJe2DWKmtLoMGatEQ0Hj4DbWJSb6uATETUl3eMgS0QQ0?=
 =?us-ascii?Q?oeMFsZU1ep1MPplfIpmle3rD1Il5pL9/v2up9rdmP5y6/sPgEK55lGNArOqp?=
 =?us-ascii?Q?L8tajLV29+QRzcGI2NmMpMctzKZF22s2TNqs+jCsEsxLQ6FWHANgVqQrfgl5?=
 =?us-ascii?Q?WdG+GpfF9R9iQlcORgMIY4a9CSgNUOv/SuD9y1oXtzM6kKhVDENEFdDW3/ss?=
 =?us-ascii?Q?Y05LSA674Zn0E2Vr3p8CPZ8gSTwNsAOG6jh5BfhRRjRT2BgUk/xFCxaeTe7x?=
 =?us-ascii?Q?vOSDmTAMpzNnoACvty6kSwGVADs0ATP3upiAdCx98p0oLL1LsVe4oU+Ps8nB?=
 =?us-ascii?Q?TOO9Q3w/RUKE4xMczbAr6FNDegjXRlxVYmPYLV7RG391l1WEQ5b9Z2o+zLCW?=
 =?us-ascii?Q?mJD5XQ8YeU96DSt2faK4BKdlRtQ4aKjGsvSY9mg4DzVajW+lW4np0pX6/53z?=
 =?us-ascii?Q?UsGr+gxY08/EXzTPYxBhPAkDHLGvlN7LCqVJsN6JdJTx8kj907K3oz0Z8acJ?=
 =?us-ascii?Q?7+/ztsF7mEU8CnvnPNmnI2P14T0UUQ1kyNH9UlIzQE56msy+5+7xfEz9Et2o?=
 =?us-ascii?Q?ECwnm83P01cXBb03qJUdjrWbJrx5RQaBdZyRRh2JRmiYomgB5OZIoaSbqN34?=
 =?us-ascii?Q?7zGSIguJQXaj9OxABzFPfmOBDxmZife00VEhCPmp/S61ef3dl58SgHST/kHb?=
 =?us-ascii?Q?qY9pCkdJk3wc+XiOBUBMjTUzg9vxcWIW5X+gy0UE93SU2uaPmnmPK/jUW6iS?=
 =?us-ascii?Q?uDvKlw+vgyrbcIGJxPipJo7ssTcT0s48Qj/bdDSxsMT6J9ep7F5AmDigXL6R?=
 =?us-ascii?Q?iNyYf7Cr+X3DSpy1B09ecD+B53npE743lB/Ksh6/KwOXXqLdWRk9Xtlki0An?=
 =?us-ascii?Q?WyT6fhktwyGS3wVU2TTLgs3Iw4vyd/wEcLkX/aij/DqrTzQcuCgyDhva8t4P?=
 =?us-ascii?Q?pijGNPk6poBDU9Vg1TY56iXKUvtBUcliJh0zfm9NtqyVp9V2Y4sxTDLBqB72?=
 =?us-ascii?Q?QmIQAIoWkpLusbfCc/GCdQ+ixxwYsTlYZZUV6G3qyOLbHptYhaIahJiwknBE?=
 =?us-ascii?Q?Viw+VxMYaNWdkajQveR/npVaR+iQ/NIEdTLij2XodB95R6m2FdbHXuBi35Rc?=
 =?us-ascii?Q?3ESUlk4md130lN87o7tztshMFgO0XcbqGQvk23Rlo5y8eIsPhkdT5sK+04Ak?=
 =?us-ascii?Q?slk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?10nTHBa2aCkxosXqTCUmt0ITxN+FDgEUVb4Qzids8j9lrx5lLpeB9S5argbF?=
 =?us-ascii?Q?mtlnNnye/pLjx/ktiwaCSOS6RqfD/+jiiG3c8OfoW22lbS12d7EuH3funNts?=
 =?us-ascii?Q?EFfBu9Hs9oTOzGs7hGs71D8fl1gyd6VbgWJ4obG1aHqHAJ7eDTf/S4nk9/2t?=
 =?us-ascii?Q?dh3G2M3LZ5C0fZ4CyCCuqMGekcJijLa5wCEJG2+mEYVUGkwSiZgW/pae/7xp?=
 =?us-ascii?Q?isKKhCpdZB/eVLUmvl8mglX1mkmBA8eeUeApFwDcM/6rS6WU/9h8NjEqp41H?=
 =?us-ascii?Q?zyTTrg/rn4pZC8otSI2nkExGACusEGBOxxNmcOU62h/td6JgC1OoP8yuZZJs?=
 =?us-ascii?Q?K5Hz2LjH70lnxZcTCId0J0JctytRmr0nJIVStIgY6uttLq7C5u2G39/P/SJd?=
 =?us-ascii?Q?03y2j5aV62Tv+4lK2EbvlPG91Qasug22ZfNvIlLoIVVxFLfU7KomqUbJTmdD?=
 =?us-ascii?Q?d1zUL8ND1qkD6x/e155i3dFA0hFG7jmya/nqYtevr84/lrZFgyT5sgGYwe8w?=
 =?us-ascii?Q?nHidU2C3FbKgliPjliYwLUQe1fKa0jX2hnh/KT86Vwm28RCuvnyZFEtJyEdM?=
 =?us-ascii?Q?BGYZ5KcF0tjCWHOpap0dW2H0ge2uGtvRLGwyGTN2+HQDjkska8e8Kcv1ocnX?=
 =?us-ascii?Q?X1xDHrOvBMzeukDd7BHAH3opVq2MDWfB80kvs8RLZ869g9bbBDvMcCLRYH/I?=
 =?us-ascii?Q?bz6aFFLrPPoaDp3FyxgyiATG1i1OhagCOYnSqHHfAwUVU/QZ6cJln1ZB6+sq?=
 =?us-ascii?Q?kdcIBObDwSkmBGapulUtAhRCN/uUxf/aV9cZrikPL+P3XCyE6ORrMxIFl42F?=
 =?us-ascii?Q?YkmFf+AM5WzG+d1jbJtZ39jBgCq1nooTr/azx0ymRf0xeqemkAa5KY1GHvpj?=
 =?us-ascii?Q?LGJTnbI2KHmaCO+5ElP20N43ErO9Vy32V+qjoqAe/b/KcODCGEWfPEH7Mnaw?=
 =?us-ascii?Q?ALCY5CmY/PrPTc3aw2wAEC3leJ510L9Pv5puAaAaLLkNG2vOIzdly0yowp2n?=
 =?us-ascii?Q?Uznskm0+vdf2ULxCr9Iqpc2bw/FWYWUTKWdBBHJznoIlV/PLRY/fv0E4frAD?=
 =?us-ascii?Q?sH2pemzPCoA+ctcObR/nywaoneVbq5Wdajjdq5IJ1ML+6lrWUJF/btAgU8Bh?=
 =?us-ascii?Q?LKR2XSxlScJUz/dvupgtP/NsfGisKhbAkWsUcsvP/jcYSE2nkX1RT96UhkBY?=
 =?us-ascii?Q?P4sWQC830VjZdrh5n9BiGcgfj1R7A8j0YXBXG7xsgRgLxiAaIQdIaJb/PO8/?=
 =?us-ascii?Q?iSBemOPxezTCUvnU2gkN?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4c578c-2053-4322-c2bd-08de1bac20e5
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:12:03.5452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4PR01MB6345

From: Junrui Luo <moonafterrain@outlook.com>

Clear substream pointers in close functions to prevent use-after-free
when timer callbacks or interrupt handlers access them after close.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 sound/isa/wavefront/wavefront_midi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/isa/wavefront/wavefront_midi.c b/sound/isa/wavefront/wavefront_midi.c
index 1250ecba659a..69d87c4cafae 100644
--- a/sound/isa/wavefront/wavefront_midi.c
+++ b/sound/isa/wavefront/wavefront_midi.c
@@ -278,6 +278,7 @@ static int snd_wavefront_midi_input_close(struct snd_rawmidi_substream *substrea
 	        return -EIO;
 
 	guard(spinlock_irqsave)(&midi->open);
+	midi->substream_input[mpu] = NULL;
 	midi->mode[mpu] &= ~MPU401_MODE_INPUT;
 
 	return 0;
@@ -300,6 +301,7 @@ static int snd_wavefront_midi_output_close(struct snd_rawmidi_substream *substre
 	        return -EIO;
 
 	guard(spinlock_irqsave)(&midi->open);
+	midi->substream_output[mpu] = NULL;
 	midi->mode[mpu] &= ~MPU401_MODE_OUTPUT;
 	return 0;
 }
-- 
2.51.1.dirty


