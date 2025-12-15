Return-Path: <stable+bounces-201009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D3ECBD0D8
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 09:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D7BD301E91F
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 08:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C32D30E83A;
	Mon, 15 Dec 2025 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="L5oUOoOJ"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9122313E3D
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788796; cv=fail; b=IgqdStLju3RMc8OJE5evfW2poiDtJSprUnmupwsYUH2MLDOsZ1utIkHbv9Ew8wuMP0i5FagxFbVauaAHdJa7NxCF8Dy5SgbpFV4tPrDiJdVBJ8ZpcpOY/Dc+YJ4cF5G9rSC17KPIh3LiSD21jroi72tuQ+mQaILr3ZT96qYzcAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788796; c=relaxed/simple;
	bh=R+7YZPSEZP3qZmzbWWSfm7OFmFNVN7CXKkX1TkK+ITQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=J0VpEAs2CdvoHietjpqq4ffhmamiMiamtF07ZXNL3ik95qVBPYPNuuWTyY9aZP+LrW9/roPr7qyYsmea+6qL2i8DKvrW4PBlmp3/imMu/AA9SIvZVUsS9OkPf0yXQUl8JmcmsL/qFyotSIQ4u1uj5HJOMNMgEWp580qOkMslWz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=L5oUOoOJ; arc=fail smtp.client-ip=40.107.162.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TODNPzvjIB04s2bfV1kuvdROqSK5NEEp4bxMAy6t263V5P/ukmV5oKMGPZctsD+F25bAo0zE7lmQmBSVv/bIl1fqqSOQa5ErWVYqUhNIShER/+f/QlbV8FtzibQCTpjCKTrbgGx9J5iqb6J/j7RfZxKVlb5rUc7PDn+fIg/A0jA9Ga1D6048GeizjgyDp/zlNWEXBt6lEvNFTuhP8MQ9dZQDsntU8U2canJPdUbgZeJemtx9oYMcQhaBl0Jtt+jwS5WL2WibXwdxHC3swwHJU65sr3rzz85IX1y6RcSVbR6bg0oz9aQlt2jPOw6bqaTp7xyeyQixHcxxro03PQkALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUWFYS1nxNIbyoW+V0+Odjr2aTYDCp+Y0FwgNURtcgc=;
 b=St+YV7HLRBlhj9Wjh0oMYiE3BFlIdBwg0oe0g+TogQU8YB4/S6HNjd/M1OD1oSIpFAa5mCa3HViXIrOUjmtaxkxnp/Vp9I+F1E2lHkDrYgV4adw0TVId2QbAS7hq3gWq8RNFJ+4dxgKEtsm17+cEx4sD79XIu2GFZk8Pidb0VIe34S9dIeT1BBJo8AaX6e0r1domp2IELLAj/t35p5nmqMfTgoXY4+J17bD5HQ2X7TaKfCyEYVTZdM4h0s4TmljqZYrg+X1Hm/Q6M9pzoYJfpWDZTwUCiM/HL8HtxJVZif9WhseCXGXL4pEPw0aGdijDS9P/7KRWUt2OXk3yqt9qXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUWFYS1nxNIbyoW+V0+Odjr2aTYDCp+Y0FwgNURtcgc=;
 b=L5oUOoOJvPv9RusXOwetAwYR3GJw60CF93tiMYcnN8U/mH4R6wX4gtpnVnBgxBgunEdTsN7WJMiMoWfucwraNbUmUcdQQLzMrfRmGz4vvNkR3bHpVfdEO9wUqZeYCdApzR4gpj1jC6BRKMXEBYaaPYcBCumRNBhFMP7dluAiFtNAnv0DfcbSrpoVbAAZ0KyF5pSXHXI0En9p58Xy2gciJ/0DNBhX/extN0zpF6Sp4SNoMIm3XHy3qhUtXczpesaJWv/smAa/enDl6d9c8NG0IrItacAPfLG3WFFSlJebWGpiE5tw2F8bYg4muSHHJjP6Vh6T9iogvLVd/fA32p9BZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by AS8P189MB1301.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:28a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 08:53:11 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b%3]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 08:53:11 +0000
From: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
Date: Mon, 15 Dec 2025 09:52:57 +0100
Subject: [PATCH 6.6.y 2/2] ext4: fix out-of-bound read in
 ext4_xattr_inode_dec_ref_all()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251215-cve-2025-22121-v1-2-283f77b33397@est.tech>
References: <20251215-cve-2025-22121-v1-0-283f77b33397@est.tech>
In-Reply-To: <20251215-cve-2025-22121-v1-0-283f77b33397@est.tech>
To: stable@vger.kernel.org
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, 
 James Simmons <uja.ornl@gmail.com>, Ye Bin <yebin10@huawei.com>, 
 =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765788781; l=7480;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=Z1VRqMYzYuR4au4hkpR2GzCRn1sQdOoFoa3s/PDHJsU=;
 b=TV3+LAPnoEVNdUluQzvFQjeM0vRZ14RaQOKoUNHg9JKYJdlYAbOnIZ0azxIusWuvAA2t4Ll9t
 3joACOb3TTUDak9ozEkbp0+cMqYVpJ2vx541KZTdrFIoQ3v0gxj6EVN
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: LO2P265CA0289.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::13) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP189MB3241:EE_|AS8P189MB1301:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4842bb-47ed-43c8-3599-08de3bb7603b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGZMK0lVRUFENFRiajBFdkQrYUJIeUlUZG1WTlRFQUZNU1l0ZUR0UW9VaGp6?=
 =?utf-8?B?enhZdXhJbWkrL09xMXNOZkVsdzlZYkxIMTZ0M3NIYUJmamRRamRjRDJIQU9y?=
 =?utf-8?B?NHpLcjRzUHVVU3RiN0M4VVo4KzRjeVVrMWxJYmtxSTF2TkNOcUovb3NadkxG?=
 =?utf-8?B?b3QrVnA4Yk9DNENVN1FZSXQzOVBUVEZMOXZmZlllSjJEZU4vSjZBVEljWFcw?=
 =?utf-8?B?bStMSE4yQXU0d0VnVXJIZzc0cFVybEkzOXBldmNCNzR3MmwwVjFGajhmOWNm?=
 =?utf-8?B?K0NYQVkwd1hGZG1Ja2tRWTF6T1hPUGFtankyM0huSVRjY00xZWdQa0FKWlJB?=
 =?utf-8?B?VVJjNDJWd2JKck1xZlVHeE5OZ29HVzJZNXpjUVJJZHRNKytrQW92Y3NoRlda?=
 =?utf-8?B?dXIwUFpnWFpEK3VKdm52ejlxaGx0MWJYZ1ZEcXlTamZiY2NKRHN2b0JQR0hP?=
 =?utf-8?B?U3JCWmh1L3hsbFgwbU1HMDFxMmN2cTZNdTJBWjFudlo3aUQ4aVJOcnhPNzJU?=
 =?utf-8?B?NXB6b084aGMySDArc2JKRHZReS95ekorNnZmLzRrN0cvMitwRVRjOWg5V0ZN?=
 =?utf-8?B?NkIxN0Y5cm8reVNjNWhpbGRCaHB6Yjc5V2RYQzhyN25GSis1K3dDU1QyYkZ5?=
 =?utf-8?B?THIzeS8vNkk1U3BIZHZLTnZoSW5KdmQrTUJ0dUVPWnViMzEyZWVIMWxoYjcx?=
 =?utf-8?B?Z0R2VEVXWVlnZit1SGdqMTZHeTYvZjdWQ2pZM0NuNko0Vk9pdTZhSUhDcTBH?=
 =?utf-8?B?OVU4S0s4K0NpSTEvSlpKYTVaamxMa2pMbTJWdmo3a0NnTFcxaGU5Vyt0djFQ?=
 =?utf-8?B?ZDBYalpwclE5d1VDcEpxZW4xMnBUOUk0dGlGMGZKV2paU3JHcXVOZWtPYzNS?=
 =?utf-8?B?UzQ2eWtJcFppcXl2bDZ4aUc0eFVpcFovUHA1d3ppZEJTd2VScUhUVE00cEhn?=
 =?utf-8?B?aHNMSE1WTkV5clRDNXNOVm1vVFRITWREOUoxSnZBNCtDZlZpeldJNzhEQWsw?=
 =?utf-8?B?MHFKelVFZ2JseHhpZEFqeVZTajJrdnk0czBheFBCTk1pc0h4eWJPaE5IMlRo?=
 =?utf-8?B?eHpXcDhvSTRwZG9uTHdqeWVYSEg0NDFDZHhqeWdVV21pN0djUmMxRUpjYk1X?=
 =?utf-8?B?S0xPc01pR0dtd3QyQWlZZFJpbXBMUENOcGliRVcyNDludi91eWU1cHBqeW0z?=
 =?utf-8?B?Mm0zc25hU1VIOHRXZ2NBS0JLRUR4MTBObVN4T2lYU2xEM0VNRVd4VWlZRC9U?=
 =?utf-8?B?azlRaFl4MGtxdjlVMVpxRlo0b1FlOEJkRktIc0V4RFIxT0ZnTkZqc2RxeGw2?=
 =?utf-8?B?dFM0TllFRlJtT3ord0tDTS9RSGxyMzdEVnZzaDJ4WkxKd2xJRHlBMm1vMTFn?=
 =?utf-8?B?aTU5OWgyckhTblhGYU12dXU3TFI3OWtzcXkzbVVUOVByR3NQQU1IRDZoRFJN?=
 =?utf-8?B?UU5SRHdyM05OTzhvYzRNK2dFMEl2SzhqcU1TM0t1VldjNm13b2xEQmtaajBW?=
 =?utf-8?B?aitUem5RN2VKNUtOT2gvb2xTVlZDZU94enJiY2pZak9RdGFwVVIrTG5ncTI4?=
 =?utf-8?B?SzZQWWYxTXNpNTN3Q3A3MVA5L1ZpVmNQS05yM1NLVVBUTFV5SkdFTzcwbVBD?=
 =?utf-8?B?MjlYNEc3M2xraGtKQnJ5UWMySVdUQjRPWVRRZ1RDand5NC9LL2NzUVhhOXdT?=
 =?utf-8?B?Y1BoZE1KcWc0cURXRnd6anhGVWUvVmp1RVFrWU9BZ0hlaEdMU1VGWVl4Nmls?=
 =?utf-8?B?K3JpZnFEQ0hYM0ltalNabmlHYkMxQ3ErWTVVQzMyR0l2WHFmN2J1RlFlS3lD?=
 =?utf-8?B?RGF6d1NwUVhpd0kxK2E4RnRRQ21BTnh3ZW02MitRaUtHUTJkYlc5elRiclk0?=
 =?utf-8?B?ZU9UUzE3eFFSQk51d3FpamJVVy9zY3NxZWtScUg5ZmJ6eXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3pRMzJwd2hIc2dOWmZUelUzMjhUbnFLT2U1bmdmbDdLNy9XV2paV1FCNlFk?=
 =?utf-8?B?OXBLazlDYTNkcitKdUdyanRzam82dDJrZGo3bDZYL1lVYUN1cUFhbFJKQkI1?=
 =?utf-8?B?QWd1RUErd3k0UHVjM1Z5aVhmeTE5QVJSaFpTWmVWSXJScVg5MEIxTVAvVkpD?=
 =?utf-8?B?NU4xN3VKKy9ONzRuYllqMmNZSTg1RmJ3ZzJ5MlM2QkVjVjN4TVpndytIeDhv?=
 =?utf-8?B?RlBtNkpwSUxZODhLWkExdzRNeldUTWlUbktKU1NQK3RnR2Q1WlBoVDk0WFZo?=
 =?utf-8?B?S1ZSbmVSM0huOGtxYlVqUHRKQXVnUVdIQ1pPTk43MTdsQW12QlZDVDE4REZH?=
 =?utf-8?B?dGNNUFhVKzErTDk2ZjkzOVFYcml3WFF1N0UxQ3FiNytpYlRwVUxHb3pZU0Jr?=
 =?utf-8?B?TVRqalVYQ3VKR2lzOHl4SnNnN3E5WDVYUGV3ZlJ0Q212T3ZxOGg5dVRneWVm?=
 =?utf-8?B?bzlmOGZsYnd0OHpDeFNmbzR3YVpLbFhzRXpGczBMb0xWR3VUb2x0aDNWV1Ft?=
 =?utf-8?B?V3IvZU5GODB1Y1crcVNZbll1TUtmMUlhNjlIRFV4cWd1VmpIaytaRjVKeG1q?=
 =?utf-8?B?UHRCODBRSVliaHV1MUFOMlczb2pIODNoN1ZGREZVOFpWRDVjQTNudHg4RXln?=
 =?utf-8?B?Rm1TMG56T1JVUitxUUtiZzRDQXE5UlFEMUpHNlE1dWZJeW5KdXFJbjZOcWsz?=
 =?utf-8?B?cDk0T2JJcVNIMjM5cUdJZUdlaXE2dzVxSnhWTnZScWpxM2t5UjRJM0JrQXBa?=
 =?utf-8?B?OFRVb0xpcTFqdE1uVFJPZlE2a0k5NkdGZy9JamhGc1B3SzJ1Njc4czVySFpn?=
 =?utf-8?B?cytnZFc1S2RvSzVrWHlUck0zdGtMRXVvY2xobWtFSEZqQmZUdXlsSUFSaVFm?=
 =?utf-8?B?R2JSZ1VsNVRZbW01WVA1YnpqOGJyTHRxdmpXK1kyc1NJb0dheEtDaTJFcVhp?=
 =?utf-8?B?MFdOSXM4S2t3ZitSK2V2MzlOQjQ4SHJLbEdld1F0clRJRE5aVDZvZ1pENzBY?=
 =?utf-8?B?aEloUVJwbFRSSThmaEVDK3pXOHRzdk0rTEp5c1RVdmR0VityaUFsbE9TK3dp?=
 =?utf-8?B?NEdUeVVMTGdTNkJUelFSYWl4M2RROXNNZUQ2RHJTRXU4M1dRWE9JTml6ckp4?=
 =?utf-8?B?eHcyMVhuQ0ZYVXVoNlZodDc4N280ckdrczZ4ekpLRk1mbXFyK09FakNJVFF2?=
 =?utf-8?B?S21JWks5OHY2MkxMeDFyZkw5bk10eEJGa3FQUUxlTm5ZRzF0YTd4WHdEa1Fn?=
 =?utf-8?B?NzM2T1pZb0UxcytPS3BwRTZWT2hhV04zaXRyQXBuT2VDZkNCb1lkS3ZxMW1n?=
 =?utf-8?B?S2NtOU9lT3plTHBTNk1KeVZERlcrM1YrOEVVVWlGVEdwOGZLMVZVTUc1YXF1?=
 =?utf-8?B?bytNU05HSmtEbEZSNlhVemF3MGRhMTJZN3Zkd2ZQdXJKT0FyR3BKeGpHcHh1?=
 =?utf-8?B?V2VUakY0TXdHSTRIbW1HMUtGdnRmbGJVbTcvaTYzV2VXS09SL1hUUDJLdFlG?=
 =?utf-8?B?d1gxbkxWZVpSNlhON1hlSFJQeHFxSkNFS1B1NWMvSktYbXFxQWxTbXBodzNu?=
 =?utf-8?B?blkvSk5jRTJWaWZ1LzI5WHFhZ0Izcks5dTBNNDBidXBidHBJMGtCMjM2YXlE?=
 =?utf-8?B?dFFoZFNkUnRoeXlwdE5lNElZcXJDcEtMcEpBS1FBVWJpVWdsRjhPMVdSaHBy?=
 =?utf-8?B?KzByZTA5R1JIY0hVdWZ2U0RvazBKcTdsVXN4MzJBeTh6V0hDVDcyTGxSYVo3?=
 =?utf-8?B?aUdWTUNyT25CaGdCZVpUQnNUWU94Q0lCN0FZekZxb1R3SGpQYkc3a0ZacktW?=
 =?utf-8?B?bHRINDk2SVUyNTlZZG1jT25PKzBUZU8zUXoyOFg0MC9oY0dlNTZScm5OU0tO?=
 =?utf-8?B?T001bUxZSjB5aGVDVTVZUVllcEtnQXJuaENqc1FnR21sTERIQ3Nhci9WYzhK?=
 =?utf-8?B?NE9sTXBBWjVFZnJ4Qmd1VkYvOVRSbGlxUEo1YXNJQ3hSTjd4Zy9LMWRMWm5L?=
 =?utf-8?B?RnhnNG9IWnVJbnNka0c5bVhtWHFlTVB6Nk45VGZVbzhxdDk4dmtjWmV5cEhY?=
 =?utf-8?B?anF2TjV4Q1dxMFhyZk14UnFnY3BXem8vUVhqcmZpc2htWGZRVFh4ZEtVcytB?=
 =?utf-8?B?K2NRNFhmZnlrWW42SlBjNWdnUmw1NFc3UzNKMGxGVkZqOUh4b09PVWMyTDRY?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4842bb-47ed-43c8-3599-08de3bb7603b
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 08:53:11.3813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HEYiHV/+RzB7NKVQJdOqof7PHcMmd0g8v1cTVPswbg2N9WkgdlC1NBXq6SZ7CxBd4fWArv7R1ETW4Xo9H7SLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB1301

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 5701875f9609b000d91351eaa6bfd97fe2f157f4 ]

There's issue as follows:
BUG: KASAN: use-after-free in ext4_xattr_inode_dec_ref_all+0x6ff/0x790
Read of size 4 at addr ffff88807b003000 by task syz-executor.0/15172

CPU: 3 PID: 15172 Comm: syz-executor.0
Call Trace:
 __dump_stack lib/dump_stack.c:82 [inline]
 dump_stack+0xbe/0xfd lib/dump_stack.c:123
 print_address_description.constprop.0+0x1e/0x280 mm/kasan/report.c:400
 __kasan_report.cold+0x6c/0x84 mm/kasan/report.c:560
 kasan_report+0x3a/0x50 mm/kasan/report.c:585
 ext4_xattr_inode_dec_ref_all+0x6ff/0x790 fs/ext4/xattr.c:1137
 ext4_xattr_delete_inode+0x4c7/0xda0 fs/ext4/xattr.c:2896
 ext4_evict_inode+0xb3b/0x1670 fs/ext4/inode.c:323
 evict+0x39f/0x880 fs/inode.c:622
 iput_final fs/inode.c:1746 [inline]
 iput fs/inode.c:1772 [inline]
 iput+0x525/0x6c0 fs/inode.c:1758
 ext4_orphan_cleanup fs/ext4/super.c:3298 [inline]
 ext4_fill_super+0x8c57/0xba40 fs/ext4/super.c:5300
 mount_bdev+0x355/0x410 fs/super.c:1446
 legacy_get_tree+0xfe/0x220 fs/fs_context.c:611
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1576
 do_new_mount fs/namespace.c:2983 [inline]
 path_mount+0x119a/0x1ad0 fs/namespace.c:3316
 do_mount+0xfc/0x110 fs/namespace.c:3329
 __do_sys_mount fs/namespace.c:3540 [inline]
 __se_sys_mount+0x219/0x2e0 fs/namespace.c:3514
 do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x67/0xd1

Memory state around the buggy address:
 ffff88807b002f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807b002f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88807b003000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88807b003080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807b003100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Above issue happens as ext4_xattr_delete_inode() isn't check xattr
is valid if xattr is in inode.
To solve above issue call xattr_check_inode() check if xattr if valid
in inode. In fact, we can directly verify in ext4_iget_extra_inode(),
so that there is no divergent verification.

Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250208063141.1539283-3-yebin@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: David Nyström <david.nystrom@est.tech>
---
 fs/ext4/inode.c |  5 +++++
 fs/ext4/xattr.c | 26 +-------------------------
 fs/ext4/xattr.h |  7 +++++++
 3 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 563cd0726424..78b9dba90922 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4728,6 +4728,11 @@ static inline int ext4_iget_extra_inode(struct inode *inode,
 	    *magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
 		int err;
 
+		err = xattr_check_inode(inode, IHDR(inode, raw_inode),
+					ITAIL(inode, raw_inode));
+		if (err)
+			return err;
+
 		ext4_set_inode_state(inode, EXT4_STATE_XATTR);
 		err = ext4_find_inline_data_nolock(inode);
 		if (!err && ext4_has_inline_data(inode))
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index cce549ef16e0..7c8234445635 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -312,7 +312,7 @@ __ext4_xattr_check_block(struct inode *inode, struct buffer_head *bh,
 	__ext4_xattr_check_block((inode), (bh),  __func__, __LINE__)
 
 
-static inline int
+int
 __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
 			 void *end, const char *function, unsigned int line)
 {
@@ -320,9 +320,6 @@ __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
 			    function, line);
 }
 
-#define xattr_check_inode(inode, header, end) \
-	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
-
 static int
 xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
 		 void *end, int name_index, const char *name, int sorted)
@@ -654,9 +651,6 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
 	end = ITAIL(inode, raw_inode);
-	error = xattr_check_inode(inode, header, end);
-	if (error)
-		goto cleanup;
 	entry = IFIRST(header);
 	error = xattr_find_entry(inode, &entry, end, name_index, name, 0);
 	if (error)
@@ -787,7 +781,6 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_inode *raw_inode;
 	struct ext4_iloc iloc;
-	void *end;
 	int error;
 
 	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR))
@@ -797,14 +790,9 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 		return error;
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
-	end = ITAIL(inode, raw_inode);
-	error = xattr_check_inode(inode, header, end);
-	if (error)
-		goto cleanup;
 	error = ext4_xattr_list_entries(dentry, IFIRST(header),
 					buffer, buffer_size);
 
-cleanup:
 	brelse(iloc.bh);
 	return error;
 }
@@ -872,7 +860,6 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_xattr_entry *entry;
 	qsize_t ea_inode_refs = 0;
-	void *end;
 	int ret;
 
 	lockdep_assert_held_read(&EXT4_I(inode)->xattr_sem);
@@ -883,10 +870,6 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 			goto out;
 		raw_inode = ext4_raw_inode(&iloc);
 		header = IHDR(inode, raw_inode);
-		end = ITAIL(inode, raw_inode);
-		ret = xattr_check_inode(inode, header, end);
-		if (ret)
-			goto out;
 
 		for (entry = IFIRST(header); !IS_LAST_ENTRY(entry);
 		     entry = EXT4_XATTR_NEXT(entry))
@@ -2246,9 +2229,6 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
 	is->s.here = is->s.first;
 	is->s.end = ITAIL(inode, raw_inode);
 	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
-		error = xattr_check_inode(inode, header, is->s.end);
-		if (error)
-			return error;
 		/* Find the named attribute. */
 		error = xattr_find_entry(inode, &is->s.here, is->s.end,
 					 i->name_index, i->name, 0);
@@ -2799,10 +2779,6 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 	min_offs = end - base;
 	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
 
-	error = xattr_check_inode(inode, header, end);
-	if (error)
-		goto cleanup;
-
 	ifree = ext4_xattr_free_space(base, &min_offs, base, &total_ino);
 	if (ifree >= isize_diff)
 		goto shift;
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index e7417fb0eb76..17c0d6bb230b 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -210,6 +210,13 @@ extern int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
 extern struct mb_cache *ext4_xattr_create_cache(void);
 extern void ext4_xattr_destroy_cache(struct mb_cache *);
 
+extern int
+__xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
+		    void *end, const char *function, unsigned int line);
+
+#define xattr_check_inode(inode, header, end) \
+	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
+
 #ifdef CONFIG_EXT4_FS_SECURITY
 extern int ext4_init_security(handle_t *handle, struct inode *inode,
 			      struct inode *dir, const struct qstr *qstr);

-- 
2.48.1


