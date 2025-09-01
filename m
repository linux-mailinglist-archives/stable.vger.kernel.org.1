Return-Path: <stable+bounces-176880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A164B3EAE1
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 17:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382F0484BCB
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 15:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECC33431E3;
	Mon,  1 Sep 2025 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="nRGn7S2H";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="jONeZzY9"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4638A350821;
	Mon,  1 Sep 2025 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740106; cv=fail; b=IriYwMLA8JnVMBXR/aH0fOu6L0cG9UBRLRpmPdkfXIY32ua5Has/1nGJcgATeLNuQiew4c2JKkIDR/KcLcnevVyYimrJpA89Ac6FhZVGoXDRPqJE0psyijyZ0BVGrkvnPW6m+sT5iGKt4qgMi+Aa4JrHpik/ZCyQ4UJ8y1Ylklk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740106; c=relaxed/simple;
	bh=/cO3jpoX6YFPhE1ru5Vb0IuQApKgGsQWSuUDAr8j9gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VCfP+6fk1CzaPv9Vr0LydJwuHhR3YPv9f8YxbI/xcS8Ljkd2qB6KXR1AS8PtEh9WGSvyJYLjQp12r428t1XCD9K/wQsP5fb+Q2fqWNvdfYwFM8jV2aUnz6db8qAUNsS1GOiA+lvu8z842q98QAO6bU+0vQuAXnNEQ3vrga3MXPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=nRGn7S2H; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=jONeZzY9; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57VNoIVW3650998;
	Mon, 1 Sep 2025 10:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=cHAwdVz5+RxkXZY3
	/d7I4lm2uAR8PnPFt4ZWdS5bSL4=; b=nRGn7S2H38ZjR+XYHIocq4MjaZ3EmfHA
	JRJejauKyRRyvHI2MDlwxruqj1Hi1wXngdjNKls1p3WP/z6UXOnV7ZUoSHgQPAle
	3OTzTG3aTmmWYVZkntnmN73aI+PzrvoF//KNMOxZIgt4HGWtApIo+PX1jj+QzYus
	UzZqaOoKqhf7nw93/PIjS9YviULcUIp7kiREo7LjG1OsWZBALRV/s7o1gvKSLBPr
	wx4do9d1M3r5bY72z6FnW13+w3tg6S2gUpwovbneyvATuUZ3Mdb1h7j8pIHS4wJ2
	+F25SDYRfTKp7V2PccuGR4/KKPRf1aHLmWsWjGqKDPvIXycPmtI/aw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11hn2238.outbound.protection.outlook.com [52.100.172.238])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 48vens9c5k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 10:15:33 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ih1agtOOJeGIHAw2W6vdy8loO5+MaVdPvB7Eu1RybR0aTTCr9Y1TMQjgaIz/gd+yuxIM+PVOI2kVs9J7gqtBjmdd1ZkwTMaIHRWLMiJcWtLbHjB1rMvyLIrXrSvci/Zq0p4LovXLjmlug/Jy2OKzSddlu+w1h97qwjH8NW278M0/vdhZQuXYhV2QpLpyC/dXZElmjZkj0qpUL7cZHJtEfFOALT35XhYg9btHiVTrU2agbmkylRIj1moctoeG+yv7lvi57qYHYCvmJX1AtGcYbUJ6OW+wecuYaWmia2kdwhqbCLj2vhk5Tnq9+eJdIS9fHsnx24fT8rSPrLO36iREBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHAwdVz5+RxkXZY3/d7I4lm2uAR8PnPFt4ZWdS5bSL4=;
 b=e5Z18Cc2fVKFJKbDcF7bOfdYW8wg9hat/8HZIriAIjhlQguS7FY9tQIvqk+LG0l3tfmHmNl94DD+XtB+EQdkGRPooW8oJBr30TruMM+olvT9ouzySTc3LvXGjaWT5CE4F94TDTaub51LscrvFBQ67y8JJkrwLRuBOD+4z3bxcQfwU9ZECgoSzWlXQxfn9xKdPwj7AHgb6EcYCw4ETDvXJxATTYkV6qS4jEhC7oKtvHzB5OeeTkNwqph+wCtAYKgnsah7S3sy2hAOebMo1j3ApL4LyvCiOn7xZa1w1tC70Ejvh/47/JKllpIhOwe/4Yn2Iy862oAt8U473PxQr7ATxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHAwdVz5+RxkXZY3/d7I4lm2uAR8PnPFt4ZWdS5bSL4=;
 b=jONeZzY9v4gIg+8MFRIPA2Mu/ccZy2b/ul++wu7vIa07vW2YvdgHPjBgueRGhAyNboB8g3SFuZATfvN1ht/rPQn6KX/iK3Nv6lw2dbs2ODiT+Asvq2SvnaRVbP5QQUdXA/ebR6MVbE0gihFeAcxtCAa8z35WEWjHcgSoa0afsZE=
Received: from DS7PR03CA0187.namprd03.prod.outlook.com (2603:10b6:5:3b6::12)
 by BY5PR19MB3987.namprd19.prod.outlook.com (2603:10b6:a03:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Mon, 1 Sep
 2025 15:15:28 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::83) by DS7PR03CA0187.outlook.office365.com
 (2603:10b6:5:3b6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Mon,
 1 Sep 2025 15:15:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Mon, 1 Sep 2025 15:15:27 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 555E3406543;
	Mon,  1 Sep 2025 15:15:25 +0000 (UTC)
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 40DCA820247;
	Mon,  1 Sep 2025 15:15:25 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        stable@vger.kernel.org,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: [PATCH v2] ASoC: SDCA: Add quirk for incorrect function types for 3 systems
Date: Mon,  1 Sep 2025 16:15:07 +0100
Message-ID: <20250901151518.3197941-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|BY5PR19MB3987:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ff1bb8d1-4cb0-4e1f-cbac-08dde96a620f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|82310400026|376014|34020700016|13003099007|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MUARjSQsC7JV27dKihd0QI7lOZhIoBiHd4HifqZgwSCj+rG1rU/evtFa1tcr?=
 =?us-ascii?Q?GLhvRA+qw2cAVsWuZzRuzgD6/YO43R4ugJpTUis5jG2PY7viWCVZzarFKVJ6?=
 =?us-ascii?Q?88fW3nCpo99xw3uyvyX3BnmiQCFpiAk/h4CgENYyZ5bYGqB3CDPn6Cayylfm?=
 =?us-ascii?Q?ebuMFTXFo1xwEh8KOF+D5aUptRm6vJF35bWoHSuGf8x4aqi6fV6QkOnQ7S+W?=
 =?us-ascii?Q?1Q8iw5Lsfy11DpjAkgUMmAFlgrn58Ww6c292lINmhtYF017HOMMYMKX4O+Hm?=
 =?us-ascii?Q?4NFJfeqzxRbESK6bL77MDz2mpFdmdu1s+gI699n1NHO8Ox5LXk6qh8scjtAR?=
 =?us-ascii?Q?hFPDK1WqSxUVgkjmPVsm340mMIRzPkIvMXrFRgIcGMcDEHgR0+hH0rN7PJWv?=
 =?us-ascii?Q?TPsV1GE396zzf0H5CB4NWhYD6z+1kizTcHCHFffufOcEuUI2LmoBoaXBGzGT?=
 =?us-ascii?Q?ffvqL004vlYlCFXEUb43B4KsyL3ZTUSyTLh7NyhPMQmtzjR7x0WVCf3PADaQ?=
 =?us-ascii?Q?cO6z5JXlQ0jA7B9VANCV1o07099DT8ebEneVQQ/IOr11GpO4/zBYqPj41wi/?=
 =?us-ascii?Q?QbjP8DrPOEqxKIZUgmvygMzCSMsIk/WzVGg+On0P4Vlc+APKmhRA7kysRNb/?=
 =?us-ascii?Q?CI/GAQwDd5qBBtimilU4NSzhnKh/ou6eV8Bxt133ToGtIsFs/3HdyjS24CpQ?=
 =?us-ascii?Q?JxGbQ44MSicdxP/gyvr+3y+S1b+2Eai4VNLru7aN8/fUU4YQJuEK+Nk5RsFE?=
 =?us-ascii?Q?EUjYbtl+fZ3rzq/dnHIq0xH3nCt4YpBY+kHzkT3bVeGfHGwmBBwAyjkYrCkX?=
 =?us-ascii?Q?Wb7d1vTZC7emhy+jCbYSOT+OKmxZax2NqMreRM/7e2K1/IK1k+7qrFCQJcuR?=
 =?us-ascii?Q?Yl/DbWcZjnq0j4lOeSjrU06jbKhMIjooMvsblnYFuaGBKOUV6b6/xinLkG9f?=
 =?us-ascii?Q?qTI+OVJLXxR2wCxAkpVSMUHxKuDAFJopWKlQherGiO+g8mnqMm8Sxjrrq3WQ?=
 =?us-ascii?Q?pt1juvODR3x+73VetKIz2ubm8MLFtbivI4zu35lO6ijdbkDFpKBMBS9tuH02?=
 =?us-ascii?Q?Zpd5RMvAGJ9gf3xoFT/dH/wX2fd7Z5PFc5CkWFvKeQm5GQeuskQXi87aDhKE?=
 =?us-ascii?Q?sEKwdjh8H0AYdJVcopBUIAitO1zX9bzt/fG2R25R6oIcfmQYtbadDXNj3auH?=
 =?us-ascii?Q?u9dTJAy6wYX2WoVQ6PhXeSXiS829afj7LE8VvyDRiIrtghMi9VdFiSiliQDJ?=
 =?us-ascii?Q?iFVC//WCInbr2Y+Uq6r000XZ2zGsHHYB81gzANbxA7vmKnYS7tr3/Xitxj3r?=
 =?us-ascii?Q?3ZCzTgIs6xb+wTSQUZqwiaSfIGHITue632AdweLShZ665Fb66PwIE1faIwxC?=
 =?us-ascii?Q?uQ+6QjtKW2LcJ8iZw4mIfRWIF8qr/u/Kr0dY5Z0qp8MboPdMXLCbUQDBc6qM?=
 =?us-ascii?Q?dyDd0tyUkkB4IncPSsO3ck8Yyrl382EFrnm/do63BjVaHV794lG7la2PZgQq?=
 =?us-ascii?Q?9G+L5nCSpG3Sm8am6oCiFwHFrA/eb/bxJY58?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(82310400026)(376014)(34020700016)(13003099007)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 15:15:27.4860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1bb8d1-4cb0-4e1f-cbac-08dde96a620f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3987
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDE2MSBTYWx0ZWRfXyHO4fK4l9Omm
 /HktcSA9r/rbRaoEOL/cXBHlXxNRBNs7L6garK6GG7ulxbgJ4014wrRM3DjNzm2MY222dA1MQAi
 lx7QDm2PQzwNG0BYe1iR6IPzedq8KlhPokk/Mo40UXiBAG1nt7kJIl6PnQzUzsvg6uTC/wZHcxG
 Ng9aXm7Z5v0hvHDPTAWEzBa6emfppDJUvWKaPCTX+uZ1o+yk/Hk/oayYuXPOElWjRrLYTpvlVWq
 KabG7gd6jeMfC2+qhRp3TBdLQf4fwBSGML9dmY6a5JKr5mkt8O2vWBn7OUjcz7H4J65+6H37FQ5
 Ao7ZzghUjc3TXEdXfQWudhp8HEGe60Hn2fkjEfmSwVLSiZ26bAkNDOPDzaV/fA=
X-Authority-Analysis: v=2.4 cv=BY/Y0qt2 c=1 sm=1 tr=0 ts=68b5b895 cx=c_pps
 a=cV6lgNW1wxL+M0wVxFL7xA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=OnzpGZJ9ApewbPU9sKIA:9
 a=jZz-an6Pvt0H8_Yc_ROU:22
X-Proofpoint-GUID: BfMapb0nKu-PqxeoTAQebBWyvMLpmDHz
X-Proofpoint-ORIG-GUID: BfMapb0nKu-PqxeoTAQebBWyvMLpmDHz
X-Proofpoint-Spam-Reason: safe

Certain systems have CS42L43 DisCo that claims to conform to version 0.6.28
but uses the function types from the 1.0 spec. Add a quirk as a workaround.

Closes: https://github.com/thesofproject/linux/issues/5515
Cc: stable@vger.kernel.org
Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
---
v2: Added a Closes: and Cc: stable tags
---
 include/sound/sdca.h            |  1 +
 sound/soc/sdca/sdca_device.c    | 20 ++++++++++++++++++++
 sound/soc/sdca/sdca_functions.c | 13 ++++++++-----
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/include/sound/sdca.h b/include/sound/sdca.h
index 5a5d6de78d728..9c6a351c9d474 100644
--- a/include/sound/sdca.h
+++ b/include/sound/sdca.h
@@ -46,6 +46,7 @@ struct sdca_device_data {

 enum sdca_quirk {
 	SDCA_QUIRKS_RT712_VB,
+	SDCA_QUIRKS_SKIP_FUNC_TYPE_PATCHING,
 };

 #if IS_ENABLED(CONFIG_ACPI) && IS_ENABLED(CONFIG_SND_SOC_SDCA)
diff --git a/sound/soc/sdca/sdca_device.c b/sound/soc/sdca/sdca_device.c
index 0244cdcdd109a..4798ce2c8f0b4 100644
--- a/sound/soc/sdca/sdca_device.c
+++ b/sound/soc/sdca/sdca_device.c
@@ -7,6 +7,7 @@
  */

 #include <linux/acpi.h>
+#include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/soundwire/sdw.h>
@@ -55,11 +56,30 @@ static bool sdca_device_quirk_rt712_vb(struct sdw_slave *slave)
 	return false;
 }

+static bool sdca_device_quirk_skip_func_type_patching(struct sdw_slave *slave)
+{
+	const char *vendor, *sku;
+
+	vendor = dmi_get_system_info(DMI_SYS_VENDOR);
+	sku = dmi_get_system_info(DMI_PRODUCT_SKU);
+
+	if (vendor && sku &&
+	    !strcmp(vendor, "Dell Inc.") &&
+	    (!strcmp(sku, "0C62") || !strcmp(sku, "0C63") || !strcmp(sku, "0C6B")) &&
+	    slave->sdca_data.interface_revision == 0x061c &&
+	    slave->id.mfg_id == 0x01fa && slave->id.part_id == 0x4243)
+		return true;
+
+	return false;
+}
+
 bool sdca_device_quirk_match(struct sdw_slave *slave, enum sdca_quirk quirk)
 {
 	switch (quirk) {
 	case SDCA_QUIRKS_RT712_VB:
 		return sdca_device_quirk_rt712_vb(slave);
+	case SDCA_QUIRKS_SKIP_FUNC_TYPE_PATCHING:
+		return sdca_device_quirk_skip_func_type_patching(slave);
 	default:
 		break;
 	}
diff --git a/sound/soc/sdca/sdca_functions.c b/sound/soc/sdca/sdca_functions.c
index f26f597dca9e9..13f68f7b6dd6a 100644
--- a/sound/soc/sdca/sdca_functions.c
+++ b/sound/soc/sdca/sdca_functions.c
@@ -90,6 +90,7 @@ static int find_sdca_function(struct acpi_device *adev, void *data)
 {
 	struct fwnode_handle *function_node = acpi_fwnode_handle(adev);
 	struct sdca_device_data *sdca_data = data;
+	struct sdw_slave *slave = container_of(sdca_data, struct sdw_slave, sdca_data);
 	struct device *dev = &adev->dev;
 	struct fwnode_handle *control5; /* used to identify function type */
 	const char *function_name;
@@ -137,11 +138,13 @@ static int find_sdca_function(struct acpi_device *adev, void *data)
 		return ret;
 	}

-	ret = patch_sdca_function_type(sdca_data->interface_revision, &function_type);
-	if (ret < 0) {
-		dev_err(dev, "SDCA version %#x invalid function type %d\n",
-			sdca_data->interface_revision, function_type);
-		return ret;
+	if (!sdca_device_quirk_match(slave, SDCA_QUIRKS_SKIP_FUNC_TYPE_PATCHING)) {
+		ret = patch_sdca_function_type(sdca_data->interface_revision, &function_type);
+		if (ret < 0) {
+			dev_err(dev, "SDCA version %#x invalid function type %d\n",
+				sdca_data->interface_revision, function_type);
+			return ret;
+		}
 	}

 	function_name = get_sdca_function_name(function_type);
--
2.47.2


