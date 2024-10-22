Return-Path: <stable+bounces-87684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AF79A9BAA
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 09:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E301F21E96
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 07:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ECF155325;
	Tue, 22 Oct 2024 07:58:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D07154C19
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583933; cv=fail; b=Yszhpj2NtdKHHJK+ZcDUJ6+PV7nJB64Ood8c7L3A63sNQl520ncUsK9JlVVgBfOBOuI0WZw01Zheqy1ljJBqpO5SjHO8wTvllPx8CQ3p5gc0uLpCAfKNtJ60a1CcXeawZXG13eieaSkTbKqjAaXUxj1gqo2WA4s4l0242sKB6eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583933; c=relaxed/simple;
	bh=RvqPNf6TWsfgZQ1qxPMa/NQMc1NuVrSpiPvWP4INHZQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ukgesIzHWmTorVh5Y0gbVZVrrYI0TuejeeVn85j9mOowqT7j7EbQ6p9a+NjxmC75gyn9IyWFdS5us598/BNNnCOCjPJm5Zx6q1O/4rs83XlA4uWDIFyySJKTchDSdyvH/Ew/uyEdsmR+/kkhxDHQtpoqNoU1qQT3QLdbKtR2gq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M60P4k020948
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 00:58:50 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42c823u08t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 00:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otu5KDfFBSoIQtLw6J5yd4owkkn65ENIftD5QWjK+Dh6kMrvsqvGege8urxtTAX+b8ShrNmYf6J2WdqA0zybnyWFJWKBttTTEIihNshw1FIuuhzkZWd4BKim/UQX/Q16R1NXCf6xAHOXlwA8xokPRa+FGZtiz5WRSWA4sdv7Kp1Oyp3PjM4bVc799Q0RqXo4erJPOtgl+UIEVAFr1vF3VBi9re/yMiFls8VRUW/2kriOOmqn3WJBi9ZYRhg8GVi8X4Pj3le33Jvcgka9J1B8S3LtB1saHZQtxo7bk2G5fhvpWBYb7e5YZ7d1Apl0kc7TMMIc5HqYYAM7pe0qvldDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duuXSyaKHce2Qxhp/biAaoZkOXisFSVQu/ifn4qGe4Q=;
 b=v5NMVGZoSoWcRRSm2345OJjru/WRYsXSFd1Gd95Kv8i2P1cOIHEvxyYhUINIB+fs8zC1Kzk1mO+bJru5vjBH0LSYxMdWPmXHG7v1h70uS+a14sCHjSXjEYzfViGwufwUq3pe3O9zwtXjxS+MTW6UObLSpfHeCw8aHcaCGqaYjlTQuV/bURbm4U2HNLRtcPFlQdjm+KGArh/4fOfylkuJKdLUSY50trB6Lje32Ssibe1YXjnGbolvYdRak8yRdZ5BAJYg4nUupMNVclFR/QqNvZE/66g+X5T7ecS2UnbIpxmBpvvfenlRcB0St3C6QQziOoF2itsXKE8Ge6XZVYd1eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SA1PR11MB6567.namprd11.prod.outlook.com (2603:10b6:806:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 07:58:47 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 07:58:47 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1/6.6] wifi: mac80211: fix NULL dereference at band check in starting tx ba session
Date: Tue, 22 Oct 2024 15:57:59 +0800
Message-ID: <20241022075759.3099841-1-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0251.apcprd06.prod.outlook.com
 (2603:1096:4:ac::35) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SA1PR11MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 872cec78-cf33-4645-2e4e-08dcf26f443a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IjjoOYT+A4d0xzgyeufUTdOYPwkbRoIUpIjM5FOxyy7W1/3BRNN116wD9Eii?=
 =?us-ascii?Q?d6zdvb6M8q8fSqBzYMcjC8/r2L2fPOCmE1nkKetHHiqoSt90JgCnEfwDmcJv?=
 =?us-ascii?Q?DocJNj2MymI6Hf6p64Ab2EklQ2kE3bk+Yja7yNc0Y7xnuoh9GXDcsqMeRsXz?=
 =?us-ascii?Q?6q1jsdwYkDlkG7PPQ3zU1+itjB6Y3F4UG04DDQE+uebeUCQ7hHYVXK86UU/p?=
 =?us-ascii?Q?dIEulj/ceaxI1VsNxEJPuhQJlgZMWcotKxtcgRiF9WV8qh7RGe0fTtdqPWNT?=
 =?us-ascii?Q?AxahGpw30l4QUW2CKSJKMC9ulblCL9erx7X/CJSUK3CkKRofzO+3hipFHSIe?=
 =?us-ascii?Q?376vzkf7RvP6g3arseMkV/mIn8Ky/FN77lI+fEvay67q7eo+f0k6iLAWZC/1?=
 =?us-ascii?Q?ZU5BlMvDdxkefBe2TC5MD0QpG1ov8oDNqqxTvFPB30lmMK6jLIRwtjOkoyUo?=
 =?us-ascii?Q?cCC5A7gKgDe3C77el7faLzRvQbbrjVw5086LqUeHzx8ut+OcOPbLRsetIpZV?=
 =?us-ascii?Q?ojJxY7QHxTdB71QLY19J017SFv+wz07rDbiMSdysuUQy4VGFPxzzFgDG/NsT?=
 =?us-ascii?Q?A0ZZd3afHTl0+XB75pXftxCyz+ZdXWQ2LTWWbjU094HM3q6VUkpL/nRfA/J0?=
 =?us-ascii?Q?Gx3pujW0hyfqyW9A+UUgyMec7zq2dt+6fF1yjXigaDl4uWV3fOXQWPjdoh1y?=
 =?us-ascii?Q?rKNCFe9RakGbPounUgJbt2VVQy24HR0qM9SxvWgz9yoYyK4+No560d+vlm3v?=
 =?us-ascii?Q?JkpUAgJBmU+9d8Wkd7hdGD3rWqD22+kV1nANWl8OwXhkayBV327SrBkiISc8?=
 =?us-ascii?Q?QiGQLRWerTA7zxT4XWGvTAu53ih5UhE4AlUzIijxHSfi7TxsB6uunKgibVRT?=
 =?us-ascii?Q?iZ5cDk30uJ9bq7Zeo1/paWBDUCOgPeHxdwAI3eHeKscwo9wMRLUqIRy+wsn+?=
 =?us-ascii?Q?HslIJsew1rG7fmJTBgcQiXxSt6hQuhc9Pt/mkljya4XR05CYZqZmYRW4rF5b?=
 =?us-ascii?Q?tCaBBYzA9+0vinNgNNTrb+e45v1g1YDDF5XIqeXbQ4U2fULa/6ME671JZD8z?=
 =?us-ascii?Q?nJ6Mj1dpGgohETcYGP/Caf5Du1JOCqzDz3d5vT0yEP0a9DtD8L/nVThDM5wU?=
 =?us-ascii?Q?qrkc0hlp/v3dJ4/7ZWYHfOyk34v7Sbium35+4Jf41RGAaMsd5BHl/jlEEmKL?=
 =?us-ascii?Q?PU1umWT0CV6uUotGojZGc3HCS+DqKVMvHElKFV+x1ig3ilkkGZ3IKCjYpeK4?=
 =?us-ascii?Q?rXNxMK0HcKnPd3DjrT3qn01+td1cHLB8Oj1/V3kFbTHhf3kQgQvgfG0NuoGN?=
 =?us-ascii?Q?/lbbxKoAOX2pp5oXNqwpiHIA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0/sNY30BusFqFt1C2B3II8OVLaHXWXrKrQmNYnbY5tBGZQ42t25RUAUNVipB?=
 =?us-ascii?Q?XHFJ1yHrZ6B0wX8lRcUG7I9HCVGpJ7toJl5Z5nQsJPl+YudqneD9b8r6OBAw?=
 =?us-ascii?Q?O+okudJWpvVQ9C/7UuVdDhpeT9wvfi9mlD2aQa/GzY746P8mH6keh2iy08c0?=
 =?us-ascii?Q?1xTFQzMuipnc5jZDFSNQbiPhhHJFI66uQrUEG3yXUhtoY1o4b539w3Hk0IXF?=
 =?us-ascii?Q?eE3+4tEodrlFQOVCQq4+hL8GHHmHIp+fGdTGPtMe/xKNvafR00pagOZtpRLF?=
 =?us-ascii?Q?jebDuVpMgQ0E0tjVPb87q2kqEp0VAbScwjxTtvb4+NXmCXBjIetCXckrpXbR?=
 =?us-ascii?Q?Ns8/E+uyVK5tL3KSk2DJNjQFDUAzaFOVGQgdSrMcE9UvAt1+a1GHbfkgzSt5?=
 =?us-ascii?Q?CMVnWJJ2XbquAi8RCMSAN6KMCDEyPcl1Xlrw6jMtjaAs2Tq1z2h5reyr0wR6?=
 =?us-ascii?Q?13dYF8Hhg8ck0K0LwSKfFoqqKR4hx76LBU4RY+hmGGRIIZ0PyZv1Y/J4Civ3?=
 =?us-ascii?Q?upd5MIinGYBdYuWlLmVQi/mJ8pebeHnEwG1Y3XWjUitsdBypdCsLGjwWAd0c?=
 =?us-ascii?Q?ASzh6J4uGZFV5Q/B5gW+nFs8n4zVI6a3bFAoJao7tSiqLAHFcoGChL/C/FBn?=
 =?us-ascii?Q?nlXj7fFf+XZKqUbkw5bt+Wxww6EH2sClQAY6HJ9exT0rbW2XGpkQRDcD56gR?=
 =?us-ascii?Q?phh3LEy/r2PltX87UfKojMDB3uTZnFDCknx0IIi0WIbw18qFe5ZMWgeFzD9v?=
 =?us-ascii?Q?YBoVwCp5q+GDl8LEF8dEBx8rThIEP8ngazs2gJ/2hUFnm7GFc9ICsySWpmWL?=
 =?us-ascii?Q?/lrb0KeKA5P+Z1CyEwrjCfFQmWW9ubnqDT1peExYs0JeltGb20td4+N9c59R?=
 =?us-ascii?Q?vVHlUG6967ivQFyFLMQQpsQ0Gm25PcJXLaj77ltNM7SF26YRsvwgmjsLk/da?=
 =?us-ascii?Q?HwEuT9VzaiL8jbmF08jD0/2rcrqvhH2SqNfl8b0l8Zo35LGFilo8wyBfSTAJ?=
 =?us-ascii?Q?J+i32CDwO1XXpf6gONOs1p6S9NapTdU0/MCfuLE5p2Wrgp21OwrZWYLUT6hg?=
 =?us-ascii?Q?z4RKId+uZgRW0KlYyaybGvhcvAzyPxz1VdtsNvK8eN0oVc/SgS31dWT7m/Mk?=
 =?us-ascii?Q?+8QOZ1uEWqNATfY47w1oSllB0y/N1RG3Pf0ujzAUqb79KO0D6c2ozQasO2RQ?=
 =?us-ascii?Q?8QkEcxu6+e+9j11vxINVm8Q7TAq/w+v6BJCodZVyKPCq3poA3gy2RLRtRhSH?=
 =?us-ascii?Q?pn7hiP4grGZ//tTjyId35yDhK66LWMCCHq9EtxKrtTFBF6tGR5sgkySvyzni?=
 =?us-ascii?Q?onOi4G7fBfCUEbPHg/Id5AhxmAkM7sSECzzeeRehQWgaJFQiAnwDlPjKCPK9?=
 =?us-ascii?Q?ZY+YtnZEIKs/QbmMI2xJjke4aL5cuwnA2JzAM4PS3/itqvyj0CLqcKTp4AyQ?=
 =?us-ascii?Q?rVrE2DIgJ4wAx9lkjoTuLwFOfClefTeVZ8wkgFuKykP4BnVud3tXAUVF23Dw?=
 =?us-ascii?Q?dYjtdNKhuAWaY4JwzeLGYwsRxMafkCj+PcuacZUD1gtWocnWqG2H5sEj2S+9?=
 =?us-ascii?Q?tEhrdTVpwU6yPoPpwV5WryQk1PkgwNbQC9PthdClh5gprIiQDmt40b0zu8x8?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872cec78-cf33-4645-2e4e-08dcf26f443a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 07:58:47.2104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7v4Svipmcf3IhvWPMHw813vIYdlJClWo5gO6+Zqd3JX62kZ8jF3+Jr/mhwED8OZEN792GPFjFVdeS2IlSVeK1ZOh3IxHHlySqfee/eeIWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6567
X-Authority-Analysis: v=2.4 cv=UrgxNPwB c=1 sm=1 tr=0 ts=67175b3a cx=c_pps a=di3315gfm3qlniCp1Rh91A==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=n9Sqmae0AAAA:8 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=mjP_N2h3gr_wx3m7mfcA:9 a=-FEs8UIgK8oA:10 a=UmAUUZEt6-oIqEbegvw9:22 a=FO4_E8m0qiDe52t0p3_H:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: WbFCciEem_C_mGpZYDYzygTjGjmNfiVU
X-Proofpoint-GUID: WbFCciEem_C_mGpZYDYzygTjGjmNfiVU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_07,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=1 clxscore=1015 adultscore=0 mlxlogscore=210
 priorityscore=1501 lowpriorityscore=0 mlxscore=1 suspectscore=0
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410220050

From: Zong-Zhe Yang <kevin_yang@realtek.com>

[ Upstream commit 021d53a3d87eeb9dbba524ac515651242a2a7e3b ]

In MLD connection, link_data/link_conf are dynamically allocated. They
don't point to vif->bss_conf. So, there will be no chanreq assigned to
vif->bss_conf and then the chan will be NULL. Tweak the code to check
ht_supported/vht_supported/has_he/has_eht on sta deflink.

Crash log (with rtw89 version under MLO development):
[ 9890.526087] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 9890.526102] #PF: supervisor read access in kernel mode
[ 9890.526105] #PF: error_code(0x0000) - not-present page
[ 9890.526109] PGD 0 P4D 0
[ 9890.526114] Oops: 0000 [#1] PREEMPT SMP PTI
[ 9890.526119] CPU: 2 PID: 6367 Comm: kworker/u16:2 Kdump: loaded Tainted: G           OE      6.9.0 #1
[ 9890.526123] Hardware name: LENOVO 2356AD1/2356AD1, BIOS G7ETB3WW (2.73 ) 11/28/2018
[ 9890.526126] Workqueue: phy2 rtw89_core_ba_work [rtw89_core]
[ 9890.526203] RIP: 0010:ieee80211_start_tx_ba_session (net/mac80211/agg-tx.c:618 (discriminator 1)) mac80211
[ 9890.526279] Code: f7 e8 d5 93 3e ea 48 83 c4 28 89 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 49 8b 84 24 e0 f1 ff ff 48 8b 80 90 1b 00 00 <83> 38 03 0f 84 37 fe ff ff bb ea ff ff ff eb cc 49 8b 84 24 10 f3
All code
========
   0:	f7 e8                	imul   %eax
   2:	d5                   	(bad)
   3:	93                   	xchg   %eax,%ebx
   4:	3e ea                	ds (bad)
   6:	48 83 c4 28          	add    $0x28,%rsp
   a:	89 d8                	mov    %ebx,%eax
   c:	5b                   	pop    %rbx
   d:	41 5c                	pop    %r12
   f:	41 5d                	pop    %r13
  11:	41 5e                	pop    %r14
  13:	41 5f                	pop    %r15
  15:	5d                   	pop    %rbp
  16:	c3                   	retq
  17:	cc                   	int3
  18:	cc                   	int3
  19:	cc                   	int3
  1a:	cc                   	int3
  1b:	49 8b 84 24 e0 f1 ff 	mov    -0xe20(%r12),%rax
  22:	ff
  23:	48 8b 80 90 1b 00 00 	mov    0x1b90(%rax),%rax
  2a:*	83 38 03             	cmpl   $0x3,(%rax)		<-- trapping instruction
  2d:	0f 84 37 fe ff ff    	je     0xfffffffffffffe6a
  33:	bb ea ff ff ff       	mov    $0xffffffea,%ebx
  38:	eb cc                	jmp    0x6
  3a:	49                   	rex.WB
  3b:	8b                   	.byte 0x8b
  3c:	84 24 10             	test   %ah,(%rax,%rdx,1)
  3f:	f3                   	repz

Code starting with the faulting instruction
===========================================
   0:	83 38 03             	cmpl   $0x3,(%rax)
   3:	0f 84 37 fe ff ff    	je     0xfffffffffffffe40
   9:	bb ea ff ff ff       	mov    $0xffffffea,%ebx
   e:	eb cc                	jmp    0xffffffffffffffdc
  10:	49                   	rex.WB
  11:	8b                   	.byte 0x8b
  12:	84 24 10             	test   %ah,(%rax,%rdx,1)
  15:	f3                   	repz
[ 9890.526285] RSP: 0018:ffffb8db09013d68 EFLAGS: 00010246
[ 9890.526291] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff9308e0d656c8
[ 9890.526295] RDX: 0000000000000000 RSI: ffffffffab99460b RDI: ffffffffab9a7685
[ 9890.526300] RBP: ffffb8db09013db8 R08: 0000000000000000 R09: 0000000000000873
[ 9890.526304] R10: ffff9308e0d64800 R11: 0000000000000002 R12: ffff9308e5ff6e70
[ 9890.526308] R13: ffff930952500e20 R14: ffff9309192a8c00 R15: 0000000000000000
[ 9890.526313] FS:  0000000000000000(0000) GS:ffff930b4e700000(0000) knlGS:0000000000000000
[ 9890.526316] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9890.526318] CR2: 0000000000000000 CR3: 0000000391c58005 CR4: 00000000001706f0
[ 9890.526321] Call Trace:
[ 9890.526324]  <TASK>
[ 9890.526327] ? show_regs (arch/x86/kernel/dumpstack.c:479)
[ 9890.526335] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434)
[ 9890.526340] ? page_fault_oops (arch/x86/mm/fault.c:713)
[ 9890.526347] ? search_module_extables (kernel/module/main.c:3256 (discriminator 3))
[ 9890.526353] ? ieee80211_start_tx_ba_session (net/mac80211/agg-tx.c:618 (discriminator 1)) mac80211

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Link: https://patch.msgid.link/20240617115217.22344-1-kevin_yang@realtek.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
CVE: CVE-2024-43911
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 net/mac80211/agg-tx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index e26a72f3a104..1241ab7a86bb 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -593,7 +593,9 @@ int ieee80211_start_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid,
 		return -EINVAL;
 
 	if (!pubsta->deflink.ht_cap.ht_supported &&
-	    sta->sdata->vif.bss_conf.chandef.chan->band != NL80211_BAND_6GHZ)
+	    !pubsta->deflink.vht_cap.vht_supported &&
+	    !pubsta->deflink.he_cap.has_he &&
+	    !pubsta->deflink.eht_cap.has_eht)
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(!local->ops->ampdu_action))
-- 
2.43.0


