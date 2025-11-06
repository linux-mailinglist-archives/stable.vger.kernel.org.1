Return-Path: <stable+bounces-192567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E40C38DD8
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 03:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E548E18892F3
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 02:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324AE23D2B4;
	Thu,  6 Nov 2025 02:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BpKGE2rb"
X-Original-To: stable@vger.kernel.org
Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011061.outbound.protection.outlook.com [52.103.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109063C38;
	Thu,  6 Nov 2025 02:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395999; cv=fail; b=cQLH05NJMCax60AVI8d7rG0bDGm7Qq36LWxzlOfhlc7rs+b0e8iGUb3Ai56c/Pqgco4cAVknjnPkaJYwp4YAetuyncLTmZXLtMOdfyjA8sDtcq+Z9pt8pHudkbeZh7+2vUQ1txW1tIkiPVI13Kjbr/ZvHYC5k1zAj1S5woX8uKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395999; c=relaxed/simple;
	bh=QbbpGhr7MOkGWoDYLKNLy7LJJwQpF42Xb6/NRHqOI+A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fegK2XIgfA67mNOtyr31Zo5Y6ur15FdLJpCfLHdGDv6hQF6cyCzwEA7ZHR8cyOnXVzuAE7HSnNc+hUv9Bo/zDYwCm7x631mOuAAP0iIdd7GH40UN39aNqCWE643MwEsmWIL+tMQhfbu7ULmeZaQ6X9pTT3Mj7J1PPrjOJb5gwN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BpKGE2rb; arc=fail smtp.client-ip=52.103.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVcveZuHaq8A22pdNBUVua1x6nKzn26h5iZ9OKYBSEkCcC+scrGpuUXrarOKTdomJmH6UXhgegVNzaH9h9Jlxm4Ys4AZ5m+HHtq8GBz1gQ48bPIRb+PHZvHx9X3WUn+fiEmSm0hpKZhDwcgAsllzCRRkyafNjo5FIdPnmlQH2UwYP47R0M9N9sTDX/g3/Kc1fLTqcw4Vla0NamLUU7Xdxicyol7l1RCyXA+0ROd1iBnb4JN9NmgGQLzDHF4CjHR9cLYq/lZGUpaAW5N3u3XC3ooSjosz7LZgIcmDAPiL+i9f+krbWom8j1YP8mf2toL0zzN1BCz0e6T4tp4KiPcRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIckBBTbtaYY9l92TUskm1/It+qRh7dAcyjHwRnf+Rs=;
 b=fwKfO+z5oYOlm4IOhvjqcfsHCWgA0AcW90k2psRh7JZFgdnydxx6M2w3mLAE7oVY5/E+3sRwtig0hK6pIW5aiK6bYSLAs0qDre62ul7HGM0QoR4NuIEy21Dqvi3LRr4lcD+UgW6GHZVGC8f/YsWY+l9fULEpX7allTGQuSfE4JVDOKjxJ1UUexidfGNpdi0wwPwDLkg38gGi5dCeiSs+pnxv8AWjGW3k9FzMdLqji/hhpBheumBxI5RPYVkEqkkREIURsJ36LctBFbDB9KscHPeY+nYdJn0qUAj9Moq0CBabk46UY3cu/+vpmQrJrWuF7vE0JXS67sSWTe9oZfMLdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIckBBTbtaYY9l92TUskm1/It+qRh7dAcyjHwRnf+Rs=;
 b=BpKGE2rb4DbkBksi6bS1eLjyH7odQtYirYibcQAdqkuToPkFhHhJKcFM9GfirWCX16VmfImqQivMr1wCflAGEkuZx52F66ToKZPOt9nQ8CLhp2hmIQyALCqbrV53R+BlLoSqHk7G5LBIUKWH5eOT9raPt1CKXQZ6Sk7wtxV83vDcDYPbEZaw1rgEh49MLHP7laWokwGx3o5jVI9jUyv+Nmg64xTw0ERtrSJF4d22BKckrACwSRlCdq9K5TYbbKDQInphsxVrx0grxPewl2XvtiSoqih6VVVa9zXoCMtPcYu/C07ljqDjsAKIsnn6hVw9ddECLxekjQerEoK5CHiY4A==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by ME3PR01MB7942.ausprd01.prod.outlook.com (2603:10c6:220:185::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 02:26:32 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 02:26:32 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Junrui Luo <moonafterrain@outlook.com>,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: [PATCH] ALSA: wavefront: Clear substream pointers on close
Date: Thu,  6 Nov 2025 10:24:57 +0800
Message-ID:
 <SYBPR01MB7881DF762CAB45EE42F6D812AFC2A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.1.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0035.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::7) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20251106022457.8614-1-moonafterrain@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|ME3PR01MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: f0958be4-ba60-4556-c18c-08de1cdbe4f5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|23021999003|8022599003|461199028|5062599005|19110799012|41001999006|8060799015|5072599009|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sX2BUXq1uSp98u/I8cL8zlNWHysQsbU6Ynqb45XOo3raYMHLnUjTy34kxmf+?=
 =?us-ascii?Q?a/nYqunGPA15TXAGjCLtQQrFXekyFxoGFuuIQJcaB7kRG2Ho+5bKCAywLCSX?=
 =?us-ascii?Q?MvzcSuCG44N/eCIFkhD1GJSt1vdCCRjcQwB7mVb2Rq2p1abLWmJE4dbJ1pXv?=
 =?us-ascii?Q?Qul6M5jkzpDVHfM933lto5HnpF1aG5muI21SUh2jJ9aJ9HDbblLUXkG+qbC5?=
 =?us-ascii?Q?bFsgwYAoH8DTjV89jsD42/5HYm8T3p0SPQn66TpyAuVkOxxReLs19DmYRf1f?=
 =?us-ascii?Q?D4bsvsiAvUOVyltvr3Ua8bP1gsaSKFP71r4pSRsS9iLUGKnjR1mYwqyKFGOx?=
 =?us-ascii?Q?OowEQSSXkXJ7er+OZsx1yGzZTtZiDhu8VmOeepwCFt2INO9ACuAr6h6F0PRv?=
 =?us-ascii?Q?P+qdBrc034IcqwnXGcKxVJvr3AxMnZinTmXN6Yrob8nMT8zIQd4TnE9aSyTW?=
 =?us-ascii?Q?b9lJCXHrIiR9ovL/tbWMgWvBqW5xm12kkhqDGoe1KTpslkmuyVCJI2H9zTFG?=
 =?us-ascii?Q?8e10Ed2EzDm1rTXUGkWn4V0OdzhuFV1S6VgaJOKJBRUzFDeoxab+4g+0V7h9?=
 =?us-ascii?Q?R2OwPO9F4VzT0s2IjGMlBoPzRR+qtmuGA0nNFa2Z4ejQUY+aalr5HgkPPP6Q?=
 =?us-ascii?Q?T0C+m+rm7rOdoCgCabY5X0lHFHz3ZX8lMgH+uOX/lg5aoC8ulsRQZ5UvgSi5?=
 =?us-ascii?Q?+hKEUiWT2dK1pykIxrlwMENy+j6UZxTK58uiVxOMG4+4Uz8g/hPWT86t8Glq?=
 =?us-ascii?Q?C64FQUWlOWfg0sPfbuMq7iEpsf14F1iMaEYI0v9tqiOrX1Mp80jk2oIVS2cd?=
 =?us-ascii?Q?oK3aQkBfm+o4ApwUhHBtTJOj8Bf5pnzWbjKCHKJhIPkWWSUxIkVFUYewHJNl?=
 =?us-ascii?Q?g8Esy0K1g7G8wWmgcudJsCWZnwrkluV6brsA6xO4fV/GJTFwhcqYjyOPalO2?=
 =?us-ascii?Q?G9VuQEZmynfRMB+NPMLgD3ydNDyB+v/t6ub4SJTCrO02EzKjCzzbrXD6DNie?=
 =?us-ascii?Q?TSp0ddZpkdz4BzAePnB8CjTHwoWYG16zy5pGx13MbGyTiCeSvxqnezgyZBCg?=
 =?us-ascii?Q?os5NuKMTlrOZx0wR9O47vRhbLZGZ5nue3fI+5exl6TmKBiFsI68re6kQFsSX?=
 =?us-ascii?Q?6pgzmxoeTBizsVAz0+HUdmnNXCOFaSksEy+yrMcsde/flZxPNkNQBZCPK2F7?=
 =?us-ascii?Q?WMl5RO48kaIY0GmpIvYdc31a/TymRjNFNHE1gFag+yfOt043QeMkC9uNF78?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hiienZu0rD4H0eZZ3fi0AsBulrQSLgqHKCZrIgCrIqBDqLYrwD8XGTTWE1iJ?=
 =?us-ascii?Q?0CwqfrRuLzsr1WNcgy4Y+pMrLVxqmc+owS6eriDSVir34Y7ZpCxKpJDaXu+d?=
 =?us-ascii?Q?t7Y/fGYRnupWQwQzmNFdeYfQSAyvcAe8Cuo8clJxU8dv6HTagox6HdODhr1x?=
 =?us-ascii?Q?qxrvdgsSkn83m65BsixViIVhOgrbdKOysDXgHe4xx3YuXSR8asfFC7ihZMTS?=
 =?us-ascii?Q?6FAPopWbI8ri5AN96WiMuP0I1paHpvXEjOLOyqEW+n7beor28+FU+cs6gY4E?=
 =?us-ascii?Q?rJ+JumXvoXo6G9u0C8/cBg7RvTnc9HQAgv5uTksVezv3kt9nPWo2GmjqK/hH?=
 =?us-ascii?Q?hiYzrCzx2QhkRoSYXmjMfmefs4C/QWAfZl6kO0+pfVYWmmSiOMIz2dHU9/0+?=
 =?us-ascii?Q?GQp22Q70ROBT3QZHKKfAnnZSTbRGyPbGEmL05/0ve2eQWtYMWv6Mqc9TIawZ?=
 =?us-ascii?Q?WV71DryBnuYvzGmDaL5W/IvO2/mo/hk5mxaYXyAyhKfQHjom1+NZaDm/4OcT?=
 =?us-ascii?Q?0n7NZNJIYOKYXx38zityBp82kDLzuwsNYtOy1gAh/Kldk55a4tBg/06DRJSV?=
 =?us-ascii?Q?BrG9K3R+uOsGNBVwJ7E4ww5jezlApnLP3A7lACbPIRRV36CJ/ED6Q24pkNzW?=
 =?us-ascii?Q?u5bqKZfOjkIA68qPcxHgzzb88TqWGtw3A05tOOr/uBB9JCv59cwTXPLa1WtM?=
 =?us-ascii?Q?iZRalP4xeUUAeVNdK93wnsXaJjDBr9w9+JpVT8XWLveKDbcikh5fVqZySBQC?=
 =?us-ascii?Q?scfoo3oteDvdYDCZUbFjRc9tIDtxjpdF7E33L52fOOBJEdRU5UlpzinA7sRe?=
 =?us-ascii?Q?39hieXPAK6JUiG1aww7QnUORF2EUACYJ2Qd6k4IjPh9aHilTrkNLdX5kjjUP?=
 =?us-ascii?Q?nfD0+vFdodQpOotTCl7z+M7XR0LyGn6xdgmP6TguM3txH9tnTCNzbySNDmna?=
 =?us-ascii?Q?DwuS3rrEuxD14gY0siYGtX95OmINUXNO+RKlboqCRGuRidcOFUMFz8qGP2mN?=
 =?us-ascii?Q?eqZGdvN9F4qGt8XIrroThd9gmRdf5wXo9wWhMrkwwIaPfrya+3x6bd+Q/Qic?=
 =?us-ascii?Q?pASAT2ocDnJVdngiYAGWRnbcyizBK/qmV7seqlcuIvFuUyVhBXljYXhUoPZt?=
 =?us-ascii?Q?G8c03KHaWLpZpFKk64aKDp+fEjD1EJFCBNB3X5lEoQNJbf940ivdXlXg4omB?=
 =?us-ascii?Q?MW7JOdiO/nTxFxdLnw//b37aAC2miBVBfvcuw07krOD+eoJ4awgYHAPX4Izz?=
 =?us-ascii?Q?BGso1AKyUtzBM6h2+3Q7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0958be4-ba60-4556-c18c-08de1cdbe4f5
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 02:26:32.3964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3PR01MB7942

Clear substream pointers in close functions to avoid leaving dangling
pointers, helping to improve code safety and
prevents potential issues.

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


