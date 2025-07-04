Return-Path: <stable+bounces-160175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9BFAF90C3
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 12:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E754A4ADE
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 10:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF27262FD4;
	Fri,  4 Jul 2025 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HZFWD1Hx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HQNPMlBv"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EFD20C00B
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751625548; cv=fail; b=hi3oSv45dftZSom+JoPJAc2CzMst6ZPKMsEgBFwN3J6c2OMj9My25y+NCIPKTE5rud3mOoWP2ZHJzTODjwmp/zYhi3U7fyEHyT5bXzVKlC2sLgW2Nf2rDvtRdU073bGdHnkt40TVJSXLSft2RUuJ/0Bf23EjS7oTu9BU6Z5Gc0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751625548; c=relaxed/simple;
	bh=Mx3UVp6EKfkNwcfHaV9qNb3wL66s8ILFAlmtYowV7SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=srAR3ba4PVah5c2WsCHrJIoyULHAaMBfsdSr8fIjFS6mWYNDxc6ZSes4uyXMzfl+dEyTbrAzNiVeVd3K+oFSjP8tjQpjJMA979rpFrmZmk5mMT+f8vPMFwvud7gGzp9+WvmUgEVyK1rFq4b1WQ3fAaIblpn9W0hd1UUxR9o817s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HZFWD1Hx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HQNPMlBv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5649YuIN018035;
	Fri, 4 Jul 2025 10:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=dDvyR1nc25+j6CWInT
	j2P1es1duiGVkX4ABgrko/9LQ=; b=HZFWD1Hx6bKN8i/6aBCGUnfGfoFCxXeLpG
	5TPddju02EXeZF8p4c6FgQSP4PJRFJZNihy39NujcqSo2pB625m5JuD2NF7qzdCH
	IoREG5usjRTN7YBUijEGUhFmhC7/6lawHma2Be6H/OnqQMZ+Lj/FKm7/m2yQfpSu
	SHXL7uFEdFw/6PHd8kmlBjRBu6sNdhCRBGi6N2GMRJDJUfUYVW6Dl+pjvybsd5/D
	0trdSCdSIs6+/QX6K57zFOGxt8RJUEIBpY9ucgUb3wzWAistKXGVQ0ZQantLMRsO
	IVqUBqIUsj1r00jKieTArIyj98XqOzxjCwrQJFTRBMWWNZR6cUEQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704jpc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Jul 2025 10:38:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5649a0v3024842;
	Fri, 4 Jul 2025 10:38:55 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6uds2rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Jul 2025 10:38:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSZ7WvxAGayr9I+vhvo+RNiv8NLifhbad3K+WlhKUEI+Z1f4yCcq82czBdnhdKwLdfz4XyOvhVUlsjz+E2QHAkiDZUs8QRpmeV7SH0+m+m3cBIJojCRDCULj5HaImQuuKEUdCBBSU7h9KGKTrU31ZwZ0uN1vEVD35VTECMSlmNcOYTqdLU1JtWtjkw202Mx97ne1qkmxBVgqnsqXzmdvaiDJDRYL6RqsuFVTSJEaxAfXp0DQRmfKOpPB9Zw6DEV/C0M5wqlliayRMRkljEGcDNU0lJRt+6+Q2GwsXHyTwG2OIbw+hQ+eqFNWLZ8gRXtMArlM1llJVlHzNlmxNFiHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDvyR1nc25+j6CWInTj2P1es1duiGVkX4ABgrko/9LQ=;
 b=ggHDhDFi+TZivyr7EsUZ8VwBbaWfIaWu4o0wmExL0yX+SFOs/K2NVg4gNz7H8QbidLLKd5w9LGZ0s9QL8U7iNMBZgB0vJacP2U2lC5boCznM4OdHGEXlK8hKzVeQzFeg2DEEA6tayGNt6tb1FHhaC5AS8lSiDV2b0pbkolODRM37ovL4U3nTjY0cRvcMtdatC4V7IlA/SmF8h9ssSAwyzJrwvG1shaCUnU0ge8a816U+9XH8XxCpm3zA9PDwwG/n0BSce0EddUjWEMRI2PsYD8O2NsJ5QBPb5SvtcKIF0CAWRWL9+XmrCpcO9S20DNhgWIhAMOFFaPRSkzHPT3zQSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDvyR1nc25+j6CWInTj2P1es1duiGVkX4ABgrko/9LQ=;
 b=HQNPMlBvA3lqG3tunSZm6H9GDdLKiT+obO7kK4umd7kViOr2aNXkbliMgVXgYim6GoWyqZ/TayyM+BMycmaZAPvEyfO5s86dyVLOKJ4ld7rG9rW7KAcB7WxZrEa3namztNalc94cbWbUL5qDFyYnjgE7mwHeSoEVSiolh0VJ6ok=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM3PPF01BF54C53.namprd10.prod.outlook.com (2603:10b6:f:fc00::c05) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Fri, 4 Jul
 2025 10:38:50 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 10:38:50 +0000
Date: Fri, 4 Jul 2025 19:38:45 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v1 mm-hotfixes] mm/zsmalloc: do not pass __GFP_MOVABLE if
 CONFIG_COMPACTION=n
Message-ID: <aGevNUp--NAJdORM@hyeyoo>
References: <20250704103053.6913-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704103053.6913-1-harry.yoo@oracle.com>
X-ClientProxiedBy: SL2P216CA0093.KORP216.PROD.OUTLOOK.COM (2603:1096:101:3::8)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM3PPF01BF54C53:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ade322-df3e-4c57-fdbe-08ddbae6f697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T4ftxF79VVwQcQLpQf5R8tXsBmurtkR6FJJuxOxwIjWE26y1uDdvQoZ1nzFI?=
 =?us-ascii?Q?45yVNk51Hi3L1dRDIxcX3NeDUdQIX0szWYJdPnd6179wuKhS+Iifbp1p6Oie?=
 =?us-ascii?Q?eOIMocPAyIdK+Jyi581/ube8Npv7q7w8l1w56WLh9Z7GETRx/AMJYXxuWwC+?=
 =?us-ascii?Q?jja5zVDTWyD7jM9pG25GatYBeqiZvzaNEvBAPERDc4ZcwGupBcc6viOukqcA?=
 =?us-ascii?Q?erxaydlPTEsfbJrkSdBEvbDeA3KnS4bNOBW7klsR3V7Uu1Nie23rodsTYFpq?=
 =?us-ascii?Q?8CLQYKnOPlsM0hK9Ps2M4qbudukrHZjgrxjILzjfCs93d1gTTpYV4uvW73yQ?=
 =?us-ascii?Q?xqM6K+NBED7+33bB7+65y05bhwJo7KFVwqMJF7DrIJACPFcWpiQUIv4vtG6f?=
 =?us-ascii?Q?hvySE0juDXQaQQg5ItElaDnnooPqvFQijh/J5NiiFX+npHznNo7nyDEKCGIq?=
 =?us-ascii?Q?DD7opTyCPkhxafCGHe6zT7Y/lqmMCpUISuvFKBIRSlK4Co/TCYVYIn1AEC9R?=
 =?us-ascii?Q?8PfC+T2/qs5UHBnNlFoD2GIG4hDsJpKYEQF/bVR8aGkP8yjPZN4rrthe/buE?=
 =?us-ascii?Q?B3xhvch+uT5aF/FjTcHre1hRV1j1MKyy5cFJ53XjBtAhkpqYNq20FWunn+lQ?=
 =?us-ascii?Q?JO6xkCcm+xFucQ0oymW/t34V1wh5FNldRe2TvXFHyiNiwo3k0f4YVEuGa0iV?=
 =?us-ascii?Q?Oo7hRC1l5pSlZtutqLe04at/0ucIAqIXzj2o0xtyYwzu390baoNJmghDbAVb?=
 =?us-ascii?Q?Zj8P1F7WjX9sQQA8AAkaqyNETWXtfoy+a3IllQ2e6ROuQX0rQehS6E6PMZde?=
 =?us-ascii?Q?BMrKM+W147ZuKnO6DGHvOwn2EXuyKiegxqagesLcdxIc7lANTEZGXFBBdi2E?=
 =?us-ascii?Q?vfK5ur3AdNsN/XBkd62N1K6JtJLM+toAbBQnfMlgBn4WMe4ZeNsjLhOSTScJ?=
 =?us-ascii?Q?rMdrjrtnbrIpag/YnPrU2IyCRxsZyb2rziGpp5S1TLJQsETPy1vXbYqco5UF?=
 =?us-ascii?Q?Dz4uLs1daBWuAgkvkBSlxuFkXpLl0XeqGLkOQSWupNslOa4Ac2GEfqNcvWpI?=
 =?us-ascii?Q?enjUxCkgzkgUhY7OJRdQQqfjQt4ov8Rbkd8jdTAqQ6KLHsPH6oYKrkoatdhX?=
 =?us-ascii?Q?robuzLg991BpH3NIOUrUP91DhzFuvfTmd/AZQZDuA03xdTFEza2nJncKKwFv?=
 =?us-ascii?Q?Kjueps88qeLa00ujHi5dfEEoOjuzghAb5kbWDkWIda2+lceZELZWKOO3ngJ+?=
 =?us-ascii?Q?fQXtbDPyECzbU9AmgYGSniaNSnKm7U6x18sJBn1jPVkOZJ4UT9r8RkC0Kykr?=
 =?us-ascii?Q?su80v3Uizp5vyOEfKeNy0wA4JIZMlLovCsL6eddg7LI63EmKsxtJ1BacARJQ?=
 =?us-ascii?Q?cy79+Yr3GIFOAEX0tej+qr2TM00fRHTjfDcXPXJwLSiOA/9aK0QPiXBDMgIw?=
 =?us-ascii?Q?zEYPFrlWBLg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HGv2POvKX26UhLYNpTOK2tvxpY5jeSjemue1JfUs/33B8oaa60u/4IO1i5LY?=
 =?us-ascii?Q?HtoheOl/xq7d7KUD5XGmFV9ei7+H7f8ae28hVeXyZKy0qfmFLo/AKPL+Ch9E?=
 =?us-ascii?Q?YxCaM1wmjRh5VtlE3WaiYslLA/QTLEhWDcrd7dknjI9lzpNR4CAX5EE2sKXv?=
 =?us-ascii?Q?b7OY4h7q5w2ibWbdj36ZnuwXZUg7n1vUB7myGRuY2N8PrargMJczkrG2Soox?=
 =?us-ascii?Q?LDJ43IYb0pipEVl838ubGfBWdxRT0OddWeFOI8sA43qYyOyN36Tz3OD64YWR?=
 =?us-ascii?Q?URG/R+o7pqdbGJ8Ybpe5r6pJCaoOdkUTP887kCbZ8B/GdrdjYLBd7MV/zkVt?=
 =?us-ascii?Q?ngsDpfMsLlxBLafW84iIpYBAtc96CdxOXN1APZWeaTYiKBCqkVqzr5q3RrZt?=
 =?us-ascii?Q?DSg7Cu/ViemADQmkeC5gROmZxpTYdU2D9xezlQaEgA0mN76LbTIn5Uz7Ps/A?=
 =?us-ascii?Q?0m/ADhWg3HCSVdyX6EGmqu7wvv5K7q7Fpu3FfOIVzenBEHbf6uTGKrbZJJlw?=
 =?us-ascii?Q?FTcCTnhJm4grBYM3gZVPGgHueLi+3r37JWyCD8Vf4x64yO40U76/zBz9bEDa?=
 =?us-ascii?Q?/Hid+yFIOySEtYJHmc18Spkg5lSWn3C5h2El4nI4nMq0sISlEpWyBjS7u0/l?=
 =?us-ascii?Q?cAPQHfUbr3FOYuFgnJ9ScO+GzMjWXZsmOaVaEau3VXqjsG+R5ALxcjw7oju2?=
 =?us-ascii?Q?7JI6lamwq+G/1UVz89oDOJ9vxSwQixN1asCtkJ0GjQhWZax+HPsXT/mETjfJ?=
 =?us-ascii?Q?MSS9dsTfxMvpWkGfKHssL5DNCxRhZLzim53+cVQ1MZFVdXAYz4qFVjob9+YD?=
 =?us-ascii?Q?OaA/WGTjYWbwnmnDvRDTr9x5kfZQYITZ1w7wyFTHgdfI3HRfe0Ut7Qr7Bee5?=
 =?us-ascii?Q?bGSulsS+iGz/Bpn1Bp2HM+SOv7U3YwVXcmgJp9Sa3gHb5+jKYce8u05vT+ie?=
 =?us-ascii?Q?FKHQVb8Fg3E0AiyN8T2vxhKHToBQ07qS2aMQkD5F6LIU0EGwG/iTPhwQht89?=
 =?us-ascii?Q?3stSQCiDVpFHHviVvl8GSshjOw+3OU5eUpGTTPamCD0t7BU0rUNLHz77oV1c?=
 =?us-ascii?Q?DGQBnLqOxKavSYy/lWD3l9q/3wI73vh9khb5Sg90ebjI/k9QI0xYbJBUTHDs?=
 =?us-ascii?Q?+H5CZ9APDxCtbLYZln14aQKsy9+BNhW65FxUqoQgoUr9oJGIH3td6XKTpNRw?=
 =?us-ascii?Q?Ucb6YehH4TnRx6kBtiBQvigUEjCATPqEkJUmBKghZQO5GUUQBb5QPBO6aRlv?=
 =?us-ascii?Q?B9unz4xwNj6eeZJhh1WMg+0GP7iOWbGyXy1S6IAwYyo3/mZ5cHfEYLSZk5Lq?=
 =?us-ascii?Q?cY1FH/dH7TZz/ZUPk5Aen1ghWeF74NHR1zEFbStmfq3s0rU3QLvYmBPzMsPD?=
 =?us-ascii?Q?betrfFCfvQluIcJIVHu9RfTReJOeJRpSP+w6hblHtcNJqugK3GJ3gKD7TpZx?=
 =?us-ascii?Q?URicah0aUGHq0m8jWSZfg8S+uNgNGfipetIhoDxFJdG//uUPObbHIkp/r+ON?=
 =?us-ascii?Q?ZkCnEmQn9rfE2pZS7B3DZ6/uVYeeGIhSJujaj3HTLXheHO2K8zFF/tmIPNg9?=
 =?us-ascii?Q?g4cfXisRPKx8XyQk6zt6dZV55hUbx2cssa/ExMMj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/EmHcN5sAnBtyaETeik1dRKvf6NZPrwZt+9F0kkHsHoH1f0Ra/PFAZtFTd8aKUNRMX8rYMO5/gSPYGp+wx6f2XkWcMmyyHZkcNR3le27tjZ+6ZV8WkkCOWiGcdFwKnPir1A4vjpl+8lZLlzEqmhFxRcAk3lf4pf5w95KVMeF01DIh+8puHfodcugKA4EO7j1A0LtUnNJk7PwMbYgzCI0wVdwCTIQmZuTLhzii7wBQnpH0dN4hKoJrhPxW2IX2HesHcvbrVMV1hVo1Mo4obNJOzGFhFSjQGLX2J4tNFVdlgaBpNmsi31IKEuV9QpSZrmif332m4TJIH0QTRJom5C4jgx1mov74iGVSSPPTfuM+OZxk2pilENtnpM6B24D76S+aldzVTLsTdv9EegpCYxMem528oKz/ccwQ2qnzhtzIZZBMCcGswSp8VbH6XK+otrYKJFHUrrcgRHLCTBbetcEgP6lflEdciCOvwfJIbHUocmlppIDXy0jjStjejSozwwK6bkau8wN0FkY40nap4ukmQ2JCatfvWav/pyg0CopSNNEm5kAxLtvEIoYiopgqIkHUkRjjc5bgMl/o0nihCOUmHjfEPD547FAE4ai2yv5vLc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ade322-df3e-4c57-fdbe-08ddbae6f697
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 10:38:50.2023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FU8chCSkEnuybP9rJ2WdaHBV5Jz/sTDZgNcRiJF5GrKYcDKj4zR51c8QMQzputMjvgspWfqoHXtr7U4dNG7jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF01BF54C53
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507040081
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDA4MSBTYWx0ZWRfXwciuB7PTanWn Lsvx8bT/AW4JP05WvtywrValzMRQwqLcN4JKz5nxGF6KLHWR7Fv03bUJqy0B/rCNzTcghkdQg+4 ctytITT1to6/4sg0C/z0ODzOabTlf2LsdvoLcMNo5iiK5+vCsF3DmKQnfvAdrGLk+phZq/48icb
 uKXLsMdCAlC3ByK77ynVOUp4ZAd06lSvkbm0/5su0JqLQDRNOlT/nJlvd+mAYTSa3NFKo8BzEVT rPECqfUxFonyGYLY5azU8vUiTnG3TN2EYYeA5fRKu9azrWn4neeL759YZSOad2wPDd6N5Uhiw2Z XuS3DYNo+WdmpkauALZpg8JiQEk75GuAIIsHrLOfOMhDVA6PzAjTAVFFZv/c0Yg7xrIv7jNhOtJ
 c/wUSNfxaluX09GUrdv8aszdafPDQNjGTmVZwkm4v2iIzIwJmh6qLQVgV+uAaOnrFtjczmM6
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=6867af40 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=-xrvNejlkGy9L0SQylQA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13565
X-Proofpoint-GUID: -8_Yi239OoDHL_aO-gKxuBkB2t9OiA2X
X-Proofpoint-ORIG-GUID: -8_Yi239OoDHL_aO-gKxuBkB2t9OiA2X

On Fri, Jul 04, 2025 at 07:30:53PM +0900, Harry Yoo wrote:
> Commit 48b4800a1c6a ("zsmalloc: page migration support") added support
> for migrating zsmalloc pages using the movable_operations migration
> framework. However, the commit did not take into account that zsmalloc
> supports migration only when CONFIG_COMPACTION is enabled.
> Tracing shows that zsmalloc was still passing the __GFP_MOVABLE flag
> even when compaction is not supported.
> 
> This can result in unmovable pages being allocated from movable page
> blocks (even without stealing page blocks), ZONE_MOVABLE and CMA area.
> 
> Clear the __GFP_MOVABLE flag when !IS_ENABLED(CONFIG_COMPACTION).
> 
> Cc: stable@vger.kernel.org
> Fixes: 48b4800a1c6a ("zsmalloc: page migration support")
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---

Possible user visible effects:
- Some ZONE_MOVABLE memory can be not actually movable
- CMA allocation can fail because of this
- Increased memory fragmentation due to ignoring the page mobility
  grouping feature  

I'm not really sure who uses kernels without compaction support, though :(

>  mm/zsmalloc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 999b513c7fdf..f3e2215f95eb 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1043,6 +1043,9 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
>  	if (!zspage)
>  		return NULL;
>  
> +	if (!IS_ENABLED(CONFIG_COMPACTION))
> +		gfp &= ~__GFP_MOVABLE;
> +
>  	zspage->magic = ZSPAGE_MAGIC;
>  	zspage->pool = pool;
>  	zspage->class = class->index;
> -- 
> 2.43.0
> 

-- 
Cheers,
Harry / Hyeonggon

