Return-Path: <stable+bounces-216710-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IJONhU0k2lx2gEAu9opvQ
	(envelope-from <stable+bounces-216710-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:13:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 048F51453E3
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67C163098F64
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 15:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090A03161A2;
	Mon, 16 Feb 2026 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GUMZzVdN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TLq1oaQS"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BE11FF1B4;
	Mon, 16 Feb 2026 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254181; cv=fail; b=ukosHLZb2D5/mjYUCeban/CsGZiBUd+PdWkKSOE2d2a87w9xOo9ZXaCU0fx3g1kZJsnGsQ90ZG6wa6o0JFmFrQvqdh/EFObJJAmp4/b/4biaChTNpMrKsEjPpkN9gIWc9FAUuJ2n7SeNYrUcu/z1LnmrMreE73by9zeV1q0GKOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254181; c=relaxed/simple;
	bh=lCIzj1eOmLdKiL0brUlbwqiQhr0+COR8xRNHa6S0Dn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HlC3H1P0gAqmCUaro6dZoNu7sQtCKD8GecmerdaP41VeeYgHqyD+qXT9MREHDgHVRAAJEuVoeYhuhikntMJfK92O0DSMJbzm2XKIRM53sPVBHbhR17li21sQ9j/RkLgQ/mn3mdEhtb3RfdOVNEa5L2BoEy6jGeazC9i2WtJ+VgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GUMZzVdN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TLq1oaQS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GEjQNC4005004;
	Mon, 16 Feb 2026 15:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wUdl/9l2JeGGQB1Nud
	PTxqtdZWwLyNqP/RkcWCD/9Zs=; b=GUMZzVdN6b9v1W1eUzkIgVlXAksayDMCJ+
	Uc14FWL8oqAS6JgNVALxNeGeITZ/h+05++P+f06PViaY3A1eDG1WwuWkfQQ+pcEr
	fiNm12xXcK+pZ3okfU2erg8fHQxI6ZINXKZT4MBlSb5E/QL83L/v54KGcCLg8c5n
	/vnHulMsQ6p3tucNGztxTLjpHOMAwav1iSkV30+wUKFmPLrlujCummlyaua6rwv0
	zucOKl7gXRpUpUMLrKtB8TnFoZCapnbgVWgQEIS5TDg9jASqaz59nt8skWi2eVk5
	DTcM9lPE5aGuhAL+4m60YabvflVAqwgPt9djqmQ3JF+yx1aDQxug==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj5r2764-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 15:02:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61GDJumP033576;
	Mon, 16 Feb 2026 15:02:03 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cafgcfm54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 15:02:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKXG3aUbbyIWXM46ZN2tntnReV17FbhGj6brqIMoka05akYdqV+JYvqzfr73iPYyETnmK5oK75e2gXhxxMmisL5AVBOWA9NGtUP08Q/st2F1bn5XaIM7tjLf4RKWDg8emH4z10LdrhFjoFgVsOBjm5wCWEVCJvMbBZhTMRvV6ruVpSq6VQdoG1UGVqpwlf96ZptvzkAdhAdAeZxFubxkvTbXFF9ujMYZevrhZ4Ap3npREMgj0FTQoa65Y72ual8k1zWUrbTQAKMWHp+V+koqwQjDORahHtkAarzL68B1uq7ZEmqBbcX5fmKxY2vYeQy8z3KCN6a0+YIl2j4zoluLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUdl/9l2JeGGQB1NudPTxqtdZWwLyNqP/RkcWCD/9Zs=;
 b=l76XWk+DHw0TDB+msbnvB/n0TAb/AXZEy8jTPRLME2H8st5WoAh4Bcqr0y7u+GFFCanLAidDTqynmgng4R0zjKrm1j4bXLMym10qEBgWWba5D8G0QADmCWGxXamlDt1RuKdxY+anl5/AImkOf6kzwV/8DvOODawdDl1s8rl7xzKZF3oM6BFuXoYc/bSjVXeWIENBjGlK1UxMTFQB2skwKlUtKGE4YnR8lF6is40Lw2lSfbjZVaGUbxQG/n78dA+IhzY1hHQ2cf3uv76Pd2MNdVlxnBVgmmhiKWkeTIAztRECHMo9GG2o22vy4BED5P+pbReU2DwrFYkoMNpzxShPqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUdl/9l2JeGGQB1NudPTxqtdZWwLyNqP/RkcWCD/9Zs=;
 b=TLq1oaQS3ypwyLFh8lYu04Y1HrB/j4OWiG71Z8GBAguPqYkktA6C0XjU8175zVOCjMNb0sWKO2h7arnLYhvZbQTiLnMLyWq1AXpP1VGjqzHvPyqcvSfqO7EO8rMsCzxUmxE7GDGXallUsO7n8dz5WhgYzE4XrVDzkeHQ/FyVwFU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BL3PR10MB6019.namprd10.prod.outlook.com (2603:10b6:208:3b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 15:01:57 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%4]) with mapi id 15.20.9587.017; Mon, 16 Feb 2026
 15:01:57 +0000
Date: Mon, 16 Feb 2026 15:01:55 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, lance.yang@linux.dev, i@maskray.me,
        shy828301@gmail.com, ackerleytng@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: thp: deny THP for files on anonymous inodes
Message-ID: <cab889ad-5663-4fae-a361-0794b57f9f79@lucifer.local>
References: <20260214001535.435626-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214001535.435626-1-kartikey406@gmail.com>
X-ClientProxiedBy: CPCP307CA0005.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::14)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BL3PR10MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f86032-2500-4732-7cce-08de6d6c5429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lf4sy2gHdI+g2c63h+/syW2fjr8dFwahejaZvBfCVOEqIG+aVlSc8sYDRh+x?=
 =?us-ascii?Q?eRp0iQeawTPahJCAZvF2JV2fQGh3wTLnHg0UOGJLoCVFehHEBtpnvnJzR9e5?=
 =?us-ascii?Q?qJyXzKvDnU8pEtszcPxvaqUzUYlHbF4KmHbND0ugFet/ROw1hYbSKwOebpxM?=
 =?us-ascii?Q?tDVjtKJROc96VR7UDsNGfxOAHDyBbJwX1tzKfiZI7ioOscmNBnYeIiVZgKlN?=
 =?us-ascii?Q?/JSifq/0tSkSgjrYwCnF83+z2dNdJ8k24qjh/5T4toejFDIs4K/pX9KYGP64?=
 =?us-ascii?Q?FwzussGtSypgECoqN20Z5VFhr7JHhqUy1Amu3QFBSuYrcYMl0M4Lz89JDIE2?=
 =?us-ascii?Q?D2IXdGC4NcX1kRIMncvu5/wcMvg1ZRZvhV7+JPPaVWtl6W2W3+bFf3u2A5tD?=
 =?us-ascii?Q?09Db2JNPzlORPeRaLSyCyA9pZ9TTTkR9sCZgwczQ4zHbn3Yn/h5jTcTt3+Dl?=
 =?us-ascii?Q?YT32pX2xitMT5iFHpA7qpkidu4GL0djR/ib9fHk+9DuE+0sdAlYpv/1cHoGL?=
 =?us-ascii?Q?qMM4Q02n0ijRb4ThGBTHDTRS828ZmhdjXbn5oVKePq1196oe7R0O0lUyxoK3?=
 =?us-ascii?Q?YEFkgu84ONdqEqOCmkUiGcOntVijrLhKmYtD1HKRZKLJmxcTa+Xkrw6cqmU7?=
 =?us-ascii?Q?kAkp1NPSKo2omojdd0kilPVS+BUgxTOpZ+O0xjJ6NklRZK9CgDq05iYSiS63?=
 =?us-ascii?Q?h66DFoEIrrwEz/3u5tBwwA5Giq3jHVDr4TRePPLprjw/v5y1HVGbYKtj6z73?=
 =?us-ascii?Q?AZXrfL0NxSSqFB+crgUaBD0wept4c8d/lcKXPU9HpDZiu9XcP1Xiqxr9yjMu?=
 =?us-ascii?Q?fsbfK9lBL+p+BbLmOAUZnLUS3LoXCvoZjsfw2kbuqaqrMHqUgiDMfHeW7CGa?=
 =?us-ascii?Q?djQ3e+BFX2AgkDtXafxt/omsH8V/bkaRomuQU5rs6M64EWU7AC0Hc0JUeTAF?=
 =?us-ascii?Q?FjaaVfFYrThVkhNouEs2uCfs9iAz9Rw33zVeUtaaZalCyaVfK9I7looyfN+n?=
 =?us-ascii?Q?I88gufVnHalI6GZG2sQIWjDkTVvIsceT7cM2/fDEoOz8mwoO2e0fOSiFAvSN?=
 =?us-ascii?Q?sVbupHbyvhD67/Ds0fg7t3tibIDsN73bENk5G5QBnZEbP0MNm9z2/t4r3bOx?=
 =?us-ascii?Q?ym77Al4BWrDSK29zTpU0kq1NGTjGfOEwxwPPpOq10DinSjRfo0LkoikwQWmX?=
 =?us-ascii?Q?NrLOjjN3fTlxWXfKMXTdEoQ5oL1lyPzOQHUtb0idQ0NkozJCTxNiCks6Q1rh?=
 =?us-ascii?Q?r7UGvc/GSzjqRoA4d+zyJBD0MPyiMSi+ec1Wson+Mjd6SD1BoPAZrYZ0L7Vi?=
 =?us-ascii?Q?9jLWA/gis1HYhc7nvxwMjT2bmluWcH2API+YRSLJWTAGHWeUv4MDgqR2cANB?=
 =?us-ascii?Q?5rc6WLamKYcz6Iws6BaJsrHma7YAxOd2jeWtcZLFeuvhBmCd31baMcm1VjcD?=
 =?us-ascii?Q?M33ulSq5uoyxP0IvEw4EKOeI3g0hG0XcgPGTbw1W4pK24mIEWgZkWcwpXgfQ?=
 =?us-ascii?Q?v4NLlI+cvgNLiqv0QJTglGb+9Qw3NRnPO0nt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4AV75zFE1xaUC42IeSr9G+/0M/ULvXYsH9RXZE2l3z7AqUSdlwpdUSvDfahD?=
 =?us-ascii?Q?wW6bSjZWqdM+4h1x+8iLlcmcn5BkPvVO143vIlAYfjnthsc3cgCLN6NKFsgo?=
 =?us-ascii?Q?RfsOmQbVEHfA/v9osuRUGrjMv1gYZ92kQmKpM1T+wkGTicgOHdsDmAPbDE6C?=
 =?us-ascii?Q?T1G35hDvRXGMHCLFx1ALVwKQewonneUp8GtPH6qxFI0E52WnI+sqlqT7hgUb?=
 =?us-ascii?Q?545a3bALNs9kt+KRSFMq+ny+Jfhm/XkXUA0xwmTMa+jBViShCS29cxSSb2ZM?=
 =?us-ascii?Q?C7P8annmeCB9bW2hVxIJtYDiKMewDANXJgmRbHBhiy4S4rfzJYVemh/ol9JV?=
 =?us-ascii?Q?6cONvJgbW2ykm0kOkvurZYpygF9uA66Aagh0Yw6t7USf23z0V8PSFpRtVN+L?=
 =?us-ascii?Q?W2XzHKGFmopXfNCEAALxa9jGRW/Js4FwdeNY804KI7v6qJaXjQHnyyWMl7Py?=
 =?us-ascii?Q?k3wsD5bG05jaOqB8n5Wc8TsGM56SakSl+EDcl/lbJKewVL68li3/i9m3LO9r?=
 =?us-ascii?Q?/QrZtVBd233gK+sef+Xr47aRpfeveadY6Zdk/R/t3P3ewElOH45QV5OAurHa?=
 =?us-ascii?Q?TsTUPMltLkr+pDFIjnGRuI6bLKXwOkb/+VFbCpkYz8pjtf+gOKzO9FqO6qkV?=
 =?us-ascii?Q?NIHIDFRnH5lOKyjPsLMJf8tzrzqAMO5e+Ltyufep+36HeuosKKippqsiyTt9?=
 =?us-ascii?Q?hqG7T388wUQhvvnCe/ga60nb2758Ga+jKtVou5PnMKkLeGY5+FzB+UDKjSri?=
 =?us-ascii?Q?6KaBJIoSrMHApbtRyopPeZjJ4vmt6JsMibmRJLFG+vrrEKl0d/OsiCpa1PoZ?=
 =?us-ascii?Q?duqOzRkgZx3WRIHLSZxeyvpB26DERiRZhjRxeVObQXgjp5jxb2410po4mm+0?=
 =?us-ascii?Q?1ciHQ8wd1jgzYFeNOoR/a8Qp5bdYtp0g4hSEtMr6zxTyyA1o5eFvrePnSMBL?=
 =?us-ascii?Q?zj0dQ3++2mIUfPbdhId4MxJBjDg0q9fNBP2gXOZqaJqcQLWYsymMkTTGdxo1?=
 =?us-ascii?Q?SRLdoi+XOLHg2s5lSRQp4aITykGdia2CFcpbsDITcTMCHDgEJqQElHHOMyiy?=
 =?us-ascii?Q?9p0sv6peSy5MeTAkYvgYSveRLTqqMEfWIY8jsSq4lmRTWYfr1AS3RNWNyK1q?=
 =?us-ascii?Q?DF3lB1vxidEnOl3+XBVceelKVQg+TX/6KDztSJ30jJZS26mfNkJhgwRkM94y?=
 =?us-ascii?Q?8yyamdIKFVTxF0+ZLsCA7TrHqg72Q5LBCvdSRtOkpNvyb34DnhS15rE7iGtI?=
 =?us-ascii?Q?kGnXjp4M27zLEzAezGxeKxPbw73bEaxjtRxmKbz7KU2o3uD0uM//G/deY35c?=
 =?us-ascii?Q?WLf632/RNnCFEJlL9HXVGymusPOv+cCq4ZWX0BdfI62TKBxk0eUKbG2eiGKc?=
 =?us-ascii?Q?7cdGHLiybesqKlMjh72B77pg5nGCdQ3xtoRmfgYZO3yrOnvZP9WPXAjvn0+0?=
 =?us-ascii?Q?5fCURGkJ9FuW7XUIihJ84ixGk2OJYU5V1NQBHmE+8ZeJGUn9Go2wU17XQMK8?=
 =?us-ascii?Q?kQgLl66Lm7xkN06PM0MzMl7mG5AX/1uoY46jT8flyqqMuueUcXDbOuYrvBqg?=
 =?us-ascii?Q?kQWpunJQ/nW8zNEAqjWodZ9Jn6PQGqaRrnOM//aKcvr8II9f2lvRimkWxP3Y?=
 =?us-ascii?Q?wi2GoxVce81hJ8khAqQ16sO5BLGSTL6wT+2V9E3NEjlHCK7NpLa+nH9jLLea?=
 =?us-ascii?Q?GKhcOt1in4U9QT988eBR6kiFccxBtP5GYu71MFf8Cch7MJcDSILDtwpIlJoy?=
 =?us-ascii?Q?DZHivyiGXAfHQ9gwp7cGKOF8W4uIgdg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vu4xi/y7iTPCTf/XyRwCo0UIq2J/tgXhQRLxmWOkwt4rcnziCp3rZrGAdDZJUl1xULopJzLernvTySY2Lfxe+MOh5DeYtG4HN5KqLBfRDC3mKyg+cUqCAeVXMiQ0tlUsvJQUEchGO4InxEkRfp/2vUmU8rSCVS+6XvD3SGmBL1+5EUcGNKa6uxfDxuY/8/CrjuQ40jucjj5SsUnhQ/U9qpLeWh9xmmKX5rCRBxFDZ4wXpx+UxS/uQW/Dd1QDJ40pvqX2Nc/LlPuQ7Mg7D9k2WSWXq5VPp707NUJKKP6tE2XJkAkT5OcznxGiYoW1kBpHl2CioVdVpVuriUKbOCcdJxifdYuqR9u4m344U4oeC7uYs4V2Fa5gMJOFQU+tPxqynYeMYrp62iOfu4V5RwkpwzSD9Rq97jaz1L7iy9wa+JYYgpv3aqsaYeC4r3eaFwIP1k8hQivP/aWrzG0kaiubSQjxMHsW0faDCXUJ0ZkduPHBfYKLhIwO9e7Z+kz1xJHesFvzN1Vaf4PfGdfLCZG5+aMkvSnr6xL4Y7k9AZ//Zqb8pOlhb++f5vBR2xDXigp4tZtf/F68QZ1dVK+/hR/G7jzQN1d42gXJVqP2UrLok58=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f86032-2500-4732-7cce-08de6d6c5429
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 15:01:57.1352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7oLbMkzuo124Dshy71EGeLrGhsu0EPURx2gLCcBWXyilZxJ53x8MrepSgYLyTCf3Fzz3E8OVHd0uHE9HUsi9LwXIbNOlKDVbcAU6UiDtr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6019
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602160128
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEyOCBTYWx0ZWRfXyqMtBEjy+GSC
 gLRYrhRv6XLiE+72cOZZ/E9iDZSeDXQot15JUAI1mJgE2OW0ddTdg7rNwDjrjvOpVKaxcGACdc9
 bbbyu//LNEz6khZwsLvobpPobhb7XCx15bpMPIFzNerhcgPuSutf80R5wbWgEIVQ5pR+/WqDZk0
 EuNOV4Dokm/qX+gNGRPIdrNgRboFAgUlMCb1r+xm/yHZQm8tsmF9uSMN/uilDcBZhwyr7/gqGdB
 KClfZz3R2aU8hNNh2A+B2XFwvBD0wFXmFLrBP6jra7iLpB+OFeAF1VHLI6l58rW+XljJM22JRy4
 qhqNEzHRD754q3hxZyl0d4QOZ7/Ubkzw9Gtu6MF1/wrq9t3PmfScXUDhi0rgP7jHQIEeNy/X1GU
 jOjd8I7NrwENFTCTvCkDDU4+/gi/1jQojKCaJaqF6hCkfFRs8RMl2pbnQY+9AQXxPAmpY2F+Sc+
 G4FgzM1u+kepyRDEFx4HlnYpwtFKcjkxKjtGcrH8=
X-Authority-Analysis: v=2.4 cv=Saz6t/Ru c=1 sm=1 tr=0 ts=6993316c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=edf1wS77AAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8 a=yPCof4ZbAAAA:8
 a=pXt4Vis0h1HzrPu7K3AA:9 a=CjuIK1q_8ugA:10 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 cc=ntf awl=host:13801
X-Proofpoint-GUID: o31ENlisyuaiMyVUjDHBTmCFeRC9Cs5g
X-Proofpoint-ORIG-GUID: o31ENlisyuaiMyVUjDHBTmCFeRC9Cs5g
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216710-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email,oracle.com:email,oracle.com:dkim];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,oracle.com,redhat.com,arm.com,linux.dev,maskray.me,gmail.com,google.com,kvack.org,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_RCPT(0.00)[stable,33a04338019ac7e43a44];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 048F51453E3
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 05:45:35AM +0530, Deepanshu Kartikey wrote:
> file_thp_enabled() incorrectly allows THP for files on anonymous inodes
> (e.g. guest_memfd and secretmem). These files are created via
> alloc_file_pseudo(), which does not call get_write_access() and leaves
> inode->i_writecount at 0. Combined with S_ISREG(inode->i_mode) being
> true, they appear as read-only regular files when
> CONFIG_READ_ONLY_THP_FOR_FS is enabled, making them eligible for THP
> collapse.
>
> Anonymous inodes can never pass the inode_is_open_for_write() check
> since their i_writecount is never incremented through the normal VFS
> open path. The right thing to do is to exclude them from THP eligibility
> altogether, since CONFIG_READ_ONLY_THP_FOR_FS was designed for real
> filesystem files (e.g. shared libraries), not for pseudo-filesystem
> inodes.
>
> For guest_memfd, this allows khugepaged and MADV_COLLAPSE to create
> large folios in the page cache via the collapse path, but the
> guest_memfd fault handler does not support large folios. This triggers
> WARN_ON_ONCE(folio_test_large(folio)) in kvm_gmem_fault_user_mapping().
>
> For secretmem, collapse_file() tries to copy page contents through the
> direct map, but secretmem pages are removed from the direct map. This
> can result in a kernel crash:
>
>     BUG: unable to handle page fault for address: ffff88810284d000
>     RIP: 0010:memcpy_orig+0x16/0x130
>     Call Trace:
>      collapse_file
>      hpage_collapse_scan_file
>      madvise_collapse
>
> Secretmem is not affected by the crash on upstream as the memory failure
> recovery handles the failed copy gracefully, but it still triggers
> confusing false memory failure reports:
>
>     Memory failure: 0x106d96f: recovery action for clean unevictable
>     LRU page: Recovered
>
> Check IS_ANON_FILE(inode) in file_thp_enabled() to deny THP for all
> anonymous inode files.

Great commit msg!

>
> Link: https://syzkaller.appspot.com/bug?extid=33a04338019ac7e43a44
> Link: https://lore.kernel.org/linux-mm/CAEvNRgHegcz3ro35ixkDw39ES8=U6rs6S7iP0gkR9enr7HoGtA@mail.gmail.com
> Reported-by: syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=33a04338019ac7e43a44
> Fixes: 7fbb5e188248 ("mm: remove VM_EXEC requirement for THP eligibility")
> Tested-by: syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
> v2:
>   - Use IS_ANON_FILE(inode) to deny THP for all anonymous inode files
>     instead of checking for specific subsystems (David Hildenbrand)
>   - Updated Fixes tag to 7fbb5e188248 which removed the VM_EXEC
>     requirement that accidentally protected secretmem
>   - Expanded commit message with implications for both guest_memfd
>     and secretmem
> ---
>  mm/huge_memory.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 40cf59301c21..d3beddd8cc30 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -94,6 +94,9 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
>
>  	inode = file_inode(vma->vm_file);
>
> +	if (IS_ANON_FILE(inode))
> +		return false;
> +
>  	return !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
>  }
>
> --
> 2.43.0
>

