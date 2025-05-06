Return-Path: <stable+bounces-141804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63240AAC368
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 14:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2CEB503E93
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 12:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644C927F16E;
	Tue,  6 May 2025 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0mLb1Cet"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BFA27F160;
	Tue,  6 May 2025 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746533330; cv=fail; b=BR00TD/oK86f/c37o4k9+mjdfCHZ13d64saprhSFxe1hfUMuVia4pFD3QWKY8NZzo7Qew/j4cBjFUvs6OU9UD4wsKvXWitt4pdUmgInyk9+64sOt4apTk+j8DBmG/yxgfubBvzZ7ttDOfm76sbmQ+rbtmzm6Byeysoqw+YW/lFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746533330; c=relaxed/simple;
	bh=fcpiLCuu0BdAH8f5Enc/2RCxoVKdwU0i3PWkQv7MRTY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W1+wEOFhoy3Sr1r/drOkp9UnanGI8eZBe0dp8Kn16QGX7+nZ0+E3HpJMqKBj9gvQqJTLrXo9NberoV2WQJMli2ZpJtOJlnXY8SbM3DsF5U7TDdoMHwzdK9pmAPNrR5joKDdTKpccnYluEOsmBn6P40N8YgO7zX/49dcKcnWnXp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0mLb1Cet; arc=fail smtp.client-ip=40.107.100.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LG8OQNNzj/3TOgEOhe4hDlgtiKGCo5g0mOvUfagvZjogwQRl99H7B6N4pq5CA3A22D/h0Srnq2oGlnrrze6XeEQ4Kh1KEGmJ8/npbtFcYsy6aBNgxOmZ6d5YH6tzZIq5kUmICL7m/WAg8joiXll8z6l9ZhMhM1HouLaTrTQMOyRtMZt3rlx6P8p8quAr+fZk+DxnqCQs1D7AKVQIsNT0JO55s1FovnxqY5kYUYcr/D2s+2NEaxNEQvPHKwoHInrGBRiJo+bSTZ8IDXOHUEdisTKR6BN5ZG7lQavaom25sxzuqNbuU4fVj1pjK+US5pq2ai1zChdWx7hLTaxbx4K8lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCJX/TqYaAGpcCEhnuUkKbGhdTdBr7ryb3GY7ZSVT/s=;
 b=yLT/dt29lnxFSullNqFhnJCnkoSVq+QhqcGEdPwTaX5iWRZz3hqDDPXaKfEZFAUSwu8pdH7D5/xhSk9/rT0oNOU/3HWAg/iaXDc/LfDVRaOsrerZlprVDFU5ilzqk4JGEfZp8FKAZM55kM/MdcZ0r6+WSAhabhK8cEmt2ojwygdFvUWPrnt9NIZtG3NJqVY3hsqTEYgMbgUEdF4oJbkeYWe5zXuEzq43iSOfdnRQ1GmvZIBGRC2uyFEYMmstFYyKCAdDqAUxTiouM1yqjMzVDk+GnWkOPP43ymXHrc9ttUqsp46qipuTGM0hAP1JTGNIXd9ywM6DoxaloTYLwsPfzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCJX/TqYaAGpcCEhnuUkKbGhdTdBr7ryb3GY7ZSVT/s=;
 b=0mLb1CetHC3i7oHcWJWus6y3SEYC9EmuJF/Ar6vboQzyvDvK6O0GHiRRFJkzcpvJ3jfME/yGfIBHv4Apq8AEl2u/0cw/1g15G46MLwZFYJeFMk8nB1fGaMtWUs8dVb2QjK1mB08hNso6ZngLTnyuQFyCYQq0yBid+A1vvaL1c+Y=
Received: from MW4PR03CA0282.namprd03.prod.outlook.com (2603:10b6:303:b5::17)
 by CY5PR12MB6178.namprd12.prod.outlook.com (2603:10b6:930:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 12:08:40 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::17) by MW4PR03CA0282.outlook.office365.com
 (2603:10b6:303:b5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Tue,
 6 May 2025 12:08:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 12:08:39 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 07:08:34 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<ranjani.sridharan@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Mario.Limonciello@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/3] ASoC: amd: amd_sdw: Fix unlikely uninitialized variable use in create_sdw_dailinks()
Date: Tue, 6 May 2025 17:37:22 +0530
Message-ID: <20250506120823.3621604-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|CY5PR12MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f87ed55-99be-4a0c-07b4-08dd8c96bcd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sXry+cZIyEmViLdqtThJReDMsRxKKWDJbQ8Uu3+y2bObXrZDqJkfjyHtEPxP?=
 =?us-ascii?Q?nP6NiEBPKOeOelDREjOir5SV4W3InAJGZLlbr4CQwgbzwyT1eRKogAKoEEKr?=
 =?us-ascii?Q?yJ9hBQNjhRznSxg0wdZXMnjzSlLGmLoCTrd2otgkEFx7n+IHMcl/YCuvxOBm?=
 =?us-ascii?Q?Mk6RlI/01TYF67vyEONuO8EVdelmHBxzph4OZM4bWHg6fKJGH5/e72SLEb+J?=
 =?us-ascii?Q?4Xg+uPJIPIOMP5pn/KZwsNCOcwvWuo08YMmg2X3amP7OYuVfY4/xOTzXwG/6?=
 =?us-ascii?Q?NicbduFLrLIVWfgvLMYIWbajdLUVJsaIEDeMTFqY58aIAScArGgahtwrsOhz?=
 =?us-ascii?Q?mVMf2zUeRSoXpfMU7KVeZ1v+AuqCl51PtPbgR70kzckmD6KSmd4lP83XCaOi?=
 =?us-ascii?Q?Btoewd0laXJkto1kS1cmb4ZpDc3XhxW45rk17Tt6B/2DaMT2nMdeE4BXA7r4?=
 =?us-ascii?Q?UL+to4JDWDmyZPIF3rx/OCg5lirDYMJODsNHI4eyXIgo3/gCOKC+tYApUNrp?=
 =?us-ascii?Q?K0tpKMIBdtHY0DelCvmVV7uweNsfgRK2ouNgdjTYniN1vNrs6joFu9C2Pzc3?=
 =?us-ascii?Q?9MkBKcaCmN5WXIKFbQ21TvS2/+Fx1PE8WHJBpGxPyq6G8S4d1QW84CmQ7kGH?=
 =?us-ascii?Q?ivw75NrsxKTR7HHwDVjbO2YuKhChbfOAtZfKpLUbnGijSBzUhPlEB+Qi0v47?=
 =?us-ascii?Q?sjTnwHhU3TrsdeuaSPBfwNnowdEcmqZl+MdEOYtC9t7XYEUHwE8uzKL4LKrr?=
 =?us-ascii?Q?TuMHc6sEfzfalW2dnU7AWuivlhdXIACiI6C/vk9xDUyP7ppsdhM8wgpYRCYY?=
 =?us-ascii?Q?IbJ5ma71cmpS2lAw3+tA0qRxDOezX3Hf93y1p31PWWKy5/aksB5wd52ppdjm?=
 =?us-ascii?Q?JBQuQIUXS1AiUuUXXdQorMC5IULeqgKaT5yF4QRCgsVfS7+yLRLg6G2/hTUT?=
 =?us-ascii?Q?OOc1ME2IQZsu4RHDhBJFDxB8TKESuaB4NQpXcTAvzK7sz08UnDYRsyiUOQnx?=
 =?us-ascii?Q?spcsp22LNwPtuBQcM3tBCuTJaHXbyoFUsZqKE4sJjga8/Q4pUeJ/xw2DBUP6?=
 =?us-ascii?Q?THIefeMM8zhPVSZUXn0zazMA/icsRwGA/MymxjySvbXPfyzD5Y2M7+s9X35Q?=
 =?us-ascii?Q?mXSGp8Stj30kJkFq9r5rBgTHKJ0u3kf3It3gKcm2QCMW98JvAc6S+eeNX2OK?=
 =?us-ascii?Q?qkoJlB+HI7DPOdk6Mg+IZlfWZ3cO83Sqaqs+e1qgVRYTOq/MAdmpOVcX6+0r?=
 =?us-ascii?Q?4LSD8xvdpojSwncZVcw7RbVuSLmKt6eQ+OyDEJra1WeZkwXnQKJy7EePiJwE?=
 =?us-ascii?Q?o5zogrWpUSgFw2Em1mN6qV3ip8SoOAsoX2y0amhJNYn7mp8AeNVIzzY9rhYq?=
 =?us-ascii?Q?o8EhiiZroiDZsa1wZ1Duy0uODnTHFlvl8IlV9rWpxwiH7UW93wrxdQ4Ezpvk?=
 =?us-ascii?Q?d+nd2s4SIIVwD+xGYQ+p79EL+ygVqqTy9duS3ETyTJFUpKY+aR9A1xw2px31?=
 =?us-ascii?Q?BIPlHG1IP9BNDfILWifEOoTmZ8WKbgz7pRKv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 12:08:39.5823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f87ed55-99be-4a0c-07b4-08dd8c96bcd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6178

Initialize current_be_id to 0 in AMD legacy stack(NO DSP enabled) SoundWire
generic machine driver code to handle the unlikely case when there are no
devices connected to a DAI.

In this case create_sdw_dailink() would return without touching the passed
pointer to current_be_id.

Found by gcc -fanalyzer

Cc: stable@vger.kernel.org
Fixes: 2981d9b0789c4 ("ASoC: amd: acp: add soundwire machine driver for legacy stack")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-legacy-mach.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-sdw-legacy-mach.c b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
index 2020c5cfb3d5..582c68aee6e5 100644
--- a/sound/soc/amd/acp/acp-sdw-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
@@ -272,7 +272,7 @@ static int create_sdw_dailinks(struct snd_soc_card *card,
 
 	/* generate DAI links by each sdw link */
 	while (soc_dais->initialised) {
-		int current_be_id;
+		int current_be_id = 0;
 
 		ret = create_sdw_dailink(card, soc_dais, dai_links,
 					 &current_be_id, codec_conf, sdw_platform_component);
-- 
2.45.2


