Return-Path: <stable+bounces-141805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2AFAAC36B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 14:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF8F3B7DD8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 12:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5CB27F19E;
	Tue,  6 May 2025 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AnlQGKiu"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F54927F190;
	Tue,  6 May 2025 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746533336; cv=fail; b=EBMLMrC4IDcm2hoEm5S6mWV/5cW8j7YF1QSZiDbUgyjMDc9z17/EnTnNh4oe8FOPQWjIDQ+hxSr4q2x9XvOyxb0iuZdP4C30cg44JoNykcEqkj866qpAQHK4jDjcZllZac5Px3Q1IzGDZHgfJEUVtW6KBxiPp6lgPc4tNrnMalY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746533336; c=relaxed/simple;
	bh=m2KmdCjkH6IMhlQK/s2s/KdlRQ8ni6CeQvvMSf0sc9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ej4XZbji9tH6n2EAKEybLCQQeFU1iC/VVi6J4tENwwKJl3no1w2tu/sUVwr3pHX9gvcXgU49OKyZeMzgAtLU/v6nr41IZesPRI7sO9UIsUV77PMZKGMPO6Cve9KojzT9YQ4Wk5E4/J4+4c6vIVvLkAasuCX/BR2xqkckIeZZC2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AnlQGKiu; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgg7PThJQgXyS8Ieq3lxT7wqoNrZT/c9wRZi2AHj9wNT6W0YL3UTGTxtP31bEyJp+clVJrxMyzV0qzPT//eUfQrU/KLHRSZ5rnMRUmloDcfpIj6BcAMJjty3Ld5CAaVQh0YaTz3OPkn7B9e6oMcdlC5kC3b3RkRQaPws3ZBwl3AvZEr93pnxVvrM/w+kCLHsaM32+MvOruKbeqBzQcUhzTdMQuZ+YDZm/CpRFde7jhimaqMmGCSpwlxl3eIhzZT7qk3IrXWlD9Z9KDs4j0+pBuFoBiVi6Fo1CrpV6b7HHqPJmnvJO6EehB8rFEWXVX5FkYGos1TToLovexVEF7cu4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XjYgHBg/u3WyCUGO1xH422al5bf5Xs80Ub4kYTv6G4=;
 b=DJk22vQGqavyBec/pv2Nf/mHctZ/ZfPnBaQWLyoMKcj+wOXbQjvkmeeUWENs7PFqy8Iesiy5hCbXbavYU3WeOTOFJ7MfnzDM6ew9OadqC2Tu8gOE/xQ9mXhMQVxEZPUqLA+68OBuRC70WANPAUo4ZKNzc+3Ls3mAVkySCLeAFe+QlIrXvcQWaqVyPJ9QXfua7JpbVga+yytS2POJ8JDLMG3wSQV/ZUBLvYm6831u1HeL9RWMnA1v43OJvMAvo+JjsGvBCD+hB3+HzFoDW2gJNQXZEww9qP2qjGM8654Nu97LLwvsOi5P5Unw5e8wbJCAM5LjsggWW4sQ05KMMRhDDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XjYgHBg/u3WyCUGO1xH422al5bf5Xs80Ub4kYTv6G4=;
 b=AnlQGKiu6KYIAnnHtvWJt4obbQthbC2YdjDEMem0W9vam/xdrqqcf0DWonXFCIBS/yfAzkAdMwtr9CjAKVaQzyCmLzt6BbB3xvgfJ0kYutp5ZEDqS1bTWRf/iEgEOSKaT/Ylf4PnY/lY1WrhWgjmoHh2WGoCFvrhxfb6NSpxJP0=
Received: from MW4PR03CA0352.namprd03.prod.outlook.com (2603:10b6:303:dc::27)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 12:08:44 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::ac) by MW4PR03CA0352.outlook.office365.com
 (2603:10b6:303:dc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Tue,
 6 May 2025 12:08:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 12:08:44 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 07:08:39 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<ranjani.sridharan@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Mario.Limonciello@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/3] ASoC: amd: sof_amd_sdw: Fix unlikely uninitialized variable use in create_sdw_dailinks()
Date: Tue, 6 May 2025 17:37:23 +0530
Message-ID: <20250506120823.3621604-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250506120823.3621604-1-Vijendar.Mukunda@amd.com>
References: <20250506120823.3621604-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbe0afb-570d-408f-8aad-08dd8c96bf92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oj/pctRKr7Wzm3tvEW6kb8MUx7qA7Majv18iV/SWzFjm//Z8US33+DY6m4MQ?=
 =?us-ascii?Q?DgSHrI13SqAIu/OBRw/muRpC1ztyQW/aNkV8cMHWB7e2SbNZCgZ0CFuzFf+w?=
 =?us-ascii?Q?hyrqKVgSWd6qFhDartdjcQjyTFzKPTvzBWqVfPxX0oGjI8IdysYtCo2E49EF?=
 =?us-ascii?Q?+dr8UT9DH5FD8V7trX97fhCOlP0jJOIwRcGgTvD111FrMBk/l9gGDZUbkF66?=
 =?us-ascii?Q?KD917x4firXjtZyXWXEfwleLFCVc7Qh4WJCKz09d/Np1r66h2fQky3IieLaq?=
 =?us-ascii?Q?+AODNHLlgKOLQLxOUcS+Xp5TGXDWZ+vKWzCC1E1xWhOMJCWV94k/olm0N9Ek?=
 =?us-ascii?Q?JnycxAgMft2HUGfXZu2vUhKo7GKB1xf3YV1QKHGGfFsWgvjto9AfqQxNaFJn?=
 =?us-ascii?Q?556DV2k43MGy9S8KCMmPv/f1/uLxBwCuS2qGn7mlSdWs7EmJhDuvQEcgQi4G?=
 =?us-ascii?Q?cnrzHdbAzO1fv8//tudYq84kpSb5DaFqKziwgaw0NwMMIfpMwuYR87fbKiSh?=
 =?us-ascii?Q?jmX8e4tgp/U9RkGBvnvkeajgc6FS8QTPlvx+cERuxmUmlde7pq3fq6OOBToD?=
 =?us-ascii?Q?8cTMBZs5vez9X6Kh2yEGcLxOgn6dK+jAYgbNavitlBL+iIvSgt5YdULT3Lmw?=
 =?us-ascii?Q?4koldGJTrX1OpRIRIQ31gD6ls1FVHoCvC+KmaeQIUFKTX8n7502jk83AMQ9Q?=
 =?us-ascii?Q?ZKNd/RxJHo9aLYNb7RINMk8X/4aWL8S1jYRZkQIPS4Kk/fN/MiCGrMwoWSGX?=
 =?us-ascii?Q?d68PILDv6Q+HfYqzDdEUCbi8MTyso8jVkm8GBS/a37rwKMw6eymlU9u4L+ii?=
 =?us-ascii?Q?kAqFHJ/3JDzwhc5p0Vcdz7dRrv2+bo7n/GXXD1KjDPDT2CT+K3L34cQn4j3F?=
 =?us-ascii?Q?e+QTZNU5jjeYU9bK0TXmZ6mYoHsGA6jlVyYPNiCcWyfTeAPqzem/eQ4QEtjM?=
 =?us-ascii?Q?nnHfhi3eroWg7r/wL2kMAj2KXwpA34vZsrFmxqnOJFYdK4CqNPEb66gXORPz?=
 =?us-ascii?Q?9ugbsmr53YxOC/HpGcfLu+uy/TFiK6CpDZ+EEI6hwD5+bR1cW4medPkQ539P?=
 =?us-ascii?Q?DbXfT3hzHT0htlPNi+0tBThrYdGO11fq82UHKDE0UlpfXgkhwYsP86J9CVdg?=
 =?us-ascii?Q?Dj92gmF22TX65dh9c8W+B8+IyOK45uokx0l9ZvjCgfJSaGjRvYt0mMWfyMs1?=
 =?us-ascii?Q?My1JA1qL2+3rfVZbZm5lSN9iT/GlEurc4jNJqDFydsZjg8MhpvH/kX9ovhlT?=
 =?us-ascii?Q?Zoajoq+cTtJM5wCmfhac0nZzvwTOUsZxOgKaZ0RZvk53CvZKoXtqkL3RhFS0?=
 =?us-ascii?Q?J196vuKfbCstIzfSsv+KNhuP9E9ke8TPSDfl6RqLHQB2BVkvW3c8oODi2nbY?=
 =?us-ascii?Q?un6KZ9EcE2tq/1seU81oBb1utl1zYOk/VOnv+Z8AeEorAQ3l9TlmArZshWQK?=
 =?us-ascii?Q?BEnahd3J+rgL9NCWPkjiHfsXxMFK2pHYsgipJlcdPbserAeRMB8YFSckchWW?=
 =?us-ascii?Q?G73wW+uDJtEC8NhjxVRFrkfqtMlFgSgLvgOz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 12:08:44.2066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbe0afb-570d-408f-8aad-08dd8c96bf92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970

Initialize current_be_id to 0 in SOF based AMD generic SoundWire machine
driver to handle the unlikely case when there are no devices connected to
a DAI.
In this case create_sdw_dailink() would return without touching the passed
pointer to current_be_id.

Found by gcc -fanalyzer

Cc: stable@vger.kernel.org
Fixes: 6d8348ddc56ed ("ASoC: amd: acp: refactor SoundWire machine driver code")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index c09b1f118a6c..75bdd843ca36 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -219,7 +219,7 @@ static int create_sdw_dailinks(struct snd_soc_card *card,
 
 	/* generate DAI links by each sdw link */
 	while (sof_dais->initialised) {
-		int current_be_id;
+		int current_be_id = 0;
 
 		ret = create_sdw_dailink(card, sof_dais, dai_links,
 					 &current_be_id, codec_conf);
-- 
2.45.2


