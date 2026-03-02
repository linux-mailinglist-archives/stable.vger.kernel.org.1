Return-Path: <stable+bounces-222589-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMzNG0iNpWmoDgYAu9opvQ
	(envelope-from <stable+bounces-222589-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 14:14:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 806051D9957
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 14:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A71130131B0
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 13:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125AD3E0C71;
	Mon,  2 Mar 2026 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MTOfFaXb"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010019.outbound.protection.outlook.com [52.101.193.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45A93E0C61;
	Mon,  2 Mar 2026 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457245; cv=fail; b=iTJFzvLHdO/+5VXbK/8U4nTh4bsNuvWJk4sudEh3LD8I1RQf1UAhHBRO9J1kOwZ9NVLD7txfqdXmimKiiaUoQ+z9Kv5oA8E2Wl/Cp6SLlvjz/DFQYX2lRqKD36Pyn32wEvwCbncXpw107X5556F730iWhqQOsIY1a2Tpo7J4w2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457245; c=relaxed/simple;
	bh=+pSczLSrsMPH7uC+u9rdwxYDOL8JOdrqDoIMx+miKhQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=XEE9kM5qXeVdFd4fUqmi8bkY0Xk+HiHpmmCPn3TsoC7pFi1M1WZiBbd5yvtB7CL7dboND/QY9Cb+CseyRlIuEks6mVcwMMfyJZxOu4ARLMHOLPEnwU2EaJdrERAw2bF88jwUmYVSB0qqZBTHSlYTm/g/mn5RMNw9BQU3g2BLnRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MTOfFaXb; arc=fail smtp.client-ip=52.101.193.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tz9vnTR/aMaCnB8zRgRBydkEEnQCngfxGqGTV7wpChQLi1fFowHhqT15Sf16hPQDkXocyDEnxjqOMDI0yQ2m+dmeHMIrgS/tUgJrZkBlHF3kXMOAHvy/k7iuF3Jy5fZBhMlB5Io6IjKshKGj62CzkB3fxT8DRKdN7+tlU9Bu0q7KbVT+Wwg39tDm3guGyve/BOrIRSWVTWUfQ1sCRiDXWF1ynn0wWXusRjERZi2EuYozub5ZKqQTi6CmRavaCzJSI3owyH/MOHnb/ESFXXHo8WTzIZOEtgJf012ol2g3D+MvDkpP9+jOg38BRTIls6DDhCv+9zAnT/bG/+RI7DlC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lnTd4J4JOwVlASnxL42h3Wwm3FBCZnTrTAVYLXE8L8=;
 b=YhJC6VE4t8HNr5DUsKM1tvfBCwtrBaED43nr1YuxXV3B9valxaM1vZ5FrKwnmZgk0Px1j3I4BnSGudS/2UdInH33ucnYAl4KGpUdqpkHrqanx2pHWNPGXUWM5GbEK/64Xd82mIKhU17PpbTJgGHsl7Low8bjs2VaePKl5I/Lt1rzbnAf1zUnHaftTdXy/BdIjJ7mqw5yGBwO4Q0jZk5jGbC3GlW22y6AZWxfD4bVg9pt/ErDNmAPkcI+C/7ks60ayY8Dcaz7SMXFYlEwhuAmtK7vEntobxZ0uvLD+IV8dSY9O+ttLIMzCamvaoFDMclfpx85xE5uc+WwvrYM+pv0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lnTd4J4JOwVlASnxL42h3Wwm3FBCZnTrTAVYLXE8L8=;
 b=MTOfFaXbuv+yaBx9+tOk6167GcPf5uvsU0WNXlG/JedH6AiH0OZ+49OassjVeY2AiltKkkxtNUK0e9SEPRI6naikj2PSQgUIJV3FS4bpKjdNMrvQ611cK1cv0gj3faDwv9yTpB2Fc5AenMGDCOqjMQMDecKqOz4yfSHsqe1UWo7RKivpDwF2EXnojgd9l2i86wX+lod0cHwURLSvHYqGU74LclQsNgvnovONDrcPCzuafr2J83BpVkZ880kcz6BTDNU80u4ygUu8V6oG1kY3gM6oY3oOgeH7caMGs7CaKJFS43/vhPKL/Ryvv2tDVwxh/gDVvdHxYpTX6APZ2+2yzQ==
Received: from DM6PR10CA0007.namprd10.prod.outlook.com (2603:10b6:5:60::20) by
 MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.20; Mon, 2 Mar 2026 13:13:59 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::2f) by DM6PR10CA0007.outlook.office365.com
 (2603:10b6:5:60::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 13:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 13:13:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 05:13:38 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 05:13:37 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Mar 2026 05:13:37 -0800
From: Jon Hunter <jonathanh@nvidia.com>
To: Sasha Levin <sashal@kernel.org>
CC: Sasha Levin <sashal@kernel.org>, <gregkh@linuxfoundation.org>,
	<patches@lists.linux.dev>, <torvalds@linux-foundation.org>,
	<akpm@linux-foundation.org>, <linux@roeck-us.net>, <shuah@kernel.org>,
	<patches@kernelci.org>, <lkft-triage@lists.linaro.org>, <pavel@nabladev.com>,
	<jonathanh@nvidia.com>, <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
	<rwarsow@gmx.de>, <conor@kernel.org>, <hargar@microsoft.com>,
	<broonie@kernel.org>, <achill@achill.org>, <sr@sladewatkins.com>,
	<linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 5.15 000/164] 5.15.202-rc1 review
In-Reply-To: <20260228181458.1600528-1-sashal@kernel.org>
References: <20260228181458.1600528-1-sashal@kernel.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5f626d00-54f0-4e37-ac42-9777b38feb36@drhqmail203.nvidia.com>
Date: Mon, 2 Mar 2026 05:13:37 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|MW4PR12MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: d005bc48-91c1-48f8-565a-08de785d90c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	ltNaCib7tr+R38Lzn9gAMXOex3GH7n3sR+p5T/e1LU8q2eKL9pzfNxVB0bYEl1YOKs6XmNNBBBewbFQ/vP2rdcv5XAvOEV1IZIz7AgYknKzDcj94wY3DTFLUi5+MoS2ylB2kjj4UpQYH0TjG2NVkGXCCi8SyU0F6uzApaJuHP3BARJIRFZpM4+Ksg7rDHBp98ffZtJJLB38Zk7ycUwW98j8eT6pJcSDBUDTR0aaBtUhZE7QyFx3SjmpM/KDbWoM1ZCtspFrsXElECZUJtU507+e2kFeZ0hXUMDi3plEJ5V4kcrUasL+qJNmxXgZ6T9eoEysnoiMTAUBmIYOoLZ6f1FmZozGYh4EWBgstwKscsFkv2/Dgou6hU23PCU48wgYsQi1hgXOuFN6+rMk4AC2FQRwr2TS4IL0LCAUOrO8QkEnHhwpTcEpLU0AcMIk+c7m+jtOyeCb1KtW725+T274wNcLzw6GyqRqcDr0QsS85qDyu+YctO0CUDfGSvkIQzuSaUjkMRZnqpLKctoOaFvqP6Xr4OU+asIfneqM4+4gx9KRzWBRGO6qxVU7mp/yE4VULA8m6GyYsdK4BOOAvrZTArQ7otltnvHpPRe1Wf/hgi72f93pJHbDQ2N3o1bPZSHnfaLj/J4xVI5w5YiqMzsYOeemfufkHCfPU8eqXQHzg1TnXy/HT+cWsIWX6B/oaUWpcm1AtJd+G03v74OfxHLyvJE1CjvgkWXulRdp2LyCUnXkxTbazRQ12+dtGRN8qAEHGuRZiwM8tK5t07YPLSRTWGuVVmt8tyQVRwSGIAAaL41Rwpau5yfT5/kcLTSBQJT/coZ/z4dg5GPuKRaUC3y2hFQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YofsbMQvf7QNgoKjRfx3Kio2FojImpSj87WOxzPhibVHUnkg/JYXHYAcb0wP8+1X/Z2LuQ8XeK434gc446UvlN6E/50HISLkduxBaPYV0bDM/8DqvQFPCMD4HP4bAdgYyZ4Zf+3Et4n+IVM9tp6vNGqOPN/H+Qyzl+e4o9lVY/I3Ul1uMN7xxTYerkdpwnOfFpWOskljJT+Ogy8YiX+a1ZRMBazNEeAMpYtGM8+Q1qdSKKakADCUAfzUci8pLhsAyy+EoGObnezuLn+4c4dPE6iS1R4xibFifrG70+Hr64HiO8qdh/ZjsNoivoKvH1w3D3N/M6WG6tsZ2woE3YPD3vyf3s9RPws6uQ5LI3zP6Ju+SZ4wiIDCxf3TF8v4Owk1uvh6r/Ze8u/N6uF3dh9/M1GohhGhssGt4QvtVf9QGUbYIM+UC0dm/Uqmikq12twU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:13:58.7787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d005bc48-91c1-48f8-565a-08de785d90c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6921
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222589-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 806051D9957
X-Rspamd-Action: no action

On Sat, 28 Feb 2026 13:14:58 -0500, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.15.202 release.
> There are 164 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Mar  2 06:14:56 PM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.201
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

All tests passing for Tegra ...

Test results for stable-v5.15:
    10 builds:	10 pass, 0 fail
    28 boots:	28 pass, 0 fail
    118 tests:	118 pass, 0 fail

Linux version:	5.15.202-rc1-g787042c7f0a1
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

