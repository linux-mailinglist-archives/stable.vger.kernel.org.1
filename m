Return-Path: <stable+bounces-124442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15772A6139C
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 15:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8BE17B52E
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 14:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3296C200BBB;
	Fri, 14 Mar 2025 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="n6ogAmMK";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="n6ogAmMK"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2072.outbound.protection.outlook.com [40.107.241.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5B1FF1A8;
	Fri, 14 Mar 2025 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.72
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741962478; cv=fail; b=JNIRPx2iYVr553l5s1o9h5bzRR4CjGCx1QkmraQb/UKrlVlgLExqcOi/hFnSCj1za+sf5968Z10qtGIWXhCZwWstjwWDtsSnfhF6Cv6rmjYR7rCB06xfMAogJPMWiAjATEL1Zv3DZlJzbZ1YdvR3XsrpDbgwsNngPFwIDjb/yYU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741962478; c=relaxed/simple;
	bh=Tcm8nt0mlQUlzzVnsC5DG4y8VuxVBaD2KiI5w+MdT5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DrZFau+T14hs4v45q/UGNEbRWzzmv2jL/a8HkB2MKHRmDIXij4YLMLN9ruvIaN4AS1yIUqwzDmEUmoVngznyPQCXK05RSWs04GJW4hqwCl15Y5b8/r5RyRYAxSumiWpfy5ePaOFGsVnqxYPaIktIlYFwylmfXWrjzB6T3YgdFs0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=n6ogAmMK; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=n6ogAmMK; arc=fail smtp.client-ip=40.107.241.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Udr6sioAiGUtAI1Ws3z6EnoVPuKKwnfMzo3zm4XVfBOmGePH0BHe5llYN2dY9azGKSeqrUbpIF+VwjKT8P5K/ftVC1pRHk4CbBdo0b0Rg9BHwT1eDjX3jGyjiLxMuYIH5tccELl/f9HhGLywzqfJAQt7aeuDCsmOzwaZgVWmTUIC1sV/6LPsfB6rhpD5nhgmCDZAZ+6VXJaTlUYxIOe1bqsTZfD9hfQymxxOAPntTllfFYMl59h2H/0RUw9prKG9dyUKURG7kEppcWwLv/NADac650QxKw0gWEIeI+7ci4N9XDoVnhLSYKvkPiCBLodkv6GeljrNhOReeCdKnGUfoA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q2wyiezPGMolrk8g7AoPntG9XWPRtnvN0drx/9iOJI=;
 b=InYTRLpgcqvmgSx+YRHD+vsXzOSPfK/eRFsNwueEzgOxll246CcX1H90ZM5q7rnqu/dWfXPWQOq/SK7Q1eooqBzSbDOW4msu65eXhr9xKFWppjjTv1TUzR+EDUw5KmBGmWtUxb6+wlawM4GCCEVvlebLEF3OCMS4ZMMXI0pufZrjNj0r2S1TS74Ll4JmtUihrDkWV2x26PtVk0CG0JKtXfBm9RVbu56MzQF0GsfXQ9uLStY7+v7yID/cbX8G8fHMmQZakBUDtJLEGGSRiDETIAuZGOoVTr1PwkUXcT4zEpaNkxROnX2HoWA72DdXZ6K6CCWGUP4YKGeuD1jfIC8Mug==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q2wyiezPGMolrk8g7AoPntG9XWPRtnvN0drx/9iOJI=;
 b=n6ogAmMKJzOdxv1JJQx+pTh7Y8BWVB7tqKIt8OokDyYfBlan7VSsg1yW9kp36zX1/bfsqJ2Q5nZawTpvhX+LTYNZ38nv3VTeuKcfPxsT9t51ZXoukT+O8JElZ1f2U0eIfADYJ7CnYoeoRnYSagU/46ICaLQauU99wElUN7J6FlE=
Received: from DUZPR01CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::9) by AM8PR08MB6324.eurprd08.prod.outlook.com
 (2603:10a6:20b:315::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 14:27:49 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::c1) by DUZPR01CA0049.outlook.office365.com
 (2603:10a6:10:469::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Fri,
 14 Mar 2025 14:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Fri, 14 Mar 2025 14:27:47 +0000
Received: ("Tessian outbound 93caadfb5148:v594"); Fri, 14 Mar 2025 14:27:47 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 310a7f45fcaed3c1
X-TessianGatewayMetadata: zp6C98OuP0bKu2sV8WgQr31W8aGsUx35Fcuqe64jHtxbyUWVUV/uVp1bPNENdEedM+RgJ6Z5wiJr4j06/kIOTKT2PAlHH0GDDZdXSPdsj3Mz/bY4PgDetKTVR4jlkJoBWKYz+fQiRZFHqdB0oXryddC/AcrKF6rQPCveB5LBi9f3UxOA698ppPXoJyFAZa13A9Wdr6wpIArCYF1Pfw1XqA==
X-CR-MTA-TID: 64aa7808
Received: from L6f67f1bb6308.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id D43D486B-3DC1-41A5-8F38-7E19553466CC.1;
	Fri, 14 Mar 2025 14:27:41 +0000
Received: from DB3PR0202CU003.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L6f67f1bb6308.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Fri, 14 Mar 2025 14:27:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOs2abd8K2SEaL7xHI6IjJpF+DBjUPwB/0NE7v9JolPGVlrFc1aGZdvK1SzpZ3qeozgRHALpv6Mg32vHMzcF+YYrGlpPlUNS5Kmu9LR4arLPngJXlAYF7PeApL2hmH/5ZhhYEPPHWMajeiaULyQ3nzq929hZrt23a8mSLGHPNA84vvnDTUdBvE7vIDvUOm3XFLIdohyp42VCk28hQj40Jo/7+JwcHFtgi5R/+WPNJDt0py8pvMgqJrv105gUSo70OP3kftXrbMldRLAqoHW5iiO/fGkMGIOSWP0GUgmCTBDnQuaFKzLpxK3+ieVY82UpA3L9IcFx76wV4re7NvPW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q2wyiezPGMolrk8g7AoPntG9XWPRtnvN0drx/9iOJI=;
 b=l5/wT7At/M4eJwhPGQF0d4Q/BWVTb6l2kjhXORv0p40kw4VF2LMKO5VnK9y/VOL/CDrNMO2RydLNwOqnDgWIiKy62/Zs8gBHdE2FWN+elYFLUvzqyzd4tGCIHpuCa7nnW4sSlRWKPXmEBwLkEnZaeOTlhrsGZYdDELaJEbRBUJT9cp03GHQi/PSOkHqGFinkbkxzNPgQfQyH3p0U7pEKnWhJSGBCGzEoRiPIs0SSkzjZJlLvN7V6CBjzeqj8TCr0DLGbM4+2CMBXyXtHAqVKTC4RhFhrngAak9So4FIT9ea1WsoVGWti5jcFETGgXL0hJcIDiPP3E3PUYfdCptoYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q2wyiezPGMolrk8g7AoPntG9XWPRtnvN0drx/9iOJI=;
 b=n6ogAmMKJzOdxv1JJQx+pTh7Y8BWVB7tqKIt8OokDyYfBlan7VSsg1yW9kp36zX1/bfsqJ2Q5nZawTpvhX+LTYNZ38nv3VTeuKcfPxsT9t51ZXoukT+O8JElZ1f2U0eIfADYJ7CnYoeoRnYSagU/46ICaLQauU99wElUN7J6FlE=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DU0PR08MB9654.eurprd08.prod.outlook.com
 (2603:10a6:10:448::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Fri, 14 Mar
 2025 14:27:38 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 14:27:38 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: Dev Jain <Dev.Jain@arm.com>, "jroedel@suse.de" <jroedel@suse.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: Ryan Roberts <Ryan.Roberts@arm.com>, "david@redhat.com"
	<david@redhat.com>, "willy@infradead.org" <willy@infradead.org>, "hch@lst.de"
	<hch@lst.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] mm: Update mask post pxd_clear_bad()
Thread-Topic: [PATCH] mm: Update mask post pxd_clear_bad()
Thread-Index: AQHblEP6iy2NxsgQOEWzpbMcMcKW17NxYv0AgAFOLW8=
Date: Fri, 14 Mar 2025 14:27:38 +0000
Message-ID:
 <GV1PR08MB105214AFCE69B0333DF65D3BCFBD22@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20250313181414.78512-1-dev.jain@arm.com>
 <495ec80f-6cf1-4be8-bc2a-9115562fe60d@arm.com>
In-Reply-To: <495ec80f-6cf1-4be8-bc2a-9115562fe60d@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|DU0PR08MB9654:EE_|DU2PEPF00028D0D:EE_|AM8PR08MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: f365a400-5ca2-48ce-9a72-08dd630464e2
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?rbfqmMmsrHGUpt9V5av39Hx5nXSKsM1OU9qIM4aAPAJPSNptnjhpJB2evp?=
 =?iso-8859-1?Q?ti4yfv9y3kFWi45rYJXUJrICPLOTMQddGs/AYIfD0z1rCEuWdC3HJbOyi6?=
 =?iso-8859-1?Q?7sJRdLnC9lnObkDUqASaytZW+rmT6vc4baKebcO3Um7bYwwpEjUEIjctv2?=
 =?iso-8859-1?Q?eg24qYNkOnMETVQfjwnXm1TXIivieDZi0KktJzbkh/vNKzFKaATqshooYr?=
 =?iso-8859-1?Q?YzTXU3tn1+XiKBsBl8X9JdwFUhd/676J1A5u2MIaq2iORXBjCRZ3EDi0O0?=
 =?iso-8859-1?Q?MP1DPb3DLi94MneZjcMKKKMggcU8644cLfgytJ5Flf2Za1ma894W+jUOPl?=
 =?iso-8859-1?Q?LQ/Dvs1Hb7IpTZo/6mDXyFCWkCU6i3sZ9stGP3nFuWzOJh0qMDrotE7jIu?=
 =?iso-8859-1?Q?kettKgV8NINpudmLPm+hQwBwqizo/eC6Drn8sEtRZBSwFews4KL98LUK47?=
 =?iso-8859-1?Q?pUGH1liazyLdSyTw4t7wNnHCN+6zQ6kg+5CuE/Sns5C69sOeRJsaGc9nbz?=
 =?iso-8859-1?Q?K523pc0ETpZhTxhQJW4OlCJLDrbLvt+lav12q+/lZGt5j6nKVGs2TVKbnn?=
 =?iso-8859-1?Q?OpC31pb162dyFciI9cNA9iz5zfyH8gdtX5Y9AGWTOOGr6MphMcqUDli3++?=
 =?iso-8859-1?Q?76+we8HfVWNgfIpsI/4MzLK9/+OGJEBhGFynEuRX6S1sSPCaEiaWJsM4PT?=
 =?iso-8859-1?Q?8l18l3kTtEA4pRwBj0STqLAQmtO8oU1TDZiFrp6GVC8RSduDycUwH6JBZg?=
 =?iso-8859-1?Q?3DmfQtH2NgROSMreMo99tgVIYqBjThbgx0sI3JzXyp+0mC2qDhK0VZP17d?=
 =?iso-8859-1?Q?1IInjnn7FWO1pJM6X9TYU0X+bMNGzUIjT854hMQ+YELOsgT6z+GssEg9ky?=
 =?iso-8859-1?Q?M+A3fkgiLsJSjF4pM39ayFD0fHGc4o3JiGh7IhDfAqHsFw6MBmVOJ6wng4?=
 =?iso-8859-1?Q?2of6sOFgvantJdWy2rFQXgzEOLViJ7KiHwssbBoWU6zFmjDJMFYngBM2rI?=
 =?iso-8859-1?Q?sQGPlDMFy20EbBg4kGLQAxTjyUodDreusdDwDX1y3/76dCjYerkuOuQwi5?=
 =?iso-8859-1?Q?aYLsmP+OwFx3haEUubbt6BYkmKJGpm/KvZN7CvkleTgGQVPYm2yz6c6mMt?=
 =?iso-8859-1?Q?APdhyk7KOa7bgY1FwH83yybsoURWEcqAGfsUh+bMfnKipiCoFcAgOkOLTl?=
 =?iso-8859-1?Q?Mw/uRIK/dfOaz47AvjGNPzWuKhVgeDvLLsjEuw5ztRAq0UO5n/XoFqJl2V?=
 =?iso-8859-1?Q?S58KzYPvjVHqy3wwVNVytJRjNjI+v5V0x1EIWLX3OOjP5FzPNO39hS0dUW?=
 =?iso-8859-1?Q?x+6ms/n5FQM/30XQEs4NMJmSG2eBLSJlpfMJYmygk1jXYSb8SKw4o4ppq2?=
 =?iso-8859-1?Q?cD/67qLsy6tr2CJ5BlN46T8BF54XlowPFhNdvtnTHr9qQr3gaHatGfQa+H?=
 =?iso-8859-1?Q?S9hXdQaDThwa0gW31r5IFsFPYrU0dV9D1MBoFm4gIJkCF5Z6gUFUSyzwv1?=
 =?iso-8859-1?Q?IQyOKOjuH46HmJRau8tt7G?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9654
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b2afd431-9ebf-4ff4-8317-08dd63045f02
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|35042699022|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?VWZBv+IveKlsBYyiO9N60NsCsuLh0ZyvGrEmXbI2qhRrF9S4E75hmTedK9?=
 =?iso-8859-1?Q?iZkQjvmGyu4hs3byeO2xfK7eHKMCZl3T08LemMrLREeZRUbuuA4u7N5Buh?=
 =?iso-8859-1?Q?Jv/fykhw8QbFSsw87O1OecOyno0uO/goQJ6kb3M5e3GE0klQXpnJalu2mu?=
 =?iso-8859-1?Q?bvtn77sROrY+pejQTdCPb9WfwmoXeuJA+IQpiTEosP3x0XWEv+PTrpkKpZ?=
 =?iso-8859-1?Q?TBJORQqGbMK1zlKLKPWKjoNbQ26/MoGzSY87kQWxMixGHACE1ksw2lcRvT?=
 =?iso-8859-1?Q?oxdZzaRLeO6I9sP8W0j7RK/54m4gSqJn8bi2a5CBkT1o3b6YqKAXArMhwN?=
 =?iso-8859-1?Q?Xb5MeeSrLddzpRGDMLjBtiubVfOKXiZybcRKgcpoj6WRM29How/N9ozAsP?=
 =?iso-8859-1?Q?avUBLbGKUoV/r+BFYRu3Y0lK/c25IWn5SR25uAMODyDUURYq1eqDkPei4l?=
 =?iso-8859-1?Q?ua39vwjuDu6GBZYNT4POxA7sW5/+dvdZamINOO0rBEt18D355RFlm/Sx80?=
 =?iso-8859-1?Q?b8gcZpO/n6al6qoyXpd0JaFZ3uf0zMwhpHlZOSsQBc3xc71GAJDnwSx60W?=
 =?iso-8859-1?Q?VxvUKZiR8QUnwkEv7ozxw7877POAuRMIIfO7OJ883bAdefFsIcJ24HuJzP?=
 =?iso-8859-1?Q?gYOpTWdqtm3pZ4+o706gcQ+PyR4XeIC8tpgTA47d/Uhs1MIxlafKiTIxZc?=
 =?iso-8859-1?Q?rXZFxhFePQlWDaBjj+N/G/LecTRB0sZbR2qHXfxqC//LPk00BA7eLzR/HB?=
 =?iso-8859-1?Q?TQ+8BDgfax5d7MjX7tpUWYfl/xXlNJB9lY8p1pM5IHJ+xEPfUjTfmsy6C5?=
 =?iso-8859-1?Q?aciiWqxp//mm1JQ1FNf6+lJ4nLr/zlG3AkKR3ZcKS/LnY1qk0JwtARrBL6?=
 =?iso-8859-1?Q?Jr+tBXmNr0REvdqMe3zEJzgjIItAMP8wOy0DnYix1mnokRf7JsX5dhJkSX?=
 =?iso-8859-1?Q?IRfeoqfXTEQVVtaCcgIBukn+T21gfMAPV3Gpvi2B0BC5i0UnsnVZ+sxi/U?=
 =?iso-8859-1?Q?aSCdwonXabaos2qfJSIfaS0Z2oL+UsviwxkbB2OOtEjtZUmDkoLJE1YGcH?=
 =?iso-8859-1?Q?Cz/ZghdRPd5LANYAXV6cnKnO5PXIf9AoygWzxgtvBCoQdWDPK3MjsHhv5y?=
 =?iso-8859-1?Q?bnP8gXkjOiUsifEGh2BmhNWS/E6ETGhwe8DvoFxOV17XGmU0tHfKAOvxJn?=
 =?iso-8859-1?Q?YimzVm+uBpgCrBiGbrJWTjE34Ow1xERQH5gYElY0LaX6z5GiUPnJCn9K4m?=
 =?iso-8859-1?Q?ncwbmleRBNAkkxR8ngfTuD3DRKs97GnAQfIQRF4YVr99nfrRwisLe+mexu?=
 =?iso-8859-1?Q?7XOBYq1vZKsexZ7kcLLgxErbVhQ3ftkcIvhQ2jrgLuMnE6XDdZLhsxwAEd?=
 =?iso-8859-1?Q?NGRl73uMCaUsbRPQ7Ouqjc6yTjEvjxKOO3yXkM6eV17bZCgDb2oPlo7BTB?=
 =?iso-8859-1?Q?hLu3F/WbvMJR5x7H0J7JnOlb3mjLmZ+A/TxkNodSZ84HD59KGlDnfInL0C?=
 =?iso-8859-1?Q?8sf1+PGud9tB3Qmf770F9If2VdYces6h/UjnWY4JB0aMWdulahOb0dpZ0T?=
 =?iso-8859-1?Q?kzICfBw=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(35042699022)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 14:27:47.9913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f365a400-5ca2-48ce-9a72-08dd630464e2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6324

Hi Dev,=0A=
=0A=
> > Since pxd_clear_bad() is an operation changing the state of the page ta=
bles,=0A=
> > we should call arch_sync_kernel_mappings() post this.=0A=
> >=0A=
> > Fixes: e80d3909be42 ("mm: track page table modifications in __apply_to_=
page_range()")=0A=
> > Cc: <stable@vger.kernel.org>=0A=
> > Signed-off-by: Dev Jain <dev.jain@arm.com>=0A=
> > ---=0A=
> >   mm/memory.c | 4 ++++=0A=
> >   1 file changed, 4 insertions(+)=0A=
> >=0A=
> > diff --git a/mm/memory.c b/mm/memory.c=0A=
> > index 78c7ee62795e..9a4a8c710be0 100644=0A=
> > --- a/mm/memory.c=0A=
> > +++ b/mm/memory.c=0A=
> > @@ -2987,6 +2987,7 @@ static int apply_to_pmd_range(struct mm_struct *m=
m, pud_t *pud,=0A=
> >                       if (!create)=0A=
> >                               continue;=0A=
> >                       pmd_clear_bad(pmd);=0A=
> > +                     *mask =3D PGTBL_PMD_MODIFIED;=0A=
>=0A=
> Oh well, I guess these should have been *mask |=3D PGTBL_PMD_MODIFIED.=0A=
>=0A=
>=0A=
> >               }=0A=
> >               err =3D apply_to_pte_range(mm, pmd, addr, next,=0A=
> >                                        fn, data, create, mask);=0A=
> > @@ -3023,6 +3024,7 @@ static int apply_to_pud_range(struct mm_struct *m=
m, p4d_t *p4d,=0A=
> >                       if (!create)=0A=
> >                               continue;=0A=
> >                       pud_clear_bad(pud);=0A=
> > +                     *mask =3D PGTBL_PUD_MODIFIED;=0A=
> >               }=0A=
> >               err =3D apply_to_pmd_range(mm, pud, addr, next,=0A=
> >                                        fn, data, create, mask);=0A=
> > @@ -3059,6 +3061,7 @@ static int apply_to_p4d_range(struct mm_struct *m=
m, pgd_t *pgd,=0A=
> >                       if (!create)=0A=
> >                               continue;=0A=
> >                       p4d_clear_bad(p4d);=0A=
> > +                     *mask =3D PGTBL_P4D_MODIFIED;=0A=
> >               }=0A=
> >               err =3D apply_to_pud_range(mm, p4d, addr, next,=0A=
> >                                        fn, data, create, mask);=0A=
> > @@ -3095,6 +3098,7 @@ static int __apply_to_page_range(struct mm_struct=
 *mm, unsigned long addr,=0A=
> >                       if (!create)=0A=
> >                               continue;=0A=
> >                       pgd_clear_bad(pgd);=0A=
> +                     mask =3D PGTBL_PGD_MODIFIED;=0A=
> >               }=0A=
> >               err =3D apply_to_p4d_range(mm, pgd, addr, next,=0A=
> >                                        fn, data, create, &mask);=0A=
=0A=
I don't think this wouldn't need.=0A=
the pXd_clear_bad() is only called at creation of each level of page table,=
=0A=
and when it clear, the following, apply_to_pXd_range() function would be se=
t=0A=
the make properly via pXd_alloc() and apply_to_pte_range().=0A=
=0A=
Thanks.=0A=
=0A=
=0A=

