Return-Path: <stable+bounces-211566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEHUCFZmd2nCfQEAu9opvQ
	(envelope-from <stable+bounces-211566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:04:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC03F888FE
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3556C30058CE
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14611336EE0;
	Mon, 26 Jan 2026 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OzhANRNQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dXIOMUdH"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6572E78F26
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432657; cv=fail; b=t9kT4KMG1XaoP/j12QBx6c+FChVrkkDiMWUb2ByxemUBf+Ck5aWVxSDlahcgQ1wOetyf27i7gejMsLcPlQOJxX+WbyugB6gtrgfCWaHlQuG9AxUC2olLsjUmMiWiSPocSW4e6xzzATatrcdloLfj+eyoWnSL8fsjbx5w0NqbTeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432657; c=relaxed/simple;
	bh=NmKQZzGExqg717TmYpHySFhbvwuQ74Cz1OLNkIR7lIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=muWrZ0FOvc0FmEkgWPw6n8EUYi163jXPyzd0ubJDWhuwaUrbCjf38GgXnMgsSmIq6ngGdA0qfa5I9hzZtuNDwwZ+YBtQkw8TPQ0Iy3L5MkhbZ1DP5zo0ij96gpm0kYypeS+drOu+SxnbGaAc3UKDhr/kc2v8rBy1w7VuuIVZ+NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OzhANRNQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dXIOMUdH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q1h5oi502192;
	Mon, 26 Jan 2026 13:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/EBObkuUdQbNJG4Im9
	fGMbnRqaalG1bQEpjEbLFV1PI=; b=OzhANRNQFpSRzTd/4a/G8u4LHoOD+Ogow3
	O07SfechZTdWQlJ09WKjL5AtiNgKNG0kqyrqeCz2voYNO6UgM2Y/2JZ6y73q7yFy
	TrQ1sP9G+p7XhxHplszQbn27HKquoPSUsAT82149k8LfFuAJiG9g55EKe3Z/YTAf
	miDAZ/lrGsg1DEZ/ZZy3zlB3tcclQJ3nZDRaK4RugqnA5+FBuhy+bxPHjcedll9e
	xKJ8xAwqmtxKhh5Db+KDSOydJ72TCeKn3hHONJ5wFErPxVR0z6A/SvLXL72Xf3Tj
	CpLW4Y4jikxcvlSMzZ6OTgYkWPc+4kGtFsXdWgGHQzJuttXBKpHA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmv2st7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 13:04:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60QC1taZ019841;
	Mon, 26 Jan 2026 13:04:02 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhd6n70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 13:04:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqjtN75wa/BKRfNBjvaoCs2ILWoSOSdDGpIsDOTXvyqJ7kdlva/8LHBxWTG2D0wzvH1fJRgBhLNZTUlkV0ZBSTlARSNv5/5LrIiDAtyo3+1Y4jJSl+vM/+VEITDicEvYLcaeP2xEQpJmCIJgqp0pUSIIyq8dB6DhEvHgBWVyrlJCsfi+NWqVn9iVBkbViBBvNq+YwwU4aTlSjOJLc0ItOHCOjYAtnRE+GHA2LA1K3PTorEnf39EBNGreok7OEGbVtBj7zwrAS5+kRoDdTJRK7cnS7XMoqmeU+L1Dingq2+blVMAsUm76hhGqi0N6wdLrCwskFLv7lomPyc7eflGlMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EBObkuUdQbNJG4Im9fGMbnRqaalG1bQEpjEbLFV1PI=;
 b=CiPZq520dtsLJc87GJOsqXPXYPuiehpOpFgrdAKHV1B4jmtjENAGfta3aKEgoJZRUyHHE5jXaoDDkUzuySxxmS//MNbo37Fi8Sp/XL3qZ9ut4NMmve63LFbesFylvH1VyXIkRJT44flHhAPyT4EvikFdHxuzXNM6kbMEPVNCvjEwWZGj7Dq9ULWZqx9zuxa2lQC9Fmb5u3Qu6U8eHpVqkuDmbdPzc79SnlvYDzBc6soFUjlczBHLBgQy1X8LmD3tPJD3D9a2I/BEGX9G9BbjVromhxd5IMhydrvjwgZvMm0/VPj0HFpe9cfbyal8PLzJHuVUzZA5iV3GNUtSBKklAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EBObkuUdQbNJG4Im9fGMbnRqaalG1bQEpjEbLFV1PI=;
 b=dXIOMUdHqvJNXJJt+SXLizMxfSRNah8PK2eO5LyN7lFqjAV8h30n0ZWlBHNf9JIqnNM8WRc365EfdHgLnk2BKkFeAOtD2e4wj7oxDPAUURC9SqOmvQmtpJ1h2GUu209/EWpbKe+SymNV2zDJEy3nBSoESmaakEcGmh/lD80N+Kk=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ2PR10MB6963.namprd10.prod.outlook.com (2603:10b6:a03:4cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 13:03:56 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 13:03:53 +0000
Date: Mon, 26 Jan 2026 22:03:51 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: linux-mm@kvack.org, cl@gentwo.org, rientjes@google.com, surenb@google.com,
        hao.li@linux.dev, kernel test robot <oliver.sang@intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH V2] mm/slab: avoid allocating slabobj_ext array from its
 own slab
Message-ID: <aXdmN1jUR5bZ6rK8@hyeyoo>
References: <20260126125714.88008-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126125714.88008-1-harry.yoo@oracle.com>
X-ClientProxiedBy: SEWP216CA0068.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ2PR10MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e4722c-67e3-4c47-03c6-08de5cdb5b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?22fzctYBSqsYN0jQtraymoOJWYVgX0phjJ2Xo3TYuRsp6VpaKwGSoLPue07t?=
 =?us-ascii?Q?WbV6gIiYso54QhDv1ignIumLH0JIlz9xa4tBisbcbYELU56vbtShAUcMP8nF?=
 =?us-ascii?Q?uN5LCGzjQWxR/mGFgZgNABLvnYufJmbeaGEr3w7hq7ZD3oLdDG4MuO0eCXYT?=
 =?us-ascii?Q?GcJrNzwG/Jex4LJaDg42mAFN0TZfYbQb65bSapzzq3DPni8044D/efAGM19Y?=
 =?us-ascii?Q?EtWRPsrOu2oIwlmL/Lz3u7OaEYKsp2v+JqnL0BN9ADQcdgaHEA92YWdo279/?=
 =?us-ascii?Q?Dcs4VkExGEm8xWlf9V+ve5oe+o5FGpHsXVnsrU2YCpsHJV7F0Xp5An6FgLr2?=
 =?us-ascii?Q?YK4gTfIunuIWFDJ+31SyzZxGl2NsJI5ZgFvhtjpRK385Io3ABftBZTGBI37i?=
 =?us-ascii?Q?+1MhzFR7juZu1TGz0Meh6WUHs48ODf0XTV7foSHhdOx59xK1UccPW4TCHMFd?=
 =?us-ascii?Q?cOYBKwQ4AenRvGx45lo8XWwNhF1JOvmTJVplpnwoQbit+tvRcSWvc7Eyo6vi?=
 =?us-ascii?Q?tb2OU0sswtYO/Abb+3GH8tm8qsfgApUm/StILY9Pt/hnIP5tPP4/LQV1hcAG?=
 =?us-ascii?Q?6EUG1CDLkZ4nrj+M+WkerwAWP5DIfnhWxCoFRkViwJTEfhPjleoUr0uVaJGN?=
 =?us-ascii?Q?Sha74Do6neuGTZ0ioYzPQizw7lYl2I5DzFykzrYcHnb5DKLiz2KIuNavl5gR?=
 =?us-ascii?Q?VsbYVwGzqxdlpM+i4rugp+axeGiV4kRloQYAHyMikL4ImVkjyfmr19V5kyVU?=
 =?us-ascii?Q?WMuwwvdBgJyXqDEmCDn9lpwE7Jvhxnzd9F0nm9wI7UxvEuXtVBAxE3v7+ulO?=
 =?us-ascii?Q?nmYfTuwcGz5sHk2nsCtZ+h2BO2q87S8wu4ZSP0oWIb0cJIPejMGvniM277f2?=
 =?us-ascii?Q?1j48nz7w7TUSoorUlX0IW2ecYw88h7aSIWraN1iFqgEKQW50r8ewrVKezoPx?=
 =?us-ascii?Q?kVsQsYlU7VYDZLl4UC9gwb7OuUa91sd+S4H8oQ8jWaoY9M7PHw16q5z6+Q4Q?=
 =?us-ascii?Q?iAB2fm2Y/1y1k5D27pi4cYfvUZKLFA0F4rRIM11DaB6vfyrM6RVjvuTLOyqX?=
 =?us-ascii?Q?zAyFXr1tUou/l5SzGhbEM6tXG+C8ovwqEuwdy0kga31vBPcSyhcbuqBaGJ0u?=
 =?us-ascii?Q?wJKjiNemxr68THwxzsPlLzejJMZGSTvDd4h001XlWA0XvPPEG8PkfaOYadsK?=
 =?us-ascii?Q?h4C6Sol5Yq0HdQhyXZJ0tzyQDc5N9Df7DxA89BrUlL2kw6xbwLCzE1d/RJGh?=
 =?us-ascii?Q?lcyIVx11uoWIB5snf7hS+Ck8BkulttDnPwmSlJ404GEZl+iEriPVmfpnBt5O?=
 =?us-ascii?Q?8Qqzh6f1VRV0iG0PSKjosWQTcCZqZSSPTJxbpR77CYYKEkC/KV4Fbjd9GQUK?=
 =?us-ascii?Q?yg1biPzi+VWddGHw2imGEs4YmcKqpF9LJ4Qgg52mgOJi77DR+tdWdbgL4WqH?=
 =?us-ascii?Q?jQi458E6585U2gkC2wFYqxiw1DHUAhHF3Iacj4d4uO6TrZHKkp+Fr09tptAo?=
 =?us-ascii?Q?KyOlAMYUpgKgJ3noQNz2hZsOWcTC2VExj29Uwji977gFEyxkB1tGDTQehzYI?=
 =?us-ascii?Q?5n2FWAQ3USTaDLN7tUo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v2F1+RhjP8eEo1JD3L2qN8/S6a8FsfyM4f91pUC68MoUrUgJC/mN5fxLlm5K?=
 =?us-ascii?Q?HcwDXTqXnnmsBYxIGA+HJzUS0KTASf5XDXaWRZ5KsacV+wNr32+AekwlpiR4?=
 =?us-ascii?Q?tP01jssUixOsaHpOYfeSddHujpa4aH3eMNyc2xr278PgY2RgjZc/pSqBmfkT?=
 =?us-ascii?Q?5hM+amIRvWiKkyfxyggRyZqSHL5y9YbjX9EfDlFUEfTOZCJX92/3mI3LvRK/?=
 =?us-ascii?Q?O9CIng8R36nSnSIc7wRVlz34vaAKiRkpW8tBLDeeZ1LyMO6qV4DquxE2hVUY?=
 =?us-ascii?Q?Bs1SSLHcN/Pi6ERJbY+qaJxgbaH46A6cGyGJ2Ga0SlIE9FyDmWyUt58SW86M?=
 =?us-ascii?Q?xu9SWU2ct/iHZ2fWnuez/sN7vt3mi8IzKadlvySFbmkOyikpIzHi6YvVm8in?=
 =?us-ascii?Q?cxrTUN8LWS3DlOijlX2T5t4dw3AIhXJL+ru8+zqUuPJ4bB+5DpVyhRoNnOfX?=
 =?us-ascii?Q?oulDOeoak8gr+yIzhIQIICHT7o+SyGUBx+dYcWRzB5vlM5SVwFs+euOCWErg?=
 =?us-ascii?Q?eP9NjjPvXQZE9lH1sA1CljXudHxgTn+Mh0En097Az6LAcJ5ZSBB7NYNPLZnw?=
 =?us-ascii?Q?4Ii++O+7YA2AyR8fWPrj3azsMEES3QYUkSWf/HxaLV1F2GsZ8FspIJUiDcl9?=
 =?us-ascii?Q?C/1CcXfX80Niuf/RwtGPuy1oyf1TDXrle583fAV6sZkSGVI9O00zxWuE9+RY?=
 =?us-ascii?Q?Xny9eUVPvMSNU93qq+tIG/GZ9mFyubx5yz6uUHuHW+7jy37KGkqsZgwuhD4r?=
 =?us-ascii?Q?A+TtfIqnNxWRuG5hnh0cn7wqRXgR3+1xO05J2ORZ83FyTWZ4knIudLRLI5a7?=
 =?us-ascii?Q?RrmFWDjdOiZssQhspCSEsha1tVH3obAwvo5CrBZqSPD5zIkRj6fvyGG/Au1m?=
 =?us-ascii?Q?8bHDWK4SzG21WZWNEzQzRoR+rkvN1XaWIjEcyvKf4ra1LP+mKU4wzbRErWtO?=
 =?us-ascii?Q?oQHQyV7rI6jnjgx/ogq098sG5yBMzhiBxg78xtvOf/jML6LBRAoPYfH3rH6O?=
 =?us-ascii?Q?7qJc+xuz4zChs3CroMS+hXBMiczip8YOh3lsopKtYQL6f/aQ4X0xAijf95re?=
 =?us-ascii?Q?45Os6WNkZP85H+qLkSfKh46vfZZeL0SllXTHfcFQU6d2aaB8IixenKDziVaH?=
 =?us-ascii?Q?h7N4VSLwVAwa6l+ovsL0ar3vx2pUCiv9ZarGc5rsIqbAEY73baEC8vepZvVW?=
 =?us-ascii?Q?p5ensG73vQW94tU6xmg4aLSPXOvw3bV+BZAPg9ckzy9t0YmTw8TslLzckiSG?=
 =?us-ascii?Q?E9hFT/+PdxfpnQXDdXflrG5tzBMkhYufNCpSuYV7XVcnoybmaRHRZo2gy2Q9?=
 =?us-ascii?Q?Tg2plTObo5/JW8iRNl74Y1MC8FtO3Ud+/OmEaWv2xKxeRCnuERuqUYdnf/8s?=
 =?us-ascii?Q?tT9yf0fl12D+x+ODwXpQaby8cp0qt/4BlH1KbgtMrafOf67RJzdvrdo5lDcI?=
 =?us-ascii?Q?Tk2MsTv3piSe2FmxXZBqLVeBU9Jut1tKWvgvBH+e9GJ7g/i4QuNIZd1YMw0Z?=
 =?us-ascii?Q?2ZksLBm1NTpzd7mEd19fkVXF1OXj8vjGEoXdhSxhqbu8y0Y3/XK2lpjPCa4M?=
 =?us-ascii?Q?x7EM0Lcz2XGciDVXcrz31g3myglhg0JMD8MMDsMmxUZ/11mFNeZApp8enH6W?=
 =?us-ascii?Q?G3/pnmDkIsbqEFeB13ixaQjmHLrZ45jSZGLSnW6J8sV8jQw71VW4Gxitmnjh?=
 =?us-ascii?Q?RY69v502Q9EQadHhtVRLmdQddJ37kWgOmsqRa/hMgsNtsVXeCoA6i62DSpJx?=
 =?us-ascii?Q?Y48Mx+xmkw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d1iZ0XnSC2fxW9/xB9MvuThhb0Ilmot33HGbFPiKgVCxv974TLAXHk8l4hl35p/SnwdZYAamtePTrEQr/Ec0hobmcKsT0jwjps1W+8jrZjcKqEOObbDEQzgw3nLIYkiYMZv69ae4U+dbwOO18Lo7LILP6cR2SpoB6yp7Jt/B0qhs6ANIt+ncwdnrGW1AF4MpZpzpNfYi0KJ9Q8GNO9AUcfi2Q1kNdwfPt8r8HBp3783xsfGQAHvVNJR06ZKoELP/9UrLWj71flA4Wua2639NNlTmL3/AhuPJRb41UFKvAgEopxnZQBnINDhh4FKYoRx84w0guB4nNTroa6sb7ucMEaybeYp1lOknrVlqk0M3lnKzxZFGMTO1rmcf9HYloHAbweYz/2tgvHLwYNUmQSVZp8d6jZ5I0Cnn0i2BfatEthLcpSv4fkWvyMgQNumP12X4jXdXX4Yq5hFL4Hyek7QLwywN1TOPdSdHqyepHKLqL/mVid52vKMT1zIPvl0Tm2+cKWhlIiDYejr+lc8c3Tvse1BZDHbZcbdv9SiDCiGR1ZgB65usgn5+dBlrEPTcK6ND5gB7LPe30sdwqMK3Wopd3pdfOnxpjkMdxB1M61xNJ7Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e4722c-67e3-4c47-03c6-08de5cdb5b19
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 13:03:53.0400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GV0oOBjHolFgI4G2IfRSynofmpkjonW+CiJMujByxCaX3IeqKmY6f13albYVHw3gBHK6aHxavRtQ7PAm9QCN1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6963
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=895 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601260111
X-Proofpoint-ORIG-GUID: jHfWhFtJnPOlHD6T8HTFeyNnxikdknQL
X-Proofpoint-GUID: jHfWhFtJnPOlHD6T8HTFeyNnxikdknQL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDExMSBTYWx0ZWRfX6UJKlttJ6asb
 WVrT833ITou/DHT7T9M7XbrQVWf+dqXbybxQbF3EUH8+El5FdcdcjcdtBZhCpt1Pkfek16v4mWQ
 W2I/qKPpAva2j2CFH0wZBx+LJx1Ny+ll0CE2IoQPyTX3ukF2HhZHfkqq1KbV038dhTt7s+C36Fh
 9FzSdvTtHs2vaaj0m14CvYVLcEhsEX1g/X1+GX6g09sMwxn95IR2mRzoBxFx1SmiXu5ZIiW+SSG
 LWOUY81l0WyBUIwiyyHKXEuX/n+/oQ9WXa/L4ivxz7VfYXJDU/srKuu9i9auK0gt69ehX1suXZB
 IsFrR47EOB2npktLIy8bDwzn7XeTcja/25pLcutE+P5J95aNYu55CYLPYxvEghZBBWbV2KbKfzW
 rbw5JZnfUZR3Mub1T5jhwHPg8bQ4k0dsoGK/g+vVCEiwiCwMK2f/mFWW7RkoEkdcVyJZxaoFO6r
 oQY9U5QUe9cZ5t63B+nFHc632Owg3+jH7H8OQyGo=
X-Authority-Analysis: v=2.4 cv=cPLtc1eN c=1 sm=1 tr=0 ts=69776642 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=HJXL5dwctRMT_Yb2wycA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211566-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,oracle.onmicrosoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BC03F888FE
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 09:57:14PM +0900, Harry Yoo wrote:
> When allocating slabobj_ext array in alloc_slab_obj_exts(), the array
> can be allocated from the same slab we're allocating the array for.
> This led to obj_exts_in_slab() incorrectly returning true [1],
> although the array is not allocated from wasted space of the slab.
> 
> Vlastimil Babka observed that this problem should be fixed even when
> ignoring its incompatibility with obj_exts_in_slab(), because it creates
> slabs that are never freed as there is always at least one allocated
> object.
> 
> To avoid this, use the next kmalloc size or large kmalloc when
> the array can be allocated from the same cache we're allocating
> the array for.
> 
> In case of random kmalloc caches, there are multiple kmalloc caches
> for the same size and the cache is selected based on the caller address.
> Because it is fragile to ensure the same caller address is passed to
> kmalloc_slab(), kmalloc_noprof(), and kmalloc_node_noprof(), bump the
> size to (s->object_size + 1) when the sizes are equal, instead of
> directly comparing the kmem_cache pointers.
> 
> Note that this doesn't happen when memory allocation profiling is
> disabled, as when the allocation of the array is triggered by memory
> cgroup (KMALLOC_CGROUP), the array is allocated from KMALLOC_NORMAL.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202601231457.f7b31e09-lkp@intel.com [1]
> Cc: stable@vger.kernel.org
> Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab allocation and free paths")
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
> 
> V1 -> V2:
> - Simplified implementation based on Vlastimil's comment
> - added virt_to_slab() != NULL check before dereferencing it - because
>   (in theory) it may be allocated via large kmalloc.
> 
>  mm/slub.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 53 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index f21b2f0c6f5a..5b4a3b9b7826 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2095,6 +2095,49 @@ static inline void init_slab_obj_exts(struct slab *slab)
>  	slab->obj_exts = 0;
>  }
>  
> +/*
> + * Calculate the allocation size for slabobj_ext array.
> + *
> + * When memory allocation profiling is enabled, the obj_exts array
> + * could be allocated from the same slab cache it's being allocated for.
> + * This would prevent the slab from ever being freed because it would
> + * always contain at least one allocated object (its own obj_exts array).
> + *
> + * To avoid this, increase the allocation size when we detect the array
> + * may come from the same cache, forcing it to use a different cache.
> + */
> +static inline size_t obj_exts_alloc_size(struct kmem_cache *s,
> +					 struct slab *slab, gfp_t gfp)
> +{
> +	size_t sz = sizeof(struct slabobj_ext) * slab->objects;
> +	struct kmem_cache *obj_exts_cache;
> +
> +	/*
> +	 * slabobj_ext array for KMALLOC_CGROUP allocations
> +	 * are served from KMALLOC_NORMAL caches.
> +	 */
> +	if (!mem_alloc_profiling_enabled())
> +		return sz;

Hmm maybe we don't need this as there's !is_kmalloc_normal(s) check,
but this allows optimizing out the checks below when
CONFIG_MEM_ALLOC_PROFILING is not enabled.

So probably worth keeping it.

> +
> +	if (sz > KMALLOC_MAX_CACHE_SIZE)
> +		return sz;
> +
> +	if (!is_kmalloc_normal(s))
> +		return sz;
> +
> +	obj_exts_cache = kmalloc_slab(sz, NULL, gfp, 0);
> +	/*
> +	 * We can't simply compare s with obj_exts_cache, because random kmalloc
> +	 * caches have multiple caches per size, selected by caller address.
> +	 * Since caller address may differ between kmalloc_slab() and actual
> +	 * allocation, bump size when sizes are equal.
> +	 */
> +	if (s->object_size == obj_exts_cache->object_size)
> +		return obj_exts_cache->object_size + 1;
> +
> +	return sz;
> +}
> +
>  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  		        gfp_t gfp, bool new_slab)
>  {
> @@ -2103,26 +2146,26 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  	unsigned long new_exts;
>  	unsigned long old_exts;
>  	struct slabobj_ext *vec;
> +	size_t sz;
>  
>  	gfp &= ~OBJCGS_CLEAR_MASK;
>  	/* Prevent recursive extension vector allocation */
>  	gfp |= __GFP_NO_OBJ_EXT;
>  
> +	sz = obj_exts_alloc_size(s, slab, gfp);
> +
>  	/*
>  	 * Note that allow_spin may be false during early boot and its
>  	 * restricted GFP_BOOT_MASK. Due to kmalloc_nolock() only supporting
>  	 * architectures with cmpxchg16b, early obj_exts will be missing for
>  	 * very early allocations on those.
>  	 */
> -	if (unlikely(!allow_spin)) {
> -		size_t sz = objects * sizeof(struct slabobj_ext);
> -
> +	if (unlikely(!allow_spin))
>  		vec = kmalloc_nolock(sz, __GFP_ZERO | __GFP_NO_OBJ_EXT,
>  				     slab_nid(slab));
> -	} else {
> -		vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
> -				   slab_nid(slab));
> -	}
> +	else
> +		vec = kmalloc_node(sz, gfp | __GFP_ZERO, slab_nid(slab));
> +
>  	if (!vec) {
>  		/*
>  		 * Try to mark vectors which failed to allocate.
> @@ -2136,6 +2179,9 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  		return -ENOMEM;
>  	}
>  
> +	VM_WARN_ON_ONCE(virt_to_slab(vec) != NULL &&
> +			virt_to_slab(vec)->slab_cache == s);
> +
>  	new_exts = (unsigned long)vec;
>  	if (unlikely(!allow_spin))
>  		new_exts |= OBJEXTS_NOSPIN_ALLOC;
> -- 
> 2.43.0
> 

-- 
Cheers,
Harry / Hyeonggon

