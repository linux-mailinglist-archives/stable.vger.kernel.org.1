Return-Path: <stable+bounces-223317-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJQmNq+Oqml0TQEAu9opvQ
	(envelope-from <stable+bounces-223317-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 09:22:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 899D921D012
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 09:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3567D302DAA8
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 08:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB06376486;
	Fri,  6 Mar 2026 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="QQ2fDKky"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD64378D71;
	Fri,  6 Mar 2026 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772785312; cv=fail; b=ktrCN3kFU9exJYBJqpX2Mpx2qQhv87FiDC+6UFpXHgrR6GPkxM2DpG51WfoYcO7XL6hxH6E/G9zdNGV8nOkC65knP0Pxh4gIOBnIKk3y46orF9DUQyss8v5CHgwEhsxfAiPjiiVFnfS4+tvjSLIYDt5Tt5jRaGMwlz6mIkL0g+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772785312; c=relaxed/simple;
	bh=nxN1nyygBlwUrY/1mJ9iAoZcW8c+tojy75JObD6axfc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=exsa/LBnVgoPaXKiLqD8/pI+hv+wmszhgAkwK9KeaLrp3umM45+WRXmHVFDSMQfipen4X6XHA3DwWFnskbhk9AmXAGHFMC7MQAsjzoSOs0CnLincLPhKNPViKFrYyJp6D4CzWM8mSiXi2J2XxzXtzP4VeXSzUlvyfnRYF/2mKJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=QQ2fDKky; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6267q34j3462864;
	Fri, 6 Mar 2026 00:21:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=lVWChNddX
	AbirgcKtCKSIx79qG1ELIpqiu1uPUNqHko=; b=QQ2fDKkye9CRQ2isCBLJFsmEF
	vERXDtgBRj1D5MuLGg7stmvZNJg/g61Py3ut97X3nsoKVUN86tRqi4JX78jXRYYF
	QCjb+W6yVVEMy5Ibua1xyGMbdUb2OODTdHNTCAPdhjEOOEvRtUf11exgs/rMzLu2
	0/Og7oJS7u32iJE4pmwzUXhC/exwcc6YKDJMnOKrlC0tEEuhQ+FBvqGjS4jFqFLz
	LhV6NkUb3sqHXbwLXwluaWbtjtjybkjTIs/MjahzUBsN6Qqc4W063HKh7GGdO0LP
	TizHFEQAP6SlJx5tdBpAW4O3msNW1j6XZOG/vr9UE8BuJ3pDY5brT7StzMs+g==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ckvh47cg7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 00:21:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+4WZQDiGw5/y05AcTCVLIg6qTOhn8Bt7CIBBG/O6v2kuHEqdp319crfPjp3PapXVGM7GJwbEWBgGkRUJ+voCTYR1McYOmn4NV/Tu4qU+twCVRroVnx42U+5QdjYjnxjhOV7bYMB5LwMNyTDg865NzltuuhJ+awcY05S6GvD732Ri7eOSnG0J0rWqYiStyJqXcWQUG6RwoFwje9JbacHO+W9ixDtpiwqShBPTDYO/2ae5qLqisSEri8v27ks8GDCavzx5T4ponPrGJHv0IEsjDmLy+ufVqAbdphD4NDs/lG7x+hicAOLDG/gNn0Mv7r/zoDzhxu6yxynY/G+ymxDMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVWChNddXAbirgcKtCKSIx79qG1ELIpqiu1uPUNqHko=;
 b=ShXC7kcVGG6hROgmQCGrOxNf5Lv9RdoANM1fQnvmZoNgwVYkb8UdX/7uVJvLYC3zmdJqv0EI9VvpOomqW0r0U70dGsT0sr1T2dqHoXgj4saierLEVfNwG4ttmdgo2f6Qmzj/vAQRvFIKZchYnZWlMEP6nZCvRTznFmVY/OIsP0UUuBiTAn9Aswx6IXR3P/hF3Sukc1Q6kFX4OYqxBbR3C1h84L6IWkxaFBQM0hY2NH3cvi7HVw7nJq5dKaNIXMVARfcXv9ol9XUErXoJeA7ySXjKIhv+lck56gkjIVnpubSKCZM89P7Ya/7C8ZlbV+A9GSg0FyYRg9ej4S9Cx9t5Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DS4PPFA424F92C2.namprd11.prod.outlook.com (2603:10b6:f:fc02::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 08:21:28 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9678.016; Fri, 6 Mar 2026
 08:21:28 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, alifm@linux.ibm.com, julianr@linux.ibm.com,
        dtatulea@nvidia.com, mani@kernel.org, lukas@wunner.de,
        kbusch@kernel.org, ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        intel-xe@lists.freedesktop.org,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: [PATCH v6 0/1] PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect sriov_add_vfs/sriov_del_vfs
Date: Fri,  6 Mar 2026 10:21:07 +0200
Message-ID: <20260306082108.17322-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0090.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::43) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DS4PPFA424F92C2:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a98869-4836-4872-14de-08de7b595d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	jjUAqu39y5lZMp9FT3Xe6lOTDyc36/pa5QzAjWCSq+5dfeGimO/25th7RQZS4pr1mDcNuRcvwtfbuAGg3iMFY6S97RP/nCpR8yLocJuSmx6/52JCj0vnffbmU6nukRLH/VWo3DJ8rVGZ1bNzQUvKULiAXDmWrxNQ5iBr/6Ag8ZpCHXsBelugnD/i9GUMUfE/jAwSsGvnNEWlz/lF1v4LYfJXV32yeAhq59/CcAfOioh2Gpa9xM41GdpMu5vCOBXbcQAx6mvdznsW82safziryVI/Z6BQka7Jor/dzV4EGwpaYcRf8tiQ/r9X/aWljcQv8Djf4y6fK3fVabpVwuS83hENrBoc0ktkj0Vg/JrjvF4eHUMzGoO8X4kSG8luY04xQwAbGu4VJ6r0edVIpOexyMB4YVAOwHVn9eOKgZaIPpVftlXGOhbO24acFHxnIXz+SsmLn+Bmb99X3kP/SjibT+MO1tah9i9k5X9JICQdgZmv62vzyFq3CxWMrkRqIcxzNigLxjIqG1xRD3nMLqyhmRtXqZpYqCAt0KjCfocppf5QsyeSyBIrTuDHdMWjMs1cv+j/m1YxguBOmbjMFNM92YOcQbbBsFr55dQKwM04IrGsjlVRWFXqIpwcxFgKsrxjfZtks5bmoQWKhmN8zZelmu2ZN9DrJG6LxUB77zl1A4RQF/3nHVVNfv8y3k/LmlMgRloGwyP4x9ML/T9dfpE+8Sdav6xmKXTA9dx8QuzY5y5D68+KBbyuxnqGg/efily1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1EAsJMhlVENgkT/n3Eh7Zo1/t5btjM2dYcR0haqV9kGPtNfd7CwffkuqqCiP?=
 =?us-ascii?Q?lT1YI51fwTgU2Uk/ap73mS/rD5PjgFVZrUsDCPid3gEEwdW/F/dheY3XzUHw?=
 =?us-ascii?Q?cdMy38bHq6npzI7xekq7uqIx2kaW++JG2pu703wgd4Ls2MAW2FMTP7BHilmn?=
 =?us-ascii?Q?LXq9gq//2tqB+2ZkUqcuILJT1yV9WGUkl2hlkOOen+64hz2O0YRsyhD3Jgma?=
 =?us-ascii?Q?CkjUMUc8a/klk6GjO8I0MnFdkHcuKqVv5zGFP27Fy6xfwT84agN0ZZ9fv3mR?=
 =?us-ascii?Q?tX43UXK352Sv88clyHr0yBwiaASc2zFl1WDLvAdqpEs/+88+kkdj/S7PGZoG?=
 =?us-ascii?Q?5Aqu4bKj+8e1LnZb/6bkmY5sT1O/vyDYBTJsGq2Sn/6KX9QfVgjZYDo1gbVD?=
 =?us-ascii?Q?JTp010amW2s+FUSYuSTRO60Ol1EIDdqzU2DyoH7TBf1eMP8r69olaAlYT/T0?=
 =?us-ascii?Q?HyMA3Qotrd2GcF+iHmEEV0VzCg09HiGmeBhbqHiHtmprL6BSV+xDeknBdbBF?=
 =?us-ascii?Q?ZWIrbgAtuOKQBUOLc+o7bZSnSaQMvv+FBJyr05sJihbB8k6WTQprnbSV5IEw?=
 =?us-ascii?Q?QFR2z85gCZney5kB9eLS43PC1vWUh1b/ZTFQ8YWcVYTWB9qC6zqG5qiyfbeR?=
 =?us-ascii?Q?6LQwUtpI2RcHg0wikB9v/YkC7Aoed4iPSM80+MxU2ssozuQOcWdZCkDpgInJ?=
 =?us-ascii?Q?tm7d2SA5fN9sqB5fAwr5shSlO1L04+jazqGrwXQYxdmgMZc8idJdICnZ5TP4?=
 =?us-ascii?Q?3UYEhcdoQ9Y0PNq8qrWOj3lkVL47ezoCuqrTZ7ti5dm73bHAROJEBx0UJ398?=
 =?us-ascii?Q?nqLZ9SVI4RzJGwB0Oi154yILj906UaneWnCSTbhNK/hFRLe1pGmy6BIdS5MY?=
 =?us-ascii?Q?NC1mWDh7go3eJo6Dxf3Clq5txZjXUimTgI8vIfhsg/KjzbB453ee3HlMP2Th?=
 =?us-ascii?Q?y4tQZDRmOE/GXpXRaAx4PmyufP/xmG8Wocrq/fEnaP9WfvLbV3CcTpwOP+iF?=
 =?us-ascii?Q?rtOpdU9Fy+pTAShtL3wbOoCwJBOVKs7tMH9xIttX2/NiggMKpQPgWRkTb7la?=
 =?us-ascii?Q?KcL9Q7jjA5RJug76Bfl/Sbnbh6x6ZNnM4caZWLf3sxt/OklCz49B6ady6PPT?=
 =?us-ascii?Q?c0Tkf0sofrTxxrmFJvRLSLvv0yDlF2XNTsYMBjuA9VG7HfxSupP/mi9bcl1t?=
 =?us-ascii?Q?l82m82/EyeJdvK8sp0rFayMyIR1XIOPlEPKMhAwGOEYcorfk5AR5uEAQNtnb?=
 =?us-ascii?Q?Uhqnb1kSI7Ddixw8TiTuMoTHrMymAn3iH6mQTPckhcxVghC26h8k91dZ5CCK?=
 =?us-ascii?Q?JkZt3UH1+jaooXTf9E9FEnV9mC83Y8nOAapdfhpCM/z9vprKhoNJyrD3Vf8I?=
 =?us-ascii?Q?r7tYdpCrxtBPVJHbsYxz3ut5ipSCetsKXjrO2F2cdITPY9TFbDdNyP72fN5k?=
 =?us-ascii?Q?8czwaOaFXX1G1yS2VLa7mYnlK22IA1P/rQMD5dNjJsdH+qyMFYoh/v+qunWn?=
 =?us-ascii?Q?7GmjLTXjIvDPSAe7/pcIA32SdIn6T613fUDBJ20Ut2ws/Masq2SQF01KsPir?=
 =?us-ascii?Q?CDcw6r3UaguXvmoNukQiYKWOMtscnJ58gsCtWM+6JBkLJoqTwnp2pJFnsPFS?=
 =?us-ascii?Q?aI5atvet5aNmf6EoflcIXeaS4a1psZQQqsPSyu2153tqAuxJdCVRnHxA1NRQ?=
 =?us-ascii?Q?HiwxPdIate3ALFedbG1xQUuqd89tLxKUnZKvwGjsulRvCsPHL0rotV3AxL2e?=
 =?us-ascii?Q?SBZ6cetd4NoyhSX5KHDJw1fiayQbZgVYi9Etzv0tJH3IUKiw+jsVDDnW8hW8?=
X-MS-Exchange-AntiSpam-MessageData-1: OcWTlXfe8tGiU6xrtn8DX2okZu52JOQzjis=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a98869-4836-4872-14de-08de7b595d0f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 08:21:27.9840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nf65D3Cc+SmcuJDiF/hRYDvEeQczv3/ps5lG1Izq8Vj5GAUW35cmyIs8Z4499V+8b7dvI2b+WfmAJ6d2KOi/VyFtxFvLfYPjFgreMvoPGwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA424F92C2
X-Proofpoint-ORIG-GUID: IDWbn8z-ZUWuxIEReFQE_7pBpe_hpZYJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA3OCBTYWx0ZWRfXyoJFBSA6qbrr
 yePQgqetZTON1xpWuRxk8K6QA9sKUkqT/KV/Dmmf8j+ohOJgKwJqCo3vEref1yOFVvFsTMiBNCL
 7jFHp6PZVBfrr34NELjI2jIZgOPE8jgBOHRAsLqKVcXDr4MXMsci4AhwgVDuPPpoKsr2SAg0BLw
 SgprvCiwoIl3dTgCXW3ttKYU5ltThG0nAl7zE8l/2nbULm9Njoa418tB1Xy0H2sUTrBNSdSQiDq
 8H4VrT3NtbtEaiCKUMBH97O0FZ3+uqEI9K/lBuX2GqQIVBaPyMMPFZqCHqefhF6OrD0MbN73Bqc
 W40BzOHB1IFuZDYegz9nk4UdMB9b28zCa/imo02rHTfOUPQw8+XkXcVUHe3n2S6iNDqc/wnYhMH
 mIj5+Ba7iVa4MkjlacSr07P9VOMPH/mBa98gcYwDi75ZkxxmU8FJF3G1uKBfiFcANd65bn+TuiP
 idgSocFSBQtABPPR+9w==
X-Proofpoint-GUID: IDWbn8z-ZUWuxIEReFQE_7pBpe_hpZYJ
X-Authority-Analysis: v=2.4 cv=Z/3h3XRA c=1 sm=1 tr=0 ts=69aa8e8b cx=c_pps
 a=TuoCv7SfN2yFw/uhdbj5/Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=aLwvNF5H5t6Pi__SSGYA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060078
X-Rspamd-Queue-Id: 899D921D012
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,nvidia.com,wunner.de,yahoo.com,gmail.com,vger.kernel.org,lists.freedesktop.org,windriver.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223317-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Hi Bjorn,

This is v6 of the fix for the SR-IOV race between driver .remove()
and concurrent hotplug events (particularly on s390).

Changes since v5 (Mar 3):
- Reworked based on Lukas Wunner's suggestion: instead of introducing
  separate pci_lock_rescan_remove_reentrant() /
  pci_unlock_rescan_remove_reentrant() helpers, make the existing
  pci_lock_rescan_remove() / pci_unlock_rescan_remove() themselves
  reentrant using owner tracking and a depth counter
- No new API: callers simply use pci_lock/unlock_rescan_remove()
  without needing to track any return value
- No changes to include/linux/pci.h
- Rebased on linux-next (20260305)

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

The fix makes pci_lock_rescan_remove() reentrant using owner tracking
and a depth counter: if the current task already holds the lock, the
counter is incremented; pci_unlock_rescan_remove() decrements the
counter and only releases the mutex when it reaches zero. This keeps
the existing API unchanged while providing correct serialization.

Link: https://lore.kernel.org/linux-pci/20260214193235.262219-3-ionut.nechita@windriver.com/ [v1]
Link: https://lore.kernel.org/linux-pci/20260219212648.82606-1-ionut.nechita@windriver.com/ [v2]
Link: https://lore.kernel.org/linux-pci/20260225202434.18737-1-ionut.nechita@windriver.com/ [v3]
Link: https://lore.kernel.org/linux-pci/20260228120138.51197-2-ionut.nechita@windriver.com/ [v4]
Link: https://lore.kernel.org/linux-pci/20260303080903.28693-1-ionut.nechita@windriver.com/ [v5]

Ionut Nechita (Wind River) (1):
  PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect
    sriov_add_vfs/sriov_del_vfs

 drivers/pci/iov.c   |  5 +++++
 drivers/pci/probe.c | 13 ++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)


base-commit: 3f9cd19e764b782706dbaacc69e502099cb014ba
--
2.53.0


