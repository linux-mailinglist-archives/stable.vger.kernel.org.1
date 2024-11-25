Return-Path: <stable+bounces-95349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E8D9D7C53
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 09:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA082B20A4B
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 08:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0AC42052;
	Mon, 25 Nov 2024 08:04:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D237E8827
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732521858; cv=fail; b=BVyZ9RVrspDI3GDrLKOVlUZROcnwUJurAJ01HMw5xqsomXaNOPdjYJfdL41ZXGzJhC8oFZuFI6k6jClOYQYBWgxldF047F3xq0lhu+FgUshXKA/iuACC74WP1GXRp4UNL3VxcTjUhmZB7DXRmct5rpKOXTeteEgwzcOaWJBUQOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732521858; c=relaxed/simple;
	bh=kVmE6LZTE8DK/nS4A1bdQ/w+apWUZHFveJ1T/+6nO/g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Aeqb0CX7QmDBcBEm4WRYGezhtybAUOLKVIX7qI9Ddc1GwigX4lFIgHw38EjJGTcMNUi6rO+LE3SIAZrYaB8K9tx0xEePYeJcht+9fzFViqbr8w9uLMiipmsFnZMFs9dr/z234pVJOjPIlrNsNaFT3jJ9oGR4TNAzwsAgYO1WLR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP7qtG9026581;
	Mon, 25 Nov 2024 00:03:56 -0800
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433feq1bg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 00:03:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCBshENaZLbGPWL1tkM7/zmivSclXcUfmRw6fahsYr15u7bowToHsREIQc2k6Jk4dlUPAYp+q6M3TvEpT39mEaFGcXn5SPgmDJ6ATAIkTLdwuseWpnL0f8B3YOc6ZvVEvOR11mXOs5z9KLc6GURBPlPk5KuNLzOCLyXL/qzfHNRdoqXqq1t7pq08nzAHCZs+449ys2J5n7wQyvI4t1VXNhO2y6vgRUFz+0Y5NSS18A7rNu+iq2pXQthpKPMivv8aDX8HUYtp4mI7yW7iNurEMgX90ehKuV2ZHguTRTOQG7BdEv5l4P0u0fV/BFsaIdDU6JA5IuKwU50zJj7bxyfy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7utajSS2/e3kIa6jTLyOvJ9mLizp9Yq5w/R/I1cLXFg=;
 b=DdRb/M7FNheby4di8tKSQ2/Kp4zJcXxuSiglgf5OdDjUHnG2iK8c4KJTIWOwvllDkQzX1EO6mdHA8D/qfCprHZnoGMTicXWEBqsXZnmpI8N8ofKOS0uMTC/0XreuthRfWowj0xlu08sENa/4RcsIvKn7PE5trsKF/BLi8JHYlXL0VUydPF1E/WuSf7bnKermnbXF/x9ZUWvugp6yQ9AEuFY5znlmEtXGj4nv/JmuhfcgYca4aF79mDZDxYcaSl2zK3ZImGbHvOR3EbcYjZUKsd6Ek9j1Ftgrl2nNmPpDAjr+l0bK0JrDajxgr/E5COuU3GaEiRB5VkPUnG0D1zw7Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SA3PR11MB8074.namprd11.prod.outlook.com (2603:10b6:806:302::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 08:03:52 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.024; Mon, 25 Nov 2024
 08:03:52 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: brauner@kernel.org, lizhijian@fujitsu.com
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.6/6.1] fs/inode: Prevent dump_mapping() accessing invalid dentry.d_name.name
Date: Mon, 25 Nov 2024 16:04:01 +0800
Message-ID: <20241125080401.3630757-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SA3PR11MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: a1606528-6ae9-490d-ce50-08dd0d27b339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U4wmf07mcxjaOilNbVRm9kJXqbBdP4Lsrxu30MkOzyt+4fUPM6bjtYaeoEhr?=
 =?us-ascii?Q?jH5CM1oe2GYpz3Ufywkh5gaI++ziwtIN9E47d4Ot/DKpY4MFO2s9LO+xctQR?=
 =?us-ascii?Q?/KLjWQkipYHSus4PgUwz6b5Ch/8tRTZ0rfZ7DYEN/KVRRGhsnRhWU36anEJx?=
 =?us-ascii?Q?irxS+pYoTHnh/uMUXySg0k0W+rVwGxxCqYKfHEpHaGwM9W1zf9kUhSu1K85J?=
 =?us-ascii?Q?g76kDT5ST5NbndWVMry6uv0OY9UJSvsvutKHPeRyKR37HfAQEhekyLPm8e9H?=
 =?us-ascii?Q?avzQet/3ImG9DV0iXXyymTSFcOJf/K7QxuPFeuJSz+Tizl9CX0xLN5BJs3OV?=
 =?us-ascii?Q?BfC54d5z4bV+L3p7mbpks8aKuMIxYCvO8Bo1l6gsshZEpjeNCpGH2gXrk+Jq?=
 =?us-ascii?Q?SEeFq6Wugd8/w+2ZIx6FTNnawaweZdMQhVDqPsRi9/QWpT7a7pRLfA5xuQJU?=
 =?us-ascii?Q?GszjkZBBWnZkwL/TdZM8ZJ/Nq/vvsRHJhBgB4z77YHKM7RZRhWwWRwbY2qhe?=
 =?us-ascii?Q?JnA4H6LQmyzkWeV6hG6ZtJUwxwZ1BEzCvS4+G7COiQgzGuvYBwmWB5XM7ODS?=
 =?us-ascii?Q?PFxEdjgeLqVQpXacQoKW9AL2Wrv0bhqVxuxDIu78nK1VgpLaEhBjJdRRSXUd?=
 =?us-ascii?Q?NIgMnyMS5hZ9C9OxlsbGtaZnOM0ESw6ZrR/j2IXhp2YT0KMuLsPQJfwB/y3Q?=
 =?us-ascii?Q?t4CTNzP0CNQAEKmyzqiP0X7zHm4JjDzotT8JVD1bkOrd0mCyxa7fG7AX+XYa?=
 =?us-ascii?Q?yhtm5e02/r8UwsNPD+ttus5Ag3FTRwHup8iWah5BY2tCOPU/4mkVmv2IiOmd?=
 =?us-ascii?Q?UfVfkb+B7+aA4FycJP7g2FDEq9UeJvC+YXJgEjsuuQbiTWS4+9QlW7holjnD?=
 =?us-ascii?Q?pbIS+BLpEy3lO2ejOnKAF5Cie3VvAmhB2LjhyAROnO5e1NS3QSIg7lNKroz8?=
 =?us-ascii?Q?+ZRdQo3jn8wS8aLYciDNvHbfzJsrvJcm0T6o//+c6SK9RHriyv3ZzQ+zu4LT?=
 =?us-ascii?Q?XrsTyHLlpnJnz45NVaImnQxNtKSG5bTcmfBvSnhGk1BDldrsdRgTVO1TKmwS?=
 =?us-ascii?Q?225EUKL1qz8wZ0U2Ma4wV8psBPq0ahSPgfIM3iQE0lXjZvLGMPaSYv0f2GdG?=
 =?us-ascii?Q?zxX7j0LpS8OkKDBUECMjdgEpHOiMZJ5srwVv2KApE5XsCxrLp8QYUufKv91+?=
 =?us-ascii?Q?lNA6Mx7YzLNKUjUo0hdXaCah3TykNCL3PIl+sPMrDkcSXO2PKm9EB/9DJlfj?=
 =?us-ascii?Q?HYraGN6ARu88LxaqJA7kUmqSJS6XEH89B8+m++4FQ58yel6gD2vWgDGe7JJD?=
 =?us-ascii?Q?ZQH8R5zWBzctVO1woCR8qHdevmVfzCfjLr8TnzJzrAO/zouatvlHlxfVFXjk?=
 =?us-ascii?Q?mNmcHV0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?58Sx+lYLk6E0tkPFOzPwB521QDuSKBdYkybLZ+RqzyUTntUWFUxQ40pH9hcl?=
 =?us-ascii?Q?sRHQNFEzzC1uWclkx+0CJRZldkRlZNuRHbw490zOSw4UZ+OhdrIcivqYOTT0?=
 =?us-ascii?Q?Ua1gR37QQRoBWhxnL8+aXArsdnNbhtYbEYQJlqTfO+Ny6DF6AoX+MRZnyadP?=
 =?us-ascii?Q?WVXlAlKBeo127u/XOyz+lfCS3EtLViOCQgJY8vsf9/6YlFvoKrJrv/pSD/93?=
 =?us-ascii?Q?NE5nwSM+nocUz9EjNqffh/EUOxfTz1oQTQAtKtCfOaLCZ58jxJRYzsm0IUP5?=
 =?us-ascii?Q?IbCx+R3V24+fmDplGEIoC9S7jtH+a7DUc96CiOO1xUagg1QKI9yEYG5Q7qoZ?=
 =?us-ascii?Q?ncUXqqtK3qpsW903uLBdQwISck0BXTLh3s9fjAfdpbDnRvz6765JqEH+LXuC?=
 =?us-ascii?Q?nXW2LMrBomzw81cN5hggQGr2h+TbmGZ7X2UB7a01XNj059y43F17aPtR4nTZ?=
 =?us-ascii?Q?Fdix/ePfBgQ4lAxDERWqd6bFeKbX4KQCIZhdnkj45gK9NXC0qiLJlsTbJaWf?=
 =?us-ascii?Q?IH1bJLoPKxtfBp/CcMQyF/TsN4HC88ng+XHgOkZV/ej+6IIkgF5OafETDID6?=
 =?us-ascii?Q?1qDbNSB/soDdvOd0KSYTv7QF2nNkge7JFJGS8fU9fRVxgC0FyX4qoQx5orPu?=
 =?us-ascii?Q?TfNJBNb1YtH1KeAkgGU8IMUwWlH4jI37LQE4xV9VHD1dwNhAMuV2aNeAlz0S?=
 =?us-ascii?Q?D6TB2oRsviJZHqYN449pcQtqEGGjrhbDhlFRqKHABuQTAfmnEpHg9EeZ2/BI?=
 =?us-ascii?Q?YQuCQlbhoD9XezNksFqD3iBVF4aW4Eo48RdoJ8Mjh1HeaGod7+A3tIeBXGmq?=
 =?us-ascii?Q?aKk7yTSDo5RXjoyOYPlnzwzlDXvilC0kbyjSHGDw/51bi0AOcwQF+JufcmyA?=
 =?us-ascii?Q?VGd1sZhNnBfiPFYY7DRs6zw6ibpe1aRbajL8MudHuZsHEdT9PbafH6H4Efkp?=
 =?us-ascii?Q?iLTsk9ZK3fE/DqJn0+zkvWkgWHJEiUN79XJJcXuqEOvRgg9g0DlWEPg3l1vV?=
 =?us-ascii?Q?0/GBA5ZFTdmTIktlGg4fAJk6KkkbZag2YtRaWsc1FISu3dsSY9p5mSqK10H4?=
 =?us-ascii?Q?2iwi4rquQ1PyhIGn3dHeB9JHAc1tU7YPvary7yUIRBnQRts5ugLnpQJdxb/z?=
 =?us-ascii?Q?LUgMmKzjJ/mZAF5MBmbiJhmzxS/uAnphQgKwlUTjK8AnRQE0ecZY7B9gG/Hw?=
 =?us-ascii?Q?EaN8zvYhHwAa6sWMgbXLTQ1wJwQqVhKw/u5eFz6ZFVjbKMdpPhLdmYKeSsWf?=
 =?us-ascii?Q?RKK8WFrj4GAboBvMpUzxU/WZSV6ry+FR2BFown5xdF2115cxsL5f0gfWdXCn?=
 =?us-ascii?Q?QPB183XTzF7YZaIuJjzyIOUS0PmcCabjfj3b9rOt9w0/5mb7DqGQokPymfH8?=
 =?us-ascii?Q?uAby3pq4Mx1UjyQdZio8lBvfgvowT8ZGjRJ2GxHUm2Z2MqU4/G1re2dvfnem?=
 =?us-ascii?Q?hOhpoGOiLRQXhZt+AqLMLiEqqq1e18FssfHdfsCxZQO4OMN9sP56NX9q02K/?=
 =?us-ascii?Q?gi82KCcLvV1mL8UdNmcsSHlOPUP2sIWPYQtTJfbeR+FAdxDOAfHQJ6cjqpn4?=
 =?us-ascii?Q?lIe3bMQWAO5nyxgxqI4PCKHszldjp1klingjDRfYBFjk6W8dK4Lu1z0PxrO6?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1606528-6ae9-490d-ce50-08dd0d27b339
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 08:03:52.0054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXd5Lo9ll9NuNhHG4uU7J3C92Cm6zkez0W0QNcQLrHgXyLEstA5OrZ8/H+T9q9J0whNJEEeukvXe7HRs+lD8xth8UN5WTDq5Yj2QPHp56Ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8074
X-Authority-Analysis: v=2.4 cv=c+L5Qg9l c=1 sm=1 tr=0 ts=67442f6c cx=c_pps a=coA4Samo6CBVwaisclppwQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=omOdbC7AAAAA:8 a=ID6ng7r3AAAA:8 a=t7CeM3EgAAAA:8 a=6SAjInJtEksahZkb5OAA:9 a=AkheI1RvQwOzcTXhi5f4:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: a3Lxj829m_bB95YqEF5MNBeIgf8366Fy
X-Proofpoint-GUID: a3Lxj829m_bB95YqEF5MNBeIgf8366Fy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-25_04,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=905
 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411250068

From: Li Zhijian <lizhijian@fujitsu.com>

[ Upstream commit 7f7b850689ac06a62befe26e1fd1806799e7f152 ]

It's observed that a crash occurs during hot-remove a memory device,
in which user is accessing the hugetlb. See calltrace as following:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 14045 at arch/x86/mm/fault.c:1278 do_user_addr_fault+0x2a0/0x790
Modules linked in: kmem device_dax cxl_mem cxl_pmem cxl_port cxl_pci dax_hmem dax_pmem nd_pmem cxl_acpi nd_btt cxl_core crc32c_intel nvme virtiofs fuse nvme_core nfit libnvdimm dm_multipath scsi_dh_rdac scsi_dh_emc s
mirror dm_region_hash dm_log dm_mod
CPU: 1 PID: 14045 Comm: daxctl Not tainted 6.10.0-rc2-lizhijian+ #492
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:do_user_addr_fault+0x2a0/0x790
Code: 48 8b 00 a8 04 0f 84 b5 fe ff ff e9 1c ff ff ff 4c 89 e9 4c 89 e2 be 01 00 00 00 bf 02 00 00 00 e8 b5 ef 24 00 e9 42 fe ff ff <0f> 0b 48 83 c4 08 4c 89 ea 48 89 ee 4c 89 e7 5b 5d 41 5c 41 5d 41
RSP: 0000:ffffc90000a575f0 EFLAGS: 00010046
RAX: ffff88800c303600 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000001000 RSI: ffffffff82504162 RDI: ffffffff824b2c36
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90000a57658
R13: 0000000000001000 R14: ffff88800bc2e040 R15: 0000000000000000
FS:  00007f51cb57d880(0000) GS:ffff88807fd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000001000 CR3: 00000000072e2004 CR4: 00000000001706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? __warn+0x8d/0x190
 ? do_user_addr_fault+0x2a0/0x790
 ? report_bug+0x1c3/0x1d0
 ? handle_bug+0x3c/0x70
 ? exc_invalid_op+0x14/0x70
 ? asm_exc_invalid_op+0x16/0x20
 ? do_user_addr_fault+0x2a0/0x790
 ? exc_page_fault+0x31/0x200
 exc_page_fault+0x68/0x200
<...snip...>
BUG: unable to handle page fault for address: 0000000000001000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 800000000ad92067 P4D 800000000ad92067 PUD 7677067 PMD 0
 Oops: Oops: 0000 [#1] PREEMPT SMP PTI
 ---[ end trace 0000000000000000 ]---
 BUG: unable to handle page fault for address: 0000000000001000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 800000000ad92067 P4D 800000000ad92067 PUD 7677067 PMD 0
 Oops: Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 1 PID: 14045 Comm: daxctl Kdump: loaded Tainted: G        W          6.10.0-rc2-lizhijian+ #492
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 RIP: 0010:dentry_name+0x1f4/0x440
<...snip...>
? dentry_name+0x2fa/0x440
vsnprintf+0x1f3/0x4f0
vprintk_store+0x23a/0x540
vprintk_emit+0x6d/0x330
_printk+0x58/0x80
dump_mapping+0x10b/0x1a0
? __pfx_free_object_rcu+0x10/0x10
__dump_page+0x26b/0x3e0
? vprintk_emit+0xe0/0x330
? _printk+0x58/0x80
? dump_page+0x17/0x50
dump_page+0x17/0x50
do_migrate_range+0x2f7/0x7f0
? do_migrate_range+0x42/0x7f0
? offline_pages+0x2f4/0x8c0
offline_pages+0x60a/0x8c0
memory_subsys_offline+0x9f/0x1c0
? lockdep_hardirqs_on+0x77/0x100
? _raw_spin_unlock_irqrestore+0x38/0x60
device_offline+0xe3/0x110
state_store+0x6e/0xc0
kernfs_fop_write_iter+0x143/0x200
vfs_write+0x39f/0x560
ksys_write+0x65/0xf0
do_syscall_64+0x62/0x130

Previously, some sanity check have been done in dump_mapping() before
the print facility parsing '%pd' though, it's still possible to run into
an invalid dentry.d_name.name.

Since dump_mapping() only needs to dump the filename only, retrieve it
by itself in a safer way to prevent an unnecessary crash.

Note that either retrieving the filename with '%pd' or
strncpy_from_kernel_nofault(), the filename could be unreliable.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Link: https://lore.kernel.org/r/20240826055503.1522320-1-lizhijian@fujitsu.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu: Bp to fix CVE: CVE-2024-49934, modified strscpy step due to 6.1/6.6 need pass
the max len to strscpy]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 fs/inode.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9cafde77e2b0..030e07b169c2 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -593,6 +593,7 @@ void dump_mapping(const struct address_space *mapping)
 	struct hlist_node *dentry_first;
 	struct dentry *dentry_ptr;
 	struct dentry dentry;
+	char fname[64] = {};
 	unsigned long ino;
 
 	/*
@@ -628,11 +629,14 @@ void dump_mapping(const struct address_space *mapping)
 		return;
 	}
 
+	if (strncpy_from_kernel_nofault(fname, dentry.d_name.name, 63) < 0)
+		strscpy(fname, "<invalid>", 63);
 	/*
-	 * if dentry is corrupted, the %pd handler may still crash,
-	 * but it's unlikely that we reach here with a corrupt mapping
+	 * Even if strncpy_from_kernel_nofault() succeeded,
+	 * the fname could be unreliable
 	 */
-	pr_warn("aops:%ps ino:%lx dentry name:\"%pd\"\n", a_ops, ino, &dentry);
+	pr_warn("aops:%ps ino:%lx dentry name(?):\"%s\"\n",
+		a_ops, ino, fname);
 }
 
 void clear_inode(struct inode *inode)
-- 
2.43.0


