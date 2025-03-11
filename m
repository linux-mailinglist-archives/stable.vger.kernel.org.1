Return-Path: <stable+bounces-123146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A25A5B898
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 06:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075A216AA7A
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 05:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6D11EDA12;
	Tue, 11 Mar 2025 05:43:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20BD1DF725
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 05:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741671801; cv=fail; b=T4+oz2CpCbeIZO2jfckt/8sPydnNZC7ihhbL++UlesrbkG+NWGhaYLovnZIbXynPbzsWSEcKYj3C1fliTO/iHegszhSafunaWew7HHamY8VsCxnCmls2+dJL9HYY7sfSwoyZbbg7F1x+v7+q6T5cBviaCT+7EGy0TAfN7TIMjik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741671801; c=relaxed/simple;
	bh=UB+w/j/0SMJbN/GZy5qI0nKzObmY1874LbkKT6lfb1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JltxUN0frWbIxJCdnH92YKCO/aZcejGQuVeJIcAzIzx/5gKRDI4HiuyKYwf49K7ADHUv4LBBVmhq95c8HR+PNMmE/hA7Ixkzf15bkVMnX4HnA8UTD59OZKyme+rUYD9AIDsC7BVTiMYPzKG19wswZ4bI9Dgxo3p2nqIXzi70/Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B5FAYb014792;
	Mon, 10 Mar 2025 22:43:03 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 458j27asdv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 22:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0Q5MyjJgXKoMoQMx2/JpHxE/PkVRvGlzhhs/54nGeTVf8KP2Md3eiZU5wB1JuNVWwrP4SgwIvuTgz1Z0Evr2O//c84cQhlgqO3Yr/Ge9rb5+FaCJEV7xgjFkzcAGPVWopvYEQ+y1/YKGQcNsYxF/XFsxoYuilZeiZ688p9Omu3hD6oJP4gDFeoFxX3ttrF/TeuEASxI3P91tmvQ6hog2K5NobKRBDX8Fba9cANQSJp0NYMVDP5Q/aOqW1dGJseZZe4XlxmteD777n/TjRyPySWvVWvb4d/M/2Z6KoTw39mTGPls+Kdd7PPjjc0ySglg2c171dO1rBBih5jLnNAUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nz4nGG1k0Xm70J/v1t8Hal3zitR9CiB7MNnmbMGSnkk=;
 b=Y2X8zL0e7hHj8bc1zn57vhDLLpm6Ta5hk16zVE8CYW7YKxxb1PmP/qNkN3iRiFDbaQ8LKirZuSzmszmoXf+eWN6022Qfl6686o5WJalVK/gSEAEwB+p3jfch/izhhT3i1o1n1COvC07QHnHRwkMbRP2VnPnvG8xfGFJM7/gheSyl1rcBK4EbWX3pMPnwLaRB60fDPNVmLUNvCiCJ4Dm0c2N4E45qO8PSyn8NxzBKd4nhASJ03VpYq6DQuJL5/7e7PNzJbLw9v188qqor0s4bT9a+tl05VxhM2XdtzQWAxGPQNga65PY53jnUcDSihm36TwkD9vJSpNCqCGCwnwaQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by CY8PR11MB7395.namprd11.prod.outlook.com (2603:10b6:930:86::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 05:43:01 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%4]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 05:43:01 +0000
From: Bo Sun <Bo.Sun.CN@windriver.com>
To: Bo <bo@joymail.io>
Cc: Bo Sun <Bo.Sun.CN@windriver.com>, stable@vger.kernel.org
Subject: [PATCH v2 1/2] PCI: Forcefully set the PCI_REASSIGN_ALL_BUS flag for Marvell CN96XX/CN10XXX boards
Date: Tue, 11 Mar 2025 13:42:39 +0800
Message-ID: <20250311054240.3246843-2-Bo.Sun.CN@windriver.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311054240.3246843-1-Bo.Sun.CN@windriver.com>
References: <20250311054240.3246843-1-Bo.Sun.CN@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To SJ0PR11MB5866.namprd11.prod.outlook.com
 (2603:10b6:a03:429::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5866:EE_|CY8PR11MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3ad462-d6b8-45f4-66eb-08dd605f95bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pHiYaV1k6Utl5KMa1kb8UuiMmFy/PljQ3XDHTrfZ8YKs/2mMLe1nYnPFjW6a?=
 =?us-ascii?Q?tUjd25sq+EhzTtO2iW0IOx60OMuB34ysZ2VtdKUSx54dA+cYJMAUY9ON0Srf?=
 =?us-ascii?Q?TEUYUJwnjq3WphkZ8duvd6QecB8A7z3Aa29k84iEb25SoJNM/C2273SwMUp3?=
 =?us-ascii?Q?jhALVVK5D2LZv13kfD2nVz3ivoFCMHjqIcfgchjijAlvfWvsIQipccv/x5B9?=
 =?us-ascii?Q?ymXHwrOp4oRT0UQNHD/prxBKjUX7+L2piPBV+IAFJIBdNGN1aABF4QUIfetG?=
 =?us-ascii?Q?c8xKzfdg9g1DkcyhFWrFf94G4VJspB/MgvQrXYJ/eTO2vbNElq72KgA3yz8v?=
 =?us-ascii?Q?p3aPJIj07iUgKfdcHx9n3S19rxIwSpb81XcdWCFD4Fo3YmObLI0EAqmkPzgo?=
 =?us-ascii?Q?ML0NPnXu9JDzDOBJPD6VrHOBUaPbcIy07NkHTqp7unZdhoIONGyDPQcVZWth?=
 =?us-ascii?Q?EvGfX0nTKudj6Rr86HzxA4lUHtOeDDvCUzkyb89KCG9Xgp5ke/veJ/WoY4XH?=
 =?us-ascii?Q?rORAl3ZzVXgJYA6uz5wWxHLkjPHuTI3bmvHwmnx9F/tuTzmfJIVLCK+5zj5Q?=
 =?us-ascii?Q?gEkn8fqfQBfwBCwHKH9XtlP1H4jW/vYAtG2987haV7x2F6Ia+Mj4yrSVJTuh?=
 =?us-ascii?Q?IfFytSoNsMAa0y4ZfwWRWjT10/+RnBn3Qbcx4mWk+18pnUjNQZ7fmM9eXWut?=
 =?us-ascii?Q?X7WITLab+XZ1mEIMic8VKGHqloVKJ4cKJ1DsebxHl0xDR8y94KLfLLw1YROk?=
 =?us-ascii?Q?H3X/pdpKxTCc0FdufEReKA+aMw1wAAddOclJORkxaNDc8k0mINkllSQd++kf?=
 =?us-ascii?Q?hTOuF7iLpXTSKRY6dAeyksBUlKaIi7twHTgvvYOMQjS61Rh2266nDn7XOc1S?=
 =?us-ascii?Q?Yjqock9H7qt5Xif1X/k0611I9GKa01DzN1TmIv+yfM6jBJwI3Zn40n9Dq6bF?=
 =?us-ascii?Q?vcglIbkS77MoyejcpxgAN8YUI8QG9N1BI7xwfQMzQ9SmcGFD2d9rJcZ+/DkI?=
 =?us-ascii?Q?sPDYSlCdMlBFAA0ltMw6Y6LvW8ilc+llctfc1EfRyCs+xjUOtLMC4zu7e53w?=
 =?us-ascii?Q?0DeWOzxZB6bYISDckCqMGIy1Z3BOeoc4NNdYjByUVb80TtilRpK2x6Exko+I?=
 =?us-ascii?Q?gIfO1qz/yZQ34oOjeo6oe0gJ7Z8FR0ufOz0FiIu82m2EYhnxKKlqXliJEu0K?=
 =?us-ascii?Q?jRyl4IEwhGVKHoargRE1Dff+6FUzu/0k2bWx76jQdeAjAeMbU8HqDlhsmkmH?=
 =?us-ascii?Q?nOIp7PzykB6ROv3NL7NaXXOMWsvQarSzz0fPxOZ14rXvFezf797QktZTyIwB?=
 =?us-ascii?Q?wrEzDUUqI8pEtNDLycp5I8CBZZc3zORLo3YhZMLX72cd/yKBQeR7hPjisotP?=
 =?us-ascii?Q?a2MeIsgCH73Q2gI0Vsi7QQ8BaEv6TeYYdqErLMfeOZ8MQo7JzYFp31yko9DQ?=
 =?us-ascii?Q?zJMx9jtKFT2nSEW3HRZaJKOvDQCPz1xo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4YOf5SBEyd2dv2fPIFl7sQf50O1lfNfparkv1nwQcvK07P0xUmc4K0R+06um?=
 =?us-ascii?Q?fml0n8FV4boDbhFWKXyvCTsYF7aaxlfiIhfRjXgGI0FmchLWg0tKME/g6CPk?=
 =?us-ascii?Q?ha3sxeDrTq2/qkJjC1FfOLgeHce/IiOyilQ1l8fWr78HRd7UHubjBvnSSgeR?=
 =?us-ascii?Q?HddguEQn2+Fujmal8WvdpPewBdvER5LQp9IB3K51TMN8a/AYNyOqPHKRxXRJ?=
 =?us-ascii?Q?vSeG2Xcvuz+cOy01oguMegq3v7sr9n4gnVRa0oxTf1W6MbiOwH9IKf6l+yN8?=
 =?us-ascii?Q?CO6G0jqj/jc/bAbWBOXKwgazm2KZeAnffl3g+scaKb0OFWZRF9Tqj6hychxk?=
 =?us-ascii?Q?NhWgY04JdeP1uuNqFF2RvsPc6Gje5Ll22A57Zy3huX3dax4jv2F7TE1aLoZx?=
 =?us-ascii?Q?2RYhmt6X0GOOTycKOhewxSG4hh0NUYL71YTUKAdsupo32mqStEO3w/MZZSkB?=
 =?us-ascii?Q?NuCC2DfNiSvdyQe7KGrGssgoINpQ93BBxKIibSueEWrykgLAnIM4a5KHWXhM?=
 =?us-ascii?Q?2niHozjem+1OJFgJi5JB64heie9VQkYS+0AAeCgEroDYIXzgHxHW4posc3A9?=
 =?us-ascii?Q?eM7RLls/LCaGASIffTWCtwiI8Op2CQVc9KrbCLg7CMQGtfswLn64kCBvBQPe?=
 =?us-ascii?Q?DEuCzMBpnsnUiuNU4vgvOQy5d4clzshLs8CngZ0MtdlA1lXE0C5/h4a58q5L?=
 =?us-ascii?Q?WbtNNod4BJAJGDMd6BgGCvIn05gAnqnWd/rbpCzGQFLjj6veOXAiQKfP9w88?=
 =?us-ascii?Q?qvqZnmErqBuXY0jpfcQ//ghSQRx9aMLxzZnIv8Z9rKxxRVR+CLiYIALigoAP?=
 =?us-ascii?Q?SHXhXzbD6f1L3/f0LmWITDDfzg55Gn+6DCR7hHg651ie0ZTOd5vx+btl+TqN?=
 =?us-ascii?Q?GtyTAp0Kjs+vNyLQpQPKO58ZIj6kk5YoG9K/BYJpC+nXr6r7h/7AcpHNIKxb?=
 =?us-ascii?Q?Mr95DRfpW8BLnT4NdCC5xX+gDZOqB4+bcg8brPGbTMeZVeao5VPZJWDOyXru?=
 =?us-ascii?Q?B4n3+flLLcdn3DXWhcDq99c3bveIYUQUfQTyqKmraXzkVZnmmkazkaQZZTCU?=
 =?us-ascii?Q?VaSD5PYF/6gOthIeeBJcbi5STHFVagU0oRfN41LxDOxcZS49Foh34NqHya67?=
 =?us-ascii?Q?87MeXLaQcjW81zULp9fu5X3Kx/22qPY06bS5fHJXpcMYckFVgVSfl8svWzNf?=
 =?us-ascii?Q?bPIHL5LJKzPNFfqrdf4t4r8s8EGrxt6huBtgrobxx8tOvSy5yvocXXkQYWx2?=
 =?us-ascii?Q?RmLymrzFBHpSqffQDdCAzpean+amPI+XTdahbm7fFngSlVZoalLfbubIEQhJ?=
 =?us-ascii?Q?0r4QzPVS2KKjXU+8iyEi+Ag9PhHWeaYNJQEJa1lTrL9X2txBf6EvmtQaVq5J?=
 =?us-ascii?Q?fWIUKkG9M3bWDtaRmu84C26Hkmus1+1CyG14GUpgmp4+ktwcTPS2XqXDXu4l?=
 =?us-ascii?Q?+1Rrtu1iLzeaop6gaI+aK6W03w3UYGWsNajf5wKjdg2Tdja46GASX9JQV6Rj?=
 =?us-ascii?Q?5nSdL1QGm1uCmDCmgYL3PovXbrqKPvsZwhMZYxvsEgodLd53ULEWmSnqfnsC?=
 =?us-ascii?Q?/GscBQ0VYxTfsP6ig8pSNxE5cJ5Tjhq5Ow6mdGJdG7Dg+SpMoE+lzwYw+spJ?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3ad462-d6b8-45f4-66eb-08dd605f95bd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 05:43:00.8980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onAwhQWdaPLH1Q49aYPI2vndIRGj9pfVWZEArAAVeDsO0HZaPEY/MRc3nTt5TmQVM9TR/Cpe8XxBOdJUTFhPWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7395
X-Proofpoint-ORIG-GUID: UB0OajU9zaWvODNNlrDiAl4jLSMcdmBf
X-Authority-Analysis: v=2.4 cv=WNuFXmsR c=1 sm=1 tr=0 ts=67cfcd66 cx=c_pps a=ZuQraZtzrhlqXEa35WAx3g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=d4GDFFIL-j1JmWKAxmIA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: UB0OajU9zaWvODNNlrDiAl4jLSMcdmBf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2502100000 definitions=main-2503110037

---8<---
Changes in v2:
 - Added explicit comment about the quirk, as requested by Mani.
 - Made commit message more clear, as requested by Bjorn.
---8<---

On our Marvell OCTEON CN96XX board, we observed the following panic on
the latest kernel:
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
CPU: 22 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc6 #20
Hardware name: Marvell OcteonTX CN96XX board (DT)
pc : of_pci_add_properties+0x278/0x4c8
Call trace:
 of_pci_add_properties+0x278/0x4c8 (P)
 of_pci_make_dev_node+0xe0/0x158
 pci_bus_add_device+0x158/0x228
 pci_bus_add_devices+0x40/0x98
 pci_host_probe+0x94/0x118
 pci_host_common_probe+0x130/0x1b0
 platform_probe+0x70/0xf0

The dmesg logs indicated that the PCI bridge was scanning with an invalid bus range:
 pci-host-generic 878020000000.pci: PCI host bridge to bus 0002:00
 pci_bus 0002:00: root bus resource [bus 00-ff]
 pci 0002:00:00.0: scanning [bus f9-f9] behind bridge, pass 0
 pci 0002:00:01.0: scanning [bus fa-fa] behind bridge, pass 0
 pci 0002:00:02.0: scanning [bus fb-fb] behind bridge, pass 0
 pci 0002:00:03.0: scanning [bus fc-fc] behind bridge, pass 0
 pci 0002:00:04.0: scanning [bus fd-fd] behind bridge, pass 0
 pci 0002:00:05.0: scanning [bus fe-fe] behind bridge, pass 0
 pci 0002:00:06.0: scanning [bus ff-ff] behind bridge, pass 0
 pci 0002:00:07.0: scanning [bus 00-00] behind bridge, pass 0
 pci 0002:00:07.0: bridge configuration invalid ([bus 00-00]), reconfiguring
 pci 0002:00:08.0: scanning [bus 01-01] behind bridge, pass 0
 pci 0002:00:09.0: scanning [bus 02-02] behind bridge, pass 0
 pci 0002:00:0a.0: scanning [bus 03-03] behind bridge, pass 0
 pci 0002:00:0b.0: scanning [bus 04-04] behind bridge, pass 0
 pci 0002:00:0c.0: scanning [bus 05-05] behind bridge, pass 0
 pci 0002:00:0d.0: scanning [bus 06-06] behind bridge, pass 0
 pci 0002:00:0e.0: scanning [bus 07-07] behind bridge, pass 0
 pci 0002:00:0f.0: scanning [bus 08-08] behind bridge, pass 0

This regression was introduced by commit 7246a4520b4b ("PCI: Use
preserve_config in place of pci_flags"). On our board, the 0002:00:07.0
bridge is misconfigured by the bootloader. Both its secondary and
subordinate bus numbers are initialized to 0, while its fixed secondary
bus number is set to 8. However, bus number 8 is also assigned to another
bridge (0002:00:0f.0). Although this is a bootloader issue, before the
change in commit 7246a4520b4b, the PCI_REASSIGN_ALL_BUS flag was set
by default when PCI_PROBE_ONLY was not enabled, ensuing that all the
bus number for these bridges were reassigned, avoiding any conflicts.

After the change introduced in commit 7246a4520b4b, the bus numbers
assigned by the bootloader are reused by all other bridges, except
the misconfigured 0002:00:07.0 bridge. The kernel attempt to reconfigure
0002:00:07.0 by reusing the fixed secondary bus number 8 assigned by
bootloader. However, since a pci_bus has already been allocated for
bus 8 due to the probe of 0002:00:0f.0, no new pci_bus allocated for
0002:00:07.0. This results in a pci bridge device without a pci_bus
attached (pdev->subordinate == NULL). Consequently, accessing
pdev->subordinate in of_pci_prop_bus_range() leads to a NULL pointer
dereference.

To summarize, we need to set the PCI_REASSIGN_ALL_BUS flag when
PCI_PROBE_ONLY is not enabled in order to work around issue like the
one described above.

Cc: stable@vger.kernel.org
Fixes: 7246a4520b4b ("PCI: Use preserve_config in place of pci_flags")
Signed-off-by: Bo Sun <Bo.Sun.CN@windriver.com>
---
 drivers/pci/quirks.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 82b21e34c545..cec58c7479e1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6181,6 +6181,23 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
 
+/*
+ * Quirk for Marvell CN96XX/CN10XXX boards:
+ *
+ * Adds PCI_REASSIGN_ALL_BUS unless PCI_PROBE_ONLY is set, forcing bus number
+ * reassignment to avoid conflicts caused by bootloader misconfigured PCI bridges.
+ *
+ * This resolves a regression introduced by commit 7246a4520b4b ("PCI: Use
+ * preserve_config in place of pci_flags"), which removed this behavior.
+ */
+static void quirk_marvell_cn96xx_cn10xxx_reassign_all_busnr(struct pci_dev *dev)
+{
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		pci_add_flags(PCI_REASSIGN_ALL_BUS);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_CAVIUM, 0xa002,
+			 quirk_marvell_cn96xx_cn10xxx_reassign_all_busnr);
+
 #ifdef CONFIG_PCIEASPM
 /*
  * Several Intel DG2 graphics devices advertise that they can only tolerate
-- 
2.48.1


