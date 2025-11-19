Return-Path: <stable+bounces-195159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7295CC6D7D9
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 09:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 32F022BF1E
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 08:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40B026AA91;
	Wed, 19 Nov 2025 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CGNzNW6R"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC66C2765D7;
	Wed, 19 Nov 2025 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763541827; cv=fail; b=Ehrci3b6HuJSURz7vJy6a3NC6ZU7OJ1Xjd1Nxe4dDyfSMmieHmR6mqBAFHYhRSjDVBfiE1LyG+8UtTdRL1toYNVoGxCdPaP+4iwtWmk4QE0+rg9XogZ75sHhEgc2gLuuDHW0JYqTPghzxNqdaeD8cJvlGcjW51Wzp6mbmqG/W5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763541827; c=relaxed/simple;
	bh=s3x0v1TicZAMQOY/0Bh9EgSOwlUFNbm9dzGF8XcB3/0=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ucVgwUnFsqT4//lfWyxlZlfy6iyrfOSmvZlSDjTVchitGmhQ+Gu+gtXjTGaR42uSXLbu6Uy+/vxXn72WXY6R2W53vcRo4f4HCfmcdggnyei8AuunvFSVnG/IIQFW8Z2Pl5Gf/AI56uwMXmvcSBT++Niab6lyFihQBvrumtBshsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CGNzNW6R; arc=fail smtp.client-ip=52.101.62.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wy58Ft9X6btI7d1WfGHq1db/V3EgSL+ZPPYO5mToY5lbthopmrx/6rtEHuf+VQjL1HxTuoiEU6VUZjYeWWQtbyRjBmcDWmIhxtPtl/hcVFUSMxmPJe3SsrQl6gwS8EfVjioxPeIliop3v0afckhHyaf9YJkpZ5feJURoepLrwO/4rpIEl3wg596GQgymmVE8FxMGT2jhCeR7jgCtZrd6OeTB0exkHzCsLCfWIER3RKBOM4dw2qfvC6CiX6E5xWiA98sbSWcBQELJayZPKxOY/PMBuHSUbB2iOUmluPTX8J2fYGWp7u5cYN/5LX+wEtRRNnGWIzFd+akKJunlcUPJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3x0v1TicZAMQOY/0Bh9EgSOwlUFNbm9dzGF8XcB3/0=;
 b=M0HC24XTjGGlj9kjDrk2QvvMU7Xh3NkZ3F0cfni2rUynHTGh5C2WcBGBzQOoZPa9qzqv0w0iHpJ0WQSu6Gpj+6wZRp0VdmcBFEI8wth2UNTIx4CmUFqmt/BABv7RmPgG/gBdSprRGJhXloRsFSaNOV1ZYP3x35jXOO07h82gIgWRAjs5E1Esi+y52JCzoU+mhlnlF91Y1jSeJJ3X/q1oHDNcahwcfBREwzSkTSqirdDMO+sycA0wmcXlyxlL/0uZtKhu9KJeGW946RpZ+gMeOnWkZtM7tONWmOUyrmbKNCJ7bzPCA9SoeCA9OX+4jPPa12k5H7hPFooS8c9NupjFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3x0v1TicZAMQOY/0Bh9EgSOwlUFNbm9dzGF8XcB3/0=;
 b=CGNzNW6RKe+XzTYMDvuvUojDUipX/erlWgYEM29P3WjGFIN4Ip9BXjUhDYvhfN5b0ONYUEPMLz1IPUHK6QMjLuw67lHnr81lVUQlAZk40SM/kMlimlKJFBDcjrqhyxhF6fs9rZsRA4lrM3T2U90o14muBcH8te3GqCwC8SFU5qY=
Received: from BYAPR05CA0092.namprd05.prod.outlook.com (2603:10b6:a03:e0::33)
 by MN0PR10MB6005.namprd10.prod.outlook.com (2603:10b6:208:3cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 08:43:41 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:e0:cafe::dd) by BYAPR05CA0092.outlook.office365.com
 (2603:10b6:a03:e0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 08:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 08:43:40 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 02:43:35 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 02:43:34 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 02:43:34 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AJ8hUWR1544454;
	Wed, 19 Nov 2025 02:43:31 -0600
Message-ID: <371e6a49846f910e9a747d4185471806cc719138.camel@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e-sk: Fix pinmux for power
 regulator
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
CC: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <y-abhilashchandra@ti.com>, <u-kumar1@ti.com>,
	<stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Date: Wed, 19 Nov 2025 14:13:48 +0530
In-Reply-To: <f4d38392-a019-4061-9ef0-d95506766027@ti.com>
References: <20251118114954.1838514-1-s-vadapalli@ti.com>
	 <f4d38392-a019-4061-9ef0-d95506766027@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|MN0PR10MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 860641c9-619c-4f8b-d2f8-08de2747bd4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTA2YzJzWmpyUk9xTlhoUHRYMmV4S1I5dTJ0V2tGRVhQcjcrVTE2NlNBMjJm?=
 =?utf-8?B?SVhObzV0ekdFNXVmVVArbkEvRzV0MmYyUmU0MnR2bmMxR0hoMzZNNC9jdTd6?=
 =?utf-8?B?SE1vbWF1YnIrUGdHSDZsOXc5VUluZnBPQ3RoWXgrWlZUREdqd3IvOHpYZ0lL?=
 =?utf-8?B?Mk1XNE5SK0kzeFk4blI4RlNaYVBhZkE0VEs3MEt2WnQzeDhQRjB1Q2dSRk05?=
 =?utf-8?B?T1FZN3EwcWlseDR1NThkWFR0ZG0wQXdpR2k4WXVlWmxFcXdVb2lpc2wvcXlM?=
 =?utf-8?B?c1ArbjVRV3ROY3ZwYkRIeTN0ZHV3dkhiVVB1NjFZWHVsdEJUaXFTNGJFQ0JO?=
 =?utf-8?B?aWJNWkd5clp0NEZRWkN1cjZuQjJDdnRlNk1nQmNIb1V5VnRpY0ZRalM5S0Ir?=
 =?utf-8?B?L21xZTlmemt6ZE9KQ3d0T3ZQR2xtV2lvaFZva3dOSmx0Um5yUW9aRzBFaWhZ?=
 =?utf-8?B?UDdJRWVPbW5hS1MveUdoNlBISnNwVnhCTmRtaFlqOWVYelNHam9UQkhHYkZT?=
 =?utf-8?B?MG1Mc0JrNXN1YnBlMFQ2L1pJNnBNaWQzdk14amF0MkN5cXovd2lwSzZETVRQ?=
 =?utf-8?B?SnlrUWZFYUYxNmZkaFJnbldNMXhscC8ydCtuN0I3WjdJK251anE4TVFGYXlo?=
 =?utf-8?B?ZG5LanJIeTYvSXZLNzFiVDVoblNXNGZaamxmMzE2T1A3WFVQQjhvZ3hleWdP?=
 =?utf-8?B?ZHNCVkZSanBHRlJrcHhHS2tieTQ3UmFkVk4rR3hDNFl1bzFrbE5IOWk4aXp0?=
 =?utf-8?B?eExPYzNKWTRKRXYzTm1zcGtqc0tTODErbmFCWDI5aGdnSndTWlBDYWwyVWoz?=
 =?utf-8?B?MlBuSUFkV3BsVGpiOEIzb0VpZ0M5OGt1ZVQrWUpkNEdxSEVlY25ZWTNvNFNp?=
 =?utf-8?B?OW5QQjQ0OEo5bDV6NFVKcTQxYlZNTHdXYnpnMTBIbzZ4YThkQ3k2TXp6cU5M?=
 =?utf-8?B?RGRwWGU4T1FyM3ZyZFpqODdzeUJvRHRWa0VxMFJjQmgzbGVxNWdsVEs1OXc5?=
 =?utf-8?B?MEViQ01zVEtLbWVKRENKTW5Veld5c2dkQk00UkJSVGFhUFBQZkROVm9LTk9P?=
 =?utf-8?B?NUFVYjRFdXEzZjJ5OUpyOTUrMW5WSTllVEtHQXorK1pRUmJxK0tSUnpqcnJU?=
 =?utf-8?B?VU9FM1FyUCtWZmNod0Z1WE5WRzQ5TmM4dUdxNkRwaTJCcjA0cjVIb05YNWtq?=
 =?utf-8?B?QVdUc0Z1Ui9tMllkaC9wdFlMMjF5VURqaS84M2VpY2lNWHNFeXYwcGxzU0o5?=
 =?utf-8?B?S21NUUJEOFNrU0FHNE5MM0lRSCt3WE5rSklCVUk3Y2dMQWJSci9IWGx3MGox?=
 =?utf-8?B?ZjlzZ0ttaEVFaHloV1B0bjFtMm1adWZLaDN6UHFsUDcwMGRXN3QxdmF0ejcy?=
 =?utf-8?B?VG83U0FpQnVnY2oxbVpsenlWTW9hTDd2bGlXeUl0aWxKS1BJTFh4RFIvT0Ev?=
 =?utf-8?B?MUJXbFR3UXhIdzk4RVZhOCt0VTFmQjFBaFJhYkJBMTB5ajVyVEVEdGZUM1Vm?=
 =?utf-8?B?cy84SjEvWi8rNUpzd1RBSEJ2N1hONWVuNEdRcXU3UEVoQjAyc2tSMHhlR01s?=
 =?utf-8?B?bjczUkp0d0s1Z0VqajhwR1dLdm1ZWU5zUmtFT01OTERPMWZpTlQxbGpEK2N2?=
 =?utf-8?B?K21rRFR1bjlNMkY5YlUvSkZHK0JHY0tSNkR4WFZXbXo1RER4UnZ2amxVVmFn?=
 =?utf-8?B?dHg4UG1GeW5zRmVUbnBhQXZZNUxWc0dMcjMwSG1ualQyWWtKSWs2ZTdaaGtu?=
 =?utf-8?B?a1M3WG9tYUoyR0NKQlAzYWE0RzByS0VEb0Jrd09HUUhYNGltK2dLLzU1aW1o?=
 =?utf-8?B?azVWSGRHanY0SWZoZDRMVDBmTGxnWXk0ODVJakdaamxRbUpXaWo3SVdwTUlT?=
 =?utf-8?B?TFhlVklYdElSWXo3WmRiSEVKT29rb09uWXNWVGZmZW4remhwd2U5OUhkSXJ5?=
 =?utf-8?B?SnRwMmJkZzZyTzEwRkZSMjhKTFVYd2tjZnlQZUJ4M08wcHNjb1I0cWp0eFJL?=
 =?utf-8?B?NWM0ZDdsVEZPMGcyMTB4c2grOXRDenc5enkyVUtsZ2RXYUEwSlpqcXlONFBu?=
 =?utf-8?B?R3YvRzgvT1dyTzFvZFo5ZFpIQTNFSlhVUEpLZ0JuV3hVVUMzQTUwMjVNY3Vq?=
 =?utf-8?Q?PK/0=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 08:43:40.3842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 860641c9-619c-4f8b-d2f8-08de2747bd4b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6005

On Wed, 2025-11-19 at 13:38 +0530, Vignesh Raghavendra wrote:

Hello Vignesh,

>=20
> On 18/11/25 17:19, Siddharth Vadapalli wrote:
> > Commit under Fixes added support for power regulators on the J721E SK
>=20
> ^^^ not the right way to quote a commit. Should follow commit SHA

I started following this format after I noticed that an earlier patch of
mine at [0]
was merged to the Networking Tree with the commit message updated to follow
this format [1]. I acknowledge that the expected format might be different
across subsystems, but I used this format since it seemed concise to me and
I believe that it makes it easier for the reader.

However, if the format should be:
commit SHA ("$subject")
for the TI-K3-DTS Tree as a policy, I will fix the format and post the v2
patch.

[0]: https://lore.kernel.org/r/20241220075618.228202-1-s-vadapalli@ti.com/
[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3D4a4d38ace1fb

> ("$subject") format. Moreover this paragraph can be simply be stated as
> node is under wrong pmx region (wakeup) and instead should be moved to ma=
in

Please let me know if I should post a v2 for this or if you plan to correct
it locally
(in case the 'commit SHA ("$subject") format doesn't require a v2).

Regards,
Siddharth.

