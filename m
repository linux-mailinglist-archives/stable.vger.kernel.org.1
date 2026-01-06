Return-Path: <stable+bounces-205075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC76CF8232
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 12:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A14E300FD54
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 11:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D7A219A8E;
	Tue,  6 Jan 2026 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FFdEJ4Qf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qkit6wG4"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095362E3387
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700100; cv=fail; b=o944AEeSjxR5NcKplTY0X20pwsQ0/QkiFxCAwUt2ANFm9+2jPpZojAxIruL2oh1YCd3q8sSz7If7c5avjlIhTI0ZGj1APnuqOqWySYW0/tw1WWQPqjEp3ZchCv3E5/TZBf9JSy+vpvdZUn3QwPSx0SDQohGjYBDQnRcACfr/oEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700100; c=relaxed/simple;
	bh=Udd9ExDs5DVZ5F7mxj/qMt7s6Khresbt6Vq6piMLu50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GSn8xOEoA8Qy/IDqoP6H5rlGRYfNVqCcyJ/aobQyztdQd83zQq9xRzP95vsOD2qrFNYDhPFcwPVo4BhoGhPF1StsxY+llU2DoRiaB2Oh1aFOea/yldVIJ6OxkcB54oZuYEl4dew42ssrc6vHf2vNKemZ88J0iHKm42dPlfKMMTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FFdEJ4Qf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qkit6wG4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606ATFAL4091065;
	Tue, 6 Jan 2026 11:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1cJK+eHl+ygCbD7BP4sI7V3NSmqgoFYyF6gwjoosPVY=; b=
	FFdEJ4QfdCa8h4GNBj+T+UACwTlLWdvtdko7FabzYqGujtt9t6gGqil3aalX4tAr
	jwQBgItq/VNQlGmypAOG07gi5CU8+R/V0qCTOyFLT7+BltE0AVbOjRZmTTR1eVEY
	GzuHpRxg8Lc4O4DHRgyLx+hBaNHctg6Fu8MIRoJKR9j2GcaBIpN7bnwP4p6zQJ+8
	6iVfq1Po3+70i9/Jc2z8B7SKVXS+MG9pJ6uy5TVEHbfQ/NIuNUOSENNJ3d8i/kc/
	un9qZiclgxgBPT/L31tD3cuTFFycyq8Wc0YdVuNv71uEn8QlK2EnhSLL5OgCRVfk
	dFkbiP1qbAXZsgo+8l71+w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bh0pd82fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 11:47:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 606ADxbX034072;
	Tue, 6 Jan 2026 11:47:44 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj8fxk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 11:47:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obZ8LWczcSJM1hJ7BrkpaspfQxPd6/QOFydQhRkIKIaWNKB0lcPtAW42pI/deynvHij+s2GOpoVNWUyaJ1swR1yesDLTUUH3xOm6nLwKFurvxoqyyrZc+x/oeVN9ljaP9vc58QvTs+NBnmncFUcRfgLmv+uS8KPYDlwsFShQYtDGUfVTYvbK2ZOKNKkyBmgdlA3qb0UhFmr8wWtV+6qOE5WMrvDsLxZe3KmnFeW6dQzLVpLPqk5leCT+ymMzPjbrm7fSOYnXJkRwvEI9PEBtfJcaqXrfwqcsn6HuZybH1qqr5PNKiwV89BYv0yVXVCGs1KQNRu2DrWcAADM0vQROow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cJK+eHl+ygCbD7BP4sI7V3NSmqgoFYyF6gwjoosPVY=;
 b=nrapd9izifjBgxIGOzkc4dKxnPqQta5o4zaG/TKXsT1xwD5djMZzbX4bYDJ5BQugmR+bl7wnI3XIe6QjI+0RI+ex3tflRkCxLD0CUAkoYNGaQ61l6GMpp5D+KlAR7gDlR6y8R3k4hRsjz0WpjVOVVisONGzNXjZlyaVDRnofmFAkALMnGG9wA68rp6iP12krbHN3K+2z92t61na8yIsEOhEqJljTqzYmTjbgFFlPzBrzLjdDodqUi0JMsGBEv2wgsfy981amOiDOreXx2cIIYt2TxtFWq9Rj8TYRAJ2BWrgdT8A7UO7P8pTSlwlZpX0NXsl1CC8BtbE+w490sxiZtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cJK+eHl+ygCbD7BP4sI7V3NSmqgoFYyF6gwjoosPVY=;
 b=Qkit6wG4HPjYnbOiAxsca1URoSqW6Jl4YX2/b0ntW+MvnHPX4UNzP1oxmechJ8lDrm1ck+B3GdoFk4Ksu7imbeffXjdPQ36DC0xplNmfRyExgO4NCXXIGYmeB1akyRfAYeJTCod9lqwnWaWvpbCJvrNFjABOger+TFtCkMn9sdA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB4551.namprd10.prod.outlook.com (2603:10b6:510:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 11:47:40 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 11:47:40 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com,
        hughd@google.com, jane.chu@oracle.com, jannh@google.com,
        kas@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, npache@redhat.com, pfalcato@suse.de,
        ryan.roberts@arm.com, vbabka@suse.cz, ziy@nvidia.com,
        Peter Xu <peterx@redhat.com>, Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Nadav Amit <nadav.amit@gmail.com>, Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH V2 6.1.y 1/2] mm/mprotect: use long for page accountings and retval
Date: Tue,  6 Jan 2026 20:47:13 +0900
Message-ID: <20260106114715.80958-2-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114715.80958-1-harry.yoo@oracle.com>
References: <20260106114715.80958-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0165.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b37b46-929a-4e62-e3f4-08de4d1964f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yfKQMmAtzBcQhEIVymxj7BbXTn033tc2B9BD79R1XS+KzSMhNm0YhkY1T8yY?=
 =?us-ascii?Q?Xr3qA4BvFm2eIvlkeFZarn12cqIQfHhp8+hCoYFOt4WkQfwFYu8/NiHGcJmk?=
 =?us-ascii?Q?ZYmkX5+olJAIi/GGxTHo3RRxak4kvod+LSb+bHvoolBjXiNyWpGLZw0as+jc?=
 =?us-ascii?Q?5pp0iEP2CTxNLmSYIRW/JnhL6Mh3z/0+UjMhd2Jh/BOyEE6bIW//f41qXAYB?=
 =?us-ascii?Q?RIRHCdxxaSx8XMxUOrvzCVyqcjYDp09YN5Pjf+CBxKOXVbzvyswF9JIUiyBj?=
 =?us-ascii?Q?5xvhWhMO8bydt23nX3o2FwO8mfXi0Zhf7nIOXecYMxdjdhVsVbeNpe8tVcnW?=
 =?us-ascii?Q?jXtvOABsgeBZbjz1rJnCwKFZi43r7j3vwxZJKNuaSyF73X2RMb5fPHV4Ochr?=
 =?us-ascii?Q?Z612ulQWigL6ITuiFVba33xjf3aonOAz8KstHlwgInNIWt3fVevtttPHUgvx?=
 =?us-ascii?Q?Ze65/uHqhUmaVGToAeVktLaXVuWFldAeiKFrcyCmgXd237T+Po6oblCS+f1E?=
 =?us-ascii?Q?tvUjx0bqS0C53TBzZuS/IeKMUsHrP4XNLY0j7Fq/sodZP5bOceteBYJOcCJY?=
 =?us-ascii?Q?38TVleSMzdKyQoZL7uI9cSY1f0Z0T0r1KiThY36ENsIOxnZYLXpHJZ8ePtA/?=
 =?us-ascii?Q?Y/MbmpwG4asaRmGrb9GxFd0OJL8NC5z05VekY50dwPUBQafIWqMSGnCnMI5e?=
 =?us-ascii?Q?FHkRtg7+lCsZV5WlHeUgXao6Gjgbh4jFxC5CgMbXmRe9KYhJJqC54gtgrDOv?=
 =?us-ascii?Q?kcwzNAkieBEDc3u8IcDh09yv7SY9HByBqJfPENQ+ohCP36J/q86d/5I2fDlR?=
 =?us-ascii?Q?O0Fl018Li95jUJNvYRlhs8hFzG/f7+sWC6HGQFQDthZ+Ql6Bs/hrJM3jn/74?=
 =?us-ascii?Q?r2TC+/dAzfIvSkpKHKexg10isQcxCvVSMszUfnEMvjZLZsuEhVkT0hjn/O/A?=
 =?us-ascii?Q?wtjb3Wpr8lusd7weVXBbP40iajxqvEIBXJ/VYr3eTkvQiFoj/h8Y5ul4i1T3?=
 =?us-ascii?Q?Czl0x3hZYyzaG75U54hJqEUWQfj8NkfweFMP2y+5GMG1OBeGA6FbvuvaUzCa?=
 =?us-ascii?Q?c1FAclFvK+oyyot2xRYQckbhyj/tSPxVMRg32yZAm42H9OAB2x9YAjDvh3fo?=
 =?us-ascii?Q?cMY6MheSa5fDgY5AXnOod5eV2wQNSNIt5Uf2PkbbBBQXtKmuuUCBDWZxdNIi?=
 =?us-ascii?Q?LY2kl3CboD0cYRFPoutjmvB1K4Sxx9PKXRfclNjlXUbvBQ3fXh9GqlCFlicQ?=
 =?us-ascii?Q?SKovkH55GRXuthf33g7Zpy8Dt/Os9G3FTHO1L2FacApXfgVeA/OOlwK7KJQ+?=
 =?us-ascii?Q?QUMcsFZBVgDCq9AvWMM02//hbN5fddrlju5YIgDdPY0vk0glDPBqOC+l8e+9?=
 =?us-ascii?Q?aJ1wY4LcxRu1lIcnEPvaUgqFAGy2vYd1X0PtcG9vB0p0pwYIo67r/T3qrQhO?=
 =?us-ascii?Q?TwaZesrEEmvKP9Sziz3bxLh1HsmVJ3pQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hX6pvG6+NpB4jzlxWuUbr7oQXmh9hnBeGEqb1SyPCS3EOts16sVjksJPQ2R0?=
 =?us-ascii?Q?DGSkq5gce7bQnr2AJ3xvHut7OqfwECWkWyhfTw2wYqwh9OCQ2tVjCK4ZKwMk?=
 =?us-ascii?Q?AhWVCrmev6S45SlU61bn2WqoGkleAI/3WLSL3gxIOkMv7X6GwvtVWuGKCi0H?=
 =?us-ascii?Q?WwOWbPo8W6jsGzrMV9vXWdgatvNJbUSlYp0Wch6J2qTBBUQZVPa5aJFESq8O?=
 =?us-ascii?Q?2jS45OF0A5igPtlksquXlOLfx4qfFYFrUBKmvBVz2uBc0loYBLP4SRPA7wV7?=
 =?us-ascii?Q?kJQkm/Am/WqBCdgCV+mrytljJOc80i6f1XTPRdRCU4SSXLiny5SmiIEthcIb?=
 =?us-ascii?Q?3lnjI25PgfXnPAo9SEBZhz6TtIejN4IhVv3pwKzNX4z43iqGFx/Z2F0ibXh2?=
 =?us-ascii?Q?qRXlssoiTdeXrkwYQuaYgbG3Q2OcHBbGdrAaJHFcVqTkijJuoKAcPBFk5Xtq?=
 =?us-ascii?Q?VXDDLpNnnwF5tMW64BZa1UHM3nNQun0lNKdio2lRNVrnlDIIXk/TGuzbDAdb?=
 =?us-ascii?Q?bkInJUoEUQCSRZ9KwYLanRr7RKcjXm8GgMFKPc4YvnBk+txYIILeOGpz5kjN?=
 =?us-ascii?Q?TxwQUJPcU3955ctwSEmtvF5IsDlSexIH6nSIEyZ55wq76aL2c89FM9VHyWIu?=
 =?us-ascii?Q?exEiZ8ULk14dQKVa6O8SQivXfsNONQqJdQlzioP8hkCR5WlfNw3lYBBD1l9T?=
 =?us-ascii?Q?ypEJyXQPbNCu4PXOLQp8KmC1vjI4cVLKbdNLwjVMdTNRnIoC01X9u4sYCOA5?=
 =?us-ascii?Q?X4hhl4VqgLnHHwkrvy8bqgg/62xLukJC07+/4fFEbS4uWCe8dgANFpT6fCX6?=
 =?us-ascii?Q?4W0/0a6fM9YW4YDF/PKt16gR1pS0zALl52vQlowvdOSh2HlTqttKWI6GUgsq?=
 =?us-ascii?Q?33HAlW1yipnM6yLZmgEppVFhzalfCwYXANlMA3o+SY9SNZ98tBJhQ0p0DGEM?=
 =?us-ascii?Q?VA4Omc8tqgOtWtO54tu1nQaeBfoIZrWnYLoLh9P0gqFmD3UtD7tnMir1XtVy?=
 =?us-ascii?Q?K+AuxNKVDS1YzF4GFr3jvUJIJpNQ4EDtVfW8DzVy8jXmKNDEhk9Gxt/BUk4b?=
 =?us-ascii?Q?uTvQD3ZuPNHXQhH4T/erDMn2iMHUM+yMVoRrLlbJXhTfdzXfoHKXig4NuRf+?=
 =?us-ascii?Q?f24I62/jsj7uFaV1m37lOEhqWA/9P0n5XdSoJ5mXvUTQU6icsv/XTP3eObzF?=
 =?us-ascii?Q?nHrFZt8JTr6XmAob2O5xcSETehpCANOP+DRciinc4EFkwyiQ4XBADClnyu5c?=
 =?us-ascii?Q?3UVL8HNVmHba5mBM9MP0OtGjsz03bEDf/Yx12S7VGO6Vir2fZ7NTXDCGEmc2?=
 =?us-ascii?Q?9QbkSIstMNnqu3S7BFZs8BQ9LPdgbm1eOlIzpR6qmLu5r92Luc4yRrfWCV97?=
 =?us-ascii?Q?EA98hPlmjNmnrXNzR+uDilRqZ+jS5xyO6GgSkO0CnFX9PF98fEpGLzOTb4M/?=
 =?us-ascii?Q?63UGb5Gi7wBzTqSwZVLZZsBdMtZTaRHycKRh8o3whMIH7Vw/wYo+qsEldHbr?=
 =?us-ascii?Q?trWYIXyIGxCZo6jxS/KkSj2/Ob1gZC5VJI75D0Oe9eTrf8ZcmS1Tq3MknPG/?=
 =?us-ascii?Q?Mh75A1C/JDBEVNVY/Qwa66uOhWbQ8dHLT1QtX7RwN4dTos8Suxnc1cJXTsvp?=
 =?us-ascii?Q?PD5RNmeJ3eIdsTjC7No9+MG98fr7A2WyHmqQMBUPGmGyWGO2bW7iLBTlaLb+?=
 =?us-ascii?Q?XL+Y4H8fFOJ7aei5eS39mZ+WbRjNj9GdHtJEGVhVPFogtsqdmqKgAn5HWGTZ?=
 =?us-ascii?Q?JemAMV7CRw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qFHd3eXVT1mmkh5avGUrQQQVZc3yOeJedBpXooeaJ04Inle2spxqm9FUOPA4Dm29XaQN2nTDe2EYUonLHIgddzSLCUDX7XcN0CDf8a3FGmKUdWSHQwEgKtdjOMxtQwEEfWDRpwsrIZZNbHJRzp8kNaxitCEnQGNY4ARUXo0DFiiRI0MJW8HEO/QniY90ISw4p5W7p7krL27KovMa7xbhBpzVdUAqsTfoEktiZliiriEoGUdPhKHxBM3Bzmmtw6rBfuRUxWxC2bgerAV015nslNfcjlJLI3sYuUAw76Nju1Opax1OFcaa34xs0QyZwNLFbxj4m0imzHc1dhlWa8WAr8kd7ofdl5T+1mSoRs4NzFlFXxFTUMUmipqRdqbVxwD2kSNer3wveE5nJrUY5nce+vlHmPBiGTLxlia8Rp/mHUHF6Xc8GsYdSkS7y4/zeyKtqLoyUDAe0Jw4UqzzvQmNZvouCPXzds5SsPqAVIZHzNBfjLD7Ez9/F3TqWXI1Br9iyE/VY5Qz2er4Z2cv9SlQb/KZOYUsJcRNtdOmgmmVqGRjqeLgzRyLCybDlIan0yOKQvn5YpCzpDMDjctFg/HNuET3lHkZb6Rhp3CZoUJyGIU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b37b46-929a-4e62-e3f4-08de4d1964f1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 11:47:39.8036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRb6H9L9q2SHkCofZK/wm2ACnDeoOW615uOra3G25CfcDUqwO0zAtluCLOsAH07Xd/DVk0m4JlMaDpocEo++7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601060101
X-Authority-Analysis: v=2.4 cv=c5amgB9l c=1 sm=1 tr=0 ts=695cf661 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=968KyxNXAAAA:8 a=pGLkceISAAAA:8
 a=Z4Rwk6OoAAAA:8 a=bsZYzbwDObJwb2A-_GYA:9 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: PPYtOU1Np2X6z-5c9f7ynVE7DhRQSDUM
X-Proofpoint-ORIG-GUID: PPYtOU1Np2X6z-5c9f7ynVE7DhRQSDUM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwMiBTYWx0ZWRfX2jmP51D6aM0k
 Nsyno4X0UJ+BJPR3VBFyFHqwq6p2WQIJfq1cT/ryA6KY6PiCPah5LqKDMxgZ4NmDsfko/RCpocQ
 5we2w4EzGnTDtajiFM3CjS/HjsX5Jv2IQ9maQ3ZrwlztEmIqvDOH+geHlI1RFdppPKmABiU5oW4
 GtbD2y3Jwk2gxvFpcVmvZPHOdX0XCsCfpFQsjCpAbSeRz9Z3OlbxCcJW+U1ymBNgEl5HEXuss94
 aVDg+CCWjcv9ejAp8C6oP+WHR5r5f/k6scZJjcu9tI27E80wvVvS0YlxQiqAecZmIc/pZaoPVWH
 3ORLaHrnireBRtWvis8dNCiQUt9XwUppCgjfEHnmQa2lBMFHzXwAfo7qUK0t4Z3+2yI+ZozZs/c
 4eleFSXS9WZopAcGHfmsBR8lno/0KbwZ8Atv4dKqpOAAl+afBgUprzlqrSW9b9kdngLaU0cgA55
 GG6YAV3fP9PtgKYOJkA==

From: Peter Xu <peterx@redhat.com>

commit a79390f5d6a78647fd70856bd42b22d994de0ba2 upstream.

Switch to use type "long" for page accountings and retval across the whole
procedure of change_protection().

The change should have shrinked the possible maximum page number to be
half comparing to previous (ULONG_MAX / 2), but it shouldn't overflow on
any system either because the maximum possible pages touched by change
protection should be ULONG_MAX / PAGE_SIZE.

Two reasons to switch from "unsigned long" to "long":

  1. It suites better on count_vm_numa_events(), whose 2nd parameter takes
     a long type.

  2. It paves way for returning negative (error) values in the future.

Currently the only caller that consumes this retval is change_prot_numa(),
where the unsigned long was converted to an int.  Since at it, touching up
the numa code to also take a long, so it'll avoid any possible overflow
too during the int-size convertion.

Link: https://lkml.kernel.org/r/20230104225207.1066932-3-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: James Houghton <jthoughton@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Adjust context ]
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 include/linux/hugetlb.h |  4 ++--
 include/linux/mm.h      |  2 +-
 mm/hugetlb.c            |  4 ++--
 mm/mempolicy.c          |  2 +-
 mm/mprotect.c           | 26 +++++++++++++-------------
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 26f2947c399d0..1ddc2b1f96d58 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -233,7 +233,7 @@ void hugetlb_vma_lock_release(struct kref *kref);
 
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
-unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot,
 		unsigned long cp_flags);
 
@@ -447,7 +447,7 @@ static inline void move_hugetlb_state(struct page *oldpage,
 {
 }
 
-static inline unsigned long hugetlb_change_protection(
+static inline long hugetlb_change_protection(
 			struct vm_area_struct *vma, unsigned long address,
 			unsigned long end, pgprot_t newprot,
 			unsigned long cp_flags)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 44381ffaf34b8..f679f9007c823 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2148,7 +2148,7 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
 #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
 					    MM_CP_UFFD_WP_RESOLVE)
 
-extern unsigned long change_protection(struct mmu_gather *tlb,
+extern long change_protection(struct mmu_gather *tlb,
 			      struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end, pgprot_t newprot,
 			      unsigned long cp_flags);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 77c1ac7a05910..e7bac08071dea 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6668,7 +6668,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	return i ? i : err;
 }
 
-unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
 {
@@ -6677,7 +6677,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0, psize = huge_page_size(h);
+	long pages = 0, psize = huge_page_size(h);
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 	unsigned long last_addr_mask;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 399d8cb488138..97106305ce21e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -628,7 +628,7 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 			unsigned long addr, unsigned long end)
 {
 	struct mmu_gather tlb;
-	int nr_updated;
+	long nr_updated;
 
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 668bfaa6ed2ae..8216f4018ee75 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -72,13 +72,13 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
 	return true;
 }
 
-static unsigned long change_pte_range(struct mmu_gather *tlb,
+static long change_pte_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	pte_t *pte, oldpte;
 	spinlock_t *ptl;
-	unsigned long pages = 0;
+	long pages = 0;
 	int target_node = NUMA_NO_NODE;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
@@ -346,13 +346,13 @@ uffd_wp_protect_file(struct vm_area_struct *vma, unsigned long cp_flags)
 		}							\
 	} while (0)
 
-static inline unsigned long change_pmd_range(struct mmu_gather *tlb,
+static inline long change_pmd_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, pud_t *pud, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	pmd_t *pmd;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 	unsigned long nr_huge_updates = 0;
 	struct mmu_notifier_range range;
 
@@ -360,7 +360,7 @@ static inline unsigned long change_pmd_range(struct mmu_gather *tlb,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		unsigned long this_pages;
+		long this_pages;
 
 		next = pmd_addr_end(addr, end);
 
@@ -430,13 +430,13 @@ static inline unsigned long change_pmd_range(struct mmu_gather *tlb,
 	return pages;
 }
 
-static inline unsigned long change_pud_range(struct mmu_gather *tlb,
+static inline long change_pud_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, p4d_t *p4d, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	pud_t *pud;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	pud = pud_offset(p4d, addr);
 	do {
@@ -451,13 +451,13 @@ static inline unsigned long change_pud_range(struct mmu_gather *tlb,
 	return pages;
 }
 
-static inline unsigned long change_p4d_range(struct mmu_gather *tlb,
+static inline long change_p4d_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, pgd_t *pgd, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	p4d_t *p4d;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	p4d = p4d_offset(pgd, addr);
 	do {
@@ -472,14 +472,14 @@ static inline unsigned long change_p4d_range(struct mmu_gather *tlb,
 	return pages;
 }
 
-static unsigned long change_protection_range(struct mmu_gather *tlb,
+static long change_protection_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset(mm, addr);
@@ -498,12 +498,12 @@ static unsigned long change_protection_range(struct mmu_gather *tlb,
 	return pages;
 }
 
-unsigned long change_protection(struct mmu_gather *tlb,
+long change_protection(struct mmu_gather *tlb,
 		       struct vm_area_struct *vma, unsigned long start,
 		       unsigned long end, pgprot_t newprot,
 		       unsigned long cp_flags)
 {
-	unsigned long pages;
+	long pages;
 
 	BUG_ON((cp_flags & MM_CP_UFFD_WP_ALL) == MM_CP_UFFD_WP_ALL);
 
-- 
2.43.0


