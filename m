Return-Path: <stable+bounces-206419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E38DD06C39
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 02:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 018C0303A950
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 01:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD89235BE2;
	Fri,  9 Jan 2026 01:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E6O6mmWG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hfIEjkwE"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB19224AE8
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767923044; cv=fail; b=W6C1OgPUBBEvf1doiJbCUmVqxmPNnz62mBQzlwCE2yvC7CHDMxSlJ2hsY9Ir6RDb/XP66QlYMs0yO+RHg1axBYUiQqjH524dNgxsCZGJR9xZjkSgtTO+S7Aia9/2vhfgXeA/8r3BUXEE4TjiJ5YN5/2Knn2PvHpPYUP1Hzjoetw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767923044; c=relaxed/simple;
	bh=GoOskjeIGVoh7I1oO28NOD6eYfIxKA9IaNSE7CUD1os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KrovhbXur9Vz5AcK6XCi3KyM1Vd1In+TyIEiK0a79G8S9XUdGLs59Jc7JnB+YLADQwdOAgSqlJVJetVPD7kr0Ix0drMfwVy78BkLntCgZ9BlPVo5eZzX0Ffb+F8MPOvgbgnAGjmoC/Ib2tPQD3QawXq5EhMrfVKhFczhslOYv3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E6O6mmWG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hfIEjkwE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6091Dius1556274;
	Fri, 9 Jan 2026 01:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ssmNdv/DtylEq0aJ10
	iwAsvsPIEkAiDkoRjCWLuEokQ=; b=E6O6mmWGs6N+PrNL7jC5hRdKfXTB0SHP8X
	7OdCTqnJy0H/yoz1QdAh9g6WCSM6+fe8HdWKZmGL3rK9c8ShtEeLaCLpiLZVgkFL
	CqZvFggNVWvK9tKT1x+qO5L6/9N1Og5XByDvurU5zyrsGV8uWMVaDo5iO3nX4Hux
	2sQ2Bc+dJmEItRHx6fL9uWfxlXDGTZ6G1qOkXPZVpDR9w9d19nyDfGiE+5ORCSk8
	zEYR0O6k9Uc+gzcvGACdAYyl5IEs9gOPBaYlqZd6vjSO8Fb92NWCifT3hG2P7EuD
	H0Ytcc8RcHasKHMGYOE2x6zSTEu2ZugDtMeR/nw+kenXgURCQeQg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bjqtyg0ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 01:43:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 608N3WRv026338;
	Fri, 9 Jan 2026 01:43:33 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjp2uw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 01:43:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THbhgOZlwjedtlV6kL6A9nKD/Mi0roIq4HlTbH3D/9wqlo03bF7iUz1HLdhlb/Uhjhw5GjFu+WLT0DlxeJNXenvEMlrJUaNF0j4fyAV/RuD+eExWtStdb2WJd+Ipz8xQPB0c5b4toGhtMcnYKdV/Hj+D67Lzp9YcbwMrIHCJQ1BLn0ZWfQf/0/OtKSDTkoX5qt3cdJ58OSVC6XIP66H66c6tYn283LsRBrv2+9/Nh/CKGJOJqxvzx/Kz4qariwljUSXfvNNoQm5aId1w7poHQ33dyEmnREqkBkIGxi+wBtTsULelMP0KMUxPs6ZB2B9G/qVmn7jBJCOC8UEsk35l0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssmNdv/DtylEq0aJ10iwAsvsPIEkAiDkoRjCWLuEokQ=;
 b=ceULRgS+xZl/KKjJOR3TpPspG2iBdHzjWbX8r+/svSwU12bCY3UFPtn894w27y0OuiRES8uIb0gCdNAz+nh6BdbTe2jchuXULKihOY0iT+0OyzZP8wHAvOATstu1yLw5W3toCorDJ/3YmdOrZjsQ/gYghRBWfvNYOCc84UqW5tJgana9pnt1lkyliR1X3fOhXKLUP5Dp5dbLzPqeQ1hhXWrHgNWj0u/dpb4DovUVcnIriKFD+8S54M0IEmJZv6+bOXX9dAi0p1x8mJYkDjLS0X8eJQry2F5r52AOfJQpKC6QmkDLeH5hYEgsYB5k6u9V9pCVQfSSHul+Idk7PC90sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssmNdv/DtylEq0aJ10iwAsvsPIEkAiDkoRjCWLuEokQ=;
 b=hfIEjkwElVxiQXJDZ3ZElplsZ0PSKo6bWIDf6Aw1VPnFb70R7U7lhb7f9ycPeHunqeAYIMEvzua4w3bggOKmklqzsW94qqUXbT1QyBZfgbIHuvlHrbV7/+G/uTWR6sBfCf7gcx9n9teFO8VIDKigWelADXteNEVTkNOF+HzEyng=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH7PR10MB6107.namprd10.prod.outlook.com (2603:10b6:510:1f9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 01:43:29 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 01:43:27 +0000
Date: Fri, 9 Jan 2026 10:43:19 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        baohua@kernel.org, baolin.wang@linux.alibaba.com, david@kernel.org,
        dev.jain@arm.com, hughd@google.com, jane.chu@oracle.com,
        jannh@google.com, kas@kernel.org, lance.yang@linux.dev,
        linux-mm@kvack.org, lorenzo.stoakes@oracle.com, npache@redhat.com,
        pfalcato@suse.de, ryan.roberts@arm.com, vbabka@suse.cz, ziy@nvidia.com
Subject: Re: [PATCH V2 5.4.y 0/2] Fix bad pmd due to race between
 change_prot_numa() and THP migration
Message-ID: <aWBdN9TdV2n8QfsY@hyeyoo>
References: <20260107032559.589977-1-harry.yoo@oracle.com>
 <2026010836-abdomen-drilling-6326@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026010836-abdomen-drilling-6326@gregkh>
X-ClientProxiedBy: SL2P216CA0231.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::23) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH7PR10MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dcb5c4d-dca3-4775-ad6b-08de4f207bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xScEvFiYVv7qP4kGVX57gOW1Wtk5UZ2YKdb3Ru4mZwNAgr1TJsCnuVcPPcZZ?=
 =?us-ascii?Q?xsVttipsxcJu1DZL5krwKdPnAG24xDnXwYDYnpkccB+jM6/+XopvumGXcFhe?=
 =?us-ascii?Q?3ynMPoTIau/wuIzJjtdHanJpZw1l/g6pFXJ5fVuIvvINLLPmGv7rlngLSykG?=
 =?us-ascii?Q?2acJsorqIGPcaWlsKquZjvyxRCUV50Iz+cKrDlWiseBSSAzXmY8LYlUuWbBx?=
 =?us-ascii?Q?OavJjTdeDWhc24ExBdRbUFa+cBEokiEIlc+9dOTH445mbplVodZbTeSw2JBW?=
 =?us-ascii?Q?b+FXZ7Z5WeXqEbfC7poDuQBvA1ABcXt0eEaRhJ1ynczw5tyRpzNvIx2RvfcU?=
 =?us-ascii?Q?PJ1pjRfrvVeh0JVMaZyBR7XUwpAlTtdtzvAyttAaPJCfjONyQfqPJ8UWgPma?=
 =?us-ascii?Q?schqNX/m5ESbu6fEySFF8FMd9AnpMYua87Hbvm5UP2f4kCGnb/CqV2hfn9Tt?=
 =?us-ascii?Q?BHovTmSSJCVBjxbZXu5nwIzB3+Pr1PfDOtYxko1w+jzta0xXZ53YsdR0ibcQ?=
 =?us-ascii?Q?bKGRNfMBwxRcyY5N1sYS11u0/T73aCohX2CYttS4jZcrqg1v2Fwt+iJ1pvhs?=
 =?us-ascii?Q?TGqsunpbMXJuJWXzxAgfCAnVlNVSWk3JAO8vp9SHsSUQn5c4ra7W1+U+EJnL?=
 =?us-ascii?Q?ES6KQQ4+by8Brht5BMPyYwSZT3mtgmjOsmH5D3sx9D0oGkPylD30KoAHj08u?=
 =?us-ascii?Q?nG0kZ1nU4ONEQ46hc+nowyc0oOMYBOGcJUNeu+GIJliPkdO12xTzmBIf5Wcb?=
 =?us-ascii?Q?6YmOWbfu77qrGGOMWCoZYNGngo2YR2tuupjBg9Vz71k2IriYuzrYmZlgYuYk?=
 =?us-ascii?Q?ioolJ1KgTQcDTeB01z2FQSPdCrj2X7FgFxX0Oake67pfzvlwPm6KYI7Kdzgy?=
 =?us-ascii?Q?TkwjOGiLjWzNtcyIfi2SogTgQiCTO8ugjs2QbSyK3pXdHcH3MVEtvDcGN95H?=
 =?us-ascii?Q?qewRQtWE+Uj9OdPs+icssFSccm2sTpykDKNk3grVIiqWCwtrYaMEmeSQ9sc9?=
 =?us-ascii?Q?Z2lI36eFgkSiUQX3iaDMO1uWLjSxNDT6Y/Rxkder6NUDAdfpSMT4p5p29e7h?=
 =?us-ascii?Q?qwKcbZ5nUAJrS6bJTu/znpXs8B1MP5ri95gwHYa3ab0N/PF2qUyBEpQ3wEdt?=
 =?us-ascii?Q?XWJAc/YG25tHiJxQga3x/+luHjX5PYSvVUFoef88hfMUXuFRKz5X+lZNoQX2?=
 =?us-ascii?Q?RW+v9/LDAXPlPbqv/EH0x1lYz+xDf4fWdhuKgjHmJoRU348Hz+k/3kP6opJL?=
 =?us-ascii?Q?hVdqQmIIQ8VTn/GvAN0TD7uAGWjOA6II6Q9zrZPUJuRBGrrnAOI778rprKE7?=
 =?us-ascii?Q?G1nUUeOR3XzvqvX4s0NoWxPMfuIrTLg1foYPnfC0x4Ld+2Kbdyr2x4+wT3DQ?=
 =?us-ascii?Q?C51tu+F4319Ls3j+X7dznxonkSZVLXraTvz6AJIoaFz+Y9Hyb/cbEEeQBhT3?=
 =?us-ascii?Q?FctMd1OAthfRIpvnbrGVUEFp62riP38HIwQD6In93QOG3NJaa0hsfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jFfHtdXsDfoOfvFbN4zARtUGtJ+hNuF4fmjx/5pXwziDKKKZpdjOwTgp1EVX?=
 =?us-ascii?Q?omvd5s2TRKkOTgilgGrz9xs1RL0haHklNavzR8QicNIOCPRmxbea4raUmA8C?=
 =?us-ascii?Q?SFe6ec7DHCST7mMxs1drDqnSTcxAs05tFgsZYKsxXnO93A/frNK7eScUTgVK?=
 =?us-ascii?Q?Hpg5qBKk8PjeyoKMcf1rvduwwX2IVG+Wvz9Oa0yAbDoFLPq8Qe8VHCugX9ru?=
 =?us-ascii?Q?RYPcbSmfvAB9O2Vk7qeXpKfw1Dlt3cyn53lsBDZMmyQNzVWEDzXssuxGC3h5?=
 =?us-ascii?Q?cM708HSJrb83jEmqaQiW72WRNKtN6BMI0iMfDxPNTzjdZ7VN3+OCiEU0SHQH?=
 =?us-ascii?Q?vTuZYTPuDGHodYIFhtL0Vr+qdB+CoSdyQu1gkm/1hE3S5gjNTHaL21OPASGg?=
 =?us-ascii?Q?vTqwS1xE85VlsWo4zGns17B+hWg6qixhae78mFQog5BUH0wd/iqFEKBEfXrR?=
 =?us-ascii?Q?IOX5vSDMMrI22wn02Rz8VETiJIpz8bdJ+amHdbUA/Uapk8fFRYzOjeDaSoZ/?=
 =?us-ascii?Q?eR96NYuwpwK1loygUJy2Ikb6TvwLPM/abIObsvaUjq3FSAgmhkFch25gP+Dd?=
 =?us-ascii?Q?5Vv5YBC6XulkwaubOo9X7E3n5nVG5jx3egA8atUK9IP/WLGF9L7ifOJXNYI6?=
 =?us-ascii?Q?NeyS2X/X/iPxO67SnvNu0EGqVicRcaIul7J3GnuC46jqO+8d0epjUbWUf3qN?=
 =?us-ascii?Q?m9zuFNHYUf4M2L1jJ5fv+KkKbAWtszikiu9RXX0QGeaetOHh5zAWaYxp4aAw?=
 =?us-ascii?Q?DttFLwSbO/SUI3fD3sgTWYrQ8NzrbB8PlOkh4Pl3X1Y7Drzj1XFuDDywH8O8?=
 =?us-ascii?Q?1eOX8IY8nXM3P8/JrAI6KLKqWiLtnpz3+Ag92XLjhaPbGtKQDW5kIY4uWJl7?=
 =?us-ascii?Q?eoodWXm1N7/jnR4JQE05GvTRnVho2JO+W+skVL8kTnglvFJwRSI6bgo3i8oe?=
 =?us-ascii?Q?D8+eCdgLfdvKwArlucJJRX1bjMeVWKRJWvWjg+3R1fnRPqmyIcgKS30oUuTD?=
 =?us-ascii?Q?gxcAijErF7LEejQRbjvFCI5t8THN6fqvIio6PP/8SefgIzFy9qXuCxPGYYVX?=
 =?us-ascii?Q?ZyRcbMzHpaCkRevzyXkahS5kw29R0afwHXRhkbrR7JSFRFGZC9ol/FqVRQiy?=
 =?us-ascii?Q?kwDTr3IjFDfICfgoFCq9hjxCnDukW/9ctiA1R+PqlWlig0zeDoVjrsmTdsb9?=
 =?us-ascii?Q?FzRLijOFbY3O6XjFqDGGeEg2G59Zn8osV9oOHTHQlwtj5V8nk94UcIsU5xFV?=
 =?us-ascii?Q?MjBbWGDYioQYyWI8igbHvKW8CfSCeiUR/m5g63vwdl7vweQbP6vnM07giSpw?=
 =?us-ascii?Q?B97cuLo11V/y+G8Yb7hR4vliEmwW9/GdUrXiL+487XoR1vaGRp71+ckiXppg?=
 =?us-ascii?Q?VR8xZer17IT5mrHHMSXbubjvkg4pey2oaw9yiFjFLZnTkCZeX8GjeguJH0p0?=
 =?us-ascii?Q?5l0GEnEAr/ka6l8IdmsLn63knVneyXj1SQB+QBFQ4UX3ZsBRaDnjK/O90amY?=
 =?us-ascii?Q?Wne4Rm/UMQ2a+5W0Kk8w61eV9L5oDX7MjSzyvq+xVL1H8JqG4ToqBNspdyBD?=
 =?us-ascii?Q?3HFMUAxjkJL+HNMGhyJPGDEzCDl1/CboKMD+uPS41OqVnn1xMk68XKLXbhyE?=
 =?us-ascii?Q?VZcZgBPWkPA8dFJZNWNwtQIN5XF1YrOHWmCL0JfZPYSprvQafPY+dzXOTEyZ?=
 =?us-ascii?Q?3CAws9WYwI6dsQbVKfilHuW1ADoZmu2gEJaPxsO0QU95C4IvoRlAwsktG90j?=
 =?us-ascii?Q?2F5DlxFbnw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/AwcSSjj1AYfdrAzEoBRIJAhP+IzqE9KAb8cPeuhB44S+g2g7yqlUSUXYpdK8UHoVw21fb2qkjc5j/KMhAopyqkzcxj0cJxxYXCwXUbeuEQv/AXvOdhkTy1Fu1gly+2RGwpSLLMDJhndtWT2RHp4p7eJLIhbCwDu8ZauOlkGgczgNY8bo8ViWEo1Wz+MsU/7MWuwUmBE0AqhqS4CNhE8aqQyxounDtg7i5jM7yk0mQMY6I3uxM/w21KWgMJWPuiyOpvqOaefqHHJyvbnJcNhxrL7dAJw/HexNtN91ZZHq6cxaxknDp0NRFlTsQOMTjRL2S+1umi9OOdLDs0WnF2PCxYmcpUCES3McXvqAqWiH0gnVtT+ZOr62C0pZU8iTa3ORO1ej/y68gV0EJil8T9qsPVCqq3YHdBB8V9j5DEtv72gRDVYe9eFRXK+WJI/0G5QcuBL+uQvEmPH33nMB+qzyQ7HxigkgQx67uQuWCsQHKKRt2L2mVpitJsSAkXJrTX1QNNkLC78jRBeEuCIHsldQ0ZTpWO91BESDMp96oIXBrVrPZEjPgfgUfToxOCuJvnMGkT8Psl0HALsnr3W8D4nfMEt4P7W/6W9Sat/N725KWc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcb5c4d-dca3-4775-ad6b-08de4f207bcc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 01:43:27.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8kkawsCMrq6+jEI9FpobIMjZZI51efpdbEkI6/w0hh8AobpEvcIlUZbDmGkpZTTSS2N9CmYbyJFjemsSnQaDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_05,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=844 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601090012
X-Proofpoint-GUID: BGbVnpYXOmV8-m_rHMrilr2pmbAmkveA
X-Proofpoint-ORIG-GUID: BGbVnpYXOmV8-m_rHMrilr2pmbAmkveA
X-Authority-Analysis: v=2.4 cv=CZIFJbrl c=1 sm=1 tr=0 ts=69605d46 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=3i0US-7io4XZAVJvmmAA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDAxMiBTYWx0ZWRfX8l/SyRfl7PrU
 Djyus1EugMVifwbiatHvriyILgBaOfhkLfx4KWCCL2MZaIxL/UiQEVVfLMFwqbdBS0WpYf03Y1Y
 4vxFMVqMBcsOaSVChWrcGJyNybKAY4kh+ICmIXB4XMbIAaZo/TVx8bmmomFMaJWE8wCJbC0nFMh
 fDFcULXIzUlcgilQpvTgBZdcfc7cTYChCs5z4og8ufPYsvpiIQ9atKjOgwuK/GBtYYMxlQLwguQ
 zxMgRstGxxjvIwq2PdMImrUJ1AmVcpQz6nHhEj6f9lS9C4gL95WiJhEZxq7FFz2KHiRK78CRf1p
 eYnmokirhnwDdj7gIt+kv5t4goeMnj13ijK3xACkrOaDWltlzOeuQI3Qn0bJopl8SZOKXhCHpfO
 hjVE6eOrPakC2BvlCgn72S45yn+uqMXfHAxTER59l1+Mt80OAFdMQdgfjWZ/ImxKQBsaGHbAQ4v
 fL86Yjm1xcLvFtNNx1hOpSQrsKbgAYysonztAHNQ=

On Thu, Jan 08, 2026 at 02:49:49PM +0100, Greg KH wrote:
> On Wed, Jan 07, 2026 at 12:25:57PM +0900, Harry Yoo wrote:
> > V1 -> V2:
> >   - Because `pmd_val` variable broke ppc builds due to its name,
> >     renamed it to `_pmd`. see [1].
> >     [1] https://lore.kernel.org/stable/aS7lPZPYuChOTdXU@hyeyoo
> > 
> >   - Added David Hildenbrand's Acked-by [2], thanks a lot!
> >     [2] https://lore.kernel.org/linux-mm/ac8d7137-3819-4a75-9dd3-fb3d2259ebe4@kernel.org/
> > 
> > # TL;DR
> > 
> > previous discussion: https://lore.kernel.org/linux-mm/20250921232709.1608699-1-harry.yoo@oracle.com/
> 
> 5.4.y is end-of-life, sorry.

Oh.

It became EOL last month and I didn't notice that.

No problem, thanks!

-- 
Cheers,
Harry / Hyeonggon

