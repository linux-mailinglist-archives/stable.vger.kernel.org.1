Return-Path: <stable+bounces-139507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22598AA7892
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 19:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2021894875
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 17:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746981B85CA;
	Fri,  2 May 2025 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qGLEY+eD";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qGLEY+eD"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013051.outbound.protection.outlook.com [52.101.72.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D32B1A3029;
	Fri,  2 May 2025 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.51
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746206283; cv=fail; b=bcQ5B/fHN0ZQy6Y5bSdTq5jl3Y6XtPCsMTL6V7A3VIQwTB6uWJlq8L8s3cIchJx5lBeJAMLcdTrM86576oZP8VDIQ+NvCXzZYGqLZWrK5T3jwAF7zoBi1yoArfYMkGzCmRQv2dcZG/Wf6gUGx6KwWeH4MjLseZoEW8xZOU+N7LU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746206283; c=relaxed/simple;
	bh=Jn2MmRLstRUaFHF7I7EqL1Bohmp9wbqKs1nu42+5+OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ld7x69xryMXPzpgO8LZmyRoI1FHQtksAgBIGTjTiSKqEgqhjfSAEgcWA8S+ZRyCQ8EczaM9+DYiDQhOsoMU6EHRCZQe48N0J2DA9m9NurgN0jHGpv3uuNBfYfkeVB8FiPdwLy7v9A40+/ULKjhrvMYPg6E5+LlLDrEocdL9cWco=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qGLEY+eD; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qGLEY+eD; arc=fail smtp.client-ip=52.101.72.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UIH6wyRDh5zCdb3lsYbeWnViJz1eMVogxi1aGpEXepUxbdIE6cSgi9SuZalO8eJ67xlJqMtkRjazK8qcfWRcsUiaa7/2VorgrcEVaHJ/JpyjT1kNpIu9WJ8Ko+ogRxwHa4jWjVZH3HFexQKg4CZVGvktIvXe6Jhchc57BHkpwHstIvh0JIaO3zkWo7wiay0wmFpv9O2XNbXovtFHsyzRI5ZtNdiiVnU6Pfs45oCUAMu7pOaCHyK6MJR5NaEh2ggDx6KxakNTWaZqJH7YJdO9KVp0NUUePxkIjl9MBPkfgY14lxABHXC6PprGI2ld0LOk7RqbtFO8TfJJfb1vrHBrHA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxfqULrWfIRB1VeGp4MVpv7Qjhng4BShJHroQmnLGO4=;
 b=PsQmj27on6gXx0e/zoULUP3tLq7Im7BXDEISNROvtGa30Fc1VlIWnF1W2lnC0eAfWSVPyW5jwRleBTU+utlDyt7zgVjt9SbcJhfm1jpeVSekKbILLP2xrokBKZ/ornH7MH2Wx5CrUehXYwLGhTQIE2tx7+UYghH8eg6dudSRurZx0LLAkppQFjIqKL2ENeTpcPXeiF4eRnBZeNKIeNdyDHe2gG31rJsPc/eIMkQccv+5qE6czNElezkpG+h9i9IxP6osQQ+fOyS+DD0h21miA3qVdU5SNsjmNh/8fzenPVzOtAqJS/eCjG7iHgal/WtMByIhQ4GjZ/fcoPWC/FYCTg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxfqULrWfIRB1VeGp4MVpv7Qjhng4BShJHroQmnLGO4=;
 b=qGLEY+eD1Jcs+2DBR9UueLAN6CAAmik8+Odle+X5DtmHLq5TF+7TrowYH6Xa5lTxb72eB1Eixfy/L1QrZQOLgpyc8iRCGb1578gVdngCyEaa6HvRPzaQwdABK3qv5n3EMkbZ44eanYvlo4xvV3WSG0qw5CQN6fiDsmxEqF3YGnc=
Received: from DB9PR05CA0003.eurprd05.prod.outlook.com (2603:10a6:10:1da::8)
 by DBBPR08MB6251.eurprd08.prod.outlook.com (2603:10a6:10:208::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 17:17:54 +0000
Received: from DU6PEPF00009529.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::f6) by DB9PR05CA0003.outlook.office365.com
 (2603:10a6:10:1da::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Fri,
 2 May 2025 17:17:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009529.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.20 via
 Frontend Transport; Fri, 2 May 2025 17:17:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1Q9XH7F60bWjMoOv/h9rAnI7eNWQYOboln+J2Vksp2QK9JxIGepGwXFI5ulOs0VT2uPdYUtw7yV3fiWMo3MM7LpT99IxBU7sjO5FP9R8dIb1yfjob3/Vy0Rnn09u4KRdx3+8EO78H8FyFt/juMiTXWjPkTj0X4AJDSDyVRsGoWMH54YaPy4fyxGTV2v1HR51K3EPK9vRietKtyCQ057Ntxazs4JKO17BumSR/t9WcEhP6tVMxtBX/l3orArml8K6F1il2cGppQ5RBWBec0iWiLhgsteq4PtCsuM3qdjVBYCGQL5Ix4eRCZv1GVgi7bVnOrr9y11QP4UQ6xkS6d79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxfqULrWfIRB1VeGp4MVpv7Qjhng4BShJHroQmnLGO4=;
 b=OXw9u+wTKdgobmCDH/TfhyNiHv2xxiByy+onhFA8kJ5AL5vh0abyTsIU9cs/oLbTltmsE9LrarcyDZE+qPI9FtAX/5C3u8b2AZoU9xKC0nNbsjiQEtKZGVvhTFMvuVtyNjMGZRNpT22w0n2Dr9oj59Xa0ei8aP0PK3iQpHMfqf01/s8FZP38g+XLJCiLBPsXnwayQdmxGjPrNAz+PhJ4ai7pAVEsrJbVhMf8i3NtSfDjwP8Vo3klS7aG7S/r2QFjFM9ahFiNEILlCJuOVJDoykO6Z6ufpYhRlHR+MCfoYsvOcMc5KFgtECdYj45+bk+PWt8LJEHSHC9OXy8PLcuecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxfqULrWfIRB1VeGp4MVpv7Qjhng4BShJHroQmnLGO4=;
 b=qGLEY+eD1Jcs+2DBR9UueLAN6CAAmik8+Odle+X5DtmHLq5TF+7TrowYH6Xa5lTxb72eB1Eixfy/L1QrZQOLgpyc8iRCGb1578gVdngCyEaa6HvRPzaQwdABK3qv5n3EMkbZ44eanYvlo4xvV3WSG0qw5CQN6fiDsmxEqF3YGnc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16) by AS2PR08MB9715.eurprd08.prod.outlook.com
 (2603:10a6:20b:605::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 17:17:21 +0000
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95]) by PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95%4]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 17:17:21 +0000
Date: Fri, 2 May 2025 18:17:18 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, broonie@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, frederic@kernel.org, joey.gouly@arm.com,
	james.morse@arm.com, hardevsinh.palaniya@siliconsignals.io,
	shameerali.kolothum.thodi@huawei.com, ardb@kernel.org,
	ryan.roberts@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
Message-ID: <aBT+Hlp3h/9UFe0N@e129823.arm.com>
References: <20250502145755.3751405-1-yeoreum.yun@arm.com>
 <20250502162540.GB2850065@ax162>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502162540.GB2850065@ax162>
X-ClientProxiedBy: LO6P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::8) To PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PA6PR08MB10526:EE_|AS2PR08MB9715:EE_|DU6PEPF00009529:EE_|DBBPR08MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab0495d-cfb5-4048-14af-08dd899d45ff
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Czq065/0RfBeUH531Sj0lxap+0tEw/Q6KUl6RsjZuQDDfInH7Sh/L5gJ/BDf?=
 =?us-ascii?Q?qQ7shHfIUM+RkWw+u5pQgO3EfH7u3t81rC4u+q5hJZCBSsjWg+NSh+g7k1uK?=
 =?us-ascii?Q?eZwOicsr+IIIvwMiLCOjzqAXYA2WReYQzKrtODFMK+RA+87hALQ1VvUL7stO?=
 =?us-ascii?Q?Bg4yGjYaqseYrnM1C6fBuu+weZLWQYWktBnJzN5vswXFNybNRkEGX4IgOMzg?=
 =?us-ascii?Q?vWft7/CBzFFePVFGw04yCEb1jXTiG/nPf4CBVHwEZJcpN9tOZKdFGfRaP8+D?=
 =?us-ascii?Q?U5pkqRQakn9I7aIpvwAipjtoOp7i4PZwjzbIhmh8qfdlIzGtx2fMY0x0KqfU?=
 =?us-ascii?Q?4TBDMYr3uX9krjLUF9CO8h06oi+K24dlM2Kc0ndZlL0mdG9vMyaTlkzSrUJT?=
 =?us-ascii?Q?KA1MzbWmgKnXkjW+oBGRthL0XcXff7ra5q85ZEr99PaosqEmdiUKZiRqIllx?=
 =?us-ascii?Q?QtRFyMEQ1Tmc7P2+wuKsu0C2bcXrT0MvijF55dQlpNnEWZSCd3ObVT/9lqG2?=
 =?us-ascii?Q?bN6ICnBmWcbr/VPkfVICjgk4ZmZgEdNGZ7//kNss6R0cc1ctggHYtr/sBu0l?=
 =?us-ascii?Q?XHIMt5as4zM6/Vk7aoPxCpPFeccIcOcxgGqPihkWjuKV+iVEfnDDgK+DamFK?=
 =?us-ascii?Q?OKYV144Q6tFqAakV481nx+znRgou9eJdrXZYWXjvIbUvlsF0PRBpzs3wnSmY?=
 =?us-ascii?Q?YHnLbXhjqzw4TAfMw7YlyNmfzSrTISMbk7rMO4tpysAZv7cQYtAULptbkJNW?=
 =?us-ascii?Q?5aaM7uqyqwsw4GYXv8sS2kTBHYLveXrk4f0RK4UGAI8sO+q77f8pb36bHSDs?=
 =?us-ascii?Q?poaqEt+5FaX86GSsGNz2OCPeY+TBfeSqG2umAx6iPljsA1TqhgCv6ed+TeYr?=
 =?us-ascii?Q?MnUfozM85msB0Y+Q+wMawYJD6sXY07jI02zXkjbkvFgpNcbehE3fDDvVHH0P?=
 =?us-ascii?Q?dlyG5AV5/WABtrLFPsgA68j/7KvUHV43qnEce6aNYfRF3NC5r1QzJ/apC7px?=
 =?us-ascii?Q?qe5JQ87AFtPIH/TKTY/3p06lCGWQC198o2rMcFmiOX+l/+zMvzDzPNqJAp52?=
 =?us-ascii?Q?YBbQl/JPchzZrWx7uCF+gfD1AC5I2Lt6MCkMNzxxdzXX6lSGX0bN6QE9nLhP?=
 =?us-ascii?Q?FBJE9P9PtCF+YS0uoMpSD632mDHIBsUC0inJENeb3wP6EytFUTQiv/9/IJSQ?=
 =?us-ascii?Q?Xp8iIpVTlNBiAJ+yZf3gWJB0UVvXB3f98NQLzTayhIOiFvKpMugtrnB4+CMY?=
 =?us-ascii?Q?E5sSPX9AtQgCoDTata0ubqIuCfyLBSYWXGB4ZZuauQvqJZ8pZVGohUjS4JJ6?=
 =?us-ascii?Q?RyxsoIsADt8ol94C/3SQjQs2TfrlUObQj6dCh8E2RcyVIE4fzcmdBiD+99e+?=
 =?us-ascii?Q?bpjZm+bEXriEIz3aMQ2I2fBeOvaKfQJDgLpCCKNslUFI74r8V+Ghiwve4oyU?=
 =?us-ascii?Q?d6VhqQ0hwaE=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10526.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9715
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	89be4d63-1701-4705-5f71-08dd899d3298
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|376014|35042699022|36860700013|7416014|1800799024|82310400026|14060799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tw0IN0JBurEpNaG0/G8bLBj3JnJ6rJOOSC2qf7bBBm+mMeC1t5JyLgeQnw2a?=
 =?us-ascii?Q?4RWAy+f0ihsb0jL7b0LYVLQrwFySVopNZSRCCeBliCqLDQ+T40lfKwZt5aPG?=
 =?us-ascii?Q?vRUI1wClN5QImqo5L3gdW4gDyXEI0LcnVqEcifxlmkoMnojH6oevIQVoh/1c?=
 =?us-ascii?Q?lCFK4+ShTR9s9GZWR02RXb/iDrOVNpvyKfscbNdTvZ+/elg94KT9FZuOLavv?=
 =?us-ascii?Q?eS8eADCjJcuRNOi6IxZGluVj8rZrUC5MoVm9RF6xItw73FVI8vrnQLjTtqvZ?=
 =?us-ascii?Q?UNLdTUzYO9cKfJ+xWyDm6enFmAVzZpZh8aJShFsQz1tfx9cyMJrExY8A0eGG?=
 =?us-ascii?Q?JAts5dP9jUiAo898hJXV38zMpxc/cRcSw/vFDvtkK6xO6+e68cMJTGXTSQuW?=
 =?us-ascii?Q?/lkQEUYjC+ANQTsTLwoGcROQgMJMZiRdXFHZ5k4gVQquBM7IDNv6uVS7M6tD?=
 =?us-ascii?Q?4/H4z2nX9Rq1Cx35HE7ZAiRrqCU0XHr2ZNM6fS4KDxxUi841Fw6ev/huG11a?=
 =?us-ascii?Q?LLsTF9plMEksEIlk7xUDqGdKFMFPV/Aad7Kxc9nuIy44MQvJdO+2G3PknI9J?=
 =?us-ascii?Q?vIzgcqJ4pxFjQBSphemY1aLSLq033oYx7FazKwpoaM8ciCX+a+CQ7nvmWgcY?=
 =?us-ascii?Q?GxceGkvsO1tYv5FpPHC4GhxU6R9dCS9JH3jEW+mrsav0Pk4iAKeqAtOcyzp/?=
 =?us-ascii?Q?uosbAyYUGJ8LLHHrq+aNuQxka7fcph9cO8h2RhpLUtrSqFOFutASfUekyC75?=
 =?us-ascii?Q?hG/OGF9zaKuK8/wmbp41/pM1jt1XHkFKvLRVQ1nF00uW4rvYbe1guIaUc4cX?=
 =?us-ascii?Q?sLa1YAwcmC2juNlmwpN71fzW2amwX9jcCbNIp1ltgEGl2MPPTdpPE5xd0r7d?=
 =?us-ascii?Q?IffcdyOEl1QWfZGWsG4JJTdZBnmBHXWsws8eSoaXavIHFQUV71tHJlKtTumk?=
 =?us-ascii?Q?pk3GP4Y5tbTtYX6GVeD7XMCNEMEtlPjczVeMy25ng+z0SGnfdBhILEepJaAR?=
 =?us-ascii?Q?U3FPaxkgXgRwT1x1yCkqVE4s4GndhZZNWvBJqBDogDiYHcZVg/83mlDyO0jy?=
 =?us-ascii?Q?X0LMAF12gbM7IpEJ1rgtdwXjZCXj7C7mUn2gb/qgZTPL3XYf7UUKsywLP9HJ?=
 =?us-ascii?Q?ec9+ueO0zpt/OVUdSIOlrMxTDAQpBWVn8x0OpidS0ASYsm+sBkeQNQJ34wXU?=
 =?us-ascii?Q?L2TjghsjUEqDALYO5lJB7CzOOFhDFJVdeiIH74gkdz2tiJXLMjSQOzhWlcRM?=
 =?us-ascii?Q?YyHKHy/+bAR/FBx8kkjLUdav1y3nRwCQAEdMMOB1eCqyc2nPuocI/CvQpSyI?=
 =?us-ascii?Q?oBgR7N2/IKJvpHiA9tktp4GP9O6dF+qy/Xsjsi6idnF9my3/owiO9DmmEFtP?=
 =?us-ascii?Q?74DCR/UyNg1aIGol/STMRh9LWu1Hrt9tfQBIFIzGrXhJvPGOc7iisWFFwITm?=
 =?us-ascii?Q?S/7jqmCNJRow3dauQ6N/Q8vaT0FyYQKpJjXicuyAZRbUlqPQ2ZIcdmUMfDcY?=
 =?us-ascii?Q?HRfOmNzcEOXixJRnFXsvqS3p1Db6s2wiKw2kZW/mOUygDSvsLlAzNS0ajg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(376014)(35042699022)(36860700013)(7416014)(1800799024)(82310400026)(14060799003)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 17:17:53.2648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab0495d-cfb5-4048-14af-08dd899d45ff
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6251

Hi Nathan,

> Hi Yeoreum,
>
> On Fri, May 02, 2025 at 03:57:55PM +0100, Yeoreum Yun wrote:
> > create_init_idmap() could be called before .bss section initialization
> > which is done in early_map_kernel() since data/test_prot could be set
> > wrong for PTE_MAYBE_NG macro.
> >
> > PTE_MAYBE_NG macro is set according to value of "arm64_use_ng_mappings".
> > and this variable is located in .bss section.
> >
> >    # llvm-objdump-21 --syms vmlinux-gcc | grep arm64_use_ng_mappings
> >      ffff800082f242a8 g O .bss    0000000000000001 arm64_use_ng_mappings
> >
> > If .bss section doesn't initialized, "arm64_use_ng_mappings" would be set
> > with garbage value ant then the text_prot or data_prot could be set
> > with garbgae value.
> >
> > Here is what i saw with kernel compiled via llvm-21
> >
> >   // create_init_idmap()
> >   ffff80008255c058: d10103ff     	sub	sp, sp, #0x40
> >   ffff80008255c05c: a9017bfd     	stp	x29, x30, [sp, #0x10]
> >   ffff80008255c060: a90257f6     	stp	x22, x21, [sp, #0x20]
> >   ffff80008255c064: a9034ff4     	stp	x20, x19, [sp, #0x30]
> >   ffff80008255c068: 910043fd     	add	x29, sp, #0x10
> >   ffff80008255c06c: 90003fc8     	adrp	x8, 0xffff800082d54000
> >   ffff80008255c070: d280e06a     	mov	x10, #0x703     // =1795
> >   ffff80008255c074: 91400409     	add	x9, x0, #0x1, lsl #12 // =0x1000
> >   ffff80008255c078: 394a4108     	ldrb	w8, [x8, #0x290] ------------- (1)
> >   ffff80008255c07c: f2e00d0a     	movk	x10, #0x68, lsl #48
> >   ffff80008255c080: f90007e9     	str	x9, [sp, #0x8]
> >   ffff80008255c084: aa0103f3     	mov	x19, x1
> >   ffff80008255c088: aa0003f4     	mov	x20, x0
> >   ffff80008255c08c: 14000000     	b	0xffff80008255c08c <__pi_create_init_idmap+0x34>
> >   ffff80008255c090: aa082d56     	orr	x22, x10, x8, lsl #11 -------- (2)
> >
> > Note (1) is load the arm64_use_ng_mappings value in w8.
> > and (2) is set the text or data prot with the w8 value to set PTE_NG bit.
> > If .bss section doesn't initialized, x8 can include garbage value
> > -- In case of some platform, x8 loaded with 0xcf -- it could generate
> > wrong mapping. (i.e) text_prot is expected with
> > PAGE_KERNEL_ROX(0x0040000000000F83) but
> > with garbage x8 -- 0xcf, it sets with (0x0040000000067F83)
> > and This makes boot failure with translation fault.
> >
> > This error cannot happen according to code generated by compiler.
> > here is the case of gcc:
> >
> >    ffff80008260a940 <__pi_create_init_idmap>:
> >    ffff80008260a940: d100c3ff      sub     sp, sp, #0x30
> >    ffff80008260a944: aa0003ed      mov     x13, x0
> >    ffff80008260a948: 91400400      add     x0, x0, #0x1, lsl #12 // =0x1000
> >    ffff80008260a94c: a9017bfd      stp     x29, x30, [sp, #0x10]
> >    ffff80008260a950: 910043fd      add     x29, sp, #0x10
> >    ffff80008260a954: f90017e0      str     x0, [sp, #0x28]
> >    ffff80008260a958: d00048c0      adrp    x0, 0xffff800082f24000 <reset_devices>
> >    ffff80008260a95c: 394aa000      ldrb    w0, [x0, #0x2a8]
> >    ffff80008260a960: 37000640      tbnz    w0, #0x0, 0xffff80008260aa28 <__pi_create_init_idmap+0xe8> ---(3)
> >    ffff80008260a964: d280f060      mov     x0, #0x783      // =1923
> >    ffff80008260a968: d280e062      mov     x2, #0x703      // =1795
> >    ffff80008260a96c: f2e00800      movk    x0, #0x40, lsl #48
> >    ffff80008260a970: f2e00d02      movk    x2, #0x68, lsl #48
> >    ffff80008260a974: aa2103e4      mvn     x4, x1
> >    ffff80008260a978: 8a210049      bic     x9, x2, x1
> >    ...
> >    ffff80008260aa28: d281f060      mov     x0, #0xf83      // =3971
> >    ffff80008260aa2c: d281e062      mov     x2, #0xf03      // =3843
> >    ffff80008260aa30: f2e00800      movk    x0, #0x40, lsl #48
> >
> > In case of gcc, according to value of arm64_use_ng_mappings (annoated as(3)),
> > it branches to each prot settup code.
>
> > However this is also problem since it branches according to garbage
> > value too -- idmapping with wrong pgprot.
> >
> > To resolve this, annotate arm64_use_ng_mappings as ro_after_init.
> >
> > Fixes: 84b04d3e6bdb ("arm64: kernel: Create initial ID map from C code")
> > Cc: <stable@vger.kernel.org> # 6.9.x
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
>
> This appears to resolve the issue that I reported to LLVM upstream:
>
> https://github.com/llvm/llvm-project/issues/138019
>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
>
> It does not look like there is anything for the compiler to fix in this
> case, correct?

No. There's no need any change in compiler.

Thanks!
>
> > ---
> >  arch/arm64/kernel/cpufeature.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index d2104a1e7843..967ffb1cbd52 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -114,7 +114,7 @@ static struct arm64_cpu_capabilities const __ro_after_init *cpucap_ptrs[ARM64_NC
> >
> >  DECLARE_BITMAP(boot_cpucaps, ARM64_NCAPS);
> >
> > -bool arm64_use_ng_mappings = false;
> > +bool arm64_use_ng_mappings __ro_after_init = false;
> >  EXPORT_SYMBOL(arm64_use_ng_mappings);
> >
> >  DEFINE_PER_CPU_READ_MOSTLY(const char *, this_cpu_vector) = vectors;
> > --
> > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> >
> >

--
Sincerely,
Yeoreum Yun

