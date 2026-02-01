Return-Path: <stable+bounces-212980-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNKxEwvLfmmceQIAu9opvQ
	(envelope-from <stable+bounces-212980-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 04:39:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90356C4D8F
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 04:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23F57300DE3F
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 03:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A915279792;
	Sun,  1 Feb 2026 03:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fbbS6wk7"
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ACD1E5B68
	for <stable@vger.kernel.org>; Sun,  1 Feb 2026 03:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769917191; cv=fail; b=GDvez6G72gk8QjNSBgY7fj9NcmmqSSps0+Szjn6ikzflbicY9wMDRb8s6XC9dbUJ+oGE1AvbABmV/MHnoUIEJcTn5jrxaPLcXQbHvTCq40ELOQUUYspXlo/CQuTQnlKHqGsyKASMuvclxTMh16ecrn9iay4/KsU8esQPiwgPSp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769917191; c=relaxed/simple;
	bh=DFiUq31Y79VRvKLY+NbwyUK+LDM0Me9mWVeeSM15b1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eTnq3KcT8BkTd+idGDNfWcnY9ozsKJ4YrGy7WGEPeBd81prbOVCWSYSzjORf23Zo50FcF1XxLnnN+OcGsQWrk6/ntNbtYPA4zbhtbO8p5ugFGJmQy/rwmswRmWuAvQwEUdoiAufzKXcLy0047yyZts7lzFqYanNV0DI6LSqhR1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fbbS6wk7; arc=fail smtp.client-ip=52.101.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zArnZCiSIg8lTqZvm1zagMlQ0qSSPzJtVHne21TH+rFkDbr/7nnWScLYe0YCja7JyDzDhODr3SItc7R0lQJsD7aIp3WrCCnsPZK8Y4O3qWKL6ACiqPkZCwBMF7DwWjbfbuUv4sRngheLptxFd2iD6PpvgVzFo1tVVXma5gGPY+ApGZV/nuZhgNOYoN2TOV7g+xyFh7vsMb9fvaWxz9WZq3+kvNlxWn4ygZd+PgFGCogiWH84Ets170blhFd/g45iTLRJdaDMJ9w5/sZ9V30++t7uBMKbw6YE3+CkS3CXbCj7O/dKuY4utGfZmira+WNJWPH9rAZROEPmtEpRrGKilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kALlBuIcTaA75hrPIwfgEn/gYjSO8L3kht/E+eK9s5U=;
 b=BVllS+kS5mjYrMgBAN3T3kp8hs3iLD82qJFuO619qMWM7dmO1Srhj4NXCQArooE4nxVHfEb1q3EgLA2SsPu90p9mKtvrHrfd9eAD1tVtgPr3zIMuXB4y99YAmtUuDdf5DkoWAP+ZmMRRx1lLeBU7pxpN4i84t6265k1cZxFyGRZX4wLOo68kq+iJqwVyweGlM0O9jm8sDv4OqhzPrXM6e+0pxthe1UkyyCTtIoywvmOT8SqE4begwwn/525ylp1WHUnSWeRFVcE1cVINHyboieLCLOoqO6Z/tdQPFmF/VxMnvlcNoQ8RBGlY4JFpeQBL+8YWkyEJaoYZMLSzaRJBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kALlBuIcTaA75hrPIwfgEn/gYjSO8L3kht/E+eK9s5U=;
 b=fbbS6wk7jfI6yGl7S9AeUm1HLehOHHTM2mCC4n5+BW4VDMplhrg2aqCodsfut3SiHqUFdFGDPqpXb5pOeEkyszYC3Er3HQ2AZFmytL4Ve0JVOZGp5AMdiVRH9/08Hcqf/5kq5hfegikcqLjOBTnZAIpZXs2pCw0HJod4xvpY7v5nDqeCY2Q4orombWhAOY7DCSGpQO06hhT40otPjGB8HWtH9HiPbUkO9Br89OzuKXdmuh2mvSSNukv1LYoJ5DB1H/QzbsVVvdY9auJ3JkxXKc3keiXPCBTWDamva/KQDK5omP6CzzW2y+X/+Ibeo8Hv9PdSsLQKVfPWlXWeLYJUUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB9097.namprd12.prod.outlook.com (2603:10b6:610:1a6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.15; Sun, 1 Feb 2026 03:39:42 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9564.010; Sun, 1 Feb 2026
 03:39:42 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>, david@kernel.org
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 jannh@google.com, gavinguo@igalia.com, baolin.wang@linux.alibaba.com,
 linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix early failure try_to_migrate() when
 split huge pmd for shared thp
Date: Sat, 31 Jan 2026 22:39:40 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <C620202F-685A-4B9E-B51B-078EBE5BF0C4@nvidia.com>
In-Reply-To: <20260201020950.p6aygkkiy4hxbi5r@master>
References: <20260130230058.11471-1-richard.weiyang@gmail.com>
 <178ADAB8-50AB-452F-B25F-6E145DEAA44C@nvidia.com>
 <20260201020950.p6aygkkiy4hxbi5r@master>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:208:329::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a04882-460f-414e-b28b-08de61438938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n1W5QtPdmHPu8s+T0dMMIcMJA0Wuhp0afDyWvheudsnv4/Dll7KIoliZsWhq?=
 =?us-ascii?Q?WtfglnSHI2bR3ftrTl1kroaCe1Q1A6M3ouXp4fZX2FIpKs+S4MaxTOCMSYDr?=
 =?us-ascii?Q?q4ktpF0IqYAv3SumGswS7oiMnLSQ7dDCWDzH5cpLKFl/WiBjx66ZIFEdDHY7?=
 =?us-ascii?Q?J8Rd9BK3fFVDpZ4g8JqjJIb5X5JtkUwoh/eJIXIcSWoO8Du/ARgkRIYFGJ4Y?=
 =?us-ascii?Q?NjGBErdQUcIsAsn9cvy5XmELWt+lXlHlRWLLqL5abhuNWDddjylSLZB5PU2U?=
 =?us-ascii?Q?s89Aogy2zwXpLHIq99s+uhDaJSIQiYNmUYJSFDrUNZ2FoQ9b/28TYU01xjuD?=
 =?us-ascii?Q?l1s0sWnscopd9C0yl6sM+n3SNjyC8suz05q1t9dy1M72rjVBZlbNcoKCq0CA?=
 =?us-ascii?Q?RURFkzef0hbr4ERivI4OVpmngfus4yXWEPD0eBlhQVREa4tTxn49asRB4ttn?=
 =?us-ascii?Q?8RTs7dEqsGPdU3Y65PmCn76JYHyTGib4BhcWdKlRej+Y6nMFLOo365wHvSOm?=
 =?us-ascii?Q?w68SnnPtww4l+JrM0nMwOAT9vpastZDU/tiWK7Auwbmn/3EIcN5ZnvyKAl9h?=
 =?us-ascii?Q?1elSOvSfpDu+1h/ZgRl5avF9xgCEBx9NX4lI10hPxcNnpBpb7CaYQgoLSJQy?=
 =?us-ascii?Q?WD2IWRpuFAnruKPrcV+PHVn+8JqFzsGbYyrbKtkcNAAY8KA8BGSHoeo0TWi9?=
 =?us-ascii?Q?DG4hCdcCwQzpEFZvAKLTQMoqMT//WduYwInNwLCIT2CHQcK1pJEqenn9LXow?=
 =?us-ascii?Q?zsi0jtEUkXwnDOSJDbFBSCCXLBj1Wsy1/is5uXvc/qrhYVcoXiney1ppc1j/?=
 =?us-ascii?Q?kW3TKCSZiamz3tNvpDxLXtDbSFNCRZ/hXcCFQdjl/ipaJ8rGxcxZzgncXdZY?=
 =?us-ascii?Q?nLxNMHqD77MVW972Xg4lj8PJAbDRZx3ZoA7LGJUJ4PvaAvsRs29P2QNkV6z0?=
 =?us-ascii?Q?4mMf5VT0GrHRk+AgEcm7KydQG3ROeDoYj1aydxDw2UDDoUIPn260zVguaRbR?=
 =?us-ascii?Q?Z/En5eUSqkhxx56aGBTHdLcvDBee/afnOiHYH9aWluJnNtugMG02Ky2EZ83q?=
 =?us-ascii?Q?QaAlAFL2A1jxtXK8ZVP/5xqYwJrIVFlZGGSl2MzLvOHfj2zFKiMkCqRHX1hP?=
 =?us-ascii?Q?sP/wakRYRiQ86iy5ywAQzMv19YakIjLrPjbT8AH8u7KBun8F4Qmf3sdKAXyd?=
 =?us-ascii?Q?O0hfa5qEWdX3LJJ6EVUQzuWfRFPEk1zsW6DdsC5co+jST1Yy0F96GzEvwaKO?=
 =?us-ascii?Q?YnP47TRw3VzxMYceoP/hM5m1Yo44vJBhch58iQliAejsEOQ0xqkcDjQha7av?=
 =?us-ascii?Q?PlaBUpKPNFJNuOEs2b6NjGk057/2cpkey0pZpIwj0NuxglJGub+eTO5YF4qG?=
 =?us-ascii?Q?lBr5ZfH60OPzn4YW0I1Fsa5++Zf6N/MMZJ0ZpeqfVIYTn0aQPruK1ZM0rVDE?=
 =?us-ascii?Q?TpE62T5YpeZWQLO8fAUmu4IjzkUY3yvF9RChk0ZKvHTeaJ0VBhWxc0NfD+iX?=
 =?us-ascii?Q?rRMusxX4ZsOfE6vCr0IKgAJVEn1YfDBK89w1b0yB7gJhFTQ4X8187mZMkkBI?=
 =?us-ascii?Q?ETqhusi0MWVcbVcRtPo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dZJgwNB01NSplWqCmsGI4aysMnIX/lRIMvP4/CqjZ5MUduhwtyBtqo3UCHve?=
 =?us-ascii?Q?7nw36pSM6AoG6/bbzimvPC+E8ASiBqGn60ocnYGCVYAXxW/nmjLQBmspZ39G?=
 =?us-ascii?Q?+Z8r9NaPSrrrIGZiHk+TXeIoRuMLSVbYO51Nd2VUaflYTKenCO1GXEs6rm8K?=
 =?us-ascii?Q?fta9MtaecGw3i50wrQH1U4ear5qiYQkaDq6uBZ9uPpTMyKOAyzB4VOf28KUf?=
 =?us-ascii?Q?RM5aAKofHwWI07r/LJ0ZJCp6xmcRfA//ov89Q90AR0j6kdD8nAbbYSjYiuZ0?=
 =?us-ascii?Q?Khlbj2vHXBdPlRiaRZNHdTuq/dCI/eUubyNvVqF+82CsiQtdOBf4/fPaIC5Z?=
 =?us-ascii?Q?Cgd8ap1wlEo3lv82ivPJME3v/NLl5tLFoTtEX72/BkomGXo29WFBdy2/exUC?=
 =?us-ascii?Q?X4FxnA2JGrp6/jw42ARwwP9+TStnAl8+qmoatQMTgavXMr9mtQrZTLDXDS4k?=
 =?us-ascii?Q?0YizLNE987pmIfNGq3SUO0bVPBo4c79EpqXntHyER17PDpX620Mt3PJXrTJX?=
 =?us-ascii?Q?YW7IHZG2n8CxqrV+PGl4bEykXqsibxspDpBckZdR8B7f8rKrm85TIxzl3T67?=
 =?us-ascii?Q?G0quXqllBsG9gwmkKwXeqIo774xDV9aEaLtjI2BW8PdnVW7n6LkqLvKsVxxQ?=
 =?us-ascii?Q?r8dCrH2nn/BeJ1qx1Krzey+xmWKPR6bc+WH5gz4OFXyKu9Ea+9AFYzjgVFiQ?=
 =?us-ascii?Q?tFiO2MEfCuwulyUsYUlxMj32BsTnNkyCNkHXSdkL89JVygyW5zRmYWv8jFIb?=
 =?us-ascii?Q?dSFGyLTYTaHdCxHznJLbw8pFWoeowSU+0R41H8I7rhtnc+3QDbDtFuK6IIwy?=
 =?us-ascii?Q?DYqm8g8ezX49pi041BDpOeQnoePNFO4r+X7eJYiabVS6q15UGtlEN/ThqwI3?=
 =?us-ascii?Q?LgDKUGoSw3JrpNFUJuBJrAG2a4PQaHBA5KlIWTVDVMjFL6LUDzarZFIgSWXF?=
 =?us-ascii?Q?glfA+WkqoEks6OcOp7dXjI2kI00D3tGmK1QtSgm7GzwlKJ3HWk4rnBX+IxIC?=
 =?us-ascii?Q?QyYLVzDtXdlqZ0f5ksLXx6/cIY90EWiipAiCLzKDiU/beBEbyD72MYSPjzCX?=
 =?us-ascii?Q?7mX1cTXo4TPI0rc961g3Kk+VK0LVILgEPwYcqwzJAq4Qd9PoEa45AJHwyFK7?=
 =?us-ascii?Q?ifQMVOvZbpv/3ssohOUDB+MCICDW7heljh+/DuThHWdu/ABMynKk/tr3U8BH?=
 =?us-ascii?Q?yJEUvRJs5YF6NE2CoAg/y3+pSjxJLU6H9v6zr0wW6riYsAr/RRzDGt/PYfZM?=
 =?us-ascii?Q?zhIsxwajwDtB3l88IX6JTgS2iOWgvjSHqvLAJDh9R3jEYR7mNWVkHcFipt3b?=
 =?us-ascii?Q?sBNE2JaIf/Fd2WR2kYbe2Has5WF/cSE1ZHS4/Lyo+9xsq3/BwKr7b41wH+D3?=
 =?us-ascii?Q?3mvHoekrDwenwkCwxWbs4D5NYXpWLYBl+inyKN/o/+sWy6r64LzlYiodbJD8?=
 =?us-ascii?Q?OPSMWVBaCoIDeqkAKYuLgBjWoHEMai9RDRVpMB9eBk4Ppk4jYZKfFg7HpHFL?=
 =?us-ascii?Q?9IOhonhHng/AesPvClwcLNpZgaBqfwcylr45sFY11aeoOWXEL6yXskvgas/6?=
 =?us-ascii?Q?16zBVL5ryIneUM9mROieIxMaobxgKxYgMzHIYy5GDVCfGynyra8HJ0/YY3xQ?=
 =?us-ascii?Q?7+4sPiRxpL7mlYswgoY4MTeIdlBGFnrsRIehExF6vP9tTqXml/wjKBTCamaV?=
 =?us-ascii?Q?3NIiXRY0CKe6W3VhTgySVHQNiQ0IhuVnB/UL7NQamfh7sH63?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a04882-460f-414e-b28b-08de61438938
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 03:39:42.7224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNmxlaftx3pECG+355O4VW5m41Y4uHZVouKmoq1At/O0IPqem1jr7bwOGcHy6gts
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9097
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-212980-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email]
X-Rspamd-Queue-Id: 90356C4D8F
X-Rspamd-Action: no action

On 31 Jan 2026, at 21:09, Wei Yang wrote:

> On Fri, Jan 30, 2026 at 09:44:10PM -0500, Zi Yan wrote:
>> On 30 Jan 2026, at 18:00, Wei Yang wrote:
>>
>>> Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and=

>>> split_huge_pmd_locked()") return false unconditionally after
>>> split_huge_pmd_locked() which may fail early during try_to_migrate() =
for
>>> shared thp. This will lead to unexpected folio split failure.
>>>
>>> One way to reproduce:
>>>
>>>     Create an anonymous thp range and fork 512 children, so we have a=

>>>     thp shared mapped in 513 processes. Then trigger folio split with=

>>>     /sys/kernel/debug/split_huge_pages debugfs to split the thp folio=
 to
>>>     order 0.
>>>
>>> Without the above commit, we can successfully split to order 0.
>>> With the above commit, the folio is still a large folio.
>>>
>>> The reason is the above commit return false after split pmd
>>> unconditionally in the first process and break try_to_migrate().
>>
>> The reasoning looks good to me.
>>
>>>
>>> The tricky thing in above reproduce method is current debugfs interfa=
ce
>>> leverage function split_huge_pages_pid(), which will iterate the whol=
e
>>> pmd range and do folio split on each base page address. This means it=

>>> will try 512 times, and each time split one pmd from pmd mapped to pt=
e
>>> mapped thp. If there are less than 512 shared mapped process,
>>> the folio is still split successfully at last. But in real world, we
>>> usually try it for once.
>>>
>>> This patch fixes this by removing the unconditional false return afte=
r
>>> split_huge_pmd_locked(). Later, we may introduce a true fail early if=

>>> split_huge_pmd_locked() does fail.
>>>
>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>> Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and=
 split_huge_pmd_locked()")
>>> Cc: Gavin Guo <gavinguo@igalia.com>
>>> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>>  mm/rmap.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 618df3385c8b..eed971568d65 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -2448,7 +2448,6 @@ static bool try_to_migrate_one(struct folio *fo=
lio, struct vm_area_struct *vma,
>>>  			if (flags & TTU_SPLIT_HUGE_PMD) {
>>>  				split_huge_pmd_locked(vma, pvmw.address,
>>>  						      pvmw.pmd, true);
>>> -				ret =3D false;
>>>  				page_vma_mapped_walk_done(&pvmw);
>>>  				break;
>>>  			}
>>
>> How about the patch below? It matches the pattern of set_pmd_migration=
_entry() below.
>> Basically, continue if the operation is successful, break otherwise.
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 618df3385c8b..83cc9d98533e 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -2448,9 +2448,7 @@ static bool try_to_migrate_one(struct folio *fol=
io, struct vm_area_struct *vma,
>> 			if (flags & TTU_SPLIT_HUGE_PMD) {
>> 				split_huge_pmd_locked(vma, pvmw.address,
>> 						      pvmw.pmd, true);
>> -				ret =3D false;
>> -				page_vma_mapped_walk_done(&pvmw);
>> -				break;
>> +				continue;
>> 			}
>
> Per my understanding if @freeze is trur, split_huge_pmd_locked() may "f=
ail" as
> the comment says:
>
> 		 * Without "freeze", we'll simply split the PMD, propagating the
> 		 * PageAnonExclusive() flag for each PTE by setting it for
> 		 * each subpage -- no need to (temporarily) clear.
> 		 *
> 		 * With "freeze" we want to replace mapped pages by
> 		 * migration entries right away. This is only possible if we
> 		 * managed to clear PageAnonExclusive() -- see
> 		 * set_pmd_migration_entry().
> 		 *
> 		 * In case we cannot clear PageAnonExclusive(), split the PMD
> 		 * only and let try_to_migrate_one() fail later.
>
> While currently we don't return the status of split_huge_pmd_locked() t=
o
> indicate whether it does replaced PMD with migration entries successful=
ly. So
> we are not sure this operation succeed.

This is the right reasoning. This means to properly handle it, split_huge=
_pmd_locked()
needs to return whether it inserts migration entries or not when freeze i=
s true.

>
> Another difference from set_pmd_migration_entry() is split_huge_pmd_loc=
ked()
> would change the page table from PMD mapped to PTE mapped.
> page_vma_mapped_walk() can handle it now for (pvmw->pmd && !pvmw->pte),=
 but I
> am not sure this is what we expected. For example, in try_to_unmap_one(=
), we
> use page_vma_mapped_walk_restart() after pmd splitted.
>
> So I prefer just remove the "ret =3D false" for a fix. Not sure this is=

> reasonable to you.
>
> I am thinking two things after this fix:
>
>   * add one similar test in selftests
>   * let split_huge_pmd_locked() return value to indicate freeze is degr=
ade to
>     !freeze, and fail early on try_to_migrate() like the thp migration =
branch
>
> Look forward your opinion on whether it worth to do it.

This is not the right fix, neither was mine above. Because before commit =
60fbb14396d5,
the code handles PAE properly. If PAE is cleared, PMD is split into PTEs =
and each
PTE becomes a migration entry, page_vma_mapped_walk(&pvmw) returns false,=

and try_to_migrate_one() returns true. If PAE is not cleared, PMD is spli=
t into PTEs
and each PTE is not a migration entry, inside while (page_vma_mapped_walk=
(&pvmw)),
PAE will be attempted to get cleared again and it will fail again, leadin=
g to
try_to_migrate_one() returns false. After commit 60fbb14396d5, no matter =
PAE is
cleared or not, try_to_migrate_one() always returns false. It causes foli=
o split
failures for shared PMD THPs.

Now with your fix (and mine above), no matter PAE is cleared or not, try_=
to_migrate_one()
always returns true. It just flips the code to a different issue. So the =
proper fix
is to let split_huge_pmd_locked() returns whether it inserts migration en=
tries or not
and do the same pattern as THP migration code path.


Hi David,

In terms of unmap_folio(), which is the only user of split_huge_pmd_locke=
d(..., freeze=3Dtrue),
there is no folio_mapped() check afterwards. That might be causing an iss=
ue,
when the folio is pinned between the refcount check and unmap_folio(), un=
map_folio()
fails, but folio split code proceeds. That means the folio is still acces=
sible
via PTEs and later remove_migration_pte() will try to remove non migratio=
n PTEs.
It needs to be fixed separately, right?


>
>> #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>> 			pmdval =3D pmdp_get(pvmw.pmd);
>>
>>
>>
>> --
>> Best Regards,
>> Yan, Zi
>
> -- =

> Wei Yang
> Help you, Help me


--
Best Regards,
Yan, Zi

