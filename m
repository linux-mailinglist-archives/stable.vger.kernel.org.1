Return-Path: <stable+bounces-141792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D04AAC186
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 12:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC9617F384
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 10:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55F127815B;
	Tue,  6 May 2025 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iY+OOzg5";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iY+OOzg5"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92C0264A6D;
	Tue,  6 May 2025 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.74
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746527940; cv=fail; b=YlZdTxeY1RkJZopOJMY6kzEjzgBGu2JOQLAFrzdQlSI98YOpA+KG7mcYyZHsqqIHVnFDZy1Xt5yWT3G3oTXVTws9NvhfRCyWAG7z67ztKcFRcoTw3eGN8w2iDZ4xuAyDeM1UtW06OVRvUiCOpmIeoDUJuFMaUStW8UKpr5ubZHk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746527940; c=relaxed/simple;
	bh=CutWzba7rTCqWu8TM6ODdMMWgFyswkd+cO+dnv5RNwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r94qD0mowTGFJzAORhWYeCGU8HAjx/SSJTQxhsj1YX5aTsMmX+/1OZnwknMTLidfOaU1fXjos9jOBoVYtMLHcT/twKGuBcU0Uu4OcPf/irzjEJeyZajUz+ciM8B7PUsnYVMb+qlw58HWsbdZlUFQBPcvKXUkw7TaWOQqN6H6nOE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iY+OOzg5; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iY+OOzg5; arc=fail smtp.client-ip=40.107.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=CeGnKnC61AS7uO4hGwJUAOFmP5vTushzBExvuyn/6hyu4/Q+tjX91Mru8+dwNKI91KJ5v3YbHcZZAlABIjIcXJd02dT84QQEJm4dHpkC7ecKW3Rli61QXYCEaCvnoPbun/WbR24CU2QnBy0vkLAsGMAZXM6BB4JgPLTOoFedeI6oeNlrg6z5i7MK0BfWMeakiCRmSms9sENngu6rAz2ziz+Oayob1vDG9F5KgGuyfTruHGK1oqJ/US9YSzFZFJp/4+k5BH5by2jX2oZAEVNOSJX3UG//rpao6XOePtce/4C22CSbaG8nP9VL+wjREVdMCCydCr7n+NZDm7xBSiK3nQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dj8barQOkmtT7oxhVXfl0hY9FUv3c7KH+ExPdixDlmU=;
 b=l/ddMEKkl4O1NNEAO9Z7KbnMOIO+1BW/DgKNHCPHOL/0M+2U+Kz/gKSS9DR9cUQxT6m6v0tf8RIDqYPCYyzFMtQT2lqLfqQI0eP0ZJWRibW90dcEIkRCaTsKFxs/6QOtG2ySJLQRPZ/EKz2gL0Kx4AQfcALWcr3QIl4loHRjY0r8TlgmBxtsH7E+/kI6NaxCC00tPzje570qaigzdiqIUjYx4jR+ET7UUY5A+N5VTzA4cpPvO7Xy8ifh0nl1ZQ/Gt8Q/NJpzSsCgAFb5sfbCgf7JgayR1qa+xRT252Yf6FszSRrj0vsOQlel3D2B/r8XQFnPoDAF7eJUXN+MNEq+gw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dj8barQOkmtT7oxhVXfl0hY9FUv3c7KH+ExPdixDlmU=;
 b=iY+OOzg58WiMZ8dRn71LbkvLY8R9vropru0MFEGuX/wu27CoveBa6sUBm+ZN8R4Vdw4NxXXXiedQY2ckVQll80eAA3ui+mO4XX69Uo9zFOhzTdEPv/Gi+5irATcN/2QYLOqsrsDybOd7GtrBBSA9U47KIs7SRjdO8MPwmWsAAek=
Received: from DB3PR06CA0019.eurprd06.prod.outlook.com (2603:10a6:8:1::32) by
 GV2PR08MB8271.eurprd08.prod.outlook.com (2603:10a6:150:b8::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.23; Tue, 6 May 2025 10:38:52 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:8:1:cafe::8d) by DB3PR06CA0019.outlook.office365.com
 (2603:10a6:8:1::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Tue,
 6 May 2025 10:38:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Tue, 6 May 2025 10:38:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCo28KLeh87HKk9mUmgbv1dquzMdVTr2Sg5UmGJET+bt3Qb4kUx00l4KDvRCpzdJ733bqX7A3GNWP33/jNmrNv23WgfC2Q9ky20oAHCybYObIjrKjbw2aMDgAqj8v45zsLYCvBnRyyG3rC+RG+7dYQFiORtifazw0Vpn5IDwbSU6V/JxsBV2FilBnpI4viBDU9C5s2cccvLGTqtkMdt1K8Iz4pM6vMWWelujE6v3mVLTRnucSlvBFfbQRP3Q578aVtmeHhTN8LUhcJkGrMV/tXa5cWQhj3pbaW2t/Ia/Q0Sm+JvS4MSw2oK/zEW8LXPtvM9yHsu58Ogi/vhf5mUicg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dj8barQOkmtT7oxhVXfl0hY9FUv3c7KH+ExPdixDlmU=;
 b=B+o6lP19YfUHv9Bm0Or7jBgHBjA/Lrsxj6xDY/M91v8aaYK4cT0HOPf7kXy7D061ny+3/yEDxtgBFV8+HXYg+3ibTy54HSFbWK/M0vV1BgICGjREIQhcyL+afAu3ZAhBh9b8oZ57X1gMCQDt/WEcL/sW6DAtG5+G/K89/12JldOmLW4YIkIBvplRkjnrXCIqKLgrVjGwZvdt8qNFrucPN6zD9JeG1TQtpU/VHgpmzc0s9E1E8/PkbiSTGYyvjtldjmHhG6gP2MLnGlKA3gtV+shN4sUTuofkTyGId1HBeWNOADXfD5lqf5hxSiFooRWBxL7XiFLlFPF2OZpl9FhlcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dj8barQOkmtT7oxhVXfl0hY9FUv3c7KH+ExPdixDlmU=;
 b=iY+OOzg58WiMZ8dRn71LbkvLY8R9vropru0MFEGuX/wu27CoveBa6sUBm+ZN8R4Vdw4NxXXXiedQY2ckVQll80eAA3ui+mO4XX69Uo9zFOhzTdEPv/Gi+5irATcN/2QYLOqsrsDybOd7GtrBBSA9U47KIs7SRjdO8MPwmWsAAek=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS2PR08MB10252.eurprd08.prod.outlook.com
 (2603:10a6:20b:648::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 10:38:18 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8699.024; Tue, 6 May 2025
 10:38:18 +0000
Date: Tue, 6 May 2025 11:38:15 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, will@kernel.org, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, broonie@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com,
	shameerali.kolothum.thodi@huawei.com, james.morse@arm.com,
	hardevsinh.palaniya@siliconsignals.io, ardb@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
Message-ID: <aBnml0luNiNZYf1s@e129823.arm.com>
References: <20250502180412.3774883-1-yeoreum.yun@arm.com>
 <174626735218.2189871.10298017577558632540.b4-ty@arm.com>
 <aBYkGJmfWDZHBEzp@arm.com>
 <aBZ7P3/dUfSjB0oV@e129823.arm.com>
 <aBkL-zUpbg7_gCEp@arm.com>
 <aBnDqvY5c6a3qQ4H@e129823.arm.com>
 <fbfded61-cfe2-4416-9098-ef39ef3e2b62@arm.com>
 <aBnOJS6TZxlZiYQ/@e129823.arm.com>
 <aBngorZeIASsJEvY@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBngorZeIASsJEvY@arm.com>
X-ClientProxiedBy: LO2P123CA0067.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::31) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS2PR08MB10252:EE_|DB1PEPF0003922F:EE_|GV2PR08MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 961f7955-5db1-437d-38c8-08dd8c8a30d7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?ml2+FBSQWUinJwnS4capE7U1BTvRIbUPrQlj3tbi8jnodSzc3r55VtXvQnjX?=
 =?us-ascii?Q?p/zGZCNAwZnx5nP3p3EFDOFh8C/Ezwjc8KLUEdhaAZMbkAop64z1NuKVVoKw?=
 =?us-ascii?Q?qOqAd3Xd8un2X8zXukiBsoL1Lt8YJOxrGi9QoBaRGmJLKWlKrBIeJv84AEFD?=
 =?us-ascii?Q?n6d19hEH1d7YoLlgLCe+BT7IMV8ZC2A2BORLWjTNvapPiGxPlzL6IPbYV2Kg?=
 =?us-ascii?Q?cC7Oq5QaRG/2sL5GMLLIFu+ovzWj+JS2WTPhKJ15Asgbp3CWmqyK5jSx6V7x?=
 =?us-ascii?Q?qmwNqCEICrptSUvTZ5/Wy1Jtpt7cY0Y7GU+jUcbRfG1YGk86bS2zlM6BfqId?=
 =?us-ascii?Q?xEyVyKRjLV/i82QYWp49wIqxlMyY6JK3fodXbSAz9qrJ1zMjQ/IocTfemuYA?=
 =?us-ascii?Q?SBV230MMt9YQ9PhwWao+GxV6GCQPS1faP2UpqvXAEECVyCcbxt7Yj3iLHVmX?=
 =?us-ascii?Q?0xqTkGB+Eru4DelMfo3QvlLes+zzUxBQO1D/4r7vQhiucb7i4jBW7kL5QO9V?=
 =?us-ascii?Q?KIpALfpOQUzZ4mQKsjgXOqSS+DXDZmiNR/slOnzvJdXYWkvQlaqB8tXCvReh?=
 =?us-ascii?Q?wYiMAssWFxuuvmaKdpvMNmTCa7r8QT5mq9ohce6a3aQJVN0hsO6qI973QCd5?=
 =?us-ascii?Q?RUw6sRxZyRtasHogKZUCsQ0gkmS69sCtkLHJqEob5+oJUHvk8qKGVxD2UvPo?=
 =?us-ascii?Q?k9h3HZfoXOOsjRIn3u/5NivS1A7jMxLan+3ZZ6oA+YfgqdKj4rHLQnnkwaU+?=
 =?us-ascii?Q?IqP/QiRW/RBDw7tXeiFpGr8SHE7o/0OmGkV/N1lEPomlHSU8ZQR0uzZiCcVs?=
 =?us-ascii?Q?fO7H1PQjp3ccGo6y7VhEuljNltkAWM5ARLL62+D+E9x8rd1zruq61g/kVTJS?=
 =?us-ascii?Q?Yy+M1Pen3/b2ev/fMVtWu2asYaWXeKaxphIpaGQCydHYst0IFCSnRHFysokL?=
 =?us-ascii?Q?MNZbJvlo3zTwSZRqeFt13e03hZPTTiw850X2QlkIc9jD4lxmUCBzCZM3je1F?=
 =?us-ascii?Q?ka2ka1jT7hvzuMiwyTAzNd34129TCy8Ks7g4lfGmHYkNdOTEy+291ISPhHjC?=
 =?us-ascii?Q?ow38u/Lxaj5tkjeVGCiP1o14efCmS6KIIob79jpi6vMkTFvoPBfPJT62rp9p?=
 =?us-ascii?Q?8qxfk4yhPBEWD+Wui4Jj3DwCWXmC9MwkIVNcMaSZWz2OJSO1lE6um/ZpYHwL?=
 =?us-ascii?Q?LZArJy/HIMB4HDK0wKmy3BsKTYa5H9EzDrdvnkO4lymf9oh6xQx0vC8Y3r5y?=
 =?us-ascii?Q?ORgxHNa9foaIQpFXGneyH8Od5LeYrgi6prIQjh49QIogbIHvWp8OKhwdDTvF?=
 =?us-ascii?Q?/l4aU21OsbpbsG3HTGm/jAymklA5LzYLYaJCp22alDZFJjwv2fwiKlEPYbsy?=
 =?us-ascii?Q?N7W9cYrSA6+uQ99WDBJV+lLtMDc3ckUyltIoL2nxVtnBeRcXJ8XIFpUik58R?=
 =?us-ascii?Q?ZtRehUAgwoI=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10252
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0c728b02-1d8a-400e-0ffc-08dd8c8a1d71
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|14060799003|376014|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gmLOobHfmB7BjXeWTNPqAUSfc8D69L8naWok7rF6ka7K5DLxfOkM0S/B1gee?=
 =?us-ascii?Q?DgXrxcr5LuezUice0A9JglgD90O3GVMIImZT//zMfY6KgAjrbw0d6PQQ9R0V?=
 =?us-ascii?Q?tCP184ztu//Rk04WNVnt4nfkVguN8pEKUU86IOnl3vC6/INgILYSoKEpJOj+?=
 =?us-ascii?Q?vgzmBwsBCbZCG2vowMg7zl6Az61wOBR6ewGKO5mntCqEaE3o3MziepEeTscD?=
 =?us-ascii?Q?nKJm2HAvgptod/aPFpDmUhfKLwUUuD8XEJyiUljy4LWeW+tWnlXz6VXdPp9m?=
 =?us-ascii?Q?0VyK/BIb26nP7i5XIYL2Oh72pw1ahBHgQypUqiUkakbX7kVxcbNG53OkjgLd?=
 =?us-ascii?Q?IeyM6S4IpI/vohgJGfzwlNWpYxqPxtOoe0bI/b2eCIX8+c4hkzDXzNG/rxcN?=
 =?us-ascii?Q?SaijxS5XZRZDth8XBoAkQj6xpgpoX3dv3+lT0iu42aM6zrBlDnzO6SkNfO9n?=
 =?us-ascii?Q?NJCq58TbNioT+6detysaDshOiVCenyfSCDuewHfRE71DsG/83gCQLEn6cR2G?=
 =?us-ascii?Q?IAISwT9+K2wytbM6fmjITqxzTZxddEp/TNvf82juijZUkQJy8F+yOuFlVXJE?=
 =?us-ascii?Q?Eq+0qxI+qr9flr+jBtCSxRxz/sTOAwYOiNxDTcnmLNv4L2dEbTZpBkkKL7Lh?=
 =?us-ascii?Q?PUnQCXHLaX8onhTWrX6iBTLE7Ow8iX/pMjKvXDU2nFuezEfLwNb9owbP0IQB?=
 =?us-ascii?Q?1bk0OIyICWw2vkdDLUd+YFJCaxmvnWoyH3YL8gQutbpzD4sGOCNFu7OWmClQ?=
 =?us-ascii?Q?BXtoOJ7GhyuKrjY07FlKv1IRN7Sbpl81SFjtpV0HxxYWdUD7gIm+1fGfsHCD?=
 =?us-ascii?Q?xwoNc7N2BjvCi6gS9DqjhY9xYb8hI9bVHD8F6VnuHnrHuSFsxahVjLbWGXb0?=
 =?us-ascii?Q?lubTFIudgd60LIu33XvDfYz9z/GRXQN8eY6/lGWGnlDlCLqnBG/wBDs/5uGS?=
 =?us-ascii?Q?qzHbXypS95/AAjSHMvI0QZiP8C+6OuHj8C056gH61506TvkA9qr8do8Cpl8M?=
 =?us-ascii?Q?Z+udCwtiG3z3GbXj3iAaSx3e7s5Cuy8ybokiNwPa0Do2BKYbqfGS5ZyJqMo3?=
 =?us-ascii?Q?v4kxpqjgyuEIKoun7Ce2r9OvthZp+XlLzq1yLB1cND9yKj7a8Kho+K08vf3d?=
 =?us-ascii?Q?eSTKRRDq87faqExL/Nd9rengGMQ5GDEpPNjBqNfqw9So06/CWI9bmlqsdDlj?=
 =?us-ascii?Q?C9R40+KcREAnOeEeh2Lr1SJMuL7o3FHJxYRzOUAY5qtg+YkhZBZ+jAr0oFb1?=
 =?us-ascii?Q?t3Vhv3UE3btsXOVm9GzT+aN5NWRhKBEV5KnOhdRaLYBTnhrFzVAbWKbCWtvO?=
 =?us-ascii?Q?/okGQc8ZJ9kn9D4KtL6onRPvZsbnPGlYQjG9PVJOPK9hQ00kmXGdNlhBvKqE?=
 =?us-ascii?Q?eG3nC0FgnUk/f6O3xQqS3+OYCbxYIXKntpMgcYAWencMJwP0gKzA/TAmtAK5?=
 =?us-ascii?Q?N2edT+FCiMGeDkmFU7a8WEo1LsCR1pln6XPZPeNOqQI0bxN11TRVOLdWMIzG?=
 =?us-ascii?Q?cfLDDYlD3H3SnPrh50LOXBAvJoygU7V8hFGgsUme9NWhf60vs7/MqLu2og?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(14060799003)(376014)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 10:38:50.8197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 961f7955-5db1-437d-38c8-08dd8c8a30d7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8271

On Tue, May 06, 2025 at 11:12:50AM +0100, Catalin Marinas wrote:
> On Tue, May 06, 2025 at 09:53:57AM +0100, Yeoreum Yun wrote:
> > > >>>> On Sat, May 03, 2025 at 11:16:12AM +0100, Catalin Marinas wrote:
> > > >>>>> On Fri, 02 May 2025 19:04:12 +0100, Yeoreum Yun wrote:
> > > >>>>>> create_init_idmap() could be called before .bss section initialization
> > > >>>>>> which is done in early_map_kernel().
> > > >>>>>> Therefore, data/test_prot could be set incorrectly by PTE_MAYBE_NG macro.
> > > >>>>>>
> > > >>>>>> PTE_MAYBE_NG macro set NG bit according to value of "arm64_use_ng_mappings".
> > > >>>>>> and this variable places in .bss section.
> > > >>>>>>
> > > >>>>>> [...]
> > > >>>>>
> > > >>>>> Applied to arm64 (for-next/fixes), with some slight tweaking of the
> > > >>>>> comment, thanks!
> > > >>>>>
> > > >>>>> [1/1] arm64/cpufeature: annotate arm64_use_ng_mappings with ro_after_init to prevent wrong idmap generation
> > > >>>>>       https://git.kernel.org/arm64/c/12657bcd1835
> > > >>>>
> > > >>>> I'm going to drop this for now. The kernel compiled with a clang 19.1.5
> > > >>>> version I have around (Debian sid) fails to boot, gets stuck early on:
> [...]
> > Personally, I don't believe this because the create_init_idmap()
> > maps the the .rodata section with PAGE_KERNEL pgprot
> > from __initdata_begin to _end.
> >
> > and at the mark_readonly() the pgprot is changed to PAGE_KERNEL_RO
> > But, arm64_use_ng_mappings is accessed with write before mark_readonly()
> > only via smp_cpus_done().
> >
> > JFYI here is map information:
> >
> > // mark_readlonly() changes to ro perm below ranges:
> > ffff800081b30000 g       .rodata	0000000000000000 __start_rodata
> > ffff800082560000 g       .rodata.text	0000000000000000 __init_begin
> >
> > // create_init_idmap() maps below range with PAGE_KERNEL.
> > ffff8000826d0000 g       .altinstructions	0000000000000000 __initdata_begin
> > ffff800082eb0000 g       .bss	0000000000000000 _end
> >
> > ffff8000824596d0 g     O .rodata	0000000000000001 arm64_use_ng_mappings
>
> So arm64_use_ng_mappings is mapped as read-only since .rodata is before
> __initdata_begin.

Right. I've misread teh address at first time.
Sorry to make noise.

> --
> Catalin

--
Sincerely,
Yeoreum Yun

