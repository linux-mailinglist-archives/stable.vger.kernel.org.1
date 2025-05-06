Return-Path: <stable+bounces-141764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26735AABCA5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 10:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD93507119
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCF0221FD8;
	Tue,  6 May 2025 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OX70gsuY";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OX70gsuY"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653D121D3CD;
	Tue,  6 May 2025 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.76
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746518999; cv=fail; b=kRyjpc5tLdjtFNL+CzPMK9qRQlF2y/paCnxXBctkPry5WHPgcqNz2klEDpGnHJAmxHHvJgiiFMuuqm8DBnZ31p7oPAV8ON5bXfuiJkyh73JwqJ6WGxV9NKRh6mt2oQ6DZjNSlQeFrWS8Uwm/PwsPNaQoN46+5rRsBhXUImTKAh8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746518999; c=relaxed/simple;
	bh=3e8wD6RBi4Xm4WMxqUj0lmwyNeBIdtyc2FtOqmXATqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CR9NQ4j/qSCOREe7bh1U00q2bm+UULUC61ERIMYlh//1GnINYqbqyI5jZwcd67T5w+HcsZixrOFAPQsr6EjpnoUjYPJ5brqBrYQOGQvFvF+nDy1Jzu/7rtKw6h00p8o8QsMyn+nuuN6n5zGpuzi+8N8e0k7HhSufRXGWIe49gYw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OX70gsuY; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OX70gsuY; arc=fail smtp.client-ip=40.107.105.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=c4xskPSNzKoA430gJT3k+booKZx+8DzJfz2EIWGUHxO9hfe9aToec2sTSTAyAizAIOKkQjMzNw1cq/Z/aJLWggrNRk6GsE8bPAEdFtttJjBAIhPqJ2SiMNTm5qlfwYDNf84mVt8BvR9Dzi6ePXUY1aS1q/Z3QkBAQXjKYJMEzNXfPFZYABuPtCsbQsH8pLqri5EhpDUAcvD4hz7OJ3+qlFXiEF3z/ELOQq+eNUKmG4IV7bTcXJm+XubO/FmLl0523vSgaRKs3147CPPhvTq1YSH+ywr6pd3mLcAptceu9lDFjkhc6bqsNaOF0/TEtei9ykrtDtyqz7+D7bL0SmKeHg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eByDabczTQvQbK9y2hBzV1ba4lOjKntsq/GoOyJ8ci8=;
 b=XM7Grq2HwiuFwBnAWzoxBtzz8mxGp2h5EsghsUsbrnEzG+ddkZONxrSsrJ1xNcedClDkBkJq3iJhuhFGmEaZQrMXTnWWfH1RB8dm6PsjOXju9oi0SFCATkPJyTqs709iSS9FhZIrLJBcayw0jK2WBDGJpaPLBQ2n5bpPHbUCex1rhDfKmEdebF8AaEZ01yCqR0EzhNTTILnm3FRyR/N65d4K904v+E7coPW7Oq3JLaeGf+OrXFk1jwC2ZuKC8E3uvcZKrIzMstLA0LAlZ05XKZjE2Tsv2MC4ZgkNgi1V5HAGXrHjK9vXTLse810uYQNDJjZdWigBxflyGPylzCvPbQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eByDabczTQvQbK9y2hBzV1ba4lOjKntsq/GoOyJ8ci8=;
 b=OX70gsuYWoOQS8Oi4se/Rq8ZWSh7xIqYLH9PZcsafctuXCCj+Q6UwMWYIWC9XH9nEmOW9Qxz96Kdj5qEfG0lZgKCpolGe/reMuiwpU24WeofTWpDr0sAaN2nAMhdeAV4BtWDAlibGGoRVVpMc5gikq6nkDuK8Uaqeu0zMKlnMpc=
Received: from DUZPR01CA0249.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::10) by DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 08:09:50 +0000
Received: from DU2PEPF00028CFC.eurprd03.prod.outlook.com
 (2603:10a6:10:4b5:cafe::71) by DUZPR01CA0249.outlook.office365.com
 (2603:10a6:10:4b5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 6 May 2025 08:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028CFC.mail.protection.outlook.com (10.167.242.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Tue, 6 May 2025 08:09:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QI/aIUH26UXpgHPh+VlqgnTWiJZk76PMw386c/BZ2nPX4fG0L1KFhDje3wev+R9c8seXbr2fppNc2d+xJ49eNdfhs8pVVmkEKrtYw2JzZElo+svzH5wiUseZjLVr+A/OsmhEm4qJIq4MeXXNMCfimbgbZiSzl5xt6JR5Ya97m8OqJ1aEnRAVredmW0jgU0pnWI92qmRLZcDCLK1Ev9UuUMP1SqT90JQ0ZlbF7+8sHy1wyT79/BH1WC0BczZtPOIY8lyWmfY2i33X+/B97YvkVPU/bJ7Lwl/NE8zXJqXxSeKP6MoX/cP30Z7TcxmuSjfZcTbXIr9l9UL6jg8BBw/WWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eByDabczTQvQbK9y2hBzV1ba4lOjKntsq/GoOyJ8ci8=;
 b=KkvsncUyt3V5KtVWduFxVcppcWJzy6tHgdYuANpnw79r0fxFizlpa20RorgjYwXNnDvUTrdM7LR2plWRn5aKoNqygxX20ZOpkMT8/L6BArB77g0kPPCIjE5fpVIHUzDiLFjIngakDG/i6U7OfRNiHAIi0MBFV3oLieSUXdSrXETL4r8Ybaf8uD+yxAy/aDI40/rgFc7dCpOedq8aTnmSdu13eRsgQmeB/b8cycSglAsRwgtI3I7M2JW0adEBMs1nx79ZreECcj5VlG1oHCc1rW6ubVyf89AN3jZ76SvT4MoKLME0ODsv7gZfHWzfS7fOSPZ81qEm3UYYHlS2UyPteQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eByDabczTQvQbK9y2hBzV1ba4lOjKntsq/GoOyJ8ci8=;
 b=OX70gsuYWoOQS8Oi4se/Rq8ZWSh7xIqYLH9PZcsafctuXCCj+Q6UwMWYIWC9XH9nEmOW9Qxz96Kdj5qEfG0lZgKCpolGe/reMuiwpU24WeofTWpDr0sAaN2nAMhdeAV4BtWDAlibGGoRVVpMc5gikq6nkDuK8Uaqeu0zMKlnMpc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB10245.eurprd08.prod.outlook.com
 (2603:10a6:20b:639::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 08:09:18 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8699.024; Tue, 6 May 2025
 08:09:17 +0000
Date: Tue, 6 May 2025 09:09:14 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com, broonie@kernel.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	shameerali.kolothum.thodi@huawei.com, james.morse@arm.com,
	hardevsinh.palaniya@siliconsignals.io, ardb@kernel.org,
	ryan.roberts@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
Message-ID: <aBnDqvY5c6a3qQ4H@e129823.arm.com>
References: <20250502180412.3774883-1-yeoreum.yun@arm.com>
 <174626735218.2189871.10298017577558632540.b4-ty@arm.com>
 <aBYkGJmfWDZHBEzp@arm.com>
 <aBZ7P3/dUfSjB0oV@e129823.arm.com>
 <aBkL-zUpbg7_gCEp@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBkL-zUpbg7_gCEp@arm.com>
X-ClientProxiedBy: LO4P123CA0093.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::8) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB10245:EE_|DU2PEPF00028CFC:EE_|DU2PR08MB10037:EE_
X-MS-Office365-Filtering-Correlation-Id: 34dc50db-d79b-41c0-a8c3-08dd8c756007
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?aNe/JwsENoT2MSzHRTwrhml0lMrFJ/5TyKByZgHJcOD3lrshswVbuXitUdp7?=
 =?us-ascii?Q?m6AmVEoTcHtvNnPpko9nZxC5HFgBaJeX9LHsAdkDtNgEmQTfbwGtLQfNbvEq?=
 =?us-ascii?Q?g3qIpif4F1hDDcq/BJwJpLlfKZ4NwxzcwTp4teYQBSeeEKIAvFqwOVx+Dvuw?=
 =?us-ascii?Q?x1u4OCLuFA3fbIdlY0SyCCx5GD/BkwG8x4g/VjQRmmske7GlW024GHdJDMIz?=
 =?us-ascii?Q?IJdXDD4Kt+czcKRHDmKjwVRluH6ZaEPv+FoS4HlLkFUtmKrOLzBOWpFe2N0u?=
 =?us-ascii?Q?ntB9BF6wKa7xqwlhDguaMSpRniMiP7bjJ8NsBPcmqH/9mZ96iNPgHYsFuVx9?=
 =?us-ascii?Q?RG8CT8PXGVfiZ/SBqNbCyVCs/AbY64lR4EZxPzM3H+edkWXvCgMZ70+qEd9U?=
 =?us-ascii?Q?83zirKhfC/HChYIPTeszadOUeyVhFxZGDq+BJAJY94RyfD9sQPezgssYkFP1?=
 =?us-ascii?Q?WVq95o+4+pPB4rC/7TMAzBKxqEKMVm1F37r6PGURcb6NrqPOlX+56E0Arxph?=
 =?us-ascii?Q?Z++MB5kYPGk3pKcK4uGoe5nBUsp0n7smy1AZBtCqQ7VOpLcr1Y64APK+cqSJ?=
 =?us-ascii?Q?hJ5oKSZiSD609jMeIoQMVzRcHWGR4PKj29ynMFqDT/caGQVdyaF4UZgd4LOb?=
 =?us-ascii?Q?4pZZf1f8HXxs6ZRBoblhMwmWdoSmS6rInVifyFs/j5M+cKYgGvkVP6+PFk8o?=
 =?us-ascii?Q?+l6FwDDjqca854d68EHjadea8Qa3BKUT3Uzn68d2oQAU9mDUAJftYR7tRmWk?=
 =?us-ascii?Q?tPZSJi78IDRaE57YQkWTJ8NAVfnToD5FmSOJuFN6nPYuB8UiM3NCw16fZrj6?=
 =?us-ascii?Q?BBkPEw98P5O2sGtQVWxwFSrTGZ5qimUDpMap2A+aYCebu900m5nqg7uh/ki3?=
 =?us-ascii?Q?+vKq6dSDVgm9kr7n/PE7nkHKG2b+/RmOsVPrzxCoHu5+3s+lRHcV6QUfgcr1?=
 =?us-ascii?Q?ZJgaQ4fD/P2zR/72g/SWUr96Dx+gFTHa2ZtcozaF+MR+cF8FKPdF0iK1R6s5?=
 =?us-ascii?Q?DSHiiz9Amt5IIALpBIvn7caZ1lL+BEdZygyT9rdhKkiVqfI0rQzSNUan6oef?=
 =?us-ascii?Q?83XoQXXTQv8Mx+DvK6HviftZJ8HFlefzOY04FWvwRpsoEAeYvEmyitGiWbc6?=
 =?us-ascii?Q?AyrLEsTHq52gU1CZ2pZqwd6huLhXLmDCPV2QvpJ0iNu3Cbb29899cnrqyz6d?=
 =?us-ascii?Q?UzUOAhH1SAP4Dr8nRpXd+qmLLGeunHTiHNbTycec5QN/+hm08xD4uU2PbUMQ?=
 =?us-ascii?Q?51kcODi92wK1gZfu+jYJRAwL8vXJDQaca0G35q5zdb7vOkchLXIfH+uQQATq?=
 =?us-ascii?Q?hFeqI+i1/br150QLHtt28F5xpYrjl8mcvlGJQuLhNS21265R+NO3EMtEyYon?=
 =?us-ascii?Q?Iyxeswg=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10245
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7f858eff-32f4-406b-a09c-08dd8c754bfe
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|14060799003|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?teRhQPkAsVHHyt9A7nun/RoF/76FiPauUV9EVAXqv3zTMlCMjimSVCGfW2yp?=
 =?us-ascii?Q?EfO62Wn0DtRATxRZx9c7R24BcY6twpTOUcvf47EoIiEp3GEdY5zjxH7TNxvM?=
 =?us-ascii?Q?grI3UVha3k7yuQMSrPw+WrkJXR4KRcJP57AThYslDC5VJzVvQJ9f3BqrPqhh?=
 =?us-ascii?Q?BgLR1f+H1tBhYgEkGMLWxwR826dkimGuYf7XuHHm7vTCS0C0akTMYMIoLM0Q?=
 =?us-ascii?Q?FMjRYqSZhNacWl88e1iZBMvKEzSd0RMCnonqUJgRzmAvFPNUTpOdQhImYj6f?=
 =?us-ascii?Q?RLcaqLdN03t14d4uo6jA9V90h/0Uxgc9p1XPfZy7e/Q8HtkkXCIz/gcGpYgm?=
 =?us-ascii?Q?d8Ve/nPp/dkIV87euFDFB8wKovT9QRBnyBXH1tLflHkNYnZwFV/Ptp1g+Gi1?=
 =?us-ascii?Q?rqcJGBsocsHRG0dm7jRCPcHKnvqrxP/ksm24uVbRy56WACje9tzEWekL8B6s?=
 =?us-ascii?Q?t0NcGlAgCS1F3ql1l62bxWkTmzLBp1N7Z6taOkIw3WOoetm/eyJqNHI+4Bi9?=
 =?us-ascii?Q?8WV1oLrnQKQVYBWpC0Yn7TrbEUIgenataqnbKjy4Bf8w1V1Zq4Z/TtCMGthR?=
 =?us-ascii?Q?gjpzZyV2Qh0veHgykcIA21QbYHPaHux5gDY2ufeBzBreAi75FiUwLS8OWVtq?=
 =?us-ascii?Q?IyU9NwEYhdHzMZ1/X8KIXYNtmYyBXGT1r+Wm62iNUp5aHcv++BBe9f7ieCij?=
 =?us-ascii?Q?PW1CAkDnslwpw/zLsfb6rwsHrYBGEjZZTJIin4OKvfjodkozQCSs0GG4x0ir?=
 =?us-ascii?Q?bteK+8MxdUt8a5J0DrPHLK662uFBSQGQfc7Nq2/n6pv7E03s8dpwdDxVUCO7?=
 =?us-ascii?Q?HHIJBEW6z3PQ1hdsJQhq9cBlqrH7iDElfxuvWULi9S6pZEwrKnXA2RYYLwX0?=
 =?us-ascii?Q?aodZiwlFjfWxhmQxvZAleR4+r13QF2IZH6ki3sNvyVOCeLUPhZmdXHneU/ZC?=
 =?us-ascii?Q?uMF8t3BTzSn215klpvQvy6vvQnwcoPuLKCARrmW4e+mnHXgPyC/Y3eE287S2?=
 =?us-ascii?Q?VjGvLTpD1Qbg6cJuXiOofZW/biY3tvO3AFfV9AYCmF1i2IbLlsMEAr8tJFne?=
 =?us-ascii?Q?ouXtKrZQJGPs/UQoS4Kc8pZpP8BnSUUxqN9mJIl+z2VSPp4F9c5QZQx7Lo2P?=
 =?us-ascii?Q?HTfFN1OwVwo8CTFqXAHzlGW89jOyHSXMGfbHj8XLfqvYXg/ZBp3ITBvdKjpD?=
 =?us-ascii?Q?moXeqEYFAhzjeUa4V3mLLcRE7CxfZnWsfVEtj1EHcFHhW+8KclOKiUI0khEu?=
 =?us-ascii?Q?V9lybW0cHlWLdWTro17zKp5RVqKwbyhNoVpaG9g9aoKayKVkb4JCCETqCsCS?=
 =?us-ascii?Q?MrA+2PW2WqqMP+lNEhdkUiHbNpy8kzw5KhJO25MTRjqLMwBoNkmwxEitXbkh?=
 =?us-ascii?Q?7tWg9WDfbL2kILFoGWP9+IOE0X+EaYMDGj7AqQW28yYo0MgMFVm+zCB6gs1q?=
 =?us-ascii?Q?JNFIc2jFpSL6FiyvhxdvxI18OP0ARjZx1FPGIbAYTjQF0QXIuQodxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(14060799003)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 08:09:50.5706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dc50db-d79b-41c0-a8c3-08dd8c756007
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10037

Hi Catalin,

> On Sat, May 03, 2025 at 09:23:27PM +0100, Yeoreum Yun wrote:
> > Hi Catalin,
> >
> > > On Sat, May 03, 2025 at 11:16:12AM +0100, Catalin Marinas wrote:
> > > > On Fri, 02 May 2025 19:04:12 +0100, Yeoreum Yun wrote:
> > > > > create_init_idmap() could be called before .bss section initialization
> > > > > which is done in early_map_kernel().
> > > > > Therefore, data/test_prot could be set incorrectly by PTE_MAYBE_NG macro.
> > > > >
> > > > > PTE_MAYBE_NG macro set NG bit according to value of "arm64_use_ng_mappings".
> > > > > and this variable places in .bss section.
> > > > >
> > > > > [...]
> > > >
> > > > Applied to arm64 (for-next/fixes), with some slight tweaking of the
> > > > comment, thanks!
> > > >
> > > > [1/1] arm64/cpufeature: annotate arm64_use_ng_mappings with ro_after_init to prevent wrong idmap generation
> > > >       https://git.kernel.org/arm64/c/12657bcd1835
> > >
> > > I'm going to drop this for now. The kernel compiled with a clang 19.1.5
> > > version I have around (Debian sid) fails to boot, gets stuck early on:
> > >
> > > $ clang --version
> > > Debian clang version 19.1.5 (1)
> > > Target: aarch64-unknown-linux-gnu
> > > Thread model: posix
> > > InstalledDir: /usr/lib/llvm-19/bin
> > >
> > > I didn't have time to investigate, disassemble etc. I'll have a look
> > > next week.
> >
> > Just for your information.
> > When I see the debian package, clang 19.1.5-1 doesn't supply anymore:
> >  - https://ftp.debian.org/debian/pool/main/l/llvm-toolchain-19/
> >
> > and the default version for sid is below:
> >
> > $ clang-19 --version
> > Debian clang version 19.1.7 (3)
> > Target: aarch64-unknown-linux-gnu
> > Thread model: posix
> > InstalledDir: /usr/lib/llvm-19/bin
> >
> > When I tested with above version with arm64-linux's for-next/fixes
> > including this patch. it works well.
>
> It doesn't seem to be toolchain related. It fails with gcc as well from
> Debian stable but you'd need some older CPU (even if emulated, e.g.
> qemu). It fails with Cortex-A72 (guest on Raspberry Pi 4) but not
> Neoverse-N2. Also changing the annotation from __ro_after_init to
> __read_mostly also works.

Thanks to let me know. But still I've failed to reproduce this
on Cortex-a72 and any older cpu on qeum.
If you don't mind, would you share your Kconfig?

> I haven't debugged it yet but I wonder whether something wants to write
> this variable after it was made read-only (well, I couldn't find any by
> grep'ing the code, so it needs some step-by-step debugging).
>
[...]

Thanks!

--
Sincerely,
Yeoreum Yun

