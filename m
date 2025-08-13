Return-Path: <stable+bounces-169335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED68B24214
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 08:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7035A06ED
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 06:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FB82D29DF;
	Wed, 13 Aug 2025 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZR1OXq4I";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZR1OXq4I"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013003.outbound.protection.outlook.com [40.107.162.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DB52BE021
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 06:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.3
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068252; cv=fail; b=mSXiYk3sudAxqlKJ2ARv0O2bS1s1nBP/MH/XaufQdzyCbyVm+09zVscC7YnN2FyIYzJ3Da2XD3bFcd4DqBaHKlRowI1dSU/Co05LIgJKmCE0eKPXfuh29mn4cOmkcuJ4lR7mK541N7tbMPvvq1yVd+x9wLAQfOOSCQ3TzWi3n0k=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068252; c=relaxed/simple;
	bh=7JUJ5GSOBuTnXRyAkjq5MY50weNpojm1dNWs7uHmNTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gJkdDAd+nQIRNpaD+x4oD2jOVINfmbPDrTuHobDncjycSrurKPe/F9oJVYupsPyZPgSHsentj5lXLp734+/JYjQYUgiIVSS/UGFZSh5A1oD1wYE1/RNfokXwL5diC5F7I7u4GfgfZtMALt070Ibu/T6Jwf7Z0RaE4JGZQIrbkbg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZR1OXq4I; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZR1OXq4I; arc=fail smtp.client-ip=40.107.162.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yShZTW8kBkM0C0pp6xhaaCWdQOj7NooWEWIC0UWhkP0k70fW5i1QpPHk0HIPiGV1JY6mXT3tON3o61xLzn7x81RNDaDQiy2KvIBwLyOXjUFOqY7Vof2gg25oo9yyjSNOO+Kgl+FhUS7jafWIF3UX3aHEK2+5D4Zv71qOEARD7tGp9BydhK7b9h4Uas0zrT6f10vM7Z4GvkhgJfj978ClyQxOy0jClW2fhvMiCDuq1Afcxj0/4O2qKNtp4bxuIVGyU2Vsh2/5iKnRBMR8AooLuf3Gr73fjXz5e45vV3cNW8cOTnzA2J74efnOT2NHcRKX1bXOZJamSCGACtlRVp08NQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANNzez2+A72pY6Li6PUxeAaCTICHgXuRUhiFPeC6Bhw=;
 b=r0w1PRC1+n7AoAIeC7HZVj3cgmMFHJZWdu7Q3kPKbZanhpkg/ADGKM/QBmUfRY2jKDhaDqrWzuIVToW3mY57TjZnAUUztdnYu34Izk2fVVpZzFi0n3e4Jk0C/8Cx9rDU+iwCIidjO7IgA8xj3/8LBIDViwpx+mIiFWbtZzKS5Ll3UHF6JuQMXQE13w1ZpO3c/vCdd47827WdFr6ymPsCI8pyBB33Bp0P1ME4rszslw6dFy//oBzUIE4/LUB96YHBGqGgI6qXnrrj9j8a5tSlhSNOi8wCnzA5l9UW1dVkaR9HHglRQ8XIK2g3CkHtJrgiIXk6zpr1FhUklw7hF+sAmQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kzalloc.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANNzez2+A72pY6Li6PUxeAaCTICHgXuRUhiFPeC6Bhw=;
 b=ZR1OXq4I7Q4UnNdsd1j/1vDp/bkhOu5isaCyDi5t3nM16dkyp6FCs1/qZmBLSASjWcBpPAQBuHnLzKccFDk3+NQRPj26o50fU7npOpLV0Rl1aZomQgWAZpcqNaiVTRdrOZyHovMCeEijnb7/GTmq+Mqk4UzrfrocNuKtBGbqxaw=
Received: from AM0PR02CA0167.eurprd02.prod.outlook.com (2603:10a6:20b:28d::34)
 by PAVPR08MB8967.eurprd08.prod.outlook.com (2603:10a6:102:326::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 13 Aug
 2025 06:57:25 +0000
Received: from AMS0EPF000001AF.eurprd05.prod.outlook.com
 (2603:10a6:20b:28d:cafe::49) by AM0PR02CA0167.outlook.office365.com
 (2603:10a6:20b:28d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 06:57:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001AF.mail.protection.outlook.com (10.167.16.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Wed, 13 Aug 2025 06:57:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jf22AwKQfV3TpcKaco0kG17OcC+FcMmXZ62wv+UkSTjLFvNY5orZ5KeK3gTI0GhXnW3g3FUr5Su+ecO+z1680Yy+T2nehb2WsyzSq2iAOC7t2YFlV17cLjngyW1YMWu4l9hxS1/OtTjhY2+EYaG+7alSLFvVEGrgU+uNNMXEr4jcDoNxbNiKfJxnmh+xt6tnQElJyIXVBITaeN5yK3qhbzuuFh3+STj0Z6qs+WtnX1UEVay/NULUNXiGKzfkR3eWm/jjdAO8UAcwCk3qkBmUAbHLZo8BqC4fT/htQJwMnS+rhWdDFyOzaGLhxKLL6sJcRX/YFjr1BUvhvVNttYuRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANNzez2+A72pY6Li6PUxeAaCTICHgXuRUhiFPeC6Bhw=;
 b=EULFpBVhPV7KPZ52p/iAGlt2ElB1esw7KTD7XQ1q1qgh9Ih2C2yULstsz+RGaDNNzOPqxf2XuqXxZl/eDYQLtUiJ+v1fGOaDZDfBarfkvVIgtAN1LPUxopBcdGK3osk2s0DS7lua+MK/8qx1Zk5U6k6DP5DMSfyqcwz/j/VYNjfeUiKGbYQy5zLrEC5FChlDtdDk4lOHZxGh8xBpdt/XbcnS+ewsgjMrdJxyXJWp7CGOlYZKbH56ybvwfisKBNNozsD+evUq9+iPrR0/FXiLhSTw2L08XtvKYvVv8MaipcbsZgBvpri2UdIRNGf3n93amutQ47wY3eFWUQtiB2VjWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANNzez2+A72pY6Li6PUxeAaCTICHgXuRUhiFPeC6Bhw=;
 b=ZR1OXq4I7Q4UnNdsd1j/1vDp/bkhOu5isaCyDi5t3nM16dkyp6FCs1/qZmBLSASjWcBpPAQBuHnLzKccFDk3+NQRPj26o50fU7npOpLV0Rl1aZomQgWAZpcqNaiVTRdrOZyHovMCeEijnb7/GTmq+Mqk4UzrfrocNuKtBGbqxaw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DU0PR08MB9680.eurprd08.prod.outlook.com
 (2603:10a6:10:444::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 06:56:50 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 06:56:49 +0000
Date: Wed, 13 Aug 2025 07:56:47 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Austin Kim <austindh.kim@gmail.com>, linux-rt-devel@lists.linux.dev,
	syzkaller@googlegroups.com, stable@vger.kernel.org
Subject: Re: [BUG] arm64: Sleeping function called from invalid context in
 do_debug_exception on PREEMPT_RT
Message-ID: <aJw3L7B7u5qAPOMz@e129823.arm.com>
References: <c36e8dca-d466-40ad-ad51-2b75e769ff47@kzalloc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c36e8dca-d466-40ad-ad51-2b75e769ff47@kzalloc.com>
X-ClientProxiedBy: LO4P123CA0692.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::15) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DU0PR08MB9680:EE_|AMS0EPF000001AF:EE_|PAVPR08MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d003ef-38a8-459f-cfe2-08ddda36a7c2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?pRgRizlifORx/NSHgjIvRAMrnPBP5uEAhYgZQ+HN8Mdqm5d1NtjlgWU/xffT?=
 =?us-ascii?Q?zHcH3KhfrLogWDesbqzhdupIRkyph7gSHiWaUyb1SqHKp9cl+E1f2c2s1dY+?=
 =?us-ascii?Q?yJE2f3PMx6urfx4owVe4ykieZ/aj/cnu+e5z4FYEugj/ztnxQH0WXYExrCgN?=
 =?us-ascii?Q?+xKEjNwNYD5H3wULUsbYKUd6jDey5AJja6qe5E35alcGMkqUvyfTJ1uYAHcM?=
 =?us-ascii?Q?KzzjMruNywhrh0/HtvFe8oMThiI/ZfviyR7Y3QW4a0mUiI+PgIJYZgcyvZ2c?=
 =?us-ascii?Q?irKFDX55UsuaGcvkAv5hGi/MnzNVzs245UnaPXLBiLjcDESZuZSJWRYgHIFL?=
 =?us-ascii?Q?Dih0dByJkf9QqlUYvBk3pPdi9fhW0SMDo3dfCTFDsCbL0umaxGSiTfgsme1a?=
 =?us-ascii?Q?8UhArJekbxjPfz3BACIRQoZEpn65tR4bQx7QAF3r0HVcj2xByvY5mS2nbqRP?=
 =?us-ascii?Q?Ic6lJL9HhsG3hv4faPI7z9dx5xLvCazTRaaGIkZ183EM13KrLvwC+2nzQdbc?=
 =?us-ascii?Q?rcXzdOKIjhim8HBDv2P47xTJqjhJr7xyrsdLklOOnfCfSnKSWcedU8D+GonI?=
 =?us-ascii?Q?Zhh5ku8BEirF3CECsQ/VhLqx6muYJy60QCHUh8zayNrCkTLhl5iRU3JLK7rM?=
 =?us-ascii?Q?8+tWvnn79Ch6Y4In5k0PAhUN3QrPyZISAZrJd0fmKH97MwFNy/8ZkZt7qSHj?=
 =?us-ascii?Q?L3SQke16W5UNiSTvvi+iheHCuEV0QlI2xO2a3sjls6WBGCor79IrIuFBxjWp?=
 =?us-ascii?Q?DtRJHyZJ3XQ/Pnggv1ZWdsrGW1gvx/U/Aoe+mkYt8YjtGkw2giYvqSwxQNgv?=
 =?us-ascii?Q?SutbM73EJ0Ms88kJ+PR+OlcVPM5Vj/CHKbnddjGNOgFUWtMckbf/iGpMNWXq?=
 =?us-ascii?Q?dwCrAEvUiL02U+uL4QIX0x7TDZBcvt2MZu0i378pcBzWMs6pXQ6TFybOEP/M?=
 =?us-ascii?Q?qvFv9mhB4tNo4PrrCuM9tqqBbAEa40glRKIRHcIM8+cEHWrMXdvrxvjhuyr1?=
 =?us-ascii?Q?6VtkN7kKNziQYmSJdRL5Fi+pBX8a90QgRwWjf1HXGvn33wNt36sQd+G+Ayl1?=
 =?us-ascii?Q?bAbKNSe34FaDJ/TzkWwzSlKzxg6XwdUthVBrWvoYoy43K+QKiyOYVceKaDu9?=
 =?us-ascii?Q?Ff8G1IxMrOTAlem9xs+o/kpySc2wYRYmdTC8Nz15/tXalrSn/LHrcFcphtZ/?=
 =?us-ascii?Q?oD8PuGPtBSFb98wfLD4BvDu5vhV6/svy1PiyZNMzi4m93VegrQnOWVZT4OHa?=
 =?us-ascii?Q?oZeWyLk0i/4cWtzaUGLkfCNOosJNIQDuZL4YEw78OUwqbSobgwEOo9zARgYv?=
 =?us-ascii?Q?e0rulaPaVkPLyO464fnBvjS+4v+43/b80D33wQWWQY6Fq6cdrApjmqiPgMH5?=
 =?us-ascii?Q?+VVZHVAnUbfavloQuBOEBH21ppBfFcg+H1gUpndikMS0crXRnEKfJ+vn51zs?=
 =?us-ascii?Q?NRsL72IWI4I=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9680
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	86f4ab2d-3c41-4b82-e505-08ddda3693af
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|14060799003|35042699022|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WyOhCmuwUMNjF4axEVETzWMTQo/1cvcPcc3g35Rx3URNinX0QM4kwUMuvHUZ?=
 =?us-ascii?Q?xYhayak/BV9NjwIV6K6hUshtbic/bClsx6DreBAhGgjmhY845MQCzvwwcjGI?=
 =?us-ascii?Q?T3hbbIGCstw/vMBjOF8Lgb912aJdY9gBpAbPXzq7y9zMatohLYPtLFhAJ6wH?=
 =?us-ascii?Q?AHFi1hwmjaTAdsL/nxg8VQE6TbTle4k0kD73Ys22p8VbWC/b9RN9+GJcEBtK?=
 =?us-ascii?Q?0HOIf78P59fLWVrBYLEeVoTeZsgI7rjdHYMqv7EQhy5Mdb2xnJhOh8myZ/4n?=
 =?us-ascii?Q?LhMX9AdcubencboLIgrHfUnq2jBBgUonf55KQ8s5r0J4MGU7A4h7yOEXq0Zu?=
 =?us-ascii?Q?K3GFPX+PoNY3w+wXgcVdgeSa186J6Xkecv+SpRZw3N2JUvtLE3ZUKY9T8Ss2?=
 =?us-ascii?Q?mKiCKf7DcYLBJCJC931mSMjWpeTuehwdjPIxsr4tbDeTlVgYiT+/Agn1Ukt6?=
 =?us-ascii?Q?veXt7r2ERJLnUsga15RASU09JeNoSaR5TX3IAzKR8trhYmLTgi3zqhlU448S?=
 =?us-ascii?Q?biYSZYwioRKo3hTuQQ2LMIBVQZpMJEcv48kpGswm8LJr22dg29WJ1teYC8x4?=
 =?us-ascii?Q?FNEisPgpV4gWBpej1fVYLOLzpcpdPPkXksU/uUaDbTDeWC9mm80rGjNAAjnE?=
 =?us-ascii?Q?1UFma1Q2xkgbNp06BX/J0nN0NclduSGApJ/h3kcCLzd3D6niWqJcaA4xcrlv?=
 =?us-ascii?Q?MwFXZ5ApzW3qeb7JJLl5DRKsbOjn6tfKa6cU2GHY9YWSOE/ICqyhsKcZqBqq?=
 =?us-ascii?Q?MRyrOGDjp0n+JSLkpfAlwAJfj7gKSgJLXrsyROkqTPoT3IRNcZYwrHYRvxjI?=
 =?us-ascii?Q?o/WN22F/kQSveWzLJnbiCNpRZrTUwgbqxBNPJbDdIPI16+eaBuipmAul8+M+?=
 =?us-ascii?Q?QiN+n7GqhOV/qoZ6btw4jMAyQL/8VdWaltli9RiC3osfn/mogMi6CAr6jJ2O?=
 =?us-ascii?Q?BGhIz7VjZw6MEFKuTeQidSxo2HwxEfihZNG+0YkmAZA4MViRULUrxNEYJciG?=
 =?us-ascii?Q?wqTKg2KOJtQ0z6YV8zn8hLQBI0kopc9cB1dKBlkiZlNkMSRw/ngV9iOfjWXs?=
 =?us-ascii?Q?QG30Diz7WxTQj97w9Vt46J8+P5Mtl+v5UZBBnXnoZlTnDDlayLXH6HfdkL+9?=
 =?us-ascii?Q?ywgoswMACnmopWo9TAHpW5/NLaM1IVOPHygLa8RZczn/JbxWdduVna25X+Nu?=
 =?us-ascii?Q?6z0qAehpFANdqy1Kw3YXxDdVrE/wJQq7JPkQzDtGXEiuf+IyZG21jVmMjwN4?=
 =?us-ascii?Q?goxzXiIIyiEsbHZWFE0el2K+JJTlBLVo4pXoVqJqmFqCagUsNgae9Y99YHDw?=
 =?us-ascii?Q?PugEButqdF4Zkr/IUeFBurnJFNf7OD26WYPNSfa9snPMHNLTm+Egr7XZRQHZ?=
 =?us-ascii?Q?yhS+kAtjnpU8aw3GScn4hI77V2eZknzl+tI7/1iMPFOcwnidsZUfOal1vslB?=
 =?us-ascii?Q?viFX1NhXfr4wPnX2+qZY1e2FWywyIaJRi4k88QzQ400aS6ePxStn7Wf/MmB8?=
 =?us-ascii?Q?XG9G3lsMz2bDlFRkvdYVFqYVi8OCQh4yQHxUO/pl/ANAb4vEsV+xoHdGQg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(14060799003)(35042699022)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 06:57:23.3197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d003ef-38a8-459f-cfe2-08ddda36a7c2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8967

Hi Yunseong,

>
> | BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> | in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 20466, name: syz.0.1689
> | preempt_count: 1, expected: 0
> | RCU nest depth: 0, expected: 0
> | Preemption disabled at:
> | [<ffff800080241600>] debug_exception_enter arch/arm64/mm/fault.c:978 [inline]
> | [<ffff800080241600>] do_debug_exception+0x68/0x2fc arch/arm64/mm/fault.c:997
> | CPU: 0 UID: 0 PID: 20466 Comm: syz.0.1689 Not tainted 6.16.0-rc1-rt1-dirty #12 PREEMPT_RT
> | Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8 05/13/2025
> | Call trace:
> |  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
> |  __dump_stack+0x30/0x40 lib/dump_stack.c:94
> |  dump_stack_lvl+0x148/0x1d8 lib/dump_stack.c:120
> |  dump_stack+0x1c/0x3c lib/dump_stack.c:129
> |  __might_resched+0x2e4/0x52c kernel/sched/core.c:8800
> |  __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
> |  rt_spin_lock+0xa8/0x1bc kernel/locking/spinlock_rt.c:57
> |  spin_lock include/linux/spinlock_rt.h:44 [inline]
> |  force_sig_info_to_task+0x6c/0x4a8 kernel/signal.c:1302
> |  force_sig_fault_to_task kernel/signal.c:1699 [inline]
> |  force_sig_fault+0xc4/0x110 kernel/signal.c:1704
> |  arm64_force_sig_fault+0x6c/0x80 arch/arm64/kernel/traps.c:265
> |  send_user_sigtrap arch/arm64/kernel/debug-monitors.c:237 [inline]
> |  single_step_handler+0x1f4/0x36c arch/arm64/kernel/debug-monitors.c:257
> |  do_debug_exception+0x154/0x2fc arch/arm64/mm/fault.c:1002
> |  el0_dbg+0x44/0x120 arch/arm64/kernel/entry-common.c:756
> |  el0t_64_sync_handler+0x3c/0x108 arch/arm64/kernel/entry-common.c:832
> |  el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:600
>
>
> It seems that commit eaff68b32861 ("arm64: entry: Add entry and exit functions
> for debug exception") in 6.17-rc1, also present as 6fb44438a5e1 in mainline,
> removed code that previously avoided sleeping context issues when handling
> debug exceptions:
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/arch/arm64/mm/fault.c?id=eaff68b3286116d499a3d4e513a36d772faba587

No. Her patch commit 31575e11ecf7 (arm64: debug: split brk64 exception entry)
solves your splat since el0_brk64() doesn't call debug_exception_enter()
by spliting el0/el1 brk64 entry exception entry.

Formerly, el(0/1)_dbg() are handled in do_debug_exception() together
and it calls debug_exception_enter() disabling preemption and this makes
your splat while handling brk excepttion from el0.

[...]

Thanks.

--
Sincerely,
Yeoreum Yun

