Return-Path: <stable+bounces-219705-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIe9BcJan2lRagQAu9opvQ
	(envelope-from <stable+bounces-219705-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 21:25:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0C919D2D8
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 21:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2107D3064B9B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 20:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06AD30DEDE;
	Wed, 25 Feb 2026 20:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="ivurDF1t"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065EF30CDB6;
	Wed, 25 Feb 2026 20:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772051109; cv=fail; b=GXAWAKrmVzrtw7qGhiBgZD7KE9cx8Acl2uRORPfJbLMBt93d1J9JamOmXGv7uw7p2WsehN2GKrgMnaSjPosb288S7yOKZ4x7DWE5cMQdB26pCJNMxLAH2Zzpd2YtVOwfcfykh6v259RIcPdgny60dkojdjkaRtboJn/h0LkxqA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772051109; c=relaxed/simple;
	bh=oP1GEFJP67ArMP3EKhSRyFpjtmTm54Vy5fEzbJ98HQk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QnI7IS2BA5tF+MT8iRDEQqlW2p6fsWVpgGubboLNnKeV5aV9MUX0mf+wUrDeIykv8vKSc7/MREsAbe8YN07Lyz7qFCvhReRPKioDr4Al8clfjfBcNx+MHN83IuLZiVpqq63pbbNdVQKh06P/MpQTN/fdhd12HubnXyOH3lJut48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ivurDF1t; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PDD3gk2033308;
	Wed, 25 Feb 2026 20:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=CZ+4c9eZM
	hSX1WSYKgCmtQNpyKQKNK+aoCG4VIB/f88=; b=ivurDF1taZhwVTFWY1S8yHivZ
	4cWFj6z500UV0xOUbgBgz0qtYR6Hvn1vBp7mYa7SqiL1Yyg2h75iy4aGJ0cRbAq1
	mU5ZItIL1C8d6kecD99z3/N+6SmZuS8vYhNiCxizaA7aw4OU3N5Sj87JXyME21w+
	tvwwg+B5wWw83x8HpNRpUmonPAedtCKrBXGqFlIeIOsYklwWI8e1Q/wG6UqYJ/WY
	gfHAiU2pB2YXrLjwWf7hl8QiefbZ0/p3t7QVkXFS9YUGxXSEu9GPU3o60kaB3UmR
	gcbkDjTfj/tILrQF+mG9d7+dlVrEbk39w5Tfe2YiwlWzoowkiW66szZQPD54A==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cf1wvdja1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 20:24:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqAkrcz9qYPVWug0hnriE3e+3h9Q4C7IrUm3bxaGVZdirEzT2+JHqw+ECCLC9Zljk/fCwuam67ENNBiq0qIQTEjyIliVYJM+toSMkjBcWnjCHh2L7gxNmtzSUziBfcBn4v1twn4vKPrJtTKc3+w7yPIZDTFAh8ZyilPtYPYoKCtiBwWr6PxgJAR4oscKcqzeKEOMV/vyPXNIoaMmmmaHanyI2USAIgyb4I/PqRZZUGyoRImPR06/xSdrx+ZFQrQ1bLWcS038Vzw7y8CjIVjSzN6tgrhxMYAancZqsmG630UW6zT7spV/AXDHY39zpUiAUqi9uLQTwrMPxg1MwB+apA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZ+4c9eZMhSX1WSYKgCmtQNpyKQKNK+aoCG4VIB/f88=;
 b=mTRH6JkOi/th/7MIFVXY3P/Wv1YHAnXROKXNCNP9J1qg7iequ7csE+oBUkXyonrWPaF+kefWHOiq0w44q4fxpc2TTj/gpn3CV6B9NX1uQY+qfNxmm3tS8VJO+OzmNi4abtMrJxUtmvuxuQju/ylmHu9yTasXnq/H8aW/xEAT8Q3+iguXENof+mDCxsQEgFroEMGzwHUAees4Qx5U0hgfUhvJEVIrzpg2b3Lm6Ke3GmvJ4oEAntLRwYk4eQKT2IRqglgNL5vF5FJg4E+mKxpeKklFqUfOVsSG6C26+yVk+wG08lnAezlv325scqjTaeccfR3v5XvOYP27nvGfgjNEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by DM4PR11MB6333.namprd11.prod.outlook.com (2603:10b6:8:b4::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.22; Wed, 25 Feb 2026 20:24:49 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 20:24:49 +0000
From: ionut.nechita@windriver.com
To: bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, alifm@linux.ibm.com, julianr@linux.ibm.com,
        dtatulea@nvidia.com, ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v3 0/1] PCI/IOV: Add reentrant locking in sriov_add_vfs/sriov_del_vfs
Date: Wed, 25 Feb 2026 22:24:33 +0200
Message-ID: <20260225202434.18737-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0227.eurprd07.prod.outlook.com
 (2603:10a6:802:58::30) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|DM4PR11MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 83dd3d75-fcc1-45f5-89d8-08de74abecaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|10070799003|7416014|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	7+vzNMgrEbRkNKf7YK5PiR50Tm6ubLfwjPWPswQtY1/W9g1T7qYMNFdTeEKui1hXjkYQghRbLC3kD5zhjtEoDiy1gQVxSHupJDaPFJumpk71H4QEV2XPFahdPnhYLX8qneGCSdOWugTjx5tkAgFBbDV+t96/cm7cNMzsHz+N+EuzgICFVD5Hr2MnWZsAVkV88Gmi6uh52mG3icgLfjCY4VUGXe1EGcnezZSPV78BAh7/zFQ2oGxMI8QwlelMg8mbyHZrVBxeZg2/bDg4cv77gTYZB+8G0NzrAEbLgk+IGE6iwyz8ZJOg7Q7LybHeXlsvDgTr1RsKGSftczIb/TVhYbjE+z5N4EiGvb168fvbDhiv1Js5+O6E8bBoTUbkVR52ftZidjA9UYhxl4yT+Jfb9Z1Rqh25pmBR4nd02JMtvyjWIQA+buY7NTR6jmSsWuGpd9JK8gJKQJN3DIKoKupAA6LiLyl3k29xJwKWbe2hNAj7whRY7RadVyJJ4ep1F5lgsxPLAziFdsIQzziPEVvghTHFX4eFQ8H/aFpylCKBZ8SgBrrWX8TK09JkrIEj8VkOo/bNRl/kMMHdJaF3OJ4KHIUHUI0W68Plto4w8BE0EvpzojH+6D7H3fw6sT+FOXACEoaFY5HrqTr5YCT8kATdRClU+Whsn439iqnYwSJmwU01RuB/4O03Z8TafPlf3D4LGj/RXfkYioYV8t8wAuMO7v4TdUoyjLoFtbeSRN+E8+g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(10070799003)(7416014)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hBNxF5AmwCCb0Cz712ppqT1iaGlY1Apvb6VkRkkYlL0oSn5cRdvXnIyFs/c7?=
 =?us-ascii?Q?rXiUio2N0kS9jp7plCTjdj6Bs7qZGSFfdrRQVclRjUtrn6EwhjB5LvwV7INE?=
 =?us-ascii?Q?yDNh4KyA7jIzPKZ+LN6Pt4xm7/jP7mSj0rc11LpaiZ6Id4GmPeuulzvunIBB?=
 =?us-ascii?Q?xYbRakfNsBfh8FEwAt3odtgOiPp7+luslZO0p1+34IKrjtEMY2YhcHRUf9cd?=
 =?us-ascii?Q?AUk6FUBxXYRDBACI1rA/IXM3OeQMNOiGF1Ct4t+rYLq4ydCQDceObQrGfdR3?=
 =?us-ascii?Q?N0zk4ihoY02t4c+WvmrBop5eFj8ibGBT80wTcGQOEUTNdiasRgJbB5V7BeKj?=
 =?us-ascii?Q?EfpiAr+slqtqMuD7EW9FKdLa5paTM7tzkfRwGdUUQtrE1KgIJmtLVNtBujbB?=
 =?us-ascii?Q?hxX1l2dhPYOgB8kHLsXyn9sUTjiYzaVeYJXJnhhvnwOuK7E/2Fst02S3NOGc?=
 =?us-ascii?Q?+FK5KVLvAAqsAUKLXLnDoLhROfV5vIC3KWc6EQBdceVonDMg1gtf0zEoiQ50?=
 =?us-ascii?Q?y/w4hfzeM65FDjPeyyFC1DJCBfrWFgtuKIRBbH47sLrg57DqxR3J8WvNxnCE?=
 =?us-ascii?Q?86iyTQ5hWFhaZw4l261x6yp9rDwIGVsxMyJZtRnZ1FsB1t3lH6s8deNnTYud?=
 =?us-ascii?Q?wf7AuQW3EKHOX/rxwaal2HnQZAbaaG0Uhr96zMCcotTZbiMF98OLRE95uWIm?=
 =?us-ascii?Q?pGGh2/qi2VFzRlJPSbsL+omoHJvwi8H/UP1D0NdfBfBN9ILd9+13z5v056+e?=
 =?us-ascii?Q?X/eRtTwM8OX0B+JdX2laKjEn0kaupFrkjjkf1901p4/MxPVM7S8zbumXwEGu?=
 =?us-ascii?Q?9cG1/8hbm1nFpuXKqVtimPCW1CncXUASySMl48vf1zFmp9chi4zU6svHusyG?=
 =?us-ascii?Q?IBcBocH5m9Hg/ItPebKtHMnhRaeIuTU0ls62Dif4TT9YGlShqZ8+POB+wKGJ?=
 =?us-ascii?Q?6xndo2Zb9sl85lY0HhERYsqxLgql5iKgsN8i8jJ2qWhU3I9GglIez0jhICrq?=
 =?us-ascii?Q?3FgdoUlrySxwp2tyvHWcLK60sqbGYTokNWlw7OuGuYOZvMmFJ1CD0TXNiV4E?=
 =?us-ascii?Q?fpqyPgBz7jTgjEuCB3IV4FWkdctYNm/7kzKe133AvPJnL9pxRBEtcalgtuzF?=
 =?us-ascii?Q?CLFJBMOEgLZSyOEFWK4uWjZ6A9RFVexxjS/Ye47bigqe+vLBjAAdyhJ5tdHl?=
 =?us-ascii?Q?QP0M12tRUnf4g+j4OXu565IJdVoTsia45Rjo0fB9uY1d7ctY+ZRgdLC3FOp8?=
 =?us-ascii?Q?f1IkQQ2bIDglFljv/8lADKVM0zgHIoJQk62Sxdmq8d6sWquThsM8zbAYYD+K?=
 =?us-ascii?Q?YhVvlM7dFaXwvp4js6Unv6Z3RAwo2ptaEdCFUX7HnPcWCvCwpc2StNy8KV0e?=
 =?us-ascii?Q?aRhXQYRUWoGk5IvKbGwJ+bej9iDuS+hRJDyrFO05THlrb2O9QIysId1dADZX?=
 =?us-ascii?Q?k/jOW4gaOIHiRvdMVx9QXW0Xy6UQUU4zWXwI94BkpkCpEixaCMyI+f6GUPOh?=
 =?us-ascii?Q?PGG2Iu1vKeZpf46AoISjHaguW42doj5s+b3X/DWQz/5/EmtMXbe8baXjTe83?=
 =?us-ascii?Q?gMula2tTYj7AIppG758sKk1NYMcDdD+w64zCphKKQoz5/nKEvf5Ieis9LL2I?=
 =?us-ascii?Q?SupYMVfDDP8xpMlKCuptjoUgXZ5tRwDGPV1oQv6U6dbYE1DPBB2E7rsTdfnD?=
 =?us-ascii?Q?fblQr8kJ1JQvmAZ22oiuPFhE/rmi0V8E071U04tFglkHlxnrHbWmuWB0tLa9?=
 =?us-ascii?Q?UqntYceS/68r8KWFd3Mtxtq6nQ/4JMiQlqleLmbtYsPVSwZ2vJt3DUlAbd0l?=
X-MS-Exchange-AntiSpam-MessageData-1: 12+/d+arDRfFNAxSSuvVuPzDLr5At9D+dCI=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83dd3d75-fcc1-45f5-89d8-08de74abecaa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 20:24:49.6214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgitPSTpXv5Bw9Ks9bJMJtX4YpJmuoJANpwhKKpPyvUPRamPVzfTXqWF8mr8+7F7JDfM7+bdWTkDQJDoLlCZTV2B/RC/h5WgEJ4WqyK3h8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6333
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE5NSBTYWx0ZWRfX8+jx5NDdOKOK
 jT3Q8mjclEFMtor2Jik6wmqVFFvlkQFYrHTvYVp0mxoqflVVEuVeDeR8XrByzw42U+ZJpAYMsNh
 lxPm/HqspzlqX+CMkAJzLpIWAccf76RXbpjjlNs/uYy8OaachIapr75/uafJuWT5ivVYmYx78xl
 XfBw5lkmGMFNtKJ6iQXBE/hq0o+STakcCzD6SE1sqmhCGsUfy9RSQvSdU9N/6f/YeKcQqxicJaV
 hka8AoNpbAc/u0Xw/+wbq91l2sSCJAEglRo7tsMu9MaIZwNzS0XaKGHWvL6ZdJEJgj0E+baiWJi
 gr6HM5IxSMjI1teoS5/wO27e/ck4Vpv2C+//M0CmjlxGhUFNv4iaJykUGYj0mlIO+7mjuBcNP9B
 uj8Gg3k1eR4qaMZuMqMff1W17ewUl0Laym/+ruJw+Vkup8p5UVo6kt+WWoS9gBjBXIjg6ADrAle
 XInjWcBKIfFoYowNlUw==
X-Proofpoint-GUID: xURLRSsq71h81K_BPa_n_paGlWAuKb6a
X-Proofpoint-ORIG-GUID: xURLRSsq71h81K_BPa_n_paGlWAuKb6a
X-Authority-Analysis: v=2.4 cv=F+hat6hN c=1 sm=1 tr=0 ts=699f5a94 cx=c_pps
 a=ixAZ6W2pdOuc7GYTaWtIWQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=VwQbUJbxAAAA:8
 a=CjxXgO3LAAAA:8 a=t7CeM3EgAAAA:8 a=lwgsdTXzEhOGwcqcKhUA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250195
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,nvidia.com,yahoo.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219705-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[windriver.com:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,windriver.com:mid,windriver.com:dkim,windriver.com:email];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AF0C919D2D8
X-Rspamd-Action: no action

From: Ionut Nechita <ionut_n2001@yahoo.com>

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi,

This is v3 of the patch adding owner-tracked reentrant locking for
pci_rescan_remove_lock in sriov_add_vfs() and sriov_del_vfs(), to
serialize VF addition/removal against concurrent hotplug events
(including platform-generated events on s390) without deadlocking
on paths that already hold the lock.

Rebased on linux-next (next-20260225).

No code changes from v2. Only added collected tags.

Changes in v3:
 - Rebased on linux-next (next-20260225)
 - Added Tested-by from Dragos Tatulea (NVIDIA)
 - Added Reviewed-by from Benjamin Block (IBM)
 - No code changes from v2

Changes in v2:
 - Renamed from pci_lock_rescan_remove_nested() to
   pci_lock_rescan_remove_reentrant() to avoid confusion with
   mutex_lock_nested() lockdep annotations (Benjamin Block)
 - Added pci_unlock_rescan_remove_reentrant(const bool locked) helper
   to avoid open-coding conditional unlock at each call site
   (Benjamin Block)
 - Moved declarations from drivers/pci/pci.h to include/linux/pci.h
   alongside existing lock/unlock declarations (Benjamin Block)
 - Simplified callers: removed negation of return value and manual
   conditional unlock in favor of the paired lock/unlock helpers

Link: https://lore.kernel.org/linux-pci/
  20260214193235.262219-5-ionut.nechita@windriver.com/ [v1]
Link: https://lore.kernel.org/linux-pci/
  20260219212620.3801194-1-ionut.nechita@windriver.com/ [v2]

Ionut Nechita (1):
  PCI/IOV: Add reentrant locking in sriov_add_vfs/sriov_del_vfs for
    complete serialization

 drivers/pci/iov.c   |  7 +++++++
 drivers/pci/probe.c | 19 +++++++++++++++++++
 include/linux/pci.h |  2 ++
 3 files changed, 28 insertions(+)

-- 
2.53.0


