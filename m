Return-Path: <stable+bounces-93049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F15DF9C91BD
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 19:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7643D1F22785
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 18:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D6019597F;
	Thu, 14 Nov 2024 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i0YgyJC3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Uv74Gb5m"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7758A189F3C
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609387; cv=fail; b=G0KvpovUEuIumcHhwkxmlPPkVgYRrf/jqhYJxz4hNhjgRJ5KrkStc3XBXuL4jl8MRLNRUS9WRxGGgcAdBw1ldznDtunJtXWwKAF0QeERvd7rTVQoqst8uslCTg4t8FBrojGbST11wMQSDBPaQk5HvCDfGhpvl21aOl4PNNYC5TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609387; c=relaxed/simple;
	bh=vYxPphM60Fr97/xqWLr0Vpbl43PH43myHa8K6jIYp/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JRIy12O62PKBUFCphh7Tkm50H83F9neTaRN3Oq3P1a4ziy5yHD9/0S0/wYght2GZRHcODw0uMos7Tavle+brEu0yBZQoLGE5wJmY3q3Z83vVJaZi1KRov6P0zh77/p/CgoZc6IwdPHsyHX3Tp2Nlo4foPtDLzHyc2lz/96AbiNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i0YgyJC3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Uv74Gb5m; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEC0WTe001666;
	Thu, 14 Nov 2024 18:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XYkwluAzbm9kVum+7FWS+cG0HvAmoo7R79viNN/W8Vc=; b=
	i0YgyJC3v13uYaTG9b55eSZ0db6oM500oPp+V1AMut7eDSghQD3DFTYvfhe8XtSL
	sSWNveRzEoQArododQbJ42hN2OlvFBY089ey8QqpaGH8iDUCeHIwG7RNiiq7aeWJ
	bL1jlHEo18lXx/Uxo0Pk7T5XbTaq2ZYVvyIG2vBy5eVWUdXu2TFoQ8U9i+d0mgCd
	9yUACL0JEjleQDPDEIaZSTAXm9lc/KzOaPCVibMPxXdb4tEsyTAujARreQlHgHW4
	ExWS/xOY0vnpgUtz+sQNvqt2qvqKnleKtZk5b7rH1dF0/PkzevKqTcGz7B8KuphP
	epE/jM67I+0OO52aB+yxAA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbj10b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 18:36:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEHJrtc005728;
	Thu, 14 Nov 2024 18:36:17 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6bkevc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 18:36:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IeBsangGlAKSuXvFcQuxzjYO2TxHwa0DQ4YD/gh77Tp2bVZANW3+moOUupnre+/x+XTkJ7J9Ra/dHR5m+PpEY7um3pqxDZ19Tv+/ImFpZg4BkwY+kqNQ+5VwRu2UDgHWvP+SBjYoE63ZZ33kbWMqehvu2bNvLfP9AFZAhp2QmZ4rpnIlk2FM5+0D32TutUaY6zeTN4ot2D2BoNIvKSnO3iHbkTyOUaczNH3QM7mQ7KLKBkXmg1/QbeY1r6DDXf4+Qa7iaExCf6Vp75pQzPliTgsC5hNHCoqnVyHRCxW9z5KQjlb1gt7ZOikx6j8Uf8NpXTLAQk2fGcVnDhk7uykS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYkwluAzbm9kVum+7FWS+cG0HvAmoo7R79viNN/W8Vc=;
 b=uWS75pmG9GnRvWY27nIl4RuUTfnVemBh3xV82MjokEieYqgbwPjJFj26+yTUkIIUzw0QNd2oL0aUqYuN8vdRHppkYHfMAW4k5tfp5PuEJ/P+N34GHXGzVgR+4pAKUSvcRUXaEli7+sGumUn0wOHHJVAnCE3mRHjkcmqv+rdTzUBEAy4e6vYIyRJP+E1EaMrRQUVHZNEnT2lv4fyT1pXGkX1T+8ohqqhorh5vMAAyquycHMIsyVufLYI8e+QFw90c3fgv1XYhUNUNoPpG5oS1mNVLE/5+3833QUBQaUsfKaRBWcbjokIH80jtUt3hVRLdavdi+VowgXSHUhnMTAlmbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYkwluAzbm9kVum+7FWS+cG0HvAmoo7R79viNN/W8Vc=;
 b=Uv74Gb5mvPMHmdsL+S+AVe7bWUb20X3ZrdA+0uwq1hfpZL2Cr6AN8GhJY8Aiso2tIiXceAO4tA4aZEunILq/mUDLZ0XW8eQswqpNsfUHranU3xLZZppMXU7+KH4mUkemS9FfMrre5P3gQ8CPanbzM1ZxFZsjOgnpeW3nRUrIeEc=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5567.namprd10.prod.outlook.com (2603:10b6:a03:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 18:36:15 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 18:36:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, stable <stable@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 6.6.y] mm: unconditionally close VMAs on error
Date: Thu, 14 Nov 2024 18:36:11 +0000
Message-ID: <20241114183611.849132-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024111155-conical-subsidy-357a@gregkh>
References: <2024111155-conical-subsidy-357a@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0043.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: d462e123-8803-43cd-f334-08dd04db3869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?svtIit1E2lgCKxleNELh2DQ//pp0RQFuJ/LmjmqgrP3BTEdnABC/Hhl+IExH?=
 =?us-ascii?Q?xVEDfaJI/CJzcWiqXNE86YhxJJEsaL7rXbKwocg/yZedB7S9pM4PDSfOLJrJ?=
 =?us-ascii?Q?0sPcD2II/V9MU0fa+xrva2hXC3J7Ui/X1ww3ZH/4JXJ37P8dThJ/md2vWFgF?=
 =?us-ascii?Q?b8F3vf47k+SWemC/cA+9/pItNXj5RP8/oZyGzdGMQEApVzQq0W6YVuiGlnWR?=
 =?us-ascii?Q?di1hr15oFoi2vnEiNWp66ojdJ7ERPVhuQt4cPstgyoK1ezpwupqghJK29ucy?=
 =?us-ascii?Q?yOd26bGfPzIzuM1krG8ergF+dkt7KCqvbf5MZlimsQALLHVGKlXh3SWJNvR3?=
 =?us-ascii?Q?HifAXwVNSRKM9tv60YeXcM/lgO3jfueu+MM0hdvrSwPkKxi3Z1BwipoWo4qJ?=
 =?us-ascii?Q?4wuofEyffCbrmvNCAfdjVR3BqgXAk4uL+ib7ImTDclSLQTYxSpwPGGKuOd1P?=
 =?us-ascii?Q?AWa29dJIzwRGQm6OIVXNmdato8LUd7aSVAUXOcxeJ5PhLnu0a0fFzLIEJ4ZZ?=
 =?us-ascii?Q?GKLvxICEMu/IH0TioZ/T2uTHVHDlNtHRYDCSn1U0X5+YAJoc1bKJzGmgdTbg?=
 =?us-ascii?Q?XsHh2nh/slTbOfWCedcF1/UoFoZYK2dsw/GwxWnMMVdF4ggQTbffMwsNnqXP?=
 =?us-ascii?Q?nH3Pe6hdFB1Z7D2PcOnvo1CLjbXDVP9UxqYGk6tXuT5P0FR+oeTkr9SQ1VtN?=
 =?us-ascii?Q?SfuX1f5/gaJLc7gNsoA1Mbd1g2YFPMSTx+7cTsrWWufbKo6gzJOOAmXf0OoX?=
 =?us-ascii?Q?p8cAesBcZSzk4/R6btLlc9M8qI9xP6qEWg5rXsETM8G+FObzSPAst1HYO4BU?=
 =?us-ascii?Q?fYFeGkoTlQfvnP80VaUH0NBhw84u/Pfb9wdqoEKoAvAWGoSZBmtdx02qO7/f?=
 =?us-ascii?Q?XSkH5kT9Z2Tqvs1kvSqpuvmgf3iHqKMnANTRig8h70HoZ9f98eZF5SodWX+0?=
 =?us-ascii?Q?SjPaXD5jIRwvxEKj+wG7+nhlNbmElDhmBZAkDLbX6WIaycGMZsI8O5VkKV0i?=
 =?us-ascii?Q?Zxu+n0c/giwtrHPhBOhtw9wXU/vSsbWAESKRsNAAa8ZWEdEBx0eFDb8m6B/L?=
 =?us-ascii?Q?HsqtKIjuUfYDjxs4DBL1D5QkFTQexqdjL+9whj1hq8HIBttzMbXABQrTnAqG?=
 =?us-ascii?Q?93MXkcOioMXnVPhbB2fQYpau3gySfX2lvvJgDGwukJGKxmjcInupmZCmFYZ9?=
 =?us-ascii?Q?xGCRAAjgu8K6y3wpE1kZuRrA27DUTJZLPvF+hgA+J/xQj9PvpI9NHLzhd2pq?=
 =?us-ascii?Q?N49ydrgbQraH6ekDqIbKEHR4vT7YJqUD1WG9qv0Lls+PGaNAwrSS8enmW1o3?=
 =?us-ascii?Q?RIOV7aTCR0lkkWfPWnAtM/YY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RikvA4i1SVvaNxpduQjJQaflE937Agxn06LUqriMdFnatLGOZrjhFpH3EyYN?=
 =?us-ascii?Q?DZZVbqyTxN9HZt7ugvK1/SKQW5r17N+4ZJaI5aZ5MG6UneglMh2fggA/A6Q0?=
 =?us-ascii?Q?khsPfa9FkctFgcPy2zuf+UwHD7MJ2d14MkKEIQqqNvCpN4N1CScSJaKtXBAE?=
 =?us-ascii?Q?6LvL+HtXhAu550Rua3R8i3mZGYUptESmkEW+1u1Jeiu/XoQWmCyuIcCR2jBh?=
 =?us-ascii?Q?BP2sFVXK5DdkqMOZ+C65VY+Hasx3K8GWNUG05U+Mdz9In7PJr5AhbX9V9s5s?=
 =?us-ascii?Q?Wrb/pKkx1YyOQvlPGZus+a5S5GjeMerkY8tN56ome416f7+fMkBUtphfZBBf?=
 =?us-ascii?Q?JGpsACYc7VTfgxvH8MJ5m8g/nRiQBekEGSHGcLqLZFyW/wfXscvSHJdMRK3Z?=
 =?us-ascii?Q?4aly+8Fjz3GvtfSBJwpQ5nk4hPMQmC8MAoaRKayiqBoQWab7lpG8lVXfOrc8?=
 =?us-ascii?Q?XTPUuucBMF9JCmJY5FRzDyoJXxsa47uLAUNA1PPmw+RRFjE3eUGpCOVM29d6?=
 =?us-ascii?Q?OK42aAOlRF0rOKaTjv/vYhu7B0sqxRlVmZcaMXPpCLIJyjobX8Sxr/eg1k6h?=
 =?us-ascii?Q?C3ZTUzJIj2e8FIEsA4hJcBIEYMLzLnM/7N3XIhyCohhjeAksP4I5iD03czXc?=
 =?us-ascii?Q?erl3Z4dDKz4rMFO0kp/PUb562MJAXrwh18QLJQ8R/S3APUYb2OGVXDReEL+n?=
 =?us-ascii?Q?p90t3Bao8bL0Q4XAxxxkwuHOBq/eiHlmq07WSHUti8zurxTwNIizetqHYYX/?=
 =?us-ascii?Q?25OKrRMla2Xk8rkP93fKmgKxWA8BiSg88Vpqd97VDFvKVZs5A+Kjylz4ECj8?=
 =?us-ascii?Q?JMO7+CAoTvT6Tuk9rcw7oYPr03zCtXiXhsZjUrpJ5IzsF1KwRa0TcJYj7Eq0?=
 =?us-ascii?Q?4Vlw1XUjCNlwORqcKpEspRbg7S4yjYwpTbKEH+bLgFHZG+Tw8jqfRplociY/?=
 =?us-ascii?Q?zQ9mLm5dZHUcEz7N6whw+E8Ij+bowew9AYWzQbTn/Pt4eOt5euM5aAE0bMgz?=
 =?us-ascii?Q?rYGqeoIdMKYQCE7fyEye3SkFUw3R2vCBXmvACD+EFZxK6+KYiM2IG57Kffiq?=
 =?us-ascii?Q?Psica4KFtSYmRBMoHKhCfJp9RBQzU0KOG1yZggks7arJsLks6MFTWwsFYXvs?=
 =?us-ascii?Q?PyCdS68nacm10T3t34TXEv9yymzrvsDkGMkPUnOUBxbp8b8tRVgnLBM8K834?=
 =?us-ascii?Q?z4T3bx/zzrZSUmrIL4vA63l1tgZbaRjoTOSBeuCNIzrZ4DeTZlQg/835bqPx?=
 =?us-ascii?Q?4CjELJud9ryMKxP1o6ujOvz/iCmLPmAd6pmBm3suVzwYbMjd7wSLNEaX/bCF?=
 =?us-ascii?Q?mQB7BLxS156swCsr6j9jR5pB2umH4nIP6Ju9RvFgxkZ54peHrgPPnah/g2YR?=
 =?us-ascii?Q?39cZUC0UfQFt4peEjwj51uc4Ln6AMTJdVsXlLjrSCWdTa+mNLByapT4OtX7C?=
 =?us-ascii?Q?2uAAg7zwcjOmJbIy/DnV9fVATS7JDZCk7e4z9gJ/CnPQFaw5jMxF4pvdRFOd?=
 =?us-ascii?Q?conuLFCXEMv6f6vRI0W1XP4/JRhRLr+ckls5+A729joMOsh7pbtjfzCFFR3M?=
 =?us-ascii?Q?GL3YxtFXy9idUL5cdThjZLeCEJBuAFDw2aI00m0LbTIxHmOAlSqCHAzyR6La?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9kYyS+hQv7aMCJrTIS4lijsmzqnCgW7yYQTw6TJylZkOhOxzD/VSsPHvJFr9SJyWZtA/qkAvNBc68OeXn4y97Cw85TZ8p9MiqsUl7HIKr8wzyEsLhHtgwoRk/PpfpQXfwkpZb8qof8PFwsWCq6cQEB3yK40EiD1g7q5GEW6RHf9jARk7/0Igoy9dOYucVI39yGBdEg665KizJIJb1tsgCHXC+if0bHNquLdPD3rynGm3OCCEm7rOXzk283duU85dgsOxXlcYFFv+4fCtsMHMmCVklXYvWCtYwFoM4YhvrROzihxwOYeBlE+lP9KprNA3bwp6ZS+DKQP+0lRkGdwetuc7COI3GediyE71FePwfYveK4RKQuNl3cGA5H9wJpXhP3DuYxwFT5/rLPMzfQHx2yjIQ77zwsnALeJNoMSy6ns3tly4Cxgbs2Xm8j5jNweBpZo+OWBg8/LByMUgrqiWuAtYCOYmpm6VsMwBLa0xQEpqRLA6WeLbOEWMt+DOzvYhtmOK8nXRri1/iDUOsV+BhTzGhZMSKdQkABTmR7qf1R9kXmQsVNH70JLKKU92M2iVKtRlkwc3pXuG9spWAnnlOmHJTkxWpeiwMGtr6+enCL8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d462e123-8803-43cd-f334-08dd04db3869
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 18:36:14.9559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Dz9nsbl/oQmPUQkFtjNzX4dg3foQ03uZhHKxkneVLTrsUV4CS85BLPlJeKShy/VhTj9CWkVwZrc308KLVOmWFSgZn9Fk4HQ4MfaA4pRsLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140146
X-Proofpoint-GUID: aJPmEnHrFabDNPOYIWR19AMCvl5rBzao
X-Proofpoint-ORIG-GUID: aJPmEnHrFabDNPOYIWR19AMCvl5rBzao

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

Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h | 18 ++++++++++++++++++
 mm/mmap.c     |  9 +++------
 mm/nommu.c    |  3 +--
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index d52d6b57dafb..36c6693f4ebf 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -110,6 +110,24 @@ static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
 	return err;
 }
 
+/*
+ * If the VMA has a close hook then close it, and since closing it might leave
+ * it in an inconsistent state which makes the use of any hooks suspect, clear
+ * them down by installing dummy empty hooks.
+ */
+static inline void vma_close(struct vm_area_struct *vma)
+{
+	if (vma->vm_ops && vma->vm_ops->close) {
+		vma->vm_ops->close(vma);
+
+		/*
+		 * The mapping is in an inconsistent state, and no further hooks
+		 * may be invoked upon it.
+		 */
+		vma->vm_ops = &vma_dummy_vm_ops;
+	}
+}
+
 void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
 						int nr_throttled);
 static inline void acct_reclaim_writeback(struct folio *folio)
diff --git a/mm/mmap.c b/mm/mmap.c
index 8a055bae6bdb..9fefd13640d1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -137,8 +137,7 @@ void unlink_file_vma(struct vm_area_struct *vma)
 static void remove_vma(struct vm_area_struct *vma, bool unreachable)
 {
 	might_sleep();
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
@@ -2899,8 +2898,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return addr;
 
 close_and_free_vma:
-	if (file && vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 
 	if (file || vma->vm_file) {
 unmap_and_free_vma:
@@ -3392,8 +3390,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	return new_vma;
 
 out_vma_link:
-	if (new_vma->vm_ops && new_vma->vm_ops->close)
-		new_vma->vm_ops->close(new_vma);
+	vma_close(new_vma);
 
 	if (new_vma->vm_file)
 		fput(new_vma->vm_file);
diff --git a/mm/nommu.c b/mm/nommu.c
index e976c62264c9..8bc339050e6d 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -600,8 +600,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
  */
 static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	put_nommu_region(vma->vm_region);
-- 
2.47.0


