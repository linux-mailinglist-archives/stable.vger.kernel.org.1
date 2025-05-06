Return-Path: <stable+bounces-141796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE4FAAC1D8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 12:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2B14C83EB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 10:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A716A270563;
	Tue,  6 May 2025 10:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rrzZknUv";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rrzZknUv"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EF920C028;
	Tue,  6 May 2025 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529079; cv=fail; b=RyPGkSy0wLARg2li6GElBgk9Xy/0TcYEYehqykebVRNaFSB3zv4cX8nb0QgZrKbQK81rgpG6us590Y8IhLzvHRNmkODPEDRKL5TFyUdit+/DfkUbx6of3vwog4LVFjYj6TSmLxuNCGLSR+EFEKuND7JX+WAsIf4rSEOIjWeT1Mc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529079; c=relaxed/simple;
	bh=dAiKc/Wu1RsdOqLw5avqirUTcu8OlOUp3J065hh16Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n8+OQ1tWcNDY9LnztpL9yZitX/dNGRrcO8+tcIdiq+medZtj8e0+Kq/6PohQ4opMAzwU6FQR7uUcwXxQWwIwsZHPtWfEq7krxhb0meVOFLjP78OD53gD1jJ9J3jnkbfIeM50E4srC+NxKhfTrVb7EOw9cJokgrqLCCKZGA1bFmw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rrzZknUv; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rrzZknUv; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=LApoV4VI9jU/3bDeWODtlCGA/kazqDDityHydEYC1weNRpNyV2QgVPSsMMqIP4FJHk461A9+q/TF+ADlniXh5vrfJ3fHb89XlX5+L5wMexyQR+5LTUUXwcixlBtD2Dv1V50EjMlMP0AvNnPMX0jSp8qvq6k3furGh5bJBtJB0sOXcHC0vrrTEe4SOand5BBjDsEC4xZxBDazErVLJhYpGc8P5U0vOB+/YOtsEiJUBrL6uzWRmweACWx0LalNJISrxbH0/WbLh2Dv/PtZs47rL2OTog3mkqoJ9l2cu99ESks7is2eBPqRaFM8pNYbCLhmll1kb6dT2RXd4IrP/M/Czg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT/R22UrU9WtOegr6kZ1JQpcjdw/tJ/+P+dXTPkOcco=;
 b=xAFPC9NrLb1fackcUW1bjhvl/AKJ9WsIpTveBCeRHhDaiXyHEK8Xorlb65FCxQtUGeqlxHMmPstsAQzY+4hHxVS2LRYqVVcy0dhQMvpPF3PAwHLZvm5ZmApPHvEPp52kItJrI/H0Jv/EiaXKc31MPPI6yXK1qf+LkGm+Xy9lf5c9lalLUhS3LR/nlhl2TwD8/D+Ebtv/2t+og+wos118GXV2qiOvURRb2o96+2dXZVoZPCXlIMoUs5hsZfUR3kGKF0/Aibq9Miev+U7OSKW93LiALNbzZ/v3q0N0aAaPa62OMEiPo15ikJinWqMOrFVCUm6Smkzk7Vcaqtg70UlQfw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT/R22UrU9WtOegr6kZ1JQpcjdw/tJ/+P+dXTPkOcco=;
 b=rrzZknUvaakyQxjBhjLHg8di+mAfFeVptHTMCQWdVpN4KZ3HKKLwqupFbm6ghtZiZ1HMHX63QgkGkJKXlLy8Ig7c69+qOFUdSmuCHNK9TKjtt2DA5eFLrtR4NcG85qNoKyVqX0MbVnsMXvVCBe9kmVwpPSj6TMU8m342Cb7uv/s=
Received: from DU7P189CA0008.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::10)
 by PAVPR08MB9082.eurprd08.prod.outlook.com (2603:10a6:102:32f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Tue, 6 May
 2025 10:57:49 +0000
Received: from DU6PEPF0000A7DE.eurprd02.prod.outlook.com
 (2603:10a6:10:552:cafe::98) by DU7P189CA0008.outlook.office365.com
 (2603:10a6:10:552::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Tue,
 6 May 2025 10:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DE.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18 via
 Frontend Transport; Tue, 6 May 2025 10:57:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKk4yGK5L6PNwkTLig2ySKfVO+/w9Nog8onhgRx+YOfz5oH7GfMRfzHYIOjOEaZmBaI5zEiZ0GRKxmtIWDC92u4SkFWOKWXHTbjYRdtlIwK9DASYwFue2qiDYnVNnztU0Si1VPtYtSnFiwFKOKpxa0DT419n6TJfBH0tw4QiLdZDSMWZGzUT/mYJ5Z6BJq0xn5gdIjeYF7w+WfZecdNL/0UlmcwUKjg25+INtsUfoHIUn+qdcwmfP8s17Yx4KkLLC4rXvSmwVICFhMx3iYlazYFhPTobHUCMelowjU3W+SaZHHaF3LclD24Qe+ajX3aPJfXNmWGZLiGeGzMGoIfEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT/R22UrU9WtOegr6kZ1JQpcjdw/tJ/+P+dXTPkOcco=;
 b=xEyRaqPPKNg/+iJEwLNBb6g6qc1Ie09STQ7wQJlkSqIBQTZxdElS2tfs9h73O4cdyp9F1nxGMYvZCqcXHh36Y9dLEbiWqzQ1yvBaQtydT+hFeIxRzCOgpVMsCy4pHG5lGwfJq6PEBOvCklsxYYBKui74Au1xg+iQ92NI5QJlO1UODenKz27KCFiJU+r7rA4FGaGc7h06WjymNtGViezJBfDbRCQFOSQEGMBt4aZlOmfgXT/lotYe1wo6hKSERCWka70d1s5UBVo9iikQX9d2t25DO+6/50MdnUAhlXHfDXFL7rRoUXn0quLxn6n9agqAdy8AZHiw+kcnryaTNBEJPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT/R22UrU9WtOegr6kZ1JQpcjdw/tJ/+P+dXTPkOcco=;
 b=rrzZknUvaakyQxjBhjLHg8di+mAfFeVptHTMCQWdVpN4KZ3HKKLwqupFbm6ghtZiZ1HMHX63QgkGkJKXlLy8Ig7c69+qOFUdSmuCHNK9TKjtt2DA5eFLrtR4NcG85qNoKyVqX0MbVnsMXvVCBe9kmVwpPSj6TMU8m342Cb7uv/s=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DU0PR08MB9027.eurprd08.prod.outlook.com
 (2603:10a6:10:470::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 6 May
 2025 10:57:16 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8699.024; Tue, 6 May 2025
 10:57:16 +0000
Date: Tue, 6 May 2025 11:57:13 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
	will@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com, broonie@kernel.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	shameerali.kolothum.thodi@huawei.com, james.morse@arm.com,
	hardevsinh.palaniya@siliconsignals.io,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
Message-ID: <aBnrCXJWKh3O0Bai@e129823.arm.com>
References: <174626735218.2189871.10298017577558632540.b4-ty@arm.com>
 <aBYkGJmfWDZHBEzp@arm.com>
 <aBZ7P3/dUfSjB0oV@e129823.arm.com>
 <aBkL-zUpbg7_gCEp@arm.com>
 <aBnDqvY5c6a3qQ4H@e129823.arm.com>
 <fbfded61-cfe2-4416-9098-ef39ef3e2b62@arm.com>
 <CAMj1kXFAYDeCgtPspQubkY688tcqwCMzCD+jEXb6Ea=9mBcdcQ@mail.gmail.com>
 <aa4241ce-02ea-4931-b60c-5ad0deba202d@arm.com>
 <aBno0C2RPQ2x8DG1@e129823.arm.com>
 <aBnpUqapTghz6E1R@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBnpUqapTghz6E1R@arm.com>
X-ClientProxiedBy: LO4P123CA0438.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::11) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DU0PR08MB9027:EE_|DU6PEPF0000A7DE:EE_|PAVPR08MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: 462f0c0e-d778-4ff2-3542-08dd8c8cd76c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?aPXpdLGIpV7RyuEU7m5SfwcJDqTIjpy0mT/PZR9N/OXz7amMAxozZ6GWFoLK?=
 =?us-ascii?Q?HgjKkedtA5mdR313is3Ytmiv6ieUTwV7OXyPqiBjgyiYVmy45RMkJvKI+83w?=
 =?us-ascii?Q?hkRVIASOJWpKC+q9J200HcCnUGy5lloU85gHc5Haat+iuuCmIlunqkkRx7or?=
 =?us-ascii?Q?xoEa7fRWFstbI2B8fg5q5CKN/fPmUJEgJEIksvDr0QJcmqH7TOYgu/n2VMsT?=
 =?us-ascii?Q?3k8WNJT1eedf6TNk32G8fD9o2uuiC58sOxBArRX9zZMNZojjW7fICtGCQH1D?=
 =?us-ascii?Q?O0leB+YF8l/Y3sXQTEwcfMCjy66WPZs2QQK8Lhjuae7rw/D9CvRrf+SgO3bw?=
 =?us-ascii?Q?WCczGFCUrLnmToQrdb+HUEWbv015VVh6XU3ckIs9VxVGjzOO8zLWg7WuKrUh?=
 =?us-ascii?Q?fgK/Fjg3H5dPq74/PeQhu1jcc+8ID34pLSdBTahssydngWVb4na5DD2P0fuw?=
 =?us-ascii?Q?DdY4NB/TLwn0G6FEni8JWxgn0W5N/ZgCTZAmUHdHL752rNSgSeAnToQgbm8B?=
 =?us-ascii?Q?fkwNexGmxvo+n0PcUMjKFfPn3A2gtMQ2gYOWSINmE/If0/KOZWVDJCgj80cW?=
 =?us-ascii?Q?NarQ8TLyK2iQzLLvNlckh7oEoZdvrcvhKBKnxLAHP89c15V9fcjMDoZ8/sC5?=
 =?us-ascii?Q?YH7itRkKySKQ7Q5QY3Af98xdpztUAT4ar6suaWTHuz59cs4UGbxfpVumbQ9w?=
 =?us-ascii?Q?br5PAesh6yNh1mQdjVxP9mTgdTHtSFYM8wywOFoEF0b6DDPFQdh8LoehPXEs?=
 =?us-ascii?Q?E8bCF2gC0XLMzvy3eIksDjc9Ce1t1ymifhVFFc0Ig/V//XcyNlhBzZq4AsKW?=
 =?us-ascii?Q?/u6zvJIppfvCvRNo1iqTu1XtO0NZV6+uMFm+RzE+NcxJSd1aOe1uVxueEJv7?=
 =?us-ascii?Q?i7HJm2PL+Lyjnsv58pyJbAT5WCxL+Esb3IEPJOaCY5N0kA5cL3gBhVSf6LIH?=
 =?us-ascii?Q?lIg2rvWC14HL0nZOs1sR/mNMA4YCyn+kkTGWg0abTfFClNh9fYfSlypEK1CX?=
 =?us-ascii?Q?I+SASAvxFZHAO65YxYuszCRa8SpZWn/+c/svGwYL5To6MD8l3YQVJw964UHN?=
 =?us-ascii?Q?AdYba8jW9RffoSS9kXDPemcCvQFO9DZ67WjLSA8NECOt0Ce0rTXxvLyxnu1z?=
 =?us-ascii?Q?XANQriQAZVysXPZkAjWlv8M1qphKnqDP5spvvssJWRF83sqxp+7TsbnfFlVe?=
 =?us-ascii?Q?mvK8pDzJ26F4lYo/MTr0D/zcGLT8XLGBXWxEgl0bCEd9bUuHhrqD0RGuO3SF?=
 =?us-ascii?Q?Jg3+EDn61DlxN+vfVuH/r/186alyywaKTzzkxMQCxJKJR4tL6bPdUD+XL/ny?=
 =?us-ascii?Q?plTKdSNa/LpAeom73xBbGcR1EkN+2FtPwUbCCnR9YnhZa8PWjwg4BV5VRjAB?=
 =?us-ascii?Q?1Obi508=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9027
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e81cd66c-72f2-4252-86cf-08dd8c8cc3c2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|82310400026|36860700013|7416014|376014|14060799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OE7I0ylA+xpB2Y8X8/jH3SnyH9SlGY0/WrCWfl6WVliuxdcSSqc0pOjvFh9B?=
 =?us-ascii?Q?MQdfBV/3v3fMEg8uSD1wWvw1fdbUTbrG9m8WAlEvCFOn4JHnzR2XXCyPGk61?=
 =?us-ascii?Q?6RDYQ/BsIlIi/IvFRIevZj3FVwnFlYtJtChrFXGhSWDlhRjMAEI+1gKHHkAv?=
 =?us-ascii?Q?xwhunAaWebi/QZK8Ru9Mb4oCzuopq78COt2a2gdbVgRuwQ6uJz50Pp4oSXEf?=
 =?us-ascii?Q?lkEL0SpQiz2phdNzlZG8UmeRhKkHnIisOZY++v4B43pmYuQuppNZt1y1O/u5?=
 =?us-ascii?Q?8cZtdbfRmGUKfwWIQd/r8Mb6ifJO0mFK29QrDdFbtGINGVcCHbl+r7kAe/6s?=
 =?us-ascii?Q?kchjad+clliiPw8DedNwGcLzk6ttKK9UQzQLxTmCqUm4Q/QFh3ZqaCctpXSK?=
 =?us-ascii?Q?5qaB+sx52FmVhNkdfSvf5dhcqilgVIrwWoHDuRxdvbsjEJs04kdnUvU1vLsV?=
 =?us-ascii?Q?rv3IJl/XYCzdMPvkAmd+XfvJT+zFLBew5yl5qpN1+qC6aSEynMFqVjOcvI8R?=
 =?us-ascii?Q?2BvCgK76+/LpqcrDuoYuu8HRA1u6l4KtQbUuFVdUdaBDUJgg3EAFopATdhh6?=
 =?us-ascii?Q?13EbtaaxpnXsE5/VBPEtq8eA5erBmUOO85FRdoAgxyxO8sb7r3ElqSQoI5eH?=
 =?us-ascii?Q?nqCmOjzHpJ5mPoSjCMCIp6yJnBcckvPX3sS/lw+ZewgWlEYpeAo+kwORyrc9?=
 =?us-ascii?Q?XugKojpHJ85gblqIUcSXeDncpRrBs9TO4Fv/Ka+yA2tfCWuV4AuwfiwISN+1?=
 =?us-ascii?Q?ExeYXr/8kRIZJvN4q2t9egIZKZhWHfffVKJzXAkROfKIAO33xjoSBTo1qJWY?=
 =?us-ascii?Q?+wOyz/4vY9CiQ7jKqODXWuluhl8CvGn3y610mTKICOHCsGb1tZMDeXvFWfBA?=
 =?us-ascii?Q?LXzeDXefGt9jsqVBMt11wftXs/64i+smTEqbmFHnD6gVMFTFiBQCvwrhR4jq?=
 =?us-ascii?Q?b5tb9iD7nvlTljO0gZkqcUOhb/5ceVxh3CNB4r47n50Uetu6WwTfYP7I9InS?=
 =?us-ascii?Q?Q7xk/1ePqTmmO5lA/U50ztIp7HwH/AIQAQnRux1C0n5Kv2PLXslUDGTu4Otb?=
 =?us-ascii?Q?me7Y4LcMx4+DgagkorRygEzXjBM16H2d/UcDTTcgP89koMSCk6PsZFO/Z8gJ?=
 =?us-ascii?Q?1X1wkiuOYGSVejFJ9LIe4bVVauhJILCemmkNoGC81yZmBluTs96sVBxbbYfj?=
 =?us-ascii?Q?May0XTUKwuMVAsWhwwYVtje+xO3Uj3b3FJQ+djZES4FXlbVKmamzKsFiH3DL?=
 =?us-ascii?Q?M7gmX1MwZqrhOWex4+MBrcJdTOn1LgLdQnVqUSqYHVINVNJCmsyZsd1s/jmw?=
 =?us-ascii?Q?KuUeZv4XrbUvN+xSeOTm/slWIlYC8kUalv0bPV4+dt/E8JJbhdaUkCEortzT?=
 =?us-ascii?Q?oPGgSgETp4qvkB6o5Ds3E1K+M7xQ+0FKBnaFYVodXMtB/9I4oYteUfoRUZWw?=
 =?us-ascii?Q?FzdWXRIbVA0anrcxDYVsa5+l+ekJ0f8M15ci+E2cpAJWpZ9OLuJ5uA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(82310400026)(36860700013)(7416014)(376014)(14060799003)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 10:57:49.2965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 462f0c0e-d778-4ff2-3542-08dd8c8cd76c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9082

> On Tue, May 06, 2025 at 11:47:44AM +0100, Yeoreum Yun wrote:
> > > On 06/05/2025 10:41, Ard Biesheuvel wrote:
> > > > On Tue, 6 May 2025 at 10:16, Ryan Roberts <ryan.roberts@arm.com> wrote:
> > > >>
> > > >> On 06/05/2025 09:09, Yeoreum Yun wrote:
> > > >>> Hi Catalin,
> > > >>>
> > > >>>> On Sat, May 03, 2025 at 09:23:27PM +0100, Yeoreum Yun wrote:
> > > >>>>> Hi Catalin,
> > > >>>>>
> > > >>>>>> On Sat, May 03, 2025 at 11:16:12AM +0100, Catalin Marinas wrote:
> > > >>>>>>> On Fri, 02 May 2025 19:04:12 +0100, Yeoreum Yun wrote:
> > > >>>>>>>> create_init_idmap() could be called before .bss section initialization
> > > >>>>>>>> which is done in early_map_kernel().
> > > >>>>>>>> Therefore, data/test_prot could be set incorrectly by PTE_MAYBE_NG macro.
> > > >>>>>>>>
> > > >>>>>>>> PTE_MAYBE_NG macro set NG bit according to value of "arm64_use_ng_mappings".
> > > >>>>>>>> and this variable places in .bss section.
> > > >>>>>>>>
> > > >>>>>>>> [...]
> > > >>>>>>>
> > > >>>>>>> Applied to arm64 (for-next/fixes), with some slight tweaking of the
> > > >>>>>>> comment, thanks!
> > > >>>>>>>
> > > >>>>>>> [1/1] arm64/cpufeature: annotate arm64_use_ng_mappings with ro_after_init to prevent wrong idmap generation
> > > >>>>>>>       https://git.kernel.org/arm64/c/12657bcd1835
> > > >>>>>>
> > > >>>>>> I'm going to drop this for now. The kernel compiled with a clang 19.1.5
> > > >>>>>> version I have around (Debian sid) fails to boot, gets stuck early on:
> > > >>>>>>
> > > >>>>>> $ clang --version
> > > >>>>>> Debian clang version 19.1.5 (1)
> > > >>>>>> Target: aarch64-unknown-linux-gnu
> > > >>>>>> Thread model: posix
> > > >>>>>> InstalledDir: /usr/lib/llvm-19/bin
> > > >>>>>>
> > > >>>>>> I didn't have time to investigate, disassemble etc. I'll have a look
> > > >>>>>> next week.
> > > >>>>>
> > > >>>>> Just for your information.
> > > >>>>> When I see the debian package, clang 19.1.5-1 doesn't supply anymore:
> > > >>>>>  - https://ftp.debian.org/debian/pool/main/l/llvm-toolchain-19/
> > > >>>>>
> > > >>>>> and the default version for sid is below:
> > > >>>>>
> > > >>>>> $ clang-19 --version
> > > >>>>> Debian clang version 19.1.7 (3)
> > > >>>>> Target: aarch64-unknown-linux-gnu
> > > >>>>> Thread model: posix
> > > >>>>> InstalledDir: /usr/lib/llvm-19/bin
> > > >>>>>
> > > >>>>> When I tested with above version with arm64-linux's for-next/fixes
> > > >>>>> including this patch. it works well.
> > > >>>>
> > > >>>> It doesn't seem to be toolchain related. It fails with gcc as well from
> > > >>>> Debian stable but you'd need some older CPU (even if emulated, e.g.
> > > >>>> qemu). It fails with Cortex-A72 (guest on Raspberry Pi 4) but not
> > > >>>> Neoverse-N2. Also changing the annotation from __ro_after_init to
> > > >>>> __read_mostly also works.
> > > >>
> > > >> I think this is likely because __ro_after_init is also "ro before init" - i.e.
> > > >> if you try to write to it in the PI code an exception is generated due to it
> > > >> being mapped RO. Looks like early_map_kernel() is writiing to it.
> > > >>
> > > >
> > > > Indeed.
> > > >
> > > >> I've noticed a similar problem in the past and it would be nice to fix it so
> > > >> that PI code maps __ro_after_init RW.
> > > >>
> > > >
> > > > The issue is that the store occurs via the ID map, which only consists
> > > > of one R-X and one RW- section. I'm not convinced that it's worth the
> > > > hassle to relax this.
> > > >
> > > > If moving the variable to .data works, then let's just do that.
> > >
> > > Yeah, fair enough.
> >
> > Thanks.
> > I've success to reproduce. and after check, Sending with this fix.
>
> No need to resend, I modified it locally. Thanks.
>

Thanks. and Sorry to all for making this because of my lack :\

--
Sincerely,
Yeoreum Yun

