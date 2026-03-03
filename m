Return-Path: <stable+bounces-222845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA/PExW0pmk7TAAAu9opvQ
	(envelope-from <stable+bounces-222845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 11:12:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ECD1EC74C
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 11:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1333310B400
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 10:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42C838C408;
	Tue,  3 Mar 2026 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YumnPj7V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VLQN/h8X"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAA639448A
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532559; cv=fail; b=IjBBGn0ltC31wRqvVkDKsdbgamnrUrGZ5cGhD+pekIYj4nQUHfx1u+FL7PJuGC4f5uXnRmYm1U2PYFaCNMYDo0+IgqRj7EDEOTUN54P3Hf2qPi62rbKHfnHDAox8FIS4Lx6h34zeG0ynGy4gt7nvzM7UAoDxVGoTHp53ilEnPrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532559; c=relaxed/simple;
	bh=LKjtQ2OGcOtyNsUNFA2Oqifkm73DdkuK5dTBbVO/6CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gIYdEl0ftpyfYue6YrJlXEMkLdFuPNTxjhYWkOEw4bBdCuPSLwJCArQq0Yj7DeE3qxN7pTGmdM5hHUMHk5P03fmcB7PdPJ9Ypk7nIXTFkx14NfeYrgxGfYqUz9N2YNxmLEiLJxAsJG4InwmIUreOtYuIDIq7uf6EMc/SuzvKpSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YumnPj7V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VLQN/h8X; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6235WlR1924969;
	Tue, 3 Mar 2026 10:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=NVV3YJ36nD2EeEicIi
	bu+jU6nLuP5r7uEYGLlzvHA3I=; b=YumnPj7VgjgdOKAzkNAxbNfBxmLllGRhRP
	x64Kdcdc42YSfd9792DXBd7dm4MVH0qA4nmzaME5+pJyjglW8S/QSlVLCDGluUNu
	a/hon6cs11BBmssQEr/0rNzZbRMnEmbFHiALusGWSfNqHspRHt40SOb1D2v0ZZty
	xT2YU55hDRuFOpTuy63TmlGoTKkZOMHcgtF1Hffnx+yZ+sDNeXlGY+Y28+N7xe1k
	kW5UedjhmHFUytTRAmNtRnLGMCEFx3BxscqTZy9Hzriw96m3edLn1ClzCfqEs46o
	bQim2etzpJkes5KVNggjld0l0Vnj3o/1kjgtMf0qteqmLYjDJyjg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cnky3rp27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 10:08:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6238E0FP037783;
	Tue, 3 Mar 2026 10:08:39 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptedtaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 10:08:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zw5vQ1NM1ng0UKGfX/Y/gD3TIYjFQ8nBd/FIrLNXd78KKBb32hYcAeKJPzn1b+EK2TOMqEQKs2SMZGyJJ2pcNnk2tF28q9FkUa/feJhGd+QWwCImdiKeGPjQDzRuOaNILlEXte4ogQ4hjw6fAOaxzNvc6ZQ4+eAzBWUCEgpRs4xz88Ei8FZu4j7uIO9K463XnNkMSdx1tID3WYK592RYPiYqERi/Eee/1KrIOJShcFgnXFphAVM+dPx/j0Mmh1f5otEyxkodf4g6KgFyI9IpZiO6hqe7SsiuQoRXbc1hOaoBcxYa+q+c2nvAuWRnBGpyHX/gs20eXX1yNTZvpxL+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVV3YJ36nD2EeEicIibu+jU6nLuP5r7uEYGLlzvHA3I=;
 b=XRXdAQSWlAljsjT1wyy4to6AB8osf/Z2+IC5Ac7Yd0Odx3RcgpRZa6anPoQqM051h+oXWAuC+YclPVTwWp1Nak8MqRnUKDMUzJfEjdIPX/FSahQb2sVfDud/teMUqUfA7z/jeR5YeJsKBOImHc2ujVXmpgu8XunfaeB98qjwelUm7WEQn3YDnGx4e/70QrgUpD6RlwoRX33dND5Vvz0LAeHZ3kXjmfQLEjZMoNsyAmTEDDXXpyHy+1FPqkvysnG90Mvjq8bVIwCjDprIbON2E3/v5yugJbuhYJCIeA1RfE58/TmJ+2OmaWJOnswf1gGJQbaJslfO3pWm1dweUHM5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVV3YJ36nD2EeEicIibu+jU6nLuP5r7uEYGLlzvHA3I=;
 b=VLQN/h8XQeXSk5Wmi62eBGogYg2WpLvZx3cqudTBaKnuWDUHp7ImCqA4Lg3sayZmeimc967lNrDdrdWfOXB9UCyEgeKNrZXCcRv46ye17hgmH6xIe4XlkJ3N3UIoR6NC/328aTLhUX4ikGOUBz2Hvks2wkLFZb6deduNGWVpv/A=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB7200.namprd10.prod.outlook.com (2603:10b6:208:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 10:08:29 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%4]) with mapi id 15.20.9632.010; Tue, 3 Mar 2026
 10:08:29 +0000
Date: Tue, 3 Mar 2026 10:08:26 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, riel@surriel.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
        jannh@google.com, gavinguo@igalia.com, baolin.wang@linux.alibaba.com,
        ziy@nvidia.com, linux-mm@kvack.org, Lance Yang <lance.yang@linux.dev>,
        stable@vger.kernel.org
Subject: Re: [Patch v3] mm/huge_memory: fix early failure try_to_migrate()
 when split huge pmd for shared thp
Message-ID: <9506fe41-6f71-4c7e-9aeb-9d18d72a9e75@lucifer.local>
References: <20260205033113.30724-1-richard.weiyang@gmail.com>
 <fbd6c31f-7f35-4986-86e3-76bf8963433d@lucifer.local>
 <20260210032304.j4k5izweewouabqb@master>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210032304.j4k5izweewouabqb@master>
X-ClientProxiedBy: LO2P265CA0123.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: c9967c8c-6e47-4e98-b50d-08de790cd165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	6URFDjKRFQEmWkOS5NpD/yjTyar4caOdSV6KHtO/JM/rXBmULoRZRVLRZSZ5QmswdzCv3Wa87eHWw7IcGD+9Jo++A5pL3BUxbwFx+ZVbyrt+/h5qS5efAAqUODGGXAoiWEZE5eVa44Od0DFtsW734TshzDe8ckjZoYHAXJ/FAQZ7gdNn73V8aSAAk7nB0zjd7uMSvBV6/UjVM8p/LywoG8Q6FgpRuK0rCScyTctFD0Inf1duxpSLdqmqH2iu5yk59OWUVPg+mZjeXrr6F3YS8KxGq3k9CnH/x2/OogTAhiyRTti3XH7j+3dkmGNSqTiKYEAtzbMEJikmix/NM6PvMA8ka0pSv1VpgSX+rN8xf/Cz43+aBf3pbojelkGcis5EA9kLrQ2etvhSduk6VsGbvHNXnqcZSIW6yaMGC1otUriBVb2A7rP7nc0ch5bdK1XBLino3RaxVpbCOGAtDxWRBNQt9ncCKyOtorz7EZ7wK/UygGviqp26kO2PDbZWugli2zfEupPuitZjgljXPv1dtzY0I4P+/FMelI2OZelaNEkzV0+oiyFyYQhPGNKK0i3NMGexo2jsPxN/ujUq8UoakoYlziQdnFKawsAqKp+NH8hAeMseKFsyzP2/9LdLgZESTkU7Hfw4Krs3IIhOsWqcgTc+eAxXScmhx9UtXNOVkzxQ9LjQbnxeL6K5qO58bQRwXUBCbzsG5ZKt8a/7D8C8bkViEigHesRfnMBX1i8XZwk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7oXBDLiw13eu4yXnShfNEB+oe3O9A0Nl3aCtH/dNUQXb82GZcsf83epQs2yG?=
 =?us-ascii?Q?X9egx/EiDCThG5z1hMgfBJsLRvc8O46f1eoIsB9RoXXzmTMg/C50Kb4K3KQN?=
 =?us-ascii?Q?JPLf08E3VJNLkyeFv8UA2MXoPWOBUNlFjZUuVZQ+/Q7t89OsKkiKcJM08THU?=
 =?us-ascii?Q?MlIeJcCfWrNi1sY+Ds2CBEjt/nWbxsvmypTCegAI0O+KKNmFdxDdw/jqg2l9?=
 =?us-ascii?Q?6ImR50zvtUOZD2fPHJL0xIojzs0DAFQCdlUZU4l6ny2oZ5Npx59FJq2flyPH?=
 =?us-ascii?Q?Inr8bB0Jm3W6J/yVgonDks+QitwA9e7OZxglPsiWBJ4m/11qGwnTenrQUhSo?=
 =?us-ascii?Q?MpfXfQflHcZwx4cmgF6A7+wBzHWCjvrkX7Lb/kVKiGOV0KlkiqbTJzRzF2P8?=
 =?us-ascii?Q?RL99gqR5Hce/qg4CgfoWmexk2XIkY+NBpSike8Gn6qT9FBA4piWi805bnduK?=
 =?us-ascii?Q?1+e5fl99Mk1HEszy47nvA7m2f/xKIXpYpNFi+HMCXIXwvy9NDkR1A4fLKwP/?=
 =?us-ascii?Q?QJu8AhVf7myl79EyHnksDTMB6PZ2j+TT76mYVKZ+X8sATzSyoKyp5SFvnF+h?=
 =?us-ascii?Q?YGUPZpjAqdeEhI35NyGX2vXzdv6fks4+hfI5pJqsFvF+iMATZpjbGk1KQMak?=
 =?us-ascii?Q?THNqTL6KAY2TNdM22/gjHJJKl+/sn8Xnv9iM6SqBFSeueLxfhA4twCOPxR1h?=
 =?us-ascii?Q?4e+DYQiOcCJ3iIQvHE/+mmo5MkZWZyOYL6s5VKDljj6o6NUFi3KmaWM9acue?=
 =?us-ascii?Q?1EHUIxTZ55CJ6LcWCw0wcTr+YUERE9PPg5BXdtS0KIyxW9Y8LrC+lbLjiume?=
 =?us-ascii?Q?6/zBQwMfiYq9W1BbwcejV4DHuZfjqpFj2KPEXDLZ3PHLQHTIUmxosJ2/azuS?=
 =?us-ascii?Q?DsvgYKFZJHs2kl0umMbqt18QRg/vbcuEMJrLA9yQTW33UJE4JWVOi52txHYw?=
 =?us-ascii?Q?k77/tIWBePBitQ8MP+MZk9S9qcz8cdwlGd/O1UdYiiOxsENqCAmb3dq24sYr?=
 =?us-ascii?Q?EtWdr4Lf+Q03qelKMt8cXDav9v/pfpLqnBwQJINgxqIHYPG8C2kGadYdf+U0?=
 =?us-ascii?Q?Q2hXGahtbcbBFlyilkbXUTL5MIy/YUpl2PSVFKr10ffbMTAU3cp9e5hJx5Et?=
 =?us-ascii?Q?4EEOfhWvkdctp3X2okipyPVCsFsMuZLqeaO9fO4F/+aRi9YxJzi7HoQ4UoeA?=
 =?us-ascii?Q?o99Wo8gSqCd3dn7BRY85g9aQvpyXC7Su6LkIXOJ7/j/htosDsBg47goc1hvC?=
 =?us-ascii?Q?EWCYtuoph0Wm2W2UDdcVhFmtHElxLl9J8XZO8hwg9g010J7tY57gBoAqoT/5?=
 =?us-ascii?Q?2WtPRliiTZVMs1ocDBclo/PZUZ9bAxnbg4AAjKCqMygY4xloENJ/M8xDXpuD?=
 =?us-ascii?Q?gK4Ygx7g5xiSIdFfdU6luU95DrP2W+D+WIMn5OcMtdkSMfkh3wpY0sh1N04x?=
 =?us-ascii?Q?CuQyK9jafnaBsx4ST6m9s5liItLEZNDGGJEa9gZd3pQSLCrjvREgIO1v67Tx?=
 =?us-ascii?Q?NOCFGRTvMBxch127+XlghhHthVaonfdMTPxsub7caMqyQ6vLXnXErW7ovKOI?=
 =?us-ascii?Q?C77W4OEbhxhJJfsCQsHqf/ewKqrG+PZ3fxejSFItFJXb4YVDCZvnHZa1xWcW?=
 =?us-ascii?Q?iVhQXF97MKZnUjxKUlGk4EYICgAZJp5Jfui8bcWzN9gn3pE3/e+vDJNmZiw7?=
 =?us-ascii?Q?9mPLOmTfoYxk6oWjY0zpQ+15K0cKQnuRZyBqgvwCM5cTxMcj6sLU9YOcII5y?=
 =?us-ascii?Q?PElngykyu447belATFbz69W4tN+6EUs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dqANBiv7P3LV4L5peu6ASo+EiBmPhwHOm905wQkXEC4lyE+OOx/ICVnjDSD0DAmkX4QvNRSIPOH7nM/pyO1oaET9ZXhGAcLAzm0PizPnUsMdLMMZzJTQ9BN2urpo4L3qE+fdSaVScc7XERK/R3cOYtqxoIK2MxCaJzdSyUYILgcGJV6YnbP/LgSJHvK650NgjDMhEV/2kMsh0QL94fDbtasL0ZwYHXmJTMIGHA84E0foZHkGrCiT1/Z2/h0W2wqTx+eD/rL18ukcp4w7i7qBK0035S+z4xBby7mBACFF3G/YuX032JKHm3iuh9IraHfx7BF/Yxcf4D3TbrQ+mtUMAvKy3hXeLd2NdpjkGTzOyiKbxXLjUda/KW7dDgAhUUqHElGn4EunSzugaiE6I4HNaWx2Ut0WSoEeXJ4VPQRFZIpHcoYqcdyQqgcpTBYrpATmeXBQ2/QPZWX6pJDhFD4Q71++DqRNjIplh32q3VTYXGPZ2oud181e0/QwEkvtomKn5Xb3FPNkheKwFGJblIQdpI/nza4c3q9n32PLHsR+H4L1icGaVF4xEQz3T4LKZrtSq+5vm4Fk/Oc7zC3YapN+KJz/yyKl+J/3Q4J7Yrttag8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9967c8c-6e47-4e98-b50d-08de790cd165
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 10:08:29.4017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Efni1gVUIGMYB+lSM1tXMJNKHScyIqT72ODGh2xvoOgxYVvstSu1DtsDqSi9d+KTazeJ6lqEDn27VazIvnzS95hDGkdnhdQlpSA8E6NpIbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603030077
X-Proofpoint-GUID: VtJImRHIRHf38_-s-M42buMnqV4IAIr-
X-Proofpoint-ORIG-GUID: VtJImRHIRHf38_-s-M42buMnqV4IAIr-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3NiBTYWx0ZWRfXx/az1ovsrkzY
 N5b6k0yy5QE2ZUL6N4VUiC+vzaK8fIJ1OlajPU+LKdWNz0+hh9/eG9ej1yBgjhFCudRxzDtsVP/
 SVBJON23jbC5/PLJcc4FgsdjRRX/Qay2tFP2oSGeNgpe8EDOHIZ6i1As9AO9yzr7J1/kXBknibL
 C1a9BpW/+1SBOyLZ7GmANuup0ttvCJXqdlDBtXpEt6zkQ4DhRBrTPVhE6WohUKrlxRRBgqPikW4
 VOW9kuyYW26QHOWyh8qODs9tID7y/Hp63MSN3XJcTjzvZ0SyOVOiVqt7iL61E/QQ3NnJBvwgPtT
 amfVrUaMu2gXIRcv/3MW94Ns+OKMBzBEOnT1jMtN9oNktRSk0A1hzuNncIqynCm1/XZPPVhsm6Z
 suDMAnlAOxXj+XuXQ8bkS1sUauwa1WbW7epEPNmCbucyfVg49dmchY94IoPC4aIFUGat2xGm4Ho
 6uEgUGtx7snz8lM5v5ShaeXpdXNPzQaX7KAFDBcM=
X-Authority-Analysis: v=2.4 cv=EMELElZC c=1 sm=1 tr=0 ts=69a6b327 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=pGLkceISAAAA:8
 a=SRrdq9N9AAAA:8 a=Ikd4Dj_1AAAA:8 a=V2sgnzSHAAAA:8 a=VwQbUJbxAAAA:8
 a=IlLzSj6Ojp8Zwya97V0A:9 a=CjuIK1q_8ugA:10 a=Z31ocT7rh6aUJxSkT1EX:22 cc=ntf
 awl=host:13810
X-Rspamd-Queue-Id: A3ECD1EC74C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222845-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,linux.dev:email,nvidia.com:email,lucifer.local:mid,oracle.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alibaba.com:email,igalia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 03:23:04AM +0000, Wei Yang wrote:
> On Mon, Feb 09, 2026 at 05:08:16PM +0000, Lorenzo Stoakes wrote:
> >On Thu, Feb 05, 2026 at 03:31:13AM +0000, Wei Yang wrote:
> >> Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and
> >> split_huge_pmd_locked()") return false unconditionally after
> >> split_huge_pmd_locked() which may fail early during try_to_migrate() for
> >> shared thp. This will lead to unexpected folio split failure.
> >
> >I think this could be put more clearly. 'When splitting a PMD THP migration
> >entry in try_to_migrate_one() in a rmap walk invoked by try_to_migrate() when
>
> split_huge_pmd_locked() could split a PMD THP migration entry, but here we
> expect a PMD THP normal entry.
>
> >TTU_SPLIT_HUGE_PMD is specified.' or something like that.
> >
> >>
> >> One way to reproduce:
> >>
> >>     Create an anonymous thp range and fork 512 children, so we have a
> >>     thp shared mapped in 513 processes. Then trigger folio split with
> >>     /sys/kernel/debug/split_huge_pages debugfs to split the thp folio to
> >>     order 0.
> >
> >I think you should explain the issue before the repro. This is just confusing
> >things. Mention the repro _afterwards_.
> >
>
> OK, will move afterwards.

Thanks.

>
> >>
> >> Without the above commit, we can successfully split to order 0.
> >> With the above commit, the folio is still a large folio.
> >>
> >> The reason is the above commit return false after split pmd
> >
> >This sentence doesn't really make sense. Returns false where? And under what
> >circumstances?
> >
> >I'm having to look through 60fbb14396d5 to understand this which isn't a good
> >sign.
> >
> >'This patch adjusted try_to_migrate_one() to, when a PMD-mapped THP migration
>
> I am afraid the original intention of commit 60fbb14396d5 is not just for
> migration entry.
>
> >entry is found, and TTU_SPLIT_HUGE_PMD is specified (for example, via
> >unmap_folio()), exit the walk and return false unconditionally'.
> >
> >> unconditionally in the first process and break try_to_migrate().
> >>
> >> On memory pressure or failure, we would try to reclaim unused memory or
> >> limit bad memory after folio split. If failed to split it, we will leave
> >
> >Limit bad memory? What does that mean? Also should be If '_we_' or '_it_' or
> >something like that.
> >
>
> What I want to mean is in memory_failure() we use try_to_split_thp_page() and
> the PG_has_hwpoisoned bit is only set in the after-split folio contains
> @split_at.

OK, if you expand it to say this that's fine.

>
> >> some more memory unusable than expected.
> >
> >'We will leave some more memory unusable than expected' is super unclear.
> >
> >You mean we will fail to migrate THP entries at the PTE level?
> >
>
> No.
>
> Hmm... I would like to clarify before continue.
>
> This fix is not to fix migration case. This is to fix folio split for a shared
> mapped PMD THP. Current folio split leverage migration entry during split
> anonymous folio. So the action here is not to migrate it.
>
> I am a little lost here.

I mean this is the issue with the commit message, it's confusing :)

You're changing code in try_to_migrate_one(), claerly this pertains to
migration, as the code you're changing is literally only invoked on migration.

So what you're saying, as explained better I think in the actual comment in the
code, is that if the folio is split, you need to abort the attempted migration
right?

Or if it is that a migration entry is created that is not somehow used by
migration then you need to make that clear.

>
> >Can we say this instead please?
> >
> >>
> >> The tricky thing in above reproduce method is current debugfs interface
> >> leverage function split_huge_pages_pid(), which will iterate the whole
> >> pmd range and do folio split on each base page address. This means it
> >> will try 512 times, and each time split one pmd from pmd mapped to pte
> >> mapped thp. If there are less than 512 shared mapped process,
> >> the folio is still split successfully at last. But in real world, we
> >> usually try it for once.
> >
> >This whole sentence could be dropped I think I don't think it adds anything.
> >
> >And you're really confusing the issue by dwelling on this I think.
> >
> >You need to restart the walk in this case in order for the PTEs to be correctly
> >handled right?
> >
> >Can you explain why we can't just essentially revert 60fbb14396d5? Or at least
> >the bit that did this change?
> >
> >Also is unmap_folio() the only caller with TTU_SPLIT_HUGE_PMD as the comment
> >that was deleted by 60fbb14396d5 implied? Or are there others? If it is, please
> >mention the commit msg.
> >
> >
> >>
> >> This patch fixes this by restart page_vma_mapped_walk() after
> >> split_huge_pmd_locked(). We cannot simply return "true" to fix the
> >> problem, as that would affect another case:
> >
> >I mean how would it fix the problem to incorrectly have it return true when the
> >walk had not in fact completed?
> >
> >I'm not sure why you're dwelling on this idea in the commit msg?
> >
> >> split_huge_pmd_locked()->folio_try_share_anon_rmap_pmd() can failed and
> >> leave the folio mapped through PTEs; we would return "true" from
> >> try_to_migrate_one() in that case as well. While that is mostly
> >> harmless, we could end up walking the rmap, wasting some cycles.
> >
> >I mean I think we can just drop this whole paragraph no?
> >
> >You might think I'm being picky about the commit msg here, but as is I find it
> >pretty much incomprehensible and that's not helpful if we have to go back and
> >read this in future.
> >
>
> Never mind.
>
> A clearer and comprehensive change log is helpful for all. And my English is
> not native language, so your suggestion helps a lot.

Sure and I'm sympathetic to that, but I felt this message was unclear enough to
be actually difficult to know your intent with the change, so it's important to
get as much clarity as possible.

Thanks for your patience on this! Apologies again for delay in response.

>
> >>
> >> Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> Reviewed-by: Zi Yan <ziy@nvidia.com>
> >> Tested-by: Lance Yang <lance.yang@linux.dev>
> >> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> >> Reviewed-by: Gavin Guo <gavinguo@igalia.com>
> >> Acked-by: David Hildenbrand (arm) <david@kernel.org>
> >> Cc: Gavin Guo <gavinguo@igalia.com>
> >> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
> >> Cc: Zi Yan <ziy@nvidia.com>
> >> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> Cc: Lance Yang <lance.yang@linux.dev>
> >> Cc: <stable@vger.kernel.org>
> >>
> >> ---
> >> v3:
> >>   * gather RB
> >>   * adjust the commit log and comment per David
> >
> >Clearly not enough :)
> >
> >>   * add userspace-visible runtime effect in change log
> >
> >Which one was that?
> >
> >> v2:
> >>   * restart page_vma_mapped_walk() after split_huge_pmd_locked()
> >> ---
> >>  mm/rmap.c | 12 +++++++++---
> >>  1 file changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/mm/rmap.c b/mm/rmap.c
> >> index 618df3385c8b..1041a64b8e6b 100644
> >> --- a/mm/rmap.c
> >> +++ b/mm/rmap.c
> >> @@ -2446,11 +2446,17 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
> >>  			__maybe_unused pmd_t pmdval;
> >>
> >>  			if (flags & TTU_SPLIT_HUGE_PMD) {
> >> +				/*
> >> +				 * split_huge_pmd_locked() might leave the
> >> +				 * folio mapped through PTEs. Retry the walk
> >> +				 * so we can detect this scenario and properly
> >> +				 * abort the walk.
> >> +				 */
> >
> >This comment is a lot clearer than the commit msg :)
> >
> >>  				split_huge_pmd_locked(vma, pvmw.address,
> >>  						      pvmw.pmd, true);
> >> -				ret = false;
> >> -				page_vma_mapped_walk_done(&pvmw);
> >> -				break;
> >> +				flags &= ~TTU_SPLIT_HUGE_PMD;
> >> +				page_vma_mapped_walk_restart(&pvmw);
> >> +				continue;
> >
> >This logic does lok reasonable.
> >
> >>  			}
> >>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> >>  			pmdval = pmdp_get(pvmw.pmd);
> >> --
> >> 2.34.1
> >>
> >
> >Cheers, Lorenzo
>
> --
> Wei Yang
> Help you, Help me

Cheers, Lorenzo

