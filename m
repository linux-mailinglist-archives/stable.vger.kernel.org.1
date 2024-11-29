Return-Path: <stable+bounces-95777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1369DBF88
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 07:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF51316481F
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 06:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE2A1531F0;
	Fri, 29 Nov 2024 06:43:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640DC14B08E
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 06:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732862624; cv=fail; b=BgLd7TPWoR2ZvpLtFA4nfAzkkxB3a7687BBAQY+Uq+7O4gAU/cN9V3PNJ1R0bfvQinKWBMILwmrRkQ3qtQyizNRCsvSmKa5l3HPXCF2+NFt+6Xn+i2C0sotLJaWjz338RxTGdxXrca3C+z1wy3uyP5fxHoNRbwopjNgZGX4TEtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732862624; c=relaxed/simple;
	bh=AxmncttSgfmV4S1mhQbOcQ2wX/IDg60ZOkueyPuslBo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uzdtUnJBUmx4AjycYHzyo9/oPmWEA36ak5F/lYt4d+QzGLT2NT48qpr01CXAmuBKl4X/gKqXPGZXWX5AAGLOj6uvfqzFVCGXIGnzTB3xvmal2w3UIcv51tYqQdH3IhDb66KTBm+9S0SIrThJ9S1GFQky7YMWeIKZagD+Xomz2Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT53gQ3002167;
	Thu, 28 Nov 2024 22:43:27 -0800
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 436719srk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 22:43:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoHHUHIOg62gLZNGqxa29n8pon19d+qgHa3xz1gpDs3e6VFIz9DXJEiTbUVGDnejVNRNk0RS9PFPllF3H7ADP3oC9MLeMVgbHFzVn44YeSmTSFnIMVBf0+Z4pz3yohg2LB6cZ0gYkjyxYL50wP8e4JQCo9FWvdQZcsOWGruH+gizS92KWfM0nBgsIOy3w9QUQ58HqfIkDok5yI+dctWtJsVm/oGXzGpU9fCl3IxvPdmO6VQitKD/Kl2XFE32A6C3+mzK/F9ptN66PR3JupWWHLPrhCJlOVNtcLCUWTfkD3auK1FNDg8W41T8P8cGvdja58gXA6bzlDI6tBcT9J4E5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgOcaUjxcU+iytqu7FTPZixCGyNEWPhgAyUh4XZLLvk=;
 b=kIeRbMd5pXW2k56iuP3P4ScvfJ8q/aQFNz60d1n5mXqt9NmJOYPCD10T6Hp+mhDHao76IjL4NnCoMWm2iD8+rLvwzMpq4lApOZ4kRsaI5vAfRkIH4z8gf7MUAtJELhb4PhnuEUXdx++RRL/WfFLDGf2WMpnf+wvbF9UqBTG7IO4QBvYRUpUDr8xZRv1jRJ4l8Ngjb3OAEOY/9px+/VkzV8PU9VsVMj/hNhHYXjgVXdXc6X9UV8ZTa7h7Cn9uQH9/HB7YcKKF0suDfxONQJzDsPJEDugigFhWiEZh+XSzoSq18sHB5YyiUsfJDKg4v5xvnb7lCUVVgjkq/oYQW7tDhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by LV3PR11MB8767.namprd11.prod.outlook.com (2603:10b6:408:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Fri, 29 Nov
 2024 06:43:22 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 06:43:22 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: brauner@kernel.org, hsiangkao@linux.alibaba.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.1] erofs: reliably distinguish block based and fscache mode
Date: Fri, 29 Nov 2024 15:40:59 +0800
Message-Id: <20241129074059.925789-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0094.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::8) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|LV3PR11MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 4685defb-5b4f-402f-4976-08dd10411e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OyFxrcfUSVKc3X3z8tn1T86a1Mb0ORiAtZ8o8oB8t3ISd5h7WeW4c5WSwcAr?=
 =?us-ascii?Q?dCHe4eImtA0b+kJi+I1BblRbklAylIvnvTp947VMgMl9b1ha5mfl5MOq8ofI?=
 =?us-ascii?Q?IIgtitnGyxFw/2ySpqHSJgriiS5Tlf+zEVncEELraLs+KkKRMc6fGUbfxUTB?=
 =?us-ascii?Q?sSwNbRoSd+fuuAZNvbiEDezxCZ1IPg5BdVGojV6/1WNN8VhOYJaXdCj9dvQz?=
 =?us-ascii?Q?QAPQnAmwKwb15iLwp41fDUljO1oJ1GL5eIXS7ip5MnbG0g9AuXQ1+D+MbMB5?=
 =?us-ascii?Q?uyr+Sp/R+sBZZlMUxTbKf5DvgSOjI4bB+Mx6/yT/UFUkheeaazh1gkSDri++?=
 =?us-ascii?Q?LWalgtM6G9KpCGwfcaoYoM1TYwB5R4Ri7Yg8wUNXLqSgd7aqX5A4d0XHc6CU?=
 =?us-ascii?Q?rzlKVJB/C8gX4S0dXGoZc/APpZSKtt8VI9V5sF0LGSfm5Bg4uJJqO210d1mY?=
 =?us-ascii?Q?q94Ki5naEIJDOp6pwhoVkv0Ujiixb56LOO4Xa9yhXgM5BirbwXZZztrl1FhE?=
 =?us-ascii?Q?fNTFaS4CWwM5+A3nCIF+4BGcC3OTlbqZd5uvyzr4c6EY6ttpfV6HZVI5mMgs?=
 =?us-ascii?Q?i5NGRtTeAFuWzFdFrxQsdGRipN5Ed11Yhrdui3hLigBYCSffQdaS12p6dpN8?=
 =?us-ascii?Q?5fyApAgkYn4ruc24WZxywddoP8ucEgh3CZffLcdAG6dK3i9eaQlW1hqbS50n?=
 =?us-ascii?Q?zMcH4vhAR0WiGC//l+CBMQcfYF26cVr/MalthtdMJrlMczkeV7FTLH6M/l+8?=
 =?us-ascii?Q?18b3g+ovVw8/YndJThOxeA6R7IdMTYaZZeinME2pwD/sBZQT35VbR8ypP1Br?=
 =?us-ascii?Q?6dbsll8PM+r/Haxv4kYS7oTDMM7Hl+5MUEyBm61U3bQyw1DoAsvl8QWYBsVW?=
 =?us-ascii?Q?RWFRAbyWaXrrxGBY+NR+x/uJldT/9JUO8SwMX4dXAabYOOG7uoTJHApqUkdE?=
 =?us-ascii?Q?4+Utz60Z9fjaYV9mIS4PLsreX37RdSQvuRlkt/DBZN9+vF6XbM/XoDUi/3tO?=
 =?us-ascii?Q?f8GKxeL2aHWAgnn8ZiKjp+5USS2DM2l9HoKT2NkL7AORyYT9e+f9ioiMo8Yy?=
 =?us-ascii?Q?YWi/j/wjTHp+3PEr38Uj5O21TymqZMKDqh3CIw+BTR6nKIQdpI9JYHdW1d4c?=
 =?us-ascii?Q?5WNq/ZT2XQGSN1yw4ohBlkAoIJan4kIrgQXZhZdMC+uSGVScNYfLy4OQWQmy?=
 =?us-ascii?Q?WnwfXsBQtN9coW1VTIR9JkKQJG2MtHAsbZOO1QjZeKPmdJzsIC/08vgP601e?=
 =?us-ascii?Q?CF2Jm+HXCktpaCi8CSDkpzCM6ZHU+RxHWqGh92ir+e+R5it2utmxHQ8oLMH+?=
 =?us-ascii?Q?MoQsHr1CrM20a1w23SX21ORvzCp7kRdy4xkIvPtAhnCh/XAk0024YJGP7Rq3?=
 =?us-ascii?Q?MG2JBz5gi03JZXY8MiGWtxU7yDSglMLXW4uSP0XEqsmQOsqpzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YHflM6ytdnAkiFPYQ8ZdfWecsYle+PGfjx/57DVFoLFS90RhE9c0O3mD3AGY?=
 =?us-ascii?Q?UK5qCh9Ba/DR3IPj5XSUPC6B80PB2yoWkFNqBS6Tu7vqVuH1jnXV9nPkHrd2?=
 =?us-ascii?Q?e9hlCC1DKUGS094g5Apd0GDwvjbPr4sEADD0P+ga7Mswdl2SoH6n6j+0JK93?=
 =?us-ascii?Q?t2ul/vqKHpuRcM+VpjkFZPSZsUgGfG70Tg6nScGRj1u1PYgv3Em64jYMjO/j?=
 =?us-ascii?Q?s0JmNpTOCbd7XU3/VC4HLRl6fi8ZZLpFoATatWXAWH7fC7uNshIiv517+pHA?=
 =?us-ascii?Q?BPpPrCdesPY0gp6R81YqzEvGCSGs2MLHE1LYC5qf5O8ezARayu6zIAXrFRai?=
 =?us-ascii?Q?TR+qImajcwZt6UTQQCoaUpDqZC5A/hD0/6nIRW2P+Hj4HZg2TiKHt2+ujYKg?=
 =?us-ascii?Q?EDdqRgdXHt/Fwpv5d6E+DIKKHvaFQAI+yZ2E8RKW+Zak52VGGi7VBLnaENlB?=
 =?us-ascii?Q?rJ2numlKwh3UObpgyI5nLarVzlxyNvW+c93yFhsxcsNf2hgCH8rF1e3pcQap?=
 =?us-ascii?Q?vM8nTgWi9B1madiHstQvtvP/IrQhHj9PcHpFSYxWW06Qbfh6iy7wZdPKojOX?=
 =?us-ascii?Q?JZvjuku9A2qeE01lyM0Z9Hdq/wpFG+cON1SDxy41VmflRex0v6fcnA1U1EIt?=
 =?us-ascii?Q?XLsIKQ+5mqGUnB6I0qhIHK5Q92iuWdc37hsnBld1vQMoZEP7Kz147mq9wMq7?=
 =?us-ascii?Q?HMRAOn0znNIDlQEE82DjiMdPYnZhn/AP53us/r4mLeyUOwHQ09ayhPlCX0zp?=
 =?us-ascii?Q?WcQtq2yjHmpuzX2BxaLdtAbPgOQkK3WSVA5EQ2GqRDfVzDoFe1p2CtPFOL4k?=
 =?us-ascii?Q?VYk3j1TdlFBTVX4TI7w0bEIy+0+ItAoZu4SnixQVq26ZqUkoxKKGL5rdxXMJ?=
 =?us-ascii?Q?7IMa/5ug8Qcrd8wTHMZR3n7QTkA7biZL/e53xsXFTPXan29zIVtCdIPhHnMf?=
 =?us-ascii?Q?0kX6JFBNvs1DGbWk6FUOMBEdXDhC/y7LuDoXDiIl+fKkXg2B5wRc35VhO/Pg?=
 =?us-ascii?Q?+xsAM7rdvMdIqCPP9+Rmk7yhZ2JFdFNvNFov9Y48SxOpaBRMhPAXm7wt36kN?=
 =?us-ascii?Q?mXhjn70UreWCUUiEQpKx8eCgQiw0oyI7EckheZ0KRxMKQSCWpL2KRx1UAExL?=
 =?us-ascii?Q?226p1whnfcO9j6N9+jqu7N/O+C5Ds7eGrzGcLDij7GA58UtoC+/7jbRKVJoe?=
 =?us-ascii?Q?QdW0N5rCu4W/DA5X3i6paUFWAB4lTehkrgZMb4xTWBhiTXsvHcfbHoxW17YS?=
 =?us-ascii?Q?vt+8HDCwq8PEw4c5zmMAzllBpwuRKU1d7NBGv6J86yFOM8I7AQTQbrgzYZzc?=
 =?us-ascii?Q?YsvIVyii0Fk76teuMBU6+Qb3str3XOFNoHARVD/83W2XYAgxsSQXuxUbEBsS?=
 =?us-ascii?Q?UqElr6QlVCuQz+Mcyez//cioP7oOYpwOTK4fJeutazmmXBLCAGqRzNxHmhht?=
 =?us-ascii?Q?qrkhZq1VTI/yPXMIsw7ZVlYcbbyfJZyUdqAvro6nmWLWu/4Yodj02oxTh7m1?=
 =?us-ascii?Q?Nd+4+6bwFZ4c1Egiu6iTwFvB67xYxbvcXRlpQxb+8+uAvL1NnCdPQTlEvvM8?=
 =?us-ascii?Q?rnSN2aIxELFk4YF2sQPsNAwp6j+DWYWKuspA8GPl0LgE349r+yQ4MtYSJ3l+?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4685defb-5b4f-402f-4976-08dd10411e49
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 06:43:22.5324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DK6vkTwwAL3Yvl408UMUaUkWuZPVwWGKm2KqoOUjIG4xKDr/fyLt56qeHj42ctj1krZ+lxo1PB15vZMh7EoeEZf4MhheEg7x8jfnRX51jlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8767
X-Proofpoint-ORIG-GUID: Q5EzIRJv6BoL_BMvNOnzVDJj2fxMttqx
X-Proofpoint-GUID: Q5EzIRJv6BoL_BMvNOnzVDJj2fxMttqx
X-Authority-Analysis: v=2.4 cv=Z/8WHGRA c=1 sm=1 tr=0 ts=6749628f cx=c_pps a=l5p8UTqLmUd1ApN92JXWiQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=i0EeH86SAAAA:8 a=SRrdq9N9AAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=ScEOmfQnvRNr6VNci78A:9 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_04,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=885 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.21.0-2411120000
 definitions=main-2411290053

From: Christian Brauner <brauner@kernel.org>

commit 7af2ae1b1531feab5d38ec9c8f472dc6cceb4606 upstream.

When erofs_kill_sb() is called in block dev based mode, s_bdev may not
have been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled,
it will be mistaken for fscache mode, and then attempt to free an anon_dev
that has never been allocated, triggering the following warning:

============================================
ida_free called for id=0 which is not allocated.
WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
Modules linked in:
CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
RIP: 0010:ida_free+0x134/0x140
Call Trace:
 <TASK>
 erofs_kill_sb+0x81/0x90
 deactivate_locked_super+0x35/0x80
 get_tree_bdev+0x136/0x1e0
 vfs_get_tree+0x2c/0xf0
 do_new_mount+0x190/0x2f0
 [...]
============================================

Now when erofs_kill_sb() is called, erofs_sb_info must have been
initialised, so use sbi->fsid to distinguish between the two modes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20240419123611.947084-3-libaokun1@huawei.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 fs/erofs/super.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 25cd66e487e8..5bb194558da5 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -892,7 +892,7 @@ static int erofs_init_fs_context(struct fs_context *fc)
  */
 static void erofs_kill_sb(struct super_block *sb)
 {
-	struct erofs_sb_info *sbi;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
 	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
 
@@ -902,15 +902,11 @@ static void erofs_kill_sb(struct super_block *sb)
 		return;
 	}
 
-	if (erofs_is_fscache_mode(sb))
+	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
 		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
 
-	sbi = EROFS_SB(sb);
-	if (!sbi)
-		return;
-
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
-- 
2.25.1


