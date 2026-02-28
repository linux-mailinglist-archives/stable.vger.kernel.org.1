Return-Path: <stable+bounces-220064-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CZKMLHZoml06AQAu9opvQ
	(envelope-from <stable+bounces-220064-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 13:04:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 303DC1C2C04
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 13:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B924303A4BC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 12:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0811642EEC8;
	Sat, 28 Feb 2026 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="rKojzoUx"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E823254BB;
	Sat, 28 Feb 2026 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772280238; cv=fail; b=bq8ldm3NeFmIh+zV5WBoSOXcUvJkXYkp4pMkI8BNZ0/R1h+ueW1t8+lUX3JPie7Dgm98eLaOp/EcuxgE0No0KfXu//rlF/N+gNBrh0QXRb6rVSTqbupEHyqPKKHihoSEQxwBJ3psYsTZwyafM86bcdWrB5Q8HMHqqRJtOpGsdXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772280238; c=relaxed/simple;
	bh=8BybYSpRvJ+EhrmcJcCkXBZCMiWsigJ+DMdG8q86rRo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WLEQlQ/CAw8fINgfU2P2ASOz0+JSyCwX4U/hcamdwgjS08FbYTdm+pfGIpBw7Bd0yAhRl8K6Cse5x/nZAcp7Jk0wvfdFR3NPsR3ZxJb8gR4eimZLUzdjtMOhEFAdoE21i33OSt5lWXYBdT8otPuUwBri3/tQRJGTr1V+IWjRNns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=rKojzoUx; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61SBo16g3318787;
	Sat, 28 Feb 2026 12:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=40jMthDRw
	jvenHe43c1ysOay2ok1wCTTlwEb7aL7YuA=; b=rKojzoUx7hUvyDcZ84fBfsF4F
	1TvL9KwWhueM/lMonqve1v/J+G53NsKTY4nhrAEZr7s+02sZKkNQIRayCwu+aq1e
	XOOYVvozwiXh0u0HQoaX9QhYRpfswQ66krOupr5uP7XEoZx6+ycMgVpvFO38Kg9n
	dR9tWa+mBLffrPFuuzGRRjfizRx61MKqm6tXXdA7MeeFV0aM2oLugbuzfaftMmaW
	FlvgT2XxIT64o1h0AN0Ude4Gu/I1AxNlQ+gLNCobIHZhIgq1f2hnOcphw9Pwas/q
	tlfkbAbkQzkNZs+GEJ/h4NTJPveraSGn1TPwX2qRx7TItCUW5A2CdR5pnHeGA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ckqb4gcc6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 28 Feb 2026 12:03:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+wboJGuJc//8/5Sy2/fkcKn9XuMGEFKwfRAPhtnmx5CZ86thhb+o8+cY0K3QOOnH6jsf2jQfigsgoaWnZijpE8QlbZwKzIy0JasreL6hrEWrSTLnJOKhuUxfaQIbABjcaXH//m3MigjD+sIVvBENkfdThokxJCsfIW4EckO+7gJZw+epqXhKuSzrGpWiJHaZu/l65tcV1ZLEaV72iCOX6VN03KL6LhUoNNaP2EObrpu1nECQfrGew5xkr2HE1AeJ6rS2ljWQnYit4mgb7rCdq+9YAaOn/Ft+RcmV8p1YPYqY2Q79HyofMoCLNPVtN/tSYz4cQgJS/Q5pyagBeGTCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40jMthDRwjvenHe43c1ysOay2ok1wCTTlwEb7aL7YuA=;
 b=V8UcYToi6fU3sDp/Yxz+ARpH39rwA7XF3vuMhbufDcgEHJpf2eKuNyS85jTXcGPP3aVh1o7gQ/JBnIN8Okr59SWzndW3688r371HOjr0/M7rT2MHF/dq4TzhYxXfegzAwCYQ6aFSgcXjQEbTj/ziG1MLKr032MUEfZHRQxclO3cuh6SmNRomu1wsrjCjqMUq3SAB2UuU7+j297UQ0naCS8FNyX9XLX+qgWBGR1Idh/K7RGozxta/+35NZLhZ5sx9sBjVmyFF18JnPNCNgYi+22FeXT3dA8pxlxI1LP4nTp3FO+MoSkjP3B34GydTbZIqfxtqN+VEestuN4QrFWas4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by PH0PR11MB4807.namprd11.prod.outlook.com (2603:10b6:510:3a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Sat, 28 Feb
 2026 12:03:45 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9654.015; Sat, 28 Feb 2026
 12:03:45 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, alifm@linux.ibm.com, julianr@linux.ibm.com,
        dtatulea@nvidia.com, ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v4 0/1] PCI/IOV: Add reentrant locking in sriov_add_vfs/sriov_del_vfs
Date: Sat, 28 Feb 2026 14:01:38 +0200
Message-ID: <20260228120138.51197-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0902CA0045.eurprd09.prod.outlook.com
 (2603:10a6:802:1::34) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|PH0PR11MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: e4db7677-82fc-4bea-f9d7-08de76c16c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|52116014|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	rHI96AhoUCmOvJCnB1lSyN336eONjV68rESE2RuoSTZSa2ak1lDlbsuX0TTFJdrXEQVX/NqVGaR606JLoldb3Y84RSHGSWBtMd/IdLCmqrnuX1d6OSSfgOY27/ukY491pEzQOtHXMRXjzFReDviKV7sZFVmlM+i4obtg67tXypiul5/BHk2gYKfz6+iJOQ8GJa52XaqkkQn5iSVAJ7HMTn3/oxU7BSVqIh9nbMNqOwbBFkuuUl1YpO0r5oVFgdw5zgwE7Y8opZVgc2L8mrTRhd/o7yzQsnSptwwNuGqVHJHnD+j4GTv3mpnCxquxcVV/4bIsL0Emn6hsimnQAEwrFTK6eQmODBYR+RYL/72KqBA4SJ1Z/NOZRbrs7m3YlIPJb4jwh/Pgb+/dxG3P5LDHubVLs+vVdLFAAFgQ57NoJ+DUyACgP8O91zMGa9fKzizCromiKi0uB+5aeNL3tUJPDw8LvzrcLAqyXuNHJvndXZTvIUmbSOiKANEVvRsimhh5DjKg7nkDUafAY07Ito2mYWGsOLpv6vLPlhZHtf963U32n18PyCV0j1cOgYsNHd8Eedn7SZg+BkgHXh/vJpRVR5fxTrvSheBi1iQmAlgL4OoMZaxrqi9GNGPSEXbYoT7Rdhm/Vg1EZx0gkIIJs+roejdGzw5oIMGtZUAPfR4skOZmkeGeLGKlMVugqr9Qm/8g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(52116014)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J1b+4t8vDdTPSebyQoToEP9pQlULbMvLKZjmK7rFHO8M7HJWl7s2w4Mg60uL?=
 =?us-ascii?Q?iamrWXW5e0+xeqPI137fAKmbE14gZQyJ+pd9gBjyFiulCXqAgct0NovEGNDe?=
 =?us-ascii?Q?JchyyrfdufNwK+fZg3DUp/mLhx+CGmxqhxIeiPJNZdGJCMgo43aiW/S+NkMt?=
 =?us-ascii?Q?VIP7CKZF9zSRnQBgyUcNZjxVFEFiF29VZPKQQ1FhXOyxQIwrqX9/tfbHuC+/?=
 =?us-ascii?Q?JaDjlh2NtyMtCWsCh8mkgbiGGBcUdzOJ/uMS6gN3HG5mniKXG7GjMnLRl79l?=
 =?us-ascii?Q?gjRzxU/qAcBEBX0yR6p3isr3htpeCJyBYGmCQ0UtKGenF+eQieGdLycNet0b?=
 =?us-ascii?Q?d1LTguQXR/0fjtmD2rvAMrn3M+LezhXrtf8VPRUdWFh6YjhSBsJBEAlveLfu?=
 =?us-ascii?Q?endRtxtdXi91iMCCnWFYDi+3jy4O9H/+cYAvk66BRXVFXknX3KsNHr2KAKs8?=
 =?us-ascii?Q?onEs3gNSWOkowGxMpK1T10Cqcwh4utTIgIFQkM3QALKylgRJvi1ENwKz433l?=
 =?us-ascii?Q?PLoffC1Pr+s+cSBaVrPyflORjV3mchGBGoMuSveg4ghMa2LmYcLruiNxYyPy?=
 =?us-ascii?Q?6b8/jriHtFDi28bWk1y+Ur057dheE4wnww6pIP2l0dhQPN1NfqWdTL4gX96o?=
 =?us-ascii?Q?ZmBmsO3USivYC8x4+u/uF0ResejpdrXVTzKbQkQIlv2N9wucbf1HWePSSXk2?=
 =?us-ascii?Q?vg0TficwybRYpCzeJvcu3w+WwSdEWT3abRJXpF2oytMf+4xjWg94xu+yqvRm?=
 =?us-ascii?Q?AeKJx8rqXQaIHO6LZk04xbwfuKQcrBTnhRmuRb3GE7+z3JtpyqeGbz0O2toR?=
 =?us-ascii?Q?b/SACNooupDlaG6iTAUU7CXO+vKdsssBfljIow6XrKcI8QApDGKWGxs+et+U?=
 =?us-ascii?Q?dT9CZ5fCaPKO2LzcPHxpislhv1pkYjBK+h6SYM5WlnEQoM5K7WVttEWYKKbd?=
 =?us-ascii?Q?TqZZixs5xApb6yvF06XpkVo624YlOT7KroTLP2OCC+9gKxH9mX7les7cXS2P?=
 =?us-ascii?Q?SAUM7ECEvPLuEE7MTshbeV+hfIaVU3ClBN5NXcUD8lpGAhAalo/2mLedUx4W?=
 =?us-ascii?Q?K7UnGJ/g/BnEe7bCfAOk9fWjIHA3C5GFvaxeny0yEI4U5o05buI0nY3p0vrm?=
 =?us-ascii?Q?mYDQchkV4iOlLpF8bYdJ+8n/pxD0MbeF5TnkGa2HfAxN+6y7fWilL87DigHy?=
 =?us-ascii?Q?uhEbPmYgWMihcqWwaf//PGTVJXbDiP05QWkpf14uo57YuAWdSNHj/QaZD7hT?=
 =?us-ascii?Q?xh8H4qKkKEo0YMS4I7DgKNcHVwHb1zDSFUVDMmN6fc3YD3V9cM2QF7LP1Twi?=
 =?us-ascii?Q?xrpNVNYoiByqTYpJOZW+A+dre32g7d4Kewa1nCPSrjGtPGM5uzbXr8Gm9FeV?=
 =?us-ascii?Q?+otJOYYCybqTBOTfdWvOXLHPMeiYdyeUxNj0AAh73DownZwB+wC8cICDRUyQ?=
 =?us-ascii?Q?SoZo4WWn5qCouj+tuUwqECXprKRkAPaQLB3EVloOzclTVqIs0QZwgeow9R2G?=
 =?us-ascii?Q?bOdXm7p9BIJhGVOAEXqsvHBC3pJMu9YWUIpzNFKdLE2WPE10ilC7f9u77hiu?=
 =?us-ascii?Q?vEGZDV0P2sLRzq50u9Dp1YOaRvXsZk5uEsbVy3zT6MphUNePZ/CfgM46b/d+?=
 =?us-ascii?Q?EZHFEzOg1YYmWSHqZP83ix/yvhhORgnrVq6DCAD7mh24Nw5bOcknkVCymIEP?=
 =?us-ascii?Q?0QLAUdIefcRv1KI3iHLhKarmX8PZ7Hu9AKzl8fltQ9vvpuIvG+/RT59dnEa6?=
 =?us-ascii?Q?cYr0ZEZarB5QTWgX3xjjtfIBekv8j1eLpsnxDvJvE7/aPBPAB6pzVoaPVHUU?=
X-MS-Exchange-AntiSpam-MessageData-1: KrJMMV//nUDD+rXvB9nyA3azGFG/c3wFYH4=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4db7677-82fc-4bea-f9d7-08de76c16c53
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 12:03:45.3312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phrMc75Sx7U8omappVEftIPqooo7se7eleLmrMHyWLLNitas0hag5i1wUpWx8omRM+B1uoumOmgX2cnOjGNrmxUnXqkOAqCuYz+Rs4luRHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4807
X-Authority-Analysis: v=2.4 cv=LqWfC3dc c=1 sm=1 tr=0 ts=69a2d9a4 cx=c_pps
 a=V6MklVWPegrOQeIbI7BYwA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=q_6G7NMapxrjoh7M8JQA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: vjROenE-VxPAhGrfJJd7UdP5n0QOg76z
X-Proofpoint-ORIG-GUID: vjROenE-VxPAhGrfJJd7UdP5n0QOg76z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDExMSBTYWx0ZWRfX1xTlTcI6n1s4
 inyNK9iBLu/aBojzTQpbP8F2dhLLo93bwq47jCryXutByYiejq/9TpTNKKthTgkDcy58HEpaqQb
 6bdYW6985gSZ/JOSMvhLda3/WD4z5mSWC/1cVG86exqjEtwdSVQKD7oL255ADToPUlMo1k39jio
 +zOFlBtyTUG37aOplrXnmJYMj2TGgfJPWLSaeQN7VH1yqmFv94gEGbj+QdSd+pQq/N7CbeRY+JI
 acZzpnP5c3UHVXPLI28GhOPj9YiIJr/nGsvxNNkthqn8vvS/TmpOM5gwId6LRH8EAw4p3T4mJ6J
 L19bMbQon0g4bqEfI82M4pGoZ2fqack2Q5MhmYbNwoIVMHZNg4H+t2mHnoXiE/N0RPv1uQmGYuV
 iSJcfutmGtgdWFK/v3Yh9ZVyBnon3DvBcP701Z/9cTp1IHn4VIjJ8Um8JyJfzH8mGKS0Ck9EzjF
 o9zt0lCHfft8qv3Ms8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602280111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,nvidia.com,yahoo.com,gmail.com,vger.kernel.org,windriver.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220064-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 303DC1C2C04
X-Rspamd-Action: no action

From: Ionut Nechita <ionut.nechita@windriver.com>

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi,

This is v4 of the patch adding owner-tracked reentrant locking for
pci_rescan_remove_lock in sriov_add_vfs() and sriov_del_vfs(), to
serialize VF addition/removal against concurrent hotplug events
(including platform-generated events on s390) without deadlocking
on paths that already hold the lock.

Rebased on linux-next (next-20260227).

Changes in v4:
 - Rebased on linux-next (next-20260227)
 - Declared pci_rescan_remove_owner as const pointer
   (const struct task_struct *) to make clear it is not meant to
   modify the task (Benjamin Block)
 - Added Reviewed-by and Tested-by from Benjamin Block (IBM)

Changes in v3:
 - Rebased on linux-next (next-20260225)
 - Added Tested-by from Dragos Tatulea (NVIDIA)
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

Link: https://lore.kernel.org/linux-pci/20260214193235.262219-3-ionut.nechita@windriver.com/ [v1]
Link: https://lore.kernel.org/linux-pci/20260219212648.82606-1-ionut.nechita@windriver.com/ [v2]
Link: https://lore.kernel.org/linux-pci/20260225202434.18737-1-ionut.nechita@windriver.com/ [v3]

Ionut Nechita (1):
  PCI/IOV: Add reentrant locking in sriov_add_vfs/sriov_del_vfs for
    complete serialization

 drivers/pci/iov.c   |  7 +++++++
 drivers/pci/probe.c | 19 +++++++++++++++++++
 include/linux/pci.h |  2 ++
 3 files changed, 28 insertions(+)

--
2.53.0


