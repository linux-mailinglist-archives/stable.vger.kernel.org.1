Return-Path: <stable+bounces-139512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED40AA7933
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 20:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623003B235E
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62090267738;
	Fri,  2 May 2025 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OHeKLrdu";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OHeKLrdu"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2085.outbound.protection.outlook.com [40.107.103.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C67E1D54D8;
	Fri,  2 May 2025 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.85
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746209695; cv=fail; b=gSXBfZD5QKRtX/wnGNTUkUYIsYogb0oOPbi2Ldtj2aZ8dYJCgvN/qig3hMBd5McZqS6HM6KLTX9x1qXQMFK09DaS6j6XC1KGlyDYK7JkSK0EpBHuzSqMs9wG+gOPtLzSGBa9QqrDMBi7e4MbpBm4XChPTNC0HnWGCIQcnFRIkrA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746209695; c=relaxed/simple;
	bh=roP2qHfiSzyv6rG1xtUIvivNsYuWYqGZ9dryKLkzcqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pvA7YZwZavCotIGy6kxdMyGvZGb3ROAgMjnWvhvjgYYGtYEDg1wyergEq5SYARM28fosA1zkkEcuVCqPSZfPsX68Up0r1dGlv7W8PZzTO8g3l10cHHoaV1Utgi3Vj2NXRxJIo8EMUJtOIRc2HD4O7pH+ygIKmHcWIrLDdCfhIww=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OHeKLrdu; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OHeKLrdu; arc=fail smtp.client-ip=40.107.103.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ccviX8m+pZEUZyM15WK9U7fQksPgFQBJZxQQCdVdAiAiCRGuQD3GrcqrZWAV0reu5H5ST0LoxF7FB6Q4e1+iLQKyAMD/Vi2ec+gXfThhIKHrMDFyS65to59x041grB1asEv1REhXtB5dHEgCOPG3SUgjAOQY1gQuNNd11fN1thpiq4PqBePw5Lza29aROUVG8RzyVjhYc0m6cpTdNx6XSuZcs+2jL5KNR0FeGFOxb/Wj8+Kx9Mqh5xg3graXeTWmkYB1drtj66KvmnefnaAsQPCuDkjh4PBKq5pscKnTG/jFcELSGBBjacEeJCoWN9ABMdeq7WotKfsMSEaH2WQELg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roP2qHfiSzyv6rG1xtUIvivNsYuWYqGZ9dryKLkzcqY=;
 b=xZM5/oo89P0OuHRC6CdVVw5Axu8ZBa1LEXraosG4sFa3DitPmMwVBY3mvUo4e6aEE26YxuJl444n9t0qTYdgsdXB1vv4OeX6myCJWLA3Rcl6Bwp2iH+oed7PWrY3lndhPtNaUJ0oOssO8zhtLorGeTu1mhV2QJmQ6R4pDGREoe4j601jaVn9DX40Ivg5FqLXLgMC7X5F8yR9W48vDY1G9cBMIEhAN/r6TecFLhsuUQhJWsLP6WRH3BeSGe7HWjlVkwh/ssSW2q+Eww3iLP2uiypLO5OM3OvdVJfuu0cwMafSutv+Sy/wbI11ehnKKoSOvkKwSp4kWOgVb042ecLAfw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roP2qHfiSzyv6rG1xtUIvivNsYuWYqGZ9dryKLkzcqY=;
 b=OHeKLrduLnJlQ1eD7jjgFzioYY0d22EUyWXFwL4X9whiCr/t/u+SOZKrWBC/Dt4gU6ydNuq2pg+CrUG1y/C9t58xiT3q8H77BPee11om+iAUgkGjWQZn49a+J7chacotVgClZ1OG/w7+RPaOXGLk/cOaQIZ3KgVOU1J4hHaGSLQ=
Received: from AM0PR03CA0056.eurprd03.prod.outlook.com (2603:10a6:208::33) by
 VI1PR08MB10198.eurprd08.prod.outlook.com (2603:10a6:800:1be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Fri, 2 May
 2025 18:14:48 +0000
Received: from AMS0EPF000001A2.eurprd05.prod.outlook.com
 (2603:10a6:208:0:cafe::21) by AM0PR03CA0056.outlook.office365.com
 (2603:10a6:208::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.24 via Frontend Transport; Fri,
 2 May 2025 18:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A2.mail.protection.outlook.com (10.167.16.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.20
 via Frontend Transport; Fri, 2 May 2025 18:14:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XstwRpwHja8e565+iBeu2DbyZ7dwmAV/mWxphK8wU2JzBsa0BE7Iy6D+oyo0+AWoocBc0BeurnoZRPsikvX1faKQryMWguKBvcNLZVLpB54rP4Ot3SFoOUVXYACtYpCicEriKbSFYJqKqwZ+jepkaq3yWY5UNY0oiP879nRZ2yKiKU+6fQ5qM0JrJ+BhBn9vN+Map3tQznbWOk/w3Y76xLn3MoeF68T2XvmFx792UgufgesGSdSmKWh+eqYyFgRPHYiAdtkuTtlLxNg8MtvqP0jRjWgo3sF8jKJVVN/5UA+kBzVTyVHdSFKodmkDN7Y423uVgPWl9uxj5AxaNKoRLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roP2qHfiSzyv6rG1xtUIvivNsYuWYqGZ9dryKLkzcqY=;
 b=xYezNiSg2EU2dUx5Kbzi3yUJpvUq3qrM/8dBzWpgRUs90HfS5juaJgk+4pUu4KQ7pDz4BRSUszNZ6yvXvSttLYHq8nY9QSReAHQBqRlisV1MUiS9HBLPlZ4BMcuIcuRT9rcmaraTa9a9FYWBBFtLmxvKPo7wXegZMFNVr4RIM44N+yxEhEYPqv/5leMkhc/UiSxAjrtDZRZ292VF8KLrlqJmqNuwXJHF1V+tbNXZEX6CRfueUi2FckRUwQ8g3LV90dKxs8GDOI7p/+C8Vf5MVTywQB6im9G3JptxutH18zGzuMYo66H/SmG8sU6q6wNQe8D3akqYk7JaT00wbOt/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roP2qHfiSzyv6rG1xtUIvivNsYuWYqGZ9dryKLkzcqY=;
 b=OHeKLrduLnJlQ1eD7jjgFzioYY0d22EUyWXFwL4X9whiCr/t/u+SOZKrWBC/Dt4gU6ydNuq2pg+CrUG1y/C9t58xiT3q8H77BPee11om+iAUgkGjWQZn49a+J7chacotVgClZ1OG/w7+RPaOXGLk/cOaQIZ3KgVOU1J4hHaGSLQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16) by DBAPR08MB5669.eurprd08.prod.outlook.com
 (2603:10a6:10:1ac::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 18:14:15 +0000
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95]) by PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95%4]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 18:14:15 +0000
Date: Fri, 2 May 2025 19:14:12 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, will@kernel.org, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, broonie@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, frederic@kernel.org, joey.gouly@arm.com,
	james.morse@arm.com, hardevsinh.palaniya@siliconsignals.io,
	shameerali.kolothum.thodi@huawei.com, ryan.roberts@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
Message-ID: <aBULdGn+klwp8CEu@e129823.arm.com>
References: <20250502145755.3751405-1-yeoreum.yun@arm.com>
 <CAMj1kXEoYcS6YPU0mBdvijDRK6ZVB7mPYZsCVpz7sYotabrxtQ@mail.gmail.com>
 <aBUHlGvZuI2O0bbs@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBUHlGvZuI2O0bbs@arm.com>
X-ClientProxiedBy: LO4P123CA0386.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::13) To PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PA6PR08MB10526:EE_|DBAPR08MB5669:EE_|AMS0EPF000001A2:EE_|VI1PR08MB10198:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d577062-8e09-48c3-757c-08dd89a53919
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?wDCWzZ/SVwkMYWHbfnHYJy6qPFxMtQPrUpluAimAfaWnxWG1l7DW6K5YzA4r?=
 =?us-ascii?Q?ginOBkIlaW6FeMeWXXz1Kuo5mBzB33r7rwd+J6ase9CZU7QExCpuS1yXyf6a?=
 =?us-ascii?Q?rivK+DcfdTiWISnQZ9c02YL8rO74wKJnC6H52c3rpzMA2DyLq3LzruBN+aOm?=
 =?us-ascii?Q?ntpjeMOQTVwu4u8hx2c6G6F5QjQwhM5R7WzKp/83QoMUQBOZlhF6c0G/gmNC?=
 =?us-ascii?Q?vC0gO5hsedU/erMkkWh6BmFJOwfZNmSQe7dmNq6qZEcHilTgHQHYftiyKkqL?=
 =?us-ascii?Q?Ru97icmEP7eGXaBoF+RgWbvD3SAvWZ7FE1gmkJUfHksqlU7acGcDYIh70HvA?=
 =?us-ascii?Q?Dlue3KGuH7WiV91tYfBrMs+b7660sKGVZA3CoqXaVoM+w2pGzkbP9Q52z+BN?=
 =?us-ascii?Q?EbjNkja+gYv6qtX+nQ+hM/I8oWSuVQFPDTKw/f8FtCUusUyG/iHweaxAdLpt?=
 =?us-ascii?Q?YOVUCXSv0IUFkszJk63XshOBnD0TSZxmz/y4Bfly0/+iZbvXSLpmJzv9Fjx1?=
 =?us-ascii?Q?BsHdlEp0Iib2PnQBUXM++5Pj0Iucp9l3IOE81AZqlWdazXJ1PzbdF+2FaWZV?=
 =?us-ascii?Q?CIbuThwUXAHHzCUs/dAqHi0ni5eRyuKtAC+GFqQqyyGRHfhc1a+eVXTuxxhr?=
 =?us-ascii?Q?nvxWWqCv/DDlQ6ahbDZdmfmQ8sEnhSD+8Y5p5fYHSBnMZBqvI8DPiYcaZ+dE?=
 =?us-ascii?Q?oUjIfRYDWQdiIPVnOsi+qToy6VxY1Si38h4UuuqpfivgcVKOSNnf+kAj7KMg?=
 =?us-ascii?Q?ZaZ83JW7MH3y4+e+8zBWZygLT1e//3q+NY48jQvfnhE6o4yO5Vg5gHX5ucv1?=
 =?us-ascii?Q?Bu0wh2HouhTa+4of9oFRRMdn+BKt4SZsQEQDNMjnsNh+F5Ci0enXFIWLkm1p?=
 =?us-ascii?Q?uWQqi8al3iQtgupDt+GNPylMrrDuEbYxMQiEa1/Vs56uzwrivdFnk6uh6R3v?=
 =?us-ascii?Q?rdh5ARQX6LMIXaa3UYwO32ePDMQ2vo9jZHjJNHdH2Zr7gR9Yge2koipPOKcm?=
 =?us-ascii?Q?P7hNY2KJniV97AVDqb2zAzCCIrcmRfwPlXwYcdKEoZucOV0kQuigJrzTJ0ro?=
 =?us-ascii?Q?dNMLLnAtMUcvsFVKILWj2nKi9fsVCKFqHZIywkQ4iiNAQL4Bxu19GA7RDyaR?=
 =?us-ascii?Q?jUEWOaeZM1lOQxvWtqSCbl8tr8YkaIS6DYACWlK/Mzv9ep4c5vlmdXOp66Fm?=
 =?us-ascii?Q?b94/ijZz1lHVpUmP/RUnnFP+oJx0wrjEsQxf3JvWTVQhiyHRYTnI1VxOdoVd?=
 =?us-ascii?Q?JVgErmE2wbwTusauWKrtJg134TM5R/zByC71qqizMBdWX/39r4fSpRCCC5aV?=
 =?us-ascii?Q?La8uLBCvcUG+sih2eNJfuTcpo4ygyDLgnlPNRL1/6OqoLKyU8EOvvIquIFgs?=
 =?us-ascii?Q?S/eWdgsRc9txYJNBFDRVE3aCy8iKc5W0Z+qnvTEV8Ub0puagGeKdgr0VWR6e?=
 =?us-ascii?Q?Hkax9qPT1p0=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10526.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5669
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	32a2894e-5327-470b-af53-08dd89a52575
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FkTfP7n+YfnCAMMlNFLG9nsOPAQ9/yy7F9ggxXc+2YhqpjZg9avEY98K6QyL?=
 =?us-ascii?Q?Gjzeu824rQqTy3U4uGuCc4vwemWS+rhqY6kBPMyrXvgQ+0S578fbOEcyE3rU?=
 =?us-ascii?Q?hqB/p9zT+H4JSPqEHjnIXyG4pQkKdEMSk6f3HvTAdUEG+wlUDuYrxV6oQnPH?=
 =?us-ascii?Q?fOfRocTeal435etSc/eW4Jto8aben/5EIIOUCJZOLtmSxNGoZ55BWVXPE19v?=
 =?us-ascii?Q?w/hYr6sUei1JRB0q0/OB/rQF8RlhlXt6r6MA65yD8YIRS1coclvOuNfq0jh0?=
 =?us-ascii?Q?AXy5diS0oXl2ggPTjBbGxRW+BVlOTsCKRvZ+7rdtSIhAyz47WyOqCXqIo7dn?=
 =?us-ascii?Q?4Tn7MNGu0/QQRUGmXZFgWTlZOHzljsSjFjwPH7iD1zrl8LdeEnXmuF0c65ON?=
 =?us-ascii?Q?9qbn+WHkz3XAObBi/gjYh6wxoJv0F4gZLTgq4y43IMNBco5CCOYI6xw3IF22?=
 =?us-ascii?Q?OMAkSedjvtR/gQLuXrkIeP/cPXaArW1Z7FOP25o5U5K8B8ye3fu4bdeSAd7i?=
 =?us-ascii?Q?IeQdNZtwGTtLqUeTGepDPWSrAR5ApXuQKRMmh7wyfrb9I77tA2cRA4QNxILf?=
 =?us-ascii?Q?t1T3lVyHCSrSgioEp+IsI2MElcFrmraMhMEsbqDsIMITBotJXFqpxbH9rOjw?=
 =?us-ascii?Q?JQ7M7kwpWp0SZyqqsWUNjz0Plf9rqJ+QapqUlNW4JsvKc/CFLbs/6nS1m+Rc?=
 =?us-ascii?Q?jYNDghCYDipZLI0br1Gqq/Q9j96dM1zhRT6ykwiDiMcR4R5ZASi5ZjSYQgGV?=
 =?us-ascii?Q?pfgfdJ0N0vYYGbrZ1OwOL7mSk/+Kudea3e34lzlM4mWzr7m4ABiqfrrjp6xJ?=
 =?us-ascii?Q?ZYFvpoY8zY/E7py0a1X1LUC/mttkgcXCjewOxbYSehNG+6Kv289KhnusFIe1?=
 =?us-ascii?Q?pVzZUVngbDf1E7xr82Hf6ss6F3ya+NdTQyXcxJo4AvIoT3CiXyWz79wujZH3?=
 =?us-ascii?Q?g6K/HYWL3pj5dVdDcblxuWbALSdFPBGuJrUqDZRNXn035uEzVX1VUDOR7veu?=
 =?us-ascii?Q?kh52qB/4dJtcsigEdOCUiuYhRBUirsHOp8vlVfvn5bV8dNJedw2kwrSe+GJy?=
 =?us-ascii?Q?95a+rPpm2tnCDrRCJND3lqxF122/cFwwqaDSFZzzBt6rAPxX4cNSlxrrze3U?=
 =?us-ascii?Q?F8S1ViDYaNq7MWGph+ku4xHYxglIeHxCgnKfOzzvwtWU+08BokfTk1GYJcsR?=
 =?us-ascii?Q?U28j5SugNcE6hQIg+mcXaDE93JapM1fhRlRDs+SyBYRZyHBb8qruiN5xysQr?=
 =?us-ascii?Q?/y86NUb5eNJhEg+VCdSuxzIWGcdoNAO7DHHCI3IXstBGoMzLovVxdUQ8QrXB?=
 =?us-ascii?Q?CjvskgoMyfCwjzaG8yjmuNff/InvAxGvh9wEGx9b+JOIX8/1hzSIZYiCIovX?=
 =?us-ascii?Q?uGiFs//FneyvOlRnqBXcL60OUsebN9CUOriNLhjJb3TFxzHuea1eSWHLrqbb?=
 =?us-ascii?Q?/rW832vd5iPwcMyiE4//g6aseOFtBfiEenfSVH8V3+jxne9nQUUJ50xZsfEM?=
 =?us-ascii?Q?EqJUt/Ydv3NVZUhva6RjUD2L/ypU5gDl9m8w?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 18:14:47.6130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d577062-8e09-48c3-757c-08dd89a53919
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10198

> On Fri, May 02, 2025 at 06:41:33PM +0200, Ard Biesheuvel wrote:
> > Making arm64_use_ng_mappings __ro_after_init seems like a useful
> > change by itself, so I am not objecting to that. But we don't solve it
> > more fundamentally, please at least add a big fat comment why it is
> > important that the variable remains there.
>
> Maybe something like the section reference checker we use for __init -
> verify that the early C code does not refer anything in the BSS section.

Maybe but it would be better to be checked at compile time (I don't
know it's possible) otherwise, early C code writer should check
mandatroy by calling is_kernel_bss_data() (not exist) for data it refers.

> --
> Catalin

--
Sincerely,
Yeoreum Yun

