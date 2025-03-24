Return-Path: <stable+bounces-125868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE34A6D762
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 10:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1012916F057
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 09:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA93E25E470;
	Mon, 24 Mar 2025 09:29:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E303325E45A
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808591; cv=fail; b=Ya9s4zd/ipDKjt70yKiwko6HmX/SGWuCcYN27/VFK7ZVYLB57hVonfu8nEVYSgK6DtsXeHKX5hQEPiDQvP8sNkR1eYEzc7NIy8whE+aPzrNiyyw+enKb67/Mbhoj9AemqbToTeUb+U84dxKekRNJoRsGRsG5idYdZnWQw1d2sSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808591; c=relaxed/simple;
	bh=j2iaFmJuh93YCdGCPIVwkuXX8DXnoXR2Wr1AmHsZMNk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=C86EVc50/H7/4kZkk2sG69OzjwopF3XQjZFXaAo3UlGcRMLGjySELDe+s7sYWaseUheYx4p6WF8pabPhthGlGNXWwkHkhrdfggML4sxGP8r8S3tl7SFwYrXro9e0vZORO/MWxp5izpqy/tUnw3G8OO88XQQ/cO0v1hkkZS/gXts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O5Z8bi014216;
	Mon, 24 Mar 2025 02:29:47 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hrg41qrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 02:29:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDJ3TsHLZB4hNXF1dQdnwBQT0qCCGXe08HeJPAEFntSF2exm0BJ/9WQDq4qx37dKONAywWmMZXgiCiuGS/7rMlDqDSvNCU9GkMm9ztHSka1Pi/JsYWaUfM8wgVRCJ2sH8wSgtSceCZxoRpWNcK4LirLRz3HP3YF19PWWjovQAS/oFjlqMhOnl4GfxUFwQNjgeHao6t1ujYraQ8EuNjoJbWX7zdsqPSzIs9hmvIjY4zhCllceSZfjJTizaCSDP3HD6vsD6vnEn+v/aeZPMEJG7p0wchEGU+p3P/lBA9SxJTRkdFjW7ZzerHPF5/tik4AD9ofj3oIQ3j6PUU9hRo0BrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSvXVptuWyybjRcs1TZUEZH5czDQT5Y/SJagnu+yai4=;
 b=sFH/4QFUj5Q//1xKivTt+YNWRFoanc5oje5Mfiq2/OWh2B97ZEErAlgM8cM2XgVSsV9DwQTwqDHjQuUIzrYhtDUpztQCwbhljJqbbhBweUYDKYpeOhtxr40Cv19MS1Bm8ZQDWF14tG0W7nI5uw7L5zefICnOxqXXyEyE3zahacs6grflSa6y8OnjVLprjFiK3mgSRLe4DthEcf/9VKljPeeQAb75ZLqAWSB0wol6jocWdiKuUJyXAnUUs1JRybisLcnvR+TsS489uPb75CJJBuqrKchIhu3V7Hw23jJbUGHGUf52FCo5efME1P4MXRYiZ5jvk4rwZ6FFLTRNAci8Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by BL1PR11MB6051.namprd11.prod.outlook.com (2603:10b6:208:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:29:45 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:29:44 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: vladbu@nvidia.com, saeedm@nvidia.com, roid@nvidia.com
Cc: zhe.he@windriver.com, stable@vger.kernel.org
Subject: [PATCH 5.10.y 0/1] Try to backport patch to fix CVE-2021-47247 on 5.10
Date: Mon, 24 Mar 2025 17:29:32 +0800
Message-Id: <20250324092933.1008166-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|BL1PR11MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 52651d98-e011-4fee-b3f1-08dd6ab669a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZJnHrYkUv2eNgK2K36VSMqNyvg43lGmcVIKdeggVTvTL7OHhQBFbpkGE3Sdy?=
 =?us-ascii?Q?Swd2L9AFwrsd3zXDGl0slrBLJD8bEwCs0BdZqSnlAje6Bg6uu/St4tjg+Be5?=
 =?us-ascii?Q?vTiopJtKhjfOkhLce0K1oT3bfy2gQ0VgCTzYxR4hwf0nbPs6F6oMcHUIzkeP?=
 =?us-ascii?Q?EvUPQ4iECOv8lJpHfpIby2nEz/rEmebV23zInBUGIuixV5M+GjADEVQ6Hsgx?=
 =?us-ascii?Q?j7q/v7konmCz/nvBqVmmN3oVQyl/Rqz2NpPxlq90sZTv3WwvZ7+TRoiV3yBy?=
 =?us-ascii?Q?FS3lSa28MawKECae/pphL4RdPxif5OAmai0ZjDl5TU3JRqVgDvUyMTO/XLtd?=
 =?us-ascii?Q?rsYQFttlOCkBFJgpRIPHWXYVYi/Gpvx0C9eTcbfdqE4uAoF83JN5wkOh/VMa?=
 =?us-ascii?Q?8JhLFQJi4i0VIff3rM7D7s4cpHkf3L/fxhgHwf5U/RcXdyEvVxUUX5Rt4bAD?=
 =?us-ascii?Q?Dx1uTWevgADXkjAbSnvn8R1p7F1l3lL5HPdv1/pAfwcRPwxNX5MhxUAOEuCh?=
 =?us-ascii?Q?/J7B7tPdpgp6oZNRTvlgTK6Qu+abU7TZL9/e1WAFN3DZVjHJdxu53KfQ8ja/?=
 =?us-ascii?Q?wRPy8iyEncYWhST1+isXb8o5tNi5oVXzkN8C7K15ivUZ4HjWFi6KdwvHVeiY?=
 =?us-ascii?Q?GD6i5iTbC9SxRM8nIscPmEmkrB0pzL9ZxZnt9jIBpfTD0IljZlej4CvZ34qs?=
 =?us-ascii?Q?CJkyPRIZRV9xssEfZ0O6iLz907XLPCSGL1PHaDxfaYZsor8tRhBUbxDrqhX+?=
 =?us-ascii?Q?3jAMHV6LNtEMsKtRYHoRUx3rcx7IvdeWxOUYbw3W4UYUeQX4RaY5U7qlG8LC?=
 =?us-ascii?Q?SqooIM/lSyZuIjrF8zMDc+F+pRR171m5+v0f7MwUcfhMxQRxgWwIJ4vEbjsx?=
 =?us-ascii?Q?xk5U/1p43JUlqM8vBw3pGmKStmChbfV9pZL6cJUIsfCm6lbp6u1wL+pvnM3e?=
 =?us-ascii?Q?zA3+4QlP4/sciQpAPnwcxm0NSdc4rVQrU4PoL5qYbEjLYODS2OvPVL2DJpYE?=
 =?us-ascii?Q?PGU8mKn7gjyruXaLibzfrMH2Iv+BhHo5JVwpWWp13XEyc37D1B2wrpOjkOrG?=
 =?us-ascii?Q?mVLA5MXXoQtd5/tIUgYpDJ2hIDpq7NawNY6Ae/INThhcHM41S5KcgisB2QF3?=
 =?us-ascii?Q?b+VeSvrVmUXpwbDpfEGgMKLFOxuNElKTuxkeIJ8P6lOabsbf0Vsj2h8r3NWB?=
 =?us-ascii?Q?hjkflICmuuHkCDA479xWLT5VQlQzdJCiJ4Zh6q/hV2xzqoj9BqbQnVdP/FeB?=
 =?us-ascii?Q?vQlG9meSjKQsoK3gI2COQG7x5aVfcCV2/Ojk5T3FasyfPl7iUPjaDyUnNmEe?=
 =?us-ascii?Q?DY4jML2HFNov4GfNKJ8idsBZEELgeZ57jfPC0w+bcK3QPgAqgRMslH36+NyA?=
 =?us-ascii?Q?VBM818EL1YqxetGBUXc723oQmv+uc6xZX/NRGERzssZC4IqbwpENdIPHiE4l?=
 =?us-ascii?Q?SZy1KNJd5q5S9Suux5GHYaLjDfMq1VM7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rw/Cd/SqWUXAiG4ULmF7vLzSxCLRHDGVrboZAK75T7x5xVrT81REmat+8uaP?=
 =?us-ascii?Q?Eb1+XJz7W2A3dJo3bluAa8G11qcfWdejXC97ZhhBtDCyXiN60/zIWBMEG+d1?=
 =?us-ascii?Q?40Ce+0YBwx8zKZAyXPSRnKOQVriTjUBOxjeT2SLAljDh2jpyILK9f8lb3ZJ5?=
 =?us-ascii?Q?yYR5KBcoQ4I0YZ7ydeGSbeNGioay2ZpOsdCn105e3HMypxWRWoToVnFlVFDX?=
 =?us-ascii?Q?Sy/nbJV/urwsJ8c3jMA9Tg14COyA9c3lZAtYc0ipWkOW/ZOGMUl2NnAa808o?=
 =?us-ascii?Q?5oKFaqGe0V1pQc0PbKRQ+dj1IO9z8VnBSyYvhjMevd/cxyjyiQwa5+gzK383?=
 =?us-ascii?Q?ccwvHyV0aVZEq8h1DThfCyf5QcEWvB4F2g0auajYpftzq7DyslDggTKJkxli?=
 =?us-ascii?Q?FqHgwLUlxaYbODu0EkdRS9jhOgI5M1e0soBodjDLhen83+w0FqTUwWdzqP0e?=
 =?us-ascii?Q?kUgZo1rSQjKAuILqY3K9vLOFjErnLHN4xXDF2XCSocT+cS8Sc3LsKXMPHzvb?=
 =?us-ascii?Q?T72A8iRmDSPdLBVbF7XgebuHsSIya5fZDFrv/+jvy5SbjbmJ/elSbixN2tRp?=
 =?us-ascii?Q?zzzFoc+GF6jSa2GUtLQvL8J4UXMaDUq5Fj7v1Ra+oXVJsPkqhBO0XDkKLsko?=
 =?us-ascii?Q?U03ODSynExdTeYLHCRnDBbbYZXriGX1xr+baApofcOhZWx4m2ot52aDKwlNa?=
 =?us-ascii?Q?jnwOHIITwZK1Du/8zlELCGJu/HaWeJJBP8jj/rAGt6hAe9MrldVFHHriyssL?=
 =?us-ascii?Q?bENaMI6ROzwdTr5mFeM46f/7zY9L6h0BJScmeeVUxbwcvscmgi6C/+pjQpLf?=
 =?us-ascii?Q?1b5QG1cp9cIIRrlp9yxmOuGg1LMQ/A6S30Oh581qw+t4BvNLcCMarwxcVtXZ?=
 =?us-ascii?Q?Z/YO3pEBdS4ouNldyXmqt3dZsIc7V/PD1J2mNR4uImzkl3QFcKSOewL+N6Pd?=
 =?us-ascii?Q?hl3LCI7l5I0L9s2NI/9IRNnwKqPnsfPN7x0EEBTZCKnVAtZ2OwCLj9MFDwEH?=
 =?us-ascii?Q?VWe54wwWHmdJRMZjuL3oeWbyJsKqBfx7jWexMwAVAHnQSJl6IBOSH9/tOVH3?=
 =?us-ascii?Q?7+IVRlEq+iYbwsjQ0RtFQx9qpSke7kEXdr2BaKpzWSYNdf0SHa3ISFx07u3u?=
 =?us-ascii?Q?0v7JKVZHgEky+fdhk2TfumWc2VEsifxO9hRWFJDgjDtktsBfe0wb9SnDnRqT?=
 =?us-ascii?Q?pdYYxWJKYYA0i33ZrOzhw09Uz6qX1AApk0EaFpo2qrb46RNOnuNw7lfcm0kc?=
 =?us-ascii?Q?l9wqv/b+tDo9pTTNmuZwsCsUvMnrHvVPp3YDK4IPGG3dKaj1+c90bsAwnzRG?=
 =?us-ascii?Q?AR1uGljVq3jrW8EUH7IpN7aPXxUvJIej0AZuaRDiyEdPfjr1sfP+fJ/Uk4Gh?=
 =?us-ascii?Q?whefh5agA/iAr3S/WKBuaYj3m1szgH3d2xirfgNM6m20mAjuDgn/DX+1wVbz?=
 =?us-ascii?Q?GEPkYdBRjf6NjgqWIr2wFZ8G08QaSbID8/3VW/UYD9opU+kocMfhnRi2a50U?=
 =?us-ascii?Q?kQrAX7t9/btU/1+2FJEF6XMWoaVT8VmJomgLpCPnmgfasdb7uRC7EcBDSnmz?=
 =?us-ascii?Q?jZR2ExcujyWfKAED6N/+crnh4nHGSCY7h/+GxJVWQrohCmd/+kYlekU+5i+n?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52651d98-e011-4fee-b3f1-08dd6ab669a1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 09:29:44.8495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vaKLWPu76ntjXkUXlxGgxn9cIsv82uV1fkQ+2BV6dt9u1IIP9slQXBM+SYCj8SE4h7JpZMw6CCeiGiLo0HPycrP08aYURWIqwg5ZtCM2B8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6051
X-Authority-Analysis: v=2.4 cv=HZwUTjE8 c=1 sm=1 tr=0 ts=67e1260b cx=c_pps a=di3315gfm3qlniCp1Rh91A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=t7CeM3EgAAAA:8 a=0wk2RGBofUerO7qkjvAA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: KrZtWog3hiQPzOPJYrrTbHZK48pCG763
X-Proofpoint-ORIG-GUID: KrZtWog3hiQPzOPJYrrTbHZK48pCG763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1011 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=780 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503240068

From: Xiangyu Chen <xiangyu.chen@windriver.com>

Try to backport commit fb1a3132ee1a ("net/mlx5e: Fix use-after-free of encap entry in neigh update handler")
to linux 5.10.y branch to fix CVE-2021-47247.

This commit modified the orginal commit due to kernel 5.10 doesn't have the 
commit 0d9f96471493 ("net/mlx5e: Extract tc tunnel encap/decap code to dedicated file")
which moved encap/decap from en_tc.c to tc_tun_encap.c, so backport and move the 
additional functions to en_tc.c instead of tc_tun_encap.c

Vlad Buslov (1):
  net/mlx5e: Fix use-after-free of encap entry in neigh update handler

 .../mellanox/mlx5/core/en/rep/neigh.c         | 15 ++++-----
 .../ethernet/mellanox/mlx5/core/en/rep/tc.c   |  6 +---
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 33 +++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en_tc.h   |  3 ++
 4 files changed, 40 insertions(+), 17 deletions(-)

-- 
2.25.1


