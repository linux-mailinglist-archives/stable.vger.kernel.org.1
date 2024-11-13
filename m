Return-Path: <stable+bounces-92887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF369C68E6
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 06:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E5D1F23717
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 05:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B562816BE0B;
	Wed, 13 Nov 2024 05:50:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7D52309AE
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 05:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731477055; cv=fail; b=r4uVsakKoZw/ciYYmW6MjPV7indtL14x/eKV+50EoYpCt4LipOrSXjs/aXcxZNXsLHyXDzVbC6Ny4MhA9ZnDUQYkT4kXnOls4/fPn2QuUMbSRF7PnYxEVWxAynhGb4g5WYiSMIhIEDamHmGrodj8LsiAYl5wr04VfjeQt4QiLkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731477055; c=relaxed/simple;
	bh=fKAj1tjCV6JRMmyeBu+JdOeaoH35f+WCrV/uz2ALnQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IILSEXSG5qVFASCvus5ArmjXn6r+bw4iB1I6BkqPOkvWN9eh3EsZ0ZkIesaxI7Lfgb3+AEy2ei+Hh0PWM5P1CVKqppGqrHj2hLwaEY1zMlMagQFDzQfjgzc5q7pbKc0HvHETmg3vQGsijRiaIn4NmIplvjuGdj56DsboV5yTRko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD5fHSW017149;
	Wed, 13 Nov 2024 05:50:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42uwtu9jxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 05:50:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXK2nMVEG3+MKNQcGhaVwBr65lYWEFzrXwCEPQDnIGnnc4622GKXezHvM2TJu4JlSEKFaXr9NRBWRhVTXsVJzCI5ANUSuKu0tMeoZG4oGSDyVsLXedh6vawWSH63ejIeg0MefiT1BoZE0h9+XEfSRVMmOwRYWvm7nSnlIbpeZ1YtgQnv758nZX1LjeqPSDvz6vaj737OhaEVQtZo1Tv95ByyKgxlrmVU1XB1wqTwjvATxcAVugJVGfpjEI5gZOMjQxYD7t4OQzxBpYaME6Y89Bv8RX0tyIuUcQUif4rc/m7qh9PR+Y8Oif3p7rFba4o9TRElsH5oBBwbAv5qhUAJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aq2ujuyavCX8k5YuZmLYMbZp5FJFQukcPCEoFM+kEcE=;
 b=mkeqZDJvTxvPJNUmKSOEPlqLjPQAj+o9rOH+oAcIdS9M6ogBIiWk4tnPdAwS4gHe2mhWVIRSYoH9n8DnYlI467ObW2UMrZhMUpKiwZbHIWfS4MzY54RvkoHijJcHZ6+0X+jTCjBPs/TAFmCL/IrvwD0n6+0DNXF+44agbQjkr+co5oOIYwjwjp/bxXyuGeHgpQ2TYp/PmMhlO31bCBHwQYfqS4x/jPVVi1gNqFxn2JDtcBWhhRRTSSSkBoGZ74Fc9Ihp+fE3LFJrDAt3kmOiehRV8GFC1dRI2MOKLX9SqyEwLgUSk39AR94pb5o6/ZL8BMNzTu56B1WwpA645wSQXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DM4PR11MB5971.namprd11.prod.outlook.com (2603:10b6:8:5e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Wed, 13 Nov 2024 05:50:27 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 05:50:27 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: luiz.von.dentz@intel.com, sashal@kernel.org, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1] Bluetooth: L2CAP: Fix uaf in l2cap_connect
Date: Wed, 13 Nov 2024 13:50:35 +0800
Message-ID: <20241113055035.1188997-1-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0092.apcprd02.prod.outlook.com
 (2603:1096:4:90::32) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|DM4PR11MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c3a149-605c-4626-7ede-08dd03a71318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/STrejScRzBjN6NXI9/0nPejW59uWa1mJLAWobcV84jkPh+zujbnIP2/LTHG?=
 =?us-ascii?Q?SQH3Xzv7NBuI3ipVqd6uukDK9WYQGQAVztp/jcbBA2pJhlWh2wA0KqyVatqQ?=
 =?us-ascii?Q?SkEm5uWmAYod3hcTcodlorb6v3WcuqEq5CyMTRGSdL66kL5nf/xaNy1OYR4r?=
 =?us-ascii?Q?KuNvTcehTVwtgvkte+dAGEKns0HcyVUd8yERmDgCkj3Q05G0f5grwLLnvG1c?=
 =?us-ascii?Q?2K5yZjNHv9f4WnGkfWDfYCIyeTAsWo7dtQKyZWxMlH626lk+B3D3z0OL7rXQ?=
 =?us-ascii?Q?HC8Rujm090BkrZj9HKrSocEhJIk+s4jdKJkp467iB/xQZe1+Zft6Gyd4xa60?=
 =?us-ascii?Q?+DRDpL6B8xkUfXpj9lg49ejPX96nX57JYyV0QiryHDhFQcG38NwRHSfFLAfp?=
 =?us-ascii?Q?NneAMxA4qXHyT5FEKVT3KOuDm2IcijDKU8MUs9agW4WLXIH4LzChKXCvMRxc?=
 =?us-ascii?Q?IgG/C7nBFIkErxkwfngZeDXaEO1AC/M0Az0MReNFtH/nOamPLB4ESQ3DVaEY?=
 =?us-ascii?Q?aHfrn8qBN64PSZZRCdtjNoQPlvREMeaCuqafaMJfqNKuvr8XZnjCFEk7tGnQ?=
 =?us-ascii?Q?kjWBrVkvetAA3HTIWWTGN0b1sKGYAiMOWZym+BXy44MRKYg2xI97BymxWvtJ?=
 =?us-ascii?Q?ImS/0Qw9JdURA9X21MkpvEYJur4OibSko+tkhZmRrpmnGZZbOVPW7yntcgw6?=
 =?us-ascii?Q?ehKGFi8AnqOQIr0uH92E5dLLiGbgGszd2FPxUjoz5FYQRIjZMPMiq1mzpwi+?=
 =?us-ascii?Q?l4NDKozco/AC1LPgDW4/jNdiWKGHOzVxjsF1Gn5URa9lb0cOm+8wtY1KeOT+?=
 =?us-ascii?Q?1hptqAvPRIfJ9fDjIXUEju3Y2lnD6/kPR6RjPWbYGf0kPZgSaZkA2dUw8rRg?=
 =?us-ascii?Q?aryV9w/nEgA4ySKlObj84ERnj6ug/wDuS0qJVZPpE04Msjcy5+9vblcWwOsJ?=
 =?us-ascii?Q?oygzhYanD+l9jrEmivfG8lbB9FYOZ6RkVCO9u611mpDp5/1caG823ICC3jp+?=
 =?us-ascii?Q?eOxqL7/5/bLelNbHgcPs6Y3xniAOmUStBLnszjofnaMz0NzchtQqe/EXju4A?=
 =?us-ascii?Q?jXNUJowlCGMGGZTyyyN9A+zFvQFpujRA+Z5augWfSZ4DBIzKWNRhmLMv7RH8?=
 =?us-ascii?Q?TNPPn9JmuY+Q68TiBOYUlH54VfeGITWkD0797t+MW6zVklJBWHJ6Ox8Z45aH?=
 =?us-ascii?Q?J+kH+Z3dN0wgCEtxWJKvdBiekMk27QtmUOAwtPM8YlGRq7Ruq2CmbLIIAJ4b?=
 =?us-ascii?Q?WS7mI64tqI04+IuXlLKYwr0FYMQbsIUgEDf/sl6kwP9TrgVjUJ2mx51iywd5?=
 =?us-ascii?Q?Ehg+OMnzBc9DFr8rBVx+gL8Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vfn/38gavEbEmJrrD2HFJMd47Qn9DKmJILCzFZj6SX6kDxrWThRp5jw+3EJq?=
 =?us-ascii?Q?XbRIHZhn7L9s20lMGXD/lnH3Z/4OyFcqLvdBxOwSVzs/NJE9pXqKZyoUBOw3?=
 =?us-ascii?Q?gNgcwbC4NZJ6f9fJm7mJfpP1a7evjN1oP8JTovmtVe1b/n+cRTIvLCgy2foE?=
 =?us-ascii?Q?OYYsKiPzkNwihSLutWqG5GkfHJYiUP2f3mC4/htjyCwesCoTytv6VTiwXRBq?=
 =?us-ascii?Q?NjVjFfAKNal3gG5eNlFVx0C6uWcJhmqwLpfc4eJGZhItnnQXSBUqWj6NKEOy?=
 =?us-ascii?Q?jKHDe3v2ddhFhCCd0LpVHpiJUGJ/m/FyF76LwlzqOldglIiVbZdwIJ2uJBZk?=
 =?us-ascii?Q?vs7rTenJngmMDawUxx4KNb22kazLM3p0O84u/XMLiN2Cu/VpAgNtHwZaeBZT?=
 =?us-ascii?Q?YA7xvPzHPfJM8pPbInBRx+TOlUVcJTRrMivFb6rZz6tm3WC/Sr3XuaX3VgZJ?=
 =?us-ascii?Q?w6sTX2n3pQvoEcsBSYgQy7sWXr3lO/nag3Sg5lHA0dhz8jO3ANWJHIRuP4Q+?=
 =?us-ascii?Q?BhECGwvWG8fhi2A46PdTzmeGwHlHEetewQ3hVaf8QoSY3KGgxsOxx77iiEYo?=
 =?us-ascii?Q?wOtLOr5Ho9iSTfBrE8jD7WMLEvS5xLdK4eRrvwBZFlK53fXVVZv/JZy7793o?=
 =?us-ascii?Q?9qwOsD9zw3+SlalicEdwVparJVqe0RhP+XrXKhX91hL2nQMm0/kZ6DwOagco?=
 =?us-ascii?Q?CWDqhJp07opgfCJZ26vJzm1ioxmsH/dTCgx/m/rbD5Cc/BkkFz2TqMQ2oBU2?=
 =?us-ascii?Q?3eam2/4++v4sBAPjOlvCvzVrTxM0AwNgK3ib22ho6/Yj1w+o6t0Bqh+OQwuG?=
 =?us-ascii?Q?z+ITqPvCX5tJchAO7+AI2GsPczxhREP8xJti+Pk2HaxQQm6bcTyUbzywmRrY?=
 =?us-ascii?Q?M7ZjXfIpDzJ/mjzK3nVm2uib2PE2BuCFTJKO8sk5yLHD8gz+eX7KgvmJPQbi?=
 =?us-ascii?Q?XJ9KAqU/1UprlFLKpsfaxKoRb2ezq3v7ODfV41c/bxakRyGUgBk0rpUXr5CQ?=
 =?us-ascii?Q?a62WpEEX3xG5qhlzrki3O7Jwu6Hc8F/H9GftBXiumIF0KnrusQriR5U7T0/I?=
 =?us-ascii?Q?k1IKoyTgv7EcRS8DvnqjSMeqISHfkcoyPCJrKIo73MQPK4p7cffJR4X6NtYx?=
 =?us-ascii?Q?05sCxjddBVaB+xkY0oZBWvJbPMGOvZoIb1e58rLYfNLZbVczycfxRljsWsBJ?=
 =?us-ascii?Q?FZ/UcvNcUA1ZUKF9BqtJXOEjX569KcuV2r4eR6lbJddDjhxzss6xEspb/SOb?=
 =?us-ascii?Q?jMonA5rGb1y9413fYyec4JuCbBZCzukz9Zg2FwvUoXwpRZjjS2CSNPhPGoF4?=
 =?us-ascii?Q?txOJ4PajDrg7BjUXG75a5r3XFEzpk0VSl8SjYdGOLdP+3yFwiIuR1TXyUUUD?=
 =?us-ascii?Q?Qimpzw82twEV+wP9bU65QGM2x0ItNKl2qzcn197IrDb7xkZuuBh7xW4yhAzt?=
 =?us-ascii?Q?j4BB0X87gOBjWOazy+wK3nyfcfikXv1ZD4XD1wwmIQ0ePMSh8xdPm1wDr5CW?=
 =?us-ascii?Q?8j9F94uNqZf1ORiE4nBn3CkxV2ag3g9zS/zMYmoiYP97+GJcAe6ajguzXiov?=
 =?us-ascii?Q?Hvqu57KHTLOgrAUlsAmI7ix7FrQHE3wA7x7gm2FBi6YqH+zyVnRCDHHtKoKH?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c3a149-605c-4626-7ede-08dd03a71318
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 05:50:27.3004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbZIb6skePxjjUdPt9EcssWyaKt4W3xj9hpVymS85JLYEj26U2Kf4zHbuUfwJoVLP2RJIZTZ0kpHZzEZyuyiAd2xEvJr80vvR92reAaok7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5971
X-Proofpoint-GUID: rlO78Ij553ggxwbmTWEkHk7I7XyoKcfl
X-Authority-Analysis: v=2.4 cv=BPnhr0QG c=1 sm=1 tr=0 ts=67343e35 cx=c_pps a=2/f09Pi2ycfuKzF0xiDRrg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=bRTqI5nwn0kA:10 a=QyXUC8HyAAAA:8
 a=hSkVLCK3AAAA:8 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=g0madpK8VFEgJAoBwicA:9 a=cQPPKAXgyycSBL8etih5:22 a=DcSpbTIhAlouE1Uv7lRv:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: rlO78Ij553ggxwbmTWEkHk7I7XyoKcfl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411130051

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 333b4fd11e89b29c84c269123f871883a30be586 ]

[Syzbot reported]
BUG: KASAN: slab-use-after-free in l2cap_connect.constprop.0+0x10d8/0x1270 net/bluetooth/l2cap_core.c:3949
Read of size 8 at addr ffff8880241e9800 by task kworker/u9:0/54

CPU: 0 UID: 0 PID: 54 Comm: kworker/u9:0 Not tainted 6.11.0-rc6-syzkaller-00268-g788220eee30d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci2 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 l2cap_connect.constprop.0+0x10d8/0x1270 net/bluetooth/l2cap_core.c:3949
 l2cap_connect_req net/bluetooth/l2cap_core.c:4080 [inline]
 l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4772 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5543 [inline]
 l2cap_recv_frame+0xf0b/0x8eb0 net/bluetooth/l2cap_core.c:6825
 l2cap_recv_acldata+0x9b4/0xb70 net/bluetooth/l2cap_core.c:7514
 hci_acldata_packet net/bluetooth/hci_core.c:3791 [inline]
 hci_rx_work+0xaab/0x1610 net/bluetooth/hci_core.c:4028
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
...

Freed by task 5245:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4598
 l2cap_conn_free net/bluetooth/l2cap_core.c:1810 [inline]
 kref_put include/linux/kref.h:65 [inline]
 l2cap_conn_put net/bluetooth/l2cap_core.c:1822 [inline]
 l2cap_conn_del+0x59d/0x730 net/bluetooth/l2cap_core.c:1802
 l2cap_connect_cfm+0x9e6/0xf80 net/bluetooth/l2cap_core.c:7241
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 hci_conn_failed+0x1c3/0x370 net/bluetooth/hci_conn.c:1265
 hci_abort_conn_sync+0x75a/0xb50 net/bluetooth/hci_sync.c:5583
 abort_conn_sync+0x197/0x360 net/bluetooth/hci_conn.c:2917
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:328
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Reported-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
Tested-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
Fixes: 7b064edae38d ("Bluetooth: Fix authentication if acl data comes before remote feature evt")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu: Modified to bp this commit to fix CVE-2024-49950]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 net/bluetooth/hci_core.c   | 2 ++
 net/bluetooth/hci_event.c  | 2 +-
 net/bluetooth/l2cap_core.c | 9 ---------
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 993b98257bc2..3039dc5fbe75 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3859,6 +3859,8 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (conn && hci_dev_test_flag(hdev, HCI_MGMT))
+		mgmt_device_connected(hdev, conn, NULL, 0);
 	hci_dev_unlock(hdev);
 
 	if (conn) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0c0141c59fd1..e5ca2d188c1a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3789,7 +3789,7 @@ static void hci_remote_features_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	if (!ev->status && !test_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
+	if (!ev->status) {
 		struct hci_cp_remote_name_req cp;
 		memset(&cp, 0, sizeof(cp));
 		bacpy(&cp.bdaddr, &conn->dst);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 209c6d458d33..187c91843876 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4300,18 +4300,9 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 static int l2cap_connect_req(struct l2cap_conn *conn,
 			     struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *data)
 {
-	struct hci_dev *hdev = conn->hcon->hdev;
-	struct hci_conn *hcon = conn->hcon;
-
 	if (cmd_len < sizeof(struct l2cap_conn_req))
 		return -EPROTO;
 
-	hci_dev_lock(hdev);
-	if (hci_dev_test_flag(hdev, HCI_MGMT) &&
-	    !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &hcon->flags))
-		mgmt_device_connected(hdev, hcon, NULL, 0);
-	hci_dev_unlock(hdev);
-
 	l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP, 0);
 	return 0;
 }
-- 
2.43.0


