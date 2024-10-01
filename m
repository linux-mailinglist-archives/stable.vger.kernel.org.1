Return-Path: <stable+bounces-78539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F31E98C02A
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E731F22254
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F5C1C6F42;
	Tue,  1 Oct 2024 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="qsvGO6JN"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2111.outbound.protection.outlook.com [40.107.247.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D37282F7
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793366; cv=fail; b=GrzCrl4RsbYxJcNRQ6Z4/bBWbukBVuNXmUsDslH4xKdXAwPVrvYV8Rlngp5x32nWoFLQwqxA4gLnA/62KxM07w85FGT4vGmxIsERzWksrqLuXVKlbu60AZtwX0GXno8wHaZV45dtb4Lp7R1rn7AUOccadZaJo2j+YOSzO1uvWqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793366; c=relaxed/simple;
	bh=gTIbMkDT24GGhCD512wmRWmdPwUqncGSLDHN5YGnRfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qF4aZFS2upIvpEnAWMGDbFINt0bhxHdpxP3vZGyyrF3RABNFbeavVhvTH8JGx84Bs6PhS8Z8BtvFvfAXbvhMkYLdhpYiYyHEtvaCx2KIUAphiiXal6/q+h/bAi9Mf/i1NHfhnNNA404d1jVXWFHObdoikzhTU/SL2qJv6AKGHdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=qsvGO6JN; arc=fail smtp.client-ip=40.107.247.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrULjFMdORcosMCA2nvmD8EN3Z2jcHcKDZZpMpC9on7/DK7MPpeAoAKdMzF2jpNa755QxlTqPOunCzUiVjTmfeBmbTfm26l0Ss4psGMpdMhimxygaT63ysRjuIA2Eg+as1krexu/sWM7Cl3inYEs+emWZMVlIuaTdwuZokLN3MGsodVaX0tVEVKN3v+6cf22Ku8f2iusB4rMT6E7gRd/YLjlQ9HpiGnKLMBiJ8xFIntqXr32ixhyAvaLVOfQwE6bIGy9JV2bD8L79HJ6kKUCYNaQdCJXrsP0SLetH6LJBSXLAn/N1J9d0TIzfaBkyiIFDIuSPADJ2WK3t6/YIFRkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/r323dAG3E72Qs2TdrH6ebelnzrJEBioCCT8NByX0s=;
 b=daxoF4QvK4xt2H/cNNY3ySWTV0UQq/QsumO5fEQSEd2Hp+smkhMBBdifdI2I7ikb0/OlKayFYW81k/t9TRxQ6XKZW5YHnrHgHRN7AEnYJ7j1Re4m+SnwrL1jilh0aeHBgRbarxeSXdck9m+gfgxyucFY07+UL0TDB/8z8A9OmYZO43pbIFrsB6B2v0EDhs2muGRz70+FRkA1B/ZEukwfy98tciUqHaJZ6EO7Aooawp3eb8aE83ng6+yB/LwQ/W4JvTaS2+1x3KM2cIFp+Z+sk2psG9SRWPtFC+t58lOzNB4Wbt4LT6oPM4w2esQgLZQKWKc5oYlAEzohMFVt8PqFOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/r323dAG3E72Qs2TdrH6ebelnzrJEBioCCT8NByX0s=;
 b=qsvGO6JNqiRUBZKkI4QZ+PnvslK1Jjn38giT2Z6GiIsfe9xXzjx3yglMlsbFhtOCR7LDFG7gRzH9TpjrvWyXrSRaqElZ7Mup2u91l6nV+UCuVYfoq3iyP9ATl4f/VEqai/KwzXKDXel5dyBrIqhdn4en0siveMVbkjZ8sJsKDTCoK45s4AYKa7rppaqlXUXHkf3znofo/D2A7Zg/1S1cRS+8FamsbKrVT+ByfHsy/hqko+aLnhA88VFbfAe5kRkoZu5KQu/24zm3e3hCmp+g8YeswDUzI1E3R51bkKlBZvZmx+7jpeDBrLZf/nhYRQXxXLxQtlGz5njaeg+oLOi8tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by GVXP192MB1758.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:68::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 14:35:57 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 14:35:57 +0000
From: hsimeliere.opensource@witekio.com
To: hsimeliere.opensource@witekio.com
Cc: concord@gentoo.org,
	johannes.berg@intel.com,
	kees@kernel.org,
	keescook@chromium.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6.6-v4.19] wifi: mac80211: Avoid address calculations via out of bounds array indexing
Date: Tue,  1 Oct 2024 16:35:40 +0200
Message-ID: <20241001143540.4271-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909105332.130630-1-hsimeliere.opensource@witekio.com>
References: <20240909105332.130630-1-hsimeliere.opensource@witekio.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0248.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::14) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|GVXP192MB1758:EE_
X-MS-Office365-Filtering-Correlation-Id: aaec7cd0-e0d1-4da9-0db2-08dce2265ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u22ZMWnjWmm7kbX7UvEHLF6V37ReDXN55vK7DOPK+ocpcmYNWu8nyDr0XKYg?=
 =?us-ascii?Q?+R0uOsH9E4OzvMUHfGdJmY67Jyzksk3DHJoePAGwxhJiiqrJuKPsYhDaiCdT?=
 =?us-ascii?Q?8EIKxM0YxqXRhZ6C46NZJexzfmDKGZqj9JOW0y5lB6T3KRvi+bPpoRmXmJ5O?=
 =?us-ascii?Q?X9Iqs3HB4XyTXAulHqx93QVFCM0sH9dKu/DvCDAJGHbCLti2jsXDHk5+3CNe?=
 =?us-ascii?Q?fFu8Q7vMPjb2w3iqdfVZU6WjBPJOH9ukrxpCVoIgJhTw5TzYowMejx1AeSwn?=
 =?us-ascii?Q?B90tlTmadaemobGUAuHxNpV9xKBeTAMYqC7pfdKsdmzEdUFr2lr0xZuQQH/U?=
 =?us-ascii?Q?zJIoi0TYAn2+QiDfxPu6l1DPvJ0vGOXgDUO87S8qn4F2b3EfUVRyS9eHySAn?=
 =?us-ascii?Q?nOHzJ2t3r8xsWTS59DQlC8r1YASHq8PVQ1HF5U/3Pey/jzqWuJK/xzrlPvhh?=
 =?us-ascii?Q?aQcfvkeEWEPiW4WxkPrsOeaq3bHjlTSp4MlsxX/vXdx6rwcNNACvfNR+sUvv?=
 =?us-ascii?Q?J7wmWeqjKepagMYTc//BsHYgjacY03mt4JC1a/3h6oY2BUVvFP6RyLTQ0GjX?=
 =?us-ascii?Q?ChPqOrTHrc0Tg/BEETxddbEq6H6ckmBchVPIVTaz0T15nYrv7CXvToT9N+4C?=
 =?us-ascii?Q?44G8epU1dJJ4H37y/5uquQ3yuXCO1BOu6Iz6Xr1uNFjU+DvvD1gOvJxmDcuA?=
 =?us-ascii?Q?IbMq8DZaV6Drzif84sxYOG/AOcd3FHIQmLzyUddUQCwdNZxcUBrVWNQJu0F/?=
 =?us-ascii?Q?y1aejv1AUviEhlNY28CKTuoKr3odUHWaKsPuf4Q7HLiaPzw8aqH56cVQfJWh?=
 =?us-ascii?Q?pZ4Crf67X77+iX3eV6V6tbZ1+gqL+nKtBeIeQeq++MV0Y56gYDrYY1E7UsiF?=
 =?us-ascii?Q?EpyIKZ9W4deCgV9b54Xv1wlBrxVYPf+czAO1YEtxqlXXpqpmy0AOBYIToeOy?=
 =?us-ascii?Q?vaa1ukIr3F/UkVh1vnleAje6eYIyaoFFJG+TINPWNAce3R1PhIXbDfk5L1du?=
 =?us-ascii?Q?kQlC7FlNhqRAjocNgM9S7RoJziO2N59IlRmeWeIGPPZ3T5abMlW7vf6Kn0HH?=
 =?us-ascii?Q?M5vZoDB8MbjnSHMWU7hr0zP/FJVZeBkBPiAnEPiAMVbojgNrlxWFvmcYTKNR?=
 =?us-ascii?Q?gr/41/xcocgegUNyHSjThNqhh/QGleECvxlSe10d+PQC38bDzJuafVzpsxB8?=
 =?us-ascii?Q?eVyaMftwN7QKdtPw+DGHrGSMVZh8or4gosvBsHG1jENvPm7/BclW6SduM+QU?=
 =?us-ascii?Q?3Bc8JUtiAD2sTKcVX0mH3TvuGOZHRAn2rggLaKbzbxO75xZsvZRfhcJO5CNI?=
 =?us-ascii?Q?j/xVelpq+npVd679uvRhI+dshZEYPaDn4mX3YKcC/swAV2lH9KuETmhADbC8?=
 =?us-ascii?Q?g332W7AJxPtBmqtLWV8Yf6d3uuunojabji5X7d4kH8XUxHl4Ww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VtGNg+a4GEQM4OR5FDihmlteogfSG0HeEWn/GOigPaNg3e/CRHCNcRS3wiC2?=
 =?us-ascii?Q?k3b6gVNAfQrS+neQ2mtrizohGYNmflorv+felYMDQVmAx1RfbKQElp3Dd/Zl?=
 =?us-ascii?Q?Ci4xto24dcOtGj26SCchCZcaMBpblsR0HHIi7EJBZStt90W9gv3UtrgfjDZ7?=
 =?us-ascii?Q?H/UqYQxXBJtd7GfUKB/rJE/MNsVB6m5eFMMGvkPbkt2SzYecV+OBqRe3deOr?=
 =?us-ascii?Q?0miIi8eX7l7DsLWL3aZnXSosf9kI2u9gozuZhhiCkIoYPSpoCQ7ferCAwM78?=
 =?us-ascii?Q?bpSwK7HG07Ghr+Fu9eGglm9pra7hWvl4E/or+5w0D5U7lnNMAp8oXGnNXngw?=
 =?us-ascii?Q?ItECISBn5GTgd5rZk2g1sAe/kY7AyypqGrlKzQPdpnag+cMIQyOE+gT9ujLD?=
 =?us-ascii?Q?ndgV19xPzirwvrvfOHA6poCeRw7ILdivbyTB9IUk2ZsmpOX9NT5xZB0MLI3q?=
 =?us-ascii?Q?2kSaiWKhzuzTq7I0mQ45z/burYPvuZXDer5l8GknZnmRDTiLNvZqrIZ4s+ja?=
 =?us-ascii?Q?lEtKFh4iaV32dORmE4wh7UwKm79tmnaMSLaeBJUBd6QUgPk8lqAcQ5kLwyMm?=
 =?us-ascii?Q?7RY5S28J2XPrC9GdzSBXl2569eaEYBrCJER6xOIaAdVMosX74eJM9BrzMR1h?=
 =?us-ascii?Q?OCJWikc/GvkIumwMH2706JOJXFBqAnn57bYjbMKUTSfvWwlYPbVID2cAcUtT?=
 =?us-ascii?Q?nRjx3o5Rmx+grYjt1N8X3bRGq1guzlqrgB78daes5t7oXfWM2h7qW747Mb2Q?=
 =?us-ascii?Q?owV4KaIFLwcFF+C4uIp92BRz4kwG7NZEIfGV5tsep5+pW0/8GenTFCp/+4rp?=
 =?us-ascii?Q?9ARuR5yVwvC/m6Q9fBAnTO5Eb+RCFG/izmAUCA4LYsphWSQBe2q/t3EepX6K?=
 =?us-ascii?Q?Rjn4f9Zs9VuDL4azIS1AS64Xh9QiAn27V8i/cju8Ykso03ctpP8YVYfa68zn?=
 =?us-ascii?Q?0D8EUKP274/U0p8vZQXXF6ok4TPlEl8/v/+TQG+WMelwM3EnIz4+RFLdODG+?=
 =?us-ascii?Q?ZnalpTF2jrn8go2vtLApemXRpmXfgyUDDN7oGBmLI5H0/cPJCPwtOko4ieFA?=
 =?us-ascii?Q?h9GCmqiXEPu56PmwZNVf407U51nW25PtoVQCtBIjd1T0rWJ/yA1tW0Ryfd/X?=
 =?us-ascii?Q?f5z3zv9H+23Nh6k+bWA/2RWUbkrlJxUNhZkX4mOy36S/5XsC9muH/iH64W1b?=
 =?us-ascii?Q?zBOJJL1qeyEOqbI0/uvkD0LnvMojP6JCQd1CQqe88zWsW9zUC1dfOuXqSMaK?=
 =?us-ascii?Q?WO0vRsqsbgWiVuP5PVSJ3oiNFx4iLv12980m87HAu/3v84u4lwgbU2TaYJ2e?=
 =?us-ascii?Q?KeJjkTbPRAQjIMKQ0/gPdQkajnslBROehwd4Ip74NMcWhHyJ7XDK9faK4nQZ?=
 =?us-ascii?Q?OAzoJsyQDzdIBIT9q/s1TLk6Xmo8AN01zksZ5XrwWCedtBGU7GQ3ebnL4IGD?=
 =?us-ascii?Q?FZdh7mm7mHekF/KAe1CLT7sO5ob7WHYgeHcLwzHu3s9lzw+jfhmS9lbwk+9k?=
 =?us-ascii?Q?3gwSu1F7ctHd/AX51K5Pc7ovvhfUoobyHtwZfVHElyREVXL2UFUSdcod1JZB?=
 =?us-ascii?Q?rt+rYaVwq0D6pqWuXG86DQiXissrX/RTTI37BUza?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaec7cd0-e0d1-4da9-0db2-08dce2265ca1
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 14:35:57.7567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0D05SwjzOMqGpQjKp+BP8s7r+Pu1riZ24xGFy99y9O0riB9uCFjxTKh02ECBlHA/XEPBSNTYiRFk5GwuN5ODA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP192MB1758

Hello,
I've noticed that several versions have been released since this patch was sent, but it still hasn't been integrated. 
Is its addition planned for future versions? Or is there a problem with this patch?  

Thanks,
Hugo SIMELIERE

