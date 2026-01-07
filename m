Return-Path: <stable+bounces-206087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00378CFBD68
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 04:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF2C63016353
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 03:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A4A24293C;
	Wed,  7 Jan 2026 03:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gt9uB/Zp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wAiEcib3"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199B021FF35
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 03:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767756413; cv=fail; b=KnwpI2ERSUcf8t9ahkoHHzVcWqrK2Ms/fN67bolFB8XRVqZCBEK9gW/Vjr9ohFFncaWEhy7jsuRIQIdxuOVdsDSdJX4+8I7xyYwzO9OM1+1GWPLldqequcWi4jQzbwDeX4DLQLRi5gWH6XePf+2KNCnV+O9CKM+xxtuiC6FR8T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767756413; c=relaxed/simple;
	bh=fUm39ZwR3Hvh0ql7UtoqS8iqUcRiRXNyr0f+6rma2pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=miXeOJhBg6wY/GU7eh36pqkRX7upW4Vhz6aqkdzBtsEjpEvyfGD3q83e7/OcEGzL27773alXcPt3IknSHolO+GS0r8TiEm0VAbnjM7N8aqQIwAWq82j2/9fKoJGL/q+b3XSTHecN5FYiMeBStYfN6IfZX5+I7S3Rf4MXcLWFwXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gt9uB/Zp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wAiEcib3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60735Jw61032455;
	Wed, 7 Jan 2026 03:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6cugDEmNIaozlH7vo/Vz2vb24sj7Ggb6PqCQztDvUYs=; b=
	gt9uB/ZpbHM4o0OaILliGcYz0fg8o5iaWyPkStNlZE3axwrFS4s3Z0jnVNvPso7c
	GjlmFRfmNJasgd+Yb4aoDJaZ5ZckAQGqapbVEAI9LWJQWZhG3N1YETnJXZXpHHwQ
	LvdrPsLZFD+SMX99ZmUbe8+3iOfM7XbeezAFNoqt91A45fiz3smOJRyNTQAZtRYA
	XSpExCYy/SgnWNPqUaca9HPg7+U6LwkBWSxL+D/0OLsyi1wRA7E9xCG1dcGfBhGM
	ClgUmILDLevJeBDpRfO0/RhJdal9TQ8M+lkhpfI+Y+p5c2FXqf9oeLrKLqlOhmcY
	8+p99iDVHxBw7m415anIEA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bhf93r0g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 03:26:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6072bKde026342;
	Wed, 7 Jan 2026 03:26:10 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012063.outbound.protection.outlook.com [40.107.200.63])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjkm6qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 03:26:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oI251H5ucsX9wR5rM7SwYMeJ4eVNt+r5vagYq82fAao69dKopLfvV09XYsxoSVwW+cy384haJhWAc+BjF5DRnbkBjNhVpDDknLdvygxaVivvj2NDI6CvqaqMansyc13c1rVVW9CYBxZdj1VOSRDMflIFvWMaNhYzQFyoTziHYJe1HCr4uzEMqOeoL7Bh64zmW4sAtB/tuCqyqwARF2yosIRs2sHFehTO5Hqq536bSkgDhy0MS/KfDVTo4pztqDBWv6/RRD7k30ujyv4vO07orAIHajuJqG+ITEtklM1SvK0S2ppfyFt0b8uoAcZ1GOKgaEbOQBxpL3ftU85yAEYv5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cugDEmNIaozlH7vo/Vz2vb24sj7Ggb6PqCQztDvUYs=;
 b=s+72MqhrgL774xkZgF8bFY/+el1pd+iZE83PdE9A2HXX0EbWNOn40HIZhiloHW3tqvafwmDwhfZEIVPilfvCK6gYdrLEw1Grf/xGwxKLIqJ9JdcIZ7y7IlUUzR5r7HSlPoxOdkIS7JiQVSyvGzsaFewya6ZlVQBwiEJZLWlS+qIkjfVfOZT0YGVXbpteZsFyNyDT/E1Af3KjBFcdiNkbGXWf2uxqKH5hdJceGVCpMF/ZcigYArd/ecFlWKbJleal5U7SaNghPkw2nngCGTwy2keOOA4ggEJoxjF3XM0LeygdiItan6delUj/BoyuQ85bUF+yh0njEkkVWMBcYfHOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cugDEmNIaozlH7vo/Vz2vb24sj7Ggb6PqCQztDvUYs=;
 b=wAiEcib3jdXhRzdRZl4fU4OQ3Vx9mHr7xaziAuDySe7ZtoOZuD9Sh2mmUcF1H/DBvfkAzcr59+X5AxkySeXxc2cfC22+0oYgJpODkfC2F7H0Q+9lim5hIW5bg1BVhVFwnaE+aRtBYFMIRDBvLZ8DczNB12badJIMTMoiScOjEbM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BY5PR10MB4116.namprd10.prod.outlook.com (2603:10b6:a03:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 03:26:07 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 03:26:07 +0000
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
Subject: [PATCH V2 5.4.y 1/2] mm/mprotect: use long for page accountings and retval
Date: Wed,  7 Jan 2026 12:25:58 +0900
Message-ID: <20260107032559.589977-2-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107032559.589977-1-harry.yoo@oracle.com>
References: <20260107032559.589977-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0188.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BY5PR10MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: b9683486-8e67-455a-aa97-08de4d9c7ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UJNq/fqcVdLaaC8BVMiwfXD+ddoEPZKiMFZobLYltx6KkTWt9wUAJx2gbg7m?=
 =?us-ascii?Q?FYoZzsXgPMiUj5unRMLPM1OrWimBGglf5dLIcXXo9kBsT2FOFu9SwfnoonRa?=
 =?us-ascii?Q?1YZdJDRUar3FPJxZo+ciJbis6dlKkYHuB+FV2eSr0WcwLGq2vzf/+YqmzlX7?=
 =?us-ascii?Q?J5EWD0dILBGZqT0kBh3oLnIRyxb+2k/AkzApJZjN8K6f4SOzyVaQyvKFsHym?=
 =?us-ascii?Q?Rtz9BDYsnZ6kP+PyI6iM+7sAruJ1AucTyWXRbXhudtlsMh4CMxOPvgABikJE?=
 =?us-ascii?Q?FKuRGXe7FSBp77AJGwn9fnGXiIW++7wNR8a/S1WvuxEEhgsoRdj4/I+2X1R8?=
 =?us-ascii?Q?btsDCpNwfDOSsAVXnkuTEhc6o+g6Yp7qImlphajzsu68Wp/0FdkISNBVKWmk?=
 =?us-ascii?Q?RnAVl+4OBd6ZxwFLqulgBQHOnB4SCMRPh6bmOijDpFWVLyIVYtsuKrisAL2m?=
 =?us-ascii?Q?Tx1BWehsmzubLjyVbp3oivcMcAYTt5FiWMpWJuAFMQEAqGbGOSE0ESxjrWTZ?=
 =?us-ascii?Q?+vopYm5kekVPRLsmDAqLt3RisGBY5CoEuYYZTTwF+gc6TTyFpiazOAKrIT7y?=
 =?us-ascii?Q?o7zhloJKuWhRF+jowYZ30y87cxp9oNEvE6M03EKF0dCXGLFtsMhc1bdjvfRK?=
 =?us-ascii?Q?EijtP0QLYQWuakZmtAHlg/j+sCh/ymOMnfaGK1DxJfm6tKDr/xfd2aL7Av24?=
 =?us-ascii?Q?OYKgmwqzgd1CtYc5a6yQ1ldZYyFWAjrCU9ytNIb0mIOpT08s7Rz6aG0hz6rt?=
 =?us-ascii?Q?gjsHiOESRORRWu1MK6+MJbQwP4sZtQ6mvue5QQbBZyt0TlBpVzqzhxO39El7?=
 =?us-ascii?Q?8npsR9UQWV7FIky+YSz5I24nbgDzov7XBYg2rFj4wQyYI8v7m26tVEe4t77x?=
 =?us-ascii?Q?bBc5jkydoSkroonDtas7d9JHF7fGUFFdnp8s9HF0SikGeGZER1WII6iGm0Av?=
 =?us-ascii?Q?+qH058BUmfHQKwz7jVXMzeOZ5N4c8apG7ZMSq9alFWJ6TCtC4zSgz0TIMIyV?=
 =?us-ascii?Q?jAiWHXDsq2SVtfZBjgtHXUzblaG/Pob4nibSp6TRHbtdpL8tR3ZC7do5xBDj?=
 =?us-ascii?Q?6er+TPSsqNRKGYWrJkhjKbz/TcFDYy+lQ2UB9prZqb4940owkXerzHtBBuMP?=
 =?us-ascii?Q?PQ9+8PVA+SCBYyfHwwCSygVtkEdIgKkRMTWaJaN1UqIZM+mEc+Y4TzJxt/Vn?=
 =?us-ascii?Q?k+AWTMiUIBqVTRlKULVDNFbmtIud9ty6ZgUre94VW+eJmZU4olz5Ig3CQ9dw?=
 =?us-ascii?Q?2MXm7/nfE6Or+sfAZNgtBp7P2TJB4PbHIXCwJ13ldHjOsPUegJPZIfGKbmn0?=
 =?us-ascii?Q?ltheIfKmmzTeSPiBwTsQ7A946IdAP1PHTgojsVt2gFKDYo2J2pNSDcZg7ZNq?=
 =?us-ascii?Q?MDY0e5D4GaNG+4ax7KD/ftpxPGLjMj3e5OAy/YEFlliahm1D/rNNebzN03ju?=
 =?us-ascii?Q?Cy/Ut3Fp8fXvxTIa+WsBuZHSH/Dvpd9K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3/yhjl/loUAR8isykQp9GEO/wQcsONYvc+MGUg3iA60tE7CJhyBW/Een6Iuh?=
 =?us-ascii?Q?Xl+NZVbIR1Y0zUVvat+rMhvr/1UkuIQ1x2ukqXPP/HffQ71KVlJ5iirAR+2s?=
 =?us-ascii?Q?UdR7B0m+Df+tmna/rtVsxnY3NSkYjjpnKpwuzE+cOoakyiwbhQGy2hlQE6sR?=
 =?us-ascii?Q?iU5f1NYQ8ybAbbAunH9Wrp/xb6EtNR2GRdTTFoqUmQgN3d3O6vTGMhdlhpGH?=
 =?us-ascii?Q?LTVhM7SMWl9g4qFZPB/lAurkTX3z1DNJzf0PDNbnPu/EC10mIF3Rf5u2Nrm2?=
 =?us-ascii?Q?Jf6i2oM2KP32W0pQ+OkodbrvyPWVcNpl/ORGe8vOPFfF9KU+kkpyeh8z77xG?=
 =?us-ascii?Q?pBQuGbdNipxCRKmQmnDsXqCaJ/xERjygwkBtelG1yC+hXprJPyJ3Qx7+3iZ/?=
 =?us-ascii?Q?gueICrX6sItjVEwkYmfQMArkd3WT0YDVZlA25s0aeMlJnmH/UtYCw4PJGQ2o?=
 =?us-ascii?Q?eFwd3ZPKOw/wIOWqn8XMiQfQAAB7wk7NA42BXOGsZGPX9b23MheSSIFXtzx9?=
 =?us-ascii?Q?EOn/UryTjyo+tfHK6rCYLmZ1B1JMlukL17Jd6//F/DfQGgLnnhsNbNUlAPEP?=
 =?us-ascii?Q?K5HtQ9mfrG6oHqrkLgVUHNA4RoOQFd7UiOcmnXnF/MkdJExy32XHe1epzhx3?=
 =?us-ascii?Q?kFSFKXmFFE1+963HujYQGQUvyj3K75rZ1mPLgnfzYoY8KxvQAkqeEMfbRv20?=
 =?us-ascii?Q?OxqeDy4sTAQdG/IDyUGNTVSu7WRokfgtw/tFT8+VPeGdoYBVOkrSX1UN+6xv?=
 =?us-ascii?Q?fub1qK2ux3BrLXhBywvdnx4IIjVQlIq/Kuy2h4Z7woZkB8kFHco9WUDpdsJp?=
 =?us-ascii?Q?AISHRISlmQL5UtPJscFfIQBzd3ch4pE6pSyfmbUApuDY9a7eh9xIElsSwncE?=
 =?us-ascii?Q?LZmomAmlVqq9xbTRzgi1aLs/nE3QPp5TK9nJWoW2X2QDpodrPNSOB8PLpyFx?=
 =?us-ascii?Q?7EcwzMxe+hr01JFo1nsrJZBS5oIglDwHqZGmAujsLtbYNqPic7k/HPo4Kt/2?=
 =?us-ascii?Q?5jV/k+hzjOU2MBNslm9cq7+ks2S56qbEb7KdMPEuG2bAtMsyNvbqeC/5gM5e?=
 =?us-ascii?Q?iXZrJu0dtEVa7JjG070NRo3Zbd9Ys3+ztkdacb0mYDFs22hwNWPnzF3TPTHb?=
 =?us-ascii?Q?3JkDMFvcrSFe/VkXIcEBfjwnNeClZBvJbrDYFq812yILygZa1z+hbGi6fjt5?=
 =?us-ascii?Q?cwYcJ866oPYVDUwFjb4Ogoo85WHkx8NpcL0jI3IUUI8ACVS5BndpEETKdo+B?=
 =?us-ascii?Q?buCAca7Myhf7Fj9tiDyx/4JKA6aT36qAuDV29A+4HV4iqFHJjmGcN7yx+zY2?=
 =?us-ascii?Q?kz00EgKs3hNKfRjr1WIXkGgxPvPfnKhDdWHR/S9JHD0y7CHqT0LlH6Yo8KsH?=
 =?us-ascii?Q?XwURa19h7ixE66HwILgrp8F9pBrycLuXnfHmKxbt8ADM1cGt2SmpAVU8Sk43?=
 =?us-ascii?Q?Ll8uXYE3zR5CT21wFr2LSqo40GpVV3b4xnjWYgZAHitz6tH/sA4rHmpFOhUb?=
 =?us-ascii?Q?xTjA9a/IGvga71NBi1sGDHEwXXJW8mM/IL5mTfVXFPQndr8YoHW+lJOB0krZ?=
 =?us-ascii?Q?yVxdkVnot9jwRjqZ9KmObTSQQf4Ike2EL8DQ/iPiivhUoPJ7soSU82biECl3?=
 =?us-ascii?Q?+te/3zM+iFbmNZJmh9DSmIBpsdyfTfbwOt439bpX/rHBagkdCYZcOlVUVx98?=
 =?us-ascii?Q?KDDqPR9iWqvyQAtX0+9pyQvL+007/iI5wp6i5FdjJh62njgYfr5YqnUW5x/W?=
 =?us-ascii?Q?oL8i/HYVdQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GUbBWUvD64la0oVAjPMjcyqVIes4qUZIXqPKwBjl+iPZU6d9gHE6s+FA1VE0I4PcsRV7dFisffGhTBe6FGWP7koNWuyDVcNSSbJG6+BMTZ03odzmdk3KvFRCOiNEOF32DTvSfPG5oJPckWpZDYkBJhvAUQRaQ2t6V0SXRpin4v5wIi65k6ZBAQR8tvHOcMhNk+PojSEQJ6SUD68sEn1SyLinzAUCriTa/ZaHmbgv031Lt+12Mx1Jsz7Xs4SdRNaxaS40IzWc50tsqqsjpy3NGSnvAZgp+BR+pgu3C4NdDv6xFuZ5KsfPO5fPsJG+0UOUl7RlYMtbIbg9Ko5OeUbiNkDVMDpjkueJw7d/g+6a27TiyaYqrqtx08aVEP+nfN2ht3wArj9tykoB/iKQnRzYgV30Lvwusl0IAQEw3XVgCg8jRWsXBpACUH6E5E1sBCHuEt31d3U+/dH2uLBg8ZJPJ1ZEiR3jGK7v3T26dWBNY2FxOI6OZMl0tPqvwgIy/EZ7qSS0bOOZKkcC9GkBtuJ9E5DLPx9iuhw/lTeDlUDVdzspCT7UFwIEClPVWVaQsRQbXsZaN/VMCE/+5GqdXTXYEdIbZuclweGWtmNtGUed4yQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9683486-8e67-455a-aa97-08de4d9c7ecb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 03:26:07.1778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTnO40jzCIHMJqAmsRD18T4hwvNBgrLt15tBrNIAfSI/iM50rBBNYXnxk9Ps5SQAX88cyQPl0ZjqhgTsTHbK0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601070025
X-Proofpoint-GUID: yrBRu9gg7vtquqOip8iw6KQXxJgcQg5-
X-Proofpoint-ORIG-GUID: yrBRu9gg7vtquqOip8iw6KQXxJgcQg5-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDAyNiBTYWx0ZWRfX+sDbJGknkVjp
 UHAGOkmKSFg5X72EConsWJebcOAJqq3pGO76LTkrSyomdBt7xlX9/sXHlWjOI5FcjABxGa/PZ82
 u6g/Br6Q0NLg77u5cCz7PygFpuUp4TqpZ6Sw4EIFqJG60nHZ1j0qxvM5WIotKFDAWOevUyORKEZ
 oaAjN4PLktQosbbTsIgRu2gE5NYgUHBupKFGUp/8lYueEIyRMsmqzntlkecDlh01/K/nwEA2+Ou
 UNA+nlqM9/9CtvfWiIHvbcu4ok1Zg8phjhDaxqGyi8Ul93YyG8aFQBx2cwzUcRlGia32TGAvsvf
 Zux0LdbRhn46GZIjuzv4CEB/NW1GDrkCCzYiK7DIYS/3HuRZO47Sih+xYCMc+LmY/Nf92/ms5G0
 yz7XWJZfukHbHgZlqB25hn5hFN4fXfCf4eQu2m4ARCWsTpSJ+YKnMfEsgme6tODl2eXjeQXnmgW
 t5+I1JMes5yfkK8en47848NJdFWVlhWpt6CbLcjs=
X-Authority-Analysis: v=2.4 cv=VYn6/Vp9 c=1 sm=1 tr=0 ts=695dd253 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=968KyxNXAAAA:8 a=pGLkceISAAAA:8
 a=Z4Rwk6OoAAAA:8 a=yhwE2cpgGALx-dzfzvsA:9 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf
 awl=host:12110

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
index 311dd8e921826..e94ac3f6d9ba4 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -137,7 +137,7 @@ struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
 
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
-unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot);
 
 bool is_hugetlb_entry_migration(pte_t pte);
@@ -195,7 +195,7 @@ static inline bool isolate_huge_page(struct page *page, struct list_head *list)
 #define putback_active_hugepage(p)	do {} while (0)
 #define move_hugetlb_state(old, new, reason)	do {} while (0)
 
-static inline unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+static inline long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot)
 {
 	return 0;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index be8c793233d39..b4b4b89dcfe90 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1657,7 +1657,7 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
 		bool need_rmap_locks);
-extern unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
+extern long change_protection(struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end, pgprot_t newprot,
 			      int dirty_accountable, int prot_numa);
 extern int mprotect_fixup(struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e83563b9ab32b..fe24be944e585 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4635,7 +4635,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 #define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
 #endif
 
-unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot)
 {
 	struct mm_struct *mm = vma->vm_mm;
@@ -4643,7 +4643,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0;
+	long pages = 0;
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2bf4ab7b2713d..576b48984928a 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -595,7 +595,7 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 unsigned long change_prot_numa(struct vm_area_struct *vma,
 			unsigned long addr, unsigned long end)
 {
-	int nr_updated;
+	long nr_updated;
 
 	nr_updated = change_protection(vma, addr, end, PAGE_NONE, 0, 1);
 	if (nr_updated)
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 95dee88f782b6..f222c305cdc7c 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -35,13 +35,13 @@
 
 #include "internal.h"
 
-static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
+static long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
 		int dirty_accountable, int prot_numa)
 {
 	pte_t *pte, oldpte;
 	spinlock_t *ptl;
-	unsigned long pages = 0;
+	long pages = 0;
 	int target_node = NUMA_NO_NODE;
 
 	/*
@@ -186,13 +186,13 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 	return 0;
 }
 
-static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
+static inline long change_pmd_range(struct vm_area_struct *vma,
 		pud_t *pud, unsigned long addr, unsigned long end,
 		pgprot_t newprot, int dirty_accountable, int prot_numa)
 {
 	pmd_t *pmd;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 	unsigned long nr_huge_updates = 0;
 	struct mmu_notifier_range range;
 
@@ -200,7 +200,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		unsigned long this_pages;
+		long this_pages;
 
 		next = pmd_addr_end(addr, end);
 
@@ -258,13 +258,13 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-static inline unsigned long change_pud_range(struct vm_area_struct *vma,
+static inline long change_pud_range(struct vm_area_struct *vma,
 		p4d_t *p4d, unsigned long addr, unsigned long end,
 		pgprot_t newprot, int dirty_accountable, int prot_numa)
 {
 	pud_t *pud;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	pud = pud_offset(p4d, addr);
 	do {
@@ -278,13 +278,13 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
+static inline long change_p4d_range(struct vm_area_struct *vma,
 		pgd_t *pgd, unsigned long addr, unsigned long end,
 		pgprot_t newprot, int dirty_accountable, int prot_numa)
 {
 	p4d_t *p4d;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	p4d = p4d_offset(pgd, addr);
 	do {
@@ -298,7 +298,7 @@ static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-static unsigned long change_protection_range(struct vm_area_struct *vma,
+static long change_protection_range(struct vm_area_struct *vma,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
 		int dirty_accountable, int prot_numa)
 {
@@ -306,7 +306,7 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	pgd_t *pgd;
 	unsigned long next;
 	unsigned long start = addr;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset(mm, addr);
@@ -328,11 +328,11 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
+long change_protection(struct vm_area_struct *vma, unsigned long start,
 		       unsigned long end, pgprot_t newprot,
 		       int dirty_accountable, int prot_numa)
 {
-	unsigned long pages;
+	long pages;
 
 	if (is_vm_hugetlb_page(vma))
 		pages = hugetlb_change_protection(vma, start, end, newprot);
-- 
2.43.0


