Return-Path: <stable+bounces-95490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9279D91B6
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 07:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 196BBB2311F
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 06:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDF512CDA5;
	Tue, 26 Nov 2024 06:25:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8530E4C8E
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 06:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732602336; cv=fail; b=LPFze1PrN3/YbAJAqjZd7WH3RNsyoqzRZ0VIUpPuRSTtBjapGmJln4nW6ZWyzzb49t6M65/i280QASckUdelbKp7/Oq85SPI6aYmhT7p2iI6pKcrBdrFfaUcHYr7BTeQLEa2WQm6L0e9DyYdAr+bEOOIoO/3eJMaEJPzlcSEubo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732602336; c=relaxed/simple;
	bh=NXTdLpI1fclwAQCk2fAFUhXWT9CymbAeWM0bYAVCw+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ru4LxsGB4WT1wDZEJsp29+oW9NklaTcRe+BrabSByg59k1lkMB8uZ6aSQwRJ/iT0ci5tQRJ5HC92w+fklpoIvA1HrnwAC64HZ+xEiAU3AJ4yOPMgVUOqjnUxy/E2ppi+ModEr1leRSybqwf3j+NW6v6XvKQMM2vWjmhrxXcnfnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ526GZ009296;
	Tue, 26 Nov 2024 06:25:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433491axpk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 06:25:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q212Rnz7+OkzqGPbb8z07ZLrKmGZ5BxWMUwLIuRm14WSgmVh9Me6UMHMcClemZIZp+2kfxIy0czC5hJXfz89++xNv05zIslD1wm2PduY74CHB141TP7RYHAhzHjnqGe4qwicKBact5fAYiwVpspdHrADZALz1Piao4Y42ApZxQU8sWPqooHFYo4Rd62D950vG5lOLVzlY5Y3eM8Acq20XZ91hkZKHPH2uPQuR9ZgD0AQrQx4pbZa55Pfrz/gMZ/4sO+J5ZZz2op9H0yppzM+Yt3uGTXNlp8KVDyz2ExeTr8EtV+pdgccqyj3P01cp9cc77TwMAUzanrPMLFIm+VAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HH/V6YDAa9HJc1Bmc+sulmz12tFordRKjcd7cch7+pA=;
 b=ujTORCqcUHX2Dk/1hyMDcWl4zA1B+KAkZvXnK4sKP9Weovc9hSfAAykNIHLwy2cN+eigNpefmbylMDk9VfSZ6baXBgzK4Tz0F8/Yv3oOmia5RbSk2iKkKCnWj+R4bTvQpgSHRBbzQcp814UEZlo5X9M6BsjYA8nG8nFsg5XuzjBwMFshnD/idkRRj9WrlBiyCxh/uHaMBhFK05OSEFdKS+ifKDAbrBv3SQSkBWU7BC1Vm7fdszIv2HZpZmocSzbqj9msYmAQQc4tlJa7bogIZIweZ1gN724a2mt//v8jaFHmF5I8zRQwN8Sy5j3rQpQ1q25eU+vsvyoabV8829QpWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CY8PR11MB7171.namprd11.prod.outlook.com (2603:10b6:930:92::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Tue, 26 Nov
 2024 06:25:27 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 06:25:27 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: luiz.von.dentz@intel.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1.y 1/2] Bluetooth: hci_sync: Add helper functions to manipulate cmd_sync queue
Date: Tue, 26 Nov 2024 14:25:36 +0800
Message-ID: <20241126062537.310401-2-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241126062537.310401-1-xiangyu.chen@eng.windriver.com>
References: <20241126062537.310401-1-xiangyu.chen@eng.windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CY8PR11MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f9f219-85e0-43ab-8001-08dd0de31e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y4eX+a2AtlKgGUUiAHEwaslU/MhDY3QC+xfBbrOODl8JsE4K6wp78ZA86yzu?=
 =?us-ascii?Q?AeoQ39ocfRSBIlSNJOCBv2nLqWmDqD0261lDOryZDfLtWw+i4QYXLdelshoi?=
 =?us-ascii?Q?kF60OZYMLzxNa5eJdEEjWh+OBLcUV4Byi+BpqrNisVPtXELXZ8Nf4tfnAwYX?=
 =?us-ascii?Q?9GwEDaE0KCb0a6NwC6cgQvQdLHcqbLgrXenbDoRo4rBzFUNQNe/OTbGWwMT6?=
 =?us-ascii?Q?YIZArPF7e+EBP3BcYAri9RzV4gNvw2pKyUaFyS4tRF5IlSmL7jdyUePndMwK?=
 =?us-ascii?Q?JcvdWhym2T7dA/D21AleJLi8xzNeO+xS90NE6UOHc1NJZCHO3PgfyXR0NzmM?=
 =?us-ascii?Q?uobtM978VQBPL/SLKJ9q6soa7zYTTR15vS6SlJSeg0qT1TjOXSxShSuP0TJZ?=
 =?us-ascii?Q?VGM4/IYDBexWHlDYsin1b64lNqebgTHzDGncEAu8blWSfIG2YmQe7viGrYmf?=
 =?us-ascii?Q?Nj8RPTtolpSqYKaovmiUWviJzfqL72UbwxiSvQE5kPzlC7zPB6DvREYGHFJi?=
 =?us-ascii?Q?SdC54vv/c6yAxMfgfYPqODxM4EWwX0faQvxxwyEhID7k/5FMfxpj3y5cT+mj?=
 =?us-ascii?Q?m4WH5FLDlr9AmCshrpGdvMM+ma9RdpuDcpr0IsmFTYDau/WjeVwWgMuohB5P?=
 =?us-ascii?Q?ij7czK0rsl3erwJZ6WnwSO196Jtd3GQrdgB4S8pcR5QvFqOL0Za0GS5g2pjP?=
 =?us-ascii?Q?ciAsn3Z6q4IqVpFLWMc1btbyZwb/2BjtEZrnFsQk/f4FEHb/mA2O041Na7sT?=
 =?us-ascii?Q?P3jM6ilSj50qKqyQsyoNFwWixKXFtRu7nptCfkMOhLeFakSl7v8HO6K3zRdw?=
 =?us-ascii?Q?CBcpeMBXD/cShbilwAkO8KgJkfBbCM7yTgpYC2o5y4gCpSn/YzTxd7mij9u1?=
 =?us-ascii?Q?OgRDkx2H12vHJ3nPClVtdlnXvVZl4kvuYNeHvp9/NxO3493SkAcB/Prl+ebc?=
 =?us-ascii?Q?JWmG5GLYf824BQ/3rQ7LeNYjsTxY8O/s9DSWNBNDxQ1jDByXe0hyMvQ2HczU?=
 =?us-ascii?Q?V9kjcs8lWU91MNpZNm/kUvvQGQe1B1urQWRvIW4yOlnmBUAxu/yH9l+AN0BC?=
 =?us-ascii?Q?Q/TebiTY55rCyLfWEJLhsURtT5YWh36JW3szDygpDSEbL5qkGoTj188m2FzJ?=
 =?us-ascii?Q?AzonopRyE7gCSbhK/5y06Mb6NvKtbr/jmaMjBMk8id5aNI3RUBmfmISe/3kw?=
 =?us-ascii?Q?8GL0T62RNYBPDHRawBpdyyzxlhe09EFWqZNLL1PFiMMABhbUEpUSkIOL1vYY?=
 =?us-ascii?Q?Vun1KDnlo9bj4X6GUmy7vamBscFX/xFPqbDEbjCpUAgE76SPM5tWZc2SxGTN?=
 =?us-ascii?Q?j2xqPCZzIXusbK5opmLVFC7vD9nzOrEwLKtAMbmUpgITvKscO9llFjnhQgtq?=
 =?us-ascii?Q?l0ufGWn6r4mzwrwczRO90CmZsmaDXC8iwZsIf9fM1HJ3IG9NLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SCBBCvgOdRYmxJufFU58WYq0JCYG0s2CNQAFmPvj3ra4yfTnVbGWwXIIL4Lh?=
 =?us-ascii?Q?LgeAH6Rayj4aON89dPJRj03Cib4fuNA5bRSgyqdVe3RfQlVrppJ2Ft3LOu8P?=
 =?us-ascii?Q?u4WfLkvI96CRV/m7yqxnzC3ZHEoUvLLCuMnATSnHZgmluExoDrgYbhiwXNnZ?=
 =?us-ascii?Q?g4yKhpzo9btlS5QCkP+7jDG34YUhe7jnJsB5b7JD76Y6OlufUyzZNaemG2G5?=
 =?us-ascii?Q?P1NBfgSXvvicP51wlA6D4QJHwk5wXRi+G6c6odUqmfYdWxdd/w7uiGTNQDjd?=
 =?us-ascii?Q?Agd4ca4GRnlcLt79uAW6xsS/6oLnJlfD+pludhLVTM/+ot776NJs9DtnElsQ?=
 =?us-ascii?Q?xb63tVGPTh2YLG4cyH/wx08UjwBLDNG3xyF2xSjz9DpAZVsLnZBHbkFTpwHs?=
 =?us-ascii?Q?MgEjCNUUvJlW8J8y9JXX68TRt+oLoAo+H3Nuo/TbfMnnw9tiffrqin+gTUeg?=
 =?us-ascii?Q?IsSDqIltLxYHAJNCWvUPQYcmleoW3BpyNcgBBLzpi0W9x2eMI1JXwQOUM1KM?=
 =?us-ascii?Q?Ad+1Dx1s/ZoGFyhYCCqkSQIN3t13iVhMtmew8FXOx/keh93wuWlN/CcEPIhI?=
 =?us-ascii?Q?edx6uHnWUv0np8B7zQ7eoVyW5eHdlcQVEAe8aSxXLzzOh1ktlcq22Ibxx483?=
 =?us-ascii?Q?3YXovhkBIRMFkVSaH2Ntzooe353T4+/uGkmZ0ZPlNpN1Bedm2+0Zqs/dCF9b?=
 =?us-ascii?Q?C0+IIX1GBm9CNfiFGabooAMycJxYXPoee/Khd8Acw+N3vGoVTYvHUEUM31Nc?=
 =?us-ascii?Q?0l6brWfiVEqEPJjeZagEz0/4KfUAuD3dDUECwclR5DFJxl1nFuhmZYgqr3xX?=
 =?us-ascii?Q?DDkdiyUJ7ZgEsHKJ4gGD1ThUTwoHDnSQGHtFSzEnJATOZjStN3zDb0GFlLCT?=
 =?us-ascii?Q?4TezUhF0NdzVQ06dN/+OEQo/IzyHadTfwzGoEdgvFgpsNvWUO+Qa17f5RAv2?=
 =?us-ascii?Q?h7UD94x/RJsYJp1l/lpktMdws/4b9TSKN5+UROybA4UHIN/iQtvjeNxInLU6?=
 =?us-ascii?Q?ZpBleKbpYcd1uYV4cuKGkTOdYw94X1LLYjreSGHk0xKMvf+ho4sWpoDb40Jh?=
 =?us-ascii?Q?tmrMQinrdW5Xk3F1G5zDpING9r9XCu44HpX5GkagmJG4G6r5glirxLJvow7c?=
 =?us-ascii?Q?0X5dI4Z3tUMTH8Z7FE4+tfqeg+vQxwjTC5Dr/5JT8DTxw3mFomibT/8Rxjjt?=
 =?us-ascii?Q?wsVG1y+WmepFX97fPVo/u4Vw63IP9W/7v4Krtivu7c1/NF9gu77J5wu0xN/z?=
 =?us-ascii?Q?ksPBCP9mVKTxcJ2KrW37gbVNRIlYmaxDmOiIyAHzufy3S4PXEOpl8vEl0Abb?=
 =?us-ascii?Q?7YsBWZH0B5s9mn6YPMtrLb0Xf9ShKI7ZdzXJCJMR8aMticv6kKKoWWoqdvAp?=
 =?us-ascii?Q?mamzKzMrw1e4UNPeyLqKMXtnmuhyJYtRO+GhyCoyw8DS3N5arNpiSW9xAsF3?=
 =?us-ascii?Q?+RRMY0Gl8auV2wkPdWy9IA2fL29PF0mx7xb5fzjcnepz3uiP4rXxcm4+/ySq?=
 =?us-ascii?Q?9IFWnR2rZbUYTF3olc1IlDUqxMHCQexQIH9RNju8CikzC8SsGcijWlIdqRv7?=
 =?us-ascii?Q?ivRZl5A5wugVXIX0S+lBD5B6LQUfeS4qQOpEjX0fGLo5vO4f066qdi7lWzUK?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f9f219-85e0-43ab-8001-08dd0de31e6e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 06:25:27.8322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hqgWbZeGgB2iFboslfAZrWqFYOSsDufORQuuNgftFiQMEqZIJpP3B9NFu3N10AhHytq3ikKjJR1Pb8IlQo7IUOQ79ti07U7xUjEF3xIByw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7171
X-Authority-Analysis: v=2.4 cv=W4ZqVgWk c=1 sm=1 tr=0 ts=674569d9 cx=c_pps a=ybfeQeV9t1qutTZukg5VSg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=QyXUC8HyAAAA:8
 a=t7CeM3EgAAAA:8 a=ThQq4DznOBhjBfZMlfgA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: ww8MjFuwu9JLr9fyvM5S46yOW9MwsZ6z
X-Proofpoint-ORIG-GUID: ww8MjFuwu9JLr9fyvM5S46yOW9MwsZ6z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_05,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411260050

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 505ea2b295929e7be2b4e1bc86ee31cb7862fb01 ]

This adds functions to queue, dequeue and lookup into the cmd_sync
list.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 include/net/bluetooth/hci_sync.h |  12 +++
 net/bluetooth/hci_sync.c         | 132 +++++++++++++++++++++++++++++--
 2 files changed, 136 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 7accd5ff0760..3a7658d66022 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -47,6 +47,18 @@ int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			void *data, hci_cmd_sync_work_destroy_t destroy);
 int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 		       void *data, hci_cmd_sync_work_destroy_t destroy);
+struct hci_cmd_sync_work_entry *
+hci_cmd_sync_lookup_entry(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			  void *data, hci_cmd_sync_work_destroy_t destroy);
+int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			    void *data, hci_cmd_sync_work_destroy_t destroy);
+void hci_cmd_sync_cancel_entry(struct hci_dev *hdev,
+			       struct hci_cmd_sync_work_entry *entry);
+bool hci_cmd_sync_dequeue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			  void *data, hci_cmd_sync_work_destroy_t destroy);
+bool hci_cmd_sync_dequeue_once(struct hci_dev *hdev,
+			      hci_cmd_sync_work_func_t func, void *data,
+			      hci_cmd_sync_work_destroy_t destroy);
 
 int hci_update_eir_sync(struct hci_dev *hdev);
 int hci_update_class_sync(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 862ac5e1f4b4..b7a7b2afaa04 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -650,6 +650,17 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
 	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
 }
 
+static void _hci_cmd_sync_cancel_entry(struct hci_dev *hdev,
+				       struct hci_cmd_sync_work_entry *entry,
+				       int err)
+{
+	if (entry->destroy)
+		entry->destroy(hdev, entry->data, err);
+
+	list_del(&entry->list);
+	kfree(entry);
+}
+
 void hci_cmd_sync_clear(struct hci_dev *hdev)
 {
 	struct hci_cmd_sync_work_entry *entry, *tmp;
@@ -658,13 +669,8 @@ void hci_cmd_sync_clear(struct hci_dev *hdev)
 	cancel_work_sync(&hdev->reenable_adv_work);
 
 	mutex_lock(&hdev->cmd_sync_work_lock);
-	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list) {
-		if (entry->destroy)
-			entry->destroy(hdev, entry->data, -ECANCELED);
-
-		list_del(&entry->list);
-		kfree(entry);
-	}
+	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list)
+		_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
 	mutex_unlock(&hdev->cmd_sync_work_lock);
 }
 
@@ -756,6 +762,115 @@ int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 }
 EXPORT_SYMBOL(hci_cmd_sync_queue);
 
+static struct hci_cmd_sync_work_entry *
+_hci_cmd_sync_lookup_entry(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			   void *data, hci_cmd_sync_work_destroy_t destroy)
+{
+	struct hci_cmd_sync_work_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list) {
+		if (func && entry->func != func)
+			continue;
+
+		if (data && entry->data != data)
+			continue;
+
+		if (destroy && entry->destroy != destroy)
+			continue;
+
+		return entry;
+	}
+
+	return NULL;
+}
+
+/* Queue HCI command entry once:
+ *
+ * - Lookup if an entry already exist and only if it doesn't creates a new entry
+ *   and queue it.
+ */
+int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			    void *data, hci_cmd_sync_work_destroy_t destroy)
+{
+	if (hci_cmd_sync_lookup_entry(hdev, func, data, destroy))
+		return 0;
+
+	return hci_cmd_sync_queue(hdev, func, data, destroy);
+}
+EXPORT_SYMBOL(hci_cmd_sync_queue_once);
+
+/* Lookup HCI command entry:
+ *
+ * - Return first entry that matches by function callback or data or
+ *   destroy callback.
+ */
+struct hci_cmd_sync_work_entry *
+hci_cmd_sync_lookup_entry(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			  void *data, hci_cmd_sync_work_destroy_t destroy)
+{
+	struct hci_cmd_sync_work_entry *entry;
+
+	mutex_lock(&hdev->cmd_sync_work_lock);
+	entry = _hci_cmd_sync_lookup_entry(hdev, func, data, destroy);
+	mutex_unlock(&hdev->cmd_sync_work_lock);
+
+	return entry;
+}
+EXPORT_SYMBOL(hci_cmd_sync_lookup_entry);
+
+/* Cancel HCI command entry */
+void hci_cmd_sync_cancel_entry(struct hci_dev *hdev,
+			       struct hci_cmd_sync_work_entry *entry)
+{
+	mutex_lock(&hdev->cmd_sync_work_lock);
+	_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
+	mutex_unlock(&hdev->cmd_sync_work_lock);
+}
+EXPORT_SYMBOL(hci_cmd_sync_cancel_entry);
+
+/* Dequeue one HCI command entry:
+ *
+ * - Lookup and cancel first entry that matches.
+ */
+bool hci_cmd_sync_dequeue_once(struct hci_dev *hdev,
+			       hci_cmd_sync_work_func_t func,
+			       void *data, hci_cmd_sync_work_destroy_t destroy)
+{
+	struct hci_cmd_sync_work_entry *entry;
+
+	entry = hci_cmd_sync_lookup_entry(hdev, func, data, destroy);
+	if (!entry)
+		return false;
+
+	hci_cmd_sync_cancel_entry(hdev, entry);
+
+	return true;
+}
+EXPORT_SYMBOL(hci_cmd_sync_dequeue_once);
+
+/* Dequeue HCI command entry:
+ *
+ * - Lookup and cancel any entry that matches by function callback or data or
+ *   destroy callback.
+ */
+bool hci_cmd_sync_dequeue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			  void *data, hci_cmd_sync_work_destroy_t destroy)
+{
+	struct hci_cmd_sync_work_entry *entry;
+	bool ret = false;
+
+	mutex_lock(&hdev->cmd_sync_work_lock);
+	while ((entry = _hci_cmd_sync_lookup_entry(hdev, func, data,
+						   destroy))) {
+		_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
+		ret = true;
+	}
+	mutex_unlock(&hdev->cmd_sync_work_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(hci_cmd_sync_dequeue);
+
 int hci_update_eir_sync(struct hci_dev *hdev)
 {
 	struct hci_cp_write_eir cp;
@@ -3023,7 +3138,8 @@ int hci_update_passive_scan(struct hci_dev *hdev)
 	    hci_dev_test_flag(hdev, HCI_UNREGISTER))
 		return 0;
 
-	return hci_cmd_sync_queue(hdev, update_passive_scan_sync, NULL, NULL);
+	return hci_cmd_sync_queue_once(hdev, update_passive_scan_sync, NULL,
+				       NULL);
 }
 
 int hci_write_sc_support_sync(struct hci_dev *hdev, u8 val)
-- 
2.43.0


