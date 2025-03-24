Return-Path: <stable+bounces-125869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B69DA6D763
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 10:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD99216EAF5
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 09:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9741025E473;
	Mon, 24 Mar 2025 09:29:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD5A25E45A
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808594; cv=fail; b=b9NvBPixYHqXDNY1DpToYWpTammjy+2fKVzrN5nu4eTU6vX3An8Fyka+WJybzdo3GJ/f7/O4SkZjjgBAUsT3YKgnHWyBPempgE7J0hSRUGySqVg3SS4i3CGp4D/2zoESwKwN39PXHgbhKzcEuq7NT+LxzIdDq148lapLS1Go3H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808594; c=relaxed/simple;
	bh=uWO2ZpNKKNp49DxT/yHQ9rksQNJb8GYDA37jdCmkmYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LC5cobu007ctK6w90/SvIMNlukZXC29QOeaPAAPhgbnMC1teUJ9XAA/9sLD4PNfzRClM2pTNZTFbxGPBBiB3q1I/pD2zXrgfxxnPXzErF5I4m+3+Ag7b7clvgkFV269AEA7Fg0QwCFVbk/m4430ioibm482imQUiEdIiu4d4ZJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O61L3j014970;
	Mon, 24 Mar 2025 09:29:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hm68hvvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 09:29:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgzMY+jUhfk0ya4AQwdHZnaJnd/OqhOCZDhpDv7dyCoEwxn9Mr6qVw49hbnBfHyYrsi2KHMK/FpPG4QKoD86p2l5ttFmmbMhw7WctdNpDHDSk9D/5zbzoR9lMSsPWIH5XH9C3sxpmAy/OTv6VmSdkpozuaLAHei0ZpU9gvjzElYTe/Nb4t6rJ54p/OUK9ddGF5ElOvwfjuyqhfh/qb90OnsJPDYziwkDzhA0hE4KvKTZicgmsJaDUqOx/YFm7Nnc5Glwwm9/nhrkgXwdKShoJvlnn9fHIE4ScdWSLkuBHUId8ctV9NOlJYuLigvOvUN5SIkrMPNJZWbJzcYBqqSPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDesCD9KlXq+zhY2aT+xb4Vcs+Vn7UbkyWxNDiouQuI=;
 b=OFn9Xp6U4YVW7/7Hw3KRG6RmoKWyWx6esi/1Mo3f8Yjhr7Tg+X3rf/szejKWuQSf8zW5MAmCwhNdIXilPpi/rhm6SnxxIpFXQ8Slp005l2DEWOwbJR4JNZZ6Y890GEmxUpwaRRyTIq/j7GvHp6c4fYxgcxwhg6C09Un89AN6r+F0n8/LK5CBqvr/8YElU1yLXs2Zs4Z433Anod9gIlpkYKaj9fJq5EPfl3dex/brpZ4rdTsSijGxCU2EViBK+Yk8rLGuToumue+Wqu7KrRjRkOEafble2opMX7XLAUkejY+cp3YLC4fYqMYRM7V0G8neJ+mmzTpk9LZw6++egImLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by BL1PR11MB6051.namprd11.prod.outlook.com (2603:10b6:208:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:29:47 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:29:47 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: vladbu@nvidia.com, saeedm@nvidia.com, roid@nvidia.com
Cc: zhe.he@windriver.com, stable@vger.kernel.org
Subject: [PATCH 5.10.y 1/1] net/mlx5e: Fix use-after-free of encap entry in neigh update handler
Date: Mon, 24 Mar 2025 17:29:33 +0800
Message-Id: <20250324092933.1008166-2-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250324092933.1008166-1-xiangyu.chen@eng.windriver.com>
References: <20250324092933.1008166-1-xiangyu.chen@eng.windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: a934105f-b72a-4974-40e8-08dd6ab66afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WiIFk9elvEqqlQNdrd7z/XGf+UXhsXw34sL/FRrqXqJazdaSwzyCTvBS1D7Q?=
 =?us-ascii?Q?UfM6HBPa1s+vQLU0WUXiAVgmL0n9/VGEG9RLJmnWX6GAkWNX7xa222a06OQM?=
 =?us-ascii?Q?hto6RPBG8QSa7hqwRkQKggdZ1shRd+Vsx5z7oQCxP+a4JkeI/Oz3zO0fu+gK?=
 =?us-ascii?Q?BjeRQHJ1t/Nq+yzp/CKaP9SH0jG5QI+ZO6vsO6B6Hc8xCwdAvu2WyXh/vBsw?=
 =?us-ascii?Q?7B+X0z1ya3QG2lZyHLW2UZdej/oYEVyZjTvIA8mXBoR7dP7eeAuIPK7XZMQQ?=
 =?us-ascii?Q?Bg4s8MMTvfOBJvtqXLmk/SpCQUEZatDR8gR/IJxLJu9NXXpUr+1O4oxVUolC?=
 =?us-ascii?Q?2ts5VTLvjnUZ69tfMQH5c1xlu+8D0+IOCN9hkiUEdZRoKvyDQzHyReMb88Cm?=
 =?us-ascii?Q?MO02rbBS7eKijDfXolS5sOmKFRYLYfAWaID20GhRcYIOpNlfL6fDYnZ/GzxW?=
 =?us-ascii?Q?Gde8EhoRietkQgy6oYnAyhkiTtqvWiGXgN/+UqAd9C2BMGlkSkWSpVX4zZ1S?=
 =?us-ascii?Q?xDC0wenY1XnsmzPW3dbQSVPdJD8W2iZX1I9r2ihV9qac1Z47RQcqec2M3erU?=
 =?us-ascii?Q?YRAk/VBm6W4b2SvycPIIFxpyuzAi+1q1d0QncZ+D1GnLul12aOMa+q/mp8Dm?=
 =?us-ascii?Q?L/GL7fE4C3hpYEcfM13GofAJLLKlK1sUa59VonZJhf+xm0Rpd+OfH8wXkPtb?=
 =?us-ascii?Q?ggoB0JSGgHB+54C9yLH4fAzTzGIakzcZ9A+dx0NANayLAGKWPsnkOjSvG61Z?=
 =?us-ascii?Q?kvUKifBsFFLnOItU6Rh++tkOLdguI1PwTvQXSgZzNRzD9uwNihtVkH5mm0al?=
 =?us-ascii?Q?JfuzMRU36zUxr4nkNkUT8Agcj3n/dKoRTuK1s+phYnuyGogweTduqRFfzHkh?=
 =?us-ascii?Q?YPYuYIF3O6UnVyV25BJFJQ7U5QLEOGiDQe5Rh76S7DK5T2BPo/DviMjKt9ur?=
 =?us-ascii?Q?1K2hSRzkYKfEAsao5MccyacX9AjdmPd8NCkCOiTktoae4tb8fZPQxzUhjVdL?=
 =?us-ascii?Q?TJmq3m+sjoUXSn3tyJVz5sYc2FTpcy233uZiJcE/o49dkz/hfDZtrJCi/9La?=
 =?us-ascii?Q?MlCBtKb3UzgdvCWVfxqOVoXUlzNfYdTFyP8ZTU/jcxpLom1OfwCdzzEH0mWE?=
 =?us-ascii?Q?FkaK2gXZV5oSaKY+fNrQu0owAJiXiXzzIOBHLCche162NLDucDrH71BQ63MQ?=
 =?us-ascii?Q?azAeYADSojm8ZiIjthqxfVB9RbMchSVGLuFD/ET1O4XcjdzgnmSH9myNWoj6?=
 =?us-ascii?Q?ErjwzcVBhNGDOcgswQ5nYkEEJsp6onYEnCvxwnkI0I5RGkgBG1T4WjYAW0Fg?=
 =?us-ascii?Q?dBwj4RMUoQLEaXDN1yyjKG2jsdxgXdOX3DIVIV8fCl52ZsdQBCV5hBDe7JI0?=
 =?us-ascii?Q?JIbZbS6vcNatlU9Y3iXbgFC9/LtCLLzAkRs+VruEJzkiKMlcYu6DIhJVZr7H?=
 =?us-ascii?Q?1d+/bGOlimNxm5x27z5/blRlLC+8x3bL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MAY4dfk8rquUrVaIayeKdhrfA/w9PSe+yftJ/eir88Dn//8wPAw4694RwQ9C?=
 =?us-ascii?Q?dHPmmjUtlyabnLyxqgTkuV0qNri4TYKYIwAdRdT4+U8oxZvnxjgOOlIEP3cV?=
 =?us-ascii?Q?7ng9//drjkwH49coGk5wWSp6D+nrxqEUpzxrM29QHFP0cgFoBt7ytGvmhgGy?=
 =?us-ascii?Q?3q6xC/1TAsfo4os+kOv4kLt2sDpCc3C3PQrMljnBG4eaXrmYaxEPC3nT8pCy?=
 =?us-ascii?Q?yCtVV8nhUjnas6jkqR6C24jGXrCFASJf3xkYheaetoPuh4arizWJCUxRoC5U?=
 =?us-ascii?Q?PTgSlMwuU2by4SF9TOwhLQ04Fdwtq/PC38bVFJe4Js8Id3+kFxWXUQyFApro?=
 =?us-ascii?Q?AxgVii1h6sNa68zG6cxDJD+9gFDDrMcDwh/cvMeKcJ5xBNM11oQquh6IRemk?=
 =?us-ascii?Q?dCdPKzuDyiVaQZc9mnaHrMLpC+XXvc1HvKX/zPvbER1bO3ASy49+YCCh59F5?=
 =?us-ascii?Q?s7aqwRjndJuDrB1eyqh06ka7zcoEsFD7sk86mWNC6IWIpUTOTtMN1rpfDy0Y?=
 =?us-ascii?Q?b/lSsiV0b5gBkgyl0gIqnNvJ7Zyv1lJt6EQzGzhvkbzO2eN2/p2Wj5Ftsmpv?=
 =?us-ascii?Q?aMwA6TseIJgyizr87talc8UobCD84LZSJtTsCxlETdr873RXU3aRdhU0Pspe?=
 =?us-ascii?Q?KB+69G/xBuUtkH4oiyZGlOCGdknUvMax3hAjmXT+sWwG8oOFsch8SAFiFs75?=
 =?us-ascii?Q?k90SkFPeYgOBEe0cTUgL2eWHUPj6GAJFwp20XfCEsgQTHlW9inHlGWqO3yOX?=
 =?us-ascii?Q?VJIJRAws81DtFfpWfqcV/TE7M8dzLYz1jQ3M7Km/I7j5B0w6Cn7QB1j2pYxh?=
 =?us-ascii?Q?NxMYdBHBpDGHYDlpMrws01j7G5jobfsoX4J/Mc/vCI8WHi4RHaL74KARH1KJ?=
 =?us-ascii?Q?eKHAGPEpcs7D4xzw+4mxmHVtCCzX7tE5yfGC8bD00s8eOeKNk6uztIkM8o21?=
 =?us-ascii?Q?EzXUGp3es/guf9etmSN//nmpeXD1XmSgbJ4I9VYgx4XNXwNzFUARNeXAOc0N?=
 =?us-ascii?Q?MCNZUFE+yHC9jfba3kcb3lYVOzVSczdiYRtqI2ZUrgNgzsb5WrRYDqNaNHae?=
 =?us-ascii?Q?KxpylgI86f/UWuKCADR0xvasfe9QySbvFM/1Vllg9exoEmn9QnHEg1s5WMeu?=
 =?us-ascii?Q?JSr/VDzyFWfxQVPgMNP0NnLWB6XDnLT98SAtkzCUjUjdoLuSUY2gObQVuJCD?=
 =?us-ascii?Q?9SLHAXrOnVUeqm3iZ3nZhPstExEjdk+/oHzw4QkPIQ+f3UeZHykrZC30Y9aX?=
 =?us-ascii?Q?T6CY/U1wGC1HC8h/LE3gRAz3wcBF16jHNrNuLjw7EYo04KlQ3iHz4TwtFUPx?=
 =?us-ascii?Q?FCm0enfT36P1qqW4HDT1iWw+khNDFj0B/FjLWGxi5V/g1t42QNC3FF4NuFYx?=
 =?us-ascii?Q?0l2MDx3APtXftaV/9MzSts5NT3gcROBVF+kabuLSzslcu/hjFTVjlVWACX3Z?=
 =?us-ascii?Q?LikaLGwleRzokEUrMwZYpL0mY2Lvv8wOCvZqQrWrGBirReg7naPYR/LGtqV1?=
 =?us-ascii?Q?T2p54F/wi9uV2pXL3picZb7ZXOuAYUHqHsWos7LzlxUXuR/bh8glIhv2JDEw?=
 =?us-ascii?Q?gtyIe/z1/9RX7qguSwnokrHzK5jJ7CLJKMsK8QK3nYgjmzCrFA+9LcRfGNov?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a934105f-b72a-4974-40e8-08dd6ab66afd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 09:29:47.0519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Krl4H+1ZfD2XUmLswW6HgFak0bcwwXBghEpZeaN7V8m4/PGuOQ62LTVVoDqbID/VnAGLVRhI2gbFYEftXehl760kIv79Elxhpax7dUbD0xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6051
X-Proofpoint-ORIG-GUID: JAtKpgzESxBUjQd_0C-hOtK_edPYQ7-R
X-Authority-Analysis: v=2.4 cv=etjfzppX c=1 sm=1 tr=0 ts=67e1260d cx=c_pps a=mEL9+5ifO1KfKUNINL6WGg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=Ikd4Dj_1AAAA:8 a=ID6ng7r3AAAA:8 a=t7CeM3EgAAAA:8 a=UGOPTdZXR8Da6ZH4CAgA:9 a=AkheI1RvQwOzcTXhi5f4:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: JAtKpgzESxBUjQd_0C-hOtK_edPYQ7-R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503240068

From: Vlad Buslov <vladbu@nvidia.com>

[ Upstream commit fb1a3132ee1ac968316e45d21a48703a6db0b6c3 ]

Function mlx5e_rep_neigh_update() wasn't updated to accommodate rtnl lock
removal from TC filter update path and properly handle concurrent encap
entry insertion/deletion which can lead to following use-after-free:

 [23827.464923] ==================================================================
 [23827.469446] BUG: KASAN: use-after-free in mlx5e_encap_take+0x72/0x140 [mlx5_core]
 [23827.470971] Read of size 4 at addr ffff8881d132228c by task kworker/u20:6/21635
 [23827.472251]
 [23827.472615] CPU: 9 PID: 21635 Comm: kworker/u20:6 Not tainted 5.13.0-rc3+ #5
 [23827.473788] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 [23827.475639] Workqueue: mlx5e mlx5e_rep_neigh_update [mlx5_core]
 [23827.476731] Call Trace:
 [23827.477260]  dump_stack+0xbb/0x107
 [23827.477906]  print_address_description.constprop.0+0x18/0x140
 [23827.478896]  ? mlx5e_encap_take+0x72/0x140 [mlx5_core]
 [23827.479879]  ? mlx5e_encap_take+0x72/0x140 [mlx5_core]
 [23827.480905]  kasan_report.cold+0x7c/0xd8
 [23827.481701]  ? mlx5e_encap_take+0x72/0x140 [mlx5_core]
 [23827.482744]  kasan_check_range+0x145/0x1a0
 [23827.493112]  mlx5e_encap_take+0x72/0x140 [mlx5_core]
 [23827.494054]  ? mlx5e_tc_tun_encap_info_equal_generic+0x140/0x140 [mlx5_core]
 [23827.495296]  mlx5e_rep_neigh_update+0x41e/0x5e0 [mlx5_core]
 [23827.496338]  ? mlx5e_rep_neigh_entry_release+0xb80/0xb80 [mlx5_core]
 [23827.497486]  ? read_word_at_a_time+0xe/0x20
 [23827.498250]  ? strscpy+0xa0/0x2a0
 [23827.498889]  process_one_work+0x8ac/0x14e0
 [23827.499638]  ? lockdep_hardirqs_on_prepare+0x400/0x400
 [23827.500537]  ? pwq_dec_nr_in_flight+0x2c0/0x2c0
 [23827.501359]  ? rwlock_bug.part.0+0x90/0x90
 [23827.502116]  worker_thread+0x53b/0x1220
 [23827.502831]  ? process_one_work+0x14e0/0x14e0
 [23827.503627]  kthread+0x328/0x3f0
 [23827.504254]  ? _raw_spin_unlock_irq+0x24/0x40
 [23827.505065]  ? __kthread_bind_mask+0x90/0x90
 [23827.505912]  ret_from_fork+0x1f/0x30
 [23827.506621]
 [23827.506987] Allocated by task 28248:
 [23827.507694]  kasan_save_stack+0x1b/0x40
 [23827.508476]  __kasan_kmalloc+0x7c/0x90
 [23827.509197]  mlx5e_attach_encap+0xde1/0x1d40 [mlx5_core]
 [23827.510194]  mlx5e_tc_add_fdb_flow+0x397/0xc40 [mlx5_core]
 [23827.511218]  __mlx5e_add_fdb_flow+0x519/0xb30 [mlx5_core]
 [23827.512234]  mlx5e_configure_flower+0x191c/0x4870 [mlx5_core]
 [23827.513298]  tc_setup_cb_add+0x1d5/0x420
 [23827.514023]  fl_hw_replace_filter+0x382/0x6a0 [cls_flower]
 [23827.514975]  fl_change+0x2ceb/0x4a51 [cls_flower]
 [23827.515821]  tc_new_tfilter+0x89a/0x2070
 [23827.516548]  rtnetlink_rcv_msg+0x644/0x8c0
 [23827.517300]  netlink_rcv_skb+0x11d/0x340
 [23827.518021]  netlink_unicast+0x42b/0x700
 [23827.518742]  netlink_sendmsg+0x743/0xc20
 [23827.519467]  sock_sendmsg+0xb2/0xe0
 [23827.520131]  ____sys_sendmsg+0x590/0x770
 [23827.520851]  ___sys_sendmsg+0xd8/0x160
 [23827.521552]  __sys_sendmsg+0xb7/0x140
 [23827.522238]  do_syscall_64+0x3a/0x70
 [23827.522907]  entry_SYSCALL_64_after_hwframe+0x44/0xae
 [23827.523797]
 [23827.524163] Freed by task 25948:
 [23827.524780]  kasan_save_stack+0x1b/0x40
 [23827.525488]  kasan_set_track+0x1c/0x30
 [23827.526187]  kasan_set_free_info+0x20/0x30
 [23827.526968]  __kasan_slab_free+0xed/0x130
 [23827.527709]  slab_free_freelist_hook+0xcf/0x1d0
 [23827.528528]  kmem_cache_free_bulk+0x33a/0x6e0
 [23827.529317]  kfree_rcu_work+0x55f/0xb70
 [23827.530024]  process_one_work+0x8ac/0x14e0
 [23827.530770]  worker_thread+0x53b/0x1220
 [23827.531480]  kthread+0x328/0x3f0
 [23827.532114]  ret_from_fork+0x1f/0x30
 [23827.532785]
 [23827.533147] Last potentially related work creation:
 [23827.534007]  kasan_save_stack+0x1b/0x40
 [23827.534710]  kasan_record_aux_stack+0xab/0xc0
 [23827.535492]  kvfree_call_rcu+0x31/0x7b0
 [23827.536206]  mlx5e_tc_del_fdb_flow+0x577/0xef0 [mlx5_core]
 [23827.537305]  mlx5e_flow_put+0x49/0x80 [mlx5_core]
 [23827.538290]  mlx5e_delete_flower+0x6d1/0xe60 [mlx5_core]
 [23827.539300]  tc_setup_cb_destroy+0x18e/0x2f0
 [23827.540144]  fl_hw_destroy_filter+0x1d2/0x310 [cls_flower]
 [23827.541148]  __fl_delete+0x4dc/0x660 [cls_flower]
 [23827.541985]  fl_delete+0x97/0x160 [cls_flower]
 [23827.542782]  tc_del_tfilter+0x7ab/0x13d0
 [23827.543503]  rtnetlink_rcv_msg+0x644/0x8c0
 [23827.544257]  netlink_rcv_skb+0x11d/0x340
 [23827.544981]  netlink_unicast+0x42b/0x700
 [23827.545700]  netlink_sendmsg+0x743/0xc20
 [23827.546424]  sock_sendmsg+0xb2/0xe0
 [23827.547084]  ____sys_sendmsg+0x590/0x770
 [23827.547850]  ___sys_sendmsg+0xd8/0x160
 [23827.548606]  __sys_sendmsg+0xb7/0x140
 [23827.549303]  do_syscall_64+0x3a/0x70
 [23827.549969]  entry_SYSCALL_64_after_hwframe+0x44/0xae
 [23827.550853]
 [23827.551217] The buggy address belongs to the object at ffff8881d1322200
 [23827.551217]  which belongs to the cache kmalloc-256 of size 256
 [23827.553341] The buggy address is located 140 bytes inside of
 [23827.553341]  256-byte region [ffff8881d1322200, ffff8881d1322300)
 [23827.555747] The buggy address belongs to the page:
 [23827.556847] page:00000000898762aa refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1d1320
 [23827.558651] head:00000000898762aa order:2 compound_mapcount:0 compound_pincount:0
 [23827.559961] flags: 0x2ffff800010200(slab|head|node=0|zone=2|lastcpupid=0x1ffff)
 [23827.561243] raw: 002ffff800010200 dead000000000100 dead000000000122 ffff888100042b40
 [23827.562653] raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
 [23827.564112] page dumped because: kasan: bad access detected
 [23827.565439]
 [23827.565932] Memory state around the buggy address:
 [23827.566917]  ffff8881d1322180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 [23827.568485]  ffff8881d1322200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 [23827.569818] >ffff8881d1322280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 [23827.571143]                       ^
 [23827.571879]  ffff8881d1322300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 [23827.573283]  ffff8881d1322380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 [23827.574654] ==================================================================

Most of the necessary logic is already correctly implemented by
mlx5e_get_next_valid_encap() helper that is used in neigh stats update
handler. Make the handler generic by renaming it to
mlx5e_get_next_matching_encap() and use callback to test whether flow is
matching instead of hardcoded check for 'valid' flag value. Implement
mlx5e_get_next_valid_encap() by calling mlx5e_get_next_matching_encap()
with callback that tests encap MLX5_ENCAP_ENTRY_VALID flag. Implement new
mlx5e_get_next_init_encap() helper by calling
mlx5e_get_next_matching_encap() with callback that tests encap completion
result to be non-error and use it in mlx5e_rep_neigh_update() to safely
iterate over nhe->encap_list.

Remove encap completion logic from mlx5e_rep_update_flows() since the encap
entries passed to this function are already guaranteed to be properly
initialized by similar code in mlx5e_get_next_init_encap().

Fixes: 2a1f1768fa17 ("net/mlx5e: Refactor neigh update for concurrent execution")
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
[ since kernel 5.10 doesn't have commit 0d9f96471493
("net/mlx5e: Extract tc tunnel encap/decap code to dedicated file")
which moved encap/decap from en_tc.c to tc_tun_encap.c, so backport and
move the additional functions to en_tc.c instead of tc_tun_encap.c ]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 .../mellanox/mlx5/core/en/rep/neigh.c         | 15 ++++-----
 .../ethernet/mellanox/mlx5/core/en/rep/tc.c   |  6 +---
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 33 +++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en_tc.h   |  3 ++
 4 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
index 58e27038c947..bbc182e9e535 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
@@ -129,9 +129,8 @@ static void mlx5e_rep_neigh_update(struct work_struct *work)
 							     work);
 	struct mlx5e_neigh_hash_entry *nhe = update_work->nhe;
 	struct neighbour *n = update_work->n;
-	struct mlx5e_encap_entry *e;
+	struct mlx5e_encap_entry *e = NULL;
 	unsigned char ha[ETH_ALEN];
-	struct mlx5e_priv *priv;
 	bool neigh_connected;
 	u8 nud_state, dead;
 
@@ -152,14 +151,12 @@ static void mlx5e_rep_neigh_update(struct work_struct *work)
 
 	trace_mlx5e_rep_neigh_update(nhe, ha, neigh_connected);
 
-	list_for_each_entry(e, &nhe->encap_list, encap_list) {
-		if (!mlx5e_encap_take(e))
-			continue;
+	/* mlx5e_get_next_init_encap() releases previous encap before returning
+	 * the next one.
+	 */
+	while ((e = mlx5e_get_next_init_encap(nhe, e)) != NULL)
+		mlx5e_rep_update_flows(netdev_priv(e->out_dev), e, neigh_connected, ha);
 
-		priv = netdev_priv(e->out_dev);
-		mlx5e_rep_update_flows(priv, e, neigh_connected, ha);
-		mlx5e_encap_put(priv, e);
-	}
 	rtnl_unlock();
 	mlx5e_release_neigh_update_work(update_work);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c
index 2fdea05eec1d..552c07e52682 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c
@@ -91,13 +91,9 @@ void mlx5e_rep_update_flows(struct mlx5e_priv *priv,
 
 	ASSERT_RTNL();
 
-	/* wait for encap to be fully initialized */
-	wait_for_completion(&e->res_ready);
-
 	mutex_lock(&esw->offloads.encap_tbl_lock);
 	encap_connected = !!(e->flags & MLX5_ENCAP_ENTRY_VALID);
-	if (e->compl_result < 0 || (encap_connected == neigh_connected &&
-				    ether_addr_equal(e->h_dest, ha)))
+	if (encap_connected == neigh_connected && ether_addr_equal(e->h_dest, ha))
 		goto unlock;
 
 	mlx5e_take_all_encap_flows(e, &flow_list);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index c6a81a51530d..6b4e028de9bf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1653,9 +1653,12 @@ void mlx5e_put_encap_flow_list(struct mlx5e_priv *priv, struct list_head *flow_l
 		mlx5e_flow_put(priv, flow);
 }
 
+typedef bool (match_cb)(struct mlx5e_encap_entry *);
+
 static struct mlx5e_encap_entry *
-mlx5e_get_next_valid_encap(struct mlx5e_neigh_hash_entry *nhe,
-			   struct mlx5e_encap_entry *e)
+mlx5e_get_next_matching_encap(struct mlx5e_neigh_hash_entry *nhe,
+			   struct mlx5e_encap_entry *e,
+			   match_cb match)
 {
 	struct mlx5e_encap_entry *next = NULL;
 
@@ -1690,7 +1693,7 @@ mlx5e_get_next_valid_encap(struct mlx5e_neigh_hash_entry *nhe,
 	/* wait for encap to be fully initialized */
 	wait_for_completion(&next->res_ready);
 	/* continue searching if encap entry is not in valid state after completion */
-	if (!(next->flags & MLX5_ENCAP_ENTRY_VALID)) {
+	if (!match(next)) {
 		e = next;
 		goto retry;
 	}
@@ -1698,6 +1701,30 @@ mlx5e_get_next_valid_encap(struct mlx5e_neigh_hash_entry *nhe,
 	return next;
 }
 
+static bool mlx5e_encap_valid(struct mlx5e_encap_entry *e)
+{
+	return e->flags & MLX5_ENCAP_ENTRY_VALID;
+}
+
+static struct mlx5e_encap_entry *
+mlx5e_get_next_valid_encap(struct mlx5e_neigh_hash_entry *nhe,
+			   struct mlx5e_encap_entry *e)
+{
+	return mlx5e_get_next_matching_encap(nhe, e, mlx5e_encap_valid);
+}
+
+static bool mlx5e_encap_initialized(struct mlx5e_encap_entry *e)
+{
+	return e->compl_result >= 0;
+}
+
+struct mlx5e_encap_entry *
+mlx5e_get_next_init_encap(struct mlx5e_neigh_hash_entry *nhe,
+			  struct mlx5e_encap_entry *e)
+{
+	return mlx5e_get_next_matching_encap(nhe, e, mlx5e_encap_initialized);
+}
+
 void mlx5e_tc_update_neigh_used_value(struct mlx5e_neigh_hash_entry *nhe)
 {
 	struct mlx5e_neigh *m_neigh = &nhe->m_neigh;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
index 4a2ce241522e..e7e5f0c080fb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
@@ -161,6 +161,9 @@ void mlx5e_take_all_encap_flows(struct mlx5e_encap_entry *e, struct list_head *f
 void mlx5e_put_encap_flow_list(struct mlx5e_priv *priv, struct list_head *flow_list);
 
 struct mlx5e_neigh_hash_entry;
+struct mlx5e_encap_entry *
+mlx5e_get_next_init_encap(struct mlx5e_neigh_hash_entry *nhe,
+			  struct mlx5e_encap_entry *e);
 void mlx5e_tc_update_neigh_used_value(struct mlx5e_neigh_hash_entry *nhe);
 
 void mlx5e_tc_reoffload_flows_work(struct work_struct *work);
-- 
2.25.1


