Return-Path: <stable+bounces-132197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3989A851DB
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 05:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C33BC7A9344
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 03:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A03827C170;
	Fri, 11 Apr 2025 03:05:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7980A27C166
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 03:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744340720; cv=fail; b=lvju+nhg6lstNwAIVU26CmzTRQ1ZZDF7mdQzfflNcF9TlAwOxUXRmFlB8JzitQoyjWrdfFM9a0nxzjbzljufjtHznY6oOr8/YkMUYDDBSFmM3JhB08kCs+TuPVS51yWKUSdrepDzM9FbIdqPiznyEY/JYgRpowxRQY+z3P+FGVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744340720; c=relaxed/simple;
	bh=JWvSzgQWy3/dtEj94IWinAG1hjQ4MORmlAHl6zUgxx4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FqLaFEAT8bZG9TRif56WjRH32yO6cdRc0yGbFQvXs6GjzGZ9xQgG6xlLKKvY+9+llEPimUl145ZQGcs8F8FCDmfb85pFsT5CJkEMajsW8NXSPqF1tx43bID/uG+lGUQ8kjJzpuYWdUmzlmf/5xlyUNWC/qqKxuTPtxb635tPgJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B2msoN009993;
	Thu, 10 Apr 2025 20:05:14 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45u41m7aua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 20:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0eLyaTbrjNy/jVOjFkDkqzqy9RHCdEwr95NvgzlW3rk2bzex6/Ks7ea85DLzuZxK2XwoyKSsIRa2B/erIstn2nqhkJA/wsH7tNPw9Dmsa73wAPbibxq0PkjI7VFU74Rbvc9SY8uPysJyd247hg0xFn3KPypd4bzmwwooUXubvjbhPbCqoyj0uzgwrrPoaDj1+GhAovuOOjEzdmmwqzeHyu4dpdifINTZIHxNBUoAuvC+VKWp3/s8L3E50T7XHw4haJMdKfGhleplzM5YRL4KX0hjWUZjnbgSBhxL7bRFgZWbYcEjqcTeoq/EciSIqoHN+xAoJKYHhf3p4OkXSL1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+v2V2ACwpMQQgsq8Mdu1HN928RdDjpr+ojgbPm5i3g=;
 b=cx9gohfvQxayrDsHhFiscUPnDKmMLsKtxrqpIsawtlQmoAeVTWXe0XNnhPR6z/ctOkq9xpN8TP4PRpNPpof2Phe/Qwa7n9ItmLu9M5hRB6FespYNHi+hNpNPBYY50KUw2gj/Rg/bL/xcOP0wm5ye+vxZN/gFUCIhhcw6flpZh1b1ZAwHKLEtz8vK/fIqbMrAO7O4K3Sb6lLoFuPosdIhG0JDZaoV2a5SXjN4+POT/2UhbZqpzuSfkEiycJuVNdYKof9t1n0jR0TsO2OggZktOA10Hzg6MUnAxsDeyJE8KOQ2GIQSGDVqp3ptag3C6TIJ3fIedPWUBE5nRrWqgZorQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7)
 by IA4PR11MB8991.namprd11.prod.outlook.com (2603:10b6:208:55e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.24; Fri, 11 Apr
 2025 03:05:11 +0000
Received: from IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4]) by IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4%4]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 03:05:10 +0000
From: Feng Liu <Feng.Liu3@windriver.com>
To: chunguang.xu@shopee.com, yue.zhao@shopee.com, kbusch@kernel.org,
        Feng.Liu3@windriver.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6.y] nvme-rdma: unquiesce admin_q before destroy it
Date: Fri, 11 Apr 2025 11:04:55 +0800
Message-Id: <20250411030455.1085781-1-Feng.Liu3@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To IA1PR11MB7174.namprd11.prod.outlook.com
 (2603:10b6:208:41a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7174:EE_|IA4PR11MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: ff41366a-54ae-41f2-d1b3-08dd78a5ab76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ThE2rofFyATy7aIrEpgJW7bNWCpBnXxR0w7/q4tfomaHTERtCMGOomUJicP?=
 =?us-ascii?Q?WraKUVFqglqMfmj5OIn/4GaGyfb+6eycr0gSRKCz/1oj7Xjb2z+f+jGWBNIA?=
 =?us-ascii?Q?28gF1gH+p9wCrE1q26IKiK3MWqtsFr9lYRfTNXyOShTbKE8xFHydwQyZjIZ6?=
 =?us-ascii?Q?nttulwBm5U6/uus2llkQT0AxeO91J3B3KhjDU1eILEGrp7LCfC7P6vapaTcA?=
 =?us-ascii?Q?bp2O1mOMsPnBoF4Jp9na3gjPqmw95uFkHIEFIDM1fOuKWExxAYV+YBlrbh8E?=
 =?us-ascii?Q?Tqmo+qiKWOAaQtLi/5l9R8BOVMRcTX4qg4gRP7/PNhgFtYiYM3BH5L1Sx0qz?=
 =?us-ascii?Q?MrOph4YXTpNeqGnk3ungxFwRTzu5xkJBdqlgaOQebt+zKTp4BFVBlvXY7HS3?=
 =?us-ascii?Q?7GS5TtuAROB2MCctPSHfscrH//nQMOD2stpN3LsE9cA9rKdp1t8TxhCINiPC?=
 =?us-ascii?Q?2cLj3TRN34CXQ92+omvDF9WvAWX7U+B9K7V3TLCWXrTuVk9DD+tQ5+jlLKE2?=
 =?us-ascii?Q?YGIpiaW23IpWtpOXneYQdlHA/OKSybq0Kgl2T0w74sRyJ/7k2EKP7Hgr+D1g?=
 =?us-ascii?Q?wahTpN/0J/XXKaO12l1Mudt9Tcmj0CgXhmf54tO4BP1biElKVXslud7hZ3JG?=
 =?us-ascii?Q?RzTBux6NPjaKK2abKtmacQn6DF8QN1bbbfoT+48o/SzdDkF8Y9G1tBXgmlbp?=
 =?us-ascii?Q?lB3dWoN7aohGB8S4bA+Tuk/UtIHEVj7XU6IAVptvJUcDUKFnq4W5dyRqXFYR?=
 =?us-ascii?Q?CH0fgiC5Fs336EMeJFXvQZMBnvqLQUBvQBSCv05ADuD8ivKrQBtJvCaCGDaT?=
 =?us-ascii?Q?hmSzTso/6CM9eAReQRgDIoni3vZf3Vmocfm0DYdbFwSqkaVTccIL3Yc9WJ2r?=
 =?us-ascii?Q?OQFR/GXuncwX+Rp/WN/5C+KUWcOBtuYT4XgZzmg942wup7MxORza3qcftjSU?=
 =?us-ascii?Q?79Zp3uca4DcnZWvXwlN5YPOVP/X9MI9OBMQR5eGgTz/N+OG2C5Yaqjt8G3hJ?=
 =?us-ascii?Q?8EtvW6d+BFBaq6mBEmAjB29Hss8dJVilWqkjKIb6VkPxvV3N0rT9I15V7+Gf?=
 =?us-ascii?Q?GuBxv/9seu0jT0ZwjpxCDzk3AYhkIT05MHVlcnDz1TKkpE/oMNvBD5Uufc8c?=
 =?us-ascii?Q?Occ1Lnd6E2Q4TDRPwAPj/caN6YlK5+KCR3cYhL6yRivTrPgVjgPcLrEGSrYQ?=
 =?us-ascii?Q?X0yZUn8wlkURMmdNpQWiOtQXgbSKG70TUNkLYDHtM1Em/p7XZoSWfwJDEOHe?=
 =?us-ascii?Q?VjinvPjIFqIBvNhNCNjjH49FgU+5QbiZIgMLCStqEavbY96+yAXSKbhBNR3z?=
 =?us-ascii?Q?58p0OpxaiuqA9aeMDIgeEYxnTk1G4LrDQCCkY0fFSKygT64Qo7l0NnBoX8N9?=
 =?us-ascii?Q?nlq1S6Cs4xUxZZQRDNmZ9h9Y3Na48YnNVBqRGS/PC9WRJHFIhPQvSKEK4MYG?=
 =?us-ascii?Q?C2+dOgMjhCjOi6BATlGoD5UP/tycp+RT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7174.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SyC6vxONm8+fiI4OBQwiexPCTd55bPhXUFmeOs7LyFXlgRhwhxlHleDb0Qfe?=
 =?us-ascii?Q?UZntDH2Rf0PSxe6qp7/m5+kBl4BYkpuMGO4UCDEpcy4ql8CA9VQMsIA4i3TZ?=
 =?us-ascii?Q?1PY0uC38CQOO7jDQu1+EzeFi3vf1uIW2txRpVeLKYAEqps3b5IjKnd8J2d/Z?=
 =?us-ascii?Q?OhPhGyXKJTfWhN+wuaUaZhv2RgcWb85ewMNPCUGMxllZ6SBGt7sAjJNBhAyw?=
 =?us-ascii?Q?rX8sKCqdMwDzgNTupOaQJfj1vGkrCH4kRplqQBV6PzOUQYaRx74vpj0snxRC?=
 =?us-ascii?Q?bcHwbBz9ChHmkdd7FCGNy02FQEyF91OvBeZvuudEYhQud6Wv5T/WdwfKZ/2O?=
 =?us-ascii?Q?XsW3yV5QhAMbsICx920JBtPX5NUjEwMyrnd05u/a0X5re9id028XXN/+CRiA?=
 =?us-ascii?Q?l/E3LhbyNrqfIlWTABe5o2P8cf2FZqwI4fLdU23zkjtpbBclCebgumYzVTkB?=
 =?us-ascii?Q?h/eNzDw7br7ohe65pYqFqh5t9QVJziD1ZGmewaZ+rjgHhmv50d9fEegT4lNf?=
 =?us-ascii?Q?WxPu1lQGsnvebniu/DqfjEjJjJ+pRh0wBItrYlGevTT6f2dkwGdghdaC742h?=
 =?us-ascii?Q?Rfd0go8KyVwHL0p7jyCsh6fKKUnuGZc9oIjSW3Ed3/rhB5YXjB7t/t1WlvN6?=
 =?us-ascii?Q?SQxTipLT68tl+lKHYVyRpYxF6TNeKBESqBo85R4Xobrk8fbCcZw8XdmEEMGE?=
 =?us-ascii?Q?oaZRrEHh+mirxJt1GDWiIiIR90bK9Yej+jWJLzw0bhdLmUjLh6VEiy6jd880?=
 =?us-ascii?Q?5B4PFZw8vPh8PE5yjl+6Exk3anTaSn6W2O3EOwAV6iJF9xDLI1yp+mpcA0tq?=
 =?us-ascii?Q?xziN5HoVCqSuamQ8fv/jZLYeSVZWyYfd4p0knsN7QO/+l361mFtfYKJ/3LcF?=
 =?us-ascii?Q?8uch/iLN6D5o+lXGD0DKkHllcHF247yC2PWh6tBbMSRKgVYvyx+u3iiybh06?=
 =?us-ascii?Q?6BUPgluvNdbKBVaJIYDL+7umg7454bMtYOTPx5ZUT4o9BP0orfKTuUV7cmRH?=
 =?us-ascii?Q?vNLEIQmHi7ir8daXgOl5FT8Wq/YLhbmuWJAJheAaI24WmGRGAhEdAyfKktHy?=
 =?us-ascii?Q?N28n10MW3RNlgt7+Jw/Oi3z8mX5QgAx1szrNHcmKzM0HXH4Cwg0JiIGQurKg?=
 =?us-ascii?Q?we3+GkIgEpnvaLHIOOAL4TdDXKpN8q7FvOkl9vb62mHM+jLX0gRgt4lQoacd?=
 =?us-ascii?Q?jZipibPr3JvQCRrM3YJrjnYF8ZNF5APyzO+GvNOhHpWlnJPRM1Acnq611Q7e?=
 =?us-ascii?Q?MUmOldosX6ssuoyvDxgyc95KU6OpRNER3QCHhRwrd7NkjJDzCTvUH2pavUw6?=
 =?us-ascii?Q?NMyWc0h7AwSm8tgFkTp4tWZGVI7A2YdSBdrM3FElRqOKVYyE0dBIxSrULC3I?=
 =?us-ascii?Q?UVkDrl5iQGUTkfp1OwolVhB744Qmgj7xptcOsKVlNOmjLB4pWpmidBwknb6W?=
 =?us-ascii?Q?U/mFPPVaXVyylC0O305pRMz+pqMz0zz81Z1BUxYgWQKETTJa9mDgDBuDkwOT?=
 =?us-ascii?Q?FE+hFTiUBKqzhZCaEy2Oyu9AEZj8j8ym0Yug8IKMrMuDvXLIdLEmC6E4l5WZ?=
 =?us-ascii?Q?Kh+pM0Bhg3y48uLshWrBnmuxN3/OAx6xKfs0rHbP?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff41366a-54ae-41f2-d1b3-08dd78a5ab76
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7174.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 03:05:10.2744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9viymtp1JAJjzlW4vxdTXnT188oug4dpMPDR68/bKWZsuVVxovu4t6zUlpFYKzKXyd67Hp+aZ9epON0ml4RVNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8991
X-Proofpoint-GUID: -gNojXbv7lnuHJ6Ymgidrhw2Z_kkCqVV
X-Proofpoint-ORIG-GUID: -gNojXbv7lnuHJ6Ymgidrhw2Z_kkCqVV
X-Authority-Analysis: v=2.4 cv=QOZoRhLL c=1 sm=1 tr=0 ts=67f886ea cx=c_pps a=rPWB9DPlu1VaKM/QD/CSBg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=J2gJbEVsAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=74U5eOUEOvMof4zedlcA:9 a=Bt_igOxda4ASFyQEjNxY:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504110021

From: "Chunguang.xu" <chunguang.xu@shopee.com>

[ Upstream commit 5858b687559809f05393af745cbadf06dee61295 ]

Kernel will hang on destroy admin_q while we create ctrl failed, such
as following calltrace:

PID: 23644    TASK: ff2d52b40f439fc0  CPU: 2    COMMAND: "nvme"
 #0 [ff61d23de260fb78] __schedule at ffffffff8323bc15
 #1 [ff61d23de260fc08] schedule at ffffffff8323c014
 #2 [ff61d23de260fc28] blk_mq_freeze_queue_wait at ffffffff82a3dba1
 #3 [ff61d23de260fc78] blk_freeze_queue at ffffffff82a4113a
 #4 [ff61d23de260fc90] blk_cleanup_queue at ffffffff82a33006
 #5 [ff61d23de260fcb0] nvme_rdma_destroy_admin_queue at ffffffffc12686ce
 #6 [ff61d23de260fcc8] nvme_rdma_setup_ctrl at ffffffffc1268ced
 #7 [ff61d23de260fd28] nvme_rdma_create_ctrl at ffffffffc126919b
 #8 [ff61d23de260fd68] nvmf_dev_write at ffffffffc024f362
 #9 [ff61d23de260fe38] vfs_write at ffffffff827d5f25
    RIP: 00007fda7891d574  RSP: 00007ffe2ef06958  RFLAGS: 00000202
    RAX: ffffffffffffffda  RBX: 000055e8122a4d90  RCX: 00007fda7891d574
    RDX: 000000000000012b  RSI: 000055e8122a4d90  RDI: 0000000000000004
    RBP: 00007ffe2ef079c0   R8: 000000000000012b   R9: 000055e8122a4d90
    R10: 0000000000000000  R11: 0000000000000202  R12: 0000000000000004
    R13: 000055e8122923c0  R14: 000000000000012b  R15: 00007fda78a54500
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b

This due to we have quiesced admi_q before cancel requests, but forgot
to unquiesce before destroy it, as a result we fail to drain the
pending requests, and hang on blk_mq_freeze_queue_wait() forever. Here
try to reuse nvme_rdma_teardown_admin_queue() to fix this issue and
simplify the code.

Fixes: 958dc1d32c80 ("nvme-rdma: add clean action for failed reconnection")
Reported-by: Yingfu.zhou <yingfu.zhou@shopee.com>
Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
Signed-off-by: Yue.zhao <yue.zhao@shopee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[Minor context change fixed]
Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>
---
Verified the build test.
---
 drivers/nvme/host/rdma.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index c04317a966b3..055b95d2ce93 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1083,13 +1083,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 		nvme_rdma_free_io_queues(ctrl);
 	}
 destroy_admin:
-	nvme_quiesce_admin_queue(&ctrl->ctrl);
-	blk_sync_queue(ctrl->ctrl.admin_q);
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
-	nvme_cancel_admin_tagset(&ctrl->ctrl);
-	if (new)
-		nvme_remove_admin_tag_set(&ctrl->ctrl);
-	nvme_rdma_destroy_admin_queue(ctrl);
+	nvme_rdma_teardown_admin_queue(ctrl, new);
 	return ret;
 }
 
-- 
2.34.1


