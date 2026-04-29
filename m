Return-Path: <stable+bounces-241816-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cH9YJlGK8WkohwEAu9opvQ
	(envelope-from <stable+bounces-241816-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 06:34:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 324F848F37A
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 06:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE465304480D
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 04:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1A836F417;
	Wed, 29 Apr 2026 04:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="noueqMT9"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1D42AD0C;
	Wed, 29 Apr 2026 04:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777437254; cv=fail; b=aovM6QK8X0xbdIRNyE2KQgcvz/V+266rZ/sRXFLRuJisTLPIkSV68w0b2x/ls67MoCY2TRmVw+/CPL/d07HxgbnaCO+LVWfqfIGHubffcKjC1W0YNmV5eqx6A2Da5/WGckvqRCsMcyDE4aMM31hw6yEl7pJ+hfKAgAiY4VYvA+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777437254; c=relaxed/simple;
	bh=KfTqWyaggYxaSXO8aXiX/pEbLDd4XAPbiZ83zf4fHXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EqrOX+D+C0Dh8QgRSsYBr0NhLzQY86LX/+FznTGxMTX/v/JGfir0GM/PDQOcPWxjuqcvk2MbA5w2jFR1Mt/M/IrZsGZ4qONYs9O4LSZc2vJuvKqa1fiGsLAn9aRqs2BPP1GrV5z0F6UF+ODA9oH5gcZ4itbmH/NGztRO90Dk5Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=noueqMT9; arc=fail smtp.client-ip=52.101.43.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKrKevH+EtyMelljyYoFzk47psTMuf3fxbI+HaRkdhvcAaNIIpIOB+s5hF1P+bZtmg/M1ZYkovCsbSCBu5GzXEdB6dJ4eTpVuq6SAwySOGh5PKf8guisPEI1smffaogIWqY4s9x3qwxvy5QeE98l4OcFnq9hUKkquM5z0aRzWp06skTktBI4vjbQHyfyixUezUG6KFjZQgk1RPGMqlf3+dIe78gABeu6c73HAXm8xsZXVeVtZL2/APkR0fvKsf7PGTcMbDZqW9F2tOURcB7Rz/lftb2y9HX4WzgQ4UscMubIJfMm7hl5e+Fj7TCohECaavtQ7tP5MtpOg/IMje2i7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IY+u3f1fDqQPle01cBWyGkYBl0QGzDm2Kd0ogLXs2uk=;
 b=YBa8HLffpi8nsQ0j7GXV74RTLMlkxmS5+GwZt5G7c2LNsr7rOiQNr/vVmCcEeO9eNRLHZUcLmKior6inZ15awcRZVr92rJGbmHdx/rQ7NJC+O20IGS+RkPlBoc0ToOqYUWO4G6XhCW1C83w73MPXu6ftetPpDVMAh7ayvZ8MhcR7WYBf1/P18JAMGMJ46Pf7HPgsJCuRMik2PWVkbs6d180iflWrBaJlVA9ZL4Z84QefgmVHEzMYVKaw+RGZGV8MiRKgovH9gsi8WsptwyLpxOJ5Yjexl87qxBNPA+vYN7ijaiFpYcQIHUGILWoIf6QcXlVFTCY20nmcgIK76u4dHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IY+u3f1fDqQPle01cBWyGkYBl0QGzDm2Kd0ogLXs2uk=;
 b=noueqMT9+I1NjzHz/S8Mb0RjvlJYqc3q+H6cyuugokZsPgovw4NOLXX9H11zHMTLc2m6mLuAEhnFHv1OxTpfXuLqo8G4A7J7LYp7s3lYv7VW5lRUN5BJnI0xMlKm0gxizcNxUNwDT8fwk14Pjt964i+pnKP9DXWDRHHh3KZwVCo=
Received: from SA1P222CA0082.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::29)
 by SJ0PR10MB5892.namprd10.prod.outlook.com (2603:10b6:a03:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 04:34:10 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:35e:cafe::a) by SA1P222CA0082.outlook.office365.com
 (2603:10b6:806:35e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 04:34:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 04:34:10 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 23:34:00 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 23:34:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Apr 2026 23:34:00 -0500
Received: from [172.24.233.103] (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63T4XtD22593536;
	Tue, 28 Apr 2026 23:33:56 -0500
Message-ID: <1fb0739e-b84f-42f1-9c96-88b5cc5866a8@ti.com>
Date: Wed, 29 Apr 2026 10:03:55 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] pmdomain: ti_sci: re-sync TIFS with genpd on resume
To: Vitor Soares <ivitro@gmail.com>, Nishanth Menon <nm@ti.com>, Tero Kristo
	<kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Ulf Hansson
	<ulfh@kernel.org>
CC: Vitor Soares <vitor.soares@toradex.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, Kevin Hilman <khilman@baylibre.com>,
	<vishalm@ti.com>, <sebin.francis@ti.com>, <d-gole@ti.com>, Devarsh Thakkar
	<devarsht@ti.com>, <stable@vger.kernel.org>
References: <20260427074808.3244226-2-ivitro@gmail.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20260427074808.3244226-2-ivitro@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|SJ0PR10MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2d188b-2548-48e4-4f8a-08dea5a88f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XdmNYrxRb9RPT0sPIGYQ09FBHGwiIU6QwJC7fQ68ZhKotgZ5OdZCAHiYikbV7bTrIAdajOrT8Lc0pdUVJ9YukSgW3MW+pFkLXrmDqsi6QjdF73ocWWKexD7ftzr+9UiJ7bFcj12A1tuTbbX6WbJb54+rVWsMWhNZ5/KEvG9Fov8bKK3SaErVs4dXKdxwyIOKiSKmMMvN37lOaNAJpMN12CtBgXMSwfSh53eGv4WVZ2K3h5RX1XYTaxvA/Z6JGV7Naxc0r7U/6M2NNzul5LEhMB4TGCYH2oIwV37lIuTAjYnUWgtuWWj6l5P01FB4KGBhLJLcZxAIromwW1lsvlVMR2z5YrJ6YuQnHHWhGf6aBNMb9HZtw2UUcy448frzAi9V1jNf8DTukXri/lFjklJ31eFyBfTY7oENqgwqiY0XOi+11NliD6owP8fF0AqW3vQ4JDDT1Qun5GJSL6Bl1R6ltWP1yIcMjU22161I6CoA0lTEDrFGVfWwN+THJ+JntCfGgQUJlX/R0Oh4i7M+w4fXNjLpsSSI5PUti/IV0eRI+K3abj0RBfE8nLkzPvkDWlGhkfH1R/HDIV4eVD2LpV5qZrFgSTR6cbXphJn4ThzvW/4MalXtJfQVDPfKxLUjh11zGP9IJ63O8BoOa3W8j5XhPXLydn9Xkz1ra6tZ2NA8r5aZ22yIYJxIs089rGVTIHYNxRAg2jYWEwYCzxNBTWopjUQGNSGwHU8NgMK0MSjB30cbcxe1WNB14DzS/dow9wW/olPrWn+kpZ3CzWq3Qs5AbA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qYrEgTddHZC/QA+BrhgIxUGms0jaDK9lOJlRzOKPkQyL464aIj6ra0xEBAh9Fy4zFoTcTgDA7AIvSVje3fsTsu0chTfDP3xS/PXi93m+tzf/SuSiPxkUpBksGUZqoC3zzpnufs+AJgNl3cRcVGbnC6tyjv858cl3mgjhQZBLELJF7kzVscPF50KN5VP3OxAUiaAc/jPn8ytl0dDePeUxF8/J/E7Y6PLMBrLxx8I5e3D6Vvmfl7bTzhcw/AJdr1HDoSzp9KoVV7f6CPzAguiAXqIAO7cgWdwnVVISor+0P/RY7aX+8niDtUe36mAb6rf0bX0XBBJ3b+ucXyop06VGqGvufzV/PHde/7E0O3GZF5PYJQFWIV3Rc9rF2B85hhOGzhw1Y9ZLGOqdVE0vgQROei6MCnhikOv7q2sV25lAsE5tm+vJBayz1CCne5bZ0Ce2
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 04:34:10.6266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2d188b-2548-48e4-4f8a-08dea5a88f17
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5892
X-Rspamd-Queue-Id: 324F848F37A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-241816-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ti.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:url,ti.com:dkim,ti.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vigneshr@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

Hi Vitor

On 27/04/26 13:18, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> When a device in a TI SCI power domain is on the wakeup path of a
> wakeup-capable child, the suspend path skips genpd_sync_power_off().
> No put_device is sent to TIFS and the domain's genpd status remains
> ON.

Correction of terminologies: TIFS is Root of trust component and is not
usually involved in power management, that would be DM (Device Manager)

But to be really sure who is doing what, Could you provide an example
and the platform on which you see the issue / external abort?


> 
> TIFS powers off the hardware during deep sleep regardless, since it
> was never informed to keep the domain active. On resume, because the
> domain's genpd status is ON, no get_device is issued. The driver
> then accesses registers of a powered-off domain, causing a
> synchronous external abort (AXI bus error, ESR 0x96000010).

Hmm, if something is wakeup source, I would expect even TIFS/DM not to
turn if off, else module wakeup wouldn't work.

> 
> Commit 0b5fe1c4ab3c ("pmdomain: ti-sci: Set PD on/off state according
> to the HW state") exposed this. Before, domain status was initialized
> to OFF, so get_device was always issued on resume.
> 
> Add a .resume hook that queries the domain's state from TIFS and
> re-syncs TIFS with get_device when genpd has it ON but TIFS has it
> OFF. The hook is only registered when the is_on op is available,
> since detection depends on it.
> 
> Move ti_sci_pm_pd_is_on() earlier in the file so it is available to
> the resume hook.
> 
> Fixes: 0b5fe1c4ab3c ("pmdomain: ti-sci: Set PD on/off state according to the HW state")
> Cc: stable@vger.kernel.org # 6.18+
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---

[...]

-- 
Regards
Vignesh
https://ti.com/opensource


