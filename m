Return-Path: <stable+bounces-95684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA659DB2F4
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 07:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 252C6B20C8D
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 06:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1810D13B590;
	Thu, 28 Nov 2024 06:55:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A546D136349
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732776948; cv=fail; b=Kj70c9RGWmIyWPHiTvX7jsx6HncumVp429byxpSi+wuHoiFC/EjLLF9HW6zblzt0som3EW7QK9ZGBTk9WwoUmeWJraT5yLlW4g3h2nbt1nQGleJtmYZa5aCcI/UQ4ocVpfRjUyYQuYZc3/7yG1kEO+cnVQjQbLWog+6dRby51dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732776948; c=relaxed/simple;
	bh=M0Rwkvr054R4KMBDmvEq8JCwrS/t91alO3ijFwHx2T8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Z8lJOzLFvM4M8SOroqYnZZnss/vFPOe47YllWQsVeZHzJTce6fxnnHk0eiTveU1SdiIQrOVblyCKpSAi+7TUTpDyDuX6E/y2K0ivnVcJrX9dzWsFmMy/xJvSegwf9WgeqpRgx7wrbJnubHx3CtW4pLgwdSm09iuvJE7rniVttDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS6E0pa031910;
	Wed, 27 Nov 2024 22:55:44 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 436719rpp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 22:55:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCqeBfQWXBg4x51pT2V4Id1gDbdE7OKxqMHXbutKcPUy7S8tYhdGacHlxpCWQp2dfIwt89z1Fg2SW/ItvLC4o1jHNRG9CgI0NPfrcWOHopGeDC13u8UAXJJUAIDNYvQLV3yfw+oiX9imon8HHWZKXvRN+M/dnGP1DdLoLLWrLRpqmXAFksccKcutvvOkrrfevEzJIOdOSiySMhMqmqpX11G4BPyIBS1UWbSOBbxqidtH17gT/FinkpUrnOzwxHmnHsWGgCf5pjOhRJoLIk8plmirxOvAB/oz9uTzOUG0aDW1cHYxUd8Kf4VlH3SNxsB44QOj4AuyN7xqpk+GF4a7GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0+WBNuwooVsWauOx9KhE/UlXZGrsjR5QfWN916CNfQ=;
 b=u9YYiyvHT4CfyBqshx5t/i6DCMp6gmggikGsqTWMzoIOX7ct8rmU0z6Lecd/k6MfiK869uZ267DydhcjNFyInAVciBKvRayDhhmeOKovbYUxBzCqY1Jy9XVfQAt5ZCNb6Ckp1Cj6CI3+vEg70FqUohqgl3wyqM+yOUIXZFLWWx9JFb34tvjGbMxuoK/huaFfOOHdncclj+wBez5bLoNE/P0l49a26KVE4ycAlYsJZkKVMSO0wA1vdX5c2YiaNf4b2aYoumck5OAIg2V4TFfV3PksJp2fFBn0jSaTyiHNN1Ulfg+998ZPPIeBlxgsewh18BBmOaUpJ5X3X2VoUKj+Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by MW4PR11MB5870.namprd11.prod.outlook.com (2603:10b6:303:187::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Thu, 28 Nov
 2024 06:55:38 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%5]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 06:55:38 +0000
From: Bin Lan <bin.lan.cn@windriver.com>
To: idosch@nvidia.com, amcohen@nvidia.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.1] mlxsw: spectrum_acl_tcam: Fix NULL pointer dereference in error path
Date: Thu, 28 Nov 2024 14:55:21 +0800
Message-Id: <20241128065521.1471959-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0137.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::15) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|MW4PR11MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a6a4f4-88d8-4040-24eb-08dd0f79aa8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qFkDYYLvEE1kZgQr4xr/umCaYfE2Z9ua4EEQQ/HDomCJ7/N6AHCnTggWLoQc?=
 =?us-ascii?Q?ZWi3auLWZk6iRPFJYAQnlbUntVYBxyIBTxZHw7w9zIqZGCWW+yLcyy2M/5Pe?=
 =?us-ascii?Q?RlY6vYGs9uAZVRPWUTOj/mw9pYa1fXi+3HPWBB6MWTuwC7nnO2Vunh0F5oat?=
 =?us-ascii?Q?KZeR7EnL1sQp1TzEVNlJHlbm4I2oTjuBfKs2ncM7pthJOsDo1YdmnHhonRte?=
 =?us-ascii?Q?cE5o70JlGA62Fs2EKmHe//7CZzdhBmtNt2RRZX1Z/jwO1WDQ69Cd+WToceK6?=
 =?us-ascii?Q?n/Y2Z6BIWVZYnrnHhEnLXXvjYqfbGL6qlAti5cBD6iLet3BB9cjInCzSfuiR?=
 =?us-ascii?Q?mPSpBbDq40wtJUharUDqWtz8ywO9F/DmYnV3bKSad2V+AtRuwTh2/eloO3uk?=
 =?us-ascii?Q?kO/cYOxGSuhefEJtBm3z4mmni72593EgI/KwvszKzXtgdSeEFp+X4iLHzoOp?=
 =?us-ascii?Q?yFkedjNdsLnNfXX1JwEIzYBQ5De+5sIsGCA4JfqhaoIMxH1OEqTmaEy8SHQw?=
 =?us-ascii?Q?FQ4Zj02oFvULEY2YJ4wQ3rt/L2puziDREEx3KQsZXU+2Y0AybTYAL5U0FLol?=
 =?us-ascii?Q?rUG4RNcYhx0NyRz9dgTojV5MrSpxshKZXK+d1WTX8aLfeHDdfMZWfJ4YHD+4?=
 =?us-ascii?Q?tOkdjw26Iagmiu/BCYfrLV7js1RtkvFVbAmTh8OOmfdIxfApEr7hQY7Sszhg?=
 =?us-ascii?Q?YoJvcYkumYZmJzXkIiUIOoZ8TYTjYh6GkFP3yh3wmItqw94v6ndQ197vyHvq?=
 =?us-ascii?Q?UWl0HLGczIW/EKC1Bn621rXsYRTjF6vLASWWqfzLPJBXPCEspvrBDPLpLeJf?=
 =?us-ascii?Q?P3T7vl4DBj2H5v8XMuxCjAn+5Sj3FnCj9TQiDYV6BV9GANSisK3Xh3jiQ6dK?=
 =?us-ascii?Q?ETG2bkTbRVqnw4D6qHF+P+oEH1Gooq8bEuVhqZVzO1x8t5Xs7v/iV7VryuP/?=
 =?us-ascii?Q?J7dPh6QH8Dco415kU8CXnFjvHXTIO/cLz1TfS9e5BAK6+qbMm/PKMqQ+f48l?=
 =?us-ascii?Q?YT9QiYnjJBbD7Rc6Hh7m5mEZMqTLssh5iBEax6OZUHhKE9Ng03cqhlDvMVUb?=
 =?us-ascii?Q?aHakB8Ltu/MarmyuXKOOsDkyiUYbcL0AMe/TQqfBX9Uks446kAvm6+GmkMAC?=
 =?us-ascii?Q?J8tRNkZNEFKJby5pUBbAoqJSKKyYx97DWv1iyt3SLRXKSaENPAB+mc3WcrFk?=
 =?us-ascii?Q?rlkgucIvZQOz0glrmI0BIVpV/ftCnv84tm9LkpGJIfqWJktRRUwOBP7VaZw3?=
 =?us-ascii?Q?D3p+u7zSL9isd4tWHJSWMSU2rjXd4ZqLf8HLKsTWrS98cl2nyCkHPq74+Vzv?=
 =?us-ascii?Q?4OA1qiZ8vHbAqYm0MmL4DcVgUbSMN7MH0TRFZmDJlIwqiFj3KVcJZotT4Xlj?=
 =?us-ascii?Q?cJWPdKs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DoYhvj6NtilbZK0mAFdYfH5uPJVtPqxePs0Xuqf5vdzB/mYZau16pVMQpg1V?=
 =?us-ascii?Q?gAahv6J6BYLUMOsiKi4YnjbI5pprSimayeAkgZ1mhEQ2NiNwqxwsuKJLp+3I?=
 =?us-ascii?Q?R1JEXYyuiTyCJIMGDYK6dHQmpsr771DA45/slRxL/3iBufhcUuJ6+14CgcUo?=
 =?us-ascii?Q?NaUbvAVN48FalzM/p29vd0q5GX3PB7FiDPgNE8VI0Z1coX5BncL7uEbB3IRo?=
 =?us-ascii?Q?WL7JsIblZdfWJxj5G8fu7p5I/QRWZd+xNgEqznmm/4KTDQV0vwPl8MZUqe64?=
 =?us-ascii?Q?H1o2cZKtQz8ed0zSimj1+fRgy9VXH0qWv8WfhmFwMKjo0hVUyRZX4VDXOph5?=
 =?us-ascii?Q?svUflbsE99Xn4GH1wA1sa6VNNoclVb9UXtYCYW2e3sN25AsaHwta8wqHJHtZ?=
 =?us-ascii?Q?9ZivyHL/bmA6JXG5laZmdwO6LtxWvIHDRA6AcfZYmmSpPec1jmQ/zkam4Rs7?=
 =?us-ascii?Q?2VxNo4XyDNprytiPkIsMkrkVkRIW4Tp/6LO5QWEAG2WmqJzs+uNu+Q+YBHSA?=
 =?us-ascii?Q?0WFR20sbIQ+/lN3Ud1jVVPsNvAEhUABOBG1tyd8LTkIUvZViowt7SwK9nxcO?=
 =?us-ascii?Q?/aKL+gPwJK5mV8rOKQ1Dx1SChRUQakopR4T7UNLKHr/2EQfWg1/d9Vxo90Wf?=
 =?us-ascii?Q?zjIDSB8/xaAaDKPyTIoCk7jhIrzyKK9BpYgFfKY9LIS6b9lCUOGsLRCQ6xhE?=
 =?us-ascii?Q?jg0SsNNfKSPZaX9Cm12i/8o2tw/zRaaJd5EhgH6wO53vDwJ4kFagyfpiCkik?=
 =?us-ascii?Q?iJiTI/clRuyAU0fiVjwwKmSzVdRWLabfUGcbg5QtUlxtO3E+70fIr1/NcKOL?=
 =?us-ascii?Q?xic5hQSBc/J2MttNv3QpriLE1MYjjEjn3ReO2/vpGazLwiO+0L5d9MiT3TnP?=
 =?us-ascii?Q?aJFBCenVhNCSP5nWpbgW/E62V/kNMheBdjNJGgJVHhn3BMnkJquSA/CltdSn?=
 =?us-ascii?Q?ewF/BKzQFw7/Y2ocvNSL1fNLcAGCb8PQCZ1fymXajsuTAg+PXGs/0IS6RRsP?=
 =?us-ascii?Q?O05LyLgjhL1rLDao6frD+I26ymxu+AMfPv0TlyxZqfrtcvJaBTPfFc9Hvxiz?=
 =?us-ascii?Q?SkoOjA10dJSA2bGZk5w5CacC2cDE8xZuiZrTE9woeLCgLnpKpVZHVZngx0wk?=
 =?us-ascii?Q?VU4mYXSEx1lkn15str7qTU/D6SfQMSmXSBaGaMlnqq58GYOTA+yQGcNpHPQH?=
 =?us-ascii?Q?OviHfLhs0Psz3MfYGckEs671c51rhK/+S3ZwMPGhZjKXeGSRubjVr4nXVpLd?=
 =?us-ascii?Q?T2hQ1e3FQWkNM8cqkTOVyvNhxrhZpvRD4/t3R/x9wJTW/+fsH+t7tbW5y2j+?=
 =?us-ascii?Q?iA45ul5klog+86jGmNcGvPb6s7duvCAI9xZHvsTa4i+6s7k44tNTuEWq8lK2?=
 =?us-ascii?Q?q77t6vIRv+I6s5GE1dKyG3LauZSoMteSgMtgiKPgrea4d8zPXAWZaFHTTrXQ?=
 =?us-ascii?Q?/8h4znKviWnxh+DPDCSAfNQwOQlEc54ZI23ewdUiumidzeoNaohqhaOTnvW5?=
 =?us-ascii?Q?vAKeL9GnokFvpkspbBdUp4ZEB6P4fNDYnYlc+zRN9nCRHJk/QVnr3AyOZpb7?=
 =?us-ascii?Q?B7FxKOc3Exd2zTdfUeDetqsELLNo6DsfJfTz+alNMJZN99MmE//LElhnyhwX?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a6a4f4-88d8-4040-24eb-08dd0f79aa8c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 06:55:38.5464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0r+eTIfCGPQa2X2sNCQQj3oRA4s8wFHbtxMTV/zONssgnbI0ymh4XfIlC9DBbhbll7bq4+KkIQ5w4e1ADmBJT+6gn1iQjSU/w8skHGseQUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5870
X-Proofpoint-ORIG-GUID: mmiUqzNxJ4xuRk1fDoxMQ75r8dmrUnCr
X-Proofpoint-GUID: mmiUqzNxJ4xuRk1fDoxMQ75r8dmrUnCr
X-Authority-Analysis: v=2.4 cv=Z/8WHGRA c=1 sm=1 tr=0 ts=674813ef cx=c_pps a=6L7f6dt9FWfToKUQdDsCmg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=bRTqI5nwn0kA:10 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=Is-75NSz2qhBGZ9VPcgA:9 a=cLft1JTYFefNwLbM5dX1:22 a=NWVoK91CQySWRX1oVYDe:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-28_06,2024-11-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.21.0-2411120000
 definitions=main-2411280053

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit efeb7dfea8ee10cdec11b6b6ba4e405edbe75809 ]

When calling mlxsw_sp_acl_tcam_region_destroy() from an error path after
failing to attach the region to an ACL group, we hit a NULL pointer
dereference upon 'region->group->tcam' [1].

Fix by retrieving the 'tcam' pointer using mlxsw_sp_acl_to_tcam().

[1]
BUG: kernel NULL pointer dereference, address: 0000000000000000
[...]
RIP: 0010:mlxsw_sp_acl_tcam_region_destroy+0xa0/0xd0
[...]
Call Trace:
 mlxsw_sp_acl_tcam_vchunk_get+0x88b/0xa20
 mlxsw_sp_acl_tcam_ventry_add+0x25/0xe0
 mlxsw_sp_acl_rule_add+0x47/0x240
 mlxsw_sp_flower_replace+0x1a9/0x1d0
 tc_setup_cb_add+0xdc/0x1c0
 fl_hw_replace_filter+0x146/0x1f0
 fl_change+0xc17/0x1360
 tc_new_tfilter+0x472/0xb90
 rtnetlink_rcv_msg+0x313/0x3b0
 netlink_rcv_skb+0x58/0x100
 netlink_unicast+0x244/0x390
 netlink_sendmsg+0x1e4/0x440
 ____sys_sendmsg+0x164/0x260
 ___sys_sendmsg+0x9a/0xe0
 __sys_sendmsg+0x7a/0xc0
 do_syscall_64+0x40/0xe0
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Fixes: 22a677661f56 ("mlxsw: spectrum: Introduce ACL core with simple TCAM implementation")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/fb6a4542bbc9fcab5a523802d97059bffbca7126.1705502064.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ For the function mlxsw_sp_acl_to_tcam() is not exist in 6.1.y, pick
mlxsw_sp_acl_to_tcam() from commit 74cbc3c03c828ccf265a72f9bcb5aee906978744 ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h          | 1 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c      | 5 +++++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c | 4 ++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index c8ff2a6d7e90..57ab91133774 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -970,6 +970,7 @@ enum mlxsw_sp_acl_profile {
 };
 
 struct mlxsw_afk *mlxsw_sp_acl_afk(struct mlxsw_sp_acl *acl);
+struct mlxsw_sp_acl_tcam *mlxsw_sp_acl_to_tcam(struct mlxsw_sp_acl *acl);
 
 int mlxsw_sp_acl_ruleset_bind(struct mlxsw_sp *mlxsw_sp,
 			      struct mlxsw_sp_flow_block *block,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
index 6c5af018546f..93b71106b4c5 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
@@ -40,6 +40,11 @@ struct mlxsw_afk *mlxsw_sp_acl_afk(struct mlxsw_sp_acl *acl)
 	return acl->afk;
 }
 
+struct mlxsw_sp_acl_tcam *mlxsw_sp_acl_to_tcam(struct mlxsw_sp_acl *acl)
+{
+	return &acl->tcam;
+}
+
 struct mlxsw_sp_acl_ruleset_ht_key {
 	struct mlxsw_sp_flow_block *block;
 	u32 chain_index;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index 685bcf8cbfa9..6796edb24951 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -747,13 +747,13 @@ static void
 mlxsw_sp_acl_tcam_region_destroy(struct mlxsw_sp *mlxsw_sp,
 				 struct mlxsw_sp_acl_tcam_region *region)
 {
+	struct mlxsw_sp_acl_tcam *tcam = mlxsw_sp_acl_to_tcam(mlxsw_sp->acl);
 	const struct mlxsw_sp_acl_tcam_ops *ops = mlxsw_sp->acl_tcam_ops;
 
 	ops->region_fini(mlxsw_sp, region->priv);
 	mlxsw_sp_acl_tcam_region_disable(mlxsw_sp, region);
 	mlxsw_sp_acl_tcam_region_free(mlxsw_sp, region);
-	mlxsw_sp_acl_tcam_region_id_put(region->group->tcam,
-					region->id);
+	mlxsw_sp_acl_tcam_region_id_put(tcam, region->id);
 	kfree(region);
 }
 
-- 
2.34.1


