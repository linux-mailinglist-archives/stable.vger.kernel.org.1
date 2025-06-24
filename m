Return-Path: <stable+bounces-158377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 638BBAE6323
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 13:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8661925253
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 11:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6979288C03;
	Tue, 24 Jun 2025 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z8ISugQf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pSRUaaZo"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D57286430
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762837; cv=fail; b=lZXUmU5gD0yFVJaTEjK/6KB2iCA7IG8oth6BJwRlrQdpah87rOoRjOlo42VNii6aj5F8n6H+nmyk+SGXp+hhi1Gz16kR5dU0JfmYifZiU5DU2y/DcBT3fDDEejj08sHOwoZImIGXl1F64DnDNoGZoNlipa5IF46Ndodc5/JTGhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762837; c=relaxed/simple;
	bh=ysEOYoa1yjA8WV6M/Ntv195noAhZFZjPBk9qR2GCkTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lvh7UdfG/uvuoNlVR/eR3K2NURJppsPD5lmhhfK3i7KoBcMe3Ckn64MmEyzSxSlKiOQ3l6VonvWChNlXbgcN9t4nuKWny5o53SKVWzkNK+vlB+l7G9r/K/dyi9VuA69KiIeaFvqJmle2ddC0cs5d/ZTIMNVyb8IJ7OF+b7KcYK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z8ISugQf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pSRUaaZo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O8iclO008253;
	Tue, 24 Jun 2025 11:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=fFS19/lASDH8DwdOJ7
	gj925bdvd1AjtimebgqpKDHnk=; b=Z8ISugQfhn/SupTfRjdxbxWQV84vAGS3t7
	lCJ9Hr2Uq1hLsI68RNTUqthsONhvP/PW1nnlYr60nTJpKfaWsOVZoLFG9pHdVTYx
	2LpYp5X+9tP6TBJp+JkMv8e459T16kNyEcbBnThT83ux1ImtEEq6KxWkL1ta5Itg
	2EoLOX1jLZw3r44bb1s/WF6wgPXItA77f7rca3xOkcR1pK2yBezv79WX9wYgly4u
	R4WxHlZjGrW5KRLZMDQXgBS+a/CVAQRPZrxb3CixstdebDDlDqGlJzIpft40CTxQ
	ItLVwMaZKEy8r7AJEaZmgwpv0VC0Gh6YO5m8h/TiR9WXVmaa43wg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt1bqf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 11:00:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55OAP3cF025119;
	Tue, 24 Jun 2025 10:59:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehvw0985-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 10:59:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYKi6vLV9TbqpXpv+Q0CWWv/RVDXWyDBNxXHl7OWJtlr+w3JQM7IPmj5WlMOTHvTRfZHOAft/s3MckQzn4sPiu1+s6EcB+cA3ZpEnviY55VZntL39TkpKWJHDvKK+d16cbtgPs5nklDwxgzYl1MGUczNBEgHaMHxK4jHrOZP6p4T/NKP6SSu2hW9f/XroJjhB9YSO5270Qy2Sf/uOUYY/YS/u9fFkSZ3HW11ZbxZkEKglN5kl9041z8SPy/JYMWf6sjBMhzdx1WLLjPZ9/ElvPbV9RCPlQ0wAQc2t3FobqIaZmJG8pfHZjjMfPaZHbsCwEM7g3vwLlN1DJwe20u/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFS19/lASDH8DwdOJ7gj925bdvd1AjtimebgqpKDHnk=;
 b=PcKhrvYA84BQE8/nVM6sO/28DPUs1T4EtRgmWJDXctQtyWtUrOf6bpr1bjRrQj5O3SjccRZMRNQPXVVeTOPjGWJzJwiVftj0isA1R4nIpqzDz0qe5rocytwNPByZGwqxuPq3MS64S0UlsYv4gf/KS/aRJUeIaWj7B9yenCzdfi9pKqWhZppi8uiEKeO1XdtVdNBIslGLbSUXKvexw+cKq0qdgGpBX9lITgXo0KboZPwCTzSydYDSw3FNewOxMK18QbHvdCuEMMtrcHdMYxViHAgjVrtaQFTO2eahQMKImn4h9zQlP/E50RQCm86tgkKoTRPg2nXrmGBXtDJ7jH1Z9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFS19/lASDH8DwdOJ7gj925bdvd1AjtimebgqpKDHnk=;
 b=pSRUaaZoQLPS2n1TgatN0dCeu2bP8ehYmnal8iliJQWbPhbO5u4rQOdWDeWZ92pCWgw3cY+H4auWlzTtGv74Q3O+wtxV4ozhnNUggwEP2PhobHBD9v+fVJXrJ5EezdSIC4ZoYAEwBAb8Ztd1CwsnPwDPJhdHEuqyyqx8CYp1fSk=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA1PR10MB5688.namprd10.prod.outlook.com (2603:10b6:806:23e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 10:59:57 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8857.025; Tue, 24 Jun 2025
 10:59:57 +0000
Date: Tue, 24 Jun 2025 19:59:52 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: David Wang <00107082@163.com>
Cc: akpm@linux-foundation.org, surenb@google.com, kent.overstreet@linux.dev,
        oliver.sang@intel.com, cachen@purestorage.com, linux-mm@kvack.org,
        oe-lkp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3] lib/alloc_tag: do not acquire non-existent lock in
 alloc_tag_top_users()y
Message-ID: <aFqFKLpkfbduVoAy@hyeyoo>
References: <20250624072513.84219-1-harry.yoo@oracle.com>
 <4f12c217.7a79.197a1070f55.Coremail.00107082@163.com>
 <aFprYu5H_ztouxw2@hyeyoo>
 <23eb5af1.9692.197a145e5c2.Coremail.00107082@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23eb5af1.9692.197a145e5c2.Coremail.00107082@163.com>
X-ClientProxiedBy: SE2P216CA0131.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA1PR10MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: 5765fb3c-8cf8-4f75-c206-08ddb30e41f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ir/5LwBykWaHK1I2D/a50UYzn88JQOZ2KQiMgyqNa6zTJihTs2Gb5eZpjAHQ?=
 =?us-ascii?Q?eY6bOLwZPR13efh6ownZwyZ/0hAAZiaKtqpdQr7DP3bX2Z+AJoGG3iUjKx5H?=
 =?us-ascii?Q?lt+1lCexKYbsiIbqiVDVGrf2ZwJPHwGNVYB6L2qN1KzSSaGUjO633ioejVRW?=
 =?us-ascii?Q?7cmAzclwmAkWRrfgQjajdU6wnFPE5Kk9QpDW/JaglvhAEWJscDP+mA4AvSsv?=
 =?us-ascii?Q?BFH4psnLCWV1o2tqo/qOVaFKtVw88mYXRrBWXzP8lUZJCj8DMH1PbyyhJdUW?=
 =?us-ascii?Q?vsHvGc3OuvIH/irbQwAqykPOZKcnHQnmMY5vaTpoGy/u5SEEOEODq7R1LjKZ?=
 =?us-ascii?Q?Xq7pAD9jrXW/xY0WHR4x7v/BY70gdU5MtLQVj5aLZ6FypmuaHmurTeFZWKNr?=
 =?us-ascii?Q?I1fPMdo7MIc39s1NTr4YmlgDZudBo7QSFUCJK74oMXMDqogHdS7bu+dJ9sHn?=
 =?us-ascii?Q?ByPGDXjOs2srMmPvfwyvcExJfqpZ9Kpz/kLG9SDthzPXS7Gz4Ug2VCixUIBf?=
 =?us-ascii?Q?6xW3wwUEgfGzE9htqjrgvRGMgcHUT2P7r9Ogy1kqfxoRKtu+btpu5XKkqbve?=
 =?us-ascii?Q?yqPYuiIbCN9uzkmP1Ps9bK/dd0AQpYvqSetOlS+IyNEp/ST/VN29ljFPdsdR?=
 =?us-ascii?Q?H1UKCG7ReGKtHpQV/YYgBYiGmC1qcIUWNi3v2OjfedDzGg+vvIQ8sFFGrfY6?=
 =?us-ascii?Q?Ggr+TWNrCtfJ/3qwYdFJf3jhuDgBl5I0eLUrl5sh4+b5SvTm50Hx21/UQePn?=
 =?us-ascii?Q?Y+MZuRu0Pcgg5+OB2PWqjMTcb33/trUafn26R0Niq+ZdXpSgeM4ot+VS0euF?=
 =?us-ascii?Q?jwLXw3xOR4rADz5gmuLihxAlbKHgiEH4UKRLmAogbt4yKAQ/p0T/LL9kLBfX?=
 =?us-ascii?Q?Z+PHDrRR24hYV+mRhhEn7wi4QkpnnP74ueBsrq5lw0hOSPCx+Qrm8mJ9bLNx?=
 =?us-ascii?Q?K9XvbAp2De/AugoDmzsycwm2P2BiwhgPcb96aKJiVfIwpwQyCesPuene0Jty?=
 =?us-ascii?Q?DzOvoEnFw/+dpKaYBhypFGZvw2I+JzB1Bi3E2x+bgpjQwERbaQLZr6HifPZS?=
 =?us-ascii?Q?l5jcXY+WqsiNFbjq3DYpVR6vrMXkbATHo4kDueWHXlWjSQyNofNgztbI5eZT?=
 =?us-ascii?Q?OiVTGmw1TJGSGvINpQr5Ty/OCjG4C3Byr0JvBHxgVxAGpto3K+Ij5Pp+yLpC?=
 =?us-ascii?Q?57nHx7DARxAUm5SlyoEvjABNWg/NFqIsI6hUZb96LgSMh9Cre5jeMHfQ9JBW?=
 =?us-ascii?Q?nXm2QFYDxZcw4+XkTOyLh5mTwgGSTNIWPEWEJDCNljKyOpaJ6ZNmcKoBhcgO?=
 =?us-ascii?Q?AOf+08U8fML74xS8BvwRO5KqnlKulswqAVnLJeTcn0oL2tnCJolPibhkt8ma?=
 =?us-ascii?Q?6cPgj/aTO1pDuQKiJ80OeRZEzOBnjnAjaCDeEgIeQXn6tGQdsq6sEKPxXM8Q?=
 =?us-ascii?Q?mto8v3N/FEc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b/UqP8+XDDxJ7F/Y99mpv9zl3ptGkKuh8N+t2o9HOxZ3NreEL2hjhw6ikwAV?=
 =?us-ascii?Q?FH9JesbmelIXr2IgDDoe4w1P4oGRT6kNVrYwFrjIQaZUxaKAM2H8sQNZiQT1?=
 =?us-ascii?Q?h3WKIHSqDsGspguHKCPOSG1P6/QBChCI9PkuyrQpDWUOI3ysF59VFcaPXDAb?=
 =?us-ascii?Q?nVrq1NRyRdWT5DtZ8tqabuLzzkWcRt9mBEPQdlxJoAs26s2AkuclwmBzQMdm?=
 =?us-ascii?Q?STbXmSZShZm3//Si86EM5G6s+Er0J9XmVuG8yViNhFMEidq8cS1N30JSDcl7?=
 =?us-ascii?Q?CQ+5hPL/Ar6HptKNtUSBGty7qbu8eNw0lhoKwfLI518HqAcXkOJNvwguYfcb?=
 =?us-ascii?Q?zPd0PzZGPxIdW9jPL+15ugcUmuzaNNjytWSyBPmUpUBERp7950QwZvxCGrg1?=
 =?us-ascii?Q?VrvDjK4CQcz/onAcSyXbOfxoaJNnGKJyMolO6YWte1efroeS37T9NazCQYBF?=
 =?us-ascii?Q?MgMGmzq5IMI8F1LcaKcOCJgKTyNmCU/2a9/dznKLaDEGJxoh9cLz+NNYlaPK?=
 =?us-ascii?Q?v11+t790yjzg+156RTLiq/KlZcfnyQvGyPTF7z68gSK4+TEsEpg0mJekduaP?=
 =?us-ascii?Q?h8seY0S+gVAImnXRJHnUmRxwTZrpsxWVJ+GJyW4eAfedxanaGr/jnthH9aok?=
 =?us-ascii?Q?GeDo5BOGECWQTEehqjzB1kboA5dzPBIJGcph2bDxdXyYgOxoB+KBIoAk/RM3?=
 =?us-ascii?Q?CYAsmMLwBaXUT/Ta1VasX50t+/1qcg1GwIuLjNvcsSjRBssAeXBC1xmT8AEY?=
 =?us-ascii?Q?H1XZMRWxb56BKYhxHMECCzgGJRgXqWNKu2R/YCZgtAra4EWie/EiDhMNtc/T?=
 =?us-ascii?Q?2TBGeBAUhehVS6JcWgtyXNn6hDshYEswzf+uj1ftq5AJS5OyqaR2OQEFJkNG?=
 =?us-ascii?Q?tI8Ar5sdr+lR3mYfBUk+9a3MlqMyZXjuDo83zmP3gzeQaNN3HnuE3SfFGXFG?=
 =?us-ascii?Q?BRySZWeHA9OuBtWTozR0G2sKEeLGmWHKw0zM4RMzN4mRR7LP0oDYe6WIvWJh?=
 =?us-ascii?Q?qXFv3hwrBnCSM+jxh633f4ya1CXIKrV67XBQ0F89sAKuKap1DxGJC5jMMUKf?=
 =?us-ascii?Q?0Z5nmjIpvoVvZUyBeg/FK3NCB6yq1bGXboYT4p1xCsotVkEFE+qORtQcnkpI?=
 =?us-ascii?Q?0WGA+BnBFm6OA0v2eYwHue+z6xX/62J8yBZD2GJJOuSe4CS6IW0EYX3eZzjq?=
 =?us-ascii?Q?gm8cmSSUlFi6nlW9NKqDlbJCO4Cg0IQxndc4R1ODunbrUwrm4Z0LwgOl73GM?=
 =?us-ascii?Q?HgHOnhFTvnmwhBzYvdwhpQU8zCCyLeg6AnznHlSwyydH8QXz+qYQe44dzNHZ?=
 =?us-ascii?Q?xbBXmeSm8P86TcX9aiCG9xN2LcwFMxmw3W5JGynFLLSMEAM/L37O5eQAi6do?=
 =?us-ascii?Q?GNikRQ466GMzqfRWSSz6boE77r7+TKtUxAWx4ZoJLiJqSaywyvXdaTH4p+Q9?=
 =?us-ascii?Q?OPlTmetq0m2/VHPrnoe9S0wlQxWHycHP0J37rdQrUQL+9s9qR8FZ3A0ymTiF?=
 =?us-ascii?Q?+RuqTLMwv0/4HhBAbLekkeX9gHju5jWMM8V6ZLKxX4p7uy3lS6xAyw0QOUYV?=
 =?us-ascii?Q?RybXXcHuSb8rdBHx1ZbPb/+ORwJG4Wq+Q4cNia+a?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SI4yO445asGdA2Ez+ohpwaPxqwKZf6kJ51TLaWIpoxkJUF7GT7zxtexKnt+w/A5y9bRXN0VN57vz/6/gYdaiLQbC0TMrtrcDWmYr7ZZaXLHr5vc6r9XPJxtlTLgD04qmaDd2wrltDq0glDB4pvNTfi0ceWhCSw8wCtpCUF7sVZDkbiEwM4uklTJfGRzNlFt1VAoiQdCJf1T1UVs6RpI4nzujDPjtp6N8UzLPEh2Pmr9eIfz/8NTW4mutrsLVnSpYq6e9TyvZhapY2mc3C//2PyQ/K/EbwYG3WqxBY3IbwqRVIQ00d3nrrwkyhx+D9wQvJ609BniNsL7XYb9TFn3KoKwUGElKWv5OoLk8hRooWzwXmeqeZIihPnrqMTNUdOSpt4H8xEuF//Y4XTJiYcI7eKnAlMitDS02NpcfAvIM3oGCvbASwDzW/jgz1WxkShhUbl75eLSZtYsRNywMS+llS8heve3mHu9xmDY3HEMp8y1Lbj9SiQU7ei9ufMZLNXltU4qX/LkWAP105bm0CjzRh66xWt2M6My/Q/Qro7lwtFGL7tyFLhfMK8TzzTvVc/PXRZgWVtPHoiTKiPRYjWiKvS+SbK2FxqU6N6wlfYUPio0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5765fb3c-8cf8-4f75-c206-08ddb30e41f3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 10:59:57.5809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9ti2X2i09yYiiI29N5bBq/O7i7bJnX9glXRi99EfOsHlios56IBntcyhZ6Uslj8hA8Cvd6qTfRgeTSOJf8z8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_04,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506240093
X-Proofpoint-GUID: XqquAgVOVn-SX2go6uWQLRE8Fm2Oq6f5
X-Proofpoint-ORIG-GUID: XqquAgVOVn-SX2go6uWQLRE8Fm2Oq6f5
X-Authority-Analysis: v=2.4 cv=cpebk04i c=1 sm=1 tr=0 ts=685a8530 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=kuw8PXs_DZxZli7PUSUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA5MiBTYWx0ZWRfX/193RhOHOaBG TGOJ9k5dXofTXKyiD8AQzi2CkfdT/33m61vka18MHHDvh4HBC9Y/9dnpJLLofvyJCcGopPZWK2D eWdHzdoIa8328286XX5Y66+F+jnUMbvIYq6lRyABsFGl8S1FfkFceBrlRyXR3BY4nxbRsZtGoFE
 sCieXH78TIgO6Um8CZpWV9aSzTGOfzoK3hoyvS+GHiIOf8okWn3bS+uyIne3Mzx7noOcIYykQCS dstmIQGUiVKnwFZ16l5V9IAC3fuon5tUz80kAWHf8SJo1KyKwSa+uHGMm0/atQHft7nHEQoQOrK ZsbOjGyjCWDJerHuxJDqoPrjNVdOuT5h1LWUXL/UDBx1bKDvVyki+u4cS6WXlXGqfRTgf1E7g/5
 vSaFRb4cuojiwTT3k71sNXqeHdjG1Smcp177Cqi80bi2a98NPjjK6UYxNPfuREUq7Ih/8b6x

On Tue, Jun 24, 2025 at 05:30:02PM +0800, David Wang wrote:
> 
> At 2025-06-24 17:09:54, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >On Tue, Jun 24, 2025 at 04:21:23PM +0800, David Wang wrote:
> >> At 2025-06-24 15:25:13, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >> >alloc_tag_top_users() attempts to lock alloc_tag_cttype->mod_lock
> >> >even when the alloc_tag_cttype is not allocated because:
> >> >
> >> >  1) alloc tagging is disabled because mem profiling is disabled
> >> >     (!alloc_tag_cttype)
> >> >  2) alloc tagging is enabled, but not yet initialized (!alloc_tag_cttype)
> >> >  3) alloc tagging is enabled, but failed initialization
> >> >     (!alloc_tag_cttype or IS_ERR(alloc_tag_cttype))
> >> >
> >> >In all cases, alloc_tag_cttype is not allocated, and therefore
> >> >alloc_tag_top_users() should not attempt to acquire the semaphore.
> >> >
> >> >This leads to a crash on memory allocation failure by attempting to
> >> >acquire a non-existent semaphore:
> >> >
> >> >  Oops: general protection fault, probably for non-canonical address 0xdffffc000000001b: 0000 [#3] SMP KASAN NOPTI
> >> >  KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
> >> >  CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G      D             6.16.0-rc2 #1 VOLUNTARY
> >> >  Tainted: [D]=DIE
> >> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> >> >  RIP: 0010:down_read_trylock+0xaa/0x3b0
> >> >  Code: d0 7c 08 84 d2 0f 85 a0 02 00 00 8b 0d df 31 dd 04 85 c9 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 6b 68 48 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 88 02 00 00 48 3b 5b 68 0f 85 53 01 00 00 65 ff
> >> >  RSP: 0000:ffff8881002ce9b8 EFLAGS: 00010016
> >> >  RAX: dffffc0000000000 RBX: 0000000000000070 RCX: 0000000000000000
> >> >  RDX: 000000000000001b RSI: 000000000000000a RDI: 0000000000000070
> >> >  RBP: 00000000000000d8 R08: 0000000000000001 R09: ffffed107dde49d1
> >> >  R10: ffff8883eef24e8b R11: ffff8881002cec20 R12: 1ffff11020059d37
> >> >  R13: 00000000003fff7b R14: ffff8881002cec20 R15: dffffc0000000000
> >> >  FS:  00007f963f21d940(0000) GS:ffff888458ca6000(0000) knlGS:0000000000000000
> >> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> >  CR2: 00007f963f5edf71 CR3: 000000010672c000 CR4: 0000000000350ef0
> >> >  Call Trace:
> >> >   <TASK>
> >> >   codetag_trylock_module_list+0xd/0x20
> >> >   alloc_tag_top_users+0x369/0x4b0
> >> >   __show_mem+0x1cd/0x6e0
> >> >   warn_alloc+0x2b1/0x390
> >> >   __alloc_frozen_pages_noprof+0x12b9/0x21a0
> >> >   alloc_pages_mpol+0x135/0x3e0
> >> >   alloc_slab_page+0x82/0xe0
> >> >   new_slab+0x212/0x240
> >> >   ___slab_alloc+0x82a/0xe00
> >> >   </TASK>
> >> >
> >> >As David Wang points out, this issue became easier to trigger after commit
> >> >780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init").
> >> >
> >> >Before the commit, the issue occurred only when it failed to allocate
> >> >and initialize alloc_tag_cttype or if a memory allocation fails before
> >> >alloc_tag_init() is called. After the commit, it can be easily triggered
> >> >when memory profiling is compiled but disabled at boot.
> >> >
> >> >To properly determine whether alloc_tag_init() has been called and
> >> >its data structures initialized, verify that alloc_tag_cttype is a valid
> >> >pointer before acquiring the semaphore. If the variable is NULL or an error
> >> >value, it has not been properly initialized. In such a case, just skip
> >> >and do not attempt to acquire the semaphore.
> >> >
> >> >Reported-by: kernel test robot <oliver.sang@intel.com>
> >> >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/202506181351.bba867dd-lkp@intel.com__;!!ACWV5N9M2RV99hQ!PxJNKp4Bj6h0XIWpRXcmFeIz51jORtRRAo1j23ZnRgvTm0E0Mp5l6UrLNCkiHww6AVWOSfbDDdBwKgJ9_Q$ 
> >> >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/202506131711.5b41931c-lkp@intel.com__;!!ACWV5N9M2RV99hQ!PxJNKp4Bj6h0XIWpRXcmFeIz51jORtRRAo1j23ZnRgvTm0E0Mp5l6UrLNCkiHww6AVWOSfbDDdC-7OiUsg$ 
> >> >Fixes: 780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init")
> >> >Fixes: 1438d349d16b ("lib: add memory allocations report in show_mem()")
> >> >Cc: stable@vger.kernel.org
> >> >Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> >> >---
> >> >
> >> >@Suren: I did not add another pr_warn() because every error path in
> >> >alloc_tag_init() already has pr_err().
> >> >
> >> >v2 -> v3:
> >> >- Added another Closes: tag (David)
> >> >- Moved the condition into a standalone if block for better readability
> >> >  (Suren)
> >> >- Typo fix (Suren)
> >> >
> >> > lib/alloc_tag.c | 3 +++
> >> > 1 file changed, 3 insertions(+)
> >> >
> >> >diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> >> >index 41ccfb035b7b..e9b33848700a 100644
> >> >--- a/lib/alloc_tag.c
> >> >+++ b/lib/alloc_tag.c
> >> >@@ -127,6 +127,9 @@ size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sl
> >> > 	struct codetag_bytes n;
> >> > 	unsigned int i, nr = 0;
> >> > 
> >> >+	if (IS_ERR_OR_NULL(alloc_tag_cttype))
> >> 
> >> Should a warning  added here? indicating  codetag module not ready yet and the memory failure happened during boot:
> >>  if (mem_profiling_support) pr_warn("...
> >
> >I think you're saying we need to print a warning when alloc tagging
> >can't provide "top users".
> 
> I just meant printing a warning when show_mem is needed before codetag module initialized, 
> as reported in https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/202506181351.bba867dd-lkp@intel.com/__;!!ACWV5N9M2RV99hQ!J2waTUro8owaYlpAZJ6fnrHZvcGMbY6qAO5QvvIGZzUv-ryWjCjhO-maTOolfpPvPSr6CpqOgkRalCwJow$ 
> where mem_profiling_support is 1, but alloc_tag_cttype is still NULL.
> This can tell we do have a memory failure during boot before codetag_init, even with memory profiling activated.

Ok. You didn't mean that.

But still I think it's better to handle all cases and print distinct
warnings, rather than handling only the specific case where memory profiling
is enabled but not yet initialized.

Users will want to know why allocation information is not available,
and there can be multiple reasons including the one you mentioned.

What do you think?

> >And there can be three different reasons why it can't provide them:
> >
> >1) alloc_tag_cttype is not ready yet or mem profiling is disabled.
> >2) the context can't sleep and trylock failed.
> 
> This case is not just about warning, it is a bug if possible.

Why do you think it is a bug? If trylock fails, alloc_tag_top_users()
returns 0 and do nothing.

> >3) alloc tags do not exist.
> >
> 
> >-- 
> >Cheers,
> >Harry / Hyeonggon

-- 
Cheers,
Harry / Hyeonggon

