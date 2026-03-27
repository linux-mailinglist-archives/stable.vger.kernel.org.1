Return-Path: <stable+bounces-230586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOBsEW4KxmlxFgUAu9opvQ
	(envelope-from <stable+bounces-230586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 05:41:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A759D33F24D
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 05:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A08C3035D2F
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 04:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE66732720D;
	Fri, 27 Mar 2026 04:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Dxx7wWdh"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E99BA21;
	Fri, 27 Mar 2026 04:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774586471; cv=fail; b=lY2Ux8PnGj4Ynvkjq+6KBaCu6s5Zom4xF99uVN12q/yFN6hPbDmU1RNkdiGKx6VcWqgLm1pqrqCgA5p1ebLF0z8SFxWD6sSE4w5jJSvpuxZ8Pb3AAITVABronmTrlWMn54VJNq7a4+T07pCDEVfqRlwIA93jEbe7NMvmpVGPnKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774586471; c=relaxed/simple;
	bh=c3rOAVJ5PQHAUWCPCjH1T8w0nxX9wHjK/kyOgxGHhf0=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=qF+ur7ydV51Q4n3KYOPWOvpdUafhDWUDChNseujxD7mtec3oz78PrgqXZuBaYfn9F7m4oXBk1tsqLncH0mQQARLaVHmNc+tVjfsaVY20uBJkce+TYidCb2ypj51uxHQPKBpPE/gBv/oNVksDc1utW+gpC9i9FjaULOYCDPoKdRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Dxx7wWdh; arc=fail smtp.client-ip=52.101.46.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7I/c53qN+khBX4Er/sNef6LfnVZkqxojZnxVug7qE6TxiveubPeZanQKNSg0b3aUjcHdcRBJaT1jXViv3uQ0pzTah2pDvyZaqm5fOBqzDv+1HARZmkoIObRvP7wLsBG8L/c/LbE7bpvbZXPGh48Jy3GH4Y2U4Z8hQ+KQJqMVtnEMKpk+kl9Nka5k8wuV8hPvD/hhOQ/co32kQNuN7xx/yoOaxJLAWHWVk2evdnFelcyc1q8VQOh9Z5WTEkpaEJFcv3FuJKGGJTzft6Y2OD6IKdiblk+P01cbQvjz/U6NKqaSdabuJ17BhGSCV2BDEiHoM6czYvI9tCfBgWU7vyM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnx8T/WUpPfJEfdCVpoJvz5/IxsubaQ8d1+YrUR+aag=;
 b=o1MpyDvTmHd6k9KT3aISRWzBgmdfQlEdsfe25Xrv2+6YzwTx1vWqMvc/pmjJfkN1QyCXu4hzJFEKBu1R0YD3+Apivrjomhbc2kZAJzP1iPGLFtv+UHUuwhbKZhwldef/IM1dQ072v+wMwIAxNCRW0RJUwh5QvjlzcuzvNI0fJaaUKH95bzt3+zUoAhbr0V2a2xkohUdfgZaCKtGpzD1gMb4+Pdjl8OcYwGHsshFLtJf98Wfu0m1852JHCSej/KbsvA6k4VmZ9W6QcxR0HtW4OvGSepwG0cMNi0GxGS72gF7olQtRjCvzzQcr5QtMcV2WeyujXkkBjNvrZXcZ2GJIqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnx8T/WUpPfJEfdCVpoJvz5/IxsubaQ8d1+YrUR+aag=;
 b=Dxx7wWdhay8XZeSziLg7EjSfGYscTiSXjC+Bq6s0R1xGdvO4itIL63ScLS9xHHH1f9puz0zQuNEgSqnMUjWGRQ0j+0pDzOItN4iG9FXfnQY1zOmP+OthZBosGfjVseq94dGMPNjedzwQ04BbWbEZWd7hNoQuCSI2ZSV34Vg9BO4=
Received: from BLAPR05CA0031.namprd05.prod.outlook.com (2603:10b6:208:335::12)
 by SA1PR10MB5736.namprd10.prod.outlook.com (2603:10b6:806:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 04:41:07 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::d7) by BLAPR05CA0031.outlook.office365.com
 (2603:10b6:208:335::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 04:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 27 Mar 2026 04:41:04 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 23:41:01 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 23:41:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 23:41:00 -0500
Received: from [127.0.1.1] (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62R4evKx2868631;
	Thu, 26 Mar 2026 23:40:58 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Francesco Dolcini <francesco@dolcini.it>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Judith Mendez <jm@ti.com>,
	<stable@vger.kernel.org>
In-Reply-To: <20260320073032.10427-1-francesco@dolcini.it>
References: <20260320073032.10427-1-francesco@dolcini.it>
Subject: Re: [PATCH v1] arm64: dts: ti: am62-verdin: Enable pullup for eMMC
 data pins
Message-ID: <177458644615.423823.12334575193190360698.b4-ty@b4>
Date: Fri, 27 Mar 2026 10:10:46 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1216; i=vigneshr@ti.com;
 h=from:subject:message-id; bh=c3rOAVJ5PQHAUWCPCjH1T8w0nxX9wHjK/kyOgxGHhf0=;
 b=owGbwMvMwCHG7GTPG/5e9jrjabUkhsxjXJEPlNMVD3Ody9S8tXrOhAncYUXPxXfIymfeYi7SY
 9noJ/eto5SFQYyDQVZMkSWAbdcsqxSLxxEViVth5rAygQxh4OIUgInMZWH4xbzMTqpr98JnUp92
 Ll8gtO0DJ0/5YXE3y5wPEx5zloXlPWT4K71fZbmdxgye6uvtOSqOr0wM7V35DC+JXp3ZtvKTq9B
 sHgA=
X-Developer-Key: i=vigneshr@ti.com; a=openpgp;
 fpr=4A5A711E8E7E44F9F12F2CFAF903332F551A78E9
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|SA1PR10MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: b631829e-4482-4161-f17a-08de8bbb0e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OhYt6QPodYix7gLdp2BT4n2VEDkNLp3qquDiWWPWH4U8OI7KALKr2hYWUxBoSdej6zzMfGzeIFWJodyyYnehOu4sxJ6A0yGswha1vRbYA/5GyTvr881rNabApzX8BT5kM2jxIfMct5Qyi9aki9QnM50id8UIllyqh/cLpYDXl3HGKmcsV5cDKcXIcIH73n1VdC1wtZJF6EtFmIFTH4SdFVmNsZp2h8fuUURAJIe9YphH9EZyZzsYlwDKJQvCn0nwpvqTB8Z1+A+MYLGRqfKH5xkWfXYO1tKa7p4f/KOWYOj3yQ5Xu5dQri7+KDMvg9Z4Qc0NtMHmiZGfdavyiX3FLU0YfgKBmwbF9HC0jE8byXQ3HoNYIGbnYJjSv9G99zymyVZcrC2HHBlE29ajTtO5BIjZbPBaHD81YxYN4Y9z1jOzVYzFXjiuj6Y4wE9Q4I/L2PmMEXzM+dQrkTiFtm9e82A6f+PMVw3bWBBAyLI8ZvBeI1IS19/GgUTnDXsTuTkwaO0na8zszJRrZIpig6BiL0SKZ1oVybeUgJ+cIePFbV80+aSkdSLoi69W0b3b0p/olOtxScr6SDyq9f37lntIhCzQTvyJhbOiLsln535JA7nhsF8Ye2FSETnKxigpwrV6WHF3M7cpugm8sqCd/kJvZh1Vc4Qo7u8Qa4l3CiH0bb78hL9Bx5kTBH19xArFGewv+Sx+8Zfr0Ui6JYGJpA1yMPqpjzPLUDfY0j+N55cgzuUb+QPp+3lkwBKrGNqgxlRKOjwZjpsFXid6HapNoM90JA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wmYQr6Z6C4kv4LNL6fnrcJLzaPUsmevwNj1RW1Nv5HTx1d7/HMgQM+yjCCe+DrHQF5LWodp69Pl0mgKPp2L/KrIegIIkdf6ZtI/5rMht8emZxAaTKU9EpeQEq37rqdqHq/eyoQfPfNwwZiH0Pm3zq05ZJvGjZVTjtyr5yf8KAzY5Jc/eKpWtQCRBVeu9TEwKMzcayYi4uf3sb/Uo6mooczUHYJojKc4fGX1jNI7goPC8+CdAYysF32wvUDc6XLpXgCWewq2hwOukk+KgngCbPQ740uFoJWWVYyizEwsymy0NC6Ie7eHSqSjP2s9sbrbIoIlHJDlHEFhFR4eChbweqPBgSmVwzWSsqyEIKIJ22PDR8p+Z4SDM5hT+/rEz7qOPzbAp47hMIfgacjd92dM6untr0OIG/xgh5JvAqVLBLnjZiGVaZe8nvdOlnlDEd0x/
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 04:41:04.9660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b631829e-4482-4161-f17a-08de8bbb0e74
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5736
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230586-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vigneshr@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A759D33F24D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Francesco Dolcini,

On Fri, 20 Mar 2026 08:30:30 +0100, Francesco Dolcini wrote:
> arm64: dts: ti: am62-verdin: Enable pullup for eMMC data pins

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: am62-verdin: Enable pullup for eMMC data pins
      commit: d5325810814ee995debfa0b6c4a22e0391598bef

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
Vignesh



