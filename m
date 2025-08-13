Return-Path: <stable+bounces-169354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA2BB244E0
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 11:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB961890E64
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 09:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39F020E023;
	Wed, 13 Aug 2025 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="o9cFN2nj";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="o9cFN2nj"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013068.outbound.protection.outlook.com [40.107.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993582EFD9A
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.68
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075592; cv=fail; b=bkhIDl7QE/ogV96R6unlN5V3YH8C+1R0MeLYYBK/19enSFlU01kNsc+fshumtIy12wgC6/TO090CHC7+t5ZywqoQP8XN129nAQJMYKX4/o/bLI5LvYJb+KKQFB+lPkllL1u0A/PCbiTVBrDPy4gjNW2oaTi0j6CmX3pkGKcXLV8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075592; c=relaxed/simple;
	bh=9FLFttO5MxCfkXjLBuPljhNPtcLngWZ0FxyweSm/GVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QmOoqC3xUZS37pRfXUMv/2bFMOg2kNOyZ7bbuQIhf+DmCUPtquY9SJDMX4xMnsLwTgIcnn5p0bQOPWevSPq68mUtJQEDFX4iTYKdUJKPSbJuM6Kzt01n5fx0w+m40XQlz878kyK2/jf9Kggrt1IijK7PneRN/FtRiFb06jgdf08=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=o9cFN2nj; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=o9cFN2nj; arc=fail smtp.client-ip=40.107.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=AsUGtTRZyzlXFssLviLNoNRc08XRlti2bEWiXlVjz9y2JXtqq2ak6LkYU2XddLRx03qMkg6R+PeYSwlpoNoujOFjEnD1RJbUBzl48PQxYBHzbbRatDlKGnqcwlCSgSSmRjH6ORrDK2f6Lf/VXPGGGk7AldLtn8aMjcEWeN7IeOxaBRV6MH+6gI5JOcMcmfi7jCbcgDRoJXazXNyJ42SY+7sQTTWwuyMMS9nc+rhaKQ3uL8C5IPzIxpQQmXuaKkwPaUqfLJoTL1kFfA93jaYRt7fjUL0vpmZy7t5YDygZfVEUaO2u7Ve/otFNM5yVfss8AxPpnWfdPJ3pI+wZlf2xzQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxELzs+seD38/oNv8EFjL6mxnNrWl+wikfOytZY45oQ=;
 b=ia+HVIgLtTtiVWxG5CkwhMV9yGF47Zkmyv4kAGPLjR2GPLDHAXYnME1eRDeBh4xp5tpKHyRMJME7Vbl0nITJXLXKxCK1Gx8IfpayBrPsqUYdLGKzySdSnUZqNIf3jVehBXHYUqa1ZdKwrAL9HeHr5gL68a2THHIdqYO55lW5KolFY17HhuZ9hcfRWuU8daf8SdfWdq7pPGQiHfAL7H/tjwXwrYdPkLgjhnaTLFCW5j79SwTvhEKPI4dr9fQFwucZYUCMdk6kJQCEGbS2MKeq07UvREmLV8MdNaBxercvkBRily6TpHzTHTanOEqCbmrax06gCHf652K8I7IboDsefw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kzalloc.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxELzs+seD38/oNv8EFjL6mxnNrWl+wikfOytZY45oQ=;
 b=o9cFN2njSBKMRyhljjZY5Cl0nP/65QAHiVFI7xmczxJBtmIeVt2iOotB+Y76HTLDed8zBB5bJWQocIzY2tG2Toicf/V5l29p2PJjqACuhbcTGuu++4XnDIYOrNjHdXHpJpYtVcc9tQhpm4RvogmsUrDA9TPDE3qENmvIfTqvstU=
Received: from AM8P189CA0004.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::9)
 by AS4PR08MB7710.eurprd08.prod.outlook.com (2603:10a6:20b:511::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 08:59:43 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:20b:218:cafe::2b) by AM8P189CA0004.outlook.office365.com
 (2603:10a6:20b:218::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 08:59:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Wed, 13 Aug 2025 08:59:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZpY6HBqUdk1MakFSjcR1rFHnUZZBOMLdplWbrp+pyUDUaTsLOUq3WbJhSFeb0MO5WnUr35J53TEbBTICT57OSbTWqtB7/Fyew0uLMkhJlCYcadVLOHY61S6YD5NGvOQev3ZRvytSGpETHbHCSIU1hVIIxm+s5zf+5dJtnk+p2MIGSer1glqgPFPC+FPOqAWYGja4glHD0uF8f/4qpAY87iTcXDG2lgNmBttqQxVSK7pUfLvBa5rtYGaermBN9d7VCKcyQqyDLkx5XZdlrtvA1X0djyMlp10Khiig47tNvm/aaH5i1bQvbJq+L6NllkxLO27yEejVzNA96SKTmcyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxELzs+seD38/oNv8EFjL6mxnNrWl+wikfOytZY45oQ=;
 b=MdAUkJpvYzFUsZY/pNts5W2Sn5RE+RFBFgo4Kxwj7FBSEn9CNI02bajXi3igs8DqGduldQZFD9ZUquER0I02CYzH+6QHNAiCmG3bMnYCP8oPd+O7KR3fwZXpza9iPubHmM5CY+5gbMPwWg41r9ia/Movw9o6YzvjZs1tItWu3IlXSKyP/E/lb+oXNwmmBL0JWSiYvtBjQayGHur62gST0vVzLPQjvMdoxNTp2DO/v13WWCaJXJwz1wsxN0MkQVub8q5J2Cq+w3zUDr1WDSD8gXHuq4lvv/dDhdM/pNMDhsWIBgOK03+GAr3K2wzdfIEDZBIIbYwdTt1DEpH8CuQSxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxELzs+seD38/oNv8EFjL6mxnNrWl+wikfOytZY45oQ=;
 b=o9cFN2njSBKMRyhljjZY5Cl0nP/65QAHiVFI7xmczxJBtmIeVt2iOotB+Y76HTLDed8zBB5bJWQocIzY2tG2Toicf/V5l29p2PJjqACuhbcTGuu++4XnDIYOrNjHdXHpJpYtVcc9tQhpm4RvogmsUrDA9TPDE3qENmvIfTqvstU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB5910.eurprd08.prod.outlook.com
 (2603:10a6:20b:296::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 08:59:10 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 08:59:10 +0000
Date: Wed, 13 Aug 2025 09:59:06 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Austin Kim <austindh.kim@gmail.com>, linux-rt-devel@lists.linux.dev,
	syzkaller@googlegroups.com, stable@vger.kernel.org
Subject: Re: [BUG] arm64: Sleeping function called from invalid context in
 do_debug_exception on PREEMPT_RT
Message-ID: <aJxT2ie1wW2+/OCg@e129823.arm.com>
References: <c36e8dca-d466-40ad-ad51-2b75e769ff47@kzalloc.com>
 <aJw3L7B7u5qAPOMz@e129823.arm.com>
 <17f91b9a-0a3a-47e1-bdfb-06237ae5da55@kzalloc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17f91b9a-0a3a-47e1-bdfb-06237ae5da55@kzalloc.com>
X-ClientProxiedBy: LO4P123CA0094.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::9) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB5910:EE_|AM2PEPF0001C713:EE_|AS4PR08MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 92cd7bef-a7b0-4e7b-a5d6-08ddda47be6d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?nE3hpknSQs7XHPUfl8yhVWX2RYN0XOBBeUFcXaKx1bdo+v+ewDb64SFBLQnb?=
 =?us-ascii?Q?06RTcBcJAwjel6KdZM1rmAkVi10BFasQ+mKOHnvdqOke3ClJFqsLATrSuciT?=
 =?us-ascii?Q?kbaLwkPFtq25hoD7+nscfsri7lt8ODn8YjXqVUT7tr1g1xpLsOT2pusntTQJ?=
 =?us-ascii?Q?VcD2t4tgdu85VE2LgqvWYmWM1hB2nE7lh51hYsyZbcObfk+zrxLCCyWuJxH7?=
 =?us-ascii?Q?xIst4IzMM5kUd/JjxSbrTiBgK7gXgtYzD+XIZZVrrO5jo5yGyWkn3P0Xnd6z?=
 =?us-ascii?Q?3IqDOzxwuhvySg9sBolplD/+dEVejyqt02r3LpJ+jLrDUmMBRgXdqxnAMOSw?=
 =?us-ascii?Q?r4BORPtBRV4b3co5zMycMhziXQpf1L+4VI/t6xgO44GHmKnuwPbw7eTPLFw/?=
 =?us-ascii?Q?QJfttxLIgYKK7bVYG/Wc0YAY5VyBfvkZcpz3USEppR7MNkkSPvrx/duHt7WF?=
 =?us-ascii?Q?+sQ9Cu8wmb5LPnoW7yCAcwlOFW3f7S31OAiHASf59nSF/SFKaX72oHzNfeeC?=
 =?us-ascii?Q?yadz96+4Vbg37ohjW+oeYcYLxm2XTph9zOIh+qMYGtblXV6UcuyAIj43rwsL?=
 =?us-ascii?Q?lg0UmxHoOkF7nddBeip4FqvyVzTctvpa4490ZNbBtk6xIq9GKVJi2D9U3A+p?=
 =?us-ascii?Q?XrtIfy5VJpe4ffw93N/+dqAuDSoxtIvzhxSxzJVtV1UCXPqWwJP/ptARlYIQ?=
 =?us-ascii?Q?NqKnvrw8zmOl9ATy8k3eu9dH/3Y0hjpiot/0z3bnSCIT7tP92XWpxr7wyrMp?=
 =?us-ascii?Q?85b/eNjumXsHpAMWpxGU40DScdaz0bGyteCly8OOt3dkSNwwTqH2H/7Jjrsg?=
 =?us-ascii?Q?S+Y06aWmjGPqTc0zvTL7WmLdtnz0ghEvjda3/rd/mNyux+7yCKp3zXE2Ir6R?=
 =?us-ascii?Q?cwcUj8hPqcu2jf7CXJdsPCaPHLeV0czcHmmVKFjCoGq5GF9G1t+TfdUawdZ/?=
 =?us-ascii?Q?7ivo6TqisvRbzAEtlr8xR+rSxwFxYCZjn38LtVr+eldcfEJGq5FskYe3BpVD?=
 =?us-ascii?Q?o2wfHVbpgQJZGzcPXw5xSQ2dIlOyE4Pshg6/f+aPfhOj1S+M9nB963GP9Cyq?=
 =?us-ascii?Q?Hm+rcUmdZqdOxhC8iBDK2QHJfXaC5eSimT6Y+L9o4w2afETPPdNRVCLOxRDX?=
 =?us-ascii?Q?wwcRDsbsW8W8gEMtdVLMWgp/fF4u3sffGXV8wl1au7b6jVqEe0HrV7QnKlTs?=
 =?us-ascii?Q?rwop1so0XmakvwibWU8zfNUabTXhSbh5mhQ3gDtMO1PR+o0rfHVtgO2TUAYF?=
 =?us-ascii?Q?ST8ba1im0kfDiXnb1Oc0NwFD6GzRJXqSz0ACESCclOdGkp82TEXNMsnewwd1?=
 =?us-ascii?Q?xP7fckIwWUiqbZrT1vjKZbckzRVFQjdxAyTsC77UrqVgbx2g9AzZkT2JwHiL?=
 =?us-ascii?Q?aDVVYXjIviyG1Y6kXEDh7lvJ3ns5g3bsJRnrzFDfB9C/JKbi/fmPGk8jDf24?=
 =?us-ascii?Q?SyKYWMDCrw8=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5910
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a8d633c5-5984-4261-ca2d-08ddda47aaaf
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700013|7416014|82310400026|35042699022|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?48+nY6W3MvSfO5YTYXlqU5ZkWsA9YhxZtl4/FFoQoJqW0oi6trRGSMBiqPxC?=
 =?us-ascii?Q?k8KUyjww367ttfhODJYzw/5jFOKT8HB0+w0in5AAZkCJGBAGxARHEO1jc16V?=
 =?us-ascii?Q?bf/vrZTgYAqnYGtZ80AuJ8XVeZiQsQqf27ieJs37r3VrD04C2bCgv+E6YvuT?=
 =?us-ascii?Q?zo2rVMhO57CmF5jfMLuUFOfkNrw0G0jLPvRehtrvc8QMUVnoEG3Nge7xhrkc?=
 =?us-ascii?Q?TzMOYH12gedF+IAxxpHneAbv9zPx2CqvKYoqFINsWcNaXLF1bukMWYVnAZt1?=
 =?us-ascii?Q?eaCFa+tF2CQtRCxm7mKmwqHkMTjXq2yKs4r3QVSfDFcKyeER0/oRusBuJ2J/?=
 =?us-ascii?Q?S73H7aqyojO1+k1n45M2mkAdFfX5cpgrbCdLlIEQuZxBEtlHaNeWAlIYDtcg?=
 =?us-ascii?Q?wOQmlv5JaoTaLle1quVUhR+nYQ/IoFX3x7CRYC7FBgozhomekfUHwPgmLdKp?=
 =?us-ascii?Q?NAAK1mP1bqvMoF1Jx84g6IqndUPM+ZkxbO02TXvQuiJOgzg2V3onpLPpp4MX?=
 =?us-ascii?Q?r0KJdo2STWcHZnlRFHwM+NatUOUl3brm3bGnaTVgAFQV8zzsrwFK/2lv1VAo?=
 =?us-ascii?Q?h1edIn+2iIhXhUJ5lnd4PTIot5vsx8sfGAHEpxUHcA7Git2Z6gwBPW8CeFdA?=
 =?us-ascii?Q?RFy2IHKBmpYnbrQZkfiI0dzMVAxLfACxqGtZ8OjbDrB/TuKMt/hrI4xatK5/?=
 =?us-ascii?Q?WUQKjREL51yJRRyikY7gPRLhFY8HdubcdcCAzAx90Ve7ROxU/9drTdnGRu6X?=
 =?us-ascii?Q?gIas536QFZ8UnIJcDDNFrHrBVErD89+AtUqnZLMqTLBAK14xD2ktHOPcKxbg?=
 =?us-ascii?Q?yDjLhuAnjUapYjQnuzLzah0sQigGhho0zbwnBasSoZwHMfJVu9ryil5mWZIe?=
 =?us-ascii?Q?bTPmVIzoBuS5eLWMrvu76+G1I44brEXDMwlJCL0PF1WdkzVyIJh0SdWPeCVB?=
 =?us-ascii?Q?xkK20X26VG9DtCm7rAudqtGme0xdQ0n1abR1I/VhBmfiLt7wFu3Q8q19SigE?=
 =?us-ascii?Q?yFtDPjhW6BMDSzJrKS70WYQfNwCalXkxzrXYcvKyklT8qfP+nXEOkjzNcS3K?=
 =?us-ascii?Q?Wg1t7aMv1GSxfhzSbqqs0SbwhRRRXumeb43geAjfZZazIh4dgOrHIEcGTeMa?=
 =?us-ascii?Q?t4dxsr1EzRhoqr8I9JpTrLECCY2P07LOJQ5m9/z8rNwryS9ag/KuGK4U4iCX?=
 =?us-ascii?Q?xMFRD2PFCipTzUNSvTLG8v8edWZ3ksRePPAXctlGfwnLgRhJnKN240Ahbape?=
 =?us-ascii?Q?vdVSVyzXv6dLIy65K1omf/ngz2grlkBJ+tZMDJpXaOx4cNKBPq68oUCoS58I?=
 =?us-ascii?Q?jLtA1aoPgd4ASbHmv9tEPSPMPb8ubf7zUItv2oQ9ENHsaPbyACbLvhRTpQMW?=
 =?us-ascii?Q?37L0Xf6G4VnzDrNh5H1NCTUjuHYOpyeZtKdzgLDLQbre3NvM7CMWc5suPfVg?=
 =?us-ascii?Q?QywdmIAIHqKglV+qfw+wYEeom9fKQxwzaH0NTdA3QQaugPgWXIUWUP+OoZhM?=
 =?us-ascii?Q?TeGbVnAV2Pzw8n02iyxeOfg2PmZExKkdc2oFNCa+PohhnqfryG2ghMVm1A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700013)(7416014)(82310400026)(35042699022)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 08:59:42.7807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cd7bef-a7b0-4e7b-a5d6-08ddda47be6d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7710

+Ada Couprie Diaz

> Hi Yeoreum,
>
> Thank you for pointing it!
>
> On 8/13/25 3:56 PM, Yeoreum Yun wrote:
> > Hi Yunseong,
> >
> >>
> >> | BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> >> | in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 20466, name: syz.0.1689
> >> | preempt_count: 1, expected: 0
> >> | RCU nest depth: 0, expected: 0
> >> | Preemption disabled at:
> >> | [<ffff800080241600>] debug_exception_enter arch/arm64/mm/fault.c:978 [inline]
> >> | [<ffff800080241600>] do_debug_exception+0x68/0x2fc arch/arm64/mm/fault.c:997
> >> | CPU: 0 UID: 0 PID: 20466 Comm: syz.0.1689 Not tainted 6.16.0-rc1-rt1-dirty #12 PREEMPT_RT
> >> | Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8 05/13/2025
> >> | Call trace:
> >> |  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
> >> |  __dump_stack+0x30/0x40 lib/dump_stack.c:94
> >> |  dump_stack_lvl+0x148/0x1d8 lib/dump_stack.c:120
> >> |  dump_stack+0x1c/0x3c lib/dump_stack.c:129
> >> |  __might_resched+0x2e4/0x52c kernel/sched/core.c:8800
> >> |  __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
> >> |  rt_spin_lock+0xa8/0x1bc kernel/locking/spinlock_rt.c:57
> >> |  spin_lock include/linux/spinlock_rt.h:44 [inline]
> >> |  force_sig_info_to_task+0x6c/0x4a8 kernel/signal.c:1302
> >> |  force_sig_fault_to_task kernel/signal.c:1699 [inline]
> >> |  force_sig_fault+0xc4/0x110 kernel/signal.c:1704
> >> |  arm64_force_sig_fault+0x6c/0x80 arch/arm64/kernel/traps.c:265
> >> |  send_user_sigtrap arch/arm64/kernel/debug-monitors.c:237 [inline]
> >> |  single_step_handler+0x1f4/0x36c arch/arm64/kernel/debug-monitors.c:257
> >> |  do_debug_exception+0x154/0x2fc arch/arm64/mm/fault.c:1002
> >> |  el0_dbg+0x44/0x120 arch/arm64/kernel/entry-common.c:756
> >> |  el0t_64_sync_handler+0x3c/0x108 arch/arm64/kernel/entry-common.c:832
> >> |  el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:600
> >>
> >>
> >> It seems that commit eaff68b32861 ("arm64: entry: Add entry and exit functions
> >> for debug exception") in 6.17-rc1, also present as 6fb44438a5e1 in mainline,
> >> removed code that previously avoided sleeping context issues when handling
> >> debug exceptions:
> >> Link: https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/arch/arm64/mm/fault.c?id=eaff68b3286116d499a3d4e513a36d772faba587
> >
> > No. Her patch commit 31575e11ecf7 (arm64: debug: split brk64 exception entry)
> > solves your splat since el0_brk64() doesn't call debug_exception_enter()
> > by spliting el0/el1 brk64 entry exception entry.
> >
> > Formerly, el(0/1)_dbg() are handled in do_debug_exception() together
> > and it calls debug_exception_enter() disabling preemption and this makes
> > your splat while handling brk excepttion from el0.
> >
>
> Do you think a fix is necessary if this issue also affects the LTS kernel
> before 6.17-rc1? As far as I know, most production RT kernels are still
> based on the existing LTS versions.

IMHO, I think her patch should be backedported.

[0]: https://lore.kernel.org/all/20250707114109.35672-1-ada.coupriediaz@arm.com/

Thanks.

--
Sincerely,
Yeoreum Yun

