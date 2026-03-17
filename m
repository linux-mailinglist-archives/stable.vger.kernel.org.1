Return-Path: <stable+bounces-226578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ELfMNGKuWl6JwIAu9opvQ
	(envelope-from <stable+bounces-226578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:09:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 800902AF0F2
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C257304199C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF3D3F54CC;
	Tue, 17 Mar 2026 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="IpjDgYl+"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC24357A4A
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767309; cv=fail; b=BFGs/u3woxMNhkTUCBxnqFcKFYhGVZcPhvsfLviYgn0bnOqE26C1m0BKaFKL04AuA+IRlNa4DJKp5G9Z1bsE4RoFHryi5YvtXI3rzBwMOjxK+wxui5/nVX6gG+E4H9Fp/mfJn8fUNzOhP3xjRoVUJKfVZgnXhQdxjOaSNHD3+2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767309; c=relaxed/simple;
	bh=Q6UxtjIAce8qBHeH7Uq5K6vNA04ZLwlsXcXt0GANSgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZzGbJ96wK/OcAz6jHYciy5boOIFgLtHPVTZNHbd/Ohzx2zRQmwb6MonVIzpJTS61HiB5XWTpIINE5/t5/MQhoepHqhuzmV7r8DwONrlg/IwWtwAaZ7gc1oZ13vS/yjlk/DfcJxDUKmXJthLcJLI7FiLLiu5VARA6EQfiUWADnds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=IpjDgYl+; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GMljgd2284393;
	Tue, 17 Mar 2026 17:08:22 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazon11011010.outbound.protection.outlook.com [52.101.125.10])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4cw11gtb9n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 17:08:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9vYG6Cdv5xMesBzVJZ38bQQxv6+uyqkXdPUuVu0s3U7GfKTOnTXhUqjZqFkgRBUaaxzSznVlnmDCge2fYnNRvTq4wMSbT7UtuW181HWde+Zu4fvfpIaJmKpwTypp3HBLMMSh0dtWJi/oUdsO61CjCYBZzUpxYiUUI/+Ol3i/UIrRComZ1OqJJt5mw6vMJqg80wwRZT/uVVtuk5J9gpy04NGZIzyoqHuqMwNdadbQ9cYAj0OgnuY92VQZtkNRN1rjwBf5Vit4RhCgEli+7/wH/1eMb+xriblCWQmprSziSS6yU9HQNVnNPey7jzV8QP/4FxSwTz9/cU0Oyr81Xbvrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKyznf+mO8kxfVKxXnZ9vXSE6GYJy0xn7xUnw52oUuM=;
 b=ObFMD1v+Nee9FAnGu1eAjNGxEtoyjQ3I8HC4LxiEVjaKdOHJPNebBXEmYf2rZKX2elShucRDqDsqfSELq8FWHq2J3NVooDefs/v7DhK3b+DiJWkO4ep+TZv/P9Kb9YpYRY4xlU0bdoCRBZC7rsqksE2+nET5Iksyc+R4FyC4/3cpWc0kRQhe0IRtmVRGxf+ME8JHrolzV4I8SCa4EpPbXXUGsfrm1rrcuJHBT7NnL+47MrpmvIEOlflrJ02jLLYy3bBOk90KISu1Z5rsV2irwBh5qwQ/Ny/5XDoujCm+4AKg6X5/K8XBKTxj4onhypme8Pvc2rUBo/uxwyXzvUvH9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKyznf+mO8kxfVKxXnZ9vXSE6GYJy0xn7xUnw52oUuM=;
 b=IpjDgYl+9pK5mK/hh/4WcMTqnzmRe5HN0RNMMeQ4k6OY150xZIJfX710X8YOnqWMGKdseTDfccXctAJ/xPHgLNUDJHszFNvuXH2ui/jUA5PJuIxg+0VR8PY6Auc9oyfOtCeefnwtiZaTV4KbLPAt8LtI+K7QTZj7F9i79xqrr+1rSDecAzb+HHZ7Yh3wkja+GSuJZBZdi2n/w5WjHnPNIRMwdhkBrqCe3q6Kd42orRRIAFuZ7E7RLsk7Flw+b2dGE5Qkt9MsuX5x5Qi1ze1afOMFcTlqNWV9ZMh5NyMSVdN8RzD6HG4wkqQsZzTecgyWLyHbvzjLiRCPvCMnKhWyxg==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS3P286MB1962.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 17:08:20 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7f13:e26e:3d72:9ab1]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7f13:e26e:3d72:9ab1%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 17:08:20 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.15.y] iio: imu: inv_icm42600: fix odr switch when turning buffer off
Date: Tue, 17 Mar 2026 17:08:08 +0000
Message-Id: <20260317170808.746087-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2026031738-vacant-most-feaf@gregkh>
References: <2026031738-vacant-most-feaf@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0081.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::17) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS3P286MB1962:EE_
X-MS-Office365-Filtering-Correlation-Id: 103689ca-27a8-4e40-9677-08de8447c9fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|3613699012|38350700014|56012099003|7053199007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SDSr3RU1rftN3rJu98XznsjpvbLoXr/5ZCrRc73QQfpIXzeyxBfozhe6OSk0ua0B8QREgK+ZHB3sOJGkatYPtM4bhMyozPr/dhCH9JTZCfvWJz1CvSxLbhYsxCkb6oss711AGPKGZc0V96OaDIlYDVYXSnKT+KAE5PFDVBlhoCQUD6evjoPELnB5BDPnQ/D5IXyigaD4n9vLjf6Kct5qzc5DHAkORp+ahZXrsQLv8xt+3k2hRKDQoT0CqWHe9GPLrWLlcozIontLfdHlIdZA6d3UIIJssaj+I67YK/OFiDX7xjLfu70LZZT54xn2oUrgoSn+zgRk7j+GNEC4MHz/SijHGYQIXFuxs1DUA0QNr1x7+JVLwUDI1rAfA63p24VZyuPUrWMHk6IQXBMgFpUFomgD8kSQoRgYToVGXMaDapi5pPepCYrdy5I47rW2hICJZlJ6zGKrj+wgw6doLI+6BYeqX4jRpoexJiNOu9t+rkPLkMKJ8+JtaWgPmB1QQmQmVBgPekfOjd8vb3cmqDdZ92Hr7/qwhaTBJFIXtJ4DgdxGpuJ5cL64JkjKYf0VMsOw6SL3lIjwRxEFvMcF5+Rp0+CbJF5237ATXNt8OdlUKdXc+ORRQkr/eioJh8D10RSGo5cCfHVK70m4OaPPnGLkngxfwYI+3Uv9UChSJNTkrRdDtOe2mt2PNrX4fekbut2Q6/9kMgl7QNThLhS2a7aVKpsnPX4cWZOrx7N3Ble7VwnrZxblD8UCvLbI1vsWKmS/d5+FxzLdAqYiLSSoZz8URvsS4FUY49LANyjcsVYMVzOA55sWgnuzRhvR1r7r65VF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(3613699012)(38350700014)(56012099003)(7053199007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l7/EujO0em5QlCI4Jqyg8t3MSJ2ONDGkyAr/H5qnlRgDOfDqLpfFBkfbBtv7?=
 =?us-ascii?Q?VG/2VHtJAAFCjdBolxM5exy7dul+T2Ymu04zQOoPYJ4PFhFFAownX+BiLKeU?=
 =?us-ascii?Q?MDdEGRPOW2/KcCuIa0CwniIpoZL3cupjaNjgDrZHZGwyIGRI8DyHpbbR0tWF?=
 =?us-ascii?Q?Gvlpmy/avXqG9XLx4Gy8G5gNvMsvFdcaAe/Jtr3QStVV/kENj5b+zwlZ7ZFK?=
 =?us-ascii?Q?zP8eufpMzxw5eJNio+f/QBllcx92EAKqOUdIBQX7AFjtxtqnV1YOtc3KVNGW?=
 =?us-ascii?Q?bt3OgvEN9MIhLeeUtfIzYboZOMS81qWhzQCl17DPeqx6fw0pcdT3UFVQcLbW?=
 =?us-ascii?Q?RW9DFdnilSPO5zY04q3EkQaehHk3EfKevJmU3w+kFTs+5IiILqtUkwr4mPKG?=
 =?us-ascii?Q?VwlHCHBgjLcd/NgQJEQbY0ZS1Iami2JRCnG5YHKzGrUFEikygt1ICW017YfG?=
 =?us-ascii?Q?bcC3SDLRv8xChmPotZSJnHR6j+HtsV9XG3Us/O9dvEXhRKh63Am0qdcy/MKW?=
 =?us-ascii?Q?OdBNASB31Xvx3DfeTKYa2hXc55BNk/Uu2Xf89NcWjdM2TF4TZCHPWt80yOwm?=
 =?us-ascii?Q?t5QLsl9jSjcVWw6lu2l/Ow0ulN0YD5GWuRfLIh8Lk1MZYgqdfdEWl9QIE9ce?=
 =?us-ascii?Q?d05ljVSq7NugFAA/WLkKgLykoGuYxn1Xwn6bn02u+XgD7gktnUfWxmq8zUQx?=
 =?us-ascii?Q?sktSqJiUPn/h+oVrybzLgz+oWELk9BPjqAc/C9mD5vHULLyyoz75CKUTFybK?=
 =?us-ascii?Q?t49KrSwMOOoRyR0boINnzB6bv+BZAuxZlU8XKRP0AyRNKdThpbfhl3bpF+aq?=
 =?us-ascii?Q?nbOpNkpVP+WAG+cn0ROoxq0yJCY2xm+ATsvQQpBCbr4ab/PHtBXqmdogmvtK?=
 =?us-ascii?Q?fgaAblXtb4ltoQE6pQxv+WAgUZ1baJyj9aUczmS8LkgrUWjLi30oR+F+RXcN?=
 =?us-ascii?Q?z2Z/nq/ibK3e7lsWfEQ+tpD0N6Kaj8UYao2YMmPC8BKu/pPJ4vxr3yflEDqD?=
 =?us-ascii?Q?fcLzhVkGxFQGKihTlb12J192bP7ucvTWnYHvLoejHGC5wV6F4nJ1cXBng12w?=
 =?us-ascii?Q?O6ceLksoD/ubhx6Mx0KbIoL4boCcRVRZq2tsRqm/57rrxEuRgOa2/SvpAJrC?=
 =?us-ascii?Q?uXBp4zA2ph7w7QJL5Izi/3MbkfZ6S82mmagQEJ1msEk4W++mPkosOM8kYmww?=
 =?us-ascii?Q?M6PAS7iDnRgZSkLSKToonyNpvtArFWAYRgGurqhaNGYrY0s6NAAEha1Q+FIE?=
 =?us-ascii?Q?YG010/LMQqOpqWCfFaPrID/uOydLAUPdCMRIZ1aLMDl8nmNne2JcW0Ch8IOT?=
 =?us-ascii?Q?eZdkLQQhkFzrb44/ogyh77gp88cFL+CNTIFwcext57EJ1c+Ah/F/hgzfMMLJ?=
 =?us-ascii?Q?3vn+DrQtkuArxWgcUSgrXFzWfLfjKoAsm1jkUFt8ru0z8yNvoBqMfXIQAGgi?=
 =?us-ascii?Q?ml1c0NpSe+xHroVeGqxo7mVR7p2QEKqLZd2d3OC5nZP7GBq4Dpy/j3ku4yKJ?=
 =?us-ascii?Q?gLZVyAQqr4lRY9f9ZloRSY2W4Has5qzg+weqFIPjJBC7CwDQ6ZBc5wW3XuGS?=
 =?us-ascii?Q?rlnQLzr/tYMpcP/LrO7KUygwDiuyEky3pYJKDBKXYSu2K23ALnyNtyOrrnoy?=
 =?us-ascii?Q?ggKqTTuS/9rk5ngjIiussuGXmbV87NeB0d3+d5mm7od7XSsmdhk7iOXUSXZd?=
 =?us-ascii?Q?ezx0Z11bpruLtphFZey0RBVd6QDvXN7bsGtb3nBj/CZBuR0vSBoM6H3Mx0gI?=
 =?us-ascii?Q?Rjzgdg7frw=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	iFepVaBrRGZn93O0f4V3duPA7NKE4dSMRxqDxQ5szPOIuzw7d+K2wurIs4wMjVACM2HuUTGy8sZjsFdENyXae5H/BQ8S6WO59293dQ1gcfrJg8ChIRrO+hSPKoxXB9gNh5ZUQNXDqHtOEjwjqw3fojiM/bHCjYFwMNV9cHutVOpMxd5Iw+MNR/PtMQ+hTybC5LnGSPWGUGHvSh673mZkvpUC/ZK8055TYJvKRAX3ppJXT2gfqgsWO9jdryAhf0B/nxkdE3ftvckpSo7WQxigacs+aubmnSnCFvwZ1DraurVFIXKDSre/k/rj8kWZX6Kzamj4xblzE42Dx1rx5CvP6A==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103689ca-27a8-4e40-9677-08de8447c9fb
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 17:08:20.0647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhwx/Z3YyvoovNeXBjyqBGcLPeE+r7zHMltDZO9Pn3SR6CkTPpcOsw+Ht9OfpgE4n3KFge8Q74UKaEg9xAJjzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1962
X-Authority-Analysis: v=2.4 cv=AIx+R2tb c=1 sm=1 tr=0 ts=69b98a86 cx=c_pps
 a=uilDTiaNKxd7Qq4rS8uPEw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=Uwzcpa5oeQwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=W6z64dnQKVPvYeLC5f8l:22 a=NpUDEC63da1vOGE9rZHW:22
 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=dmF26TSAndsNLafa5AIA:9
 a=EFfWL0t1EGez1ldKSZgj:22
X-Proofpoint-GUID: Z-HL-rYQLTlV4CKvrzuYhMVuqdK4crry
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE1MSBTYWx0ZWRfX//nz3vYJBRk9
 IKs9Juwx51kIAglUquncBnPvdJ0ZohVvjjTktS+AkfNmO2zWAfBs4Fskzf1zSf13aoio4yweCom
 ghSTg0RWxqtzU5fQW3wU1HnnGTZvnHDXVUWXGezKNEjijdxKlwI+HAs1K4afAZDj4LzSgsLuq0n
 BBrpK1yGB8CsUef4C75XvscolyjE8ltkxNqVPJl4MTGKphvuUmesSm+2m6cOl+GninsXxOLz8Ad
 GiONwS76Cm+FSb0YXmGbicW6+Gt/fT7M/eafbp/2E/qIu5noPb6I1N5zYS04WDPYIqJOenCN+u7
 /RWkUiwfVPqzcqRSW1S9BYn5myAk36wtDN4thQB9xZBSdkx+ZG4J6UmjmNkQlkxRMXag6kcAH5p
 eg0Iv5oIhr+RdXUeDTpVb/ZuFhD8MBF/P2I3nW3ogx8+lE2S3B6rvtftMz5ZaIh3954rpG0wJvS
 0Qt77FfiyzyEddJ5I8w==
X-Proofpoint-ORIG-GUID: Z-HL-rYQLTlV4CKvrzuYhMVuqdK4crry
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_03,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170151
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tdk.com,quarantine];
	R_DKIM_ALLOW(-0.20)[tdk.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226578-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[tdk.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tdk.com:dkim,tdk.com:email,tdk.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inv.git-commit@tdk.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 800902AF0F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

[ Upstream commit ffd32db8263d2d785a2c419486a450dc80693235 ]

ODR switch is done in 2 steps when FIFO is on : change the ODR register
value and acknowledge change when reading the FIFO ODR change flag.
When we are switching odr and turning buffer off just afterward, we are
losing the FIFO ODR change flag and ODR switch is blocked.

Fix the issue by force applying any waiting ODR change when turning
buffer off.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 32d7f8364230..f29c3e8531e6 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -377,6 +377,7 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
 static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int sensor;
 	unsigned int *watermark;
@@ -398,6 +399,8 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 
 	mutex_lock(&st->lock);
 
+	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
+
 	ret = inv_icm42600_buffer_set_fifo_en(st, st->fifo.en & ~sensor);
 	if (ret)
 		goto out_unlock;
-- 
2.25.1


