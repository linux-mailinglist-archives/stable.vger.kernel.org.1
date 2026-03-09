Return-Path: <stable+bounces-223721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UECVER0mr2mzOgIAu9opvQ
	(envelope-from <stable+bounces-223721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 20:57:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E28C9240762
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 20:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0974A3031E82
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 19:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05AA410D1F;
	Mon,  9 Mar 2026 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="L5+5F1Dj"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A16258ED4;
	Mon,  9 Mar 2026 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085817; cv=fail; b=EI5wGOizJs3DJ0N0fSLTxo9j26Vt+26pM1vuCDsDbgZEMnNToVGXrGRKjPPV4yyehxrtlAmE+YyksA/H+mSE4hfp3XF09PSpy2hN4dngPNj7nNCPmH1pB9u3rxLaiCK82K2PreY1YHp5XVFxBiLO2A2meRk4rPDnvo5pnbfYvKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085817; c=relaxed/simple;
	bh=Qq7+Rarb2hUJlp395xAUFDRwXpkkmfJeUFjX6gD2A+E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ozCO/9EQkT/+J0YNDxFQPJRa8b5X6GWR4nz9W3+K335gXjCODQlBwiXfSFCsqtLp3zVPZT+xIGURrZfh2dky612L8WqffKEz9Gqkk4HxAiUTLgcEfLyHREd1VUTOrvypHzPXMx4HIXrCj/8A03BHHaZq2pEkldWmWBuNyydaNiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=L5+5F1Dj; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6295JF1k4055645;
	Mon, 9 Mar 2026 19:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=n0kB719zy
	T1+Idy/nY4ocFk0qymWqH4v+FtpTcMYJ9Q=; b=L5+5F1DjegsfGxYzxjuzbkXTd
	f0llkN0QoN/z2HgvYd/+A+0Ux8IpBuJlr1Mn7ocVzqfpJ75edmh0zMLQRFaxKaR/
	I6xCAe8ZrWo9HZOp0rjukSPjXGzHox+xfQyyBXM8nQyTavNviWq9zjsWTjn7wIUl
	TWKts1/21srmZV7/QJ3ALr7ZVSTqAB1a1wCfuXg6jyA1f5j/dqbyB+pvPoA18pn3
	NCanuqVeWKuXd+o10STTYmH9zBn9P3XOg8P0ql09tnJ/rs7URGkNF/1x/aaI5ZRN
	aGYRJ1u/yUDzACPxJ8Tzs+UZw1S8a10cleLVTelHogP4pjMIUgT15qZOjkIQQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4crb082bn9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 19:49:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Osr9EE2hqUYL6q2B5zrQFwZaxIzlz5281VVGPyI70CghYEoAu6lJk1uNvNxw3Vwj5IHHGsHkXHrDGCYeN3VeM6Vu696zwV7plDQV+t+NjmV3+VHSUIFL/43tdwsgfK2TkG6pDE+//tTxFCiIU+S7DU3Y1pLFAgSDsW0z4cYfciS0ICMpShL+ACvHNyIktF7VDpz5SrVyIGHpnIBWqWHLaEEl2EMDbVOpIcwBwZIeWoyBGkS0ajAUqUn+ItApXeMfc14pNbi4lCR4gbAEy9ozGpvnydS+L024urZ3s2t0dtDYqTYx1DJf4YCxoBUc1pghWln5J7g+fJ3vliA1GZtR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0kB719zyT1+Idy/nY4ocFk0qymWqH4v+FtpTcMYJ9Q=;
 b=ZUtazqxK/geet0pLywV1ysu0dLi3K3AOmP7R5Ul2VOohqEsRHPrGK/RwxnVwTDP15oEkaVNmag9xDgx7SoK31lqmnTMKYJx+GqEB2+0CMv/DRoulR4XkYWMmhtG5CB1bKW3akOOKXJ2grSLvrLBcKcovSxuJi1kphAqAQ0PCJfJNKl+EvF1T6JV5xboRlilJa4zPVotC0vyUc5qabj0Dpvn7PR9oDpfwGGdCzzRRS1nnF3TI9wjfOk8Qd3u/rmEK1pTr32DZPrZ8m6Vag3A/uimpbWJDLVUtKTVVmHBs2angxR/yM7i3q6XOF4Uw6Szu8X9y9qobjW7Xli025F//dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by PH7PR11MB6908.namprd11.prod.outlook.com (2603:10b6:510:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 19:49:40 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 19:49:40 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, alifm@linux.ibm.com, julianr@linux.ibm.com,
        dtatulea@nvidia.com, mani@kernel.org, lukas@wunner.de,
        kbusch@kernel.org, ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v8 0/1] PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect sriov_add_vfs/sriov_del_vfs
Date: Mon,  9 Mar 2026 21:49:18 +0200
Message-ID: <20260309194920.16459-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0126.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::19) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|PH7PR11MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: e5fb0ddf-01e2-46b1-7c81-08de7e14fffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	Ts/oLIhX8H4h7lCxAmF1aQUdXH377O/rXHXk3QpGZy4m69YMbFZ3Yw4jbTLnGp2YzuWssRxFBlr3RqhdNbUKSpgMCob94DZ140qTEmkW3ueJDNGvQQVEzISXmMvA3R86w4L8I/Tkr6IkfxkIw2VTiDwlQbox/Vh0KInEUv5NHagNSnni+v0b7pv0AYgL/6zyQTTucl/vaoBCwY3tBPrnRjGcqvlXhmrtar2hXnjwV//qYMdjX38keBcNXfLOrNzrc6D4wL90RgUdqHwvM2esmLmAC3yJL5YycP+NT/aZkqw4o3sY0iMPJerumOLbQsjjaibBdDiv1UMu6uuOYh+i/+KY1CP3pbyoJ2zy8Ob7La++LtJIygwRKAZidWJHcYmN74DrB/AOzAYTIVWHVJADrP72PKYXfJqBAxmDyCq5riKS1ShhUMtQUU4vpXiJwmVa9UiyerLUwMf0gApfZs2JlmlrYat8A0jpyIHa8yE9ZW0uXdo4Uqd0m+gRqNwAWAqLYxC9QSkSs2L4BWt1eUNuAxMAPmfBTojwBdGJCXGpDWr37X/7H57Terd7elrcZwFy4N6FcruXssjVZy/OvUY+NGTAnD9mc5pvTBKuT5iTSmLOgTbYTxdBJhY6q/A8vGvgLseXZ1KQK20GN7GG3coRXH9hMU9o1+pXGvz0B0n47K/jsLyVsdiuInL+gZ6vr8X0JZf4qVf6gmRA3F77JMP0EWR7VmgQeV5EERS2KgLipEHk51k6lFOS3QcEHd6muV0l
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ExgICBheVpj4/y6p3XP9IY7zYTP/1gPbmt4W15ch1KYT+miV0MKew/C4bdxT?=
 =?us-ascii?Q?s9Q9M6k67NnP0DKGRrP0z+pw8CqW6d7Nxf/Fwfrw+AkvYZTYepK48rrEWIfZ?=
 =?us-ascii?Q?aB5zKuC6sBrtEeNqWTsviaVjCnxUkCyPeiFGrCNqam1gMZAen6RvoLwEJAiu?=
 =?us-ascii?Q?DUHqrlsYIwgQ9jaR5dnICDg1F8a7b9nq0eN60yF7xVYqCY04s8gU1gg2feei?=
 =?us-ascii?Q?zPW1LA3QGaAlR+xXPc1dGLDqu5bWT0StArt94V8JvXVOdzD6Mu2H0pkPz+O3?=
 =?us-ascii?Q?VK+KOsYJcjwDL7DFnJTYi8KpzR8TO7nZu519gjyngY1rKBymSuS2f2D4Sels?=
 =?us-ascii?Q?FPIGysEop89lvXR9I1kTjLHLtZbtOFZMrN2yqmWwyg7SWnL5bF3jBOOORYpg?=
 =?us-ascii?Q?UzAnJDG6TyU5jUHxWOzcnWgn4ocr5/IzgFAFqQZbRizjJu2E0+x/Co9KB65A?=
 =?us-ascii?Q?CYozbElyGUgJf/6bpxZMiaajEKsXw2Ij8OBZSyyCujhHMWNw3/FKm46EmvQz?=
 =?us-ascii?Q?q9gS5bpEjFDsd/TcsfMoWXghPmTTCWT7zkUw2u+zc0q01KDyJ/JunVP2lDnD?=
 =?us-ascii?Q?MZF8JHJnWqJ4X/4t3Cu2hkd6xwDgIVJv6hAeYeFyzgBcXqfZyAlZq5sycIXA?=
 =?us-ascii?Q?YRxBUm7TlbRJXd2Kc8Xve5LwNHA5f4Pi7UxHvDHPnqhKRYdoEyH9IfQg1lnO?=
 =?us-ascii?Q?CewaeJvrCQdNM1+XRUCok0PQiUoOZ5L7CPkOD7/Oput9mUnQg/11+eLU+xOK?=
 =?us-ascii?Q?XyFv6iRieZTG1rAnpE+OEXflJZQVj5Fn0ygpDy+QN0PeoxQa1fMnaK7H9OTS?=
 =?us-ascii?Q?gl6nCP2wtSEk70c1Lq5H4HVKHeEQlcw/lGlRDZTqs11An8c0+j2Lo7YO960h?=
 =?us-ascii?Q?a+jsfX78ZZvrjT0FIabdbUf7Gulbugb7n/MlZ6MlXEMnkQYFIRBGbptPH/W9?=
 =?us-ascii?Q?/0CQhCs5SsDJuscS0pio/Y5bvU7/II0L4awrmCVZ9fsubWjl0xvrK5JPfweA?=
 =?us-ascii?Q?EAxSFdn0/yNNiEXohVQEBnwELjKpcURPmU9YeKj8N3E32xgZqdTOT6Rwn3v7?=
 =?us-ascii?Q?Aq3qHZEfzTIaDrp82F5NPKX1r+I6m7dwkZwxXS+pMoRm9psgq2xzx77IbNm4?=
 =?us-ascii?Q?NJ5BBiGkYQQwif96bYxZ+QcUJuEG4IWUcTzD/v5EwbhA99Ch9dx6bM/+qfMT?=
 =?us-ascii?Q?ph04PDI5M6Filo7Ff5sCeOm9lhYLUeFONs6r4mCWaYR2Op0Z4Ji8HE5Sh8iN?=
 =?us-ascii?Q?UgvH03wFm/yfXNyJZHLK5AnvpGB7zgsLvJkGoeYW9EPbON3vJJRs/yNPXYQV?=
 =?us-ascii?Q?cxNkGwUzI/VvMWbuAe6+OgJPWkoM84qbWmi9vn1/NjxWaR64TFmFy0xV8mEF?=
 =?us-ascii?Q?jqWJ4/CN2ZMD3LkQBc3CRP13h913dVN6RKPFf3MwXBE3OfsyjFj0DV8W9Ly1?=
 =?us-ascii?Q?n2SRiCIOx9WjNdOckB/atIX2OW0Gk4zrzWeIYkWIWg6T/a+VGqAdn1D/M9MU?=
 =?us-ascii?Q?RLie19qW0c9W7CzpZYyjd6Z04e7zcS9gXKDySabIQy7nA/aMZJDq5H7Eexaw?=
 =?us-ascii?Q?J0+MycjPYYb7l6oTEtIGXQzAvXgqwA8vhKMpC3JN3JJgGhR5majLfQP56ob8?=
 =?us-ascii?Q?6U3sKlOBoC4p2I/lNGKrC4R7yYqRlLcHhui+w/5NEtQdRV6KSdfdnXMTRPPv?=
 =?us-ascii?Q?lhhZhYtt6bmWWa1UdPKCYtv6VcE+IGALWxBizwPI8krjXltcXeW9+TGeX2T/?=
 =?us-ascii?Q?mGmsDF/bC3JGdpU+AOsQYFlcfXZhFpLv0F2FkCJJVyFT+Fi9a5W/miRuz200?=
X-MS-Exchange-AntiSpam-MessageData-1: EIghdlk+PYhTPpj2sbeS6hsgJn/WyOjGtDk=
X-Exchange-RoutingPolicyChecked:
	j/Gd6LKYiUEBaBw/KjiTLOLxw50mNGe1yahJcu9WJWrxaNtkmFZFB1plA4oyysdiMn2l5Dm5DKerU1cVqx9xwfxR2a81nyhheCcVYMJXdReNNT5IGgbE0PgrcJo+azzL0qyNmGQYceZV/PcQf1t2D7SqpXgaDcKUEdnYqWjeI4n9sPvZKURO+1KfUftTxPg5r7JArUehf13Xx5Ud05639Tv/kPoURlIc74od6Ar2FULLE82BQ6klu/napyg2huMSK3WN9FHheJg8fra54lk0A2tvYiU/LnEhQEcuo+Nuf2xIV2lDagxOTi2KyYWbiN614XDTfxuKT1lUiKZtZHqJTw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5fb0ddf-01e2-46b1-7c81-08de7e14fffc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:49:39.8795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzFBE6H4mhYdj1QSjy9HmUGDpifQdVx/cZpECAadiASCnrljaNldK0hkFHq3KkdCD/mzeAmbYlRXgraIiFPqi3ig/J7AFtm+f1t3m+1srCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6908
X-Proofpoint-GUID: au4veFl67GIlSk2dQnP_dCQGi1YsXJ20
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE3NiBTYWx0ZWRfX38pTHkSDFfgB
 SiqpJctyBD6GTHr7f7xjR2PLfg4RJYfCiZKwfdQGjhPqMhZ7ZgZFog3dN+TT0b3r/uv7ZkIETqI
 inl99nt4omiDMnwh5Tf4eDGk/IXch1hOsciJ8rDTa5IkTNXaamGP3fxfRl8kI/5qCAyR6Z0Djf2
 kriUEr9lCVuVTgb6HRHCs0OmJnRh4SCEpCsyB1/GwItL7V2uyxSZuIVfwIClk92FQte8TZY9IWM
 VXEBk3BeAi2Y/ASA1w4j5YPayJao85B8l9FoqbpkOAuDFo8uEsqMB1C9vlZtrvbSYOvuIgGKYQJ
 PEDcA3yPCEuNfVrvxElyKgYNntB6gYIG+Mtj7gNqMZL62PBesdUjc7pH9cFP/MMk/7sZX8nhtIq
 Y/osfXkOYFWYDNNHRVI7dXuJ8kp46cztABLz+5dH12mPUfrTciQx+lknWxg66T7MSmEBAqF+KSw
 OetPwP4ktcauV2d3c+A==
X-Proofpoint-ORIG-GUID: au4veFl67GIlSk2dQnP_dCQGi1YsXJ20
X-Authority-Analysis: v=2.4 cv=UahciaSN c=1 sm=1 tr=0 ts=69af2457 cx=c_pps
 a=SMA1khf41ao6nOkIv5XeTA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=t7CeM3EgAAAA:8 a=26wv8n36nriTzGZiW7YA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090176
X-Rspamd-Queue-Id: E28C9240762
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,nvidia.com,wunner.de,yahoo.com,gmail.com,vger.kernel.org,lists.freedesktop.org,intel.com,windriver.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223721-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,windriver.com:dkim,windriver.com:email,windriver.com:mid];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Bjorn,

This is v8 of the fix for the SR-IOV race between driver .remove()
and concurrent hotplug events (particularly on s390).

This race has been independently observed by multiple organizations:
 - IBM (s390 platform-generated hot-unplug events racing with
   sriov_del_vfs during PF driver unload)
 - NVIDIA (tested by Dragos Tatulea in earlier versions)
 - Intel (xe driver hitting lockdep warnings and deadlocks when
   calling pci_disable_sriov from .remove, as reported and discussed
   in https://lore.kernel.org/all/20260227214048.12649-1-michal.wajdeczko@intel.com/)
 - Wind River (original reporter and patch author)

Changes since v7 (Mar 8):
- Added Reviewed-by and Tested-by from Benjamin Block (IBM), who
  ran tests in the IBM s390 test lab
- Rebased on linux-next (20260309)
- No code changes from v7

Changes since v6 (Mar 6):
- Replaced local pci_rescan_remove_owner / pci_rescan_remove_count
  variables with mutex_get_owner() for owner checking and a single
  pci_rescan_remove_reentrant_count depth counter, as tested and
  suggested by Benjamin Block
- Dropped Reviewed-by and Tested-by tags per Benjamin Block's
  feedback, since the implementation changed substantially between
  the reviewed version and the current one
- Added Suggested-by for Benjamin Block
- Rebased on linux-next (20260306)

Changes since v5 (Mar 3):
- Reworked based on Lukas Wunner's suggestion: instead of introducing
  separate pci_lock_rescan_remove_reentrant() /
  pci_unlock_rescan_remove_reentrant() helpers, make the existing
  pci_lock_rescan_remove() / pci_unlock_rescan_remove() themselves
  reentrant using owner tracking and a depth counter
- No new API: callers simply use pci_lock/unlock_rescan_remove()
  without needing to track any return value
- No changes to include/linux/pci.h
- Rebased on linux-next (20260306)

Changes since v4 (Feb 28):
- Replaced local pci_rescan_remove_owner variable with
  mutex_get_owner() to check lock ownership, as suggested by
  Manivannan Sadhasivam and agreed by Benjamin Block
- Removed owner tracking from pci_lock_rescan_remove() and
  pci_unlock_rescan_remove() - they are now unchanged from upstream
- Rebased on linux-next (20260302)

Changes since v3 (Feb 25):
- Rebased on linux-next (next-20260227)
- Declared pci_rescan_remove_owner as const pointer
  (const struct task_struct *) to make clear it is not meant to
  modify the task (Benjamin Block)
- Added Reviewed-by and Tested-by from Benjamin Block (IBM)

Changes since v2 (Feb 19):
- Rebased on linux-next (next-20260225)
- Added Tested-by from Dragos Tatulea (NVIDIA)
- No code changes from v2

Changes since v1 (Feb 14):
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

The problem: on s390, platform-generated hot-unplug events for VFs
can race with sriov_del_vfs() when a PF driver is being unloaded.
The platform event handler takes pci_rescan_remove_lock, but
sriov_del_vfs() does not, leading to double removal and list
corruption. We cannot use a plain mutex_lock() because
sriov_del_vfs() may be called from paths that already hold the
lock (deadlock), and mutex_trylock() cannot distinguish self from
other holders.

The same class of problem has been observed on Intel xe, where
pci_disable_sriov() is called from the driver's .remove() callback
without pci_rescan_remove_lock, but .remove() may itself be called
from a path that already holds the lock (e.g. remove_store ->
pci_stop_and_remove_bus_device_locked), leading to lockdep warnings
and potential deadlocks.

The fix makes pci_lock_rescan_remove() reentrant using
mutex_get_owner() and a depth counter: if the current task already
holds the lock, the counter is incremented;
pci_unlock_rescan_remove() decrements the counter and only releases
the mutex when it reaches zero. This keeps the existing API unchanged
while providing correct serialization.

Link: https://lore.kernel.org/linux-pci/20260214193235.262219-3-ionut.nechita@windriver.com/ [v1]
Link: https://lore.kernel.org/linux-pci/20260219212648.82606-1-ionut.nechita@windriver.com/ [v2]
Link: https://lore.kernel.org/linux-pci/20260225202434.18737-1-ionut.nechita@windriver.com/ [v3]
Link: https://lore.kernel.org/linux-pci/20260228120138.51197-2-ionut.nechita@windriver.com/ [v4]
Link: https://lore.kernel.org/linux-pci/20260303080903.28693-1-ionut.nechita@windriver.com/ [v5]
Link: https://lore.kernel.org/linux-pci/20260306082108.17322-1-ionut.nechita@windriver.com/ [v6]
Link: https://lore.kernel.org/linux-pci/20260308135352.80346-1-ionut.nechita@windriver.com/ [v7]

Ionut Nechita (Wind River) (1):
  PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect
    sriov_add_vfs/sriov_del_vfs

 drivers/pci/iov.c   |  5 +++++
 drivers/pci/probe.c | 11 +++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)


base-commit: ea4134533224d500b2985d30cde106aa3680905d
--
2.53.0


