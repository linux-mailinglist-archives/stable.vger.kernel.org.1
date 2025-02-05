Return-Path: <stable+bounces-113969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DEDA29BF6
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC62D3A79CD
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE2C215074;
	Wed,  5 Feb 2025 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bw3XCxXA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DT4VtaFe"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747AF214A96;
	Wed,  5 Feb 2025 21:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791640; cv=fail; b=sE8Giy6qlFS4vg26KORuv7isvvKm7VEGR4yZUQBeFR6IU1nr//i40f9aLgmqXQdrPAqNBSvd0jDAnWiTqi5ji/Z2Ym7RKWRrFPuGNjYDWqV5WDLgXm6qeNNxrB1uSc3wmc3lIGssgaPC4ITjBfiHs9PUkUTfJfF37VeAlHiku90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791640; c=relaxed/simple;
	bh=W7ohdTNFI/qzLkMU+sxFBYoq9juCC6ADTXc+IoU9VOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G34HhBGJxdGhaV6nx0OsQ+ERDEvAqv8Q8rB6JLVbLxW51q5/2OLhPd8eVWh8D5AFSOhO4nln5qN2eV92rbdnDZqgLGX+QsjKVYzk73BkF43F+9pOJJIoMOoy72qN/PzEG9BA/5GzN4vudUv9OPMfH7LSDVC4yaKfftq/PsbCMPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bw3XCxXA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DT4VtaFe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515Gg1mS028661;
	Wed, 5 Feb 2025 21:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Db3Tye6J+X33DrGQkuL7OV5fm/BtLEKKDNrDzKa9aI4=; b=
	bw3XCxXAawJlZ1FT2qxegZoMV8M4tmltavEgeLnx03m9htrppe0WNC1mPqFr28WT
	9VJzTwllil3y0BiWNAGMICGMDdCUFqVymTn7KU/fWZ03VxJlUevsg1+8jV89SmWy
	IEEgF/iQeZXK/EFFGwB9OI6RyZTTP1DkisMhpKUcCQ9xZcxBL5g1BX9YcWoKGhbU
	Kp4LC6hyj3++8OnbHOkMrW6yKpVpZAHX0+eH4hy4bJBCo2frFpF7BbsSgsKQraNO
	NpDvwjDg0U9mkCUy7prd2afCH3tyIsvOEmNBUq3d8zR+CCzMM9mWQi8wOUmajOst
	qYJd5KDjiUaDzb7UfQIXpw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhbtg7f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515JqDik020693;
	Wed, 5 Feb 2025 21:40:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fr07dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQr8YQ+eKLyrR6WKFmiePao2lSfkWCQDeRAwSzF5MrvtPPVOhWg+ugJ4x4POpC7aRNVlxnQDIVCLkGwheAITdfR+3lgo39p+2pIWj0ArVImTQMbgG3om/+wYcL8YnTHSVKxzsv97QXWBHrCq0HzllrprFqNxwb4GJKfsY9uLdstbJvjmsylQVeJOoFF4vxDOQmM4bFLBNNgFIYsEsSeVUcf0zuU/aFhEbx3TB8Tg8e3cZUHYEce+pVzdFyds3dEbOSFbfnEmDZsR0+4mH3Dt8WcW2coEsIPZBm9ZDU0001gwXod7SQGcOuLjspbxeuL1gSgClvTpSN/PR60It8ZzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Db3Tye6J+X33DrGQkuL7OV5fm/BtLEKKDNrDzKa9aI4=;
 b=cmdiN/Sgpv7Ln3NEC7crGRVY2HdjM0ENTVp6xpSEOvrvGoWmVh/dNoRYpbjmvVHJU6uPff0sNBhbH9VipjaSlN42fXFjXDcivKm50vEjPiXypiujq/4/vl4s20UzSxUMIJ+lslhItVVxQRKS12tNdNn+P3+N1X+o2qjT+9ITqg2cAk+3G/WTwrpzPXLDqbH9odKs8DjPCJNDVLpp8tlbC5040wW5TW0NRsyLyJDWd6kSGZqyFB5JZnrxMaXBFtc5niPL/6EDZrFuqlyPFoTcg2ejM+srAexwa+lO11zlW5s3CxVj+Q9F5BSl9GbY4tcUd5icrJLLdCp9+McfEzfZsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Db3Tye6J+X33DrGQkuL7OV5fm/BtLEKKDNrDzKa9aI4=;
 b=DT4VtaFepIlWmqUiyIVB95+rKqeOJXT1gmtnE4eUHnqExMKelbXBcMXNf3izPI1/J0nh7TBM8G4P3m8Njc7Jv2kAHyJSNPYCqoc0N+kHSpLoLwBQ4LoUc7spczTuPpprx/h1rcS+GHSAAYxVaiUUET8pGRZsFga917Lde75rwYQ=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by MW6PR10MB7637.namprd10.prod.outlook.com (2603:10b6:303:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 21:40:34 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:40:34 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 03/24] xfs: fix a sloppy memory handling bug in xfs_iroot_realloc
Date: Wed,  5 Feb 2025 13:40:04 -0800
Message-Id: <20250205214025.72516-4-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::35) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|MW6PR10MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 6909b569-85fa-4d08-5daa-08dd462db87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6yFQZ5rcXf2ivlFmE8e1NGkM5gRSOStj5x2ta9/vGxsvs2sKOuaPAxMTFueq?=
 =?us-ascii?Q?sZIF/HYlTpnReCj5SRvLjhI4P8kRhJgHS4G6wYArY8xGs9w6k2ZZCSwEKKwt?=
 =?us-ascii?Q?7glh2B1QCSQnBgzNQ7rwJM2zz2SM4meWVuO/+u3CeguwicaGNx+Oi9M+Iw82?=
 =?us-ascii?Q?UpB07va3LvAK9Z65ygL/6S6OxLgpuxVDQMG13krmKYS3o80nZ3elMlmpckNG?=
 =?us-ascii?Q?dUWoJgRK1niJcUJf+o7c0rMLbA4OdJ8RnXg+PhaTlky3n7U/tu3GMNMGF/vc?=
 =?us-ascii?Q?rS+tNzgU6ahW8f/L1Mmo4L8THCe1XjgKQ6a/DN7CYuqv/IRXwtQFLJRPije2?=
 =?us-ascii?Q?NIkpND1LdaPzmmRO+dZ8jtAKfDB/JbrH7lDjZ5GX37R34/N83pgDlno1BFU4?=
 =?us-ascii?Q?bFHU2bGNsT9QH4y+6xo3z6AaLh6P3TN18gwPGwIqmRnc+RdJkU6Z/BdpE53X?=
 =?us-ascii?Q?7sUBTDwtlfZunNi/v0svygppPFPmDaTrdCT+wHB7yYkq1lNlOriTwz0LTk5U?=
 =?us-ascii?Q?gDUF0l3nUzcyrMT62e7Pi4u06UtbqOkvjcKrBK4D/7jk8Mcf5ejN1vHikAR8?=
 =?us-ascii?Q?q0H1USprl+4fxg81iaxX9cULSxV3Xyc+td/DLznGk6KHqBdWSM6d/lAd4Xcq?=
 =?us-ascii?Q?bbLxrT0TP7Xy1TrptFyoUpAyz26ddDxutG4Q1RvEhTHqjspBS0hN2PEbAiZc?=
 =?us-ascii?Q?cNxKX4Dmx0TaaCotcsYYPA/Fa1yoKL1PXvsE6tuHnBD+Ho+tTTbFjOrMDEgD?=
 =?us-ascii?Q?izPD16SQT106c7BqMkNw4uLs449wAiCm8Cpa37u45BLGMg2fnUbxKtrYDBQ9?=
 =?us-ascii?Q?p5mpUJskWtoNKjjwfDZ4peh6vs321a/OJ43WvFkTWt97LSbfkSAliX/su3aV?=
 =?us-ascii?Q?haUXBBR7b2TWhdJPLqgfRyrYhFEt1aR3e43kU3tmfCAiQhsq/wX2vMEHTUz6?=
 =?us-ascii?Q?ph7FrWev5vW3gpPguHaC5meLxKwVMJ1Z/UL+pu66D9Kxkg8z7WP70zquhFaN?=
 =?us-ascii?Q?zQL4uEVCyknXryNysbm4bmKAMiGhRr2KAL7mj8RiV1GcXUUQmS25fBudkQWd?=
 =?us-ascii?Q?OKVaeEaj+B83TsFMlxVSjjQRqzByCGjz7MMgaIqwqfLkmPInU/XpU+os6KLA?=
 =?us-ascii?Q?x+nl+mWMf3S+a5zrfFoILeh8XUVRwB0kAZjSwg4UwV3RbMND1CJ71p3cIhXa?=
 =?us-ascii?Q?+93tPbZj2wC4ol1s8xTJYPVLd9nBJSAvUkrqjPAEdoO1VtCo5ieGKfmxcr8D?=
 =?us-ascii?Q?z5IYAl84uOMVyrkeHGAzrNLLfTyPeQVLVjjNprvxpzHZbGWe7ZucEH8Zul67?=
 =?us-ascii?Q?KBsCYp0JL6f4qBpTf4UD6id+dWlOziaTV3P64waIyPxytQYDJ5JU6vNeC/Ua?=
 =?us-ascii?Q?DxKG6vpY37oye9TYhiYthAZoqich?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Lwcn9toYTvxyzUzmZcuZg6wxl4KUOV80o8dO65VjcC4a15mx/MO5KCddifd?=
 =?us-ascii?Q?TCfxQ9nlXhy3fWzBKsSsR9RXjdLsdb7dlBIuYhBgaBc9I5deGxUpKD/7UmCm?=
 =?us-ascii?Q?cdwaY34aaIpnXTTLEJ11uGiwOBYT7N8tlWzlNIBCcFLsuGEgFItUvUSXW2MN?=
 =?us-ascii?Q?tL5IU9nUjqP2x6SwG7vqI6qX49x9vxL/3abEF2S1hInuhK/F+lE+o4o9TeRk?=
 =?us-ascii?Q?idVrhNMPZ2lrsrlVksrA2ZalEStwrNEuc7UjM+ww1Ent+Yw5bmoohg2tjIiR?=
 =?us-ascii?Q?9vN4h5JuPLgWFMnEdvZ4l2LbcT/fiok1IHD9B1W99SFELIa7UFXC2OV50GzN?=
 =?us-ascii?Q?fI/ylwRce4ZurAsSvXxrIutkOnSbouu6+Qr8w/4Hhsn+xC6GprLgzzoUYK8K?=
 =?us-ascii?Q?OX4MBpEoOI018puuCLavZmKrbBk98q0kK/yoOtmGoRnyuGAQ/lutVazNtvkO?=
 =?us-ascii?Q?iNH6zJsUYFqKqpb0ss2f1AN6zV4ffxFdsBoLMVPYuyBW9BUH6mNR6iLJ60WP?=
 =?us-ascii?Q?apOj1ojn9bCk4IKSmLQvu8olkztWh8c1yqGgjFIqQ6W4jvpdocV8l+FR4IHI?=
 =?us-ascii?Q?Cqgx6ukNhve6GNtXbd8rKbLKFhmJ7FqEkwIDr/NaGJeDnUumLd+BMH9k667F?=
 =?us-ascii?Q?LtwDgYAluBtsuVKrWWk0DM0lcNGUvdMmA/kyg1jv1NotwI/IcNJRT63gdmW+?=
 =?us-ascii?Q?451Hy4ZQQvkQ72jz8oef5ZsG2UwIIJ62ec0/+dZHbb6i5eNeJikxcBvLRdin?=
 =?us-ascii?Q?sEmnN06WvDUBnyzkL2tdti14/+vUzbewuqBseUJAdsN8iGUGXMYwjztIxB6Z?=
 =?us-ascii?Q?++PK3wLEPrigBgrl2A/hP6EsKZn9YN5X0vdjPYnxqh+E2cTfhHlrBvyI7Ve7?=
 =?us-ascii?Q?yfx8n2mWQP9qVrvt7cnokbtjDBzLj9cdMMiZEMo78sRqjTYxr4LQAMlrQ2nC?=
 =?us-ascii?Q?owpvmkrRxukEtNgEl5jRlFarBfYDGACYuPdDaaIy8MceBxEDCfzKwF1j3sxU?=
 =?us-ascii?Q?+WyDCKoJ5ZK1JfovhvB7L8PuUpscMJHTHhVJqTB513VRhKq6OAvRI1nWkzbD?=
 =?us-ascii?Q?PSknxhBGXyc80n9vwYFoTLnHkYB812Gp4c6UfeI2C5V1Scy4RfNoxYuB0X0m?=
 =?us-ascii?Q?BXf9/AGUj24Wzrmgkoh1JNVhTcyKWB60pxjWE+7xA9oU6rwVhuk2ck6qA7BB?=
 =?us-ascii?Q?YwzNNi5Ujo6AqXEnwutLoD88owXCFdgSHnpjzmOpfMuugQsg1B/0erZbSwPh?=
 =?us-ascii?Q?tdrCltieS9e44VoUR4yTGZCSEK0qOWbTKbLYL5NwfuSdVv5ZJSUoDbPvV/OD?=
 =?us-ascii?Q?+cC02vRAOJzTJV+8NrN4fgmNEr2H6c9Tj5oklTKExBblrZwieO19EMYOMVpa?=
 =?us-ascii?Q?HUjjSxRWQijl3uhPc0qfVR8/+3AtK2a8+S+8awQrrucxmTvVskEcaceNkQ7n?=
 =?us-ascii?Q?IkG7ZAE0RUSSIRf0zQKXR6hrmIFubhJkp2e+OLvPw5hh28q1sQy3zQNgxEun?=
 =?us-ascii?Q?/WmrAlIkG3qjBvTcOCmGzuTe5LEQ3VhvQzISIAHmX4M6DPNTAu5GOpB4jXxO?=
 =?us-ascii?Q?86ky+YFE75TJYPhaiEeBppmpyOfziautoZYR7NPiOaeQqutL5VCgY0H/LLM9?=
 =?us-ascii?Q?dEetDf5Hb1NS7+akNriwAMI1+JMkdPAOPULghhpT7E4Mux0pdmu1Sa2WjqIB?=
 =?us-ascii?Q?23AH1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SE1iXnWLckVvedYKINH4hoL4fEgDeh+vI9o4fKQPdb+0Ih86ifh8Gq4LXqwZcnoV51gkxIdDB6orODa8tinuzlR4nqT4QoQb+2kBlrwf3k96IrJkdOBbRp43IUmC2r9GuFPzGyAiNb1NpJO7uR2J6mDeN7Kgm9m1004OYYGCnTY/4ZLSXdSC9JylKMBkb7MHtI8mkUqMpTddaL+au8zYfho8RfBTLRTEhjwvinT7aHKEPbrmKj5WER1W5CLBv2trgkcVs8g3t9v/B/kS6vcPkOrxT9U4OHECxvM7sWmm8rbkaOQCHgQLttRnwshLsY+X1y1MZ3X+jTLgVB0Aiz74vo84KMyMo/Y9n6AknXpKQSlzGt7x67mSwezRSqp7L/V4LtWQogPmva16UWznlIKWJGliolt+GD4REYdeLOgJil+m6wFzsaEMQWKm+klo/qfj8rUtPavXOXTqgUd7Z51MqTwu/RE/AXB4WIaqbv0kLL2mmKE6qy6sicSgHP3XTqJThZOS9IrdrMc5keQWb9qjO/gLFooP93SdYj0ot0wylj4x7B3GBf4fkNXkT3zDV9v7wxXUUz9/4lBiLkLWhlyxG0rFf5ZlMtM3nS+1O/avS14=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6909b569-85fa-4d08-5daa-08dd462db87b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:40:34.2950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bK4Ewm9z89tSMVPMdWxDvUvF+ypu1/OADVKrdDs4ehjdi3SnEpJs3xzi0PM32/3ZHySFqu88AQlTgeuRs+7XBwp3XABMfnV4CzCeKEjzp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: wl-shBAcP-B9I2lRY6vuk8Nx9B62SomD
X-Proofpoint-ORIG-GUID: wl-shBAcP-B9I2lRY6vuk8Nx9B62SomD

From: "Darrick J. Wong" <djwong@kernel.org>

commit de55149b6639e903c4d06eb0474ab2c05060e61d upstream.

While refactoring code, I noticed that when xfs_iroot_realloc tries to
shrink a bmbt root block, it allocates a smaller new block and then
copies "records" and pointers to the new block.  However, bmbt root
blocks cannot ever be leaves, which means that it's not technically
correct to copy records.  We /should/ be copying keys.

Note that this has never resulted in actual memory corruption because
sizeof(bmbt_rec) == (sizeof(bmbt_key) + sizeof(bmbt_ptr)).  However,
this will no longer be true when we start adding realtime rmap stuff,
so fix this now.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_inode_fork.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_inode_fork.c b/fs/xfs/libxfs/xfs_inode_fork.c
index 5a2e7ddfa76d..25b86ffc2ce3 100644
--- a/fs/xfs/libxfs/xfs_inode_fork.c
+++ b/fs/xfs/libxfs/xfs_inode_fork.c
@@ -449,15 +449,15 @@ xfs_iroot_realloc(
 	}
 
 	/*
-	 * Only copy the records and pointers if there are any.
+	 * Only copy the keys and pointers if there are any.
 	 */
 	if (new_max > 0) {
 		/*
-		 * First copy the records.
+		 * First copy the keys.
 		 */
-		op = (char *)XFS_BMBT_REC_ADDR(mp, ifp->if_broot, 1);
-		np = (char *)XFS_BMBT_REC_ADDR(mp, new_broot, 1);
-		memcpy(np, op, new_max * (uint)sizeof(xfs_bmbt_rec_t));
+		op = (char *)XFS_BMBT_KEY_ADDR(mp, ifp->if_broot, 1);
+		np = (char *)XFS_BMBT_KEY_ADDR(mp, new_broot, 1);
+		memcpy(np, op, new_max * (uint)sizeof(xfs_bmbt_key_t));
 
 		/*
 		 * Then copy the pointers.
-- 
2.39.3


