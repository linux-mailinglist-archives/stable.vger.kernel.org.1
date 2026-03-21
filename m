Return-Path: <stable+bounces-227747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FbtLVJyvmmYPwMAu9opvQ
	(envelope-from <stable+bounces-227747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:26:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 247B82E4BAA
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BABA93037896
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 10:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F9931197C;
	Sat, 21 Mar 2026 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Vxn44jE/"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EAD2DF719;
	Sat, 21 Mar 2026 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774088730; cv=fail; b=refVhQUtEmhprHHxLnbWG3saY+hOG2ONU7wv1VceFpamsEh5ZcfPFdBTVPa7WCWTAA5H7Bc26WjtYxmAjCxKkCTClpCBVL8EsFHuyMXw/56HSypTtc+F6yGY3d9WquZhSWmYAd/nvfWZiKy13YxVberoM7HVbD9qjbvB3+9D8IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774088730; c=relaxed/simple;
	bh=8yPr34tgXpCLuKPuW0OIra8MSwOfONatQL9tty1Z5zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hmiQht1I9Y6zmYC/6+29tjrP3S5ncOS6pyB3RjWcty9/OG/BWhysFYGDEASKq28rv2rxSUjZ7BV39rG8yhFnv7AmiSy4VTMmyL0QwJnILGoMWfUcbUuyxky1KSjYRbeGpnkn+Ld8OlxHKr1Fbik5QLIM7yETKQrDUukQxgcg4lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Vxn44jE/; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LAH2Xa3561056;
	Sat, 21 Mar 2026 03:25:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=bX9I/KmzbRv+1dRa8Ep7RrGp9rTJM4hokTb1P+mwqnc=; b=
	Vxn44jE/l0UpWOozHmf1Zogs+JGmWWZH2+rQ5nT7jTgBvmer7gdGikrXKyaIgeSo
	//p47w1HirT7qVetRv7zuz1aiRuaLd4Ivym06qSV9HJ8IhAK8ZkRVS0QUNoMD0Iq
	N460VIJWbEePAgR5y6XwYdA5TWFFwVZXRSCFk5GZeJFOmTWpMMWpKydJzBsO6gt9
	yosh8qsA16/eUR8jswWx+D/lMbP+TnhhtSa+pzTpW6scx0y9Yj5kjY8qwNZr0J+F
	yzSzF1xK6f9KmZ915ZwAip4BOORjD/B2s+QafXdIOI4fWcCU67JzZRrvfcwLcCJU
	4oQhd+8wTgtD7lYSE8oH9w==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1pky834m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 03:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIoE9Bid+t3B8PAsq2HH+rwLKIW2FkJx3yaO/hd0T12NHbHg6L0q5bmngNxzvZzn76UvdZgFcTva+B1/4cqY8EvpZt22c+Mj60TkZV3iHi104xNLXcQd4uUNlkpbEbMr5jB/9Qx4OWPlXODT7+MqKZbYlWPs/EqX5MmoNqR75HRMi4VODYDpOHFWWd9NPXTggj/NYd1/1pLdDAwkiDSA4Wfe60xuQwLkaul172VY+aHdoY/zR8yK5VvVYfEZtzloij/lrKAXWcWCBAIwbj4Wd7XY83qo3gXaUQ8nIr6R4j03Rrjiri0h1RDotbV7HZuLZjtr4i1vk6QEKE0YdZaUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bX9I/KmzbRv+1dRa8Ep7RrGp9rTJM4hokTb1P+mwqnc=;
 b=VL9uz8I9OM24XHpDisIl/1qHgYbzxsea/I2vjHJeY9TWhzE0SX4yUZpuPjDdpayHZIOEAAxlAnfl64yUYbKu92KgQ+nD5pi4vgr22MjQyMt3U/XCbQwQL6tb6ryWIn5vkXfx1fun8Rd+dQvdTo9SxQVpnbyBTK8AV+UTIiJnV9ObA51JN6K/j6z1mYzGaHqfCM97yOobwxyHozHGRnlWBK1Y+lgwO/uiVUPOc9/SvEkUD3aex46faTbtrC5/fjhAjHTxPwHnI4FT84TkW1unQ0Bw7uMRqD291rYu59J+BNUrPcBvkfP0SRf1t4PSZlb0eaprhIn9S4Jsw3tAAtJw0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by LV1PR11MB8850.namprd11.prod.outlook.com (2603:10b6:408:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Sat, 21 Mar
 2026 10:24:58 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.012; Sat, 21 Mar 2026
 10:24:58 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: frederic@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, ptesarik@suse.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 1/7] timer/migration: Fix kernel-doc warnings for union tmigr_state
Date: Sat, 21 Mar 2026 12:24:34 +0200
Message-ID: <20260321102440.27782-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321102440.27782-1-ionut.nechita@windriver.com>
References: <20260321102440.27782-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIZP296CA0002.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::6) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|LV1PR11MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e53601-9e5a-44d0-7c60-08de87341a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	5/RptLK5YJFnURq1Vo7Jm494eLz4mktJxTjCfO3EY1B4YA47/wK2NlzthgwP9sYbwUhERHJy5kq1cz71lHq3NqEzCj+7h9xKRH5xVo5ROSQuezYUkgpjWXCA47nfEKRMq9+bDvKz2dzqLiaOV6Ltcxfy3e4QImGcoG0yUKoK558ZgYu8c4SttBe/ogCiFwCn9lnlViBDkRSaO7t5k6VcK2loWXZvDzIIHjg1FyEHDyhqiiH1CfYh9BQ6B9Zy0qxIfygorYtlsMNPo64bo7a4HDD0fj08JCuetqJrWRZNEzpS20yvR/D3AwSpPK56mbV+J0s82cFXmAM/ziLFIb9bP0fc5kVCC7iDsIHtD9u0uKnxr0PxNEltEjqV03H/m31srq1b1ni1S4Xc3JSmhzjWyvGTRxtC9zcDtPKPe4uAHLvxEaxnVRLsElR/VFoPG0c7xsyZ6FE9QFklQARZo4/H498L7LpRPLzwZ6/jp736X6upLgffbNTrzdeEEdTXxV409m7MDHAc0iSUvJqELWLrxNkht7oNDSQUhmuwdbpfSYr5nv0n//ZfRqq0aNZWLx+qVu9TCnQ/7MPsw7TOc+1I2VcJcizoqRO7lGCcSmF1nvG48jaCwnSBHmb3BGx9FrHALfAMAsnE19sQU4r5V6+q0EGoac5u4ILfgdxaRIxYmh7nUV+rSy6oU7cnlkz04IlvcoAIqGf4B/ERfCr+uED0bVdEEbbcRkIIqE5mkqbvzn41ZmVagphqam9b3JYx/2q2NtLlacX/m3SvQUrH45OxkhlY5ef5bcDX4s26vMPykMU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a5Azvq4P2JlWjidoqvjJSiDgNoxswuIXmCdTgS2ktP9HPxD/9Af5+52hMrFb?=
 =?us-ascii?Q?ANp+lgZAlQsKKw8w6KMnRuIi55Yb4tgyVXJll/EivkKC9Ze6K3v4d98A8fJH?=
 =?us-ascii?Q?FfWFtsX+1rGvC/7PJxxPahydWgHzkKMHEzkvfKcMDDYN7HiDeiea086/lTGV?=
 =?us-ascii?Q?XIx0cIt7kIxuLxt3neXHdFZsGiV3Jyyw+QGU+wXTfM1DbnDeK/wbcFqsgIDt?=
 =?us-ascii?Q?hOznBMWw24jGqWERMmKn3Pd5Vdvg94pDNbPBV0GO5UQiwFfIk+a/OU+XtJy5?=
 =?us-ascii?Q?2b2K/fRDQXpGnrLsaIjce9XTuEsYRm5GofaAHTG1QV/sfr6CU9j06aS06YMc?=
 =?us-ascii?Q?LMEonjfw+WBY5zMyX3SQAFGfLWMQAJ29r+uztsw9SUa25PXrWNaVtGzmr57r?=
 =?us-ascii?Q?radUKaXgtlREsdgeAVgI1QGLu8xiGkhIHY/BL5jdMx3+CQ4glTLYlGJNHtSk?=
 =?us-ascii?Q?r80eKhX2QKWDo+OlYnVyaDvlhBdXVzWLm9+aRfTKnhfie6rTgkKPCNohw8Y+?=
 =?us-ascii?Q?+ERq5SA0POwqhMEJwpEp51sfQBxe63eO2zHsv2Pjq3YJOPWwYsIEnCD+J81A?=
 =?us-ascii?Q?0mbVpNdDFCCTtKZVOfXbWF9J9ecXNkOkzxPVf4mMSZ9v0xAoKH5xRFt7ReP2?=
 =?us-ascii?Q?ILidsYw7fwyrW3aujKr6fckGnOZqX5wXJF18ie04NIU4skqwb8eTrOrye/jY?=
 =?us-ascii?Q?joU1hB+QZkpRV7+iycn/AGRBOu/hjgKjYjWmaWdCwkUgXdmTxhb96yQu8Gbn?=
 =?us-ascii?Q?ZYhDXrPjs+4UvyCh+KeY2Bt6lM+37144ZuB6LFkQugUYULPjAifGKG19vMy9?=
 =?us-ascii?Q?BqK4rhU4oSvKTWW+BZxWg+bHmNxzXuYhlTMheUk/ODf1ymu5H+0EORHsY6t1?=
 =?us-ascii?Q?FBD2VePdITWnISLv0a+ZsqZwGFhKZZCiWBLrHdZ/EmqM51AoL/eNAdQcQhEF?=
 =?us-ascii?Q?uWI7adI06TnpTYLKwqCYGTuuS9rWbmCrxxmzq4jj81EBxj4MrkKXhZVbQycm?=
 =?us-ascii?Q?yFn2zYAaVnyjxadHk5ZGn1ajefmgltod7gwvmWj9zbeSQD0FykgXX69aqOTe?=
 =?us-ascii?Q?EhBS95SGaweofHiiyz8d+ct/nws9AgkcmlCbtNQsB6RrWCq9fObbT1jf20Qw?=
 =?us-ascii?Q?SzBufFuZYFXTLstdVoYouOIBSS1uAPk1u0TrdTHnjHMTu7tp9cJzWpKj0KeC?=
 =?us-ascii?Q?zBvha/104MN92DBCSSnhUeJjhoUbFms5pLjeDFQbLeeTTUQ3cbFO5whJlraM?=
 =?us-ascii?Q?5QLdZ8LQjpBIW7BDZ7C7CLNyoDMp3n9NMB4txMnJi4HTKa8ip5CSWeqqMPJG?=
 =?us-ascii?Q?a8+UKwC0GOQp4A/9EPiM9jN6YLDAj+GFt7GrMl/ix/94riSkdhmknirsVmFJ?=
 =?us-ascii?Q?xCWLpvBsHkPCGHTS0qNcJdEiGm3Tolz3Q7TGmfgJ1nWvuH0py3LRt5P0q/p8?=
 =?us-ascii?Q?+yuCXI8z3gYHTn92xwxRvTmvaTM8jQQ2rWtSrEpbhyVIBSn87eU0gBzMytzt?=
 =?us-ascii?Q?o8EsOiCfLDoktyVEUx14XjromCIroLnWR9ChPNDTzUaGPUoBWUKq6PBESQ/R?=
 =?us-ascii?Q?T5AGqGN2fRuzTM3LJTsqQL1UwzeVyRAiW8c9jPweuzQOdmv5DtGw9vXk16kn?=
 =?us-ascii?Q?tn3L5O1RM1uwJvlCdlh5A0A1acyq3RirGFXQglQLqbfJGWG/QyNr5nxabV0q?=
 =?us-ascii?Q?HCrxVm17+IZWp87G6kzfAi4+gyHFPnGhraRwjwDVbDpC0MPB/ydEmaeovDoP?=
 =?us-ascii?Q?+MoOKyxa6idj5FLtq1JTugZe5dhnTGo=3D?=
X-Exchange-RoutingPolicyChecked:
	tSxWApIRsOgNRmOkI082QkPa902Wj2HRexAYZSlOoVLYwGUY8+a+Rtk5ET+KIVJaHJ3kKiVaRdR81tT9QvXW3BPRzXycqeQ4eKhBqmdDuTKILoMxD/+J4PyMlkI5xdCaO6m0JD24Cu8fGJEbShGRHizTHoCf+FTJhqWwr2CYSsblDVoyhccbWF+kP/bL50lfohnqSzqK3qehDHyQTl3rX3GLLHmWtwrHw2xrZKhpeY9GGvND5iIaaQrCumz56pSBfVQjMjjdanxK7YzSj+ifPJ7Tz/hvb1PkorvIl/Ie6oOMm9hVSHTtm2VFfeFp6uHDghAR27DzRkSXcHGZl/uT2w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e53601-9e5a-44d0-7c60-08de87341a72
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 10:24:58.7154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUQ2h9SjqLUbCTvgba20iBaKTYzFMi7kTjPVm9glEU9X4rBb4NkQ+CH+CeOzTBOARkKkUDn8rBoBThggVgvtTlAsbDZTK5pCUD9YT/ZrPoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8850
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4NCBTYWx0ZWRfXxgnqURrohQjw
 0qBDzoyJzEFGVtE9EVV4Zqrpto2KZNshFTs5oZ5EC1MeYT5/lZwLuuF3Usk/WD+VSMJHj2Y2NK1
 Nl37nCHae7iBXLxPzbXKSvZlHXDe/J4e3+eMzHhtq3oQOpRSinmr0xuchGoixNNCl7FbzMo9vJA
 ALzDViU5OsXqPKJB6FnC0aljn9D7rbilTkd8qg495pbTG3PUUn+w+3KwxnVwwBc3rFUNKVdEtgL
 kZDYRMlJRSyLRbt/m3J2oUKJYoYo5gGIqJS27O7SzYHuGMsPjOEMywTx3pX5Ojk3gruEd/68agE
 ypaC4V/KMTNOqD86Jm7IYaQFyxyUcwu/NicGGZYf1QbPFvEag8mKaJOW+/eN8iUV3mPl3iBfSTd
 6g8K8YSbGs7QlnYKCv9E9uqFbApi1Bft54Z3cC8CKAVt6XKGFpViOYP+RVWjFKEeLrrckwv4PCT
 Q7ZTaqkW9T2gF6pw5Kw==
X-Proofpoint-ORIG-GUID: vGZzzWH45-_XMBLynteRdZBJUQR_F2Tn
X-Authority-Analysis: v=2.4 cv=Scr6t/Ru c=1 sm=1 tr=0 ts=69be71fc cx=c_pps
 a=XJaUxuKKdFC3a9vqRM80qw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8
 a=JfrnYn6hAAAA:8 a=t7CeM3EgAAAA:8 a=clBZWekMHlowcS1oBDgA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: vGZzzWH45-_XMBLynteRdZBJUQR_F2Tn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210084
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227747-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:email,windriver.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 247B82E4BAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

From: Randy Dunlap <rdunlap@infradead.org>

commit 4477b0601471ba4fc67501b62b78aebd327fefd7 upstream.

Use the correct kernel-doc notation for nested structs/unions to
eliminate warnings:

timer_migration.h:119: warning: Incorrect use of kernel-doc format:          * struct - split state of tmigr_group
timer_migration.h:134: warning: Function parameter or struct member 'active' not described in 'tmigr_state'
timer_migration.h:134: warning: Function parameter or struct member 'migrator' not described in 'tmigr_state'
timer_migration.h:134: warning: Function parameter or struct member 'seq' not described in 'tmigr_state'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250111063156.910903-1-rdunlap@infradead.org
---
 kernel/time/timer_migration.h | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
index 154accc7a543c..ae19f70f8170f 100644
--- a/kernel/time/timer_migration.h
+++ b/kernel/time/timer_migration.h
@@ -110,22 +110,19 @@ struct tmigr_cpu {
  * union tmigr_state - state of tmigr_group
  * @state:	Combined version of the state - only used for atomic
  *		read/cmpxchg function
- * @struct:	Split version of the state - only use the struct members to
+ * &anon struct: Split version of the state - only use the struct members to
  *		update information to stay independent of endianness
+ * @active:	Contains each mask bit of the active children
+ * @migrator:	Contains mask of the child which is migrator
+ * @seq:	Sequence counter needs to be increased when an update
+ *		to the tmigr_state is done. It prevents a race when
+ *		updates in the child groups are propagated in changed
+ *		order. Detailed information about the scenario is
+ *		given in the documentation at the begin of
+ *		timer_migration.c.
  */
 union tmigr_state {
 	u32 state;
-	/**
-	 * struct - split state of tmigr_group
-	 * @active:	Contains each mask bit of the active children
-	 * @migrator:	Contains mask of the child which is migrator
-	 * @seq:	Sequence counter needs to be increased when an update
-	 *		to the tmigr_state is done. It prevents a race when
-	 *		updates in the child groups are propagated in changed
-	 *		order. Detailed information about the scenario is
-	 *		given in the documentation at the begin of
-	 *		timer_migration.c.
-	 */
 	struct {
 		u8	active;
 		u8	migrator;
-- 
2.53.0


