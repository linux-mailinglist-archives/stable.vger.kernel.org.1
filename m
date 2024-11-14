Return-Path: <stable+bounces-93040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5F69C9176
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 19:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 194C7B295A4
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 17:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DB2185B6D;
	Thu, 14 Nov 2024 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OFrGQd1G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ytfC1J+E"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EDC183088
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605450; cv=fail; b=uhh6l7icvUsKLTINyFdhBE4XbwwIVVh+KNtsZqF/z/UKcCUnM3GuL9i+Ae3AT00I+EYJEotY60AQtf83u3SkrizDi9XZno71RMx/6X/irKU797knmch9xfsyMDmpytzcrhKXPaeAXhtMo59a2hOokTpVuTIIl8uOdtP29rbe+Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605450; c=relaxed/simple;
	bh=q7BDW44GBx11tHXHBa7ANo7LVTnepAk2mn8cvgVwNMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QUPrEikEhSz4Zoke9GWx13f96Q68UPZOdZ8yOI0NYt3GARykAGFXopvegXYpn2o9UExEZhfsc2Y4LGB75SWqUldUneX8ke8CO+3U9VMvi0wYYNUFc3faIHKKA2DGeq3NajpUer82bwvka2g/VUJzsyZ4pq4vuNrimgtKZOEHONE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OFrGQd1G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ytfC1J+E; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECt4v7007710;
	Thu, 14 Nov 2024 17:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fzS7/p0Vl9hng8Gjlv4GEP63bK1fN+InN4oXZqEHW9Q=; b=
	OFrGQd1G/I5qMMGe0fHX90F90YV+x0cAy8gVNVSbG/a9eO5RH7ZHZIjJKATBhHah
	tVB3wkZLSwIgrI4sTDoDqAi2jQLhugDw+g38rtFh8Ez9vsN0Rntp/3I8hJF9s+Ar
	qV9S66+KhTgDNViCEkunqYWio/lrfJxT2DlqlBF+Hq+m69hdtjfhB6m2A9Jo4ony
	syeiM7U8iMbXjZMlaaegouxWtSMnT69VdGIVPWr38FJYjI8gK0EzncoZO0ymswLA
	pScuXYulpbLPzsWSazUfYzDGMYCwqlJdd4ASVyRVZg3oEtaTw1QqaxVXaJ1Ix6QT
	VgwZiyD6bs1El70Zovaa4g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0nwst0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:30:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEGViOb000490;
	Thu, 14 Nov 2024 17:30:30 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbpagtwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:30:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtN1PMePwFmanifwl+dcliaHMc9PD6eChtyrEHZ/Ex+Lb4xs9vLwRq+aXhJ3JKYRtwPIWKYHa7WintfrYMRdo4EfUVX6TtO/KhLej4qJq/m5eC8rXvg9WURzKtBgzLbC/k0lC5AALNkiDb6FK3wep1WQ9gJInwMwYZOYZnmE1OAsVmSAVtDE8ddRrkQbtv3u7Fjck1yorGuM1dYW1Nj9I8kkGiAscB26ug1hi6/igT5eS0MGoMUfITn4qNhkVwR12eyPE3EvoXPzaBF9q2RKbbhzY1D5ZbRyhlqDe7nDAo6jC0nYeO+gdrm72lG3NLi07yQ4tHu+2WLX07jci5mTiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzS7/p0Vl9hng8Gjlv4GEP63bK1fN+InN4oXZqEHW9Q=;
 b=KIk0B8ty8Hk5hEYL9ZFZXTpt9aJpdpLfdMY1IwBlkV7SBrtS+7WKeQ7C+ggLxaxtfE3/WyW58FcowxbwcgFFOSxMVTteGafrCj20WUdOnwVp1itBAmOG1nAwJC/mWA8rQc0say+Axov+N6qE5ORidvL946vf/eIxsgKK4h7dYonPfGE795NxtCk56rfaolZEOXBVNwqw6wARBY0tyXlrCMUxFT8qLkO5SUpaE65NS8eEqjsBTH9T/cvOF91zVG363/BqsOwNs342tUWAF5ufAaN0rOG59cHGOxfTTET21jdLLhykneF7cqpQ5JDidQNkgl7TMkEcAd1Rbk1GdUSc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzS7/p0Vl9hng8Gjlv4GEP63bK1fN+InN4oXZqEHW9Q=;
 b=ytfC1J+EXIqO+m0hV6eDgoX+d2PX6bTz1xa1rRMGhrGUmSeHVa8WXakaR1DDVHkcr2gNowF1tRqJ4xoQqayYIogDD70aBLVaqe1lVgN3jl3GmAIufzLUyHCVi4WYFbnSoGE+S83kHf2iBZ671NXaO/gtHUw18oLxCUOu8ZqEZAo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB4694.namprd10.prod.outlook.com (2603:10b6:510:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 17:30:28 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 17:30:28 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andreas Larsson <andreas@gaisler.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, Peter Xu <peterx@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm: unconditionally close VMAs on error
Date: Thu, 14 Nov 2024 17:30:24 +0000
Message-ID: <20241114173024.731229-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111156-vascular-splashed-3ffc@gregkh>
References: <2024111156-vascular-splashed-3ffc@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0181.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB4694:EE_
X-MS-Office365-Filtering-Correlation-Id: 4802da70-a67e-420a-94ec-08dd04d207d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zg0TH3mPik/fu/c47c04mKzvD52TMQOYXfbDzq3+IFx1CkE0U0N6YO9iRLPa?=
 =?us-ascii?Q?de1y0XzAlRPIU0v0qF2LkQxNPV7BFSekhc+w3KFEzuiqt8mORdygUjXYHxoK?=
 =?us-ascii?Q?S7yOH5HJi1VtwJyyTtM+03w1wIAXqKKkUTzrKfBDk8MJg+VRSbeZLktKfV/t?=
 =?us-ascii?Q?+5KvvKD3hHliGa9MCBiquOQ4Pvo1NKdXfV91ynVs0wbHyguLAYc0V2tuDSbH?=
 =?us-ascii?Q?Fy7/HbjFki5mActc/pCOeerQNLWZxeU9aesH7ec5gkAEFV1Zv7S8NUcgxgK8?=
 =?us-ascii?Q?MaHw6QTjpsZWFLzdv5T0o2eZYpsMPCN/L9SYq8GjzgYK1tyo9OrMRAM70LBl?=
 =?us-ascii?Q?nNwtTs9nNYGE2j0O7e9n2xIhXPi9lT4FpjjIY1wUGBTNRJ6qjMsS5cHeuWU6?=
 =?us-ascii?Q?X8g4/C8maHLmEZiiPVuWEvAwkzDaObqxov2nlqUuPAFdFn0TH4nvE6ZQt754?=
 =?us-ascii?Q?63XB6GARU5ux2BtrvtErghOQwoltLJO+hV9Q+nX7kgPNZb+b8pgA8DZhWhMp?=
 =?us-ascii?Q?3KEFPrOvDGdpziK3VjdiLXqnX0/9NuwPU/gGBZof0A37ngCrxWvXqnwpKd6I?=
 =?us-ascii?Q?ARRhbUoZJ1VkrqKJAVRhONN/r8dn9JwJvQWYOkRMi45+nt+LgX7Vyu8c4aRs?=
 =?us-ascii?Q?N4rHKMNTu1U4x5uMSbcmMukktC9mPkiJWXKTshGAlzFZ2f0vApmlB/1tjMza?=
 =?us-ascii?Q?aj4IgTD2UYdtG2wsnn9ZcoeMvCoxrXdqAiWzp6qUBMBjeBAx010t2tiukN16?=
 =?us-ascii?Q?i0L1ZAjgapBm35NQkipI/po6sSY0Fy3bPwQ4KvudwmpyrhbT8DjpIFkM+NOz?=
 =?us-ascii?Q?+zrmnau8c69YpAmPB0ngUAjL9SuG/roHvtTL2ZkhqZcYRjRZnx3IOfgs0rlc?=
 =?us-ascii?Q?q9sS8kES5fji9enQL852iIusZXgj6CpSBKDTHE+mdR/ZZgTJolcTzWm3am8q?=
 =?us-ascii?Q?EC/Qbc7SN3pUqKC74aeoh0BHLVlKG5rB20V1ao9mDAVsfjvr5HOtQ7xx4dtA?=
 =?us-ascii?Q?BNSVotFvNjjVNJSoIQnoeB8++QQCdYrw82HTopsasjyEYuViaP8kBqz5wPX0?=
 =?us-ascii?Q?mkOjdz0sWQIqGnwxgAMiDV2NkK3OZX2nMpWrmW4LBsGSjEKF+h91+NJOo2fa?=
 =?us-ascii?Q?XiG9krNquW/xUVKEjxRv92/bfo0X9KXfV7onDsriLkNdoTbLah/ExRFgZ4lJ?=
 =?us-ascii?Q?BCyh95A19wJIXyHYrz+9MBCqpOr+2xYBoP8QGPT6YLcdoiMGM7abLoAc4ucy?=
 =?us-ascii?Q?H0n21+/1vpl0NpaO4mDhZS9q94HVfA/OdlhFG2tObMrFNpyb45nZMGAmzsPY?=
 =?us-ascii?Q?2EeWiqrdsUTTfFYjnz9OcSFj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MKmh8X6o2dOcI0vAGN0mlZxEfBhPiRBd5EPlcZhU/zz8z0s4+ygd293okX33?=
 =?us-ascii?Q?2M5vqDy66KezVhdyfetYgBCdUg1/nOfxxWzb55ioKCD9qWloL379j9E+oWBa?=
 =?us-ascii?Q?ALCpZic6bGSqViDZinFRwMKWsoGUNXhfEph2flMLYYL68idGuei/DtaLA7HV?=
 =?us-ascii?Q?8EKBYMfUUlcKB1p7vSZzGUpIVnRYRNbYZFBCxmmrqwXxOIDTJSHB0TIsz1vm?=
 =?us-ascii?Q?mSuYbX6J+guM1w8UPhUU4spgzXqDdFO1UgZPuRYXIbomCKRa7ePsVek/76B3?=
 =?us-ascii?Q?cXPsMahnJTjL4Rvv4A5GMH/NBbwHsq9LyHOjLGn/oUABlcEbI0Bur+cIZibs?=
 =?us-ascii?Q?6K89i3+J8B+DCvn70inIrIY3iCBJauXRH6JXPmuwzXt5ptAt1eW4FS0OqhMs?=
 =?us-ascii?Q?RQ6QVESHHXe+Sphp4j6GMD3UFYlP7Hdc1PT+GSm6mqSjE7a5DNfFk4HeItMk?=
 =?us-ascii?Q?lYp9RyOJo2d0Qu7yJ3PjD1MUNdRgDIJjzyspFJFBs+62q4md0B7BL7YAcj59?=
 =?us-ascii?Q?NghdUpBPYtJ4LIcQ/1VApVOWXnMuHhgCfyAAsyUdFtR9o78W1+aTFG4iMqMZ?=
 =?us-ascii?Q?FDR1N6s/U8UKug0TPNIacs4GVsDHdvUOT7gGy9uNCrdDxbRRhKGD6GzUVgIz?=
 =?us-ascii?Q?Ixbif569qzgEQKFJLctEMFO6uSwMO2FNYAVmdIYMl0x4tZIcOr0TJkRgSzzV?=
 =?us-ascii?Q?Y1GHek+vVUqB4+JDyuDXIItavSEZIXRwCVFRrRGIbRPv/NxZo19OOVYiFlq3?=
 =?us-ascii?Q?Tpc2phmb8WN3QWshkywwCN5QGRv39a/xozqb7HoFpukp8BhEAsVmUcX8jJJ3?=
 =?us-ascii?Q?Sp1u9w+eSn2hUtPXYZ25Cg9VrHEcG15AWDccZk8lu6Ju3iJMHeC7yynU3V5I?=
 =?us-ascii?Q?EOXf+e+h8ld6A7XcSv5QdJSzo7mWA0bSofUHk4PtNCtR5u7J529GsiNHRWOY?=
 =?us-ascii?Q?oFT84nPswpje9TZW3GwnaeN3nv7Pfo8YELxvsWW2Q3cyzL/v0lXjE6PiwlI9?=
 =?us-ascii?Q?gkF92N6NvWE2s/ZazwLSo1S0Eqpf6DRtxJ8Qc+D64UKXjQmrqbsd2kWgJeQN?=
 =?us-ascii?Q?bLyW1XA4v8Q8ds0wsri2KfWjVN/lL5vb2DxC/1pk3ZPFRV31OfK02KUQfmSL?=
 =?us-ascii?Q?5Ga1BDNruJxGZkyeFAxJM9YQFqT3FL8pH+xDoA9Zp6wItGEh0cy/2SFQmDB/?=
 =?us-ascii?Q?SHuGVFK4lUs0a+Q7M2h699+fsAqgGFfU1yioX5/y/ROZRC25YoN9D8K3VPq0?=
 =?us-ascii?Q?Mh8KiB/UtpUFZkc+P91Al+rVP/ooniMa5QJAQnH+ItOByT2FY1ytAOl/4iLP?=
 =?us-ascii?Q?Kk1m4RIsvLEnE9uSBHQBd8md7VNz7FVWBPLGYVu7yC3NRLV+LS9EZwnJDxmK?=
 =?us-ascii?Q?sd/V6LDNwkl7Pe//9+tF8pZWnWSHVDSGo5CrIJ3H0sVlcbtAxVOaOhbhC5qt?=
 =?us-ascii?Q?Nm1UPqU2g1WH4twa5ndL4kwNYgRzz33HOU4LzTWUlXrOk2SQUoZLDxleJdxu?=
 =?us-ascii?Q?Wgwd+dLrEnEwvn4TrNC4GoajacwkPg16oRaKsROjqAd576t7ATnFQAf0DsME?=
 =?us-ascii?Q?EhOvy+A6TBEwZr3+d3WfI2qRKV+o5hUdlbe8z2Fpgg6sLq8Kpf1IJE/tEK55?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dA5tcB5fUvgvvAhYpDAnVfWHjzIIEnqVlhy1fCpYGQykZKa+oXlv6rGRQnCuClEzyR39FKpIS9dNYMgo0JR++dqXLGlXXcKpdLTYztPUx7P15yYXgm5EgF3X/bb2UmJUDchptKOMMburM0pdB7o3HokXSLKWAQphpcQFG8N7riGrSMiYJ1QXJmqmTxKyIIKt2sHmui6atVDxE1ooPxexh0SyQYRfI19+nRkGPvOPw5vqR+u3ChiU9TG4EzfoeZXn1fivv3NUFAjP/prEfMqWR9dVN2e7DlBLE4rbZnjiM/sVL915ug4vOjEuRWc9X4sk/NpY16mWPpT2axeDUjatssoKu4+/ODZoAQpL7stT/hYz6w8rQt3SMQqmSDdiJQXpfNqvGxg6ygFsASjxsZlysikp0quD0eK5XjS2HlkcirGwfv+YV57eyryGA1LVzRN2n9XxOKH0n7qCnfsRE+kLyYKYX98WlJ3OlHVms2fNGoAYlBJoNW8078W14QD5LWfFSAlbCAXXGeY0VbUwnrz0bcmmUKk6MmY5d5XSxlaqo+RLj3eycY0+q+qxrP2CFwqEYAjcii0Ztrtszm+zJN8aw4WpvNjO8WuB2QdZggh2ZN8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4802da70-a67e-420a-94ec-08dd04d207d6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 17:30:27.9948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+Zs64cJti+HywqU3VauFi7N8+HwDUVXSTfTjsRzeoyfXlhQa/HS3g7a63HoQBNxkeEKp958JiDp0vG3WPAP5D0Ii/n5N5GlTlNERJlB5XY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140137
X-Proofpoint-GUID: T-oMVkiWglAqo1mcy4V83z3H1oA7XM95
X-Proofpoint-ORIG-GUID: T-oMVkiWglAqo1mcy4V83z3H1oA7XM95

Incorrect invocation of VMA callbacks when the VMA is no longer in a
consistent state is bug prone and risky to perform.

With regards to the important vm_ops->close() callback We have gone to
great lengths to try to track whether or not we ought to close VMAs.

Rather than doing so and risking making a mistake somewhere, instead
unconditionally close and reset vma->vm_ops to an empty dummy operations
set with a NULL .close operator.

We introduce a new function to do so - vma_close() - and simplify existing
vms logic which tracked whether we needed to close or not.

This simplifies the logic, avoids incorrect double-calling of the .close()
callback and allows us to update error paths to simply call vma_close()
unconditionally - making VMA closure idempotent.

Link: https://lkml.kernel.org/r/28e89dda96f68c505cb6f8e9fc9b57c3e9f74b42.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Jann Horn <jannh@google.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 4080ef1579b2413435413988d14ac8c68e4d42c8)
---
 mm/internal.h |  7 +++++++
 mm/mmap.c     |  9 +++------
 mm/nommu.c    |  3 +--
 mm/util.c     | 15 +++++++++++++++
 4 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 4670e97eb694..34b3a16aa01f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -46,6 +46,13 @@ void page_writeback_init(void);
  */
 int mmap_file(struct file *file, struct vm_area_struct *vma);
 
+/*
+ * If the VMA has a close hook then close it, and since closing it might leave
+ * it in an inconsistent state which makes the use of any hooks suspect, clear
+ * them down by installing dummy empty hooks.
+ */
+void vma_close(struct vm_area_struct *vma);
+
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
diff --git a/mm/mmap.c b/mm/mmap.c
index 11d023eab949..d19fdcf2aa26 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -180,8 +180,7 @@ static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
 	struct vm_area_struct *next = vma->vm_next;
 
 	might_sleep();
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
@@ -1877,8 +1876,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return addr;
 
 close_and_free_vma:
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 unmap_and_free_vma:
 	fput(vma->vm_file);
 	vma->vm_file = NULL;
@@ -2762,8 +2760,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 		return 0;
 
 	/* Clean everything up if vma_adjust failed. */
-	if (new->vm_ops && new->vm_ops->close)
-		new->vm_ops->close(new);
+	vma_close(new);
 	if (new->vm_file)
 		fput(new->vm_file);
 	unlink_anon_vmas(new);
diff --git a/mm/nommu.c b/mm/nommu.c
index 2515c98d4be1..084dd593913e 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -652,8 +652,7 @@ static void delete_vma_from_mm(struct vm_area_struct *vma)
  */
 static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	put_nommu_region(vma->vm_region);
diff --git a/mm/util.c b/mm/util.c
index f55d7be982de..af6c9bce8314 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1104,6 +1104,21 @@ int mmap_file(struct file *file, struct vm_area_struct *vma)
 	return err;
 }
 
+void vma_close(struct vm_area_struct *vma)
+{
+	static const struct vm_operations_struct dummy_vm_ops = {};
+
+	if (vma->vm_ops && vma->vm_ops->close) {
+		vma->vm_ops->close(vma);
+
+		/*
+		 * The mapping is in an inconsistent state, and no further hooks
+		 * may be invoked upon it.
+		 */
+		vma->vm_ops = &dummy_vm_ops;
+	}
+}
+
 #ifdef CONFIG_PRINTK
 /**
  * mem_dump_obj - Print available provenance information
-- 
2.47.0


