Return-Path: <stable+bounces-219704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEaxJqpan2lRagQAu9opvQ
	(envelope-from <stable+bounces-219704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 21:25:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B68D19D2C2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 21:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47E4E3042949
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 20:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ADD30BBA9;
	Wed, 25 Feb 2026 20:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="TfBu85mq"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B54306B3B;
	Wed, 25 Feb 2026 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772051107; cv=fail; b=KAYWQHXWBV02prXawI2UcLC7wBgQ/O/T9FR1PCJ9NXprKoiJGc/ZkiVW3Fp5CIOI74mNJFpG+TAYlts03w45476V2IGvY8Biq8Yyta5rEf1YEle4jeokm1X7TEmmFRhdjpC8iN73E1wGWJQ2wULuiXiFsBnFE9OaA/69b4eoU28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772051107; c=relaxed/simple;
	bh=s9LTSPkhojNt5bVTbG7vhizsKgPicxieii68OsD0deg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OsIx/wm0JUju5v2H00pK5JN5zqSVGdGr3y4Nd/MDNNWadgYcm/uTIYnTscQ/O9HqEp/j0eDKO+vuMPz2AL7V4o/3o1bAL/uYx2yFpX3jWisN7xk5+xp8Tk6hwy861WxpWbpnu84+jiSHdOEZ4/TnmSexLXxNtpUYSkqL4vj4WLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=TfBu85mq; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PBkdga2232984;
	Wed, 25 Feb 2026 12:24:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=XFwHP5zkmRm0taqKTRaGZScdPcAR9e64MPt/2+5e+8I=; b=
	TfBu85mqxSoebS41vXivNZwT1dr+68bCPoAwzG3bY6k2shnhVF/YVEDjLOuvVFR0
	v0ZNywbK5woa1g9U2s2B2jyWRieOtmTNHRFwPQPhfQG23w9MzWez8C6CB89SPeGr
	qFay4IuHQgu2vkO69czuUVOrwBRAEIJkhKXEpNr2q7vRutmPnqeu3H70855Pknv8
	7uveHkltBZq7U8Aavebwn/IfywrraPWWEESZvrJE9cCHvIBMIb1OHZJPLlRuJaB/
	8Aer8+sMRJRLFr01IrXIk0gKRq0byjJxpH7MWscuO7SzL/yOPLnXElD344ExScyp
	hWrIz9xAhBT2Q6tCoq7q9g==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cfd3k579e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 12:24:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w83TlS+tdAn5E8farMVZSi3c6peiNU/cj7siXflmGwKg6B573/xUM6APytstmD2+QffFfP0nnLevb3Ig4wRT9NtCIWaUUCBzRed+IjrlRIfJDC9w0JkAomTv1tPkOARDQ66tbPdA763qWQpw94uea/sjAawNPTYE/8iOjx73WtagP6OXXy7bTLU7etZeLTbPog4id3/Qjf4QGFL4xb+7nfCIH2e2517xud1/xj5DAZSAYOWbOLCtL/kNTg4OBy1g2J0sE5Y9Nalr0HoP2X3r3N/Wjpg0bqWnMdgKPn5TidtqRclCLSbK+AQDQZc5jPBER09kesawm13LAJntSVyfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFwHP5zkmRm0taqKTRaGZScdPcAR9e64MPt/2+5e+8I=;
 b=WASJ/i2H3pr2xRCHG1RHPakz8Ip/lPC1EAoflEpS174bCsxs1bjjPYLEQ3ol3fmRmFwQXA0etu2DwH/yGpAdkCdTjFItYOVnL5P5SG2EUe2tmISsd2xxZ4qxRIJKLJ1l0tvh9xVWH5Jo8u9O7RQvCYGo1F5fnm8sgFhFvm0281qSz3igtp6RpBS69RT+Pmqoxp9R04ZYQc2TmfFW0P2Y/l3ll3FX/HuiqkWNOFclWO2DwAle9GHovdPk0xNsHh0scTkDC3YFPOaezp9+2VrpH/g0uUtL9z698heM2fJL/LBtFyLBPeGOU7CIQ+NkG5alFVppcGvd/DQwxk3rM5FKaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by DM4PR11MB6333.namprd11.prod.outlook.com (2603:10b6:8:b4::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.22; Wed, 25 Feb 2026 20:24:52 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 20:24:52 +0000
From: ionut.nechita@windriver.com
To: bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, alifm@linux.ibm.com, julianr@linux.ibm.com,
        dtatulea@nvidia.com, ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v3 1/1] PCI/IOV: Add reentrant locking in sriov_add_vfs/sriov_del_vfs for complete serialization
Date: Wed, 25 Feb 2026 22:24:34 +0200
Message-ID: <20260225202434.18737-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225202434.18737-1-ionut.nechita@windriver.com>
References: <20260225202434.18737-1-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 37bc89d7-800b-4157-d5d3-08de74abee4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	odzFY8CaXwtTTVacEpv7s0A0js+o+1RA+zSOksTWj+vUzM6b8txVQfHPXbznlOv8GjdutkwGhEMRciB+gOoh/Jiav+VXP5K+i+yr0xNY/RXyu0e2CoaKu3b7EFqmwzi0LRxKYy5+QACC2NSuDdX4T9fM2EfXQWmJnm0cPREDDhlFS9CnPU0hQVVpxEGemw5gak875hoLrfW8uYvrCs8tg0o5taqOqjSMIV8uUhTW+wnSG+8G4gAN3D6dK4ahoUyzNFVK2cgINnDGbBrgnjA+ZJQA9yFdwvphkXtBGSueb6NSdGZMaj7ha1rlpYIFe9+3+56Ja7riWnjnqkHgkFgkW3Kvmojqaiaca1mSGOHjYzUcu6CY1K2/Xnujw4kPLOi1u3vobLUWA0ToZXK+UcYr0o7Gh/zBPy2g+ZtXZLp2msEVglmfgd0Rq81JWjcw5dszwTrry4FkP6TVfTKVOYjNu09DXFirVLKCmfVHFT33x8f9T5f9UhjqIzRa4HDRlLvJw2BRLkt7P/r72PH+HXZLGZSXRQFL7Hj4KPsWxVWOZ1dMofM4N3aP/7yjZRJeaOre7LD4+I8tao1p9q0ej0l8gQ7ZlGzY5NXh9zkvpmD7F0DZNoiX+yzQtLSgec+VaRSs9Mcqn7k5dspWt0ysPb6EX7poN6OzDZeZDyORDHu1ZFC2XWORn7s4935YP5HSTU8hH147mWRkSpxzLu8c59PNtuxIbqWTVta06X1O6uYIDT0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lp3rnGWDG4egFwK+QeJmxzxGSHx+XOlt9xggvLq9viryTW31+NBtHU6YxRnI?=
 =?us-ascii?Q?+exmYPhUaxaoCvY86guAkBL6Yv9KlwISKhaOYsGGSKSCFBrPonw35x6qwBhC?=
 =?us-ascii?Q?yGZVGvMCl5WuVkilznLyKh+ODM+OnbV1qyZRzUmSI871JpFuspdiCjtycLSk?=
 =?us-ascii?Q?POhGwkbQHeGe4uXJafJcGmCpvheIIV7BP4U+KPU12p8Hz0AIz/0kwYxz+VD2?=
 =?us-ascii?Q?OKIxCSbkkhYVp7Hn83Gs0FCUEOyxsNhKpW2+m98q2BR+KTtfXaO6ruKP1htM?=
 =?us-ascii?Q?3XWjOHZQX4EiaIJ4k/oDQ6JhTddz+gI/it1NB7fQ3kKR0LhqCS88CIF4HFTv?=
 =?us-ascii?Q?NOB/RzvSfVS0lQeFRttRquSsIBELynB5EwNCXWCXF8yCnjst6CkF4DJA/KWa?=
 =?us-ascii?Q?sNElK4zcM9MHRyJD75MEfNvgEP9GuGX1cU5SymSjLYqEiduGuArYIpuV5U2i?=
 =?us-ascii?Q?h1Bn+RkKzZNyW4zj+cTXDoSrByAfmDor6dug0YFgwJ12f12vocsuiSm6rRJG?=
 =?us-ascii?Q?t15K8An7uJMVsRis32JeIG2IG47FTSZRRm8/sHf6qQm0cJHtSom8JIYC3NKw?=
 =?us-ascii?Q?21WOw7O5LnHN3y4MxIzqNfc21NC9YDlu+2s83sbqL8FLaVbWP8j/FT1q0rCV?=
 =?us-ascii?Q?BoVCiq8ZejXqcSu5inQUdBo7iUDQ0Fhkh+egv9ucAMbEFDF3TqxQcbVCYGhP?=
 =?us-ascii?Q?ZYm3NMp0sMwZk71wSjqNwDcsQMlReocWdRBpZ6RvYYjrnQkuJSlJtjuMiKnC?=
 =?us-ascii?Q?7O/UK3B027J8iX+fG/TDu+GCwOB/RVENmlg5QKyVZwVmQZ9npBNQbwkitYCg?=
 =?us-ascii?Q?9UecPCfS6DruNe9/erNGtOksBmmrn7czqL276eQrXEHYy2D5IMlXzdkXfJf4?=
 =?us-ascii?Q?bEJhwhISw0z0kFXt9vtXnzrz+7E0gs9QUeN0X9zJcNAAyZAXhgR2qcjVrM+O?=
 =?us-ascii?Q?BypzbqmGdpxiRp6dvU854qVvWhe158ZNT27zkztKIM0Z7XykejYx5G7hvU/f?=
 =?us-ascii?Q?9tmMfSMNZlQvus0R5lCfEe6hv6kHhfEeFcoEpj/3cLl578ZHl/alseOGg+FY?=
 =?us-ascii?Q?zQGvaBT1mScnXye5LFbSf3g73P1G8kyImP/+mY+JCXP8WBf0Mp8F8w/SCbni?=
 =?us-ascii?Q?MiAobXb22uCbcOUWBEYkOzhNuJLv+K8S7dm9kRMT+oTt8lBzxUshhTGBmwiU?=
 =?us-ascii?Q?rXQlmTIAgEc2qsHMMJCgI5E8J8L+GIPrOxfKADIcvNAjVHfxmL9r5+Yu/wSh?=
 =?us-ascii?Q?sctfIUpLMnA7D/PA4s14RAlLsIHAKlBZ4nXl7eAYsiIDP3heW41SBR8VMKma?=
 =?us-ascii?Q?iPdqPUJx3oHNLHgSAaUbj1zD0ksUw/811XmaQeJPQn84XGP99MDugiKi3UlM?=
 =?us-ascii?Q?q6Y8L4tPFc/QVXUHGYaOQ/5Q2tfzy+GX9oB+g6Tb3CmlS1xIpsTudiOIb0/5?=
 =?us-ascii?Q?8kyfaCuEGJFaxS7VaPzhWB3F9Mjo7kEDoPta/ht2QKv333O1EnSQwm0rB0gv?=
 =?us-ascii?Q?EWx2uEDpLvmgqlVNBx9TwR152XGGEqhCIcWIDx/4/Xz2gWSHAz9CSmKQRWMx?=
 =?us-ascii?Q?8lOX4yqH5HEO5Zp1Wqb9KOV5MByi7PsvmliWc1AD3HpyHcpaOULkXxl4Ph6k?=
 =?us-ascii?Q?SqwmoE02X6dtqbzCgYiZ36/XZUqaP/l39QKNo220XamdMl6Kf62rLXdZSLn6?=
 =?us-ascii?Q?MV2vnnRMUmyoJ4ncE2/cMI1VHlIEC0QHkWT5FNT0KUajPuAGpr90jmC3hVn0?=
 =?us-ascii?Q?fUzg2XQYmpKijGKMlYGsYgjlCXyTh8GRNeTmgWbVKt8S9XxdSLkM70vt/wgA?=
X-MS-Exchange-AntiSpam-MessageData-1: oqzZuvfzISuEHybv3mGrBKsscr5aAT7IvVw=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bc89d7-800b-4157-d5d3-08de74abee4d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 20:24:52.4450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfNoevEc4/aDfghW9G2fSIxFbCTboBIG+996hIohLn09zhlW9DwH/Kw/dYGH5h/QZp9mS7Q3h/wIkEFxLEC6jeeRZh6yqTpB9/aZgpcaNv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6333
X-Proofpoint-GUID: s2WgT5BznemIIA-sPFWxa3U0sF065nju
X-Authority-Analysis: v=2.4 cv=Bo2QAIX5 c=1 sm=1 tr=0 ts=699f5a96 cx=c_pps
 a=5/iD8UG2uIJM/AKiuvK9Ew==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8 a=CjxXgO3LAAAA:8
 a=Ea_S87Vdr1rjus-4YBkA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: s2WgT5BznemIIA-sPFWxa3U0sF065nju
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE5NSBTYWx0ZWRfXxCrcaArQjmmI
 TKSdwb0iBHhXCH66vwDIJMyqTPO63TGKVJ6anweHf2NS+aPwVYX1fnJk5Xg86Amwj2kMLLoCyBb
 wjql9BZSccvE1covF8saXDSPsjy/0SAty2zdj/t1ikIIXK1LHCHP4hwWoyCY3XmwB1+jk1BWntk
 fMYdZ/yvAYWSs/V0q47JeDwSZxcbGbwdAluoujBDwRiZ9yXGnuQjPgR8fgxG+6im7CB5cFzwA4k
 T2/i71L7WmGdRS6Mu9+br5EPw0atqRWpNIeddenyUzgmBsv7tUyCooirLoNI640roko75iZGIe6
 mW1Gi3JjSUyfKmsnndcdyLCnsOupwbjFSd0zW5eGDJLXwNNnzHJW8zxa6jsKLdCXMlz62SM4/EZ
 YyXiapLvfQNM/qC7gD9zsnEP7sy61ixymzou06Ny7iCVHdQh8pp3qvDyYu5vrIHbeYFSSHDM3O2
 hHFzPUw9z8omAExxfug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602250195
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
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
	TAGGED_FROM(0.00)[bounces-219704-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[windriver.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1B68D19D2C2
X-Rspamd-Action: no action

From: Ionut Nechita <ionut.nechita@windriver.com>

After reverting commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
locking when enabling/disabling SR-IOV") and moving the lock to
sriov_numvfs_store(), the path through driver .remove() (e.g. rmmod,
or manual unbind) that calls pci_disable_sriov() directly remains
unprotected against concurrent hotplug events. This affects any SR-IOV
capable driver that calls pci_disable_sriov() from its .remove()
callback (i40e, ice, mlx5, bnxt, etc.).

On s390, platform-generated hot-unplug events for VFs can race with
sriov_del_vfs() when a PF driver is being unloaded. The platform event
handler takes pci_rescan_remove_lock, but sriov_del_vfs() does not,
leading to double removal and list corruption.

We cannot use a plain mutex_lock() here because sriov_del_vfs() may also
be called from paths that already hold pci_rescan_remove_lock (e.g.
remove_store -> pci_stop_and_remove_bus_device_locked, or
sriov_numvfs_store with the lock taken by the previous patch). Using
mutex_lock() in those cases would deadlock.

Instead, introduce owner tracking for pci_rescan_remove_lock via a new
pci_lock_rescan_remove_reentrant() helper. This function checks if the
current task already holds the lock:
 - If the lock is not held: acquires it and returns true, providing
   full serialization against concurrent hotplug events (including
   platform-generated events on s390).
 - If the lock is already held by the current task (reentrant call from
   remove_store or sriov_numvfs_store paths): returns false without
   re-acquiring, avoiding deadlock while the caller already provides
   the necessary serialization.
 - If the lock is held by another task (concurrent hotplug): blocks
   until the lock is released, then acquires it, providing complete
   serialization. This is the key improvement over a trylock approach.

A matching pci_unlock_rescan_remove_reentrant() helper takes the return
value of the lock function as argument, so callers don't need to
open-code the conditional unlock.

The "reentrant" naming is chosen to avoid confusion with existing
mutex_lock_nested() which is a lockdep annotation concept, not actual
reentrant locking.

Note: owner-tracking patterns for reentrant lock behavior exist elsewhere
in the kernel, for example in the regulator core (drivers/regulator/core.c)
with rdev->mutex_owner, and in the PPP subsystem (drivers/net/ppp/
ppp_generic.c) with xmit_recursion->owner.

The declarations are placed in include/linux/pci.h alongside the existing
pci_lock_rescan_remove()/pci_unlock_rescan_remove() declarations to
maintain API consistency and allow use by external drivers if needed.

Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
Cc: stable@vger.kernel.org
Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
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

 drivers/pci/iov.c   |  7 +++++++
 drivers/pci/probe.c | 19 +++++++++++++++++++
 include/linux/pci.h |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9c..adbe4ecc587c9 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -629,19 +629,23 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 {
 	unsigned int i;
 	int rc;
+	bool locked;
 
 	if (dev->no_vf_scan)
 		return 0;
 
+	locked = pci_lock_rescan_remove_reentrant();
 	for (i = 0; i < num_vfs; i++) {
 		rc = pci_iov_add_virtfn(dev, i);
 		if (rc)
 			goto failed;
 	}
+	pci_unlock_rescan_remove_reentrant(locked);
 	return 0;
 failed:
 	while (i--)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove_reentrant(locked);
 
 	return rc;
 }
@@ -764,10 +768,13 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 static void sriov_del_vfs(struct pci_dev *dev)
 {
 	struct pci_sriov *iov = dev->sriov;
+	bool locked;
 	int i;
 
+	locked = pci_lock_rescan_remove_reentrant();
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove_reentrant(locked);
 }
 
 static void sriov_disable(struct pci_dev *dev)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bccc7a4bdd794..467362c277f19 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3509,19 +3509,38 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  * routines should always be executed under this mutex.
  */
 DEFINE_MUTEX(pci_rescan_remove_lock);
+static struct task_struct *pci_rescan_remove_owner;
 
 void pci_lock_rescan_remove(void)
 {
 	mutex_lock(&pci_rescan_remove_lock);
+	pci_rescan_remove_owner = current;
 }
 EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
 
 void pci_unlock_rescan_remove(void)
 {
+	pci_rescan_remove_owner = NULL;
 	mutex_unlock(&pci_rescan_remove_lock);
 }
 EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);
 
+bool pci_lock_rescan_remove_reentrant(void)
+{
+	if (pci_rescan_remove_owner == current)
+		return false;
+	pci_lock_rescan_remove();
+	return true;
+}
+EXPORT_SYMBOL_GPL(pci_lock_rescan_remove_reentrant);
+
+void pci_unlock_rescan_remove_reentrant(const bool locked)
+{
+	if (locked)
+		pci_unlock_rescan_remove();
+}
+EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove_reentrant);
+
 static int __init pci_sort_bf_cmp(const struct device *d_a,
 				  const struct device *d_b)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d51230..080950f0bab33 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1535,6 +1535,8 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev);
 unsigned int pci_rescan_bus(struct pci_bus *bus);
 void pci_lock_rescan_remove(void);
 void pci_unlock_rescan_remove(void);
+bool pci_lock_rescan_remove_reentrant(void);
+void pci_unlock_rescan_remove_reentrant(const bool locked);
 
 /* Vital Product Data routines */
 ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
-- 
2.53.0


