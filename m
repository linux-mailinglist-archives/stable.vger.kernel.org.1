Return-Path: <stable+bounces-94090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088999D328C
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 04:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 181F4B21F70
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 03:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A4F15625A;
	Wed, 20 Nov 2024 03:29:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FD7155C96
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 03:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732073349; cv=fail; b=IgC/MjC87Hwe8wTD+5hVfij9/WZ7tO/KbLvu+yFHwTvvAUjSAc8az/njLcdZHXlgpc8DUh3Sod9BVMCyp/Y1BB2pD/2EvIj5ykUE+EVZf4NXGpGLVXRTN27w6KxYeitKatIxy3m0NkJPJBZOSXxog1qQG+O25eBvd9tSmVgeA3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732073349; c=relaxed/simple;
	bh=vm7aHi7BiEByX/cthb+y9xIZsrEZgGoaIjz58LwM9zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KJn3lN4GOaP4mXqK5Picloi91XYCql54GeCQC5pSDEoRvG9TWYaVqmfLLOK/C9c9TfinkbscZT+2s23znc9QMrqw8Romr/YTpKt2fUOltKKpLsTZs6oYoOEBejKTHgLsogKnQllnyodsKeviuhqB4jPH2i9RBkn3xLqORCucXBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK1Fe1r006125;
	Wed, 20 Nov 2024 03:28:48 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xjc8bshp-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 03:28:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKEQ/xtOJVShZteS1EYjf+paclsNbaqkf1m/Pme/aJZ1LABFp/CHSdr6g+89ulBDPW/hsUJ/XX99IsfDpQl3X1dTX3wKMofkDXQ7IRcFHb8D953GaXsQotT4ARvXuqbIEgfuK1H6KwaOWj74j7qeg02kLyoV5KWpcTTymVUdDcv2X7Vx9km/8BUoDlfwA0Lztd66HdeTilMNeyDykwvTHb0botcXEdVmmBgq9ovkt45+Q0dG+TvKau+Q1yYmEYcjwooEmdXfkmQJt/65ALjLiceqXpp2oZDT3lfrOsC8p577DawrJ/Ni/QdOeW2p6qH6h8v5Jx9j9nzOFwwJca/eWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjJgkwPOm5OYCZjtKPYjy04rCR2tBWza14F1Q6wza9Q=;
 b=ipkoq6/yHx65Ixwj30dMLSBUBzxBFzl40RnBggP+2EI0Ql1/moo2rJhjO4zYANQ1WQoaG7Z7uge4DGp+x7U4MDlrF6b74N5CExV07UHyfL8SJOIKRQiZ7wzoAUDuC93L7hXXFRWAJREMyMZYNmUjPudgl+EivmcPWXAnKP5qCSKBW8XJtWNvHN9dv4xGv7HJZtRm0+Yf8mRIW7uNgMzpzPvqoBg/jpNtyzfbquUmK3CrgWeiv2HGLH1agAAwFRe1kP0O8qYka+xzFfKo9cvMunrSpp58jGBTNBpXRadCMnYcMRGu6ltATdT/clqxYEYC0AuPtVojCyEcWWmUNPJiXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DS0PR11MB7192.namprd11.prod.outlook.com (2603:10b6:8:13a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 03:28:46 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 03:28:46 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: yukuai1@huaweicloud.com, christophe.jaillet@wanadoo.fr, yukuai3@huawei.com,
        dlemoal@kernel.org
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH v2 6.1.y 2/3] null_blk: fix null-ptr-dereference while configuring 'power' and 'submit_queues'
Date: Wed, 20 Nov 2024 11:28:40 +0800
Message-ID: <20241120032841.28236-3-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120032841.28236-1-xiangyu.chen@eng.windriver.com>
References: <20241120032841.28236-1-xiangyu.chen@eng.windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0177.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::16) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|DS0PR11MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: cc0999e2-3a45-4a9f-2cab-08dd091370db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TRmG9EHCOXfOYz4g1E+sl7/p6hFTd2t9kPaBHjelsqaOaWfIxJxvGrrHRQJT?=
 =?us-ascii?Q?sFnA6JJSUpPCmO+ysFqlSH/bCGLqMlJA4baIi00NOTA2KbPJb+TaMrBPIJ1t?=
 =?us-ascii?Q?+dLMIYo9V4mRQvKQnh2f4cmUv3HpXTjegWNF0OmZe7J/LDUH9W4YeGQ+6qnU?=
 =?us-ascii?Q?7jWpTw9AOReK3gPQS3MrZqZupuOg0D+3wl4l88kXb2NqnqdJRnBPp/JsgHVd?=
 =?us-ascii?Q?NfZBo43ge7nIhwzgy5nooT1cotgh6fgjczhRTgUTGTGx3x3wOVJ3FP8rGZay?=
 =?us-ascii?Q?zFad/zXsEYbJgSvECo8XcV9n+CMTHtp5y3Q8kLyPSVC21g/MMZiKtA/1SDl4?=
 =?us-ascii?Q?ssyYxTZ2nwnjCZkb4cJPjArphkdocX+2pmaTM9qDgApdP6qutxWTkWcLZYoM?=
 =?us-ascii?Q?iPJQ9iE69rYXcAEfXhVGeBBaWp3Fc4j7V4B6znpiHUo5ZX9RmItYn1cv0idR?=
 =?us-ascii?Q?ZO6MD4ONIdSMMhiTkAwPfGXHposZ1JVBRoIW1Y94HR8sJViI64lcQrghashB?=
 =?us-ascii?Q?pajSZefk55dpQOpTPE42Fo0RnJBKGIO58Kw9wHvXXCOFmN/5Y7lY40/fRK4k?=
 =?us-ascii?Q?PjDXxTc/ky6wspqZSESLSG8wO0HYMuC6UCrm22ZaGskPvndnQu6JpmjDnrAF?=
 =?us-ascii?Q?gl+AjTRXb4mZa0GaDxrGMo+e5T2L5tmRpq1KIj4RnQ4ttZuBkO6iIBwNvKZL?=
 =?us-ascii?Q?vKaawXirWYAejPf8MkxuLwNRP7pR77FgFG+2uepvRrVUuoQcTUqOmQQxdeG0?=
 =?us-ascii?Q?9Thp9Kb42BQJQv70hfsXuSGe5OpKRU7eyNx9cKN/tfVsPooJTIzrYxoQMwhb?=
 =?us-ascii?Q?vVlml3QGvb4fv4v+6/syDcnpC6QQp5DTzdGWQ7L0D694iKcvPPPXUeFiXJpz?=
 =?us-ascii?Q?sKTBaAA0RfSu0q+9H+ToirytHMBqtLtgfUdtohJREeTNmD9sFnAH7dQax0+o?=
 =?us-ascii?Q?rwBfaVidx+aR6YkVz4dHiN5T8fnmNqzEJJyFMByUwZuUWyYVyA/p1qZrrwB+?=
 =?us-ascii?Q?r0BHDwrLEGIiVmLaOE7xDhfXB3jVOUfldILxmcB90jgrEf/+PPhH9FDjx6ik?=
 =?us-ascii?Q?rm/Xb5Mayt690rj1AtPtR9yXD961p++06fVlqKIakV10+4GeR04UklXkMvl6?=
 =?us-ascii?Q?rD2BQBUdoSLQAODFSigwQ4SLvmPu9ucUC9cUHJgT+caLHVnlWIXlCBMNBlyZ?=
 =?us-ascii?Q?IiDVhBF157xNtr/TenvVnSxSSCoVIeHdfIWmtOUbqNvNSIjCuKC7zAP8cnTH?=
 =?us-ascii?Q?i6V6TvksQXT8+HVjkS+x5ta1iTYhtFocVK9TFShhpPVVugy8PlufS+jvGpo8?=
 =?us-ascii?Q?87l0PTokT16rGTdE25ZI5MOUVfK/amQteBILM/QMZ++64Q2WA2LNyGdwdQzY?=
 =?us-ascii?Q?RgPhFRuw38vEHJYFZ2SL1Z2QwaXi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t74Pcdugpo0SAAZ6OM4x89+ajgAsok6C0g9eQDR5iyhv9QSQiHHk5LubnPH5?=
 =?us-ascii?Q?lMuWYZ9ygdx0Ij4JkK99SiC+8YYepAindfxWRHjYYbqZv7A7dSmh+LJq5nSc?=
 =?us-ascii?Q?5V4LKROANTkr9pA6Gg8ZHzXHBAiqhpLRkDm5euO5M+j2YoaQPTJm39oPSrRr?=
 =?us-ascii?Q?0tNZH49YvdevAVQzhkSSmmdVedXHNvWTzD4IipT01MGSBARBVJcU2gn1l20G?=
 =?us-ascii?Q?fj8EqYsT42TlKPAotoGfZmeafUBSZ/CY9RviE/T0KzGyyxNE6akod6rWKOw3?=
 =?us-ascii?Q?IuOP5Z6dA1Q8x5sOqH/UIsFTyyAkVi5wftuV9CkLV1eV9fbiBj+YPKBsQG+V?=
 =?us-ascii?Q?QXlLukarjMfeRR955iFgoZQLZVJDD9BuOR2LlhXBhrhki3TMLjo+zY01FIQv?=
 =?us-ascii?Q?6d7B2/BKqEAaUC9NiQIQHB6vOeYKPftuOyVNAXEaaRLNNsD01prVNqcO+INh?=
 =?us-ascii?Q?2vHzU2yTs+is5N/7YAJyArXpoLllQUJI4XtaLTHQR+2+9OyVZbb7R/Mo93zb?=
 =?us-ascii?Q?7rJOnDx8IFAO2z001FoOzJXy4ELM68VPKQLrMnfOZ+LIv+U5Eym7L999QLwt?=
 =?us-ascii?Q?Me5JAm0bPFaS+99YeTPr8pCw/qBQDLdH8uCqhoPV5n141mI9wKG9yR4yReNm?=
 =?us-ascii?Q?Jz6KnIW7OBnH3efz1yOTd0Ffj07czcDnWSIAgt/rjrVGD07k2zDYDChk5UWi?=
 =?us-ascii?Q?WA2t2zJDGVPdAb0640Dxj0e1G9OUy2lWFzUntvU/dgS1/Q/WG9MbWsL/fDF+?=
 =?us-ascii?Q?v/yFlDXWcd6TtxRWteGiVhKYUBm5f4E9cgdvnIcrUcVOxpbLcbK9Jt7qv43n?=
 =?us-ascii?Q?n3j43zokGE9HTb2dFHLdyXZ7susZqKPp2tHs/CpiFJijQSdFANK8RILsw2sG?=
 =?us-ascii?Q?Up3kNeSsKbfEEBAo2s7t8oJ47hqSdknRClEBo2fSkEEvMHhTLC+kSfRdxesn?=
 =?us-ascii?Q?layOBPcFets8OoAps9a+1lbkBX/kxFduLo0C+pdllg4et8IrYJeAAdjRZLIZ?=
 =?us-ascii?Q?WtwjzBnBM/C9Nc30rupouy6/soHZFAEqMmV6WXyXDCvqqrasmgdrO16BwXrv?=
 =?us-ascii?Q?gaa5o1OHSCoM5i/iHmgrf7arYvpA4aN1XJH+Y56ULjmvlTSTbXQo8ull2/zS?=
 =?us-ascii?Q?neXzH+iW1alwwlH8mL8IoTolMS4xD60amSspElbuF8ccc/3zQ4n0NrvDyym5?=
 =?us-ascii?Q?Qf9KSl4xDXHCfsH6gs4wpkn2fyvHzaqZNu5eojc4SMoegNoWi4YWNZGykkmt?=
 =?us-ascii?Q?BvLnXiV7Zms09Tog6+xCBYobB8CxFo9fzvhIRjaMqrTg3UqamuyMSuSriE1W?=
 =?us-ascii?Q?Mm/P7EtuaIR2XGSC3EXINwxcBvWJNTYxODY50sVZR2jOzyIk6uiTajw4SCj0?=
 =?us-ascii?Q?4+ddqpjEjmMv/ghufETP5dhG5x41psHTHd4ZQsJlo6aIR5nM2zkCve5XhejL?=
 =?us-ascii?Q?y2q6xeFNL+dUTLn2FQE5tiEHZGfOK5Yc2r26otS6xPlAn8hY1NWeDadr7kgO?=
 =?us-ascii?Q?yBBqFsws21JsjsrOTJeHJNon1y/LEpJYt0ow8oZWDglBktwjRcP2Wz63D5Km?=
 =?us-ascii?Q?0dgXPuCLzm5E5JcqtZqlO/YNqSB/05xsCa0N57xwREII3R8umNRCmeWNFoly?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0999e2-3a45-4a9f-2cab-08dd091370db
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 03:28:46.0589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRA9aXmbpPpciY2qi7cFFZUPCEroB9rqDL1J2hkYHGp0IxI0X0sQIgQ26Dlfn76cdJ4ylVlgHkQfkw0jOplSGnq+XN8SgdGBEYQCh7eKwiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7192
X-Proofpoint-GUID: hWm4N6kBmwqEBXnkGacBmUew1furaL5x
X-Authority-Analysis: v=2.4 cv=R6hRGsRX c=1 sm=1 tr=0 ts=673d5770 cx=c_pps a=o99l/OlIsmxthp48M8gYaQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=hDw6coYFGg755DguiL8A:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: hWm4N6kBmwqEBXnkGacBmUew1furaL5x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_16,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411200026

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit a2db328b0839312c169eb42746ec46fc1ab53ed2 ]

Writing 'power' and 'submit_queues' concurrently will trigger kernel
panic:

Test script:

modprobe null_blk nr_devices=0
mkdir -p /sys/kernel/config/nullb/nullb0
while true; do echo 1 > submit_queues; echo 4 > submit_queues; done &
while true; do echo 1 > power; echo 0 > power; done

Test result:

BUG: kernel NULL pointer dereference, address: 0000000000000148
Oops: 0000 [#1] PREEMPT SMP
RIP: 0010:__lock_acquire+0x41d/0x28f0
Call Trace:
 <TASK>
 lock_acquire+0x121/0x450
 down_write+0x5f/0x1d0
 simple_recursive_removal+0x12f/0x5c0
 blk_mq_debugfs_unregister_hctxs+0x7c/0x100
 blk_mq_update_nr_hw_queues+0x4a3/0x720
 nullb_update_nr_hw_queues+0x71/0xf0 [null_blk]
 nullb_device_submit_queues_store+0x79/0xf0 [null_blk]
 configfs_write_iter+0x119/0x1e0
 vfs_write+0x326/0x730
 ksys_write+0x74/0x150

This is because del_gendisk() can concurrent with
blk_mq_update_nr_hw_queues():

nullb_device_power_store	nullb_apply_submit_queues
 null_del_dev
 del_gendisk
				 nullb_update_nr_hw_queues
				  if (!dev->nullb)
				  // still set while gendisk is deleted
				   return 0
				  blk_mq_update_nr_hw_queues
 dev->nullb = NULL

Fix this problem by resuing the global mutex to protect
nullb_device_power_store() and nullb_update_nr_hw_queues() from configfs.

Fixes: 45919fbfe1c4 ("null_blk: Enable modifying 'submit_queues' after an instance has been configured")
Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs9LgsHLnjg8z06LQ3Pr5cax-+Ps+xT7AP7TPnEjStuwZA@mail.gmail.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Link: https://lore.kernel.org/r/20240523153934.1937851-1-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/block/null_blk/main.c | 40 +++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index f58778b57375..e838eed4aacf 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -392,13 +392,25 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
 static int nullb_apply_submit_queues(struct nullb_device *dev,
 				     unsigned int submit_queues)
 {
-	return nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
+	int ret;
+
+	mutex_lock(&lock);
+	ret = nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
+	mutex_unlock(&lock);
+
+	return ret;
 }
 
 static int nullb_apply_poll_queues(struct nullb_device *dev,
 				   unsigned int poll_queues)
 {
-	return nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
+	int ret;
+
+	mutex_lock(&lock);
+	ret = nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
+	mutex_unlock(&lock);
+
+	return ret;
 }
 
 NULLB_DEVICE_ATTR(size, ulong, NULL);
@@ -444,28 +456,31 @@ static ssize_t nullb_device_power_store(struct config_item *item,
 	if (ret < 0)
 		return ret;
 
+	ret = count;
+	mutex_lock(&lock);
 	if (!dev->power && newp) {
 		if (test_and_set_bit(NULLB_DEV_FL_UP, &dev->flags))
-			return count;
+			goto out;
+
 		ret = null_add_dev(dev);
 		if (ret) {
 			clear_bit(NULLB_DEV_FL_UP, &dev->flags);
-			return ret;
+			goto out;
 		}
 
 		set_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
 		dev->power = newp;
 	} else if (dev->power && !newp) {
 		if (test_and_clear_bit(NULLB_DEV_FL_UP, &dev->flags)) {
-			mutex_lock(&lock);
 			dev->power = newp;
 			null_del_dev(dev->nullb);
-			mutex_unlock(&lock);
 		}
 		clear_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
 	}
 
-	return count;
+out:
+	mutex_unlock(&lock);
+	return ret;
 }
 
 CONFIGFS_ATTR(nullb_device_, power);
@@ -2102,15 +2117,12 @@ static int null_add_dev(struct nullb_device *dev)
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
 
-	mutex_lock(&lock);
 	rv = ida_alloc(&nullb_indexes, GFP_KERNEL);
-	if (rv < 0) {
-		mutex_unlock(&lock);
+	if (rv < 0)
 		goto out_cleanup_zone;
-	}
+
 	nullb->index = rv;
 	dev->index = rv;
-	mutex_unlock(&lock);
 
 	blk_queue_logical_block_size(nullb->q, dev->blocksize);
 	blk_queue_physical_block_size(nullb->q, dev->blocksize);
@@ -2134,9 +2146,7 @@ static int null_add_dev(struct nullb_device *dev)
 	if (rv)
 		goto out_ida_free;
 
-	mutex_lock(&lock);
 	list_add_tail(&nullb->list, &nullb_list);
-	mutex_unlock(&lock);
 
 	pr_info("disk %s created\n", nullb->disk_name);
 
@@ -2185,7 +2195,9 @@ static int null_create_dev(void)
 	if (!dev)
 		return -ENOMEM;
 
+	mutex_lock(&lock);
 	ret = null_add_dev(dev);
+	mutex_unlock(&lock);
 	if (ret) {
 		null_free_dev(dev);
 		return ret;
-- 
2.43.0


