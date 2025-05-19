Return-Path: <stable+bounces-144724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FD5ABB2CA
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 03:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA943B34C8
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 01:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4714B1E72;
	Mon, 19 May 2025 01:17:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9787F2CA6
	for <stable@vger.kernel.org>; Mon, 19 May 2025 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747617460; cv=fail; b=ZT5UG//ohDA+7A/Bgen2lCH/1PSJbyQ3jQ2mzVPmSVKZDFCMRC2xa0a4kUvmuucGYMDIfv//CEQiWC5/iSxWmaxtcQsjdW1OtFbjRQqp897QIYxDw2t3r5aNwBUNyLAsC0sZzGve8Hxi/P6O7Aegl38H/JxA0J9O4D4l9vqW5Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747617460; c=relaxed/simple;
	bh=Oq20+mVNQgKPuKvFenFSEXIecwIr0GpYEU4Dfhly52M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UbhDad0VUCo/QGHtP7n3XaT1oPCV/2cKURC8TCz4S4TvjGNJg+rOPjkSahL55ucIjOLqbW6WyGbS5Aw69r8rZrhH/E9s/TrQIeM3JVB3vgkFna+jKCrojmDbxtQKsw8kZXGSbrgBIar23ch1WfQxGJS0zGKjCTMY291e52zRa/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J0j3Bf028298;
	Sun, 18 May 2025 18:17:21 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46psykh3k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 18:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Imcxz8POazpoVjaTvxaHNVHZRlWf8hg24Uq64B0pZ6NrY9cMDZAXNb0eow1y0I7DlCXfcz//mJ0AW9HIl3idILs/kUN6kXlb7nJlSYsiH95MUztCKyUaGKUFdu2u/QGEoY4R7DaPIXYFLhMd5D/u+QFZs8UigXE6UhKXQrgTYdiSg2V9IGezSyRQMqHBQfSbZQAvxbPXcbj0C0QgqWjgeLguQaLXP8HN+StouL/YcvMrccBFhLBsTbRGg97ueokjlfkzmt65Q2gpXchD48M2j26ldfXCADct9fKASTpNUfZ00hHncr21LgK9V+WTcp69maJLNcrEGg3hyHela9Mwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvJC6cZhZWaosVS0w3QjSQ5E6StS+4q+V1NNGMy+lk0=;
 b=bw6gowqyGgXbqeFuAcdI1qbk5sXxw882SWgsCKEQR+7lTOMhjPB/ZAKEiMK5fEU+cwru1AYoCaVChIKAVz59c1oPYCZFaMFZAY/REN9tqAzsIMSZM78pZccEvXFeu4hGaXPQfdN9N21lCeOfAxSY93dM3Yp87aHblOjQbbhDeUNGZi0F4fC0P+rh29YECiZLbZ9U0KLWgsanEgO4UMco0yNJzNKsl9onLBKRhrKdn8PCmQklqwGRxMI3ODcmq/xY6lyJLeThRcYEhZuSc1VvyP9iRMFsnfcHnun+2Uo9xr0xljoRIcqNJXHRlxfbBSvs3SQcoyJaUoBvA2/YVgnqKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7)
 by SJ1PR11MB6130.namprd11.prod.outlook.com (2603:10b6:a03:45f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 19 May
 2025 01:17:15 +0000
Received: from IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4]) by IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4%5]) with mapi id 15.20.8722.031; Mon, 19 May 2025
 01:17:12 +0000
From: Feng Liu <Feng.Liu3@windriver.com>
To: dmitry.baryshkov@linaro.org, srinivas.kandagatla@linaro.org,
        sboyd@kernel.org, broonie@kernel.org, Zhe.He@windriver.com,
        Feng.Liu3@windriver.com
Cc: stable@vger.kernel.org
Subject: [PATCH 5.10.y] ASoC: q6afe-clocks: fix reprobing of the driver
Date: Mon, 19 May 2025 09:16:58 +0800
Message-Id: <20250519011658.3642339-1-Feng.Liu3@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0189.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::14) To IA1PR11MB7174.namprd11.prod.outlook.com
 (2603:10b6:208:41a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7174:EE_|SJ1PR11MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d797071-0b42-4a9f-6757-08dd9672e22a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2WZsDHUITssmkfdl3B5qmjmj+8zuqqm5A9jmELoDyX29CP8OyXT5AuhEQrJa?=
 =?us-ascii?Q?wiGiE8ToHqi1ocudhqRpnlj8PJsNlXjgNH3SuyoRrKzXfV8kDMvroZQsnEus?=
 =?us-ascii?Q?xLQq32HOqVRTjChSnlKCmgMHn7OJZpYU8YvttVmmaMuya0JVuQefCL31F0W/?=
 =?us-ascii?Q?759qkaBpOSKb7//YQe2x4XeC0/gI8q0ncZCDi0p7ayF+9AwBnc0IbhCNMRoN?=
 =?us-ascii?Q?Ju5fsD12jwLQHPo6vwloYxW1Eq+gihfnpoW5QdSMc9oyr96Vb51J9puyj3xU?=
 =?us-ascii?Q?IrworRg3Z7AICXiX1+sAlsvf9I483RZ8ALzkXdjOPGKmfwNnmxtOlrIYArWZ?=
 =?us-ascii?Q?uMN4ItLYgKyGL9ZeWAeHi9STn4iCSpEl/1JpnxgPf1OmdTkiiPKL0Kgc4T0q?=
 =?us-ascii?Q?kL6i+ZHU87xMCosD/ImqxO/wuBo9nZfSTRDp8UGFz8lOKsUrKDaauyxNDe7X?=
 =?us-ascii?Q?Vf6FjE++tnD4heNXbIPWhHQ7BfinFYAF980BJHLhBItYB30zDl/mtQIvvT2x?=
 =?us-ascii?Q?0IzxstdDGtGBZSiYW5nFn32GBSxsgLIIwVsdrmQ4+NF2YUBPtYIb68LV1ky4?=
 =?us-ascii?Q?gkg6zTOQmjJj1WpXCLg6EO5G0A0KaeWn6yPOexh4OiUq/ZBDP0eHXCjzGTyU?=
 =?us-ascii?Q?akmxlYfdgxrTA8mYHrV8PvDjYEQq+Fs9SjqxFdBTdgn/bFmfQ755iFkuvowN?=
 =?us-ascii?Q?htfNKiOw8Or4AxBsIzFYfZtm57B1y3BF2XErKZa0H6QKL1pPy4UFaMIbZo4d?=
 =?us-ascii?Q?tm3MyTi/5s2DsvbKhix2eyMC+deOY6y2IUJee9o/HWfCh8KGirxcERDyyBJZ?=
 =?us-ascii?Q?s+1i62XbPUPWU1mXc2OjtiKayul/vt9tnzBVcMeBX5fwU4zSXqR8sZYh7dr0?=
 =?us-ascii?Q?jM/36VjAfsKkZZzPUuhB8tBrVFwAKrbXHbLP/O9fuNK1HqOq0GssnaLJUi39?=
 =?us-ascii?Q?DiJtGKI0UEIE1VhTK7LyFQbJZEwN+WX/KKv6WqxZ7v3xythwPvNEH4rDfMjW?=
 =?us-ascii?Q?iwOM/mhD5uV92VLG+DRaBClTQIXoZcyvDqAGoPw2Hzn9mqJCfvWUUVDs9UXF?=
 =?us-ascii?Q?MysjP91vL60aR9nSRYbeDHa11jXu/FBK3X2DsW+Toa3XUPdTA5K87nHHNndE?=
 =?us-ascii?Q?pL5EvhbUT2LVP5beGCl/Gw4Ye6eybftHWSZrlU8BT9PkEvRM9HxJ7tyRvNTr?=
 =?us-ascii?Q?ZLL4+MikHnlvbDd5Lif9TRhlIMoInbsJU3+QBWhrXT6JtI4vpTpioBAjlmpU?=
 =?us-ascii?Q?MymbW0OPITpFZa1EFKLUgAYE0owcXv+sRvZNG/EU2mdRngsIJ+zUts6GBNTk?=
 =?us-ascii?Q?FtBTHR9qpQXq2I/rpPu+CSw5LWXzXdGqlFqzTM222iBPPlViFQuHxgWFR3Qo?=
 =?us-ascii?Q?pMKJ1lWxyc83XrPwy507TFTz39LNpAV+jlOBACpxcOtiK9nEhZnHwv/4BuOt?=
 =?us-ascii?Q?JvcMjkPEoc3ZmUtegJFCD/1FjFf80095qhuOeMKamEt55xXA1K6vrOUYxlWa?=
 =?us-ascii?Q?zZN5rb6D7acTFh0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7174.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q8wKaG7/rQn4qvDdhL/1wwevyMYHeEitfPHZ4Bwcu7G6pl1HgruNlPxChtpn?=
 =?us-ascii?Q?VWyeowrpEj2vTrvl4ccDOo5wAGNREtIuNLJFyR/8CjiyJuRJ7nvIUsntDklT?=
 =?us-ascii?Q?kJwDjyfdB4fa4GaUUp/hTa21CLMyN9rcpPPUc4x+v29TmFNxbD135TT4KZs5?=
 =?us-ascii?Q?VOCIlAc3LnPnFDxVovG+ckFayKEJwfEeXKjyb2sSXpxOTtRbE8aIMf+YNFHn?=
 =?us-ascii?Q?zjMambWTK7iQDaat8Qwrx/9MYPeP+bJpV4WedLMiiY+LOMkJ4eBwdTzK0u2I?=
 =?us-ascii?Q?RWH2ZmHwUhrKDgbW2xHEpX5F9FLN/407gPiiBq/gzZZzADg/xkXU/kHAgB3M?=
 =?us-ascii?Q?r3saOM/kMpLwMJdzFBoE1J19DrLAeO86dZkQ0/RhC2ughUv3mWanDO+vDuZg?=
 =?us-ascii?Q?OPmBFZe9VKHR6EULSELdUIDAec6Hp2fhIp4GdeWL9Z/yWO+oZLsmW0Y3/jwf?=
 =?us-ascii?Q?tU1v/irYT/GRa5q2aR9vbjch3wt13Z89d7qmcgSEhO/tkiXqjSHDkTntZWAS?=
 =?us-ascii?Q?doHj2Ka0Nf00dDbCLcPNL9QeY581byuoSLKc/H8S63eBcecDi/ULV0b46Kwf?=
 =?us-ascii?Q?6cyjm2G9nKgdH/JN3NahDU805kEFQ6fuhIu1Houo/+TlFHqG58neemilK5px?=
 =?us-ascii?Q?T0nqyJkOO2Nipdo7EshVaNgVkfHsvmvnr8LoZpCxvsbm+NhV7dCTPQhxhR3D?=
 =?us-ascii?Q?nkl0QwOOzwmQX8eT5qRtZ9AVaxZwUt9zL6SlajyVfpiCwdBQIyKCmK19HrLY?=
 =?us-ascii?Q?CMS9VHdcdPstH0uMVttrtjqwcPAJlspN09DhFzfrOEP55HcdZs6o2wDdE6x4?=
 =?us-ascii?Q?sJZNnCdA+JWD6uhZ6EahC4AX9agQF/sHcV8+5yso9ubpIi1R27HHBWPIVXUQ?=
 =?us-ascii?Q?SCZmIgWdkbZl5W1LLqTu2klCtqF/jnfsCpN6q4nwefEH7y5IJrdEnjjyBBt6?=
 =?us-ascii?Q?hfX9MUT2OgKI5C3FQRLrDkJ3MJcd9oHVM67CQGyBYoHicfxWLelQxeJDWpxN?=
 =?us-ascii?Q?ukpDnfUHwa46c53uYPPkSXDxhHvkpt2f5Kx18DbC4GuNlNz9C4RXzlxB7w2m?=
 =?us-ascii?Q?1ZJlmo/lvP7zXyiPfygarAorz98fDb1suTk6m10t6avoG1yR8Kd+Kzyp2enV?=
 =?us-ascii?Q?pu8TWUAqE09V7+VK4p2cNuO+W3HdsLmIYIeQSFavCQXYh+c1QWlMe2oun8jU?=
 =?us-ascii?Q?ObYV1zV3ha14gljiZgVWuusrkm75/MIF7KEt6RI0jeC3rqH469QiEuVXbjvo?=
 =?us-ascii?Q?DVqmkhnsRUb9Z4Pm5tySB6oNdi8c/o24mqFvN/1vCxiG89kWxW3cVToVIwLz?=
 =?us-ascii?Q?kbHJjKIpKh/VcKWzPVxP0McKmImXCz7vdzVSGWjqj5cG0tzIAKPA3GVLutQw?=
 =?us-ascii?Q?GvUby/LRyJDDG7g6SoBfQxfHLmQNB09kvMf3y76XJnVq9xg4ijhE9tV0FoDt?=
 =?us-ascii?Q?PbkN28pnebXjcuGeYzOz3jQjvoNkrvu/yyQZ5cYfY7x8trcDWQKVp1NC6KaZ?=
 =?us-ascii?Q?ecnPGXjYmSgazSTtbSv8EpAnxWLK/Uxyse+flFeUVHvLW4lEkwkhFmNymuYe?=
 =?us-ascii?Q?4XW7qtZShuT/1/muypRVsD7hmNFNqqr5vB2pRM43?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d797071-0b42-4a9f-6757-08dd9672e22a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7174.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 01:17:12.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jw9JUqvvpxWZ1FufBienhKl76Exf0nY8cIPHqCHsFs3AoKL1TEP8dh1akxoBJG3dygoCbcxQXFeT0hnPTo30lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6130
X-Authority-Analysis: v=2.4 cv=a8kw9VSF c=1 sm=1 tr=0 ts=682a86a1 cx=c_pps a=S2IcI55zTQM2EKrhu3zyRw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=t7CeM3EgAAAA:8 a=IYtqZXSvkW_t-lYs0WcA:9 a=cvBusfyB2V15izCimMoJ:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: y94X1vZnbTgfn-WgV-w_z-qOn1I1QLxT
X-Proofpoint-ORIG-GUID: y94X1vZnbTgfn-WgV-w_z-qOn1I1QLxT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDAwOSBTYWx0ZWRfX99vIA5iYPZiu x2rBIm841R8vE2ewd8/oRJHhf2FEEXwu5OCWFycCKT5HXkAPK4JE1zXqT4X2hb0l6Bbrguh23Vx +KiQ8eqzJ83UD8yBBhx6ae0oA76zKmI8EuHlqqgighjfh08b4+VXMxoITMwpjBqxtnSqQ65vs0m
 uNj9pkYzuZBgpBqhyE+gV8vvSIZJeQlndejOEF15q1BGreEq3oPIIcgVk+moSP8GNnXk3a3V6t7 WroW7ziYlvaArHMcaSJCO0n63UjuiHZYQJccqebxA0sRCcZ0d9Rw+B7s9oX6KDjL8bW6ysnSCkr IUgf0ZQSAJfPqG1w5MBWGiQtexbkN1WzQzttGyl9O3zz3Z6EHXmLHpu8pI1cwAc5KzsMVBgjd2y
 k34vb2Rj2X/pwKTdal2EWnIdkeUJiqHk8y4uxvTG3QSYBt2U0JnJZTT1GWnY+zDsMFmig8Qi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_12,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505190009

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 96fadf7e8ff49fdb74754801228942b67c3eeebd ]

Q6afe-clocks driver can get reprobed. For example if the APR services
are restarted after the firmware crash. However currently Q6afe-clocks
driver will oops because hw.init will get cleared during first _probe
call. Rewrite the driver to fill the clock data at runtime rather than
using big static array of clocks.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Fixes: 520a1c396d19 ("ASoC: q6afe-clocks: add q6afe clock controller")
Link: https://lore.kernel.org/r/20210327092857.3073879-1-dmitry.baryshkov@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
[Minor context change fixed]
Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>
---
Verified the build test.
---
 sound/soc/qcom/qdsp6/q6afe-clocks.c | 209 ++++++++++++++--------------
 sound/soc/qcom/qdsp6/q6afe.c        |   2 +-
 sound/soc/qcom/qdsp6/q6afe.h        |   2 +-
 3 files changed, 108 insertions(+), 105 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-clocks.c b/sound/soc/qcom/qdsp6/q6afe-clocks.c
index acfc0c698f6a..9431656283cd 100644
--- a/sound/soc/qcom/qdsp6/q6afe-clocks.c
+++ b/sound/soc/qcom/qdsp6/q6afe-clocks.c
@@ -11,33 +11,29 @@
 #include <linux/slab.h>
 #include "q6afe.h"
 
-#define Q6AFE_CLK(id) &(struct q6afe_clk) {		\
+#define Q6AFE_CLK(id) {					\
 		.clk_id	= id,				\
 		.afe_clk_id	= Q6AFE_##id,		\
 		.name = #id,				\
-		.attributes = LPASS_CLK_ATTRIBUTE_COUPLE_NO, \
 		.rate = 19200000,			\
-		.hw.init = &(struct clk_init_data) {	\
-			.ops = &clk_q6afe_ops,		\
-			.name = #id,			\
-		},					\
 	}
 
-#define Q6AFE_VOTE_CLK(id, blkid, n) &(struct q6afe_clk) { \
+#define Q6AFE_VOTE_CLK(id, blkid, n) {			\
 		.clk_id	= id,				\
 		.afe_clk_id = blkid,			\
-		.name = #n,				\
-		.hw.init = &(struct clk_init_data) {	\
-			.ops = &clk_vote_q6afe_ops,	\
-			.name = #id,			\
-		},					\
+		.name = n,				\
 	}
 
-struct q6afe_clk {
-	struct device *dev;
+struct q6afe_clk_init {
 	int clk_id;
 	int afe_clk_id;
 	char *name;
+	int rate;
+};
+
+struct q6afe_clk {
+	struct device *dev;
+	int afe_clk_id;
 	int attributes;
 	int rate;
 	uint32_t handle;
@@ -48,8 +44,7 @@ struct q6afe_clk {
 
 struct q6afe_cc {
 	struct device *dev;
-	struct q6afe_clk **clks;
-	int num_clks;
+	struct q6afe_clk *clks[Q6AFE_MAX_CLK_ID];
 };
 
 static int clk_q6afe_prepare(struct clk_hw *hw)
@@ -105,7 +100,7 @@ static int clk_vote_q6afe_block(struct clk_hw *hw)
 	struct q6afe_clk *clk = to_q6afe_clk(hw);
 
 	return q6afe_vote_lpass_core_hw(clk->dev, clk->afe_clk_id,
-					clk->name, &clk->handle);
+					clk_hw_get_name(&clk->hw), &clk->handle);
 }
 
 static void clk_unvote_q6afe_block(struct clk_hw *hw)
@@ -120,84 +115,76 @@ static const struct clk_ops clk_vote_q6afe_ops = {
 	.unprepare	= clk_unvote_q6afe_block,
 };
 
-struct q6afe_clk *q6afe_clks[Q6AFE_MAX_CLK_ID] = {
-	[LPASS_CLK_ID_PRI_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_MI2S_IBIT),
-	[LPASS_CLK_ID_PRI_MI2S_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_MI2S_EBIT),
-	[LPASS_CLK_ID_SEC_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEC_MI2S_IBIT),
-	[LPASS_CLK_ID_SEC_MI2S_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEC_MI2S_EBIT),
-	[LPASS_CLK_ID_TER_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_TER_MI2S_IBIT),
-	[LPASS_CLK_ID_TER_MI2S_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_TER_MI2S_EBIT),
-	[LPASS_CLK_ID_QUAD_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUAD_MI2S_IBIT),
-	[LPASS_CLK_ID_QUAD_MI2S_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUAD_MI2S_EBIT),
-	[LPASS_CLK_ID_SPEAKER_I2S_IBIT] =
-				Q6AFE_CLK(LPASS_CLK_ID_SPEAKER_I2S_IBIT),
-	[LPASS_CLK_ID_SPEAKER_I2S_EBIT] =
-				Q6AFE_CLK(LPASS_CLK_ID_SPEAKER_I2S_EBIT),
-	[LPASS_CLK_ID_SPEAKER_I2S_OSR] =
-				Q6AFE_CLK(LPASS_CLK_ID_SPEAKER_I2S_OSR),
-	[LPASS_CLK_ID_QUI_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUI_MI2S_IBIT),
-	[LPASS_CLK_ID_QUI_MI2S_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUI_MI2S_EBIT),
-	[LPASS_CLK_ID_SEN_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEN_MI2S_IBIT),
-	[LPASS_CLK_ID_SEN_MI2S_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEN_MI2S_EBIT),
-	[LPASS_CLK_ID_INT0_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT0_MI2S_IBIT),
-	[LPASS_CLK_ID_INT1_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT1_MI2S_IBIT),
-	[LPASS_CLK_ID_INT2_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT2_MI2S_IBIT),
-	[LPASS_CLK_ID_INT3_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT3_MI2S_IBIT),
-	[LPASS_CLK_ID_INT4_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT4_MI2S_IBIT),
-	[LPASS_CLK_ID_INT5_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT5_MI2S_IBIT),
-	[LPASS_CLK_ID_INT6_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT6_MI2S_IBIT),
-	[LPASS_CLK_ID_QUI_MI2S_OSR] = Q6AFE_CLK(LPASS_CLK_ID_QUI_MI2S_OSR),
-	[LPASS_CLK_ID_PRI_PCM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_PCM_IBIT),
-	[LPASS_CLK_ID_PRI_PCM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_PCM_EBIT),
-	[LPASS_CLK_ID_SEC_PCM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEC_PCM_IBIT),
-	[LPASS_CLK_ID_SEC_PCM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEC_PCM_EBIT),
-	[LPASS_CLK_ID_TER_PCM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_TER_PCM_IBIT),
-	[LPASS_CLK_ID_TER_PCM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_TER_PCM_EBIT),
-	[LPASS_CLK_ID_QUAD_PCM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUAD_PCM_IBIT),
-	[LPASS_CLK_ID_QUAD_PCM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUAD_PCM_EBIT),
-	[LPASS_CLK_ID_QUIN_PCM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUIN_PCM_IBIT),
-	[LPASS_CLK_ID_QUIN_PCM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUIN_PCM_EBIT),
-	[LPASS_CLK_ID_QUI_PCM_OSR] = Q6AFE_CLK(LPASS_CLK_ID_QUI_PCM_OSR),
-	[LPASS_CLK_ID_PRI_TDM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_TDM_IBIT),
-	[LPASS_CLK_ID_PRI_TDM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_TDM_EBIT),
-	[LPASS_CLK_ID_SEC_TDM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEC_TDM_IBIT),
-	[LPASS_CLK_ID_SEC_TDM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEC_TDM_EBIT),
-	[LPASS_CLK_ID_TER_TDM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_TER_TDM_IBIT),
-	[LPASS_CLK_ID_TER_TDM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_TER_TDM_EBIT),
-	[LPASS_CLK_ID_QUAD_TDM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUAD_TDM_IBIT),
-	[LPASS_CLK_ID_QUAD_TDM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUAD_TDM_EBIT),
-	[LPASS_CLK_ID_QUIN_TDM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUIN_TDM_IBIT),
-	[LPASS_CLK_ID_QUIN_TDM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUIN_TDM_EBIT),
-	[LPASS_CLK_ID_QUIN_TDM_OSR] = Q6AFE_CLK(LPASS_CLK_ID_QUIN_TDM_OSR),
-	[LPASS_CLK_ID_MCLK_1] = Q6AFE_CLK(LPASS_CLK_ID_MCLK_1),
-	[LPASS_CLK_ID_MCLK_2] = Q6AFE_CLK(LPASS_CLK_ID_MCLK_2),
-	[LPASS_CLK_ID_MCLK_3] = Q6AFE_CLK(LPASS_CLK_ID_MCLK_3),
-	[LPASS_CLK_ID_MCLK_4] = Q6AFE_CLK(LPASS_CLK_ID_MCLK_4),
-	[LPASS_CLK_ID_INTERNAL_DIGITAL_CODEC_CORE] =
-		Q6AFE_CLK(LPASS_CLK_ID_INTERNAL_DIGITAL_CODEC_CORE),
-	[LPASS_CLK_ID_INT_MCLK_0] = Q6AFE_CLK(LPASS_CLK_ID_INT_MCLK_0),
-	[LPASS_CLK_ID_INT_MCLK_1] = Q6AFE_CLK(LPASS_CLK_ID_INT_MCLK_1),
-	[LPASS_CLK_ID_WSA_CORE_MCLK] = Q6AFE_CLK(LPASS_CLK_ID_WSA_CORE_MCLK),
-	[LPASS_CLK_ID_WSA_CORE_NPL_MCLK] =
-				Q6AFE_CLK(LPASS_CLK_ID_WSA_CORE_NPL_MCLK),
-	[LPASS_CLK_ID_VA_CORE_MCLK] = Q6AFE_CLK(LPASS_CLK_ID_VA_CORE_MCLK),
-	[LPASS_CLK_ID_TX_CORE_MCLK] = Q6AFE_CLK(LPASS_CLK_ID_TX_CORE_MCLK),
-	[LPASS_CLK_ID_TX_CORE_NPL_MCLK] =
-			Q6AFE_CLK(LPASS_CLK_ID_TX_CORE_NPL_MCLK),
-	[LPASS_CLK_ID_RX_CORE_MCLK] = Q6AFE_CLK(LPASS_CLK_ID_RX_CORE_MCLK),
-	[LPASS_CLK_ID_RX_CORE_NPL_MCLK] =
-				Q6AFE_CLK(LPASS_CLK_ID_RX_CORE_NPL_MCLK),
-	[LPASS_CLK_ID_VA_CORE_2X_MCLK] =
-				Q6AFE_CLK(LPASS_CLK_ID_VA_CORE_2X_MCLK),
-	[LPASS_HW_AVTIMER_VOTE] = Q6AFE_VOTE_CLK(LPASS_HW_AVTIMER_VOTE,
-						 Q6AFE_LPASS_CORE_AVTIMER_BLOCK,
-						 "LPASS_AVTIMER_MACRO"),
-	[LPASS_HW_MACRO_VOTE] = Q6AFE_VOTE_CLK(LPASS_HW_MACRO_VOTE,
-						Q6AFE_LPASS_CORE_HW_MACRO_BLOCK,
-						"LPASS_HW_MACRO"),
-	[LPASS_HW_DCODEC_VOTE] = Q6AFE_VOTE_CLK(LPASS_HW_DCODEC_VOTE,
-					Q6AFE_LPASS_CORE_HW_DCODEC_BLOCK,
-					"LPASS_HW_DCODEC"),
+static const struct q6afe_clk_init q6afe_clks[] = {
+	Q6AFE_CLK(LPASS_CLK_ID_PRI_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_PRI_MI2S_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SEC_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SEC_MI2S_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_TER_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_TER_MI2S_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUAD_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUAD_MI2S_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SPEAKER_I2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SPEAKER_I2S_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SPEAKER_I2S_OSR),
+	Q6AFE_CLK(LPASS_CLK_ID_QUI_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUI_MI2S_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SEN_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SEN_MI2S_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_INT0_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_INT1_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_INT2_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_INT3_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_INT4_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_INT5_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_INT6_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUI_MI2S_OSR),
+	Q6AFE_CLK(LPASS_CLK_ID_PRI_PCM_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_PRI_PCM_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SEC_PCM_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SEC_PCM_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_TER_PCM_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_TER_PCM_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUAD_PCM_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUAD_PCM_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUIN_PCM_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUIN_PCM_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUI_PCM_OSR),
+	Q6AFE_CLK(LPASS_CLK_ID_PRI_TDM_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_PRI_TDM_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SEC_TDM_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SEC_TDM_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_TER_TDM_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_TER_TDM_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUAD_TDM_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUAD_TDM_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUIN_TDM_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUIN_TDM_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUIN_TDM_OSR),
+	Q6AFE_CLK(LPASS_CLK_ID_MCLK_1),
+	Q6AFE_CLK(LPASS_CLK_ID_MCLK_2),
+	Q6AFE_CLK(LPASS_CLK_ID_MCLK_3),
+	Q6AFE_CLK(LPASS_CLK_ID_MCLK_4),
+	Q6AFE_CLK(LPASS_CLK_ID_INTERNAL_DIGITAL_CODEC_CORE),
+	Q6AFE_CLK(LPASS_CLK_ID_INT_MCLK_0),
+	Q6AFE_CLK(LPASS_CLK_ID_INT_MCLK_1),
+	Q6AFE_CLK(LPASS_CLK_ID_WSA_CORE_MCLK),
+	Q6AFE_CLK(LPASS_CLK_ID_WSA_CORE_NPL_MCLK),
+	Q6AFE_CLK(LPASS_CLK_ID_VA_CORE_MCLK),
+	Q6AFE_CLK(LPASS_CLK_ID_TX_CORE_MCLK),
+	Q6AFE_CLK(LPASS_CLK_ID_TX_CORE_NPL_MCLK),
+	Q6AFE_CLK(LPASS_CLK_ID_RX_CORE_MCLK),
+	Q6AFE_CLK(LPASS_CLK_ID_RX_CORE_NPL_MCLK),
+	Q6AFE_CLK(LPASS_CLK_ID_VA_CORE_2X_MCLK),
+	Q6AFE_VOTE_CLK(LPASS_HW_AVTIMER_VOTE,
+		       Q6AFE_LPASS_CORE_AVTIMER_BLOCK,
+		       "LPASS_AVTIMER_MACRO"),
+	Q6AFE_VOTE_CLK(LPASS_HW_MACRO_VOTE,
+		       Q6AFE_LPASS_CORE_HW_MACRO_BLOCK,
+		       "LPASS_HW_MACRO"),
+	Q6AFE_VOTE_CLK(LPASS_HW_DCODEC_VOTE,
+		       Q6AFE_LPASS_CORE_HW_DCODEC_BLOCK,
+		       "LPASS_HW_DCODEC"),
 };
 
 static struct clk_hw *q6afe_of_clk_hw_get(struct of_phandle_args *clkspec,
@@ -207,7 +194,7 @@ static struct clk_hw *q6afe_of_clk_hw_get(struct of_phandle_args *clkspec,
 	unsigned int idx = clkspec->args[0];
 	unsigned int attr = clkspec->args[1];
 
-	if (idx >= cc->num_clks || attr > LPASS_CLK_ATTRIBUTE_COUPLE_DIVISOR) {
+	if (idx >= Q6AFE_MAX_CLK_ID || attr > LPASS_CLK_ATTRIBUTE_COUPLE_DIVISOR) {
 		dev_err(cc->dev, "Invalid clk specifier (%d, %d)\n", idx, attr);
 		return ERR_PTR(-EINVAL);
 	}
@@ -230,20 +217,36 @@ static int q6afe_clock_dev_probe(struct platform_device *pdev)
 	if (!cc)
 		return -ENOMEM;
 
-	cc->clks = &q6afe_clks[0];
-	cc->num_clks = ARRAY_SIZE(q6afe_clks);
+	cc->dev = dev;
 	for (i = 0; i < ARRAY_SIZE(q6afe_clks); i++) {
-		if (!q6afe_clks[i])
-			continue;
+		unsigned int id = q6afe_clks[i].clk_id;
+		struct clk_init_data init = {
+			.name =  q6afe_clks[i].name,
+		};
+		struct q6afe_clk *clk;
+
+		clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
+		if (!clk)
+			return -ENOMEM;
+
+		clk->dev = dev;
+		clk->afe_clk_id = q6afe_clks[i].afe_clk_id;
+		clk->rate = q6afe_clks[i].rate;
+		clk->hw.init = &init;
+
+		if (clk->rate)
+			init.ops = &clk_q6afe_ops;
+		else
+			init.ops = &clk_vote_q6afe_ops;
 
-		q6afe_clks[i]->dev = dev;
+		cc->clks[id] = clk;
 
-		ret = devm_clk_hw_register(dev, &q6afe_clks[i]->hw);
+		ret = devm_clk_hw_register(dev, &clk->hw);
 		if (ret)
 			return ret;
 	}
 
-	ret = of_clk_add_hw_provider(dev->of_node, q6afe_of_clk_hw_get, cc);
+	ret = devm_of_clk_add_hw_provider(dev, q6afe_of_clk_hw_get, cc);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 0ca1e4aae518..7be495336446 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -1681,7 +1681,7 @@ int q6afe_unvote_lpass_core_hw(struct device *dev, uint32_t hw_block_id,
 EXPORT_SYMBOL(q6afe_unvote_lpass_core_hw);
 
 int q6afe_vote_lpass_core_hw(struct device *dev, uint32_t hw_block_id,
-			     char *client_name, uint32_t *client_handle)
+			     const char *client_name, uint32_t *client_handle)
 {
 	struct q6afe *afe = dev_get_drvdata(dev->parent);
 	struct afe_cmd_remote_lpass_core_hw_vote_request *vote_cfg;
diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
index 22e10269aa10..3845b56c0ed3 100644
--- a/sound/soc/qcom/qdsp6/q6afe.h
+++ b/sound/soc/qcom/qdsp6/q6afe.h
@@ -236,7 +236,7 @@ int q6afe_port_set_sysclk(struct q6afe_port *port, int clk_id,
 int q6afe_set_lpass_clock(struct device *dev, int clk_id, int clk_src,
 			  int clk_root, unsigned int freq);
 int q6afe_vote_lpass_core_hw(struct device *dev, uint32_t hw_block_id,
-			     char *client_name, uint32_t *client_handle);
+			     const char *client_name, uint32_t *client_handle);
 int q6afe_unvote_lpass_core_hw(struct device *dev, uint32_t hw_block_id,
 			       uint32_t client_handle);
 #endif /* __Q6AFE_H__ */
-- 
2.34.1


