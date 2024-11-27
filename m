Return-Path: <stable+bounces-95578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C81869DA097
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 03:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F341168564
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 02:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F331BC3F;
	Wed, 27 Nov 2024 02:18:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF2D49638
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 02:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732673888; cv=fail; b=B4qH3D+pfWJ1ptBS3ehwEiyP4Rotm5gqm+ap6HfwC0Tae73sLlmIlx/9AsA6Y5VcUTkQlsIhSg14vuG9rVXyMHBogMofuu0QxhVJ2uFY8m4u7c8B/lu6X75Mb1QteWgcrwcgvQUwae7comCWsTrkzJfgPEP7UDqu9afWggojbMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732673888; c=relaxed/simple;
	bh=F7QU2LEM78SHaDrceTnImDbt6Hkqwn1DwiTk4vuJ814=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SrWmLNq+Fas2Y3zT3kgPft3UKUwKpzJGll48hUh+Yyu7XUL11AZ01wwP8IapkqWSBRRujH1ju969IPS250VT4bv9ITbsILgRTPqcnraZx0lpb9P9Ty9i2ZDT9TuIEbBj2mgmRzmqBN+mnUcKprvB+QZ5cYpiUt0J2SXhZtnJM/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR1NPCM010399;
	Tue, 26 Nov 2024 18:18:02 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433feq3mdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 18:18:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAod6lPlGqzyg5WG+ODipTvajk9YYvcd6GDT52vTizLnlvpXlulEsdXaC25eKzLBd48dim1Hrd/hux/NkTvATFENx1o0jrNR/vTizIm84Bd6JnVP8lO7LeJsiFnBGtG0q7NEmORRPAirBrMWph1RVSCrSyxwQsYnriWhWoiT6LLAOl+huNpmJfKsBal6xKbGb8tPNid13mvofkLgGsMoUCGRbQ+ONwRE1TqmT99+1fzuqWPxy2AEv/A6yxA4AYKXfQkoDC+umostKh9rq1oig6scZvrSSUtM8GQd5P8EeXboZvPAUjUtIhtKXwdqKBtm3thvjLz3xYY95RFuXHseFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTPay9bqxA7RRaF4vEX8MfgaC16GNuxdavTduHg2nrM=;
 b=JQGJWbuSNGuvOph1KnQJ4RP4AY2PCD8zm/KhGVT9ZNr0Ecd+Msgh4lykQrzL/tx9UlDiMUIXySoTVSLMIplr+9LG4r7ksjBzJGlIPPVDcx438GlviEEUH43V8j3yGIpsfKbi7+EJ37nEf6uYdYc2z+Oftc1i+RZPjVchrnrmi6gztX5m460O8JsduGR8UGcS9eRNyzOWCIpQ2GMumpznoiqsOYab6l32IaKjvMAbs5o0Yq/WoLhg4wvk9ae+nZ1Atq931BWKLYvhBSWjc0Qgl7OnXvrzWUmTWFSZ8cm6UIMbboN8F7NQ+M+90w48KubkNIzqLo4/uf1doq6f2nFD1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by BL1PR11MB5303.namprd11.prod.outlook.com (2603:10b6:208:31b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 02:17:57 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 02:17:57 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: qiang.zhang1211@gmail.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1.y] rcu-tasks: Fix access non-existent percpu rtpcp variable in rcu_tasks_need_gpcb()
Date: Wed, 27 Nov 2024 10:18:13 +0800
Message-ID: <20241127021813.472737-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0082.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::22) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|BL1PR11MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: def4f977-b95f-4848-3340-08dd0e89b54a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TEMUVKUK2IBP9g1QVF2lO4OSWK3qlU1sZB3YjPVcqxeTd6mplkGhqbVw6LdT?=
 =?us-ascii?Q?BqWvcuhs0blj2YGkRZYkZMD6OjKnRA5KhwKz3EPs/Vcm8epYww8w+HjytQzt?=
 =?us-ascii?Q?RFG7FPel0ugWU7rvD9ReumGRufWOo3S/GEoq1MDu6SCQGnQMSxEigVTC+/rR?=
 =?us-ascii?Q?v666q4dLjzJ819WK5kizLKVi/vqRcrwJC5LUhGLuVL5FRSYRGxK+irWCtioc?=
 =?us-ascii?Q?pn9fkZsoA43JIrUn1TLUSuz4DCCoxPglh2RMSb/whZd7xmSxt2xL7ONI3O9k?=
 =?us-ascii?Q?YTtDE5IZmTNX1LUf6WiTyjPAiJse1grwKJBzzTLxeh/uV5XtmO9HGVBuv+g7?=
 =?us-ascii?Q?NjCf5p4MJs4oYmOxrDvv14wtiWkItLf3KX2phfbaFL6u8EYjwUD+rkEE7k31?=
 =?us-ascii?Q?s7naSTU9LYHRUEqjMaqD8Zq4NJ4pIUps6QXxqFxaKWrFN+3V8P1F9rj6g1SJ?=
 =?us-ascii?Q?UL5hhGFR5oWKxFYsKVJJVk7agiEhWgf37EnSi9hRUnD3hNZ5kB9ebgw6gXSx?=
 =?us-ascii?Q?AlBbOw723c9zGtM9kQtbfWtCJEPEUtlCSxkbYldA2REzhpu5rHk0aAQmC490?=
 =?us-ascii?Q?HrHzCOFaQO7vQO2To2sPkMJinDV2kmYAIe++l9aJjlPLrnE6f2aHbKLiiShm?=
 =?us-ascii?Q?fJiq1S2NDSSG3z7oqBvbUZzRxZdge9XiDUtXnb0llMSHVQq8MLVeJ3obges2?=
 =?us-ascii?Q?Thn7OPDshnd3ti0e/fgEmC4kaPsYFAaLXyjCaV0AXkbLbXCRXFg0KyIIFkVc?=
 =?us-ascii?Q?+NumgTUkeiSqiATFWl3sBLI17P+J6ZhqRo0OhzJX5g49xoGUomqWBLMiXkAF?=
 =?us-ascii?Q?ToM5YY4DbJBsrddehbfIIZRvRJXrHntM4FEo5IGZMijbgZh3PULG41esOA/t?=
 =?us-ascii?Q?9Z9TxrNPhSO6J7nGOdrEd6QHvHyRTcQ2S6MtpvlVpB77yGsGbEpvfFnTd22m?=
 =?us-ascii?Q?ybOS/O8t+hXAcVAXoR9MLTuI46E2UByT9yZWB8rrKO3upiBZSl2EDdOXOu/O?=
 =?us-ascii?Q?0Mvdb9ZFBXvwj8husbwzpkfWppxaRKPGsZlVyvEpIjuhvIq1wOAjLWnS/1ct?=
 =?us-ascii?Q?5zyLCSRha9Lv2mDCpOzbT+pyQyRLm61/1B41dbgYaR2stT3obFzsaB0KgQwW?=
 =?us-ascii?Q?1u59wMXGvD6g2xXxEhlkzQESh4axtSbslVMDYzMUF9Cl5JZ6bj8EqW1YbqUC?=
 =?us-ascii?Q?V2tyJPXd63jdyOJrza44ZGJIQ9c5NwiHVnkHXumBPVDoomxxtfrCL4C9YdL+?=
 =?us-ascii?Q?II3UF1AJTF+7z+1x/vGKHKWpndT9l1mnOQiPabLhMiXL3eEmerRAg8pvJxjv?=
 =?us-ascii?Q?tzXEu8iQRPOz2JEBTjlmIsIGLh8gyWvKYeHRUaGZ8gAPpvsmk/iPLn8VyTsp?=
 =?us-ascii?Q?TSzQ8bw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IEEM0HxVe23KZVTdycxTd8z41gdc/AWpGK72vJYnEqkHA0FrOwP5kPj5aYqE?=
 =?us-ascii?Q?kWPcn5vu72Ow0XtQLN8pFp4fdufRHcPNXwdy95PEk6bfA/pylQF+w61xGHR9?=
 =?us-ascii?Q?Lmf5lSCBx+fKmkTb9CmyE5ZWrays4i5q6Cnqkk0acqQY+OmJEbfKkq6onvao?=
 =?us-ascii?Q?MmtUKjhaXXI+h89bC3bI2sqKMNodTH+Mt64nE1hDAwPvhew1AM7TeACyoqpo?=
 =?us-ascii?Q?wzpK5PYdTraeJFOP0eN8Ie7fkjw5dd/IqjuF81sOIUOrrhfTAIxFwRvWm6oB?=
 =?us-ascii?Q?bFzjrKu18IaY0nN52GAIOkmN0DFd6twBuY3FWDr5pUTSNTsv6aJgO2mRndyB?=
 =?us-ascii?Q?tx11JhEi7xqFkJ/Gudl6BRWxu+EcJ9XHJt4NU6XQ/fCM3nbwSQpViv5u971Z?=
 =?us-ascii?Q?lmu4XNQYhqRL1QOsKKpV3fywIBSwQmrtgA9mfDOFsMFp5lq0gT79uBoH5Wun?=
 =?us-ascii?Q?BDaPXczs6uxRQgGOVP+eTxa7yOIj006TjtIMhHdHQV9Vc7WLo6683rw2kn1q?=
 =?us-ascii?Q?PtGCW1Ja3G61c3rMDE0NMIAXdg7UjISdLtYCSvTZB/EYAYziKZqjjOcPzRW4?=
 =?us-ascii?Q?X8harMxfBIrOM2doQvbEoZKuQjFJVx7oX2qfpGxkT9Kxwri4moAcEccLiKA+?=
 =?us-ascii?Q?AjHfCEP5faNiA+M0/mX6HE+DUrcnFs8tcbKx8CLpl3WIwMMxyBhieEMw5eGl?=
 =?us-ascii?Q?7BVm1PYrGSXyxD+daEHE/HaJfAorlAX5b733Vk39F+rhJIKqenjyLUAUbk/I?=
 =?us-ascii?Q?4J5yXvJn1/KaJY7C6ZpEq5g2zrIk4wlTJjZ3ae8DCkyy7TGWDRKLtxMCi/4w?=
 =?us-ascii?Q?fmPg+ZRUz8hTGHjIx0RGfBvaTYMYklGANH3vWCHNBCUplhA72CphSBD3tXS9?=
 =?us-ascii?Q?nZCi+FH985YkMVn4LkDkky3Kb9tlKVWI2+q6ZbdcQC2NaQUMGpEgW2XtfEmU?=
 =?us-ascii?Q?08eiD1qcq9QCBdU9TX/4wfNgfqMN6BhIzK0s9oKTae0oFvHdhA8c0AdCffje?=
 =?us-ascii?Q?3WziLnb2sYXSFItIKvvadcXJWyuEd//WeLV6YetiO/bh1zgNmsgSpP4xr+gm?=
 =?us-ascii?Q?K4YIT36ys3bvrLazMnKlpDbgMQNrinWvtP8ZdWWZbKCB7fdrIuEidZj9GERZ?=
 =?us-ascii?Q?QnxbUxdfZ8HtrSBJjxsZFS/cvhmaV/TAG+DHqEGlUVHNymhdXk48th+E7Ky4?=
 =?us-ascii?Q?2C5LKodJKA4VI8+KDd4HwbS5aEsGTDY9CXjYV02g5qxR51u7vrqVP6WetIFg?=
 =?us-ascii?Q?L6jw3VWdmadYuP1VB8vpGCetUGLVSNP95hZCc3Dz93jE2jb6N98qIuS2HmOj?=
 =?us-ascii?Q?CSHyrY3M4NHUzul1aADkQr1baRFzpnd2/squnGikejvOemNLbfDvmMt3qFNT?=
 =?us-ascii?Q?nOwGkdRJSya7iMENRFKaOxR2Vl0W36yxOFbkcoOQtOvdaedpgG9VAprs/861?=
 =?us-ascii?Q?+qO4MKZJM2s+YxhybCiJv6JcFCJkHEWSxaBgDKGfd2FH5ps6L38RnwR+uhyJ?=
 =?us-ascii?Q?TD88ruWVf6etbju73MYeVwE6MgkJcwFIde2gTfgBQwYUE+0ZSU8AtqLjRkdg?=
 =?us-ascii?Q?cIsVMeZQXxiPBR7gYLKaAVxAL7+40lh4VxlmKB3qiyizfI6aJyuEa+xRjMjh?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def4f977-b95f-4848-3340-08dd0e89b54a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 02:17:57.3577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k79JVZqx5zcKeH8U9nepJvI2IeMPZy4FnsKDPjizAWD5TRc76LyEmfCP+PawnklmK71Aw7uj6MXwh97N08ugLtrprBxfPhNjxEGiK8IapRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5303
X-Authority-Analysis: v=2.4 cv=c+L5Qg9l c=1 sm=1 tr=0 ts=6746815a cx=c_pps a=5b96o3JgDboJA9an2DnXiA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=7x47-C_dmutJdX_ceZcA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: UWslo1owAFUgWBzCn2c9f1v8NZsTmHl2
X-Proofpoint-GUID: UWslo1owAFUgWBzCn2c9f1v8NZsTmHl2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_16,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411270018

From: Zqiang <qiang.zhang1211@gmail.com>

[ Upstream commit fd70e9f1d85f5323096ad313ba73f5fe3d15ea41 ]

For kernels built with CONFIG_FORCE_NR_CPUS=y, the nr_cpu_ids is
defined as NR_CPUS instead of the number of possible cpus, this
will cause the following system panic:

smpboot: Allowing 4 CPUs, 0 hotplug CPUs
...
setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:512 nr_node_ids:1
...
BUG: unable to handle page fault for address: ffffffff9911c8c8
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 0 PID: 15 Comm: rcu_tasks_trace Tainted: G W
6.6.21 #1 5dc7acf91a5e8e9ac9dcfc35bee0245691283ea6
RIP: 0010:rcu_tasks_need_gpcb+0x25d/0x2c0
RSP: 0018:ffffa371c00a3e60 EFLAGS: 00010082
CR2: ffffffff9911c8c8 CR3: 000000040fa20005 CR4: 00000000001706f0
Call Trace:
<TASK>
? __die+0x23/0x80
? page_fault_oops+0xa4/0x180
? exc_page_fault+0x152/0x180
? asm_exc_page_fault+0x26/0x40
? rcu_tasks_need_gpcb+0x25d/0x2c0
? __pfx_rcu_tasks_kthread+0x40/0x40
rcu_tasks_one_gp+0x69/0x180
rcu_tasks_kthread+0x94/0xc0
kthread+0xe8/0x140
? __pfx_kthread+0x40/0x40
ret_from_fork+0x34/0x80
? __pfx_kthread+0x40/0x40
ret_from_fork_asm+0x1b/0x80
</TASK>

Considering that there may be holes in the CPU numbers, use the
maximum possible cpu number, instead of nr_cpu_ids, for configuring
enqueue and dequeue limits.

[ neeraj.upadhyay: Fix htmldocs build error reported by Stephen Rothwell ]

Closes: https://lore.kernel.org/linux-input/CALMA0xaTSMN+p4xUXkzrtR5r6k7hgoswcaXx7baR_z9r5jjskw@mail.gmail.com/T/#u
Reported-by: Zhixu Liu <zhixu.liu@gmail.com>
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu: BP to fix CVE:CVE-2024-49926, minor conflict resolution]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 kernel/rcu/tasks.h | 82 ++++++++++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 28 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index bb6b037ef30f..46b207eac171 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -31,6 +31,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @barrier_q_head: RCU callback for barrier operation.
  * @rtp_blkd_tasks: List of tasks blocked as readers.
  * @cpu: CPU number corresponding to this entry.
+ * @index: Index of this CPU in rtpcp_array of the rcu_tasks structure.
  * @rtpp: Pointer to the rcu_tasks structure.
  */
 struct rcu_tasks_percpu {
@@ -43,6 +44,7 @@ struct rcu_tasks_percpu {
 	struct rcu_head barrier_q_head;
 	struct list_head rtp_blkd_tasks;
 	int cpu;
+	int index;
 	struct rcu_tasks *rtpp;
 };
 
@@ -68,6 +70,7 @@ struct rcu_tasks_percpu {
  * @postgp_func: This flavor's post-grace-period function (optional).
  * @call_func: This flavor's call_rcu()-equivalent function.
  * @rtpcpu: This flavor's rcu_tasks_percpu structure.
+ * @rtpcp_array: Array of pointers to rcu_tasks_percpu structure of CPUs in cpu_possible_mask.
  * @percpu_enqueue_shift: Shift down CPU ID this much when enqueuing callbacks.
  * @percpu_enqueue_lim: Number of per-CPU callback queues in use for enqueuing.
  * @percpu_dequeue_lim: Number of per-CPU callback queues in use for dequeuing.
@@ -100,6 +103,7 @@ struct rcu_tasks {
 	postgp_func_t postgp_func;
 	call_rcu_func_t call_func;
 	struct rcu_tasks_percpu __percpu *rtpcpu;
+	struct rcu_tasks_percpu **rtpcp_array;
 	int percpu_enqueue_shift;
 	int percpu_enqueue_lim;
 	int percpu_dequeue_lim;
@@ -164,6 +168,8 @@ module_param(rcu_task_contend_lim, int, 0444);
 static int rcu_task_collapse_lim __read_mostly = 10;
 module_param(rcu_task_collapse_lim, int, 0444);
 
+static int rcu_task_cpu_ids;
+
 /* RCU tasks grace-period state for debugging. */
 #define RTGS_INIT		 0
 #define RTGS_WAIT_WAIT_CBS	 1
@@ -228,6 +234,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	unsigned long flags;
 	int lim;
 	int shift;
+	int maxcpu;
+	int index = 0;
 
 	raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 	if (rcu_task_enqueue_lim < 0) {
@@ -238,14 +246,9 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	}
 	lim = rcu_task_enqueue_lim;
 
-	if (lim > nr_cpu_ids)
-		lim = nr_cpu_ids;
-	shift = ilog2(nr_cpu_ids / lim);
-	if (((nr_cpu_ids - 1) >> shift) >= lim)
-		shift++;
-	WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
-	WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
-	smp_store_release(&rtp->percpu_enqueue_lim, lim);
+	rtp->rtpcp_array = kcalloc(num_possible_cpus(), sizeof(struct rcu_tasks_percpu *), GFP_KERNEL);
+	BUG_ON(!rtp->rtpcp_array);
+
 	for_each_possible_cpu(cpu) {
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
@@ -258,16 +261,33 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 		INIT_WORK(&rtpcp->rtp_work, rcu_tasks_invoke_cbs_wq);
 		rtpcp->cpu = cpu;
 		rtpcp->rtpp = rtp;
+		rtpcp->index = index;
+		rtp->rtpcp_array[index] = rtpcp;
+		index++;
 		if (!rtpcp->rtp_blkd_tasks.next)
 			INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
 		raw_spin_unlock_rcu_node(rtpcp); // irqs remain disabled.
+		maxcpu = cpu;
 	}
 	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 
 	if (rcu_task_cb_adjust)
 		pr_info("%s: Setting adjustable number of callback queues.\n", __func__);
 
-	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim));
+	rcu_task_cpu_ids = maxcpu + 1;
+	if (lim > rcu_task_cpu_ids)
+		lim = rcu_task_cpu_ids;
+	shift = ilog2(rcu_task_cpu_ids / lim);
+	if (((rcu_task_cpu_ids - 1) >> shift) >= lim)
+		shift++;
+	WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
+	WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
+	smp_store_release(&rtp->percpu_enqueue_lim, lim);
+
+	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d rcu_task_cpu_ids=%d.\n",
+			rtp->name, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim),
+			rcu_task_cb_adjust, rcu_task_cpu_ids);
+
 }
 
 // IRQ-work handler that does deferred wakeup for call_rcu_tasks_generic().
@@ -307,7 +327,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 			rtpcp->rtp_n_lock_retries = 0;
 		}
 		if (rcu_task_cb_adjust && ++rtpcp->rtp_n_lock_retries > rcu_task_contend_lim &&
-		    READ_ONCE(rtp->percpu_enqueue_lim) != nr_cpu_ids)
+		    READ_ONCE(rtp->percpu_enqueue_lim) != rcu_task_cpu_ids)
 			needadjust = true;  // Defer adjustment to avoid deadlock.
 	}
 	if (!rcu_segcblist_is_enabled(&rtpcp->cblist)) {
@@ -320,10 +340,10 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	if (unlikely(needadjust)) {
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
-		if (rtp->percpu_enqueue_lim != nr_cpu_ids) {
+		if (rtp->percpu_enqueue_lim != rcu_task_cpu_ids) {
 			WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
-			WRITE_ONCE(rtp->percpu_dequeue_lim, nr_cpu_ids);
-			smp_store_release(&rtp->percpu_enqueue_lim, nr_cpu_ids);
+			WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cpu_ids);
+			smp_store_release(&rtp->percpu_enqueue_lim, rcu_task_cpu_ids);
 			pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
 		}
 		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
@@ -394,6 +414,8 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 	int needgpcb = 0;
 
 	for (cpu = 0; cpu < smp_load_acquire(&rtp->percpu_dequeue_lim); cpu++) {
+		if (!cpu_possible(cpu))
+			continue;
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
 		/* Advance and accelerate any new callbacks. */
@@ -426,7 +448,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 	if (rcu_task_cb_adjust && ncbs <= rcu_task_collapse_lim) {
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 		if (rtp->percpu_enqueue_lim > 1) {
-			WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_2(nr_cpu_ids));
+			WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_2(rcu_task_cpu_ids));
 			smp_store_release(&rtp->percpu_enqueue_lim, 1);
 			rtp->percpu_dequeue_gpseq = get_state_synchronize_rcu();
 			gpdone = false;
@@ -441,7 +463,9 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 			pr_info("Completing switch %s to CPU-0 callback queuing.\n", rtp->name);
 		}
 		if (rtp->percpu_dequeue_lim == 1) {
-			for (cpu = rtp->percpu_dequeue_lim; cpu < nr_cpu_ids; cpu++) {
+			for (cpu = rtp->percpu_dequeue_lim; cpu < rcu_task_cpu_ids; cpu++) {
+				if (!cpu_possible(cpu))
+					continue;
 				struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
 				WARN_ON_ONCE(rcu_segcblist_n_cbs(&rtpcp->cblist));
@@ -456,30 +480,32 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 // Advance callbacks and invoke any that are ready.
 static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu *rtpcp)
 {
-	int cpu;
-	int cpunext;
 	int cpuwq;
 	unsigned long flags;
 	int len;
+	int index;
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	struct rcu_tasks_percpu *rtpcp_next;
 
-	cpu = rtpcp->cpu;
-	cpunext = cpu * 2 + 1;
-	if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
-		rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
-		cpuwq = rcu_cpu_beenfullyonline(cpunext) ? cpunext : WORK_CPU_UNBOUND;
-		queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
-		cpunext++;
-		if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
-			rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
-			cpuwq = rcu_cpu_beenfullyonline(cpunext) ? cpunext : WORK_CPU_UNBOUND;
+	index = rtpcp->index * 2 + 1;
+	if (index < num_possible_cpus()) {
+		rtpcp_next = rtp->rtpcp_array[index];
+		if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
+			cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
 			queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
+			index++;
+			if (index < num_possible_cpus()) {
+				rtpcp_next = rtp->rtpcp_array[index];
+				if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
+					cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
+					queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
+				}
+			}
 		}
 	}
 
-	if (rcu_segcblist_empty(&rtpcp->cblist) || !cpu_possible(cpu))
+	if (rcu_segcblist_empty(&rtpcp->cblist))
 		return;
 	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 	rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
-- 
2.43.0


