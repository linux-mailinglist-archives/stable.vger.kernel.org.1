Return-Path: <stable+bounces-206369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A43D04201
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 17:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEE233491604
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18871B6D08;
	Thu,  8 Jan 2026 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ElevO/HX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BMU1EeBE"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A940C3033DC
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885968; cv=fail; b=HtF2yl5XJp5g7zzH5pCsx84UZjqH0Hk7LWigpXjCnqOLK0qOnBwWmtubn6cxgLm8QH5J/HhjA9OR0WjXb/oEorvb/ODV6rLDMwlPpvVaiV08p6dA9jPFzi+xqH0ZMLf/dwIuTGuQW1dcQXAgmFV1iDtHVORumbnRWnSAcW3RH3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885968; c=relaxed/simple;
	bh=gRmuyenGxJ/OOcZpQ7gSav2/0setRh7V5/PldBvOy6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LCykp37XwncjcZBphfu+6G5xfgeRwj0Qfiu9y5CQRpVmnFI++/xH2qkQZTzZWAH5uveC7ulfYwq/0MlRScxspSKm6qaf7o/BBC4KB2q5UvezxcZrGGz2we8jzLt/9UavTb3EwHfOJlb8IF2smoUF1zEWXqZsG7WBidWzNRa6+Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ElevO/HX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BMU1EeBE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608EnsOo540425;
	Thu, 8 Jan 2026 15:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4C5f5548Fsh5nWwi4a
	uNcDwLJsWmDQIbA4T0gvdsKNI=; b=ElevO/HXBnJnwUJiDLlLFQL5BgL395qNSG
	BNJv4U+YGTcD+YXPDshbYIcKsE8cYo5YFu+GSCE3DpbEWoK1MIOJnn21F87vd5fR
	vrirAhKepgFQiQi//Udl29B1ZDc9O70qVdjreBSgXaf4Cb/mbUSCLnUKKqDUQNm4
	VzVVH7XI3F5CK18X6GybZNEK1PM5VIt1riP04UPLBc9pj9Ul63pmAUfpP6MY4ayf
	FplDseqtVc0Gnfgfv24lHD9OAWJWTEUVw6q6QXxNk1sVxG4O0rf3Y2QQjOhaPISc
	rMQEbTR426B8pFWsqu01RBAqWDfWRjqC2G5ktOxAj/wXlt1VpX5w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bjephg1wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 15:25:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 608Egd3c020452;
	Thu, 8 Jan 2026 15:25:41 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjn7rgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 15:25:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kwuql2viSTRWdnAYi/3VYDNfSrNj0WGiD3epwb2XQp7DsJ6p3EHPKZLP2l1fA0Cd5REsvWyGG5ZhW87B1YnINhQokoVVvi7iwhhIUm3RUNnfv4zUy8DZLsGNUrgvLoji/MyLzZMZIQhiEfuw81T/Ms772ByLtb+8Y5ceZdtjGlCQp6BVO/kVo6aSzmsohfIQExPqZ8Y+VugoOGnC/eAWNuyOGTHI05ixOkRteLypdaG5cSs8yjz5/TQR0SUwlr6Y+th6hb7w/uo/rVldK4NBYeUPgVNUt/wg7AK0MptzOZmyqy0Br/dRZdPH83RDrNVJiFmabVfYbCtiImHkunIn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4C5f5548Fsh5nWwi4auNcDwLJsWmDQIbA4T0gvdsKNI=;
 b=W0/GdoVK28XmYOo+xtnfiUqbkxHUjup4dxUk6pw+yK6a+vgGqHHUdPOMabx4O5KpkfGeG0v/WJWXq7HwUDJi5LrA8PPgkTd8EfaoVD/6FL3AQSFo2YjHy7qbPYUIslForV94f464H/F7VcuZCwf0Lg+BTdbS30PiHD5lyzIOIF6HoTEx4a/dPc/zi9t6dC/HFlNDDSDJ8jCjjmiFhSUMkV97qALn/YLrQ+3j42Ot/vpm4d8W8FLbykDyfhaztOG9EA2+FRBmlNH25IVYRKlpWz6SPfmfUSDgt8144rnGrJXBT8prQkouedVtD+lg1svqNYGjRb4DhAtBBQ9DyUlfYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4C5f5548Fsh5nWwi4auNcDwLJsWmDQIbA4T0gvdsKNI=;
 b=BMU1EeBE9rHlyxnRlQV9G4hEkjbw1U1QvTiCf3fDfULYjvQ8/jd/O6P5mCiHR08l95Z8ec+ULpzfqYzy2hL+PDFiVRZ7SEime2uVwluNtMaARrZkvqsPT+vaO5HO3PA4dvyXI23aJC4Crs5RxF38M2jc+MqK8NXR0m+qkYHbBCA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6440.namprd10.prod.outlook.com (2603:10b6:303:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 15:25:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 15:25:33 +0000
Date: Thu, 8 Jan 2026 15:25:36 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pedro Falcato <pfalcato@suse.de>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm_take_all_locks: change -EINTR to -ERESTARTSYS
Message-ID: <d76d80a8-64a0-43f8-ae68-8b6461a349b5@lucifer.local>
References: <20260107203113.690118053@debian4.vm>
 <20260107203224.969740802@debian4.vm>
 <aV7IO8-trMSI1twA@casper.infradead.org>
 <d3d77df6-931a-b97c-d551-a69ee5ca9493@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3d77df6-931a-b97c-d551-a69ee5ca9493@redhat.com>
X-ClientProxiedBy: LO4P123CA0554.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f97178-be49-41d2-f7e3-08de4eca2a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DTL0Fad+UGgk1HUlr8YkNyF7gitemWw2Jq0IrZZIH6ro35jn/8dwTBv/8hOj?=
 =?us-ascii?Q?HpFsHTb+DHZeuPPotHaj1A4Urs0YGuvAswv0jnaR9iPLz5CA84DZnP8PZmB7?=
 =?us-ascii?Q?YFuiKNC3E4jef8FiuYyRP4adC5Z6veDhhUWJFRNAzKMmE2vJBgTs8qg3GTXL?=
 =?us-ascii?Q?A8qaAlFsLIXlCx4dPDNPJSu9laFiXAzULnOqPZChjguk9bv+YuBXN4tYHmuI?=
 =?us-ascii?Q?87JKYgZopqi4IO1F80dd0/ffitMvs1S8+/pyVBStFygjIaa5uAiGt4jtY6kv?=
 =?us-ascii?Q?sCvbd6y1pIysXyuxSuthbpZWbITNLgUD0hmcHpKzN+QKNp8O0Hjl+B27LjLu?=
 =?us-ascii?Q?l0xmMzg8xPG8prghkVOiCuL0xS3koOimQ/3bZFEgyHugbqVigkST6MC+avbj?=
 =?us-ascii?Q?X4VhgIPdq3hWKz7zQUqq4IXCrio7UzkeZwQ280Jj+nWObeNXrGw8b/yX9Xxa?=
 =?us-ascii?Q?MY/v4npU7pwasbwifPqMkekxE01zd6agcNjRcgvDuFVTKSLUsO/FUO10EKM7?=
 =?us-ascii?Q?gs2qAiOND/4LuPsskSrUoFq9A0eond8ZX7yhj2TnaSeNzf0JsGJESoqqu42S?=
 =?us-ascii?Q?hQe9EpKFoEsGC+6GJVideOpjWIt0AjDU8sD7+08JfK3HrPbxU/nInlDktf/q?=
 =?us-ascii?Q?2xJ8bPUtw2oATctHRIz223gMIwHgztnKxBLw6fUvn34JBFJPz0exXhhIABR+?=
 =?us-ascii?Q?XOqxhMiTMEgFb5z3DnkhmpPuP7164tjQIRUGg9+a4hfJodgsDgJmyqs1CBDI?=
 =?us-ascii?Q?U6YarckZB7/y4Pp9hRf2mpwoRclhSt3MfcsNcvjzgRVp3sMHGWCOZPEhGxek?=
 =?us-ascii?Q?9zAZ0QsWdFc9/BH7p7EMOX8Sxp39L5GH2orVyWLkGX8AbD9TIPTLVgyCwZKK?=
 =?us-ascii?Q?q1PVPZHQWhsn4mLQ6/eyfZRJbgwWee0wUWIPkJeuKjJs6+lQeq6ho5doURy/?=
 =?us-ascii?Q?a7b+8dj7rOB47k07GdytQOOfLWKk1ycetXkSymSuqMx1ypZdqbij3H7Tityz?=
 =?us-ascii?Q?KxUX6QAO9Hne8B85BKw3NnhGjcnmr958sQHGX2RD0EFcNHivU23toXCTp9Qf?=
 =?us-ascii?Q?q7ZYnCmZO/Wo3u2F3LWqLjC1Lwvnr7FtBZRA6K9MvlKFtAUDl05/di2R+Cfv?=
 =?us-ascii?Q?MedD1tcFoEWUVo9vX9L+N1F0YRB4IfQ47HYDqNQSv9mThxPMZ68QdSQx6Qm+?=
 =?us-ascii?Q?QuvES0pydxEroyVSJEq6vy3yrzAhOYYpUAzgLUVw1o68JcgmNnG9rPZscgTK?=
 =?us-ascii?Q?g6Z7s3/1cqK4uzaeVV0z0/tQ3gxn3/BiMXTg23+zOpiRtfezy93oi3sExO9K?=
 =?us-ascii?Q?CDjQ1GF+Nae6iqvBBm7KjnKido+cbuJZBizlDFajiychW7ySbmqIlR2421ce?=
 =?us-ascii?Q?hPuVVbiC8LaDFaOnSRbH3tBAF/sV57TwD4FErA46lToJQavDCNyMGcx+TsM4?=
 =?us-ascii?Q?8+v7MfDEvm8u39Yn3eyOuSnFSNqn9p77?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8pIXKkhsipNiz8Tz1nISFpz1if3zg+prYTV0IN8Fnn6Dch9ffKfYyJcAl7mk?=
 =?us-ascii?Q?SGF5nIqJdxtOvJtc+y1gMd46khrqOSh1+/hMYHZ3qlaskNELmb8vKZHau86U?=
 =?us-ascii?Q?Zez3Dr0Ossw1mFkxq6a8whjkjYbQYoNuqQEOwJDz+7yM0+MAWlbp5N6ooO+I?=
 =?us-ascii?Q?ozMqCvzBoT3KXzb5zJu6VijgSOMmyYq3lBXnu3kR7vmVDS736OV7NSrqEDjA?=
 =?us-ascii?Q?mW/SOw5v1zbZfnPTTkJNXiS099OvTlCiXmObdPhh+fy1xxY2rG4tA7L+UJ+H?=
 =?us-ascii?Q?JO2XQV587kHULi/M4OyZNaQKkBAVBZrZzcojXPbTRbBo6AjzaJ0j4RjoteSw?=
 =?us-ascii?Q?tzlUG0bvrIGmP0fS+H5iEvOwokymRC4AhyRPFV8VwTLxatuhCs2hVHhfOWUI?=
 =?us-ascii?Q?n0w7q1qFpxlid7qRjdbuRkOPFBZjDnD/xcalvM1yy3tiXOCCEOKcEjAWUrnf?=
 =?us-ascii?Q?T/+CS/sxaQg7mSakobO/EByKTZGAhcG64VOtD9B4rN9awl4NZ+9/67zVA08A?=
 =?us-ascii?Q?HAIWfgoUvVjRZeRzX93o2O7DCYXoKWSZkm/v9lvrcq/A4Oz4xlp9NZLY0GFS?=
 =?us-ascii?Q?ow9t1sLwlzTccIC/2WlT5nYnCEvCJIpRRPizZF/OB2OK9Z4zUFsZ14DK86cO?=
 =?us-ascii?Q?ovrNDDJD0TGTum4A09wO6BlPcKdehWL5DKCJEBYQWzDhN9s5/HYuxu/W3nBh?=
 =?us-ascii?Q?ALTDwQ8R0XgK+cjBzRvx88aW0c3zZJM9knpSueyYFsGMb5bxAZDMm+lopjEY?=
 =?us-ascii?Q?VJowO9Jq1BC5xoo81D717aQSu01WKXWjpkhrvS9b376LtwW8cUVyJovVUEVo?=
 =?us-ascii?Q?FDI3axRZFbYez+smJOhpdLXLPLsAaX54Yl9SfjaGygRjIX20rF44g1FCxuNh?=
 =?us-ascii?Q?4l7yNlrWEeqd6dIZB9LXM5fY0C03pZVrAsYu2a8cG95LrgFSIFXelEioBatn?=
 =?us-ascii?Q?MM7o41e8NlB8RhD7gHrfrkoG4kQbUYp2X0b6AHh1+H3vGar275bpj2piEWcF?=
 =?us-ascii?Q?2d/XM6mgVGP/ZOHV619mNhnWGIrKYRlJNPo62niDyCJGmQ62xrGpE/1MjL6U?=
 =?us-ascii?Q?cRCA2JztdcXIsvN6ZWq1USmizRXUM1vPz59MNKQy3PjiRPlgkQpvfsv1HJO2?=
 =?us-ascii?Q?Ur09Tb7E2FTtqLsaMekcpBA9WihHBLamlMl8WAHP4wgpPUtH1bj+GWEu3St+?=
 =?us-ascii?Q?snqp4vzludc4R/K+REkIZbCTNH24NwpWRyUzW8+oviFqf57Wxmod5WthgUv0?=
 =?us-ascii?Q?4XkAOjzpMWHLjAbJfb1gLIVJlgr9z7WSS8fdsuZ3As36/CiEZDgAg4EXr0vg?=
 =?us-ascii?Q?ZoVbxxDk0ym46jPSHgmzSEG8EX6S/W4d75INKR6fb1Gbs+BtW3OqbtvQb0cI?=
 =?us-ascii?Q?2QdgYkM2E2bxGPMhZIHI31Wve1995vrK3691z1aviJbMKYPivCzUU5ucT+Pj?=
 =?us-ascii?Q?TCTRMaK0z3/lsqH+op6g4PcOT6dfbUpIIVWt3ceT1E0SlchZWPjn+KWzID57?=
 =?us-ascii?Q?L0QavWRHhofNgz3lhPB3Yr+sAzFngVwgqxc087yjR30wUdq/zx69fCwzmx7W?=
 =?us-ascii?Q?r/upG/FPd5Wmz6JrZMXwWQBbJ1pT148fxlFZkvNzIaq5ZmbVMAKtQLOh+UK8?=
 =?us-ascii?Q?5fgBN1rD6WX+AZMcCVw7iBRE5TvOMD3R1vLcBbTxM4bxJQI4kouWkYHSpoRp?=
 =?us-ascii?Q?N7J0QRQiNS8JSOnoV/1TrQHsdRZMlz5rEpaxs8SYOjtcqja3OBj6yS+6v11F?=
 =?us-ascii?Q?6XXYWeUcN0xzR7SglWNfahJMu9b8QZU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LJ0/0PbVQ05EzNHlr3cgXkt1niOZsmh7JhIT8g3RHFSBoD3fPWtjwwFYr3FTYSgxTUtstjHk9Gz5RsKa2UaTcBLZNjq8vIofDfZX1MWq/pcWZ6Ik54v7htLCqI3Voz/KImjr7sjMT1zpuifIoPryUkmM+Ny1zrwPTCOjuthc4efrLRKlAJIj6SKNkDr7pYTO/shSvKBLvM8Bj0a8OXoAniVzwd/sYpHJpMGi49YHDqFJ8R1IGQAIxkNWZiIbtQbWr8kdkpaqKYBJ68w5LYhCnyECoePrf3lxn0I9xgPFJTYZurGys8j/4ZbBzi7q4YlLuYDRXlr1Y2RQ8cCv4tZrvYQKHbgDlA4tdZ0rK35LnwkD6hFqmbZk5HFQoD8GwzCWb6TRAPQerw3PDCt3eL82RVKw0vcI5jeIJmSOw6SKfrMPZS6U+BZRC/G4SYE6Q9JZzrQbtHaG2R0qslMyQAW8zsxXsHJzmKo0ts5snjMQa6UgjGiYLWdxTcgHaaX0J5Wf9VAF+jvDsrL2aA8ORgUIsTBSHGditIh2dI6fusBP38/cjCITz4yd1tHuchuTLqCfBgazKhCAI2EbngEnriDxZfDE6PbDJ3CKr/K86fogNoQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f97178-be49-41d2-f7e3-08de4eca2a81
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 15:25:33.7793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgTqiYYau+pZ+oBCEx8zpfSXqcWjirI5ykBnHL5+w0LwQTBQcpuDrlt1U0LLak+xDnrkwpqLldAGxdqmBBByec/Q11YDoS9eXQ8VertNces=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6440
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_03,2026-01-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=904 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601080112
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDExMiBTYWx0ZWRfXw6JGSKavaqsl
 sg9IIVhdhFxD63FE+rgB44AF/8wPMxZ/DZaxu3VqJhQXgiv08Gew8GTuETityJzkC+WoLnj6LB0
 ljzU50gB2GruEHkLr9/mznGZCx/eIa8D/Whl1GhT2Rv0ANk4Fcwp05VidpQib6I2yJItBA4gWut
 1FMMS2ESTSeTaxJ1+YfDNbqUuBElsGIiZHJX9IKy81WLu9ICCIT5ES30e5uOlo4OPglXxOk5t+H
 pB621AmhjfkZ5SB8tpKlr2CKBZQvKw8cOTq5WOUcwn1MXfuGw2I9WHdlnG5fUsePGogqQLTfRJP
 UTWtCNeKWJhs1jsdPY8SXRsbniBELKh4wOfntntuJJk5bP6P3vllBY5HxDcLFQ1qHie6H+3znlU
 zM2lnhK+DPZJL5PKcfONGAf5k5nPHjgWVh1pdMUbyN0S+zRru9Mh6TGGYmoagE5j+4TJs3Lrp+F
 GxX67ZCOi4ihG2HMxH8Y5OW38sskuVdxPNBwCKvU=
X-Authority-Analysis: v=2.4 cv=WcIBqkhX c=1 sm=1 tr=0 ts=695fcc77 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3h__0y5NYsgpCY70QnIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: efjtspZIC6aP3IcblVNg5F65vEvmt00O
X-Proofpoint-GUID: efjtspZIC6aP3IcblVNg5F65vEvmt00O

On Wed, Jan 07, 2026 at 10:29:44PM +0100, Mikulas Patocka wrote:
>
>
> On Wed, 7 Jan 2026, Matthew Wilcox wrote:
>
> > On Wed, Jan 07, 2026 at 09:31:14PM +0100, Mikulas Patocka wrote:
> > > This commit changes -EINTR to -ERESTARTSYS, so that if the signal handler
> > > was installed with the SA_RESTART flag, the operation is automatically
> > > restarted.
> >
> > No, this is bonkers.  If you get a signal, you return -EINTR.
>
> Why?
>
> fifo_open returns -ERESTARTSYS, so why not here?

This is fundamentally changing what this does for all callers, and we've
simply not encountered this issue elsewhere.

Given how long it might take to work it might be interrupted by another
signal on the next attempt, whose to say that it might not result in a
situation where it can never complete?

I thnk it should stay as it is.

Also the comment above literally has:

 * mm_take_all_locks() and mm_drop_all_locks are expensive operations
 * that may have to take thousand of locks.
 *
 * mm_take_all_locks() can fail if it's interrupted by signals.
 */

Which at any rate would need to be changed even if we were to change it.

I'm more and more inclined to say let's just drop this series in general,
and you should go fix how signals are handled in the driver/userland code.

This is really feeling like the wrong place to fix this.

>
> Mikulas
>

Cheers, Lorenzo

