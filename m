Return-Path: <stable+bounces-169851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80BAB28BDB
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 10:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8146BB00988
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 08:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E431CAA65;
	Sat, 16 Aug 2025 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n4BjRA6Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RUQIfHIs"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630BB21D3E2;
	Sat, 16 Aug 2025 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755332768; cv=fail; b=a6UVIxMeoljKbh0GIwwEJOVh/Wxfrd7bcNbaQugGdIBnZdEYuWwtYm1Xu1eQoDLm1aJsTlEi1oCGyHeCetNxKF98P7VyEccyR7k6ZA/c/NirfpjKtFfoCkCN3jxiRALVpsp9bTc9y64l9HaQQUFjgvmiaUoHPg4OO47llEBZggc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755332768; c=relaxed/simple;
	bh=VLZJ4hUMidqzvSl4K8Y1bOnJWU2OVpkoyt7JRu3zUTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CBZTR/1HMftk3SnqYRubNV8kI5MzTJcv1gGVvwxOptLo5hTJ2+K2PF9IqGDVV/s3qWSXUA7WPSjnIn457mNy8RP15UW7M3nFcbTmtbmai9+2U4TxbK+m1fYqznXG1ENkZFMRIQb2eFEG1/v2kPuYBk/NS7P3Ha7e6J6UoMPb53c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n4BjRA6Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RUQIfHIs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G3gcCA020442;
	Sat, 16 Aug 2025 08:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+9GyNqMWT365VaZT2w
	0pLN55ht/P9vYvWyK94RxcWAU=; b=n4BjRA6YCg7tkK/SmiY2YjxlUoDvejP2zw
	iuCVy4FTq4qJvaEIaTG7cH7k3hedTWLmtfBNTz1WRAigdgNQzcz9jp/KAKcl0Ikp
	H0gvwlC/GlkwP5cVUW+iJ8oJrha/PXiP/SisGNRO9zvAxS6MJMUlPvPFk4qG6D7V
	msnrri+OSuPxQ4RGVoeiHe0OGBdwx0oS7cpWrDLpZJk83UOGgmXwtXpOtD04l0Dw
	WRW8UkOuE4iZ2GOo229QWhUStt89w7Tc26PlED/g8IRuZwd36CAS6Elv5YB8NCiZ
	9wE+Ivk/a5Q6hcV165iwPBkO6pHMQFwSrNBT0fomHjzR18WtjJuw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jgwe88xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Aug 2025 08:25:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57G5jC2x011695;
	Sat, 16 Aug 2025 08:25:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48jge784rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Aug 2025 08:25:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wP6yjFBD1EW8irW6DNMuZUPIOEMEb1iv2K8KMbScgfIZKdTJSEU/HwwAZeQ+7erf1vGFLXSc3e1eFO4I+DJcyhFDwNswKjOQrLrdsMsNJ8e8XQZr17HdqwQElpm0ouwnJbxYUQOdWEbVe6Iel4yhf5fsu/vZ/0IXY6lpci05/tn+MsBdPmX951T5IwszgeLSiBeZxfbIb2XLys7++WiC3MAbEJKMFSTjivC6SSByaNr0Dm0+4u1iEC/tOdLu+ZV/gv7oWOMGypa2uSFJHSShbsIHZk1b8FdXPSqpoZr0fixCaUsQxdutP86N89FkrRZ7Ef9nAoxjdCx/EHb9L+rCAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9GyNqMWT365VaZT2w0pLN55ht/P9vYvWyK94RxcWAU=;
 b=FL5BJXRjWOn+1DVA50AhIU/bhrpQu3H3pHs9sf5lWgYwwfKdCuEsOKQF10VbnQ9ZBrmu02hC6fpGU3T5Ndq/IxdTzBC80GjpwwSiDFiBaIwnQkCr9n+Tip8uw4cf16HC0aRVF5P0w+oJnkttUWaSDZ0v0ZWaV6m3gUYbnvnFPbEEBUsQTG6sDDZbFDBdPeVWRXO7Y674/sUvIq0cvKmyihU7xHeClN9FBAH7tcpktOfY9zC9I3fWXsP0KQkF+dsMiksiKbCV1rrHML8daBG6u8L1u3Rje8gnRWbiQ/RPkxDohs5KC42b6dXdGV35NE5/CtcRD0Aepya6RwPC8f4SSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9GyNqMWT365VaZT2w0pLN55ht/P9vYvWyK94RxcWAU=;
 b=RUQIfHIsra1JUvmMZE3wnU0RWroreRKom9WbVaGFBho9SSBNtliywglDxQVgL6zBRlVItrvsASWkVU9xDfWnmLy47qzTqNanQoTtUubymE7WDjGca52kMZRqc7ZVTPQBukwd7DQ0KVPIm6SJS0U1LvDsbwVij/6soVwdawSrt7s=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BN0PR10MB4854.namprd10.prod.outlook.com (2603:10b6:408:123::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Sat, 16 Aug
 2025 08:25:33 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9031.018; Sat, 16 Aug 2025
 08:25:33 +0000
Date: Sat, 16 Aug 2025 17:25:25 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: yangshiguang1011@163.com
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cl@gentwo.org,
        rientjes@google.com, roman.gushchin@linux.dev, glittao@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, yangshiguang <yangshiguang@xiaomi.com>
Subject: Re: [PATCH v2] mm: slub: avoid wake up kswapd in set_track_prepare
Message-ID: <aKBAdUkCd95Rg85A@harry>
References: <20250814111641.380629-2-yangshiguang1011@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814111641.380629-2-yangshiguang1011@163.com>
X-ClientProxiedBy: SE2P216CA0036.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BN0PR10MB4854:EE_
X-MS-Office365-Filtering-Correlation-Id: e69e978e-b288-4c4d-88f7-08dddc9e77da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?azFzruNgxy9qmiXsmasWZf5QOgEiJ1tl3/5PeKxrahYea8+qtl/aV2aFuMtJ?=
 =?us-ascii?Q?RFyIetjmCIIvy6ial1HBwDkRuy9JDzam95v8GA0g4pMt40qq+C9klA++Xd5M?=
 =?us-ascii?Q?HSaAkAlkjgy8he7Nlm2sHXynaQp7ovIFtGQcq3c/pBb7/SKNiVOkQlCDpLfx?=
 =?us-ascii?Q?HkvMUE+TuyTidkc8hGDdiJwxOlyle+Yr+7PzIv7/tKX4kk3CYXY/eNuiNKyZ?=
 =?us-ascii?Q?6aW3FREecaTNBJMF+cabq7Bfb6dPtQOweZz+q+Uq2hNo5ozCyF5LI0Z/HnG4?=
 =?us-ascii?Q?mdZ81MK5pwGWSzurh+ypIJpB3CvuJB9z+vzpn2TenhkNAl16pDVJGdrLqozP?=
 =?us-ascii?Q?knnLskVaiGalJEXEq4jmbGEdsxBYG9RNzCOcYcgFfMiGUB1UEUFEPME4nZxC?=
 =?us-ascii?Q?bDI8rYs6pPPtfkAZ6MAnjMifsZaiZslAtrHIdpbvrM6v2N/SRET+wNOFx+Ey?=
 =?us-ascii?Q?w9DNHS+ksVeqHP4RWEmRhcFzn3kKvG7o8riHf/WolUOsr7M+4UDWu9Zz87wQ?=
 =?us-ascii?Q?URiXQvSXwNHu3y0NUfO8goSVxnuh8tdhjQ4hHkpIkVAEUjAE/RlsEhCFGeXx?=
 =?us-ascii?Q?ERXQ7M88PqJhismQNZYfDUsV0C42q19wcRyIWZsoqBcTYMwY86tidEPw2enU?=
 =?us-ascii?Q?t7dOvJRKtlJ+wYOh3ofuFfV9TNsqZk0EMnNSoDBWc3jqpz5WKDAYjanXj1u3?=
 =?us-ascii?Q?Vv9lDNQExYj+xUC6Mhxw8OZZGQKT1Qm0rUdYYoS/8F0Mpqg3WbeOvmVtPCv/?=
 =?us-ascii?Q?r3pb1lh1OyQGY964IIbBI//yvg/hCHft4+JzWg+hrfxxlKwRrPKiLuDkFrRZ?=
 =?us-ascii?Q?Pt5YQsTOY7Psfl+4xjcLsJoV1iGf02sF8sh05R6/qthP9/U8447MZVZJCDLK?=
 =?us-ascii?Q?RxDJM+Gq3jTe2GcRb5L9c4B8H+f50XrR0JTtn47TODGc5Ds1ggyKDsNpTgt3?=
 =?us-ascii?Q?BBSOjaWu1ENyHwkZG8GMqburgjFYV4BNpbBD7qaUEW9FFmU0HhiTvSyO9puY?=
 =?us-ascii?Q?NoJ72nKGzge/JZBZKVKeKo5BJ3AOvwHcboHAHWdntsK5U3eZftAKbwusjfYU?=
 =?us-ascii?Q?oKkLwIL6XrTyYIZAueWCtjNIpe7QqESHDDrYaNMDRxY0hkTEb8KDrg5DcPzO?=
 =?us-ascii?Q?fpr71czBFRTkHbKXa4p1jcf2CeGNh3xCruiJDNQD5AOZok9ViEdrgMJWLueA?=
 =?us-ascii?Q?ksxgj5VA1GqaaNzFDthR9y5P4M/hzEvpko5VMW3KrTtsnbDLyO88jC/H5ABn?=
 =?us-ascii?Q?c3mNwBdB4c66uY1IXaAEUw5pPQaII1n9OuNyMsZVaZRhSviXynOI/Kkr9l1G?=
 =?us-ascii?Q?TjYGRF7GgICW89kpB5/DUOE0UDt5GABe4i1nOuDxk+qzDOhyFrmWWmqdyfwD?=
 =?us-ascii?Q?YVkSYFiWLSEZ8tYsYv942CK0L6lw0nksyeEbO19VtTw313JRBHrmXYaBfg8W?=
 =?us-ascii?Q?91yM/cc+GfI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l4rSLt8mElAMZpojaaZHtqqvmGPeRi23NEagGMorUJLxZmtrRTky607OJ1o8?=
 =?us-ascii?Q?N05fGuhFZCl0xYJvgaYrWrhMIOWvJ9PHtIK/jieVJrhXO+4kqkUtT9lIqp2y?=
 =?us-ascii?Q?o1iJnsoeBjlYQDZrbgdEbP/KkMwEy+gBPxrxEIr2NAOP9VLev0DBKuB42pQ7?=
 =?us-ascii?Q?7k3VvXdGUQsOpavPTGMw7Jub1MgHIdCrt/5LboegC6pkpUCOZFTKbRBDb/HG?=
 =?us-ascii?Q?PEENkYoNPa5xwq32rdvcGiHo5GJLkKgytILuYrvhYDWWyC5Ofhp6AK4fSC9o?=
 =?us-ascii?Q?MDVczhluW47S5PUJ7f9DQdCaEKvkiiJQpBcWO/pYOv7WB3BLQQ5FvQYgF11d?=
 =?us-ascii?Q?OahVJdc/bAeabZLAUTclkGKN9s+t5+MFrIPdXip6LuQOJ4b/dE3hJswSgRv+?=
 =?us-ascii?Q?VpT5w5xF4MY2JalFbb0d/eaX9eLUbqQMS7y3jlLBwBz13NeXd092BwRovcgM?=
 =?us-ascii?Q?LjZn6zPlavJR+iiTRG68t3W4vm/ZzhXML1xWZuKhxiP5NAt3/qUx6EU1Ipjr?=
 =?us-ascii?Q?rogIBBQvckbIb7fFrGREfap+JYAEPOE8Y84k0YYPD9mEzsCMBp3kDZFnYfxC?=
 =?us-ascii?Q?2rwrdBUz+/2434BbPhKkdXeVz5zJ2/wiUBIObce5QoslByb9fn1tEriMmvlu?=
 =?us-ascii?Q?DT/CG7kHIx60JnHUpRO2I8Tv8RtkHAi1F/+ULeLGtBGmcavWGus6uAfhh71m?=
 =?us-ascii?Q?nu3kXR3+Lq3o+UEnyCt7xmgHkJDfykMEi41lX9eZB6KHsCKBj5CGr2JeDb0W?=
 =?us-ascii?Q?E/UvmJJgBFNBMz9gmDfe0AxMid4sbu5ytHPTMsGeCMmPfpcJ8TMeCnyelRsX?=
 =?us-ascii?Q?KnuZA3T2YUb2V1BwdP8O5C4omd/4uoK/Dyqy6kozfHDkftwvgSJMptWssTvE?=
 =?us-ascii?Q?J0IjJCtdabYZfBt3IxP/l9rheMRuAYc7mnJKa6u7ypxVlRxbWo2q2v4MlpZb?=
 =?us-ascii?Q?QbuGmhhu+0e2GpU/kYJopWAVoguPjv/PMyTarXc20UfhOGsyYHy7fYmoTsuO?=
 =?us-ascii?Q?mQFl6A1RDobVfeWKjAyukpJQBc2HtyKPW2UYyZ8YqxVC8CTa3TdBtKYpAsCM?=
 =?us-ascii?Q?zkGm+HgDBAM7Dn1UlfZS+qEILsXtYBT7P/JWwoFhYVyV376/6QD5f/+y5uHl?=
 =?us-ascii?Q?9QXv7nlDegSCsVs6Ve13TZfCetQHOZSA2gxLtPF8+dgFjkijxiJfi3sSsHqF?=
 =?us-ascii?Q?pF4j0xjdRk+B3EXR888hVmpCohO/TsYRC2fTvnyERmB1B19LgHXWk+noskrD?=
 =?us-ascii?Q?F5Rroge/3m8b4VmPuNfLwDoDYSegz02/xVUDvTC6UbU1rrWzSGTkdHVORBBB?=
 =?us-ascii?Q?UWN4nOLtE9oi1u0E2wkHOxFACP7XQmtaNN3jlf9WVXTlov0D8Nw8dKX2A1jV?=
 =?us-ascii?Q?sjeGofz3So3G54f1lTJjlYKlC9xCvsiB6sdNDfr/yxoknxFdlDpBJ1Bpluh5?=
 =?us-ascii?Q?GP4bCnsG+9mbgYJgLeb/akuHrKB5EBMIW4u7WaEU9i/764RhTUCr+eHG2Obz?=
 =?us-ascii?Q?sveKMqEJzh5KWUkn6mJR/YD3v7ASZU+jfxbBipsuCxVEaCzB7H4SvkG6IbBm?=
 =?us-ascii?Q?acPgoagwn5UIeyl3g5nXo/6c/aK4nwer9CKL4dT7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T/L9p8zqFoMDFdGnkjMcabS2ThBbEmxQzUFKMy6kt4VbkeJdeBXHUsncdURW5+JWJMkKBP/00FYtmcrSzHKtBiKctV1NW5Kmwt9RI8qbesEvftqSaFcO/TFr0ATJ676D/MfvioI4GVyaFrdqB15v6yZF9WrfObPQOyu8R91xwtvl1/ywbIOiYfrpAmXEV6vXl0O4MInVa/L1uarS01IMCBuDqrnsupkDzpOEcFQJ3Un+4YUD2q8gjHRTbYR366UdM4vnheSGKNBdVX8Y/dh0ViHT5BrFH2dyFrnNWcHEihek2gCHxL6WFE7RAW3aBLzwIS/ipDB0liMfV75MuXQmD6nBcYTdoGanNzIb+kr0uVyPw6O95f4DpqYZIOz/VtlRN5r7dU6pNgmZI1FXuFH3lknZ75rXA4mi4TI1ucMt5dpRxHlxP7g04cXmigWLiEi5aCfhVYxkmJ6W/kbYMoU6Sbhyuqz/YSvRIa76wpNSaAB6G4ErMjD1tVl+2rTFiwiQDfl4ZIrgq59+WPbzuQ4Zps5xktGT8PeN5pRX/Za3JCNKx6QlQ98OPMK01klkow3zNuH2zZ7pkc+3L9be8cVMMP2Il6vbERPg/vlrbh8fFGw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e69e978e-b288-4c4d-88f7-08dddc9e77da
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 08:25:33.3583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFzRTT7JtWptNjjwFN7SoG9pgHLOv20zl/RERZve22XAOUdN4X2cT0EumifCiKLAMZJkry9hU0C1WoUXCv8FoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4854
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508160084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA4MyBTYWx0ZWRfXw8VbVkNofbf4
 mrUsFrwusAkBF4p3pAKMV8N9yP1grGr8j0O+2pvT5A7ho+y4ms/k2hyGdvk7qUwStV/v33UEKhp
 lpukSnV30mF8YYCg2xolNbZ0GDg+2G9G/V8WEhOF5SExMXFUdBYEzr6jZE+PA4kqpXL/DcyPnKb
 24jM9kzoZjQfdD42tgJlB5AvUiCTRtkAintU1gKAQIR8xleXgSBH5l4tex9COMPFfl7X75yfa5B
 2hV/i3dV4I6JDb+YRP03AxJKqQ3lnBqLWmGYNhwNNJYUJgeC3UHH+4sFcciWK60LO4hBAifi0P0
 spcMVBOeZk95xdYsfYuYaS39eD4JRXZubS/khB5m7S/Hghr0t5wqLaP0CyVlKIcwLgvXsoFVc5j
 v2Gx42Ad1DeXN058ulWIQ0EIH4J2CJZuFgfr3VNBObqtg0UXauVlglmyeyBTbvOLeF1PMeh7
X-Proofpoint-ORIG-GUID: qsgK_Q56BCTE7kcnSzDpOUJvKWaCmmhG
X-Authority-Analysis: v=2.4 cv=arOyCTZV c=1 sm=1 tr=0 ts=68a04088 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8
 a=IeNN-m2dAAAA:8 a=qM0OLKiR_kgXb-OMCP8A:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12070
X-Proofpoint-GUID: qsgK_Q56BCTE7kcnSzDpOUJvKWaCmmhG

On Thu, Aug 14, 2025 at 07:16:42PM +0800, yangshiguang1011@163.com wrote:
> From: yangshiguang <yangshiguang@xiaomi.com>
> 
> From: yangshiguang <yangshiguang@xiaomi.com>
> 
> set_track_prepare() can incur lock recursion.
> The issue is that it is called from hrtimer_start_range_ns
> holding the per_cpu(hrtimer_bases)[n].lock, but when enabled
> CONFIG_DEBUG_OBJECTS_TIMERS, may wake up kswapd in set_track_prepare,
> and try to hold the per_cpu(hrtimer_bases)[n].lock.
> 
> So avoid waking up kswapd.The oops looks something like:

Hi yangshiguang, 

In the next revision, could you please elaborate the commit message
to reflect how this change avoids waking up kswapd?

> BUG: spinlock recursion on CPU#3, swapper/3/0
>  lock: 0xffffff8a4bf29c80, .magic: dead4ead, .owner: swapper/3/0, .owner_cpu: 3
> Hardware name: Qualcomm Technologies, Inc. Popsicle based on SM8850 (DT)
> Call trace:
> spin_bug+0x0
> _raw_spin_lock_irqsave+0x80
> hrtimer_try_to_cancel+0x94
> task_contending+0x10c
> enqueue_dl_entity+0x2a4
> dl_server_start+0x74
> enqueue_task_fair+0x568
> enqueue_task+0xac
> do_activate_task+0x14c
> ttwu_do_activate+0xcc
> try_to_wake_up+0x6c8
> default_wake_function+0x20
> autoremove_wake_function+0x1c
> __wake_up+0xac
> wakeup_kswapd+0x19c
> wake_all_kswapds+0x78
> __alloc_pages_slowpath+0x1ac
> __alloc_pages_noprof+0x298
> stack_depot_save_flags+0x6b0
> stack_depot_save+0x14
> set_track_prepare+0x5c
> ___slab_alloc+0xccc
> __kmalloc_cache_noprof+0x470
> __set_page_owner+0x2bc
> post_alloc_hook[jt]+0x1b8
> prep_new_page+0x28
> get_page_from_freelist+0x1edc
> __alloc_pages_noprof+0x13c
> alloc_slab_page+0x244
> allocate_slab+0x7c
> ___slab_alloc+0x8e8
> kmem_cache_alloc_noprof+0x450
> debug_objects_fill_pool+0x22c
> debug_object_activate+0x40
> enqueue_hrtimer[jt]+0xdc
> hrtimer_start_range_ns+0x5f8
> ...
> 
> Signed-off-by: yangshiguang <yangshiguang@xiaomi.com>
> Fixes: 5cf909c553e9 ("mm/slub: use stackdepot to save stack trace in objects")
> ---
> v1 -> v2:
>     propagate gfp flags to set_track_prepare()
> 
> [1] https://lore.kernel.org/all/20250801065121.876793-1-yangshiguang1011@163.com 
> ---
>  mm/slub.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 30003763d224..dba905bf1e03 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -962,19 +962,20 @@ static struct track *get_track(struct kmem_cache *s, void *object,
>  }
>  
>  #ifdef CONFIG_STACKDEPOT
> -static noinline depot_stack_handle_t set_track_prepare(void)
> +static noinline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
>  {
>  	depot_stack_handle_t handle;
>  	unsigned long entries[TRACK_ADDRS_COUNT];
>  	unsigned int nr_entries;
> +	gfp_flags &= GFP_NOWAIT;

Is there any reason to downgrade it to GFP_NOWAIT when the gfp flag allows
direct reclamation?

>  	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
> -	handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
> +	handle = stack_depot_save(entries, nr_entries, gfp_flags);
>  
>  	return handle;
>  }
>  #else
> -static inline depot_stack_handle_t set_track_prepare(void)
> +static inline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
>  {
>  	return 0;
>  }
> @@ -4422,7 +4423,7 @@ static noinline void free_to_partial_list(
>  	depot_stack_handle_t handle = 0;
>  
>  	if (s->flags & SLAB_STORE_USER)
> -		handle = set_track_prepare();
> +		handle = set_track_prepare(GFP_NOWAIT);

I don't think it is safe to use GFP_NOWAIT during free?

Let's say fill_pool() -> kmem_alloc_batch() fails to allocate an object
and then free_object_list() frees allocated objects,
set_track_prepare(GFP_NOWAIT) may wake up kswapd, and the same deadlock
you reported will occur.

So I think it should be __GFP_NOWARN?

-- 
Cheers,
Harry / Hyeonggon

