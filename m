Return-Path: <stable+bounces-208373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28950D2071A
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 18:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48547300CF0E
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 17:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BE61DD877;
	Wed, 14 Jan 2026 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GqfzxaIi"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9920E2E9EB5;
	Wed, 14 Jan 2026 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410652; cv=fail; b=UqDeWaM2CfPpCAMq/WP5td6sz45yxlWzJocalx2Ttsyc9WtXWRXf0toQRy2fahSH6COLTuoIWGFFwgtZv3hwhe6xAZy2oF/3OO0E2E9Ce3t175PRh/QkH9iM/1+LU4KBVQbZ1tf/Gpf0XE2Wseea7UvcCH+mP+fiZsPmC52iXeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410652; c=relaxed/simple;
	bh=h7PkkyxOKdog8JgRhng+J/7MsdoYaWnayfjt/yVcSEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBe4iN7Bx14aIRHBxloHdHUfuILlFWCdNKkg+M44hFlCyDtLqEdh9TvQPeULkVzt1afKEvN70SYSPRt40SRHaToP6S/Wcf7jR37xXsmEJuSESzY4DOywLBil6ljMTyeuUVL151ek2nqq8YvH50UTf8SNUsMcIrL5OpXVmbi4lYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GqfzxaIi; arc=fail smtp.client-ip=40.107.209.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1D76oyZwIjjT1i5ECn+CToO2Qja0hF/9OrFnSopw4jznJegDn5GossKItLcpUDcvnrdDAR0ctlRc0+we67kZKLDcF+D9pAIk7qi0qRZMQnBo7GoSzqH1tpPtBnr87+jXtOxgjdGaer9VcMQHWQQLzOiC9aEP/GTu+rd6ZHucFl1Jg2Bnv3zJob0E+upii34tdcUuk1VeqWTCmexwsJBV2tA6feA38Z9EcAzGONQSGW66q1Te3VybqyBoV7aGibdU+uH5N7v3W2I2z1DhCMpopVGZIfENH5frmLTFsTnbvenBuG+yeByeYPwBfrM44cGNkMca5e59Zwv+TEiOeqHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aM/LziR/MOUWagErEGlU6MilNCBiZcJdHoA92XdBDRI=;
 b=BCzQo6m59pyBUZSMlNnBIBnw921up1aPKo/g1fzZ4/w9FUl7Eet4xfTjk8YaQBGMvyE294IR7jSFNk/uJ2f8cIBkZwemChZU73k9JL1kYpL5E8mE3U6I7L27Shm8Gg0KOE3XH/tQLoXJPeuYKJtVTdgUO8yP+CTvGNG8pw8hshChB7LCebtQ8s3wPr8NrdiEBQVx7zijb8cb1m0/gRSSzQnuV3h4Pt5YqcBE9vuoRklEI6srJL7P9O85u5vowjRpiIDeVgMan3zhedr71jNlqc+4waEXns5NaICTqfkfyYTy2Kc5PUjTXqEbhzkaoacjbaIPG9Vd0sZtB5v5WeA6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM/LziR/MOUWagErEGlU6MilNCBiZcJdHoA92XdBDRI=;
 b=GqfzxaIigerbsDYAFCkQ9z28NTD5ug0BfyN4N3hhu8m4zQ6C26XkugGZHJgW3tiocLiSingMU5ab4NQ9C1h7p61YaQfndzYOVm261iB0lCB5aPQeqhghU911bKmY71WDnZ5o80W3lMoUDvcKMF71YG/2Ktim+4jLcgPOHOCYVi8=
Received: from CY8PR12CA0002.namprd12.prod.outlook.com (2603:10b6:930:4e::26)
 by CY8PR10MB7121.namprd10.prod.outlook.com (2603:10b6:930:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 17:10:43 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:4e:cafe::c4) by CY8PR12CA0002.outlook.office365.com
 (2603:10b6:930:4e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 17:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 17:10:43 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 11:10:43 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 11:10:43 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 14 Jan 2026 11:10:43 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60EHAhPS134096;
	Wed, 14 Jan 2026 11:10:43 -0600
From: Nishanth Menon <nm@ti.com>
To: <ssantosh@kernel.org>, Wentao Liang <vulab@iscas.ac.cn>
CC: Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3] soc: ti: pruss: fix double free in pruss_clk_mux_setup()
Date: Wed, 14 Jan 2026 11:10:41 -0600
Message-ID: <176841062848.1986261.4427039972750135925.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260113014716.2464741-1-vulab@iscas.ac.cn>
References: <20260113014716.2464741-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|CY8PR10MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 2580b339-9cdb-42fd-6b13-08de538fda1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|34020700016|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TU1lMTVpNkwwOFRDd1h3S1NQaXIydWpVdUVtQ2MvZ3VQWGtqZTQ1ZGYzSXZF?=
 =?utf-8?B?dnp3WGpLb1BHV2U0eWc2N25uZ2xEY0Y0MWtVNU1JbkQrL2cvWEwvNStMWkJT?=
 =?utf-8?B?UkNmS3RIU3FiOTJodjVSQzhYVFRJcklWYkluYUlDQ1llNWVRQ0lvTm4xZFU4?=
 =?utf-8?B?WWRhVS9kdDcycGhmNTd0NnhOK1JvY1lGQ1h0MlFISE9xYmc4ZCtKMk1LTWRQ?=
 =?utf-8?B?UzhvMEtVQzI4VjdzUDliTWYySG1uM1lHVS9ydzRUNWV2QytsVUt3aFhUNHBN?=
 =?utf-8?B?SjRUTzR0TFg3Ty8wckxFbGNBVm5lZVMxcXoybkFuTW9QZHZmT0FLeVNhbmFx?=
 =?utf-8?B?YitXR2VaL0djRjczWHdwUDcwaG1GaDdSRWtueVNYUmkvUVJMdk5uNXZBYWtr?=
 =?utf-8?B?RnhDOGgvcW45cDVxc1FQMGxpdThyVFZjd0lVM0VuTS9GRUNFOHhsUUxDRk93?=
 =?utf-8?B?bkdCWVg5eCthU3pIaDJwSnk3RG5GYnFRb2xvVE4zQ0hiZHNYRE8vdnVTTmJQ?=
 =?utf-8?B?VkZyUVcvNkpnVFFsTjRWVWV0ZFVuaVZ6Y0QvbDRhZEtsT05pYXU3VGJkbCts?=
 =?utf-8?B?akdTMmpqTnBLdzFRTkNXQlNIeVVUWXhwVkQyYTJFeGtpNWx3WFdVU3hxK2Vh?=
 =?utf-8?B?TThjcDRCUFV5WEdneXRoTmFXMFpPaGVDc2IvTTJaSFFEQ2JVNFg0Rkx4WVZS?=
 =?utf-8?B?dXNyNmhpVVJNdFBkMU1MRkdka2JVZTU3ZUs4VXVWUXhXY2FCazJjd283c0hX?=
 =?utf-8?B?L0VpYzhRV1hxczRhc2dMNXZiWmpzYmxORXRremlWVkg2SSszeHhpZEJTZ3d5?=
 =?utf-8?B?UzYxS1FVQ1lRbWNEQmF5OWdmdGpRUEFUVSt3Q2RTS2ZMdTJFWk94cHdiVC90?=
 =?utf-8?B?eUk3czBuLzFvdUZkOG5JSkJub2VXNVVML2kzNUhQQWJPa0xkN043L2FDakRU?=
 =?utf-8?B?U254U09tMHRhTXNuejkwL0phbkh6ZW9PM3VrV2gzZ1ZUaG5FTDRwMHlnSXFL?=
 =?utf-8?B?dzlXVFJOOGd0UE9TeGhwdEtOUE9lMVovMHcvWUp2OCtVTGxqdE15U2JPbjBI?=
 =?utf-8?B?Umo0OFRWSEhlOEhOc3phc2pacDllNTIrcDFiUWNjZDJMem1wRXVLUVMxZEpC?=
 =?utf-8?B?YzY5ZDk3MDdzclppQ3VvT2M3MWVaMUk1U0RSa0lSV1lTTnhkbWJjZ2NKbHZy?=
 =?utf-8?B?NHZ3MTJmMG1SbElWUmZVelFKUklWQ1prOE9HeUhubXVnN0taZ2xsRVIvaWJZ?=
 =?utf-8?B?MVdOQ1RramRyL3hRa3lQajhKQkpOdFM1NmxkUHB3T3JqeUFZTTF3aFkyMFlK?=
 =?utf-8?B?SE9OMDdHMWZGT1RibGlXellyQk55bWpxa0tqMU9mTjhDQlFFdWxDV2U3MVBn?=
 =?utf-8?B?dk4yeXBZQVBlcVVBZ202cHN2THVhUHdyUityWXVEbkZ3TzhHb2U4N0FWbjJx?=
 =?utf-8?B?SE41RHR2SG5GaldSUm9zdUk2REJ3MWI5UlJROGxQUUh1MERkbWFtN1h2Nzlz?=
 =?utf-8?B?c3U1dVFJZ3Y3aUhnVS9vbjhYb0lUQm1DK05QOHJDZVBXNW1RR3NFSHdhS3VF?=
 =?utf-8?B?aE12eE53dHMyTkJJZ3QrVXczVFcrU2tqL042WnVTUmdaYnd4dTFqcGpQcXZN?=
 =?utf-8?B?VXZvR0k4SklZYW9RWWpxZjNNQ0JXNVl4UFZXYzM5L3dKaDd1NWl5NDFvRFZX?=
 =?utf-8?B?eVMyenpzajhmbmlIRTd6SjNrY3FqNThoZTI2R0ZuSXorWU13Z1hJQlNxYk1i?=
 =?utf-8?B?R0F2TEV5NkdRV1RuNUllR2oyWGU1aGM5ZkQ5aXRYbXdDRElBQllwbzNFMkxH?=
 =?utf-8?B?MEozOGg5MTNqN0xQMGNTNXZDQ1hMMjZ4VHdBcHZjbkkzR29NdGxnbzNMRXB3?=
 =?utf-8?B?aU5GckZCWWdJRUQ0bHcyVHo1V3haSjVCeDRENFFEZVVxK2ZYVWhobW1nU1Jn?=
 =?utf-8?B?U0dvaXdFUGUvNldtSjdsZlJxMXJ6S0h0b0doanlKM01hSVFFZUM3WXFCRXBR?=
 =?utf-8?B?NTNUakR6RVZXZjJIZVN1Z0lSVkFweWhFc0JSdSs0cVRqU3VTOVV0TkEzQkRx?=
 =?utf-8?B?eUhUSlZab21WUTNXdzNDeFZCZm12S0swRk4rdURZUCtYZUNjRUcyQitPWjA3?=
 =?utf-8?B?anJoU200RlhOdnhabGlxNStMZ0E0bFd1MzBpV28wUTJFZG1RWlgzQjJRSDZx?=
 =?utf-8?B?alkrczhocCtrUll4YmwySzFtcC9RQnF5RFJnckVkUWhPYWcwQmc1NDN2U3Q1?=
 =?utf-8?Q?BxSj3dKHViRWdLr4zr8C3SoQGB4Pnc310AwTC+VHsg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(34020700016)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:10:43.7190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2580b339-9cdb-42fd-6b13-08de538fda1f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7121

Hi Wentao Liang,

On Tue, 13 Jan 2026 01:47:16 +0000, Wentao Liang wrote:
> In the pruss_clk_mux_setup(), the devm_add_action_or_reset() indirectly
> calls pruss_of_free_clk_provider(), which calls of_node_put(clk_mux_np)
> on the error path. However, after the devm_add_action_or_reset()
> returns, the of_node_put(clk_mux_np) is called again, causing a double
> free.
> 
> Fix by returning directly, to avoid the duplicate of_node_put().
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: pruss: fix double free in pruss_clk_mux_setup()
      commit: 80db65d4acfb9ff12d00172aed39ea8b98261aad

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource


