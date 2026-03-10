Return-Path: <stable+bounces-224509-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iK39FxI3sGkKhQIAu9opvQ
	(envelope-from <stable+bounces-224509-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 16:21:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC452533AB
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 16:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C86E2310ADB9
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 14:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB16129D29D;
	Tue, 10 Mar 2026 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NVm3oziP"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013047.outbound.protection.outlook.com [40.93.196.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD43A2D1907;
	Tue, 10 Mar 2026 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773152594; cv=fail; b=pT1Q0ydaSqiQwd0+ucRMuH54/IrLu5xdyiw9g+dCXoHPZDUK1pczDpjbz45dPxZuZBWHh0pmUKCgTtpq6RM5Y8OQVB0TCzCkUaa19vJmSPr8N+X2M92ND6za4lEJp/INYaNjrKGGlK2h2CxAs7zJfLm0oW1hiISkwLCdvcSTmNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773152594; c=relaxed/simple;
	bh=gfE1vW2RF0FQ420Kdnf9s5aZyCd2wD82rvBfHbJB6tk=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=KrzcoQE0RZRczcSqxtAlU9rjbkhhN/Qx7ALfQ7LOBvcVccH6RiLSqWjA7a0JBRr0piNkOCpU/N3NEuG+adhg6+EN55aneRsi1a9IF5fgzo9qxjXMJ+wWOrLV8cc/XC2Ibae2GAfYp7H9giL/UUAlWE82fvURF8HD40juyikxA3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NVm3oziP; arc=fail smtp.client-ip=40.93.196.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUry/kfhIrkMbbHWGgSmcYgheCHkxtNqoK9jZkeQD/4b94m2DPXphCfYMLzp2ymuJfVyfE687SaskN+f2APa4YXeUxmojMm9SSatf4pyCr9rhgLV59gbnvf5oRE3zguag6X4H1QjaB8grabRHSJURfml1sTMwOc0SXl5OAG4ldFrUaaXcBeJfhNGipQLw57E1+p0GUpsVJx/ythLEec/qqqq9bM5YGsq8hpE1GqQ9MTY3hKHWCRA+oI9wAOPnnPBFwCtYwF8s5UwPd5v/NN8sxGD/eHjDBeY1dZcyaUDQj5/+Xwb+z+HJVGWS90RisdBdVx+U42Jc3auELjMVAnQAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpofAMp216cZas0ixz9e9tuMCaVFM9FMUGuEQLuWS8A=;
 b=N2I9K5VOTOVKq5IEtfyQid35hvNjB68Uh1AIZXf//tP7tr0+8itTJ5v/hs4GgvDUiNjJEuD0vq57DxfHYJJpa+ExNu0R4QrzIso1YNXyXc/sM5TRp/rFl8NehkNEEhDQaZTuT4XsiH6Ym3k7jb2odUCP1jhhC0Pe8eb9E00Z8g7fK7JIuPsLdtOGxbyJ1ALlV0PCMgh9cLEINQyXqx9/WLczYD6y9d1SQ3Ku4eUInUSQdDqFOw+0JTEB4vJL6iy6iUuzUt9r5u+47pmpmtWYIU7DLuVzLRGYZBkhdqMeFA8qIDkDeRAs22b20xzbfncwqoymynhfeVcZ1d/FKPJ8vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpofAMp216cZas0ixz9e9tuMCaVFM9FMUGuEQLuWS8A=;
 b=NVm3oziPFqj9QpPL1D0jegvYM30pHtqdVE74nVzmAPGP/J707ZXc1ze3yJowYuL7SkH3xkJADVJLJ42JnimNNW8JXgQZnPtwKebAISSV/8SU+G+1dBuLSMRWKSSB+KSlBdusdpvmA9qbuSZGBrHaR++dg34KJDyQK5Q1MEaazJ+XHibWzvOVupYHUtKLaCD4I8G+yHLJhqaIhkxfnxLWDxiD7QgrKnW00fV+a5TYBX6VhM+fABImw3LDA/kgXC2DgKDjQJmwFfUCVYIwPM3ToODDkDolNZK1xrVn9nW8v2LI/fREhjpaCbxWyxC0pagb22TM3FtYr0tFlgDvjqIdQA==
Received: from MN2PR18CA0019.namprd18.prod.outlook.com (2603:10b6:208:23c::24)
 by DS7PR12MB5742.namprd12.prod.outlook.com (2603:10b6:8:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 14:23:01 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::8e) by MN2PR18CA0019.outlook.office365.com
 (2603:10b6:208:23c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 14:22:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 14:23:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 07:22:34 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 07:22:34 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 07:22:33 -0700
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
Subject: Re: [PATCH 6.19 000/311] 6.19.7-rc1 review
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <9b6f0707-225f-4ce8-8d3c-b9a88633ce4f@rnnvmail205.nvidia.com>
Date: Tue, 10 Mar 2026 07:22:33 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|DS7PR12MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e5454b-0ce2-48d0-343d-08de7eb088c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|18002099003|22082099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	W2jFXaQikjRigMGFR7TWPgmFEgPT6KcXxbG24t0vXAzfjQfOruOsvw2ipUwK7majNg7KpMvoQ/23FibqCiqNOcwbdMNacfuFraXK6ohrKRgEH6X1yjfbvDF8pvhnwPqiVtZrMiUq822T9W8WtocReQ4Rt08wkUQ5PlQ2QQjJJHrIAOZk/AabJ0muSknvIzPUy4cwQ2nusEDkewYjchwKI07fUwyra5UBveGLyE7nNzMTUIuC4BUuA74rqzN45ZB1diNDUrLcyCBb/xl+qtHf//dLt6ig7rXUiqz9dL1UL8U9Q1ms3QyYnM+VIE5a5jBlx/3D4rEGgWfg0T4TPNn7793Qm6RU3Fz+wzf6e53+xI3aNLuaBWaq9db6XAtWfmL65HCmmCmV1giS9wwUTpI69r25LXWFF4mTU8LSk+/cE5Ua4N2dGB3w+gKs5xV6MpehGZT50iRQAb4NsPjJuGfsDrZsLaNVxFhuhp2wMsiXsToWHvhAHbqVZnl+gEQwM5se9RMMMmhpkH7ooSiRtCMx8eizwxsY184pN6HZfMKmlHroJtkQ7/YPNHOLPduUE8/Qx0WtWhHKducxnvkt9gRlaEWSv/lRKg8oMpZqBcftUGeS/KXurpbePfb+eB7NejdDLzYdl5BgGj6yzfdsiox32z8z4TjZ4qTfJx31Q9vDx6rV/w/U11CJLyaW5l9U61mzwS6xEziwvKwEOalv9Jgzsd72u4ftYZIY2vHaWB4k1YxHSNQum0x88woRdaRDdVh9N4MPj6yWPe/XIjRdWv3dlA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(18002099003)(22082099003)(56012099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jr4r3lFeNcXlsOFeHME4SMJY6e/8QgF1uvAME55kPowu/pcNlFTmGZIRHqhGm8IY/C7P8aKIWbypVjatvy2OG/xWtqx9gE/ycHITyidB9DIocXldPXerA50KWsjumKbg0Je2QcJ7IX5kZ4Pev4WN4hOMk8t0Vdy5/bC9QRiQQoUu1WJMEtd6IzmxWAkRpiHsVGwsE2gjAAgRmOeglzHBeZWx9l3oHVQALaXqE9hbwAumeuJK3Y/KVW3ML5oTYKNnul6IhW/schpIdUCG9Y3lpM5ez0U2MvuuJUZu7bsrOiYCPoGjz1BDt0avcght8FNotKDIBRH/A0sKpJbcnJt16Ak/EHyjIZRrcuR6oQnNdGxreHu3xKknBb0aD5bgC6357BcCU0y6L5PQowPs5eP4VZonwftcGWV7Yaazm/GtVp9DDONKYP83kELYaD6TQybF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 14:23:00.5619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e5454b-0ce2-48d0-343d-08de7eb088c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5742
X-Rspamd-Queue-Id: CBC452533AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224509-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 07:05:54 -0400, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.19.7 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 12 11:04:16 AM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/rawdiff/?id=linux-6.19.y&id2=v6.19.6
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

All tests passing for Tegra ...

Test results for stable-v6.19:
    10 builds:	10 pass, 0 fail
    28 boots:	28 pass, 0 fail
    133 tests:	133 pass, 0 fail

Linux version:	6.19.7-rc1-g2867504d9c53
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

