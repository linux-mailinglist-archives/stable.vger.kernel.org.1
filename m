Return-Path: <stable+bounces-194681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B75E9C56FE5
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 11:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D1424EB387
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 10:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6193833373C;
	Thu, 13 Nov 2025 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UBdjJgGt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x2zN9Acy"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5558E2D7DC0;
	Thu, 13 Nov 2025 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030788; cv=fail; b=jjp7J2VYdl8X0r4sci32g0HNKJzhgHf/X/C1IiM3I7li/d2x0cQN7eSrdBnDwE6UliYJTDScFK9ZojFXz8oFooV4AwntZFnh0eiIM2pOADO2HvO/pWecJYf54qL8mSD0mWA9fw5tTt8qi6FOXTdodVd0kC/W8ND42frCseyfCeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030788; c=relaxed/simple;
	bh=Q7jjUXeX7fYf26XD4/IO9Vc4YpLxeE5fUGiygMKLWdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GInBoNiNibya6GVdwCU/ywA03b4ADIBHRAXe52bEo2M8Cc0+SMFlKKOnBQZt1fOLCaMlegPAC2rt86MlZ8SVvNR4KlU1S0wzrT4J6rKNi9TA2RJ/m5P8vKMuKnE40LDImEcWTIRTJLs0YS3s2hM/TXLgA6EXK3JRxGOUceNpmWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UBdjJgGt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x2zN9Acy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD1gd6E022715;
	Thu, 13 Nov 2025 10:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=hTPoMQP3K8D4HixfDl
	lzN/Xzno1eISdWqYGOEqGU9SQ=; b=UBdjJgGtp3ixNjlkiTMOt7tAYw1QeI5eTz
	+3KKDyFircSaiGnxMHjCcytH6taq3mKBF65d1eMuxAz/ZIT0Y2NpzVHoU+20LFGw
	debnrcRsEf/OtRwb6wwrtLLVzOxf7tbVN8O0ZNLhVTeJyOWAbgSvZXBpC/eHNM/4
	5/mGDBpy5OVwgsTIL7boGSZsqWcJ6xnqV/3DRaRGUaHg+2B59yqTUUa6JAGbiqf2
	77kTBMHn/bP8v3YTCUvnj91xiqQ60CWvJ3dhC+r8SoACIBbcxylAg85peAG/nDCR
	EVz8alAL+rNjn0Ki54bD6W9BhfCdmnG1jayMmomjMYxkhdBVZZYQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acxpnhk7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 10:45:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD9htOk027830;
	Thu, 13 Nov 2025 10:45:42 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013006.outbound.protection.outlook.com [40.93.201.6])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vag11gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 10:45:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyDMKwArqg/EB1vizgqUO//K1qp13HJs/fneSEtydkPkXTckIsi9PUSJC9qzefFax08nqz1/AiqoaKf8Uq0Rqd6FupIeGsOy4OvatZuvuTT8e6xKl4mh40ah4IWOy2N/1SCnlSisdP7Ghhm2qSenwZhy4LofpcgshJ/2nzOOSheVRhGgDAQFlhhX1HUtfoVAoTuxRMu/9oL0Z8RVke1nPpt7xrAvxUZJFRtaAZcSls1YR9VIQbVIsrjpONOUOLZMcmGGNrU0b02MSPPbeCMTdL+mN45Bj+lQmfWOPnjJmE5x05OB28Ib5Ct6IcnFVvaf7KM49MtkfJVzzrgaFBdz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTPoMQP3K8D4HixfDllzN/Xzno1eISdWqYGOEqGU9SQ=;
 b=WdyEKZ09zFkPZYVdb0LfXT6AtqXuiVoEaxOmDfo/MFVtLjX8vNQsri5FvH9aFTPIj31SA4UXwFcl0BG5uAXcdTjs3eHGWuWxMiue9/Rn2AS8ZJ4ZSvT1pQRksUDD46u+DGJ+1FYmHlZ1WAoGrnxACL6rWETk0fXvDpZX71MYU/PGWRfr8HuAw2KfkStk+wkn1WAXqr0k990VJWBCHIegEdvEpWYFDhL5OKw3GJAqxABxNBObXkuj99nmyhwhbYMu0xvmrw47k6zfO+aq4jtQ0LDEQxUGib8FYN2CHKSlA0RWpMWTIkzxJ1U/JR0+HfObXhZbTG0JAw81o1QMhtAmNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTPoMQP3K8D4HixfDllzN/Xzno1eISdWqYGOEqGU9SQ=;
 b=x2zN9AcyG84cCpwBZ3FJ0J/gI090VlIAZZDrbUHHl22ofPXxI6RKIvFtu0HHHuH02mI1gUlr3kEG6Pph5EtKINPVLrylNEIcPgKXL6H0iRNegXzf/VhA3yEUft15dP5qf9lX3OeBx4DDhK3vRp/9Aa3LkgtPMuBe+sy42ABRDeI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7173.namprd10.prod.outlook.com (2603:10b6:8:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 10:45:39 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 10:45:39 +0000
Date: Thu, 13 Nov 2025 10:45:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
        stable@vger.kernel.org,
        syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] mm/mmap_lock: Reset maple state on lock_vma_under_rcu()
 retry
Message-ID: <8935c95a-674e-44be-b5cc-dc5154a8db41@lucifer.local>
References: <20251111215605.1721380-1-Liam.Howlett@oracle.com>
 <2d93af49-fd76-4b05-aee7-0b4a32b1048e@lucifer.local>
 <aRUggwAQJsnQV_07@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRUggwAQJsnQV_07@casper.infradead.org>
X-ClientProxiedBy: LO4P265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: ba7f4635-b4b0-429f-b0b7-08de22a1c930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i0JqvAS8ifs9ar5ns1+LT5bzNw86i3Gdea66YOWVRlVGGrrq+X0ugGcfVHrl?=
 =?us-ascii?Q?vTzPxZFs+/yMulYcpfcM1g0/ID4VOZmIei5iywEpXINeEQeeR1279cpqHuEw?=
 =?us-ascii?Q?eYpDRrpd+Xa6KUlMKAIpHykLGlaFEO+I+1YCjo5Oj4HgFn6kVJqfYlxfkMaU?=
 =?us-ascii?Q?p6YgV+m4BQZu7/q+JL3rBHRpuOQ3/T8UDk6y59KPxhv7Y/Ojpn+e6G8W7LDN?=
 =?us-ascii?Q?l7iUFRMquRNT4HKQcFgy9DWCqcAyjhnvRq+8cZqtbukn32C4ECEatZwPCdT4?=
 =?us-ascii?Q?Nrn5W3YVDGSu/R4rX3fZpYYrvOoH7ZsdsP511RN1NZj97qkYkgTmfTOGudkF?=
 =?us-ascii?Q?ZWCQwO20O7mExWit1nVjpSviQIySdE5Jc9xyVLl0SPkXO+92NMpgvyKG4hqM?=
 =?us-ascii?Q?Ebjec6WkN5Reaju0cXdk417nL0BpCkuEcvkMtco8HLjkaVToGjc0Owf0LMsg?=
 =?us-ascii?Q?ClDtGT0NGqQEosVF6d9qvY8IsWaTigiRfXJHThkcOR19JtmmunV6luCe2/wA?=
 =?us-ascii?Q?0ude4aUtwIZaPNJyIeCgSuMNYCmAZqRWqNrqEgqq4lGQ+yLQNITQk+Rl6uft?=
 =?us-ascii?Q?QzK0Wxo3JcWSTl/K/Jq6Eooc8nLUSSgPXVD4oYmxyf4WBCgcacAw4N/x76Az?=
 =?us-ascii?Q?tSLKYJ99Md2kXau0x19CayfhVZ8GT/KljY2/q7/zldjQxHHhAPRFg/H5yxeE?=
 =?us-ascii?Q?4GHndGjv/SXcq2GnRqRatUlEW851VLz+15B0jwf5zU5atk38xsBr063ab2Qb?=
 =?us-ascii?Q?7ww5ucrxqju1kRA/hkbmS/wwV60JAOqnFS6XFjO25yjZ4/NHsEuqHveoLw+r?=
 =?us-ascii?Q?upFE4iZ9k6169oYVh0L6p7aX65xFwUbqydIHM8sIBGaKeGqXfaqYBeZTxiAe?=
 =?us-ascii?Q?xOLtAUSzX2Xq/foGjNzSC0tcQPLIF656SQqy7K/TXJhR7/zztYotdSaJ3Ufw?=
 =?us-ascii?Q?lxTOupNu9GquScGMPbr+bl4koLNxckmEHaGCS2CKCet7CEuftlQDWJOyMY5o?=
 =?us-ascii?Q?bPGiuY/eGBQ/FEKIrVoazIc+dMFgSg0OiUaxlC8oatGM902MFxRE2w4oXVTE?=
 =?us-ascii?Q?xjYKe07tIlEfdXyKYSeYxXxILtbxF76xwVzdy4NaJ9eDwp30DrLZ7OWKQ43V?=
 =?us-ascii?Q?evtq2/n/CgDSMFhf4J2/RoT6ztSnGtXt1FMdUondG6QXz9xVxRDHA1vjbBkS?=
 =?us-ascii?Q?nWeS2aFys7aHWnw+soc3lVkKoouOfb7nO/42O8k1hb33Cay0UUdiKfMvXWrc?=
 =?us-ascii?Q?DspLMmipag54Eqd6yik4EVPA3LGmORU3aRiDi0tarrlgfhwfMI+6mmvfmzyD?=
 =?us-ascii?Q?scqTceSt6/BVItpO75lYunO+Q0NWTg/ZhCp5HrmGC8LCg7SmV2GUd5aYBti5?=
 =?us-ascii?Q?jC4rSuT4aNnVBWZ2ymbDEFtLqTiwZ8/Prz8uqR173u9YDdaPLfruCBU/Ji3Q?=
 =?us-ascii?Q?Zmb7HTfKWbL/qieOUD9cC6beriPDR0Re?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qLYiYZesqnbyIk9Ep3glV5oumjNT0gqrGj+JbVCRMLCHM5nWeCSKewqV3TDT?=
 =?us-ascii?Q?LayouTS98xO8muk3Q/OZRUSG7++Nk8k6bTaR/G2FjABsmmUXzA/Y9dnJSM9q?=
 =?us-ascii?Q?rnZOep3k2+yg+Q1oi9MeAkRzjZdNseLKxlxL/yri1Rf4opDYQrJNRpAebqKJ?=
 =?us-ascii?Q?wIdLtkD7oIGyYR7FqJlRFPtrtV5wxFRjsqLu0jonDfkNQPaQkfXyTznor2ET?=
 =?us-ascii?Q?XYNRahPGgBfIvjJg3zyQCAptOq3VkxTiRWNnO6Y+ToXweTv6wZq7cEa3frSj?=
 =?us-ascii?Q?NwC8PPeysoc9HqN3c6yaeEb/bGIfIBFEFv3lURw6uScMp3RL5Nxc5Wm7d9v+?=
 =?us-ascii?Q?YpHbKDMICy427pYOjpvr2GxYtXZNhGMmKfIN/2XbUaKmCAdEDfu7Rt8Nl6VM?=
 =?us-ascii?Q?vDGWVRdL9picezw3WatIqu/2ov3znltoOHlu3z8lSYNmT5dyY2TelEhn8HnA?=
 =?us-ascii?Q?Pv+A3O4BIuQLwygp8kznnrSqWChWK1EUb4yzXCyzsXQmQu1wlK4V+unusXOx?=
 =?us-ascii?Q?ZoRWL0w/LXwppLYb64brjYJTQDK6WSBs4IIu12KLBxtQNhOjdCHKWMZzOW+b?=
 =?us-ascii?Q?Fb407LAVBcE/gIcKeBMsTGhjS+x28qiabM+9fiWGQWT7EThxs/xFMO+EOCT3?=
 =?us-ascii?Q?8jZcIvXQ+BHAG95EY0Qaw6EpffZdrTdXboiM+NviePvbjLf5VmeVMN3EMcah?=
 =?us-ascii?Q?7k6slVWDw5y8r80TrvAfOLyUd1xZzf+yOrO+wEeq17VPvr70LeqjX1jtaLzI?=
 =?us-ascii?Q?5k+82upPGuc4BZOFXcSGCJ9RmmZrvN+99BjjFSw1xpSuYAK2kJYC3gX4lSuv?=
 =?us-ascii?Q?HlTPXnQRW1MSYVGy7SpYTGy4+ThL7UxZsch5syIo3bRvh7GNAAVhtFhr5oJe?=
 =?us-ascii?Q?kpDe6FNL2jeCFa5OtOAGtA9ryDwDxSEXPTD1OMymt4RYwHALBcQ2xTlMtZfW?=
 =?us-ascii?Q?TVzQQ6AdfXTF//qDibgSX/ogwLJWKe2nEe/ksSbwvVSIKdWlWGYeRftvSnzS?=
 =?us-ascii?Q?kztUIMsHkL1JCixORPUyI1vAbO5Nd5Pj/FQqh5SwsRp5BMZalf78+sm1O3Mf?=
 =?us-ascii?Q?qxr+IRWJ9zwzLqFNaShb4MqskTjk971F4Aon5eRiOh75ElvahQnvLRQeMxnb?=
 =?us-ascii?Q?OU8htQLHCJolEBuI6tSo7HrEocmB0N+8oaHwsLyT6BQHuHzxQAwyn9N2iCKq?=
 =?us-ascii?Q?W+GYtl9pgB4On6rZvOBjXoLPPJx6ZM9KEZ0fDon7jFUnYu8IeaZ38nyOMSw4?=
 =?us-ascii?Q?5JXkjGQZaWsv1tYqdVTSdqm9nX5ju+vt2rZ7QDnJGiJ9yHKViWF4WlIZ4qpL?=
 =?us-ascii?Q?iHJPU1tRTFc6Pvo0EqHLhbcxefsc+nXT4hUYzkxUEWKUR4X+MzjLdDW0Y7yc?=
 =?us-ascii?Q?snLsVCWPfGs8yxlYUok+0/AdNLeplJUn+JiFchDw5M0+uJca1xcG7mJL1K39?=
 =?us-ascii?Q?maKVzTMdPYIxre6VCaoPSY2Tfua7d38EiYxfFzoYFhqgU1D46qz9FqG1qBcM?=
 =?us-ascii?Q?hMXWpvo3bT6oiHrWQCTfaE7vs4aX0exWCSPQS6s9lOVI4Svec7QwOtsJ5wwB?=
 =?us-ascii?Q?a74eMBl6/fNINragTQI6DRHmeCGfo0DbK/diI1V94T0qldg1cl+WQBMCF0jk?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NDscpXzB2heTmO25ERGmbhYMbZ/wlg/nn0hOnFbZChjTwUnOKCZ0sbHKp/BfsrRgCWq2v0Brz7FTA8FPN8W+w+YOSHQK7GztSVGjkB4cxsuGF6f7wzZw1ZaP7b9ybI7RXD3diybbLcKPzw2D0GZ64rZhlHbMPzgxOTV5TZspdgN8cqz7ecG5hyBrW9+/ehT8DLTNm0NLKaDvnk9IMxRcgFMwKOADjEEX/ad2iZP2zstBk4utiLAPCX8UHjPdSEMaGIOoy35sGpwG+KFPmqsUFLk4yI8L6kXDhoBvvY83X97cCCF2Rz9mVuWNMEcI7Jdnes1t8PEUM2tlIAI6mpY8fQauSdAr0UgYvI7QzHijF4W2BnQAEaV2iUMynW7mRWiQx4CPazs1dn1LwE5Dsy9cAXrMXFztl8zapBVBHF2V4BpgH4bDcN6wicDcpJKhHW9nIczeS8ThtuX9IY9iWVxnqohn0l4R+i1TevnLdzq+2/D4BeNowGmFy1twsKXfOxGiZVxNqiAsfjWipo/TmC+uTKph3Pc7Rhs8gYWKRGcGfUcDFjZf5e/mTxuGAD3TimWou/bCTTqJnD/BSmhMBpgAqT8xcXcOpr4/Orvixw2cFuo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7f4635-b4b0-429f-b0b7-08de22a1c930
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:45:39.4454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TWBFefKAsiUGps70wIgooa/R0UMq7GtfjIf2iez/0BwPHSmB+zawIKfHN12vYpDz6B86Hu+1hI6jVXcqxieTT4mGE0Gym9b+sU5PYO7liY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130079
X-Authority-Analysis: v=2.4 cv=Criys34D c=1 sm=1 tr=0 ts=6915b6d7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ye9jCOb3GT2e8QYJ_TUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13634
X-Proofpoint-GUID: BVGUIvwshrzvbI-lMXo8v85J-Wc6tHFN
X-Proofpoint-ORIG-GUID: BVGUIvwshrzvbI-lMXo8v85J-Wc6tHFN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0MSBTYWx0ZWRfX8wwqOqFYDpnz
 5Uisl9dhDX52Bf/vufuMU4NzYlqFQOvNq77XcERSNqoUr2KnGifFtOLMK9/8sOrZgtYLh4FqWhH
 644qz0q2Q6yanbmpKMt/HCjzH8upRx28L4chKu4Ap8rDP1a00Tw7wToHv2xXJUtsldrjRW1yM43
 J3itIlFUVvuC4c5xtvhetH1ETN9cBmbk8/1P1ci/TLSC3M2Gw3jCVBMxev3zHyFqCjwhJ24uLqG
 522wdvOB437wLAW137tfrwWDtJ7/HJHGueqBxmYEEnVmM/msVIg+ad4FbcFy4Z2PopjxzghQCEj
 DkZKNl/XINxAH5TFQBxqtSfoQoXEuH3FIqBNRA3IJuZQvv/Zh7kFKJDxy+p3LAn/oX0nWQajz5t
 jB+j6GwKcPIRivPiX336P3sTySYWtvdyU8ZFjVgd9VwUaKc7/ms=

On Thu, Nov 13, 2025 at 12:04:19AM +0000, Matthew Wilcox wrote:
> On Wed, Nov 12, 2025 at 03:06:38PM +0000, Lorenzo Stoakes wrote:
> > > Any time the rcu read lock is dropped, the maple state must be
> > > invalidated.  Resetting the address and state to MA_START is the safest
> > > course of action, which will result in the next operation starting from
> > > the top of the tree.
> >
> > Since we all missed it I do wonder if we need some super clear comment
> > saying 'hey if you drop + re-acquire RCU lock you MUST revalidate mas state
> > by doing 'blah'.
>
> I mean, this really isn't an RCU thing.  This is also bad:
>
> 	spin_lock(a);
> 	p = *q;
> 	spin_unlock(a);
> 	spin_lock(a);
> 	b = *p;
>
> p could have been freed while you didn't hold lock a.  Detecting this
> kind of thing needs compiler assistence (ie Rust) to let you know that
> you don't have the right to do that any more.

Right but in your example the use of the pointers is _realy clear_. In the
mas situation, the pointers are embedded in the helper struct, there's a
state machine, etc. so it's harder to catch this.

There's already a state machine embedded in it, and I think the confusing
bit, at least for me, was a line of thinking like - 'oh there's all this
logic that figures out what's going on and if there's an error rewalks and
etc. - so it'll handle this case too'.

Obviously, very much wrong.

Generally I wonder if, when dealing with VMAs, we shouldn't just use the
VMA iterator anyway? Whenever I see 'naked' mas stuff I'm always a little
confused as to why.


>
> > I think one source of confusion for me with maple tree operations is - what
> > to do if we are in a position where some kind of reset is needed?
> >
> > So even if I'd realised 'aha we need to reset this' it wouldn't be obvious
> > to me that we ought to set to the address.
>
> I think that's a separate problem.

Sure but I think there's a broader issue around confusion arising around
mas state and when we need to do one thing or another, there were a number
of issues that arose in the past where people got confused about what to do
with vma iterator state.

I think it's a difficult problem - we're both trying to abstract stuff
here but also retain performance, which is a trade-off.

>
> > > +++ b/mm/mmap_lock.c
> > > @@ -257,6 +257,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> > >  		if (PTR_ERR(vma) == -EAGAIN) {
> > >  			count_vm_vma_lock_event(VMA_LOCK_MISS);
> > >  			/* The area was replaced with another one */
> > > +			mas_set(&mas, address);
> >
> > I wonder if we could detect that the RCU lock was released (+ reacquired) in
> > mas_walk() in a debug mode, like CONFIG_VM_DEBUG_MAPLE_TREE?
>
> Dropping and reacquiring the RCU read lock should have been a big red
> flag.  I didn't have time to review the patches, but if I had, I would

I think if you have 3 mm developers who all work with VMAs all the time
missing this, that's a signal that something is confusing here :)

So the issue is we all thought dropping the RCU lock would be OK, and
mas_walk(...) would 'somehow' do the right thing. See above for why I think
perhaps that happened.

> have suggested passing the mas down to the routine that drops the rcu
> read lock so it can be invalidated before dropping the readlock.
>

This would require changing vma_start_read(), which is called by both
lock_vma_under_rcu() and lock_next_vma().

We could make them consistent and have lock_vma_under_rcu() do something
like:

	VMA_ITERATOR(vmi, mm, address);

	...

	rcu_read_lock();
	vma = vma_start_read(&vmi);

And have vma_start_read() handle the:

	if (!vma) {
		rcu_read_unlock();
		goto inval;
	}

Case we have in lock_vma_under_rcu() now.

We'd need to keep:

	vma = vma_next(vmi);
	if (!vma)
		return NULL;

In lock_next_vma().

Then you could have:

err:
	/* Reset so state is valid if reused. */
	vmi_iter_reset(vmi);
	rcu_read_unlock();

In vma_start_read().

Assuming any/all of this is correct :)

I _think_ based on what Liam said in other sub-thread the reset should work
here (perhaps not quite maximally efficient).

If we risk perhaps relying on the optimiser to help us or hope no real perf
impact perhaps we could do both by also having the 'set address' bit happen
in lock_vma_under_rcu() also e.g.:


	VMA_ITERATOR(vmi, mm, address);

	...

retry:
	rcu_read_lock();
	vma_iter_set(&vmi, address);
	vma = vma_start_read(&vmi);

Let me know if any of this is sane... :)

Cheers, Lorenzo

