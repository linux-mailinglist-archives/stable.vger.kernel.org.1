Return-Path: <stable+bounces-222818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHrFL+yXpmltRgAAu9opvQ
	(envelope-from <stable+bounces-222818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:12:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEFD1EA9DE
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF20F30338BC
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 08:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDDB387572;
	Tue,  3 Mar 2026 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="XUmmlwn1"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFA2386C14;
	Tue,  3 Mar 2026 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772525370; cv=fail; b=GcYh1fxcxDtJslEe9PBZC0HIb2ExoVLo6sxIoh9alAzd54QRx1JNh7ZjDMHWVStJIiH31P00OTiO9HJYCu/61yv/KSNWL/jMsMe3F4g7LopVqnzaw0unubMU9LgakgADB+0j6nFm0Hhb0UpPN9C5Ul9dSdqbl8Gfv/k8eDrnbmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772525370; c=relaxed/simple;
	bh=NS2ZdBb9bzJm0blmjwyFeSA6Mneb+qdc5STB2G6jCU0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=n0MXx47Y3dYupBxrnr+gcZBBklq2zGDnm4JO1mwp+KpOOrX6vaV0EtP5Hj4ujQF1cAYgLQQusUMZJxPALFn/XUCVpU5VmDIl+SuN18zrcmuYhw7fB9FXt302xkrIeFO2aiNP5l1v+JKG1ABNtCMmzMvrwJglltnKYFuqJl/12yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=XUmmlwn1; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6236Pv0Y4019490;
	Tue, 3 Mar 2026 00:09:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=4NpFvvXTc
	4r3Zo+SKL+bQL5ZSE+8C//m9OzCGSkX1os=; b=XUmmlwn1sOXUCyhS5giwq/NCz
	KyYk02trhy1ZtbEq5/1+kijcpGaUG1bAQLwFfzN/GBVQG7x28d7pq1AMJ7TZLji+
	D/+tpdrx/n9IsjKHnGkFpV+49gqiushLn9KpS+gQvfWndkj9DSZzKH/cjETve5xv
	lbcBqe6xYnf2CgL+kTtyWkDtW3vGf44vxBY9xUPFAa4wlLXOsc3MoHNtVzt8qLje
	/mpH7Fq/oqg3/R9UCxFls5fyxqoxpH+aDmvePWITVOkDe6iJYeH88+sZ2iDL6ybx
	PvPEK+1p6wyT1F6Gci/p6mFQHUN96X9DDtduWD036B1OidOi8BD/X4grattCQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010052.outbound.protection.outlook.com [52.101.193.52])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ckvh432wn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 00:09:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwvyDd1Wo4hbZpej7IE+R+ugOZ9u/Igolls+JWsWuJbE2uPEl3H7kKyqy9uxEN67NOC3z9fc79e+qGsCLsTgL0gbZZXybm+Q8305gV/b9I854MBneji8dSdEEZLM3axmOSy52jYpho4nmx99fP8RcZaclFBH4YHNj7f9bePDDN3dwAxapfGgDqCr0LrtvgVGePHvIepBjVE1W6QOO287p0lQLprGt67X9P8hDA7iR2eseZCY/6nH3Iqqmu4COASph0So8WYdRH05zIG7vD9qXYw+X2Cw7MDDVfFh9NgLjOpwUQgoME6quwTuGf0N3pBBeOBdzPJeURmjDY8KG2T2pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NpFvvXTc4r3Zo+SKL+bQL5ZSE+8C//m9OzCGSkX1os=;
 b=pAFaHKcYM9M/9Q5Z/nXk3lF0FS6BfOcrlck/uwU5DfDaAqhmNoPigCrJUD/iv8M6RaGulK3GlKjJ3qh+F52tnSQrLdEHI3w1Dx09tqykGh9oUe6tppBs5D4PM2TVzBVCVpmgHuMBsxHfqHt4hfeKE4pi3BTlMf7Fte/Mr6hP8tMpuKkxkLZ9IdNnIt1ZOnrECEp02O74LBXux25rS9bVmR101298wv6DFkRXX8S8dX1Pp9+6p4M9lf8e5kYibGo3SyZ33vV/ubhu9cPXjww+2EPHYe/KpGro5qkDlVMNxvks2PvfQR+Sx5lP66Vv03uAIJSUwjIbiV/0wEpaLYgSVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by DM4PR11MB7325.namprd11.prod.outlook.com (2603:10b6:8:107::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 08:09:13 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 08:09:13 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, alifm@linux.ibm.com, julianr@linux.ibm.com,
        dtatulea@nvidia.com, mani@kernel.org, ionut_n2001@yahoo.com,
        sunlightlinux@gmail.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: [PATCH v5 0/1] PCI/IOV: Add reentrant locking in sriov_add_vfs/sriov_del_vfs
Date: Tue,  3 Mar 2026 10:09:01 +0200
Message-ID: <20260303080903.28693-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE0P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::17) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|DM4PR11MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 7878f9d2-2284-40a6-4c4f-08de78fc2812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|52116014;
X-Microsoft-Antispam-Message-Info:
	B1nFXDhaoUhMV+dt8MDLJtPLNr8nIDy7cWKhROwhIY+uPMg16vrFf06lfhR30XCIspk8tvrdkUsy51zjp5EBfzSsk7iI2/mR88xLrW9V3oVs+0qYU2jxe7hbi+N1rLFW8wlsvzZMaPrBLtCAC3NJEN9RUDK+XLDm4tNNJCBoL3HYZti0StH2M90817Fw/edN0c+/Ren8ddhNz2d7ePDvDs4PK7S4nDxHZW59lq7/m2HgR6JBuABWYqm0Jz702vVy+4WnXZAKkVdlftuQgqPu4bo3XZ2LC/HApVyebY6tw19U1Ks4K36ni3sSU6Ojp5FCCOKcRvnWDmt8zgoEnK2+itnAiqMLd17LryTuXAv/U8ptXMkngyCwp2sVcKafPTpvDOpHr3XROQ56Anx8bXViXx55a/vWQ9w84ViEtaMhvRNCcPS7PX3slefNFW8atJJG8T1LUI9Sr5eMIoFgrNIiDOX7LHNTdRlLAdYxc9z2TUWonJy28W1hOrMbLmi0TfUESwM9Oa+JtLdnztNI7poUW+TbHEFwpPvulbuDr/kbK6q00MbvFt1thDlC9+1K4ifxIUoouNFGbDIoDEwYtk5zAtNvvHlYkbSp+5H6CMKDA/akJWhQLqqSOarru5U9d/SG3MZR5aTcLKvHHUWBDiXD17zMamlDiS39e0AM4dQfFqohqZPgqEwZWMAuzhDZ3S6jbd39LuABP+a4Bnmef/yBHVbNS0F2Uo8rKwqFs0/bcx8sq5WPJRHdxAVqswJH4FRd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VgSwwGBDzOaI4EKY7OLe/T0bxUGGYniKVyvexAjGwg4d9vNsk0rHGYcBN7M0?=
 =?us-ascii?Q?jeFxHkW5/6KTHv4e6NkI2DyWRM2VKaePwLGfDyg1fgbwM+YqQu41PtQ8dYuM?=
 =?us-ascii?Q?fw6KK/Trq6P0bszJTunLuxW50Zl/FOobzxZnEeWBsxIft1tJqRcE3/+Iabgp?=
 =?us-ascii?Q?jJVAGcvQhf0XoXmXaFq97JSXsp16xdB5ht13+xmUPqv1XBWJ1D0Er6ELpz3i?=
 =?us-ascii?Q?KR2xCQ4lyE3Gho32KpEvOn0pja/Yz9Qmy6LWOBPeQgYX4qZAoooMtpaPNZWN?=
 =?us-ascii?Q?6hxP0u8OF9K1K58hsZ//Oe82Vsvq0dRBz41Neo3yV3Khx2m/yC1OkAKIVnDg?=
 =?us-ascii?Q?CuWdQ8GrJ9QkCz6MvS+R9QH/kpq+pGvGVc4r7GkAfjaYFxIyLVMa6HSibPSe?=
 =?us-ascii?Q?uFpndVCvvhZJrs7q/Zp5ovKcJc9mDJiKNx3qXlkFEXRSalrplj9Gq6/BSyxW?=
 =?us-ascii?Q?PESkyfnRFIghzWm+DIDNWrLQN91ooi/8mvN8WOecNxV6BLtGwOb9DQ0L6CMf?=
 =?us-ascii?Q?B/2uNvLtcO3aa0rdYkwTLPfOQ18TfqSTHW/vUJcVvjSUyFzmsTGo8bALQoZf?=
 =?us-ascii?Q?RArlhoZsqKV6WKkgq/xnGenVUQqy9myjDQja21ZZuW/YCq6Jh8ookeOdg/84?=
 =?us-ascii?Q?fsUgwCUN74krf5lThv5tWOdTiA4GGuoTNRd9i/Gql/Xc2jCif0NtH+k8Njna?=
 =?us-ascii?Q?PXRs9iP0WG/5sAXcFFy2LZdZ9clPMf5DSd8KoXXSRV2VP924OaknAyuhNVMO?=
 =?us-ascii?Q?3hXh7Xk0yfilSXbDH4R4JjHtDV36MLg647Mlp2N8RtWdla9JKmRJWZaXS45P?=
 =?us-ascii?Q?AKEYohouqXjYxsroUUm4WP5iMaulz2IRElOvmRurVmtc/LHc9yBA0l40SQCj?=
 =?us-ascii?Q?eJYdqepBu2rkx1rxyGny+msY9/6vY7ptdRvJWiV+tWXRPN4ub4AruhD0Bt6Q?=
 =?us-ascii?Q?uppQRQJ5o9dtqlUftv+guwCbltohwGCVMJvF1SqgVRaYpTfazbAxH9l6uX1r?=
 =?us-ascii?Q?yZ7soWuUrwqEH/lNvgXN1Y5DoF3Y7i55GKfsNCycD/sRtvvO5k1lFqiX8OIn?=
 =?us-ascii?Q?nMXSJ8BamSzFpe30oYxyjCySoJRwsanLgA+meXl4uxevSQRxllVuOH+dPM6B?=
 =?us-ascii?Q?uxKBTLVjin2X0USUhekvo814E24+NdpMJhDxRauq2Yl6OPhWBNcY/dXGcRop?=
 =?us-ascii?Q?eKWlODmfTjiMNwfRvQn0ZU96gjOMHYW+Br85xmJOjs80fqTxG86QsiDJcxWN?=
 =?us-ascii?Q?FFgWCMzNEv9zVKph45xBQ6frjYZutbDsRnw1oYuA18NBN8JAl8hA35Oufton?=
 =?us-ascii?Q?vUsTsPnWWFMejqpvR8YjgRKydtkcXLXI6fBVeCoABrvCcVNt8ahLRgmZCGz9?=
 =?us-ascii?Q?BkEtXi63z297Ccth81vr2N3h7kTO2qDUSXn3M3HlY0gH0s05Fbqm3cBoDZyb?=
 =?us-ascii?Q?zVUCs+sNhhDtPgJV2FPg/IAddSn1Z1r6uCmsOonTaP9w61W1CqWlPkCf+g8V?=
 =?us-ascii?Q?O52utR9C+JZwFwNx2DVabfpN8xq3IssSVXOZYRSM2ztYmg04KehJirUKvyKX?=
 =?us-ascii?Q?jTtLDoxB68UDeiQjMCBo4H5obMcWAezVPss8veXYYc4hoq79vK3oH+TWRfye?=
 =?us-ascii?Q?PUwffeFKKxNqsGDd6JVUvRbl17sC/zFKMpoGRjYohSH4QxOYPtygHiXgZlP3?=
 =?us-ascii?Q?67yDZlYLnJRc0JGDl+TfPO4C5zKwumFxnFCSsBOK3VgXxvlExV60HkWCoAYI?=
 =?us-ascii?Q?62nNldK3vUERhfaYaRjGhI7feOQM66j7Aj/n9whV4U7CurfuhK3WBh7ZX5ML?=
X-MS-Exchange-AntiSpam-MessageData-1: kHcgxB+EE3QcIUsMBkKK6pNIZRgY+JA4+7E=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7878f9d2-2284-40a6-4c4f-08de78fc2812
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 08:09:13.3880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNffN3pdezB7g9RWyAHASFs/A5dxkcTtWdGfHFBMDqfAwTD1XgDq9wtiamHRPwTeyRuMsqbeIeYw09Iqu0DrrbsxqjTLG+Pxj8f8e4+xYJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7325
X-Proofpoint-ORIG-GUID: frJzGUizxScz-cjRMaqAaB5aj-vj_736
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA1OCBTYWx0ZWRfX3//Gi36JvfMR
 TlsHE7qT4H0PHqnvmdFCTDF2XYc1mP+aVU8kxB6H6CJWaQiUTmPQ7ahA1dT8ZAjXpSB4wBnIClx
 wnULkZLoi2pI1nZ6/Vz2wTzS0tosJ0x18f2ekX+wejv6bex/um6Qavhuq/MRYd+Q3MJLjIrUUfW
 +3PUtu7kcP/5b0IVzKukgCEuHjVQEgjpjgQImr3MZjRcO3T6fZ5XgfDPe1P8fYva9dntQtFoY0e
 DRzVnRlNvBVt4ckMb48x/SjkADM0tPhWoUqrJOBuaVoFD4wKYJrN5dKr0DjPb6k//vZsIaJmDlP
 Xm/XR4hQrdYSU5zIz5ePY8NwZeRAI5K9hPHvIGBLLisT5JAGIXbeBtCrnpSWfiIeQqBQLBhlmW6
 s8P49AkiOUXzzGuKx3nz6borDQBkqqKJguq16IW8PJz/5SftnAD74+AX422BaHpdF/HtFqqH/J7
 ttq05dUVLqqA9Nkb0Fg==
X-Proofpoint-GUID: frJzGUizxScz-cjRMaqAaB5aj-vj_736
X-Authority-Analysis: v=2.4 cv=Z/3h3XRA c=1 sm=1 tr=0 ts=69a6972c cx=c_pps
 a=N8fQrVaeAljVkTo8kKJ49A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=AOdrN6hKkUKB2FtgEPQA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030058
X-Rspamd-Queue-Id: 8EEFD1EA9DE
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
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,nvidia.com,yahoo.com,gmail.com,vger.kernel.org,windriver.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222818-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,windriver.com:dkim,windriver.com:mid];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Hi Bjorn,

This is v5 of the fix for the SR-IOV race between driver .remove()
and concurrent hotplug events (particularly on s390).

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

The fix introduces pci_lock_rescan_remove_reentrant() which uses
mutex_get_owner() to check if the current task already holds the
lock, avoiding both deadlock and the trylock problem.

Link: https://lore.kernel.org/linux-pci/20260214193235.262219-3-ionut.nechita@windriver.com/ [v1]
Link: https://lore.kernel.org/linux-pci/20260219212648.82606-1-ionut.nechita@windriver.com/ [v2]
Link: https://lore.kernel.org/linux-pci/20260225202434.18737-1-ionut.nechita@windriver.com/ [v3]
Link: https://lore.kernel.org/linux-pci/20260228120138.51197-2-ionut.nechita@windriver.com/ [v4]

Ionut Nechita (1):
  PCI/IOV: Add reentrant locking in sriov_add_vfs/sriov_del_vfs for
    complete serialization

 drivers/pci/iov.c   |  7 +++++++
 drivers/pci/probe.c | 16 ++++++++++++++++
 include/linux/pci.h |  2 ++
 3 files changed, 25 insertions(+)

--
2.53.0


