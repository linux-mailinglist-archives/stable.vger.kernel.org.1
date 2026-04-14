Return-Path: <stable+bounces-237749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ4iK1fz3WmMlQkAu9opvQ
	(envelope-from <stable+bounces-237749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 09:57:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 513763F6CF0
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 09:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63B5C305F823
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 07:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D133876DE;
	Tue, 14 Apr 2026 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YVDnFlX0"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011016.outbound.protection.outlook.com [40.93.194.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6822C386554;
	Tue, 14 Apr 2026 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153270; cv=fail; b=dgQ0arx2QEzZnpsKz+o1DMDvw0BE0yHDErQ8oBbhjnZD9qtrZrSQIlKeDH0LHetx7C00c8imid/qyZPIJYIdgLVw1xsSPBkoCxwk96IXdecYESmxDjws4D8LIAAmLeq9RacclRIEyoRwjhpI3z/HN/TrllK9ARAuihWhsKpWW8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153270; c=relaxed/simple;
	bh=hP4o0dXKoTJ8ZPt02ZK9eQKpPZFcuUa37D1EQUzso3M=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=kx3OlLMMu/64XOnVGhwYnpsnnRvTWXMZGpdWvq9e12JzKphVOdkzu0Ee3p9wSl35YjmodquXdYKibsAo8xNk6oq3qlrRgqgEFvDlXYLAJvdaQZlcFSpe8+lMTMMR+MWHvgEd3d+GIWZotb/c8FYpTLqVtHkNBXm3Zevy0D3BBQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YVDnFlX0; arc=fail smtp.client-ip=40.93.194.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utNR5YutJ7uL+VKjqd0WMsn6HjrvvyXkpYyx1WEuvaPcK85vlaIu5QhhozuWd+jkQdetcvp8lq47onQNHpNDK8iUqx3bWWedYtqRZnPCpCEixdwDfidkcbq0mpoPVAQM2228nMKdn4jNN/eOEwk8FKZ8GteX5vmQQF5FHhC1JybfNHrRMJYbAFYWv/Bxmni8K+jDetEWlYLo3NNVnFozjNWc7Ri0glfa9EspZYeYP5NuJDQD+9RWmli9smC3LXd9BvohFcJnWbWrvq40AAo16WERd5RxJgBJgy1RPplLZX+oWq//NdGjduT0lKi3+cVT3kQ/C8XZXoTqV7EQSdWcfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5B2+4HgPFGrIOl5E2BWfjYCJ3l/5AY64FpLuaem0nM=;
 b=XTXtLY+vxblcBz77jfKrheNtOLM7z5sMXQ8MAjAubCjUoeoVYX+/s2UdcuEUTn/mj5WtHSLb+s2OO3DxyZSgcyeA8qusFscuTXDq/bcE9gVBBTyqzccui/9QeZ3p4a8J25yEJSW0iDgFu+TD/U/DN6vctdiR2SQUmi0RDaZEWdnjAQG+E34FGqFzrKBbriAp32EXl6UfFd5dFHe03MGx+ktxqnQBR+1DyoLlbziYxdJC01U3PTll6XpDMhTGPSKev/NYA+KYSvNxjqEL0eyCZjllhqAMHJgHl3VDFpD1bCzUy9+XPhx07X9yUt6GTvZgvlKY2zcF/HsrFIAohIasqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5B2+4HgPFGrIOl5E2BWfjYCJ3l/5AY64FpLuaem0nM=;
 b=YVDnFlX0kGvd1LMTP/qCC+3ZZpw/XDswYD809RS5UQsLZvzwu5CE/DZ+Ngl2cTYQ51yWELjI+3Cph1vlUGdVArxB9Dq455N0BnvbsxJ8duXgm7bpm9+XkYnvZ53HmUD0/1VDNIWVWpKwpe/7bOHLp+9eQaNTJSWhZ1dPveWdCmOlpkQ17U8pinlQs5V+NHS60AlT8FYa7iyN2n/GWyZ7RwN9dnB9DgNN2PIlrPwTNf8iy4EZyUpUbLDrrJ7LB7y9IyPLTmOkVL7lZtfAv0aDC1sfRztxWETaZOiK4PMOSeTiLmW8/SBzeh4zIJjnvIOdVNUP8kb98oxAY1uLLFbhmQ==
Received: from BLAPR03CA0170.namprd03.prod.outlook.com (2603:10b6:208:32f::17)
 by BN7PPF34483F4BA.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 07:54:21 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::74) by BLAPR03CA0170.outlook.office365.com
 (2603:10b6:208:32f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 07:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 07:54:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Apr
 2026 00:54:03 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Apr
 2026 00:54:03 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Apr 2026 00:54:02 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
	<linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
	<lkft-triage@lists.linaro.org>, <pavel@nabladev.com>, <jonathanh@nvidia.com>,
	<f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <rwarsow@gmx.de>,
	<conor@kernel.org>, <hargar@microsoft.com>, <broonie@kernel.org>,
	<achill@achill.org>, <sr@sladewatkins.com>, <linux-tegra@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 6.12 00/70] 6.12.82-rc1 review
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
References: <20260413155728.181580293@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <b7fb605b-5e0f-49e5-8835-685c4c0893d4@rnnvmail201.nvidia.com>
Date: Tue, 14 Apr 2026 00:54:02 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|BN7PPF34483F4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3bd3c9-11a7-46a0-fff4-08de99fb0a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Y+Lt/Q9VucU81tK4bBPfYx/mEvJnGLeZiH9U9eAZP9sHP/uwm86k7lCYmlI/CZ6qe9mMa9xI0q1tFejaREGD77iiGsTO+yRJ0yHjeppLA9MREDwE28blhHmuZD82ewZno7qqX10duDgcyBkfQ0G9gdbr4GTdPiCa4OzzUqdL64nnBvmev2O/TtuzpxsC9ZR2zclYaAMPjJGBFXX/4gQ88nSWASA3rsYz0lJfkfH2VN64kGn9YLpGwh8TkRvT1ZVRZea/K5nSUKTu7qg/E1Cq0W/M2K9+Vgbw5ODPeIIArAHxKROnKw40aA66u4HSmFt16FyOHizWdGQi+cG4PP96N5M/ZnC22SvsXmooBQoIbgpIEBUkz3yunb/mkKvekOyc6K2j74fyoTpffUxltUEB2o/MId3NXx4lBmfJZR3HNgvwkjznbw+iDOUDNlM/6z3EtSVf6XCf+C/+0odg7ZWFPtgnT/e8XdkEq8+SgOyPei60JvWGO3firZq1v++6j4Ew19bWE4g6GCVm9VhZjHewOPETNCJUWJ3XzNJBntRSRMuXzcrQfUITsoTxgvVTwQ7xyEaomsRcScRGd65AgQYQUyYyRV1p8QSUhdvHk+aisodFOmRhxiUNCNCQNIq1SKfGjEVLRwkgkPjrM07w2KMoSzu3TiCm16EC9skGsgp9Ila3rphlWHM3M1uLvf2dz/YazMxN6H9ieAtNvkaQqb5k+j2ykvfOXf/zxTSjCWBpNEQBxRlXZO6VdGh9yJ5vMbeQJcoczhIY1KXAmLvKcGEMSQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(13003099007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vqIgsNzmUa0nJ2f/dVsxtyHsLEcTP8ezo/ZtBSVxE3jnJ/UNLeQRRIfzeAYWq/DCul7nqdnj+plm8nSRgDkWhXZd9JDNherznA0hqm5MoC1m9gyEoszQq9KqO2xvd5Dl9yqhXfqAcZXBYZEJmbVDzyXjfkzoAlM77DeSUn+cq+eBMP2GSrLD+bOPFYiWr6FwGi0M4vcVqrH9b+B2xBPC+8XWN4hIlahlnxbCTtTxwD9nPiUNEQcWSRTFvxzThdnJl2gp6qv72zoDuFdsERDmItCJu3Qz7vfgxcuRqtU6dvCXMuDFZ83ZhtiPpkdUpKw4dcOsni7AOasQbIul8LBOHFZLhUmvsyeL2Jh3qmouYmHfn5H/yvkkvgXTWQYspOnulLB2EAZsuHVOPY1XP55IXIIg18V3+8gwV3ZXK++L6Mke3eLV0TMsby1pLSWteCm3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 07:54:21.5206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3bd3c9-11a7-46a0-fff4-08de99fb0a02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF34483F4BA
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237749-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rnnvmail201.nvidia.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 513763F6CF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 17:59:55 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.82 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.82-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.12:
    10 builds:	10 pass, 0 fail
    28 boots:	28 pass, 0 fail
    133 tests:	133 pass, 0 fail

Linux version:	6.12.82-rc1-gf4ef43b0a8c4
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra234-p3737-0000+p3701-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

