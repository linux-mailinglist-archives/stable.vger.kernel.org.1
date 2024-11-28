Return-Path: <stable+bounces-95688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9BC9DB3C5
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 09:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A8A2825DD
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 08:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A0B14B96E;
	Thu, 28 Nov 2024 08:30:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BFA149DFA
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732782600; cv=fail; b=baeCO1moPpVyQ2ONY8y0BT2nuBBkTqPMqSScqwZjf3M3uQx4kKJPmEknn/y0Dg5qdTWyQZs+D1KJmGlfeTWMC+HkqqQHzytHAX0Ar8R5F0jkGnat6Y9ihtbKEfZunRgAqM2/1ljgfi0bJYPKvZ1iJeY0SzLb4L3KMKXEYVDCf3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732782600; c=relaxed/simple;
	bh=IpgFoZeOwN48+l+yARt+ga86czZQn5F3yVKYYKwzim4=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AzWAnEM5Kxh/tFO11oxQB1XH9plBMdUnyw3RG598hGCCQAJBxoKy8PpA/WM82CQMLWplEfiT19XRSkbW4z8vhvoae6FBGGgIuJ5GTLonDZsnYvHGn/LzFjqsg52KX/z+4v619V1y/DNj493CCkCLsgjWzF9p5YoTTVuOmSYznoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS6wpck031387;
	Thu, 28 Nov 2024 08:29:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43671b0sqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 08:29:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+FCcnrLF5VHwFCIgru1kx4VO/9WjTM+BVrZ6rlJyDYJfT7h0hlPuHvKtKDiFnxia0xhrSJtg/wRvqI1Wu1w/T+BJJkq9Q/w9ePToK8Fn7Y4y1b3YiqceeuGVTTphEWwI7kr4fyJ1Xx4HEsJEMvSmN1X0iufpPReUwW9A02ju1D3g/oD1MtVRwnUczDhneMHKgi29RfyauKRKb0QjrrDuqCuZoxX5Oez1V0VKXUqtrcf6wY7s+puTGQEaixCV+W9XI+W1B4CrJEFo1dZPC23VMoE3ab4so3iXPGmdoJd1DJk0/iLGL9YZWxaZnAKkj6hjz3P7GUk/eQbShiIAozQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rufYzzK0wwzbEem/HbMLvfbOqcXL4FDu/tBURKaW7xk=;
 b=vnUsqwCwTLDSIXWJosgB71p4Wo2FRv4aYEkXYF8601sevR7qDTU75OOQUfPepUko/Xq8+f+BvLA7bKaW+W98HFZTMW0FlU7l44RKY1KG4sgNPO47nIHaRZ3JBrVMEAXo5Y702iDDN9TvPEWn0Qhvgh2fdkJfvNBhWF1A2FhUcIjdnIP94Rv6n+xYODRMWua97UyOJCbNAE9REluAtZMP+Fiqhopiatn7/m/eB1UTSnnSrG5wSuEuRcI0f926wdEcjSMUj5AzxXTdt79EpL7Vn0ArnUIiE5/6fRfGzVagcj3sE8FmxOegkTAkxq0ZFqFO14N4IHiXdVvx03oNPD1xzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by BN9PR11MB5259.namprd11.prod.outlook.com (2603:10b6:408:134::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Thu, 28 Nov
 2024 08:29:47 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%5]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 08:29:47 +0000
From: bin.lan.cn@eng.windriver.com
To: stable@vger.kernel.org, jason-jh.lin@mediatek.com
Subject: [PATCH 6.6] mailbox: mtk-cmdq: Move devm_mbox_controller_register() after devm_pm_runtime_enable()
Date: Thu, 28 Nov 2024 16:29:30 +0800
Message-Id: <20241128082930.1988659-1-bin.lan.cn@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0239.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::35) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|BN9PR11MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: b36d4d8c-e049-4397-2297-08dd0f86d13f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5E4Fygg+4XJyjR62yBMe/lhNE/GhlVNLtwmUd3xJpVAEeBQxcGtfztFIYF1k?=
 =?us-ascii?Q?PnM4hLgmccCj7PZBt8T5SMW1uhSbqCNHhRgef4LpJ2VPSgZafT7Y0E4tT9oZ?=
 =?us-ascii?Q?7NZPr85/n5P3XxqooB8H8Ij2Lhh+Cf23FdadJxkf+pUmPJ36uTsCZSA8jbsg?=
 =?us-ascii?Q?Qri8iU/S5nTKWAjdXucZZnTE4B2nCQQMPxOHObuF5ebd35z6ubcgcpYojFp3?=
 =?us-ascii?Q?Dl1aLNJB8THHvzvGfgZ6vYrJoAbouhBVPA0qrOqi78LewTq84e8zbZMxEyJZ?=
 =?us-ascii?Q?r16XvYmo0qQ3yiri9Xx4p1Y81q5J9veWCbhFsV2mj94p0l1dlnmbtm69a6w5?=
 =?us-ascii?Q?+2JtoMoENKasjtSfScoGQmlyDV79WenzynsQk8OZT0fTEsgKhONbgZcn6sTO?=
 =?us-ascii?Q?nrGqvNYlakQ7h1cRKYDAEaQUAY6XepnEncq/2dtKVTTafoc+MQtN/Qjs/Fpv?=
 =?us-ascii?Q?gmoOICTJlkjJ3jMp4Qwewj0DJjeaUH9Uk4/KvF5r91gvdvRmHfRAviuan0Ta?=
 =?us-ascii?Q?r775NwPKxl692/NVhAggaLExBAVVNRb1M7bePy8ubuVSHfHLlqtX1ck37mGw?=
 =?us-ascii?Q?cEHECjLlJQoq0CTSlv0B+hPBR3KPju3FQRFDxq2i8rBKv9kx2tA4HAe+e046?=
 =?us-ascii?Q?O3ZRosYsubmigtk1N+mOZaWg7WP8zg1MhYJxpuLXcsLhCpV38a/9tlMAZl5A?=
 =?us-ascii?Q?mjoNztpZEt5r4a1t1NLiKZD3oDYvTgQ8l2WOLXuD59OGQ8lzyoCXyStuQ3LE?=
 =?us-ascii?Q?QdGdplRWpnbZtYF45FWuS67t7SeryBgrQMBxDgLDMkAWKy8UcmmFE1gIwoKT?=
 =?us-ascii?Q?gJ81vn/dtm3lke3LlzlaEuSEOkJ3d0l6WwhcittVwjaJjvuXBp1LiUwVjEXG?=
 =?us-ascii?Q?RVB1mcvCakcUUlrvXDCY9+JVbUH2t1uD3AdjSjPmxOp8ccw+UPeIacM1AqKc?=
 =?us-ascii?Q?lhnwA7X7WB/BvQUMV4hVS2uquncwC7BB9DETtZT6Woo2XnusLBg1PAIIPQMa?=
 =?us-ascii?Q?I/2Tz7i6ZVLxd9+aDZKQIiId8HgM/o+d9/p4KzTbLu+KijuqE31MZ9UCWAsw?=
 =?us-ascii?Q?vAcKTluHm0/++9kpTdOZUhrPInKM7jbz+wID8vFt5KMVKukbmlnUu+LYYg9a?=
 =?us-ascii?Q?oOWwZ52Nsgs0G8BTNAssf8W2RLBZFrroJL44XPdP7W9850nPcEIz5zPGDozZ?=
 =?us-ascii?Q?2DE/vIZ9dcr2gYaHAqutXFNpqIvBfLADsevU2aKdA47w3MvgVjKjiNDeZDCI?=
 =?us-ascii?Q?WGSZX2ddN2c3XCT5C5GG7jjs5iphpqXw19QVcJ5wY/LH6msrsf5l59ZOgAYX?=
 =?us-ascii?Q?0Y9RINyMloG/Pkf9AtJD50BwTV23lYa+2fH/pIwM8jl6rVycpgjgPqMKW1rp?=
 =?us-ascii?Q?TOaWSa05mRNTiSK71Sfz4rlausLkm1PYa9lh+zQsnIn95IIm8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hmpWil3IshgsdWhOnvQ/5EMTxwrqfWAygXhywjZYcvty+Vw5iU9kXbY6Ow43?=
 =?us-ascii?Q?rQZ/rYACrhCMJtlifbYAee1sjoCeK4y2SAXRJlH0vRSvj3jhNqdyhyW0njxr?=
 =?us-ascii?Q?ue2oGj2i3Ojmncv1MHZ9V3IBI0CH9XXXwGsqOSx8qjAT8SAWlT4rFGHnBbMA?=
 =?us-ascii?Q?wrdtJhQeLgmUoriC6SALarJfl4micGdi+YVct7iep5zNl7mKrRJwO7YH46Vv?=
 =?us-ascii?Q?jIon/T4QscwifXhw26W6UE8+SMWkYbRALoeaLfcPpv8PQOx+b9/1J73G8Gzy?=
 =?us-ascii?Q?rM4JKm3NTqiAQK5JjKPpsZgsVW4uEcHVfX72Y7S4xS27x20lny9m4SE+Zcv6?=
 =?us-ascii?Q?KXwcMo24iKQkiskE/MVntaAojtDpd+wu/pZddEQPysgTpLxZAhh3QlmKN1Zn?=
 =?us-ascii?Q?JCswIOntR7ug87nfAur0oQYftMQU79Q2VhOmgRj6z+XZRVBSABCXbNgqVUZB?=
 =?us-ascii?Q?t/XiQUN2sWjyySoSbKthFhmQEIADwqhOr9qJOGVWmHMnI80qIu+uxUeQUVkl?=
 =?us-ascii?Q?PEBiIXQvY2NGUxNAF8m9wHfQ7ViZDphz4pZykfhoGAZaxi1HPZhuBaGGI5GZ?=
 =?us-ascii?Q?M/RYYcFRPyFlqbUtrB35t/4O7bBo+wQbuIudrk5U5I5V56nBjubwRFbO1AHW?=
 =?us-ascii?Q?Q3lsF0DUWmK6FrkgV57pbgCvus9/yVDzeNyLa3Uh/yFwZffFfm+7bbj+W+Ez?=
 =?us-ascii?Q?q/fbMB/A31Wc+eDF41qFtrcr8D7VrqLgxFXVQUqLeoX89eZVH/Wjyq4StiPm?=
 =?us-ascii?Q?GEZgMOKUqTvssJGjs22CbJpzzbb+Z9ESFvhQVzc4MxCD4UEn6C3qVmaXIJ9k?=
 =?us-ascii?Q?93jh1usBWLLqz7GFR9oyxex5zA9m+8FOp7RjUYPRmcrgYSn9DM6pHYCoovNj?=
 =?us-ascii?Q?lXpg/VNHLEs8pwsy0xHVbTi9FchGAj2RbVEBu+HenfPOefLyDAC5CIm/+F74?=
 =?us-ascii?Q?CiDd80PRxqaFEPM3zzHnzS6GrnVWQtjptiQUc24GKa0fbpHKWVgyYnzm+rs2?=
 =?us-ascii?Q?ZECqzWWgAvgVPAtd2e/gn4k7R0oJ2ZyYKX4B9ytHY5iJeiqCxtbShJcHyb5Z?=
 =?us-ascii?Q?gYe/h0tLDAucA7inpNBEbYat0TGz4FCsvHN4HNMvypiE5UlElElpXOwa2IxU?=
 =?us-ascii?Q?eLmYupscGMc0ueIkY5XJaNboOlQxmoBNX7g8CCkwqqaMBM8RrlQ8mNnbbWqV?=
 =?us-ascii?Q?QiuqeIyCEjw0xZmMAtue90QExhgYgDeu/cC1V5MPFrAjSm8aK2Yg5i3jxJtS?=
 =?us-ascii?Q?SAetoJyvn3FlpAtvMSihEfDYOgMrvTJFW5Bm4xDM6Iw11bHSH12RmdZhA9AD?=
 =?us-ascii?Q?x/l+JDzra8X5gE2fyi/ghdokxl1aXk0tHyCyNUEGYYDnA6qmgi/D68p3f/dw?=
 =?us-ascii?Q?q7k/q3cBgfWfN2Gewj+AOMI0DIcxJMMKifOqIOZWfWdbL1kEouC2Mla9ovmt?=
 =?us-ascii?Q?8Da03HOD0u40I/FZXatkd8gH/gChjYZuJEyKqlS5l1RfQtqBgWEoQ6Mc6fH7?=
 =?us-ascii?Q?xYv6qkz4eyw6KkBPYiSKm/LvLtgpywcJLVkXkHCUCvQZcFiHJG18jBMjf9Zw?=
 =?us-ascii?Q?UqEUfyQkemiWbQUEDe6aD1DXgWYK6//3KzDkF3FWXzoZZeZmOwdft+Wb8uo8?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36d4d8c-e049-4397-2297-08dd0f86d13f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 08:29:46.9544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oVP8TRQ/GXk1NNIBNW5Yf9HXci4eMw2/RfqgSZGSPsHDGJyHFNamGf4nbiFIXYCJd4CxwsvFzlGKtUNBb68+hiSsL/r2tp74t2Txp2DLO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5259
X-Proofpoint-GUID: fI8eGBl6GDnF-KVmZau_eqhETgjx0RwE
X-Proofpoint-ORIG-GUID: fI8eGBl6GDnF-KVmZau_eqhETgjx0RwE
X-Authority-Analysis: v=2.4 cv=TIe/S0la c=1 sm=1 tr=0 ts=674829fe cx=c_pps a=ZuQraZtzrhlqXEa35WAx3g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=mpaa-ttXAAAA:8
 a=QX4gbG5DAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=ghR5xj94K-_V6kW8Z9EA:9 a=AbAUZ8qAyYyZVLSsDulk:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-28_07,2024-11-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2411120000 definitions=main-2411280066

From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>

[ Upstream commit a8bd68e4329f9a0ad1b878733e0f80be6a971649 ]

When mtk-cmdq unbinds, a WARN_ON message with condition
pm_runtime_get_sync() < 0 occurs.

According to the call tracei below:
  cmdq_mbox_shutdown
  mbox_free_channel
  mbox_controller_unregister
  __devm_mbox_controller_unregister
  ...

The root cause can be deduced to be calling pm_runtime_get_sync() after
calling pm_runtime_disable() as observed below:
1. CMDQ driver uses devm_mbox_controller_register() in cmdq_probe()
   to bind the cmdq device to the mbox_controller, so
   devm_mbox_controller_unregister() will automatically unregister
   the device bound to the mailbox controller when the device-managed
   resource is removed. That means devm_mbox_controller_unregister()
   and cmdq_mbox_shoutdown() will be called after cmdq_remove().
2. CMDQ driver also uses devm_pm_runtime_enable() in cmdq_probe() after
   devm_mbox_controller_register(), so that devm_pm_runtime_disable()
   will be called after cmdq_remove(), but before
   devm_mbox_controller_unregister().

To fix this problem, cmdq_probe() needs to move
devm_mbox_controller_register() after devm_pm_runtime_enable() to make
devm_pm_runtime_disable() be called after
devm_mbox_controller_unregister().

Fixes: 623a6143a845 ("mailbox: mediatek: Add Mediatek CMDQ driver")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 4d62b07c1411..d5f5606585f4 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -623,12 +623,6 @@ static int cmdq_probe(struct platform_device *pdev)
 		cmdq->mbox.chans[i].con_priv = (void *)&cmdq->thread[i];
 	}
 
-	err = devm_mbox_controller_register(dev, &cmdq->mbox);
-	if (err < 0) {
-		dev_err(dev, "failed to register mailbox: %d\n", err);
-		return err;
-	}
-
 	platform_set_drvdata(pdev, cmdq);
 
 	WARN_ON(clk_bulk_prepare(cmdq->pdata->gce_num, cmdq->clocks));
@@ -642,6 +636,12 @@ static int cmdq_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	err = devm_mbox_controller_register(dev, &cmdq->mbox);
+	if (err < 0) {
+		dev_err(dev, "failed to register mailbox: %d\n", err);
+		return err;
+	}
+
 	return 0;
 }
 
-- 
2.34.1


